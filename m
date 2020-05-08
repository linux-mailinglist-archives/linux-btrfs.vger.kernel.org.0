Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A7C1CA7C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHKBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 06:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgEHKBu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 06:01:50 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4C6215A4
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588932109;
        bh=11McgwhBPQrgq5qc4S91AOOvxmuFMgJuehUlihMKuOI=;
        h=From:To:Subject:Date:From;
        b=JFE8+TiJ/H4oGWGnEEocq/J6433HdP6EVV+MCWzmQnnLa7/kZGK05vbmgg1MlbqI6
         oIaQ1jBqE6mioAPvhb3P9U3CrbsIWAMQZjUDqhQ/WDEG8gUZYB1CU2kyo1cUogX9Lm
         qjudQSj0540Li/kGoMusa/uUIYlRwj9qjnSmzzdI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] Btrfs: rename member 'trimming' of block group to a more generic name
Date:   Fri,  8 May 2020 11:01:47 +0100
Message-Id: <20200508100147.8202-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Back in 2014, commit 04216820fe83d5 ("Btrfs: fix race between fs trimming
and block group remove/allocation"), I added the 'trimming' member to the
block group structure. Its purpose was to prevent races between trimming
and block group deletion/allocation by pinning the block group in a way
that prevents its logical address and device extents from being reused
while trimming is in progress for a block group, so that if another task
deletes the block group and then another task allocates a new block group
that gets the same logical address and device extents while the trimming
task is still in progress.

After the previous fix for scrub (patch "Btrfs: fix a race between scrub
and block group removal/allocation"), scrub now also has the same needs that
trimming has, so the member name 'trimming' no longer makes sense.
Since there is already a 'pinned' member in the block group that refers
to space reservations (pinned bytes), rename the member to 'frozen',
add a comment on top of it to describe its general purpose and rename
the helpers to increment and decrement the counter as well, to match
the new member name.

The next patch in the series will move the helpers into a more suitable
file (from free-space-cache.c to block-group.c).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c      | 29 ++++++++++++++++-------------
 fs/btrfs/block-group.h      | 11 ++++++++++-
 fs/btrfs/ctree.h            |  4 ++--
 fs/btrfs/extent-tree.c      |  2 +-
 fs/btrfs/free-space-cache.c | 25 +++++++++++++------------
 fs/btrfs/scrub.c            |  6 +++---
 fs/btrfs/transaction.c      |  2 +-
 7 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f96ab9d6f3fe..138d9c6a84a2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1073,18 +1073,21 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	spin_lock(&block_group->lock);
 	block_group->removed = 1;
 	/*
-	 * At this point trimming can't start on this block group, because we
-	 * removed the block group from the tree fs_info->block_group_cache_tree
-	 * so no one can't find it anymore and even if someone already got this
-	 * block group before we removed it from the rbtree, they have already
-	 * incremented block_group->trimming - if they didn't, they won't find
-	 * any free space entries because we already removed them all when we
-	 * called btrfs_remove_free_space_cache().
+	 * At this point trimming or scrub can't start on this block group,
+	 * because we removed the block group from the rbtree
+	 * fs_info->block_group_cache_tree so no one can't find it anymore and
+	 * even if someone already got this block group before we removed it
+	 * from the rbtree, they have already incremented block_group->frozen -
+	 * if they didn't, for the trimming case they won't find any free space
+	 * entries because we already removed them all when we called
+	 * btrfs_remove_free_space_cache().
 	 *
 	 * And we must not remove the extent map from the fs_info->mapping_tree
 	 * to prevent the same logical address range and physical device space
-	 * ranges from being reused for a new block group. This is because our
-	 * fs trim operation (btrfs_trim_fs() / btrfs_ioctl_fitrim()) is
+	 * ranges from being reused for a new block group. This is needed to
+	 * avoid races with trimming and scrub.
+	 *
+	 * An fs trim operation (btrfs_trim_fs() / btrfs_ioctl_fitrim()) is
 	 * completely transactionless, so while it is trimming a range the
 	 * currently running transaction might finish and a new one start,
 	 * allowing for new block groups to be created that can reuse the same
@@ -1095,7 +1098,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * in place until the extents have been discarded completely when
 	 * the transaction commit has completed.
 	 */
-	remove_em = (atomic_read(&block_group->trimming) == 0);
+	remove_em = (atomic_read(&block_group->frozen) == 0);
 	spin_unlock(&block_group->lock);
 
 	mutex_unlock(&fs_info->chunk_mutex);
@@ -1440,7 +1443,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
-			btrfs_get_block_group_trimming(block_group);
+			btrfs_freeze_block_group(block_group);
 
 		/*
 		 * Btrfs_remove_chunk will abort the transaction if things go
@@ -1450,7 +1453,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		if (ret) {
 			if (trimming)
-				btrfs_put_block_group_trimming(block_group);
+				btrfs_unfreeze_block_group(block_group);
 			goto end_trans;
 		}
 
@@ -1799,7 +1802,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
 	btrfs_init_free_space_ctl(cache);
-	atomic_set(&cache->trimming, 0);
+	atomic_set(&cache->frozen, 0);
 	mutex_init(&cache->free_space_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
 
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 107bb557ca8d..04967ea7ba2c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -129,8 +129,17 @@ struct btrfs_block_group {
 	/* For read-only block groups */
 	struct list_head ro_list;
 
+	/*
+	 * When non-zero it means the block group's logical address and its
+	 * device extents can not be reused for future block group allocations
+	 * until the counter goes down to 0. This is to prevent them from being
+	 * reused while some task is still using the block group after it was
+	 * deleted - we want to make sure they can only be reused for new block
+	 * groups after that task is done with the deleted block group.
+	 */
+	atomic_t frozen;
+
 	/* For discard operations */
-	atomic_t trimming;
 	struct list_head discard_list;
 	int discard_index;
 	u64 discard_eligible_time;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8aa7b9dac405..bc10747d1a74 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2498,8 +2498,8 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
-void btrfs_get_block_group_trimming(struct btrfs_block_group *cache);
-void btrfs_put_block_group_trimming(struct btrfs_block_group *cache);
+void btrfs_freeze_block_group(struct btrfs_block_group *cache);
+void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
 enum btrfs_reserve_flush_enum {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 54a64d1e18c6..95e8598d30c9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2932,7 +2932,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 						   &trimmed);
 
 		list_del_init(&block_group->bg_list);
-		btrfs_put_block_group_trimming(block_group);
+		btrfs_unfreeze_block_group(block_group);
 		btrfs_put_block_group(block_group);
 
 		if (ret) {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3613da065a73..e9cfe9da6bbe 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3762,12 +3762,12 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 	return ret;
 }
 
-void btrfs_get_block_group_trimming(struct btrfs_block_group *cache)
+void btrfs_freeze_block_group(struct btrfs_block_group *cache)
 {
-	atomic_inc(&cache->trimming);
+	atomic_inc(&cache->frozen);
 }
 
-void btrfs_put_block_group_trimming(struct btrfs_block_group *block_group)
+void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct extent_map_tree *em_tree;
@@ -3775,7 +3775,7 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group *block_group)
 	bool cleanup;
 
 	spin_lock(&block_group->lock);
-	cleanup = (atomic_dec_and_test(&block_group->trimming) &&
+	cleanup = (atomic_dec_and_test(&block_group->frozen) &&
 		   block_group->removed);
 	spin_unlock(&block_group->lock);
 
@@ -3795,8 +3795,9 @@ void btrfs_put_block_group_trimming(struct btrfs_block_group *block_group)
 		free_extent_map(em);
 
 		/*
-		 * We've left one free space entry and other tasks trimming
-		 * this block group have left 1 entry each one. Free them.
+		 * We may have left one free space entry and other possible
+		 * tasks trimming this block group have left 1 entry each one.
+		 * Free them if any.
 		 */
 		__btrfs_remove_free_space_cache(block_group->free_space_ctl);
 	}
@@ -3816,7 +3817,7 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
-	btrfs_get_block_group_trimming(block_group);
+	btrfs_freeze_block_group(block_group);
 	spin_unlock(&block_group->lock);
 
 	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, false);
@@ -3829,7 +3830,7 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	if (rem)
 		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
 out:
-	btrfs_put_block_group_trimming(block_group);
+	btrfs_unfreeze_block_group(block_group);
 	return ret;
 }
 
@@ -3846,11 +3847,11 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
-	btrfs_get_block_group_trimming(block_group);
+	btrfs_freeze_block_group(block_group);
 	spin_unlock(&block_group->lock);
 
 	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, async);
-	btrfs_put_block_group_trimming(block_group);
+	btrfs_unfreeze_block_group(block_group);
 
 	return ret;
 }
@@ -3868,13 +3869,13 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
-	btrfs_get_block_group_trimming(block_group);
+	btrfs_freeze_block_group(block_group);
 	spin_unlock(&block_group->lock);
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
 			   async);
 
-	btrfs_put_block_group_trimming(block_group);
+	btrfs_unfreeze_block_group(block_group);
 
 	return ret;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7c50ac5b6876..2486f58d8205 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3583,7 +3583,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			btrfs_put_block_group(cache);
 			goto skip;
 		}
-		btrfs_get_block_group_trimming(cache);
+		btrfs_freeze_block_group(cache);
 		spin_unlock(&cache->lock);
 
 		/*
@@ -3641,7 +3641,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		} else {
 			btrfs_warn(fs_info,
 				   "failed setting block group ro: %d", ret);
-			btrfs_put_block_group_trimming(cache);
+			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 			scrub_pause_off(fs_info);
 			break;
@@ -3728,7 +3728,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			spin_unlock(&cache->lock);
 		}
 
-		btrfs_put_block_group_trimming(cache);
+		btrfs_unfreeze_block_group(cache);
 		btrfs_put_block_group(cache);
 		if (ret)
 			break;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8cede6eb9843..3b63f45cb546 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -141,7 +141,7 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 						 struct btrfs_block_group,
 						 bg_list);
 			list_del_init(&cache->bg_list);
-			btrfs_put_block_group_trimming(cache);
+			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 		}
 		WARN_ON(!list_empty(&transaction->dev_update_list));
-- 
2.11.0

