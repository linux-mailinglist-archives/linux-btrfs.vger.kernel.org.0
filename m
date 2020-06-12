Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4E1F73FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFLGmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 02:42:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgFLGmo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 02:42:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D615AD5C;
        Fri, 12 Jun 2020 06:42:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Greed Rong <greedrong@gmail.com>
Subject: [PATCH] btrfs: Share the same anonymous block device for the whole filesystem
Date:   Fri, 12 Jun 2020 14:42:37 +0800
Message-Id: <20200612064237.13439-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report about transaction abort due to -EMFILE error.

  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -24)
  WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
  RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
  Call Trace:
   create_pending_snapshots+0x82/0xa0 [btrfs]
   btrfs_commit_transaction+0x275/0x8c0 [btrfs]
   btrfs_mksubvol+0x4b9/0x500 [btrfs]
   btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
   btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
   btrfs_ioctl+0x11a4/0x2da0 [btrfs]
   do_vfs_ioctl+0xa9/0x640
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x1a/0x20
   do_syscall_64+0x5a/0x110
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ---[ end trace 33f2f83f3d5250e9 ]---
  BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
  BTRFS info (device sda1): forced readonly
  BTRFS warning (device sda1): Skipping commit of aborted transaction.
  BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown

The workload involves creating and deleting a lot of snapshots in a
short period.

[CAUSE]
The error is returned from get_anon_bdev(), which will return -EMFILE
if there is no anonymous block device left in the range.

For anonymous block device, we have at most 1 << 20 devices to allocate,
which looks quite a lot, but if we have a workload which created 1
snapshots per second, we only need 12 days to exhaust the whole pool.

So the anonymous block device pool is not an almost-unlimited resource,
not to mention there are still other users in the kernel relying on
anonyous block device.

When the resouce is exhausted, create_pending_snapshot() will fail due to
error returned from btrfs_get_fs_root(), and abort the transaction.

This problem would also affect other filesystems like ceph or overlayfs.

[FIX]
Currently btrfs uses unique anonymous block device for each root, which
sometimes can be overkilled, especially considering how lightweight
btrfs snapshot is.

This patch will use just one anonymous block device for each btrfs, and
since we only allocate it at mount time, it should not exhause anonymous
block device pool so easily.

Although this brings a big user visible interface change, before this
patch each subvolume has its own bdev for stat(), now all subvolumes
shares the same bdev.
I'm not sure how many users will be affected.

Furthermore, since overlayfs and ceph are already using different
anonymous block device for their snapshots/overlays, I'm not sure if we
should differ from the common behavior.

Reported-by: Greed Rong <greedrong@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
The patch will introduce a user visible behavior change, and a behavior
change from ceph/overlayfs.
I'm not sure whether we should go this direction, or go David's way to
pre-allocate bdev at ioctl time.
---
 fs/btrfs/ctree.h   |  8 +++-----
 fs/btrfs/disk-io.c | 13 ++++++-------
 fs/btrfs/inode.c   |  2 +-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 161533040978..585b951915b0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -928,6 +928,9 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	u32 stripesize;
 
+	/* For the shared devid of the fs */
+	dev_t anon_dev;
+
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
@@ -1097,11 +1100,6 @@ struct btrfs_root {
 	 * protected by inode_lock
 	 */
 	struct radix_tree_root delayed_nodes_tree;
-	/*
-	 * right now this just gets used so that a root has its own devid
-	 * for stat.  It may be used for more later
-	 */
-	dev_t anon_dev;
 
 	spinlock_t root_item_lock;
 	refcount_t refs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f8ec2d8606fd..0bda60943d83 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1148,7 +1148,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	else
 		root->defrag_trans_start = 0;
 	root->root_key.objectid = objectid;
-	root->anon_dev = 0;
 
 	spin_lock_init(&root->root_item_lock);
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
@@ -1430,10 +1429,6 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
 	spin_lock_init(&root->ino_cache_lock);
 	init_waitqueue_head(&root->ino_cache_wait);
 
-	ret = get_anon_bdev(&root->anon_dev);
-	if (ret)
-		goto fail;
-
 	mutex_lock(&root->objectid_mutex);
 	ret = btrfs_find_highest_objectid(root,
 					&root->highest_objectid);
@@ -1509,6 +1504,8 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	if (fs_info->anon_dev)
+		free_anon_bdev(fs_info->anon_dev);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->dio_bytes);
@@ -2000,8 +1997,6 @@ void btrfs_put_root(struct btrfs_root *root)
 	if (refcount_dec_and_test(&root->refs)) {
 		WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
-		if (root->anon_dev)
-			free_anon_bdev(root->anon_dev);
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
 		free_extent_buffer(root->node);
 		free_extent_buffer(root->commit_root);
@@ -2769,6 +2764,10 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
+	ret = get_anon_bdev(&fs_info->anon_dev);
+	if (ret < 0)
+		return ret;
+
 	ret = percpu_counter_init(&fs_info->dio_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1242d0aa108d..f70a2e2b2d9c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8612,7 +8612,7 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(inode, stat);
-	stat->dev = BTRFS_I(inode)->root->anon_dev;
+	stat->dev = BTRFS_I(inode)->root->fs_info->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
-- 
2.27.0

