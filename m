Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDCE68B3A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 02:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBFBKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 20:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFBKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 20:10:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468A196A9
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 17:10:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28B225FEA2
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675645828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qcy3I9/lS8CRdQBR06DZOuv6yx8J4dqcZrws+oycSts=;
        b=ehFEeK9eorpGHdZ9az6lhaOduI+8mhUvqiuWLDQybQRpwuPV3OHg+ebbxh1WIzhmIgn3U6
        xe8UvOWcR6VCNfwnnzOJmhz0Dv7ax7X1waxsiyzcamcnlpO/2gJkev8iwUsfN4l7YWdOze
        bAV4yKOtGzwIkqwIcuHM646/ObD+YOw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 918A4138E7
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 01:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yIXuGINT4GNRcwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 01:10:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: reduce div64 calls by limiting the number of stripes of a chunk to u32
Date:   Mon,  6 Feb 2023 09:10:08 +0800
Message-Id: <5392f2206e7431647a442a7f87fc1af5fbb47570.1675645730.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675645730.git.wqu@suse.com>
References: <cover.1675645730.git.wqu@suse.com>
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

There are quite some div64 calls inside btrfs_map_block() and its
variants.

One of such calls are for @stripe_nr, where @stripe_nr is the number of
stripes before our logical bytenr inside a chunk.

However we can eliminate such div64 calls by just reducing the width of
@stripe_nr from 64 to 32.

This can be done because our chunk size limit is already 10G, with fixed
stripe length 64K.
Thus a U32 is definitely enough to contain the number of stripes.

With such width reduction, we can get rid of slower div64, and extra
warning for certain 32bit arch.

This patch would do:

- Reduce the width of various stripe_nr variables

- Add a new tree-checker chunk validation on chunk length
  Make sure no chunk can reach 256G, which can also act as a bitflip
  checker.

- Replace unnecessary div64 calls with regular modulo and division
  32bit division and modulo are much faster than 64bit operations, and
  we are finally free of the div64 fear at least in those involved
  functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c  | 18 +++++-----
 fs/btrfs/tree-checker.c | 14 ++++++++
 fs/btrfs/volumes.c      | 79 ++++++++++++++++++++++-------------------
 fs/btrfs/volumes.h      |  2 +-
 4 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1c74af23f54c..93938e673f1e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2009,8 +2009,8 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 
 	for (i = 0; i < map->num_stripes; i++) {
 		bool already_inserted = false;
-		u64 stripe_nr;
-		u64 offset;
+		u32 stripe_nr;
+		u32 offset;
 		int j;
 
 		if (!in_range(physical, map->stripes[i].physical,
@@ -2020,20 +2020,20 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		if (bdev && map->stripes[i].dev->bdev != bdev)
 			continue;
 
-		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64_rem(stripe_nr, BTRFS_STRIPE_LEN, &offset);
+		stripe_nr = (physical - map->stripes[i].physical) >>
+			     BTRFS_STRIPE_LEN_SHIFT;
+		offset = (physical - map->stripes[i].physical) &
+			 ((1 << BTRFS_STRIPE_LEN_SHIFT) - 1);
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
-				 BTRFS_BLOCK_GROUP_RAID10)) {
-			stripe_nr = stripe_nr * map->num_stripes + i;
-			stripe_nr = div_u64(stripe_nr, map->sub_stripes);
-		}
+				 BTRFS_BLOCK_GROUP_RAID10))
+			stripe_nr = div_u64(stripe_nr * map->num_stripes + 1,
+					    map->sub_stripes);
 		/*
 		 * The remaining case would be for RAID56, multiply by
 		 * nr_data_stripes().  Alternatively, just use rmap_len below
 		 * instead of map->stripe_len
 		 */
-
 		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index baad1ed7e111..7968fc89f278 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -849,6 +849,20 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			  stripe_len);
 		return -EUCLEAN;
 	}
+	/*
+	 * We artificially limit the chunk size, so that the number of stripes
+	 * inside a chunk can be fit into a U32.
+	 * The current limit (256G) would be way too large for real world usage
+	 * anyway, and it's already way larger than our existing limit (10G).
+	 *
+	 * Thus it should be a good way to catch obvious bitflip.
+	 */
+	if (unlikely(((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT) <= length)) {
+		chunk_err(leaf, chunk, logical,
+			  "chunk length too large: have %llu limit %llu",
+			  length, (u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT);
+		return -EUCLEAN;
+	}
 	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
 			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
 		chunk_err(leaf, chunk, logical,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4c91cc6471c3..ce073083b0dc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5940,15 +5940,15 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	struct btrfs_discard_stripe *stripes;
 	u64 length = *length_ret;
 	u64 offset;
-	u64 stripe_nr;
-	u64 stripe_nr_end;
+	u32 stripe_nr;
+	u32 stripe_nr_end;
+	u32 stripe_cnt;
 	u64 stripe_end_offset;
-	u64 stripe_cnt;
 	u64 stripe_offset;
 	u32 stripe_index;
 	u32 factor = 0;
 	u32 sub_stripes = 0;
-	u64 stripes_per_dev = 0;
+	u32 stripes_per_dev = 0;
 	u32 remaining_stripes = 0;
 	u32 last_stripe = 0;
 	int ret;
@@ -5974,13 +5974,13 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	 * stripe_nr counts the total number of stripes we have to stride
 	 * to get to this block
 	 */
-	stripe_nr = div64_u64(offset, BTRFS_STRIPE_LEN);
+	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 
 	/* stripe_offset is the offset of this block in its stripe */
 	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 
-	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN);
-	stripe_nr_end = div64_u64(stripe_nr_end, BTRFS_STRIPE_LEN);
+	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN) >>
+			BTRFS_STRIPE_LEN_SHIFT;
 	stripe_cnt = stripe_nr_end - stripe_nr;
 	stripe_end_offset = (stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
 			    (offset + length);
@@ -6001,18 +6001,18 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 		factor = map->num_stripes / sub_stripes;
 		*num_stripes = min_t(u64, map->num_stripes,
 				    sub_stripes * stripe_cnt);
-		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
+		stripe_index = stripe_nr % factor;
+		stripe_nr /= factor;
 		stripe_index *= sub_stripes;
 		stripes_per_dev = div_u64_rem(stripe_cnt, factor,
 					      &remaining_stripes);
-		div_u64_rem(stripe_nr_end - 1, factor, &last_stripe);
-		last_stripe *= sub_stripes;
+		last_stripe = (stripe_nr_end - 1) % factor * sub_stripes;
 	} else if (map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK |
 				BTRFS_BLOCK_GROUP_DUP)) {
 		*num_stripes = map->num_stripes;
 	} else {
-		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
-					&stripe_index);
+		stripe_index = stripe_nr % map->num_stripes;
+		stripe_nr /= map->num_stripes;
 	}
 
 	stripes = kcalloc(*num_stripes, sizeof(*stripes), GFP_NOFS);
@@ -6286,11 +6286,10 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 			  struct btrfs_io_geometry *io_geom)
 {
 	struct map_lookup *map;
-	const u32 stripe_len = BTRFS_STRIPE_LEN;
 	u64 len;
 	u64 offset;
 	u64 stripe_offset;
-	u64 stripe_nr;
+	u32 stripe_nr;
 	u64 raid56_full_stripe_start = (u64)-1;
 	int data_stripes;
 
@@ -6303,20 +6302,22 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	 * Stripe_nr is where this block falls in
 	 * stripe_offset is the offset of this block in its stripe.
 	 */
-	stripe_nr = div64_u64_rem(offset, stripe_len, &stripe_offset);
+	stripe_offset = offset & ((1 << BTRFS_STRIPE_LEN_SHIFT) - 1);
+	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 	ASSERT(stripe_offset < U32_MAX);
 
 	data_stripes = nr_data_stripes(map);
 
 	/* Only stripe based profiles needs to check against stripe length. */
 	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) {
-		u64 max_len = stripe_len - stripe_offset;
+		u64 max_len = BTRFS_STRIPE_LEN - stripe_offset;
 
 		/*
 		 * In case of raid56, we need to know the stripe aligned start
 		 */
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-			unsigned long full_stripe_len = stripe_len * data_stripes;
+			unsigned long full_stripe_len = data_stripes <<
+							BTRFS_STRIPE_LEN_SHIFT;
 			raid56_full_stripe_start = offset;
 
 			/*
@@ -6333,7 +6334,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 			 * reads, just allow a single stripe (on a single disk).
 			 */
 			if (op == BTRFS_MAP_WRITE) {
-				max_len = stripe_len * data_stripes -
+				max_len = (data_stripes << BTRFS_STRIPE_LEN_SHIFT) -
 					  (offset - raid56_full_stripe_start);
 			}
 		}
@@ -6344,7 +6345,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 
 	io_geom->len = len;
 	io_geom->offset = offset;
-	io_geom->stripe_len = stripe_len;
+	io_geom->stripe_len = BTRFS_STRIPE_LEN;
 	io_geom->stripe_nr = stripe_nr;
 	io_geom->stripe_offset = stripe_offset;
 	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
@@ -6353,7 +6354,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 }
 
 static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
-		          u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
+			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
 {
 	dst->dev = map->stripes[stripe_index].dev;
 	dst->physical = map->stripes[stripe_index].physical +
@@ -6369,8 +6370,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	struct extent_map *em;
 	struct map_lookup *map;
 	u64 stripe_offset;
-	u64 stripe_nr;
 	u64 stripe_len;
+	u32 stripe_nr;
 	u32 stripe_index;
 	int data_stripes;
 	int i;
@@ -6433,8 +6434,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	num_stripes = 1;
 	stripe_index = 0;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
-				&stripe_index);
+		stripe_index = stripe_nr % map->num_stripes;
+		stripe_nr /= map->num_stripes;
 		if (!need_full_stripe(op))
 			mirror_num = 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
@@ -6460,8 +6461,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		u32 factor = map->num_stripes / map->sub_stripes;
 
-		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
-		stripe_index *= map->sub_stripes;
+		stripe_index = stripe_nr % factor * map->sub_stripes;
+		stripe_nr /= factor;
 
 		if (need_full_stripe(op))
 			num_stripes = map->sub_stripes;
@@ -6477,9 +6478,16 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
-			/* push stripe_nr back to the start of the full stripe */
-			stripe_nr = div64_u64(raid56_full_stripe_start,
-					stripe_len * data_stripes);
+			/*
+			 * Push stripe_nr back to the start of the full stripe
+			 * For those cases needing a full stripe, @stripe_nr
+			 * is the full stripe number.
+			 *
+			 * Original we go raid56_full_stripe_start / full_stripe_len,
+			 * but that can be expensive.
+			 * Here we just divide @stripe_nr with @data_stripes.
+			 */
+			stripe_nr /= data_stripes;
 
 			/* RAID[56] write or recovery. Return all stripes */
 			num_stripes = map->num_stripes;
@@ -6497,25 +6505,24 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			 * Mirror #2 is RAID5 parity block.
 			 * Mirror #3 is RAID6 Q block.
 			 */
-			stripe_nr = div_u64_rem(stripe_nr,
-					data_stripes, &stripe_index);
+			stripe_index = stripe_nr % data_stripes;
+			stripe_nr /= data_stripes;
 			if (mirror_num > 1)
 				stripe_index = data_stripes + mirror_num - 2;
 
 			/* We distribute the parity blocks across stripes */
-			div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
-					&stripe_index);
+			stripe_index = (stripe_nr + stripe_index) % map->num_stripes;
 			if (!need_full_stripe(op) && mirror_num <= 1)
 				mirror_num = 1;
 		}
 	} else {
 		/*
-		 * after this, stripe_nr is the number of stripes on this
+		 * After this, stripe_nr is the number of stripes on this
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
-		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
-				&stripe_index);
+		stripe_index = stripe_nr % map->num_stripes;
+		stripe_nr /= map->num_stripes;
 		mirror_num = stripe_index + 1;
 	}
 	if (stripe_index >= map->num_stripes) {
@@ -6577,7 +6584,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		unsigned rot;
 
 		/* Work out the disk rotation on this stripe-set */
-		div_u64_rem(stripe_nr, num_stripes, &rot);
+		rot = stripe_nr % num_stripes;
 
 		/* Fill in the logical address of each stripe */
 		tmp = stripe_nr * data_stripes;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7d0d9f25864c..96dda0f4c564 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -67,7 +67,7 @@ struct btrfs_io_geometry {
 	/* offset of address in stripe */
 	u32 stripe_offset;
 	/* number of stripe where address falls */
-	u64 stripe_nr;
+	u32 stripe_nr;
 	/* offset of raid56 stripe into the chunk */
 	u64 raid56_stripe_offset;
 };
-- 
2.39.1

