Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FFB54F4C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380841AbiFQKE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B95909E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qyoco4D/zp7BW9g/pUII6IAbhlZvQKjAfHTOi4dWglI=; b=1I1C65biJjYFHPR4JhJuTlVzQ+
        xuJ0NC/vZF3eRqR+7RUZudUVoMoyMA1HJ4bI4/PW9w+66TYSnvWIkJKRZCvSMipDNPJQHHiUKUkzb
        VUJT3P1tLa5oK1t2QKGjdlswkIQPS+rCd57OA0xEKnt+aMK/yjKV9q8VnotOrYGaEPi3+Frgb1qi0
        MLsd+PFIf//9FV9DFbiY1m5pr7nFCEsGqcxLC7A/EYnVPkZzqZ6cxmfyzrRnhT6npUL9+eVIrA5p/
        Oibx6MIHwDfySdofIY7dlRBQIaVAFrYsLund/7VyiaVMIZhCrNJT7e6GqC0iQByIE7yivaq0uIOjw
        8d2rN4TA==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28pw-006sio-DT; Fri, 17 Jun 2022 10:04:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 01/10] btrfs: remove a bunch of pointles stripe_len arguments
Date:   Fri, 17 Jun 2022 12:04:05 +0200
Message-Id: <20220617100414.1159680-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
References: <20220617100414.1159680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The raid56 code assumes a fixed stripe length.  To start simplifying the
bio mapping code remove a few arguments and explicitly hard code that
fixes stripe length.

Partially based on a patch from Qu Wenruo.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  | 61 ++++++++++++++++++++--------------------------
 fs/btrfs/raid56.h  | 12 +++------
 fs/btrfs/scrub.c   |  9 +++----
 fs/btrfs/volumes.c | 13 ++++------
 4 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0f0368e63e5af..233dcef6ce3ad 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -474,9 +474,9 @@ static int rbio_is_full(struct btrfs_raid_bio *rbio)
 	int ret = 1;
 
 	spin_lock_irqsave(&rbio->bio_list_lock, flags);
-	if (size != rbio->nr_data * rbio->stripe_len)
+	if (size != rbio->nr_data * BTRFS_STRIPE_LEN)
 		ret = 0;
-	BUG_ON(size > rbio->nr_data * rbio->stripe_len);
+	BUG_ON(size > rbio->nr_data * BTRFS_STRIPE_LEN);
 	spin_unlock_irqrestore(&rbio->bio_list_lock, flags);
 
 	return ret;
@@ -913,18 +913,17 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
  * this does not allocate any pages for rbio->pages.
  */
 static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
-					 struct btrfs_io_context *bioc,
-					 u32 stripe_len)
+					 struct btrfs_io_context *bioc)
 {
 	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
-	const unsigned int stripe_npages = stripe_len >> PAGE_SHIFT;
+	const unsigned int stripe_npages = BTRFS_STRIPE_LEN >> PAGE_SHIFT;
 	const unsigned int num_pages = stripe_npages * real_stripes;
-	const unsigned int stripe_nsectors = stripe_len >> fs_info->sectorsize_bits;
+	const unsigned int stripe_nsectors =
+		BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
 	const unsigned int num_sectors = stripe_nsectors * real_stripes;
 	struct btrfs_raid_bio *rbio;
 	void *p;
 
-	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
 	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
 	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
 	/*
@@ -948,7 +947,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&rbio->stripe_cache);
 	INIT_LIST_HEAD(&rbio->hash_list);
 	rbio->bioc = bioc;
-	rbio->stripe_len = stripe_len;
 	rbio->nr_pages = num_pages;
 	rbio->nr_sectors = num_sectors;
 	rbio->real_stripes = real_stripes;
@@ -1020,7 +1018,6 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 			      struct sector_ptr *sector,
 			      unsigned int stripe_nr,
 			      unsigned int sector_nr,
-			      unsigned long bio_max_len,
 			      unsigned int opf)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
@@ -1065,7 +1062,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1UL),
+	bio = bio_alloc(stripe->dev->bdev,
+			max(BTRFS_STRIPE_LEN >> PAGE_SHIFT, 1),
 			opf, GFP_NOFS);
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
@@ -1287,8 +1285,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		}
 
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-					 sectornr, rbio->stripe_len,
-					 REQ_OP_WRITE);
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -1327,8 +1324,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 
 		ret = rbio_add_io_sector(rbio, &bio_list, sector,
 					 rbio->bioc->tgtdev_map[stripe],
-					 sectornr, rbio->stripe_len,
-					 REQ_OP_WRITE);
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -1373,7 +1369,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 
 	for (i = 0; i < rbio->bioc->num_stripes; i++) {
 		stripe = &rbio->bioc->stripes[i];
-		if (in_range(physical, stripe->physical, rbio->stripe_len) &&
+		if (in_range(physical, stripe->physical, BTRFS_STRIPE_LEN) &&
 		    stripe->dev->bdev && bio->bi_bdev == stripe->dev->bdev) {
 			return i;
 		}
@@ -1395,7 +1391,7 @@ static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 	for (i = 0; i < rbio->nr_data; i++) {
 		u64 stripe_start = rbio->bioc->raid_map[i];
 
-		if (in_range(logical, stripe_start, rbio->stripe_len))
+		if (in_range(logical, stripe_start, BTRFS_STRIPE_LEN))
 			return i;
 	}
 	return -1;
@@ -1580,8 +1576,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 			continue;
 
 		ret = rbio_add_io_sector(rbio, &bio_list, sector,
-			       stripe, sectornr, rbio->stripe_len,
-			       REQ_OP_READ);
+			       stripe, sectornr, REQ_OP_READ);
 		if (ret)
 			goto cleanup;
 	}
@@ -1790,7 +1785,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 
 	ASSERT(orig_logical >= full_stripe_start &&
 	       orig_logical + orig_len <= full_stripe_start +
-	       rbio->nr_data * rbio->stripe_len);
+	       rbio->nr_data * BTRFS_STRIPE_LEN);
 
 	bio_list_add(&rbio->bio_list, orig_bio);
 	rbio->bio_list_bytes += orig_bio->bi_iter.bi_size;
@@ -1808,7 +1803,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 /*
  * our main entry point for writes from the rest of the FS.
  */
-int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc, u32 stripe_len)
+int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -1816,7 +1811,7 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc, u32 stri
 	struct blk_plug_cb *cb;
 	int ret;
 
-	rbio = alloc_rbio(fs_info, bioc, stripe_len);
+	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
 		btrfs_put_bioc(bioc);
 		return PTR_ERR(rbio);
@@ -2141,8 +2136,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 			continue;
 
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-					 sectornr, rbio->stripe_len,
-					 REQ_OP_READ);
+					 sectornr, REQ_OP_READ);
 		if (ret < 0)
 			goto cleanup;
 	}
@@ -2200,7 +2194,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
  * of the drive.
  */
 int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  u32 stripe_len, int mirror_num, int generic_io)
+			  int mirror_num, int generic_io)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -2211,7 +2205,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 		btrfs_bio(bio)->mirror_num = mirror_num;
 	}
 
-	rbio = alloc_rbio(fs_info, bioc, stripe_len);
+	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
 		if (generic_io)
 			btrfs_put_bioc(bioc);
@@ -2305,14 +2299,14 @@ static void read_rebuild_work(struct work_struct *work)
 
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
-				u32 stripe_len, struct btrfs_device *scrub_dev,
+				struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap, int stripe_nsectors)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 	int i;
 
-	rbio = alloc_rbio(fs_info, bioc, stripe_len);
+	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio))
 		return NULL;
 	bio_list_add(&rbio->bio_list, bio);
@@ -2357,7 +2351,7 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 
 	ASSERT(logical >= rbio->bioc->raid_map[0]);
 	ASSERT(logical + sectorsize <= rbio->bioc->raid_map[0] +
-				rbio->stripe_len * rbio->nr_data);
+				BTRFS_STRIPE_LEN * rbio->nr_data);
 	stripe_offset = (int)(logical - rbio->bioc->raid_map[0]);
 	index = stripe_offset / sectorsize;
 	rbio->bio_sectors[index].page = page;
@@ -2513,7 +2507,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
-					 sectornr, rbio->stripe_len, REQ_OP_WRITE);
+					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2527,7 +2521,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
 		ret = rbio_add_io_sector(rbio, &bio_list, sector,
 				       bioc->tgtdev_map[rbio->scrubp],
-				       sectornr, rbio->stripe_len, REQ_OP_WRITE);
+				       sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2694,7 +2688,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 			continue;
 
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-					 sectornr, rbio->stripe_len, REQ_OP_READ);
+					 sectornr, REQ_OP_READ);
 		if (ret)
 			goto cleanup;
 	}
@@ -2759,13 +2753,12 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 /* The following code is used for dev replace of a missing RAID 5/6 device. */
 
 struct btrfs_raid_bio *
-raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
-			  u64 length)
+raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 
-	rbio = alloc_rbio(fs_info, bioc, length);
+	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio))
 		return NULL;
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index c73bceb2b4616..1dce205b79bf9 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -56,9 +56,6 @@ struct btrfs_raid_bio {
 	 */
 	enum btrfs_rbio_ops operation;
 
-	/* Size of each individual stripe on disk */
-	u32 stripe_len;
-
 	/* How many pages there are for the full stripe including P/Q */
 	u16 nr_pages;
 
@@ -169,21 +166,20 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 struct btrfs_device;
 
 int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  u32 stripe_len, int mirror_num, int generic_io);
-int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc, u32 stripe_len);
+			  int mirror_num, int generic_io);
+int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    unsigned int pgoff, u64 logical);
 
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
-				struct btrfs_io_context *bioc, u32 stripe_len,
+				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
 struct btrfs_raid_bio *
-raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
-			  u64 length);
+raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc);
 void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a0c45e92bd6cb..ad7958d18158f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1216,7 +1216,6 @@ static inline int scrub_nr_raid_mirrors(struct btrfs_io_context *bioc)
 
 static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 						 u64 *raid_map,
-						 u64 mapped_length,
 						 int nstripes, int mirror,
 						 int *stripe_index,
 						 u64 *stripe_offset)
@@ -1231,7 +1230,7 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 				continue;
 
 			if (logical >= raid_map[i] &&
-			    logical < raid_map[i] + mapped_length)
+			    logical < raid_map[i] + BTRFS_STRIPE_LEN)
 				break;
 		}
 
@@ -1335,7 +1334,6 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			scrub_stripe_index_and_offset(logical,
 						      bioc->map_type,
 						      bioc->raid_map,
-						      mapped_length,
 						      bioc->num_stripes -
 						      bioc->num_tgtdevs,
 						      mirror_index,
@@ -1387,7 +1385,6 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 
 	mirror_num = sector->sblock->sectors[0]->mirror_num;
 	ret = raid56_parity_recover(bio, sector->recover->bioc,
-				    sector->recover->map_length,
 				    mirror_num, 0);
 	if (ret)
 		return ret;
@@ -2195,7 +2192,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
 
-	rbio = raid56_alloc_missing_rbio(bio, bioc, length);
+	rbio = raid56_alloc_missing_rbio(bio, bioc);
 	if (!rbio)
 		goto rbio_out;
 
@@ -2829,7 +2826,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
 
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, length,
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc,
 					      sparity->scrub_dev,
 					      &sparity->dbitmap,
 					      sparity->nsectors);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 80636fbf28b7a..556a18dca6e9f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6466,6 +6466,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		ASSERT(map->stripe_len == BTRFS_STRIPE_LEN);
 		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
 			/* push stripe_nr back to the start of the full stripe */
 			stripe_nr = div64_u64(raid56_full_stripe_start,
@@ -6763,14 +6764,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
-		/* In this case, map_length has been set to the length of
-		   a single stripe; not the whole write */
-		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-			ret = raid56_parity_write(bio, bioc, map_length);
-		} else {
-			ret = raid56_parity_recover(bio, bioc, map_length,
-						    mirror_num, 1);
-		}
+		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+			ret = raid56_parity_write(bio, bioc);
+		else
+			ret = raid56_parity_recover(bio, bioc, mirror_num, 1);
 		goto out_dec;
 	}
 
-- 
2.30.2

