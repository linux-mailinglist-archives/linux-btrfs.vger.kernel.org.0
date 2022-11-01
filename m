Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DEB61484F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKALQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKALQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AC17E15
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1A3F338F7
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNFCCiTX9QpDLXV043Z0e0SwCh5I2/XWOIYiB1xn+rc=;
        b=qjH3wOwMvvl4zszUZo6mNo9oXLniWPpVctp02tLf4dLa6ElaPgqmIOSCmNjYsbv+wt6OW7
        do9ftUjV6EGu7GMdNk2r2NkoLsBTKiRuXSKRAVN7n9HyIJQQ58UBCcOa6A40UQcqYJBM6W
        7nhxl5D1MEwDQ93TdtBhuZzKtIP61q8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A8FF1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OAW1AwAAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/12] btrfs: raid56: extract the pq generation code into a helper
Date:   Tue,  1 Nov 2022 19:16:02 +0800
Message-Id: <a0cf4976feb564d886e45798400eddee4bb385ee.1667300355.git.wqu@suse.com>
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

Currently finish_rmw() will updates the P/Q stripes before submitting
the writes.

It's done behind a for(;;) loop, it's a little congested indent-wise, so
extract the code into a helper called generate_pq_vertical().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 90 +++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 85b883a21baa..fe525fe9338f 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1193,6 +1193,48 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
 	trace_info->stripe_nr = -1;
 }
 
+/* Generate PQ for one veritical stripe. */
+static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
+{
+	void **pointers = rbio->finish_pointers;
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	struct sector_ptr *sector;
+	int stripe;
+	const bool has_qstripe = rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6;
+
+	/* First collect one sector from each data stripe */
+	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
+		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
+		pointers[stripe] = kmap_local_page(sector->page) +
+				   sector->pgoff;
+	}
+
+	/* Then add the parity stripe */
+	sector = rbio_pstripe_sector(rbio, sectornr);
+	sector->uptodate = 1;
+	pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
+
+	if (has_qstripe) {
+		/*
+		 * RAID6, add the qstripe and call the library function
+		 * to fill in our p/q
+		 */
+		sector = rbio_qstripe_sector(rbio, sectornr);
+		sector->uptodate = 1;
+		pointers[stripe++] = kmap_local_page(sector->page) +
+				     sector->pgoff;
+
+		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
+					pointers);
+	} else {
+		/* raid5 */
+		memcpy(pointers[rbio->nr_data], pointers[0], sectorsize);
+		run_xor(pointers + 1, rbio->nr_data - 1, sectorsize);
+	}
+	for (stripe = stripe - 1; stripe >= 0; stripe--)
+		kunmap_local(pointers[stripe]);
+}
+
 /*
  * this is called from one of two situations.  We either
  * have a full stripe from the higher layers, or we've read all
@@ -1204,28 +1246,17 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
-	const u32 sectorsize = bioc->fs_info->sectorsize;
-	void **pointers = rbio->finish_pointers;
-	int nr_data = rbio->nr_data;
 	/* The total sector number inside the full stripe. */
 	int total_sector_nr;
 	int stripe;
 	/* Sector number inside a stripe. */
 	int sectornr;
-	bool has_qstripe;
 	struct bio_list bio_list;
 	struct bio *bio;
 	int ret;
 
 	bio_list_init(&bio_list);
 
-	if (rbio->real_stripes - rbio->nr_data == 1)
-		has_qstripe = false;
-	else if (rbio->real_stripes - rbio->nr_data == 2)
-		has_qstripe = true;
-	else
-		BUG();
-
 	/* We should have at least one data sector. */
 	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
 
@@ -1258,41 +1289,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	else
 		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-		struct sector_ptr *sector;
-
-		/* First collect one sector from each data stripe */
-		for (stripe = 0; stripe < nr_data; stripe++) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_page(sector->page) +
-					   sector->pgoff;
-		}
-
-		/* Then add the parity stripe */
-		sector = rbio_pstripe_sector(rbio, sectornr);
-		sector->uptodate = 1;
-		pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
-
-		if (has_qstripe) {
-			/*
-			 * RAID6, add the qstripe and call the library function
-			 * to fill in our p/q
-			 */
-			sector = rbio_qstripe_sector(rbio, sectornr);
-			sector->uptodate = 1;
-			pointers[stripe++] = kmap_local_page(sector->page) +
-					     sector->pgoff;
-
-			raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
-						pointers);
-		} else {
-			/* raid5 */
-			memcpy(pointers[nr_data], pointers[0], sectorsize);
-			run_xor(pointers + 1, nr_data - 1, sectorsize);
-		}
-		for (stripe = stripe - 1; stripe >= 0; stripe--)
-			kunmap_local(pointers[stripe]);
-	}
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
+		generate_pq_vertical(rbio, sectornr);
 
 	/*
 	 * Start writing.  Make bios for everything from the higher layers (the
-- 
2.38.1

