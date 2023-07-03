Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF7745621
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGCHdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGCHdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184FE5D
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 982BB1F8B4
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1GHaYZFWXJD/qRSi9l2fwrNwMSQrKAsf8uX196ZxxE=;
        b=UdtKrJVubbv/vPGajNkx0shFpjRSGKo9PFc6/CljLgPTr4mhw3WPaXexeLEZaHJYSerQho
        NPzNwAcCFGBbNyyTfC38iTjHDwe6HT2joG9LwPC+f05/l8zKuddqm/fsvIInBXjODmQO9j
        EadroRrnDQMoUyVIOMBsTnuEla+vd7Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3D4713276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kJoEK6p5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:32:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/14] btrfs: raid56: allow scrub operation to update both P and Q stripes
Date:   Mon,  3 Jul 2023 15:32:26 +0800
Message-ID: <af2b86a9089423882813409531e3bcd1d8479b38.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

Current the scrub_rbio() workload (used by
raid56_parity_alloc_scrub_rbio() then
raid56_parity_submit_scrub_rbio()) can only handle one P/Q stripe
workload.

But inside finish_parity_scrub() we always do the P/Q generation and
verification for both P/Q stripes.

For the incoming scrub_logical feature, we want to verify P/Q stripes in
one go, so here we introduce the ability to scrub both P/Q stripes.

To do that the following things are modified:

- raid56_parity_alloc_scrub_rbio() to allows empty @scrub_dev
  Thankfully we don't have any extra sanity checks to reject such
  empty parameter.

- Verify both P and Q stripes if @rbio->scrubp is 0
  Now we do the verification in a loop, and skip the stripe if
  rbio->scrubp is not zero and does not match the stripe number.

- Add bad sectors of both P/Q stripes to writeback
  Unfortunately we're using the same dbitmap, this means if only one
  of the P/Q stripes is corrupted, we would write both.
  However we can accept the slightly extra cost for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 56 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index cc783da065b4..d96bfc3a16fc 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2363,7 +2363,14 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 			break;
 		}
 	}
-	ASSERT(i < rbio->real_stripes);
+	/*
+	 * If @scrub_dev is specified, @scrubp must be the stripe number of
+	 * P or Q stripe.
+	 */
+	if (scrub_dev) {
+		ASSERT(rbio->scrubp >= rbio->nr_data);
+		ASSERT(rbio->scrubp < rbio->real_stripes);
+	}
 
 	bitmap_copy(&rbio->dbitmap, dbitmap, rbio->stripe_nsectors);
 	return rbio;
@@ -2426,7 +2433,8 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * Replace is running and our P/Q stripe is being replaced, then we
 	 * need to duplicate the final write to replace target.
 	 */
-	if (bioc->replace_nr_stripes && bioc->replace_stripe_src == rbio->scrubp) {
+	if (rbio->scrubp && bioc->replace_nr_stripes &&
+	    bioc->replace_stripe_src == rbio->scrubp) {
 		is_replace = 1;
 		bitmap_copy(pbitmap, &rbio->dbitmap, rbio->stripe_nsectors);
 	}
@@ -2464,6 +2472,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
+		bool found_error = false;
 		void *parity;
 
 		/* first collect one page from each data stripe */
@@ -2484,14 +2493,22 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 		}
 
 		/* Check scrubbing parity and repair it */
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		parity = kmap_local_page(sector->page) + sector->pgoff;
-		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
-			memcpy(parity, pointers[rbio->scrubp], sectorsize);
-		else
+		for (int i = rbio->nr_data; i < rbio->real_stripes; i++) {
+			/* Skip this stripe if it's not our scrub target. */
+			if (rbio->scrubp && i != rbio->scrubp)
+				continue;
+
+			sector = rbio_stripe_sector(rbio, i, sectornr);
+			parity = kmap_local_page(sector->page) + sector->pgoff;
+			if (memcmp(parity, pointers[i], sectorsize) != 0) {
+				memcpy(parity, pointers[i], sectorsize);
+				found_error = true;
+			}
+			kunmap_local(parity);
+		}
+		if (!found_error)
 			/* Parity is right, needn't writeback */
 			bitmap_clear(&rbio->dbitmap, sectornr, 1);
-		kunmap_local(parity);
 
 		for (stripe = nr_data - 1; stripe >= 0; stripe--)
 			kunmap_local(pointers[stripe]);
@@ -2514,11 +2531,16 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
-					 sectornr, REQ_OP_WRITE);
-		if (ret)
-			goto cleanup;
+		for (int i = rbio->nr_data; i < rbio->real_stripes; i++) {
+			/* Skip this stripe if it's not our scrub target. */
+			if (rbio->scrubp && i != rbio->scrubp)
+				continue;
+			sector = rbio_stripe_sector(rbio, i, sectornr);
+			ret = rbio_add_io_sector(rbio, &bio_list, sector, i,
+						 sectornr, REQ_OP_WRITE);
+			if (ret)
+				goto cleanup;
+		}
 	}
 
 	if (!is_replace)
@@ -2529,6 +2551,12 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * the target device.  Check we have a valid source stripe number.
 	 */
 	ASSERT(rbio->bioc->replace_stripe_src >= 0);
+	/*
+	 * For dev-replace case, scrubp must be provided by the caller at
+	 * raid56_parity_alloc_scrub_rbio().
+	 */
+	ASSERT(rbio->scrubp >= rbio->nr_data);
+	ASSERT(rbio->scrubp < rbio->real_stripes);
 	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 
@@ -2625,7 +2653,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 		 * scrubbing parity, luckily, use the other one to repair the
 		 * data, or we can not repair the data stripe.
 		 */
-		if (failp != rbio->scrubp) {
+		if (rbio->scrubp && failp != rbio->scrubp) {
 			ret = -EIO;
 			goto out;
 		}
-- 
2.41.0

