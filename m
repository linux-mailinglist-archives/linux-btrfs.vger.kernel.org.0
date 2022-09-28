Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98105ED7F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiI1IgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI1IgR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E199AF8D
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 667E121DB4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eq2pZcQKAb3W8VSJULoNfGJsNa6E6z/p1TmbSeyBgV8=;
        b=Y490EjolFb1af2QtIXns2a02plnRyQta5HiGobt+agJ8h5Q9pztTg9scg5g65jaarVvMBK
        KWvD9d7eZHNOGZSWiODBxHxlH+fcyz0N3yrtc4LS4+aZY17rX0Tf3g9KOeDjG2bxCkLyPa
        ut4GByKw7bOX8eh32bF55hRmCRD4nVc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5499213A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +I0EB3wHNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 06/10] btrfs: scrub: submit and wait for the read of each copy
Date:   Wed, 28 Sep 2022 16:35:43 +0800
Message-Id: <2cedd7b23cb4e38c84233fff298f6e065f596591.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduce a helper, scrub_fs_one_stripe().

Currently it's only doing the following work:

- Submit bios for each copy of 64K stripe
  We don't need to skip any range which doesn't have data/metadata.
  That would only eat up the IOPS performance of the disk.

  At per-stripe initialization time we have marked all sectors unused,
  until extent tree search time marks the needed sectors DATA/METADATA.

  So at verification time we can skip those unused sectors.

- Wait for the bios to finish

No csum verification yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 218 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f04d2e552666..cb0973e7ffd2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -203,6 +203,11 @@ struct scrub_ctx {
 #define SCRUB_FS_SECTOR_FLAG_META		(1 << 2)
 #define SCRUB_FS_SECTOR_FLAG_PARITY		(1 << 3)
 
+/* This marks if the sector belongs to a missing device. */
+#define SCRUB_FS_SECTOR_FLAG_DEV_MISSING	(1 << 4)
+#define SCRUB_FS_SECTOR_FLAG_IO_ERROR		(1 << 5)
+#define SCRUB_FS_SECTOR_FLAG_IO_DONE		(1 << 6)
+
 /*
  * Represent a sector.
  *
@@ -237,6 +242,14 @@ struct scrub_fs_sector {
 	};
 };
 
+/* Endio ctrl for each device. */
+struct scrub_fs_endio_ctrl {
+	struct scrub_fs_ctx		*sfctx;
+
+	/* To locate the real sectors of the stripe. */
+	int				mirror_nr;
+};
+
 /* This structure should only has a lifespan inside btrfs_scrub_fs(). */
 struct scrub_fs_ctx {
 	struct btrfs_fs_info		*fs_info;
@@ -286,6 +299,9 @@ struct scrub_fs_ctx {
 	 */
 	int				total_sectors;
 
+	/* Endio control for all read operations. */
+	struct scrub_fs_endio_ctrl	*endio_ctrls;
+
 	/* Page array for above total_sectors. */
 	struct page			**pages;
 
@@ -304,6 +320,8 @@ struct scrub_fs_ctx {
 	 * would point to the same location inside the buffer.
 	 */
 	u8				*csum_buf;
+
+	wait_queue_head_t		wait;
 };
 
 struct scrub_warning {
@@ -4565,6 +4583,7 @@ static struct scrub_fs_ctx *scrub_fs_alloc_ctx(struct btrfs_fs_info *fs_info,
 	sfctx->fs_info = fs_info;
 	sfctx->readonly = readonly;
 	atomic_set(&sfctx->bios_under_io, 0);
+	init_waitqueue_head(&sfctx->wait);
 	return sfctx;
 error:
 	kfree(sfctx);
@@ -4580,6 +4599,9 @@ static void scrub_fs_cleanup_for_bg(struct scrub_fs_ctx *sfctx)
 	int i;
 	const int nr_pages = sfctx->nr_copies * (BTRFS_STRIPE_LEN >> PAGE_SHIFT);
 
+	kfree(sfctx->endio_ctrls);
+	sfctx->endio_ctrls = NULL;
+
 	if (sfctx->pages) {
 		for (i = 0; i < nr_pages; i++) {
 			if (sfctx->pages[i]) {
@@ -4624,6 +4646,7 @@ static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
 	ASSERT(!sfctx->pages);
 	ASSERT(!sfctx->sectors);
 	ASSERT(!sfctx->csum_buf);
+	ASSERT(!sfctx->endio_ctrls);
 
 	read_lock(&map_tree->lock);
 	em = lookup_extent_mapping(map_tree, bg->start, bg->length);
@@ -4657,6 +4680,16 @@ static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
 
 	nr_pages = (BTRFS_STRIPE_LEN >> PAGE_SHIFT) * sfctx->nr_copies;
 
+	sfctx->endio_ctrls = kcalloc(sfctx->nr_copies,
+			sizeof(struct scrub_fs_endio_ctrl), GFP_KERNEL);
+	if (!sfctx->endio_ctrls)
+		goto enomem;
+
+	for (i = 0; i < sfctx->nr_copies; i++) {
+		sfctx->endio_ctrls[i].sfctx = sfctx;
+		sfctx->endio_ctrls[i].mirror_nr = i;
+	}
+
 	sfctx->pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!sfctx->pages)
 		goto enomem;
@@ -4942,6 +4975,188 @@ static void scrub_fs_reset_stripe(struct scrub_fs_ctx *sfctx)
 	}
 }
 
+static void mark_missing_dev_sectors(struct scrub_fs_ctx *sfctx,
+				     int stripe_nr)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	const int sectors_per_stripe = BTRFS_STRIPE_LEN >>
+				       fs_info->sectorsize_bits;
+	int i;
+
+	for (i = 0; i < sectors_per_stripe; i++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, i, stripe_nr);
+
+		sector->flags |= SCRUB_FS_SECTOR_FLAG_DEV_MISSING;
+	}
+}
+
+static struct page *scrub_fs_get_page(struct scrub_fs_ctx *sfctx,
+				      int sector_nr, int mirror_nr)
+{
+	int page_index;
+
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, mirror_nr);
+
+	page_index = (sector_nr + mirror_nr * sfctx->sectors_per_stripe) /
+		     (PAGE_SIZE >> sfctx->fs_info->sectorsize_bits);
+
+	ASSERT(sfctx->pages[page_index]);
+	return sfctx->pages[page_index];
+}
+
+static unsigned int scrub_fs_get_page_offset(struct scrub_fs_ctx *sfctx,
+					     int sector_nr, int mirror_nr)
+{
+	int index;
+
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, mirror_nr);
+	index = sector_nr + mirror_nr * sfctx->sectors_per_stripe;
+
+	return offset_in_page(index << sfctx->fs_info->sectorsize_bits);
+}
+
+static void scrub_fs_read_endio(struct bio *bio)
+{
+	struct scrub_fs_endio_ctrl *endio_ctrl = bio->bi_private;
+	struct scrub_fs_ctx *sfctx = endio_ctrl->sfctx;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	int bio_size = 0;
+	bool error = (bio->bi_status != BLK_STS_OK);
+	const int mirror_nr = endio_ctrl->mirror_nr;
+	int i;
+
+	/* Grab the bio size for later sanity checks. */
+	bio_for_each_segment_all(bvec, bio, iter_all)
+		bio_size += bvec->bv_len;
+
+	/* We always submit a bio for a stripe length. */
+	ASSERT(bio_size == BTRFS_STRIPE_LEN);
+
+	for (i = 0; i < sfctx->sectors_per_stripe; i++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, i, mirror_nr);
+
+		/*
+		 * Here we only set the sector flags, don't do any stat update,
+		 * that will be done by the main thread when doing verification.
+		 */
+		if (error) {
+			sector->flags |= SCRUB_FS_SECTOR_FLAG_IO_ERROR;
+			continue;
+		}
+		sector->flags |= SCRUB_FS_SECTOR_FLAG_IO_DONE;
+	}
+	atomic_dec(&sfctx->bios_under_io);
+	wake_up(&sfctx->wait);
+	bio_put(bio);
+}
+
+static void submit_stripe_read_bio(struct scrub_fs_ctx *sfctx,
+				   struct btrfs_io_context *bioc,
+				   int mirror_nr)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct btrfs_io_stripe *stripe = &bioc->stripes[mirror_nr];
+	struct btrfs_device *dev = stripe->dev;
+	struct bio *bio;
+	int ret;
+	int i;
+
+	/*
+	 * Missing device, just mark the sectors with missing device
+	 * and continue to next copy.
+	 */
+	if (!dev || !dev->bdev) {
+		mark_missing_dev_sectors(sfctx, mirror_nr);
+		return;
+	}
+
+	/* Submit a bio to read the stripe length. */
+	bio = bio_alloc(dev->bdev, BIO_MAX_VECS,
+			REQ_OP_READ | REQ_BACKGROUND, GFP_KERNEL);
+
+	/* Bio is backed up by mempool, allocation should not fail. */
+	ASSERT(bio);
+
+	bio->bi_iter.bi_sector = stripe->physical >> SECTOR_SHIFT;
+	for (i = 0; i < sfctx->sectors_per_stripe; i++) {
+		struct page *page = scrub_fs_get_page(sfctx, i, mirror_nr);
+		unsigned int page_off = scrub_fs_get_page_offset(sfctx, i,
+								 mirror_nr);
+
+		ret = bio_add_page(bio, page, fs_info->sectorsize, page_off);
+
+		/*
+		 * Should not fail as we will at most add STRIPE_LEN / 4K
+		 * (aka, 16) sectors, way smaller than BIO_MAX_VECS.
+		 */
+		ASSERT(ret == fs_info->sectorsize);
+	}
+
+	bio->bi_private = &sfctx->endio_ctrls[mirror_nr];
+	bio->bi_end_io = scrub_fs_read_endio;
+	atomic_inc(&sfctx->bios_under_io);
+	submit_bio(bio);
+}
+
+static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct btrfs_io_context *bioc = NULL;
+	u64 mapped_len = BTRFS_STRIPE_LEN;
+	int i;
+	int ret;
+
+	/* We should at a stripe start inside current block group. */
+	ASSERT(sfctx->cur_bg->start <= sfctx->cur_logical &&
+	       sfctx->cur_logical < sfctx->cur_bg->start +
+				    sfctx->cur_bg->length);
+	ASSERT(IS_ALIGNED(sfctx->cur_logical - sfctx->cur_bg->start,
+			  BTRFS_STRIPE_LEN));
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
+			sfctx->cur_logical, &mapped_len, &bioc);
+	if (ret < 0)
+		goto out;
+
+	if (mapped_len < BTRFS_STRIPE_LEN) {
+		btrfs_err_rl(fs_info,
+	"get short map for bytenr %llu, got mapped length %llu expect %u",
+			     sfctx->cur_logical, mapped_len, BTRFS_STRIPE_LEN);
+		ret = -EUCLEAN;
+		sfctx->stat.nr_fatal_errors++;
+		goto out;
+	}
+
+	if (bioc->num_stripes != sfctx->nr_copies) {
+		btrfs_err_rl(fs_info,
+		"got unexpected number of stripes, got %d stripes expect %d",
+			     bioc->num_stripes, sfctx->nr_copies);
+		ret = -EUCLEAN;
+		sfctx->stat.nr_fatal_errors++;
+		goto out;
+	}
+
+	for (i = 0; i < sfctx->nr_copies; i++)
+		submit_stripe_read_bio(sfctx, bioc, i);
+	wait_event(sfctx->wait, atomic_read(&sfctx->bios_under_io) == 0);
+
+	/*
+	 * Place holder to update the accounting.
+	 *
+	 * Endio functions should have done the verification and updated
+	 * sector->flags, but they don't update the accounting as they
+	 * don't have the full view of other mirrors.
+	 */
+out:
+	btrfs_put_bioc(bioc);
+	btrfs_bio_counter_dec(fs_info);
+	return ret;
+}
+
 static int scrub_fs_block_group(struct scrub_fs_ctx *sfctx,
 				struct btrfs_block_group *bg)
 {
@@ -4988,8 +5203,9 @@ static int scrub_fs_block_group(struct scrub_fs_ctx *sfctx,
 				break;
 		}
 
-		/* Place holder for real stripe scrubbing. */
-		ret = 0;
+		ret = scrub_fs_one_stripe(sfctx);
+		if (ret < 0)
+			break;
 
 		/* Reset the stripe for next run. */
 		scrub_fs_reset_stripe(sfctx);
-- 
2.37.3

