Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358F53B497
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiFBHvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFBHvo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:51:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC041EE
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:51:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3052B1F99E
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654156302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83SOTEGmpGPk8XwGmBbUzZASoag2rFvTS90BN+fAHBM=;
        b=Gzl8HpXkQqlKbsy4wDEVb5YShqYwwWFwQv0ZUggf54ulJpGb9dIi9fXPxLBoYu1lg2ISbM
        hCp8+6CTHEBWGUsxKotC6w/bZ1VSuhdrRe2cgnkOX63otXdMKGVZLrUY0Lk6GNuyDcqyCe
        Bc1pfyogYJ+Dy6fmSchr7CMW0IRe6c8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 766B4134F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gGcxDw1smGI7GAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:51:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: avoid double for loop inside finish_rmw()
Date:   Thu,  2 Jun 2022 15:51:18 +0800
Message-Id: <f372e2e97d0bebc9a89f7a338659be436a5fb807.1654156185.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654156185.git.wqu@suse.com>
References: <cover.1654156185.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can easily calculate the stripe number and sector number inside the
stripe.

Thus there is not much need for a double for loop.

For the only case we want to skip the whole stripe, we can manually
increase @total_sector_nr.
This is not a recommended behavior, thus every time the iterator get
modified there will be a comment along with an ASSERT() for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 94 +++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 03e82707d856..91b53ef20b0e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1185,7 +1185,10 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	const u32 sectorsize = bioc->fs_info->sectorsize;
 	void **pointers = rbio->finish_pointers;
 	int nr_data = rbio->nr_data;
+	/* The total sector number inside the full stripe. */
+	int total_sector_nr;
 	int stripe;
+	/* Sector number inside a stripe. */
 	int sectornr;
 	bool has_qstripe;
 	struct bio_list bio_list;
@@ -1270,63 +1273,74 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	}
 
 	/*
-	 * time to start writing.  Make bios for everything from the
+	 * Time to start writing.  Make bios for everything from the
 	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
 	 * everything else.
 	 */
-	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-			struct sector_ptr *sector;
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
 
-			/* This vertical stripe has no data, skip it. */
-			if (!test_bit(sectornr, &rbio->dbitmap))
-				continue;
+		stripe = total_sector_nr / rbio->stripe_nsectors;
+		sectornr = total_sector_nr % rbio->stripe_nsectors;
 
-			if (stripe < rbio->nr_data) {
-				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-				if (!sector)
-					continue;
-			} else {
-				sector = rbio_stripe_sector(rbio, stripe, sectornr);
-			}
+		/* This vertical stripe has no data, skip it. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
 
-			ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-						 sectornr, rbio->stripe_len,
-						 REQ_OP_WRITE);
-			if (ret)
-				goto cleanup;
+		if (stripe < rbio->nr_data) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (!sector)
+				continue;
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
 		}
+
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+					 sectornr, rbio->stripe_len,
+					 REQ_OP_WRITE);
+		if (ret)
+			goto cleanup;
 	}
 
 	if (likely(!bioc->num_tgtdevs))
 		goto write_data;
 
-	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		if (!bioc->tgtdev_map[stripe])
-			continue;
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
 
-		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-			struct sector_ptr *sector;
+		stripe = total_sector_nr / rbio->stripe_nsectors;
+		sectornr = total_sector_nr % rbio->stripe_nsectors;
 
-			/* This vertical stripe has no data, skip it. */
-			if (!test_bit(sectornr, &rbio->dbitmap))
-				continue;
+		if (!bioc->tgtdev_map[stripe]) {
+			/*
+			 * We can skip the whole stripe completely, note
+			 * total_sector_nr will be increased by one anyway.
+			 */
+			ASSERT(sectornr == 0);
+			total_sector_nr += rbio->stripe_nsectors - 1;
+			continue;
+		}
 
-			if (stripe < rbio->nr_data) {
-				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-				if (!sector)
-					continue;
-			} else {
-				sector = rbio_stripe_sector(rbio, stripe, sectornr);
-			}
+		/* This vertical stripe has no data, skip it. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
 
-			ret = rbio_add_io_sector(rbio, &bio_list, sector,
-					       rbio->bioc->tgtdev_map[stripe],
-					       sectornr, rbio->stripe_len,
-					       REQ_OP_WRITE);
-			if (ret)
-				goto cleanup;
+		if (stripe < rbio->nr_data) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (!sector)
+				continue;
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
 		}
+
+		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+				       rbio->bioc->tgtdev_map[stripe],
+				       sectornr, rbio->stripe_len,
+				       REQ_OP_WRITE);
+		if (ret)
+			goto cleanup;
 	}
 
 write_data:
-- 
2.36.1

