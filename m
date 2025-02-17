Return-Path: <linux-btrfs+bounces-11497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9AA379D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C983AFA99
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A215E5B8;
	Mon, 17 Feb 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fJgglkiE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43A14D2B7
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759877; cv=none; b=KKdCxD8qGrPygyrGfc6eZu3dpCZS6X2SgZnFExTuQMLWjpoi12VZQjg3u+rK0B2pOom82YGwWFcx+Bzscv3iOeCP2N8AEzhvFsBoTmWQKP8PqfpMDSlQh4YA4uLxwuIuyIa9SsmaQ+1cDrEAMtBAX/Xd90JasqNHvXXHaxKE2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759877; c=relaxed/simple;
	bh=yXhAD6P03SJMemKKQjfkaDbiWr7LwH2+E5dAXD+GlNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPf6RWujy6cRU7jslcrA7FRlaSxosxLECHpTtPQIyF5U5SmSNmzjJZSWffXcpqHUOLdwluPHeu5WBjHQyeyqc7X2TmOrV04/A8PBMTao18gLLysbWhElXl2CSz2ekVFMBo0DkY+xpmdniJYLKLcfwotzOXIFcx9jTOKpvrMCcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fJgglkiE; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759875; x=1771295875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yXhAD6P03SJMemKKQjfkaDbiWr7LwH2+E5dAXD+GlNY=;
  b=fJgglkiE5blOb3pixxeAcOlvOkW0hAZmypICVG0cYSAowwJuSWeIkcB5
   IFqHzShKw7MKsXD35HszDNZzBBMGjlu8G10hMVllXCgLo073HBZSWXBgg
   AduyrhuZDFH0236KxGmOXosL+YKqn804Ifr8KMFK/88FDS6JypzKkAkfz
   0eahgnsKZHt2H1TuBeKH9ValbuAVw9fReIGTplCZ495kZRqnQa0ApTRGO
   yFsHzbJTtoEQzuZ9b78S5Yvi4vhImWVNQWRphFfJEd1mgzTcv/whwINUX
   Utm59sIIEPCFK+N4uurJAV2RbG1fCCexw7lKCC5ZKvJKGwyXmr3KTMqai
   w==;
X-CSE-ConnectionGUID: Z/6NVwM7QO6MVPhGJG45gg==
X-CSE-MsgGUID: i+vfu6NpQOWhad8swqA4Ag==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877179"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:52 +0800
IronPort-SDR: 67b29348_5EOnZVRltFQ+FE0VbZsrIaYDUmCpCPg3rC1iJF9JykHtwvD
 aSXcTZksfN4VxIuoX2bUk+DctWbD57dUFm+SO1A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:20 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:52 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/12] btrfs-progs: factor out btrfs_load_zone_info()
Date: Mon, 17 Feb 2025 11:37:36 +0900
Message-ID: <13b005c387446c5bb3e0212ba31423e1458688de.1739756953.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739756953.git.naohiro.aota@wdc.com>
References: <cover.1739756953.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that, we have zone capacity and (basic) zone activeness support. It's time
to factor out btrfs_load_zone_info() as same as the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 124 ++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 53 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index ee6c4ee61e4a..4045cf0d2b98 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -891,10 +891,76 @@ struct zone_info {
 	u64 alloc_offset;
 };
 
+static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
+				struct zone_info *info, unsigned long *active,
+				struct map_lookup *map)
+{
+	struct btrfs_device *device;
+	struct blk_zone zone;
+
+	info->physical = map->stripes[zone_idx].physical;
+
+	device = map->stripes[zone_idx].dev;
+
+	if (device->fd == -1) {
+		info->alloc_offset = WP_MISSING_DEV;
+		return 0;
+	}
+
+	/* Consider a zone as active if we can allow any number of active zones. */
+	if (!device->zone_info->max_active_zones)
+		set_bit(zone_idx, active);
+
+	if (!btrfs_dev_is_sequential(device, info->physical)) {
+		info->alloc_offset = WP_CONVENTIONAL;
+		info->capacity = device->zone_info->zone_size;
+		return 0;
+	}
+
+	/*
+	 * The group is mapped to a sequential zone. Get the zone write
+	 * pointer to determine the allocation offset within the zone.
+	 */
+	WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+	zone = device->zone_info->zones[info->physical / fs_info->zone_size];
+
+	if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		error("zoned: unexpected conventional zone %llu on device %s (devid %llu)",
+		      zone.start << SECTOR_SHIFT, device->name,
+		      device->devid);
+		return -EIO;
+	}
+
+	info->capacity = (zone.capacity << SECTOR_SHIFT);
+
+	switch (zone.cond) {
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+		error(
+	"zoned: offline/readonly zone %llu on device %s (devid %llu)",
+		      info->physical / fs_info->zone_size, device->name,
+		      device->devid);
+		info->alloc_offset = WP_MISSING_DEV;
+		break;
+	case BLK_ZONE_COND_EMPTY:
+		info->alloc_offset = 0;
+		break;
+	case BLK_ZONE_COND_FULL:
+		info->alloc_offset = fs_info->zone_size;
+		break;
+	default:
+		/* Partially used zone */
+		info->alloc_offset = ((zone.wp - zone.start) << SECTOR_SHIFT);
+		set_bit(zone_idx, active);
+		break;
+	}
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
-	struct btrfs_device *device;
 	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
 	struct cache_extent *ce;
 	struct map_lookup *map;
@@ -944,60 +1010,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		struct zone_info *info = &zone_info[i];
-		bool is_sequential;
-		struct blk_zone zone;
-
-		device = map->stripes[i].dev;
-		info->physical = map->stripes[i].physical;
-
-		if (device->fd == -1) {
-			info->alloc_offset = WP_MISSING_DEV;
-			continue;
-		}
-
-		/* Consider a zone as active if we can allow any number of active zones. */
-		if (!device->zone_info->max_active_zones)
-			set_bit(i, active);
+		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map);
+		if (ret)
+			goto out;
 
-		is_sequential = btrfs_dev_is_sequential(device, info->physical);
-		if (!is_sequential) {
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
 			num_conventional++;
-			info->alloc_offset = WP_CONVENTIONAL;
-			info->capacity = device->zone_info->zone_size;
-			continue;
-		}
-
-		/*
-		 * The group is mapped to a sequential zone. Get the zone write
-		 * pointer to determine the allocation offset within the zone.
-		 */
-		WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
-		zone = device->zone_info->zones[info->physical / fs_info->zone_size];
-
-		info->capacity = (zone.capacity << SECTOR_SHIFT);
-
-		switch (zone.cond) {
-		case BLK_ZONE_COND_OFFLINE:
-		case BLK_ZONE_COND_READONLY:
-			error(
-		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-			      info->physical / fs_info->zone_size, device->name,
-			      device->devid);
-			info->alloc_offset = WP_MISSING_DEV;
-			break;
-		case BLK_ZONE_COND_EMPTY:
-			info->alloc_offset = 0;
-			break;
-		case BLK_ZONE_COND_FULL:
-			info->alloc_offset = fs_info->zone_size;
-			break;
-		default:
-			/* Partially used zone */
-			info->alloc_offset = ((zone.wp - zone.start) << SECTOR_SHIFT);
-			set_bit(i, active);
-			break;
-		}
 	}
 
 	if (num_conventional > 0) {
-- 
2.48.1


