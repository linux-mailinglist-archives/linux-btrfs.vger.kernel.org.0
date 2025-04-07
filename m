Return-Path: <linux-btrfs+bounces-12849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C2A7E8B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB894401D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E39C253B6A;
	Mon,  7 Apr 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7s0JfaE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D9253353
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047398; cv=none; b=a3h/F8YRkrn4VlwVrIawcoOuZWVNQ5I9nu8mYYPqkC5cLRVsZteZ3gFgmKkAbufsX4HtZkzcSXTMFy9K7Sd+XogoCk0Fx8FISyNRLV8kjD1e4JwAFRNSt02Jrd0bUXqr5AMlVs0JTwlDk4AHoTEyf7/pxmbwxDtgSBVi1Uo8Yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047398; c=relaxed/simple;
	bh=dNOiZkpWE5sYSrClG0/nMSxFK7DxF9KDdnpwQ9+Hd50=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9X5hPtP1ojXTJpI0ltkD7ro1kk1zhxESqqOoECGO126SINYFSYqkwEoyF+8dEEwQUpgAas7hLL7fdCdjmr/1oSOYnYbF8ofPuh/1OLaxhv0sNS4HUYhZhjis8HmBUOUucEdECVu6N9ChoxG7t6l0nYflHGgqoSIz+lu2Fh9umY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7s0JfaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5E5C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047398;
	bh=dNOiZkpWE5sYSrClG0/nMSxFK7DxF9KDdnpwQ9+Hd50=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V7s0JfaE/cdL8S1QDke4gv3XiN5DBnuXE2LKwIf91oMBfpi0AVsasWYxr1zt6L6jn
	 c9JklmeHck9dolTykyaqV16xPZ7sQebxcm2XVVtv5N+/DarmtMHw9GR6keb0efPrYP
	 IIEZiLAQi7Vb5f5ywIdQ3L+SMk04YIwrbdfKqfFZY/DCqVVl5u0m6RNAYV36vEsEwF
	 kwBiQP+uNqcVEEz+rF3gsBVG52VcIiXDl4H/qH6jxzYQ+BsmCty6+j27mOd52rn9YW
	 k0JFjyyLiNesZPmYhj7IV2ttzWV6pFOiBBwmoHtwDYP4WjX8mJwM1BQQsj4pcyKoZO
	 /rv+8JSVZyepA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/16] btrfs: rename the functions to init and release an extent io tree
Date: Mon,  7 Apr 2025 18:36:18 +0100
Message-Id: <8ec9a2b1c13315bc4d53a0abb330f7f862747956.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These functions are exported so they should have a 'btrfs_' prefix by
convention, to make it clear they are btrfs specific and to avoid
collisions with functions from elsewhere in the kernel.

So add a 'btrfs_' prefix to their name to make it clear they are from
btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c               | 16 ++++++++--------
 fs/btrfs/extent-io-tree.c        |  6 +++---
 fs/btrfs/extent-io-tree.h        |  6 +++---
 fs/btrfs/inode.c                 |  5 +++--
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/tests/btrfs-tests.c     |  4 ++--
 fs/btrfs/tests/extent-io-tests.c |  4 ++--
 fs/btrfs/transaction.c           | 12 ++++++------
 fs/btrfs/tree-log.c              |  4 ++--
 fs/btrfs/volumes.c               |  6 +++---
 10 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4259f0582c0d..f90f74d8b137 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -691,10 +691,10 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	btrfs_set_root_last_log_commit(root, 0);
 	root->anon_dev = 0;
 	if (!dummy) {
-		extent_io_tree_init(fs_info, &root->dirty_log_pages,
-				    IO_TREE_ROOT_DIRTY_LOG_PAGES);
-		extent_io_tree_init(fs_info, &root->log_csum_range,
-				    IO_TREE_LOG_CSUM_RANGE);
+		btrfs_extent_io_tree_init(fs_info, &root->dirty_log_pages,
+					  IO_TREE_ROOT_DIRTY_LOG_PAGES);
+		btrfs_extent_io_tree_init(fs_info, &root->log_csum_range,
+					  IO_TREE_LOG_CSUM_RANGE);
 	}
 
 	spin_lock_init(&root->root_item_lock);
@@ -1920,8 +1920,8 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	inode->i_mapping->a_ops = &btree_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
-	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
-			    IO_TREE_BTREE_INODE_IO);
+	btrfs_extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
+				  IO_TREE_BTREE_INODE_IO);
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
@@ -2855,8 +2855,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	rwlock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
 
-	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
-			    IO_TREE_FS_EXCLUDED_EXTENTS);
+	btrfs_extent_io_tree_init(fs_info, &fs_info->excluded_extents,
+				  IO_TREE_FS_EXCLUDED_EXTENTS);
 
 	mutex_init(&fs_info->ordered_operations_mutex);
 	mutex_init(&fs_info->tree_log_mutex);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6330071cc73f..4b9f18a12154 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -95,8 +95,8 @@ const struct btrfs_fs_info *btrfs_extent_io_tree_to_fs_info(const struct extent_
 	return tree->fs_info;
 }
 
-void extent_io_tree_init(struct btrfs_fs_info *fs_info,
-			 struct extent_io_tree *tree, unsigned int owner)
+void btrfs_extent_io_tree_init(struct btrfs_fs_info *fs_info,
+			       struct extent_io_tree *tree, unsigned int owner)
 {
 	tree->state = RB_ROOT;
 	spin_lock_init(&tree->lock);
@@ -111,7 +111,7 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
  * aren't any waiters on any extent state record (EXTENT_LOCK_BITS are never
  * set on any extent state when calling this function).
  */
-void extent_io_tree_release(struct extent_io_tree *tree)
+void btrfs_extent_io_tree_release(struct extent_io_tree *tree)
 {
 	struct rb_root root;
 	struct extent_state *state;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 361d27c6b294..85eeee4ac613 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -137,9 +137,9 @@ struct extent_state {
 const struct btrfs_inode *btrfs_extent_io_tree_to_inode(const struct extent_io_tree *tree);
 const struct btrfs_fs_info *btrfs_extent_io_tree_to_fs_info(const struct extent_io_tree *tree);
 
-void extent_io_tree_init(struct btrfs_fs_info *fs_info,
-			 struct extent_io_tree *tree, unsigned int owner);
-void extent_io_tree_release(struct extent_io_tree *tree);
+void btrfs_extent_io_tree_init(struct btrfs_fs_info *fs_info,
+			       struct extent_io_tree *tree, unsigned int owner);
+void btrfs_extent_io_tree_release(struct extent_io_tree *tree);
 int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 			   struct extent_state **cached);
 bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ebdd5e46af6..bf1f4821b8db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3816,7 +3816,8 @@ static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
 	if (!inode->file_extent_tree)
 		return -ENOMEM;
 
-	extent_io_tree_init(fs_info, inode->file_extent_tree, IO_TREE_INODE_FILE_EXTENT);
+	btrfs_extent_io_tree_init(fs_info, inode->file_extent_tree,
+				  IO_TREE_INODE_FILE_EXTENT);
 	/* Lockdep class is set only for the file extent tree. */
 	lockdep_set_class(&inode->file_extent_tree->lock, &file_extent_tree_class);
 
@@ -7742,7 +7743,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_map_tree_init(&ei->extent_tree);
 
 	/* This io tree sets the valid inode. */
-	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
+	btrfs_extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
 	ei->io_tree.inode = ei;
 
 	ei->file_extent_tree = NULL;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b996fb0ee374..0a5a48aa58cc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3860,7 +3860,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 	btrfs_backref_init_cache(fs_info, &rc->backref_cache, true);
 	rc->reloc_root_tree.rb_root = RB_ROOT;
 	spin_lock_init(&rc->reloc_root_tree.lock);
-	extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLOCKS);
+	btrfs_extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLOCKS);
 	return rc;
 }
 
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 5eff8d7d2360..02a915eb51fb 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -102,7 +102,7 @@ struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	extent_io_tree_init(fs_info, &dev->alloc_state, 0);
+	btrfs_extent_io_tree_init(fs_info, &dev->alloc_state, 0);
 	INIT_LIST_HEAD(&dev->dev_list);
 	list_add(&dev->dev_list, &fs_info->fs_devices->devices);
 
@@ -111,7 +111,7 @@ struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info)
 
 static void btrfs_free_dummy_device(struct btrfs_device *dev)
 {
-	extent_io_tree_release(&dev->alloc_state);
+	btrfs_extent_io_tree_release(&dev->alloc_state);
 	kfree(dev);
 }
 
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 6f9bf1174d3b..b603563bd209 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -148,7 +148,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * Passing NULL as we don't have fs_info but tracepoints are not used
 	 * at this point
 	 */
-	extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST);
+	btrfs_extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST);
 
 	/*
 	 * First go through and create and mark all of our pages dirty, we pin
@@ -563,7 +563,7 @@ static int test_find_first_clear_extent_bit(void)
 
 	test_msg("running find_first_clear_extent_bit test");
 
-	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST);
+	btrfs_extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST);
 
 	/* Test correct handling of empty tree */
 	btrfs_find_first_clear_extent_bit(&tree, 0, &start, &end, CHUNK_TRIMMED);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8fa9af18e483..c640e80d2a20 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -197,7 +197,7 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 		list_del_init(&root->dirty_list);
 		free_extent_buffer(root->commit_root);
 		root->commit_root = btrfs_root_node(root);
-		extent_io_tree_release(&root->dirty_log_pages);
+		btrfs_extent_io_tree_release(&root->dirty_log_pages);
 		btrfs_qgroup_clean_swapped_blocks(root);
 	}
 
@@ -383,10 +383,10 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
-	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
-			IO_TREE_TRANS_DIRTY_PAGES);
-	extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
-			IO_TREE_FS_PINNED_EXTENTS);
+	btrfs_extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
+				  IO_TREE_TRANS_DIRTY_PAGES);
+	btrfs_extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
+				  IO_TREE_FS_PINNED_EXTENTS);
 	btrfs_set_fs_generation(fs_info, fs_info->generation + 1);
 	cur_trans->transid = fs_info->generation;
 	fs_info->running_transaction = cur_trans;
@@ -1265,7 +1265,7 @@ static int btrfs_write_and_wait_transaction(struct btrfs_trans_handle *trans)
 	blk_finish_plug(&plug);
 	ret2 = btrfs_wait_extents(fs_info, dirty_pages);
 
-	extent_io_tree_release(&trans->transaction->dirty_pages);
+	btrfs_extent_io_tree_release(&trans->transaction->dirty_pages);
 
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 31087b69d68f..856ec4431ce2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3251,8 +3251,8 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	extent_io_tree_release(&log->dirty_log_pages);
-	extent_io_tree_release(&log->log_csum_range);
+	btrfs_extent_io_tree_release(&log->dirty_log_pages);
+	btrfs_extent_io_tree_release(&log->log_csum_range);
 
 	btrfs_put_root(log);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3c7633a33944..7509cbe3272c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -404,7 +404,7 @@ static void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
 	rcu_string_free(device->name);
-	extent_io_tree_release(&device->alloc_state);
+	btrfs_extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
@@ -1225,7 +1225,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 
 	device->fs_info = NULL;
 	atomic_set(&device->dev_stats_ccnt, 0);
-	extent_io_tree_release(&device->alloc_state);
+	btrfs_extent_io_tree_release(&device->alloc_state);
 
 	/*
 	 * Reset the flush error record. We might have a transient flush error
@@ -6952,7 +6952,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 
 	atomic_set(&dev->dev_stats_ccnt, 0);
 	btrfs_device_data_ordered_init(dev);
-	extent_io_tree_init(fs_info, &dev->alloc_state, IO_TREE_DEVICE_ALLOC_STATE);
+	btrfs_extent_io_tree_init(fs_info, &dev->alloc_state, IO_TREE_DEVICE_ALLOC_STATE);
 
 	if (devid)
 		tmp = *devid;
-- 
2.45.2


