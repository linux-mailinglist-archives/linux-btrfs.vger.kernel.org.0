Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05EF61485B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKALQe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiKALQ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7818E35
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 074FC1F910
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xxq9WrPmDE0Y3PeGiSiQlyTsrZhuCBy8GFZNN62hky8=;
        b=bk5bwUcibTURg5weNvyYI0WNeFJDyJKyIPF7csWZ1tXvNlMXz03/fm1SzKHD3LmPF8gbsy
        +5NekxdMGoNgw3Pztoj5gWwUGzVEJifTmx3GO8HbDqQjwrfOs9boCA8s+r4KT6M1RVeESM
        bFXmSVrsgfD1T0JBWIq+WZuYWMnoH3s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49EF21346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WMx0BwgAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/12] btrfs: raid56: switch scrub path to use a single function
Date:   Tue,  1 Nov 2022 19:16:11 +0800
Message-Id: <afdc83d9d0647e22d14f9f8fac2e70ff402d6b6c.1667300355.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667300355.git.wqu@suse.com>
References: <cover.1667300355.git.wqu@suse.com>
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

This switch involves the following changes:

- Make finish_parity_scrub() only to submit the write bios
  It will no longer call rbio_orig_end_io(), and now it will
  return error.

- Add a new helper, recover_scrub_rbio(), to handle recovery
  It's just doing extra scrub related checks, and then call
  recover_sectors().

- Rename raid56_parity_scrub_stripe() to scrub_rbio()
- Rename scrub_parity_work() to scrub_rbio_work_locked()
  To follow the existing naming scheme.

- Delete unused functions
  Including:
  * finish_rmw()
  * raid_write_end_io()
  * raid56_bio_end_io()
  * __raid_recover_end_io()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 401 ++++++++++------------------------------------
 1 file changed, 81 insertions(+), 320 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4a82bffbcb4b..74e870941340 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -64,7 +64,6 @@ struct sector_ptr {
 	unsigned int uptodate:8;
 };
 
-static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
 static void rmw_rbio_work(struct work_struct *work);
 static void rmw_rbio_work_locked(struct work_struct *work);
 static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
@@ -72,9 +71,8 @@ static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
 
-static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
-					 int need_check);
-static void scrub_parity_work(struct work_struct *work);
+static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check);
+static void scrub_rbio_work_locked(struct work_struct *work);
 
 static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
@@ -819,7 +817,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 				start_async_work(next, rmw_rbio_work_locked);
 			} else if (next->operation == BTRFS_RBIO_PARITY_SCRUB) {
 				steal_rbio(rbio, next);
-				start_async_work(next, scrub_parity_work);
+				start_async_work(next, scrub_rbio_work_locked);
 			}
 
 			goto done_nolock;
@@ -880,35 +878,6 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 		rbio_endio_bio_list(extra, err);
 }
 
-/*
- * end io function used by finish_rmw.  When we finally
- * get here, we've written a full stripe
- */
-static void raid_write_end_io(struct bio *bio)
-{
-	struct btrfs_raid_bio *rbio = bio->bi_private;
-	blk_status_t err = bio->bi_status;
-	int max_errors;
-
-	if (err)
-		fail_bio_stripe(rbio, bio);
-
-	bio_put(bio);
-
-	if (!atomic_dec_and_test(&rbio->stripes_pending))
-		return;
-
-	err = BLK_STS_OK;
-
-	/* OK, we have read all the stripes we need to. */
-	max_errors = (rbio->operation == BTRFS_RBIO_PARITY_SCRUB) ?
-		     0 : rbio->bioc->max_errors;
-	if (atomic_read(&rbio->error) > max_errors)
-		err = BLK_STS_IOERR;
-
-	rbio_orig_end_io(rbio, err);
-}
-
 /**
  * Get a sector pointer specified by its @stripe_nr and @sector_nr
  *
@@ -1319,87 +1288,6 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	return -EIO;
 }
 
-/*
- * this is called from one of two situations.  We either
- * have a full stripe from the higher layers, or we've read all
- * the missing bits off disk.
- *
- * This will calculate the parity and then send down any
- * changed blocks.
- */
-static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
-{
-	/* The total sector number inside the full stripe. */
-	/* Sector number inside a stripe. */
-	int sectornr;
-	struct bio_list bio_list;
-	struct bio *bio;
-	int ret;
-
-	bio_list_init(&bio_list);
-
-	/* We should have at least one data sector. */
-	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
-
-	/* at this point we either have a full stripe,
-	 * or we've read the full stripe from the drive.
-	 * recalculate the parity and write the new results.
-	 *
-	 * We're not allowed to add any new bios to the
-	 * bio list here, anyone else that wants to
-	 * change this stripe needs to do their own rmw.
-	 */
-	spin_lock_irq(&rbio->bio_list_lock);
-	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
-	spin_unlock_irq(&rbio->bio_list_lock);
-
-	atomic_set(&rbio->error, 0);
-
-	/*
-	 * now that we've set rmw_locked, run through the
-	 * bio list one last time and map the page pointers
-	 *
-	 * We don't cache full rbios because we're assuming
-	 * the higher layers are unlikely to use this area of
-	 * the disk again soon.  If they do use it again,
-	 * hopefully they will send another full bio.
-	 */
-	index_rbio_pages(rbio);
-	if (!rbio_is_full(rbio))
-		cache_rbio_pages(rbio);
-	else
-		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
-
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
-		generate_pq_vertical(rbio, sectornr);
-
-	ret = rmw_assemble_write_bios(rbio, &bio_list);
-	if (ret < 0)
-		goto cleanup;
-
-	atomic_set(&rbio->stripes_pending, bio_list_size(&bio_list));
-	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
-
-	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_write_end_io;
-
-		if (trace_raid56_write_stripe_enabled()) {
-			struct raid56_bio_trace_info trace_info = { 0 };
-
-			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_write_stripe(rbio, bio, &trace_info);
-		}
-		submit_bio(bio);
-	}
-	return;
-
-cleanup:
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
-
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-}
-
 /*
  * helper to find the stripe number for a given bio.  Used to figure out which
  * stripe has failed.  This expects the bio to correspond to a physical disk,
@@ -1569,22 +1457,6 @@ static void submit_read_bios(struct btrfs_raid_bio *rbio,
 	}
 }
 
-static void raid56_bio_end_io(struct bio *bio)
-{
-	struct btrfs_raid_bio *rbio = bio->bi_private;
-
-	if (bio->bi_status)
-		fail_bio_stripe(rbio, bio);
-	else
-		set_bio_pages_uptodate(rbio, bio);
-
-	bio_put(bio);
-
-	if (atomic_dec_and_test(&rbio->stripes_pending))
-		queue_work(rbio->bioc->fs_info->endio_raid56_workers,
-			   &rbio->end_io_work);
-}
-
 static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				  struct bio_list *bio_list)
 {
@@ -1969,60 +1841,6 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
-/*
- * all parity reconstruction happens here.  We've read in everything
- * we can find from the drives and this does the heavy lifting of
- * sorting the good from the bad.
- */
-static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
-{
-	int ret;
-
-	ret = recover_sectors(rbio);
-
-	/*
-	 * Similar to READ_REBUILD, REBUILD_MISSING at this point also has a
-	 * valid rbio which is consistent with ondisk content, thus such a
-	 * valid rbio can be cached to avoid further disk reads.
-	 */
-	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
-		/*
-		 * - In case of two failures, where rbio->failb != -1:
-		 *
-		 *   Do not cache this rbio since the above read reconstruction
-		 *   (raid6_datap_recov() or raid6_2data_recov()) may have
-		 *   changed some content of stripes which are not identical to
-		 *   on-disk content any more, otherwise, a later write/recover
-		 *   may steal stripe_pages from this rbio and end up with
-		 *   corruptions or rebuild failures.
-		 *
-		 * - In case of single failure, where rbio->failb == -1:
-		 *
-		 *   Cache this rbio iff the above read reconstruction is
-		 *   executed without problems.
-		 */
-		if (!ret && rbio->failb < 0)
-			cache_rbio_pages(rbio);
-		else
-			clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
-
-		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
-	} else if (!ret) {
-		rbio->faila = -1;
-		rbio->failb = -1;
-
-		if (rbio->operation == BTRFS_RBIO_WRITE)
-			finish_rmw(rbio);
-		else if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB)
-			finish_parity_scrub(rbio, 0);
-		else
-			BUG();
-	} else {
-		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
-	}
-}
-
 static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				      struct bio_list *bio_list)
 {
@@ -2450,8 +2268,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 	return 0;
 }
 
-static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
-					 int need_check)
+static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
 	const u32 sectorsize = bioc->fs_info->sectorsize;
@@ -2494,7 +2311,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	p_sector.page = alloc_page(GFP_NOFS);
 	if (!p_sector.page)
-		goto cleanup;
+		return -ENOMEM;
 	p_sector.pgoff = 0;
 	p_sector.uptodate = 1;
 
@@ -2504,7 +2321,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		if (!q_sector.page) {
 			__free_page(p_sector.page);
 			p_sector.page = NULL;
-			goto cleanup;
+			return -ENOMEM;
 		}
 		q_sector.pgoff = 0;
 		q_sector.uptodate = 1;
@@ -2591,33 +2408,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	}
 
 submit_write:
-	nr_data = bio_list_size(&bio_list);
-	if (!nr_data) {
-		/* Every parity is right */
-		rbio_orig_end_io(rbio, BLK_STS_OK);
-		return;
-	}
-
-	atomic_set(&rbio->stripes_pending, nr_data);
-
-	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid_write_end_io;
-
-		if (trace_raid56_scrub_write_stripe_enabled()) {
-			struct raid56_bio_trace_info trace_info = { 0 };
-
-			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_scrub_write_stripe(rbio, bio, &trace_info);
-		}
-		submit_bio(bio);
-	}
-	return;
+	submit_write_bios(rbio, &bio_list);
+	return 0;
 
 cleanup:
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
-
 	while ((bio = bio_list_pop(&bio_list)))
 		bio_put(bio);
+	return ret;
 }
 
 static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
@@ -2627,85 +2424,51 @@ static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
 	return 0;
 }
 
-/*
- * While we're doing the parity check and repair, we could have errors
- * in reading pages off the disk.  This checks for errors and if we're
- * not able to read the page it'll trigger parity reconstruction.  The
- * parity scrub will be finished after we've reconstructed the failed
- * stripes
- */
-static void validate_rbio_for_parity_scrub(struct btrfs_raid_bio *rbio)
+static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		goto cleanup;
+	int dfail = 0, failp = -1;
+	int ret;
 
-	if (rbio->faila >= 0 || rbio->failb >= 0) {
-		int dfail = 0, failp = -1;
+	/* No error case should be already handled by the caller. */
+	ASSERT(rbio->faila >= 0 || rbio->failb >= 0);
 
-		if (is_data_stripe(rbio, rbio->faila))
-			dfail++;
-		else if (is_parity_stripe(rbio->faila))
-			failp = rbio->faila;
+	if (is_data_stripe(rbio, rbio->faila))
+		dfail++;
+	else if (is_parity_stripe(rbio->faila))
+		failp = rbio->faila;
 
-		if (is_data_stripe(rbio, rbio->failb))
-			dfail++;
-		else if (is_parity_stripe(rbio->failb))
-			failp = rbio->failb;
-
-		/*
-		 * Because we can not use a scrubbing parity to repair
-		 * the data, so the capability of the repair is declined.
-		 * (In the case of RAID5, we can not repair anything)
-		 */
-		if (dfail > rbio->bioc->max_errors - 1)
-			goto cleanup;
-
-		/*
-		 * If all data is good, only parity is correctly, just
-		 * repair the parity.
-		 */
-		if (dfail == 0) {
-			finish_parity_scrub(rbio, 0);
-			return;
-		}
-
-		/*
-		 * Here means we got one corrupted data stripe and one
-		 * corrupted parity on RAID6, if the corrupted parity
-		 * is scrubbing parity, luckily, use the other one to repair
-		 * the data, or we can not repair the data stripe.
-		 */
-		if (failp != rbio->scrubp)
-			goto cleanup;
-
-		__raid_recover_end_io(rbio);
-	} else {
-		finish_parity_scrub(rbio, 1);
-	}
-	return;
-
-cleanup:
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
-}
-
-/*
- * end io for the read phase of the rmw cycle.  All the bios here are physical
- * stripe bios we've read from the disk so we can recalculate the parity of the
- * stripe.
- *
- * This will usually kick off finish_rmw once all the bios are read in, but it
- * may trigger parity reconstruction if we had any errors along the way
- */
-static void raid56_parity_scrub_end_io_work(struct work_struct *work)
-{
-	struct btrfs_raid_bio *rbio =
-		container_of(work, struct btrfs_raid_bio, end_io_work);
+	if (is_data_stripe(rbio, rbio->failb))
+		dfail++;
+	else if (is_parity_stripe(rbio->failb))
+		failp = rbio->failb;
 
 	/*
-	 * This will normally call finish_rmw to start our write, but if there
-	 * are any failed stripes we'll reconstruct from parity first
+	 * Because we can not use a scrubbing parity to repair
+	 * the data, so the capability of the repair is declined.
+	 * (In the case of RAID5, we can not repair anything)
 	 */
-	validate_rbio_for_parity_scrub(rbio);
+	if (dfail > rbio->bioc->max_errors - 1)
+		return -EIO;
+
+	/*
+	 * If all data is good, only parity is correctly, just
+	 * repair the parity.
+	 */
+	if (dfail == 0)
+		return 0;
+
+	/*
+	 * Here means we got one corrupted data stripe and one
+	 * corrupted parity on RAID6, if the corrupted parity
+	 * is scrubbing parity, luckily, use the other one to repair
+	 * the data, or we can not repair the data stripe.
+	 */
+	if (failp != rbio->scrubp)
+		return -EIO;
+
+	/* We have some corrupted sectors, need to repair them. */
+	ret = recover_sectors(rbio);
+	return ret;
 }
 
 static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
@@ -2757,9 +2520,9 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	return ret;
 }
 
-static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
+static int scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	int bios_to_read = 0;
+	bool need_check = false;
 	struct bio_list bio_list;
 	int ret;
 	struct bio *bio;
@@ -2775,61 +2538,59 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		goto cleanup;
 
-	bios_to_read = bio_list_size(&bio_list);
-	if (!bios_to_read) {
-		/*
-		 * this can happen if others have merged with
-		 * us, it means there is nothing left to read.
-		 * But if there are missing devices it may not be
-		 * safe to do the full stripe write yet.
-		 */
+	submit_read_bios(rbio, &bio_list);
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
+		ret = -EIO;
+		goto cleanup;
+	}
+	/*
+	 * No error during read, can finish the scrub and need to verify the
+	 * P/Q sectors;
+	 */
+	if (atomic_read(&rbio->error) == 0) {
+		need_check = true;
 		goto finish;
 	}
 
+	/* We have some failures, need to recover the failed sectors first. */
+	ret = recover_scrub_rbio(rbio);
+	if (ret < 0)
+		goto cleanup;
+
+finish:
 	/*
-	 * The bioc may be freed once we submit the last bio. Make sure not to
-	 * touch it after that.
+	 * We have every sector properly prepared. Can finish the scrub
+	 * and writeback the good content.
 	 */
-	atomic_set(&rbio->stripes_pending, bios_to_read);
-	INIT_WORK(&rbio->end_io_work, raid56_parity_scrub_end_io_work);
-	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid56_bio_end_io;
-
-		if (trace_raid56_scrub_read_enabled()) {
-			struct raid56_bio_trace_info trace_info = { 0 };
-
-			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_scrub_read(rbio, bio, &trace_info);
-		}
-		submit_bio(bio);
-	}
-	/* the actual write will happen once the reads are done */
-	return;
+	ret = finish_parity_scrub(rbio, need_check);
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
+		ret = -EIO;
+	return ret;
 
 cleanup:
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
-
 	while ((bio = bio_list_pop(&bio_list)))
 		bio_put(bio);
 
-	return;
-
-finish:
-	validate_rbio_for_parity_scrub(rbio);
+	return ret;
 }
 
-static void scrub_parity_work(struct work_struct *work)
+static void scrub_rbio_work_locked(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
+	int ret;
 
 	rbio = container_of(work, struct btrfs_raid_bio, work);
-	raid56_parity_scrub_stripe(rbio);
+	ret = scrub_rbio(rbio);
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	if (!lock_stripe_add(rbio))
-		start_async_work(rbio, scrub_parity_work);
+		start_async_work(rbio, scrub_rbio_work_locked);
 }
 
 /* The following code is used for dev replace of a missing RAID 5/6 device. */
-- 
2.38.1

