Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF3564FE9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGDIob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIoa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:44:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D511B7E0
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ih1uH35fY+20vl+6dJHqBVw8UKDoDvir5l/PrNeEFRU=; b=iTm7efNf5L50Uno0EfYzdaOC18
        umnzkm8FNHGe9YmA2rLVNsbfyjvpAN/G8bLUZNoZ/JtuOxZZ7vyc5yLUVUE3o4VBF3STp2jAUIIgN
        m3T/1VOVuRL4ZDgsRA58/n3swUxHBMlobcT5rp0t3iPqakWp05tEZBRW82h9OT7Q0XdmB6QFxast2
        3NOLBk0MHbqsYLUsDuV79Q3Qmkj9Ikgpttvg7oj3F0qv1+0d7rL6RjMv2iYCmihX7DVSQDqvAuSRj
        356sGxIdpJgPpOBtdn/oRoaD2Xjou7Tl/TQDCmpNYspl7PxIyKTwqmJX34MH2tGmKwjO5ZcGWenmP
        MqIhDK9w==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hgw-0068N3-OU; Mon, 04 Jul 2022 08:44:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: stop allocation a btrfs_io_context for simple I/O
Date:   Mon,  4 Jul 2022 10:44:06 +0200
Message-Id: <20220704084406.106929-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704084406.106929-1-hch@lst.de>
References: <20220704084406.106929-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The I/O context structure is only really used to pass the btrfs_device to
the end I/O handler for I/Os that go to a single device.

Stop allocating the I/O context for these cases and just pass an optional
btrfs_io_stripe argument to __btrfs_map_block that is filled out for this
fast path.  Additionally the num_mirrors argument is changed to be passed
by references so that the mirror_num can be returned in addition to be
passed in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 194 +++++++++++++++++++++++++++++----------------
 1 file changed, 124 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 32810641737e0..7e0a5f28f53da 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -250,10 +250,10 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info);
 static void btrfs_dev_stat_print_on_error(struct btrfs_device *dev);
 static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op,
-			     u64 logical, u64 *length,
+			     enum btrfs_map_op op, u64 logical, u64 *length,
 			     struct btrfs_io_context **bioc_ret,
-			     int mirror_num, int need_raid_map);
+			     struct btrfs_io_stripe *smap,
+			     int *mirror_num_p, int need_raid_map);
 
 /*
  * Device locking
@@ -6088,7 +6088,7 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	ret = __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				logical, &length, &bioc, 0, 0);
+				logical, &length, &bioc, NULL, NULL, 0);
 	if (ret) {
 		ASSERT(bioc == NULL);
 		return ret;
@@ -6347,11 +6347,19 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	return 0;
 }
 
+static void set_stripe(struct btrfs_io_stripe *dst, struct map_lookup *map,
+		       u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
+{
+	dst->dev = map->stripes[stripe_index].dev;
+	dst->physical = map->stripes[stripe_index].physical +
+			stripe_offset + stripe_nr * map->stripe_len;
+}
+
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
-			     enum btrfs_map_op op,
-			     u64 logical, u64 *length,
+			     enum btrfs_map_op op, u64 logical, u64 *length,
 			     struct btrfs_io_context **bioc_ret,
-			     int mirror_num, int need_raid_map)
+			     struct btrfs_io_stripe *smap,
+			     int *mirror_num_p, int need_raid_map)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -6362,6 +6370,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	int data_stripes;
 	int i;
 	int ret = 0;
+	int mirror_num = mirror_num_p ? *mirror_num_p : 0;
 	int num_stripes;
 	int max_errors = 0;
 	int tgtdev_indexes = 0;
@@ -6522,6 +6531,29 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		tgtdev_indexes = num_stripes;
 	}
 
+	/*
+	 * If this I/O maps to a single device, try to return the device and
+	 * physical block information on the stack instead of allocating an
+	 * I/O context structure.
+	 */
+	if (smap && num_alloc_stripes == 1 &&
+	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
+	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
+	     !dev_replace->tgtdev)) {
+		if (unlikely(patch_the_first_stripe_for_dev_replace)) {
+			smap->dev = dev_replace->tgtdev;
+			smap->physical = physical_to_patch_in_first_stripe;
+			*mirror_num_p = map->num_stripes + 1;
+		} else {
+			set_stripe(smap, map, stripe_index, stripe_offset,
+				   stripe_nr);
+			*mirror_num_p = mirror_num;
+		}
+		*bioc_ret = NULL;
+		ret = 0;
+		goto out;
+	}
+
 	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes, tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
@@ -6529,9 +6561,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
-			stripe_offset + stripe_nr * map->stripe_len;
-		bioc->stripes[i].dev = map->stripes[stripe_index].dev;
+		set_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
+			   stripe_nr);
 		stripe_index++;
 	}
 
@@ -6599,7 +6630,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		      struct btrfs_io_context **bioc_ret, int mirror_num)
 {
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
-				 mirror_num, 0);
+				 NULL, &mirror_num, 0);
 }
 
 /* For Scrub/replace */
@@ -6607,7 +6638,8 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret)
 {
-	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
+	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret,
+				 NULL, NULL, 1);
 }
 
 /*
@@ -6671,11 +6703,12 @@ static void btrfs_log_dev_io_error(struct bio *bio, struct btrfs_device *dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_FLUSH_ERRS);
 }
 
-static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
+static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_info,
+						struct bio *bio)
 {
-	if (bioc->orig_bio->bi_opf & REQ_META)
-		return bioc->fs_info->endio_meta_workers;
-	return bioc->fs_info->endio_workers;
+	if (bio->bi_opf & REQ_META)
+		return fs_info->endio_meta_workers;
+	return fs_info->endio_workers;
 }
 
 static void btrfs_end_bio_work(struct work_struct *work)
@@ -6686,6 +6719,23 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	bbio->end_io(bbio);
 }
 
+static void btrfs_simple_end_io(struct bio *bio)
+{
+	struct btrfs_fs_info *fs_info = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	if (bio->bi_status)
+		btrfs_log_dev_io_error(bio, bbio->device);
+	btrfs_bio_counter_dec(fs_info);
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
+		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
+	} else {
+		bbio->end_io(bbio);
+	}
+}
+
 static void btrfs_raid56_end_io(struct bio *bio)
 {
 	struct btrfs_io_context *bioc = bio->bi_private;
@@ -6712,7 +6762,7 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static void btrfs_end_bio(struct bio *bio)
+static void btrfs_orig_write_end_io(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
 	struct btrfs_io_context *bioc = stripe->bioc;
@@ -6733,39 +6783,12 @@ static void btrfs_end_bio(struct bio *bio)
 		bio->bi_status = BLK_STS_OK;
 
 	btrfs_bio_counter_dec(bioc->fs_info);
-	bbio->mirror_num = bioc->mirror_num;
-	if (btrfs_op(bio) == BTRFS_MAP_READ) {
-		bbio->device = stripe->dev;
-		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
-		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
-	} else {
-		bbio->end_io(bbio);
-	}
-
+	bbio->end_io(bbio);
 	btrfs_put_bioc(bioc);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc,
-			      struct bio *orig_bio, int dev_nr, bool clone)
+static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
-	struct btrfs_fs_info *fs_info = bioc->fs_info;
-	struct btrfs_device *dev = bioc->stripes[dev_nr].dev;
-	u64 physical = bioc->stripes[dev_nr].physical;
-	struct bio *bio;
-
-	if (clone) {
-		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
-		bio_inc_remaining(orig_bio);
-		bio->bi_end_io = btrfs_clone_write_end_io;
-	} else {
-		bio = orig_bio;
-		bio->bi_end_io = btrfs_end_bio;
-	}
-
-	bioc->stripes[dev_nr].bioc = bioc;
-	bio->bi_private = &bioc->stripes[dev_nr];
-	bio->bi_iter.bi_sector = physical >> 9;
-
 	if (!dev || !dev->bdev ||
 	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
 	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
@@ -6781,8 +6804,11 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	 * zone
 	 */
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		u64 physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
 		if (btrfs_dev_is_sequential(dev, physical)) {
-			u64 zone_start = round_down(physical, fs_info->zone_size);
+			u64 zone_start = round_down(physical,
+						    dev->fs_info->zone_size);
 
 			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 		} else {
@@ -6790,7 +6816,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 			bio->bi_opf |= REQ_OP_WRITE;
 		}
 	}
-	btrfs_debug_in_rcu(fs_info,
+
+	btrfs_debug_in_rcu(dev->fs_info,
 	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
@@ -6800,39 +6827,46 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	submit_bio(bio);
 }
 
+static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
+{
+	struct bio *orig_bio = bioc->orig_bio, *bio;
+
+	ASSERT(bio_op(orig_bio) != REQ_OP_READ);
+
+	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
+	if (dev_nr == bioc->num_stripes - 1) {
+		bio = orig_bio;
+		bio->bi_end_io = btrfs_orig_write_end_io;
+	} else {
+		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
+		bio_inc_remaining(orig_bio);
+		bio->bi_end_io = btrfs_clone_write_end_io;
+	}
+
+	bio->bi_private = &bioc->stripes[dev_nr];
+	bio->bi_iter.bi_sector = bioc->stripes[dev_nr].physical >> SECTOR_SHIFT;
+	bioc->stripes[dev_nr].bioc = bioc;
+	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
+}
+
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror_num)
 {
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
-	int ret;
-	int dev_nr;
-	int total_devs;
 	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_io_stripe smap;
+	int ret;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bioc, mirror_num, 1);
+	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+				&bioc, &smap, &mirror_num, 1);
 	if (ret) {
 		btrfs_bio_counter_dec(fs_info);
 		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
 		return;
 	}
 
-	total_devs = bioc->num_stripes;
-	bioc->orig_bio = bio;
-
-	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
-		bio->bi_private = bioc;
-		bio->bi_end_io = btrfs_raid56_end_io;
-		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-			raid56_parity_write(bio, bioc);
-		else
-			raid56_parity_recover(bio, bioc, mirror_num);
-		return;
-	}
-
 	if (map_length < length) {
 		btrfs_crit(fs_info,
 			   "mapping failed logical %llu bio len %llu len %llu",
@@ -6840,10 +6874,30 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		BUG();
 	}
 
-	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		const bool should_clone = (dev_nr < total_devs - 1);
+	if (!bioc) {
+		/* Single mirror read/write fast path */
+		btrfs_bio(bio)->mirror_num = mirror_num;
+		btrfs_bio(bio)->device = smap.dev;
+		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
+		bio->bi_private = fs_info;
+		bio->bi_end_io = btrfs_simple_end_io;
+		btrfs_submit_dev_bio(smap.dev, bio);
+	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/* Parity RAID write or read recovery */
+		bio->bi_private = bioc;
+		bio->bi_end_io = btrfs_raid56_end_io;
+		if (bio_op(bio) == REQ_OP_READ)
+			raid56_parity_recover(bio, bioc, mirror_num);
+		else
+			raid56_parity_write(bio, bioc);
+	} else {
+		/* Write to multiple mirrors */
+		int total_devs = bioc->num_stripes;
+		int dev_nr;
 
-		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
+		bioc->orig_bio = bio;
+		for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+			btrfs_submit_mirrored_bio(bioc, dev_nr);
 	}
 }
 
-- 
2.30.2

