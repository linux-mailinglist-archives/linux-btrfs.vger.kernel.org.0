Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992643F1921
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhHSM1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376032; x=1660912032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NvhEHYRf6v9MLv00R1539/6EIQsm/kkL5qMr7mYZfuw=;
  b=n4AFHGV2qudguRv8NE0xuD1uPh/rozwgaBakza+ssJBScyOpphZv5yd3
   LGbet0ArCgqrVQSqye1YtS7EGMSxZSFNMcfmhZed66ZRwotnNi3+wl0oo
   phKZyORDUr2dYTqlgnsAr7xCko4RZbqO80Bh/O92fGR3kIzisDehMriHW
   R4rv53AU+fixcZDVYV3dRo5tQrfmeTtr263pve6cXeasKwJGbWkaK6JEJ
   ZrOAM8v6gEP6wpqWwmx2pKRElD4hypqvuVT+Y+TwW0zUFIzEU0XtqaoK8
   jTuTCTI7cYlaWKtCdRVcOLX8KnmaPNExMFJ6/IOwH3ZO2S2G4OSHPHQCx
   w==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773553"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:12 +0800
IronPort-SDR: EPABFxRaWILz5cAH1QH+1ufdOSkvH4tRxfObvoTjb3hdxRDQamZJ7LXMdnq8QbBtUlC7/kd0T1
 Tbgsmvl5cvbrao5xR1fxZiB8s6chpONt4ARL0nYQ6I04pgszcfrVhT9DPSOIP+MVAogWWQGsEp
 zSMddwGftiheQPbexo4RYCclHDTFHazJsXGG9WzVggaba2lBQ7/UM842tOl7N5/XJC3RdRzbWj
 zOcc1T0hv8/+bNcXGH4R1hu5x1HYjasZfNFdhB8eMm7QLFCOQPlehlLGIf0ixuvja9yv8JuhwA
 zIHKbBAc2sx2b/cJOIcQDCjS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:21 -0700
IronPort-SDR: nOrJ2Hg3qzL+nlbs9xGMtsDAf6byYNXdvF9WrGbFLTFF9UWCL/4BgkRvTFF/n5RhJrSWTBvqwh
 A/aB7x82DeRIMQLYkUc4FFTZK21qnC4ekOco606SEHcXE0FeWnful9Ok8x2h8kmPcgXE4CfZl/
 95Otep7Lk3Fi/PxS7WQ8TX1aQGb0zlk21K7gAk8GuiqCeQCx3jSyq6w+CxbzZkMQpNeZAFNGG+
 CWdDxaatr+EqWvnJBOKzGzpuBLCe+DkbUQRTzvyMW2R7oczMObnle7ZvEhhtxEVoSRnB+58o+R
 4Qo=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 05/17] btrfs: zoned: consider zone as full when no more SB can be written
Date:   Thu, 19 Aug 2021 21:19:12 +0900
Message-Id: <7b3768a49229cf41cd86c654d58863cbdaec783e.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We cannot write beyond zone capacity. So, we should consider a zone as
"full" when the write pointer goes beyond capacity - the size of super
info.

Also, take this opportunity to replace a subtle duplicated code with a loop
and fix a typo in comment.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0eb8ea4d3542..d20c97395a70 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -45,6 +45,14 @@
  */
 #define BTRFS_MAX_ZONE_SIZE		SZ_8G
 
+#define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
+
+static inline bool sb_zone_is_full(struct blk_zone *zone)
+{
+	return (zone->cond == BLK_ZONE_COND_FULL) ||
+		(zone->wp + SUPER_INFO_SECTORS > zone->start + zone->capacity);
+}
+
 static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
 {
 	struct blk_zone *zones = data;
@@ -60,14 +68,13 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 	bool empty[BTRFS_NR_SB_LOG_ZONES];
 	bool full[BTRFS_NR_SB_LOG_ZONES];
 	sector_t sector;
+	int i;
 
-	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
-	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
-
-	empty[0] = (zones[0].cond == BLK_ZONE_COND_EMPTY);
-	empty[1] = (zones[1].cond == BLK_ZONE_COND_EMPTY);
-	full[0] = (zones[0].cond == BLK_ZONE_COND_FULL);
-	full[1] = (zones[1].cond == BLK_ZONE_COND_FULL);
+	for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+		ASSERT(zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL);
+		empty[i] = (zones[i].cond == BLK_ZONE_COND_EMPTY);
+		full[i] = sb_zone_is_full(&zones[i]);
+	}
 
 	/*
 	 * Possible states of log buffer zones
@@ -664,7 +671,7 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 			reset = &zones[1];
 
 		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
-			ASSERT(reset->cond == BLK_ZONE_COND_FULL);
+			ASSERT(sb_zone_is_full(reset));
 
 			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
 					       reset->start, reset->len,
-- 
2.33.0

