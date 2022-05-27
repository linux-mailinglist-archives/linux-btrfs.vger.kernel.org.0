Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8AA535A64
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiE0H2p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 03:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiE0H2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 03:28:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C3966AE0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 00:28:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 131511F943
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653636519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F1FEmZQXmphIySOYsE2BMQQ6IHORd1OA48kf9Q0Zi0=;
        b=svW4qG3A7CZbX3fTM80TxfvM9nbkpv+HF+rs1I+paRTcOdiOkgx3yQSWca7PNNwj8XNYT6
        XPBwGgx8OYHIrqFsEfodc/S4/n8JN0ziRfVbOwPgqX+PeLfPhgRyUphdn7VvAsSAaFFJS7
        x03bF7l2VSdClUE/2Gs/o4vRIBvd9QQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A38213A84
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SBE9N6V9kGLFIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:28:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: use integrated bitmaps for btrfs_raid_bio::dbitmap and finish_pbitmap
Date:   Fri, 27 May 2022 15:28:17 +0800
Message-Id: <354833cdd0b94908fc5a6064d2dee63f8ba0c175.1653636443.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653636443.git.wqu@suse.com>
References: <cover.1653636443.git.wqu@suse.com>
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

Previsouly we use "unsigned long *" for those two bitmaps.

But since we only support fixed stripe length (64KiB, already checked in
tree-checker), "unsigned long *" is really a waste of memory, while we
can just use "unsigned long".

This saves us 8 bytes in total for btrfs_raid_bio.

To be extra safe, add an ASSERT() making sure calculated
@stripe_nsectors is always smaller than BITS_PER_LONG.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a5b623ee6fac..bc1e510b0c12 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -164,6 +164,13 @@ struct btrfs_raid_bio {
 	atomic_t stripes_pending;
 
 	atomic_t error;
+
+	/* Bitmap to record which horizontal stripe has data */
+	unsigned long dbitmap;
+
+	/* Allocated with stripe_nsectors-many bits for finish_*() calls */
+	unsigned long finish_pbitmap;
+
 	/*
 	 * these are two arrays of pointers.  We allocate the
 	 * rbio big enough to hold them both and setup their
@@ -184,14 +191,8 @@ struct btrfs_raid_bio {
 	 */
 	struct sector_ptr *stripe_sectors;
 
-	/* Bitmap to record which horizontal stripe has data */
-	unsigned long *dbitmap;
-
 	/* allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
-
-	/* Allocated with stripe_nsectors-many bits for finish_*() calls */
-	unsigned long *finish_pbitmap;
 };
 
 static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
@@ -1038,14 +1039,17 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
 	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
 	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
+	/*
+	 * Our current stripe len should be fixed to 64k thus stripe_nsectors
+	 * (at most 16) should be no larger than BITS_PER_LONG.
+	 */
+	ASSERT(stripe_nsectors <= BITS_PER_LONG);
 
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
 		       sizeof(*rbio->bio_sectors) * num_sectors +
 		       sizeof(*rbio->stripe_sectors) * num_sectors +
-		       sizeof(*rbio->finish_pointers) * real_stripes +
-		       sizeof(*rbio->dbitmap) * BITS_TO_LONGS(stripe_nsectors) +
-		       sizeof(*rbio->finish_pbitmap) * BITS_TO_LONGS(stripe_nsectors),
+		       sizeof(*rbio->finish_pointers) * real_stripes,
 		       GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
@@ -1081,8 +1085,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	CONSUME_ALLOC(rbio->bio_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->stripe_sectors, num_sectors);
 	CONSUME_ALLOC(rbio->finish_pointers, real_stripes);
-	CONSUME_ALLOC(rbio->dbitmap, BITS_TO_LONGS(stripe_nsectors));
-	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_nsectors));
 #undef  CONSUME_ALLOC
 
 	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
@@ -1939,7 +1941,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 		 * which we have data when doing parity scrub.
 		 */
 		if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
-		    !test_bit(sectornr, rbio->dbitmap))
+		    !test_bit(sectornr, &rbio->dbitmap))
 			continue;
 
 		/*
@@ -2374,7 +2376,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	}
 	ASSERT(i < rbio->real_stripes);
 
-	bitmap_copy(rbio->dbitmap, dbitmap, stripe_nsectors);
+	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
 
 	/*
 	 * We have already increased bio_counter when getting bioc, record it
@@ -2412,7 +2414,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 	int stripe;
 	int sectornr;
 
-	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
+	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
 			struct page *page;
 			int index = (stripe * rbio->stripe_nsectors + sectornr) *
@@ -2437,7 +2439,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	struct btrfs_io_context *bioc = rbio->bioc;
 	const u32 sectorsize = bioc->fs_info->sectorsize;
 	void **pointers = rbio->finish_pointers;
-	unsigned long *pbitmap = rbio->finish_pbitmap;
+	unsigned long *pbitmap = &rbio->finish_pbitmap;
 	int nr_data = rbio->nr_data;
 	int stripe;
 	int sectornr;
@@ -2460,7 +2462,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 	if (bioc->num_tgtdevs && bioc->tgtdev_map[rbio->scrubp]) {
 		is_replace = 1;
-		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_nsectors);
+		bitmap_copy(pbitmap, &rbio->dbitmap, rbio->stripe_nsectors);
 	}
 
 	/*
@@ -2497,7 +2499,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	/* Map the parity stripe just once */
 	pointers[nr_data] = kmap_local_page(p_sector.page);
 
-	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
+	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 		void *parity;
 
@@ -2525,7 +2527,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 			memcpy(parity, pointers[rbio->scrubp], sectorsize);
 		else
 			/* Parity is right, needn't writeback */
-			bitmap_clear(rbio->dbitmap, sectornr, 1);
+			bitmap_clear(&rbio->dbitmap, sectornr, 1);
 		kunmap_local(parity);
 
 		for (stripe = nr_data - 1; stripe >= 0; stripe--)
@@ -2547,7 +2549,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
 	 * everything else.
 	 */
-	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
+	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
 
 		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
@@ -2714,7 +2716,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 * stripe
 	 */
 	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		for_each_set_bit(sectornr , rbio->dbitmap, rbio->stripe_nsectors) {
+		for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 			struct sector_ptr *sector;
 			/*
 			 * We want to find all the sectors missing from the
-- 
2.36.1

