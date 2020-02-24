Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4A16AA05
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXP0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:26:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:48996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbgBXP0n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:26:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CBA1EADE8;
        Mon, 24 Feb 2020 15:26:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 1/2] btrfs: convert snapshot/nocow exlcusion to drw lock
Date:   Mon, 24 Feb 2020 17:26:36 +0200
Message-Id: <20200224152637.30774-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224152637.30774-1-nborisov@suse.com>
References: <20200224152637.30774-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch removes all haphazard code implementing nocow writers
exclusion from pending snapshot creation and switches to using the drw
lock to ensure this invariant still holds. "Readers" are snapshot
creators from create_snapshot and 'writers' are nocow writers from
buffered write path or btrfs_setsize. This locking scheme allows for
multiple snapshots to happen while any nocow writers are blocked, since
writes to page cache in the nocow path will make snapshots inconsistent.

So for performance reasons we'd like to have the ability to run multiple
concurrent snapshots and also favors readers in this case. And in case
there aren't pending snapshots (which will be the majority of the cases)
we rely on the percpu's writers counter to avoid cacheline contention.

The main gain from using the drw is it's now a lot easier to reason about
the guarantees of the locking scheme and whether there is some silent
breakage lurking.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       |  9 ++-------
 fs/btrfs/disk-io.c     | 46 ++++++++++--------------------------------
 fs/btrfs/extent-tree.c | 44 ----------------------------------------
 fs/btrfs/file.c        | 11 +++++-----
 fs/btrfs/inode.c       |  8 ++++----
 fs/btrfs/ioctl.c       | 10 +++------
 6 files changed, 25 insertions(+), 103 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index efc2cd147141..91cc25590040 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -957,11 +957,6 @@ static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
-struct btrfs_subvolume_writers {
-	struct percpu_counter	counter;
-	wait_queue_head_t	wait;
-};
-
 /*
  * The state of btrfs root
  */
@@ -1133,8 +1128,8 @@ struct btrfs_root {
 	 * root_item_lock.
 	 */
 	int dedupe_in_progress;
-	struct btrfs_subvolume_writers *subv_writers;
-	atomic_t will_be_snapshotted;
+	struct btrfs_drw_lock snapshot_lock;
+
 	atomic_t snapshot_force_cow;
 
 	/* For qgroup metadata reserved space */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 770d469e1d9c..e2576aa70960 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1104,32 +1104,6 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
 	}
 }
 
-static struct btrfs_subvolume_writers *btrfs_alloc_subvolume_writers(void)
-{
-	struct btrfs_subvolume_writers *writers;
-	int ret;
-
-	writers = kmalloc(sizeof(*writers), GFP_NOFS);
-	if (!writers)
-		return ERR_PTR(-ENOMEM);
-
-	ret = percpu_counter_init(&writers->counter, 0, GFP_NOFS);
-	if (ret < 0) {
-		kfree(writers);
-		return ERR_PTR(ret);
-	}
-
-	init_waitqueue_head(&writers->wait);
-	return writers;
-}
-
-static void
-btrfs_free_subvolume_writers(struct btrfs_subvolume_writers *writers)
-{
-	percpu_counter_destroy(&writers->counter);
-	kfree(writers);
-}
-
 static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
@@ -1178,7 +1152,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	atomic_set(&root->log_writers, 0);
 	atomic_set(&root->log_batch, 0);
 	refcount_set(&root->refs, 1);
-	atomic_set(&root->will_be_snapshotted, 0);
 	atomic_set(&root->snapshot_force_cow, 0);
 	atomic_set(&root->nr_swapfiles, 0);
 	root->log_transid = 0;
@@ -1450,7 +1423,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 static int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
-	struct btrfs_subvolume_writers *writers;
+	unsigned int nofs_flag;
 
 	root->free_ino_ctl = kzalloc(sizeof(*root->free_ino_ctl), GFP_NOFS);
 	root->free_ino_pinned = kzalloc(sizeof(*root->free_ino_pinned),
@@ -1460,12 +1433,16 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
 		goto fail;
 	}
 
-	writers = btrfs_alloc_subvolume_writers();
-	if (IS_ERR(writers)) {
-		ret = PTR_ERR(writers);
+	/*
+	 * We might be called under a transaction (e.g. indirect
+	 * backref resolution) which could deadlock if it triggers memory
+	 * reclaim
+	 */
+	nofs_flag = memalloc_nofs_save();
+	ret = btrfs_drw_lock_init(&root->snapshot_lock);
+	memalloc_nofs_restore(nofs_flag);
+	if (ret)
 		goto fail;
-	}
-	root->subv_writers = writers;
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
@@ -3961,8 +3938,7 @@ void btrfs_free_fs_root(struct btrfs_root *root)
 	WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
 	if (root->anon_dev)
 		free_anon_bdev(root->anon_dev);
-	if (root->subv_writers)
-		btrfs_free_subvolume_writers(root->subv_writers);
+	btrfs_drw_lock_destroy(&root->snapshot_lock);
 	free_extent_buffer(root->node);
 	free_extent_buffer(root->commit_root);
 	kfree(root->free_ino_ctl);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7eef91d6c2b6..9dcd70cc3ca3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5740,47 +5740,3 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		return bg_ret;
 	return dev_ret;
 }
-
-/*
- * btrfs_{start,end}_write_no_snapshotting() are similar to
- * mnt_{want,drop}_write(), they are used to prevent some tasks from writing
- * data into the page cache through nocow before the subvolume is snapshoted,
- * but flush the data into disk after the snapshot creation, or to prevent
- * operations while snapshotting is ongoing and that cause the snapshot to be
- * inconsistent (writes followed by expanding truncates for example).
- */
-void btrfs_end_write_no_snapshotting(struct btrfs_root *root)
-{
-	percpu_counter_dec(&root->subv_writers->counter);
-	cond_wake_up(&root->subv_writers->wait);
-}
-
-int btrfs_start_write_no_snapshotting(struct btrfs_root *root)
-{
-	if (atomic_read(&root->will_be_snapshotted))
-		return 0;
-
-	percpu_counter_inc(&root->subv_writers->counter);
-	/*
-	 * Make sure counter is updated before we check for snapshot creation.
-	 */
-	smp_mb();
-	if (atomic_read(&root->will_be_snapshotted)) {
-		btrfs_end_write_no_snapshotting(root);
-		return 0;
-	}
-	return 1;
-}
-
-void btrfs_wait_for_snapshot_creation(struct btrfs_root *root)
-{
-	while (true) {
-		int ret;
-
-		ret = btrfs_start_write_no_snapshotting(root);
-		if (ret)
-			break;
-		wait_var_event(&root->will_be_snapshotted,
-			       !atomic_read(&root->will_be_snapshotted));
-	}
-}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fd52ad00b6c8..1031a0b5002e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1553,8 +1553,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	u64 num_bytes;
 	int ret;
 
-	ret = btrfs_start_write_no_snapshotting(root);
-	if (!ret)
+	if (!btrfs_drw_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
@@ -1569,7 +1568,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			NULL, NULL, NULL);
 	if (ret <= 0) {
 		ret = 0;
-		btrfs_end_write_no_snapshotting(root);
+		btrfs_drw_write_unlock(&root->snapshot_lock);
 	} else {
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
@@ -1675,7 +1674,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						data_reserved, pos,
 						write_bytes);
 			else
-				btrfs_end_write_no_snapshotting(root);
+				btrfs_drw_write_unlock(&root->snapshot_lock);
 			break;
 		}
 
@@ -1779,7 +1778,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		release_bytes = 0;
 		if (only_release_metadata)
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 
 		if (only_release_metadata && copied > 0) {
 			lockstart = round_down(pos,
@@ -1808,7 +1807,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 	if (release_bytes) {
 		if (only_release_metadata) {
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					release_bytes, true);
 		} else {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 85d6b31ab51c..9a12bdf4969b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4726,16 +4726,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		 * truncation, it must capture all writes that happened before
 		 * this truncation.
 		 */
-		btrfs_wait_for_snapshot_creation(root);
+		btrfs_drw_write_lock(&root->snapshot_lock);
 		ret = btrfs_cont_expand(inode, oldsize, newsize);
 		if (ret) {
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 			return ret;
 		}
 
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 			return PTR_ERR(trans);
 		}
 
@@ -4743,7 +4743,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
-		btrfs_end_write_no_snapshotting(root);
+		btrfs_drw_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e97fd0f91406..f4b1ed038378 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -790,11 +790,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	 * possible. This is to avoid later writeback (running dealloc) to
 	 * fallback to COW mode and unexpectedly fail with ENOSPC.
 	 */
-	atomic_inc(&root->will_be_snapshotted);
-	smp_mb__after_atomic();
-	/* wait for no snapshot writes */
-	wait_event(root->subv_writers->wait,
-		   percpu_counter_sum(&root->subv_writers->counter) == 0);
+	btrfs_drw_read_lock(&root->snapshot_lock);
 
 	ret = btrfs_start_delalloc_snapshot(root);
 	if (ret)
@@ -875,8 +871,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 dec_and_free:
 	if (snapshot_force_cow)
 		atomic_dec(&root->snapshot_force_cow);
-	if (atomic_dec_and_test(&root->will_be_snapshotted))
-		wake_up_var(&root->will_be_snapshotted);
+	btrfs_drw_read_unlock(&root->snapshot_lock);
+
 free_pending:
 	kfree(pending_snapshot->root_item);
 	btrfs_free_path(pending_snapshot->path);
-- 
2.17.1

