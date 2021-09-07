Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C34024A5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbhIGHoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 03:44:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbhIGHoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 03:44:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1B2E1FD64
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631000574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJi4V5ZFzJxowqQqa2GpI3MQ88yng5YDztmtThCxgss=;
        b=D63Vk4A0XaNASlTh+5Riep4Bi8KYHXveWAfDJj/Ml1iTLNSn3asa/j02suCOBVhINWVXqh
        /O9CJvdLRfWTkavkQVqfiT4O5cfTTdBOr+PvOI3cDV3VoirGKqrSWRUTvfIDiNbfks1pMl
        urMd+ul3R18BGSyZ0yoExANNouR2V4U=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BD220132FD
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iB/BHvwXN2GTFQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 07:42:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: rename struct btrfs_bio to btrfs_physical_bio
Date:   Tue,  7 Sep 2021 15:42:42 +0800
Message-Id: <20210907074242.103438-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907074242.103438-1-wqu@suse.com>
References: <20210907074242.103438-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The structure btrfs_bio records extra mapping info for scrub/raid56 and
real bio submission to each device.

The naming btrfs_bio itself makes no sense, and can be easily confused
with btrfs_io_bio (now renamed to btrfs_logical_bio).

So this patch will rename btrfs_bio to btrfs_physical_bio, and use pbio
to replace bbio for various call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c |   2 +-
 fs/btrfs/extent-tree.c     |  14 +-
 fs/btrfs/extent_io.c       |  18 +--
 fs/btrfs/raid56.c          | 118 ++++++++---------
 fs/btrfs/raid56.h          |   8 +-
 fs/btrfs/reada.c           |  26 ++--
 fs/btrfs/scrub.c           | 116 ++++++++---------
 fs/btrfs/volumes.c         | 256 ++++++++++++++++++-------------------
 fs/btrfs/volumes.h         |  13 +-
 fs/btrfs/zoned.c           |  16 +--
 10 files changed, 295 insertions(+), 292 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 0edb16da44d2..963f21de3112 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1455,7 +1455,7 @@ static int btrfsic_map_block(struct btrfsic_state *state, u64 bytenr, u32 len,
 	struct btrfs_fs_info *fs_info = state->fs_info;
 	int ret;
 	u64 length;
-	struct btrfs_bio *multi = NULL;
+	struct btrfs_physical_bio *multi = NULL;
 	struct btrfs_device *device;
 
 	length = len;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7d03ffa04bce..bcc7532bb104 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1313,11 +1313,11 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 	u64 discarded_bytes = 0;
 	u64 end = bytenr + num_bytes;
 	u64 cur = bytenr;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 
 
 	/*
-	 * Avoid races with device replace and make sure our bbio has devices
+	 * Avoid races with device replace and make sure our pbio has devices
 	 * associated to its stripes that don't go away while we are discarding.
 	 */
 	btrfs_bio_counter_inc_blocked(fs_info);
@@ -1328,7 +1328,7 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 		num_bytes = end - cur;
 		/* Tell the block device(s) that the sectors can be discarded */
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
-				      &num_bytes, &bbio, 0);
+				      &num_bytes, &pbio, 0);
 		/*
 		 * Error can be -ENOMEM, -ENOENT (no such chunk mapping) or
 		 * -EOPNOTSUPP. For any such error, @num_bytes is not updated,
@@ -1337,8 +1337,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 		if (ret < 0)
 			goto out;
 
-		stripe = bbio->stripes;
-		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+		stripe = pbio->stripes;
+		for (i = 0; i < pbio->num_stripes; i++, stripe++) {
 			u64 bytes;
 			struct btrfs_device *device = stripe->dev;
 
@@ -1361,7 +1361,7 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				 * And since there are two loops, explicitly
 				 * go to out to avoid confusion.
 				 */
-				btrfs_put_bbio(bbio);
+				btrfs_put_physical_bio(pbio);
 				goto out;
 			}
 
@@ -1372,7 +1372,7 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 */
 			ret = 0;
 		}
-		btrfs_put_bbio(bbio);
+		btrfs_put_physical_bio(pbio);
 		cur += num_bytes;
 	}
 out:
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7d6eb45c1fdf..0420f348e7c6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2290,7 +2290,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	struct btrfs_device *dev;
 	u64 map_length = 0;
 	u64 sector;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	int ret;
 
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
@@ -2304,7 +2304,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	map_length = length;
 
 	/*
-	 * Avoid races with device replace and make sure our bbio has devices
+	 * Avoid races with device replace and make sure our pbio has devices
 	 * associated to its stripes that don't go away while we are doing the
 	 * read repair operation.
 	 */
@@ -2317,28 +2317,28 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		 * stripe's dev and sector.
 		 */
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-				      &map_length, &bbio, 0);
+				      &map_length, &pbio, 0);
 		if (ret) {
 			btrfs_bio_counter_dec(fs_info);
 			bio_put(bio);
 			return -EIO;
 		}
-		ASSERT(bbio->mirror_num == 1);
+		ASSERT(pbio->mirror_num == 1);
 	} else {
 		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
-				      &map_length, &bbio, mirror_num);
+				      &map_length, &pbio, mirror_num);
 		if (ret) {
 			btrfs_bio_counter_dec(fs_info);
 			bio_put(bio);
 			return -EIO;
 		}
-		BUG_ON(mirror_num != bbio->mirror_num);
+		BUG_ON(mirror_num != pbio->mirror_num);
 	}
 
-	sector = bbio->stripes[bbio->mirror_num - 1].physical >> 9;
+	sector = pbio->stripes[pbio->mirror_num - 1].physical >> 9;
 	bio->bi_iter.bi_sector = sector;
-	dev = bbio->stripes[bbio->mirror_num - 1].dev;
-	btrfs_put_bbio(bbio);
+	dev = pbio->stripes[pbio->mirror_num - 1].dev;
+	btrfs_put_physical_bio(pbio);
 	if (!dev || !dev->bdev ||
 	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
 		btrfs_bio_counter_dec(fs_info);
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4fbb64785930..9611258a8f93 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -61,7 +61,7 @@ enum btrfs_rbio_ops {
 
 struct btrfs_raid_bio {
 	struct btrfs_fs_info *fs_info;
-	struct btrfs_bio *bbio;
+	struct btrfs_physical_bio *pbio;
 
 	/* while we're doing rmw on a stripe
 	 * we put it into a hash table so we can
@@ -271,7 +271,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
  */
 static int rbio_bucket(struct btrfs_raid_bio *rbio)
 {
-	u64 num = rbio->bbio->raid_map[0];
+	u64 num = rbio->pbio->raid_map[0];
 
 	/*
 	 * we shift down quite a bit.  We're using byte
@@ -559,8 +559,8 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	    test_bit(RBIO_CACHE_BIT, &cur->flags))
 		return 0;
 
-	if (last->bbio->raid_map[0] !=
-	    cur->bbio->raid_map[0])
+	if (last->pbio->raid_map[0] !=
+	    cur->pbio->raid_map[0])
 		return 0;
 
 	/* we can't merge with different operations */
@@ -673,7 +673,7 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 
 	spin_lock_irqsave(&h->lock, flags);
 	list_for_each_entry(cur, &h->hash_list, hash_list) {
-		if (cur->bbio->raid_map[0] != rbio->bbio->raid_map[0])
+		if (cur->pbio->raid_map[0] != rbio->pbio->raid_map[0])
 			continue;
 
 		spin_lock(&cur->bio_list_lock);
@@ -838,7 +838,7 @@ static void __free_raid_bio(struct btrfs_raid_bio *rbio)
 		}
 	}
 
-	btrfs_put_bbio(rbio->bbio);
+	btrfs_put_physical_bio(rbio->pbio);
 	kfree(rbio);
 }
 
@@ -906,7 +906,7 @@ static void raid_write_end_io(struct bio *bio)
 
 	/* OK, we have read all the stripes we need to. */
 	max_errors = (rbio->operation == BTRFS_RBIO_PARITY_SCRUB) ?
-		     0 : rbio->bbio->max_errors;
+		     0 : rbio->pbio->max_errors;
 	if (atomic_read(&rbio->error) > max_errors)
 		err = BLK_STS_IOERR;
 
@@ -961,12 +961,12 @@ static unsigned long rbio_nr_pages(unsigned long stripe_len, int nr_stripes)
  * this does not allocate any pages for rbio->pages.
  */
 static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
-					 struct btrfs_bio *bbio,
+					 struct btrfs_physical_bio *pbio,
 					 u64 stripe_len)
 {
 	struct btrfs_raid_bio *rbio;
 	int nr_data = 0;
-	int real_stripes = bbio->num_stripes - bbio->num_tgtdevs;
+	int real_stripes = pbio->num_stripes - pbio->num_tgtdevs;
 	int num_pages = rbio_nr_pages(stripe_len, real_stripes);
 	int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
 	void *p;
@@ -987,7 +987,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&rbio->bio_list_lock);
 	INIT_LIST_HEAD(&rbio->stripe_cache);
 	INIT_LIST_HEAD(&rbio->hash_list);
-	rbio->bbio = bbio;
+	rbio->pbio = pbio;
 	rbio->fs_info = fs_info;
 	rbio->stripe_len = stripe_len;
 	rbio->nr_pages = num_pages;
@@ -1015,9 +1015,9 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	CONSUME_ALLOC(rbio->finish_pbitmap, BITS_TO_LONGS(stripe_npages));
 #undef  CONSUME_ALLOC
 
-	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID5)
+	if (pbio->map_type & BTRFS_BLOCK_GROUP_RAID5)
 		nr_data = real_stripes - 1;
-	else if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID6)
+	else if (pbio->map_type & BTRFS_BLOCK_GROUP_RAID6)
 		nr_data = real_stripes - 2;
 	else
 		BUG();
@@ -1080,7 +1080,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	struct btrfs_bio_stripe *stripe;
 	u64 disk_start;
 
-	stripe = &rbio->bbio->stripes[stripe_nr];
+	stripe = &rbio->pbio->stripes[stripe_nr];
 	disk_start = stripe->physical + (page_index << PAGE_SHIFT);
 
 	/* if the device is missing, just fail this stripe */
@@ -1155,7 +1155,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 		int i = 0;
 
 		start = bio->bi_iter.bi_sector << 9;
-		stripe_offset = start - rbio->bbio->raid_map[0];
+		stripe_offset = start - rbio->pbio->raid_map[0];
 		page_index = stripe_offset >> PAGE_SHIFT;
 
 		if (bio_flagged(bio, BIO_CLONED))
@@ -1179,7 +1179,7 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
  */
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 {
-	struct btrfs_bio *bbio = rbio->bbio;
+	struct btrfs_physical_bio *pbio = rbio->pbio;
 	void **pointers = rbio->finish_pointers;
 	int nr_data = rbio->nr_data;
 	int stripe;
@@ -1284,11 +1284,11 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		}
 	}
 
-	if (likely(!bbio->num_tgtdevs))
+	if (likely(!pbio->num_tgtdevs))
 		goto write_data;
 
 	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-		if (!bbio->tgtdev_map[stripe])
+		if (!pbio->tgtdev_map[stripe])
 			continue;
 
 		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
@@ -1302,7 +1302,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 			}
 
 			ret = rbio_add_io_page(rbio, &bio_list, page,
-					       rbio->bbio->tgtdev_map[stripe],
+					       rbio->pbio->tgtdev_map[stripe],
 					       pagenr, rbio->stripe_len);
 			if (ret)
 				goto cleanup;
@@ -1343,8 +1343,8 @@ static int find_bio_stripe(struct btrfs_raid_bio *rbio,
 
 	physical <<= 9;
 
-	for (i = 0; i < rbio->bbio->num_stripes; i++) {
-		stripe = &rbio->bbio->stripes[i];
+	for (i = 0; i < rbio->pbio->num_stripes; i++) {
+		stripe = &rbio->pbio->stripes[i];
 		if (in_range(physical, stripe->physical, rbio->stripe_len) &&
 		    stripe->dev->bdev && bio->bi_bdev == stripe->dev->bdev) {
 			return i;
@@ -1365,7 +1365,7 @@ static int find_logical_bio_stripe(struct btrfs_raid_bio *rbio,
 	int i;
 
 	for (i = 0; i < rbio->nr_data; i++) {
-		u64 stripe_start = rbio->bbio->raid_map[i];
+		u64 stripe_start = rbio->pbio->raid_map[i];
 
 		if (in_range(logical, stripe_start, rbio->stripe_len))
 			return i;
@@ -1456,7 +1456,7 @@ static void raid_rmw_end_io(struct bio *bio)
 	if (!atomic_dec_and_test(&rbio->stripes_pending))
 		return;
 
-	if (atomic_read(&rbio->error) > rbio->bbio->max_errors)
+	if (atomic_read(&rbio->error) > rbio->pbio->max_errors)
 		goto cleanup;
 
 	/*
@@ -1538,7 +1538,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	}
 
 	/*
-	 * the bbio may be freed once we submit the last bio.  Make sure
+	 * the pbio may be freed once we submit the last bio.  Make sure
 	 * not to touch it after that
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
@@ -1720,16 +1720,16 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
  * our main entry point for writes from the rest of the FS.
  */
 int raid56_parity_write(struct btrfs_fs_info *fs_info, struct bio *bio,
-			struct btrfs_bio *bbio, u64 stripe_len)
+			struct btrfs_physical_bio *pbio, u64 stripe_len)
 {
 	struct btrfs_raid_bio *rbio;
 	struct btrfs_plug_cb *plug = NULL;
 	struct blk_plug_cb *cb;
 	int ret;
 
-	rbio = alloc_rbio(fs_info, bbio, stripe_len);
+	rbio = alloc_rbio(fs_info, pbio, stripe_len);
 	if (IS_ERR(rbio)) {
-		btrfs_put_bbio(bbio);
+		btrfs_put_physical_bio(pbio);
 		return PTR_ERR(rbio);
 	}
 	bio_list_add(&rbio->bio_list, bio);
@@ -1842,7 +1842,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 		}
 
 		/* all raid6 handling here */
-		if (rbio->bbio->map_type & BTRFS_BLOCK_GROUP_RAID6) {
+		if (rbio->pbio->map_type & BTRFS_BLOCK_GROUP_RAID6) {
 			/*
 			 * single failure, rebuild from parity raid5
 			 * style
@@ -1874,8 +1874,8 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 			 * here due to a crc mismatch and we can't give them the
 			 * data they want
 			 */
-			if (rbio->bbio->raid_map[failb] == RAID6_Q_STRIPE) {
-				if (rbio->bbio->raid_map[faila] ==
+			if (rbio->pbio->raid_map[failb] == RAID6_Q_STRIPE) {
+				if (rbio->pbio->raid_map[faila] ==
 				    RAID5_P_STRIPE) {
 					err = BLK_STS_IOERR;
 					goto cleanup;
@@ -1887,7 +1887,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 				goto pstripe;
 			}
 
-			if (rbio->bbio->raid_map[failb] == RAID5_P_STRIPE) {
+			if (rbio->pbio->raid_map[failb] == RAID5_P_STRIPE) {
 				raid6_datap_recov(rbio->real_stripes,
 						  PAGE_SIZE, faila, pointers);
 			} else {
@@ -2006,7 +2006,7 @@ static void raid_recover_end_io(struct bio *bio)
 	if (!atomic_dec_and_test(&rbio->stripes_pending))
 		return;
 
-	if (atomic_read(&rbio->error) > rbio->bbio->max_errors)
+	if (atomic_read(&rbio->error) > rbio->pbio->max_errors)
 		rbio_orig_end_io(rbio, BLK_STS_IOERR);
 	else
 		__raid_recover_end_io(rbio);
@@ -2074,7 +2074,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		 * were up to date, or we might have no bios to read because
 		 * the devices were gone.
 		 */
-		if (atomic_read(&rbio->error) <= rbio->bbio->max_errors) {
+		if (atomic_read(&rbio->error) <= rbio->pbio->max_errors) {
 			__raid_recover_end_io(rbio);
 			return 0;
 		} else {
@@ -2083,7 +2083,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	}
 
 	/*
-	 * the bbio may be freed once we submit the last bio.  Make sure
+	 * the pbio may be freed once we submit the last bio.  Make sure
 	 * not to touch it after that
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
@@ -2117,21 +2117,21 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
  * of the drive.
  */
 int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_bio *bbio, u64 stripe_len,
+			  struct btrfs_physical_bio *pbio, u64 stripe_len,
 			  int mirror_num, int generic_io)
 {
 	struct btrfs_raid_bio *rbio;
 	int ret;
 
 	if (generic_io) {
-		ASSERT(bbio->mirror_num == mirror_num);
+		ASSERT(pbio->mirror_num == mirror_num);
 		btrfs_logical_bio(bio)->mirror_num = mirror_num;
 	}
 
-	rbio = alloc_rbio(fs_info, bbio, stripe_len);
+	rbio = alloc_rbio(fs_info, pbio, stripe_len);
 	if (IS_ERR(rbio)) {
 		if (generic_io)
-			btrfs_put_bbio(bbio);
+			btrfs_put_physical_bio(pbio);
 		return PTR_ERR(rbio);
 	}
 
@@ -2142,11 +2142,11 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
 	if (rbio->faila == -1) {
 		btrfs_warn(fs_info,
-	"%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bbio has map_type %llu)",
+	"%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, pbio has map_type %llu)",
 			   __func__, bio->bi_iter.bi_sector << 9,
-			   (u64)bio->bi_iter.bi_size, bbio->map_type);
+			   (u64)bio->bi_iter.bi_size, pbio->map_type);
 		if (generic_io)
-			btrfs_put_bbio(bbio);
+			btrfs_put_physical_bio(pbio);
 		kfree(rbio);
 		return -EIO;
 	}
@@ -2155,7 +2155,7 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
 		btrfs_bio_counter_inc_noblocked(fs_info);
 		rbio->generic_bio_cnt = 1;
 	} else {
-		btrfs_get_bbio(bbio);
+		btrfs_get_physical_bio(pbio);
 	}
 
 	/*
@@ -2214,7 +2214,7 @@ static void read_rebuild_work(struct btrfs_work *work)
 /*
  * The following code is used to scrub/replace the parity stripe
  *
- * Caller must have already increased bio_counter for getting @bbio.
+ * Caller must have already increased bio_counter for getting @pbio.
  *
  * Note: We need make sure all the pages that add into the scrub/replace
  * raid bio are correct and not be changed during the scrub/replace. That
@@ -2223,14 +2223,14 @@ static void read_rebuild_work(struct btrfs_work *work)
 
 struct btrfs_raid_bio *
 raid56_parity_alloc_scrub_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			       struct btrfs_bio *bbio, u64 stripe_len,
+			       struct btrfs_physical_bio *pbio, u64 stripe_len,
 			       struct btrfs_device *scrub_dev,
 			       unsigned long *dbitmap, int stripe_nsectors)
 {
 	struct btrfs_raid_bio *rbio;
 	int i;
 
-	rbio = alloc_rbio(fs_info, bbio, stripe_len);
+	rbio = alloc_rbio(fs_info, pbio, stripe_len);
 	if (IS_ERR(rbio))
 		return NULL;
 	bio_list_add(&rbio->bio_list, bio);
@@ -2242,12 +2242,12 @@ raid56_parity_alloc_scrub_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	rbio->operation = BTRFS_RBIO_PARITY_SCRUB;
 
 	/*
-	 * After mapping bbio with BTRFS_MAP_WRITE, parities have been sorted
+	 * After mapping pbio with BTRFS_MAP_WRITE, parities have been sorted
 	 * to the end position, so this search can start from the first parity
 	 * stripe.
 	 */
 	for (i = rbio->nr_data; i < rbio->real_stripes; i++) {
-		if (bbio->stripes[i].dev == scrub_dev) {
+		if (pbio->stripes[i].dev == scrub_dev) {
 			rbio->scrubp = i;
 			break;
 		}
@@ -2260,7 +2260,7 @@ raid56_parity_alloc_scrub_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	bitmap_copy(rbio->dbitmap, dbitmap, stripe_nsectors);
 
 	/*
-	 * We have already increased bio_counter when getting bbio, record it
+	 * We have already increased bio_counter when getting pbio, record it
 	 * so we can free it at rbio_orig_end_io().
 	 */
 	rbio->generic_bio_cnt = 1;
@@ -2275,10 +2275,10 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 	int stripe_offset;
 	int index;
 
-	ASSERT(logical >= rbio->bbio->raid_map[0]);
-	ASSERT(logical + PAGE_SIZE <= rbio->bbio->raid_map[0] +
+	ASSERT(logical >= rbio->pbio->raid_map[0]);
+	ASSERT(logical + PAGE_SIZE <= rbio->pbio->raid_map[0] +
 				rbio->stripe_len * rbio->nr_data);
-	stripe_offset = (int)(logical - rbio->bbio->raid_map[0]);
+	stripe_offset = (int)(logical - rbio->pbio->raid_map[0]);
 	index = stripe_offset >> PAGE_SHIFT;
 	rbio->bio_pages[index] = page;
 }
@@ -2312,7 +2312,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 					 int need_check)
 {
-	struct btrfs_bio *bbio = rbio->bbio;
+	struct btrfs_physical_bio *pbio = rbio->pbio;
 	void **pointers = rbio->finish_pointers;
 	unsigned long *pbitmap = rbio->finish_pbitmap;
 	int nr_data = rbio->nr_data;
@@ -2335,7 +2335,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	else
 		BUG();
 
-	if (bbio->num_tgtdevs && bbio->tgtdev_map[rbio->scrubp]) {
+	if (pbio->num_tgtdevs && pbio->tgtdev_map[rbio->scrubp]) {
 		is_replace = 1;
 		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_npages);
 	}
@@ -2435,7 +2435,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
 		ret = rbio_add_io_page(rbio, &bio_list, page,
-				       bbio->tgtdev_map[rbio->scrubp],
+				       pbio->tgtdev_map[rbio->scrubp],
 				       pagenr, rbio->stripe_len);
 		if (ret)
 			goto cleanup;
@@ -2483,7 +2483,7 @@ static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
  */
 static void validate_rbio_for_parity_scrub(struct btrfs_raid_bio *rbio)
 {
-	if (atomic_read(&rbio->error) > rbio->bbio->max_errors)
+	if (atomic_read(&rbio->error) > rbio->pbio->max_errors)
 		goto cleanup;
 
 	if (rbio->faila >= 0 || rbio->failb >= 0) {
@@ -2504,7 +2504,7 @@ static void validate_rbio_for_parity_scrub(struct btrfs_raid_bio *rbio)
 		 * the data, so the capability of the repair is declined.
 		 * (In the case of RAID5, we can not repair anything)
 		 */
-		if (dfail > rbio->bbio->max_errors - 1)
+		if (dfail > rbio->pbio->max_errors - 1)
 			goto cleanup;
 
 		/*
@@ -2625,7 +2625,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	}
 
 	/*
-	 * the bbio may be freed once we submit the last bio.  Make sure
+	 * the pbio may be freed once we submit the last bio.  Make sure
 	 * not to touch it after that
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
@@ -2671,11 +2671,11 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 
 struct btrfs_raid_bio *
 raid56_alloc_missing_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_bio *bbio, u64 length)
+			  struct btrfs_physical_bio *pbio, u64 length)
 {
 	struct btrfs_raid_bio *rbio;
 
-	rbio = alloc_rbio(fs_info, bbio, length);
+	rbio = alloc_rbio(fs_info, pbio, length);
 	if (IS_ERR(rbio))
 		return NULL;
 
@@ -2695,7 +2695,7 @@ raid56_alloc_missing_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	}
 
 	/*
-	 * When we get bbio, we have already increased bio_counter, record it
+	 * When we get pbio, we have already increased bio_counter, record it
 	 * so we can free it at rbio_orig_end_io()
 	 */
 	rbio->generic_bio_cnt = 1;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 2503485db859..68e334db03ca 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -31,24 +31,24 @@ struct btrfs_raid_bio;
 struct btrfs_device;
 
 int raid56_parity_recover(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_bio *bbio, u64 stripe_len,
+			  struct btrfs_physical_bio *pbio, u64 stripe_len,
 			  int mirror_num, int generic_io);
 int raid56_parity_write(struct btrfs_fs_info *fs_info, struct bio *bio,
-			       struct btrfs_bio *bbio, u64 stripe_len);
+			       struct btrfs_physical_bio *pbio, u64 stripe_len);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    u64 logical);
 
 struct btrfs_raid_bio *
 raid56_parity_alloc_scrub_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			       struct btrfs_bio *bbio, u64 stripe_len,
+			       struct btrfs_physical_bio *pbio, u64 stripe_len,
 			       struct btrfs_device *scrub_dev,
 			       unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
 struct btrfs_raid_bio *
 raid56_alloc_missing_rbio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			  struct btrfs_bio *bbio, u64 length);
+			  struct btrfs_physical_bio *pbio, u64 length);
 void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 06713a8fe26b..0dabe75045ae 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -227,7 +227,7 @@ int btree_readahead_hook(struct extent_buffer *eb, int err)
 }
 
 static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
-					  struct btrfs_bio *bbio)
+					  struct btrfs_physical_bio *pbio)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
 	int ret;
@@ -275,11 +275,11 @@ static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
 	kref_init(&zone->refcnt);
 	zone->elems = 0;
 	zone->device = dev; /* our device always sits at index 0 */
-	for (i = 0; i < bbio->num_stripes; ++i) {
+	for (i = 0; i < pbio->num_stripes; ++i) {
 		/* bounds have already been checked */
-		zone->devs[i] = bbio->stripes[i].dev;
+		zone->devs[i] = pbio->stripes[i].dev;
 	}
-	zone->ndevs = bbio->num_stripes;
+	zone->ndevs = pbio->num_stripes;
 
 	spin_lock(&fs_info->reada_lock);
 	ret = radix_tree_insert(&dev->reada_zones,
@@ -309,7 +309,7 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct reada_extent *re = NULL;
 	struct reada_extent *re_exist = NULL;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	struct btrfs_device *dev;
 	struct btrfs_device *prev_dev;
 	u64 length;
@@ -345,28 +345,28 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 	 */
 	length = fs_info->nodesize;
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			&length, &bbio, 0);
-	if (ret || !bbio || length < fs_info->nodesize)
+			&length, &pbio, 0);
+	if (ret || !pbio || length < fs_info->nodesize)
 		goto error;
 
-	if (bbio->num_stripes > BTRFS_MAX_MIRRORS) {
+	if (pbio->num_stripes > BTRFS_MAX_MIRRORS) {
 		btrfs_err(fs_info,
 			   "readahead: more than %d copies not supported",
 			   BTRFS_MAX_MIRRORS);
 		goto error;
 	}
 
-	real_stripes = bbio->num_stripes - bbio->num_tgtdevs;
+	real_stripes = pbio->num_stripes - pbio->num_tgtdevs;
 	for (nzones = 0; nzones < real_stripes; ++nzones) {
 		struct reada_zone *zone;
 
-		dev = bbio->stripes[nzones].dev;
+		dev = pbio->stripes[nzones].dev;
 
 		/* cannot read ahead on missing device. */
 		if (!dev->bdev)
 			continue;
 
-		zone = reada_find_zone(dev, logical, bbio);
+		zone = reada_find_zone(dev, logical, pbio);
 		if (!zone)
 			continue;
 
@@ -464,7 +464,7 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 	if (!have_zone)
 		goto error;
 
-	btrfs_put_bbio(bbio);
+	btrfs_put_physical_bio(pbio);
 	return re;
 
 error:
@@ -488,7 +488,7 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 		kref_put(&zone->refcnt, reada_zone_release);
 		spin_unlock(&fs_info->reada_lock);
 	}
-	btrfs_put_bbio(bbio);
+	btrfs_put_physical_bio(pbio);
 	kfree(re);
 	return re_exist;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ae44b36a3a63..d42e968032a2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -57,7 +57,7 @@ struct scrub_ctx;
 
 struct scrub_recover {
 	refcount_t		refs;
-	struct btrfs_bio	*bbio;
+	struct btrfs_physical_bio *pbio;
 	u64			map_length;
 };
 
@@ -254,7 +254,7 @@ static void scrub_put_ctx(struct scrub_ctx *sctx);
 static inline int scrub_is_page_on_raid56(struct scrub_page *spage)
 {
 	return spage->recover &&
-	       (spage->recover->bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+	       (spage->recover->pbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 }
 
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
@@ -798,7 +798,7 @@ static inline void scrub_put_recover(struct btrfs_fs_info *fs_info,
 {
 	if (refcount_dec_and_test(&recover->refs)) {
 		btrfs_bio_counter_dec(fs_info);
-		btrfs_put_bbio(recover->bbio);
+		btrfs_put_physical_bio(recover->pbio);
 		kfree(recover);
 	}
 }
@@ -1027,8 +1027,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			sblock_other = sblocks_for_recheck + mirror_index;
 		} else {
 			struct scrub_recover *r = sblock_bad->pagev[0]->recover;
-			int max_allowed = r->bbio->num_stripes -
-						r->bbio->num_tgtdevs;
+			int max_allowed = r->pbio->num_stripes -
+						r->pbio->num_tgtdevs;
 
 			if (mirror_index >= max_allowed)
 				break;
@@ -1218,14 +1218,14 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	return 0;
 }
 
-static inline int scrub_nr_raid_mirrors(struct btrfs_bio *bbio)
+static inline int scrub_nr_raid_mirrors(struct btrfs_physical_bio *pbio)
 {
-	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID5)
+	if (pbio->map_type & BTRFS_BLOCK_GROUP_RAID5)
 		return 2;
-	else if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID6)
+	else if (pbio->map_type & BTRFS_BLOCK_GROUP_RAID6)
 		return 3;
 	else
-		return (int)bbio->num_stripes;
+		return (int)pbio->num_stripes;
 }
 
 static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
@@ -1269,7 +1269,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 	u64 flags = original_sblock->pagev[0]->flags;
 	u64 have_csum = original_sblock->pagev[0]->have_csum;
 	struct scrub_recover *recover;
-	struct btrfs_bio *bbio;
+	struct btrfs_physical_bio *pbio;
 	u64 sublen;
 	u64 mapped_length;
 	u64 stripe_offset;
@@ -1288,7 +1288,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 	while (length > 0) {
 		sublen = min_t(u64, length, fs_info->sectorsize);
 		mapped_length = sublen;
-		bbio = NULL;
+		pbio = NULL;
 
 		/*
 		 * With a length of sectorsize, each returned stripe represents
@@ -1296,27 +1296,27 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 		 */
 		btrfs_bio_counter_inc_blocked(fs_info);
 		ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				logical, &mapped_length, &bbio);
-		if (ret || !bbio || mapped_length < sublen) {
-			btrfs_put_bbio(bbio);
+				logical, &mapped_length, &pbio);
+		if (ret || !pbio || mapped_length < sublen) {
+			btrfs_put_physical_bio(pbio);
 			btrfs_bio_counter_dec(fs_info);
 			return -EIO;
 		}
 
 		recover = kzalloc(sizeof(struct scrub_recover), GFP_NOFS);
 		if (!recover) {
-			btrfs_put_bbio(bbio);
+			btrfs_put_physical_bio(pbio);
 			btrfs_bio_counter_dec(fs_info);
 			return -ENOMEM;
 		}
 
 		refcount_set(&recover->refs, 1);
-		recover->bbio = bbio;
+		recover->pbio = pbio;
 		recover->map_length = mapped_length;
 
 		BUG_ON(page_index >= SCRUB_MAX_PAGES_PER_BLOCK);
 
-		nmirrors = min(scrub_nr_raid_mirrors(bbio), BTRFS_MAX_MIRRORS);
+		nmirrors = min(scrub_nr_raid_mirrors(pbio), BTRFS_MAX_MIRRORS);
 
 		for (mirror_index = 0; mirror_index < nmirrors;
 		     mirror_index++) {
@@ -1348,17 +1348,17 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				       sctx->fs_info->csum_size);
 
 			scrub_stripe_index_and_offset(logical,
-						      bbio->map_type,
-						      bbio->raid_map,
+						      pbio->map_type,
+						      pbio->raid_map,
 						      mapped_length,
-						      bbio->num_stripes -
-						      bbio->num_tgtdevs,
+						      pbio->num_stripes -
+						      pbio->num_tgtdevs,
 						      mirror_index,
 						      &stripe_index,
 						      &stripe_offset);
-			spage->physical = bbio->stripes[stripe_index].physical +
+			spage->physical = pbio->stripes[stripe_index].physical +
 					 stripe_offset;
-			spage->dev = bbio->stripes[stripe_index].dev;
+			spage->dev = pbio->stripes[stripe_index].dev;
 
 			BUG_ON(page_index >= original_sblock->page_count);
 			spage->physical_for_dev_replace =
@@ -1401,7 +1401,7 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 	bio->bi_end_io = scrub_bio_wait_endio;
 
 	mirror_num = spage->sblock->pagev[0]->mirror_num;
-	ret = raid56_parity_recover(fs_info, bio, spage->recover->bbio,
+	ret = raid56_parity_recover(fs_info, bio, spage->recover->pbio,
 				    spage->recover->map_length,
 				    mirror_num, 0);
 	if (ret)
@@ -2203,7 +2203,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	u64 length = sblock->page_count * PAGE_SIZE;
 	u64 logical = sblock->pagev[0]->logical;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	struct bio *bio;
 	struct btrfs_raid_bio *rbio;
 	int ret;
@@ -2211,19 +2211,19 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			&length, &bbio);
-	if (ret || !bbio || !bbio->raid_map)
-		goto bbio_out;
+			&length, &pbio);
+	if (ret || !pbio || !pbio->raid_map)
+		goto pbio_out;
 
 	if (WARN_ON(!sctx->is_dev_replace ||
-		    !(bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK))) {
+		    !(pbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK))) {
 		/*
 		 * We shouldn't be scrubbing a missing device. Even for dev
 		 * replace, we should only get here for RAID 5/6. We either
 		 * managed to mount something with no mirrors remaining or
 		 * there's a bug in scrub_remap_extent()/btrfs_map_block().
 		 */
-		goto bbio_out;
+		goto pbio_out;
 	}
 
 	bio = btrfs_logical_bio_alloc_iovecs(0);
@@ -2231,7 +2231,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
 
-	rbio = raid56_alloc_missing_rbio(fs_info, bio, bbio, length);
+	rbio = raid56_alloc_missing_rbio(fs_info, bio, pbio, length);
 	if (!rbio)
 		goto rbio_out;
 
@@ -2249,9 +2249,9 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 
 rbio_out:
 	bio_put(bio);
-bbio_out:
+pbio_out:
 	btrfs_bio_counter_dec(fs_info);
-	btrfs_put_bbio(bbio);
+	btrfs_put_physical_bio(pbio);
 	spin_lock(&sctx->stat_lock);
 	sctx->stat.malloc_errors++;
 	spin_unlock(&sctx->stat_lock);
@@ -2826,7 +2826,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct bio *bio;
 	struct btrfs_raid_bio *rbio;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	u64 length;
 	int ret;
 
@@ -2838,16 +2838,16 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_WRITE, sparity->logic_start,
-			       &length, &bbio);
-	if (ret || !bbio || !bbio->raid_map)
-		goto bbio_out;
+			       &length, &pbio);
+	if (ret || !pbio || !pbio->raid_map)
+		goto pbio_out;
 
 	bio = btrfs_logical_bio_alloc_iovecs(0);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
 
-	rbio = raid56_parity_alloc_scrub_rbio(fs_info, bio, bbio,
+	rbio = raid56_parity_alloc_scrub_rbio(fs_info, bio, pbio,
 					      length, sparity->scrub_dev,
 					      sparity->dbitmap,
 					      sparity->nsectors);
@@ -2860,9 +2860,9 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 
 rbio_out:
 	bio_put(bio);
-bbio_out:
+pbio_out:
 	btrfs_bio_counter_dec(fs_info);
-	btrfs_put_bbio(bbio);
+	btrfs_put_physical_bio(pbio);
 	bitmap_or(sparity->ebitmap, sparity->ebitmap, sparity->dbitmap,
 		  sparity->nsectors);
 	spin_lock(&sctx->stat_lock);
@@ -2901,7 +2901,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_root *csum_root = fs_info->csum_root;
 	struct btrfs_extent_item *extent;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	u64 flags;
 	int ret;
 	int slot;
@@ -3044,22 +3044,22 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						       extent_len);
 
 			mapped_length = extent_len;
-			bbio = NULL;
+			pbio = NULL;
 			ret = btrfs_map_block(fs_info, BTRFS_MAP_READ,
-					extent_logical, &mapped_length, &bbio,
+					extent_logical, &mapped_length, &pbio,
 					0);
 			if (!ret) {
-				if (!bbio || mapped_length < extent_len)
+				if (!pbio || mapped_length < extent_len)
 					ret = -EIO;
 			}
 			if (ret) {
-				btrfs_put_bbio(bbio);
+				btrfs_put_physical_bio(pbio);
 				goto out;
 			}
-			extent_physical = bbio->stripes[0].physical;
-			extent_mirror_num = bbio->mirror_num;
-			extent_dev = bbio->stripes[0].dev;
-			btrfs_put_bbio(bbio);
+			extent_physical = pbio->stripes[0].physical;
+			extent_mirror_num = pbio->mirror_num;
+			extent_dev = pbio->stripes[0].dev;
+			btrfs_put_physical_bio(pbio);
 
 			ret = btrfs_lookup_csums_range(csum_root,
 						extent_logical,
@@ -4309,20 +4309,20 @@ static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
 			       int *extent_mirror_num)
 {
 	u64 mapped_length;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	int ret;
 
 	mapped_length = extent_len;
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
-			      &mapped_length, &bbio, 0);
-	if (ret || !bbio || mapped_length < extent_len ||
-	    !bbio->stripes[0].dev->bdev) {
-		btrfs_put_bbio(bbio);
+			      &mapped_length, &pbio, 0);
+	if (ret || !pbio || mapped_length < extent_len ||
+	    !pbio->stripes[0].dev->bdev) {
+		btrfs_put_physical_bio(pbio);
 		return;
 	}
 
-	*extent_physical = bbio->stripes[0].physical;
-	*extent_mirror_num = bbio->mirror_num;
-	*extent_dev = bbio->stripes[0].dev;
-	btrfs_put_bbio(bbio);
+	*extent_physical = pbio->stripes[0].physical;
+	*extent_mirror_num = pbio->mirror_num;
+	*extent_dev = pbio->stripes[0].dev;
+	btrfs_put_physical_bio(pbio);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 77086b9c7736..865e9fd9eaa0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -250,7 +250,7 @@ static void btrfs_dev_stat_print_on_load(struct btrfs_device *device);
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			     enum btrfs_map_op op,
 			     u64 logical, u64 *length,
-			     struct btrfs_bio **bbio_ret,
+			     struct btrfs_physical_bio **pbio_ret,
 			     int mirror_num, int need_raid_map);
 
 /*
@@ -5767,7 +5767,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 }
 
 /* Bubble-sort the stripe set to put the parity/syndrome stripes last */
-static void sort_parity_stripes(struct btrfs_bio *bbio, int num_stripes)
+static void sort_parity_stripes(struct btrfs_physical_bio *pbio,
+				int num_stripes)
 {
 	int i;
 	int again = 1;
@@ -5776,20 +5777,21 @@ static void sort_parity_stripes(struct btrfs_bio *bbio, int num_stripes)
 		again = 0;
 		for (i = 0; i < num_stripes - 1; i++) {
 			/* Swap if parity is on a smaller index */
-			if (bbio->raid_map[i] > bbio->raid_map[i + 1]) {
-				swap(bbio->stripes[i], bbio->stripes[i + 1]);
-				swap(bbio->raid_map[i], bbio->raid_map[i + 1]);
+			if (pbio->raid_map[i] > pbio->raid_map[i + 1]) {
+				swap(pbio->stripes[i], pbio->stripes[i + 1]);
+				swap(pbio->raid_map[i], pbio->raid_map[i + 1]);
 				again = 1;
 			}
 		}
 	}
 }
 
-static struct btrfs_bio *alloc_btrfs_bio(int total_stripes, int real_stripes)
+static struct btrfs_physical_bio *alloc_physical_bio(int total_stripes,
+						     int real_stripes)
 {
-	struct btrfs_bio *bbio = kzalloc(
+	struct btrfs_physical_bio *pbio = kzalloc(
 		 /* the size of the btrfs_bio */
-		sizeof(struct btrfs_bio) +
+		sizeof(struct btrfs_physical_bio) +
 		/* plus the variable array for the stripes */
 		sizeof(struct btrfs_bio_stripe) * (total_stripes) +
 		/* plus the variable array for the tgt dev */
@@ -5801,27 +5803,27 @@ static struct btrfs_bio *alloc_btrfs_bio(int total_stripes, int real_stripes)
 		sizeof(u64) * (total_stripes),
 		GFP_NOFS|__GFP_NOFAIL);
 
-	atomic_set(&bbio->error, 0);
-	refcount_set(&bbio->refs, 1);
+	atomic_set(&pbio->error, 0);
+	refcount_set(&pbio->refs, 1);
 
-	bbio->tgtdev_map = (int *)(bbio->stripes + total_stripes);
-	bbio->raid_map = (u64 *)(bbio->tgtdev_map + real_stripes);
+	pbio->tgtdev_map = (int *)(pbio->stripes + total_stripes);
+	pbio->raid_map = (u64 *)(pbio->tgtdev_map + real_stripes);
 
-	return bbio;
+	return pbio;
 }
 
-void btrfs_get_bbio(struct btrfs_bio *bbio)
+void btrfs_get_physical_bio(struct btrfs_physical_bio *pbio)
 {
-	WARN_ON(!refcount_read(&bbio->refs));
-	refcount_inc(&bbio->refs);
+	WARN_ON(!refcount_read(&pbio->refs));
+	refcount_inc(&pbio->refs);
 }
 
-void btrfs_put_bbio(struct btrfs_bio *bbio)
+void btrfs_put_physical_bio(struct btrfs_physical_bio *pbio)
 {
-	if (!bbio)
+	if (!pbio)
 		return;
-	if (refcount_dec_and_test(&bbio->refs))
-		kfree(bbio);
+	if (refcount_dec_and_test(&pbio->refs))
+		kfree(pbio);
 }
 
 /* can REQ_OP_DISCARD be sent with other REQ like REQ_OP_WRITE? */
@@ -5831,11 +5833,11 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
  */
 static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 					 u64 logical, u64 *length_ret,
-					 struct btrfs_bio **bbio_ret)
+					 struct btrfs_physical_bio **pbio_ret)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
-	struct btrfs_bio *bbio;
+	struct btrfs_physical_bio *pbio;
 	u64 length = *length_ret;
 	u64 offset;
 	u64 stripe_nr;
@@ -5854,8 +5856,8 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	int i;
 
-	/* discard always return a bbio */
-	ASSERT(bbio_ret);
+	/* discard always return a pbio */
+	ASSERT(pbio_ret);
 
 	em = btrfs_get_chunk_map(fs_info, logical, length);
 	if (IS_ERR(em))
@@ -5918,26 +5920,25 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 					&stripe_index);
 	}
 
-	bbio = alloc_btrfs_bio(num_stripes, 0);
-	if (!bbio) {
+	pbio = alloc_physical_bio(num_stripes, 0);
+	if (!pbio) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		bbio->stripes[i].physical =
+		pbio->stripes[i].physical =
 			map->stripes[stripe_index].physical +
 			stripe_offset + stripe_nr * map->stripe_len;
-		bbio->stripes[i].dev = map->stripes[stripe_index].dev;
+		pbio->stripes[i].dev = map->stripes[stripe_index].dev;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
 				 BTRFS_BLOCK_GROUP_RAID10)) {
-			bbio->stripes[i].length = stripes_per_dev *
+			pbio->stripes[i].length = stripes_per_dev *
 				map->stripe_len;
 
 			if (i / sub_stripes < remaining_stripes)
-				bbio->stripes[i].length +=
-					map->stripe_len;
+				pbio->stripes[i].length += map->stripe_len;
 
 			/*
 			 * Special for the first stripe and
@@ -5948,19 +5949,16 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 			 *    off     end_off
 			 */
 			if (i < sub_stripes)
-				bbio->stripes[i].length -=
-					stripe_offset;
+				pbio->stripes[i].length -= stripe_offset;
 
 			if (stripe_index >= last_stripe &&
-			    stripe_index <= (last_stripe +
-					     sub_stripes - 1))
-				bbio->stripes[i].length -=
-					stripe_end_offset;
+			    stripe_index <= (last_stripe + sub_stripes - 1))
+				pbio->stripes[i].length -= stripe_end_offset;
 
 			if (i == sub_stripes - 1)
 				stripe_offset = 0;
 		} else {
-			bbio->stripes[i].length = length;
+			pbio->stripes[i].length = length;
 		}
 
 		stripe_index++;
@@ -5970,9 +5968,9 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	*bbio_ret = bbio;
-	bbio->map_type = map->type;
-	bbio->num_stripes = num_stripes;
+	*pbio_ret = pbio;
+	pbio->map_type = map->type;
+	pbio->num_stripes = num_stripes;
 out:
 	free_extent_map(em);
 	return ret;
@@ -5996,7 +5994,7 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 					 u64 srcdev_devid, int *mirror_num,
 					 u64 *physical)
 {
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	int num_stripes;
 	int index_srcdev = 0;
 	int found = 0;
@@ -6005,20 +6003,20 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	ret = __btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
-				logical, &length, &bbio, 0, 0);
+				logical, &length, &pbio, 0, 0);
 	if (ret) {
-		ASSERT(bbio == NULL);
+		ASSERT(pbio == NULL);
 		return ret;
 	}
 
-	num_stripes = bbio->num_stripes;
+	num_stripes = pbio->num_stripes;
 	if (*mirror_num > num_stripes) {
 		/*
 		 * BTRFS_MAP_GET_READ_MIRRORS does not contain this mirror,
 		 * that means that the requested area is not left of the left
 		 * cursor
 		 */
-		btrfs_put_bbio(bbio);
+		btrfs_put_physical_bio(pbio);
 		return -EIO;
 	}
 
@@ -6028,7 +6026,7 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	 * pointer to the one of the target drive.
 	 */
 	for (i = 0; i < num_stripes; i++) {
-		if (bbio->stripes[i].dev->devid != srcdev_devid)
+		if (pbio->stripes[i].dev->devid != srcdev_devid)
 			continue;
 
 		/*
@@ -6036,15 +6034,15 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 		 * mirror with the lowest physical address
 		 */
 		if (found &&
-		    physical_of_found <= bbio->stripes[i].physical)
+		    physical_of_found <= pbio->stripes[i].physical)
 			continue;
 
 		index_srcdev = i;
 		found = 1;
-		physical_of_found = bbio->stripes[i].physical;
+		physical_of_found = pbio->stripes[i].physical;
 	}
 
-	btrfs_put_bbio(bbio);
+	btrfs_put_physical_bio(pbio);
 
 	ASSERT(found);
 	if (!found)
@@ -6075,12 +6073,12 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 }
 
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
-				      struct btrfs_bio **bbio_ret,
+				      struct btrfs_physical_bio **pbio_ret,
 				      struct btrfs_dev_replace *dev_replace,
 				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
-	struct btrfs_bio *bbio = *bbio_ret;
+	struct btrfs_physical_bio *pbio = *pbio_ret;
 	u64 srcdev_devid = dev_replace->srcdev->devid;
 	int tgtdev_indexes = 0;
 	int num_stripes = *num_stripes_ret;
@@ -6110,17 +6108,17 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 		 */
 		index_where_to_add = num_stripes;
 		for (i = 0; i < num_stripes; i++) {
-			if (bbio->stripes[i].dev->devid == srcdev_devid) {
+			if (pbio->stripes[i].dev->devid == srcdev_devid) {
 				/* write to new disk, too */
 				struct btrfs_bio_stripe *new =
-					bbio->stripes + index_where_to_add;
+					pbio->stripes + index_where_to_add;
 				struct btrfs_bio_stripe *old =
-					bbio->stripes + i;
+					pbio->stripes + i;
 
 				new->physical = old->physical;
 				new->length = old->length;
 				new->dev = dev_replace->tgtdev;
-				bbio->tgtdev_map[i] = index_where_to_add;
+				pbio->tgtdev_map[i] = index_where_to_add;
 				index_where_to_add++;
 				max_errors++;
 				tgtdev_indexes++;
@@ -6140,7 +6138,7 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 		 * full copy of the source drive.
 		 */
 		for (i = 0; i < num_stripes; i++) {
-			if (bbio->stripes[i].dev->devid == srcdev_devid) {
+			if (pbio->stripes[i].dev->devid == srcdev_devid) {
 				/*
 				 * In case of DUP, in order to keep it simple,
 				 * only add the mirror with the lowest physical
@@ -6148,22 +6146,22 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				 */
 				if (found &&
 				    physical_of_found <=
-				     bbio->stripes[i].physical)
+				     pbio->stripes[i].physical)
 					continue;
 				index_srcdev = i;
 				found = 1;
-				physical_of_found = bbio->stripes[i].physical;
+				physical_of_found = pbio->stripes[i].physical;
 			}
 		}
 		if (found) {
 			struct btrfs_bio_stripe *tgtdev_stripe =
-				bbio->stripes + num_stripes;
+				pbio->stripes + num_stripes;
 
 			tgtdev_stripe->physical = physical_of_found;
 			tgtdev_stripe->length =
-				bbio->stripes[index_srcdev].length;
+				pbio->stripes[index_srcdev].length;
 			tgtdev_stripe->dev = dev_replace->tgtdev;
-			bbio->tgtdev_map[index_srcdev] = num_stripes;
+			pbio->tgtdev_map[index_srcdev] = num_stripes;
 
 			tgtdev_indexes++;
 			num_stripes++;
@@ -6172,8 +6170,8 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 
 	*num_stripes_ret = num_stripes;
 	*max_errors_ret = max_errors;
-	bbio->num_tgtdevs = tgtdev_indexes;
-	*bbio_ret = bbio;
+	pbio->num_tgtdevs = tgtdev_indexes;
+	*pbio_ret = pbio;
 }
 
 static bool need_full_stripe(enum btrfs_map_op op)
@@ -6276,7 +6274,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			     enum btrfs_map_op op,
 			     u64 logical, u64 *length,
-			     struct btrfs_bio **bbio_ret,
+			     struct btrfs_physical_bio **pbio_ret,
 			     int mirror_num, int need_raid_map)
 {
 	struct extent_map *em;
@@ -6291,7 +6289,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	int num_stripes;
 	int max_errors = 0;
 	int tgtdev_indexes = 0;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int dev_replace_is_ongoing = 0;
 	int num_alloc_stripes;
@@ -6300,7 +6298,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	u64 raid56_full_stripe_start = (u64)-1;
 	struct btrfs_io_geometry geom;
 
-	ASSERT(bbio_ret);
+	ASSERT(pbio_ret);
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
@@ -6444,16 +6442,16 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		tgtdev_indexes = num_stripes;
 	}
 
-	bbio = alloc_btrfs_bio(num_alloc_stripes, tgtdev_indexes);
-	if (!bbio) {
+	pbio = alloc_physical_bio(num_alloc_stripes, tgtdev_indexes);
+	if (!pbio) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		bbio->stripes[i].physical = map->stripes[stripe_index].physical +
+		pbio->stripes[i].physical = map->stripes[stripe_index].physical +
 			stripe_offset + stripe_nr * map->stripe_len;
-		bbio->stripes[i].dev = map->stripes[stripe_index].dev;
+		pbio->stripes[i].dev = map->stripes[stripe_index].dev;
 		stripe_index++;
 	}
 
@@ -6469,15 +6467,15 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		/* Fill in the logical address of each stripe */
 		tmp = stripe_nr * data_stripes;
 		for (i = 0; i < data_stripes; i++)
-			bbio->raid_map[(i+rot) % num_stripes] =
+			pbio->raid_map[(i+rot) % num_stripes] =
 				em->start + (tmp + i) * map->stripe_len;
 
-		bbio->raid_map[(i+rot) % map->num_stripes] = RAID5_P_STRIPE;
+		pbio->raid_map[(i+rot) % map->num_stripes] = RAID5_P_STRIPE;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-			bbio->raid_map[(i+rot+1) % num_stripes] =
+			pbio->raid_map[(i+rot+1) % num_stripes] =
 				RAID6_Q_STRIPE;
 
-		sort_parity_stripes(bbio, num_stripes);
+		sort_parity_stripes(pbio, num_stripes);
 	}
 
 	if (need_full_stripe(op))
@@ -6485,15 +6483,15 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+		handle_ops_on_dev_replace(op, &pbio, dev_replace, logical,
 					  &num_stripes, &max_errors);
 	}
 
-	*bbio_ret = bbio;
-	bbio->map_type = map->type;
-	bbio->num_stripes = num_stripes;
-	bbio->max_errors = max_errors;
-	bbio->mirror_num = mirror_num;
+	*pbio_ret = pbio;
+	pbio->map_type = map->type;
+	pbio->num_stripes = num_stripes;
+	pbio->max_errors = max_errors;
+	pbio->mirror_num = mirror_num;
 
 	/*
 	 * this is the case that REQ_READ && dev_replace_is_ongoing &&
@@ -6502,9 +6500,9 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	 */
 	if (patch_the_first_stripe_for_dev_replace && num_stripes > 0) {
 		WARN_ON(num_stripes > 1);
-		bbio->stripes[0].dev = dev_replace->tgtdev;
-		bbio->stripes[0].physical = physical_to_patch_in_first_stripe;
-		bbio->mirror_num = map->num_stripes + 1;
+		pbio->stripes[0].dev = dev_replace->tgtdev;
+		pbio->stripes[0].physical = physical_to_patch_in_first_stripe;
+		pbio->mirror_num = map->num_stripes + 1;
 	}
 out:
 	if (dev_replace_is_ongoing) {
@@ -6518,40 +6516,41 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		      u64 logical, u64 *length,
-		      struct btrfs_bio **bbio_ret, int mirror_num)
+		      struct btrfs_physical_bio **pbio_ret, int mirror_num)
 {
 	if (op == BTRFS_MAP_DISCARD)
 		return __btrfs_map_block_for_discard(fs_info, logical,
-						     length, bbio_ret);
+						     length, pbio_ret);
 
-	return __btrfs_map_block(fs_info, op, logical, length, bbio_ret,
+	return __btrfs_map_block(fs_info, op, logical, length, pbio_ret,
 				 mirror_num, 0);
 }
 
 /* For Scrub/replace */
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
-		     struct btrfs_bio **bbio_ret)
+		     struct btrfs_physical_bio **pbio_ret)
 {
-	return __btrfs_map_block(fs_info, op, logical, length, bbio_ret, 0, 1);
+	return __btrfs_map_block(fs_info, op, logical, length, pbio_ret, 0, 1);
 }
 
-static inline void btrfs_end_bbio(struct btrfs_bio *bbio, struct bio *bio)
+static inline void btrfs_end_full_pbio(struct btrfs_physical_bio *pbio,
+				       struct bio *bio)
 {
-	bio->bi_private = bbio->private;
-	bio->bi_end_io = bbio->end_io;
+	bio->bi_private = pbio->private;
+	bio->bi_end_io = pbio->end_io;
 	bio_endio(bio);
 
-	btrfs_put_bbio(bbio);
+	btrfs_put_physical_bio(pbio);
 }
 
-static void btrfs_end_bio(struct bio *bio)
+static void btrfs_end_physical_bio(struct bio *bio)
 {
-	struct btrfs_bio *bbio = bio->bi_private;
+	struct btrfs_physical_bio *pbio = bio->bi_private;
 	int is_orig_bio = 0;
 
 	if (bio->bi_status) {
-		atomic_inc(&bbio->error);
+		atomic_inc(&pbio->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
 			struct btrfs_device *dev =
@@ -6570,22 +6569,22 @@ static void btrfs_end_bio(struct bio *bio)
 		}
 	}
 
-	if (bio == bbio->orig_bio)
+	if (bio == pbio->orig_bio)
 		is_orig_bio = 1;
 
-	btrfs_bio_counter_dec(bbio->fs_info);
+	btrfs_bio_counter_dec(pbio->fs_info);
 
-	if (atomic_dec_and_test(&bbio->stripes_pending)) {
+	if (atomic_dec_and_test(&pbio->stripes_pending)) {
 		if (!is_orig_bio) {
 			bio_put(bio);
-			bio = bbio->orig_bio;
+			bio = pbio->orig_bio;
 		}
 
-		btrfs_logical_bio(bio)->mirror_num = bbio->mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = pbio->mirror_num;
 		/* only send an error to the higher layers if it is
 		 * beyond the tolerance of the btrfs bio
 		 */
-		if (atomic_read(&bbio->error) > bbio->max_errors) {
+		if (atomic_read(&pbio->error) > pbio->max_errors) {
 			bio->bi_status = BLK_STS_IOERR;
 		} else {
 			/*
@@ -6595,20 +6594,20 @@ static void btrfs_end_bio(struct bio *bio)
 			bio->bi_status = BLK_STS_OK;
 		}
 
-		btrfs_end_bbio(bbio, bio);
+		btrfs_end_full_pbio(pbio, bio);
 	} else if (!is_orig_bio) {
 		bio_put(bio);
 	}
 }
 
-static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
+static void submit_stripe_bio(struct btrfs_physical_bio *pbio, struct bio *bio,
 			      u64 physical, struct btrfs_device *dev)
 {
-	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	struct btrfs_fs_info *fs_info = pbio->fs_info;
 
-	bio->bi_private = bbio;
+	bio->bi_private = pbio;
 	btrfs_logical_bio(bio)->device = dev;
-	bio->bi_end_io = btrfs_end_bio;
+	bio->bi_end_io = btrfs_end_physical_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	/*
 	 * For zone append writing, bi_sector must point the beginning of the
@@ -6636,20 +6635,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfsic_submit_bio(bio);
 }
 
-static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
+static void pbio_error(struct btrfs_physical_bio *pbio, struct bio *bio,
+		       u64 logical)
 {
-	atomic_inc(&bbio->error);
-	if (atomic_dec_and_test(&bbio->stripes_pending)) {
+	atomic_inc(&pbio->error);
+	if (atomic_dec_and_test(&pbio->stripes_pending)) {
 		/* Should be the original bio. */
-		WARN_ON(bio != bbio->orig_bio);
+		WARN_ON(bio != pbio->orig_bio);
 
-		btrfs_logical_bio(bio)->mirror_num = bbio->mirror_num;
+		btrfs_logical_bio(bio)->mirror_num = pbio->mirror_num;
 		bio->bi_iter.bi_sector = logical >> 9;
-		if (atomic_read(&bbio->error) > bbio->max_errors)
+		if (atomic_read(&pbio->error) > pbio->max_errors)
 			bio->bi_status = BLK_STS_IOERR;
 		else
 			bio->bi_status = BLK_STS_OK;
-		btrfs_end_bbio(bbio, bio);
+		btrfs_end_full_pbio(pbio, bio);
 	}
 }
 
@@ -6664,35 +6664,35 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	int ret;
 	int dev_nr;
 	int total_devs;
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 
 	length = bio->bi_iter.bi_size;
 	map_length = length;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
-				&map_length, &bbio, mirror_num, 1);
+				&map_length, &pbio, mirror_num, 1);
 	if (ret) {
 		btrfs_bio_counter_dec(fs_info);
 		return errno_to_blk_status(ret);
 	}
 
-	total_devs = bbio->num_stripes;
-	bbio->orig_bio = first_bio;
-	bbio->private = first_bio->bi_private;
-	bbio->end_io = first_bio->bi_end_io;
-	bbio->fs_info = fs_info;
-	atomic_set(&bbio->stripes_pending, bbio->num_stripes);
+	total_devs = pbio->num_stripes;
+	pbio->orig_bio = first_bio;
+	pbio->private = first_bio->bi_private;
+	pbio->end_io = first_bio->bi_end_io;
+	pbio->fs_info = fs_info;
+	atomic_set(&pbio->stripes_pending, pbio->num_stripes);
 
-	if ((bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
+	if ((pbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
 		/* In this case, map_length has been set to the length of
 		   a single stripe; not the whole write */
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-			ret = raid56_parity_write(fs_info, bio, bbio,
+			ret = raid56_parity_write(fs_info, bio, pbio,
 						  map_length);
 		} else {
-			ret = raid56_parity_recover(fs_info, bio, bbio,
+			ret = raid56_parity_recover(fs_info, bio, pbio,
 						    map_length, mirror_num, 1);
 		}
 
@@ -6708,12 +6708,12 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	}
 
 	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		dev = bbio->stripes[dev_nr].dev;
+		dev = pbio->stripes[dev_nr].dev;
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
 						   &dev->dev_state) ||
 		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
-			bbio_error(bbio, first_bio, logical);
+			pbio_error(pbio, first_bio, logical);
 			continue;
 		}
 
@@ -6722,7 +6722,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		else
 			bio = first_bio;
 
-		submit_stripe_bio(bbio, bio, bbio->stripes[dev_nr].physical, dev);
+		submit_stripe_bio(pbio, bio, pbio->stripes[dev_nr].physical, dev);
 	}
 	btrfs_bio_counter_dec(fs_info);
 	return BLK_STS_OK;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 22356a09131a..5654def5e3b4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -365,7 +365,10 @@ struct btrfs_bio_stripe {
 	u64 length; /* only used for discard mappings */
 };
 
-struct btrfs_bio {
+/*
+ * Records the physical mapping info and extra members to submit real device IO.
+ */
+struct btrfs_physical_bio {
 	refcount_t refs;
 	atomic_t stripes_pending;
 	struct btrfs_fs_info *fs_info;
@@ -461,14 +464,14 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	}
 }
 
-void btrfs_get_bbio(struct btrfs_bio *bbio);
-void btrfs_put_bbio(struct btrfs_bio *bbio);
+void btrfs_get_physical_bio(struct btrfs_physical_bio *pbio);
+void btrfs_put_physical_bio(struct btrfs_physical_bio *pbio);
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    u64 logical, u64 *length,
-		    struct btrfs_bio **bbio_ret, int mirror_num);
+		    struct btrfs_physical_bio **pbio_ret, int mirror_num);
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
-		     struct btrfs_bio **bbio_ret);
+		     struct btrfs_physical_bio **pbio_ret);
 int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
 			  enum btrfs_map_op op, u64 logical,
 			  struct btrfs_io_geometry *io_geom);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 28a06c2d80ad..41c88519d646 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1626,27 +1626,27 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 len
 static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
 			  struct blk_zone *zone)
 {
-	struct btrfs_bio *bbio = NULL;
+	struct btrfs_physical_bio *pbio = NULL;
 	u64 mapped_length = PAGE_SIZE;
 	unsigned int nofs_flag;
 	int nmirrors;
 	int i, ret;
 
 	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
-			       &mapped_length, &bbio);
-	if (ret || !bbio || mapped_length < PAGE_SIZE) {
-		btrfs_put_bbio(bbio);
+			       &mapped_length, &pbio);
+	if (ret || !pbio || mapped_length < PAGE_SIZE) {
+		btrfs_put_physical_bio(pbio);
 		return -EIO;
 	}
 
-	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+	if (pbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 		return -EINVAL;
 
 	nofs_flag = memalloc_nofs_save();
-	nmirrors = (int)bbio->num_stripes;
+	nmirrors = (int)pbio->num_stripes;
 	for (i = 0; i < nmirrors; i++) {
-		u64 physical = bbio->stripes[i].physical;
-		struct btrfs_device *dev = bbio->stripes[i].dev;
+		u64 physical = pbio->stripes[i].physical;
+		struct btrfs_device *dev = pbio->stripes[i].dev;
 
 		/* Missing device */
 		if (!dev->bdev)
-- 
2.33.0

