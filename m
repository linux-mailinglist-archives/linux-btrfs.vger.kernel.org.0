Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854212CB541
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgLBGtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgLBGtL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAQVnz17eaV/KGT6Q3AI3r5uDcsh2LFrnaOWTkHV63g=;
        b=jTz/8+V+3tsdOLZ3xtyNjxKgjWfTl+1PHJV1aDt9w2d8WT6OrGIW9HgNuhibMNmawA+GMd
        yVI03Mtvtgbfu0pKqAgJ+ec2UzIBVtDF1G4DWfYgdvurneb1+lj4lY4wVg9KJdOzCXwPFy
        FsJAWdX9cKa7NaHifAgNUvnS7PWizTg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D62EAD5C;
        Wed,  2 Dec 2020 06:48:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 02/15] btrfs: pass bio_offset to check_data_csum() directly
Date:   Wed,  2 Dec 2020 14:47:58 +0800
Message-Id: <20201202064811.100688-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Parameter @icsum for check_data_csum() is a little hard to understand.
So is the @phy_offset for btrfs_verify_data_csum().

Both parameters are calculated values for csum lookup.

Instead of some calculated value, just pass @bio_offset and let the
final and only user, check_data_csum(), to calculate whatever it needs.

Since we are here, also make the bio_offset parameter and some related
variables to be u32 (unsigned int).
As bio size is limited by its bi_size, which is unsigned int, and has
extra size limit check during various bio operations.
Thus we are ensured that bio_offset won't over flow u32.

Thus for all involved functions, not only rename the parameter from
@phy_offset to @bio_offset, but also reduce its width to u32, so we
won't have suspicious "u32 = u64 >> sector_bits;" lines anymore.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++------------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 32 ++++++++++++++++++++------------
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2744e13e8eb9..112c9a2ae47b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3052,7 +3052,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 			   struct page *page, u64 start, u64 end, int mirror);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 569d50ccf78a..a28b61510265 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2634,7 +2634,7 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 }
 
 blk_status_t btrfs_submit_read_repair(struct inode *inode,
-				      struct bio *failed_bio, u64 phy_offset,
+				      struct bio *failed_bio, u32 bio_offset,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
 				      submit_bio_hook_t *submit_bio_hook)
@@ -2644,7 +2644,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
-	const int icsum = phy_offset >> fs_info->sectorsize_bits;
+	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	bool need_validation;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
@@ -2869,10 +2869,11 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
-	u64 offset = 0;
-	u64 start;
-	u64 end;
-	u64 len;
+	/*
+	 * The offset to the beginning of a bio, since one bio can never be
+	 * larger than UINT_MAX, u32 here is enough.
+	 */
+	u32 bio_offset = 0;
 	int mirror;
 	int ret;
 	struct bvec_iter_all iter_all;
@@ -2882,7 +2883,10 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		u32 sectorsize = fs_info->sectorsize;
+		const u32 sectorsize = fs_info->sectorsize;
+		u64 start;
+		u64 end;
+		u32 len;
 
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
@@ -2915,8 +2919,9 @@ static void end_bio_extent_readpage(struct bio *bio)
 		mirror = io_bio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode))
-				ret = btrfs_verify_data_csum(io_bio, offset, page,
-							     start, end, mirror);
+				ret = btrfs_verify_data_csum(io_bio,
+						bio_offset, page, start, end,
+						mirror);
 			else
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
@@ -2944,12 +2949,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * If it can't handle the error it will return -EIO and
 			 * we remain responsible for that page.
 			 */
-			if (!btrfs_submit_read_repair(inode, bio, offset, page,
+			if (!btrfs_submit_read_repair(inode, bio, bio_offset,
+						page,
 						start - page_offset(page),
 						start, end, mirror,
 						btrfs_submit_data_bio)) {
 				uptodate = !bio->bi_status;
-				offset += len;
+				ASSERT(bio_offset + len > bio_offset);
+				bio_offset += len;
 				continue;
 			}
 		} else {
@@ -2974,7 +2981,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			if (page->index == end_index && off)
 				zero_user_segment(page, off, PAGE_SIZE);
 		}
-		offset += len;
+		ASSERT(bio_offset + len > bio_offset);
+		bio_offset += len;
 
 		/* Update page status and unlock */
 		endio_readpage_update_page_status(page, uptodate);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index d3c7ad02db24..db95468801c7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -291,7 +291,7 @@ struct io_failure_record {
 
 
 blk_status_t btrfs_submit_read_repair(struct inode *inode,
-				      struct bio *failed_bio, u64 phy_offset,
+				      struct bio *failed_bio, u32 bio_offset,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
 				      submit_bio_hook_t *submit_bio_hook);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cf27729e41c8..5c051b0e58a5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2942,28 +2942,30 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
- * @inode:	the inode
+ * @inode:	inode
  * @io_bio:	btrfs_io_bio which contains the csum
- * @icsum:	checksum index in the io_bio->csum array, size of csum_size
+ * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @page:	page where is the data to be verified
  * @pgoff:	offset inside the page
  *
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   int icsum, struct page *page, int pgoff)
+			   u32 bio_offset, struct page *page, int pgoff)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
 	u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
+	unsigned int offset_sectors;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
-	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
+	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
+	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -2988,11 +2990,16 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 }
 
 /*
- * when reads are done, we need to check csums to verify the data is correct
+ * When reads are done, we need to check csums to verify the data is correct.
  * if there's a match, we allow the bio to finish.  If not, the code in
  * extent_io.c will try to find good copies for us.
+ *
+ * @bio_offset:	offset to the beginning of the bio (in bytes)
+ * @start:	file offset of the range start
+ * @end:	file offset of the range end (inclusive)
+ * @mirror:	mirror number
  */
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 			   struct page *page, u64 start, u64 end, int mirror)
 {
 	size_t offset = start - page_offset(page);
@@ -3017,8 +3024,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		return 0;
 	}
 
-	phy_offset >>= root->fs_info->sectorsize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	return check_data_csum(inode, io_bio, bio_offset, page, offset);
 }
 
 /*
@@ -7712,7 +7718,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u64 start = io_bio->logical;
-	int icsum = 0;
+	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
 	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
@@ -7723,8 +7729,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
-			    (!csum || !check_data_csum(inode, io_bio, icsum,
-						       bvec.bv_page, pgoff))) {
+			    (!csum || !check_data_csum(inode, io_bio,
+					bio_offset, bvec.bv_page, pgoff))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
 						 start, bvec.bv_page,
 						 btrfs_ino(BTRFS_I(inode)),
@@ -7732,6 +7738,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			} else {
 				blk_status_t status;
 
+				ASSERT((start - io_bio->logical) < UINT_MAX);
 				status = btrfs_submit_read_repair(inode,
 							&io_bio->bio,
 							start - io_bio->logical,
@@ -7744,7 +7751,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 					err = status;
 			}
 			start += sectorsize;
-			icsum++;
+			ASSERT(bio_offset + sectorsize > bio_offset);
+			bio_offset += sectorsize;
 			pgoff += sectorsize;
 		}
 	}
-- 
2.29.2

