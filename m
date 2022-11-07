Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FA61EC1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 08:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKGHc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 02:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKGHcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 02:32:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042FAE
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 23:32:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E078622654
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667806371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOhxgebS76eaxm6fWzltl/NELCjJovokV4R4zPCywS0=;
        b=A3vSxz3zE4cT5Rf3JsH++gXROFhxVsSab6jalcHvwC+jt2st25mLyzybj3KqqlFCzpI0la
        pqxvE8zft8AIAHOHdleigNLsUbCrGAFzXR3rLdeiblDY7ol7RTuGrmynv7gR5OSdruwprL
        ZgL8L/UJmJi66szvI5tKcN6E8Zz55oQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D75813AC7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8NijOKK0aGMmDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 07:32:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: raid56: migrate recovery and scrub recovery path to use error_bitmap
Date:   Mon,  7 Nov 2022 15:32:30 +0800
Message-Id: <342e8d02e3cb6e657d44d506788ab976f6d465bc.1667805755.git.wqu@suse.com>
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

Since we have rbio::error_bitmap to indicate exactly where the errors
are (including read error and csum mismatch error), we can make recovery
path more accurate.

For example:

             0        32K       64K
     Data 1  |XXXXXXXX|         |
     Data 2  |        |XXXXXXXXX|
     Parity  |        |         |

1) Get csum mismatch when reading data 1 [0, 32K)

2) Mark corresponding range error
   The old code will mark the whole data 1 stripe as error.
   While the new code will only mark data 1 [0, 32K) as error.

3) Recovery path
   The old code will recover data 1 [0, 64K), all using Data 2 and
   parity.

   This means, Data 1 [32K, 64K) will be corrupted data, as data 2
   [32K, 64K) is already corrupted.

   While the new code will only recover data 1 [0, 32K), as only
   that range has error so far.

This new behavior can avoid populating rbio cache with incorrect data.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 281 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 195 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e5c630a0e8e9..800213ab44a1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1013,6 +1013,37 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	return 0;
 }
 
+/*
+ * Return the total errors found in the vertical stripe of @sector_nr.
+ *
+ * @faila and @failb will also be updated to the first and second stripe
+ * number of the errors.
+ */
+static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
+				     int *faila, int *failb)
+{
+	int stripe_nr;
+	int found_errors = 0;
+
+	ASSERT(faila && failb);
+	*faila = -1;
+	*failb = -1;
+
+	for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
+		int total_sector_nr = stripe_nr * rbio->stripe_nsectors +
+				      sector_nr;
+
+		if (test_bit(total_sector_nr, rbio->error_bitmap)) {
+			found_errors++;
+			if (*faila < 0)
+				*faila = stripe_nr;
+			else if (*failb < 0)
+				*failb = stripe_nr;
+		}
+	}
+	return found_errors;
+}
+
 /*
  * Add a single sector @sector into our list of bios for IO.
  *
@@ -1745,14 +1776,15 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
  * @*pointers are the pre-allocated pointers by the caller, so we don't
  * need to allocate/free the pointers again and again.
  */
-static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
-			     void **pointers, void **unmap_array)
+static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
+			    void **pointers, void **unmap_array)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct sector_ptr *sector;
 	const u32 sectorsize = fs_info->sectorsize;
-	const int faila = rbio->faila;
-	const int failb = rbio->failb;
+	int found_errors;
+	int faila;
+	int failb;
 	int stripe_nr;
 
 	/*
@@ -1761,7 +1793,19 @@ static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	 */
 	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
 	    !test_bit(sector_nr, &rbio->dbitmap))
-		return;
+		return 0;
+
+	found_errors = get_rbio_veritical_errors(rbio, sector_nr, &faila,
+						 &failb);
+	/*
+	 * No errors in the veritical stripe, skip it.
+	 * Can happen for recovery which only part of a stripe failed csum check.
+	 */
+	if (!found_errors)
+		return 0;
+
+	if (found_errors > rbio->bioc->max_errors)
+		return -EIO;
 
 	/*
 	 * Setup our array of pointers with sectors from each stripe
@@ -1772,11 +1816,10 @@ static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
 		/*
 		 * If we're rebuilding a read, we have to use
-		 * pages from the bio list
+		 * pages from the bio list if possible.
 		 */
 		if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-		     rbio->operation == BTRFS_RBIO_REBUILD_MISSING) &&
-		    (stripe_nr == faila || stripe_nr == failb)) {
+		     rbio->operation == BTRFS_RBIO_REBUILD_MISSING)) {
 			sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
 		} else {
 			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
@@ -1864,18 +1907,19 @@ static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	 * Especially if we determine to cache the rbio, we need to
 	 * have at least all data sectors uptodate.
 	 */
-	if (rbio->faila >= 0) {
-		sector = rbio_stripe_sector(rbio, rbio->faila, sector_nr);
+	if (faila >= 0) {
+		sector = rbio_stripe_sector(rbio, faila, sector_nr);
 		sector->uptodate = 1;
 	}
-	if (rbio->failb >= 0) {
-		sector = rbio_stripe_sector(rbio, rbio->failb, sector_nr);
+	if (failb >= 0) {
+		sector = rbio_stripe_sector(rbio, failb, sector_nr);
 		sector->uptodate = 1;
 	}
 
 cleanup:
 	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
 		kunmap_local(unmap_array[stripe_nr]);
+	return 0;
 }
 
 static int recover_sectors(struct btrfs_raid_bio *rbio)
@@ -1898,10 +1942,6 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 		goto out;
 	}
 
-	/* Make sure faila and fail b are in order. */
-	if (rbio->faila >= 0 && rbio->failb >= 0 && rbio->faila > rbio->failb)
-		swap(rbio->faila, rbio->failb);
-
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
 	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
 		spin_lock_irq(&rbio->bio_list_lock);
@@ -1911,8 +1951,11 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 
 	index_rbio_pages(rbio);
 
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
-		recover_vertical(rbio, sectornr, pointers, unmap_array);
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+		ret = recover_vertical(rbio, sectornr, pointers, unmap_array);
+		if (ret < 0)
+			break;
+	}
 
 out:
 	kfree(pointers);
@@ -1942,13 +1985,21 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
 		struct sector_ptr *sector;
 
-		if (rbio->faila == stripe || rbio->failb == stripe) {
-			/* Skip the current stripe. */
-			ASSERT(sectornr == 0);
-			total_sector_nr += rbio->stripe_nsectors - 1;
-			atomic_inc(&rbio->error);
+		/*
+		 * Skip the range which has error.
+		 * It can be a range which is marked error (for csum mismatch),
+		 * or it can be a missing device.
+		 */
+		if (!rbio->bioc->stripes[stripe].dev->bdev ||
+		    test_bit(total_sector_nr, rbio->error_bitmap)) {
+			/*
+			 * Also set the error bit for missing device, which
+			 * may not yet have its error bit set.
+			 */
+			set_bit(total_sector_nr, rbio->error_bitmap);
 			continue;
 		}
+
 		sector = rbio_stripe_sector(rbio, stripe, sectornr);
 		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
 					 sectornr, REQ_OP_READ);
@@ -1971,9 +2022,8 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 
 	/*
 	 * Either we're doing recover for a read failure or degraded write,
-	 * caller should have set faila/b and error bitmap correctly.
+	 * caller should have set error bitmap correctly.
 	 */
-	ASSERT(rbio->faila >= 0 || rbio->failb >= 0);
 	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
 	bio_list_init(&bio_list);
 
@@ -1997,12 +2047,6 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
-	/* We have more errors than our tolerance during the read. */
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
-		ret = -EIO;
-		goto out;
-	}
-
 	ret = recover_sectors(rbio);
 
 out:
@@ -2037,6 +2081,52 @@ static void recover_rbio_work_locked(struct work_struct *work)
 	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
+static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio,
+				       int mirror_num)
+{
+	bool found = false;
+	int sector_nr;
+
+	/*
+	 * This is for RAID6 extra recovery tries, thus mirror number should
+	 * be large than 2.
+	 * Mirror 1 means read from data stripes. Mirror 2 means rebuild using
+	 * RAID5 methods.
+	 */
+	ASSERT(mirror_num > 2);
+	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+		int found_errors;
+		int faila;
+		int failb;
+
+		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+							 &faila, &failb);
+		/* This vertical stripe doesn't have errors. */
+		if (!found_errors)
+			continue;
+
+		/*
+		 * If we found errors, there should be only one error marked
+		 * by previous set_rbio_range_error().
+		 */
+		ASSERT(found_errors == 1);
+		found = true;
+
+		/* Now select another stripe to mark as error. */
+		failb = rbio->real_stripes - (mirror_num - 1);
+		if (failb <= faila)
+			failb--;
+
+		/* Set the extra bit in error bitmap. */
+		if (failb >= 0)
+			set_bit(failb * rbio->stripe_nsectors + sector_nr,
+				rbio->error_bitmap);
+	}
+
+	/* We should found at least one vertical stripe with error.*/
+	ASSERT(found);
+}
+
 /*
  * the main entry point for reads from the higher layers.  This
  * is really only called when the normal read path had a failure,
@@ -2079,11 +2169,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	 * for 'mirror_num > 2', select a stripe to fail on every retry.
 	 */
 	if (mirror_num > 2) {
-		/*
-		 * 'mirror == 3' is to fail the p stripe and
-		 * reconstruct from the q stripe.  'mirror > 3' is to
-		 * fail a data stripe and reconstruct from p+q stripe.
-		 */
+		set_rbio_raid6_extra_error(rbio, mirror_num);
 		rbio->failb = rbio->real_stripes - (mirror_num - 1);
 		ASSERT(rbio->failb > 0);
 		if (rbio->failb <= rbio->faila)
@@ -2512,48 +2598,85 @@ static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
 
 static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	int dfail = 0, failp = -1;
+	void **pointers = NULL;
+	void **unmap_array = NULL;
+	int sector_nr;
 	int ret;
 
-	/* No error case should be already handled by the caller. */
-	ASSERT(rbio->faila >= 0 || rbio->failb >= 0);
-
-	if (is_data_stripe(rbio, rbio->faila))
-		dfail++;
-	else if (is_parity_stripe(rbio->faila))
-		failp = rbio->faila;
-
-	if (is_data_stripe(rbio, rbio->failb))
-		dfail++;
-	else if (is_parity_stripe(rbio->failb))
-		failp = rbio->failb;
-
 	/*
-	 * Because we can not use a scrubbing parity to repair
-	 * the data, so the capability of the repair is declined.
-	 * (In the case of RAID5, we can not repair anything)
+	 * @pointers array stores the pointer for each sector.
+	 *
+	 * @unmap_array stores copy of pointers that does not get reordered
+	 * during reconstruction so that kunmap_local works.
 	 */
-	if (dfail > rbio->bioc->max_errors - 1)
-		return -EIO;
+	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	if (!pointers || !unmap_array) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	/*
-	 * If all data is good, only parity is correctly, just
-	 * repair the parity.
-	 */
-	if (dfail == 0)
-		return 0;
+	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+		int dfail = 0, failp = -1;
+		int faila;
+		int failb;
+		int found_errors;
 
-	/*
-	 * Here means we got one corrupted data stripe and one
-	 * corrupted parity on RAID6, if the corrupted parity
-	 * is scrubbing parity, luckily, use the other one to repair
-	 * the data, or we can not repair the data stripe.
-	 */
-	if (failp != rbio->scrubp)
-		return -EIO;
+		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+							 &faila, &failb);
+		if (found_errors > rbio->bioc->max_errors) {
+			ret = -EIO;
+			goto out;
+		}
+		if (found_errors == 0)
+			continue;
 
-	/* We have some corrupted sectors, need to repair them. */
-	ret = recover_sectors(rbio);
+		/* We should have at least one error here. */
+		ASSERT(faila >= 0 || failb >= 0);
+
+		if (is_data_stripe(rbio, faila))
+			dfail++;
+		else if (is_parity_stripe(faila))
+			failp = faila;
+
+		if (is_data_stripe(rbio, failb))
+			dfail++;
+		else if (is_parity_stripe(failb))
+			failp = failb;
+		/*
+		 * Because we can not use a scrubbing parity to repair
+		 * the data, so the capability of the repair is declined.
+		 * (In the case of RAID5, we can not repair anything)
+		 */
+		if (dfail > rbio->bioc->max_errors - 1) {
+			ret = -EIO;
+			goto out;
+		}
+		/*
+		 * If all data is good, only parity is correctly, just
+		 * repair the parity, no need to recover data stripes.
+		 */
+		if (dfail == 0)
+			continue;
+
+		/*
+		 * Here means we got one corrupted data stripe and one
+		 * corrupted parity on RAID6, if the corrupted parity
+		 * is scrubbing parity, luckily, use the other one to repair
+		 * the data, or we can not repair the data stripe.
+		 */
+		if (failp != rbio->scrubp) {
+			ret = -EIO;
+			goto out;
+		}
+
+		ret = recover_vertical(rbio, sector_nr, pointers, unmap_array);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	kfree(pointers);
+	kfree(unmap_array);
 	return ret;
 }
 
@@ -2629,25 +2752,11 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
-		ret = -EIO;
-		goto cleanup;
-	}
-	/*
-	 * No error during read, can finish the scrub and need to verify the
-	 * P/Q sectors;
-	 */
-	if (atomic_read(&rbio->error) == 0) {
-		need_check = true;
-		goto finish;
-	}
-
-	/* We have some failures, need to recover the failed sectors first. */
+	/* We may have some failures, recover the failed sectors first. */
 	ret = recover_scrub_rbio(rbio);
 	if (ret < 0)
 		goto cleanup;
 
-finish:
 	/*
 	 * We have every sector properly prepared. Can finish the scrub
 	 * and writeback the good content.
-- 
2.38.1

