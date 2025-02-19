Return-Path: <linux-btrfs+bounces-11552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A709A3B2E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723FF7A630E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6861C5D4D;
	Wed, 19 Feb 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eNU03J2N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231A1C4A13
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951897; cv=none; b=jtd2dUaih2BLy00zyqhBbN2zTEGUsYt5SS+A8KhBWK0FSev+TUyKAvA141/d6g9/URE6828494+abMSVaJTIYf3/Ld6t/rhGCsdhzIjbywdTXk9UwNzNzf8QJJqXaijX82HOaQuAiUk07oC7kNw+u9hFTWkIlR6M+gWd8RTwo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951897; c=relaxed/simple;
	bh=l0MELxl+UYSrAkXECBypm34bdJVZBkjGfRlCTd1xIeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o88Ez1j/UJfui35g2UNa5Ti+oXeRu2wNfecNCG6sZwBN0DvLZLK920rJrY80Xb8XS1/GEYtenU9KaIVpUSB5Qzh/LnDvRimSKJ2EBPq1fM2z1E/J3wc2SBGYRcWOKPpjdD5qOvJNMb6ZZLPh2weuzOppLvtLnBN/ZZyZnUeMfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eNU03J2N; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951896; x=1771487896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l0MELxl+UYSrAkXECBypm34bdJVZBkjGfRlCTd1xIeI=;
  b=eNU03J2N2oN984ivLaoyeMs4FoxQj48ecI5dkbJnDu90iWignzn0Ie8g
   HnqiLfck7FaaSqAKKIoXPOWf3C4y1bawm7LmR9slDCdELV5USAC9LJ6a2
   yS/HH1dIGg6AJ+aLwPewHfXiY+MHYzj7qJwCSbrQGrZwrPsZ/9Xm8v06v
   VbChPkwKqZvCCraJFsWA+/EYaCS4n6CEB4eYkrsIyK/QyYBkXZTfmb4op
   cz/3QmoeP4Scto+/S/dV5pvqet34c3zID00q5mAyD3ee35NfVZWajLVH0
   Q30xzWBVXflxdv3MnAD6gb/4YZZ8JbSEpZW4cQIJou4zinoTlQ8CM/GcD
   Q==;
X-CSE-ConnectionGUID: I0GhGNyyRTuj/uHViR/jxA==
X-CSE-MsgGUID: aJ38rfM2QQWS3EnyqR3fGA==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310806"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:06 +0800
IronPort-SDR: 67b58154_vZCyP20u+NYTsCXBOpttyRNwM9EBDfQxEZOQUE/E5T8hW5q
 9K40aaGMkuAodTlP6u4IJazg8X87fNBhBdMjB8Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:32 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:06 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 04/12] btrfs-progs: zoned: load zone activeness
Date: Wed, 19 Feb 2025 16:57:48 +0900
Message-ID: <58ad7ad0db8a17c2e27a54314869c3e94f7ab048.1739951758.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739951758.git.naohiro.aota@wdc.com>
References: <cover.1739951758.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly load the zone activeness on the userland tool. Also, check if a device
has enough active zone limit to run btrfs.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h |  1 +
 kernel-shared/zoned.c | 77 +++++++++++++++++++++++++++++++++++++++----
 kernel-shared/zoned.h |  3 ++
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a6aa10a690bb..f10142df80eb 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -368,6 +368,7 @@ struct btrfs_fs_info {
 	unsigned int allow_transid_mismatch:1;
 	unsigned int skip_leaf_item_checks:1;
 	unsigned int rebuilding_extent_tree:1;
+	unsigned int active_zone_tracking:1;
 
 	int transaction_aborted;
 
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 319ee88d5b06..a97466635ecb 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -23,6 +23,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include "kernel-lib/list.h"
+#include "kernel-lib/bitmap.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/zoned.h"
 #include "kernel-shared/accessors.h"
@@ -57,6 +58,16 @@ static u64 emulated_zone_size = DEFAULT_EMULATED_ZONE_SIZE;
 #define BTRFS_MAX_ZONE_SIZE		(8ULL * SZ_1G)
 #define BTRFS_MIN_ZONE_SIZE		(SZ_4M)
 
+/*
+ * Minimum of active zones we need:
+ *
+ * - BTRFS_SUPER_MIRROR_MAX zones for superblock mirrors
+ * - 3 zones to ensure at least one zone per SYSTEM, META and DATA block group
+ * - 1 zone for tree-log dedicated block group
+ * - 1 zone for relocation
+ */
+#define BTRFS_MIN_ACTIVE_ZONES		(BTRFS_SUPER_MIRROR_MAX + 5)
+
 static int btrfs_get_dev_zone_info(struct btrfs_device *device);
 
 enum btrfs_zoned_model zoned_model(const char *file)
@@ -132,6 +143,18 @@ static u64 max_zone_append_size(const char *file)
 	return strtoull((const char *)chunk, NULL, 10);
 }
 
+static unsigned int max_active_zone_count(const char *file)
+{
+	char buf[32];
+	int ret;
+
+	ret = device_get_queue_param(file, "max_active_zones", buf, sizeof(buf));
+	if (ret <= 0)
+		return 0;
+
+	return strtoul((const char *)buf, NULL, 10);
+}
+
 #ifdef BTRFS_ZONED
 /*
  * Emulate blkdev_report_zones() for a non-zoned device. It slices up the block
@@ -273,7 +296,8 @@ static int report_zones(int fd, const char *file,
 	struct stat st;
 	struct blk_zone_report *rep;
 	struct blk_zone *zone;
-	unsigned int i, n = 0;
+	unsigned int i, nreported = 0, nactive = 0;
+	unsigned int max_active_zones;
 	int ret;
 
 	/*
@@ -336,6 +360,20 @@ static int report_zones(int fd, const char *file,
 		exit(1);
 	}
 
+	zinfo->active_zones = bitmap_zalloc(zinfo->nr_zones);
+	if (!zinfo->active_zones) {
+		error_msg(ERROR_MSG_MEMORY, "active zone bitmap");
+		exit(1);
+	}
+
+	max_active_zones = max_active_zone_count(file);
+	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
+		error("zoned: %s: max active zones %u is too small, need at least %u active zones",
+		      file, max_active_zones, BTRFS_MIN_ACTIVE_ZONES);
+		exit(1);
+	}
+	zinfo->max_active_zones = max_active_zones;
+
 	/* Allocate a zone report */
 	rep_size = sizeof(struct blk_zone_report) +
 		   sizeof(struct blk_zone) * BTRFS_REPORT_NR_ZONES;
@@ -347,7 +385,7 @@ static int report_zones(int fd, const char *file,
 
 	/* Get zone information */
 	zone = (struct blk_zone *)(rep + 1);
-	while (n < zinfo->nr_zones) {
+	while (nreported < zinfo->nr_zones) {
 		memset(rep, 0, rep_size);
 		rep->sector = sector;
 		rep->nr_zones = BTRFS_REPORT_NR_ZONES;
@@ -374,17 +412,36 @@ static int report_zones(int fd, const char *file,
 			break;
 
 		for (i = 0; i < rep->nr_zones; i++) {
-			if (n >= zinfo->nr_zones)
+			if (nreported >= zinfo->nr_zones)
 				break;
-			memcpy(&zinfo->zones[n], &zone[i],
+			memcpy(&zinfo->zones[nreported], &zone[i],
 			       sizeof(struct blk_zone));
-			n++;
+			switch (zone[i].cond) {
+			case BLK_ZONE_COND_EMPTY:
+				break;
+			case BLK_ZONE_COND_IMP_OPEN:
+			case BLK_ZONE_COND_EXP_OPEN:
+			case BLK_ZONE_COND_CLOSED:
+				set_bit(nreported, zinfo->active_zones);
+				nactive++;
+				break;
+			}
+			nreported++;
 		}
 
 		sector = zone[rep->nr_zones - 1].start +
 			 zone[rep->nr_zones - 1].len;
 	}
 
+	if (max_active_zones) {
+		if (nactive > max_active_zones) {
+			error("zoned: %u active zones on %s exceeds max_active_zones %u",
+			      nactive, file, max_active_zones);
+			exit(1);
+		}
+		zinfo->active_zones_left = max_active_zones - nactive;
+	}
+
 	kfree(rep);
 
 	return 0;
@@ -1080,6 +1137,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 static int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
+	int ret;
 
 	/*
 	 * Cannot use btrfs_is_zoned here, since fs_info::zone_size might not
@@ -1091,7 +1149,14 @@ static int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (device->zone_info)
 		return 0;
 
-	return btrfs_get_zone_info(device->fd, device->name, &device->zone_info);
+	ret = btrfs_get_zone_info(device->fd, device->name, &device->zone_info);
+	if (ret)
+		return ret;
+
+	if (device->zone_info->max_active_zones)
+		fs_info->active_zone_tracking = 1;
+
+	return 0;
 }
 
 int btrfs_get_zone_info(int fd, const char *file,
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index c593571c4b69..d004ff16f198 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -72,7 +72,10 @@ struct btrfs_zoned_device_info {
 	enum btrfs_zoned_model	model;
 	u64			zone_size;
 	u32			nr_zones;
+	unsigned int            max_active_zones;
 	struct blk_zone		*zones;
+	atomic_t                active_zones_left;
+	unsigned long           *active_zones;
 	bool			emulated;
 };
 
-- 
2.48.1


