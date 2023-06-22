Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74F73978D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjFVGnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFVGnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 02:43:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ABA19AD
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 23:43:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D01F2286E
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687416180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hazU46HZQ7R9yF53bwurPk4XiMegL8GhZsHtM8ncLQ4=;
        b=sv5LPRuzR5A66i2lZc2HB4QMXrHYVmLRXtS06kQqpIKQZ8jZGFSiNvDuhRTnOQGAGzcOUy
        /DX6iM98BJXzSalmUNcyIRE4LppU6Xx+AshAI+A7aDRFZwczomjrTKsFXr6Eq9SrYHMwQp
        aUQ1OovP4gkj+tR0GmndgA+rjLc7JaQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57DEA132BE
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 06:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xDIWCHPtk2QvVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 06:42:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use a dedicated helper to convert stripe_nr to offset
Date:   Thu, 22 Jun 2023 14:42:40 +0800
Message-ID: <10aca1661eee22e6a74ecab62a48227b51284ece.1687416153.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[BACKGROUND]
We already had a nasty regression introduced by commit a97699d1d610
("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN"), which is
doing a u32 left shift and can cause overflow.

Later we have an incomplete fix, a7299a18a179 ("btrfs: fix u32 overflows
when left shifting @stripe_nr"), which fixes 5 call sites, but with one
missing call site (*) still not caught until a proper regression test is
crafted.

*: The assignment on bioc->full_stripe_logical inside btrfs_map_block()

[FIX]
To end the whack-a-mole game, this patch will introduce a helper,
btrfs_stripe_nr_to_offset(), to do the u32 left shift with proper type
cast to u64 to avoid overflow.

This would replace all "<< BTRFS_STRIPE_LEN_SHIFT" calls, and solve the
problem permanently.

Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
Fixes: a7299a18a179 ("btrfs: fix u32 overflows when left shifting stripe_nr")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c  |  2 +-
 fs/btrfs/raid56.c       |  2 +-
 fs/btrfs/scrub.c        | 24 ++++++++++++------------
 fs/btrfs/tree-checker.c |  4 ++--
 fs/btrfs/volumes.c      | 29 +++++++++++++++--------------
 fs/btrfs/volumes.h      | 12 ++++++++++++
 6 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6753524b146c..48ae509f2ac2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2006,7 +2006,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-		io_stripe_size = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
+		io_stripe_size = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
 
 	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
 	if (!buf) {
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f37b925d587f..a649a1684f33 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2779,7 +2779,7 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 
 	/* data_logical must be at stripe boundary and inside the full stripe. */
 	ASSERT(IS_ALIGNED(offset_in_full_stripe, BTRFS_STRIPE_LEN));
-	ASSERT(offset_in_full_stripe < (rbio->nr_data << BTRFS_STRIPE_LEN_SHIFT));
+	ASSERT(offset_in_full_stripe < btrfs_stripe_nr_to_offset(rbio->nr_data));
 
 	for (int page_nr = 0; page_nr < (BTRFS_STRIPE_LEN >> PAGE_SHIFT); page_nr++) {
 		struct page *dst = rbio->stripe_pages[page_nr + page_index];
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c7fdbb60314..1b56c94de2c5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1255,7 +1255,7 @@ static int get_raid56_logic_offset(u64 physical, int num,
 		u32 stripe_index;
 		u32 rot;
 
-		*offset = last_offset + (i << BTRFS_STRIPE_LEN_SHIFT);
+		*offset = last_offset + btrfs_stripe_nr_to_offset(i);
 
 		stripe_nr = (u32)(*offset >> BTRFS_STRIPE_LEN_SHIFT) / data_stripes;
 
@@ -1270,7 +1270,7 @@ static int get_raid56_logic_offset(u64 physical, int num,
 		if (stripe_index < num)
 			j++;
 	}
-	*offset = last_offset + (j << BTRFS_STRIPE_LEN_SHIFT);
+	*offset = last_offset + btrfs_stripe_nr_to_offset(j);
 	return 1;
 }
 
@@ -1666,7 +1666,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
 
 	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
-			      nr_stripes << BTRFS_STRIPE_LEN_SHIFT);
+			      btrfs_stripe_nr_to_offset(nr_stripes));
 	for (int i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
 		scrub_submit_initial_read(sctx, stripe);
@@ -1789,7 +1789,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	bool all_empty = true;
 	const int data_stripes = nr_data_stripes(map);
 	unsigned long extent_bitmap = 0;
-	u64 length = data_stripes << BTRFS_STRIPE_LEN_SHIFT;
+	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
 	int ret;
 
 	ASSERT(sctx->raid56_data_stripes);
@@ -1804,13 +1804,13 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 			      data_stripes) >> BTRFS_STRIPE_LEN_SHIFT;
 		stripe_index = (i + rot) % map->num_stripes;
 		physical = map->stripes[stripe_index].physical +
-			   (rot << BTRFS_STRIPE_LEN_SHIFT);
+			   btrfs_stripe_nr_to_offset(rot);
 
 		scrub_reset_stripe(stripe);
 		set_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state);
 		ret = scrub_find_fill_first_stripe(bg,
 				map->stripes[stripe_index].dev, physical, 1,
-				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT),
+				full_stripe_start + btrfs_stripe_nr_to_offset(i),
 				BTRFS_STRIPE_LEN, stripe);
 		if (ret < 0)
 			goto out;
@@ -1820,7 +1820,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		 */
 		if (ret > 0) {
 			stripe->logical = full_stripe_start +
-					  (i << BTRFS_STRIPE_LEN_SHIFT);
+					  btrfs_stripe_nr_to_offset(i);
 			stripe->dev = map->stripes[stripe_index].dev;
 			stripe->mirror_num = 1;
 			set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
@@ -1928,7 +1928,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		stripe = &sctx->raid56_data_stripes[i];
 
 		raid56_parity_cache_data_pages(rbio, stripe->pages,
-				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
+				full_stripe_start + btrfs_stripe_nr_to_offset(i));
 	}
 	raid56_parity_submit_scrub_rbio(rbio);
 	wait_for_completion_io(&io_done);
@@ -2020,7 +2020,7 @@ static u64 simple_stripe_full_stripe_len(const struct map_lookup *map)
 	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 			    BTRFS_BLOCK_GROUP_RAID10));
 
-	return (map->num_stripes / map->sub_stripes) << BTRFS_STRIPE_LEN_SHIFT;
+	return btrfs_stripe_nr_to_offset(map->num_stripes / map->sub_stripes);
 }
 
 /* Get the logical bytenr for the stripe */
@@ -2036,7 +2036,7 @@ static u64 simple_stripe_get_logical(struct map_lookup *map,
 	 * (stripe_index / sub_stripes) gives how many data stripes we need to
 	 * skip.
 	 */
-	return ((stripe_index / map->sub_stripes) << BTRFS_STRIPE_LEN_SHIFT) +
+	return btrfs_stripe_nr_to_offset(stripe_index / map->sub_stripes) +
 	       bg->start;
 }
 
@@ -2162,7 +2162,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	}
 	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
 		ret = scrub_simple_stripe(sctx, bg, map, scrub_dev, stripe_index);
-		offset = (stripe_index / map->sub_stripes) << BTRFS_STRIPE_LEN_SHIFT;
+		offset = btrfs_stripe_nr_to_offset(stripe_index / map->sub_stripes);
 		goto out;
 	}
 
@@ -2177,7 +2177,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	/* Initialize @offset in case we need to go to out: label */
 	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
-	increment = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
+	increment = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
 
 	/*
 	 * Due to the rotation, for RAID56 it's better to iterate each stripe
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 351ba9e90675..038dfa8f1788 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -857,10 +857,10 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	 *
 	 * Thus it should be a good way to catch obvious bitflips.
 	 */
-	if (unlikely(length >= ((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT))) {
+	if (unlikely(length >= btrfs_stripe_nr_to_offset(U32_MAX))) {
 		chunk_err(leaf, chunk, logical,
 			  "chunk length too large: have %llu limit %llu",
-			  length, (u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT);
+			  length, btrfs_stripe_nr_to_offset(U32_MAX));
 		return -EUCLEAN;
 	}
 	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a536d0e0e055..4193ace3fb5a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5135,7 +5135,7 @@ static void init_alloc_chunk_ctl_policy_regular(
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size = min(mult_perc(fs_devices->total_rw_bytes, 10),
 				  ctl->max_chunk_size);
-	ctl->dev_extent_min = ctl->dev_stripes << BTRFS_STRIPE_LEN_SHIFT;
+	ctl->dev_extent_min = btrfs_stripe_nr_to_offset(ctl->dev_stripes);
 }
 
 static void init_alloc_chunk_ctl_policy_zoned(
@@ -5811,7 +5811,7 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	if (!WARN_ON(IS_ERR(em))) {
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			len = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
+			len = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
 		free_extent_map(em);
 	}
 	return len;
@@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 
 	/* stripe_offset is the offset of this block in its stripe */
-	stripe_offset = offset - ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+	stripe_offset = offset - btrfs_stripe_nr_to_offset(stripe_nr);
 
 	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN) >>
 			BTRFS_STRIPE_LEN_SHIFT;
 	stripe_cnt = stripe_nr_end - stripe_nr;
-	stripe_end_offset = ((u64)stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
+	stripe_end_offset = btrfs_stripe_nr_to_offset(stripe_nr_end) -
 			    (offset + length);
 	/*
 	 * after this, stripe_nr is the number of stripes on this
@@ -6033,12 +6033,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < *num_stripes; i++) {
 		stripes[i].physical =
 			map->stripes[stripe_index].physical +
-			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
 		stripes[i].dev = map->stripes[stripe_index].dev;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 				 BTRFS_BLOCK_GROUP_RAID10)) {
-			stripes[i].length = stripes_per_dev << BTRFS_STRIPE_LEN_SHIFT;
+			stripes[i].length = btrfs_stripe_nr_to_offset(stripes_per_dev);
 
 			if (i / sub_stripes < remaining_stripes)
 				stripes[i].length += BTRFS_STRIPE_LEN;
@@ -6186,8 +6186,8 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 	ASSERT(*stripe_offset < U32_MAX);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		unsigned long full_stripe_len = nr_data_stripes(map) <<
-						BTRFS_STRIPE_LEN_SHIFT;
+		unsigned long full_stripe_len =
+			btrfs_stripe_nr_to_offset(nr_data_stripes(map));
 
 		/*
 		 * For full stripe start, we use previously calculated
@@ -6199,8 +6199,8 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 		 * not ensured to be power of 2.
 		 */
 		*full_stripe_start =
-			(u64)rounddown(*stripe_nr, nr_data_stripes(map)) <<
-			BTRFS_STRIPE_LEN_SHIFT;
+			btrfs_stripe_nr_to_offset(
+				rounddown(*stripe_nr, nr_data_stripes(map)));
 
 		ASSERT(*full_stripe_start + full_stripe_len > offset);
 		ASSERT(*full_stripe_start <= offset);
@@ -6226,7 +6226,7 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 {
 	dst->dev = map->stripes[stripe_index].dev;
 	dst->physical = map->stripes[stripe_index].physical +
-			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
 }
 
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -6347,7 +6347,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			/* Return the length to the full stripe end */
 			*length = min(logical + *length,
 				      raid56_full_stripe_start + em->start +
-				      (data_stripes << BTRFS_STRIPE_LEN_SHIFT)) - logical;
+				      btrfs_stripe_nr_to_offset(data_stripes)) -
+				  logical;
 			stripe_index = 0;
 			stripe_offset = 0;
 		} else {
@@ -6437,7 +6438,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * modulo, to reduce one modulo call.
 		 */
 		bioc->full_stripe_logical = em->start +
-			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
+			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
 		for (i = 0; i < num_stripes; i++)
 			set_io_stripe(&bioc->stripes[i], map,
 				      (i + stripe_nr) % num_stripes,
@@ -8017,7 +8018,7 @@ static void map_raid56_repair_block(struct btrfs_io_context *bioc,
 
 	for (i = 0; i < data_stripes; i++) {
 		u64 stripe_start = bioc->full_stripe_logical +
-				   (i << BTRFS_STRIPE_LEN_SHIFT);
+				   btrfs_stripe_nr_to_offset(i);
 
 		if (logical >= stripe_start &&
 		    logical < stripe_start + BTRFS_STRIPE_LEN)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3930ee01d696..f4f410550306 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -580,6 +580,18 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 		sizeof(struct btrfs_stripe) * (num_stripes - 1);
 }
 
+/*
+ * Do the type safe converstion from stripe_nr to offset inside the chunk.
+ *
+ * @stripe_nr is u32, with left shift it can overflow u32 for chunks larger
+ * than 4G.
+ * This function do the proper type cast to avoid overflow.
+ */
+static inline u64 btrfs_stripe_nr_to_offset(u32 stripe_nr)
+{
+	return (u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT;
+}
+
 void btrfs_get_bioc(struct btrfs_io_context *bioc);
 void btrfs_put_bioc(struct btrfs_io_context *bioc);
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-- 
2.41.0

