Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68D71971B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjFAJhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 05:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFAJhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 05:37:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB1136
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 02:37:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D26CC67373; Thu,  1 Jun 2023 11:37:47 +0200 (CEST)
Date:   Thu, 1 Jun 2023 11:37:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: fix dev-replace after the scrub rework
Message-ID: <20230601093747.GA6652@lst.de>
References: <0113e9e82b06106940e8ef7323fd4a9c01aa5afc.1685610531.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0113e9e82b06106940e8ef7323fd4a9c01aa5afc.1685610531.git.wqu@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes the tests case for me.  I'd much prefer to not
duplicate all this logic though, so something like this should
be folded in:

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4e74105bc97191..6fbf30bea27ab0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1102,6 +1102,33 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		wake_up(&stripe->io_wait);
 }
 
+static void btrfs_submit_scrub_bio(struct scrub_ctx *sctx,
+				   struct scrub_stripe *stripe,
+				   struct btrfs_bio *bbio,
+				   bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	u32 bio_len = bbio->bio.bi_iter.bi_size;
+	u32 bio_off = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
+		stripe->logical;
+
+	fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
+	atomic_inc(&stripe->pending_io);
+	btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
+
+	/* For zoned writeback, queue depth must be 1. */
+	if (!btrfs_is_zoned(fs_info))
+		return;
+
+	/*
+	 * If the write finished without error, forward the write pointer.
+	 */
+	wait_scrub_stripe_io(stripe);
+	if (!test_bit(bio_off >> fs_info->sectorsize_bits,
+		      &stripe->write_error_bitmap))
+		sctx->write_pointer += bio_len;
+}
+
 /*
  * Submit the write bio(s) for the sectors specified by @write_bitmap.
  *
@@ -1120,7 +1147,6 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	const bool zoned = btrfs_is_zoned(fs_info);
 	int sector_nr;
 
 	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
@@ -1133,25 +1159,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 
 		/* Cannot merge with previous sector, submit the current one. */
 		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
-			u32 bio_len = bbio->bio.bi_iter.bi_size;
-			u32 bio_off = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
-				      stripe->logical;
-
-			fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
-			atomic_inc(&stripe->pending_io);
-			btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
-			/* For zoned writeback, queue depth must be 1. */
-			if (zoned) {
-				wait_scrub_stripe_io(stripe);
-
-				/*
-				 * Write finished without error, forward the
-				 * write pointer.
-				 */
-				if (!test_bit(bio_off >> fs_info->sectorsize_bits,
-					     &stripe->write_error_bitmap))
-					sctx->write_pointer += bio_len;
-			}
+			btrfs_submit_scrub_bio(sctx, stripe, bbio, dev_replace);
 			bbio = NULL;
 		}
 		if (!bbio) {
@@ -1164,26 +1172,9 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
 		ASSERT(ret == fs_info->sectorsize);
 	}
-	if (bbio) {
-		u32 bio_len = bbio->bio.bi_iter.bi_size;
-		u32 bio_off = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
-			      stripe->logical;
 
-		fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
-		atomic_inc(&stripe->pending_io);
-		btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
-		if (zoned) {
-			wait_scrub_stripe_io(stripe);
-
-			/*
-			 * Write finished without error, forward the
-			 * write pointer.
-			 */
-			if (!test_bit(bio_off >> fs_info->sectorsize_bits,
-				     &stripe->write_error_bitmap))
-				sctx->write_pointer += bio_len;
-		}
-	}
+	if (bbio)
+		btrfs_submit_scrub_bio(sctx, stripe, bbio, dev_replace);
 }
 
 /*
