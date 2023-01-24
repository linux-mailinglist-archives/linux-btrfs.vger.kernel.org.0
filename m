Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE5679277
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 09:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjAXIAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 03:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjAXIAu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 03:00:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B803EFC6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 00:00:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 070F4218E6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674547243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x6YRQnGtBq+TNx039uwWbVnsHjW/GWUxtLjIwiKCimM=;
        b=mPLuBxBwOzY7ptFFhHP6ELkdTuKbzTPlRURNSkLFrJXCVH2svRssJNyDn82N6SgWaOd9h0
        RkJGTjDqQa07KoJgOGgW6iPPKXqbWuowaMfbqf1LrWBUkc8x1zubHNEyfvvsXA62Yv/Zg0
        rRHsrkrDE4EV4UWiPQDnoCZBEStLNx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F11F139FB
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 08:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pmxWCiqQz2MYIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 08:00:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: separate single stripe optimization into a dedicate branch
Date:   Tue, 24 Jan 2023 16:00:24 +0800
Message-Id: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
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

Commit 03793cbbc80f ("btrfs: add fast path for single device io in
__btrfs_map_block") added a fast handling for single device read/write
path.

However the function __btrfs_map_block() itself is going to be very
complex already.
The input value array is already complex, even for that fast path.

Here is the truth value table for it.

The T/F/D result is whether we can go single stripe path.
D means it depends, need extra conditions.

Table for OP related:

      | SINGLE | DUP | RAID0 | RAID10 | RAID1C* | RAID56 |
------+--------+-----+-------+--------+---------+--------+
 Read | T      | T   | T     | T      | T       | D (*1) |
 Write| D (*2) | F   | D (*2)| F      | F       | F      |

*1: Only true if the mirror_num is 0/1, aka, directly read from
    data stripes.
*2: Only true if there is no running dev-replace for our chunk.

Thus the complexity is already worthy a dedicated branch to even handle
the very simple single stripe fast path.

This patch would add dedicated handling for the fast path, with extra
comments, hoping we can at least make it easier to read.

Furthermore this patch would only distinguish RAID56 and non-raid56 in
map_single_stripe(), all non-RAID56 would have a unified handling.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch would looks awful by itself, as it's causing a lot of new
lines.

But firstly, a lot of the new lines are just comments.

Secondly I hope my RAID56/non-RAID56 split can later be used to
refactor the slow path.
---
 fs/btrfs/volumes.c | 232 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 209 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bcfef75b97da..6e3ab84948ec 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6353,6 +6353,25 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	return 0;
 }
 
+/* Calculate the number of stripes we need for dev-replace case. */
+static int calc_replace_stripes(struct btrfs_fs_info *fs_info,
+				struct map_lookup *map)
+{
+	int ret = 0;
+	int i;
+
+	if (!btrfs_dev_replace_is_ongoing(&fs_info->dev_replace))
+		return ret;
+
+	for (i = 0; i < map->num_stripes; i++) {
+		struct btrfs_io_stripe *stripe = &map->stripes[i];
+
+		if (stripe->dev == fs_info->dev_replace.srcdev)
+			ret++;
+	}
+	return ret;
+}
+
 static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
 		          u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
 {
@@ -6361,6 +6380,179 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 			stripe_offset + stripe_nr * map->stripe_len;
 }
 
+static bool is_single_stripe(struct btrfs_fs_info *fs_info,
+			     struct map_lookup *map, enum btrfs_map_op op,
+			     int mirror_num)
+{
+	enum btrfs_raid_types raid_index = btrfs_bg_flags_to_raid_index(map->type);
+	bool is_raid56 = map->type & BTRFS_BLOCK_GROUP_RAID56_MASK;
+	int num_write_stripes;
+
+	if (op == BTRFS_MAP_READ) {
+		int replace_target;
+
+		/*
+		 * If we're reading from a simple mirror for non-RAID56, it's
+		 * always a single stripe, including running dev-replace case.
+		 */
+		if (!is_raid56)
+			return true;
+
+		if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+			replace_target = 2 + 1;
+		else
+			replace_target = map->num_stripes + 1;
+		/*
+		 * For RAID56, we can only return a single stripe if it's reading
+		 * from data stripes.
+		 * This includes two cases, regular read, or read from data stripes
+		 * on replace target.
+		 */
+		if (mirror_num <= 1 || mirror_num == replace_target)
+			return true;
+
+		/* RAID56, recover case, needs the full stripe. */
+		return false;
+	}
+
+	/*
+	 * Write cases, we still have chances to have sinle stripe.
+	 *
+	 * For write case, we have two parts containing stripes:
+	 *
+	 * - Stripes we need to write to
+	 * - Stripes we need to duplicate for replace.
+	 */
+	ASSERT(op == BTRFS_MAP_WRITE);
+
+	/*
+	 * Calculate the stripes we need to write to.
+	 * For RAID56, it's number of stripes, other wise it's ncopies of
+	 * the profiles.
+	 */
+	if (is_raid56)
+		num_write_stripes = map->num_stripes;
+	else
+		num_write_stripes = btrfs_raid_array[raid_index].ncopies;
+
+	if (num_write_stripes > 1)
+		return false;
+
+	/* Single write stripe case, but still need to check dev-replace. */
+	lockdep_assert_held_read(&fs_info->dev_replace.rwsem);
+	/* No running replace and only single stripe to write. */
+	if (!btrfs_dev_replace_is_ongoing(&fs_info->dev_replace))
+		return true;
+	/*
+	 * Calcluate the stipres for dev-replace.
+	 * We have to go through the map and compare with the replace source,
+	 * as the replace can be unrelated to our chunk.
+	 */
+	if (calc_replace_stripes(fs_info, map))
+		return false;
+
+	return true;
+}
+
+static int patch_single_stripe_for_replace(struct btrfs_fs_info *fs_info,
+					   struct btrfs_io_stripe *smap,
+					   int mirror_num, int ncopies)
+{
+	if (mirror_num > ncopies) {
+		if (mirror_num == ncopies + 1 &&
+		    btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
+		    fs_info->dev_replace.srcdev == smap->dev &&
+		    fs_info->dev_replace.tgtdev)
+			smap->dev = fs_info->dev_replace.tgtdev;
+		else
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static int map_single_stripe(struct btrfs_fs_info *fs_info,
+			     struct btrfs_io_stripe *smap,
+			     struct map_lookup *map,
+			     struct btrfs_io_geometry *geom,
+			     enum btrfs_map_op op,
+			     int mirror_num)
+{
+	enum btrfs_raid_types raid_index = btrfs_bg_flags_to_raid_index(map->type);
+	bool is_raid56 = map->type & BTRFS_BLOCK_GROUP_RAID56_MASK;
+	int data_stripes = nr_data_stripes(map);
+	int ncopies;
+	int target;
+	int rot;
+
+	/* For non-RAID56, just select the target stripe.*/
+	if (!is_raid56) {
+		/*
+		 * After BTRFS_STRIPE_LEN bytes, we need to forward @stripe_inc
+		 * stripes, and increase physical by (stripe_nr / @stripe_div) *
+		 * BTRFS_STRIPE_LEN bytes.
+		 *
+		 * The default values would handle SINGLE/DUP/RAID1*.
+		 * Only need to update to handle RAID0 and RAID10.
+		 */
+		int stripe_inc = 0;
+		int stripe_div = 1;
+
+		/*
+		 * No special request on mirror_num, select one according to
+		 * the read policy.
+		 */
+		if (mirror_num == 0 && op == BTRFS_MAP_READ)
+			mirror_num = find_live_mirror(fs_info, map, 0, 0);
+
+		ncopies = btrfs_raid_array[raid_index].ncopies;
+
+		if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) {
+			stripe_inc = map->sub_stripes;
+			stripe_div = map->num_stripes / map->sub_stripes;
+		}
+
+
+		target = (mirror_num - 1 + (geom->stripe_nr * stripe_inc)) %
+			 map->num_stripes;
+
+		smap->dev = map->stripes[target].dev;
+		smap->physical = map->stripes[target].physical +
+				 geom->stripe_nr / stripe_div * BTRFS_STRIPE_LEN +
+				 geom->stripe_offset;
+		return patch_single_stripe_for_replace(fs_info, smap,
+						       mirror_num, ncopies);
+	}
+
+	/*
+	 * For RAID56 case, select the data stripes direct.
+	 *
+	 * Thus if our mirror_num is not specified, go 1 as default.
+	 */
+	if (mirror_num == 0)
+		mirror_num = 1;
+
+	/* Calculate the rotation first. */
+	rot = div_u64(geom->raid56_stripe_offset, data_stripes * BTRFS_STRIPE_LEN);
+
+	/* Calculate the stripe_index without rotation. */
+	div_u64_rem(geom->stripe_nr, data_stripes, &target);
+
+	/* Get final stripe with rotation. */
+	div_u64_rem(target + rot, map->num_stripes, &target);
+
+	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+		ncopies = 2;
+	else
+		ncopies = map->num_stripes;
+
+	smap->dev = map->stripes[target].dev;
+	smap->physical = map->stripes[target].physical +
+			 geom->stripe_nr / data_stripes * BTRFS_STRIPE_LEN +
+			 geom->stripe_offset;
+	return patch_single_stripe_for_replace(fs_info, smap, mirror_num,
+					       ncopies);
+}
+
 int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		      u64 logical, u64 *length,
 		      struct btrfs_io_context **bioc_ret,
@@ -6409,6 +6601,23 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	data_stripes = nr_data_stripes(map);
 
 	down_read(&dev_replace->rwsem);
+	/*
+	 * If this I/O maps to a single device, try to return the device and
+	 * physical block information on the stack instead of allocating an
+	 * I/O context structure.
+	 */
+	if (smap && is_single_stripe(fs_info, map, op, mirror_num)) {
+		if (mirror_num == 0)
+			mirror_num = 1;
+
+		ret = map_single_stripe(fs_info, smap, map, &geom, op,
+					mirror_num);
+		up_read(&dev_replace->rwsem);
+		*bioc_ret = NULL;
+		free_extent_map(em);
+		return ret;
+	}
+
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 	/*
 	 * Hold the semaphore for read during the whole operation, write is
@@ -6537,29 +6746,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		tgtdev_indexes = num_stripes;
 	}
 
-	/*
-	 * If this I/O maps to a single device, try to return the device and
-	 * physical block information on the stack instead of allocating an
-	 * I/O context structure.
-	 */
-	if (smap && num_alloc_stripes == 1 &&
-	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
-	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
-	     !dev_replace->tgtdev)) {
-		if (patch_the_first_stripe_for_dev_replace) {
-			smap->dev = dev_replace->tgtdev;
-			smap->physical = physical_to_patch_in_first_stripe;
-			*mirror_num_ret = map->num_stripes + 1;
-		} else {
-			set_io_stripe(smap, map, stripe_index, stripe_offset,
-				      stripe_nr);
-			*mirror_num_ret = mirror_num;
-		}
-		*bioc_ret = NULL;
-		ret = 0;
-		goto out;
-	}
-
 	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
-- 
2.39.1

