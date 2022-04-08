Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B04F8E25
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiDHFL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 01:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiDHFLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 01:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A4824BD54
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 22:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XtL3dHU8QLuzv4afc3wWQfQh0P4Yt6HHlkgPBduibfw=; b=MpWKy4vBNIReKhkjK2BEf5zPr4
        S5cASYMabVJpefIxWEb0EEty155KU63yBmXhcKQ2K0azyZh0jFQoycKWhqk3bKKHGJpVfnHz93vO8
        nQEC1gK9AobqSuFXk6klRlDD/W6hDaBwrwVfsVBgdt5FnvXtoWJJMgYGw7QBM0BaAeX0wBWwzdfli
        PBCYol6/no4AIf4SI6oTRIfR3+0VLPT/flcgsdnDlnUH+hlliJOtwf3KIwd5Wb5p6JDy0PtXzmH00
        7OfSu64769YA+jA5QrOaehV64XeyuJO74VnbA/5M1QdHMuuPKha4nmLkIaWOy9VCadC86cgXWzPIY
        aidpfFyg==;
Received: from 213-225-37-164.nat.highway.a1.net ([213.225.37.164] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgs3-00F1BN-6M; Fri, 08 Apr 2022 05:09:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: don't allocate a btrfs_bio for scrub bios
Date:   Fri,  8 Apr 2022 07:08:38 +0200
Message-Id: <20220408050839.239113-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408050839.239113-1-hch@lst.de>
References: <20220408050839.239113-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All the scrub bios go straight to the block device or the raid56 code,
none of which looks at the btrfs_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe25a0d3d7c2d..7de6479020a1b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1411,8 +1411,8 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_sector->dev->bdev)
 		goto out;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
-	bio_set_dev(bio, first_sector->dev->bdev);
+	bio = bio_alloc(first_sector->dev->bdev, BIO_MAX_VECS, REQ_OP_READ,
+			GFP_NOFS);
 
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct scrub_sector *sector = sblock->sectors[i];
@@ -1642,8 +1642,6 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 	}
 	sbio = sctx->wr_curr_bio;
 	if (sbio->sector_count == 0) {
-		struct bio *bio;
-
 		ret = fill_writer_pointer_gap(sctx, sector->physical_for_dev_replace);
 		if (ret) {
 			mutex_unlock(&sctx->wr_lock);
@@ -1653,17 +1651,14 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->physical = sector->physical_for_dev_replace;
 		sbio->logical = sector->logical;
 		sbio->dev = sctx->wr_tgtdev;
-		bio = sbio->bio;
-		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->sectors_per_bio);
-			sbio->bio = bio;
+		if (!sbio->bio) {
+			sbio->bio = bio_alloc(sbio->dev->bdev,
+					      sctx->sectors_per_bio,
+					      REQ_OP_WRITE, GFP_NOFS);
 		}
-
-		bio->bi_private = sbio;
-		bio->bi_end_io = scrub_wr_bio_end_io;
-		bio_set_dev(bio, sbio->dev->bdev);
-		bio->bi_iter.bi_sector = sbio->physical >> 9;
-		bio->bi_opf = REQ_OP_WRITE;
+		sbio->bio->bi_private = sbio;
+		sbio->bio->bi_end_io = scrub_wr_bio_end_io;
+		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->sector_count * sectorsize !=
 		   sector->physical_for_dev_replace ||
@@ -1704,7 +1699,6 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 
 	sbio = sctx->wr_curr_bio;
 	sctx->wr_curr_bio = NULL;
-	WARN_ON(!sbio->bio->bi_bdev);
 	scrub_pending_bio_inc(sctx);
 	/* process all writes in a single worker thread. Then the block layer
 	 * orders the requests before sending them to the driver which
@@ -2076,22 +2070,17 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 	}
 	sbio = sctx->bios[sctx->curr];
 	if (sbio->sector_count == 0) {
-		struct bio *bio;
-
 		sbio->physical = sector->physical;
 		sbio->logical = sector->logical;
 		sbio->dev = sector->dev;
-		bio = sbio->bio;
-		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->sectors_per_bio);
-			sbio->bio = bio;
+		if (!sbio->bio) {
+			sbio->bio = bio_alloc(sbio->dev->bdev,
+					      sctx->sectors_per_bio,
+					      REQ_OP_READ, GFP_NOFS);
 		}
-
-		bio->bi_private = sbio;
-		bio->bi_end_io = scrub_bio_end_io;
-		bio_set_dev(bio, sbio->dev->bdev);
-		bio->bi_iter.bi_sector = sbio->physical >> 9;
-		bio->bi_opf = REQ_OP_READ;
+		sbio->bio->bi_private = sbio;
+		sbio->bio->bi_end_io = scrub_bio_end_io;
+		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->sector_count * sectorsize !=
 		   sector->physical ||
@@ -2207,7 +2196,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto bioc_out;
 	}
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = logical >> 9;
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
@@ -2823,7 +2812,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	if (ret || !bioc || !bioc->raid_map)
 		goto bioc_out;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
-- 
2.30.2

