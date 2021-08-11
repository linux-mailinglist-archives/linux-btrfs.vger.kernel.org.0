Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0D3E9386
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhHKOVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35974 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhHKOVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691650; x=1660227650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPFgbVgcLq2p0fDO+TzE8v4FfTU1y2CyIExGFOZBU4U=;
  b=lkwXirpC2kg5rstVsGOvol0imsqB3xN/sA+Rd30mtWGQCxVryaxjhqcI
   YkHF1o2Hx9gwXHzuirLhTFjup8zsAeYO358jkBTIjnrl6owoD2VIzQSgk
   YyVL4sZnvsAsPeLskVXuJ4UPBzt+epAXx5UHuLzmLgywmSdUIFGzLaIvw
   mefcFCldvPkqWmckRCjQMZTjn3vqG82TyMekgvNMKmhejcUlwTxqYbIxx
   4EqWn9qD0d0XWR08lYuQt1pCFnXMkGSIVJwci53K2FnMYoH93/h1M/H3f
   rX77yf+TO3ug3S/pjdWfWYc+9Mu8kiCq55eFZv8LBs4c7jZTupFG4C0jh
   g==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937877"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:50 +0800
IronPort-SDR: tYzRNHDHt+wuvc11QvVvNFhqbspmie9W5Yy+YmYRD6qEY8ttGrxquF/ZNt+q/7TfK8LnKjqpbk
 wEe6/J9EDot+MZbpy9X1ZB1K1DslgAfb7lgwvOU1qm3nRAgD9MjXzQ86dvU3PPlO5Ye9Q8A06M
 LnZEsf5AXtELt1PvQ430uRqJpU5u6azlI5tb5P0Hc3Bc8w6hZK+177cv4LeTHTkvkxaf5Q0kol
 +0ACKTMNFczUVUpFuWpSmbb4673mZB2A5h5vPJ9Pc0RWkVxLCWGC0e57K6r68YJjXuAJbNtpPg
 wgLJJdB6pF717ZGScH2B8GgC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:21 -0700
IronPort-SDR: jW/azO0ZT6HunARblGz/zzuC3/8jFF21hKVJGuyAigzQ3HzsZscaWsIxlPP5tmEW8pNKhSkgiZ
 /ZrY06qtacySGbCvqI1sCr7W5f0tl4R0yTTtrASfZhctKwuJeiWpiRGq1xmodhzowiWtAIcPqR
 E5Ryu6V7MI5cGdR/sZfDWhKbzO9Csc7LLjhBiUkMHMs+mk4gPk9R7dFUr8Y8M5LtlTU9qMPcjL
 EtGV4siGM3FN945ka9rXuJWHtLOvTC/ODv9snJbOQEg9eEPWQcTJPzv6olHv9Jv/urevKehlfY
 ArY=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/17] btrfs: zoned: consider zone as full when no more SB can be written
Date:   Wed, 11 Aug 2021 23:16:29 +0900
Message-Id: <74323d21d61fa334e033d301fb3163f1b73f0238.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
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
2.32.0

