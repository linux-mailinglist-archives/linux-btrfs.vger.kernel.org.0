Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A328754252D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiFHDRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349627AbiFHDPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:15:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF814144FF6
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:35:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31CFD1FA16
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654648499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvI3Nk5WuscPYvv1MGWYBG2MOAD7yQhsjag9W/r/vAU=;
        b=Ly62nzABjl39CInhrF3Dh/M5YD/WhudzH4GPV1V6dYVqunmr4Lww8IpTPO/uE1dBFm5uQM
        AmnMYoZxrzSS2TAroAU+lkNcEaQWnUnwdDAp6OF4gWFZLT72ek/OYS23ujVDa9vH56YQ0M
        quhp5ZsHN+2B4NOetbmQwZ/TLfCivq4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87557137FA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIivFLLun2LiHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 00:34:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/5] btrfs: avoid double for loop inside raid56_rmw_stripe()
Date:   Wed,  8 Jun 2022 08:34:35 +0800
Message-Id: <3dc86c8c745b6dce7e0dd32dc8d1d5007c284374.1654648358.git.wqu@suse.com>
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

This function doesn't even utilize full stripe skip, just iterate all
the data sectors is definitely enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 59 ++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 29b623be5b61..61e86920271d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1548,9 +1548,9 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 {
 	int bios_to_read = 0;
 	struct bio_list bio_list;
+	const int nr_data_sectors = rbio->stripe_nsectors * rbio->nr_data;
 	int ret;
-	int sectornr;
-	int stripe;
+	int total_sector_nr;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -1562,38 +1562,35 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	index_rbio_pages(rbio);
 
 	atomic_set(&rbio->error, 0);
-	/*
-	 * build a list of bios to read all the missing parts of this
-	 * stripe
-	 */
-	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
-		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-			struct sector_ptr *sector;
+	/* Build a list of bios to read all the missing data sectors. */
+	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
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

