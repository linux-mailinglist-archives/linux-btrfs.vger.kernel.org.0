Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475E5424CB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiFHDRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 23:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbiFHDO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 23:14:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55A106344
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 17:35:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C81F1FA12
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654648497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/FrlPzDyqiyBP057q1SCzYhdovsti5sasNO7d8VTVk=;
        b=Scrvd66nlvdZnZKwUW0jjCGJagHQ3COeMmUA7QVr/s9zJQ5zoI0sHmL28ILjeWLC523AeS
        9QAUFan+KeeVT5acD/ctGPvKbZSVgiyq146X/bji2vFg8C8quhuaShGhalZTQPrpZztGZn
        smcsN1ALOFFjq8CsJkStbL4g5gUkmD8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 730E4137FA
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 00:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4FmED7Dun2LiHQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 00:34:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/5] btrfs: avoid double for loop inside __raid56_parity_recover()
Date:   Wed,  8 Jun 2022 08:34:33 +0800
Message-Id: <5b8eef23d19d6c4a7c7b751f713849a22c887283.1654648358.git.wqu@suse.com>
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
index c79c6ae1e2c7..b5fcc6dd1c0f 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2116,8 +2116,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int sectornr;
-	int stripe;
+	int total_sector_nr;
 	struct bio *bio;
 
 	bio_list_init(&bio_list);
@@ -2133,29 +2132,29 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
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

