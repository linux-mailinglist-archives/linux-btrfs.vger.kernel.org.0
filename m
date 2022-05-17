Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52152A553
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbiEQOvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349425AbiEQOve (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81318358
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CggfV78VLKOgKACYxrle1UO3y6/cU/pC/Ah7chn6aVY=; b=JsmCvsXpWbzT80igJyGt8iiy9b
        QgwvbIihJoHsytbwCzNazT7DSQwdpKHZYE4z+8xBdVSYCcKNdMBVYLD7Wv1oEk2CZProhoqPqmbDv
        Jm+RmnrHQs39qtlg0j6nzYpQTucbAFbUvCYou8tifAjF10nC62S3AXFiYhJVga6eFJ51RQsWNP3sT
        92RpSJ28tB9MFzLl3H8odJbsT5woU+XbiPG5iqM1MelyvkGy7WKWATZkiyY8aaF/3m/HYTyfIfsLu
        R6hT/QwTgIE7EMIRxi21CPTWkYpGjqXhNOAPBbZ8S9Aytx7XTSD1FwFSOy0Qa2lmhU+blMDTWbPpY
        ssHHhQoQ==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXl-00EXHr-Uq; Tue, 17 May 2022 14:51:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 13/15] btrfs: use the new read repair code for direct I/O
Date:   Tue, 17 May 2022 16:50:37 +0200
Message-Id: <20220517145039.3202184-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rewrite btrfs_check_read_dio_bio to use btrfs_bio_for_each_sector and
start/end a repair session as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 76 +++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c771136116151..51cca8f343b72 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "read-repair.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -7861,71 +7862,36 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				  int mirror_num,
-				  enum btrfs_compression_type compress_type)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
-	if (btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA))
-		return;
-
-	refcount_inc(&dip->refs);
-	if (btrfs_map_bio(fs_info, bio, mirror_num))
-		refcount_dec(&dip->refs);
-}
-
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
-	struct bio_vec bvec;
+	struct btrfs_read_repair rr = { };
+	blk_status_t ret = BLK_STS_OK;
 	struct bvec_iter iter;
-	u32 bio_offset = 0;
-	blk_status_t err = BLK_STS_OK;
-
-	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
-		unsigned int i, nr_sectors, pgoff;
-
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
-		pgoff = bvec.bv_offset;
-		for (i = 0; i < nr_sectors; i++) {
-			u64 start = bbio->file_offset + bio_offset;
-
-			ASSERT(pgoff < PAGE_SIZE);
-			if (uptodate &&
-			    (!csum || !check_data_csum(inode, bbio,
-						       bio_offset, bvec.bv_page,
-						       pgoff, start))) {
-				clean_io_failure(fs_info, failure_tree, io_tree,
-						 start, bvec.bv_page,
-						 btrfs_ino(BTRFS_I(inode)),
-						 pgoff);
-			} else {
-				int ret;
-
-				ret = btrfs_repair_one_sector(inode, &bbio->bio,
-						bio_offset, bvec.bv_page, pgoff,
-						start, bbio->mirror_num,
-						submit_dio_repair_bio);
-				if (ret)
-					err = errno_to_blk_status(ret);
-			}
-			ASSERT(bio_offset + sectorsize > bio_offset);
-			bio_offset += sectorsize;
-			pgoff += sectorsize;
+	struct bio_vec bv;
+	u32 offset;
+
+	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
+		if (uptodate &&
+		    (!csum || !check_data_csum(inode, bbio, offset,
+				bv.bv_page, bv.bv_offset,
+				bbio->file_offset + offset))) {
+			if (!btrfs_read_repair_end(&rr, bbio, inode, offset,
+					NULL))
+				ret = BLK_STS_IOERR;
+		} else {
+			if (!btrfs_read_repair_add(&rr, bbio, inode, offset))
+				ret = BLK_STS_IOERR;
 		}
 	}
-	return err;
+
+	if (!btrfs_read_repair_end(&rr, bbio, inode, offset, NULL))
+		ret = BLK_STS_IOERR;
+	return ret;
 }
 
 static void __endio_write_update_ordered(struct btrfs_inode *inode,
-- 
2.30.2

