Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFB354245A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiFHDRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349776AbiFHDPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:15:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E020A157E9B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:35:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B81A1FA1A
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654648500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnYj6iOE12131T9LuQyxu//YjSkDLxvyCgKwMxEPivU=;
        b=q22R/344Hb9alOX7FGDYX0xArwwCy6u3KSR+beUbjb1Yv6qVY9Qxpw+I+2ormCJBQ5FkPF
        Fed7rlUPQXZkNEO+JjX3SQHevChqer4RD550LaB5tMFBijVa4lDitAbuDlMcwgZWkTTiEW
        xPi599E8ZMSMyNPEOMPFz7/WTkeKiqc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 932A0137FA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKZ6F7Pun2LiHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 00:34:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/5] btrfs: avoid double for loop inside raid56_parity_scrub_stripe()
Date:   Wed,  8 Jun 2022 08:34:36 +0800
Message-Id: <b3dabb44fdee011237e13066b64f87ffb4ab263f.1654648358.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654648358.git.wqu@suse.com>
References: <cover.1654648358.git.wqu@suse.com>
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

Originally it's iterating all the sectors which has dbitmap sector for
the vertical stripe.

It can be easily converted to sector bytenr iteration with an test_bit()
call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 63 ++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 61e86920271d..c1f61d1708ee 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2662,8 +2662,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int sectornr;
-	int stripe;
+	int total_sector_nr;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -2673,37 +2672,39 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 		goto cleanup;
 
 	atomic_set(&rbio->error, 0);
-	/*
-	 * build a list of bios to read all the missing parts of this
-	 * stripe
-	 */
-	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-			struct sector_ptr *sector;
-			/*
-			 * We want to find all the sectors missing from the
-			 * rbio and read them from the disk.  If * sector_in_rbio()
-			 * finds a sector in the bio list we don't need to read
-			 * it off the stripe.
-			 */
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (sector)
-				continue;
+	/* Build a list of bios to read all the missing parts. */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		struct sector_ptr *sector;
 
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
-			/*
-			 * The bio cache may have handed us an uptodate sector.
-			 * If so, be happy and use it.
-			 */
-			if (sector->uptodate)
-				continue;
+		/* No data in the vertical stripe, no need to read. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
 
-			ret = rbio_add_io_sector(rbio, &bio_list, sector,
-						 stripe, sectornr, rbio->stripe_len,
-						 REQ_OP_READ);
-			if (ret)
-				goto cleanup;
-		}
+		/*
+		 * We want to find all the sectors missing from the rbio and
+		 * read them from the disk. If sector_in_rbio() finds a sector
+		 * in the bio list we don't need to read it off the stripe.
+		 */
+		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+		if (sector)
+			continue;
+
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		/*
+		 * The bio cache may have handed us an uptodate sector.
+		 * If so, be happy and use it.
+		 */
+		if (sector->uptodate)
+			continue;
+
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+					 sectornr, rbio->stripe_len,
+					 REQ_OP_READ);
+		if (ret)
+			goto cleanup;
 	}
 
 	bios_to_read = bio_list_size(&bio_list);
-- 
2.36.1

