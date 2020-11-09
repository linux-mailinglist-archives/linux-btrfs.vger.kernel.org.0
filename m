Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD02AB794
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgKILy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 06:54:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbgKILy1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 06:54:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604922866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N70hnqisWGeZLXBB0GQOQrx1aF1OE/uzE2BQU24FTMM=;
        b=XBO6eynhZbOch08I9YzHK13NfAEXtR+HB/k9GvFQHjRp1f80oqWBnOTMrdkoovHcnzg3tI
        fw8qd8hQwqawUt847OiuawRgsz1ivv6AQnET1SqfeqLwuimW2nZPk/yONpJXV4d2r074MZ
        5SvJ1CwgMANjvDdoqGT4scUBs9Lke/A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B479AC1D
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 11:54:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: use more straightforward disk_bytenr to replace icsum for check_data_csum()
Date:   Mon,  9 Nov 2020 19:54:10 +0800
Message-Id: <20201109115410.605880-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109115410.605880-1-wqu@suse.com>
References: <20201109115410.605880-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Parameter @icsum for check_data_csum() is a little hard to understand.
It is the offset in sectors compared to io_bio->logical.

Instead of using the calculated value, let's go with disk_bytenr, as the
new name is not only straightforward,  but also utilized in a lot of
existing code for file items.

To get the old @icsum value, we simply use
(disk_bytenr - (io_bio->bio.bi_iter.bi_sector << 9)) >>
fs_info->sectorsize_bits;

This patch would separate file offset with disk_bytenr completely, to
reduce the confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 14 ++++++++------
 fs/btrfs/inode.c     | 35 ++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bd5a22bfee68..f8b5d3d4e5b0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
-	u64 offset = 0;
+	u64 disk_bytenr = (bio->bi_iter.bi_sector << 9);
 	u64 start;
 	u64 end;
 	u64 len;
@@ -2924,8 +2924,9 @@ static void end_bio_extent_readpage(struct bio *bio)
 		mirror = io_bio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode))
-				ret = btrfs_verify_data_csum(io_bio, offset, page,
-							     start, end, mirror);
+				ret = btrfs_verify_data_csum(io_bio,
+						disk_bytenr, page, start, end,
+						mirror);
 			else
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
@@ -2953,12 +2954,13 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * If it can't handle the error it will return -EIO and
 			 * we remain responsible for that page.
 			 */
-			if (!btrfs_submit_read_repair(inode, bio, offset, page,
+			if (!btrfs_submit_read_repair(inode, bio, disk_bytenr,
+						page,
 						start - page_offset(page),
 						start, end, mirror,
 						btrfs_submit_data_bio)) {
 				uptodate = !bio->bi_status;
-				offset += len;
+				disk_bytenr += len;
 				continue;
 			}
 		} else {
@@ -2983,7 +2985,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 			if (page->index == end_index && off)
 				zero_user_segment(page, off, PAGE_SIZE);
 		}
-		offset += len;
+		disk_bytenr += len;
 
 		endio_readpage_update_page_status(page, uptodate);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c54e0ed0b938..eff987931f0d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2843,19 +2843,27 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   int icsum, struct page *page, int pgoff)
+			   u64 disk_bytenr, struct page *page, int pgoff)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
 	u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
+	u64 bio_disk_bytenr = (io_bio->bio.bi_iter.bi_sector << 9);
+	int offset_sectors;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
-	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
+	/* Our disk_bytenr should be inside the io_bio */
+	ASSERT(bio_disk_bytenr <= disk_bytenr &&
+	       disk_bytenr < bio_disk_bytenr + io_bio->bio.bi_iter.bi_size);
+
+	offset_sectors = (disk_bytenr - bio_disk_bytenr) >>
+			 fs_info->sectorsize_bits;
+	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -2883,8 +2891,13 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * when reads are done, we need to check csums to verify the data is correct
  * if there's a match, we allow the bio to finish.  If not, the code in
  * extent_io.c will try to find good copies for us.
+ *
+ * @disk_bytenr: The on-disk bytenr of the range start
+ * @start:	 The file offset of the range start
+ * @end:	 The file offset of the range end (inclusive)
+ * @mirror:	 The mirror number
  */
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 disk_bytenr,
 			   struct page *page, u64 start, u64 end, int mirror)
 {
 	size_t offset = start - page_offset(page);
@@ -2909,8 +2922,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		return 0;
 	}
 
-	phy_offset >>= root->fs_info->sectorsize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	return check_data_csum(inode, io_bio, disk_bytenr, page, offset);
 }
 
 /*
@@ -7616,7 +7628,12 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u64 start = io_bio->logical;
-	int icsum = 0;
+	/*
+	 * Dio io_bio uses file offset other than disk bytenr for
+	 * io_bio->logical.
+	 * Thus we need to grab disk_bytenr from bio.
+	 */
+	u64 disk_bytenr = (io_bio->bio.bi_iter.bi_sector << 9);
 	blk_status_t err = BLK_STS_OK;
 
 	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
@@ -7627,8 +7644,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
-			    (!csum || !check_data_csum(inode, io_bio, icsum,
-						       bvec.bv_page, pgoff))) {
+			    (!csum || !check_data_csum(inode, io_bio,
+					disk_bytenr, bvec.bv_page, pgoff))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
 						 start, bvec.bv_page,
 						 btrfs_ino(BTRFS_I(inode)),
@@ -7648,7 +7665,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 					err = status;
 			}
 			start += sectorsize;
-			icsum++;
+			disk_bytenr += sectorsize;
 			pgoff += sectorsize;
 		}
 	}
-- 
2.29.2

