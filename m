Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001A3FE289
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 17:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfKOQRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 11:17:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbfKOQRh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27A0DAC4A;
        Fri, 15 Nov 2019 16:17:34 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/7] btrfs: Use iomap_dio_rw() for direct I/O
Date:   Fri, 15 Nov 2019 10:16:57 -0600
Message-Id: <20191115161700.12305-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191115161700.12305-1-rgoldwyn@suse.de>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is the main patch to switch call from
__blockdev_direct_IO() to iomap_dio_rw(). In this patch:

Removed buffer_head references
Removed inode_dio_begin() and inode_dio_end() functions since
they are called in iomap_dio_rw().
Renamed btrfs_get_blocks_direct() to direct_iomap_begin() and
used it as iomap_begin()
address_space.direct_IO now is a noop since direct_IO is called
from __btrfs_write_direct().

Removed flags parameter used for __blockdev_direct_IO(). iomap is
capable of direct I/O reads from a hole, so we don't need to
return -ENOENT.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |   1 +
 fs/btrfs/file.c  |   2 +-
 fs/btrfs/inode.c | 105 ++++++++++++++++++-------------------------------------
 3 files changed, 36 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fe2b8765d9e6..cde8423673fc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2903,6 +2903,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
+ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index eede9dcbb4b6..d47da00fa61e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1835,7 +1835,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	int err;
 
-	written = generic_file_direct_write(iocb, from);
+	written = btrfs_direct_IO(iocb, from);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c6dc4dd16cf7..e2e4dfb7a568 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8,6 +8,7 @@
 #include <linux/buffer_head.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/iomap.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
@@ -7619,28 +7620,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 }
 
 
-static int btrfs_get_blocks_direct_read(struct extent_map *em,
-					struct buffer_head *bh_result,
-					struct inode *inode,
-					u64 start, u64 len)
-{
-	if (em->block_start == EXTENT_MAP_HOLE ||
-			test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		return -ENOENT;
-
-	len = min(len, em->len - (start - em->start));
-
-	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
-		inode->i_blkbits;
-	bh_result->b_size = len;
-	bh_result->b_bdev = em->bdev;
-	set_buffer_mapped(bh_result);
-
-	return 0;
-}
-
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
-					 struct buffer_head *bh_result,
 					 struct inode *inode,
 					 struct btrfs_dio_data *dio_data,
 					 u64 start, u64 len)
@@ -7702,7 +7682,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	}
 
 	/* this will cow the extent */
-	len = bh_result->b_size;
 	free_extent_map(em);
 	*map = em = btrfs_new_extent_direct(inode, start, len);
 	if (IS_ERR(em)) {
@@ -7713,15 +7692,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	len = min(len, em->len - (start - em->start));
 
 skip_cow:
-	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
-		inode->i_blkbits;
-	bh_result->b_size = len;
-	bh_result->b_bdev = em->bdev;
-	set_buffer_mapped(bh_result);
-
-	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		set_buffer_new(bh_result);
-
 	/*
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
@@ -7737,17 +7707,18 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	return ret;
 }
 
-static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
-				   struct buffer_head *bh_result, int create)
+static int direct_iomap_begin(struct inode *inode, loff_t start,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = NULL;
-	u64 start = iblock << inode->i_blkbits;
 	u64 lockstart, lockend;
-	u64 len = bh_result->b_size;
+	int create = flags & IOMAP_WRITE;
 	int ret = 0;
+	u64 len = length;
 
 	if (!create)
 		len = min_t(u64, len, fs_info->sectorsize);
@@ -7803,7 +7774,7 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 	}
 
 	if (create) {
-		ret = btrfs_get_blocks_direct_write(&em, bh_result, inode,
+		ret = btrfs_get_blocks_direct_write(&em, inode,
 						    dio_data, start, len);
 		if (ret < 0)
 			goto unlock_err;
@@ -7811,19 +7782,13 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
 				     lockend, &cached_state);
 	} else {
-		ret = btrfs_get_blocks_direct_read(em, bh_result, inode,
-						   start, len);
-		/* Can be negative only if we read from a hole */
-		if (ret < 0) {
-			ret = 0;
-			free_extent_map(em);
-			goto unlock_err;
-		}
+
+		len = min(len, em->len - (start - em->start));
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
 		 */
-		lockstart = start + bh_result->b_size;
+		lockstart = start + len;
 		if (lockstart < lockend) {
 			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
 					     lockstart, lockend, &cached_state);
@@ -7832,6 +7797,18 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 		}
 	}
 
+	if ((em->block_start == EXTENT_MAP_HOLE) ||
+	    (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) && !create)) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_HOLE;
+	} else {
+		iomap->addr = em->block_start - (start - em->start);
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = start;
+	iomap->bdev = em->bdev;
+	iomap->length = min(len, em->len - (start - em->start));
+
 	free_extent_map(em);
 
 	return 0;
@@ -8199,9 +8176,8 @@ static void btrfs_endio_direct_read(struct bio *bio)
 	kfree(dip);
 
 	dio_bio->bi_status = err;
-	dio_end_io(dio_bio);
+	bio_endio(dio_bio);
 	btrfs_io_bio_free_csum(io_bio);
-	bio_put(bio);
 }
 
 static void __endio_write_update_ordered(struct inode *inode,
@@ -8263,8 +8239,7 @@ static void btrfs_endio_direct_write(struct bio *bio)
 	kfree(dip);
 
 	dio_bio->bi_status = bio->bi_status;
-	dio_end_io(dio_bio);
-	bio_put(bio);
+	bio_endio(dio_bio);
 }
 
 static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
@@ -8568,7 +8543,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		/*
 		 * The end io callbacks free our dip, do the final put on bio
 		 * and all the cleanup and final put for dio_bio (through
-		 * dio_end_io()).
+		 * end_io()).
 		 */
 		dip = NULL;
 		bio = NULL;
@@ -8587,7 +8562,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		 * Releases and cleans up our dio_bio, no need to bio_put()
 		 * nor bio_endio()/bio_io_error() against dio_bio.
 		 */
-		dio_end_io(dio_bio);
+		bio_endio(dio_bio);
 	}
 	if (bio)
 		bio_put(bio);
@@ -8627,7 +8602,11 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	return retval;
 }
 
-static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+static const struct iomap_ops dio_iomap_ops = {
+	.iomap_begin		= direct_iomap_begin,
+};
+
+ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
@@ -8637,14 +8616,11 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
 	int flags = 0;
-	bool wakeup = true;
-	bool relock = false;
 	ssize_t ret;
 
 	if (check_direct_IO(fs_info, iter, offset))
 		return 0;
 
-	inode_dio_begin(inode);
 
 	/*
 	 * The generic stuff only does filemap_write_and_wait_range, which
@@ -8664,11 +8640,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * the isize, but it is protected by i_mutex. So we can
 		 * not unlock the i_mutex at this case.
 		 */
-		if (offset + count <= inode->i_size) {
-			dio_data.overwrite = 1;
-			inode_unlock(inode);
-			relock = true;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
 		}
@@ -8690,15 +8662,11 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		down_read(&BTRFS_I(inode)->dio_sem);
 	} else if (test_bit(BTRFS_INODE_READDIO_NEED_LOCK,
 				     &BTRFS_I(inode)->runtime_flags)) {
-		inode_dio_end(inode);
 		flags = DIO_LOCKING | DIO_SKIP_HOLES;
-		wakeup = false;
 	}
 
-	ret = __blockdev_direct_IO(iocb, inode,
-				   fs_info->fs_devices->latest_bdev,
-				   iter, btrfs_get_blocks_direct, NULL,
-				   btrfs_submit_direct, flags);
+	ret = iomap_dio_rw(iocb, iter, &dio_iomap_ops, NULL, is_sync_kiocb(iocb));
+
 	if (iov_iter_rw(iter) == WRITE) {
 		up_read(&BTRFS_I(inode)->dio_sem);
 		current->journal_info = NULL;
@@ -8725,11 +8693,6 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
 	}
 out:
-	if (wakeup)
-		inode_dio_end(inode);
-	if (relock)
-		inode_lock(inode);
-
 	extent_changeset_free(data_reserved);
 	return ret;
 }
-- 
2.16.4

