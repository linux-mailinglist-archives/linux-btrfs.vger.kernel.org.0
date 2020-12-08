Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7F2D34A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 22:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgLHUyt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 15:54:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbgLHUyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Dec 2020 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 071B5AD09;
        Tue,  8 Dec 2020 18:42:49 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] btrfs: Make btrfs_direct_write atomic with respect to inode_lock
Date:   Tue,  8 Dec 2020 12:42:41 -0600
Message-Id: <f779c217a8599d71adec3b31e4afbac43df2a74c.1607449636.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607449636.git.rgoldwyn@suse.com>
References: <cover.1607449636.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_direct_write() fallsback to buffered write in case btrfs is not
able to perform or complete a direct I/O. During the fallback
inode lock is unlocked and relocked. This does not guarantee the
atomicity of the entire write since the lock can be acquired by another
write between unlock and relock.

__btrfs_buffered_write() is used to perform the write without locks or
checks and called from btrfs_direct_write().

fa54fc76db94 ("btrfs: push inode locking and unlocking into buffered/direct write")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 55 +++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 272660a8279f..03569fe20237 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1649,11 +1649,11 @@ static ssize_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
 	return count;
 }
 
-static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
+static noinline ssize_t __btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
-	loff_t pos;
+	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page **pages = NULL;
@@ -1667,20 +1667,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
-	unsigned int ilock_flags = 0;
-
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		ilock_flags |= BTRFS_ILOCK_TRY;
-
-	ret = btrfs_inode_lock(inode, ilock_flags);
-	if (ret < 0)
-		return ret;
-
-	ret = btrfs_write_check(iocb, i);
-	if (ret <= 0)
-		goto out;
 
-	pos = iocb->ki_pos;
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
 	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
@@ -1884,10 +1871,33 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		iocb->ki_pos += num_written;
 	}
 out:
-	btrfs_inode_unlock(inode, ilock_flags);
 	return num_written ? num_written : ret;
 }
 
+static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
+					       struct iov_iter *i)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	unsigned int ilock_flags = 0;
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	ret = btrfs_inode_lock(inode, ilock_flags);
+	if (ret < 0)
+		return ret;
+
+	ret = btrfs_write_check(iocb, i);
+	if (ret <= 0)
+		goto out;
+
+	ret = __btrfs_buffered_write(iocb, i);
+out:
+	btrfs_inode_unlock(inode, ilock_flags);
+	return ret;
+}
+
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 			       const struct iov_iter *iter, loff_t offset)
 {
@@ -1928,10 +1938,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		return err;
 
 	err = btrfs_write_check(iocb, from);
-	if (err <= 0) {
-		btrfs_inode_unlock(inode, ilock_flags);
+	if (err <= 0)
 		goto out;
-	}
 
 	pos = iocb->ki_pos;
 	/*
@@ -1945,16 +1953,12 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto relock;
 	}
 
-	if (check_direct_IO(fs_info, from, pos)) {
-		btrfs_inode_unlock(inode, ilock_flags);
+	if (check_direct_IO(fs_info, from, pos))
 		goto buffered;
-	}
 
 	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
 			     &btrfs_dio_ops, is_sync_kiocb(iocb));
 
-	btrfs_inode_unlock(inode, ilock_flags);
-
 	if (IS_ERR_OR_NULL(dio)) {
 		err = PTR_ERR_OR_ZERO(dio);
 		if (err < 0 && err != -ENOTBLK)
@@ -1970,7 +1974,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 buffered:
 	pos = iocb->ki_pos;
-	written_buffered = btrfs_buffered_write(iocb, from);
+	written_buffered = __btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
 		err = written_buffered;
 		goto out;
@@ -1991,6 +1995,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
 				 endbyte >> PAGE_SHIFT);
 out:
+	btrfs_inode_unlock(inode, ilock_flags);
 	return written ? written : err;
 }
 
-- 
2.29.2

