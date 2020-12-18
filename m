Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145402DE73C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgLRQIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 11:08:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:58454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgLRQIn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 11:08:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81AEEACF1;
        Fri, 18 Dec 2020 16:08:01 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3] btrfs: Make btrfs_direct_write atomic with respect to inode_lock
Date:   Fri, 18 Dec 2020 10:07:57 -0600
Message-Id: <8846c296bcd4d5d3c21c6a98ee467ab5060c6757.1608307404.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.29.2
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

__btrfs_buffered_write() is used to perform the direct fallback write,
which performs the write without acquiring the lock or checks.

Before calling iomap_dio_complete(), clar the IOCB_DSYNC flag.
Re-instate after calling iomap_dio_complete()

fa54fc76db94 ("btrfs: push inode locking and unlocking into buffered/direct write")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Changes since v2:
 - Manipulate iocb->ki_flags before and after calling
 iomap_dio_complete()

Changes since v1:
 - Fix the issue of hang with the direct I/O and sync.
 - lockdep_assert_held() in __btrfs_buffered_write()

---
 fs/btrfs/file.c | 77 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e65223e3510d..b7fe2f3d179a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1638,11 +1638,11 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	return 0;
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
@@ -1656,24 +1656,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
-	unsigned int ilock_flags = 0;
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		ilock_flags |= BTRFS_ILOCK_TRY;
+	lockdep_assert_held(&inode->i_rwsem);
 
-	ret = btrfs_inode_lock(inode, ilock_flags);
-	if (ret < 0)
-		return ret;
-
-	ret = generic_write_checks(iocb, i);
-	if (ret <= 0)
-		goto out;
-
-	ret = btrfs_write_check(iocb, i, ret);
-	if (ret < 0)
-		goto out;
-
-	pos = iocb->ki_pos;
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
 	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
@@ -1877,10 +1862,37 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
+	ret = generic_write_checks(iocb, i);
+	if (ret <= 0)
+		goto out;
+
+	ret = btrfs_write_check(iocb, i, ret);
+	if (ret < 0)
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
@@ -1907,6 +1919,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio = NULL;
+	bool dsync;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1927,10 +1940,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	err = btrfs_write_check(iocb, from, err);
-	if (err < 0) {
-		btrfs_inode_unlock(inode, ilock_flags);
+	if (err < 0)
 		goto out;
-	}
 
 	pos = iocb->ki_pos;
 	/*
@@ -1944,22 +1955,30 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
 
 	if (IS_ERR_OR_NULL(dio)) {
 		err = PTR_ERR_OR_ZERO(dio);
 		if (err < 0 && err != -ENOTBLK)
 			goto out;
 	} else {
+		/*
+		 * Remove the DSYNC flag because iomap_dio_complete() calls
+		 * generic_write_sync() which may deadlock with btrfs_sync()
+		 * on inode->i_rwsem
+		 */
+		if (iocb->ki_flags & IOCB_DSYNC) {
+			dsync = true;
+			iocb->ki_flags &= ~IOCB_DSYNC;
+		}
 		written = iomap_dio_complete(dio);
+		if (dsync)
+			iocb->ki_flags |= IOCB_DSYNC;
 	}
 
 	if (written < 0 || !iov_iter_count(from)) {
@@ -1969,7 +1988,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 buffered:
 	pos = iocb->ki_pos;
-	written_buffered = btrfs_buffered_write(iocb, from);
+	written_buffered = __btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
 		err = written_buffered;
 		goto out;
@@ -1990,6 +2009,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
 				 endbyte >> PAGE_SHIFT);
 out:
+	btrfs_inode_unlock(inode, ilock_flags);
+	if (written > 0 && dsync)
+		generic_write_sync(iocb, written);
+
 	return written ? written : err;
 }
 
-- 
2.29.2

