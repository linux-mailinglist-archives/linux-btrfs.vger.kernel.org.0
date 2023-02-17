Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51369A530
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 06:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBQFhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 00:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQFhq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 00:37:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96A5B771
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 21:37:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1A3734028;
        Fri, 17 Feb 2023 05:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676612250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YU+CznA1wPWPQVRWdMDHFqYnPgXBc72uG/I5f6NW+Q=;
        b=SN6gKuu5d2EJzvDj+ZtC7+huCjfcQ7PdTWZia2JyHxPr+tnV1LIayromO/vHokGRedJO31
        fAl9A4c961ceCCmIlT7Y5wF7Qjgs2lwc0zsgpNcy+vt16YPkD0P43sq+gcDbmYkqN5PnQe
        LNvB+bbGrGuSI1eJhuMNMsFtA3bLZgM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B6111323E;
        Fri, 17 Feb 2023 05:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GB3vNZgS72PTSQAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 17 Feb 2023 05:37:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: replace btrfs_io_context::raid_map with a fixed u64 value
Date:   Fri, 17 Feb 2023 13:37:03 +0800
Message-Id: <43c7dfc22297d3bc8e564e10695a403bed7f18c2.1676611536.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676611535.git.wqu@suse.com>
References: <cover.1676611535.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_io_context structure, we have a pointer raid_map, which is to
indicate the logical bytenr for each stripe.

But considering we always call sort_parity_stripes(), the result
raid_map[] is always sorted, thus raid_map[0] is always the logical
bytenr of the full stripe.

So why we waste the space and time (for sorting) for raid_map?

This patch will replace btrfs_io_context::raid_map with a single u64
number, full_stripe_start, by:

- Replace btrfs_io_context::raid_map with full_stripe_start

- Replace call sites using raid_map[0] to use full_stripe_start

- Replace call sites using raid_map[i] to compare with nr_data_stripes.

The benefits are:

- Less memory wasted on raid_map
  It's sizeof(u64) * num_stripes vs size(u64).
  It's always a save of at least one u64, and the benefit grows larger
  with num_stripes.

- No more weird alloc_btrfs_io_context() behavior
  As there is only one fixed size + one variable length array.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c            | 31 +++++++------
 fs/btrfs/scrub.c             | 26 +++++------
 fs/btrfs/volumes.c           | 84 ++++++++++++++----------------------
 fs/btrfs/volumes.h           | 19 ++++++--
 include/trace/events/btrfs.h |  2 +-
 5 files changed, 78 insertions(+), 84 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e495ac147822..e7eccadca5f0 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -202,7 +202,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
  */
 static int rbio_bucket(struct btrfs_raid_bio *rbio)
 {
-	u64 num = rbio->bioc->raid_map[0];
+	u64 num = rbio->bioc->full_stripe_logical;
 
 	/*
 	 * we shift down quite a bit.  We're using byte
@@ -571,7 +571,7 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	    test_bit(RBIO_CACHE_BIT, &cur->flags))
 		return 0;
 
-	if (last->bioc->raid_map[0] != cur->bioc->raid_map[0])
+	if (last->bioc->full_stripe_logical != cur->bioc->full_stripe_logical)
 		return 0;
 
 	/* we can't merge with different operations */
@@ -666,7 +666,7 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 
 	spin_lock_irqsave(&h->lock, flags);
 	list_for_each_entry(cur, &h->hash_list, hash_list) {
-		if (cur->bioc->raid_map[0] != rbio->bioc->raid_map[0])
+		if (cur->bioc->full_stripe_logical != rbio->bioc->full_stripe_logical)
 			continue;
 
 		spin_lock(&cur->bio_list_lock);
@@ -1119,7 +1119,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
-		     rbio->bioc->raid_map[0];
+		     rbio->bioc->full_stripe_logical;
 
 	bio_for_each_segment(bvec, bio, iter) {
 		u32 bvec_offset;
@@ -1343,7 +1343,7 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
-		     rbio->bioc->raid_map[0];
+		     rbio->bioc->full_stripe_logical;
 	int total_nr_sector = offset >> fs_info->sectorsize_bits;
 
 	ASSERT(total_nr_sector < rbio->nr_data * rbio->stripe_nsectors);
@@ -1620,7 +1620,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 {
 	const struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	const u64 orig_logical = orig_bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	const u64 full_stripe_start = rbio->bioc->raid_map[0];
+	const u64 full_stripe_start = rbio->bioc->full_stripe_logical;
 	const u32 orig_len = orig_bio->bi_iter.bi_size;
 	const u32 sectorsize = fs_info->sectorsize;
 	u64 cur_logical;
@@ -1807,9 +1807,8 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		 * here due to a crc mismatch and we can't give them the
 		 * data they want.
 		 */
-		if (rbio->bioc->raid_map[failb] == RAID6_Q_STRIPE) {
-			if (rbio->bioc->raid_map[faila] ==
-			    RAID5_P_STRIPE)
+		if (failb == rbio->real_stripes - 1) {
+			if (faila == rbio->real_stripes - 2)
 				/*
 				 * Only P and Q are corrupted.
 				 * We only care about data stripes recovery,
@@ -1823,7 +1822,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 			goto pstripe;
 		}
 
-		if (rbio->bioc->raid_map[failb] == RAID5_P_STRIPE) {
+		if (failb == rbio->real_stripes - 2) {
 			raid6_datap_recov(rbio->real_stripes, sectorsize,
 					  faila, pointers);
 		} else {
@@ -2086,8 +2085,8 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
-						       rbio->bioc->raid_map[0]);
-	const u64 start = rbio->bioc->raid_map[0];
+					rbio->bioc->full_stripe_logical);
+	const u64 start = rbio->bioc->full_stripe_logical;
 	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
 			fs_info->sectorsize_bits;
 	int ret;
@@ -2135,7 +2134,7 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 	 */
 	btrfs_warn_rl(fs_info,
 "sub-stripe write for full stripe %llu is not safe, failed to get csum: %d",
-			rbio->bioc->raid_map[0], ret);
+			rbio->bioc->full_stripe_logical, ret);
 no_csum:
 	kfree(rbio->csum_buf);
 	bitmap_free(rbio->csum_bitmap);
@@ -2391,10 +2390,10 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 	int stripe_offset;
 	int index;
 
-	ASSERT(logical >= rbio->bioc->raid_map[0]);
-	ASSERT(logical + sectorsize <= rbio->bioc->raid_map[0] +
+	ASSERT(logical >= rbio->bioc->full_stripe_logical);
+	ASSERT(logical + sectorsize <= rbio->bioc->full_stripe_logical +
 				       BTRFS_STRIPE_LEN * rbio->nr_data);
-	stripe_offset = (int)(logical - rbio->bioc->raid_map[0]);
+	stripe_offset = (int)(logical - rbio->bioc->full_stripe_logical);
 	index = stripe_offset / sectorsize;
 	rbio->bio_sectors[index].page = page;
 	rbio->bio_sectors[index].pgoff = pgoff;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 83de9fecc7b6..ee3fe6c291fe 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1430,7 +1430,7 @@ static inline int scrub_nr_raid_mirrors(struct btrfs_io_context *bioc)
 }
 
 static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
-						 u64 *raid_map,
+						 u64 full_stripe_logical,
 						 int nstripes, int mirror,
 						 int *stripe_index,
 						 u64 *stripe_offset)
@@ -1438,19 +1438,21 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 	int i;
 
 	if (map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		/* RAID5/6 */
-		for (i = 0; i < nstripes; i++) {
-			if (raid_map[i] == RAID6_Q_STRIPE ||
-			    raid_map[i] == RAID5_P_STRIPE)
-				continue;
+		const int nr_data_stripes = (map_type & BTRFS_BLOCK_GROUP_RAID5) ?
+					    nstripes - 1 : nstripes - 2;
 
-			if (logical >= raid_map[i] &&
-			    logical < raid_map[i] + BTRFS_STRIPE_LEN)
+		/* RAID5/6 */
+		for (i = 0; i < nr_data_stripes; i++) {
+			const u64 data_stripe_start = full_stripe_logical +
+						(i * BTRFS_STRIPE_LEN);
+
+			if (logical >= data_stripe_start &&
+			    logical < data_stripe_start + BTRFS_STRIPE_LEN)
 				break;
 		}
 
 		*stripe_index = i;
-		*stripe_offset = logical - raid_map[i];
+		*stripe_offset = logical - full_stripe_logical;
 	} else {
 		/* The other RAID type */
 		*stripe_index = mirror;
@@ -1538,7 +1540,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 
 			scrub_stripe_index_and_offset(logical,
 						      bioc->map_type,
-						      bioc->raid_map,
+						      bioc->full_stripe_logical,
 						      bioc->num_stripes -
 						      bioc->replace_nr_stripes,
 						      mirror_index,
@@ -2398,7 +2400,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
 			       &length, &bioc);
-	if (ret || !bioc || !bioc->raid_map)
+	if (ret || !bioc)
 		goto bioc_out;
 
 	if (WARN_ON(!sctx->is_dev_replace ||
@@ -3008,7 +3010,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_WRITE, sparity->logic_start,
 			       &length, &bioc);
-	if (ret || !bioc || !bioc->raid_map)
+	if (ret || !bioc)
 		goto bioc_out;
 
 	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 31a25281c7d8..d528e6aca8ee 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5878,25 +5878,6 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	return preferred_mirror;
 }
 
-/* Bubble-sort the stripe set to put the parity/syndrome stripes last */
-static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
-{
-	int i;
-	int again = 1;
-
-	while (again) {
-		again = 0;
-		for (i = 0; i < num_stripes - 1; i++) {
-			/* Swap if parity is on a smaller index */
-			if (bioc->raid_map[i] > bioc->raid_map[i + 1]) {
-				swap(bioc->stripes[i], bioc->stripes[i + 1]);
-				swap(bioc->raid_map[i], bioc->raid_map[i + 1]);
-				again = 1;
-			}
-		}
-	}
-}
-
 static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 						       u16 total_stripes)
 {
@@ -5906,12 +5887,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 		 /* The size of btrfs_io_context */
 		sizeof(struct btrfs_io_context) +
 		/* Plus the variable array for the stripes */
-		sizeof(struct btrfs_io_stripe) * (total_stripes) +
-		/*
-		 * Plus the raid_map, which includes both the tgt dev
-		 * and the stripes.
-		 */
-		sizeof(u64) * (total_stripes),
+		sizeof(struct btrfs_io_stripe) * (total_stripes),
 		GFP_NOFS);
 
 	if (!bioc)
@@ -5920,8 +5896,8 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
 	refcount_set(&bioc->refs, 1);
 
 	bioc->fs_info = fs_info;
-	bioc->raid_map = (u64 *)(bioc->stripes + total_stripes);
 	bioc->replace_stripe_src = -1;
+	bioc->full_stripe_logical = (u64)-1;
 
 	return bioc;
 }
@@ -6525,33 +6501,39 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 	bioc->map_type = map->type;
 
-	for (i = 0; i < num_stripes; i++) {
-		set_io_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
-			      stripe_nr);
-		stripe_index++;
-	}
-
-	/* Build raid_map */
+	/*
+	 * For RAID56 full map, we need to make sure the stripes[] follows the
+	 * rule that data stripes are all ordered, then followed with P and Q
+	 * (if we have).
+	 *
+	 * It's still mostly the same as other profiles, just with extra rotation.
+	 */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
 	    (need_full_stripe(op) || mirror_num > 1)) {
-		u64 tmp;
-		unsigned rot;
-
-		/* Work out the disk rotation on this stripe-set */
-		rot = stripe_nr % num_stripes;
-
-		/* Fill in the logical address of each stripe */
-		tmp = stripe_nr * data_stripes;
-		for (i = 0; i < data_stripes; i++)
-			bioc->raid_map[(i + rot) % num_stripes] =
-				em->start + ((tmp + i) << BTRFS_STRIPE_LEN_SHIFT);
-
-		bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
-		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-			bioc->raid_map[(i + rot + 1) % num_stripes] =
-				RAID6_Q_STRIPE;
-
-		sort_parity_stripes(bioc, num_stripes);
+		/*
+		 * For RAID56 @stripe_nr is already the number of full stripes
+		 * before us, which is also the rotation value (needs to modulo
+		 * with num_stripes).
+		 *
+		 * In this case, we just add @stripe_nr with @i, then do the
+		 * modulo, to reduce one modulo call.
+		 */
+		bioc->full_stripe_logical = em->start +
+			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
+		for (i = 0; i < num_stripes; i++)
+			set_io_stripe(&bioc->stripes[i], map,
+				      (i + stripe_nr) % num_stripes,
+				      stripe_offset, stripe_nr);
+	} else {
+		/*
+		 * For all other non-RAID56 profiles, just copy the target
+		 * stripe into the bioc.
+		 */
+		for (i = 0; i < num_stripes; i++) {
+			set_io_stripe(&bioc->stripes[i], map, stripe_index,
+				      stripe_offset, stripe_nr);
+			stripe_index++;
+		}
 	}
 
 	if (need_full_stripe(op))
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1da65538c7e2..6296cd9a72b2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -459,11 +459,22 @@ struct btrfs_io_context {
 	u16 replace_nr_stripes;
 	s16 replace_stripe_src;
 	/*
-	 * logical block numbers for the start of each stripe
-	 * The last one or two are p/q.  These are sorted,
-	 * so raid_map[0] is the start of our full stripe
+	 * Logical bytenr of the full stripe start, only for RAID56 cases.
+	 *
+	 * When this value is set to other than (u64)-1, the stripes[] should
+	 * follow this pattern:
+	 *
+	 * (real_stripes = num_stripes - replace_nr_stripes)
+	 * (data_stripes = (is_raid6) ? (real_stripes - 2) : (real_stripes - 1))
+	 *
+	 * stripes[0]:			The first data stripe
+	 * stripes[1]:			The second data stripe
+	 * ...
+	 * stripes[data_stripes - 1]:	The last data stripe
+	 * stripes[data_stripes]:	The P stripe
+	 * stripes[data_stripes + 1]:	The Q stripe (only for RAID6).
 	 */
-	u64 *raid_map;
+	u64 full_stripe_logical;
 	struct btrfs_io_stripe stripes[];
 };
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 75d7d22c3a27..8ea9cea9bfeb 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2422,7 +2422,7 @@ DECLARE_EVENT_CLASS(btrfs_raid56_bio,
 	),
 
 	TP_fast_assign_btrfs(rbio->bioc->fs_info,
-		__entry->full_stripe	= rbio->bioc->raid_map[0];
+		__entry->full_stripe	= rbio->bioc->full_stripe_logical;
 		__entry->physical	= bio->bi_iter.bi_sector << SECTOR_SHIFT;
 		__entry->len		= bio->bi_iter.bi_size;
 		__entry->opf		= bio_op(bio);
-- 
2.39.1

