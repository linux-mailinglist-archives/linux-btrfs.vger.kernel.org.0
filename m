Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E86A2EAC
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Feb 2023 07:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBZG5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Feb 2023 01:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZG5I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Feb 2023 01:57:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBA15572
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 22:57:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 229AF2197E
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 06:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677394624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OOkzVPwQgnAAClAwzQZEyS/YMrDFdQK/ZTVcYjf5mAo=;
        b=ta/AgJkP66X5nq5ahGK2eOkRVbtMIDk7iAOax40FdTVHS2IPy1BQqkjmZ7/YnZ1s7XHic9
        d00q+HAYwyF044/o7LV5BrMOcVHXz2GA3hc6fHbtBRv82vq317j7RGwdR67q+XYarwv7RD
        nnv5PeYyZJTknrUEiNNRKFl4KqHeMVw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B844139B5
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 06:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PIsjCL8C+2MeYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 06:57:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: refactor __btrfs_map_block()
Date:   Sun, 26 Feb 2023 14:56:45 +0800
Message-Id: <e7d711b6ea444e2f018516f4187f9a614e81af38.1677394468.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

This refactor mostly focuses on using a generic way to handle stripe
selection, with minimal per-chunk-type special handling.

This brings some extra benefits:

- Better single stripe quick path
  Now even for dev-replace running with WRITE operations, we may still
  got single stripe, and still go through the fast path.
  E.g. write into RAID0, while the replace is not involved in the
  stripe.

- More common path for all profiles
  The only real difference is for RAID56 and non-RAID56.
  As RAID56 write needs to map the full stripe, not just the input
  logical range.

- Better comments
  This refactor saves no code line by a quick glance, but all the saved
  lines are mostly replaced by more extensive comments.

The only hiccup would be:

- Slightly complex handling for MAP_READ case without @smap
  We still have 3 call sites using MAP_READ without an @smap.
  This brings us the need to handle such cases differently.

  Although 2 of the call sites can be converted, the one in
  check-integrity.c is much harder to convert.

Now the workflow of __btrfs_map_block() is:

- Grab the chunk map

- Calculate @nr_stripes_div, @nr_stripes_inc and @phy_div
  The two numbers means, after every @nr_stripes_div stripes, we will
  advance our stripe index by @nr_stripes_inc.
  And after every @phy_div stripes, we increase our physical offset by
  BTRFS_STRIPE_LEN.

  These two numbers are going to calculate @init_stripe, which would be
  the first mirror for non-RAID56 profiles, or the first data stripe
  for RAID56.

  This brings the following table:

  |   Type  |    @nr_stripes_div    | @nr_stripes_inc |   @phy_div   |
  +---------+-----------------------+-----------------+--------------+
  | SINGLE  |                     1 |               0 |            1 |
  | DUP     |                     1 |               0 |            1 |
  | RAID1   |                     1 |               0 |            1 |
  | RAID1C* |                     1 |               0 |            1 |
  | RAID0   |                     1 |               1 |  num_stripes |
  | RAID10  |                     1 |     sub_stripes |    num / sub |
  | RAID5   |          data_stripes |               1 | data_stripes |
  | RAID6   |          data_stripes |               1 | data_stripes |

  So we only needs 3 types:
  * SINGLE/DUP/RAID1*
    @nr_stripes_div = 1
    @nr_stripes_inc = 1
    @phy_div = 1

  * RAID0/RAID10
    @nr_stripes_div = num_stripes / sub_stripes
    @nr_stripes_inc = sub_stripes
    @phy_div = num_stripes / sub_stripes

  * RAID5/RAID6
    @nr_stripes_div = data_stripes
    @nr_stripes_inc = 1
    @phy_div = data_stripes

- Calculate @init_stripes and @physical_delta
  @physical_delta is the physical difference of the stripes.

  With above @nr_stripes_div and @nr_stripe_inc, @init_stripe is very
  easy:

  @init_stripe = (stripe_nr / nr_stripes_div * nr_stripes_inc) %
		 map->num_stripes

  So is @physical_delta:

  @pjysical_delta = (stripe_nr / phy_div ) << BTRFS_STRIPE_LEN_SHIFT

- Select the target stripe for single stripe usage
  For non-RAID56, it's @init_stripe + @mirror_num - 1, where @mirror_num
  must be >= 1.

  For RAID56, we needs to advance (stripe_nr % data_stripes) stripes.

- Handle single stripe case
  Now we have a more accurate check, which can handle cases like running
  replace while the stripes doesn't involve the replace source.

- Allocate and setup bioc

- Handle replace case

Although with my extensive comments, the code save is not that obvious,
but should explain the code much better.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Please fetch the whole series from my github tree:

 https://github.com/adam900710/linux/tree/map_block_refactor

This has a hard dependency: "btrfs: do not use replace target
device as an extra mirror".
---
 fs/btrfs/volumes.c | 326 +++++++++++++++++++++++----------------------
 1 file changed, 164 insertions(+), 162 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 52e1fc2a79f4..8be7e4a53b83 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6147,11 +6147,6 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	bioc->replace_nr_stripes = nr_extra_stripes;
 }
 
-static bool need_full_stripe(enum btrfs_map_op op)
-{
-	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
-}
-
 static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
 			    u64 *full_stripe_start)
@@ -6201,11 +6196,43 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 }
 
 static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
-			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
+			  u32 stripe_index, u64 stripe_offset, u64 physical_delta)
 {
 	dst->dev = map->stripes[stripe_index].dev;
 	dst->physical = map->stripes[stripe_index].physical +
-			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + physical_delta;
+}
+
+static int calc_replace_stripes(struct btrfs_fs_info *fs_info,
+				enum btrfs_map_op op, struct map_lookup *map,
+				int init_stripe, int num_stripes)
+{
+	struct btrfs_dev_replace *replace = &fs_info->dev_replace;
+	int found = 0;
+	int i;
+
+	/* Caller should have replace rwsem hold. */
+	lockdep_assert_held(&replace->rwsem);
+
+	/* No dev_replace running. */
+	if (!btrfs_dev_replace_is_ongoing(replace))
+		return 0;
+
+	/* Read won't utilize dev-replace at all.*/
+	if (op == BTRFS_MAP_READ)
+		return 0;
+
+	/*
+	 * The remaining cases are GET_MIRRORS and write, they all need full
+	 * stripes. So here we check if the involved stripes are involved.
+	 */
+	for (i = 0; i < num_stripes; i++) {
+		struct btrfs_io_stripe *stripe = &map->stripes[(init_stripe + i) %
+								map->num_stripes];
+		if (stripe->dev == replace->srcdev)
+			found++;
+	}
+	return found;
 }
 
 int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -6219,7 +6246,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	u64 map_offset;
 	u64 stripe_offset;
 	u32 stripe_nr;
-	u32 stripe_index;
 	int data_stripes;
 	int i;
 	int ret = 0;
@@ -6227,10 +6253,43 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int num_stripes;
 	int num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
 	int max_errors = 0;
+	enum btrfs_raid_types raid_index;
+	bool need_full_stripe;
+	bool single_stripe = false;
+	/*
+	 * This is the index of the first stripe for the profile.
+	 * For non-RAID56, it's the mirror 1 of the stripe.
+	 * For RAID56, it's the first data stripe.
+	 *
+	 * And @stripe_index can be easily calculated based on @init_stripe.
+	 * For non-RAID56, it's @init_stripe + (@mirror_num - 1) (mirror_num >= 1).
+	 * For RAID56, it's @init_stripes + (@stripe_nr % @data_stripes).
+	 */
+	int init_stripe = 0;
+	u32 stripe_index;
+	/*
+	 * The following members determines how the @init_stripe number changes.
+	 * After every @nr_stripes_div stripe, we forward @init_stripe by
+	 * @nr_stripe_inc.
+	 * After every @phy_div stripe, we increase @physical_delta by
+	 * BTRFS_STRIPE_LEN.
+	 */
+	int nr_stripes_div;
+	int nr_stripes_inc;
+	int phy_div;
+	u64 physical_delta;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
-	int dev_replace_is_ongoing = 0;
+	/*
+	 * The number of stripes for full stripe usage, excluding the stripes
+	 * for dev-replace.
+	 */
 	u16 num_alloc_stripes;
+	/*
+	 * The number of dev-replace stripes needed. For DUP it can be 2,
+	 * otherwise no more than 1.
+	 */
+	u16 num_replace_stripes = 0;
 	u64 raid56_full_stripe_start = (u64)-1;
 	u64 max_len;
 
@@ -6239,159 +6298,107 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	if (mirror_num > num_copies)
 		return -EINVAL;
-
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
-
 	map = em->map_lookup;
+	raid_index = btrfs_bg_flags_to_raid_index(map->type);
+
+	/* Select a proper mirror_num, as later we rely on mirror_num >= 1. */
+	if (mirror_num == 0) {
+		if (map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK |
+				 BTRFS_BLOCK_GROUP_RAID10))
+			mirror_num = find_live_mirror(fs_info, map, 0, false) + 1;
+		else
+			mirror_num = 1;
+	}
+	ASSERT(mirror_num >= 1);
+
+	/* For write, get_mirror or RAID56 rebuild, we need all stripes. */
+	if (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS ||
+	    (op == BTRFS_MAP_READ && map->type & BTRFS_BLOCK_GROUP_RAID56_MASK
+	     && mirror_num > 1))
+		need_full_stripe = true;
+
 	data_stripes = nr_data_stripes(map);
+	num_alloc_stripes = num_copies;
 
 	map_offset = logical - em->start;
 	max_len = btrfs_max_io_len(map, op, map_offset, &stripe_nr,
 				   &stripe_offset, &raid56_full_stripe_start);
 	*length = min_t(u64, em->len - map_offset, max_len);
 
+	/* Calculate @nr_stripes_div and @nr_stripes_inc. */
+	switch (raid_index) {
+	case BTRFS_RAID_RAID0:
+	case BTRFS_RAID_RAID10:
+		nr_stripes_div = 1;
+		nr_stripes_inc = map->sub_stripes;
+		phy_div = map->num_stripes / map->sub_stripes;
+		break;
+	case BTRFS_RAID_RAID5:
+	case BTRFS_RAID_RAID6:
+		nr_stripes_div = data_stripes;
+		nr_stripes_inc = 1;
+		phy_div = data_stripes;
+		num_alloc_stripes = map->num_stripes;
+		break;
+	default:
+		nr_stripes_div = 1;
+		nr_stripes_inc = 0;
+		phy_div = 1;
+		break;
+	}
+	init_stripe = (stripe_nr / nr_stripes_div * nr_stripes_inc) %
+		      map->num_stripes;
+	physical_delta = (stripe_nr / phy_div) << BTRFS_STRIPE_LEN_SHIFT;
+	num_stripes = num_alloc_stripes;
+
+	/* Select the stripe for RAID56. */
+	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		stripe_index = (init_stripe + (stripe_nr % data_stripes)) %
+				map->num_stripes;
+	else
+		stripe_index = init_stripe + mirror_num - 1;
+
 	down_read(&dev_replace->rwsem);
-	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
+	num_replace_stripes = calc_replace_stripes(fs_info, op, map, init_stripe,
+						   num_alloc_stripes);
 	/*
 	 * Hold the semaphore for read during the whole operation, write is
 	 * requested at commit time but must wait.
 	 */
-	if (!dev_replace_is_ongoing)
+	if (!num_replace_stripes)
 		up_read(&dev_replace->rwsem);
 
-	num_stripes = 1;
-	stripe_index = 0;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		stripe_index = stripe_nr % map->num_stripes;
-		stripe_nr /= map->num_stripes;
-		if (!need_full_stripe(op))
-			mirror_num = 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		if (need_full_stripe(op))
-			num_stripes = map->num_stripes;
-		else if (mirror_num)
-			stripe_index = mirror_num - 1;
-		else {
-			stripe_index = find_live_mirror(fs_info, map, 0,
-					    dev_replace_is_ongoing);
-			mirror_num = stripe_index + 1;
-		}
-
-	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		if (need_full_stripe(op)) {
-			num_stripes = map->num_stripes;
-		} else if (mirror_num) {
-			stripe_index = mirror_num - 1;
-		} else {
-			mirror_num = 1;
-		}
-
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
-		u32 factor = map->num_stripes / map->sub_stripes;
-
-		stripe_index = (stripe_nr % factor) * map->sub_stripes;
-		stripe_nr /= factor;
-
-		if (need_full_stripe(op))
-			num_stripes = map->sub_stripes;
-		else if (mirror_num)
-			stripe_index += mirror_num - 1;
-		else {
-			int old_stripe_index = stripe_index;
-			stripe_index = find_live_mirror(fs_info, map,
-					      stripe_index,
-					      dev_replace_is_ongoing);
-			mirror_num = stripe_index - old_stripe_index + 1;
-		}
-
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
-			/*
-			 * Push stripe_nr back to the start of the full stripe
-			 * For those cases needing a full stripe, @stripe_nr
-			 * is the full stripe number.
-			 *
-			 * Originally we go raid56_full_stripe_start / full_stripe_len,
-			 * but that can be expensive.  Here we just divide
-			 * @stripe_nr with @data_stripes.
-			 */
-			stripe_nr /= data_stripes;
-
-			/* RAID[56] write or recovery. Return all stripes */
-			num_stripes = map->num_stripes;
-			max_errors = btrfs_chunk_max_errors(map);
-
-			/* Return the length to the full stripe end */
-			*length = min(logical + *length,
-				      raid56_full_stripe_start + em->start +
-				      (data_stripes << BTRFS_STRIPE_LEN_SHIFT)) - logical;
-			stripe_index = 0;
-			stripe_offset = 0;
-		} else {
-			/*
-			 * Mirror #0 or #1 means the original data block.
-			 * Mirror #2 is RAID5 parity block.
-			 * Mirror #3 is RAID6 Q block.
-			 */
-			stripe_index = stripe_nr % data_stripes;
-			stripe_nr /= data_stripes;
-			if (mirror_num > 1)
-				stripe_index = data_stripes + mirror_num - 2;
-
-			/* We distribute the parity blocks across stripes */
-			stripe_index = (stripe_nr + stripe_index) % map->num_stripes;
-			if (!need_full_stripe(op) && mirror_num <= 1)
-				mirror_num = 1;
-		}
-	} else {
-		/*
-		 * After this, stripe_nr is the number of stripes on this
-		 * device we have to walk to find the data, and stripe_index is
-		 * the number of our device in the stripe array
-		 */
-		stripe_index = stripe_nr % map->num_stripes;
-		stripe_nr /= map->num_stripes;
-		mirror_num = stripe_index + 1;
-	}
-	if (stripe_index >= map->num_stripes) {
-		btrfs_crit(fs_info,
-			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
-			   stripe_index, map->num_stripes);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	num_alloc_stripes = num_stripes;
-	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
-	    op != BTRFS_MAP_READ)
-		/*
-		 * For replace case, we need to add extra stripes for extra
-		 * duplicated stripes.
-		 *
-		 * For both WRITE and GET_READ_MIRRORS, we may have at most
-		 * 2 more stripes (DUP types, otherwise 1).
-		 */
-		num_alloc_stripes += 2;
-
 	/*
 	 * If this I/O maps to a single device, try to return the device and
 	 * physical block information on the stack instead of allocating an
 	 * I/O context structure.
+	 *
+	 * This includes the following cases:
+	 *
+	 * - Non-RAID56 rebuild read
+	 * - Write that has only one stripe
+	 *   This includes dev-replace stripes.
 	 */
-	if (smap && num_alloc_stripes == 1 &&
-	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
-	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
-	     !dev_replace->tgtdev)) {
-		set_io_stripe(smap, map, stripe_index, stripe_offset,
-			      stripe_nr);
-		*mirror_num_ret = mirror_num;
-		*bioc_ret = NULL;
-		ret = 0;
-		goto out;
+	if (((op == BTRFS_MAP_READ &&
+	     !(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && mirror_num > 1)) ||
+	     num_alloc_stripes + num_replace_stripes == 1)) {
+		if (smap) {
+			set_io_stripe(smap, map, stripe_index, stripe_offset,
+				      physical_delta);
+			*mirror_num_ret = mirror_num;
+			*bioc_ret = NULL;
+			ret = 0;
+			goto out;
+		}
+		/* We may still have MAP_READ without @smap. */
+		single_stripe = true;
+		num_alloc_stripes = 1;
+		num_replace_stripes = 0;
 	}
 
-	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes);
+	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes + num_replace_stripes);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
@@ -6403,44 +6410,39 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * rule that data stripes are all ordered, then followed with P and Q
 	 * (if we have).
 	 *
-	 * It's still mostly the same as other profiles, just with extra rotation.
+	 * It's still mostly the same as other profiles, just with extra rotation,
+	 * and full stripe mapping (aka, no @stripe_offset involved).
 	 */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
-	    (need_full_stripe(op) || mirror_num > 1)) {
-		/*
-		 * For RAID56 @stripe_nr is already the number of full stripes
-		 * before us, which is also the rotation value (needs to modulo
-		 * with num_stripes).
-		 *
-		 * In this case, we just add @stripe_nr with @i, then do the
-		 * modulo, to reduce one modulo call.
-		 */
+	    need_full_stripe) {
+		/* Just go all stripes starting from @init_stripe. */
 		bioc->full_stripe_logical = em->start +
-			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
-		for (i = 0; i < num_stripes; i++)
+			(rounddown(stripe_nr, data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
+		for (i = 0; i < map->num_stripes; i++)
 			set_io_stripe(&bioc->stripes[i], map,
-				      (i + stripe_nr) % num_stripes,
-				      stripe_offset, stripe_nr);
+				      (init_stripe + i) % map->num_stripes, 0,
+				      physical_delta);
+	} else if (single_stripe) {
+		set_io_stripe(&bioc->stripes[0], map, stripe_index,
+			      stripe_offset, physical_delta);
 	} else {
 		/*
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
-		for (i = 0; i < num_stripes; i++) {
-			set_io_stripe(&bioc->stripes[i], map, stripe_index,
-				      stripe_offset, stripe_nr);
-			stripe_index++;
-		}
+		for (i = 0; i < num_copies; i++)
+			set_io_stripe(&bioc->stripes[i], map,
+				      (init_stripe + i) % map->num_stripes,
+				      stripe_offset, physical_delta);
 	}
 
-	if (need_full_stripe(op))
+	if (need_full_stripe)
 		max_errors = btrfs_chunk_max_errors(map);
 
-	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
-	    need_full_stripe(op)) {
+	if (num_replace_stripes && dev_replace->tgtdev != NULL &&
+	    need_full_stripe)
 		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
 					  &num_stripes, &max_errors);
-	}
 
 	*bioc_ret = bioc;
 	bioc->num_stripes = num_stripes;
@@ -6448,7 +6450,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
+	if (num_replace_stripes) {
 		lockdep_assert_held(&dev_replace->rwsem);
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
-- 
2.39.1

