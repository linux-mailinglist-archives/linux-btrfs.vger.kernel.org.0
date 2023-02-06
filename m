Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE11868BB24
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 12:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBFLTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBFLTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 06:19:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961C9ECB
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 03:19:11 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A668C60439;
        Mon,  6 Feb 2023 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675682350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPMj3nWG+LqBxYitLIkZ1F50lmtD1xVVt1LJDM55g8M=;
        b=PgLimcx5wKLIVdFKH7HgxZ/RzrdyKDIJEDt93Xne2ch2+6Rer57B50bPAdO6Y88w3gaNpH
        Sd3ddAdu8gs9LAjEy0ESmn/5PZJjwCxi9+TAVV0TTZzm1YX6woLvYuo1r2uryVzDrA1++j
        8PDbR+M2i0rtC2Py83qN5NBTWTOgNS0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 72C1C133A6;
        Mon,  6 Feb 2023 11:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SArSDS3i4GMdKgAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 06 Feb 2023 11:19:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/2] btrfs: remove map_lookup->stripe_len
Date:   Mon,  6 Feb 2023 19:18:48 +0800
Message-Id: <9f238a29f8875a7f5bebd510e324bb10062eb4ab.1675681212.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675681212.git.wqu@suse.com>
References: <cover.1675681212.git.wqu@suse.com>
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

Currently btrfs doesn't support stripe lengths other than 64KiB.
This is already in the tree-checker.

Thus there is really no meaning to record that fixed value in
map_lookup, and can all be replaced with BTRFS_STRIPE_LEN.

Furthermore we can use the fix stripe length to do the following
optimization:

- Use BTRFS_STRIPE_LEN_SHIFT to replace some 64bit division
  Now we only need to do a right shift.

  And BTRFS_STRIPE_LEN itself is already too large, thus if we
  accidentally use BTRFS_STRIPE_LEN to do bit shift, a compiler warning
  would be triggered.

  Thus this bit shift optimization would be very safe.

- Use BTRFS_STRIPE_LEN_MASK to calculate the offset inside a stripe

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c            | 10 +++---
 fs/btrfs/scrub.c                  | 43 ++++++++++++-------------
 fs/btrfs/tests/extent-map-tests.c |  1 -
 fs/btrfs/volumes.c                | 53 ++++++++++++++-----------------
 fs/btrfs/volumes.h                |  4 ++-
 5 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 45ccb25c5b1f..ded80f791adc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1994,12 +1994,12 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
-	io_stripe_size = map->stripe_len;
+	io_stripe_size = BTRFS_STRIPE_LEN;
 	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-		io_stripe_size = map->stripe_len * nr_data_stripes(map);
+		io_stripe_size = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
 
 	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
 	if (!buf) {
@@ -2020,8 +2020,10 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		if (bdev && map->stripes[i].dev->bdev != bdev)
 			continue;
 
-		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
+		stripe_nr = (physical - map->stripes[i].physical) >>
+			    BTRFS_STRIPE_LEN_SHIFT;
+		offset = (physical - map->stripes[i].physical) &
+			 BTRFS_STRIPE_LEN_MASK;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 				 BTRFS_BLOCK_GROUP_RAID10)) {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 69c93ae333f6..190536b90779 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2722,7 +2722,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 
 	if (flags & BTRFS_EXTENT_FLAG_DATA) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			blocksize = map->stripe_len;
+			blocksize = BTRFS_STRIPE_LEN;
 		else
 			blocksize = sctx->fs_info->sectorsize;
 		spin_lock(&sctx->stat_lock);
@@ -2731,7 +2731,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 		spin_unlock(&sctx->stat_lock);
 	} else if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			blocksize = map->stripe_len;
+			blocksize = BTRFS_STRIPE_LEN;
 		else
 			blocksize = sctx->fs_info->nodesize;
 		spin_lock(&sctx->stat_lock);
@@ -2920,9 +2920,9 @@ static int get_raid56_logic_offset(u64 physical, int num,
 
 	*offset = last_offset;
 	for (i = 0; i < data_stripes; i++) {
-		*offset = last_offset + i * map->stripe_len;
+		*offset = last_offset + (i << BTRFS_STRIPE_LEN_SHIFT);
 
-		stripe_nr = div64_u64(*offset, map->stripe_len);
+		stripe_nr = *offset >> BTRFS_STRIPE_LEN_SHIFT;
 		stripe_nr = div_u64(stripe_nr, data_stripes);
 
 		/* Work out the disk rotation on this stripe-set */
@@ -2935,7 +2935,7 @@ static int get_raid56_logic_offset(u64 physical, int num,
 		if (stripe_index < num)
 			j++;
 	}
-	*offset = last_offset + j * map->stripe_len;
+	*offset = last_offset + (j << BTRFS_STRIPE_LEN_SHIFT);
 	return 1;
 }
 
@@ -3205,7 +3205,7 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 	/* Path must not be populated */
 	ASSERT(!path->nodes[0]);
 
-	while (cur_logical < logical + map->stripe_len) {
+	while (cur_logical < logical + BTRFS_STRIPE_LEN) {
 		struct btrfs_io_context *bioc = NULL;
 		struct btrfs_device *extent_dev;
 		u64 extent_start;
@@ -3217,7 +3217,7 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 		u64 extent_mirror_num;
 
 		ret = find_first_extent_item(extent_root, path, cur_logical,
-					     logical + map->stripe_len - cur_logical);
+					     logical + BTRFS_STRIPE_LEN - cur_logical);
 		/* No more extent item in this data stripe */
 		if (ret > 0) {
 			ret = 0;
@@ -3231,7 +3231,7 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 		/* Metadata should not cross stripe boundaries */
 		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
 		    does_range_cross_boundary(extent_start, extent_size,
-					      logical, map->stripe_len)) {
+					      logical, BTRFS_STRIPE_LEN)) {
 			btrfs_err(fs_info,
 	"scrub: tree block %llu spanning stripes, ignored. logical=%llu",
 				  extent_start, logical);
@@ -3247,7 +3247,7 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 
 		/* Truncate the range inside this data stripe */
 		extent_size = min(extent_start + extent_size,
-				  logical + map->stripe_len) - cur_logical;
+				  logical + BTRFS_STRIPE_LEN) - cur_logical;
 		extent_start = cur_logical;
 		ASSERT(extent_size <= U32_MAX);
 
@@ -3320,8 +3320,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
 
-	ASSERT(map->stripe_len <= U32_MAX);
-	nsectors = map->stripe_len >> fs_info->sectorsize_bits;
+	nsectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
 	ASSERT(nsectors <= BITS_PER_LONG);
 	sparity = kzalloc(sizeof(struct scrub_parity), GFP_NOFS);
 	if (!sparity) {
@@ -3332,8 +3331,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 		return -ENOMEM;
 	}
 
-	ASSERT(map->stripe_len <= U32_MAX);
-	sparity->stripe_len = map->stripe_len;
+	sparity->stripe_len = BTRFS_STRIPE_LEN;
 	sparity->nsectors = nsectors;
 	sparity->sctx = sctx;
 	sparity->scrub_dev = sdev;
@@ -3344,7 +3342,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 
 	ret = 0;
 	for (cur_logical = logic_start; cur_logical < logic_end;
-	     cur_logical += map->stripe_len) {
+	     cur_logical += BTRFS_STRIPE_LEN) {
 		ret = scrub_raid56_data_stripe_for_parity(sctx, sparity, map,
 							  sdev, path, cur_logical);
 		if (ret < 0)
@@ -3536,7 +3534,7 @@ static u64 simple_stripe_full_stripe_len(const struct map_lookup *map)
 	ASSERT(map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 			    BTRFS_BLOCK_GROUP_RAID10));
 
-	return map->num_stripes / map->sub_stripes * map->stripe_len;
+	return (map->num_stripes / map->sub_stripes) << BTRFS_STRIPE_LEN_SHIFT;
 }
 
 /* Get the logical bytenr for the stripe */
@@ -3552,7 +3550,8 @@ static u64 simple_stripe_get_logical(struct map_lookup *map,
 	 * (stripe_index / sub_stripes) gives how many data stripes we need to
 	 * skip.
 	 */
-	return (stripe_index / map->sub_stripes) * map->stripe_len + bg->start;
+	return ((stripe_index / map->sub_stripes) << BTRFS_STRIPE_LEN_SHIFT) +
+	       bg->start;
 }
 
 /* Get the mirror number for the stripe */
@@ -3589,14 +3588,14 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 		 * this stripe.
 		 */
 		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg, map,
-					  cur_logical, map->stripe_len, device,
+					  cur_logical, BTRFS_STRIPE_LEN, device,
 					  cur_physical, mirror_num);
 		if (ret)
 			return ret;
 		/* Skip to next stripe which belongs to the target device */
 		cur_logical += logical_increment;
 		/* For physical offset, we just go to next stripe */
-		cur_physical += map->stripe_len;
+		cur_physical += BTRFS_STRIPE_LEN;
 	}
 	return ret;
 }
@@ -3690,7 +3689,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
 		ret = scrub_simple_stripe(sctx, root, csum_root, bg, map,
 					  scrub_dev, stripe_index);
-		offset = map->stripe_len * (stripe_index / map->sub_stripes);
+		offset = (stripe_index / map->sub_stripes) << BTRFS_STRIPE_LEN_SHIFT;
 		goto out;
 	}
 
@@ -3705,7 +3704,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	/* Initialize @offset in case we need to go to out: label */
 	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
-	increment = map->stripe_len * nr_data_stripes(map);
+	increment = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
 
 	/*
 	 * Due to the rotation, for RAID56 it's better to iterate each stripe
@@ -3736,13 +3735,13 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * is still based on @mirror_num.
 		 */
 		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
-					  logical, map->stripe_len,
+					  logical, BTRFS_STRIPE_LEN,
 					  scrub_dev, physical, 1);
 		if (ret < 0)
 			goto out;
 next:
 		logical += increment;
-		physical += map->stripe_len;
+		physical += BTRFS_STRIPE_LEN;
 		spin_lock(&sctx->stat_lock);
 		if (stop_loop)
 			sctx->stat.last_physical =
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index c5b3a631bf4f..5d09fc4e1c3c 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -486,7 +486,6 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	em->map_lookup = map;
 
 	map->num_stripes = test->num_stripes;
-	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->type = test->raid_type;
 
 	for (i = 0; i < map->num_stripes; i++) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 883e5d2a23b6..4f659425a2ab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5095,7 +5095,7 @@ static void init_alloc_chunk_ctl_policy_regular(
 	/* We don't want a chunk larger than 10% of writable space */
 	ctl->max_chunk_size = min(mult_perc(fs_devices->total_rw_bytes, 10),
 				  ctl->max_chunk_size);
-	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
+	ctl->dev_extent_min = ctl->dev_stripes << BTRFS_STRIPE_LEN_SHIFT;
 }
 
 static void init_alloc_chunk_ctl_policy_zoned(
@@ -5377,7 +5377,6 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 						   j * ctl->stripe_size;
 		}
 	}
-	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
 	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = type;
@@ -5585,11 +5584,11 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 
 	btrfs_set_stack_chunk_length(chunk, bg->length);
 	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
-	btrfs_set_stack_chunk_stripe_len(chunk, map->stripe_len);
+	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_type(chunk, map->type);
 	btrfs_set_stack_chunk_num_stripes(chunk, map->num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, map->stripe_len);
-	btrfs_set_stack_chunk_io_width(chunk, map->stripe_len);
+	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
+	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_sector_size(chunk, fs_info->sectorsize);
 	btrfs_set_stack_chunk_sub_stripes(chunk, map->sub_stripes);
 
@@ -5779,7 +5778,7 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	if (!WARN_ON(IS_ERR(em))) {
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			len = map->stripe_len * nr_data_stripes(map);
+			len = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
 		free_extent_map(em);
 	}
 	return len;
@@ -5945,7 +5944,6 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	u64 stripe_nr_end;
 	u64 stripe_end_offset;
 	u64 stripe_cnt;
-	u64 stripe_len;
 	u64 stripe_offset;
 	u32 stripe_index;
 	u32 factor = 0;
@@ -5966,26 +5964,25 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		ret = -EOPNOTSUPP;
 		goto out_free_map;
-}
+	}
 
 	offset = logical - em->start;
 	length = min_t(u64, em->start + em->len - logical, length);
 	*length_ret = length;
 
-	stripe_len = map->stripe_len;
 	/*
 	 * stripe_nr counts the total number of stripes we have to stride
 	 * to get to this block
 	 */
-	stripe_nr = div64_u64(offset, stripe_len);
+	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 
 	/* stripe_offset is the offset of this block in its stripe */
-	stripe_offset = offset - stripe_nr * stripe_len;
+	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 
-	stripe_nr_end = round_up(offset + length, map->stripe_len);
-	stripe_nr_end = div64_u64(stripe_nr_end, map->stripe_len);
+	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN) >>
+			BTRFS_STRIPE_LEN_SHIFT;
 	stripe_cnt = stripe_nr_end - stripe_nr;
-	stripe_end_offset = stripe_nr_end * map->stripe_len -
+	stripe_end_offset = (stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
 			    (offset + length);
 	/*
 	 * after this, stripe_nr is the number of stripes on this
@@ -6027,15 +6024,15 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < *num_stripes; i++) {
 		stripes[i].physical =
 			map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
+			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 		stripes[i].dev = map->stripes[stripe_index].dev;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 				 BTRFS_BLOCK_GROUP_RAID10)) {
-			stripes[i].length = stripes_per_dev * map->stripe_len;
+			stripes[i].length = stripes_per_dev << BTRFS_STRIPE_LEN_SHIFT;
 
 			if (i / sub_stripes < remaining_stripes)
-				stripes[i].length += map->stripe_len;
+				stripes[i].length += BTRFS_STRIPE_LEN;
 
 			/*
 			 * Special for the first stripe and
@@ -6293,7 +6290,6 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	u64 offset;
 	u64 stripe_offset;
 	u64 stripe_nr;
-	u32 stripe_len;
 	u64 raid56_full_stripe_start = (u64)-1;
 	int data_stripes;
 
@@ -6302,26 +6298,25 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	map = em->map_lookup;
 	/* Offset of this logical address in the chunk */
 	offset = logical - em->start;
-	/* Len of a stripe in a chunk */
-	stripe_len = map->stripe_len;
 	/*
 	 * Stripe_nr is where this block falls in
 	 * stripe_offset is the offset of this block in its stripe.
 	 */
-	stripe_nr = div64_u64_rem(offset, stripe_len, &stripe_offset);
-	ASSERT(stripe_offset < U32_MAX);
+	stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
+	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 
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
@@ -6338,7 +6333,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 			 * reads, just allow a single stripe (on a single disk).
 			 */
 			if (op == BTRFS_MAP_WRITE) {
-				max_len = stripe_len * data_stripes -
+				max_len = (data_stripes << BTRFS_STRIPE_LEN_SHIFT) -
 					  (offset - raid56_full_stripe_start);
 			}
 		}
@@ -6349,7 +6344,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 
 	io_geom->len = len;
 	io_geom->offset = offset;
-	io_geom->stripe_len = stripe_len;
+	io_geom->stripe_len = BTRFS_STRIPE_LEN;
 	io_geom->stripe_nr = stripe_nr;
 	io_geom->stripe_offset = stripe_offset;
 	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
@@ -6362,7 +6357,7 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 {
 	dst->dev = map->stripes[stripe_index].dev;
 	dst->physical = map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
+			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 }
 
 int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -6481,7 +6476,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		ASSERT(map->stripe_len == BTRFS_STRIPE_LEN);
 		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
 			/* push stripe_nr back to the start of the full stripe */
 			stripe_nr = div64_u64(raid56_full_stripe_start,
@@ -6589,7 +6583,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		tmp = stripe_nr * data_stripes;
 		for (i = 0; i < data_stripes; i++)
 			bioc->raid_map[(i + rot) % num_stripes] =
-				em->start + (tmp + i) * map->stripe_len;
+				em->start + ((tmp + i) << BTRFS_STRIPE_LEN_SHIFT);
 
 		bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
@@ -6962,7 +6956,6 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	map->num_stripes = num_stripes;
 	map->io_width = btrfs_chunk_io_width(leaf, chunk);
 	map->io_align = btrfs_chunk_io_align(leaf, chunk);
-	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	map->type = type;
 	/*
 	 * We can't use the sub_stripes value, as for profiles other than
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6b7a05f6cf82..c2248b60de62 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -19,6 +19,9 @@ extern struct mutex uuid_mutex;
 
 #define BTRFS_STRIPE_LEN	SZ_64K
 
+#define BTRFS_STRIPE_LEN_SHIFT	(const_ilog2(BTRFS_STRIPE_LEN))
+#define BTRFS_STRIPE_LEN_MASK	(BTRFS_STRIPE_LEN - 1)
+
 /* Used by sanity check for btrfs_raid_types. */
 #define const_ffs(n) (__builtin_ctzll(n) + 1)
 
@@ -461,7 +464,6 @@ struct map_lookup {
 	u64 type;
 	int io_align;
 	int io_width;
-	u32 stripe_len;
 	int num_stripes;
 	int sub_stripes;
 	int verified_stripes; /* For mount time dev extent verification */
-- 
2.39.1

