Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5D46CD2AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC2HKQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjC2HKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054202D5E
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99D1A21A20
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBpApp6DH2psjFgqsJ861qO0zObmglyOuuVSpfIWMWY=;
        b=ZPQRxBivpP0hyQUmP80pcEBFotB26CBgADIpfUxENDeGUnzYsUevG231KxEXJguqxXl+zf
        DJRvpWzMqVvXLpZn1h8U8z0xzZowb333mB164fAs6C34yJEc2Vhy8eWW17IJJLTxg1sQNC
        IxCeSr1WYueg+q27TWgBkFVG+oV7o+8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05D8E138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SM6AMVDkI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: scrub: use scrub_stripe to implement RAID56 P/Q scrub
Date:   Wed, 29 Mar 2023 15:09:45 +0800
Message-Id: <c8d40d3e3f87265674b669503ba6c97ad28f7e21.1680073696.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680073696.git.wqu@suse.com>
References: <cover.1680073696.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch would implement the only missing part for scrub: RAID56 P/Q
stripe scrub.

The workflow is pretty straightforward for the new function,
scrub_raid56_parity_stripe():

- Go through the regular scrub path for each data stripe

- Wait for the verification and repair to finish

- Writeback the repaired sectors to data stripes

- Make sure all stripes are properly repaired
  If we have sectors unrepaired, we can not continue, or we may
  further corrupt the P/Q stripe.

- Submit the rbio for P/Q stripe
  The dev-replace would be handled inside
  raid56_parity_submit_scrub_rbio() path.

- Wait for the above bio to finish

Although the old code is no longer used, we still keep the declaration,
as the cleanup can be several times larger than this patch itself.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 217 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/scrub.h |   5 ++
 2 files changed, 212 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 42e18cc905b8..c340fd51aa65 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -99,6 +99,13 @@ enum scrub_stripe_flags {
 
 	/* Set when the read-repair is finished. */
 	SCRUB_STRIPE_FLAG_REPAIR_DONE,
+
+	/*
+	 * Set for data stripes if it's triggered from P/Q stripe.
+	 * During such scrub, we should not report error in data stripes, nor
+	 * update the accounting.
+	 */
+	SCRUB_STRIPE_FLAG_NO_REPORT,
 };
 
 #define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
@@ -279,6 +286,7 @@ struct scrub_parity {
 struct scrub_ctx {
 	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
 	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
+	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
 	int			first_free;
 	int			curr;
@@ -2509,6 +2517,9 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	int nr_repaired_sectors = 0;
 	int sector_nr;
 
+	if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
+		return;
+
 	/*
 	 * Init needed infos for error reporting.
 	 *
@@ -3823,11 +3834,9 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 	return ret;
 }
 
-static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
-						  struct map_lookup *map,
-						  struct btrfs_device *sdev,
-						  u64 logic_start,
-						  u64 logic_end)
+int scrub_raid56_parity(struct scrub_ctx *sctx, struct map_lookup *map,
+			struct btrfs_device *sdev, u64 logic_start,
+			u64 logic_end)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_path *path;
@@ -4200,6 +4209,11 @@ static void flush_scrub_stripes(struct scrub_ctx *sctx)
 	sctx->cur_stripe = 0;
 }
 
+static void raid56_scrub_wait_endio(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
 static int queue_scrub_stripe(struct scrub_ctx *sctx,
 			      struct btrfs_block_group *bg,
 			      struct btrfs_device *dev, int mirror_num,
@@ -4225,6 +4239,167 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx,
 	return 0;
 }
 
+static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
+				      struct btrfs_device *scrub_dev,
+				      struct btrfs_block_group *bg,
+				      struct map_lookup *map,
+				      u64 full_stripe_start)
+{
+	DECLARE_COMPLETION_ONSTACK(io_done);
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_raid_bio *rbio;
+	struct btrfs_io_context *bioc = NULL;
+	struct bio *bio;
+	struct scrub_stripe *stripe;
+	bool all_empty = true;
+	const int data_stripes = nr_data_stripes(map);
+	unsigned long extent_bitmap = 0;
+	u64 length = data_stripes << BTRFS_STRIPE_LEN_SHIFT;
+	int ret;
+
+	ASSERT(sctx->raid56_data_stripes);
+
+	for (int i = 0; i < data_stripes; i++) {
+		int stripe_index;
+		int rot;
+		u64 physical;
+
+		stripe = &sctx->raid56_data_stripes[i];
+		rot = div_u64(full_stripe_start - bg->start, data_stripes) >>
+			BTRFS_STRIPE_LEN_SHIFT;
+		stripe_index = (i + rot) % map->num_stripes;
+		physical = map->stripes[stripe_index].physical +
+			   (rot << BTRFS_STRIPE_LEN_SHIFT);
+
+		scrub_reset_stripe(stripe);
+		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
+		ret = scrub_find_fill_first_stripe(bg,
+				map->stripes[stripe_index].dev, physical, 1,
+				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT),
+				BTRFS_STRIPE_LEN, stripe);
+		if (ret < 0)
+			goto out;
+		/*
+		 * No extent in this data stripe, need to manually mark them
+		 * initialized to make later read submission happy.
+		 */
+		if (ret > 0) {
+			stripe->logical = full_stripe_start +
+					  (i << BTRFS_STRIPE_LEN_SHIFT);
+			stripe->dev = map->stripes[stripe_index].dev;
+			stripe->mirror_num = 1;
+			set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
+		}
+	}
+
+	/* Check if all data stripes are empty. */
+	for (int i = 0; i < data_stripes; i++) {
+		stripe = &sctx->raid56_data_stripes[i];
+		if (!bitmap_empty(&stripe->extent_sector_bitmap,
+				  stripe->nr_sectors)) {
+			all_empty = false;
+			break;
+		}
+	}
+	if (all_empty) {
+		ret = 0;
+		goto out;
+	}
+
+	for (int i = 0; i < data_stripes; i++) {
+		stripe = &sctx->raid56_data_stripes[i];
+		scrub_submit_initial_read(sctx, stripe);
+	}
+	for (int i = 0; i < data_stripes; i++) {
+		stripe = &sctx->raid56_data_stripes[i];
+
+		wait_event(stripe->repair_wait,
+			   test_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE,
+				    &stripe->state));
+	}
+	/* For now, no zoned support for RAID56. */
+	ASSERT(!btrfs_is_zoned(sctx->fs_info));
+
+	/* Writeback for the repaired sectors. */
+	for (int i = 0; i < data_stripes; i++) {
+		unsigned long repaired;
+
+		stripe = &sctx->raid56_data_stripes[i];
+
+		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
+			      &stripe->error_bitmap, stripe->nr_sectors);
+		scrub_write_sectors(sctx, stripe, repaired, false);
+	}
+
+	/* Wait for above writebacks to finish. */
+	for (int i = 0; i < data_stripes; i++) {
+		stripe = &sctx->raid56_data_stripes[i];
+
+		wait_scrub_stripe_io(stripe);
+	}
+
+	/*
+	 * Now all data stripes are properly verify. Check if we have any
+	 * unrepaired, if so abort immediate or we can further corrupt the
+	 * P/Q stripes.
+	 *
+	 * During the loop, also populate extent_bitmap.
+	 */
+	for (int i = 0; i < data_stripes; i++) {
+		unsigned long error;
+
+		stripe = &sctx->raid56_data_stripes[i];
+
+		/*
+		 * We should only check the errors where there is an extent.
+		 * As we may hit an empty data stripe while it's missing.
+		 */
+		bitmap_and(&error, &stripe->error_bitmap,
+			   &stripe->extent_sector_bitmap, stripe->nr_sectors);
+		if (!bitmap_empty(&error, stripe->nr_sectors)) {
+			btrfs_err(fs_info,
+"unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
+				  full_stripe_start, i, stripe->nr_sectors,
+				  &error); 
+			ret = -EIO;
+			goto out;
+		}
+		bitmap_or(&extent_bitmap, &extent_bitmap,
+			  &stripe->extent_sector_bitmap, stripe->nr_sectors);
+	}
+
+	/* Now we can check and regenerate the P/Q stripe. */
+	bio = bio_alloc(NULL, 1, REQ_OP_READ, GFP_NOFS);
+	bio->bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
+	bio->bi_private = &io_done;
+	bio->bi_end_io = raid56_scrub_wait_endio;
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
+			       &length, &bioc);
+	if (ret < 0) {
+		btrfs_put_bioc(bioc);
+		btrfs_bio_counter_dec(fs_info);
+		goto out;
+	}
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap,
+			BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
+	btrfs_put_bioc(bioc);
+	if (!rbio) {
+		ret = -ENOMEM;
+		btrfs_bio_counter_dec(fs_info);
+		goto out;
+	}
+	raid56_parity_submit_scrub_rbio(rbio);
+	wait_for_completion_io(&io_done);
+	ret = blk_status_to_errno(bio->bi_status);
+	bio_put(bio);
+	btrfs_bio_counter_dec(fs_info);
+
+out:
+	return ret;
+}
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
@@ -4398,7 +4573,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	/* Offset inside the chunk */
 	u64 offset;
 	u64 stripe_logical;
-	u64 stripe_end;
 	int stop_loop = 0;
 
 	wait_event(sctx->list_wait,
@@ -4413,6 +4587,25 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		sctx->flush_all_writes = true;
 	}
 
+	/* Prepare the extra data stripes used by RAID56. */
+	if (profile & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		ASSERT(sctx->raid56_data_stripes == NULL);
+
+		sctx->raid56_data_stripes = kcalloc(nr_data_stripes(map),
+				sizeof(struct scrub_stripe), GFP_KERNEL);
+		if (!sctx->raid56_data_stripes) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		for (int i = 0; i < nr_data_stripes(map); i++) {
+			ret = init_scrub_stripe(fs_info,
+					&sctx->raid56_data_stripes[i]);
+			if (ret < 0)
+				goto out;
+			sctx->raid56_data_stripes[i].bg = bg;
+			sctx->raid56_data_stripes[i].sctx = sctx;
+		}
+	}
 	/*
 	 * There used to be a big double loop to handle all profiles using the
 	 * same routine, which grows larger and more gross over time.
@@ -4466,10 +4659,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		if (ret) {
 			/* it is parity strip */
 			stripe_logical += chunk_logical;
-			stripe_end = stripe_logical + increment;
-			ret = scrub_raid56_parity(sctx, map, scrub_dev,
-						  stripe_logical,
-						  stripe_end);
+			ret = scrub_raid56_parity_stripe(sctx, scrub_dev, bg,
+							 map, stripe_logical);
 			if (ret)
 				goto out;
 			goto next;
@@ -4507,6 +4698,12 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 	flush_scrub_stripes(sctx);
+	if (sctx->raid56_data_stripes) {
+		for (int i = 0; i < nr_data_stripes(map); i++)
+			release_scrub_stripe(&sctx->raid56_data_stripes[i]);
+		kfree(sctx->raid56_data_stripes);
+		sctx->raid56_data_stripes = NULL;
+	}
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7639103ebf9d..6c17668dfad9 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,4 +13,9 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
+/* Temporary declaration, would be deleted later. */
+int scrub_raid56_parity(struct scrub_ctx *sctx, struct map_lookup *map,
+			struct btrfs_device *sdev, u64 logic_start,
+			u64 logic_end);
+
 #endif
-- 
2.39.2

