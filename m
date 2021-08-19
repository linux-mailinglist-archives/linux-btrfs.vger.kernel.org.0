Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE23F1923
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhHSM1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbhHSM1v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376034; x=1660912034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/Os05JdqmaTF1eNNDNXLOUs4+2MAGe0vT6RQUjKbFw=;
  b=XI9OXidrNTASZisskYynmXVvqY4x9M/K+FU757eUM0xhnzDoZDFfasQb
   zLwonv0mZ9RpEoGFIygRAemnPMHv4NzZqOT1v1eQA5gqKXVXXbAKiOH+P
   nPsWz699R2IjT2E4/J6n/6fcWoELzcnmog38th8kFAPs9GagcveCjeh6y
   8U8r4vvlwWVF7lKjyK1WCP9V5UQt1id4ENVSeI0fI5YBfM6J4+W8Qo81l
   gJSzP3luPsx0cG8VXn0zhdvdjSFc1oASQeItE1TrfsgFMH3MJx9OEiGhu
   hlTn1cxIr0rb7HbXud2XCLV30PN10IKSvl3YjZgKUkyUXK/xSYo3rh+sb
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773567"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:14 +0800
IronPort-SDR: 08rrP1O5SJLE/Lp2UzJQb744E1vRAAxtFrUuXGWSRxv+FwuJSs606MPpXSfv+G9HXPgCPENCx3
 kyGXAyHnd9w8VYBkO6rJ7ZZ8xNN02F7e13bLMf51wzUEq0y8gilGHtsitD8ZMR2NWjtbuqv6kG
 KsSEy0xC3jjVdhTyeZGrjs92J0y3Mcnde+siukVnNc264XDWku6XncF+uTujn65ZMpVvvnafCm
 dB1ytO7ao/p4MmJrICUOHqLr23ZQkUdZIi5i3mxqlKHeW63RJ/Q4fbjEPL1ozzdQd9uKVSfoPw
 gL/JxUazvX6Tubae7WJro0mM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:23 -0700
IronPort-SDR: uVq1BfF0Z78zBBP4cltsmZ6qoHod1XNoGm8d0/cuO2PMW3xR8PdgogSW5u1YDkgurR3HWh1DE+
 N/ulTYC30axvN8ujJLS3Bf2VrSWTJAtpRBt/kGoj0lNusn42WtItJi3vazzTEYweMkbnWvjxKa
 LLfWze+35tEiPolaJ2ehy4qE56tkTDPjEUFNEy6tRmC2MML/gdXToFVACDZhQhKd4t/lNa/X9Y
 sEAycSzuP1alP2SF1tq11bAD3s17JgtzoJE+Qj1LIPmE1C39gHYTmFG08mtqa8Qx/+WGfoQZZl
 Z+Q=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 07/17] btrfs: zoned: finish superblock zone once no space left for new SB
Date:   Thu, 19 Aug 2021 21:19:14 +0900
Message-Id: <3c81ee7f5399ad41607640d7bcfb93e63288d49b.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
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
2.33.0

