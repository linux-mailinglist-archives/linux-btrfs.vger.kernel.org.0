Return-Path: <linux-btrfs+bounces-7980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495899776CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89DA2B22224
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31061D3643;
	Fri, 13 Sep 2024 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UDXmWDKt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7461D31BB
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193791; cv=none; b=c8AZlwn66bUjaTs8uJ8RIqBngLTIkRyIUJkq0CbLPuSaV6yj1BRSp0OaLDXCmXu1T5h1JPaXZXA/heBGh6rrWvVtfh19B2KFVNp1Bh5T/mmX264L/smSrshzNM+xf3Yf8Ezj8nLporQRbyZPAIBmq+sEcKBtCY2ZLahBYEhdbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193791; c=relaxed/simple;
	bh=TwcNJHcKPMQfkhqTVL3SwDxpKVZEvzzhV80TEshwm1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9LG+F7ZRpbaS5pmcdbLfcwaQ9PMDf1JS4eHohLL+hjvwKlK/bWAPNrMYEfdEeupGKVj9yePJ0tmKM71LIe4uGoQhegQsbGnmgjltEqiq5VG8Ic9Ep/7GC0x7p4MlbBjkO/HWsUY14rn6E/kGpaofrFyNzU8zFsCO2Kxo7M2tKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UDXmWDKt; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726193788; x=1757729788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TwcNJHcKPMQfkhqTVL3SwDxpKVZEvzzhV80TEshwm1I=;
  b=UDXmWDKtB7Nx1cxS+3OLJq5NmF/VN04TBG+ZJEon4oWtm5ACe1x6R+MU
   jPPfMlw0OV8VK44SmRMOzLSEKkOCBfxvClItffh1sHJokh1Eh9vlHzcrc
   xPOZJdPnjZBSdMaJgPdkQjFsdJUhtKbpWEFa0hNNcut76O+D/h0Hez59g
   HseK7Ik+9xU3Qy6tArj/o6vqLBx50D6tmwhlgWqa9wBQwrjD7+6hhX+9n
   q7utfHgTvqWSWhPUGd3zy4LvBSQvPNr7MTDyKDF5NN/dwhBQqXa/tff8N
   gKuJBtuFi+5cGoo76UuoNpxBA3DMuFw4FMd8aB9KPhmzcPF2WD+cCSjWI
   Q==;
X-CSE-ConnectionGUID: V3EIrnoiRLWrvS4ZBOEqjg==
X-CSE-MsgGUID: SaZEe5keTbm47DS+33zR9g==
X-IronPort-AV: E=Sophos;i="6.10,224,1719849600"; 
   d="scan'208";a="27406957"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2024 10:16:22 +0800
IronPort-SDR: 66e39394_q/ZQSO3sDLEWODcjTnF3mJHDQuSGMObl5VScXevBWEd9JUu
 8vRFmJZeulA2+FMVRwDdWEpAn+LU9Yzp2WZOSeA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 18:21:25 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.124])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Sep 2024 19:16:20 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: xuefer@gmail.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: clear SB magic on conventional zone
Date: Fri, 13 Sep 2024 11:14:27 +0900
Message-ID: <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_reset_sb_log_zones() properly resets a zone if the first zone of SB
log zones is not a conventional zone, which clears a SB magic
properly. However, it leaves SB magic on a conventional zone intact. As a
result, "btrfs delete" cannot remove the SB magic on a conventional
zone. So, re-adding the disk results in an error.

Use the same logic as btrfs_scratch_superblock() to remove the magic, if
the first zone is conventional.

Reported-by: Xuefer <xuefer@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219170
Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c |  6 ++--
 fs/btrfs/volumes.h |  2 ++
 fs/btrfs/zoned.c   | 80 ++++++++++++++++++++++++++++++++++------------
 fs/btrfs/zoned.h   |  4 +--
 4 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4a259bdaa21c..140c4ca74d4f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1270,8 +1270,8 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 	put_page(page);
 }
 
-static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
-						       u64 bytenr, u64 bytenr_orig)
+struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
+						u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
 	struct page *page;
@@ -2101,7 +2101,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
 
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
 		if (bdev_is_zoned(bdev))
-			btrfs_reset_sb_log_zones(bdev, copy_num);
+			btrfs_reset_sb_log_zones(device, copy_num);
 		else
 			btrfs_scratch_superblock(fs_info, bdev, copy_num);
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 03d2d60afe0c..176aa916fc05 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -758,6 +758,8 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
 void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
 void btrfs_release_disk_super(struct btrfs_super_block *super);
+struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev, u64 bytenr,
+						u64 bytenr_orig);
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 41ce252bb8fe..39d37a246b3e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -989,30 +989,70 @@ int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 	return -EIO;
 }
 
-int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
+int btrfs_reset_sb_log_zones(struct btrfs_device *device, int mirror)
 {
-	unsigned int nofs_flags;
-	sector_t zone_sectors;
-	sector_t nr_sectors;
-	u8 zone_sectors_shift;
-	u32 sb_zone;
-	u32 nr_zones;
-	int ret;
-
-	zone_sectors = bdev_zone_sectors(bdev);
-	zone_sectors_shift = ilog2(zone_sectors);
-	nr_sectors = bdev_nr_sectors(bdev);
-	nr_zones = nr_sectors >> zone_sectors_shift;
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u32 sb_zone = sb_zone_number(zinfo->zone_size_shift, mirror);
+	struct blk_zone *zone;
+	int ret = 0;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
-	if (sb_zone + 1 >= nr_zones)
+	if (sb_zone + BTRFS_NR_SB_LOG_ZONES > zinfo->nr_zones)
 		return -ENOENT;
 
-	nofs_flags = memalloc_nofs_save();
-	ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-			       zone_start_sector(sb_zone, bdev),
-			       zone_sectors * BTRFS_NR_SB_LOG_ZONES);
-	memalloc_nofs_restore(nofs_flags);
+	zone = &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		/*
+		 * If the first zone is conventional, the SB is placed at the
+		 * first zone.
+		 */
+
+		u64 bytenr = zone->start << SECTOR_SHIFT;
+		u64 bytenr_orig = btrfs_sb_offset(mirror);
+		struct btrfs_super_block *disk_super;
+		const size_t len = sizeof(disk_super->magic);
+
+		disk_super = btrfs_read_disk_super(device->bdev, bytenr, bytenr_orig);
+		if (IS_ERR(disk_super))
+			return PTR_ERR(disk_super);
+
+		memset(&disk_super->magic, 0, len);
+		folio_mark_dirty(virt_to_folio(disk_super));
+		btrfs_release_disk_super(disk_super);
+
+		ret = sync_blockdev_range(device->bdev, bytenr, bytenr + len - 1);
+	} else {
+		unsigned int nofs_flags;
+
+		/*
+		 * For the other case, all zones must be a sequential required
+		 * zone.
+		 */
+#ifdef CONFIG_BTRFS_ASSERT
+		for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+			ASSERT(zone->type != BLK_ZONE_TYPE_CONVENTIONAL);
+			zone++;
+		}
+		zone = &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
+#endif
+
+		nofs_flags = memalloc_nofs_save();
+		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET, zone->start,
+				       zone->len * BTRFS_NR_SB_LOG_ZONES);
+		memalloc_nofs_restore(nofs_flags);
+
+		if (!ret) {
+			for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+				zone->cond = BLK_ZONE_COND_EMPTY;
+				zone->wp = zone->start;
+				zone++;
+			}
+		}
+	}
+
+	if (ret)
+		btrfs_warn(device->fs_info, "error clearing superblock number %d (%d)", mirror,
+			   ret);
+
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 7612e6572605..eef3272b087c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -65,7 +65,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 			  u64 *bytenr_ret);
 int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
-int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
+int btrfs_reset_sb_log_zones(struct btrfs_device *device, int mirror);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
@@ -155,7 +155,7 @@ static inline int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 	return 0;
 }
 
-static inline int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
+static inline int btrfs_reset_sb_log_zones(struct btrfs_device *device, int mirror)
 {
 	return 0;
 }
-- 
2.46.0


