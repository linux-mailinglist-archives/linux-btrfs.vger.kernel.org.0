Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2E3E9388
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhHKOVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35974 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhHKOVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691653; x=1660227653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7hltgxblR23hImnrXs7/wUSzAFM0N8z5c4FTzz+w/8=;
  b=S38HEp2TW6M0rS8egckw3bKuBUt9Bi/JMvlsxWEi4GtDkEOVkAyoM7wv
   Zpmzb/O3d96RgpeSpTykthPNmJIWczT2KDEbTs/YN6/kcKvOTWKwpHpys
   jVtuv3Ptq1SPZONfDkCroPqCgYBqREE8aw1aB4kKDgEfc+eJKnnAHrEOv
   488Gs7Rd4kR973AdmvTHiOOS1XCpXPGp2MkzcpnUJz/MfY29ka92E2oqd
   U9lh7UxaHRvfxzkz8q+qsIbgs6TX4FwV2j5J9QRI+njE+tpTVyAAOJK6r
   TZ3oUmgNmgMQZDOgDwQhd1SQy63Ts9Ey0+EiIdF5Ikqsmp6oaQYozf9HD
   g==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937885"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:53 +0800
IronPort-SDR: qGkLLFzHc33wZ/YIVL7N7inWwQ0GMTC6klYJ+71UsWHyO57oyWdCCATMMXlvxyWaJxXDC+CONW
 y45H66fryF+J527mFxYFOAvv4SxQNB5FGDqPLBJa3aWptIuBaXouCINZDt5Iv4HpID1xD6C8xa
 UqGiG58LM9Xw/F6yazev2aZtCwLE1MPvblP+zIGU00iYC85V8URD7R0J+QdHx2J2cOZ2GfQox1
 fa3l62C5tcnoVkJD0DYG26M6qCOm4+iIqHfs5goUBqnca7Y2HQOVuPXRqJ6qNGGka4i4q0CCe5
 gwW1HEbamRkkEWcQfXTBPBUd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:23 -0700
IronPort-SDR: QBlztBBOiDwVoMVsrXy5hdoRY5gwMevpoORxUFkQBGuaFsZkigxgffzul4Q+DDCONO0Pbz5xrb
 AcYvpzUza6iZyUJIf/xQPCKYo9erSF3CoqPrp+0JSSsb/COOV0YfSD3JCt7ZRVIJl3wTsjjxCZ
 U2MxbjTZICerxVsN76xUYa91PKr8LHb87r8qrkhNxNEkJUV62KPe+sxYecAWl4lH6JJxQKA2Ew
 1VK7VkuXdo2kXEXTR6wQTGLe7vAqEZsV8x/XgfbAwa8PX8fSYNJmAw7sAbNgx0CmoAu3O7S1aF
 V90=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:52 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/17] btrfs: zoned: finish superblock zone once no space left for new SB
Date:   Wed, 11 Aug 2021 23:16:31 +0900
Message-Id: <bc2556c3d9f253eec39aad5382969a36f844325a.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there is no more space left for a new superblock in a superblock zone,
then it is better to ZONE_FINISH the zone and frees up the active zone
count.

Since btrfs_advance_sb_log() can now issue REQ_OP_ZONE_FINISH, we also need
to convert it to return int for the error case.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c |  4 +++-
 fs/btrfs/zoned.c   | 53 ++++++++++++++++++++++++++++++++--------------
 fs/btrfs/zoned.h   |  8 ++++---
 3 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2f9515dccce0..74b8848de8da 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3881,7 +3881,9 @@ static int write_dev_supers(struct btrfs_device *device,
 			bio->bi_opf |= REQ_FUA;
 
 		btrfsic_submit_bio(bio);
-		btrfs_advance_sb_log(device, i);
+
+		if (btrfs_advance_sb_log(device, i))
+			errors++;
 	}
 	return errors < i ? 0 : -1;
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188a4ebefe59..3eb74542a9b1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -789,36 +789,57 @@ static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
 	return true;
 }
 
-void btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
+int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 {
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	struct blk_zone *zone;
+	int i;
 
 	if (!is_sb_log_zone(zinfo, mirror))
-		return;
+		return 0;
 
 	zone = &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
-	if (zone->cond != BLK_ZONE_COND_FULL) {
+	for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+		/* Advance the next zone */
+		if (zone->cond == BLK_ZONE_COND_FULL) {
+			zone++;
+			continue;
+		}
+
 		if (zone->cond == BLK_ZONE_COND_EMPTY)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
-		zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+		zone->wp += SUPER_INFO_SECTORS;
+
+		if (sb_zone_is_full(zone)) {
+			/*
+			 * No room left to write new superblock. Since
+			 * superblock is written with REQ_SYNC, it is safe
+			 * to finish the zone now.
+			 *
+			 * If the write pointer is exactly at the capacity,
+			 * explicit ZONE_FINISH is not necessary.
+			 */
+			if (zone->wp != zone->start + zone->capacity) {
+				int ret;
+
+				ret = blkdev_zone_mgmt(device->bdev,
+						       REQ_OP_ZONE_FINISH,
+						       zone->start, zone->len,
+						       GFP_NOFS);
+				if (ret)
+					return ret;
+			}
 
-		if (zone->wp == zone->start + zone->len)
+			zone->wp = zone->start + zone->len;
 			zone->cond = BLK_ZONE_COND_FULL;
-
-		return;
+		}
+		return 0;
 	}
 
-	zone++;
-	ASSERT(zone->cond != BLK_ZONE_COND_FULL);
-	if (zone->cond == BLK_ZONE_COND_EMPTY)
-		zone->cond = BLK_ZONE_COND_IMP_OPEN;
-
-	zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
-
-	if (zone->wp == zone->start + zone->len)
-		zone->cond = BLK_ZONE_COND_FULL;
+	/* All the zones are FULL. Should not reach here. */
+	ASSERT(0);
+	return -EIO;
 }
 
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 4b299705bb12..4f30f3bf1886 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -40,7 +40,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 			  u64 *bytenr_ret);
-void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
+int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
@@ -113,8 +113,10 @@ static inline int btrfs_sb_log_location(struct btrfs_device *device, int mirror,
 	return 0;
 }
 
-static inline void btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
-{ }
+static inline int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
+{
+	return 0;
+}
 
 static inline int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 {
-- 
2.32.0

