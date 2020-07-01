Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109B521078E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgGAJGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgGAJGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 05:06:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFFC03E979;
        Wed,  1 Jul 2020 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qiamtDfOkXtrbvHOufxPWy8aTrpdWnlM5yuvnv87lH8=; b=KRBUMbCcgO/Sg/hq1D66Iqy4kL
        2P0ZLTASwGm5YGqNbtJyVPoIHyn5xuVa/E/xg5fnnd/KJo8MHVQcxY4pi4NOM+92b+cUM92p/LHdz
        zMy+1ATRcTAVkHP6YXV+9eqFgGEbQP8odQ2oLogHZ4Ya3Q677m6xijVg9fDAnKcbj0T+UpYm0LJVj
        N8OEkzQdggowlSQth2KOfcCdgu9FNd8JTQPbYQ1zOIDKqrqPoUUcOjnxc4LPH+b3lYcG4VwV3cyiB
        lVPfemHarENp/yw8CNfO/9Smv3L7tvv5444KcfhCjQrU5JomRdI8Vx7byK6peLs841z5t2oCjR7zP
        lvplzM7g==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqYhJ-0000iQ-Lu; Wed, 01 Jul 2020 09:06:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, dm-devel@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] writeback: remove bdi->congested_fn
Date:   Wed,  1 Jul 2020 11:06:22 +0200
Message-Id: <20200701090622.3354860-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701090622.3354860-1-hch@lst.de>
References: <20200701090622.3354860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Except for pktdvd, the only places setting congested bits are file
systems that allocate their own backing_dev_info structures.  And
pktdvd is a deprecated driver that isn't useful in stack setup
either.  So remove the dead congested_fn stacking infrastructure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c   | 59 --------------------------------
 drivers/md/bcache/request.c      | 43 -----------------------
 drivers/md/bcache/super.c        |  1 -
 drivers/md/dm-cache-target.c     | 19 ----------
 drivers/md/dm-clone-target.c     | 15 --------
 drivers/md/dm-era-target.c       | 15 --------
 drivers/md/dm-raid.c             | 12 -------
 drivers/md/dm-table.c            | 37 +-------------------
 drivers/md/dm-thin.c             | 16 ---------
 drivers/md/dm.c                  | 33 ------------------
 drivers/md/dm.h                  |  1 -
 drivers/md/md-linear.c           | 24 -------------
 drivers/md/md-multipath.c        | 23 -------------
 drivers/md/md.c                  | 23 -------------
 drivers/md/md.h                  |  4 ---
 drivers/md/raid0.c               | 16 ---------
 drivers/md/raid1.c               | 31 -----------------
 drivers/md/raid10.c              | 26 --------------
 drivers/md/raid5.c               | 25 --------------
 fs/btrfs/disk-io.c               | 23 -------------
 include/linux/backing-dev-defs.h |  4 ---
 include/linux/backing-dev.h      |  4 ---
 include/linux/device-mapper.h    | 11 ------
 23 files changed, 1 insertion(+), 464 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 45fbd526c453bc..e9c9ac3c520282 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2414,62 +2414,6 @@ static void drbd_cleanup(void)
 	pr_info("module cleanup done.\n");
 }
 
-/**
- * drbd_congested() - Callback for the flusher thread
- * @congested_data:	User data
- * @bdi_bits:		Bits the BDI flusher thread is currently interested in
- *
- * Returns 1<<WB_async_congested and/or 1<<WB_sync_congested if we are congested.
- */
-static int drbd_congested(void *congested_data, int bdi_bits)
-{
-	struct drbd_device *device = congested_data;
-	struct request_queue *q;
-	char reason = '-';
-	int r = 0;
-
-	if (!may_inc_ap_bio(device)) {
-		/* DRBD has frozen IO */
-		r = bdi_bits;
-		reason = 'd';
-		goto out;
-	}
-
-	if (test_bit(CALLBACK_PENDING, &first_peer_device(device)->connection->flags)) {
-		r |= (1 << WB_async_congested);
-		/* Without good local data, we would need to read from remote,
-		 * and that would need the worker thread as well, which is
-		 * currently blocked waiting for that usermode helper to
-		 * finish.
-		 */
-		if (!get_ldev_if_state(device, D_UP_TO_DATE))
-			r |= (1 << WB_sync_congested);
-		else
-			put_ldev(device);
-		r &= bdi_bits;
-		reason = 'c';
-		goto out;
-	}
-
-	if (get_ldev(device)) {
-		q = bdev_get_queue(device->ldev->backing_bdev);
-		r = bdi_congested(q->backing_dev_info, bdi_bits);
-		put_ldev(device);
-		if (r)
-			reason = 'b';
-	}
-
-	if (bdi_bits & (1 << WB_async_congested) &&
-	    test_bit(NET_CONGESTED, &first_peer_device(device)->connection->flags)) {
-		r |= (1 << WB_async_congested);
-		reason = reason == 'b' ? 'a' : 'n';
-	}
-
-out:
-	device->congestion_reason = reason;
-	return r;
-}
-
 static void drbd_init_workqueue(struct drbd_work_queue* wq)
 {
 	spin_lock_init(&wq->q_lock);
@@ -2825,9 +2769,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	/* we have no partitions. we contain only ourselves. */
 	device->this_bdev->bd_contains = device->this_bdev;
 
-	q->backing_dev_info->congested_fn = drbd_congested;
-	q->backing_dev_info->congested_data = device;
-
 	blk_queue_write_cache(q, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 7acf024e99f351..cda05fc61c3afa 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1228,36 +1228,10 @@ static int cached_dev_ioctl(struct bcache_device *d, fmode_t mode,
 	return __blkdev_driver_ioctl(dc->bdev, mode, cmd, arg);
 }
 
-static int cached_dev_congested(void *data, int bits)
-{
-	struct bcache_device *d = data;
-	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
-	struct request_queue *q = bdev_get_queue(dc->bdev);
-	int ret = 0;
-
-	if (bdi_congested(q->backing_dev_info, bits))
-		return 1;
-
-	if (cached_dev_get(dc)) {
-		unsigned int i;
-		struct cache *ca;
-
-		for_each_cache(ca, d->c, i) {
-			q = bdev_get_queue(ca->bdev);
-			ret |= bdi_congested(q->backing_dev_info, bits);
-		}
-
-		cached_dev_put(dc);
-	}
-
-	return ret;
-}
-
 void bch_cached_dev_request_init(struct cached_dev *dc)
 {
 	struct gendisk *g = dc->disk.disk;
 
-	g->queue->backing_dev_info->congested_fn = cached_dev_congested;
 	dc->disk.cache_miss			= cached_dev_cache_miss;
 	dc->disk.ioctl				= cached_dev_ioctl;
 }
@@ -1342,27 +1316,10 @@ static int flash_dev_ioctl(struct bcache_device *d, fmode_t mode,
 	return -ENOTTY;
 }
 
-static int flash_dev_congested(void *data, int bits)
-{
-	struct bcache_device *d = data;
-	struct request_queue *q;
-	struct cache *ca;
-	unsigned int i;
-	int ret = 0;
-
-	for_each_cache(ca, d->c, i) {
-		q = bdev_get_queue(ca->bdev);
-		ret |= bdi_congested(q->backing_dev_info, bits);
-	}
-
-	return ret;
-}
-
 void bch_flash_dev_request_init(struct bcache_device *d)
 {
 	struct gendisk *g = d->disk;
 
-	g->queue->backing_dev_info->congested_fn = flash_dev_congested;
 	d->cache_miss				= flash_dev_cache_miss;
 	d->ioctl				= flash_dev_ioctl;
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2014016f9a60d3..1810d7ca2f6653 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -877,7 +877,6 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	d->disk->queue			= q;
 	q->queuedata			= d;
-	q->backing_dev_info->congested_data = d;
 	q->limits.max_hw_sectors	= UINT_MAX;
 	q->limits.max_sectors		= UINT_MAX;
 	q->limits.max_segment_size	= UINT_MAX;
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index d3bb355819a421..24549dc92eeec5 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -421,8 +421,6 @@ struct cache {
 
 	struct rw_semaphore quiesce_lock;
 
-	struct dm_target_callbacks callbacks;
-
 	/*
 	 * origin_blocks entries, discarded if set.
 	 */
@@ -2423,20 +2421,6 @@ static void set_cache_size(struct cache *cache, dm_cblock_t size)
 	cache->cache_size = size;
 }
 
-static int is_congested(struct dm_dev *dev, int bdi_bits)
-{
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-	return bdi_congested(q->backing_dev_info, bdi_bits);
-}
-
-static int cache_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
-{
-	struct cache *cache = container_of(cb, struct cache, callbacks);
-
-	return is_congested(cache->origin_dev, bdi_bits) ||
-		is_congested(cache->cache_dev, bdi_bits);
-}
-
 #define DEFAULT_MIGRATION_THRESHOLD 2048
 
 static int cache_create(struct cache_args *ca, struct cache **result)
@@ -2471,9 +2455,6 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 			goto bad;
 	}
 
-	cache->callbacks.congested_fn = cache_is_congested;
-	dm_table_add_target_callbacks(ti->table, &cache->callbacks);
-
 	cache->metadata_dev = ca->metadata_dev;
 	cache->origin_dev = ca->origin_dev;
 	cache->cache_dev = ca->cache_dev;
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 5ce96ddf1ce1eb..8e900418d571ff 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -68,7 +68,6 @@ struct hash_table_bucket;
 
 struct clone {
 	struct dm_target *ti;
-	struct dm_target_callbacks callbacks;
 
 	struct dm_dev *metadata_dev;
 	struct dm_dev *dest_dev;
@@ -1518,18 +1517,6 @@ static void clone_status(struct dm_target *ti, status_type_t type,
 	DMEMIT("Error");
 }
 
-static int clone_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
-{
-	struct request_queue *dest_q, *source_q;
-	struct clone *clone = container_of(cb, struct clone, callbacks);
-
-	source_q = bdev_get_queue(clone->source_dev->bdev);
-	dest_q = bdev_get_queue(clone->dest_dev->bdev);
-
-	return (bdi_congested(dest_q->backing_dev_info, bdi_bits) |
-		bdi_congested(source_q->backing_dev_info, bdi_bits));
-}
-
 static sector_t get_dev_size(struct dm_dev *dev)
 {
 	return i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT;
@@ -1930,8 +1917,6 @@ static int clone_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto out_with_mempool;
 
 	mutex_init(&clone->commit_lock);
-	clone->callbacks.congested_fn = clone_is_congested;
-	dm_table_add_target_callbacks(ti->table, &clone->callbacks);
 
 	/* Enable flushes */
 	ti->num_flush_bios = 1;
diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index bdb84b8e71621d..e8d3b5abc85bd6 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1137,7 +1137,6 @@ static int metadata_get_stats(struct era_metadata *md, void *ptr)
 
 struct era {
 	struct dm_target *ti;
-	struct dm_target_callbacks callbacks;
 
 	struct dm_dev *metadata_dev;
 	struct dm_dev *origin_dev;
@@ -1375,18 +1374,6 @@ static void stop_worker(struct era *era)
 /*----------------------------------------------------------------
  * Target methods
  *--------------------------------------------------------------*/
-static int dev_is_congested(struct dm_dev *dev, int bdi_bits)
-{
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-	return bdi_congested(q->backing_dev_info, bdi_bits);
-}
-
-static int era_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
-{
-	struct era *era = container_of(cb, struct era, callbacks);
-	return dev_is_congested(era->origin_dev, bdi_bits);
-}
-
 static void era_destroy(struct era *era)
 {
 	if (era->md)
@@ -1514,8 +1501,6 @@ static int era_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	ti->flush_supported = true;
 
 	ti->num_discard_bios = 1;
-	era->callbacks.congested_fn = era_is_congested;
-	dm_table_add_target_callbacks(ti->table, &era->callbacks);
 
 	return 0;
 }
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 10e8b2fe787b56..d9e270957e1840 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -242,7 +242,6 @@ struct raid_set {
 
 	struct mddev md;
 	struct raid_type *raid_type;
-	struct dm_target_callbacks callbacks;
 
 	sector_t array_sectors;
 	sector_t dev_sectors;
@@ -1705,13 +1704,6 @@ static void do_table_event(struct work_struct *ws)
 	dm_table_event(rs->ti->table);
 }
 
-static int raid_is_congested(struct dm_target_callbacks *cb, int bits)
-{
-	struct raid_set *rs = container_of(cb, struct raid_set, callbacks);
-
-	return mddev_congested(&rs->md, bits);
-}
-
 /*
  * Make sure a valid takover (level switch) is being requested on @rs
  *
@@ -3248,9 +3240,6 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad_md_start;
 	}
 
-	rs->callbacks.congested_fn = raid_is_congested;
-	dm_table_add_target_callbacks(ti->table, &rs->callbacks);
-
 	/* If raid4/5/6 journal mode explicitly requested (only possible with journal dev) -> set it */
 	if (test_bit(__CTR_FLAG_JOURNAL_MODE, &rs->ctr_flags)) {
 		r = r5c_journal_mode_set(&rs->md, rs->journal_dev.mode);
@@ -3310,7 +3299,6 @@ static void raid_dtr(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
-	list_del_init(&rs->callbacks.list);
 	md_stop(&rs->md);
 	raid_set_free(rs);
 }
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8277b959e00bd6..0ea5b7367179ff 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -64,8 +64,6 @@ struct dm_table {
 	void *event_context;
 
 	struct dm_md_mempools *mempools;
-
-	struct list_head target_callbacks;
 };
 
 /*
@@ -190,7 +188,6 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&t->devices);
-	INIT_LIST_HEAD(&t->target_callbacks);
 
 	if (!num_targets)
 		num_targets = KEYS_PER_NODE;
@@ -361,7 +358,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
  * This upgrades the mode on an already open dm_dev, being
  * careful to leave things as they were if we fail to reopen the
  * device and not to touch the existing bdev field in case
- * it is accessed concurrently inside dm_table_any_congested().
+ * it is accessed concurrently.
  */
 static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
 			struct mapped_device *md)
@@ -2052,38 +2049,6 @@ int dm_table_resume_targets(struct dm_table *t)
 	return 0;
 }
 
-void dm_table_add_target_callbacks(struct dm_table *t, struct dm_target_callbacks *cb)
-{
-	list_add(&cb->list, &t->target_callbacks);
-}
-EXPORT_SYMBOL_GPL(dm_table_add_target_callbacks);
-
-int dm_table_any_congested(struct dm_table *t, int bdi_bits)
-{
-	struct dm_dev_internal *dd;
-	struct list_head *devices = dm_table_get_devices(t);
-	struct dm_target_callbacks *cb;
-	int r = 0;
-
-	list_for_each_entry(dd, devices, list) {
-		struct request_queue *q = bdev_get_queue(dd->dm_dev->bdev);
-		char b[BDEVNAME_SIZE];
-
-		if (likely(q))
-			r |= bdi_congested(q->backing_dev_info, bdi_bits);
-		else
-			DMWARN_LIMIT("%s: any_congested: nonexistent device %s",
-				     dm_device_name(t->md),
-				     bdevname(dd->dm_dev->bdev, b));
-	}
-
-	list_for_each_entry(cb, &t->target_callbacks, list)
-		if (cb->congested_fn)
-			r |= cb->congested_fn(cb, bdi_bits);
-
-	return r;
-}
-
 struct mapped_device *dm_table_get_md(struct dm_table *t)
 {
 	return t->md;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index fa8d5464c1fb51..e95682e09d5af8 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -326,7 +326,6 @@ struct pool_c {
 	struct pool *pool;
 	struct dm_dev *data_dev;
 	struct dm_dev *metadata_dev;
-	struct dm_target_callbacks callbacks;
 
 	dm_block_t low_water_blocks;
 	struct pool_features requested_pf; /* Features requested during table load */
@@ -2796,18 +2795,6 @@ static int thin_bio_map(struct dm_target *ti, struct bio *bio)
 	}
 }
 
-static int pool_is_congested(struct dm_target_callbacks *cb, int bdi_bits)
-{
-	struct pool_c *pt = container_of(cb, struct pool_c, callbacks);
-	struct request_queue *q;
-
-	if (get_pool_mode(pt->pool) == PM_OUT_OF_DATA_SPACE)
-		return 1;
-
-	q = bdev_get_queue(pt->data_dev->bdev);
-	return bdi_congested(q->backing_dev_info, bdi_bits);
-}
-
 static void requeue_bios(struct pool *pool)
 {
 	struct thin_c *tc;
@@ -3420,9 +3407,6 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	dm_pool_register_pre_commit_callback(pool->pmd,
 					     metadata_pre_commit_callback, pool);
 
-	pt->callbacks.congested_fn = pool_is_congested;
-	dm_table_add_target_callbacks(ti->table, &pt->callbacks);
-
 	mutex_unlock(&dm_thin_pool_table.mutex);
 
 	return 0;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 97838b6d0b5473..f0fd8822da514f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1825,31 +1825,6 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 	return ret;
 }
 
-static int dm_any_congested(void *congested_data, int bdi_bits)
-{
-	int r = bdi_bits;
-	struct mapped_device *md = congested_data;
-	struct dm_table *map;
-
-	if (!test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)) {
-		if (dm_request_based(md)) {
-			/*
-			 * With request-based DM we only need to check the
-			 * top-level queue for congestion.
-			 */
-			struct backing_dev_info *bdi = md->queue->backing_dev_info;
-			r = bdi->wb.congested & bdi_bits;
-		} else {
-			map = dm_get_live_table_fast(md);
-			if (map)
-				r = dm_table_any_congested(map, bdi_bits);
-			dm_put_live_table_fast(md);
-		}
-	}
-
-	return r;
-}
-
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -2289,12 +2264,6 @@ struct queue_limits *dm_get_queue_limits(struct mapped_device *md)
 }
 EXPORT_SYMBOL_GPL(dm_get_queue_limits);
 
-static void dm_init_congested_fn(struct mapped_device *md)
-{
-	md->queue->backing_dev_info->congested_data = md;
-	md->queue->backing_dev_info->congested_fn = dm_any_congested;
-}
-
 /*
  * Setup the DM device's queue based on md's type
  */
@@ -2311,12 +2280,10 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 			DMERR("Cannot initialize queue for request-based dm-mq mapped device");
 			return r;
 		}
-		dm_init_congested_fn(md);
 		break;
 	case DM_TYPE_BIO_BASED:
 	case DM_TYPE_DAX_BIO_BASED:
 	case DM_TYPE_NVME_BIO_BASED:
-		dm_init_congested_fn(md);
 		break;
 	case DM_TYPE_NONE:
 		WARN_ON_ONCE(true);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index d7c4f6606b5fca..4f5fe664d05ac7 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -63,7 +63,6 @@ void dm_table_presuspend_targets(struct dm_table *t);
 void dm_table_presuspend_undo_targets(struct dm_table *t);
 void dm_table_postsuspend_targets(struct dm_table *t);
 int dm_table_resume_targets(struct dm_table *t);
-int dm_table_any_congested(struct dm_table *t, int bdi_bits);
 enum dm_queue_mode dm_table_get_type(struct dm_table *t);
 struct target_type *dm_table_get_immutable_target_type(struct dm_table *t);
 struct dm_target *dm_table_get_immutable_target(struct dm_table *t);
diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 26c75c0199fa1b..e19d1919a753d2 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -46,29 +46,6 @@ static inline struct dev_info *which_dev(struct mddev *mddev, sector_t sector)
 	return conf->disks + lo;
 }
 
-/*
- * In linear_congested() conf->raid_disks is used as a copy of
- * mddev->raid_disks to iterate conf->disks[], because conf->raid_disks
- * and conf->disks[] are created in linear_conf(), they are always
- * consitent with each other, but mddev->raid_disks does not.
- */
-static int linear_congested(struct mddev *mddev, int bits)
-{
-	struct linear_conf *conf;
-	int i, ret = 0;
-
-	rcu_read_lock();
-	conf = rcu_dereference(mddev->private);
-
-	for (i = 0; i < conf->raid_disks && !ret ; i++) {
-		struct request_queue *q = bdev_get_queue(conf->disks[i].rdev->bdev);
-		ret |= bdi_congested(q->backing_dev_info, bits);
-	}
-
-	rcu_read_unlock();
-	return ret;
-}
-
 static sector_t linear_size(struct mddev *mddev, sector_t sectors, int raid_disks)
 {
 	struct linear_conf *conf;
@@ -322,7 +299,6 @@ static struct md_personality linear_personality =
 	.hot_add_disk	= linear_add,
 	.size		= linear_size,
 	.quiesce	= linear_quiesce,
-	.congested	= linear_congested,
 };
 
 static int __init linear_init (void)
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 152f9e65a22665..f9c895fa9afc25 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -151,28 +151,6 @@ static void multipath_status(struct seq_file *seq, struct mddev *mddev)
 	seq_putc(seq, ']');
 }
 
-static int multipath_congested(struct mddev *mddev, int bits)
-{
-	struct mpconf *conf = mddev->private;
-	int i, ret = 0;
-
-	rcu_read_lock();
-	for (i = 0; i < mddev->raid_disks ; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->multipaths[i].rdev);
-		if (rdev && !test_bit(Faulty, &rdev->flags)) {
-			struct request_queue *q = bdev_get_queue(rdev->bdev);
-
-			ret |= bdi_congested(q->backing_dev_info, bits);
-			/* Just like multipath_map, we just check the
-			 * first available device
-			 */
-			break;
-		}
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
 /*
  * Careful, this can execute in IRQ contexts as well!
  */
@@ -478,7 +456,6 @@ static struct md_personality multipath_personality =
 	.hot_add_disk	= multipath_add_disk,
 	.hot_remove_disk= multipath_remove_disk,
 	.size		= multipath_size,
-	.congested	= multipath_congested,
 };
 
 static int __init multipath_init (void)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529bd..b27038246bc563 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -549,26 +549,6 @@ void mddev_resume(struct mddev *mddev)
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
-int mddev_congested(struct mddev *mddev, int bits)
-{
-	struct md_personality *pers = mddev->pers;
-	int ret = 0;
-
-	rcu_read_lock();
-	if (mddev->suspended)
-		ret = 1;
-	else if (pers && pers->congested)
-		ret = pers->congested(mddev, bits);
-	rcu_read_unlock();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mddev_congested);
-static int md_congested(void *data, int bits)
-{
-	struct mddev *mddev = data;
-	return mddev_congested(mddev, bits);
-}
-
 /*
  * Generic flush handling for md
  */
@@ -5964,8 +5944,6 @@ int md_run(struct mddev *mddev)
 			blk_queue_flag_set(QUEUE_FLAG_NONROT, mddev->queue);
 		else
 			blk_queue_flag_clear(QUEUE_FLAG_NONROT, mddev->queue);
-		mddev->queue->backing_dev_info->congested_data = mddev;
-		mddev->queue->backing_dev_info->congested_fn = md_congested;
 	}
 	if (pers->sync_request) {
 		if (mddev->kobj.sd &&
@@ -6350,7 +6328,6 @@ static int do_md_stop(struct mddev *mddev, int mode,
 
 		__md_stop_writes(mddev);
 		__md_stop(mddev);
-		mddev->queue->backing_dev_info->congested_fn = NULL;
 
 		/* tell userspace to handle 'inactive' */
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 612814d07d35ab..e2f1ad9afc4885 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -597,9 +597,6 @@ struct md_personality
 	 * array.
 	 */
 	void *(*takeover) (struct mddev *mddev);
-	/* congested implements bdi.congested_fn().
-	 * Will not be called while array is 'suspended' */
-	int (*congested)(struct mddev *mddev, int bits);
 	/* Changes the consistency policy of an active array. */
 	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
 };
@@ -710,7 +707,6 @@ extern void md_done_sync(struct mddev *mddev, int blocks, int ok);
 extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
 
-extern int mddev_congested(struct mddev *mddev, int bits);
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
 extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 			   sector_t sector, int size, struct page *page);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 322386ff5d225d..d092b88af80a66 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -29,21 +29,6 @@ module_param(default_layout, int, 0644);
 	 (1L << MD_HAS_PPL) |		\
 	 (1L << MD_HAS_MULTIPLE_PPLS))
 
-static int raid0_congested(struct mddev *mddev, int bits)
-{
-	struct r0conf *conf = mddev->private;
-	struct md_rdev **devlist = conf->devlist;
-	int raid_disks = conf->strip_zone[0].nb_dev;
-	int i, ret = 0;
-
-	for (i = 0; i < raid_disks && !ret ; i++) {
-		struct request_queue *q = bdev_get_queue(devlist[i]->bdev);
-
-		ret |= bdi_congested(q->backing_dev_info, bits);
-	}
-	return ret;
-}
-
 /*
  * inform the user of the raid configuration
 */
@@ -818,7 +803,6 @@ static struct md_personality raid0_personality=
 	.size		= raid0_size,
 	.takeover	= raid0_takeover,
 	.quiesce	= raid0_quiesce,
-	.congested	= raid0_congested,
 };
 
 static int __init raid0_init (void)
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dcd27f3da84eca..4edc7ff05ed278 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -786,36 +786,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	return best_disk;
 }
 
-static int raid1_congested(struct mddev *mddev, int bits)
-{
-	struct r1conf *conf = mddev->private;
-	int i, ret = 0;
-
-	if ((bits & (1 << WB_async_congested)) &&
-	    conf->pending_count >= max_queued_requests)
-		return 1;
-
-	rcu_read_lock();
-	for (i = 0; i < conf->raid_disks * 2; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
-		if (rdev && !test_bit(Faulty, &rdev->flags)) {
-			struct request_queue *q = bdev_get_queue(rdev->bdev);
-
-			BUG_ON(!q);
-
-			/* Note the '|| 1' - when read_balance prefers
-			 * non-congested targets, it can be removed
-			 */
-			if ((bits & (1 << WB_async_congested)) || 1)
-				ret |= bdi_congested(q->backing_dev_info, bits);
-			else
-				ret &= bdi_congested(q->backing_dev_info, bits);
-		}
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
 static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 {
 	/* flush any pending bitmap writes to disk before proceeding w/ I/O */
@@ -3396,7 +3366,6 @@ static struct md_personality raid1_personality =
 	.check_reshape	= raid1_reshape,
 	.quiesce	= raid1_quiesce,
 	.takeover	= raid1_takeover,
-	.congested	= raid1_congested,
 };
 
 static int __init raid_init(void)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ec136e44aef7f8..1768300138b35f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -848,31 +848,6 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 	return rdev;
 }
 
-static int raid10_congested(struct mddev *mddev, int bits)
-{
-	struct r10conf *conf = mddev->private;
-	int i, ret = 0;
-
-	if ((bits & (1 << WB_async_congested)) &&
-	    conf->pending_count >= max_queued_requests)
-		return 1;
-
-	rcu_read_lock();
-	for (i = 0;
-	     (i < conf->geo.raid_disks || i < conf->prev.raid_disks)
-		     && ret == 0;
-	     i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
-		if (rdev && !test_bit(Faulty, &rdev->flags)) {
-			struct request_queue *q = bdev_get_queue(rdev->bdev);
-
-			ret |= bdi_congested(q->backing_dev_info, bits);
-		}
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
 static void flush_pending_writes(struct r10conf *conf)
 {
 	/* Any writes that have been queued but are awaiting
@@ -4929,7 +4904,6 @@ static struct md_personality raid10_personality =
 	.start_reshape	= raid10_start_reshape,
 	.finish_reshape	= raid10_finish_reshape,
 	.update_reshape_pos = raid10_update_reshape_pos,
-	.congested	= raid10_congested,
 };
 
 static int __init raid_init(void)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ab8067f9ce8c68..229a36a8694f28 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5099,28 +5099,6 @@ static void activate_bit_delay(struct r5conf *conf,
 	}
 }
 
-static int raid5_congested(struct mddev *mddev, int bits)
-{
-	struct r5conf *conf = mddev->private;
-
-	/* No difference between reads and writes.  Just check
-	 * how busy the stripe_cache is
-	 */
-
-	if (test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state))
-		return 1;
-
-	/* Also checks whether there is pressure on r5cache log space */
-	if (test_bit(R5C_LOG_TIGHT, &conf->cache_state))
-		return 1;
-	if (conf->quiesce)
-		return 1;
-	if (atomic_read(&conf->empty_inactive_list_nr))
-		return 1;
-
-	return 0;
-}
-
 static int in_chunk_boundary(struct mddev *mddev, struct bio *bio)
 {
 	struct r5conf *conf = mddev->private;
@@ -8427,7 +8405,6 @@ static struct md_personality raid6_personality =
 	.finish_reshape = raid5_finish_reshape,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
-	.congested	= raid5_congested,
 	.change_consistency_policy = raid5_change_consistency_policy,
 };
 static struct md_personality raid5_personality =
@@ -8452,7 +8429,6 @@ static struct md_personality raid5_personality =
 	.finish_reshape = raid5_finish_reshape,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
-	.congested	= raid5_congested,
 	.change_consistency_policy = raid5_change_consistency_policy,
 };
 
@@ -8478,7 +8454,6 @@ static struct md_personality raid4_personality =
 	.finish_reshape = raid5_finish_reshape,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
-	.congested	= raid5_congested,
 	.change_consistency_policy = raid5_change_consistency_policy,
 };
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7c6f0bbb54a5bd..eb5f2506cede72 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1616,27 +1616,6 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	return ERR_PTR(ret);
 }
 
-static int btrfs_congested_fn(void *congested_data, int bdi_bits)
-{
-	struct btrfs_fs_info *info = (struct btrfs_fs_info *)congested_data;
-	int ret = 0;
-	struct btrfs_device *device;
-	struct backing_dev_info *bdi;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(device, &info->fs_devices->devices, dev_list) {
-		if (!device->bdev)
-			continue;
-		bdi = device->bdev->bd_bdi;
-		if (bdi_congested(bdi, bdi_bits)) {
-			ret = 1;
-			break;
-		}
-	}
-	rcu_read_unlock();
-	return ret;
-}
-
 /*
  * called by the kthread helper functions to finally call the bio end_io
  * functions.  This is where read checksum verification actually happens
@@ -3051,8 +3030,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sb_buffer;
 	}
 
-	sb->s_bdi->congested_fn = btrfs_congested_fn;
-	sb->s_bdi->congested_data = fs_info;
 	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
 	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 1cec4521e1fbe2..fff9367a634856 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -33,8 +33,6 @@ enum wb_congested_state {
 	WB_sync_congested,	/* The sync queue is getting full */
 };
 
-typedef int (congested_fn)(void *, int);
-
 enum wb_stat_item {
 	WB_RECLAIMABLE,
 	WB_WRITEBACK,
@@ -170,8 +168,6 @@ struct backing_dev_info {
 	struct list_head bdi_list;
 	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
 	unsigned long io_pages;	/* max allowed IO size */
-	congested_fn *congested_fn; /* Function pointer if device is md/dm */
-	void *congested_data;	/* Pointer to aux data for congested func */
 
 	struct kref refcnt;	/* Reference counter for the structure */
 	unsigned int capabilities; /* Device capabilities */
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 9173d2c22b4aa0..0b06b2d26c9aa3 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -169,10 +169,6 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
 
 static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
 {
-	struct backing_dev_info *bdi = wb->bdi;
-
-	if (bdi->congested_fn)
-		return bdi->congested_fn(bdi->congested_data, cong_bits);
 	return wb->congested & cong_bits;
 }
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 8750f2dc5613ab..d5306d9c29c4f2 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -322,12 +322,6 @@ struct dm_target {
 	bool discards_supported:1;
 };
 
-/* Each target can link one of these into the table */
-struct dm_target_callbacks {
-	struct list_head list;
-	int (*congested_fn) (struct dm_target_callbacks *, int);
-};
-
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
 struct bio *dm_bio_from_per_bio_data(void *data, size_t data_size);
 unsigned dm_bio_get_target_bio_nr(const struct bio *bio);
@@ -477,11 +471,6 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 int dm_table_add_target(struct dm_table *t, const char *type,
 			sector_t start, sector_t len, char *params);
 
-/*
- * Target_ctr should call this if it needs to add any callbacks.
- */
-void dm_table_add_target_callbacks(struct dm_table *t, struct dm_target_callbacks *cb);
-
 /*
  * Target can use this to set the table's type.
  * Can only ever be called from a target's ctr.
-- 
2.26.2

