Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8244FDCA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiDLKhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354439AbiDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C524B5622D
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85E8A1F868
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JnavMaJ+S/+lrV/5yld7BQI92vg3dRO35Iatv6GdQLg=;
        b=cFWB/Vxi9ldK7x0DXGzgbyPPLo5d0mmKKEMAKIaJ02LpHNLeVZ7M7hPXoQWKzDhuGGdIM9
        o2cFUFy0LwMFKWbSHmEfDu0zSbYbHW2OEs0BzNkFOQFX1yyo9c97DHvUGdJCoixrP23um3
        QwN0UG/H5T66j8hEvEZQBK/7tRpsth8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFA9B13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ODDNJHBHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/17] btrfs: make finish_rmw() subpage compatible
Date:   Tue, 12 Apr 2022 17:33:00 +0800
Message-Id: <64ef7c98b87001a19ac0d2d9c75faadf9fd9670b.1649753690.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
References: <cover.1649753690.git.wqu@suse.com>
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

With this function converted to subpage compatible sector interfaces,
the following helper functions can be removed:

- rbio_stripe_page()
- rbio_pstripe_page()
- rbio_qstripe_page()
- page_in_rbio()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 108 ++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 075b996040ba..928359840e8e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -681,39 +681,26 @@ static struct sector_ptr *rbio_stripe_sector(const struct btrfs_raid_bio *rbio,
 							      sector_nr)];
 }
 
-static int rbio_stripe_page_index(struct btrfs_raid_bio *rbio, int stripe,
-				  int index)
+/* Helper to grab a sector inside P stripe */
+static struct sector_ptr *rbio_pstripe_sector(const struct btrfs_raid_bio *rbio,
+					      unsigned int sector_nr)
 {
-	return stripe * rbio->stripe_npages + index;
+	return rbio_stripe_sector(rbio, rbio->nr_data, sector_nr);
 }
 
-/*
- * these are just the pages from the rbio array, not from anything
- * the FS sent down to us
- */
-static struct page *rbio_stripe_page(struct btrfs_raid_bio *rbio, int stripe,
-				     int index)
+/* Helper to grab a sector inside Q stripe, return NULL if not RAID6 */
+static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
+					      unsigned int sector_nr)
 {
-	return rbio->stripe_pages[rbio_stripe_page_index(rbio, stripe, index)];
-}
-
-/*
- * helper to index into the pstripe
- */
-static struct page *rbio_pstripe_page(struct btrfs_raid_bio *rbio, int index)
-{
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
@@ -1030,40 +1017,6 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
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
@@ -1333,6 +1286,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
+	const u32 sectorsize = bioc->fs_info->sectorsize;
 	void **pointers = rbio->finish_pointers;
 	int nr_data = rbio->nr_data;
 	int stripe;
@@ -1381,34 +1335,36 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
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
 		}
 		for (stripe = stripe - 1; stripe >= 0; stripe--)
 			kunmap_local(pointers[stripe]);
-- 
2.35.1

