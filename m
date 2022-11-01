Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B34614854
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKALQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKALQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AFD1835F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC8B8338A1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1yoTH+0Q0hwLobKdAcjq7U794KjZvxW32Gwi1q6R74=;
        b=Rp797CJTS4IoIUDxEZWMpA/vrLjAo1htMgL01hUHmcGmgvG0QtxAp4MyomYkdAmXm+5/Bm
        dEuzFVzLbZJa0S+fm9/4KH7zTPdPQkBm2rV2LtY5am3nwFSlJjNxectXzFeuJk2zVWqzmb
        kcxsPDPnMIodcsU6s26SgafQs5MrHNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 540A51346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AH+aCf//YGMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/12] btrfs: raid56: extract the vertical stripe recovery code into recover_vertical()
Date:   Tue,  1 Nov 2022 19:16:01 +0800
Message-Id: <6c0fa9f3251101b7402a57196e7520fdb365bb0c.1667300355.git.wqu@suse.com>
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

This refactor includes the following behavior change first:

- Don't error out if only P/Q is corrupted

  The old code will directly error out if only P/Q is corrupted.
  Although it is an logical error if we go into rebuild path with
  only P/Q corrupted, there is no need to error out.

  Just skip the rebuild and return the already good data.

Then comes the following refactor which shouldn't cause behavior
changes:

- Introduce a helper to do vertical stripe recovery

  This not only reduce one indent level, but also paves the road for
  later data checksum verification in RMW cycles.

- Sort rbio->faila/b before recovery

  So we don't need to do the same swap every vertical stripe

- Replace a BUG_ON() with ASSERT()

  Or checkpatch won't let me pass.

- Mark recovered sectors uptodate after the recover loop

- Do the cleanup for pointers unconditionally

  We only need to initialize @pointers and @unmap_array to NULL, so
  we can safely free them unconditionally.

- Mark the repaired sector uptodate in recover_vertical()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 285 ++++++++++++++++++++++++----------------------
 1 file changed, 149 insertions(+), 136 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 349270537c2e..85b883a21baa 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1886,6 +1886,144 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	bio_endio(bio);
 }
 
+/*
+ * Recover a vertical stripe specified by @sector_nr.
+ * @*pointers are the pre-allocated pointers by the caller, so we don't
+ * need to allocate/free the pointers again and again.
+ */
+static void recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
+			     void **pointers, void **unmap_array)
+{
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	struct sector_ptr *sector;
+	const u32 sectorsize = fs_info->sectorsize;
+	const int faila = rbio->faila;
+	const int failb = rbio->failb;
+	int stripe_nr;
+
+	/*
+	 * Now we just use bitmap to mark the horizontal stripes in
+	 * which we have data when doing parity scrub.
+	 */
+	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
+	    !test_bit(sector_nr, &rbio->dbitmap))
+		return;
+
+	/*
+	 * Setup our array of pointers with sectors from each stripe
+	 *
+	 * NOTE: store a duplicate array of pointers to preserve the
+	 * pointer order.
+	 */
+	for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
+		/*
+		 * If we're rebuilding a read, we have to use
+		 * pages from the bio list
+		 */
+		if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
+		     rbio->operation == BTRFS_RBIO_REBUILD_MISSING) &&
+		    (stripe_nr == faila || stripe_nr == failb)) {
+			sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
+		}
+		ASSERT(sector->page);
+		pointers[stripe_nr] = kmap_local_page(sector->page) +
+				   sector->pgoff;
+		unmap_array[stripe_nr] = pointers[stripe_nr];
+	}
+
+	/* All raid6 handling here */
+	if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6) {
+		/* Single failure, rebuild from parity raid5 style */
+		if (failb < 0) {
+			if (faila == rbio->nr_data)
+				/*
+				 * Just the P stripe has failed, without
+				 * a bad data or Q stripe.
+				 * We have nothing to do, just skip the
+				 * recovery for this stripe.
+				 */
+				goto cleanup;
+			/*
+			 * a single failure in raid6 is rebuilt
+			 * in the pstripe code below
+			 */
+			goto pstripe;
+		}
+
+		/*
+		 * If the q stripe is failed, do a pstripe reconstruction from
+		 * the xors.
+		 * If both the q stripe and the P stripe are failed, we're
+		 * here due to a crc mismatch and we can't give them the
+		 * data they want.
+		 */
+		if (rbio->bioc->raid_map[failb] == RAID6_Q_STRIPE) {
+			if (rbio->bioc->raid_map[faila] ==
+			    RAID5_P_STRIPE)
+				/*
+				 * Only P and Q are corrupted.
+				 * We only care about data stripes recovery,
+				 * can skip this vertical stripe.
+				 */
+				goto cleanup;
+			/*
+			 * Otherwise we have one bad data stripe and
+			 * a good P stripe.  raid5!
+			 */
+			goto pstripe;
+		}
+
+		if (rbio->bioc->raid_map[failb] == RAID5_P_STRIPE) {
+			raid6_datap_recov(rbio->real_stripes, sectorsize,
+					  faila, pointers);
+		} else {
+			raid6_2data_recov(rbio->real_stripes, sectorsize,
+					  faila, failb, pointers);
+		}
+	} else {
+		void *p;
+
+		/* Rebuild from P stripe here (raid5 or raid6). */
+		ASSERT(failb == -1);
+pstripe:
+		/* Copy parity block into failed block to start with */
+		memcpy(pointers[faila], pointers[rbio->nr_data], sectorsize);
+
+		/* Rearrange the pointer array */
+		p = pointers[faila];
+		for (stripe_nr = faila; stripe_nr < rbio->nr_data - 1;
+		     stripe_nr++)
+			pointers[stripe_nr] = pointers[stripe_nr + 1];
+		pointers[rbio->nr_data - 1] = p;
+
+		/* Xor in the rest */
+		run_xor(pointers, rbio->nr_data - 1, sectorsize);
+
+	}
+
+	/*
+	 * No matter if this is a RMW or recovery, we should have all
+	 * failed sectors repaired in the vertical stripe, thus they are now
+	 * uptodate.
+	 * Especially if we determine to cache the rbio, we need to
+	 * have at least all data sectors uptodate.
+	 */
+	if (rbio->faila >= 0) {
+		sector = rbio_stripe_sector(rbio, rbio->faila, sector_nr);
+		sector->uptodate = 1;
+	}
+	if (rbio->failb >= 0) {
+		sector = rbio_stripe_sector(rbio, rbio->failb, sector_nr);
+		sector->uptodate = 1;
+	}
+
+cleanup:
+	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
+		kunmap_local(unmap_array[stripe_nr]);
+}
+
 /*
  * all parity reconstruction happens here.  We've read in everything
  * we can find from the drives and this does the heavy lifting of
@@ -1893,13 +2031,10 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
  */
 static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	int sectornr, stripe;
-	void **pointers;
-	void **unmap_array;
-	int faila = -1, failb = -1;
+	int sectornr;
+	void **pointers = NULL;
+	void **unmap_array = NULL;
 	blk_status_t err;
-	int i;
 
 	/*
 	 * This array stores the pointer for each sector, thus it has the extra
@@ -1908,7 +2043,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
 	if (!pointers) {
 		err = BLK_STS_RESOURCE;
-		goto cleanup_io;
+		goto cleanup;
 	}
 
 	/*
@@ -1918,11 +2053,12 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
 	if (!unmap_array) {
 		err = BLK_STS_RESOURCE;
-		goto cleanup_pointers;
+		goto cleanup;
 	}
 
-	faila = rbio->faila;
-	failb = rbio->failb;
+	/* Make sure faila and fail b are in order. */
+	if (rbio->faila >= 0 && rbio->failb >= 0 && rbio->faila > rbio->failb)
+		swap(rbio->faila, rbio->failb);
 
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
 	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
@@ -1933,138 +2069,15 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 
 	index_rbio_pages(rbio);
 
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-		struct sector_ptr *sector;
-
-		/*
-		 * Now we just use bitmap to mark the horizontal stripes in
-		 * which we have data when doing parity scrub.
-		 */
-		if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
-		    !test_bit(sectornr, &rbio->dbitmap))
-			continue;
-
-		/*
-		 * Setup our array of pointers with sectors from each stripe
-		 *
-		 * NOTE: store a duplicate array of pointers to preserve the
-		 * pointer order
-		 */
-		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-			/*
-			 * If we're rebuilding a read, we have to use
-			 * pages from the bio list
-			 */
-			if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-			     rbio->operation == BTRFS_RBIO_REBUILD_MISSING) &&
-			    (stripe == faila || stripe == failb)) {
-				sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-			} else {
-				sector = rbio_stripe_sector(rbio, stripe, sectornr);
-			}
-			ASSERT(sector->page);
-			pointers[stripe] = kmap_local_page(sector->page) +
-					   sector->pgoff;
-			unmap_array[stripe] = pointers[stripe];
-		}
-
-		/* All raid6 handling here */
-		if (rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6) {
-			/* Single failure, rebuild from parity raid5 style */
-			if (failb < 0) {
-				if (faila == rbio->nr_data) {
-					/*
-					 * Just the P stripe has failed, without
-					 * a bad data or Q stripe.
-					 * TODO, we should redo the xor here.
-					 */
-					err = BLK_STS_IOERR;
-					goto cleanup;
-				}
-				/*
-				 * a single failure in raid6 is rebuilt
-				 * in the pstripe code below
-				 */
-				goto pstripe;
-			}
-
-			/* make sure our ps and qs are in order */
-			if (faila > failb)
-				swap(faila, failb);
-
-			/* if the q stripe is failed, do a pstripe reconstruction
-			 * from the xors.
-			 * If both the q stripe and the P stripe are failed, we're
-			 * here due to a crc mismatch and we can't give them the
-			 * data they want
-			 */
-			if (rbio->bioc->raid_map[failb] == RAID6_Q_STRIPE) {
-				if (rbio->bioc->raid_map[faila] ==
-				    RAID5_P_STRIPE) {
-					err = BLK_STS_IOERR;
-					goto cleanup;
-				}
-				/*
-				 * otherwise we have one bad data stripe and
-				 * a good P stripe.  raid5!
-				 */
-				goto pstripe;
-			}
-
-			if (rbio->bioc->raid_map[failb] == RAID5_P_STRIPE) {
-				raid6_datap_recov(rbio->real_stripes,
-						  sectorsize, faila, pointers);
-			} else {
-				raid6_2data_recov(rbio->real_stripes,
-						  sectorsize, faila, failb,
-						  pointers);
-			}
-		} else {
-			void *p;
-
-			/* rebuild from P stripe here (raid5 or raid6) */
-			BUG_ON(failb != -1);
-pstripe:
-			/* Copy parity block into failed block to start with */
-			memcpy(pointers[faila], pointers[rbio->nr_data], sectorsize);
-
-			/* rearrange the pointer array */
-			p = pointers[faila];
-			for (stripe = faila; stripe < rbio->nr_data - 1; stripe++)
-				pointers[stripe] = pointers[stripe + 1];
-			pointers[rbio->nr_data - 1] = p;
-
-			/* xor in the rest */
-			run_xor(pointers, rbio->nr_data - 1, sectorsize);
-		}
-
-		/*
-		 * No matter if this is a RMW or recovery, we should have all
-		 * failed sectors repaired, thus they are now uptodate.
-		 * Especially if we determine to cache the rbio, we need to
-		 * have at least all data sectors uptodate.
-		 */
-		for (i = 0;  i < rbio->stripe_nsectors; i++) {
-			if (faila != -1) {
-				sector = rbio_stripe_sector(rbio, faila, i);
-				sector->uptodate = 1;
-			}
-			if (failb != -1) {
-				sector = rbio_stripe_sector(rbio, failb, i);
-				sector->uptodate = 1;
-			}
-		}
-		for (stripe = rbio->real_stripes - 1; stripe >= 0; stripe--)
-			kunmap_local(unmap_array[stripe]);
-	}
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
+		recover_vertical(rbio, sectornr, pointers, unmap_array);
 
 	err = BLK_STS_OK;
+
 cleanup:
 	kfree(unmap_array);
-cleanup_pointers:
 	kfree(pointers);
 
-cleanup_io:
 	/*
 	 * Similar to READ_REBUILD, REBUILD_MISSING at this point also has a
 	 * valid rbio which is consistent with ondisk content, thus such a
-- 
2.38.1

