Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEB53B499
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiFBHvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFBHvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 03:51:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A053DDEC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 00:51:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59A4C219B8
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654156303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGC3ior9J0eMhjsh4eGUZfNR+dgiwlpd1boXY32+//E=;
        b=S+e5Dz9uyoI4pkrMw239XPP0x5ycEY9lOgWloawTjEhMLRsmDjUIZH5lW98xc0kDJoDDNy
        h8GqzszsY+S1f3pO7/aV56Db/2Mzf0DRXGyjNh3SzYzRe0RdnUQpyG2l3yE1DLZTzL/Y9j
        gI7PDJzQzC8OJYEoUnNjbcyqfbPvljs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D355134F3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gNePGA5smGI7GAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:51:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: avoid double for loop inside __raid56_parity_recover()
Date:   Thu,  2 Jun 2022 15:51:19 +0800
Message-Id: <475aa584548807cf543f2f8d4cd6ef231a9028bb.1654156185.git.wqu@suse.com>
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

The double for loop can be easily converted to single for loop as we're
really iterating the sectors in their bytenr order.

The only exception is the full stripe skip, however that can also easily
be done inside the loop.
Add an ASSERT() along with a comment for that specific case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 91b53ef20b0e..8d06be2153db 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2127,8 +2127,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int sectornr;
-	int stripe;
+	int total_sector_nr;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -2144,29 +2143,29 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 * stripe cache, it is possible that some or all of these
 	 * pages are going to be uptodate.
 	 */
-	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+		struct sector_ptr *sector;
+
 		if (rbio->faila == stripe || rbio->failb == stripe) {
 			atomic_inc(&rbio->error);
+			/* Skip the current stripe. */
+			ASSERT(sectornr == 0);
+			total_sector_nr += rbio->stripe_nsectors - 1;
 			continue;
 		}
+		/* The rmw code may have already read this page in. */
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		if (sector->uptodate)
+			continue;
 
-		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-			struct sector_ptr *sector;
-
-			/*
-			 * the rmw code may have already read this
-			 * page in
-			 */
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
-			if (sector->uptodate)
-				continue;
-
-			ret = rbio_add_io_sector(rbio, &bio_list, sector,
-						 stripe, sectornr, rbio->stripe_len,
-						 REQ_OP_READ);
-			if (ret < 0)
-				goto cleanup;
-		}
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+					 sectornr, rbio->stripe_len,
+					 REQ_OP_READ);
+		if (ret < 0)
+			goto cleanup;
 	}
 
 	bios_to_read = bio_list_size(&bio_list);
-- 
2.36.1

