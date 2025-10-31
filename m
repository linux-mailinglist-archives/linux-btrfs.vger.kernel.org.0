Return-Path: <linux-btrfs+bounces-18439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7AC23581
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B38C4EC8A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCC3064B9;
	Fri, 31 Oct 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTVZy2WC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A229ACC5;
	Fri, 31 Oct 2025 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891422; cv=none; b=W09tyDKi0WNS456oIcZaEFVHCK6bOroQFk8NFhDMfEoHxYoRUual1n/VneI/ljSSQMuVe6B+O/uuqrfK6cwuJcXcL1/G8RwpJZn4Vv1jHnXFHGj7xbZmqMMwduchTvMng4reSbnSuEp5jlEDD22tNM3539SvHxKWNwP7PDBS+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891422; c=relaxed/simple;
	bh=c4dwgdAKJswIhrFy8zNj1UrZtk7QIU2O5wikZQf9l94=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGZ5XxVm/QYnx4pSLrbH1lkI8EkueECtRIz2CQh9+3OT2T8tpD3bSYmNKj1A6jcEmjjsViVRkDMqvzneaAFePJg22ScNbAnEhaWyrk+XI3PLyswrrJRprxwVb6qVJnsRVN5wtCItIiempSdmgf1QFV7DZdaN3gx1QjWrgn1DNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTVZy2WC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C86C4CEFB;
	Fri, 31 Oct 2025 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891422;
	bh=c4dwgdAKJswIhrFy8zNj1UrZtk7QIU2O5wikZQf9l94=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MTVZy2WCV2OyrmEvu/b3ONvDX2vcME9v9JOkgv7LVfnlPSeKZC1lzq2oQQosoBnDV
	 kJfZKf+98GtHrIMdkOUTXKUQwxKlvI1VXIHini+HdmufZKc47rWoL7qpyFFjFAfXfg
	 5HoabI+30DN5Wm84DJeqSQVHbHH9xU45ZyAdJc9sBYkEqy+8yEZy3/rbLQJGJc4OhQ
	 x47rBGxMMBfOQM4ESr54SLiHyjYD+4XnLYw4XEN9EL73Z8zgZ60G+kx+LkffqDz58w
	 +EgURJ0x+f8huHJP0V7GvNNy06/qBv5/zuMfn/oJW4ud+lP8/aXoqnyHGSd0cheWb1
	 80/16N4PbaSnQ==
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
Subject: [PATCH 04/13] block: introduce disk_report_zone()
Date: Fri, 31 Oct 2025 15:12:58 +0900
Message-ID: <20251031061307.185513-5-dlemoal@kernel.org>
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

Commit b76b840fd933 ("dm: Fix dm-zoned-reclaim zone write pointer
alignment") introduced an indirect call for the callback function of a
report zones executed with blkdev_report_zones(). This is necessary so
that the function disk_zone_wplug_sync_wp_offset() can be called to
refresh a zone write plug zone write pointer offset after a write error.
However, this solution makes following the path of a zone information
harder to understand.

Clean this up by introducing the new blk_report_zones_args structure to
define a zone report callback and its private data and introduce the
helper function disk_report_zone() which calls both
disk_zone_wplug_sync_wp_offset() and the zone report user callback
function for all zones of a zone report. This helper function must be
called by all block device drivers that implement the report zones
block operation in order to correctly report a zone information.

All block device drivers supporting the report_zones block operation are
updated to use this new scheme.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c                 | 79 ++++++++++++++++---------------
 drivers/block/null_blk/null_blk.h |  3 +-
 drivers/block/null_blk/zoned.c    |  4 +-
 drivers/block/ublk_drv.c          |  4 +-
 drivers/block/virtio_blk.c        | 11 +++--
 drivers/block/zloop.c             |  4 +-
 drivers/md/dm-zone.c              | 54 +++++++++++----------
 drivers/md/dm.h                   |  3 +-
 drivers/nvme/host/core.c          |  5 +-
 drivers/nvme/host/multipath.c     |  4 +-
 drivers/nvme/host/nvme.h          |  2 +-
 drivers/nvme/host/zns.c           | 10 ++--
 drivers/scsi/sd.h                 |  2 +-
 drivers/scsi/sd_zbc.c             | 17 +++----
 include/linux/blkdev.h            |  7 ++-
 include/linux/device-mapper.h     | 10 +++-
 16 files changed, 119 insertions(+), 100 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index b6332b3124fc..603ed8dc472c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -114,30 +114,16 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-struct disk_report_zones_cb_args {
-	struct gendisk	*disk;
-	report_zones_cb	user_cb;
-	void		*user_data;
+/*
+ * Zone report arguments for block device drivers report_zones operation.
+ * @cb: report_zones_cb callback for each reported zone.
+ * @data: Private data passed to report_zones_cb.
+ */
+struct blk_report_zones_args {
+	report_zones_cb cb;
+	void		*data;
 };
 
-static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
-					   struct blk_zone *zone);
-
-static int disk_report_zones_cb(struct blk_zone *zone, unsigned int idx,
-				void *data)
-{
-	struct disk_report_zones_cb_args *args = data;
-	struct gendisk *disk = args->disk;
-
-	if (disk->zone_wplugs_hash)
-		disk_zone_wplug_sync_wp_offset(disk, zone);
-
-	if (!args->user_cb)
-		return 0;
-
-	return args->user_cb(zone, idx, args->user_data);
-}
-
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
@@ -161,10 +147,9 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	struct disk_report_zones_cb_args args = {
-		.disk = disk,
-		.user_cb = cb,
-		.user_data = data,
+	struct blk_report_zones_args args = {
+		.cb = cb,
+		.data = data,
 	};
 
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
@@ -173,8 +158,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
-	return disk->fops->report_zones(disk, sector, nr_zones,
-					disk_report_zones_cb, &args);
+	return disk->fops->report_zones(disk, sector, nr_zones, &args);
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
 
@@ -692,15 +676,32 @@ static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 	disk_put_zone_wplug(zwplug);
 }
 
-static int disk_zone_sync_wp_offset(struct gendisk *disk, sector_t sector)
+/**
+ * disk_report_zone - Report one zone
+ * @disk:	Target disk
+ * @zone:	The zone to report
+ * @idx:	The index of the zone in the overall zone report
+ * @args:	report zones callback and data
+ *
+ * Description:
+ *    Helper function for block device drivers to report one zone of a zone
+ *    report initiated with blkdev_report_zones(). The zone being reported is
+ *    specified by @zone and used to update, if necessary, the zone write plug
+ *    information for the zone. If @args specifies a user callback function,
+ *    this callback is executed.
+ */
+int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
+		     unsigned int idx, struct blk_report_zones_args *args)
 {
-	struct disk_report_zones_cb_args args = {
-		.disk = disk,
-	};
+	if (disk->zone_wplugs_hash)
+		disk_zone_wplug_sync_wp_offset(disk, zone);
+
+	if (args && args->cb)
+		return args->cb(zone, idx, args->data);
 
-	return disk->fops->report_zones(disk, sector, 1,
-					disk_report_zones_cb, &args);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(disk_report_zone);
 
 static void blk_zone_reset_bio_endio(struct bio *bio)
 {
@@ -1783,6 +1784,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
 	unsigned int noio_flag;
+	struct blk_report_zones_args rep_args = {
+		.cb = blk_revalidate_zone_cb,
+		.data = &args,
+	};
 	int ret = -ENOMEM;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
@@ -1814,8 +1819,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		return ret;
 	}
 
-	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
-				       blk_revalidate_zone_cb, &args);
+	ret = disk->fops->report_zones(disk, 0, UINT_MAX, &rep_args);
 	if (!ret) {
 		pr_warn("%s: No zones reported\n", disk->disk_name);
 		ret = -ENODEV;
@@ -1866,6 +1870,7 @@ EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
 int blk_zone_issue_zeroout(struct block_device *bdev, sector_t sector,
 			   sector_t nr_sects, gfp_t gfp_mask)
 {
+	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
 	if (WARN_ON_ONCE(!bdev_is_zoned(bdev)))
@@ -1881,7 +1886,7 @@ int blk_zone_issue_zeroout(struct block_device *bdev, sector_t sector,
 	 * pointer. Undo this using a report zone to update the zone write
 	 * pointer to the correct current value.
 	 */
-	ret = disk_zone_sync_wp_offset(bdev->bd_disk, sector);
+	ret = disk->fops->report_zones(disk, sector, 1, NULL);
 	if (ret != 1)
 		return ret < 0 ? ret : -EIO;
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 7bb6128dbaaf..6c4c4bbe7dad 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -143,7 +143,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
 int null_register_zoned_dev(struct nullb *nullb);
 void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
-		      unsigned int nr_zones, report_zones_cb cb, void *data);
+		      unsigned int nr_zones,
+		      struct blk_report_zones_args *args);
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
 				    sector_t sector, sector_t nr_sectors);
 size_t null_zone_valid_read_len(struct nullb *nullb,
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 4e5728f45989..6a93b12a06ff 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -191,7 +191,7 @@ void null_free_zoned_dev(struct nullb_device *dev)
 }
 
 int null_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
+		unsigned int nr_zones, struct blk_report_zones_args *args)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
@@ -225,7 +225,7 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 		blkz.capacity = zone->capacity;
 		null_unlock_zone(dev, zone);
 
-		error = cb(&blkz, i, data);
+		error = disk_report_zone(disk, &blkz, i, args);
 		if (error)
 			return error;
 	}
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0c74a41a6753..b1549e56c69b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -368,7 +368,7 @@ static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
 }
 
 static int ublk_report_zones(struct gendisk *disk, sector_t sector,
-		      unsigned int nr_zones, report_zones_cb cb, void *data)
+		      unsigned int nr_zones, struct blk_report_zones_args *args)
 {
 	struct ublk_device *ub = disk->private_data;
 	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
@@ -431,7 +431,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			if (!zone->len)
 				break;
 
-			ret = cb(zone, i, data);
+			ret = disk_report_zone(disk, zone, i, args);
 			if (ret)
 				goto out;
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f061420dfb10..a5e97f03dbf0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -584,7 +584,8 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 
 static int virtblk_parse_zone(struct virtio_blk *vblk,
 			       struct virtio_blk_zone_descriptor *entry,
-			       unsigned int idx, report_zones_cb cb, void *data)
+			       unsigned int idx,
+			       struct blk_report_zones_args *args)
 {
 	struct blk_zone zone = { };
 
@@ -650,12 +651,12 @@ static int virtblk_parse_zone(struct virtio_blk *vblk,
 	 * The callback below checks the validity of the reported
 	 * entry data, no need to further validate it here.
 	 */
-	return cb(&zone, idx, data);
+	return disk_report_zone(vblk->disk, &zone, idx, args);
 }
 
 static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
-				 unsigned int nr_zones, report_zones_cb cb,
-				 void *data)
+				 unsigned int nr_zones,
+				 struct blk_report_zones_args *args)
 {
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_blk_zone_report *report;
@@ -693,7 +694,7 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
 			ret = virtblk_parse_zone(vblk, &report->zones[i],
-						 zone_idx, cb, data);
+						 zone_idx, args);
 			if (ret)
 				goto fail_report;
 
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index a423228e201b..92be9f0af00a 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -647,7 +647,7 @@ static int zloop_open(struct gendisk *disk, blk_mode_t mode)
 }
 
 static int zloop_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
+		unsigned int nr_zones, struct blk_report_zones_args *args)
 {
 	struct zloop_device *zlo = disk->private_data;
 	struct blk_zone blkz = {};
@@ -687,7 +687,7 @@ static int zloop_report_zones(struct gendisk *disk, sector_t sector,
 
 		mutex_unlock(&zone->lock);
 
-		ret = cb(&blkz, i, data);
+		ret = disk_report_zone(disk, &blkz, i, args);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 78e17dd4d01b..984fb621b0e9 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -17,33 +17,26 @@
  * For internal zone reports bypassing the top BIO submission path.
  */
 static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
-				  sector_t sector, unsigned int nr_zones,
-				  report_zones_cb cb, void *data)
+				  unsigned int nr_zones,
+				  struct dm_report_zones_args *args)
 {
-	struct gendisk *disk = md->disk;
-	int ret;
-	struct dm_report_zones_args args = {
-		.next_sector = sector,
-		.orig_data = data,
-		.orig_cb = cb,
-	};
-
 	do {
 		struct dm_target *tgt;
+		int ret;
 
-		tgt = dm_table_find_target(t, args.next_sector);
+		tgt = dm_table_find_target(t, args->next_sector);
 		if (WARN_ON_ONCE(!tgt->type->report_zones))
 			return -EIO;
 
-		args.tgt = tgt;
-		ret = tgt->type->report_zones(tgt, &args,
-					      nr_zones - args.zone_idx);
+		args->tgt = tgt;
+		ret = tgt->type->report_zones(tgt, args,
+					      nr_zones - args->zone_idx);
 		if (ret < 0)
 			return ret;
-	} while (args.zone_idx < nr_zones &&
-		 args.next_sector < get_capacity(disk));
+	} while (args->zone_idx < nr_zones &&
+		 args->next_sector < get_capacity(md->disk));
 
-	return args.zone_idx;
+	return args->zone_idx;
 }
 
 /*
@@ -52,7 +45,8 @@ static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
  * generally implemented by targets using dm_report_zones().
  */
 int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-			unsigned int nr_zones, report_zones_cb cb, void *data)
+			unsigned int nr_zones,
+			struct blk_report_zones_args *args)
 {
 	struct mapped_device *md = disk->private_data;
 	struct dm_table *map;
@@ -76,9 +70,14 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 		map = zone_revalidate_map;
 	}
 
-	if (map)
-		ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb,
-					     data);
+	if (map) {
+		struct dm_report_zones_args dm_args = {
+			.disk = md->disk,
+			.next_sector = sector,
+			.rep_args = args,
+		};
+		ret = dm_blk_do_report_zones(md, map, nr_zones, &dm_args);
+	}
 
 	if (put_table)
 		dm_put_live_table(md, srcu_idx);
@@ -113,7 +112,9 @@ static int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx,
 	}
 
 	args->next_sector = zone->start + zone->len;
-	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
+
+	return disk_report_zone(args->disk, zone, args->zone_idx++,
+				args->rep_args);
 }
 
 /*
@@ -492,10 +493,15 @@ int dm_zone_get_reset_bitmap(struct mapped_device *md, struct dm_table *t,
 			     sector_t sector, unsigned int nr_zones,
 			     unsigned long *need_reset)
 {
+	struct dm_report_zones_args args = {
+		.disk = md->disk,
+		.next_sector = sector,
+		.cb = dm_zone_need_reset_cb,
+		.data = need_reset,
+	};
 	int ret;
 
-	ret = dm_blk_do_report_zones(md, t, sector, nr_zones,
-				     dm_zone_need_reset_cb, need_reset);
+	ret = dm_blk_do_report_zones(md, t, nr_zones, &args);
 	if (ret != nr_zones) {
 		DMERR("Get %s zone reset bitmap failed\n",
 		      md->disk->disk_name);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index 245f52b59215..7a795979ec72 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -109,7 +109,8 @@ void dm_finalize_zone_settings(struct dm_table *t, struct queue_limits *lim);
 void dm_zone_endio(struct dm_io *io, struct bio *clone);
 #ifdef CONFIG_BLK_DEV_ZONED
 int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
-			unsigned int nr_zones, report_zones_cb cb, void *data);
+			unsigned int nr_zones,
+			struct blk_report_zones_args *args);
 bool dm_is_zone_write(struct mapped_device *md, struct bio *bio);
 int dm_zone_get_reset_bitmap(struct mapped_device *md, struct dm_table *t,
 			     sector_t sector, unsigned int nr_zones,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de73..c0fe50fb7b08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2599,10 +2599,9 @@ static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static int nvme_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
+		unsigned int nr_zones, struct blk_report_zones_args *args)
 {
-	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
-			data);
+	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, args);
 }
 #else
 #define nvme_report_zones	NULL
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 543e17aead12..0b7ac0735bd0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -576,7 +576,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
+		unsigned int nr_zones, struct blk_report_zones_args *args)
 {
 	struct nvme_ns_head *head = disk->private_data;
 	struct nvme_ns *ns;
@@ -585,7 +585,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (ns)
-		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
+		ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..928c748ccbd1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1108,7 +1108,7 @@ struct nvme_zone_info {
 };
 
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data);
+		unsigned int nr_zones, struct blk_report_zones_args *args);
 int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
 		struct nvme_zone_info *zi);
 void nvme_update_zone_info(struct nvme_ns *ns, struct queue_limits *lim,
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index cce4c5b55aa9..deea2dbef5b8 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -148,8 +148,8 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 
 static int nvme_zone_parse_entry(struct nvme_ns *ns,
 				 struct nvme_zone_descriptor *entry,
-				 unsigned int idx, report_zones_cb cb,
-				 void *data)
+				 unsigned int idx,
+				 struct blk_report_zones_args *args)
 {
 	struct nvme_ns_head *head = ns->head;
 	struct blk_zone zone = { };
@@ -169,11 +169,11 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	else
 		zone.wp = nvme_lba_to_sect(head, le64_to_cpu(entry->wp));
 
-	return cb(&zone, idx, data);
+	return disk_report_zone(ns->disk, &zone, idx, args);
 }
 
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data)
+		unsigned int nr_zones, struct blk_report_zones_args *args)
 {
 	struct nvme_zone_report *report;
 	struct nvme_command c = { };
@@ -213,7 +213,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
 			ret = nvme_zone_parse_entry(ns, &report->entries[i],
-						    zone_idx, cb, data);
+						    zone_idx, args);
 			if (ret)
 				goto out_free;
 			zone_idx++;
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 36382eca941c..574af8243016 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -240,7 +240,7 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			     struct scsi_sense_hdr *sshdr);
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
-		unsigned int nr_zones, report_zones_cb cb, void *data);
+		unsigned int nr_zones, struct blk_report_zones_args *args);
 
 #else /* CONFIG_BLK_DEV_ZONED */
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index a8db66428f80..e57595a36dc5 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -44,12 +44,11 @@ static bool sd_zbc_is_gap_zone(const u8 buf[64])
  * call @cb(blk_zone, @data).
  */
 static int sd_zbc_parse_report(struct scsi_disk *sdkp, const u8 buf[64],
-			       unsigned int idx, report_zones_cb cb, void *data)
+			unsigned int idx, struct blk_report_zones_args *args)
 {
 	struct scsi_device *sdp = sdkp->device;
 	struct blk_zone zone = { 0 };
 	sector_t start_lba, gran;
-	int ret;
 
 	if (WARN_ON_ONCE(sd_zbc_is_gap_zone(buf)))
 		return -EINVAL;
@@ -87,11 +86,7 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, const u8 buf[64],
 	else
 		zone.wp = logical_to_sectors(sdp, get_unaligned_be64(&buf[24]));
 
-	ret = cb(&zone, idx, data);
-	if (ret)
-		return ret;
-
-	return 0;
+	return disk_report_zone(sdkp->disk, &zone, idx, args);
 }
 
 /**
@@ -217,14 +212,14 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
  * @disk: Disk to report zones for.
  * @sector: Start sector.
  * @nr_zones: Maximum number of zones to report.
- * @cb: Callback function called to report zone information.
- * @data: Second argument passed to @cb.
+ * @args: Callback arguments.
  *
  * Called by the block layer to iterate over zone information. See also the
  * disk->fops->report_zones() calls in block/blk-zoned.c.
  */
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
-			unsigned int nr_zones, report_zones_cb cb, void *data)
+			unsigned int nr_zones,
+			struct blk_report_zones_args *args)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
 	sector_t lba = sectors_to_logical(sdkp->device, sector);
@@ -283,7 +278,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			}
 
 			ret = sd_zbc_parse_report(sdkp, buf + offset, zone_idx,
-						  cb, data);
+						  args);
 			if (ret)
 				goto out;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99be263b31ab..2f75fb15f55f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -38,6 +38,7 @@ struct blk_flush_queue;
 struct kiocb;
 struct pr_ops;
 struct rq_qos;
+struct blk_report_zones_args;
 struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_crypto_profile;
@@ -432,6 +433,9 @@ struct queue_limits {
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
+int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
+		     unsigned int idx, struct blk_report_zones_args *args);
+
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
@@ -1662,7 +1666,8 @@ struct block_device_operations {
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
-			unsigned int nr_zones, report_zones_cb cb, void *data);
+			    unsigned int nr_zones,
+			    struct blk_report_zones_args *args);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 84fdc3a6a19a..38f625af6ab4 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -538,12 +538,18 @@ void dm_submit_bio_remap(struct bio *clone, struct bio *tgt_clone);
 #ifdef CONFIG_BLK_DEV_ZONED
 struct dm_report_zones_args {
 	struct dm_target *tgt;
+	struct gendisk *disk;
 	sector_t next_sector;
 
-	void *orig_data;
-	report_zones_cb orig_cb;
 	unsigned int zone_idx;
 
+	/* for block layer ->report_zones */
+	struct blk_report_zones_args *rep_args;
+
+	/* for internal users */
+	report_zones_cb cb;
+	void *data;
+
 	/* must be filled by ->report_zones before calling dm_report_zones_cb */
 	sector_t start;
 };
-- 
2.51.0


