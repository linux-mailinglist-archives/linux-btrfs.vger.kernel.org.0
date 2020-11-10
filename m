Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8568D2ACAE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 03:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgKJCJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 21:09:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:59886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbgKJCJU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 21:09:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604974158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpG2oOlwB56fXt/dSW7lLRxpB4kuskF6lzRuqr5+oA8=;
        b=rppfe22kcnzDMsdQ7nCN7gaR+JCbuowLcWY+ZJjKTNzzsrlnZw/DOL301X9d9/DfPEvhsq
        OlOJgFgI4p0zsgAk9oA1HkKKn69TSdDkLJ3PoVQQZJl27lXX8To3P0noHezcumH183oJP/
        DNKgKY04xzux7xnDwSWS3ZAkS2f1NKE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 972FEAC24
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Nov 2020 02:09:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: pass disk_bytenr directly for check_data_csum()
Date:   Tue, 10 Nov 2020 10:09:09 +0800
Message-Id: <20201110020909.23438-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110020909.23438-1-wqu@suse.com>
References: <20201110020909.23438-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Parameter @icsum for check_data_csum() is a little hard to understand.
So is the @phy_offset for btrfs_verify_data_csum().

Both parameters are calculated values for csum lookup.

Instead of some calculated value, just pass @disk_bytenr and let the
final and only user, check_data_csum(), to calculate whatever it needs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 14 ++++++++------
 fs/btrfs/inode.c     | 26 +++++++++++++++++---------
 2 files changed, 25 insertions(+), 15 deletions(-)

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
index c54e0ed0b938..e1d309bfc693 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2843,19 +2843,23 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
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
+	offset_sectors = (disk_bytenr - bio_disk_bytenr) >>
+			 fs_info->sectorsize_bits;
+	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -2883,8 +2887,13 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
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
@@ -2909,8 +2918,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		return 0;
 	}
 
-	phy_offset >>= root->fs_info->sectorsize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	return check_data_csum(inode, io_bio, disk_bytenr, page, offset);
 }
 
 /*
@@ -7616,7 +7624,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u64 start = io_bio->logical;
-	int icsum = 0;
+	u64 disk_bytenr = (io_bio->bio.bi_iter.bi_sector << 9);
 	blk_status_t err = BLK_STS_OK;
 
 	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
@@ -7627,8 +7635,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
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
@@ -7648,7 +7656,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
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

