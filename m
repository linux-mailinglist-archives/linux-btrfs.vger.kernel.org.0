Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E986A45C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjB0PRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjB0PRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E09227AA
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+JFECx0Y30G9fQlDyMMtcWNCVMQ8Mt9yQCXypNSHCfs=; b=1Nlp0syA9lKZ1Cax05VbKQXaLK
        J15XbAj0odRbtVTwhBxeNNKea7lOezEG6gOmSSpTiLH1vHGhnLah4pxZerk1aJLwJXb1+PemuavKG
        Zo6BWDFMnFf3qvQ95xqGNLa79p2HP08j0iMZD4K8Yce+DfQEBedWGUxeZY6vX6gNkIo824KRxBPip
        svExP4oeCca+LBRoooNASe7TGtDbfzbPDnomb/sDjsLPXOCv2aUYgDfxxIGutXxzww3ddsX68mUJa
        O/S36RVgdOwIfa1L+dcM5Pf2/ClLWOnNPnVE0cbBWEsdCQ/avjNcMA0toesP9lzrOL4gyiPabWPj8
        ntfmmU3w==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFV-00AAu1-Mw; Mon, 27 Feb 2023 15:17:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 11/12] btrfs: check for contiguity in submit_extent_page
Date:   Mon, 27 Feb 2023 08:17:03 -0700
Message-Id: <20230227151704.1224688-12-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
References: <20230227151704.1224688-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Different loop iterations in btrfs_bio_add_page not only have
the same contiguity parameters, but also any non-initial operation
operates on a fresh bio anyway.

Factor out the contiguity check into a new btrfs_bio_is_contig and
only call it once in submit_extent_page before descending into the
bio_add_page loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 68 +++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d318b7f1b92cf3..8e6f0f07597e45 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -866,6 +866,37 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 	return 0;
 }
 
+static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
+				struct page *page, u64 disk_bytenr,
+				unsigned int pg_offset)
+{
+	struct bio *bio = bio_ctrl->bio;
+	struct bio_vec *bvec = bio_last_bvec_all(bio);
+	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
+
+	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
+		/*
+		 * For compression, all IO should have its logical bytenr
+		 * set to the starting bytenr of the compressed extent.
+		 */
+		return bio->bi_iter.bi_sector == sector;
+	}
+
+	/*
+	 * The contig check requires the following conditions to be met:
+	 * 1) The pages are belonging to the same inode
+	 *    This is implied by the call chain.
+	 *
+	 * 2) The range has adjacent logical bytenr
+	 *
+	 * 3) The range has adjacent file offset
+	 *    This is required for the usage of btrfs_bio->file_offset.
+	 */
+	return bio_end_sector(bio) == sector &&
+		page_offset(bvec->bv_page) + bvec->bv_offset + bvec->bv_len ==
+		page_offset(page) + pg_offset;
+}
+
 /*
  * Attempt to add a page to bio.
  *
@@ -890,44 +921,11 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	struct bio *bio = bio_ctrl->bio;
 	u32 bio_size = bio->bi_iter.bi_size;
 	u32 real_size;
-	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
-	bool contig = false;
 
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary);
 
-	if (bio->bi_iter.bi_size == 0) {
-		/* We can always add a page into an empty bio. */
-		contig = true;
-	} else if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE) {
-		struct bio_vec *bvec = bio_last_bvec_all(bio);
-
-		/*
-		 * The contig check requires the following conditions to be met:
-		 * 1) The pages are belonging to the same inode
-		 *    This is implied by the call chain.
-		 *
-		 * 2) The range has adjacent logical bytenr
-		 *
-		 * 3) The range has adjacent file offset
-		 *    This is required for the usage of btrfs_bio->file_offset.
-		 */
-		if (bio_end_sector(bio) == sector &&
-		    page_offset(bvec->bv_page) + bvec->bv_offset +
-		    bvec->bv_len == page_offset(page) + pg_offset)
-			contig = true;
-	} else {
-		/*
-		 * For compression, all IO should have its logical bytenr
-		 * set to the starting bytenr of the compressed extent.
-		 */
-		contig = bio->bi_iter.bi_sector == sector;
-	}
-
-	if (!contig)
-		return 0;
-
 	real_size = min(bio_ctrl->len_to_oe_boundary - bio_size, size);
 
 	/*
@@ -1024,6 +1022,10 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 	ASSERT(bio_ctrl->end_io_func);
 
+	if (bio_ctrl->bio &&
+	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
+		submit_one_bio(bio_ctrl);
+
 	while (cur < pg_offset + size) {
 		u32 offset = cur - pg_offset;
 		int added;
-- 
2.39.1

