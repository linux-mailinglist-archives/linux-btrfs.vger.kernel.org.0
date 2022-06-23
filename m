Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B5572B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiFWFxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 01:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFWFxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 01:53:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6143ED3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qkvI2y09+WPT4ibf/Bw31I+yRHI4Fi2z67qHlJykPG4=; b=edEddi0Zbm2Gef3w6NdTeTpwfu
        Zcnn/TXhEf1TyraDrNA9usWKsu2FlLmzhK+l100E8ON5GdqmFrO3+KG7wrckIUzuKSTn2PnNIHrTA
        4ca7z/henlbISqunoaA7Wk2iazI2XF4TwChYiPZYIQbseF+h4XuaYftebyANouWwkXLFgz53CpgpL
        cjZIITVu+NuPMaNgOJuQ9Hsdu+curnTEN70Q0ULQ+Y0YY/mFVgCQaWxyKXtdYp4E5/imo/rynOkv2
        oyE3+EKjs04waXOV9yHcMoimEivTYq+zAXqyuR/TfG04/YdeSZwpp9YcYA3AyEURLBw937wKUC098
        xr2eF3kQ==;
Received: from [2001:4bb8:189:7251:96bf:4177:9572:1a29] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Fml-00DY8I-Vi; Thu, 23 Jun 2022 05:53:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove the start argument to check_data_csum
Date:   Thu, 23 Jun 2022 07:53:37 +0200
Message-Id: <20220623055338.3833616-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623055338.3833616-1-hch@lst.de>
References: <20220623055338.3833616-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just derive it from the btrfs_bio now that ->file_offset is always valid.
Also make the function available outside of inode.c as we'll need that
soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/inode.c | 22 +++++++++-------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e2569f84aabc..164f54e6aa447 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3293,6 +3293,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
+int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
+		    struct page *page, u32 pgoff);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a627b2af9e243..429428fde4a88 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3396,20 +3396,18 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
- * @io_bio:	btrfs_io_bio which contains the csum
+ * @bbio:	btrfs_io_bio which contains the csum
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @page:	page where is the data to be verified
  * @pgoff:	offset inside the page
- * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
  *
  * When csum mismatch is detected, we will also report the error and fill the
  * corrupted range with zero. (Thus it needs the extra parameters)
  */
-static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
-			   u32 bio_offset, struct page *page, u32 pgoff,
-			   u64 start)
+int check_data_csum(struct inode *inode, struct btrfs_bio *bbio, u32 bio_offset,
+		    struct page *page, u32 pgoff)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u32 len = fs_info->sectorsize;
@@ -3425,8 +3423,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	return 0;
 
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
-				    bbio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode),
+				    bbio->file_offset + bio_offset,
+				    csum, csum_expected, bbio->mirror_num);
 	if (bbio->device)
 		btrfs_dev_stat_inc_and_print(bbio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
@@ -3495,8 +3494,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 					  EXTENT_NODATASUM);
 			continue;
 		}
-		ret = check_data_csum(inode, bbio, bio_offset, page, pg_off,
-				      page_offset(page) + pg_off);
+		ret = check_data_csum(inode, bbio, bio_offset, page, pg_off);
 		if (ret < 0) {
 			const int nr_bit = (pg_off - offset_in_page(start)) >>
 				     root->fs_info->sectorsize_bits;
@@ -7946,7 +7944,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 
 		if (uptodate &&
 		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
-					       bv.bv_offset, start))) {
+					       bv.bv_offset))) {
 			clean_io_failure(fs_info, failure_tree, io_tree, start,
 					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
 					 bv.bv_offset);
@@ -10324,7 +10322,6 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 	u32 sectorsize = fs_info->sectorsize;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
-	u64 start = priv->file_offset;
 	u32 bio_offset = 0;
 
 	if (priv->skip_csum || !uptodate)
@@ -10338,9 +10335,8 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (check_data_csum(&inode->vfs_inode, bbio, bio_offset,
-					    bvec->bv_page, pgoff, start))
+					    bvec->bv_page, pgoff))
 				return BLK_STS_IOERR;
-			start += sectorsize;
 			bio_offset += sectorsize;
 			pgoff += sectorsize;
 		}
-- 
2.30.2

