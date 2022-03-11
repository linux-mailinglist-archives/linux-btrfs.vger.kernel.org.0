Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F304D5C7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347237AbiCKHkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347232AbiCKHkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:40:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2665A5A9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:39:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8D5F218FF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646984353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVoHYz49EAj5wQQgEvVsc0HGQp2Sb2e64Vv2Us+yh7s=;
        b=Yhy2oqgrYPatbWuziOLqXMqY+SelkmRJc3PWOkk2n5e2CJkNEs8G6tsdgx4HMyEbDITMrN
        n32MfasWkNSLsV1OCZIiaiTcOoaiikmVIhxVCzkS+CmDn/1biLlkViKpR/uYfq0e0ENe/6
        hlBOcnRo+hq7HNMGYs0rRN8EN/2Uizs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AF4C13A82
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNv0BaH8KmKkJgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 07:39:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 6/9] btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub
Date:   Fri, 11 Mar 2022 15:38:46 +0800
Message-Id: <bfa310be0adaabf5301ca9d7eef220f2f911b25f.1646984153.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646984153.git.wqu@suse.com>
References: <cover.1646984153.git.wqu@suse.com>
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

Although RAID56 has complex repair mechanism, which involves reading the
whole full stripe, but inside one data stripe, it's in fact no
different than SINGLE/RAID1.

The point here is, for data stripe we just check the csum for each
extent we hit.
Only for csum mismatch case, our repair paths divide.

So we can still reuse scrub_simple_mirror() for RAID56 data stripes,
which saves quite some code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 255 +++++------------------------------------------
 1 file changed, 24 insertions(+), 231 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ddfbca03791b..cd34db07e387 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3520,33 +3520,18 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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
-	struct extent_buffer *l;
 	u64 physical = map->stripes[stripe_index].physical;
+	const u64 physical_end = physical + dev_extent_len;
 	u64 logical;
 	u64 logic_end;
-	const u64 physical_end = physical + dev_extent_len;
-	u64 generation;
-	struct btrfs_key key;
-	u64 increment;
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
 
 	path = btrfs_alloc_path();
@@ -3554,7 +3539,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		return -ENOMEM;
 
 	/*
-	 * work on commit root. The related disk blocks are static as
+	 * Work on commit root. The related disk blocks are static as
 	 * long as COW is applied. This means, it is save to rewrite
 	 * them to repair disk errors without any race conditions
 	 */
@@ -3570,7 +3555,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	csum_root = btrfs_csum_root(fs_info, bg->start);
 
 	/*
-	 * collect all data csums for the stripe to avoid seeking during
+	 * Collect all data csums for the stripe to avoid seeking during
 	 * the scrub. This might currently (crc32) end up to be about 1MB
 	 */
 	blk_start_plug(&plug);
@@ -3627,37 +3612,16 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
 	increment = map->stripe_len * nr_data_stripes(map);
 
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
-		}
-		/*
-		 * check to see if we have to pause
-		 */
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
-		ret = get_raid56_logic_offset(physical, stripe_index,
-					      map, &logical,
-					      &stripe_logical);
+		ret = get_raid56_logic_offset(physical, stripe_index, map,
+					      &logical, &stripe_logical);
 		logical += chunk_logical;
 		if (ret) {
-			/* it is parity strip */
+			/* It is parity strip */
 			stripe_logical += chunk_logical;
 			stripe_end = stripe_logical + increment;
 			ret = scrub_raid56_parity(sctx, map, scrub_dev,
@@ -3665,194 +3629,23 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 						  stripe_end);
 			if (ret)
 				goto out;
-			goto skip;
+			goto next;
 		}
 
-		if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
-			key.type = BTRFS_METADATA_ITEM_KEY;
-		else
-			key.type = BTRFS_EXTENT_ITEM_KEY;
-		key.objectid = logical;
-		key.offset = (u64)-1;
-
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		/*
+		 * Now we're at a data stripe, scrub each extents in the range.
+		 *
+		 * At this stage, if we ignore the repair part, inside each data
+		 * stripe it is no different than SINGLE profile.
+		 * We can reuse scrub_simple_mirror() here, as the repair part
+		 * is still based on @mirror_num.
+		 */
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
-			/* For RAID56 data stripes, mirror_num is fixed to 1 */
-			extent_mirror_num = 1;
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
-				/*
-				 * loop until we find next data stripe
-				 * or we have finished all stripes.
-				 */
-loop:
-				physical += map->stripe_len;
-				ret = get_raid56_logic_offset(physical,
-						stripe_index, map,
-						&logical, &stripe_logical);
-				logical += chunk_logical;
-
-				if (ret && physical < physical_end) {
-					stripe_logical += chunk_logical;
-					stripe_end = stripe_logical +
-							increment;
-					ret = scrub_raid56_parity(sctx,
-						map, scrub_dev,
-						stripe_logical,
-						stripe_end);
-					if (ret)
-						goto out;
-					goto loop;
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
2.35.1

