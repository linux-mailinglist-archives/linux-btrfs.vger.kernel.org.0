Return-Path: <linux-btrfs+bounces-18441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB6C2359C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A723B0621
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBB130BF4F;
	Fri, 31 Oct 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhdpoRnJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB92F12BA;
	Fri, 31 Oct 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891426; cv=none; b=GTyX7hROBDf9A8db7REx/rw1uA/+foRLed/ReWXKlhD4iSJbMoojbeBr/svklWEtjB4OapTEN4VLD+UVgcZ0SZKvIIbhKKiSir9f5XVXfKn6WhPBk00q0WAlXw9AOx2wWdAooJoCCCfsO26NDh/l16esGn+Ksi577z9JNgvqZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891426; c=relaxed/simple;
	bh=e3PoW0O+rEzMhAl5pll3o5AMgtNjudnPG184isR6j4A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2QwkMX2YGyw1P3k+AQoZtq4yPHnr6yh5DfYnHKp778mlZuf09w09sp8el78P8wN8XKPe5p57pliuDr4il6+Zcd9kvIkNX5qwHNeWSvnKL3k4GsVMFsTEUpH50nuw7XKTFa1yx1WVwp0CfKP6nDxfoTOLU1T8VZbi+9mlvMt4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhdpoRnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD40C4CEF1;
	Fri, 31 Oct 2025 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891425;
	bh=e3PoW0O+rEzMhAl5pll3o5AMgtNjudnPG184isR6j4A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VhdpoRnJ5Yr4d5mY3yqpkeR5lRIM15siOIlTk8iQIu16HZHUUFRUWCFQKdONISdqc
	 U+FavPfcDRfsQJ7zw3PCCf1bHA9m5eSaglk8wsiwZJt6QZj5NUJLHqSjhzmBCnNKo7
	 l1ROpz9/Xobwu4EZ+d4Vd9Rfm8AuLnIkxT1WX245B3dhsiBdmfK1ZVKLcMp7ojtyyV
	 IWgCGmRWyqTyqLd9hiJsSVDn7VTb9tLZjyRC/6jEpOljmIG7ZsR8FCXCH+Oq6qb0n+
	 GM/fKdox45U/iyeQI6pnFusNM/fy0hCwU6XxJx6LvcGIsLPGAT1dGg76h0lmJ6fi0c
	 e17QK13YOCVlw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 06/13] block: use zone condition to determine conventional zones
Date: Fri, 31 Oct 2025 15:13:00 +0900
Message-ID: <20251031061307.185513-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conv_zones_bitmap field of struct gendisk is used to define a bitmap
to identify the conventional zones of a zoned block device. The bit for
a zone is set in this bitmap if the zone is a conventional one, that is,
if the zone type is BLK_ZONE_TYPE_CONVENTIONAL. For such zone, this
always corresponds to the zone condition BLK_ZONE_COND_NOT_WP.
In other words, conv_zones_bitmap tracks a single condition of the
zones of a zoned block device.

In preparation for tracking more zone conditions, change
conv_zones_bitmap into an array of zone conditions, using 1 byte per
zone. This increases the memory usage from 1 bit per zone to 1 bytes per
zone, that is, from 16 KiB to about 100 KiB for a 30 TB SMR HDD with 256
MiB zones. This is a trade-off to allow fast cached report zones later
on top of this change.

Rename the conv_zones_bitmap field of struct gendisk to zones_cond. Add
a blk_revalidate_zone_cond() function to initialize the zones_cond array
of a disk during device scan and to update it on device revalidation.
Move the allocation of the zones_cond array to
disk_revalidate_zone_resources(), making sure that this array is always
allocated, even for devices that do not need zone write plugs (zone
resources), to ensure that bdev_zone_is_seq() can be re-implemented to
use the zone condition array in place of the conv zones bitmap.

Finally, the function bdev_zone_is_seq() is rewritten to use a test on
the condition of the target zone.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 151 +++++++++++++++++++++++++++++------------
 include/linux/blkdev.h |  32 ++-------
 2 files changed, 111 insertions(+), 72 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 29891253a920..4997f11caa0c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -114,6 +114,33 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
+/**
+ * bdev_zone_is_seq - check if a sector belongs to a sequential write zone
+ * @bdev:       block device to check
+ * @sector:     sector number
+ *
+ * Check if @sector on @bdev is contained in a sequential write required zone.
+ */
+bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	unsigned int zno = disk_zone_no(disk, sector);
+	bool is_seq = false;
+	u8 *zones_cond;
+
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	rcu_read_lock();
+	zones_cond = rcu_dereference(disk->zones_cond);
+	if (zones_cond)
+		is_seq = zones_cond[zno] != BLK_ZONE_COND_NOT_WP;
+	rcu_read_unlock();
+
+	return is_seq;
+}
+EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
+
 /*
  * Zone report arguments for block device drivers report_zones operation.
  * @cb: report_zones_cb callback for each reported zone.
@@ -1458,22 +1485,16 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	disk->zone_wplugs_hash_bits = 0;
 }
 
-static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
-					       unsigned long *bitmap)
+static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
 {
-	unsigned int nr_conv_zones = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
-	if (bitmap)
-		nr_conv_zones = bitmap_weight(bitmap, disk->nr_zones);
-	bitmap = rcu_replace_pointer(disk->conv_zones_bitmap, bitmap,
-				     lockdep_is_held(&disk->zone_wplugs_lock));
+	zones_cond = rcu_replace_pointer(disk->zones_cond, zones_cond,
+				lockdep_is_held(&disk->zone_wplugs_lock));
 	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
 
-	kfree_rcu_mightsleep(bitmap);
-
-	return nr_conv_zones;
+	kfree_rcu_mightsleep(zones_cond);
 }
 
 void disk_free_zone_resources(struct gendisk *disk)
@@ -1497,7 +1518,7 @@ void disk_free_zone_resources(struct gendisk *disk)
 	mempool_destroy(disk->zone_wplugs_pool);
 	disk->zone_wplugs_pool = NULL;
 
-	disk_set_conv_zones_bitmap(disk, NULL);
+	disk_set_zones_cond_array(disk, NULL);
 	disk->zone_capacity = 0;
 	disk->last_zone_capacity = 0;
 	disk->nr_zones = 0;
@@ -1516,12 +1537,31 @@ static inline bool disk_need_zone_resources(struct gendisk *disk)
 		queue_emulates_zone_append(disk->queue);
 }
 
+struct blk_revalidate_zone_args {
+	struct gendisk	*disk;
+	u8		*zones_cond;
+	unsigned int	nr_zones;
+	unsigned int	nr_conv_zones;
+	unsigned int	zone_capacity;
+	unsigned int	last_zone_capacity;
+	sector_t	sector;
+};
+
 static int disk_revalidate_zone_resources(struct gendisk *disk,
-					  unsigned int nr_zones)
+				struct blk_revalidate_zone_args *args)
 {
 	struct queue_limits *lim = &disk->queue->limits;
 	unsigned int pool_size;
 
+	args->disk = disk;
+	args->nr_zones =
+		DIV_ROUND_UP_ULL(get_capacity(disk), lim->chunk_sectors);
+
+	/* Cached zone conditions: 1 byte per zone */
+	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
+	if (!args->zones_cond)
+		return -ENOMEM;
+
 	if (!disk_need_zone_resources(disk))
 		return 0;
 
@@ -1531,7 +1571,8 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 	 */
 	pool_size = max(lim->max_open_zones, lim->max_active_zones);
 	if (!pool_size)
-		pool_size = min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, nr_zones);
+		pool_size =
+			min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, args->nr_zones);
 
 	if (!disk->zone_wplugs_hash)
 		return disk_alloc_zone_resources(disk, pool_size);
@@ -1539,15 +1580,6 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 	return 0;
 }
 
-struct blk_revalidate_zone_args {
-	struct gendisk	*disk;
-	unsigned long	*conv_zones_bitmap;
-	unsigned int	nr_zones;
-	unsigned int	zone_capacity;
-	unsigned int	last_zone_capacity;
-	sector_t	sector;
-};
-
 /*
  * Update the disk zone resources information and device queue limits.
  * The disk queue is frozen when this is executed.
@@ -1556,7 +1588,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 				      struct blk_revalidate_zone_args *args)
 {
 	struct request_queue *q = disk->queue;
-	unsigned int nr_seq_zones, nr_conv_zones;
+	unsigned int nr_seq_zones;
 	unsigned int pool_size, memflags;
 	struct queue_limits lim;
 	int ret;
@@ -1566,24 +1598,24 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
-	disk->zone_capacity = args->zone_capacity;
-	disk->last_zone_capacity = args->last_zone_capacity;
-	nr_conv_zones =
-		disk_set_conv_zones_bitmap(disk, args->conv_zones_bitmap);
-	if (nr_conv_zones >= disk->nr_zones) {
+	if (args->nr_conv_zones >= disk->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
-			disk->disk_name, nr_conv_zones, disk->nr_zones);
+			disk->disk_name, args->nr_conv_zones, disk->nr_zones);
 		ret = -ENODEV;
 		goto unfreeze;
 	}
 
+	disk->zone_capacity = args->zone_capacity;
+	disk->last_zone_capacity = args->last_zone_capacity;
+	disk_set_zones_cond_array(disk, args->zones_cond);
+
 	/*
 	 * Some devices can advertize zone resource limits that are larger than
 	 * the number of sequential zones of the zoned block device, e.g. a
 	 * small ZNS namespace. For such case, assume that the zoned device has
 	 * no zone resource limits.
 	 */
-	nr_seq_zones = disk->nr_zones - nr_conv_zones;
+	nr_seq_zones = disk->nr_zones - args->nr_conv_zones;
 	if (lim.max_open_zones >= nr_seq_zones)
 		lim.max_open_zones = 0;
 	if (lim.max_active_zones >= nr_seq_zones)
@@ -1621,6 +1653,44 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	return ret;
 }
 
+static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
+				    struct blk_revalidate_zone_args *args)
+{
+	enum blk_zone_cond cond = zone->cond;
+
+	/* Check that the zone condition is consistent with the zone type. */
+	switch (cond) {
+	case BLK_ZONE_COND_NOT_WP:
+		if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
+			goto invalid_condition;
+		break;
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_FULL:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+		if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
+			goto invalid_condition;
+		break;
+	default:
+		pr_warn("%s: Invalid zone condition 0x%X\n",
+			args->disk->disk_name, cond);
+		return -ENODEV;
+	}
+
+	args->zones_cond[idx] = cond;
+
+	return 0;
+
+invalid_condition:
+	pr_warn("%s: Invalid zone condition 0x%x for type 0x%x\n",
+		args->disk->disk_name, cond, zone->type);
+
+	return -ENODEV;
+}
+
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
 				    struct blk_revalidate_zone_args *args)
 {
@@ -1635,17 +1705,7 @@ static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
 	if (disk_zone_is_last(disk, zone))
 		args->last_zone_capacity = zone->capacity;
 
-	if (!disk_need_zone_resources(disk))
-		return 0;
-
-	if (!args->conv_zones_bitmap) {
-		args->conv_zones_bitmap =
-			bitmap_zalloc(args->nr_zones, GFP_NOIO);
-		if (!args->conv_zones_bitmap)
-			return -ENOMEM;
-	}
-
-	set_bit(idx, args->conv_zones_bitmap);
+	args->nr_conv_zones++;
 
 	return 0;
 }
@@ -1743,6 +1803,11 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
+	/* Check zone condition */
+	ret = blk_revalidate_zone_cond(zone, idx, args);
+	if (ret)
+		return ret;
+
 	/* Check zone type */
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
@@ -1810,10 +1875,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
 	 */
-	args.disk = disk;
-	args.nr_zones = (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
 	noio_flag = memalloc_noio_save();
-	ret = disk_revalidate_zone_resources(disk, args.nr_zones);
+	ret = disk_revalidate_zone_resources(disk, &args);
 	if (ret) {
 		memalloc_noio_restore(noio_flag);
 		return ret;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f75fb15f55f..15cc13006d06 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -196,7 +196,7 @@ struct gendisk {
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
-	unsigned long __rcu	*conv_zones_bitmap;
+	u8 __rcu		*zones_cond;
 	unsigned int		zone_wplugs_hash_bits;
 	atomic_t		nr_zone_wplugs;
 	spinlock_t		zone_wplugs_lock;
@@ -925,6 +925,9 @@ static inline unsigned int bdev_zone_capacity(struct block_device *bdev,
 {
 	return disk_zone_capacity(bdev->bd_disk, pos);
 }
+
+bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector);
+
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
@@ -1533,33 +1536,6 @@ static inline bool bdev_is_zone_aligned(struct block_device *bdev,
 	return bdev_is_zone_start(bdev, sector);
 }
 
-/**
- * bdev_zone_is_seq - check if a sector belongs to a sequential write zone
- * @bdev:	block device to check
- * @sector:	sector number
- *
- * Check if @sector on @bdev is contained in a sequential write required zone.
- */
-static inline bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
-{
-	bool is_seq = false;
-
-#if IS_ENABLED(CONFIG_BLK_DEV_ZONED)
-	if (bdev_is_zoned(bdev)) {
-		struct gendisk *disk = bdev->bd_disk;
-		unsigned long *bitmap;
-
-		rcu_read_lock();
-		bitmap = rcu_dereference(disk->conv_zones_bitmap);
-		is_seq = !bitmap ||
-			!test_bit(disk_zone_no(disk, sector), bitmap);
-		rcu_read_unlock();
-	}
-#endif
-
-	return is_seq;
-}
-
 int blk_zone_issue_zeroout(struct block_device *bdev, sector_t sector,
 			   sector_t nr_sects, gfp_t gfp_mask);
 
-- 
2.51.0


