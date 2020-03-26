Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488A31949B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 22:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCZVDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 17:03:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVDb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:03:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AEF4CAE83;
        Thu, 26 Mar 2020 21:03:29 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/9] btrfs: Use ->iomap_end() instead of btrfs_dio_data
Date:   Thu, 26 Mar 2020 16:02:50 -0500
Message-Id: <20200326210254.17647-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200326210254.17647-1-rgoldwyn@suse.de>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use iomap->iomap_end() to check for failed or incomplete writes and call
__endio_write_update_ordered(). We don't need btrfs_dio_data anymore so
remove that. The bonus is we don't abuse current->journal_info anymore.

A new structure btrfs_iomap is used to keep a count of submitted I/O
for writes.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 110 +++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bb7b3cfd24e8..7bda178afa87 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,11 +55,8 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
-struct btrfs_dio_data {
-	u64 reserve;
-	u64 unsubmitted_oe_range_start;
-	u64 unsubmitted_oe_range_end;
-	int overwrite;
+struct btrfs_iomap {
+	u64 submitted_bytes;
 };
 
 static const struct inode_operations btrfs_dir_inode_operations;
@@ -7084,7 +7081,6 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 
 static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
 					 u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -7158,13 +7154,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 * Need to update the i_size under the extent lock so buffered
 	 * readers will get the updated i_size when we unlock.
 	 */
-	if (!dio_data->overwrite && start + len > i_size_read(inode))
+	if (start + len > i_size_read(inode))
 		i_size_write(inode, start + len);
 
-	WARN_ON(dio_data->reserve < len);
-	dio_data->reserve -= len;
-	dio_data->unsubmitted_oe_range_end = start + len;
-	current->journal_info = dio_data;
 out:
 	return ret;
 }
@@ -7176,7 +7168,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_dio_data *dio_data = NULL;
 	u64 lockstart, lockend;
 	bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
@@ -7200,14 +7191,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		ret = filemap_fdatawrite_range(inode->i_mapping, start,
 					 start + length - 1);
 
-	if (current->journal_info) {
-		/*
-		 * Need to pull our outstanding extents and set journal_info to NULL so
-		 * that anything that needs to check if there's a transaction doesn't get
-		 * confused.
-		 */
-		dio_data = current->journal_info;
-		current->journal_info = NULL;
+	if (write) {
+		iomap->private = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
+		if (!iomap->private) {
+			ret = -ENOMEM;
+			goto err;
+		}
 	}
 
 	/*
@@ -7217,7 +7206,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (lock_extent_direct(inode, lockstart, lockend, &cached_state,
 			       write)) {
 		ret = -ENOTBLK;
-		goto err;
+		goto release;
 	}
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
@@ -7250,7 +7239,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	len = min(len, em->len - (start - em->start));
 	if (write) {
 		ret = btrfs_get_blocks_direct_write(&em, inode,
-						    dio_data, start, len);
+						    start, len);
 		if (ret < 0)
 			goto unlock_err;
 		unlock_extents = true;
@@ -7301,9 +7290,31 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 unlock_err:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
+release:
+	if (iomap->private)
+		kfree(iomap->private);
 err:
-	if (dio_data)
-		current->journal_info = dio_data;
+	return ret;
+}
+
+static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned flags, struct iomap *iomap)
+{
+	struct btrfs_iomap *btrfs_iomap = iomap->private;
+	int ret = 0;
+
+	if (!(flags & IOMAP_WRITE))
+		return 0;
+
+	if (btrfs_iomap->submitted_bytes < length) {
+		__endio_write_update_ordered(inode,
+				pos + btrfs_iomap->submitted_bytes,
+				length - btrfs_iomap->submitted_bytes,
+				false);
+		ret = -ENOTBLK;
+	}
+
+	kfree(btrfs_iomap);
 	return ret;
 }
 
@@ -7963,6 +7974,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode,
 	struct bio *bio = NULL;
 	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	struct btrfs_iomap *btrfs_iomap = iomap->private;
 	int ret = 0;
 
 	bio = btrfs_bio_clone(dio_bio);
@@ -7977,6 +7989,8 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode,
 	dip->inode = inode;
 	dip->logical_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
+	if (write)
+		btrfs_iomap->submitted_bytes += dip->bytes;
 	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
 	bio->bi_private = dip;
 	dip->orig_bio = bio;
@@ -7992,21 +8006,6 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode,
 		dip->subio_endio = btrfs_subio_endio_read;
 	}
 
-	/*
-	 * Reset the range for unsubmitted ordered extents (to a 0 length range)
-	 * even if we fail to submit a bio, because in such case we do the
-	 * corresponding error handling below and it must not be done a second
-	 * time by btrfs_direct_IO().
-	 */
-	if (write) {
-		struct btrfs_dio_data *dio_data = current->journal_info;
-
-		dio_data->unsubmitted_oe_range_end = dip->logical_offset +
-			dip->bytes;
-		dio_data->unsubmitted_oe_range_start =
-			dio_data->unsubmitted_oe_range_end;
-	}
-
 	ret = btrfs_submit_direct_hook(dip);
 	if (!ret)
 		return BLK_QC_T_NONE;
@@ -8086,6 +8085,7 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_begin            = btrfs_dio_iomap_begin,
+	.iomap_end		= btrfs_dio_iomap_end,
 };
 
 static const struct iomap_dio_ops btrfs_dops = {
@@ -8105,7 +8105,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_dio_data dio_data = { 0 };
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
 	size_t count = 0;
@@ -8123,7 +8122,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		 * not unlock the i_mutex at this case.
 		 */
 		if (offset + count <= inode->i_size) {
-			dio_data.overwrite = 1;
 			inode_unlock(inode);
 			relock = true;
 		} else if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -8135,16 +8133,6 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		if (ret)
 			goto out;
 
-		/*
-		 * We need to know how many extents we reserved so that we can
-		 * do the accounting properly if we go over the number we
-		 * originally calculated.  Abuse current->journal_info for this.
-		 */
-		dio_data.reserve = round_up(count,
-					    fs_info->sectorsize);
-		dio_data.unsubmitted_oe_range_start = (u64)offset;
-		dio_data.unsubmitted_oe_range_end = (u64)offset;
-		current->journal_info = &dio_data;
 		down_read(&BTRFS_I(inode)->dio_sem);
 	}
 
@@ -8153,25 +8141,7 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iov_iter_rw(iter) == WRITE) {
 		up_read(&BTRFS_I(inode)->dio_sem);
-		current->journal_info = NULL;
-		if (ret < 0 && ret != -EIOCBQUEUED) {
-			if (dio_data.reserve)
-				btrfs_delalloc_release_space(inode, data_reserved,
-					offset, dio_data.reserve, true);
-			/*
-			 * On error we might have left some ordered extents
-			 * without submitting corresponding bios for them, so
-			 * cleanup them up to avoid other tasks getting them
-			 * and waiting for them to complete forever.
-			 */
-			if (dio_data.unsubmitted_oe_range_start <
-			    dio_data.unsubmitted_oe_range_end)
-				__endio_write_update_ordered(inode,
-					dio_data.unsubmitted_oe_range_start,
-					dio_data.unsubmitted_oe_range_end -
-					dio_data.unsubmitted_oe_range_start,
-					false);
-		} else if (ret >= 0 && (size_t)ret < count)
+		if (ret >= 0 && (size_t)ret < count)
 			btrfs_delalloc_release_space(inode, data_reserved,
 					offset, count - (size_t)ret, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
-- 
2.25.0

