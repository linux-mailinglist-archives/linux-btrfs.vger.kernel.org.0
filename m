Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9226E2A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfGSIj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 04:39:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:35728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726965AbfGSIj6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 04:39:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D31FADE0;
        Fri, 19 Jul 2019 08:39:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs: convert snapshot/nocow exlcusion to drw lock
Date:   Fri, 19 Jul 2019 11:39:49 +0300
Message-Id: <20190719083949.5351-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719083949.5351-1-nborisov@suse.com>
References: <20190719083949.5351-1-nborisov@suse.com>
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
 fs/btrfs/extent-tree.c | 35 --------------------------------
 fs/btrfs/file.c        | 11 +++++-----
 fs/btrfs/inode.c       |  8 ++++----
 fs/btrfs/ioctl.c       | 10 +++------
 6 files changed, 25 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7c9359b24a0..c04a23384210 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1087,11 +1087,6 @@ static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
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
@@ -1263,8 +1258,8 @@ struct btrfs_root {
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
index baebbb74032d..5a967d6264c9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1122,32 +1122,6 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
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
@@ -1195,7 +1169,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	atomic_set(&root->log_writers, 0);
 	atomic_set(&root->log_batch, 0);
 	refcount_set(&root->refs, 1);
-	atomic_set(&root->will_be_snapshotted, 0);
 	atomic_set(&root->snapshot_force_cow, 0);
 	atomic_set(&root->nr_swapfiles, 0);
 	root->log_transid = 0;
@@ -1484,7 +1457,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
-	struct btrfs_subvolume_writers *writers;
+	unsigned int nofs_flag;
 
 	root->free_ino_ctl = kzalloc(sizeof(*root->free_ino_ctl), GFP_NOFS);
 	root->free_ino_pinned = kzalloc(sizeof(*root->free_ino_pinned),
@@ -1494,12 +1467,16 @@ int btrfs_init_fs_root(struct btrfs_root *root)
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
 
 	btrfs_init_free_ino_ctl(root);
 	spin_lock_init(&root->ino_cache_lock);
@@ -3920,8 +3897,7 @@ void btrfs_free_fs_root(struct btrfs_root *root)
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
index d3b58e388535..e4f36c874f1b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9061,41 +9061,6 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
  * operations while snapshotting is ongoing and that cause the snapshot to be
  * inconsistent (writes followed by expanding truncates for example).
  */
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
 
 void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
 {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 52fb235e6d19..c043dc9a6e43 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1555,8 +1555,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	u64 num_bytes;
 	int ret;
 
-	ret = btrfs_start_write_no_snapshotting(root);
-	if (!ret)
+	if (!btrfs_drw_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
@@ -1571,7 +1570,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			NULL, NULL, NULL);
 	if (ret <= 0) {
 		ret = 0;
-		btrfs_end_write_no_snapshotting(root);
+		btrfs_drw_write_unlock(&root->snapshot_lock);
 	} else {
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
@@ -1676,7 +1675,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						data_reserved, pos,
 						write_bytes);
 			else
-				btrfs_end_write_no_snapshotting(root);
+				btrfs_drw_write_unlock(&root->snapshot_lock);
 			break;
 		}
 
@@ -1770,7 +1769,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		release_bytes = 0;
 		if (only_release_metadata)
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 
 		if (only_release_metadata && copied > 0) {
 			lockstart = round_down(pos,
@@ -1800,7 +1799,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 	if (release_bytes) {
 		if (only_release_metadata) {
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					release_bytes, true);
 		} else {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 11068a54e696..6359aa3bfcab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5138,16 +5138,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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
 
@@ -5155,7 +5155,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_ordered_update_i_size(inode, i_size_read(inode), NULL);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
-		btrfs_end_write_no_snapshotting(root);
+		btrfs_drw_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a8c21da77b87..2182af8d62e2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -791,11 +791,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
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

