Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D161EC1E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiKGHc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 02:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiKGHc4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 02:32:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E21A1
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 23:32:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1760222652
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667806373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyNLmfx8oh/0bhH383U3ucjMJkvqtc2eFTI9KYyTDCs=;
        b=C0xZjmfYxNE7/2SeUaMmbVY/xwPu7TKgemn1EHW6MyovTM4aD3FlWZ5O+HXhHdvzZHx51/
        L7mYdMC/jjbIEXSmLeusbY3aJPu30QtrSLQ6IsM8c48N8zTYSaIz4pjJCwTTCj04+3ELHb
        bs8nJNPfe1ZyunArVBUZWJHsDMKBScw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59F7A13AC7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6MbuB6S0aGMmDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 07:32:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: raid56: remove the old error tracing system
Date:   Mon,  7 Nov 2022 15:32:31 +0800
Message-Id: <0719cf44589eadf7113aa65bd9342343f74b96fa.1667805755.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667805755.git.wqu@suse.com>
References: <cover.1667805755.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since all the recovery path has migrated to the new error bitmap based
system, we can remove the old stripe number based system.

This cleanup involves one behavior change:

- Rebuild rbio can no longer be merged
  Previously a rebuild rbio (caused by retry after data csum mismatch)
  can be merged, if the the error happens in the same stripe.

  But with the new error bitmap based solution, it's much harder to
  compare error bitmaps.

  So here we just don't merge rebuild rbio at all.
  This may introduce some performance impact at extreme corner cases,
  but I'm willing to take it.

Other than that, this patch will cleanup the following members:

- rbio::faila
- rbio::failb
  They will be replaced by per-veritical stripe check, which is more
  accurate.

- rbio::error
  It will be replace by per-vertical stripe error bitmap check.

- Allow get_rbio_vertical_errors() to accept NULL pointers for
  @faila and @failb
  Some call sites only want to check if we have errors beyond the
  tolerance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 235 +++++++++++-----------------------------------
 fs/btrfs/raid56.h |   8 --
 2 files changed, 55 insertions(+), 188 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 800213ab44a1..73dce024a25e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -66,8 +66,6 @@ struct sector_ptr {
 
 static void rmw_rbio_work(struct work_struct *work);
 static void rmw_rbio_work_locked(struct work_struct *work);
-static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
-static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
 
@@ -588,28 +586,10 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	if (last->operation == BTRFS_RBIO_PARITY_SCRUB)
 		return 0;
 
-	if (last->operation == BTRFS_RBIO_REBUILD_MISSING)
+	if (last->operation == BTRFS_RBIO_REBUILD_MISSING ||
+	    last->operation == BTRFS_RBIO_READ_REBUILD)
 		return 0;
 
-	if (last->operation == BTRFS_RBIO_READ_REBUILD) {
-		int fa = last->faila;
-		int fb = last->failb;
-		int cur_fa = cur->faila;
-		int cur_fb = cur->failb;
-
-		if (last->faila >= last->failb) {
-			fa = last->failb;
-			fb = last->faila;
-		}
-
-		if (cur->faila >= cur->failb) {
-			cur_fa = cur->failb;
-			cur_fb = cur->faila;
-		}
-
-		if (fa != cur_fa || fb != cur_fb)
-			return 0;
-	}
 	return 1;
 }
 
@@ -973,10 +953,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->real_stripes = real_stripes;
 	rbio->stripe_npages = stripe_npages;
 	rbio->stripe_nsectors = stripe_nsectors;
-	rbio->faila = -1;
-	rbio->failb = -1;
 	refcount_set(&rbio->refs, 1);
-	atomic_set(&rbio->error, 0);
 	atomic_set(&rbio->stripes_pending, 0);
 
 	ASSERT(btrfs_nr_parity_stripes(bioc->map_type));
@@ -1025,9 +1002,15 @@ static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
 	int stripe_nr;
 	int found_errors = 0;
 
-	ASSERT(faila && failb);
-	*faila = -1;
-	*failb = -1;
+	if (faila || failb) {
+		/*
+		 * Both @faila and @failb should be valid pointers if any of them is
+		 * specified.
+		 */
+		ASSERT(faila && failb);
+		*faila = -1;
+		*failb = -1;
+	}
 
 	for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
 		int total_sector_nr = stripe_nr * rbio->stripe_nsectors +
@@ -1035,10 +1018,13 @@ static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
 
 		if (test_bit(total_sector_nr, rbio->error_bitmap)) {
 			found_errors++;
-			if (*faila < 0)
-				*faila = stripe_nr;
-			else if (*failb < 0)
-				*failb = stripe_nr;
+			if (faila) {
+				/* Update faila and failb. */
+				if (*faila < 0)
+					*faila = stripe_nr;
+				else if (*failb < 0)
+					*failb = stripe_nr;
+			}
 		}
 	}
 	return found_errors;
@@ -1078,9 +1064,17 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 
 	/* if the device is missing, just fail this stripe */
 	if (!stripe->dev->bdev) {
+		int found_errors;
+
 		set_bit(stripe_nr * rbio->stripe_nsectors + sector_nr,
 			rbio->error_bitmap);
-		return fail_rbio_index(rbio, stripe_nr);
+
+		/* Check if we have reached tolerance early. */
+		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+							 NULL, NULL);
+		if (found_errors > rbio->bioc->max_errors)
+			return -EIO;
+		return 0;
 	}
 
 	/* see if we can add this page onto our existing bio */
@@ -1244,10 +1238,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	 * Reset errors, as we may have errors inherited from from degraded
 	 * write.
 	 */
-	atomic_set(&rbio->error, 0);
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
-	rbio->faila = -1;
-	rbio->failb = -1;
 
 	/*
 	 * Start assembly.  Make bios for everything from the higher layers (the
@@ -1325,50 +1316,6 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	return -EIO;
 }
 
-/*
- * helper to find the stripe number for a given bio.  Used to figure out which
- * stripe has failed.  This expects the bio to correspond to a physical disk,
- * so it looks up based on physical sector numbers.
- */
-static int find_bio_stripe(struct btrfs_raid_bio *rbio,
-			   struct bio *bio)
-{
-	u64 physical = bio->bi_iter.bi_sector;
-	int i;
-	struct btrfs_io_stripe *stripe;
-
-	physical <<= 9;
-
-	for (i = 0; i < rbio->bioc->num_stripes; i++) {
-		stripe = &rbio->bioc->stripes[i];
-		if (in_range(physical, stripe->physical, BTRFS_STRIPE_LEN) &&
-		    stripe->dev->bdev && bio->bi_bdev == stripe->dev->bdev) {
-			return i;
-		}
-	}
-	return -1;
-}
-
-/*
- * helper to find the stripe number for a given
- * bio (before mapping).  Used to figure out which stripe has
- * failed.  This looks up based on logical block numbers.
- */
-static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
-				   struct bio *bio)
-{
-	u64 logical = bio->bi_iter.bi_sector << 9;
-	int i;
-
-	for (i = 0; i < rbio->nr_data; i++) {
-		u64 stripe_start = rbio->bioc->raid_map[i];
-
-		if (in_range(logical, stripe_start, BTRFS_STRIPE_LEN))
-			return i;
-	}
-	return -1;
-}
-
 static void set_rbio_range_error(struct btrfs_raid_bio *rbio,
 				  struct bio *bio)
 {
@@ -1406,52 +1353,6 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio,
 	}
 }
 
-/*
- * returns -EIO if we had too many failures
- */
-static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&rbio->bio_list_lock, flags);
-
-	/* we already know this stripe is bad, move on */
-	if (rbio->faila == failed || rbio->failb == failed)
-		goto out;
-
-	if (rbio->faila == -1) {
-		/* first failure on this rbio */
-		rbio->faila = failed;
-		atomic_inc(&rbio->error);
-	} else if (rbio->failb == -1) {
-		/* second failure on this rbio */
-		rbio->failb = failed;
-		atomic_inc(&rbio->error);
-	} else {
-		ret = -EIO;
-	}
-out:
-	spin_unlock_irqrestore(&rbio->bio_list_lock, flags);
-
-	return ret;
-}
-
-/*
- * helper to fail a stripe based on a physical disk
- * bio.
- */
-static int fail_bio_stripe(struct btrfs_raid_bio *rbio,
-			   struct bio *bio)
-{
-	int failed = find_bio_stripe(rbio, bio);
-
-	if (failed < 0)
-		return -EIO;
-
-	return fail_rbio_index(rbio, failed);
-}
-
 /*
  * For subpage case, we can no longer set page Uptodate directly for
  * stripe_pages[], thus we need to locate the sector.
@@ -1537,10 +1438,9 @@ static void raid_wait_read_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 
-	if (bio->bi_status) {
-		fail_bio_stripe(rbio, bio);
+	if (bio->bi_status)
 		rbio_update_error_bitmap(rbio, bio);
-	} else
+	else
 		set_bio_pages_uptodate(rbio, bio);
 
 	bio_put(bio);
@@ -2027,12 +1927,6 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
 	bio_list_init(&bio_list);
 
-	/*
-	 * Reset error to 0, as we will later increase error for missing
-	 * devices.
-	 */
-	atomic_set(&rbio->error, 0);
-
 	/* For recovery, we need to read all sectors including P/Q. */
 	ret = alloc_rbio_pages(rbio);
 	if (ret < 0)
@@ -2151,30 +2045,13 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	set_rbio_range_error(rbio, bio);
 
-	rbio->faila = find_logical_bio_stripe(rbio, bio);
-	if (rbio->faila == -1) {
-		btrfs_warn(fs_info,
-"%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bioc has map_type %llu)",
-			   __func__, bio->bi_iter.bi_sector << 9,
-			   (u64)bio->bi_iter.bi_size, bioc->map_type);
-		free_raid_bio(rbio);
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
-		return;
-	}
-
 	/*
 	 * Loop retry:
 	 * for 'mirror == 2', reconstruct from all other stripes.
 	 * for 'mirror_num > 2', select a stripe to fail on every retry.
 	 */
-	if (mirror_num > 2) {
+	if (mirror_num > 2)
 		set_rbio_raid6_extra_error(rbio, mirror_num);
-		rbio->failb = rbio->real_stripes - (mirror_num - 1);
-		ASSERT(rbio->failb > 0);
-		if (rbio->failb <= rbio->faila)
-			rbio->failb--;
-	}
 
 	start_async_work(rbio, recover_rbio_work);
 }
@@ -2186,7 +2063,6 @@ static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
 	int ret;
 
 	bio_list_init(&bio_list);
-	atomic_set(&rbio->error, 0);
 
 	ret = rmw_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
@@ -2207,10 +2083,8 @@ static void raid_wait_write_end_io(struct bio *bio)
 	struct btrfs_raid_bio *rbio = bio->bi_private;
 	blk_status_t err = bio->bi_status;
 
-	if (err) {
-		fail_bio_stripe(rbio, bio);
+	if (err)
 		rbio_update_error_bitmap(rbio, bio);
-	}
 	bio_put(bio);
 	atomic_dec(&rbio->stripes_pending);
 	wake_up(&rbio->io_wait);
@@ -2260,19 +2134,14 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		return ret;
 
-	atomic_set(&rbio->error, 0);
 	index_rbio_pages(rbio);
 
 	ret = rmw_read_and_wait(rbio);
 	if (ret < 0)
 		return ret;
 
-	/* Too many read errors, beyond our tolerance. */
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		return ret;
-
-	/* Have read failures but under tolerance, needs recovery. */
-	if (rbio->faila >= 0 || rbio->failb >= 0) {
+	/* We have read errors, try recovery path. */
+	if (!bitmap_empty(rbio->error_bitmap, rbio->nr_sectors)) {
 		ret = recover_rbio(rbio);
 		if (ret < 0)
 			return ret;
@@ -2287,7 +2156,6 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
 	spin_unlock_irq(&rbio->bio_list_lock);
 
-	atomic_set(&rbio->error, 0);
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	index_rbio_pages(rbio);
@@ -2316,9 +2184,17 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	submit_write_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
-	/* We have more errors than our tolerance during the read. */
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		ret = -EIO;
+	/* We may have more errors than our tolerance during the read. */
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+		int found_errors;
+
+		found_errors = get_rbio_veritical_errors(rbio, sectornr,
+							 NULL, NULL);
+		if (found_errors > rbio->bioc->max_errors) {
+			ret = -EIO;
+			break;
+		}
+	}
 	return ret;
 }
 
@@ -2499,7 +2375,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 		pointers[rbio->real_stripes - 1] = kmap_local_page(q_sector.page);
 	}
 
-	atomic_set(&rbio->error, 0);
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	/* Map the parity stripe just once */
@@ -2733,6 +2608,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	bool need_check = false;
 	struct bio_list bio_list;
+	int sector_nr;
 	int ret;
 	struct bio *bio;
 
@@ -2742,7 +2618,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	if (ret)
 		goto cleanup;
 
-	atomic_set(&rbio->error, 0);
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	ret = scrub_assemble_read_bios(rbio, &bio_list);
@@ -2763,8 +2638,16 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	 */
 	ret = finish_parity_scrub(rbio, need_check);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		ret = -EIO;
+	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+		int found_errors;
+
+		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+							 NULL, NULL);
+		if (found_errors > rbio->bioc->max_errors) {
+			ret = -EIO;
+			break;
+		}
+	}
 	return ret;
 
 cleanup:
@@ -2811,14 +2694,6 @@ raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 	ASSERT(!bio->bi_iter.bi_size);
 
 	set_rbio_range_error(rbio, bio);
-	rbio->faila = find_logical_bio_stripe(rbio, bio);
-	if (rbio->faila == -1) {
-		btrfs_warn_rl(fs_info,
-	"can not determine the failed stripe number for full stripe %llu",
-			      bioc->raid_map[0]);
-		free_raid_bio(rbio);
-		return NULL;
-	}
 
 	return rbio;
 }
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index e38da4fa76d6..a2e653e93fd8 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -74,12 +74,6 @@ struct btrfs_raid_bio {
 	/* How many sectors there are for each stripe */
 	u8 stripe_nsectors;
 
-	/* First bad stripe, -1 means no corruption */
-	s8 faila;
-
-	/* Second bad stripe (for RAID6 use) */
-	s8 failb;
-
 	/* Stripe number that we're scrubbing  */
 	u8 scrubp;
 
@@ -93,8 +87,6 @@ struct btrfs_raid_bio {
 
 	atomic_t stripes_pending;
 
-	atomic_t error;
-
 	wait_queue_head_t io_wait;
 
 	/* Bitmap to record which horizontal stripe has data */
-- 
2.38.1

