Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F792B0155
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgKLIsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 03:48:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:39886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgKLIsI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 03:48:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605170886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMqMdX++n5lyxoc2vhVlXZPRBqXRtWZZ8EkQ35uRuTU=;
        b=fbAPx5eY2OLoc/NFKn603P5D/UVHVAu31phFEGtxWuYkUSKn6TKGKUfYd0XbCfJ5AeVAx7
        vAdyY5WWotAtgZToA1PxGlRpnZK9NvFuDep/aOAgzEiE59fN0SSnIBd3wjGuAAo7oCVepX
        XH+LlPZHtzlt0aFlishwTtI/Ltw/dCs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B09D9ABD1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 08:48:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: pass bio_offset to check_data_csum() directly
Date:   Thu, 12 Nov 2020 16:47:58 +0800
Message-Id: <20201112084758.73617-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112084758.73617-1-wqu@suse.com>
References: <20201112084758.73617-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/extent_io.c | 14 ++++++++------
 fs/btrfs/inode.c     | 26 ++++++++++++++++----------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 679da4920c92..99955b6bfc62 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3046,7 +3046,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 bio_offset,
 			   struct page *page, u64 start, u64 end, int mirror);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d26677745757..72aac9a007ee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
-	u64 offset = 0;
+	u64 bio_offset = 0;
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
+						bio_offset, page, start, end,
+						mirror);
 			else
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
@@ -2953,12 +2954,13 @@ static void end_bio_extent_readpage(struct bio *bio)
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
+				bio_offset += len;
 				continue;
 			}
 		} else {
@@ -2983,7 +2985,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 			if (page->index == end_index && off)
 				zero_user_segment(page, off, PAGE_SIZE);
 		}
-		offset += len;
+		bio_offset += len;
 
 		endio_readpage_update_page_status(page, uptodate);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 435b270430e3..bcf3152d0efb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2931,26 +2931,28 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	the inode
  * @io_bio:	btrfs_io_bio which contains the csum
- * @icsum:	checksum index in the io_bio->csum array, size of csum_size
+ * @bio_offset:	the offset to the beginning of the bio (in bytes)
  * @page:	page where is the data to be verified
  * @pgoff:	offset inside the page
  *
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   int icsum, struct page *page, int pgoff)
+			   u64 bio_offset, struct page *page, int pgoff)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
 	u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
+	int offset_sectors;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
-	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
+	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
+	csum_expected = ((u8 *)io_bio->csum) + offset_sectors * csum_size;
 
 	kaddr = kmap_atomic(page);
 	shash->tfm = fs_info->csum_shash;
@@ -2978,8 +2980,13 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
  * when reads are done, we need to check csums to verify the data is correct
  * if there's a match, we allow the bio to finish.  If not, the code in
  * extent_io.c will try to find good copies for us.
+ *
+ * @bio_offset:	The offset to the begining of the bio (in bytes)
+ * @start:	The file offset of the range start
+ * @end:	The file offset of the range end (inclusive)
+ * @mirror:	The mirror number
  */
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
+int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 bio_offset,
 			   struct page *page, u64 start, u64 end, int mirror)
 {
 	size_t offset = start - page_offset(page);
@@ -3004,8 +3011,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		return 0;
 	}
 
-	phy_offset >>= root->fs_info->sectorsize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	return check_data_csum(inode, io_bio, bio_offset, page, offset);
 }
 
 /*
@@ -7716,7 +7722,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u64 start = io_bio->logical;
-	int icsum = 0;
+	u64 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
 	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
@@ -7727,8 +7733,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
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
@@ -7748,7 +7754,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 					err = status;
 			}
 			start += sectorsize;
-			icsum++;
+			bio_offset += sectorsize;
 			pgoff += sectorsize;
 		}
 	}
-- 
2.29.2

