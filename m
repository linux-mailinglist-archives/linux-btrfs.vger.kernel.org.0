Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58264614851
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiKALQ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKALQX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8218B0A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4207533883
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9Vuahsa+ALwrwjj/d3F7BToFt7VhkMa8SHVuEHZ2zg=;
        b=jbTsSN+8Xrr7eq8v9XY3+34C1tpRXFxukIGDahmgybmFj9PUuW3KgoJAmlrkS07tupzQKt
        9t75rDuRXXU/FXPTFXL3AIV0InJb2x2//Wwbqcr6tVHRiRLXbSH00volK6oieOyeXvO4Gh
        z03ihD20ezkT/2+TMHrV7BOk9Bl21Go=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACCEC1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6NaFHwQAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/12] btrfs: raid56: extract rwm write bios assembly into a helper
Date:   Tue,  1 Nov 2022 19:16:07 +0800
Message-Id: <5a672330a861939cffbfc010d6073363c82d6df7.1667300355.git.wqu@suse.com>
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

The helper will be later used to refactor the rmw write path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 165 ++++++++++++++++++++++++++--------------------
 1 file changed, 94 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3133c9706da4..de986bbe43fc 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1237,6 +1237,97 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		kunmap_local(pointers[stripe]);
 }
 
+static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
+				   struct bio_list *bio_list)
+{
+	struct bio *bio;
+	/* The total sector number inside the full stripe. */
+	int total_sector_nr;
+	int sectornr;
+	int stripe;
+	int ret;
+
+	ASSERT(bio_list_size(bio_list) == 0);
+
+	/* We should have at least one data sector. */
+	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
+
+	/*
+	 * Start assembly.  Make bios for everything from the higher layers (the
+	 * bio_list in our rbio) and our P/Q.  Ignore everything else.
+	 */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+
+		stripe = total_sector_nr / rbio->stripe_nsectors;
+		sectornr = total_sector_nr % rbio->stripe_nsectors;
+
+		/* This vertical stripe has no data, skip it. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
+
+		if (stripe < rbio->nr_data) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (!sector)
+				continue;
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		}
+
+		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
+					 sectornr, REQ_OP_WRITE);
+		if (ret)
+			goto error;
+	}
+
+	if (likely(!rbio->bioc->num_tgtdevs))
+		return 0;
+
+	/* Make a copy for the replace target device. */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+
+		stripe = total_sector_nr / rbio->stripe_nsectors;
+		sectornr = total_sector_nr % rbio->stripe_nsectors;
+
+		if (!rbio->bioc->tgtdev_map[stripe]) {
+			/*
+			 * We can skip the whole stripe completely, note
+			 * total_sector_nr will be increased by one anyway.
+			 */
+			ASSERT(sectornr == 0);
+			total_sector_nr += rbio->stripe_nsectors - 1;
+			continue;
+		}
+
+		/* This vertical stripe has no data, skip it. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
+
+		if (stripe < rbio->nr_data) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (!sector)
+				continue;
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		}
+
+		ret = rbio_add_io_sector(rbio, bio_list, sector,
+					 rbio->bioc->tgtdev_map[stripe],
+					 sectornr, REQ_OP_WRITE);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+error:
+	while ((bio = bio_list_pop(bio_list)))
+		bio_put(bio);
+	return -EIO;
+}
+
 /*
  * this is called from one of two situations.  We either
  * have a full stripe from the higher layers, or we've read all
@@ -1247,10 +1338,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
  */
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 {
-	struct btrfs_io_context *bioc = rbio->bioc;
 	/* The total sector number inside the full stripe. */
-	int total_sector_nr;
-	int stripe;
 	/* Sector number inside a stripe. */
 	int sectornr;
 	struct bio_list bio_list;
@@ -1294,75 +1382,10 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
 		generate_pq_vertical(rbio, sectornr);
 
-	/*
-	 * Start writing.  Make bios for everything from the higher layers (the
-	 * bio_list in our rbio) and our P/Q.  Ignore everything else.
-	 */
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
+	ret = rmw_assemble_write_bios(rbio, &bio_list);
+	if (ret < 0)
+		goto cleanup;
 
-		stripe = total_sector_nr / rbio->stripe_nsectors;
-		sectornr = total_sector_nr % rbio->stripe_nsectors;
-
-		/* This vertical stripe has no data, skip it. */
-		if (!test_bit(sectornr, &rbio->dbitmap))
-			continue;
-
-		if (stripe < rbio->nr_data) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (!sector)
-				continue;
-		} else {
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		}
-
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-					 sectornr, REQ_OP_WRITE);
-		if (ret)
-			goto cleanup;
-	}
-
-	if (likely(!bioc->num_tgtdevs))
-		goto write_data;
-
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
-
-		stripe = total_sector_nr / rbio->stripe_nsectors;
-		sectornr = total_sector_nr % rbio->stripe_nsectors;
-
-		if (!bioc->tgtdev_map[stripe]) {
-			/*
-			 * We can skip the whole stripe completely, note
-			 * total_sector_nr will be increased by one anyway.
-			 */
-			ASSERT(sectornr == 0);
-			total_sector_nr += rbio->stripe_nsectors - 1;
-			continue;
-		}
-
-		/* This vertical stripe has no data, skip it. */
-		if (!test_bit(sectornr, &rbio->dbitmap))
-			continue;
-
-		if (stripe < rbio->nr_data) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (!sector)
-				continue;
-		} else {
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		}
-
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
-					 rbio->bioc->tgtdev_map[stripe],
-					 sectornr, REQ_OP_WRITE);
-		if (ret)
-			goto cleanup;
-	}
-
-write_data:
 	atomic_set(&rbio->stripes_pending, bio_list_size(&bio_list));
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
-- 
2.38.1

