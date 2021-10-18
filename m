Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1560432525
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 19:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhJRRkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 13:40:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59254 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhJRRkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 13:40:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE8371FD6D;
        Mon, 18 Oct 2021 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634578712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RVn1MY1RbkUfhwczssXSnfiuaWNCfUBuP2Z3AXRHC+E=;
        b=LylGOP9njabgTLwRKk/GYZoHs0gCV76DzQCTEzpiGEm1Rvvi0pmDuGvBtOti+50FFJwIIE
        VFIhu291ycwZElXcl1o0u4RcjN/wKvNHj7lNCPSu2a3dm488JCxr4payGLrpNziE505hnH
        i6uqlgFQcUG74CVHoDGFVfoX+wSCf6o=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A3398A3B84;
        Mon, 18 Oct 2021 17:38:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4572DA7A3; Mon, 18 Oct 2021 19:38:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: add stub argument to transaction API
Date:   Mon, 18 Oct 2021 19:38:03 +0200
Message-Id: <20211018173803.18353-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is minimum preparatory patch (still big) for the scoped NOFS
changes. I'd like to get it merged for 5.16 so I can start the
conversion. To keep patch conflicts low I'm going to apply as one of the
last patches before code freeze, as we're in rc6 time it's a good
opportunity to still catch the next dev cycle.

---

This is preparatory work for scope NOFS [1]. The section that must not
recurse back to the filesystem would be enclosed in
memalloc_nofs_save/memalloc_nofs_restore, wrapped by our transaction
API. The new argument will store the context data for the NOFS status.

This patch doesn't change anything yet, only extends the functions to
make it easier to integrate with new patches and develop the real scope
NOFS changes in incrementally.

Until the rest of the changes lands, use NULL for the argument.

References:

* https://lwn.net/Articles/635354/ (2015)
* https://lwn.net/Articles/723317/ (2017)
* https://lwn.net/Articles/710545/ (2017)
* every now and then somebody asks about GFP_NOFAIL and GFP_NOFS

Note: full conversion to scoped NOFS is a long term plan with following
phases:

1. switch GFP_NOFS to GFP_KERNEL where it's safe without any additional
   changes (context is safe, eg. in tests)
2. switch GFP_NOFS to memalloc_nofs_* + GFP_KERNEL in cases where we
   know it's unsafe to do plain GFP_KERNEL, eg. with an open transaction
3. introduce framework to do transaction start/end scope NOFS
   protection, no actual changes
4. incrementally switch function by function to use the local
   transaction context to track the NOFS context
5. once finished, remove the memalloc_nofs_* calls

1 and 2 are basically done, 3 is this patch.

Why the stub/context argument is needed: the NOFS protection is per call
site, so it must be set and reset in the caller thread, so any
allocations between btrfs_start_transaction and btrfs_end_transaction
are safe. We can't store it in the transaction handle, because it's not
passed everywhere, eg. to various helpers in btrfs and potentially in
other subsystems.

The changes in each function will go like:

  int function() {
	  DEFINE_TCTX(tctx);

	  ...
	  trans = btrfs_start_transaction(0, &tctx);
	  ...
	  btrfs_end_transaction(trans, &tctx);
  }

The protection itself will be schematically:

  struct btrfs_tctx {
	  u32 nofs_flags;
  };

  transaction* btrfs_start_transaction(..., *tctx) {
	  ...
	  tctx->nofs_flags = memalloc_nofs_save();
	  ...
  }

  int btrfs_end_transaction(trans, *tctx) {
	  ...
	  memalloc_nofs_restore(tctx->nofs_flags);
	  ...
  }

The context must be saved at the right time, there are more starting
points and error handling must keep the context nesting balanced.
This inevitably bloats stacks of many functions, but u32 should
be acceptable.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c          |   8 +--
 fs/btrfs/block-group.c      |  12 ++--
 fs/btrfs/delayed-inode.c    |   8 +--
 fs/btrfs/dev-replace.c      |  24 ++++----
 fs/btrfs/disk-io.c          |  10 +--
 fs/btrfs/extent-tree.c      |  16 ++---
 fs/btrfs/file.c             |  28 ++++-----
 fs/btrfs/free-space-cache.c |   6 +-
 fs/btrfs/free-space-tree.c  |  12 ++--
 fs/btrfs/inode.c            | 117 ++++++++++++++++++------------------
 fs/btrfs/ioctl.c            |  66 ++++++++++----------
 fs/btrfs/qgroup.c           |  32 +++++-----
 fs/btrfs/reflink.c          |  10 +--
 fs/btrfs/relocation.c       |  54 ++++++++---------
 fs/btrfs/root-tree.c        |   4 +-
 fs/btrfs/scrub.c            |   4 +-
 fs/btrfs/send.c             |   6 +-
 fs/btrfs/space-info.c       |  16 ++---
 fs/btrfs/super.c            |  10 +--
 fs/btrfs/transaction.c      |  83 ++++++++++++++-----------
 fs/btrfs/transaction.h      |  38 ++++++++----
 fs/btrfs/tree-log.c         |   6 +-
 fs/btrfs/uuid-tree.c        |   4 +-
 fs/btrfs/verity.c           |  28 ++++-----
 fs/btrfs/volumes.c          |  57 +++++++++---------
 fs/btrfs/xattr.c            |   8 +--
 26 files changed, 348 insertions(+), 319 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f735b8798ba1..6a9730b74886 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1539,7 +1539,7 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 	ulist_init(roots);
 	ulist_init(tmp);
 
-	trans = btrfs_join_transaction_nostart(root);
+	trans = btrfs_join_transaction_nostart(root, NULL);
 	if (IS_ERR(trans)) {
 		if (PTR_ERR(trans) != -ENOENT && PTR_ERR(trans) != -EROFS) {
 			ret = PTR_ERR(trans);
@@ -1573,7 +1573,7 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
 
 	if (trans) {
 		btrfs_put_tree_mod_seq(fs_info, &elem);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	} else {
 		up_read(&fs_info->commit_root_sem);
 	}
@@ -1962,7 +1962,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 			extent_item_objectid);
 
 	if (!search_commit_root) {
-		trans = btrfs_attach_transaction(fs_info->extent_root);
+		trans = btrfs_attach_transaction(fs_info->extent_root, NULL);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) != -ENOENT &&
 			    PTR_ERR(trans) != -EROFS)
@@ -2009,7 +2009,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 out:
 	if (trans) {
 		btrfs_put_tree_mod_seq(fs_info, &seq_elem);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	} else {
 		up_read(&fs_info->commit_root_sem);
 	}
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 444e9c89ff3e..a0941ea25027 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1140,7 +1140,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
-							   num_items);
+							   num_items, NULL);
 }
 
 /*
@@ -1458,7 +1458,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			btrfs_get_block_group(block_group);
 		}
 end_trans:
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 next:
 		btrfs_put_block_group(block_group);
 		spin_lock(&fs_info->unused_bgs_lock);
@@ -1468,7 +1468,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	return;
 
 flip_async:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_put_block_group(block_group);
 	btrfs_discard_punt_unused_bgs_list(fs_info);
@@ -2548,7 +2548,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	bool dirty_bg_running;
 
 	do {
-		trans = btrfs_join_transaction(fs_info->extent_root);
+		trans = btrfs_join_transaction(fs_info->extent_root, NULL);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
@@ -2564,7 +2564,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			u64 transid = trans->transid;
 
 			mutex_unlock(&fs_info->ro_block_group_mutex);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 
 			ret = btrfs_wait_for_commit(fs_info, transid);
 			if (ret)
@@ -2615,7 +2615,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 unlock_out:
 	mutex_unlock(&fs_info->ro_block_group_mutex);
 
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e164766dcc38..4b8a77db9ac7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1172,7 +1172,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	}
 	mutex_unlock(&delayed_node->mutex);
 
-	trans = btrfs_join_transaction(delayed_node->root);
+	trans = btrfs_join_transaction(delayed_node->root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -1198,7 +1198,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 	btrfs_free_path(path);
 	trans->block_rsv = block_rsv;
 trans_out:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(fs_info);
 out:
 	btrfs_release_delayed_node(delayed_node);
@@ -1253,7 +1253,7 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 
 		root = delayed_node->root;
 
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			btrfs_release_path(path);
 			btrfs_release_prepared_delayed_node(delayed_node);
@@ -1267,7 +1267,7 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		__btrfs_commit_inode_delayed_items(trans, path, delayed_node);
 
 		trans->block_rsv = block_rsv;
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_btree_balance_dirty_nodelay(root->fs_info);
 
 		btrfs_release_path(path);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 59ef388d43bc..8ebfb4e8e517 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -486,7 +486,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	       !list_empty(&fs_info->running_transaction->dev_update_list)) {
 		spin_unlock(&fs_info->trans_lock);
 		mutex_unlock(&fs_info->chunk_mutex);
-		trans = btrfs_attach_transaction(root);
+		trans = btrfs_attach_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			mutex_lock(&fs_info->chunk_mutex);
@@ -498,7 +498,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 			}
 		}
 
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 		mutex_lock(&fs_info->chunk_mutex);
 		if (ret)
 			goto unlock;
@@ -667,9 +667,9 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	 * Here we commit the transaction to make sure commit_total_bytes
 	 * of all the devices are updated.
 	 */
-	trans = btrfs_attach_transaction(root);
+	trans = btrfs_attach_transaction(root, NULL);
 	if (!IS_ERR(trans)) {
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 		if (ret)
 			return ret;
 	} else if (PTR_ERR(trans) != -ENOENT) {
@@ -732,7 +732,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 
 	/* Commit dev_replace state and reserve 1 item for it. */
-	trans = btrfs_start_transaction(root, 1);
+	trans = btrfs_start_transaction(root, 1, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		down_write(&dev_replace->rwsem);
@@ -744,7 +744,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		goto leave;
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	WARN_ON(ret);
 
 	/* the disk copy procedure reuses the scrub code */
@@ -916,13 +916,13 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	 * chunks shouldn't be allocated on the device.
 	 */
 	while (1) {
-		trans = btrfs_start_transaction(root, 0);
+		trans = btrfs_start_transaction(root, 0, NULL);
 		if (IS_ERR(trans)) {
 			btrfs_reada_undo_remove_dev(src_device);
 			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 			return PTR_ERR(trans);
 		}
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 		WARN_ON(ret);
 
 		/* Prevent write_all_supers() during the finishing procedure */
@@ -1032,9 +1032,9 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 					  src_device->name->str);
 
 	/* write back the superblocks */
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (!IS_ERR(trans))
-		btrfs_commit_transaction(trans);
+		btrfs_commit_transaction(trans, NULL);
 
 	mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 
@@ -1154,12 +1154,12 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 		ret = btrfs_scrub_cancel(fs_info);
 		ASSERT(ret != -ENOTCONN);
 
-		trans = btrfs_start_transaction(root, 0);
+		trans = btrfs_start_transaction(root, 0, NULL);
 		if (IS_ERR(trans)) {
 			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
 			return PTR_ERR(trans);
 		}
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 		WARN_ON(ret);
 
 		btrfs_info_in_rcu(fs_info,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1ae30b29f2b5..f06647a2225e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1939,16 +1939,16 @@ static int transaction_kthread(void *arg)
 		spin_unlock(&fs_info->trans_lock);
 
 		/* If the file system is aborted, this will always fail. */
-		trans = btrfs_attach_transaction(root);
+		trans = btrfs_attach_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) != -ENOENT)
 				cannot_commit = true;
 			goto sleep;
 		}
 		if (transid == trans->transid) {
-			btrfs_commit_transaction(trans);
+			btrfs_commit_transaction(trans, NULL);
 		} else {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 		}
 sleep:
 		wake_up_process(fs_info->cleaner_kthread);
@@ -4307,10 +4307,10 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 }
 
 void __cold close_ctree(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3fd736a02c1e..46af7bac5ed7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4038,7 +4038,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			if (trans)
 				exist = 1;
 			else
-				trans = btrfs_join_transaction(root);
+				trans = btrfs_join_transaction(root, NULL);
 
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
@@ -4056,7 +4056,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			else
 				ret = 0;
 			if (!exist)
-				btrfs_end_transaction(trans);
+				btrfs_end_transaction(trans, NULL);
 			if (ret)
 				return ret;
 		}
@@ -5598,9 +5598,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 * wait_reserve_ticket and the whole reservation callchain.
 	 */
 	if (for_reloc)
-		trans = btrfs_join_transaction(tree_root);
+		trans = btrfs_join_transaction(tree_root, NULL);
 	else
-		trans = btrfs_start_transaction(tree_root, 0);
+		trans = btrfs_start_transaction(tree_root, 0, NULL);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_free;
@@ -5722,7 +5722,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 				goto out_end_trans;
 			}
 
-			btrfs_end_transaction_throttle(trans);
+			btrfs_end_transaction_throttle(trans, NULL);
 			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
 				btrfs_debug(fs_info,
 					    "drop snapshot early exit");
@@ -5736,9 +5736,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			* reservation callchain.
 			*/
 			if (for_reloc)
-				trans = btrfs_join_transaction(tree_root);
+				trans = btrfs_join_transaction(tree_root, NULL);
 			else
-				trans = btrfs_start_transaction(tree_root, 0);
+				trans = btrfs_start_transaction(tree_root, 0, NULL);
 			if (IS_ERR(trans)) {
 				err = PTR_ERR(trans);
 				goto out_free;
@@ -5788,7 +5788,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		btrfs_put_root(root);
 	root_dropped = true;
 out_end_trans:
-	btrfs_end_transaction_throttle(trans);
+	btrfs_end_transaction_throttle(trans, NULL);
 out_free:
 	kfree(wc);
 	btrfs_free_path(path);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9a3db1365ae8..96b94b359036 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2262,7 +2262,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * from thinking they are super smart and changing this to
 	 * btrfs_join_transaction *cough*Josef*cough*.
 	 */
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_release_extents;
@@ -2292,20 +2292,20 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		if (!ret) {
 			ret = btrfs_sync_log(trans, root, &ctx);
 			if (!ret) {
-				ret = btrfs_end_transaction(trans);
+				ret = btrfs_end_transaction(trans, NULL);
 				goto out;
 			}
 		}
 		if (!full_sync) {
 			ret = btrfs_wait_ordered_range(inode, start, len);
 			if (ret) {
-				btrfs_end_transaction(trans);
+				btrfs_end_transaction(trans, NULL);
 				goto out;
 			}
 		}
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 	} else {
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_end_transaction(trans, NULL);
 	}
 out:
 	ASSERT(list_empty(&ctx.list));
@@ -2687,7 +2687,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	else
 		rsv_count = 2;
 
-	trans = btrfs_start_transaction(root, rsv_count);
+	trans = btrfs_start_transaction(root, rsv_count, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
@@ -2784,10 +2784,10 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		if (ret)
 			break;
 
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_btree_balance_dirty(fs_info);
 
-		trans = btrfs_start_transaction(root, rsv_count);
+		trans = btrfs_start_transaction(root, rsv_count, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			trans = NULL;
@@ -2878,7 +2878,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 
 	trans->block_rsv = &fs_info->trans_block_rsv;
 	if (ret)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	else
 		*trans_out = trans;
 out_free:
@@ -3019,7 +3019,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	updated_inode = true;
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(fs_info);
 out:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
@@ -3038,14 +3038,14 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		inode_inc_iversion(inode);
 		inode->i_mtime = now;
 		inode->i_ctime = now;
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 		} else {
 			int ret2;
 
 			ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-			ret2 = btrfs_end_transaction(trans);
+			ret2 = btrfs_end_transaction(trans, NULL);
 			if (!ret)
 				ret = ret2;
 		}
@@ -3104,7 +3104,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 	if (mode & FALLOC_FL_KEEP_SIZE || end <= i_size_read(inode))
 		return 0;
 
-	trans = btrfs_start_transaction(root, 1);
+	trans = btrfs_start_transaction(root, 1, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -3112,7 +3112,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 	i_size_write(inode, end);
 	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	ret2 = btrfs_end_transaction(trans);
+	ret2 = btrfs_end_transaction(trans, NULL);
 
 	return ret ? ret : ret2;
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f3fee88c8ee0..83997e99fc88 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3990,7 +3990,7 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
 	 * have any other work to do, or are disabling it and removing free
 	 * space inodes.
 	 */
-	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	trans = btrfs_start_transaction(fs_info->tree_root, 0, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -3999,12 +3999,12 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool act
 		ret = cleanup_free_space_cache_v1(fs_info, trans);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			goto out;
 		}
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 out:
 	clear_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a33bca94d133..a2705d4e7d25 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1145,7 +1145,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	struct rb_node *node;
 	int ret;
 
-	trans = btrfs_start_transaction(tree_root, 0);
+	trans = btrfs_start_transaction(tree_root, 0, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -1172,7 +1172,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
 	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
 	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 
 	/*
 	 * Now that we've committed the transaction any reading of our commit
@@ -1185,7 +1185,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
 	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 	btrfs_abort_transaction(trans, ret);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -1235,7 +1235,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	struct btrfs_root *free_space_root = fs_info->free_space_root;
 	int ret;
 
-	trans = btrfs_start_transaction(tree_root, 0);
+	trans = btrfs_start_transaction(tree_root, 0, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -1261,11 +1261,11 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 
 	btrfs_put_root(free_space_root);
 
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 
 abort:
 	btrfs_abort_transaction(trans, ret);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3032893efee5..d952688c257b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -372,7 +372,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -432,7 +432,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	 */
 	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
 	btrfs_free_path(path);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -3054,9 +3054,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		if (freespace_inode)
-			trans = btrfs_join_transaction_spacecache(root);
+			trans = btrfs_join_transaction_spacecache(root, NULL);
 		else
-			trans = btrfs_join_transaction(root);
+			trans = btrfs_join_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			trans = NULL;
@@ -3073,9 +3073,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	lock_extent_bits(io_tree, start, end, &cached_state);
 
 	if (freespace_inode)
-		trans = btrfs_join_transaction_spacecache(root);
+		trans = btrfs_join_transaction_spacecache(root, NULL);
 	else
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
@@ -3139,7 +3139,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			 &cached_state);
 
 	if (trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 
 	if (ret || truncated) {
 		u64 unwritten_start = start;
@@ -3610,7 +3610,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 				if (ret)
 					goto out;
 			}
-			trans = btrfs_start_transaction(root, 1);
+			trans = btrfs_start_transaction(root, 1, NULL);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
 				goto out;
@@ -3619,7 +3619,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 				    found_key.objectid);
 			ret = btrfs_del_orphan_item(trans, root,
 						    found_key.objectid);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			if (ret)
 				goto out;
 			continue;
@@ -3636,9 +3636,9 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	root->orphan_cleanup_state = ORPHAN_CLEANUP_DONE;
 
 	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state)) {
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 		if (!IS_ERR(trans))
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 	}
 
 	if (nr_unlink)
@@ -4171,7 +4171,8 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
  * plenty of slack room in the global reserve to migrate, otherwise we cannot
  * allow the unlink to occur.
  */
-static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
+static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir,
+		struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 
@@ -4182,7 +4183,7 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 	 * 1 for the inode ref
 	 * 1 for the inode
 	 */
-	return btrfs_start_transaction_fallback_global_rsv(root, 5);
+	return btrfs_start_transaction_fallback_global_rsv(root, 5, NULL);
 }
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
@@ -4192,7 +4193,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	int ret;
 
-	trans = __unlink_start_trans(dir);
+	trans = __unlink_start_trans(dir, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -4212,7 +4213,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 out:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(root->fs_info);
 	return ret;
 }
@@ -4479,7 +4480,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	if (ret)
 		goto out_up_write;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_release;
@@ -4539,7 +4540,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 out_end_trans:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
-	ret = btrfs_end_transaction(trans);
+	ret = btrfs_end_transaction(trans, NULL);
 	inode->i_flags |= S_DEAD;
 out_release:
 	btrfs_subvolume_release_metadata(root, &block_rsv);
@@ -4573,7 +4574,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (btrfs_ino(BTRFS_I(inode)) == BTRFS_FIRST_FREE_OBJECTID)
 		return btrfs_delete_subvolume(dir, dentry);
 
-	trans = __unlink_start_trans(dir);
+	trans = __unlink_start_trans(dir, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -4609,7 +4610,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 			BTRFS_I(dir)->last_unlink_trans = last_unlink_trans;
 	}
 out:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(root->fs_info);
 
 	return err;
@@ -5166,7 +5167,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 	 * 1 - for the one we're adding
 	 * 1 - for updating the inode.
 	 */
-	trans = btrfs_start_transaction(root, 3);
+	trans = btrfs_start_transaction(root, 3, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -5177,7 +5178,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		return ret;
 	}
 
@@ -5189,7 +5190,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 		btrfs_update_inode_bytes(inode, 0, drop_args.bytes_found);
 		btrfs_update_inode(trans, root, inode);
 	}
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -5339,7 +5340,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 			return ret;
 		}
 
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans)) {
 			btrfs_drew_write_unlock(&root->snapshot_lock);
 			return PTR_ERR(trans);
@@ -5350,7 +5351,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		btrfs_drew_write_unlock(&root->snapshot_lock);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	} else {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
@@ -5523,7 +5524,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 }
 
 static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
-							struct btrfs_block_rsv *rsv)
+		struct btrfs_block_rsv *rsv, struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
@@ -5560,7 +5561,7 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 		delayed_refs_extra = 0;
 	}
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans))
 		return trans;
 
@@ -5624,7 +5625,7 @@ void btrfs_evict_inode(struct inode *inode)
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
 	while (1) {
-		trans = evict_refill_and_join(root, rsv);
+		trans = evict_refill_and_join(root, rsv, NULL);
 		if (IS_ERR(trans))
 			goto free_rsv;
 
@@ -5633,7 +5634,7 @@ void btrfs_evict_inode(struct inode *inode)
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 						 0, 0, NULL);
 		trans->block_rsv = &fs_info->trans_block_rsv;
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_btree_balance_dirty(fs_info);
 		if (ret && ret != -ENOSPC && ret != -EAGAIN)
 			goto free_rsv;
@@ -5650,12 +5651,12 @@ void btrfs_evict_inode(struct inode *inode)
 	 * If it turns out that we are dropping too many of these, we might want
 	 * to add a mechanism for retrying these after a commit.
 	 */
-	trans = evict_refill_and_join(root, rsv);
+	trans = evict_refill_and_join(root, rsv, NULL);
 	if (!IS_ERR(trans)) {
 		trans->block_rsv = rsv;
 		btrfs_orphan_del(trans, BTRFS_I(inode));
 		trans->block_rsv = &fs_info->trans_block_rsv;
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	}
 
 free_rsv:
@@ -6264,21 +6265,21 @@ static int btrfs_dirty_inode(struct inode *inode)
 	if (test_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags))
 		return 0;
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret && (ret == -ENOSPC || ret == -EDQUOT)) {
 		/* whoops, lets try again with the full transaction */
-		btrfs_end_transaction(trans);
-		trans = btrfs_start_transaction(root, 1);
+		btrfs_end_transaction(trans, NULL);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	}
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	if (BTRFS_I(inode)->delayed_node)
 		btrfs_balance_delayed_items(fs_info);
 
@@ -6725,7 +6726,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	 * 2 for dir items
 	 * 1 for xattr if selinux is on
 	 */
-	trans = btrfs_start_transaction(root, 5);
+	trans = btrfs_start_transaction(root, 5, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -6764,7 +6765,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err && inode) {
 		inode_dec_link_count(inode);
@@ -6789,7 +6790,7 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	 * 2 for dir items
 	 * 1 for xattr if selinux is on
 	 */
-	trans = btrfs_start_transaction(root, 5);
+	trans = btrfs_start_transaction(root, 5, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -6831,7 +6832,7 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	if (err && inode) {
 		inode_dec_link_count(inode);
 		discard_new_inode(inode);
@@ -6868,7 +6869,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	 * 1 item for parent inode
 	 * 1 item for orphan item deletion if O_TMPFILE
 	 */
-	trans = btrfs_start_transaction(root, inode->i_nlink ? 5 : 6);
+	trans = btrfs_start_transaction(root, inode->i_nlink ? 5 : 6, NULL);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		trans = NULL;
@@ -6909,7 +6910,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 
 fail:
 	if (trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	if (drop_inode) {
 		inode_dec_link_count(inode);
 		iput(inode);
@@ -6934,7 +6935,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	 * 2 items for dir items
 	 * 1 for xattr if selinux is on
 	 */
-	trans = btrfs_start_transaction(root, 5);
+	trans = btrfs_start_transaction(root, 5, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -6974,7 +6975,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 out_fail:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	if (err && inode) {
 		inode_dec_link_count(inode);
 		discard_new_inode(inode);
@@ -8941,7 +8942,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	 * 1 for the truncate slack space
 	 * 1 for updating the inode.
 	 */
-	trans = btrfs_start_transaction(root, 2);
+	trans = btrfs_start_transaction(root, 2, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -8967,10 +8968,10 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		if (ret)
 			break;
 
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_btree_balance_dirty(fs_info);
 
-		trans = btrfs_start_transaction(root, 2);
+		trans = btrfs_start_transaction(root, 2, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			trans = NULL;
@@ -8991,13 +8992,13 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	 * btrfs_truncate_block and then update the disk_i_size.
 	 */
 	if (ret == NEED_TRUNCATE_BLOCK) {
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_btree_balance_dirty(fs_info);
 
 		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
 		if (ret)
 			goto out;
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			goto out;
@@ -9013,7 +9014,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		if (ret2 && !ret)
 			ret = ret2;
 
-		ret2 = btrfs_end_transaction(trans);
+		ret2 = btrfs_end_transaction(trans, NULL);
 		if (ret2 && !ret)
 			ret = ret2;
 		btrfs_btree_balance_dirty(fs_info);
@@ -9364,7 +9365,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	 * inodes.  So 5 * 2 is 10, plus 2 for the new links, so 12 total items
 	 * should cover the worst case number of items we'll modify.
 	 */
-	trans = btrfs_start_transaction(root, 12);
+	trans = btrfs_start_transaction(root, 12, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_notrans;
@@ -9557,7 +9558,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 			dest_log_pinned = false;
 		}
 	}
-	ret2 = btrfs_end_transaction(trans);
+	ret2 = btrfs_end_transaction(trans, NULL);
 	ret = ret ? ret : ret2;
 out_notrans:
 	if (new_ino == BTRFS_FIRST_FREE_OBJECTID ||
@@ -9696,7 +9697,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	trans_num_items = 11;
 	if (flags & RENAME_WHITEOUT)
 		trans_num_items += 5;
-	trans = btrfs_start_transaction(root, trans_num_items);
+	trans = btrfs_start_transaction(root, trans_num_items, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_notrans;
@@ -9843,7 +9844,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		btrfs_end_log_trans(root);
 		log_pinned = false;
 	}
-	ret2 = btrfs_end_transaction(trans);
+	ret2 = btrfs_end_transaction(trans, NULL);
 	ret = ret ? ret : ret2;
 out_notrans:
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
@@ -10088,7 +10089,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	 * 1 item for the inline extent item
 	 * 1 item for xattr if selinux is on
 	 */
-	trans = btrfs_start_transaction(root, 7);
+	trans = btrfs_start_transaction(root, 7, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -10170,7 +10171,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	if (err && inode) {
 		inode_dec_link_count(inode);
 		discard_new_inode(inode);
@@ -10372,12 +10373,12 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			if (own_trans)
-				btrfs_end_transaction(trans);
+				btrfs_end_transaction(trans, NULL);
 			break;
 		}
 
 		if (own_trans) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			trans = NULL;
 		}
 	}
@@ -10440,7 +10441,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	/*
 	 * 5 units required for adding orphan entry
 	 */
-	trans = btrfs_start_transaction(root, 5);
+	trans = btrfs_start_transaction(root, 5, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -10484,7 +10485,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	unlock_new_inode(inode);
 	mark_inode_dirty(inode);
 out:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	if (ret && inode)
 		discard_new_inode(inode);
 	btrfs_btree_balance_dirty(fs_info);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c9d3f375df83..a513791282c1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -266,7 +266,7 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	/* If coming from FS_IOC_FSSETXATTR then skip unconverted flags */
 	if (!fa->flags_valid) {
 		/* 1 item for the inode */
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 		goto update_flags;
@@ -329,7 +329,7 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	 * 1 for inode item
 	 * 2 for properties
 	 */
-	trans = btrfs_start_transaction(root, 3);
+	trans = btrfs_start_transaction(root, 3, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -357,7 +357,7 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
  out_end_trans:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -552,7 +552,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	if (ret)
 		goto fail_free;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_subvolume_release_metadata(root, &block_rsv);
@@ -695,7 +695,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	trans->bytes_reserved = 0;
 	btrfs_subvolume_release_metadata(root, &block_rsv);
 
-	err = btrfs_commit_transaction(trans);
+	err = btrfs_commit_transaction(trans, NULL);
 	if (err && !ret)
 		ret = err;
 
@@ -770,7 +770,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	pending_snapshot->dir = dir;
 	pending_snapshot->inherit = inherit;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto fail;
@@ -781,7 +781,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		 &trans->transaction->pending_snapshots);
 	spin_unlock(&fs_info->trans_lock);
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	if (ret)
 		goto fail;
 
@@ -1725,13 +1725,13 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	new_size = round_down(new_size, fs_info->sectorsize);
 
 	if (new_size > old_size) {
-		trans = btrfs_start_transaction(root, 0);
+		trans = btrfs_start_transaction(root, 0, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			goto out_finish;
 		}
 		ret = btrfs_grow_device(trans, device, new_size);
-		btrfs_commit_transaction(trans);
+		btrfs_commit_transaction(trans, NULL);
 	} else if (new_size < old_size) {
 		ret = btrfs_shrink_device(device, new_size);
 	} /* equal, nothing need to do */
@@ -1986,7 +1986,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 		}
 	}
 
-	trans = btrfs_start_transaction(root, 1);
+	trans = btrfs_start_transaction(root, 1, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_reset;
@@ -1995,11 +1995,11 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
 	if (ret < 0) {
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		goto out_reset;
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 
 out_reset:
 	if (ret)
@@ -3418,7 +3418,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		goto out_free;
 	}
 
-	trans = btrfs_start_transaction(root, 1);
+	trans = btrfs_start_transaction(root, 1, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_free;
@@ -3429,7 +3429,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 				   dir_id, "default", 7, 1);
 	if (IS_ERR_OR_NULL(di)) {
 		btrfs_release_path(path);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_err(fs_info,
 			  "Umm, you don't have the default diritem, this isn't going to work");
 		ret = -ENOENT;
@@ -3442,7 +3442,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	btrfs_release_path(path);
 
 	btrfs_set_fs_incompat(fs_info, DEFAULT_SUBVOL);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 out_free:
 	btrfs_put_root(new_root);
 	btrfs_free_path(path);
@@ -3610,7 +3610,7 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 	u64 transid;
 	int ret;
 
-	trans = btrfs_attach_transaction_barrier(root);
+	trans = btrfs_attach_transaction_barrier(root, NULL);
 	if (IS_ERR(trans)) {
 		if (PTR_ERR(trans) != -ENOENT)
 			return PTR_ERR(trans);
@@ -3620,9 +3620,9 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 		goto out;
 	}
 	transid = trans->transid;
-	ret = btrfs_commit_transaction_async(trans);
+	ret = btrfs_commit_transaction_async(trans, NULL);
 	if (ret) {
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		return ret;
 	}
 out:
@@ -4218,7 +4218,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 		goto drop_write;
 	}
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -4235,7 +4235,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 	if (err < 0)
 		btrfs_handle_fs_error(fs_info, err,
 				      "failed to update qgroup status and info");
-	err = btrfs_end_transaction(trans);
+	err = btrfs_end_transaction(trans, NULL);
 	if (err && !ret)
 		ret = err;
 
@@ -4273,7 +4273,7 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -4285,7 +4285,7 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		ret = btrfs_remove_qgroup(trans, sa->qgroupid);
 	}
 
-	err = btrfs_end_transaction(trans);
+	err = btrfs_end_transaction(trans, NULL);
 	if (err && !ret)
 		ret = err;
 
@@ -4319,7 +4319,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 		goto drop_write;
 	}
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -4333,7 +4333,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 
 	ret = btrfs_limit_qgroup(trans, qgroupid, &sa->lim);
 
-	err = btrfs_end_transaction(trans);
+	err = btrfs_end_transaction(trans, NULL);
 	if (err && !ret)
 		ret = err;
 
@@ -4442,7 +4442,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	 * 1 - root item
 	 * 2 - uuid items (received uuid + subvol uuid)
 	 */
-	trans = btrfs_start_transaction(root, 3);
+	trans = btrfs_start_transaction(root, 3, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
@@ -4462,7 +4462,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 					  root->root_key.objectid);
 		if (ret && ret != -ENOENT) {
 		        btrfs_abort_transaction(trans, ret);
-		        btrfs_end_transaction(trans);
+		        btrfs_end_transaction(trans, NULL);
 		        goto out;
 		}
 	}
@@ -4477,7 +4477,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
 	if (ret < 0) {
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		goto out;
 	}
 	if (received_uuid_changed && !btrfs_is_empty_uuid(sa->uuid)) {
@@ -4486,11 +4486,11 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 					  root->root_key.objectid);
 		if (ret < 0 && ret != -EEXIST) {
 			btrfs_abort_transaction(trans, ret);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			goto out;
 		}
 	}
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 out:
 	up_write(&fs_info->subvol_sem);
 	mnt_drop_write_file(file);
@@ -4623,7 +4623,7 @@ static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_unlock;
@@ -4632,7 +4632,7 @@ static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 	spin_lock(&fs_info->super_lock);
 	strcpy(super_block->label, label);
 	spin_unlock(&fs_info->super_lock);
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 
 out_unlock:
 	mnt_drop_write_file(file);
@@ -4780,7 +4780,7 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_drop_write;
@@ -4803,7 +4803,7 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	btrfs_set_super_incompat_flags(super_block, newflags);
 	spin_unlock(&fs_info->super_lock);
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 out_drop_write:
 	mnt_drop_write_file(file);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db680f5be745..55398de200fa 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -977,7 +977,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	 * per subvolume. However those are not currently reserved since it
 	 * would be a lot of overkill.
 	 */
-	trans = btrfs_start_transaction(tree_root, 2);
+	trans = btrfs_start_transaction(tree_root, 2, NULL);
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (IS_ERR(trans)) {
@@ -1117,7 +1117,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		goto out_free_path;
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	trans = NULL;
 	if (ret)
 		goto out_free_path;
@@ -1153,9 +1153,9 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	else if (trans)
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_end_transaction(trans, NULL);
 	ulist_free(ulist);
 	return ret;
 }
@@ -1180,7 +1180,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	 * Also, we must always start a transaction without holding the mutex
 	 * qgroup_ioctl_lock, see btrfs_quota_enable().
 	 */
-	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	trans = btrfs_start_transaction(fs_info->tree_root, 1, NULL);
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (IS_ERR(trans)) {
@@ -1226,9 +1226,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	else if (trans)
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_end_transaction(trans, NULL);
 
 	return ret;
 }
@@ -3249,7 +3249,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 
 	err = 0;
 	while (!err && !(stopped = rescan_should_stop(fs_info))) {
-		trans = btrfs_start_transaction(fs_info->fs_root, 0);
+		trans = btrfs_start_transaction(fs_info->fs_root, 0, NULL);
 		if (IS_ERR(trans)) {
 			err = PTR_ERR(trans);
 			break;
@@ -3260,9 +3260,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 			err = qgroup_rescan_leaf(trans, path);
 		}
 		if (err > 0)
-			btrfs_commit_transaction(trans);
+			btrfs_commit_transaction(trans, NULL);
 		else
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 	}
 
 out:
@@ -3281,7 +3281,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	 * only update status, since the previous part has already updated the
 	 * qgroup info.
 	 */
-	trans = btrfs_start_transaction(fs_info->quota_root, 1);
+	trans = btrfs_start_transaction(fs_info->quota_root, 1, NULL);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		trans = NULL;
@@ -3308,7 +3308,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	if (!trans)
 		return;
 
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 
 	if (stopped) {
 		btrfs_info(fs_info, "qgroup scan paused");
@@ -3420,12 +3420,12 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	 * going to clear all tracking information for a clean start.
 	 */
 
-	trans = btrfs_join_transaction(fs_info->fs_root);
+	trans = btrfs_join_transaction(fs_info->fs_root, NULL);
 	if (IS_ERR(trans)) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 		return PTR_ERR(trans);
 	}
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	if (ret) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 		return ret;
@@ -3587,13 +3587,13 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		goto out;
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 out:
 	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
 	wake_up(&root->qgroup_flush_wait);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e0f93b357548..283a30357fc1 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -38,10 +38,10 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		goto out;
 	}
-	ret = btrfs_end_transaction(trans);
+	ret = btrfs_end_transaction(trans, NULL);
 out:
 	return ret;
 }
@@ -255,7 +255,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	 * 1 unit - add new extent
 	 * 1 unit - inode update
 	 */
-	trans = btrfs_start_transaction(root, 3);
+	trans = btrfs_start_transaction(root, 3, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
@@ -287,7 +287,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 		 *
 		 * 1 unit to update inode item
 		 */
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			trans = NULL;
@@ -295,7 +295,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	}
 	if (ret && trans) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	}
 	if (!ret)
 		*trans_out = trans;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 33a0ee7ac590..d0d512add931 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1740,7 +1740,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 					     BTRFS_RESERVE_FLUSH_LIMIT);
 		if (ret)
 			goto out;
-		trans = btrfs_start_transaction(root, 0);
+		trans = btrfs_start_transaction(root, 0, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			trans = NULL;
@@ -1798,7 +1798,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 			       path->slots[level]);
 		btrfs_set_root_drop_level(root_item, level);
 
-		btrfs_end_transaction_throttle(trans);
+		btrfs_end_transaction_throttle(trans, NULL);
 		trans = NULL;
 
 		btrfs_btree_balance_dirty(fs_info);
@@ -1826,7 +1826,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	}
 
 	if (trans)
-		btrfs_end_transaction_throttle(trans);
+		btrfs_end_transaction_throttle(trans, NULL);
 
 	btrfs_btree_balance_dirty(fs_info);
 
@@ -1861,7 +1861,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 			err = ret;
 	}
 
-	trans = btrfs_join_transaction(rc->extent_root);
+	trans = btrfs_join_transaction(rc->extent_root, NULL);
 	if (IS_ERR(trans)) {
 		if (!err)
 			btrfs_block_rsv_release(fs_info, rc->block_rsv,
@@ -1871,7 +1871,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 	if (!err) {
 		if (num_bytes != rc->merging_rsv_size) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			btrfs_block_rsv_release(fs_info, rc->block_rsv,
 						num_bytes, NULL);
 			goto again;
@@ -1926,9 +1926,9 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		err = btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans, NULL);
 	else
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	return err;
 }
 
@@ -3324,7 +3324,7 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 	if (ret)
 		goto out;
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -3332,7 +3332,7 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_truncate_free_space_cache(trans, block_group, inode);
 
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(fs_info);
 out:
 	iput(inode);
@@ -3559,7 +3559,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 	rc->create_reloc_tree = 1;
 	set_reloc_control(rc);
 
-	trans = btrfs_join_transaction(rc->extent_root);
+	trans = btrfs_join_transaction(rc->extent_root, NULL);
 	if (IS_ERR(trans)) {
 		unset_reloc_control(rc);
 		/*
@@ -3569,7 +3569,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3606,7 +3606,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			break;
 		}
 		progress++;
-		trans = btrfs_start_transaction(rc->extent_root, 0);
+		trans = btrfs_start_transaction(rc->extent_root, 0, NULL);
 		if (IS_ERR(trans)) {
 			err = PTR_ERR(trans);
 			trans = NULL;
@@ -3614,7 +3614,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		}
 restart:
 		if (update_backref_cache(trans, &rc->backref_cache)) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			trans = NULL;
 			continue;
 		}
@@ -3657,7 +3657,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			}
 		}
 
-		btrfs_end_transaction_throttle(trans);
+		btrfs_end_transaction_throttle(trans, NULL);
 		btrfs_btree_balance_dirty(fs_info);
 		trans = NULL;
 
@@ -3689,7 +3689,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	clear_extent_bits(&rc->processed_blocks, 0, (u64)-1, EXTENT_DIRTY);
 
 	if (trans) {
-		btrfs_end_transaction_throttle(trans);
+		btrfs_end_transaction_throttle(trans, NULL);
 		btrfs_btree_balance_dirty(fs_info);
 	}
 
@@ -3723,12 +3723,12 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
 
 	/* get rid of pinned extents */
-	trans = btrfs_join_transaction(rc->extent_root);
+	trans = btrfs_join_transaction(rc->extent_root, NULL);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	if (ret && !err)
 		err = ret;
 out_free:
@@ -3814,7 +3814,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	int err = 0;
 
 	root = btrfs_grab_root(fs_info->data_reloc_root);
-	trans = btrfs_start_transaction(root, 6);
+	trans = btrfs_start_transaction(root, 6, NULL);
 	if (IS_ERR(trans)) {
 		btrfs_put_root(root);
 		return ERR_CAST(trans);
@@ -3840,7 +3840,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
 	btrfs_put_root(root);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
 		if (inode)
@@ -4098,7 +4098,7 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 	struct btrfs_trans_handle *trans;
 	int ret, err;
 
-	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	trans = btrfs_start_transaction(fs_info->tree_root, 0, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -4109,7 +4109,7 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
 
-	err = btrfs_end_transaction(trans);
+	err = btrfs_end_transaction(trans, NULL);
 	if (err)
 		return err;
 	return ret;
@@ -4218,7 +4218,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	set_reloc_control(rc);
 
-	trans = btrfs_join_transaction(rc->extent_root);
+	trans = btrfs_join_transaction(rc->extent_root, NULL);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_unset;
@@ -4242,7 +4242,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			goto out_unset;
 		}
 
@@ -4251,14 +4251,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (err) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			goto out_unset;
 		}
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
+	err = btrfs_commit_transaction(trans, NULL);
 	if (err)
 		goto out_unset;
 
@@ -4266,12 +4266,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	unset_reloc_control(rc);
 
-	trans = btrfs_join_transaction(rc->extent_root);
+	trans = btrfs_join_transaction(rc->extent_root, NULL);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	err = btrfs_commit_transaction(trans, NULL);
 out_clean:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 702dc5441f03..4fb67ed54905 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -260,7 +260,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 			btrfs_release_path(path);
 
-			trans = btrfs_join_transaction(tree_root);
+			trans = btrfs_join_transaction(tree_root, NULL);
 			if (IS_ERR(trans)) {
 				err = PTR_ERR(trans);
 				btrfs_handle_fs_error(fs_info, err,
@@ -269,7 +269,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			}
 			err = btrfs_del_orphan_item(trans, tree_root,
 						    root_objectid);
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			if (err) {
 				btrfs_handle_fs_error(fs_info, err,
 					    "Failed to delete root orphan item");
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf82ea6f54fb..47ebdc370341 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3640,10 +3640,10 @@ static int finish_extent_writes_for_zoned(struct btrfs_root *root,
 	btrfs_wait_nocow_writers(cache);
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_join_transaction(root, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 }
 
 static noinline_for_stack
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index afdcbe7844e0..60e8e082fecb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7132,20 +7132,20 @@ static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 			goto commit_trans;
 
 	if (trans)
-		return btrfs_end_transaction(trans);
+		return btrfs_end_transaction(trans, NULL);
 
 	return 0;
 
 commit_trans:
 	/* Use any root, all fs roots will get their commit roots updated. */
 	if (!trans) {
-		trans = btrfs_join_transaction(sctx->send_root);
+		trans = btrfs_join_transaction(sctx->send_root, NULL);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 		goto again;
 	}
 
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 }
 
 /*
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 48d77f360a24..1189830a944a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -630,13 +630,13 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		else
 			nr = -1;
 
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			break;
 		}
 		ret = btrfs_run_delayed_items_nr(trans, nr);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
@@ -648,7 +648,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELAYED_REFS_NR:
 	case FLUSH_DELAYED_REFS:
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			break;
@@ -658,11 +658,11 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		else
 			nr = 0;
 		btrfs_run_delayed_refs(trans, nr);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		break;
 	case ALLOC_CHUNK:
 	case ALLOC_CHUNK_FORCE:
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			break;
@@ -671,7 +671,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 				btrfs_get_alloc_profile(fs_info, space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
@@ -686,12 +686,12 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case COMMIT_TRANS:
 		ASSERT(current->journal_info == NULL);
-		trans = btrfs_join_transaction(root);
+		trans = btrfs_join_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			break;
 		}
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 		break;
 	default:
 		ret = -ENOSPC;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c..2f03ba8690f8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1398,7 +1398,7 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 
-	trans = btrfs_attach_transaction_barrier(root);
+	trans = btrfs_attach_transaction_barrier(root, NULL);
 	if (IS_ERR(trans)) {
 		/* no transaction, don't bother */
 		if (PTR_ERR(trans) == -ENOENT) {
@@ -1418,12 +1418,12 @@ int btrfs_sync_fs(struct super_block *sb, int wait)
 				sb_end_write(sb);
 			else
 				return 0;
-			trans = btrfs_start_transaction(root, 0);
+			trans = btrfs_start_transaction(root, 0, NULL);
 		}
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 	}
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 }
 
 static void print_rescue_option(struct seq_file *seq, const char *s, bool *printed)
@@ -2442,14 +2442,14 @@ static int btrfs_freeze(struct super_block *sb)
 	 * we want to avoid on a frozen filesystem), or do the commit
 	 * ourselves.
 	 */
-	trans = btrfs_attach_transaction_barrier(root);
+	trans = btrfs_attach_transaction_barrier(root, NULL);
 	if (IS_ERR(trans)) {
 		/* no transaction, don't bother */
 		if (PTR_ERR(trans) == -ENOENT)
 			return 0;
 		return PTR_ERR(trans);
 	}
-	return btrfs_commit_transaction(trans);
+	return btrfs_commit_transaction(trans, NULL);
 }
 
 static int btrfs_unfreeze(struct super_block *sb)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1c3a1189c0bd..6b28895c7172 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -276,7 +276,7 @@ void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
  * either allocate a new transaction or hop into the existing one
  */
 static noinline int join_transaction(struct btrfs_fs_info *fs_info,
-				     unsigned int type)
+		unsigned int type, struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_transaction *cur_trans;
 
@@ -567,7 +567,7 @@ static inline bool need_reserve_reloc_root(struct btrfs_root *root)
 static struct btrfs_trans_handle *
 start_transaction(struct btrfs_root *root, unsigned int num_items,
 		  unsigned int type, enum btrfs_reserve_flush_enum flush,
-		  bool enforce_qgroups)
+		  bool enforce_qgroups, struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
@@ -676,7 +676,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		wait_current_trans(fs_info);
 
 	do {
-		ret = join_transaction(fs_info, type);
+		ret = join_transaction(fs_info, type, NULL);
 		if (ret == -EBUSY) {
 			wait_current_trans(fs_info);
 			if (unlikely(type == TRANS_ATTACH ||
@@ -703,7 +703,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
 	    may_wait_transaction(fs_info, type)) {
 		current->journal_info = h;
-		btrfs_commit_transaction(h);
+		btrfs_commit_transaction(h, NULL);
 		goto again;
 	}
 
@@ -747,7 +747,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * other structures so it needs to be ended in case of errors,
 		 * not just freed.
 		 */
-		btrfs_end_transaction(h);
+		btrfs_end_transaction(h, NULL);
 		return ERR_PTR(ret);
 	}
 
@@ -767,40 +767,45 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 }
 
 struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
-						   unsigned int num_items)
+		unsigned int num_items, struct btrfs_tctx *tctx)
 {
 	return start_transaction(root, num_items, TRANS_START,
-				 BTRFS_RESERVE_FLUSH_ALL, true);
+				 BTRFS_RESERVE_FLUSH_ALL, true, tctx);
 }
 
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
-					unsigned int num_items)
+					unsigned int num_items,
+					struct btrfs_tctx *tctx)
 {
+	/* ??? */
 	return start_transaction(root, num_items, TRANS_START,
-				 BTRFS_RESERVE_FLUSH_ALL_STEAL, false);
+				 BTRFS_RESERVE_FLUSH_ALL_STEAL, false, tctx);
 }
 
-struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root)
+struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root,
+		struct btrfs_tctx *tctx)
 {
 	return start_transaction(root, 0, TRANS_JOIN, BTRFS_RESERVE_NO_FLUSH,
-				 true);
+				 true, tctx);
 }
 
-struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root)
+struct btrfs_trans_handle *btrfs_join_transaction_spacecache(
+		struct btrfs_root *root, struct btrfs_tctx *tctx)
 {
 	return start_transaction(root, 0, TRANS_JOIN_NOLOCK,
-				 BTRFS_RESERVE_NO_FLUSH, true);
+				 BTRFS_RESERVE_NO_FLUSH, true, tctx);
 }
 
 /*
  * Similar to regular join but it never starts a transaction when none is
  * running or after waiting for the current one to finish.
  */
-struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root)
+struct btrfs_trans_handle *btrfs_join_transaction_nostart(
+		struct btrfs_root *root, struct btrfs_tctx *tctx)
 {
 	return start_transaction(root, 0, TRANS_JOIN_NOSTART,
-				 BTRFS_RESERVE_NO_FLUSH, true);
+				 BTRFS_RESERVE_NO_FLUSH, true, tctx);
 }
 
 /*
@@ -816,10 +821,11 @@ struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *roo
  * invoke
  *     btrfs_attach_transaction_barrier()
  */
-struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root)
+struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root,
+		struct btrfs_tctx *tctx)
 {
 	return start_transaction(root, 0, TRANS_ATTACH,
-				 BTRFS_RESERVE_NO_FLUSH, true);
+				 BTRFS_RESERVE_NO_FLUSH, true, tctx);
 }
 
 /*
@@ -829,13 +835,13 @@ struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root)
  * will wait for all the inactive transactions until they fully
  * complete.
  */
-struct btrfs_trans_handle *
-btrfs_attach_transaction_barrier(struct btrfs_root *root)
+struct btrfs_trans_handle *btrfs_attach_transaction_barrier(
+		struct btrfs_root *root, struct btrfs_tctx *tctx)
 {
 	struct btrfs_trans_handle *trans;
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
-				  BTRFS_RESERVE_NO_FLUSH, true);
+				  BTRFS_RESERVE_NO_FLUSH, true, tctx);
 	if (trans == ERR_PTR(-ENOENT))
 		btrfs_wait_for_commit(root->fs_info, 0);
 
@@ -955,7 +961,8 @@ static void btrfs_trans_release_metadata(struct btrfs_trans_handle *trans)
 }
 
 static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
-				   int throttle)
+				   int throttle,
+				   struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_transaction *cur_trans = trans->transaction;
@@ -1003,14 +1010,16 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	return err;
 }
 
-int btrfs_end_transaction(struct btrfs_trans_handle *trans)
+int btrfs_end_transaction(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx)
 {
-	return __btrfs_end_transaction(trans, 0);
+	return __btrfs_end_transaction(trans, 0, tctx);
 }
 
-int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans)
+int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx)
 {
-	return __btrfs_end_transaction(trans, 1);
+	return __btrfs_end_transaction(trans, 1, tctx);
 }
 
 /*
@@ -1396,7 +1405,7 @@ int btrfs_defrag_root(struct btrfs_root *root)
 		return 0;
 
 	while (1) {
-		trans = btrfs_start_transaction(root, 0);
+		trans = btrfs_start_transaction(root, 0, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			break;
@@ -1404,7 +1413,7 @@ int btrfs_defrag_root(struct btrfs_root *root)
 
 		ret = btrfs_defrag_leaves(trans, root);
 
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		btrfs_btree_balance_dirty(info);
 		cond_resched();
 
@@ -1884,11 +1893,12 @@ static void do_async_commit(struct work_struct *work)
 
 	current->journal_info = ac->newtrans;
 
-	btrfs_commit_transaction(ac->newtrans);
+	btrfs_commit_transaction(ac->newtrans, NULL);
 	kfree(ac);
 }
 
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
+int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_async_commit *ac;
@@ -1899,7 +1909,7 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 		return -ENOMEM;
 
 	INIT_WORK(&ac->work, do_async_commit);
-	ac->newtrans = btrfs_join_transaction(trans->root);
+	ac->newtrans = btrfs_join_transaction(trans->root, NULL);
 	if (IS_ERR(ac->newtrans)) {
 		int err = PTR_ERR(ac->newtrans);
 		kfree(ac);
@@ -1910,7 +1920,7 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 	cur_trans = trans->transaction;
 	refcount_inc(&cur_trans->use_count);
 
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 
 	/*
 	 * Tell lockdep we've released the freeze rwsem, since the
@@ -2032,7 +2042,8 @@ static inline void btrfs_wait_delalloc_flush(struct btrfs_fs_info *fs_info)
 		btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 }
 
-int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
+int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx __maybe_unused)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_transaction *cur_trans = trans->transaction;
@@ -2044,7 +2055,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	/* Stop the commit early if ->aborted is set */
 	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		return ret;
 	}
 
@@ -2063,7 +2074,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		 */
 		ret = btrfs_run_delayed_refs(trans, 0);
 		if (ret) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			return ret;
 		}
 	}
@@ -2095,7 +2106,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		if (run_it) {
 			ret = btrfs_start_dirty_block_groups(trans);
 			if (ret) {
-				btrfs_end_transaction(trans);
+				btrfs_end_transaction(trans, NULL);
 				return ret;
 			}
 		}
@@ -2110,7 +2121,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 		if (trans->in_fsync)
 			want_state = TRANS_STATE_SUPER_COMMITTED;
-		ret = btrfs_end_transaction(trans);
+		ret = btrfs_end_transaction(trans, NULL);
 		wait_for_commit(cur_trans, want_state);
 
 		if (TRANS_ABORTED(cur_trans))
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index ba45065f9451..9bcb5a1e9ec6 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -148,6 +148,13 @@ struct btrfs_trans_handle {
  */
 #define TRANS_ABORTED(trans)		(unlikely(READ_ONCE((trans)->aborted)))
 
+/*
+ * Store scope NOFS protection data in the caller, used internally by
+ * transaction framework.
+ */
+struct btrfs_tctx {
+};
+
 struct btrfs_pending_snapshot {
 	struct dentry *dentry;
 	struct inode *dir;
@@ -199,26 +206,35 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
 	delayed_refs->qgroup_to_skip = 0;
 }
 
-int btrfs_end_transaction(struct btrfs_trans_handle *trans);
+int btrfs_end_transaction(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx);
 struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
-						   unsigned int num_items);
+		unsigned int num_items, struct btrfs_tctx *tctx __maybe_unused);
 struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
 					struct btrfs_root *root,
-					unsigned int num_items);
-struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root);
-struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root);
-struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root);
-struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root);
+					unsigned int num_items,
+					struct btrfs_tctx *tctx __maybe_unused);
+struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root,
+		struct btrfs_tctx *tctx);
+struct btrfs_trans_handle *btrfs_join_transaction_spacecache(
+		struct btrfs_root *root, struct btrfs_tctx *tctx);
+struct btrfs_trans_handle *btrfs_join_transaction_nostart(
+		struct btrfs_root *root, struct btrfs_tctx *tctx);
+struct btrfs_trans_handle *btrfs_attach_transaction(struct btrfs_root *root,
+		struct btrfs_tctx *tctx);
 struct btrfs_trans_handle *btrfs_attach_transaction_barrier(
-					struct btrfs_root *root);
+		struct btrfs_root *root, struct btrfs_tctx *tctx);
 int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
 
 void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
 int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
-int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
-int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
-int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans);
+int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx __maybe_unused);
+int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx __maybe_unused);
+int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans,
+		struct btrfs_tctx *tctx __maybe_unused);
 bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans);
 void btrfs_throttle(struct btrfs_fs_info *fs_info);
 int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c900eb27cf8..bec6b9c3a7fb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6527,7 +6527,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 	set_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 
-	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	trans = btrfs_start_transaction(fs_info->tree_root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto error;
@@ -6662,7 +6662,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	btrfs_free_path(path);
 
 	/* step 4: commit the transaction, which also unpins the blocks */
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	if (ret)
 		return ret;
 
@@ -6673,7 +6673,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	return 0;
 error:
 	if (wc.trans)
-		btrfs_end_transaction(wc.trans);
+		btrfs_end_transaction(wc.trans, NULL);
 	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 74023c8a783f..4e8085b1adbd 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -232,14 +232,14 @@ static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 	int ret;
 
 	/* 1 - for the uuid item */
-	trans = btrfs_start_transaction(uuid_root, 1);
+	trans = btrfs_start_transaction(uuid_root, 1, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
 	}
 
 	ret = btrfs_uuid_tree_remove(trans, uuid, type, subid);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 
 out:
 	return ret;
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4968535dfff0..93284627cfa9 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -115,7 +115,7 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 
 	while (1) {
 		/* 1 for the item being dropped */
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			goto out;
@@ -137,7 +137,7 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 				break;
 			path->slots[0]--;
 		} else if (ret < 0) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			goto out;
 		}
 
@@ -155,15 +155,15 @@ static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
 		 */
 		ret = btrfs_del_items(trans, root, path, path->slots[0], 1);
 		if (ret) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			goto out;
 		}
 		count++;
 		btrfs_release_path(path);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	}
 	ret = count;
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -227,7 +227,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 
 	while (len > 0) {
 		/* 1 for the new item being inserted */
-		trans = btrfs_start_transaction(root, 1);
+		trans = btrfs_start_transaction(root, 1, NULL);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
 			break;
@@ -245,7 +245,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key, copy_bytes);
 		if (ret) {
-			btrfs_end_transaction(trans);
+			btrfs_end_transaction(trans, NULL);
 			break;
 		}
 
@@ -259,7 +259,7 @@ static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
 		len -= copy_bytes;
 
 		btrfs_release_path(path);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	}
 
 	btrfs_free_path(path);
@@ -470,7 +470,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 	 * 1 for updating the inode flag
 	 * 1 for deleting the orphan
 	 */
-	trans = btrfs_start_transaction(root, 2);
+	trans = btrfs_start_transaction(root, 2, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
@@ -493,7 +493,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 	}
 out:
 	if (trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -541,7 +541,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 	 * 1 for updating the inode flag
 	 * 1 for deleting the orphan
 	 */
-	trans = btrfs_start_transaction(root, 2);
+	trans = btrfs_start_transaction(root, 2, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -557,7 +557,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
 	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
 end_trans:
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 out:
 	return ret;
 
@@ -596,14 +596,14 @@ static int btrfs_begin_enable_verity(struct file *filp)
 		return ret;
 
 	/* 1 for the orphan item */
-	trans = btrfs_start_transaction(root, 1);
+	trans = btrfs_start_transaction(root, 1, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
 	ret = btrfs_orphan_add(trans, inode);
 	if (!ret)
 		set_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 
 	return 0;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9eab8a741166..80027fa2a343 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1914,7 +1914,7 @@ static int btrfs_rm_dev_item(struct btrfs_device *device)
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -1930,20 +1930,20 @@ static int btrfs_rm_dev_item(struct btrfs_device *device)
 		if (ret > 0)
 			ret = -ENOENT;
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		goto out;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	}
 
 out:
 	btrfs_free_path(path);
 	if (!ret)
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 	return ret;
 }
 
@@ -2638,7 +2638,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (ret)
 		goto error_free_device;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto error_free_zone;
@@ -2740,7 +2740,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 
 	if (seeding_dev) {
 		mutex_unlock(&uuid_mutex);
@@ -2754,7 +2754,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		if (ret < 0)
 			btrfs_handle_fs_error(fs_info, ret,
 				    "Failed to relocate sys chunks after device initialization. This can be fixed using the \"btrfs balance\" command.");
-		trans = btrfs_attach_transaction(root);
+		trans = btrfs_attach_transaction(root, NULL);
 		if (IS_ERR(trans)) {
 			if (PTR_ERR(trans) == -ENOENT)
 				return 0;
@@ -2762,7 +2762,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 			trans = NULL;
 			goto error_sysfs;
 		}
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 	}
 
 	/*
@@ -2801,7 +2801,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (seeding_dev)
 		btrfs_set_sb_rdonly(sb);
 	if (trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 error_free_zone:
 	btrfs_destroy_dev_zone_info(device);
 error_free_device:
@@ -3264,7 +3264,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * chunk tree entries
 	 */
 	ret = btrfs_remove_chunk(trans, chunk_offset);
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -3370,12 +3370,12 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
 		struct btrfs_trans_handle *trans;
 		int ret;
 
-		trans =	btrfs_join_transaction(fs_info->tree_root);
+		trans =	btrfs_join_transaction(fs_info->tree_root, NULL);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 
 		ret = btrfs_force_chunk_alloc(trans, BTRFS_BLOCK_GROUP_DATA);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		if (ret < 0)
 			return ret;
 		return 1;
@@ -3400,7 +3400,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -3432,7 +3432,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-	err = btrfs_commit_transaction(trans);
+	err = btrfs_commit_transaction(trans, NULL);
 	if (err && !ret)
 		ret = err;
 	return ret;
@@ -3450,7 +3450,7 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
+	trans = btrfs_start_transaction_fallback_global_rsv(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -3471,7 +3471,7 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	ret = btrfs_del_item(trans, root, path);
 out:
 	btrfs_free_path(path);
-	err = btrfs_commit_transaction(trans);
+	err = btrfs_commit_transaction(trans, NULL);
 	if (err && !ret)
 		ret = err;
 	return ret;
@@ -4654,7 +4654,8 @@ int btrfs_uuid_scan_kthread(void *data)
 			 * 1 - subvol uuid item
 			 * 1 - received_subvol uuid item
 			 */
-			trans = btrfs_start_transaction(fs_info->uuid_root, 2);
+			trans = btrfs_start_transaction(fs_info->uuid_root, 2,
+							NULL);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
 				break;
@@ -4691,7 +4692,7 @@ int btrfs_uuid_scan_kthread(void *data)
 skip:
 		btrfs_release_path(path);
 		if (trans) {
-			ret = btrfs_end_transaction(trans);
+			ret = btrfs_end_transaction(trans, NULL);
 			trans = NULL;
 			if (ret)
 				break;
@@ -4715,7 +4716,7 @@ int btrfs_uuid_scan_kthread(void *data)
 out:
 	btrfs_free_path(path);
 	if (trans && !IS_ERR(trans))
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	if (ret)
 		btrfs_warn(fs_info, "btrfs_uuid_scan_kthread failed %d", ret);
 	else if (!closing)
@@ -4736,7 +4737,7 @@ int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
 	 * 1 - root node
 	 * 1 - root item
 	 */
-	trans = btrfs_start_transaction(tree_root, 2);
+	trans = btrfs_start_transaction(tree_root, 2, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -4744,13 +4745,13 @@ int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(uuid_root)) {
 		ret = PTR_ERR(uuid_root);
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 		return ret;
 	}
 
 	fs_info->uuid_root = uuid_root;
 
-	ret = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans, NULL);
 	if (ret)
 		return ret;
 
@@ -4805,7 +4806,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 
 	path->reada = READA_BACK;
 
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -4826,12 +4827,12 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	 */
 	if (contains_pending_extent(device, &start, diff)) {
 		mutex_unlock(&fs_info->chunk_mutex);
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 		if (ret)
 			goto done;
 	} else {
 		mutex_unlock(&fs_info->chunk_mutex);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	}
 
 again:
@@ -4915,7 +4916,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	}
 
 	/* Shrinking succeeded, else we would be at "done". */
-	trans = btrfs_start_transaction(root, 0);
+	trans = btrfs_start_transaction(root, 0, NULL);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto done;
@@ -4942,9 +4943,9 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	btrfs_trans_release_chunk_metadata(trans);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	} else {
-		ret = btrfs_commit_transaction(trans);
+		ret = btrfs_commit_transaction(trans, NULL);
 	}
 done:
 	btrfs_free_path(path);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 2837b4c8424d..f50f33a3bacc 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -237,7 +237,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 		 * 1 unit for inserting/updating/deleting the xattr
 		 * 1 unit for the inode item update
 		 */
-		trans = btrfs_start_transaction(root, 2);
+		trans = btrfs_start_transaction(root, 2, NULL);
 		if (IS_ERR(trans))
 			return PTR_ERR(trans);
 	} else {
@@ -267,7 +267,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 	BUG_ON(ret);
 out:
 	if (start_trans)
-		btrfs_end_transaction(trans);
+		btrfs_end_transaction(trans, NULL);
 	return ret;
 }
 
@@ -409,7 +409,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	if (ret)
 		return ret;
 
-	trans = btrfs_start_transaction(root, 2);
+	trans = btrfs_start_transaction(root, 2, NULL);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
@@ -421,7 +421,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 		BUG_ON(ret);
 	}
 
-	btrfs_end_transaction(trans);
+	btrfs_end_transaction(trans, NULL);
 
 	return ret;
 }
-- 
2.33.0

