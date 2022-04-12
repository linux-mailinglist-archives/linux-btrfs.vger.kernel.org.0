Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2B4FDCD4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiDLKmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354412AbiDLKdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F01FCDC
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 234D321608
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5wS/OV5ME7Plgu9DzOHyxNBtdRXvcVZi1lZee3lzG8=;
        b=cpR/bPZLjxk+VpGuwu0AhkAP/uXwD9pFq6R00UD0viwEqiG3nEd7vfbYtcKwrSlOMRKffT
        HC9c7WJgfdDm7YkpVidPlJH+PsUAlNx41RBq+AFDvEWaYAzoL7wK4/jF740jeV0qHUBdoh
        5VfQPj5WWiKJ2rLO5EpG5G6Dm53iwls=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A6FC13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cFdUDG1HVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage compatible
Date:   Tue, 12 Apr 2022 17:32:57 +0800
Message-Id: <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
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

This involves:

- Rename rbio_add_io_page() to rbio_add_io_sector()
  Since we are still relying on PAGE_SIZE == sectorsize, add a new
  ASSERT() inside rbio_add_io_sector() to makesure all pgoff is 0.

- Introduce rbio_stripe_sector() helper
  The equivalent of rbio_stripe_page().

  This new helper has extra ASSERT()s to validate the stripe and sector
  number.

- Introduce sector_in_rbio() helper
  The equivalent of page_in_rbio().

- Rename @pagenr variables to @sectornr

- Use rbio::stripe_nsectors when iterating the bitmap

Please note that, this only changes the interface, the bios are still
using full page for IO.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 247 ++++++++++++++++++++++++++++++----------------
 1 file changed, 161 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f88dd11a208d..9c3e0201d032 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -662,6 +662,25 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	return 1;
 }
 
+static unsigned int rbio_stripe_sector_index(const struct btrfs_raid_bio *rbio,
+					     unsigned int stripe_nr,
+					     unsigned int sector_nr)
+{
+	ASSERT(stripe_nr < rbio->real_stripes);
+	ASSERT(sector_nr < rbio->stripe_nsectors);
+
+	return stripe_nr * rbio->stripe_nsectors + sector_nr;
+}
+
+/* Return a sector from rbio->stripe_sectors, not from the bio list */
+static struct sector_ptr *rbio_stripe_sector(const struct btrfs_raid_bio *rbio,
+					     unsigned int stripe_nr,
+					     unsigned int sector_nr)
+{
+	return &rbio->stripe_sectors[rbio_stripe_sector_index(rbio, stripe_nr,
+							      sector_nr)];
+}
+
 static int rbio_stripe_page_index(struct btrfs_raid_bio *rbio, int stripe,
 				  int index)
 {
@@ -973,6 +992,44 @@ static void raid_write_end_io(struct bio *bio)
 	rbio_orig_end_io(rbio, err);
 }
 
+/*
+ * To get a sector pointer specified by its @stripe_nr and @sector_nr
+ *
+ * @stripe_nr:		Stripe number, valid range [0, real_stripe)
+ * @sector_nr:		Sector number inside the stripe,
+ *			valid range [0, stripe_nsectors)
+ * @bio_list_only:	Whether to use sectors inside the bio list only.
+ *
+ * The read/modify/write code wants to reuse the original bio page as much
+ * as possible, and only use stripe_sectors as fallback.
+ */
+static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
+					 int stripe_nr, int sector_nr,
+					 bool bio_list_only)
+{
+	struct sector_ptr *sector = NULL;
+	int index;
+
+	ASSERT(stripe_nr >= 0 && stripe_nr < rbio->real_stripes);
+	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
+
+	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
+	ASSERT(index >= 0 && index < rbio->nr_sectors);
+
+	spin_lock_irq(&rbio->bio_list_lock);
+	sector = &rbio->bio_sectors[index];
+	if (sector->page || bio_list_only) {
+		/* Don't return sector without a valid page pointer */
+		if (!sector->page)
+			sector = NULL;
+		spin_unlock_irq(&rbio->bio_list_lock);
+		return sector;
+	}
+	spin_unlock_irq(&rbio->bio_list_lock);
+
+	return &rbio->stripe_sectors[index];
+}
+
 /*
  * the read/modify/write code wants to use the original bio for
  * any pages it included, and then use the rbio for everything
@@ -1120,26 +1177,39 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 }
 
 /*
- * add a single page from a specific stripe into our list of bios for IO
- * this will try to merge into existing bios if possible, and returns
- * zero if all went well.
+ * Add a single sector @sector into our list of bios for IO.
+ *
+ * Return 0 if everything went well.
+ * Return <0 for error.
  */
-static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
-			    struct bio_list *bio_list,
-			    struct page *page,
-			    int stripe_nr,
-			    unsigned long page_index,
-			    unsigned long bio_max_len,
-			    unsigned int opf)
+static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
+			      struct bio_list *bio_list,
+			      struct sector_ptr *sector,
+			      unsigned int stripe_nr,
+			      unsigned int sector_nr,
+			      unsigned long bio_max_len, unsigned int opf)
 {
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	struct bio *last = bio_list->tail;
 	int ret;
 	struct bio *bio;
 	struct btrfs_io_stripe *stripe;
 	u64 disk_start;
 
+	/*
+	 * NOTE: here stripe_nr has taken device replace into consideration,
+	 * thus it can be larger than rbio->real_stripe.
+	 * So here we check against bioc->num_stripes, not rbio->real_stripes.
+	 */
+	ASSERT(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes);
+	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
+	ASSERT(sector->page);
+
+	/* We don't yet support subpage, thus pgoff should always be 0 */
+	ASSERT(sector->pgoff == 0);
+
 	stripe = &rbio->bioc->stripes[stripe_nr];
-	disk_start = stripe->physical + (page_index << PAGE_SHIFT);
+	disk_start = stripe->physical + sector_nr * sectorsize;
 
 	/* if the device is missing, just fail this stripe */
 	if (!stripe->dev->bdev)
@@ -1156,8 +1226,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 		 */
 		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_bdev == stripe->dev->bdev) {
-			ret = bio_add_page(last, page, PAGE_SIZE, 0);
-			if (ret == PAGE_SIZE)
+			ret = bio_add_page(last, sector->page, sectorsize,
+					   sector->pgoff);
+			if (ret == sectorsize)
 				return 0;
 		}
 	}
@@ -1168,7 +1239,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
-	bio_add_page(bio, page, PAGE_SIZE, 0);
+	bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
 	bio_list_add(bio_list, bio);
 	return 0;
 }
@@ -1265,7 +1336,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	void **pointers = rbio->finish_pointers;
 	int nr_data = rbio->nr_data;
 	int stripe;
-	int pagenr;
+	int sectornr;
 	bool has_qstripe;
 	struct bio_list bio_list;
 	struct bio *bio;
@@ -1309,16 +1380,16 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	else
 		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
 		struct page *p;
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
-			p = page_in_rbio(rbio, stripe, pagenr, 0);
+			p = page_in_rbio(rbio, stripe, sectornr, 0);
 			pointers[stripe] = kmap_local_page(p);
 		}
 
 		/* then add the parity stripe */
-		p = rbio_pstripe_page(rbio, pagenr);
+		p = rbio_pstripe_page(rbio, sectornr);
 		SetPageUptodate(p);
 		pointers[stripe++] = kmap_local_page(p);
 
@@ -1328,7 +1399,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 			 * raid6, add the qstripe and call the
 			 * library function to fill in our p/q
 			 */
-			p = rbio_qstripe_page(rbio, pagenr);
+			p = rbio_qstripe_page(rbio, sectornr);
 			SetPageUptodate(p);
 			pointers[stripe++] = kmap_local_page(p);
 
@@ -1349,19 +1420,19 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	 * everything else.
 	 */
 	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
-			struct page *page;
+		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+			struct sector_ptr *sector;
+
 			if (stripe < rbio->nr_data) {
-				page = page_in_rbio(rbio, stripe, pagenr, 1);
-				if (!page)
+				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+				if (!sector)
 					continue;
 			} else {
-			       page = rbio_stripe_page(rbio, stripe, pagenr);
+				sector = rbio_stripe_sector(rbio, stripe, sectornr);
 			}
 
-			ret = rbio_add_io_page(rbio, &bio_list,
-				       page, stripe, pagenr, rbio->stripe_len,
-				       REQ_OP_WRITE);
+			ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+						 sectornr, rbio->stripe_len, REQ_OP_WRITE);
 			if (ret)
 				goto cleanup;
 		}
@@ -1374,20 +1445,21 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		if (!bioc->tgtdev_map[stripe])
 			continue;
 
-		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
-			struct page *page;
+		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+			struct sector_ptr *sector;
+
 			if (stripe < rbio->nr_data) {
-				page = page_in_rbio(rbio, stripe, pagenr, 1);
-				if (!page)
+				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+				if (!sector)
 					continue;
 			} else {
-			       page = rbio_stripe_page(rbio, stripe, pagenr);
+				sector = rbio_stripe_sector(rbio, stripe, sectornr);
 			}
 
-			ret = rbio_add_io_page(rbio, &bio_list, page,
-					       rbio->bioc->tgtdev_map[stripe],
-					       pagenr, rbio->stripe_len,
-					       REQ_OP_WRITE);
+			ret = rbio_add_io_sector(rbio, &bio_list, sector,
+						 rbio->bioc->tgtdev_map[stripe],
+						 sectornr, rbio->stripe_len,
+						 REQ_OP_WRITE);
 			if (ret)
 				goto cleanup;
 		}
@@ -1563,7 +1635,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int pagenr;
+	int sectornr;
 	int stripe;
 	struct bio *bio;
 
@@ -1581,28 +1653,29 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 * stripe
 	 */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
-		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
-			struct page *page;
+		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+			struct sector_ptr *sector;
+
 			/*
-			 * we want to find all the pages missing from
+			 * We want to find all the sectors missing from
 			 * the rbio and read them from the disk.  If
-			 * page_in_rbio finds a page in the bio list
+			 * sector_in_rbio() finds a page in the bio list
 			 * we don't need to read it off the stripe.
 			 */
-			page = page_in_rbio(rbio, stripe, pagenr, 1);
-			if (page)
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (sector)
 				continue;
 
-			page = rbio_stripe_page(rbio, stripe, pagenr);
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
 			/*
-			 * the bio cache may have handed us an uptodate
+			 * The bio cache may have handed us an uptodate
 			 * page.  If so, be happy and use it
 			 */
-			if (PageUptodate(page))
+			if (sector->uptodate)
 				continue;
 
-			ret = rbio_add_io_page(rbio, &bio_list, page,
-				       stripe, pagenr, rbio->stripe_len,
+			ret = rbio_add_io_sector(rbio, &bio_list, sector,
+				       stripe, sectornr, rbio->stripe_len,
 				       REQ_OP_READ);
 			if (ret)
 				goto cleanup;
@@ -2107,7 +2180,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int pagenr;
+	int sectornr;
 	int stripe;
 	struct bio *bio;
 
@@ -2130,21 +2203,20 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 
-		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
-			struct page *p;
+		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+			struct sector_ptr *sector;
 
 			/*
 			 * the rmw code may have already read this
 			 * page in
 			 */
-			p = rbio_stripe_page(rbio, stripe, pagenr);
-			if (PageUptodate(p))
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+			if (sector->uptodate)
 				continue;
 
-			ret = rbio_add_io_page(rbio, &bio_list,
-				       rbio_stripe_page(rbio, stripe, pagenr),
-				       stripe, pagenr, rbio->stripe_len,
-				       REQ_OP_READ);
+			ret = rbio_add_io_sector(rbio, &bio_list, sector,
+						 stripe, sectornr,
+						 rbio->stripe_len, REQ_OP_READ);
 			if (ret < 0)
 				goto cleanup;
 		}
@@ -2399,7 +2471,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	unsigned long *pbitmap = rbio->finish_pbitmap;
 	int nr_data = rbio->nr_data;
 	int stripe;
-	int pagenr;
+	int sectornr;
 	bool has_qstripe;
 	struct page *p_page = NULL;
 	struct page *q_page = NULL;
@@ -2419,7 +2491,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	if (bioc->num_tgtdevs && bioc->tgtdev_map[rbio->scrubp]) {
 		is_replace = 1;
-		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_npages);
+		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_nsectors);
 	}
 
 	/*
@@ -2453,12 +2525,12 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	/* Map the parity stripe just once */
 	pointers[nr_data] = kmap_local_page(p_page);
 
-	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
+	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
 		struct page *p;
 		void *parity;
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
-			p = page_in_rbio(rbio, stripe, pagenr, 0);
+			p = page_in_rbio(rbio, stripe, sectornr, 0);
 			pointers[stripe] = kmap_local_page(p);
 		}
 
@@ -2473,13 +2545,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		}
 
 		/* Check scrubbing parity and repair it */
-		p = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
+		p = rbio_stripe_page(rbio, rbio->scrubp, sectornr);
 		parity = kmap_local_page(p);
 		if (memcmp(parity, pointers[rbio->scrubp], PAGE_SIZE))
 			copy_page(parity, pointers[rbio->scrubp]);
 		else
 			/* Parity is right, needn't writeback */
-			bitmap_clear(rbio->dbitmap, pagenr, 1);
+			bitmap_clear(rbio->dbitmap, sectornr, 1);
 		kunmap_local(parity);
 
 		for (stripe = nr_data - 1; stripe >= 0; stripe--)
@@ -2499,12 +2571,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
 	 * everything else.
 	 */
-	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
-		struct page *page;
+	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
+		struct sector_ptr *sector;
 
-		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
-		ret = rbio_add_io_page(rbio, &bio_list, page, rbio->scrubp,
-				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
+		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
+					 sectornr, rbio->stripe_len,
+					 REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2512,13 +2585,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	if (!is_replace)
 		goto submit_write;
 
-	for_each_set_bit(pagenr, pbitmap, rbio->stripe_npages) {
-		struct page *page;
+	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
+		struct sector_ptr *sector;
 
-		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
-		ret = rbio_add_io_page(rbio, &bio_list, page,
+		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
+		ret = rbio_add_io_sector(rbio, &bio_list, sector,
 				       bioc->tgtdev_map[rbio->scrubp],
-				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
+				       sectornr, rbio->stripe_len, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2650,7 +2723,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	int bios_to_read = 0;
 	struct bio_list bio_list;
 	int ret;
-	int pagenr;
+	int sectornr;
 	int stripe;
 	struct bio *bio;
 
@@ -2666,28 +2739,30 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 * stripe
 	 */
 	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
-			struct page *page;
+		for_each_set_bit(sectornr, rbio->dbitmap,
+				 rbio->stripe_nsectors) {
+			struct sector_ptr *sector;
 			/*
-			 * we want to find all the pages missing from
+			 * We want to find all the sectors missing from
 			 * the rbio and read them from the disk.  If
-			 * page_in_rbio finds a page in the bio list
+			 * sector_in_rbio() finds a sector in the bio list
 			 * we don't need to read it off the stripe.
 			 */
-			page = page_in_rbio(rbio, stripe, pagenr, 1);
-			if (page)
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (sector)
 				continue;
 
-			page = rbio_stripe_page(rbio, stripe, pagenr);
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
 			/*
-			 * the bio cache may have handed us an uptodate
-			 * page.  If so, be happy and use it
+			 * The bio cache may have handed us an uptodate
+			 * sector.  If so, be happy and use it
 			 */
-			if (PageUptodate(page))
+			if (sector->uptodate)
 				continue;
 
-			ret = rbio_add_io_page(rbio, &bio_list, page, stripe,
-					       pagenr, rbio->stripe_len, REQ_OP_READ);
+			ret = rbio_add_io_sector(rbio, &bio_list, sector,
+						 stripe, sectornr,
+						 rbio->stripe_len, REQ_OP_READ);
 			if (ret)
 				goto cleanup;
 		}
-- 
2.35.1

