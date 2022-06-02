Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F313E53B498
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiFBHvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiFBHvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:51:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A351EE
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:51:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D602C1F9B9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654156306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HuZ6/Qu0bdiftmJx/OPfB9zWieAl0NHPgWLHx2xsZVs=;
        b=nxGc0VsNeazF+jjn5OreCd81mCO4AM5YLg1mJLs81YokyhLmnVD5izkmaTyeo9hoqSnXHw
        LxDSnXVkrvHSiP3XPEBuNrklLrtGHT4jPmGEDGROmcK2Rda+betoLUF4M3loBqb8sXriN6
        2QG2EykwAeDoDlAQnQuYlbgV0f4LjK4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2490F134F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KNymNhFsmGI7GAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:51:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: avoid double for loop inside raid56_parity_scrub_stripe()
Date:   Thu,  2 Jun 2022 15:51:22 +0800
Message-Id: <161a6074a01789027b4a08fb125e1f0ee2dd9318.1654156185.git.wqu@suse.com>
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

Originally it's iterating all the sectors which has dbitmap sector for
the vertical stripe.

It can be easily converted to sector bytenr iteration with an test_bit()
call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 63 ++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5feb6b668829..0f557dd483c2 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2681,8 +2681,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int sectornr;
-	int stripe;
+	int total_sector_nr;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -2692,37 +2691,39 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
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

