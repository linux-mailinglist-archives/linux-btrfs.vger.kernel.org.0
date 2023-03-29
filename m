Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438016CD2AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjC2HKS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjC2HKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E010E9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF47121A27
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFX6UdDBr467d3PhwT075wmbRskqeqos3NeGXp73P0U=;
        b=blGo03ZeKNjcFWjd913lHrpGyVavyEiPGQOzvmBes9e7TX+W/YfpB6htsVEcMuQ3NMNeg2
        KNsPOA9BZNg1ZVW0bBCqkauSQQiVS5gWNOFtKQKaBrARp49Q/lMyKARd63zY1TnaIELHiX
        ym2sS1iLg7zsyNZ+Pw0bsNIh0dn15KM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1BA4138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KBuIL1HkI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: scrub: remove scrub_parity structure
Date:   Wed, 29 Mar 2023 15:09:46 +0800
Message-Id: <c10fd46ee71343d8eec5b3cc07441d48daf83118.1680073696.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680073696.git.wqu@suse.com>
References: <cover.1680073696.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The structure scrub_parity is used to indicate that some extents are
scrubbed for the purpose of RAID56 P/Q scrubbing.

Since the whole RAID56 P/Q scrubbing path is replaced with new
scrub_stripe infrastructure, and we no longer needs to use scrub_parity
to modify the behavior of data stripes, we can remove the structure
completely.

This removal involves:

- scrub_parity_workers
  Now only one worker would be utilized, scrub_workers, to do the read
  and repair.
  All writeback would happen at the main scrub thread.

- scrub_block::sparity member
- scrub_parity structure
- function scrub_parity_get()
- function scrub_parity_put()
- function scrub_free_parity()

- function __scrub_mark_bitmap()
- function scrub_parity_mark_sectors_error()
- function scrub_parity_mark_sectors_data()
  Those helpers are no longer needed, scrub_stripe has its bitmaps and
  we can use bitmap helpers to get the error/data status.

- scrub_parity_bio_endio()
- scrub_parity_check_and_repair()
- function scrub_sectors_for_parity()
- function scrub_extent_for_parity()
- function scrub_raid56_data_stripe_for_parity()
- function scrub_raid56_parity()
  The new code would reuse the scrub read-repair and writeback path.
  Just skip the dev-replace phase.
  And scrub_stripe infrastructure allows us to submit and wait for those
  data stripes before scrubbing P/Q, without extra infrastructures.

The following two functions are temporary exported for later cleanup:

- scrub_find_csum()
- scrub_add_sector_to_rd_bio()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h    |   1 -
 fs/btrfs/scrub.c | 526 +----------------------------------------------
 fs/btrfs/scrub.h |   8 +-
 3 files changed, 10 insertions(+), 525 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index abe5b3475a9d..b00f0e9c99dc 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -633,7 +633,6 @@ struct btrfs_fs_info {
 	refcount_t scrub_workers_refcnt;
 	struct workqueue_struct *scrub_workers;
 	struct workqueue_struct *scrub_wr_completion_workers;
-	struct workqueue_struct *scrub_parity_workers;
 	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c340fd51aa65..8e9f47859d3d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -238,7 +238,6 @@ struct scrub_block {
 	atomic_t		outstanding_sectors;
 	refcount_t		refs; /* free mem on transition to zero */
 	struct scrub_ctx	*sctx;
-	struct scrub_parity	*sparity;
 	struct {
 		unsigned int	header_error:1;
 		unsigned int	checksum_error:1;
@@ -252,37 +251,6 @@ struct scrub_block {
 	struct work_struct	work;
 };
 
-/* Used for the chunks with parity stripe such RAID5/6 */
-struct scrub_parity {
-	struct scrub_ctx	*sctx;
-
-	struct btrfs_device	*scrub_dev;
-
-	u64			logic_start;
-
-	u64			logic_end;
-
-	int			nsectors;
-
-	u32			stripe_len;
-
-	refcount_t		refs;
-
-	struct list_head	sectors_list;
-
-	/* Work of parity check and repair */
-	struct work_struct	work;
-
-	/* Mark the parity blocks which have data */
-	unsigned long		dbitmap;
-
-	/*
-	 * Mark the parity blocks which have data, but errors happen when
-	 * read data or check data
-	 */
-	unsigned long		ebitmap;
-};
-
 struct scrub_ctx {
 	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
 	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
@@ -588,8 +556,6 @@ static int scrub_checksum_super(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
 static void scrub_sector_get(struct scrub_sector *sector);
 static void scrub_sector_put(struct scrub_sector *sector);
-static void scrub_parity_get(struct scrub_parity *sparity);
-static void scrub_parity_put(struct scrub_parity *sparity);
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_block_complete(struct scrub_block *sblock);
@@ -1945,13 +1911,6 @@ static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
 	struct btrfs_fs_info *fs_info = sblock->sctx->fs_info;
 	int i;
 
-	/*
-	 * This block is used for the check of the parity on the source device,
-	 * so the data needn't be written into the destination device.
-	 */
-	if (sblock->sparity)
-		return;
-
 	for (i = 0; i < sblock->sector_count; i++) {
 		int ret;
 
@@ -2956,9 +2915,6 @@ static void scrub_block_put(struct scrub_block *sblock)
 	if (refcount_dec_and_test(&sblock->refs)) {
 		int i;
 
-		if (sblock->sparity)
-			scrub_parity_put(sblock->sparity);
-
 		for (i = 0; i < sblock->sector_count; i++)
 			scrub_sector_put(sblock->sectors[i]);
 		for (i = 0; i < DIV_ROUND_UP(sblock->len, PAGE_SIZE); i++) {
@@ -3062,8 +3018,8 @@ static void scrub_submit(struct scrub_ctx *sctx)
 	submit_bio(sbio->bio);
 }
 
-static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
-				      struct scrub_sector *sector)
+int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
+			       struct scrub_sector *sector)
 {
 	struct scrub_block *sblock = sector->sblock;
 	struct scrub_bio *sbio;
@@ -3183,45 +3139,6 @@ static void scrub_bio_end_io_worker(struct work_struct *work)
 	scrub_pending_bio_dec(sctx);
 }
 
-static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
-				       unsigned long *bitmap,
-				       u64 start, u32 len)
-{
-	u64 offset;
-	u32 nsectors;
-	u32 sectorsize_bits = sparity->sctx->fs_info->sectorsize_bits;
-
-	if (len >= sparity->stripe_len) {
-		bitmap_set(bitmap, 0, sparity->nsectors);
-		return;
-	}
-
-	start -= sparity->logic_start;
-	start = div64_u64_rem(start, sparity->stripe_len, &offset);
-	offset = offset >> sectorsize_bits;
-	nsectors = len >> sectorsize_bits;
-
-	if (offset + nsectors <= sparity->nsectors) {
-		bitmap_set(bitmap, offset, nsectors);
-		return;
-	}
-
-	bitmap_set(bitmap, offset, sparity->nsectors - offset);
-	bitmap_set(bitmap, 0, nsectors - (sparity->nsectors - offset));
-}
-
-static inline void scrub_parity_mark_sectors_error(struct scrub_parity *sparity,
-						   u64 start, u32 len)
-{
-	__scrub_mark_bitmap(sparity, &sparity->ebitmap, start, len);
-}
-
-static inline void scrub_parity_mark_sectors_data(struct scrub_parity *sparity,
-						  u64 start, u32 len)
-{
-	__scrub_mark_bitmap(sparity, &sparity->dbitmap, start, len);
-}
-
 static void scrub_block_complete(struct scrub_block *sblock)
 {
 	int corrupted = 0;
@@ -3239,17 +3156,6 @@ static void scrub_block_complete(struct scrub_block *sblock)
 		if (!corrupted && sblock->sctx->is_dev_replace)
 			scrub_write_block_to_dev_replace(sblock);
 	}
-
-	if (sblock->sparity && corrupted && !sblock->data_corrected) {
-		u64 start = sblock->logical;
-		u64 end = sblock->logical +
-			  sblock->sectors[sblock->sector_count - 1]->offset +
-			  sblock->sctx->fs_info->sectorsize;
-
-		ASSERT(end - start <= U32_MAX);
-		scrub_parity_mark_sectors_error(sblock->sparity,
-						start, end - start);
-	}
 }
 
 static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *sum)
@@ -3270,7 +3176,7 @@ static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *su
  * Return 0 if there is no csum for the range.
  * Return 1 if there is csum for the range and copied to @csum.
  */
-static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
+int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 {
 	bool found = false;
 
@@ -3314,123 +3220,6 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	return 1;
 }
 
-static int scrub_sectors_for_parity(struct scrub_parity *sparity,
-				  u64 logical, u32 len,
-				  u64 physical, struct btrfs_device *dev,
-				  u64 flags, u64 gen, int mirror_num, u8 *csum)
-{
-	struct scrub_ctx *sctx = sparity->sctx;
-	struct scrub_block *sblock;
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-	int index;
-
-	ASSERT(IS_ALIGNED(len, sectorsize));
-
-	sblock = alloc_scrub_block(sctx, dev, logical, physical, physical, mirror_num);
-	if (!sblock) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.malloc_errors++;
-		spin_unlock(&sctx->stat_lock);
-		return -ENOMEM;
-	}
-
-	sblock->sparity = sparity;
-	scrub_parity_get(sparity);
-
-	for (index = 0; len > 0; index++) {
-		struct scrub_sector *sector;
-
-		sector = alloc_scrub_sector(sblock, logical);
-		if (!sector) {
-			spin_lock(&sctx->stat_lock);
-			sctx->stat.malloc_errors++;
-			spin_unlock(&sctx->stat_lock);
-			scrub_block_put(sblock);
-			return -ENOMEM;
-		}
-		sblock->sectors[index] = sector;
-		/* For scrub parity */
-		scrub_sector_get(sector);
-		list_add_tail(&sector->list, &sparity->sectors_list);
-		sector->flags = flags;
-		sector->generation = gen;
-		if (csum) {
-			sector->have_csum = 1;
-			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
-		} else {
-			sector->have_csum = 0;
-		}
-
-		/* Iterate over the stripe range in sectorsize steps */
-		len -= sectorsize;
-		logical += sectorsize;
-		physical += sectorsize;
-	}
-
-	WARN_ON(sblock->sector_count == 0);
-	for (index = 0; index < sblock->sector_count; index++) {
-		struct scrub_sector *sector = sblock->sectors[index];
-		int ret;
-
-		ret = scrub_add_sector_to_rd_bio(sctx, sector);
-		if (ret) {
-			scrub_block_put(sblock);
-			return ret;
-		}
-	}
-
-	/* Last one frees, either here or in bio completion for last sector */
-	scrub_block_put(sblock);
-	return 0;
-}
-
-static int scrub_extent_for_parity(struct scrub_parity *sparity,
-				   u64 logical, u32 len,
-				   u64 physical, struct btrfs_device *dev,
-				   u64 flags, u64 gen, int mirror_num)
-{
-	struct scrub_ctx *sctx = sparity->sctx;
-	int ret;
-	u8 csum[BTRFS_CSUM_SIZE];
-	u32 blocksize;
-
-	if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
-		scrub_parity_mark_sectors_error(sparity, logical, len);
-		return 0;
-	}
-
-	if (flags & BTRFS_EXTENT_FLAG_DATA) {
-		blocksize = sparity->stripe_len;
-	} else if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-		blocksize = sparity->stripe_len;
-	} else {
-		blocksize = sctx->fs_info->sectorsize;
-		WARN_ON(1);
-	}
-
-	while (len) {
-		u32 l = min(len, blocksize);
-		int have_csum = 0;
-
-		if (flags & BTRFS_EXTENT_FLAG_DATA) {
-			/* push csums to sbio */
-			have_csum = scrub_find_csum(sctx, logical, csum);
-			if (have_csum == 0)
-				goto skip;
-		}
-		ret = scrub_sectors_for_parity(sparity, logical, l, physical, dev,
-					     flags, gen, mirror_num,
-					     have_csum ? csum : NULL);
-		if (ret)
-			return ret;
-skip:
-		len -= l;
-		logical += l;
-		physical += l;
-	}
-	return 0;
-}
-
 /*
  * Given a physical address, this will calculate it's
  * logical offset. if this is a parity stripe, it will return
@@ -3476,119 +3265,6 @@ static int get_raid56_logic_offset(u64 physical, int num,
 	return 1;
 }
 
-static void scrub_free_parity(struct scrub_parity *sparity)
-{
-	struct scrub_ctx *sctx = sparity->sctx;
-	struct scrub_sector *curr, *next;
-	int nbits;
-
-	nbits = bitmap_weight(&sparity->ebitmap, sparity->nsectors);
-	if (nbits) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.read_errors += nbits;
-		sctx->stat.uncorrectable_errors += nbits;
-		spin_unlock(&sctx->stat_lock);
-	}
-
-	list_for_each_entry_safe(curr, next, &sparity->sectors_list, list) {
-		list_del_init(&curr->list);
-		scrub_sector_put(curr);
-	}
-
-	kfree(sparity);
-}
-
-static void scrub_parity_bio_endio_worker(struct work_struct *work)
-{
-	struct scrub_parity *sparity = container_of(work, struct scrub_parity,
-						    work);
-	struct scrub_ctx *sctx = sparity->sctx;
-
-	btrfs_bio_counter_dec(sctx->fs_info);
-	scrub_free_parity(sparity);
-	scrub_pending_bio_dec(sctx);
-}
-
-static void scrub_parity_bio_endio(struct bio *bio)
-{
-	struct scrub_parity *sparity = bio->bi_private;
-	struct btrfs_fs_info *fs_info = sparity->sctx->fs_info;
-
-	if (bio->bi_status)
-		bitmap_or(&sparity->ebitmap, &sparity->ebitmap,
-			  &sparity->dbitmap, sparity->nsectors);
-
-	bio_put(bio);
-
-	INIT_WORK(&sparity->work, scrub_parity_bio_endio_worker);
-	queue_work(fs_info->scrub_parity_workers, &sparity->work);
-}
-
-static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
-{
-	struct scrub_ctx *sctx = sparity->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct bio *bio;
-	struct btrfs_raid_bio *rbio;
-	struct btrfs_io_context *bioc = NULL;
-	u64 length;
-	int ret;
-
-	if (!bitmap_andnot(&sparity->dbitmap, &sparity->dbitmap,
-			   &sparity->ebitmap, sparity->nsectors))
-		goto out;
-
-	length = sparity->logic_end - sparity->logic_start;
-
-	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_WRITE, sparity->logic_start,
-			       &length, &bioc);
-	if (ret || !bioc)
-		goto bioc_out;
-
-	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
-	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
-	bio->bi_private = sparity;
-	bio->bi_end_io = scrub_parity_bio_endio;
-
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc,
-					      sparity->scrub_dev,
-					      &sparity->dbitmap,
-					      sparity->nsectors);
-	btrfs_put_bioc(bioc);
-	if (!rbio)
-		goto rbio_out;
-
-	scrub_pending_bio_inc(sctx);
-	raid56_parity_submit_scrub_rbio(rbio);
-	return;
-
-rbio_out:
-	bio_put(bio);
-bioc_out:
-	btrfs_bio_counter_dec(fs_info);
-	bitmap_or(&sparity->ebitmap, &sparity->ebitmap, &sparity->dbitmap,
-		  sparity->nsectors);
-	spin_lock(&sctx->stat_lock);
-	sctx->stat.malloc_errors++;
-	spin_unlock(&sctx->stat_lock);
-out:
-	scrub_free_parity(sparity);
-}
-
-static void scrub_parity_get(struct scrub_parity *sparity)
-{
-	refcount_inc(&sparity->refs);
-}
-
-static void scrub_parity_put(struct scrub_parity *sparity)
-{
-	if (!refcount_dec_and_test(&sparity->refs))
-		return;
-
-	scrub_parity_check_and_repair(sparity);
-}
-
 /*
  * Return 0 if the extent item range covers any byte of the range.
  * Return <0 if the extent item is before @search_start.
@@ -3715,185 +3391,6 @@ static void get_extent_info(struct btrfs_path *path, u64 *extent_start_ret,
 	*generation_ret = btrfs_extent_generation(path->nodes[0], ei);
 }
 
-static bool does_range_cross_boundary(u64 extent_start, u64 extent_len,
-				      u64 boundary_start, u64 boudary_len)
-{
-	return (extent_start < boundary_start &&
-		extent_start + extent_len > boundary_start) ||
-	       (extent_start < boundary_start + boudary_len &&
-		extent_start + extent_len > boundary_start + boudary_len);
-}
-
-static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
-					       struct scrub_parity *sparity,
-					       struct map_lookup *map,
-					       struct btrfs_device *sdev,
-					       struct btrfs_path *path,
-					       u64 logical)
-{
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
-	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
-	u64 cur_logical = logical;
-	int ret;
-
-	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
-
-	/* Path must not be populated */
-	ASSERT(!path->nodes[0]);
-
-	while (cur_logical < logical + BTRFS_STRIPE_LEN) {
-		struct btrfs_io_context *bioc = NULL;
-		struct btrfs_device *extent_dev;
-		u64 extent_start;
-		u64 extent_size;
-		u64 mapped_length;
-		u64 extent_flags;
-		u64 extent_gen;
-		u64 extent_physical;
-		u64 extent_mirror_num;
-
-		ret = find_first_extent_item(extent_root, path, cur_logical,
-					     logical + BTRFS_STRIPE_LEN - cur_logical);
-		/* No more extent item in this data stripe */
-		if (ret > 0) {
-			ret = 0;
-			break;
-		}
-		if (ret < 0)
-			break;
-		get_extent_info(path, &extent_start, &extent_size, &extent_flags,
-				&extent_gen);
-
-		/* Metadata should not cross stripe boundaries */
-		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
-		    does_range_cross_boundary(extent_start, extent_size,
-					      logical, BTRFS_STRIPE_LEN)) {
-			btrfs_err(fs_info,
-	"scrub: tree block %llu spanning stripes, ignored. logical=%llu",
-				  extent_start, logical);
-			spin_lock(&sctx->stat_lock);
-			sctx->stat.uncorrectable_errors++;
-			spin_unlock(&sctx->stat_lock);
-			cur_logical += extent_size;
-			continue;
-		}
-
-		/* Skip hole range which doesn't have any extent */
-		cur_logical = max(extent_start, cur_logical);
-
-		/* Truncate the range inside this data stripe */
-		extent_size = min(extent_start + extent_size,
-				  logical + BTRFS_STRIPE_LEN) - cur_logical;
-		extent_start = cur_logical;
-		ASSERT(extent_size <= U32_MAX);
-
-		scrub_parity_mark_sectors_data(sparity, extent_start, extent_size);
-
-		mapped_length = extent_size;
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_start,
-				      &mapped_length, &bioc, 0);
-		if (!ret && (!bioc || mapped_length < extent_size))
-			ret = -EIO;
-		if (ret) {
-			btrfs_put_bioc(bioc);
-			scrub_parity_mark_sectors_error(sparity, extent_start,
-							extent_size);
-			break;
-		}
-		extent_physical = bioc->stripes[0].physical;
-		extent_mirror_num = bioc->mirror_num;
-		extent_dev = bioc->stripes[0].dev;
-		btrfs_put_bioc(bioc);
-
-		ret = btrfs_lookup_csums_list(csum_root, extent_start,
-					      extent_start + extent_size - 1,
-					      &sctx->csum_list, 1, false);
-		if (ret) {
-			scrub_parity_mark_sectors_error(sparity, extent_start,
-							extent_size);
-			break;
-		}
-
-		ret = scrub_extent_for_parity(sparity, extent_start,
-					      extent_size, extent_physical,
-					      extent_dev, extent_flags,
-					      extent_gen, extent_mirror_num);
-		scrub_free_csums(sctx);
-
-		if (ret) {
-			scrub_parity_mark_sectors_error(sparity, extent_start,
-							extent_size);
-			break;
-		}
-
-		cond_resched();
-		cur_logical += extent_size;
-	}
-	btrfs_release_path(path);
-	return ret;
-}
-
-int scrub_raid56_parity(struct scrub_ctx *sctx, struct map_lookup *map,
-			struct btrfs_device *sdev, u64 logic_start,
-			u64 logic_end)
-{
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_path *path;
-	u64 cur_logical;
-	int ret;
-	struct scrub_parity *sparity;
-	int nsectors;
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.malloc_errors++;
-		spin_unlock(&sctx->stat_lock);
-		return -ENOMEM;
-	}
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-
-	nsectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
-	ASSERT(nsectors <= BITS_PER_LONG);
-	sparity = kzalloc(sizeof(struct scrub_parity), GFP_NOFS);
-	if (!sparity) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.malloc_errors++;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_free_path(path);
-		return -ENOMEM;
-	}
-
-	sparity->stripe_len = BTRFS_STRIPE_LEN;
-	sparity->nsectors = nsectors;
-	sparity->sctx = sctx;
-	sparity->scrub_dev = sdev;
-	sparity->logic_start = logic_start;
-	sparity->logic_end = logic_end;
-	refcount_set(&sparity->refs, 1);
-	INIT_LIST_HEAD(&sparity->sectors_list);
-
-	ret = 0;
-	for (cur_logical = logic_start; cur_logical < logic_end;
-	     cur_logical += BTRFS_STRIPE_LEN) {
-		ret = scrub_raid56_data_stripe_for_parity(sctx, sparity, map,
-							  sdev, path, cur_logical);
-		if (ret < 0)
-			break;
-	}
-
-	scrub_parity_put(sparity);
-	scrub_submit(sctx);
-	mutex_lock(&sctx->wr_lock);
-	scrub_wr_submit(sctx);
-	mutex_unlock(&sctx->wr_lock);
-
-	btrfs_free_path(path);
-	return ret < 0 ? ret : 0;
-}
-
 static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 					u64 physical, u64 physical_end)
 {
@@ -5192,20 +4689,15 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 		struct workqueue_struct *scrub_workers = fs_info->scrub_workers;
 		struct workqueue_struct *scrub_wr_comp =
 						fs_info->scrub_wr_completion_workers;
-		struct workqueue_struct *scrub_parity =
-						fs_info->scrub_parity_workers;
 
 		fs_info->scrub_workers = NULL;
 		fs_info->scrub_wr_completion_workers = NULL;
-		fs_info->scrub_parity_workers = NULL;
 		mutex_unlock(&fs_info->scrub_lock);
 
 		if (scrub_workers)
 			destroy_workqueue(scrub_workers);
 		if (scrub_wr_comp)
 			destroy_workqueue(scrub_wr_comp);
-		if (scrub_parity)
-			destroy_workqueue(scrub_parity);
 	}
 }
 
@@ -5217,7 +4709,6 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 {
 	struct workqueue_struct *scrub_workers = NULL;
 	struct workqueue_struct *scrub_wr_comp = NULL;
-	struct workqueue_struct *scrub_parity = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
@@ -5234,18 +4725,12 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	if (!scrub_wr_comp)
 		goto fail_scrub_wr_completion_workers;
 
-	scrub_parity = alloc_workqueue("btrfs-scrubparity", flags, max_active);
-	if (!scrub_parity)
-		goto fail_scrub_parity_workers;
-
 	mutex_lock(&fs_info->scrub_lock);
 	if (refcount_read(&fs_info->scrub_workers_refcnt) == 0) {
 		ASSERT(fs_info->scrub_workers == NULL &&
-		       fs_info->scrub_wr_completion_workers == NULL &&
-		       fs_info->scrub_parity_workers == NULL);
+		       fs_info->scrub_wr_completion_workers == NULL);
 		fs_info->scrub_workers = scrub_workers;
 		fs_info->scrub_wr_completion_workers = scrub_wr_comp;
-		fs_info->scrub_parity_workers = scrub_parity;
 		refcount_set(&fs_info->scrub_workers_refcnt, 1);
 		mutex_unlock(&fs_info->scrub_lock);
 		return 0;
@@ -5255,8 +4740,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	mutex_unlock(&fs_info->scrub_lock);
 
 	ret = 0;
-	destroy_workqueue(scrub_parity);
-fail_scrub_parity_workers:
+
 	destroy_workqueue(scrub_wr_comp);
 fail_scrub_wr_completion_workers:
 	destroy_workqueue(scrub_workers);
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 6c17668dfad9..d23068e741fb 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -14,8 +14,10 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
 /* Temporary declaration, would be deleted later. */
-int scrub_raid56_parity(struct scrub_ctx *sctx, struct map_lookup *map,
-			struct btrfs_device *sdev, u64 logic_start,
-			u64 logic_end);
+struct scrub_ctx;
+struct scrub_sector;
+int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
+int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
+			       struct scrub_sector *sector);
 
 #endif
-- 
2.39.2

