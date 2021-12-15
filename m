Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE0475374
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 08:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbhLOHA1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 02:00:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbhLOHAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 02:00:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 549AD1F382
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639551603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sStcuSOWH8xyXN/TsDICXyzWNU1sAmMxY+et0OWbMwU=;
        b=WnktsNMEtX4IYiAFHLdz5Hj5OQkeU0a3K4PDP5SOn7dhWroQPja6JWgTIuq1fPkzevPO+B
        ewL6o+R1LGJ/WPJq+GRiERUANDc2cuiAtEu8TgfpkELq1xI6bP8cUvgZWes6HBuXqgkRq3
        bwkB4SwpZoeSu8Pz8CzUX5TZfbQs5Ms=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4347139CF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 07:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KIxnIHKSuWHiEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 07:00:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: cleanup the argument list of scrub_stripe()
Date:   Wed, 15 Dec 2021 14:59:42 +0800
Message-Id: <20211215065942.26683-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215065942.26683-1-wqu@suse.com>
References: <20211215065942.26683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The argument list of btrfs_stripe() has similar problems of
scrub_chunk():

- Duplicated and ambiguous @base argument
  Can be fetched from btrfs_block_group::bg.

- Ambiguous argument @length
  It's again device extent length

- Ambiguous argument @num
  The instinctive guess would be mirror number, but in fact it's stripe
  index.

Fix it by:

- Remove @base parameter

- Rename @length to @dev_ext_len

- Rename @num to @stripe_index

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 67 +++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ffbaf6fbf71c..f20ad60dcc0e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3173,10 +3173,10 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 }
 
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
+					   struct btrfs_block_group *bg,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
-					   int num, u64 base, u64 length,
-					   struct btrfs_block_group *cache)
+					   int stripe_index, u64 dev_ext_len)
 {
 	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
@@ -3184,6 +3184,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	struct btrfs_root *csum_root;
 	struct btrfs_extent_item *extent;
 	struct blk_plug plug;
+	const u64 chunk_logical = bg->start;
 	u64 flags;
 	int ret;
 	int slot;
@@ -3211,25 +3212,26 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	int extent_mirror_num;
 	int stop_loop = 0;
 
-	physical = map->stripes[num].physical;
+	physical = map->stripes[stripe_index].physical;
 	offset = 0;
-	nstripes = div64_u64(length, map->stripe_len);
+	nstripes = div64_u64(dev_ext_len, map->stripe_len);
 	mirror_num = 1;
 	increment = map->stripe_len;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		offset = map->stripe_len * num;
+		offset = map->stripe_len * stripe_index;
 		increment = map->stripe_len * map->num_stripes;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		int factor = map->num_stripes / map->sub_stripes;
-		offset = map->stripe_len * (num / map->sub_stripes);
+		offset = map->stripe_len * (stripe_index / map->sub_stripes);
 		increment = map->stripe_len * factor;
-		mirror_num = num % map->sub_stripes + 1;
+		mirror_num = stripe_index % map->sub_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		mirror_num = num % map->num_stripes + 1;
+		mirror_num = stripe_index % map->num_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		mirror_num = num % map->num_stripes + 1;
+		mirror_num = stripe_index % map->num_stripes + 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		get_raid56_logic_offset(physical, num, map, &offset, NULL);
+		get_raid56_logic_offset(physical, stripe_index, map, &offset,
+					NULL);
 		increment = map->stripe_len * nr_data_stripes(map);
 	}
 
@@ -3246,12 +3248,12 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	path->skip_locking = 1;
 	path->reada = READA_FORWARD;
 
-	logical = base + offset;
+	logical = chunk_logical + offset;
 	physical_end = physical + nstripes * map->stripe_len;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		get_raid56_logic_offset(physical_end, num,
+		get_raid56_logic_offset(physical_end, stripe_index,
 					map, &logic_end, NULL);
-		logic_end += base;
+		logic_end += chunk_logical;
 	} else {
 		logic_end = logical + increment * nstripes;
 	}
@@ -3306,13 +3308,13 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		}
 
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-			ret = get_raid56_logic_offset(physical, num, map,
-						      &logical,
+			ret = get_raid56_logic_offset(physical, stripe_index,
+						      map, &logical,
 						      &stripe_logical);
-			logical += base;
+			logical += chunk_logical;
 			if (ret) {
 				/* it is parity strip */
-				stripe_logical += base;
+				stripe_logical += chunk_logical;
 				stripe_end = stripe_logical + increment;
 				ret = scrub_raid56_parity(sctx, map, scrub_dev,
 							  stripe_logical,
@@ -3392,13 +3394,13 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			 * Continuing would prevent reusing its device extents
 			 * for new block groups for a long time.
 			 */
-			spin_lock(&cache->lock);
-			if (cache->removed) {
-				spin_unlock(&cache->lock);
+			spin_lock(&bg->lock);
+			if (bg->removed) {
+				spin_unlock(&bg->lock);
 				ret = 0;
 				goto out;
 			}
-			spin_unlock(&cache->lock);
+			spin_unlock(&bg->lock);
 
 			extent = btrfs_item_ptr(l, slot,
 						struct btrfs_extent_item);
@@ -3477,12 +3479,12 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 loop:
 					physical += map->stripe_len;
 					ret = get_raid56_logic_offset(physical,
-							num, map, &logical,
-							&stripe_logical);
-					logical += base;
+							stripe_index, map,
+							&logical, &stripe_logical);
+					logical += chunk_logical;
 
 					if (ret && physical < physical_end) {
-						stripe_logical += base;
+						stripe_logical += chunk_logical;
 						stripe_end = stripe_logical +
 								increment;
 						ret = scrub_raid56_parity(sctx,
@@ -3516,8 +3518,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		physical += map->stripe_len;
 		spin_lock(&sctx->stat_lock);
 		if (stop_loop)
-			sctx->stat.last_physical = map->stripes[num].physical +
-						   length;
+			sctx->stat.last_physical = map->stripes[stripe_index].physical +
+						   dev_ext_len;
 		else
 			sctx->stat.last_physical = physical;
 		spin_unlock(&sctx->stat_lock);
@@ -3537,9 +3539,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
 
-		ret2 = sync_write_pointer_for_zoned(sctx, base + offset,
-						    map->stripes[num].physical,
-						    physical_end);
+		ret2 = sync_write_pointer_for_zoned(sctx,
+				chunk_logical + offset,
+				map->stripes[stripe_index].physical,
+				physical_end);
 		if (ret2)
 			ret = ret2;
 	}
@@ -3585,8 +3588,8 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	for (i = 0; i < map->num_stripes; ++i) {
 		if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
 		    map->stripes[i].physical == dev_offset) {
-			ret = scrub_stripe(sctx, map, scrub_dev, i,
-					   bg->start, dev_ext_len, bg);
+			ret = scrub_stripe(sctx, bg, map, scrub_dev, i,
+					   dev_ext_len);
 			if (ret)
 				goto out;
 		}
-- 
2.34.1

