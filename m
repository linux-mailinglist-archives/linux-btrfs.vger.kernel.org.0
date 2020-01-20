Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A5142CE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgATOJ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:49142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgATOJ0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E3756B1B4;
        Mon, 20 Jan 2020 14:09:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/11] btrfs: Use btrfs_transaction::pinned_extents
Date:   Mon, 20 Jan 2020 16:09:18 +0200
Message-Id: <20200120140918.15647-12-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit flips the switch to start tracking/processing pinned
extents on a per-transaction basis. It mostly replaces all references
from btrfs_fs_info::(pinned_extents|freed_extents[]) to
btrfs_transaction::pinned_extents. Two notable modifications that
warrant explicit mention are changing clean_pinned_extents to get a
reference to the previously running transaction. The other one is
removal of call to btrfs_destroy_pinned_extent since transactions are
going to be cleaned in btrfs_cleanup_one_transaction.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c       | 38 ++++++++++++++++++++++++------------
 fs/btrfs/ctree.h             |  4 ++--
 fs/btrfs/disk-io.c           | 30 +++++-----------------------
 fs/btrfs/extent-io-tree.h    |  3 +--
 fs/btrfs/extent-tree.c       | 31 ++++++++---------------------
 fs/btrfs/free-space-cache.c  |  2 +-
 fs/btrfs/tests/btrfs-tests.c |  7 ++-----
 fs/btrfs/transaction.c       |  1 +
 fs/btrfs/transaction.h       |  1 +
 include/trace/events/btrfs.h |  3 +--
 10 files changed, 47 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 48bb9e08f2e8..562dfb7dc77f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -460,7 +460,7 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 	int ret;
 
 	while (start < end) {
-		ret = find_first_extent_bit(info->pinned_extents, start,
+		ret = find_first_extent_bit(&info->excluded_extents, start,
 					    &extent_start, &extent_end,
 					    EXTENT_DIRTY | EXTENT_UPTODATE,
 					    NULL);
@@ -1233,32 +1233,44 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	return ret;
 }
 
-static bool clean_pinned_extents(struct btrfs_block_group *bg)
+static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
+				 struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_transaction *prev_trans = NULL;
 	u64 start = bg->start;
 	u64 end = start + bg->length - 1;
 	int ret;
 
+	spin_lock(&fs_info->trans_lock);
+	if (trans->transaction->list.prev != &fs_info->trans_list) {
+		prev_trans = list_entry(trans->transaction->list.prev,
+					struct btrfs_transaction, list);
+		refcount_inc(&prev_trans->use_count);
+	}
+	spin_unlock(&fs_info->trans_lock);
+
 	/*
 	 * Hold the unused_bg_unpin_mutex lock to avoid racing with
 	 * btrfs_finish_extent_commit(). If we are at transaction N,
 	 * another task might be running finish_extent_commit() for the
 	 * previous transaction N - 1, and have seen a range belonging
-	 * to the block group in freed_extents[] before we were able to
-	 * clear the whole block group range from freed_extents[]. This
+	 * to the block group in pinned_extents before we were able to
+	 * clear the whole block group range from pinned_extents. This
 	 * means that task can lookup for the block group after we
-	 * unpinned it from freed_extents[] and removed it, leading to
+	 * unpinned it from pinned_extents[] and removed it, leading to
 	 * a BUG_ON() at unpin_extent_range().
 	 */
 	mutex_lock(&fs_info->unused_bg_unpin_mutex);
-	ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
-			  EXTENT_DIRTY);
-	if (ret)
-		goto failure;
+	if (prev_trans) {
+		ret = clear_extent_bits(&prev_trans->pinned_extents, start, end,
+					EXTENT_DIRTY);
+		if (ret)
+			goto failure;
+	}
 
-	ret = clear_extent_bits(&fs_info->freed_extents[1], start, end,
-			  EXTENT_DIRTY);
+	ret = clear_extent_bits(&trans->transaction->pinned_extents, start, end,
+				EXTENT_DIRTY);
 	if (ret)
 		goto failure;
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
@@ -1367,7 +1379,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * We could have pending pinned extents for this block group,
 		 * just delete them, we don't care about them anymore.
 		 */
-		if (!clean_pinned_extents(block_group))
+		if (!clean_pinned_extents(trans, block_group))
 			goto end_trans;
 
 		/*
@@ -2877,7 +2889,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 					&cache->space_info->total_bytes_pinned,
 					num_bytes,
 					BTRFS_TOTAL_BYTES_PINNED_BATCH);
-			set_extent_dirty(info->pinned_extents,
+			set_extent_dirty(&trans->transaction->pinned_extents,
 					 bytenr, bytenr + num_bytes - 1,
 					 GFP_NOFS | __GFP_NOFAIL);
 		}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c6ce8c047814..a84072fbb4e7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -596,8 +596,8 @@ struct btrfs_fs_info {
 	/* keep track of unallocated space */
 	atomic64_t free_chunk_space;
 
-	struct extent_io_tree freed_extents[2];
-	struct extent_io_tree *pinned_extents;
+	/* Tracks ranges which used by log trees blocks/logged data extents */
+	struct extent_io_tree excluded_extents;
 
 	/* logical->physical extent mapping */
 	struct extent_map_tree mapping_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9209c7b0997c..3cb786463eb2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2021,10 +2021,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 			btrfs_drop_and_free_fs_root(fs_info, gang[i]);
 	}
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
 		btrfs_free_log_root_tree(NULL, fs_info);
-		btrfs_destroy_pinned_extent(fs_info, fs_info->pinned_extents);
-	}
 }
 
 static void btrfs_init_scrub(struct btrfs_fs_info *fs_info)
@@ -2779,11 +2777,8 @@ int __cold open_ctree(struct super_block *sb,
 	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->first_logical_byte = (u64)-1;
 
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[0],
-			    IO_TREE_FS_INFO_FREED_EXTENTS0, NULL);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[1],
-			    IO_TREE_FS_INFO_FREED_EXTENTS1, NULL);
-	fs_info->pinned_extents = &fs_info->freed_extents[0];
+	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
+			    IO_TREE_FS_INFO_EXCLUDED_EXTENTS, NULL);
 	set_bit(BTRFS_FS_BARRIER, &fs_info->flags);
 
 	mutex_init(&fs_info->ordered_operations_mutex);
@@ -4384,16 +4379,12 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 }
 
 static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
-				       struct extent_io_tree *pinned_extents)
+				       struct extent_io_tree *unpin)
 {
-	struct extent_io_tree *unpin;
 	u64 start;
 	u64 end;
 	int ret;
-	bool loop = true;
 
-	unpin = pinned_extents;
-again:
 	while (1) {
 		struct extent_state *cached_state = NULL;
 
@@ -4418,15 +4409,6 @@ static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		cond_resched();
 	}
 
-	if (loop) {
-		if (unpin == &fs_info->freed_extents[0])
-			unpin = &fs_info->freed_extents[1];
-		else
-			unpin = &fs_info->freed_extents[0];
-		loop = false;
-		goto again;
-	}
-
 	return 0;
 }
 
@@ -4518,8 +4500,7 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 
 	btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
 				     EXTENT_DIRTY);
-	btrfs_destroy_pinned_extent(fs_info,
-				    fs_info->pinned_extents);
+	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
@@ -4571,7 +4552,6 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_all_ordered_extents(fs_info);
 	btrfs_destroy_delayed_inodes(fs_info);
 	btrfs_assert_delayed_root_empty(fs_info);
-	btrfs_destroy_pinned_extent(fs_info, fs_info->pinned_extents);
 	btrfs_destroy_all_delalloc_inodes(fs_info);
 	mutex_unlock(&fs_info->transaction_kthread_mutex);
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index a3febe746c79..02c2e4e711bf 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -36,8 +36,7 @@ struct io_failure_record;
 #define CHUNK_TRIMMED				EXTENT_DEFRAG
 
 enum {
-	IO_TREE_FS_INFO_FREED_EXTENTS0,
-	IO_TREE_FS_INFO_FREED_EXTENTS1,
+	IO_TREE_FS_INFO_EXCLUDED_EXTENTS,
 	IO_TREE_INODE_IO,
 	IO_TREE_INODE_IO_FAILURE,
 	IO_TREE_RELOC_BLOCKS,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d680f2ac336b..f7b89ab921e1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -64,10 +64,8 @@ int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes)
 {
 	u64 end = start + num_bytes - 1;
-	set_extent_bits(&fs_info->freed_extents[0],
-			start, end, EXTENT_UPTODATE);
-	set_extent_bits(&fs_info->freed_extents[1],
-			start, end, EXTENT_UPTODATE);
+	set_extent_bits(&fs_info->excluded_extents, start, end,
+			EXTENT_UPTODATE);
 	return 0;
 }
 
@@ -79,10 +77,8 @@ void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
 	start = cache->start;
 	end = start + cache->length - 1;
 
-	clear_extent_bits(&fs_info->freed_extents[0],
-			  start, end, EXTENT_UPTODATE);
-	clear_extent_bits(&fs_info->freed_extents[1],
-			  start, end, EXTENT_UPTODATE);
+	clear_extent_bits(&fs_info->excluded_extents, start, end,
+			  EXTENT_UPTODATE);
 }
 
 static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
@@ -2606,7 +2602,7 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 
 	percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
 		    num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-	set_extent_dirty(fs_info->pinned_extents, bytenr,
+	set_extent_dirty(&trans->transaction->pinned_extents, bytenr,
 			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
 	return 0;
 }
@@ -2762,11 +2758,6 @@ void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 		}
 	}
 
-	if (fs_info->pinned_extents == &fs_info->freed_extents[0])
-		fs_info->pinned_extents = &fs_info->freed_extents[1];
-	else
-		fs_info->pinned_extents = &fs_info->freed_extents[0];
-
 	up_write(&fs_info->commit_root_sem);
 
 	btrfs_update_global_block_rsv(fs_info);
@@ -2907,10 +2898,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	u64 end;
 	int ret;
 
-	if (fs_info->pinned_extents == &fs_info->freed_extents[0])
-		unpin = &fs_info->freed_extents[1];
-	else
-		unpin = &fs_info->freed_extents[0];
+	unpin = &trans->transaction->pinned_extents;
 
 	while (!trans->aborted) {
 		struct extent_state *cached_state = NULL;
@@ -2922,12 +2910,9 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
 		}
-		if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
-			clear_extent_bits(&fs_info->freed_extents[0], start,
+		if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+			clear_extent_bits(&fs_info->excluded_extents, start,
 					  end, EXTENT_UPTODATE);
-			clear_extent_bits(&fs_info->freed_extents[1], start,
-					  end, EXTENT_UPTODATE);
-		}
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 9d6372139547..bd9c4b5da549 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1086,7 +1086,7 @@ static noinline_for_stack int write_pinned_extent_entries(
 	 * We shouldn't have switched the pinned extents yet so this is the
 	 * right one
 	 */
-	unpin = block_group->fs_info->pinned_extents;
+	unpin = &trans->transaction->pinned_extents;
 
 	start = block_group->start;
 
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index c12b91ff5f56..2f7514068c3f 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -156,12 +156,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 	INIT_LIST_HEAD(&fs_info->fs_devices->devices);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[0],
-			    IO_TREE_FS_INFO_FREED_EXTENTS0, NULL);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[1],
-			    IO_TREE_FS_INFO_FREED_EXTENTS1, NULL);
+	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
+			    IO_TREE_FS_INFO_EXCLUDED_EXTENTS, NULL);
 	extent_map_tree_init(&fs_info->mapping_tree);
-	fs_info->pinned_extents = &fs_info->freed_extents[0];
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 
 	test_mnt->mnt_sb->s_fs_info = fs_info;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 55d8fd68775a..4b9091582ec4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -334,6 +334,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
+	extent_io_tree_init(fs_info, &cur_trans->pinned_extents, 0, NULL);
 	fs_info->generation++;
 	cur_trans->transid = fs_info->generation;
 	fs_info->running_transaction = cur_trans;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 49f7196368f5..2a046a0155c1 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -71,6 +71,7 @@ struct btrfs_transaction {
 	 */
 	struct list_head io_bgs;
 	struct list_head dropped_roots;
+	struct extent_io_tree pinned_extents;
 
 	/*
 	 * we need to make sure block group deletion doesn't race with
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 17088a112ed0..f4fa3e15297d 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -81,8 +81,7 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 
 #define show_extent_io_tree_owner(owner)				       \
 	__print_symbolic(owner,						       \
-		{ IO_TREE_FS_INFO_FREED_EXTENTS0, "FREED_EXTENTS0" },	       \
-		{ IO_TREE_FS_INFO_FREED_EXTENTS1, "FREED_EXTENTS1" },	       \
+		{ IO_TREE_FS_INFO_EXCLUDED_EXTENTS, "EXCLUDED_EXTENTS" }, \
 		{ IO_TREE_INODE_IO,		  "INODE_IO" },		       \
 		{ IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE" },	       \
 		{ IO_TREE_RELOC_BLOCKS,		  "RELOC_BLOCKS" },	       \
-- 
2.17.1

