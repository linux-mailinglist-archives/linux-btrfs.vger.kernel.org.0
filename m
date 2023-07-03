Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2174562C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGCHd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGCHdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3456E44
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64504218FB
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vP14oweh2ISZxU/9Pxuc8fnIrwr+WC2bF6ODfZ6142E=;
        b=gRLZkI1zVAWWwVGZq6YZcEZDuED3AE0+U5NTiXUdAyJZiKILTbiPj7ZeWxPlD3Wv5zLb+/
        9+tO/cQHd6aGMKqnstqvdYi9e8+wLp5jjXRpzoULR5ZSB0L2KCYSUzAGp/4qtB1e3VCjiX
        SDXMRyGbplSolAfS0u7y5BSVjZXzsnc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB94513276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wAPAIbd5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/14] btrfs: scrub: introduce the RAID56 data recovery path for scrub logical
Date:   Mon,  3 Jul 2023 15:32:37 +0800
Message-ID: <e6f839c77dfc839a1db45852040cd1b75ca1fce3.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

The recovery path would use cached stripe contents to make sure we won't
waste IO on re-read the same contents from disks.

This is done by reusing raid56_parity_cache_pages() function to cache
data and P/Q stripes.

And since we need to call raid56_parity_cache_pages(), this means we
can not go the same btrfs_submit_bio() path for the repair, thus we
introduce the following two helpers:

- submit_cached_recover_bio()
  This would do the all necessary preparation: grab a bioc, rbio, then
  fill the cache and finally submit and wait the bio.

- scrub_submit_cached_raid56_repair_read()
  This is doing mostly the same work as
  scrub_stripe_submit_repair_read(), but since we can not go
  btrfs_submit_bio(), we have to go a different path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c   | 244 +++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.c |  20 +---
 fs/btrfs/volumes.h |  16 +++
 3 files changed, 253 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f37b9fd30595..4ca502fa0b40 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -174,6 +174,7 @@ struct scrub_stripe {
 struct scrub_ctx {
 	struct scrub_stripe	*stripes;
 	struct scrub_stripe	*raid56_data_stripes;
+	struct map_lookup	*map;
 	struct btrfs_fs_info	*fs_info;
 	int			first_free;
 	int			cur_stripe;
@@ -846,6 +847,130 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 	}
 }
 
+static void raid56_scrub_wait_endio(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
+/*
+ * The read repair path of scrub_logical.
+ *
+ * This would use the full stripe cache as cache, so we can afford to do
+ * synchronous repair here, as everything is done inside memory.
+ */
+static void submit_cached_recover_bio(struct scrub_stripe *first_stripe,
+				      int group_stripes,
+				      struct scrub_stripe *stripe,
+				      struct bio *bio,
+				      int mirror)
+{
+	DECLARE_COMPLETION_ONSTACK(io_done);
+	struct btrfs_fs_info *fs_info = first_stripe->bg->fs_info;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_raid_bio *rbio;
+	u64 bio_logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	u32 bio_size = bio->bi_iter.bi_size;
+	u64 length = fs_info->sectorsize;
+	unsigned long bio_bitmap = 0;
+	int sector_start = calc_sector_number(stripe, bio_first_bvec_all(bio));
+	int ret;
+
+	ASSERT(mirror > 1);
+	ASSERT(bio_size);
+	ASSERT(bio_logical >= first_stripe->logical);
+
+	bio->bi_private = &io_done;
+	bio->bi_end_io = raid56_scrub_wait_endio;
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, first_stripe->logical,
+			      &length, &bioc, NULL, 0, 1);
+	if (ret < 0)
+		goto out;
+
+	rbio = raid56_parity_alloc_recover_rbio(bio, bioc, mirror);
+	btrfs_put_bioc(bioc);
+	if (!rbio) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (int i = 0; i < group_stripes; i++) {
+		struct scrub_stripe *stripe = first_stripe + i;
+
+		raid56_parity_cache_pages(rbio, stripe->pages, i);
+	}
+	raid56_parity_submit_recover_rbio(rbio);
+	wait_for_completion_io(&io_done);
+	ret = blk_status_to_errno(bio->bi_status);
+out:
+	btrfs_bio_counter_dec(fs_info);
+	if (ret < 0) {
+		bitmap_set(&stripe->io_error_bitmap, sector_start,
+			   bio_size >> fs_info->sectorsize_bits);
+		bitmap_set(&stripe->error_bitmap, sector_start,
+			   bio_size >> fs_info->sectorsize_bits);
+		return;
+	}
+	bitmap_set(&bio_bitmap, sector_start,
+		   bio_size >> fs_info->sectorsize_bits);
+	/* Verify the repaired sector. */
+	scrub_verify_one_stripe(stripe, bio_bitmap);
+}
+
+static void scrub_submit_cached_raid56_repair_read(
+				struct scrub_stripe *first_stripe,
+				int group_stripes,
+				struct scrub_stripe *stripe,
+				int mirror)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio *bio = NULL;
+	int i;
+
+	ASSERT(stripe->mirror_num >= 1);
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+
+	/*
+	 * Here we will repair every sector even if it's not covered by an
+	 * extent.
+	 * This is to handle missing device, so that we won't re-generate
+	 * P/Q using garbage.
+	 */
+	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_sectors) {
+		struct page *page;
+		int pgoff;
+		int ret;
+
+		page = scrub_stripe_get_page(stripe, i);
+		pgoff = scrub_stripe_get_page_offset(stripe, i);
+
+		/* The current sector cannot be merged, submit the bio. */
+		if (bio && i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) {
+			ASSERT(bio->bi_iter.bi_size);
+			submit_cached_recover_bio(first_stripe, group_stripes,
+						  stripe, bio, mirror);
+			bio_put(bio);
+			bio = NULL;
+		}
+
+		if (!bio) {
+			bio = bio_alloc(NULL, stripe->nr_sectors, REQ_OP_READ,
+					GFP_NOFS);
+			bio->bi_iter.bi_sector = (stripe->logical +
+				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
+		}
+
+		ret = bio_add_page(bio, page, fs_info->sectorsize, pgoff);
+		ASSERT(ret == fs_info->sectorsize);
+	}
+	if (bio) {
+		ASSERT(bio->bi_iter.bi_size);
+		submit_cached_recover_bio(first_stripe, group_stripes, stripe,
+					  bio, mirror);
+		bio_put(bio);
+	}
+}
+
 static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 				       struct scrub_stripe *stripe)
 {
@@ -1657,6 +1782,94 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 	return false;
 }
 
+static int repair_raid56_full_stripe(struct scrub_ctx *sctx, int start_stripe,
+				     int group_stripes)
+{
+	const int tolerance = btrfs_map_num_copies(sctx->map);
+	struct scrub_stripe *first_stripe = &sctx->stripes[start_stripe];
+	struct scrub_stripe *p_stripe;
+	unsigned long extents_bitmap;
+	int data_stripes = nr_data_stripes(sctx->map);
+	bool has_error = false;
+	int ret = 0;
+
+	ASSERT(start_stripe + group_stripes <= sctx->cur_stripe);
+	ASSERT(sctx->map);
+
+	/* Zoned fs doesn't support RAID56 yet. */
+	ASSERT(!btrfs_is_zoned(sctx->fs_info));
+
+	p_stripe = first_stripe + data_stripes;
+
+	bitmap_copy(&extents_bitmap, &p_stripe->extent_sector_bitmap,
+		    p_stripe->nr_sectors);
+
+	for (int stripe_nr = 0; stripe_nr < data_stripes; stripe_nr++) {
+		struct scrub_stripe *stripe = first_stripe + stripe_nr;
+		unsigned long final_errors = 0;
+
+		for (int mirror = 2; mirror <= tolerance; mirror++) {
+			scrub_submit_cached_raid56_repair_read(first_stripe,
+					group_stripes, stripe, mirror);
+		}
+		bitmap_and(&final_errors, &stripe->error_bitmap,
+			   &stripe->extent_sector_bitmap, stripe->nr_sectors);
+		if (!bitmap_empty(&final_errors, stripe->nr_sectors)) {
+			btrfs_err_rl(sctx->fs_info,
+"unrepaired sector found, full_stripe %llu stripe_num %u error_sectors %*pbl",
+				     first_stripe->logical, stripe_nr,
+				     stripe->nr_sectors, &final_errors);
+			has_error = true;
+		}
+		/*
+		 * Here we continue repairing the remaining data stripes,
+		 * This is to update the accounting to have a correct view
+		 * of the errors we have.
+		 */
+	}
+	if (has_error) {
+		btrfs_err(sctx->fs_info, "failed to repair full stripe %llu",
+			  first_stripe->logical);
+		ret = -EIO;
+		goto report;
+	}
+
+	/* Submit the write for repaired data sectors. */
+	if (!sctx->readonly) {
+		for (int stripe_nr = 0; stripe_nr < data_stripes; stripe_nr++) {
+			struct scrub_stripe *stripe = first_stripe + stripe_nr;
+			unsigned long repaired;
+
+			bitmap_andnot(&repaired, &stripe->init_error_bitmap,
+				      &stripe->error_bitmap,
+				      stripe->nr_sectors);
+			scrub_write_sectors(sctx, stripe, repaired, false);
+		}
+	}
+	/* Wait for above writeback to finish. */
+	for (int stripe_nr = 0; stripe_nr < data_stripes; stripe_nr++) {
+		struct scrub_stripe *stripe = first_stripe + stripe_nr;
+
+		wait_scrub_stripe_io(stripe);
+	}
+
+	/* Still need to scrub P/Q stripes. */
+	ret = -EOPNOTSUPP;
+report:
+	/*
+	 * Update the accounting for data stripes.
+	 *
+	 * Unfortunately the current scrub structure doesn't have the extra
+	 * members to report errors about P/Q sectors.
+	 */
+	for (int stripe_nr = 0; stripe_nr < data_stripes; stripe_nr++) {
+		struct scrub_stripe *stripe = first_stripe + stripe_nr;
+
+		scrub_stripe_report_errors(sctx, stripe);
+	}
+	return ret;
+}
+
 /*
  * Unlike the per-device repair, we have all mirrors read out already.
  *
@@ -1750,8 +1963,14 @@ static int handle_logical_stripes(struct scrub_ctx *sctx,
 				  struct btrfs_block_group *bg)
 {
 	const int nr_stripes = sctx->cur_stripe;
-	const int group_stripes = btrfs_bg_type_to_factor(bg->flags);
+	const bool is_raid56 = bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK;
+	const int group_stripes = is_raid56 ? sctx->map->num_stripes :
+					      btrfs_bg_type_to_factor(bg->flags);
 	struct scrub_stripe *stripe;
+	int ret = 0;
+
+	/* For scrub_logical, sctx->map should be set. */
+	ASSERT(sctx->map);
 
 	for (int i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
@@ -1773,11 +1992,21 @@ static int handle_logical_stripes(struct scrub_ctx *sctx,
 			bitmap_weight(&stripe->meta_error_bitmap, stripe->nr_sectors);
 	}
 
-	for (int i = 0; i < nr_stripes; i += group_stripes)
-		repair_one_mirror_group(sctx, i, group_stripes);
+
+	for (int i = 0; i < nr_stripes; i += group_stripes) {
+		int tmp;
+
+		if (is_raid56) {
+			tmp = repair_raid56_full_stripe(sctx, i, group_stripes);
+			if (!ret)
+				ret = tmp;
+		} else {
+			repair_one_mirror_group(sctx, i, group_stripes);
+		}
+	}
 	sctx->cur_stripe = 0;
 
-	return 0;
+	return ret;
 }
 
 static int flush_scrub_stripes(struct scrub_ctx *sctx,
@@ -1874,11 +2103,6 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx,
 	return ret;
 }
 
-static void raid56_scrub_wait_endio(struct bio *bio)
-{
-	complete(bio->bi_private);
-}
-
 static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *bg,
 			      struct btrfs_device *dev, int mirror_num,
 			      u64 logical, u32 length, u64 physical)
@@ -3317,6 +3541,7 @@ static int scrub_logical_one_chunk(struct scrub_ctx *sctx,
 		spin_unlock(&bg->lock);
 		return ret;
 	}
+	sctx->map = em->map_lookup;
 
 	scrub_blocked_if_needed(fs_info);
 
@@ -3368,6 +3593,7 @@ static int scrub_logical_one_chunk(struct scrub_ctx *sctx,
 		ret = flush_ret;
 	free_scrub_stripes(sctx);
 	free_extent_map(em);
+	sctx->map = NULL;
 	return ret;
 
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c22007bd830b..1f79180dab83 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5752,22 +5752,6 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree)
 	}
 }
 
-static int map_num_copies(const struct map_lookup *map)
-{
-	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
-		return 2;
-	if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		/*
-		 * There could be two corrupted data stripes, we need
-		 * to loop retry in order to rebuild the correct data.
-		 *
-		 * Fail a stripe at a time on every retry except the
-		 * stripe under reconstruction.
-		 */
-		return map->num_stripes;
-	return btrfs_bg_type_to_factor(map->type);
-}
-
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 {
 	struct extent_map *em;
@@ -5783,7 +5767,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 */
 		return 1;
 
-	ret = map_num_copies(em->map_lookup);
+	ret = btrfs_map_num_copies(em->map_lookup);
 	free_extent_map(em);
 	return ret;
 }
@@ -6294,7 +6278,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		return PTR_ERR(em);
 	map = em->map_lookup;
 
-	if (mirror_num > map_num_copies(map)) {
+	if (mirror_num > btrfs_map_num_copies(map)) {
 		ret = -EINVAL;
 		goto out_free_em;
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f4f410550306..0753675a2c5b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -752,4 +752,20 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 
+static inline int btrfs_map_num_copies(struct map_lookup *map)
+{
+	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+		return 2;
+	if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+		/*
+		 * There could be two corrupted data stripes, we need
+		 * to loop retry in order to rebuild the correct data.
+		 *
+		 * Fail a stripe at a time on every retry except the
+		 * stripe under reconstruction.
+		 */
+		return map->num_stripes;
+	return btrfs_bg_type_to_factor(map->type);
+}
+
 #endif
-- 
2.41.0

