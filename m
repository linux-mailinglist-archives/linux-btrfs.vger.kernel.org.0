Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F210113A35B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 09:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANI7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 03:59:45 -0500
Received: from snd00005.auone-net.jp ([111.86.247.5]:60129 "EHLO
        dmta0006-f.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgANI7o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 03:59:44 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 03:59:43 EST
Received: from ppp.dion.ne.jp by dmta0008.auone-net.jp with ESMTP
          id <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>;
          Tue, 14 Jan 2020 17:53:25 +0900
Date:   Tue, 14 Jan 2020 17:53:24 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Implement lazytime
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I tested with xfstests and lazytime didn't cause any new failures.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 fs/btrfs/delayed-inode.c |  6 ++++++
 fs/btrfs/file.c          | 11 +++++++++++
 fs/btrfs/inode.c         | 28 +++++++++++++++++++++++++---
 fs/btrfs/ioctl.c         | 14 ++++++++++++++
 fs/btrfs/super.c         |  1 +
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index d3e15e1d4a91..b30b00678503 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1722,6 +1722,12 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode_item *inode_item,
 				  struct inode *inode)
 {
+	if (inode->i_sb->s_flags & SB_LAZYTIME) {
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~(I_DIRTY_SYNC | I_DIRTY_TIME);
+		spin_unlock(&inode->i_lock);
+	}
+
 	btrfs_set_stack_inode_uid(inode_item, i_uid_read(inode));
 	btrfs_set_stack_inode_gid(inode_item, i_gid_read(inode));
 	btrfs_set_stack_inode_size(inode_item, BTRFS_I(inode)->disk_i_size);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8d47c76b7bd1..36aa75f4e532 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2069,6 +2069,17 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	trace_btrfs_sync_file(file, datasync);
 
+	if (!datasync && inode->i_sb->s_flags & SB_LAZYTIME) {
+		while (1) {
+			ret = sync_inode_metadata(inode, 0);
+			if (ret != -EAGAIN)
+				break;
+			flush_work(&fs_info->async_reclaim_work);
+		}
+		if (ret)
+			return ret;
+	}
+
 	btrfs_init_log_ctx(&ctx, inode);
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5509c41a4f43..a60aee76cc95 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3941,6 +3941,12 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 
 	btrfs_init_map_token(&token, leaf);
 
+	if (inode->i_sb->s_flags & SB_LAZYTIME) {
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~(I_DIRTY_SYNC | I_DIRTY_TIME);
+		spin_unlock(&inode->i_lock);
+	}
+
 	btrfs_set_token_inode_uid(leaf, item, i_uid_read(inode), &token);
 	btrfs_set_token_inode_gid(leaf, item, i_gid_read(inode), &token);
 	btrfs_set_token_inode_size(leaf, item, BTRFS_I(inode)->disk_i_size,
@@ -6188,6 +6194,16 @@ static int btrfs_dirty_inode(struct inode *inode)
 	return ret;
 }
 
+int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	if (work_busy(&btrfs_sb(inode->i_sb)->async_reclaim_work) & WORK_BUSY_RUNNING) {
+		mark_inode_dirty_sync(inode);
+		return -EAGAIN;
+	}
+
+	return btrfs_dirty_inode(inode);
+}
+
 /*
  * This is a copy of file_update_time.  We need this so we can return error on
  * ENOSPC for updating the inode in the case of file write and mmap writes.
@@ -6201,15 +6217,21 @@ static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	if (flags & S_VERSION)
-		dirty |= inode_maybe_inc_iversion(inode, dirty);
+	if (!(flags & S_VERSION && inode_maybe_inc_iversion(inode, dirty))) {
+		if (unlikely(!dirty))
+			return 0;
+		if (inode->i_sb->s_flags & SB_LAZYTIME &&
+		    !test_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags))
+			return generic_update_time(inode, now, flags);
+	}
+
 	if (flags & S_CTIME)
 		inode->i_ctime = *now;
 	if (flags & S_MTIME)
 		inode->i_mtime = *now;
 	if (flags & S_ATIME)
 		inode->i_atime = *now;
-	return dirty ? btrfs_dirty_inode(inode) : 0;
+	return btrfs_dirty_inode(inode);
 }
 
 /*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 18e328ce4b54..af47b4b046de 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -799,6 +799,14 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (ret)
 		goto dec_and_free;
 
+	/* For xfstests generic/003. Is it better to fix the test? */
+	if (dir->i_sb->s_flags & SB_LAZYTIME) {
+		down_read(&dir->i_sb->s_umount);
+		if (!sb_rdonly(dir->i_sb))
+			sync_inodes_sb(dir->i_sb);
+		up_read(&dir->i_sb->s_umount);
+	}
+
 	/*
 	 * All previous writes have started writeback in NOCOW mode, so now
 	 * we force future writes to fallback to COW mode during snapshot
@@ -5497,6 +5505,12 @@ long btrfs_ioctl(struct file *file, unsigned int
 		ret = btrfs_start_delalloc_roots(fs_info, -1);
 		if (ret)
 			return ret;
+		if (inode->i_sb->s_flags & SB_LAZYTIME) {
+			down_read(&inode->i_sb->s_umount);
+			if (!sb_rdonly(inode->i_sb))
+				sync_inodes_sb(inode->i_sb);
+			up_read(&inode->i_sb->s_umount);
+		}
 		ret = btrfs_sync_fs(inode->i_sb, 1);
 		/*
 		 * The transaction thread may want to do more work,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..ccfe9aff1394 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2281,6 +2281,7 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations btrfs_super_ops = {
+	.write_inode	= btrfs_write_inode,
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
 	.put_super	= btrfs_put_super,
-- 
2.25.0.rc2

