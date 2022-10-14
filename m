Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE825FE956
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 09:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJNHRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 03:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJNHRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 03:17:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250EC32D94
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 00:17:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFF7A22013
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665731853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHrwGkYk1/BCWBJQu4asFmmiFCGKJPGcRT1pcYmErFA=;
        b=lpwAm7cs+R+j3nyOWvCidXUa5+YIgR4KDXBKxHEvZAY1LsYI9ILUdnlNmhNi3tWCiakJE5
        6Edb+KlQjfFsWT71lzSu2FWWqBURDxp+2Xb/rScmZ2cu3vbfMs2dda6g/7bTJG1nEKAn0U
        hrVkTkB5FqsfRdhyxIs7rXJ2d9jNQiA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D19413451
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qD+wMAwNSWOsUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:17:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/5] btrfs: raid56: refactor __raid_recover_end_io()
Date:   Fri, 14 Oct 2022 15:17:10 +0800
Message-Id: <6cbdf72be1c531f62dba95803c4ed7c32018506d.1665730948.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665730948.git.wqu@suse.com>
References: <cover.1665730948.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 277 ++++++++++++++++++++++++----------------------
 1 file changed, 146 insertions(+), 131 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c009c0a2081e..1b2899173ae1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1885,6 +1885,127 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
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
@@ -1892,11 +2013,9 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
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
 	int i;
 
@@ -1907,7 +2026,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
 	if (!pointers) {
 		err = BLK_STS_RESOURCE;
-		goto cleanup_io;
+		goto cleanup;
 	}
 
 	/*
@@ -1917,11 +2036,12 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
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
@@ -1932,138 +2052,33 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 
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
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
+		recover_vertical(rbio, sectornr, pointers, unmap_array);
 
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
+	/*
+	 * No matter if this is a RMW or recovery, we should have all
+	 * failed sectors repaired, thus they are now uptodate.
+	 * Especially if we determine to cache the rbio, we need to
+	 * have at least all data sectors uptodate.
+	 */
+	for (i = 0;  i < rbio->stripe_nsectors; i++) {
+		struct sector_ptr *sector;
 
-			/* xor in the rest */
-			run_xor(pointers, rbio->nr_data - 1, sectorsize);
+		if (rbio->faila != -1) {
+			sector = rbio_stripe_sector(rbio, rbio->faila, i);
+			sector->uptodate = 1;
 		}
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
+		if (rbio->failb != -1) {
+			sector = rbio_stripe_sector(rbio, rbio->failb, i);
+			sector->uptodate = 1;
 		}
-		for (stripe = rbio->real_stripes - 1; stripe >= 0; stripe--)
-			kunmap_local(unmap_array[stripe]);
 	}
-
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
2.37.3

