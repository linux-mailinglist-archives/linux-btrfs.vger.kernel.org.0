Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22D643E79
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiLFIY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiLFIYI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32315FD7
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:06 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98DD21FDC8
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQ3S0hgdMPVDvH+JgrVnpPFqM2yrGjiHlk3SHkGjLPY=;
        b=oibH25gVIql/O+Z38AQst51JSNKuOuIiriXj4CU4KH0IQGvN3fonhw1peA0yu0RDh+UXsi
        iI3BpXjEx77WtNAPeH+dKR4masLyfVyL0l3N5F0Uew268eU8/UfIgWaBMl5xlzAsHWQoLE
        lqmlvNnRQrzeKLQYVSgtGoW21BzRb3k=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 00502132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4JafLyT8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 09/11] btrfs: scrub: switch to the new scrub2_stripe based infrastructure
Date:   Tue,  6 Dec 2022 16:23:36 +0800
Message-Id: <f5eeb85a235e5ff762ef1bf60587a76c43dee4c2.1670314744.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
References: <cover.1670314744.git.wqu@suse.com>
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

Since scrub2_stripe now can handle both regular and raid56 scrubbing,
it's time to switch to the new infrastructure.

Please note that, the following old functions are temporarily exported:

- scrub_extent()
- scrub_raid56_parity()

The reason is, the cleanup is too large (will be at least 2K lines
removed), thus this patch is really just doing the minimal to switch the
infrastructure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 192 ++++++++++++++++++++++-------------------------
 fs/btrfs/scrub.h |  21 ++----
 2 files changed, 98 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9a9e706cba3e..77209792fa90 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -416,8 +416,8 @@ static void free_scrub2_stripe(struct scrub2_stripe *stripe)
 	kfree(stripe);
 }
 
-struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
-					  struct btrfs_block_group *bg)
+static struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
+						 struct btrfs_block_group *bg)
 {
 	struct scrub2_stripe *stripe;
 	int ret;
@@ -2908,10 +2908,10 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 }
 
 /* scrub extent tries to collect up to 64 kB for each bio */
-static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
-			u64 logical, u32 len,
-			u64 physical, struct btrfs_device *dev, u64 flags,
-			u64 gen, int mirror_num)
+int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
+		 u64 logical, u32 len, u64 physical,
+		 struct btrfs_device *dev, u64 flags,
+		 u64 gen, int mirror_num)
 {
 	struct btrfs_device *src_dev = dev;
 	u64 src_physical = physical;
@@ -3497,11 +3497,9 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 	return ret;
 }
 
-static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
-						  struct map_lookup *map,
-						  struct btrfs_device *sdev,
-						  u64 logic_start,
-						  u64 logic_end)
+int scrub_raid56_parity(struct scrub_ctx *sctx, struct map_lookup *map,
+			struct btrfs_device *sdev, u64 logic_start,
+			u64 logic_end)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_path *path;
@@ -3631,11 +3629,11 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
  * Return >0 if there is no such stripe in the specified range.
  * Return <0 for error.
  */
-int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
-				  struct btrfs_root *csum_root,
-				  struct btrfs_block_group *bg,
-				  u64 logical_start, u64 logical_len,
-				  struct scrub2_stripe *stripe)
+static int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
+					 struct btrfs_root *csum_root,
+					 struct btrfs_block_group *bg,
+					 u64 logical_start, u64 logical_len,
+					 struct scrub2_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = extent_root->fs_info;
 	const u64 logical_end = logical_start + logical_len;
@@ -4116,8 +4114,8 @@ static void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
 		      &stripe->current_error_bitmap, stripe->nr_sectors);
 }
 
-void scrub2_report_errors(struct scrub_ctx *sctx,
-			  struct scrub2_stripe *stripe)
+static void scrub2_report_errors(struct scrub_ctx *sctx,
+				 struct scrub2_stripe *stripe)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
@@ -4401,10 +4399,10 @@ static void scrub2_wait_raid56_scrub_endio(struct bio *bio)
  * stripes, and only when all of the sectors in them are fine, we can
  * check the parity.
  */
-int scrub2_raid56_parity(struct scrub_ctx *sctx,
-			 struct btrfs_block_group *bg,
-			 struct btrfs_device *target,
-			 u64 full_stripe_logical)
+static int scrub2_raid56_parity(struct scrub_ctx *sctx,
+				struct btrfs_block_group *bg,
+				struct btrfs_device *target,
+				u64 full_stripe_logical)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct scrub2_stripe_group full_stripe;
@@ -4472,6 +4470,30 @@ int scrub2_raid56_parity(struct scrub_ctx *sctx,
 	return ret;
 }
 
+/* Only reset the bitmaps and scrub2_sector info, but keeps the pages. */
+static void scrub2_reset_stripe(struct scrub2_stripe *stripe)
+{
+	int i;
+
+	stripe->used_sector_bitmap = 0;
+	stripe->init_error_bitmap = 0;
+	stripe->current_error_bitmap = 0;
+
+	stripe->io_error_bitmap = 0;
+	stripe->csum_error_bitmap = 0;
+	stripe->meta_error_bitmap = 0;
+	stripe->write_error_bitmap = 0;
+
+	stripe->nr_meta_extents = 0;
+	stripe->nr_data_extents = 0;
+
+	for (i = 0; i < stripe->nr_sectors; i++) {
+		stripe->sectors[i].is_metadata = false;
+		stripe->sectors[i].csum = NULL;
+		stripe->sectors[i].generation = 0;
+	}
+}
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
@@ -4481,6 +4503,7 @@ int scrub2_raid56_parity(struct scrub_ctx *sctx,
  * and @logical_length parameter.
  */
 static int scrub_simple_mirror(struct scrub_ctx *sctx,
+			       struct scrub2_stripe *stripe,
 			       struct btrfs_root *extent_root,
 			       struct btrfs_root *csum_root,
 			       struct btrfs_block_group *bg,
@@ -4491,8 +4514,6 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	const u64 logical_end = logical_start + logical_length;
-	/* An artificial limit, inherit from old scrub behavior */
-	const u32 max_length = SZ_64K;
 	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
 	int ret;
@@ -4502,13 +4523,12 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 	path.search_commit_root = 1;
 	path.skip_locking = 1;
+
+	stripe->mirror_num = mirror_num;
+
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
-		u64 extent_start;
-		u64 extent_len;
-		u64 extent_flags;
-		u64 extent_gen;
-		u64 scrub_len;
+		unsigned long writeback_bitmap = 0;
 
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
@@ -4538,8 +4558,10 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		spin_unlock(&bg->lock);
 
-		ret = find_first_extent_item(extent_root, &path, cur_logical,
-					     logical_end - cur_logical);
+		scrub2_reset_stripe(stripe);
+		ret = scrub2_find_fill_first_stripe(extent_root, csum_root, bg,
+				cur_logical, logical_end - cur_logical, stripe);
+
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
 			sctx->stat.last_physical = physical + logical_length;
@@ -4548,52 +4570,30 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		if (ret < 0)
 			break;
-		get_extent_info(&path, &extent_start, &extent_len,
-				&extent_flags, &extent_gen);
-		/* Skip hole range which doesn't have any extent */
-		cur_logical = max(extent_start, cur_logical);
+		scrub2_read_and_wait_stripe(stripe);
+		scrub2_repair_one_stripe(stripe);
+		scrub2_report_errors(sctx, stripe);
 
-		/*
-		 * Scrub len has three limits:
-		 * - Extent size limit
-		 * - Scrub range limit
-		 *   This is especially imporatant for RAID0/RAID10 to reuse
-		 *   this function
-		 * - Max scrub size limit
-		 */
-		scrub_len = min(min(extent_start + extent_len,
-				    logical_end), cur_logical + max_length) -
-			    cur_logical;
+		if (sctx->is_dev_replace) {
+			/* We have to write all good sectors back. */
+			bitmap_andnot(&writeback_bitmap,
+				      &stripe->used_sector_bitmap,
+				      &stripe->current_error_bitmap,
+				      stripe->nr_sectors);
+			scrub2_writeback_sectors(stripe, &writeback_bitmap);
 
-		if (extent_flags & BTRFS_EXTENT_FLAG_DATA) {
-			ret = btrfs_lookup_csums_list(csum_root, cur_logical,
-					cur_logical + scrub_len - 1,
-					&sctx->csum_list, 1, false);
-			if (ret)
-				break;
-		}
-		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
-		    does_range_cross_boundary(extent_start, extent_len,
-					      logical_start, logical_length)) {
-			btrfs_err(fs_info,
-"scrub: tree block %llu spanning boundaries, ignored. boundary=[%llu, %llu)",
-				  extent_start, logical_start, logical_end);
-			spin_lock(&sctx->stat_lock);
-			sctx->stat.uncorrectable_errors++;
-			spin_unlock(&sctx->stat_lock);
-			cur_logical += scrub_len;
-			continue;
-		}
-		ret = scrub_extent(sctx, map, cur_logical, scrub_len,
-				   cur_logical - logical_start + physical,
-				   device, extent_flags, extent_gen,
-				   mirror_num);
-		scrub_free_csums(sctx);
-		if (ret)
-			break;
-		if (sctx->is_dev_replace)
+			/* TODO: add support for zoned devices. */
 			sync_replace_for_zoned(sctx);
-		cur_logical += scrub_len;
+		} else if (!sctx->readonly) {
+			/* Only writeback the repaired sectors. */
+			bitmap_andnot(&writeback_bitmap,
+				      &stripe->init_error_bitmap,
+				      &stripe->current_error_bitmap,
+				      stripe->nr_sectors);
+			scrub2_writeback_sectors(stripe, &writeback_bitmap);
+		}
+		cur_logical = stripe->logical + BTRFS_STRIPE_LEN;
+
 		/* Don't hold CPU for too long time */
 		cond_resched();
 	}
@@ -4638,6 +4638,7 @@ static int simple_stripe_mirror_num(struct map_lookup *map, int stripe_index)
 }
 
 static int scrub_simple_stripe(struct scrub_ctx *sctx,
+			       struct scrub2_stripe *stripe,
 			       struct btrfs_root *extent_root,
 			       struct btrfs_root *csum_root,
 			       struct btrfs_block_group *bg,
@@ -4659,9 +4660,9 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
 		 * this stripe.
 		 */
-		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg, map,
-					  cur_logical, map->stripe_len, device,
-					  cur_physical, mirror_num);
+		ret = scrub_simple_mirror(sctx, stripe, extent_root, csum_root,
+					  bg, map, cur_logical, map->stripe_len,
+					  device, cur_physical, mirror_num);
 		if (ret)
 			return ret;
 		/* Skip to next stripe which belongs to the target device */
@@ -4678,10 +4679,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct btrfs_device *scrub_dev,
 					   int stripe_index)
 {
-	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_root *csum_root;
+	struct scrub2_stripe *stripe;
 	struct blk_plug plug;
 	struct map_lookup *map = em->map_lookup;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
@@ -4697,22 +4698,12 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	/* Offset inside the chunk */
 	u64 offset;
 	u64 stripe_logical;
-	u64 stripe_end;
 	int stop_loop = 0;
 
-	path = btrfs_alloc_path();
-	if (!path)
+	stripe = alloc_scrub2_stripe(fs_info, bg);
+	if (!stripe)
 		return -ENOMEM;
 
-	/*
-	 * work on commit root. The related disk blocks are static as
-	 * long as COW is applied. This means, it is save to rewrite
-	 * them to repair disk errors without any race conditions
-	 */
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-	path->reada = READA_FORWARD;
-
 	wait_event(sctx->list_wait,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
@@ -4751,16 +4742,16 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * Only @physical and @mirror_num needs to calculated using
 		 * @stripe_index.
 		 */
-		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
-				bg->start, bg->length, scrub_dev,
+		ret = scrub_simple_mirror(sctx, stripe, root, csum_root, bg,
+				map, bg->start, bg->length, scrub_dev,
 				map->stripes[stripe_index].physical,
 				stripe_index + 1);
 		offset = 0;
 		goto out;
 	}
 	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
-		ret = scrub_simple_stripe(sctx, root, csum_root, bg, map,
-					  scrub_dev, stripe_index);
+		ret = scrub_simple_stripe(sctx, stripe, root, csum_root, bg,
+					  map, scrub_dev, stripe_index);
 		offset = map->stripe_len * (stripe_index / map->sub_stripes);
 		goto out;
 	}
@@ -4789,10 +4780,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		if (ret) {
 			/* it is parity strip */
 			stripe_logical += chunk_logical;
-			stripe_end = stripe_logical + increment;
-			ret = scrub_raid56_parity(sctx, map, scrub_dev,
-						  stripe_logical,
-						  stripe_end);
+			ret = scrub2_raid56_parity(sctx, bg, scrub_dev,
+						   stripe_logical);
 			if (ret)
 				goto out;
 			goto next;
@@ -4806,8 +4795,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * We can reuse scrub_simple_mirror() here, as the repair part
 		 * is still based on @mirror_num.
 		 */
-		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
-					  logical, map->stripe_len,
+		ret = scrub_simple_mirror(sctx, stripe, root, csum_root, bg,
+					  map, logical, map->stripe_len,
 					  scrub_dev, physical, 1);
 		if (ret < 0)
 			goto out;
@@ -4825,6 +4814,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			break;
 	}
 out:
+	free_scrub2_stripe(stripe);
+
 	/* push queued extents */
 	scrub_submit(sctx);
 	mutex_lock(&sctx->wr_lock);
@@ -4832,7 +4823,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	mutex_unlock(&sctx->wr_lock);
 
 	blk_finish_plug(&plug);
-	btrfs_free_path(path);
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index c22349380c50..1498c770fb77 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -17,19 +17,12 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
  * The following functions are temporary exports to avoid warning on unused
  * static functions.
  */
-struct scrub2_stripe;
-struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
-					  struct btrfs_block_group *bg);
-int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
-				  struct btrfs_root *csum_root,
-				  struct btrfs_block_group *bg,
-				  u64 logical_start, u64 logical_len,
-				  struct scrub2_stripe *stripe);
-void scrub2_report_errors(struct scrub_ctx *sctx,
-			  struct scrub2_stripe *stripe);
-int scrub2_raid56_parity(struct scrub_ctx *sctx,
-			 struct btrfs_block_group *bg,
-			 struct btrfs_device *target,
-			 u64 full_stripe_logical);
+int scrub_raid56_parity(struct scrub_ctx *sctx, struct map_lookup *map,
+			struct btrfs_device *sdev, u64 logic_start,
+			u64 logic_end);
+int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
+		 u64 logical, u32 len, u64 physical,
+		 struct btrfs_device *dev, u64 flags,
+		 u64 gen, int mirror_num);
 
 #endif
-- 
2.38.1

