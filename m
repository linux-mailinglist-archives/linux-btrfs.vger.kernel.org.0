Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5432314DB1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 13:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgA3M7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 07:59:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgA3M7t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 07:59:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27A55B028;
        Thu, 30 Jan 2020 12:59:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: convert snapshot/nocow exlcusion to drw lock
Date:   Thu, 30 Jan 2020 14:59:42 +0200
Message-Id: <20200130125945.7383-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130125945.7383-1-nborisov@suse.com>
References: <20200130125945.7383-1-nborisov@suse.com>
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
 fs/btrfs/ctree.h       | 10 +++-------
 fs/btrfs/disk-io.c     | 39 +++------------------------------------
 fs/btrfs/extent-tree.c | 35 -----------------------------------
 fs/btrfs/file.c        | 12 ++++++------
 fs/btrfs/inode.c       |  8 ++++----
 fs/btrfs/ioctl.c       | 10 +++-------
 6 files changed, 19 insertions(+), 95 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a66ed58058d9..fa8a2e15c77c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -32,6 +32,7 @@
 #include "extent_io.h"
 #include "extent_map.h"
 #include "async-thread.h"
+#include "drw_lock.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -1174,11 +1175,6 @@ static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
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
@@ -1350,8 +1346,8 @@ struct btrfs_root {
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
index 05f215b4d060..ece45e606846 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1125,32 +1125,6 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
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
@@ -1198,7 +1172,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	atomic_set(&root->log_writers, 0);
 	atomic_set(&root->log_batch, 0);
 	refcount_set(&root->refs, 1);
-	atomic_set(&root->will_be_snapshotted, 0);
 	atomic_set(&root->snapshot_force_cow, 0);
 	atomic_set(&root->nr_swapfiles, 0);
 	root->log_transid = 0;
@@ -1487,7 +1460,6 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
-	struct btrfs_subvolume_writers *writers;
 
 	root->free_ino_ctl = kzalloc(sizeof(*root->free_ino_ctl), GFP_NOFS);
 	root->free_ino_pinned = kzalloc(sizeof(*root->free_ino_pinned),
@@ -1497,12 +1469,8 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 		goto fail;
 	}
 
-	writers = btrfs_alloc_subvolume_writers();
-	if (IS_ERR(writers)) {
-		ret = PTR_ERR(writers);
-		goto fail;
-	}
-	root->subv_writers = writers;
+
+	btrfs_drw_lock_init(&root->snapshot_lock);
 
 	btrfs_init_free_ino_ctl(root);
 	spin_lock_init(&root->ino_cache_lock);
@@ -3873,8 +3841,7 @@ void btrfs_free_fs_root(struct btrfs_root *root)
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
index 5a11e4988243..3564bae0434d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11322,41 +11322,6 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
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
index 5370152ea7e3..b9f01efff276 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -26,6 +26,7 @@
 #include "volumes.h"
 #include "qgroup.h"
 #include "compression.h"
+#include "drw_lock.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
@@ -1554,8 +1555,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	u64 num_bytes;
 	int ret;
 
-	ret = btrfs_start_write_no_snapshotting(root);
-	if (!ret)
+	if (!btrfs_drw_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
@@ -1570,7 +1570,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			NULL, NULL, NULL);
 	if (ret <= 0) {
 		ret = 0;
-		btrfs_end_write_no_snapshotting(root);
+		btrfs_drw_write_unlock(&root->snapshot_lock);
 	} else {
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
@@ -1675,7 +1675,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 						data_reserved, pos,
 						write_bytes);
 			else
-				btrfs_end_write_no_snapshotting(root);
+				btrfs_drw_write_unlock(&root->snapshot_lock);
 			break;
 		}
 
@@ -1769,7 +1769,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		release_bytes = 0;
 		if (only_release_metadata)
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 
 		if (only_release_metadata && copied > 0) {
 			lockstart = round_down(pos,
@@ -1799,7 +1799,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 	if (release_bytes) {
 		if (only_release_metadata) {
-			btrfs_end_write_no_snapshotting(root);
+			btrfs_drw_write_unlock(&root->snapshot_lock);
 			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 					release_bytes, true);
 		} else {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f5e19ba27bdc..00118805ef00 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5102,16 +5102,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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
 
@@ -5119,7 +5119,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_ordered_update_i_size(inode, i_size_read(inode), NULL);
 		pagecache_isize_extended(inode, oldsize, newsize);
 		ret = btrfs_update_inode(trans, root, inode);
-		btrfs_end_write_no_snapshotting(root);
+		btrfs_drw_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 803577d42518..e35f1b14d772 100644
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

