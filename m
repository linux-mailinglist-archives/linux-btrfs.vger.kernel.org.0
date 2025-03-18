Return-Path: <linux-btrfs+bounces-12348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C0A66464
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 02:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E48C3B8C4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A312BCF5;
	Tue, 18 Mar 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ERqyIBmH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900051474DA;
	Tue, 18 Mar 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259605; cv=none; b=kPuEdxmiutMnAINPSWns7CQAytaOz482QK9K0wALDwWhIZODX9UsxlAMoagPLqcV/AavEmmR9jyNONxssj58p2bAmyXJ/o/TUXGCHq/JY/ocNya14GkC383xJ6Jfe57DHut8BzkB6LQNLW+1mKtsJQivdiNa5aeMj6TSA+aWDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259605; c=relaxed/simple;
	bh=S4kxKJrNpd0fxfoP/VAPApTUQjOV44Sobijrx1UxMzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQziEqm+NUF3+BCme0CVRdFxpPTo5l0RUEVvTUJSQXWpeA5VWF98fqyu+1vGC43M9xGTryBz88Rm+TzzDJJWVhqqGbvFIcRSNXdj+XWzumVHiN7XRAuVAzbqqvUbCSQcnUR+fn6is9k3jk2pqVVM9PvNWaWyza00LzN9pyffKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ERqyIBmH; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742259603; x=1773795603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S4kxKJrNpd0fxfoP/VAPApTUQjOV44Sobijrx1UxMzk=;
  b=ERqyIBmHpaq+iKYPlCNM0vTxqgKesdbWufnXPdrpaRc1u66gBFlK1PhQ
   af0lxr1qhnp5EUj31jrxyK2qOn2D/YqfHD8gY5iscDEJCalNs/T36TjS9
   s0hFh3S7FgsA15fj2kWd3sTdk+MsfX2lu2jw2wz36RvG6WMmXmSrxn+4p
   Pxjhwiz86SMGwv+gkVip1Ix9M5gCYgB+BM5QSC4qNFYlh97whThAroGz1
   5B8UOv4Y9fLecwYvA6Tvxv3XIMGv3doNQh8IzxgC9J8dAipLnfrmPRxtJ
   Oquwqf+WXJfx2uBSKerVEI5JNL3pFLij7st0WID1UZ/uT3y7JW++uPCTj
   g==;
X-CSE-ConnectionGUID: 9G0+KkHxSjqRL8LYp8wDfg==
X-CSE-MsgGUID: tAyntOJHSFabJJtNcqujWA==
X-IronPort-AV: E=Sophos;i="6.14,255,1736784000"; 
   d="scan'208";a="52645829"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 08:59:56 +0800
IronPort-SDR: 67d8b7af_0CjUtiTm887T9CNJUiRkEbby4K6rxrbGhbG1Fsa2fKrIIca
 qA15MnydVei9JR5kVZEKN8wAXkHeu5u1KVx4ILg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2025 17:00:47 -0700
WDCIronportException: Internal
Received: from 5cg21468mp.ad.shared (HELO naota-xeon..) ([10.224.109.129])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Mar 2025 17:59:56 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	hch@infradead.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] block: introduce zone capacity helper
Date: Tue, 18 Mar 2025 09:59:41 +0900
Message-ID: <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742259006.git.naohiro.aota@wdc.com>
References: <cover.1742259006.git.naohiro.aota@wdc.com>
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
---
 include/linux/blkdev.h | 67 ++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d37751789bf5..6f1bdec27ac7 100644
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
+ * disk_zone_capacity - returns the zone capacity of zone at @pos
+ * @disk:	disk to work with
+ * @pos:	sector number within the querying zone
+ *
+ * Returns the zone capacity of a zone at @pos. @pos can be any sector contained
+ * in the zone.
+ */
+static inline unsigned int disk_zone_capacity(struct gendisk *disk,
+					      sector_t pos)
+{
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
+	if (pos + zone_sectors >= get_capacity(disk))
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


