Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D674EEC53
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbiDALZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbiDALZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9D1959CD
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5173D1FD03
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkQQYXrG1VfDRfH4N618bb+W0v7MSdIrYhNYZVHJ90k=;
        b=qznkzscKDiMWX0s9BjF7ksPF7SwGMRJHZTJZMCo7T9Vq0kvy2wWDoyx/0QgI6+zzQfiuVq
        3O7wly1lwfP8qomeH/MgpC+07QTNX3OiurqUZGbZJPb8TqWArm8dXpzGbA+SZRZLYjm3sB
        ePLzG80GCq+UeDJ67xV4igiBXhIGJKc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DDB9132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kOhdGs3gRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs: make finish_rmw() subpage compatible
Date:   Fri,  1 Apr 2022 19:23:24 +0800
Message-Id: <911628d0221328e4e5c0bdff58313c0c64485315.1648807440.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648807440.git.wqu@suse.com>
References: <cover.1648807440.git.wqu@suse.com>
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

The trick involved is how we call kunmap_local(), as now the pointers[]
only store the address with @pgoff added, thus they can not be directly
used for kunmap_local().

For the cleanup, we have to re-grab all the sectors and reduce the
@pgoff from pointers[], then call kunmap_local().

With this function converted to subpage compatible sector interfaces,
the following helper functions can be removed:

- rbio_stripe_page()
- rbio_pstripe_page()
- rbio_qstripe_page()
- page_in_rbio()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 127 ++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1fbeaf2909b4..61df2b3636d2 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -683,39 +683,26 @@ static struct sector_ptr *rbio_stripe_sector(const struct btrfs_raid_bio *rbio,
 							      sector_nr)];
 }
 
-static int rbio_stripe_page_index(struct btrfs_raid_bio *rbio, int stripe,
-				  int index)
-{
-	return stripe * rbio->stripe_npages + index;
-}
-
-/*
- * these are just the pages from the rbio array, not from anything
- * the FS sent down to us
- */
-static struct page *rbio_stripe_page(struct btrfs_raid_bio *rbio, int stripe,
-				     int index)
+/* Helper to grab a sector inside P stripe */
+static struct sector_ptr *rbio_pstripe_sector(const struct btrfs_raid_bio *rbio,
+					      unsigned int sector_nr)
 {
-	return rbio->stripe_pages[rbio_stripe_page_index(rbio, stripe, index)];
+	return rbio_stripe_sector(rbio, rbio->nr_data, sector_nr);
 }
 
-/*
- * helper to index into the pstripe
- */
-static struct page *rbio_pstripe_page(struct btrfs_raid_bio *rbio, int index)
+/* Helper to grab a sector inside Q stripe, return NULL if not RAID6 */
+static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
+					      unsigned int sector_nr)
 {
-	return rbio_stripe_page(rbio, rbio->nr_data, index);
+	if (rbio->nr_data + 1 == rbio->real_stripes)
+		return NULL;
+	return rbio_stripe_sector(rbio, rbio->nr_data + 1, sector_nr);
 }
 
-/*
- * helper to index into the qstripe, returns null
- * if there is no qstripe
- */
-static struct page *rbio_qstripe_page(struct btrfs_raid_bio *rbio, int index)
+static int rbio_stripe_page_index(struct btrfs_raid_bio *rbio, int stripe,
+				  int index)
 {
-	if (rbio->nr_data + 1 == rbio->real_stripes)
-		return NULL;
-	return rbio_stripe_page(rbio, rbio->nr_data + 1, index);
+	return stripe * rbio->stripe_npages + index;
 }
 
 /*
@@ -1032,40 +1019,6 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 	return &rbio->stripe_sectors[index];
 }
 
-/*
- * the read/modify/write code wants to use the original bio for
- * any pages it included, and then use the rbio for everything
- * else.  This function decides if a given index (stripe number)
- * and page number in that stripe fall inside the original bio
- * or the rbio.
- *
- * if you set bio_list_only, you'll get a NULL back for any ranges
- * that are outside the bio_list
- *
- * This doesn't take any refs on anything, you get a bare page pointer
- * and the caller must bump refs as required.
- *
- * You must call index_rbio_pages once before you can trust
- * the answers from this function.
- */
-static struct page *page_in_rbio(struct btrfs_raid_bio *rbio,
-				 int index, int pagenr, int bio_list_only)
-{
-	int chunk_page;
-	struct page *p = NULL;
-
-	chunk_page = index * (rbio->stripe_len >> PAGE_SHIFT) + pagenr;
-
-	spin_lock_irq(&rbio->bio_list_lock);
-	p = rbio->bio_pages[chunk_page];
-	spin_unlock_irq(&rbio->bio_list_lock);
-
-	if (p || bio_list_only)
-		return p;
-
-	return rbio->stripe_pages[chunk_page];
-}
-
 /*
  * allocation and initial setup for the btrfs_raid_bio.  Not
  * this does not allocate any pages for rbio->pages.
@@ -1355,6 +1308,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
+	const u32 sectorsize = bioc->fs_info->sectorsize;
 	void **pointers = rbio->finish_pointers;
 	int nr_data = rbio->nr_data;
 	int stripe;
@@ -1403,37 +1357,54 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
 	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-		struct page *p;
-		/* first collect one page from each data stripe */
+		struct sector_ptr *sector;
+
+		/* First collect one sector from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
-			p = page_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_page(p);
+			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
+			pointers[stripe] = kmap_local_page(sector->page) +
+					   sector->pgoff;
 		}
 
-		/* then add the parity stripe */
-		p = rbio_pstripe_page(rbio, sectornr);
-		SetPageUptodate(p);
-		pointers[stripe++] = kmap_local_page(p);
+		/* Then add the parity stripe */
+		sector = rbio_pstripe_sector(rbio, sectornr);
+		sector->uptodate = 1;
+		pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
 
 		if (has_qstripe) {
-
 			/*
-			 * raid6, add the qstripe and call the
+			 * RAID6, add the qstripe and call the
 			 * library function to fill in our p/q
 			 */
-			p = rbio_qstripe_page(rbio, sectornr);
-			SetPageUptodate(p);
-			pointers[stripe++] = kmap_local_page(p);
+			sector = rbio_qstripe_sector(rbio, sectornr);
+			sector->uptodate = 1;
+			pointers[stripe++] = kmap_local_page(sector->page) +
+					     sector->pgoff;
 
-			raid6_call.gen_syndrome(rbio->real_stripes, PAGE_SIZE,
+			raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
 						pointers);
 		} else {
 			/* raid5 */
-			copy_page(pointers[nr_data], pointers[0]);
-			run_xor(pointers + 1, nr_data - 1, PAGE_SIZE);
+			memcpy(pointers[nr_data], pointers[0], sectorsize);
+			run_xor(pointers + 1, nr_data - 1, sectorsize);
+		}
+
+		/*
+		 * Unmap the pointers, need to re-grab those sectors to get
+		 * pgoff and calculate the original mapping address.
+		 * So we need to re-do the data and P/Q iteration.
+		 */
+		for (stripe = 0; stripe < nr_data; stripe++) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
+			kunmap_local(pointers[stripe] - sector->pgoff);
+		}
+		sector = rbio_pstripe_sector(rbio, sectornr);
+		kunmap_local(pointers[stripe] - sector->pgoff);
+		stripe++;
+		if (has_qstripe) {
+			sector = rbio_qstripe_sector(rbio, sectornr);
+			kunmap_local(pointers[stripe] - sector->pgoff);
 		}
-		for (stripe = stripe - 1; stripe >= 0; stripe--)
-			kunmap_local(pointers[stripe]);
 	}
 
 	/*
-- 
2.35.1

