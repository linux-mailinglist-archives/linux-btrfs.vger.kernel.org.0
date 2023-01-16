Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE166B7C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjAPHE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAPHEy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC7B45D
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5838B67470
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBKkWUV9fK4PC9PqEq9DLg61DBdbrFw/03+9FSIlPVQ=;
        b=sQ1v5ZtIk8Jk1od5v3wqWVTe4NLtz2XykCIb4vcEvj9hpvo1Bb9iDN5nrUqpWVJ0D3V7tc
        H5CqDhuCseCkcY8Gbij5zwc4YxPTBz8QldzXOs1ypQRA96GJGZ0r2egzz/Kl4se/GXEVot
        +5F20MMH1N7szzEx6ECi8fyNh9IfQ+c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 853E8138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGSXFBL3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure
Date:   Mon, 16 Jan 2023 15:04:22 +0800
Message-Id: <c90ed1f4d40808fe48610341966c1b38fa9d3e72.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
References: <cover.1673851704.git.wqu@suse.com>
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
 fs/btrfs/scrub.c | 523 +++++++++++------------------------------------
 fs/btrfs/scrub.h |  18 --
 2 files changed, 121 insertions(+), 420 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d587ca1fb8e7..6ff3f0d74683 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -619,18 +619,9 @@ static void scrub_sector_get(struct scrub_sector *sector);
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
-static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
-				 u64 extent_logical, u32 extent_len,
-				 u64 *extent_physical,
-				 struct btrfs_device **extent_dev,
-				 int *extent_mirror_num);
 static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 				      struct scrub_sector *sector);
 static void scrub_wr_submit(struct scrub_ctx *sctx);
@@ -2536,10 +2527,10 @@ static void scrub_write_endio(struct bio *bio)
  *
  * Thus here we submit bio directly to @device.
  */
-void scrub_write_wait_sectors(struct scrub_ctx *sctx,
-			      struct scrub_stripe *stripe,
-			      struct btrfs_device *dev, u64 physical,
-			      unsigned long *write_bitmap)
+static void scrub_write_wait_sectors(struct scrub_ctx *sctx,
+				     struct scrub_stripe *stripe,
+				     struct btrfs_device *dev, u64 physical,
+				     unsigned long *write_bitmap)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct bio *bio = NULL;
@@ -2597,7 +2588,7 @@ void scrub_write_wait_sectors(struct scrub_ctx *sctx,
 	wait_scrub_stripe(stripe);
 }
 
-int scrub_repair_one_stripe(struct scrub_stripe *stripe)
+static int scrub_repair_one_stripe(struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct scrub_stripe **repair_stripes;
@@ -2678,8 +2669,8 @@ int scrub_repair_one_stripe(struct scrub_stripe *stripe)
 	return ret;
 }
 
-void scrub_report_stripe_errors(struct scrub_ctx *sctx,
-				struct scrub_stripe *stripe)
+static void scrub_report_stripe_errors(struct scrub_ctx *sctx,
+				       struct scrub_stripe *stripe)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
@@ -2968,22 +2959,16 @@ static void scrub_sector_put(struct scrub_sector *sector)
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
@@ -3005,7 +2990,7 @@ static void scrub_throttle(struct scrub_ctx *sctx)
 	/* Still in the time to send? */
 	if (ktime_before(now, sctx->throttle_deadline)) {
 		/* If current bio is within the limit, send it */
-		sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
+		sctx->throttle_sent += bio_size;
 		if (sctx->throttle_sent <= div_u64(bwlimit, div))
 			return;
 
@@ -3027,6 +3012,17 @@ static void scrub_throttle(struct scrub_ctx *sctx)
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
@@ -3111,202 +3107,6 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
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
-	if (ret || !bioc || !bioc->raid_map)
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
@@ -3491,77 +3291,6 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	return 1;
 }
 
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
-			blocksize = map->stripe_len;
-		else
-			blocksize = sctx->fs_info->sectorsize;
-		spin_lock(&sctx->stat_lock);
-		sctx->stat.data_extents_scrubbed++;
-		sctx->stat.data_bytes_scrubbed += len;
-		spin_unlock(&sctx->stat_lock);
-	} else if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
-			blocksize = map->stripe_len;
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
-	 * For dev-replace case, we can have @dev being a missing device.
-	 * Regular scrub will avoid its execution on missing device at all,
-	 * as that would trigger tons of read error.
-	 *
-	 * Reading from missing device will cause read error counts to
-	 * increase unnecessarily.
-	 * So here we change the read source to a good mirror.
-	 */
-	if (sctx->is_dev_replace && !dev->bdev)
-		scrub_find_good_copy(sctx->fs_info, logical, len, &src_physical,
-				     &src_dev, &src_mirror);
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
@@ -4145,20 +3874,6 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
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
@@ -4216,11 +3931,11 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
  * Return >0 if there is no such stripe in the specified range.
  * Return <0 for error.
  */
-int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
-				 struct btrfs_root *csum_root,
-				 struct btrfs_block_group *bg,
-				 u64 logical_start, u64 logical_len,
-				 struct scrub_stripe *stripe)
+static int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
+					struct btrfs_root *csum_root,
+					struct btrfs_block_group *bg,
+					u64 logical_start, u64 logical_len,
+					struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = extent_root->fs_info;
 	const u64 logical_end = logical_start + logical_len;
@@ -4326,6 +4041,67 @@ int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
 	return ret;
 }
 
+/* Reset the bitmaps and sectors info for next stripe. */
+static void scrub_reset_stripe(struct scrub_stripe *stripe)
+{
+	int i;
+
+	stripe->extent_sector_bitmap = 0;
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
+static void scrub_write_repaired_sectors(struct scrub_ctx *sctx,
+					 struct scrub_stripe *stripe)
+{
+	unsigned long write_bitmap;
+
+	if (sctx->readonly)
+		return;
+
+	/*
+	 * Repaired sectors are in @init_error_bitmap, but not in
+	 * @current_error_bitmap.
+	 */
+	bitmap_andnot(&write_bitmap, &stripe->init_error_bitmap,
+		      &stripe->current_error_bitmap, stripe->nr_sectors);
+	scrub_write_wait_sectors(sctx, stripe, stripe->dev, stripe->physical,
+				 &write_bitmap);
+}
+
+static void scrub_write_replace_sectors(struct scrub_ctx *sctx,
+					struct scrub_stripe *stripe)
+{
+	unsigned long write_bitmap;
+
+	if (sctx->readonly)
+		return;
+
+	/*
+	 * Rplace sectors are in @extent_sector_bitmap, but not in
+	 * @current_error_bitmap.
+	 *
+	 * If we have unrepaired sectors, we have no choice but to skip them.
+	 */
+	bitmap_andnot(&write_bitmap, &stripe->extent_sector_bitmap,
+		      &stripe->current_error_bitmap, stripe->nr_sectors);
+	scrub_write_wait_sectors(sctx, stripe, sctx->wr_tgtdev, stripe->physical,
+				 &write_bitmap);
+}
 
 /*
  * Scrub one range which can only has simple mirror based profile.
@@ -4336,6 +4112,7 @@ int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
  * and @logical_length parameter.
  */
 static int scrub_simple_mirror(struct scrub_ctx *sctx,
+			       struct scrub_stripe *stripe,
 			       struct btrfs_block_group *bg,
 			       struct map_lookup *map,
 			       u64 logical_start, u64 logical_length,
@@ -4346,25 +4123,17 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
 	const u64 logical_end = logical_start + logical_length;
-	/* An artificial limit, inherit from old scrub behavior */
-	const u32 max_length = SZ_64K;
-	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
 	int ret;
 
 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
 
-	path.search_commit_root = 1;
-	path.skip_locking = 1;
+	stripe->mirror_num = mirror_num;
+	stripe->dev = device;
+
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
-		u64 extent_start;
-		u64 extent_len;
-		u64 extent_flags;
-		u64 extent_gen;
-		u64 scrub_len;
-
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
 		    atomic_read(&sctx->cancel_req)) {
@@ -4393,8 +4162,9 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		spin_unlock(&bg->lock);
 
-		ret = find_first_extent_item(extent_root, &path, cur_logical,
-					     logical_end - cur_logical);
+		scrub_reset_stripe(stripe);
+		ret = scrub_find_fill_first_stripe(extent_root, csum_root, bg,
+				cur_logical, logical_end - cur_logical, stripe);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
 			sctx->stat.last_physical = physical + logical_length;
@@ -4403,56 +4173,20 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		if (ret < 0)
 			break;
-		get_extent_info(&path, &extent_start, &extent_len,
-				&extent_flags, &extent_gen);
-		/* Skip hole range which doesn't have any extent */
-		cur_logical = max(extent_start, cur_logical);
-
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
-
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
+		stripe->physical = physical + stripe->logical - logical_start;
+		scrub_throttle_dev_io(sctx, device, BTRFS_STRIPE_LEN);
+		scrub_submit_read_one_stripe(stripe);
+		wait_scrub_stripe(stripe);
+		scrub_repair_one_stripe(stripe);
+		scrub_write_repaired_sectors(sctx, stripe);
+		scrub_report_stripe_errors(sctx, stripe);
 		if (sctx->is_dev_replace)
-			sync_replace_for_zoned(sctx);
-		cur_logical += scrub_len;
+			scrub_write_replace_sectors(sctx, stripe);
+
+		cur_logical = stripe->logical + BTRFS_STRIPE_LEN;
 		/* Don't hold CPU for too long time */
 		cond_resched();
 	}
-	btrfs_release_path(&path);
 	return ret;
 }
 
@@ -4493,6 +4227,7 @@ static int simple_stripe_mirror_num(struct map_lookup *map, int stripe_index)
 }
 
 static int scrub_simple_stripe(struct scrub_ctx *sctx,
+			       struct scrub_stripe *stripe,
 			       struct btrfs_block_group *bg,
 			       struct map_lookup *map,
 			       struct btrfs_device *device,
@@ -4512,7 +4247,7 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
 		 * this stripe.
 		 */
-		ret = scrub_simple_mirror(sctx, bg, map, cur_logical,
+		ret = scrub_simple_mirror(sctx, stripe, bg, map, cur_logical,
 					  map->stripe_len, device, cur_physical,
 					  mirror_num);
 		if (ret)
@@ -4532,6 +4267,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   int stripe_index)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct scrub_stripe *stripe;
 	struct blk_plug plug;
 	struct map_lookup *map = em->map_lookup;
 	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
@@ -4550,10 +4286,15 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 stripe_end;
 	int stop_loop = 0;
 
+	stripe = alloc_scrub_stripe(fs_info, bg);
+	if (!stripe)
+		return -ENOMEM;
+
 	wait_event(sctx->list_wait,
 		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
+
 	/*
 	 * collect all data csums for the stripe to avoid seeking during
 	 * the scrub. This might currently (crc32) end up to be about 1MB
@@ -4585,14 +4326,16 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * Only @physical and @mirror_num needs to calculated using
 		 * @stripe_index.
 		 */
-		ret = scrub_simple_mirror(sctx, bg, map, bg->start, bg->length,
-				scrub_dev, map->stripes[stripe_index].physical,
+		ret = scrub_simple_mirror(sctx, stripe, bg, map, bg->start,
+				bg->length, scrub_dev,
+				map->stripes[stripe_index].physical,
 				stripe_index + 1);
 		offset = 0;
 		goto out;
 	}
 	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
-		ret = scrub_simple_stripe(sctx, bg, map, scrub_dev, stripe_index);
+		ret = scrub_simple_stripe(sctx, stripe, bg, map, scrub_dev,
+					  stripe_index);
 		offset = map->stripe_len * (stripe_index / map->sub_stripes);
 		goto out;
 	}
@@ -4638,8 +4381,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		 * We can reuse scrub_simple_mirror() here, as the repair part
 		 * is still based on @mirror_num.
 		 */
-		ret = scrub_simple_mirror(sctx, bg, map, logical, map->stripe_len,
-					  scrub_dev, physical, 1);
+		ret = scrub_simple_mirror(sctx, stripe, bg, map, logical,
+					  map->stripe_len, scrub_dev, physical, 1);
 		if (ret < 0)
 			goto out;
 next:
@@ -4674,6 +4417,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		if (ret2)
 			ret = ret2;
 	}
+	free_scrub_stripe(stripe);
 
 	return ret < 0 ? ret : 0;
 }
@@ -5479,28 +5223,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 
 	return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
 }
-
-static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
-				 u64 extent_logical, u32 extent_len,
-				 u64 *extent_physical,
-				 struct btrfs_device **extent_dev,
-				 int *extent_mirror_num)
-{
-	u64 mapped_length;
-	struct btrfs_io_context *bioc = NULL;
-	int ret;
-
-	mapped_length = extent_len;
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
-			      &mapped_length, &bioc, 0);
-	if (ret || !bioc || mapped_length < extent_len ||
-	    !bioc->stripes[0].dev->bdev) {
-		btrfs_put_bioc(bioc);
-		return;
-	}
-
-	*extent_physical = bioc->stripes[0].physical;
-	*extent_mirror_num = bioc->mirror_num;
-	*extent_dev = bioc->stripes[0].dev;
-	btrfs_put_bioc(bioc);
-}
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index fc294a250945..7639103ebf9d 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,22 +13,4 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
-/*
- * The following functions are temporary exports to avoid warning on unused
- * static functions.
- */
-struct scrub_stripe;
-int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
-				 struct btrfs_root *csum_root,
-				 struct btrfs_block_group *bg,
-				 u64 logical_start, u64 logical_len,
-				 struct scrub_stripe *stripe);
-int scrub_repair_one_stripe(struct scrub_stripe *stripe);
-void scrub_write_wait_sectors(struct scrub_ctx *sctx,
-			      struct scrub_stripe *stripe,
-			      struct btrfs_device *dev, u64 physical,
-			      unsigned long *write_bitmap);
-void scrub_report_stripe_errors(struct scrub_ctx *sctx,
-				struct scrub_stripe *stripe);
-
 #endif
-- 
2.39.0

