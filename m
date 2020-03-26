Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55721949B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 22:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZVDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 17:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVDk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B759AFDF;
        Thu, 26 Mar 2020 21:03:38 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 8/9] btrfs: btrfs: split btrfs_direct_IO
Date:   Thu, 26 Mar 2020 16:02:53 -0500
Message-Id: <20200326210254.17647-9-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200326210254.17647-1-rgoldwyn@suse.de>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The read and write versions don't have anything in common except
for the call to iomap_dio_rw.  So split this function, and merge
each half into its only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |   3 ++
 fs/btrfs/file.c  | 103 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/inode.c |  99 +--------------------------------------------
 3 files changed, 99 insertions(+), 106 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0cf65cf1d84f..9f6f2df27b4c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -28,6 +28,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
+#include <linux/iomap.h>
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -2950,6 +2951,8 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
 ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
+extern const struct iomap_ops btrfs_dio_iomap_ops;
+extern const struct iomap_dio_ops btrfs_dops;
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e76be6472652..491951ebfb5d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1821,17 +1821,73 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	return num_written ? num_written : ret;
 }
 
-static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
+                               const struct iov_iter *iter, loff_t offset)
+{
+        unsigned int blocksize_mask = fs_info->sectorsize - 1;
+
+        if (offset & blocksize_mask)
+                return -EINVAL;
+
+        if (iov_iter_alignment(iter) & blocksize_mask)
+                return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	loff_t pos;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t pos = iocb->ki_pos;
 	ssize_t written;
 	ssize_t written_buffered;
 	loff_t endbyte;
 	int err;
+	struct extent_changeset *data_reserved = NULL;
+	size_t count = 0;
+	bool relock = false;
+
+	if (check_direct_IO(fs_info, from, pos))
+		return 0;
+
+	count = iov_iter_count(from);
+	/*
+	 * If the write DIO is beyond the EOF, we need update
+	 * the isize, but it is protected by i_mutex. So we can
+	 * not unlock the i_mutex at this case.
+	 */
+	if (pos + count <= inode->i_size) {
+		inode_unlock(inode);
+		relock = true;
+	} else if (iocb->ki_flags & IOCB_NOWAIT) {
+		return -EAGAIN;
+	}
+	err = btrfs_delalloc_reserve_space(inode, &data_reserved,
+			pos, count);
+	if (err) {
+		extent_changeset_free(data_reserved);
+		if (relock)
+			inode_lock(inode);
+		return err;
+	}
+
+	down_read(&BTRFS_I(inode)->dio_sem);
+	written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dops,
+			is_sync_kiocb(iocb));
+	up_read(&BTRFS_I(inode)->dio_sem);
 
-	written = btrfs_direct_IO(iocb, from);
+	if (written < count) {
+		size_t w = written < 0 ? 0 : written;
+		btrfs_delalloc_release_space(inode, data_reserved,
+				pos, count - (size_t)w, true);
+	}
+	btrfs_delalloc_release_extents(BTRFS_I(inode), count);
+
+	if (relock)
+		inode_lock(inode);
+	extent_changeset_free(data_reserved);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
@@ -1974,7 +2030,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		num_written = __btrfs_direct_write(iocb, from);
+		num_written = btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
 		if (num_written > 0)
@@ -3443,16 +3499,45 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static int check_direct_read(struct btrfs_fs_info *fs_info,
+                               const struct iov_iter *iter, loff_t offset)
+{
+	int ret;
+	int i, seg;
+
+	ret = check_direct_IO(fs_info, iter, offset);
+	if (ret < 0)
+		return ret;
+
+	for (seg = 0; seg < iter->nr_segs; seg++)
+		for (i = seg + 1; i < iter->nr_segs; i++)
+			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
+				return -EINVAL;
+	return 0;
+}
+
+static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	ret = check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos);
+	if (ret < 0)
+		return ret;
+
+	inode_lock_shared(inode);
+        ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dops,
+                        is_sync_kiocb(iocb));
+	inode_unlock_shared(inode);
+	return ret;
+}
+
 static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		struct inode *inode = file_inode(iocb->ki_filp);
-
-		inode_lock_shared(inode);
-		ret = btrfs_direct_IO(iocb, to);
-		inode_unlock_shared(inode);
+		ret = btrfs_direct_read(iocb, to);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 97ff3a38d704..4ccd2a23b1b4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -29,7 +29,6 @@
 #include <linux/iversion.h>
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
-#include <linux/iomap.h>
 #include <asm/unaligned.h>
 #include "misc.h"
 #include "ctree.h"
@@ -8047,109 +8046,15 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode,
 	return BLK_QC_T_NONE;
 }
 
-static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-			       const struct iov_iter *iter, loff_t offset)
-{
-	int seg;
-	int i;
-	unsigned int blocksize_mask = fs_info->sectorsize - 1;
-	ssize_t retval = -EINVAL;
-
-	if (offset & blocksize_mask)
-		goto out;
-
-	if (iov_iter_alignment(iter) & blocksize_mask)
-		goto out;
-
-	/* If this is a write we don't need to check anymore */
-	if (iov_iter_rw(iter) != READ || !iter_is_iovec(iter))
-		return 0;
-	/*
-	 * Check to make sure we don't have duplicate iov_base's in this
-	 * iovec, if so return EINVAL, otherwise we'll get csum errors
-	 * when reading back.
-	 */
-	for (seg = 0; seg < iter->nr_segs; seg++) {
-		for (i = seg + 1; i < iter->nr_segs; i++) {
-			if (iter->iov[seg].iov_base == iter->iov[i].iov_base)
-				goto out;
-		}
-	}
-	retval = 0;
-out:
-	return retval;
-}
-
-static const struct iomap_ops btrfs_dio_iomap_ops = {
+const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
 	.iomap_end		= btrfs_dio_iomap_end,
 };
 
-static const struct iomap_dio_ops btrfs_dops = {
+const struct iomap_dio_ops btrfs_dops = {
 	.submit_io		= btrfs_submit_direct,
 };
 
-
-/*
- * btrfs_direct_IO - perform direct I/O
- * inode->i_rwsem must be locked before calling this function, shared or exclusive.
- * @iocb - kernel iocb
- * @iter - iter to/from data is copied
- */
-
-ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_changeset *data_reserved = NULL;
-	loff_t offset = iocb->ki_pos;
-	size_t count = 0;
-	bool relock = false;
-	ssize_t ret;
-
-	if (check_direct_IO(fs_info, iter, offset))
-		return 0;
-
-	count = iov_iter_count(iter);
-	if (iov_iter_rw(iter) == WRITE) {
-		/*
-		 * If the write DIO is beyond the EOF, we need update
-		 * the isize, but it is protected by i_mutex. So we can
-		 * not unlock the i_mutex at this case.
-		 */
-		if (offset + count <= inode->i_size) {
-			inode_unlock(inode);
-			relock = true;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
-			ret = -EAGAIN;
-			goto out;
-		}
-		ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
-						   offset, count);
-		if (ret)
-			goto out;
-
-		down_read(&BTRFS_I(inode)->dio_sem);
-	}
-
-	ret = iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dops,
-			is_sync_kiocb(iocb));
-
-	if (iov_iter_rw(iter) == WRITE) {
-		up_read(&BTRFS_I(inode)->dio_sem);
-		if (ret >= 0 && (size_t)ret < count)
-			btrfs_delalloc_release_space(inode, data_reserved,
-					offset, count - (size_t)ret, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
-	}
-out:
-	if (relock)
-		inode_lock(inode);
-	extent_changeset_free(data_reserved);
-	return ret;
-}
-
 #define BTRFS_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.25.0

