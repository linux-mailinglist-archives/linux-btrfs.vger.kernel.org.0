Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AFA47B866
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 03:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhLUCeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 21:34:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhLUCeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 21:34:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF6721F388
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640054051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBOwMZeHVOU9hmTubpPDi70b48EgScyoZ0Hq/ee0J3s=;
        b=rTIlBWcl89y+xim7bRDh/CKv0a4UZRfcSfS40uZQ1PjgIsbkODHVPYZ3ZKKcp7Eb/7jx9X
        mpRH/tiiFw8go11YnNu2TJJgpbsRKkzzDzFHKXt1aCE7KU85t6QTbLL6XFCE97Z1a6cc36
        Zb1v7p4pppI5QrlKJwGImlXtxpw0FOk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3837313BDA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDaBACM9wWEOLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 02:34:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/4] btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub
Date:   Tue, 21 Dec 2021 10:33:49 +0800
Message-Id: <20211221023349.27696-5-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221023349.27696-1-wqu@suse.com>
References: <20211221023349.27696-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although RAID56 has complex repair mechanism, which involves reading the
whole full stripe, but for current data stripe scrub, it's in fact no
different than SINGLE/RAID1.

The point here is, for data stripe we just check the csum for each
extent we hit.
Only for csum mismatch case, our repair path divides.

So we can still reuse scrub_simple_mirror() for RAID56 data stripes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 330 +++++++----------------------------------------
 1 file changed, 49 insertions(+), 281 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aff9db6fbc7e..c0c2e9bfd606 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3505,66 +3505,27 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_root *csum_root;
-	struct btrfs_extent_item *extent;
 	struct blk_plug plug;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 	const u64 chunk_logical = bg->start;
-	u64 flags;
 	int ret;
-	int slot;
 	u64 nstripes;
-	struct extent_buffer *l;
 	u64 physical;
 	u64 logical;
 	u64 logic_end;
 	u64 physical_end;
-	u64 generation;
-	int mirror_num;
-	struct btrfs_key key;
-	u64 increment = map->stripe_len;
-	u64 offset;
-	u64 extent_logical;
-	u64 extent_physical;
-	/*
-	 * Unlike chunk length, extent length should never go beyond
-	 * BTRFS_MAX_EXTENT_SIZE, thus u32 is enough here.
-	 */
-	u32 extent_len;
+	u64 increment;	/* The logical increment after finishing one stripe */
+	u64 offset;	/* Offset inside the chunk */
 	u64 stripe_logical;
 	u64 stripe_end;
-	struct btrfs_device *extent_dev;
-	int extent_mirror_num;
 	int stop_loop = 0;
 
-	physical = map->stripes[stripe_index].physical;
-	offset = 0;
-	nstripes = div64_u64(dev_ext_len, map->stripe_len);
-	mirror_num = 1;
-	increment = map->stripe_len;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		offset = map->stripe_len * stripe_index;
-		increment = map->stripe_len * map->num_stripes;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
-		int factor = map->num_stripes / map->sub_stripes;
-		offset = map->stripe_len * (stripe_index / map->sub_stripes);
-		increment = map->stripe_len * factor;
-		mirror_num = stripe_index % map->sub_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		mirror_num = stripe_index % map->num_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		mirror_num = stripe_index % map->num_stripes + 1;
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		get_raid56_logic_offset(physical, stripe_index, map, &offset,
-					NULL);
-		increment = map->stripe_len * nr_data_stripes(map);
-	}
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	/*
-	 * work on commit root. The related disk blocks are static as
+	 * Work on commit root. The related disk blocks are static as
 	 * long as COW is applied. This means, it is save to rewrite
 	 * them to repair disk errors without any race conditions
 	 */
@@ -3572,32 +3533,24 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	path->skip_locking = 1;
 	path->reada = READA_FORWARD;
 
-	logical = chunk_logical + offset;
-	physical_end = physical + nstripes * map->stripe_len;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		get_raid56_logic_offset(physical_end, stripe_index,
-					map, &logic_end, NULL);
-		logic_end += chunk_logical;
-	} else {
-		logic_end = logical + increment * nstripes;
-	}
 	wait_event(sctx->list_wait,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
-	root = btrfs_extent_root(fs_info, logical);
-	csum_root = btrfs_csum_root(fs_info, logical);
+	root = btrfs_extent_root(fs_info, bg->start);
+	csum_root = btrfs_csum_root(fs_info, bg->start);
 
 	/*
-	 * collect all data csums for the stripe to avoid seeking during
+	 * Collect all data csums for the stripe to avoid seeking during
 	 * the scrub. This might currently (crc32) end up to be about 1MB
 	 */
 	blk_start_plug(&plug);
 
 	if (sctx->is_dev_replace &&
-	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev,
+				    map->stripes[stripe_index].physical)) {
 		mutex_lock(&sctx->wr_lock);
-		sctx->write_pointer = physical;
+		sctx->write_pointer = map->stripes[stripe_index].physical;
 		mutex_unlock(&sctx->wr_lock);
 		sctx->flush_all_writes = true;
 	}
@@ -3633,239 +3586,54 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	/* Only RAID56 goes through the old code */
 	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+
+	physical = map->stripes[stripe_index].physical;
+	offset = 0;
+	nstripes = div64_u64(dev_ext_len, map->stripe_len);
+	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
+	increment = map->stripe_len * nr_data_stripes(map);
+
+	logical = chunk_logical + offset;
+	physical_end = physical + nstripes * map->stripe_len;
+	get_raid56_logic_offset(physical_end, stripe_index, map, &logic_end,
+				NULL);
+	logic_end += chunk_logical;
+
 	ret = 0;
+	/*
+	 * Due to the rotation, for RAID56 it's better to iterate each stripe
+	 * using their physical offset.
+	 */
 	while (physical < physical_end) {
-		/*
-		 * canceled?
-		 */
-		if (atomic_read(&fs_info->scrub_cancel_req) ||
-		    atomic_read(&sctx->cancel_req)) {
-			ret = -ECANCELED;
-			goto out;
+		ret = get_raid56_logic_offset(physical, stripe_index, map,
+					      &logical, &stripe_logical);
+		logical += chunk_logical;
+		if (ret) {
+			/* It is parity strip */
+			stripe_logical += chunk_logical;
+			stripe_end = stripe_logical + increment;
+			ret = scrub_raid56_parity(sctx, map, scrub_dev,
+						  stripe_logical,
+						  stripe_end);
+			if (ret)
+				goto out;
+			goto next;
 		}
+
 		/*
-		 * check to see if we have to pause
+		 * Now we're at data stripes, scrub each extents in the range.
+		 *
+		 * At this stage, if we ignore the repair part, each data stripe
+		 * is no different than SINGLE profile.
+		 * We can reuse scrub_simple_mirror() here, as the repair part
+		 * is still based on @mirror_num.
 		 */
-		if (atomic_read(&fs_info->scrub_pause_req)) {
-			/* push queued extents */
-			sctx->flush_all_writes = true;
-			scrub_submit(sctx);
-			mutex_lock(&sctx->wr_lock);
-			scrub_wr_submit(sctx);
-			mutex_unlock(&sctx->wr_lock);
-			wait_event(sctx->list_wait,
-				   atomic_read(&sctx->bios_in_flight) == 0);
-			sctx->flush_all_writes = false;
-			scrub_blocked_if_needed(fs_info);
-		}
-
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-			ret = get_raid56_logic_offset(physical, stripe_index,
-						      map, &logical,
-						      &stripe_logical);
-			logical += chunk_logical;
-			if (ret) {
-				/* it is parity strip */
-				stripe_logical += chunk_logical;
-				stripe_end = stripe_logical + increment;
-				ret = scrub_raid56_parity(sctx, map, scrub_dev,
-							  stripe_logical,
-							  stripe_end);
-				if (ret)
-					goto out;
-				goto skip;
-			}
-		}
-
-		if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
-			key.type = BTRFS_METADATA_ITEM_KEY;
-		else
-			key.type = BTRFS_EXTENT_ITEM_KEY;
-		key.objectid = logical;
-		key.offset = (u64)-1;
-
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
+					  logical, map->stripe_len,
+					  scrub_dev, physical, 1);
 		if (ret < 0)
 			goto out;
-
-		if (ret > 0) {
-			ret = btrfs_previous_extent_item(root, path, 0);
-			if (ret < 0)
-				goto out;
-			if (ret > 0) {
-				/* there's no smaller item, so stick with the
-				 * larger one */
-				btrfs_release_path(path);
-				ret = btrfs_search_slot(NULL, root, &key,
-							path, 0, 0);
-				if (ret < 0)
-					goto out;
-			}
-		}
-
-		stop_loop = 0;
-		while (1) {
-			u64 bytes;
-
-			l = path->nodes[0];
-			slot = path->slots[0];
-			if (slot >= btrfs_header_nritems(l)) {
-				ret = btrfs_next_leaf(root, path);
-				if (ret == 0)
-					continue;
-				if (ret < 0)
-					goto out;
-
-				stop_loop = 1;
-				break;
-			}
-			btrfs_item_key_to_cpu(l, &key, slot);
-
-			if (key.type != BTRFS_EXTENT_ITEM_KEY &&
-			    key.type != BTRFS_METADATA_ITEM_KEY)
-				goto next;
-
-			if (key.type == BTRFS_METADATA_ITEM_KEY)
-				bytes = fs_info->nodesize;
-			else
-				bytes = key.offset;
-
-			if (key.objectid + bytes <= logical)
-				goto next;
-
-			if (key.objectid >= logical + map->stripe_len) {
-				/* out of this device extent */
-				if (key.objectid >= logic_end)
-					stop_loop = 1;
-				break;
-			}
-
-			/*
-			 * If our block group was removed in the meanwhile, just
-			 * stop scrubbing since there is no point in continuing.
-			 * Continuing would prevent reusing its device extents
-			 * for new block groups for a long time.
-			 */
-			spin_lock(&bg->lock);
-			if (bg->removed) {
-				spin_unlock(&bg->lock);
-				ret = 0;
-				goto out;
-			}
-			spin_unlock(&bg->lock);
-
-			extent = btrfs_item_ptr(l, slot,
-						struct btrfs_extent_item);
-			flags = btrfs_extent_flags(l, extent);
-			generation = btrfs_extent_generation(l, extent);
-
-			if ((flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
-			    (key.objectid < logical ||
-			     key.objectid + bytes >
-			     logical + map->stripe_len)) {
-				btrfs_err(fs_info,
-					   "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
-				       key.objectid, logical);
-				spin_lock(&sctx->stat_lock);
-				sctx->stat.uncorrectable_errors++;
-				spin_unlock(&sctx->stat_lock);
-				goto next;
-			}
-
-again:
-			extent_logical = key.objectid;
-			ASSERT(bytes <= U32_MAX);
-			extent_len = bytes;
-
-			/*
-			 * trim extent to this stripe
-			 */
-			if (extent_logical < logical) {
-				extent_len -= logical - extent_logical;
-				extent_logical = logical;
-			}
-			if (extent_logical + extent_len >
-			    logical + map->stripe_len) {
-				extent_len = logical + map->stripe_len -
-					     extent_logical;
-			}
-
-			extent_physical = extent_logical - logical + physical;
-			extent_dev = scrub_dev;
-			extent_mirror_num = mirror_num;
-			if (sctx->is_dev_replace)
-				scrub_remap_extent(fs_info, extent_logical,
-						   extent_len, &extent_physical,
-						   &extent_dev,
-						   &extent_mirror_num);
-
-			if (flags & BTRFS_EXTENT_FLAG_DATA) {
-				ret = btrfs_lookup_csums_range(csum_root,
-						extent_logical,
-						extent_logical + extent_len - 1,
-						&sctx->csum_list, 1);
-				if (ret)
-					goto out;
-			}
-
-			ret = scrub_extent(sctx, map, extent_logical, extent_len,
-					   extent_physical, extent_dev, flags,
-					   generation, extent_mirror_num,
-					   extent_logical - logical + physical);
-
-			scrub_free_csums(sctx);
-
-			if (ret)
-				goto out;
-
-			if (sctx->is_dev_replace)
-				sync_replace_for_zoned(sctx);
-
-			if (extent_logical + extent_len <
-			    key.objectid + bytes) {
-				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-					/*
-					 * loop until we find next data stripe
-					 * or we have finished all stripes.
-					 */
-loop:
-					physical += map->stripe_len;
-					ret = get_raid56_logic_offset(physical,
-							stripe_index, map,
-							&logical, &stripe_logical);
-					logical += chunk_logical;
-
-					if (ret && physical < physical_end) {
-						stripe_logical += chunk_logical;
-						stripe_end = stripe_logical +
-								increment;
-						ret = scrub_raid56_parity(sctx,
-							map, scrub_dev,
-							stripe_logical,
-							stripe_end);
-						if (ret)
-							goto out;
-						goto loop;
-					}
-				} else {
-					physical += map->stripe_len;
-					logical += increment;
-				}
-				if (logical < key.objectid + bytes) {
-					cond_resched();
-					goto again;
-				}
-
-				if (physical >= physical_end) {
-					stop_loop = 1;
-					break;
-				}
-			}
 next:
-			path->slots[0]++;
-		}
-		btrfs_release_path(path);
-skip:
 		logical += increment;
 		physical += map->stripe_len;
 		spin_lock(&sctx->stat_lock);
-- 
2.34.1

