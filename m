Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7982F643E7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiLFIYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiLFIYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFDD8C
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:09 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5F0D21C0B
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cb736H8c0T1nOKVthUNnZykPgASk/5BEBXgudAJRoFc=;
        b=AQRA77e2a/HT2mMNgtO6cPAu8aASHIWqquhDZyf0Rh7pQj13lP4xoZg+IoBcWcg5e8+Ys3
        +3ETWjRJgYs8474eN95c+Lwy7xG01Ayw2g6Mde+h0n611YyNW7uMGtLQvMI/9iUH58uloA
        kgOsBr8MMDwzdXsOcCN7XfjJXJRzHIQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2FAF2132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iF5HOyb8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 11/11] btrfs: scrub: cleanup scrub_extent() and its related functions
Date:   Tue,  6 Dec 2022 16:23:38 +0800
Message-Id: <87b515af90d9533754af5d549d4f6f6d3b909036.1670314744.git.wqu@suse.com>
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

Since scrub_simple_mirror() has migrated to scrub2_stripe based
solution, scrub_extent() can be safely removed.

With that function removed, all the static functions called by it can
also be removed.

Please note that, the following structures are no longer in use:

- scrub_block
- scrub_sector
- scrub_bio

But this cleanup is already too large for a single patch, thus they are
left for further cleanup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 443 -----------------------------------------------
 fs/btrfs/scrub.h |   9 -
 2 files changed, 452 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f3981f11dd2c..41e676e2a1b9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -608,18 +608,8 @@ static int scrub_checksum_super(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
 static void scrub_sector_get(struct scrub_sector *sector);
 static void scrub_sector_put(struct scrub_sector *sector);
-static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
-			 u64 physical, struct btrfs_device *dev, u64 flags,
-			 u64 gen, int mirror_num, u8 *csum,
-			 u64 physical_for_dev_replace);
-static void scrub_bio_end_io(struct bio *bio);
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
@@ -2415,281 +2405,6 @@ static void scrub_submit(struct scrub_ctx *sctx)
 	submit_bio(sbio->bio);
 }
 
-static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
-				      struct scrub_sector *sector)
-{
-	struct scrub_block *sblock = sector->sblock;
-	struct scrub_bio *sbio;
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-	int ret;
-
-again:
-	/*
-	 * grab a fresh bio or wait for one to become available
-	 */
-	while (sctx->curr == -1) {
-		spin_lock(&sctx->list_lock);
-		sctx->curr = sctx->first_free;
-		if (sctx->curr != -1) {
-			sctx->first_free = sctx->bios[sctx->curr]->next_free;
-			sctx->bios[sctx->curr]->next_free = -1;
-			sctx->bios[sctx->curr]->sector_count = 0;
-			spin_unlock(&sctx->list_lock);
-		} else {
-			spin_unlock(&sctx->list_lock);
-			wait_event(sctx->list_wait, sctx->first_free != -1);
-		}
-	}
-	sbio = sctx->bios[sctx->curr];
-	if (sbio->sector_count == 0) {
-		sbio->physical = sblock->physical + sector->offset;
-		sbio->logical = sblock->logical + sector->offset;
-		sbio->dev = sblock->dev;
-		if (!sbio->bio) {
-			sbio->bio = bio_alloc(sbio->dev->bdev, sctx->sectors_per_bio,
-					      REQ_OP_READ, GFP_NOFS);
-		}
-		sbio->bio->bi_private = sbio;
-		sbio->bio->bi_end_io = scrub_bio_end_io;
-		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
-		sbio->status = 0;
-	} else if (sbio->physical + sbio->sector_count * sectorsize !=
-		   sblock->physical + sector->offset ||
-		   sbio->logical + sbio->sector_count * sectorsize !=
-		   sblock->logical + sector->offset ||
-		   sbio->dev != sblock->dev) {
-		scrub_submit(sctx);
-		goto again;
-	}
-
-	sbio->sectors[sbio->sector_count] = sector;
-	ret = bio_add_scrub_sector(sbio->bio, sector, sectorsize);
-	if (ret != sectorsize) {
-		if (sbio->sector_count < 1) {
-			bio_put(sbio->bio);
-			sbio->bio = NULL;
-			return -EIO;
-		}
-		scrub_submit(sctx);
-		goto again;
-	}
-
-	scrub_block_get(sblock); /* one for the page added to the bio */
-	atomic_inc(&sblock->outstanding_sectors);
-	sbio->sector_count++;
-	if (sbio->sector_count == sctx->sectors_per_bio)
-		scrub_submit(sctx);
-
-	return 0;
-}
-
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
-static void scrub_bio_end_io(struct bio *bio)
-{
-	struct scrub_bio *sbio = bio->bi_private;
-	struct btrfs_fs_info *fs_info = sbio->dev->fs_info;
-
-	sbio->status = bio->bi_status;
-	sbio->bio = bio;
-
-	queue_work(fs_info->scrub_workers, &sbio->work);
-}
-
 static void scrub_bio_end_io_worker(struct work_struct *work)
 {
 	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
@@ -2751,139 +2466,6 @@ static void scrub_block_complete(struct scrub_block *sblock)
 	}
 }
 
-static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *sum)
-{
-	sctx->stat.csum_discards += sum->len >> sctx->fs_info->sectorsize_bits;
-	list_del(&sum->list);
-	kfree(sum);
-}
-
-/*
- * Find the desired csum for range [logical, logical + sectorsize), and store
- * the csum into @csum.
- *
- * The search source is sctx->csum_list, which is a pre-populated list
- * storing bytenr ordered csum ranges.  We're responsible to cleanup any range
- * that is before @logical.
- *
- * Return 0 if there is no csum for the range.
- * Return 1 if there is csum for the range and copied to @csum.
- */
-static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
-{
-	bool found = false;
-
-	while (!list_empty(&sctx->csum_list)) {
-		struct btrfs_ordered_sum *sum = NULL;
-		unsigned long index;
-		unsigned long num_sectors;
-
-		sum = list_first_entry(&sctx->csum_list,
-				       struct btrfs_ordered_sum, list);
-		/* The current csum range is beyond our range, no csum found */
-		if (sum->bytenr > logical)
-			break;
-
-		/*
-		 * The current sum is before our bytenr, since scrub is always
-		 * done in bytenr order, the csum will never be used anymore,
-		 * clean it up so that later calls won't bother with the range,
-		 * and continue search the next range.
-		 */
-		if (sum->bytenr + sum->len <= logical) {
-			drop_csum_range(sctx, sum);
-			continue;
-		}
-
-		/* Now the csum range covers our bytenr, copy the csum */
-		found = true;
-		index = (logical - sum->bytenr) >> sctx->fs_info->sectorsize_bits;
-		num_sectors = sum->len >> sctx->fs_info->sectorsize_bits;
-
-		memcpy(csum, sum->sums + index * sctx->fs_info->csum_size,
-		       sctx->fs_info->csum_size);
-
-		/* Cleanup the range if we're at the end of the csum range */
-		if (index == num_sectors - 1)
-			drop_csum_range(sctx, sum);
-		break;
-	}
-	if (!found)
-		return 0;
-	return 1;
-}
-
-/* scrub extent tries to collect up to 64 kB for each bio */
-int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
-		 u64 logical, u32 len, u64 physical,
-		 struct btrfs_device *dev, u64 flags,
-		 u64 gen, int mirror_num)
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
 /*
  * Given a physical address, this will calculate it's
  * logical offset. if this is a parity stripe, it will return
@@ -5132,28 +4714,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 
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
index d387c7eef061..7639103ebf9d 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,13 +13,4 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
-/*
- * The following functions are temporary exports to avoid warning on unused
- * static functions.
- */
-int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
-		 u64 logical, u32 len, u64 physical,
-		 struct btrfs_device *dev, u64 flags,
-		 u64 gen, int mirror_num);
-
 #endif
-- 
2.38.1

