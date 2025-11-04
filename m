Return-Path: <linux-btrfs+bounces-18617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 294FEC2ECF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 02:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E173134D2ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F52264B1;
	Tue,  4 Nov 2025 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CENYhYTH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69F24DCE3;
	Tue,  4 Nov 2025 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220165; cv=none; b=STI3f9WS/9JeebdFI74+ZAFV6Z5ao41i724Me3YsfoDoTai7LuhD6n56+tK8pEMJA5u4Ft+EyfPqnZRtwkLMZ6KjNM+yGJHg+rXIplYL6L4Ga0TraZpSm2Ybtq7I2M8mntsKvcM0eNta3UBU46HFvYz6Sn+vzqK0FOQg1KEkSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220165; c=relaxed/simple;
	bh=lhti3Bmuj8AIwiq9MmprORxEZKyFGs+A4UNqxbkJ10Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUh8QbslAErGl31Q81TKmbUvx2E46mj6hgWdFDbANL2j9Ijar0L3R6nexxGnMhVfeAZROpF/PihSCnjEIkY7OcKnTSCTFqYRCHCX6/2TKsPdtBVhVSmWekqajz59NtqLyOly6fElu1h5M8K/BDkOkJJbPDPinNso5EGVxtK1fKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CENYhYTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AAFC113D0;
	Tue,  4 Nov 2025 01:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220164;
	bh=lhti3Bmuj8AIwiq9MmprORxEZKyFGs+A4UNqxbkJ10Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CENYhYTHWC1Zmu+byXAz5GOdwsMK0EUQkV0JOXaTW2IQ5SueyYjH2zH2CaMa2SbW9
	 tumQiBlwRoTT49WCapf0154EPTk03i+YHmNrcJ7LCd59DAdX8MSH6JHAqs0nDOCQCi
	 AKGaGAAhrkl/z+PmXnDC67RF0fRhig11CfAi+SLv+YxDRhSmAsXD3b7wHw4cDvDs6I
	 tbrLpi6IQ+jjn63zq7NFMIHWWOEhGj3b6bv7PSxEILyEdV9btjyG6UbWlN5scw0EsQ
	 W6anrsl/jwMc+agDxxycBV7x0UBGN9s5p0olijSuGKtHsSM2437R43HBrap4q6EBUm
	 UPQ3GXRvp9BEg==
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
Subject: [PATCH v3 10/15] block: introduce blkdev_report_zones_cached()
Date: Tue,  4 Nov 2025 10:31:42 +0900
Message-ID: <20251104013147.913802-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function blkdev_report_zones_cached() to provide a fast
report zone built using the blkdev_get_zone_info() function, which gets
zone information from a disk zones_cond array or zone write plugs.
For a large capacity SMR drive, such fast report zone can be completed
in a few milliseconds compared to several seconds completion times
when the report zone is obtained from the device.

The zone report is built in the same manner as with the regular
blkdev_report_zones() function, that is, the first zone reported is the
one containing the specified start sector and the report is limited to
the specified number of zones (nr_zones argument). The information for
each zone in the report is obtained using blkdev_get_zone_info().

For zoned devices that do not use zone write plug resources,
using blkdev_get_zone_info() is inefficient as the zone report would
be very slow, generated one zone at a time. To avoid this,
blkdev_report_zones_cached() falls back to calling
blkdev_do_report_zones() to execute a regular zone report. In this case,
the .report_active field of struct blk_report_zones_args is set to true
to report zone conditions using the BLK_ZONE_COND_ACTIVE condition in
place of the implicit open, explicit open and closed conditions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c      | 88 +++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h |  2 +
 2 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dd5f1f703114..fc96cad083fd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -74,6 +74,19 @@ struct blk_zone_wplug {
 	enum blk_zone_cond	cond;
 };
 
+static inline bool disk_need_zone_resources(struct gendisk *disk)
+{
+	/*
+	 * All request-based zoned devices need zone resources so that the
+	 * block layer can automatically handle write BIO plugging. BIO-based
+	 * device drivers (e.g. DM devices) are normally responsible for
+	 * handling zone write ordering and do not need zone resources, unless
+	 * the driver requires zone append emulation.
+	 */
+	return queue_is_mq(disk->queue) ||
+		queue_emulates_zone_append(disk->queue);
+}
+
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
 {
 	return 1U << disk->zone_wplugs_hash_bits;
@@ -963,6 +976,68 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL_GPL(blkdev_get_zone_info);
 
+/**
+ * blkdev_report_zones_cached - Get cached zones information
+ * @bdev:     Target block device
+ * @sector:   Sector from which to report zones
+ * @nr_zones: Maximum number of zones to report
+ * @cb:       Callback function called for each reported zone
+ * @data:     Private data for the callback function
+ *
+ * Description:
+ *    Similar to blkdev_report_zones() but instead of calling into the low level
+ *    device driver to get the zone report from the device, use
+ *    blkdev_get_zone_info() to generate the report from the disk zone write
+ *    plugs and zones condition array. Since calling this function without a
+ *    callback does not make sense, @cb must be specified.
+ */
+int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
+			unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	sector_t capacity = get_capacity(disk);
+	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	unsigned int idx = 0;
+	struct blk_zone zone;
+	int ret;
+
+	if (!cb || !bdev_is_zoned(bdev) ||
+	    WARN_ON_ONCE(!disk->fops->report_zones))
+		return -EOPNOTSUPP;
+
+	if (!nr_zones || sector >= capacity)
+		return 0;
+
+	/*
+	 * If we do not have any zone write plug resources, fallback to using
+	 * the regular zone report.
+	 */
+	if (!disk_need_zone_resources(disk)) {
+		struct blk_report_zones_args args = {
+			.cb = cb,
+			.data = data,
+			.report_active = true,
+		};
+
+		return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
+	}
+
+	for (sector = ALIGN_DOWN(sector, zone_sectors);
+	     sector < capacity && idx < nr_zones;
+	     sector += zone_sectors, idx++) {
+		ret = blkdev_get_zone_info(bdev, sector, &zone);
+		if (ret)
+			return ret;
+
+		ret = cb(&zone, idx, data);
+		if (ret)
+			return ret;
+	}
+
+	return idx;
+}
+EXPORT_SYMBOL_GPL(blkdev_report_zones_cached);
+
 static void blk_zone_reset_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -1773,19 +1848,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
-static inline bool disk_need_zone_resources(struct gendisk *disk)
-{
-	/*
-	 * All mq zoned devices need zone resources so that the block layer
-	 * can automatically handle write BIO plugging. BIO-based device drivers
-	 * (e.g. DM devices) are normally responsible for handling zone write
-	 * ordering and do not need zone resources, unless the driver requires
-	 * zone append emulation.
-	 */
-	return queue_is_mq(disk->queue) ||
-		queue_emulates_zone_append(disk->queue);
-}
-
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	u8		*zones_cond;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 03a594b4dfbc..f0ab02e0a673 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -442,6 +442,8 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
+int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
+		unsigned int nr_zones, report_zones_cb cb, void *data);
 int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		sector_t sectors, sector_t nr_sectors);
 int blk_revalidate_disk_zones(struct gendisk *disk);
-- 
2.51.0


