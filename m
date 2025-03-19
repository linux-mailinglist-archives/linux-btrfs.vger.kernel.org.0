Return-Path: <linux-btrfs+bounces-12395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058A3A682EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 02:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FC23B29B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 01:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1A24E4B9;
	Wed, 19 Mar 2025 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WyLENFQM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D52248B5;
	Wed, 19 Mar 2025 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349126; cv=none; b=RcMU3zkjhTH75F22qu6XsIETo9fjNf2bRUQUqUQj5OwN07XqeKRJR4hr+2W5AiidNLtFKXDfJSW2h5ymwj25asbEhLiGnEUQCYJOPHqR3R3nAInIdIEDh8ikY6hbPReYgPPigxAE1dZG4mJLJIjt4YWgcTEd169uMK9+lgCfAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349126; c=relaxed/simple;
	bh=Xzj5eSTAMgHw9vpP+UlDGT6rGrjf+fdOysagLVZKD9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcKBKrJpNuyZD8Fa34I5F/B4dyLgL+gu2TKQTQ+7/LQ1V3lpD7cHzr3LHVgVt2yn2CIWYaF7WihQ5O+j6zAF3XEKZmTDduByu22pUjqwuHWXMONNSNpHz4hiZkUDkkyqrspHMbosBOeG6LPjYXFIDu8apVod2IshUdB/Mg4P1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WyLENFQM; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742349124; x=1773885124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xzj5eSTAMgHw9vpP+UlDGT6rGrjf+fdOysagLVZKD9w=;
  b=WyLENFQMCwGA9JArbPWj40yPLJ5ypncXKZUbTrYGfHsSVhK0gh7ZI9Qf
   edjnqBnU3nyCopCnyhK9sRu21MomoDEIQns52SQWY+qOZIgRn/+5N/QU0
   tetzJxAkDtVKltC/oNZ/8AZ19/aS74BtA2TGSC7eNcAYLO5Dxb8ZRTTRd
   p7hlI4GxhQRbLKI5Y9xRyXQ+e9gugsAVFuxIS8R8Ov0xQBmEnav0MzVe8
   SKOB6gMHExW6lJ1VGI+FqBXQx5qaIR/T58lQosDBa6clfUXMPwxhKJLrS
   JEG1ShRXWwutAKPmBDZapYc8VqpD332xDCSYmU59sP7rUt626WmCxFoQn
   g==;
X-CSE-ConnectionGUID: jRZkdJYaQQOYrTghbhjhQQ==
X-CSE-MsgGUID: J8Adb60iTMmwMXJumU+LQw==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55009580"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 09:52:03 +0800
IronPort-SDR: 67da1564_Xx0LaSDx5qs+6rABDoPurOSHxjtWl799lRvlqUbCS6ntwAe
 PsU8iLfgSPflX3P2e3HIFoB5s+pa+j5xCN8WLrg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 17:52:52 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 18:52:03 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	hch@infradead.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] block: introduce zone capacity helper
Date: Wed, 19 Mar 2025 10:49:16 +0900
Message-ID: <3b1a27ddd0a5c0bc1e60d9802eb43c91c7d22617.1742348826.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742348826.git.naohiro.aota@wdc.com>
References: <cover.1742348826.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

{bdev,disk}_zone_capacity() takes block_device or gendisk and sector position
and returns the zone capacity of the corresponding zone.

With that, move disk_nr_zones() and blk_zone_plug_bio() to consolidate them in
the same #ifdef block.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blkdev.h | 67 ++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d37751789bf5..c57babb0adb9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -691,23 +691,6 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 		(q->limits.features & BLK_FEAT_ZONED);
 }
 
-#ifdef CONFIG_BLK_DEV_ZONED
-static inline unsigned int disk_nr_zones(struct gendisk *disk)
-{
-	return disk->nr_zones;
-}
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
-#else /* CONFIG_BLK_DEV_ZONED */
-static inline unsigned int disk_nr_zones(struct gendisk *disk)
-{
-	return 0;
-}
-static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
-{
-	return false;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	if (!blk_queue_is_zoned(disk->queue))
@@ -715,11 +698,6 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return sector >> ilog2(disk->queue->limits.chunk_sectors);
 }
 
-static inline unsigned int bdev_nr_zones(struct block_device *bdev)
-{
-	return disk_nr_zones(bdev->bd_disk);
-}
-
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return bdev->bd_disk->queue->limits.max_open_zones;
@@ -826,6 +804,51 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
 		(sb->s_blocksize_bits - SECTOR_SHIFT);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline unsigned int disk_nr_zones(struct gendisk *disk)
+{
+	return disk->nr_zones;
+}
+bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
+
+/**
+ * disk_zone_capacity - returns the zone capacity of zone containing @sector
+ * @disk:	disk to work with
+ * @sector:	sector number within the querying zone
+ *
+ * Returns the zone capacity of a zone containing @sector. @sector can be any
+ * sector in the zone.
+ */
+static inline unsigned int disk_zone_capacity(struct gendisk *disk,
+					      sector_t sector)
+{
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
+	if (sector + zone_sectors >= get_capacity(disk))
+		return disk->last_zone_capacity;
+	return disk->zone_capacity;
+}
+static inline unsigned int bdev_zone_capacity(struct block_device *bdev,
+					      sector_t pos)
+{
+	return disk_zone_capacity(bdev->bd_disk, pos);
+}
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline unsigned int disk_nr_zones(struct gendisk *disk)
+{
+	return 0;
+}
+static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
+{
+	return false;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+static inline unsigned int bdev_nr_zones(struct block_device *bdev)
+{
+	return disk_nr_zones(bdev->bd_disk);
+}
+
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 
 void put_disk(struct gendisk *disk);
-- 
2.49.0


