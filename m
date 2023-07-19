Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3163758D21
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 07:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGSFa5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 01:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSFa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 01:30:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1920119
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 22:30:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ADEBC21902
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689744650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/Wmzk7iRx28jnqFxlxIhjkcUFkWY8FTU/g0s+t8rX8=;
        b=H4cOltqv7zL5HUnkptz29TVOwXTzg+i6gyNR0j969l8JEtV7LQPuV1ge0Z7oonc7LWLVEn
        ivijmbIozwHBwvWx7pWQa4HC0wCmpDfXf7Lx/3+4j4BNwn3+Xs8W+t+bhxBOezeOBDXiWi
        uzIQf5GBuJscXRqmp4vEQMkCTqc8Mj4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AF9D138EE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AFGCMQl1t2R7JQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/4] btrfs: scrub: use btrfs workqueue to synchronize the write back for dev-replace
Date:   Wed, 19 Jul 2023 13:30:25 +0800
Message-ID: <010815c1c06275ab502647d6863514508a6c4f01.1689744163.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689744163.git.wqu@suse.com>
References: <cover.1689744163.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we submit the last group of stripes and wait for all stripes
in flush_scrub_stripes(), then submit writes for dev-replace.

This design is mostly to make sure the writeback for dev-replace target
is correct for zoned devices.

As for zone devices, we have to ensure not only all writes are properly
submitted and waited (queue depth = 1), but also all writes must be in
their bytenr order.

On the other hand, the repair-from-other-mirrors part can happen in any
order, thus we can not simply let the dev-replace writeback happen in
the scrub_stripe_read_repair_worker().

That's why we go the wait for all stripes in flush_scrub_stripes(), then
submit writes for dev-replace in a dedicated loop.

This patch would enhance the situation by utilizing btrfs_workqueue, as
it provides an ordered execution part for the dev-replace writeback,
while the async part can be utilized for read-repair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h    |   2 +-
 fs/btrfs/scrub.c | 193 ++++++++++++++++++++++++-----------------------
 2 files changed, 100 insertions(+), 95 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..670f114e8bca 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -642,7 +642,7 @@ struct btrfs_fs_info {
 	 * running.
 	 */
 	refcount_t scrub_workers_refcnt;
-	struct workqueue_struct *scrub_workers;
+	struct btrfs_workqueue *scrub_workers;
 	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9cb1106bdc11..784fbe2341d4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -97,10 +97,16 @@ enum scrub_stripe_flags {
 
 	/*
 	 * Set for data stripes if it's triggered from P/Q stripe.
-	 * During such scrub, we should not report errors in data stripes, nor
-	 * update the accounting.
+	 * This flag prevents us from doing the following work:
+	 * - Writeback for dev-replace
+	 *   Since we're doing P/Q scrub, it's we just need the data stripe
+	 *   contents, should not do dev-replace for them.
+	 *
+	 * - No csum error report
+	 * - No reset
+	 *   Keep the contents and bitmaps, but cleanup the state.
 	 */
-	SCRUB_STRIPE_FLAG_NO_REPORT,
+	SCRUB_STRIPE_FLAG_DATA_STRIPES_FOR_PQ,
 };
 
 #define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
@@ -182,7 +188,7 @@ struct scrub_stripe {
 	 */
 	u8 *csums;
 
-	struct work_struct work;
+	struct btrfs_work work;
 };
 
 struct scrub_ctx {
@@ -199,6 +205,8 @@ struct scrub_ctx {
 	ktime_t			throttle_deadline;
 	u64			throttle_sent;
 
+	/* Should abort the dev-replace. Set when we have metadata errors. */
+	bool			replace_abort;
 	int			is_dev_replace;
 	u64			write_pointer;
 
@@ -871,7 +879,7 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	int nr_repaired_sectors = 0;
 	int sector_nr;
 
-	if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
+	if (test_bit(SCRUB_STRIPE_FLAG_DATA_STRIPES_FOR_PQ, &stripe->state))
 		return;
 
 	/*
@@ -1099,7 +1107,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
  * synchronization to ensure they all happen in correct order (for zoned
  * devices).
  */
-static void scrub_stripe_read_repair_worker(struct work_struct *work)
+static void scrub_stripe_read_repair_worker(struct btrfs_work *work)
 {
 	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
 	struct scrub_ctx *sctx = stripe->sctx;
@@ -1202,11 +1210,8 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 		bitmap_clear(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
 	}
 	bio_put(&bbio->bio);
-	if (atomic_dec_and_test(&stripe->pending_io)) {
+	if (atomic_dec_and_test(&stripe->pending_io))
 		wake_up(&stripe->io_wait);
-		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
-		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
-	}
 }
 
 /*
@@ -1629,6 +1634,65 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	}
 }
 
+static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
+{
+	int i;
+
+	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_sectors) {
+		if (stripe->sectors[i].is_metadata) {
+			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+
+			btrfs_err(fs_info,
+			"stripe %llu has unrepaired metadata sector at %llu",
+				  stripe->logical,
+				  stripe->logical + (i << fs_info->sectorsize_bits));
+			return true;
+		}
+	}
+	return false;
+}
+
+static void scrub_stripe_writeback_worker(struct btrfs_work *work)
+{
+	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
+	struct scrub_ctx *sctx = stripe->sctx;
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+
+	if (sctx->is_dev_replace &&
+	    !test_bit(SCRUB_STRIPE_FLAG_DATA_STRIPES_FOR_PQ, &stripe->state)) {
+		unsigned long good;
+
+		/*
+		 * For dev-replace, if we know there is something wrong with
+		 * metadata, we should immedately abort.
+		 */
+		if (stripe_has_metadata_error(stripe)) {
+			btrfs_err_rl(fs_info,
+	"stripe logical %llu has metadata error, can not continue dev-replace",
+				     stripe->logical);
+			sctx->replace_abort = true;
+			return;
+		}
+		ASSERT(stripe->dev == fs_info->dev_replace.srcdev);
+
+		bitmap_andnot(&good, &stripe->extent_sector_bitmap,
+			      &stripe->error_bitmap, stripe->nr_sectors);
+		scrub_write_sectors(sctx, stripe, good, true);
+	}
+	wait_scrub_stripe_io(stripe);
+}
+
+static void scrub_stripe_release_worker(struct btrfs_work *work)
+{
+	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
+
+	if (!test_bit(SCRUB_STRIPE_FLAG_DATA_STRIPES_FOR_PQ, &stripe->state))
+		scrub_reset_stripe(stripe);
+	else
+		stripe->state = 0;
+	wake_up(&stripe->repair_wait);
+}
+
 static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 				      struct scrub_stripe *stripe)
 {
@@ -1636,13 +1700,17 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	struct btrfs_bio *bbio;
 	int mirror = stripe->mirror_num;
 
-	ASSERT(stripe->bg);
-	ASSERT(stripe->mirror_num > 0);
-	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
+	/* Not yet initialized. */
+	if (!test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state))
+		return;
 
 	if (test_and_set_bit(SCRUB_STRIPE_FLAG_READ_SUBMITTED, &stripe->state))
 		return;
 
+	ASSERT(stripe->bg);
+	ASSERT(stripe->mirror_num > 0);
+	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
+
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 
@@ -1671,91 +1739,43 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 		mirror = calc_next_mirror(mirror, num_copies);
 	}
 	btrfs_submit_bio(bbio, mirror);
-}
-
-static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
-{
-	int i;
-
-	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_sectors) {
-		if (stripe->sectors[i].is_metadata) {
-			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-
-			btrfs_err(fs_info,
-			"stripe %llu has unrepaired metadata sector at %llu",
-				  stripe->logical,
-				  stripe->logical + (i << fs_info->sectorsize_bits));
-			return true;
-		}
-	}
-	return false;
+	btrfs_init_work(&stripe->work, scrub_stripe_read_repair_worker,
+				scrub_stripe_writeback_worker,
+				scrub_stripe_release_worker);
+	btrfs_queue_work(fs_info->scrub_workers, &stripe->work);
 }
 
 static int flush_scrub_stripes(struct scrub_ctx *sctx)
 {
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct scrub_stripe *stripe;
 	const int nr_stripes = sctx->cur_stripe;
+	const int first_stripe = round_down(nr_stripes - 1, SCRUB_STRIPES_PER_GROUP);
 	struct blk_plug plug;
 	int ret = 0;
 
 	if (!nr_stripes)
 		return 0;
 
-	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
-
 	/* We should only have at most one group to submit. */
 	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
 			      btrfs_stripe_nr_to_offset(
 				      nr_stripes % SCRUB_STRIPES_PER_GROUP ?:
 				      SCRUB_STRIPES_PER_GROUP));
 	blk_start_plug(&plug);
-	for (int i = 0; i < nr_stripes; i++) {
+	for (int i = first_stripe; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
+
 		scrub_submit_initial_read(sctx, stripe);
 	}
 	blk_finish_plug(&plug);
 
+	/* Wait for all stripes to finish. */
 	for (int i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
 
-		wait_event(stripe->repair_wait,
-			   test_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state));
+		wait_event(stripe->repair_wait, stripe->state == 0);
 	}
 
-	/* Submit for dev-replace. */
-	if (sctx->is_dev_replace) {
-		/*
-		 * For dev-replace, if we know there is something wrong with
-		 * metadata, we should immedately abort.
-		 */
-		for (int i = 0; i < nr_stripes; i++) {
-			if (stripe_has_metadata_error(&sctx->stripes[i])) {
-				ret = -EIO;
-				goto out;
-			}
-		}
-		for (int i = 0; i < nr_stripes; i++) {
-			unsigned long good;
-
-			stripe = &sctx->stripes[i];
-
-			ASSERT(stripe->dev == fs_info->dev_replace.srcdev);
-
-			bitmap_andnot(&good, &stripe->extent_sector_bitmap,
-				      &stripe->error_bitmap, stripe->nr_sectors);
-			scrub_write_sectors(sctx, stripe, good, true);
-		}
-	}
-
-	/* Wait for the above writebacks to finish. */
-	for (int i = 0; i < nr_stripes; i++) {
-		stripe = &sctx->stripes[i];
-
-		wait_scrub_stripe_io(stripe);
-		scrub_reset_stripe(stripe);
-	}
-out:
 	sctx->cur_stripe = 0;
 	return ret;
 }
@@ -1844,7 +1864,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 			   btrfs_stripe_nr_to_offset(rot);
 
 		scrub_reset_stripe(stripe);
-		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
+		set_bit(SCRUB_STRIPE_FLAG_DATA_STRIPES_FOR_PQ, &stripe->state);
 		ret = scrub_find_fill_first_stripe(bg,
 				map->stripes[stripe_index].dev, physical, 1,
 				full_stripe_start + btrfs_stripe_nr_to_offset(i),
@@ -1877,35 +1897,19 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		goto out;
 	}
 
-	for (int i = 0; i < data_stripes; i++) {
-		stripe = &sctx->raid56_data_stripes[i];
-		scrub_submit_initial_read(sctx, stripe);
-	}
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
 
-		wait_event(stripe->repair_wait,
-			   test_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state));
+		scrub_submit_initial_read(sctx, stripe);
 	}
 	/* For now, no zoned support for RAID56. */
 	ASSERT(!btrfs_is_zoned(sctx->fs_info));
 
-	/* Writeback for the repaired sectors. */
-	for (int i = 0; i < data_stripes; i++) {
-		unsigned long repaired;
-
-		stripe = &sctx->raid56_data_stripes[i];
-
-		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
-			      &stripe->error_bitmap, stripe->nr_sectors);
-		scrub_write_sectors(sctx, stripe, repaired, false);
-	}
-
 	/* Wait for the above writebacks to finish. */
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
 
-		wait_scrub_stripe_io(stripe);
+		wait_event(stripe->repair_wait, stripe->state == 0);
 	}
 
 	/*
@@ -2728,13 +2732,13 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 {
 	if (refcount_dec_and_mutex_lock(&fs_info->scrub_workers_refcnt,
 					&fs_info->scrub_lock)) {
-		struct workqueue_struct *scrub_workers = fs_info->scrub_workers;
+		struct btrfs_workqueue *scrub_workers = fs_info->scrub_workers;
 
 		fs_info->scrub_workers = NULL;
 		mutex_unlock(&fs_info->scrub_lock);
 
 		if (scrub_workers)
-			destroy_workqueue(scrub_workers);
+			btrfs_destroy_workqueue(scrub_workers);
 	}
 }
 
@@ -2743,7 +2747,7 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
  */
 static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 {
-	struct workqueue_struct *scrub_workers = NULL;
+	struct btrfs_workqueue *scrub_workers = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
@@ -2751,7 +2755,8 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
 		return 0;
 
-	scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
+	scrub_workers = btrfs_alloc_workqueue(fs_info, "btrfs-scrub", flags,
+					      max_active, 0);
 	if (!scrub_workers)
 		return -ENOMEM;
 
@@ -2769,7 +2774,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 
 	ret = 0;
 
-	destroy_workqueue(scrub_workers);
+	btrfs_destroy_workqueue(scrub_workers);
 	return ret;
 }
 
-- 
2.41.0

