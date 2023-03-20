Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC96C08E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCTCNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCTCNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CD06A4E
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA9B421B18
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edREfsN+zi4/yoGmsQ2ouM5moulkt8R1+RI/wAqfOgo=;
        b=aJvYNn/+Wk/cwAivQtGhY59Bk9vHuz5joiNKzh4BIPTPzES8aW/dyMcxmrXL38Km5B4M2m
        EjD+8sP2MuHckSKNf5vJq151IP+pzjLZ9qs9F1JGgqYdxWue4ES4QWsPDyNZdwM6RYvHUT
        l0BWWzieDo2lpt0aUdkf7hrdlZmKNTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BDEA13416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sLANMk/BF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 12/12] btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure
Date:   Mon, 20 Mar 2023 10:12:58 +0800
Message-Id: <ddc0a6d6370e79d76cdedb3108d018c2efaebaa7.1679278088.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679278088.git.wqu@suse.com>
References: <cover.1679278088.git.wqu@suse.com>
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

Switch scrub_simple_mirror() to the new scrub_stripe infrastructure.

Since scrub_simple_mirror() is the core part of scrub (only RAID56
P/Q stripes doesn't utilize it), we can get rid of a big hunk of code,
mostly scrub_extent() and scrub_sectors().

There is a functionality change:

- Scrub speed throttle now only affects read on the scrubbing device
  Writes (for repair and replace), and reads from other mirrors won't
  be limited by the limits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 494 +++--------------------------------------------
 fs/btrfs/scrub.h |  10 -
 2 files changed, 30 insertions(+), 474 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 44f34883adc7..beccf763ae64 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -579,10 +579,6 @@ static void scrub_sector_get(struct scrub_sector *sector);
 static void scrub_sector_put(struct scrub_sector *sector);
 static void scrub_parity_get(struct scrub_parity *sparity);
 static void scrub_parity_put(struct scrub_parity *sparity);
-static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
-			 u64 physical, struct btrfs_device *dev, u64 flags,
-			 u64 gen, int mirror_num, u8 *csum,
-			 u64 physical_for_dev_replace);
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_block_complete(struct scrub_block *sblock);
@@ -2978,22 +2974,16 @@ static void scrub_sector_put(struct scrub_sector *sector)
 		kfree(sector);
 }
 
-/*
- * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
- * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
- */
-static void scrub_throttle(struct scrub_ctx *sctx)
+static void scrub_throttle_dev_io(struct scrub_ctx *sctx,
+				  struct btrfs_device *device,
+				  unsigned int bio_size)
 {
 	const int time_slice = 1000;
-	struct scrub_bio *sbio;
-	struct btrfs_device *device;
 	s64 delta;
 	ktime_t now;
 	u32 div;
 	u64 bwlimit;
 
-	sbio = sctx->bios[sctx->curr];
-	device = sbio->dev;
 	bwlimit = READ_ONCE(device->scrub_speed_max);
 	if (bwlimit == 0)
 		return;
@@ -3015,7 +3005,7 @@ static void scrub_throttle(struct scrub_ctx *sctx)
 	/* Still in the time to send? */
 	if (ktime_before(now, sctx->throttle_deadline)) {
 		/* If current bio is within the limit, send it */
-		sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
+		sctx->throttle_sent += bio_size;
 		if (sctx->throttle_sent <= div_u64(bwlimit, div))
 			return;
 
@@ -3037,6 +3027,17 @@ static void scrub_throttle(struct scrub_ctx *sctx)
 	sctx->throttle_deadline = 0;
 }
 
+/*
+ * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
+ * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
+ */
+static void scrub_throttle(struct scrub_ctx *sctx)
+{
+	struct scrub_bio *sbio = sctx->bios[sctx->curr];
+
+	scrub_throttle_dev_io(sctx, sbio->dev, sbio->bio->bi_iter.bi_size);
+}
+
 static void scrub_submit(struct scrub_ctx *sctx)
 {
 	struct scrub_bio *sbio;
@@ -3121,202 +3122,6 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 	return 0;
 }
 
-static void scrub_missing_raid56_end_io(struct bio *bio)
-{
-	struct scrub_block *sblock = bio->bi_private;
-	struct btrfs_fs_info *fs_info = sblock->sctx->fs_info;
-
-	btrfs_bio_counter_dec(fs_info);
-	if (bio->bi_status)
-		sblock->no_io_error_seen = 0;
-
-	bio_put(bio);
-
-	queue_work(fs_info->scrub_workers, &sblock->work);
-}
-
-static void scrub_missing_raid56_worker(struct work_struct *work)
-{
-	struct scrub_block *sblock = container_of(work, struct scrub_block, work);
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u64 logical;
-	struct btrfs_device *dev;
-
-	logical = sblock->logical;
-	dev = sblock->dev;
-
-	if (sblock->no_io_error_seen)
-		scrub_recheck_block_checksum(sblock);
-
-	if (!sblock->no_io_error_seen) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.read_errors++;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_err_rl_in_rcu(fs_info,
-			"IO error rebuilding logical %llu for dev %s",
-			logical, btrfs_dev_name(dev));
-	} else if (sblock->header_error || sblock->checksum_error) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.uncorrectable_errors++;
-		spin_unlock(&sctx->stat_lock);
-		btrfs_err_rl_in_rcu(fs_info,
-			"failed to rebuild valid logical %llu for dev %s",
-			logical, btrfs_dev_name(dev));
-	} else {
-		scrub_write_block_to_dev_replace(sblock);
-	}
-
-	if (sctx->is_dev_replace && sctx->flush_all_writes) {
-		mutex_lock(&sctx->wr_lock);
-		scrub_wr_submit(sctx);
-		mutex_unlock(&sctx->wr_lock);
-	}
-
-	scrub_block_put(sblock);
-	scrub_pending_bio_dec(sctx);
-}
-
-static void scrub_missing_raid56_pages(struct scrub_block *sblock)
-{
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u64 length = sblock->sector_count << fs_info->sectorsize_bits;
-	u64 logical = sblock->logical;
-	struct btrfs_io_context *bioc = NULL;
-	struct bio *bio;
-	struct btrfs_raid_bio *rbio;
-	int ret;
-	int i;
-
-	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			       &length, &bioc);
-	if (ret || !bioc)
-		goto bioc_out;
-
-	if (WARN_ON(!sctx->is_dev_replace ||
-		    !(bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK))) {
-		/*
-		 * We shouldn't be scrubbing a missing device. Even for dev
-		 * replace, we should only get here for RAID 5/6. We either
-		 * managed to mount something with no mirrors remaining or
-		 * there's a bug in scrub_find_good_copy()/btrfs_map_block().
-		 */
-		goto bioc_out;
-	}
-
-	bio = bio_alloc(NULL, BIO_MAX_VECS, REQ_OP_READ, GFP_NOFS);
-	bio->bi_iter.bi_sector = logical >> 9;
-	bio->bi_private = sblock;
-	bio->bi_end_io = scrub_missing_raid56_end_io;
-
-	rbio = raid56_alloc_missing_rbio(bio, bioc);
-	if (!rbio)
-		goto rbio_out;
-
-	for (i = 0; i < sblock->sector_count; i++) {
-		struct scrub_sector *sector = sblock->sectors[i];
-
-		raid56_add_scrub_pages(rbio, scrub_sector_get_page(sector),
-				       scrub_sector_get_page_offset(sector),
-				       sector->offset + sector->sblock->logical);
-	}
-
-	INIT_WORK(&sblock->work, scrub_missing_raid56_worker);
-	scrub_block_get(sblock);
-	scrub_pending_bio_inc(sctx);
-	raid56_submit_missing_rbio(rbio);
-	btrfs_put_bioc(bioc);
-	return;
-
-rbio_out:
-	bio_put(bio);
-bioc_out:
-	btrfs_bio_counter_dec(fs_info);
-	btrfs_put_bioc(bioc);
-	spin_lock(&sctx->stat_lock);
-	sctx->stat.malloc_errors++;
-	spin_unlock(&sctx->stat_lock);
-}
-
-static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
-		       u64 physical, struct btrfs_device *dev, u64 flags,
-		       u64 gen, int mirror_num, u8 *csum,
-		       u64 physical_for_dev_replace)
-{
-	struct scrub_block *sblock;
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-	int index;
-
-	sblock = alloc_scrub_block(sctx, dev, logical, physical,
-				   physical_for_dev_replace, mirror_num);
-	if (!sblock) {
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.malloc_errors++;
-		spin_unlock(&sctx->stat_lock);
-		return -ENOMEM;
-	}
-
-	for (index = 0; len > 0; index++) {
-		struct scrub_sector *sector;
-		/*
-		 * Here we will allocate one page for one sector to scrub.
-		 * This is fine if PAGE_SIZE == sectorsize, but will cost
-		 * more memory for PAGE_SIZE > sectorsize case.
-		 */
-		u32 l = min(sectorsize, len);
-
-		sector = alloc_scrub_sector(sblock, logical);
-		if (!sector) {
-			spin_lock(&sctx->stat_lock);
-			sctx->stat.malloc_errors++;
-			spin_unlock(&sctx->stat_lock);
-			scrub_block_put(sblock);
-			return -ENOMEM;
-		}
-		sector->flags = flags;
-		sector->generation = gen;
-		if (csum) {
-			sector->have_csum = 1;
-			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
-		} else {
-			sector->have_csum = 0;
-		}
-		len -= l;
-		logical += l;
-		physical += l;
-		physical_for_dev_replace += l;
-	}
-
-	WARN_ON(sblock->sector_count == 0);
-	if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
-		/*
-		 * This case should only be hit for RAID 5/6 device replace. See
-		 * the comment in scrub_missing_raid56_pages() for details.
-		 */
-		scrub_missing_raid56_pages(sblock);
-	} else {
-		for (index = 0; index < sblock->sector_count; index++) {
-			struct scrub_sector *sector = sblock->sectors[index];
-			int ret;
-
-			ret = scrub_add_sector_to_rd_bio(sctx, sector);
-			if (ret) {
-				scrub_block_put(sblock);
-				return ret;
-			}
-		}
-
-		if (flags & BTRFS_EXTENT_FLAG_SUPER)
-			scrub_submit(sctx);
-	}
-
-	/* last one frees, either here or in bio completion for last page */
-	scrub_block_put(sblock);
-	return 0;
-}
-
 static void scrub_bio_end_io(struct bio *bio)
 {
 	struct scrub_bio *sbio = bio->bi_private;
@@ -3501,179 +3306,6 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	return 1;
 }
 
-static bool should_use_device(struct btrfs_fs_info *fs_info,
-			      struct btrfs_device *dev,
-			      bool follow_replace_read_mode)
-{
-	struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
-	struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
-
-	if (!dev->bdev)
-		return false;
-
-	/*
-	 * We're doing scrub/replace, if it's pure scrub, no tgtdev should be
-	 * here.  If it's replace, we're going to write data to tgtdev, thus
-	 * the current data of the tgtdev is all garbage, thus we can not use
-	 * it at all.
-	 */
-	if (dev == replace_tgtdev)
-		return false;
-
-	/* No need to follow replace read mode, any existing device is fine. */
-	if (!follow_replace_read_mode)
-		return true;
-
-	/* Need to follow the mode. */
-	if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
-	    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
-		return dev != replace_srcdev;
-	return true;
-}
-static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
-				u64 extent_logical, u32 extent_len,
-				u64 *extent_physical,
-				struct btrfs_device **extent_dev,
-				int *extent_mirror_num)
-{
-	u64 mapped_length;
-	struct btrfs_io_context *bioc = NULL;
-	int ret;
-	int i;
-
-	mapped_length = extent_len;
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-			      extent_logical, &mapped_length, &bioc, 0);
-	if (ret || !bioc || mapped_length < extent_len) {
-		btrfs_put_bioc(bioc);
-		btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical %llu: %d",
-				extent_logical, ret);
-		return -EIO;
-	}
-
-	/*
-	 * First loop to exclude all missing devices and the source device if
-	 * needed.  And we don't want to use target device as mirror either, as
-	 * we're doing the replace, the target device range contains nothing.
-	 */
-	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
-		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
-
-		if (!should_use_device(fs_info, stripe->dev, true))
-			continue;
-		goto found;
-	}
-	/*
-	 * We didn't find any alternative mirrors, we have to break our replace
-	 * read mode, or we can not read at all.
-	 */
-	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
-		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
-
-		if (!should_use_device(fs_info, stripe->dev, false))
-			continue;
-		goto found;
-	}
-
-	btrfs_err_rl(fs_info, "failed to find any live mirror for logical %llu",
-			extent_logical);
-	return -EIO;
-
-found:
-	*extent_physical = bioc->stripes[i].physical;
-	*extent_mirror_num = i + 1;
-	*extent_dev = bioc->stripes[i].dev;
-	btrfs_put_bioc(bioc);
-	return 0;
-}
-
-static bool scrub_need_different_mirror(struct scrub_ctx *sctx,
-					struct map_lookup *map,
-					struct btrfs_device *dev)
-{
-	/*
-	 * For RAID56, all the extra mirrors are rebuilt from other P/Q,
-	 * cannot utilize other mirrors directly.
-	 */
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-		return false;
-
-	if (!dev->bdev)
-		return true;
-
-	return sctx->fs_info->dev_replace.cont_reading_from_srcdev_mode ==
-		BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID;
-}
-
-/* scrub extent tries to collect up to 64 kB for each bio */
-static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
-			u64 logical, u32 len,
-			u64 physical, struct btrfs_device *dev, u64 flags,
-			u64 gen, int mirror_num)
-{
-	struct btrfs_device *src_dev = dev;
-	u64 src_physical = physical;
-	int src_mirror = mirror_num;
-	int ret;
-	u8 csum[BTRFS_CSUM_SIZE];
-	u32 blocksize;
-
-	if (flags & BTRFS_EXTENT_FLAG_DATA) {
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			blocksize = BTRFS_STRIPE_LEN;
-		else
-			blocksize = sctx->fs_info->sectorsize;
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.data_extents_scrubbed++;
-		sctx->stat.data_bytes_scrubbed += len;
-		spin_unlock(&sctx->stat_lock);
-	} else if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			blocksize = BTRFS_STRIPE_LEN;
-		else
-			blocksize = sctx->fs_info->nodesize;
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.tree_extents_scrubbed++;
-		sctx->stat.tree_bytes_scrubbed += len;
-		spin_unlock(&sctx->stat_lock);
-	} else {
-		blocksize = sctx->fs_info->sectorsize;
-		WARN_ON(1);
-	}
-
-	/*
-	 * For dev-replace case, we can have @dev being a missing device, or
-	 * we want to avoid reading from the source device if possible.
-	 */
-	if (sctx->is_dev_replace && scrub_need_different_mirror(sctx, map, dev)) {
-		ret = scrub_find_good_copy(sctx->fs_info, logical, len,
-					   &src_physical, &src_dev, &src_mirror);
-		if (ret < 0)
-			return ret;
-	}
-	while (len) {
-		u32 l = min(len, blocksize);
-		int have_csum = 0;
-
-		if (flags & BTRFS_EXTENT_FLAG_DATA) {
-			/* push csums to sbio */
-			have_csum = scrub_find_csum(sctx, logical, csum);
-			if (have_csum == 0)
-				++sctx->stat.no_csum;
-		}
-		ret = scrub_sectors(sctx, logical, l, src_physical, src_dev,
-				    flags, gen, src_mirror,
-				    have_csum ? csum : NULL, physical);
-		if (ret)
-			return ret;
-		len -= l;
-		logical += l;
-		physical += l;
-		src_physical += l;
-	}
-	return 0;
-}
-
 static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 				  u64 logical, u32 len,
 				  u64 physical, struct btrfs_device *dev,
@@ -4256,20 +3888,6 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
-static void sync_replace_for_zoned(struct scrub_ctx *sctx)
-{
-	if (!btrfs_is_zoned(sctx->fs_info))
-		return;
-
-	sctx->flush_all_writes = true;
-	scrub_submit(sctx);
-	mutex_lock(&sctx->wr_lock);
-	scrub_wr_submit(sctx);
-	mutex_unlock(&sctx->wr_lock);
-
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
-}
-
 static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 					u64 physical, u64 physical_end)
 {
@@ -4518,6 +4136,9 @@ static void flush_scrub_stripes(struct scrub_ctx *sctx)
 		return;
 
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
+
+	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
+			      nr_stripes << BTRFS_STRIPE_LEN_SHIFT);
 	for (i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
 		scrub_submit_initial_read(sctx, stripe);
@@ -4575,10 +4196,10 @@ static void flush_scrub_stripes(struct scrub_ctx *sctx)
 	sctx->cur_stripe = 0;
 }
 
-int queue_scrub_stripe(struct scrub_ctx *sctx,
-		       struct btrfs_block_group *bg,
-		       struct btrfs_device *dev, int mirror_num,
-		       u64 logical, u32 length, u64 physical)
+static int queue_scrub_stripe(struct scrub_ctx *sctx,
+			      struct btrfs_block_group *bg,
+			      struct btrfs_device *dev, int mirror_num,
+			      u64 logical, u32 length, u64 physical)
 {
 	struct scrub_stripe *stripe;
 	int ret;
@@ -4616,11 +4237,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			       u64 physical, int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
 	const u64 logical_end = logical_start + logical_length;
 	/* An artificial limit, inherit from old scrub behavior */
-	const u32 max_length = SZ_64K;
 	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
 	int ret;
@@ -4632,11 +4250,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	path.skip_locking = 1;
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
-		u64 extent_start;
-		u64 extent_len;
-		u64 extent_flags;
-		u64 extent_gen;
-		u64 scrub_len;
+		u64 cur_physical = physical + cur_logical - logical_start;
 
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
@@ -4666,8 +4280,9 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		spin_unlock(&bg->lock);
 
-		ret = find_first_extent_item(extent_root, &path, cur_logical,
-					     logical_end - cur_logical);
+		ret = queue_scrub_stripe(sctx, bg, device, mirror_num,
+					 cur_logical, logical_end - cur_logical,
+					 cur_physical);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
 			sctx->stat.last_physical = physical + logical_length;
@@ -4676,52 +4291,11 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		if (ret < 0)
 			break;
-		get_extent_info(&path, &extent_start, &extent_len,
-				&extent_flags, &extent_gen);
-		/* Skip hole range which doesn't have any extent */
-		cur_logical = max(extent_start, cur_logical);
 
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
+		ASSERT(sctx->cur_stripe > 0);
+		cur_logical = sctx->stripes[sctx->cur_stripe - 1].logical
+			      + BTRFS_STRIPE_LEN;
 
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
-			sync_replace_for_zoned(sctx);
-		cur_logical += scrub_len;
 		/* Don't hold CPU for too long time */
 		cond_resched();
 	}
@@ -4806,7 +4380,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   int stripe_index)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct blk_plug plug;
 	struct map_lookup *map = em->map_lookup;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 	const u64 chunk_logical = bg->start;
@@ -4828,12 +4401,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
-	/*
-	 * collect all data csums for the stripe to avoid seeking during
-	 * the scrub. This might currently (crc32) end up to be about 1MB
-	 */
-	blk_start_plug(&plug);
-
 	if (sctx->is_dev_replace &&
 	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
 		mutex_lock(&sctx->wr_lock);
@@ -4935,8 +4502,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	mutex_lock(&sctx->wr_lock);
 	scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
-
-	blk_finish_plug(&plug);
+	flush_scrub_stripes(sctx);
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index fb9d906f5a17..7639103ebf9d 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,14 +13,4 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
-/*
- * The following functions are temporary exports to avoid warning on unused
- * static functions.
- */
-struct scrub_stripe;
-int queue_scrub_stripe(struct scrub_ctx *sctx,
-		       struct btrfs_block_group *bg,
-		       struct btrfs_device *dev, int mirror_num,
-		       u64 logical, u32 length, u64 physical);
-
 #endif
-- 
2.39.2

