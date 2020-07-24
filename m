Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0551722BE31
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXGqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 02:46:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:50244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGXGqS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 02:46:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22052AC20
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 06:46:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations
Date:   Fri, 24 Jul 2020 14:46:10 +0800
Message-Id: <20200724064610.69442-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724064610.69442-1-wqu@suse.com>
References: <20200724064610.69442-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When quota is enabled for TEST_DEV, generic/013 sometimes fails like this:

  generic/013 14s ... _check_dmesg: something found in dmesg (see xfstests-dev/results//generic/013.dmesg)

And with the following metadata leak:

  BTRFS warning (device dm-3): qgroup 0/1370 has unreleased space, type 2 rsv 49152
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 47912 at fs/btrfs/disk-io.c:4078 close_ctree+0x1dc/0x323 [btrfs]
  Call Trace:
   btrfs_put_super+0x15/0x17 [btrfs]
   generic_shutdown_super+0x72/0x110
   kill_anon_super+0x18/0x30
   btrfs_kill_super+0x17/0x30 [btrfs]
   deactivate_locked_super+0x3b/0xa0
   deactivate_super+0x40/0x50
   cleanup_mnt+0x135/0x190
   __cleanup_mnt+0x12/0x20
   task_work_run+0x64/0xb0
   __prepare_exit_to_usermode+0x1bc/0x1c0
   __syscall_return_slowpath+0x47/0x230
   do_syscall_64+0x64/0xb0
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ---[ end trace a6cfd45ba80e4e06 ]---
  BTRFS error (device dm-3): qgroup reserved space leaked
  BTRFS info (device dm-3): disk space caching is enabled
  BTRFS info (device dm-3): has skinny extents

[CAUSE]
The qgroup preallocated meta rsv operations of that offending root are:

  btrfs_delayed_inode_reserve_metadata: rsv_meta_prealloc root=1370 num_bytes=131072
  btrfs_delayed_inode_reserve_metadata: rsv_meta_prealloc root=1370 num_bytes=131072
  btrfs_subvolume_reserve_metadata: rsv_meta_prealloc root=1370 num_bytes=49152
  btrfs_delayed_inode_release_metadata: convert_meta_prealloc root=1370 num_bytes=-131072
  btrfs_delayed_inode_release_metadata: convert_meta_prealloc root=1370 num_bytes=-131072

It's pretty obvious that, we reserve qgroup meta rsv in
btrfs_subvolume_reserve_metadata(), but doesn't have corresponding
release/convert calls in btrfs_subvolume_release_metadata().

This leads to the leakage.

[FIX]
To fix this bug, we should follow what we're doing in
btrfs_delalloc_reserve_metadata(), where we reserve qgroup space, and
add it to block_rsv->qgroup_rsv_reserved.

And free the qgroup reserved metadata space when releasing the
block_rsv.

To do this, we need to change the btrfs_subvolume_release_metadata() to
accept btrfs_root, and record the qgroup_to_release number, and call
btrfs_qgroup_convert_reserved_meta() for it.

Fixes: 733e03a0b26a ("btrfs: qgroup: Split meta rsv type into meta_prealloc and meta_pertrans")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/ioctl.c     |  6 +++---
 fs/btrfs/root-tree.c | 13 +++++++++++--
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c7e466f27a9..e1db56ff8f6f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2619,7 +2619,7 @@ enum btrfs_flush_state {
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
-void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
+void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 611b3412fbfd..e9def7cdf662 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4047,7 +4047,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		err = ret;
 	inode->i_flags |= S_DEAD;
 out_release:
-	btrfs_subvolume_release_metadata(fs_info, &block_rsv);
+	btrfs_subvolume_release_metadata(root, &block_rsv);
 out_up_write:
 	up_write(&fs_info->subvol_sem);
 	if (err) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bd3511c5ca81..976aeddca86c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -618,7 +618,7 @@ static noinline int create_subvol(struct inode *dir,
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		btrfs_subvolume_release_metadata(fs_info, &block_rsv);
+		btrfs_subvolume_release_metadata(root, &block_rsv);
 		goto fail_free;
 	}
 	trans->block_rsv = &block_rsv;
@@ -742,7 +742,7 @@ static noinline int create_subvol(struct inode *dir,
 	kfree(root_item);
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
-	btrfs_subvolume_release_metadata(fs_info, &block_rsv);
+	btrfs_subvolume_release_metadata(root, &block_rsv);
 
 	err = btrfs_commit_transaction(trans);
 	if (err && !ret)
@@ -856,7 +856,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (ret && pending_snapshot->snap)
 		pending_snapshot->snap->anon_dev = 0;
 	btrfs_put_root(pending_snapshot->snap);
-	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
+	btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
 free_pending:
 	if (pending_snapshot->anon_dev)
 		free_anon_bdev(pending_snapshot->anon_dev);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index c89697486366..702dc5441f03 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -512,11 +512,20 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	if (ret && qgroup_num_bytes)
 		btrfs_qgroup_free_meta_prealloc(root, qgroup_num_bytes);
 
+	if (!ret) {
+		spin_lock(&rsv->lock);
+		rsv->qgroup_rsv_reserved += qgroup_num_bytes;
+		spin_unlock(&rsv->lock);
+	}
 	return ret;
 }
 
-void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
+void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv)
 {
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, NULL);
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	u64 qgroup_to_release;
+
+	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
 }
-- 
2.27.0

