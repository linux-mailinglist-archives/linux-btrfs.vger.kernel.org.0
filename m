Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9B60DA6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiJZFGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiJZFGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20458DE7
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7747822040
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6NAyeDkUSasEFCQW9LgNO8moqhV6Ud1nvMXLoHXPDA=;
        b=SaHIdtboBZQtnzmwnStpt9RjeLCPVJxB5JNNhy99zg+rObXlPIa20i+8irTD4Xe+IYMVb1
        a/Xd5Rmikg4/8rkpIWsazTACNoz9PxsGj4c78awHFw4QLOupxXQwMtc+K1EVE5nQZtkB1L
        VqW1XwSjGVuSwbp0+gzVV0ZTzm73poA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C05BD13A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eF+DIlzAWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: raid56: extract the pq generation code into a helper
Date:   Wed, 26 Oct 2022 13:06:26 +0800
Message-Id: <1057ff2dd342d3dc742db14e18d0b2bc0e1735aa.1666760699.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1666760699.git.wqu@suse.com>
References: <cover.1666760699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently finish_rmw() will updates the P/Q stripes before submitting
the writes.

It's done behind a for loop, it's a little congested indent wise, so
extract the code into a helper called generate_pq_vertical().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 90 +++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 085c549a09a9..acf36fcaa9f2 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1192,6 +1192,48 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
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
@@ -1203,28 +1245,17 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
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
 
@@ -1257,41 +1288,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
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

