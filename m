Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0753B49A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiFBHvs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiFBHvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:51:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE61B3DDEC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:51:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABF7421A17
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654156305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q09f6YW9ij7TBav61UHkvLWj78R75hIyaYnVHzIUoTE=;
        b=pessrs9sm5k3FjXcAHoVzXESvjRqOM3452NzvZBuBdwYMX3QCXgJht2/z0GIVGNaeb5G54
        Nc+ZPe7OpGMH5Je8ONbsI30SWlMQ+EcOlmFI/I92ds6vYNRj7YFGJe2SAw4nIVpcTIGn3C
        u5PMR7arfyfdzmwGg8vPHbXXSRs6xLo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE937134F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Is9LBBsmGI7GAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:51:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: avoid double for loop inside raid56_rmw_stripe()
Date:   Thu,  2 Jun 2022 15:51:21 +0800
Message-Id: <f274486d48f52a96b20c50f8010389639486767d.1654156185.git.wqu@suse.com>
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

This function doesn't even utilize full stripe skip, just iterate all
the sectors is definitely enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 58 ++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1df5f1208e8b..5feb6b668829 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1548,8 +1548,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int sectornr;
-	int stripe;
+	int total_sector_nr;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -1561,38 +1560,35 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	index_rbio_pages(rbio);
 
 	atomic_set(&rbio->error, 0);
-	/*
-	 * build a list of bios to read all the missing parts of this
-	 * stripe
-	 */
-	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
-		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-			struct sector_ptr *sector;
+	/* Build a list of bios to read all the missing parts. */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
 
-			/*
-			 * We want to find all the sectors missing from the
-			 * rbio and read them from the disk.  If * sector_in_rbio()
-			 * finds a page in the bio list we don't need to read
-			 * it off the stripe.
-			 */
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (sector)
-				continue;
+		/*
+		 * We want to find all the sectors missing from the rbio and
+		 * read them from the disk.  If sector_in_rbio() finds a page
+		 * in the bio list we don't need to read it off the stripe.
+		 */
+		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+		if (sector)
+			continue;
 
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
-			/*
-			 * The bio cache may have handed us an uptodate page.
-			 * If so, be happy and use it.
-			 */
-			if (sector->uptodate)
-				continue;
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		/*
+		 * The bio cache may have handed us an uptodate page.
+		 * If so, be happy and use it.
+		 */
+		if (sector->uptodate)
+			continue;
 
-			ret = rbio_add_io_sector(rbio, &bio_list, sector,
-				       stripe, sectornr, rbio->stripe_len,
-				       REQ_OP_READ);
-			if (ret)
-				goto cleanup;
-		}
+		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+			       stripe, sectornr, rbio->stripe_len,
+			       REQ_OP_READ);
+		if (ret)
+			goto cleanup;
 	}
 
 	bios_to_read = bio_list_size(&bio_list);
-- 
2.36.1

