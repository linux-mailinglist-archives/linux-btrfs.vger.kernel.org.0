Return-Path: <linux-btrfs+bounces-11551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F2A3B2EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A943AC817
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500D1C3C11;
	Wed, 19 Feb 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rrveHa9/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EF1A315E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951897; cv=none; b=ubwah9yPUQkhSbxX5IUXECEEyWZxWzK+PRjpOct/CjUubFX2hFiUN6k8UKjd7bIpzx6A7fMOXmY/RREmOHoboZSujO7lwc8l55QNrrumLYNM8EpIGjRLouZVMU3LPw8USOAex/Uru+mA1huSc++XC0oot63CPIwq935xPH+avZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951897; c=relaxed/simple;
	bh=MppZ9PrHLju78y/W9D+X52JUgf00fP8+kOtxv7KfvY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+5hD+TjOm8J59rIfL+iH3xAU9JSirSK1omU2gDQn3j9rRag8IH/oTIeOunqbdILHoe0zFUePZ9NnKyScZdVuM3m//X4Il/V3u8x7+crkRXctT6zGv5AwfMugpfQxEwNPbZWBM5WtJRvtDvhdJiKV5G8ZSb4S2MY9fRSk9dDsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rrveHa9/; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951892; x=1771487892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MppZ9PrHLju78y/W9D+X52JUgf00fP8+kOtxv7KfvY4=;
  b=rrveHa9/uofHTq7VBssmjxrcDTuk/oKEY+sV/GbdALirHLRaVMdF8sDk
   FRmeQWo1/McbSLd5fquxX8IuUjsxeqRNFk/2EzydyNpleSZeX/Rzt0dD6
   81ejBJc9Y0EQeOrbZpm9+HRoUHjQ2TQe6b0OPgbwy8zRvdynBumfUzEL+
   guP9yvvcDjMOIKH5dcvFsjhr5rUjVVSn0VdYaTVtEGhY2dZyx4E5tG8Gd
   6iFtW877EZgjnioAfjfjCCt4y02olWGOfcFbGeP8bJ0c8vUMDXe+r20go
   gt9phHoMGfsBUqRNpdr2lTsC6LkEoMT4yHT8973DYPuElM/56rwDPKPHV
   A==;
X-CSE-ConnectionGUID: sgxxQi6YQZes4wI7cGHoqQ==
X-CSE-MsgGUID: /dA8dMXXQRSL9H0/Oi3Jig==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310802"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:05 +0800
IronPort-SDR: 67b58152_HaDpThY8jhuCG63a+kNYtwS2wZEauYo5ZTohB0wAhlwLf4v
 10P1EEj0upapj11P15n3p1kDzHK5grdUpPDsWzQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:30 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:04 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 02/12] btrfs-progs: zoned: introduce a zone_info struct in btrfs_load_block_group_zone_info
Date: Wed, 19 Feb 2025 16:57:46 +0900
Message-ID: <48e5d55e3d4e773cb7952ac14978466dcf93a32a.1739951758.git.naohiro.aota@wdc.com>
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

This is an userland side update to follow kernel-side commit 15c12fcc50a1
("btrfs: zoned: introduce a zone_info struct in
btrfs_load_block_group_zone_info"). This will make the code unification easier.

This commit introduces zone_info structure to hold per-zone information in
btrfs_load_block_group_zone_info.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 46 ++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index fd8a776dc471..b06774482cfd 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -828,6 +828,11 @@ bool zoned_profile_supported(u64 map_type, bool rst)
 	return false;
 }
 
+struct zone_info {
+	u64 physical;
+	u64 alloc_offset;
+};
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -837,10 +842,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	struct map_lookup *map;
 	u64 logical = cache->start;
 	u64 length = cache->length;
-	u64 physical = 0;
+	struct zone_info *zone_info = NULL;
 	int ret = 0;
 	int i;
-	u64 *alloc_offsets = NULL;
 	u64 last_alloc = 0;
 	u32 num_conventional = 0;
 
@@ -867,30 +871,29 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	}
 	map = container_of(ce, struct map_lookup, ce);
 
-	alloc_offsets = calloc(map->num_stripes, sizeof(*alloc_offsets));
-	if (!alloc_offsets) {
-		error_msg(ERROR_MSG_MEMORY, "zone offsets");
+	zone_info = calloc(map->num_stripes, sizeof(*zone_info));
+	if (!zone_info) {
+		error_msg(ERROR_MSG_MEMORY, "zone info");
 		return -ENOMEM;
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
+		struct zone_info *info = &zone_info[i];
 		bool is_sequential;
 		struct blk_zone zone;
 
 		device = map->stripes[i].dev;
-		physical = map->stripes[i].physical;
+		info->physical = map->stripes[i].physical;
 
 		if (device->fd == -1) {
-			alloc_offsets[i] = WP_MISSING_DEV;
+			info->alloc_offset = WP_MISSING_DEV;
 			continue;
 		}
 
-		is_sequential = btrfs_dev_is_sequential(device, physical);
-		if (!is_sequential)
-			num_conventional++;
-
+		is_sequential = btrfs_dev_is_sequential(device, info->physical);
 		if (!is_sequential) {
-			alloc_offsets[i] = WP_CONVENTIONAL;
+			num_conventional++;
+			info->alloc_offset = WP_CONVENTIONAL;
 			continue;
 		}
 
@@ -898,28 +901,27 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
 		 */
-		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
-		zone = device->zone_info->zones[physical / fs_info->zone_size];
+		WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+		zone = device->zone_info->zones[info->physical / fs_info->zone_size];
 
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
 			error(
 		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-			      physical / fs_info->zone_size, device->name,
+			      info->physical / fs_info->zone_size, device->name,
 			      device->devid);
-			alloc_offsets[i] = WP_MISSING_DEV;
+			info->alloc_offset = WP_MISSING_DEV;
 			break;
 		case BLK_ZONE_COND_EMPTY:
-			alloc_offsets[i] = 0;
+			info->alloc_offset = 0;
 			break;
 		case BLK_ZONE_COND_FULL:
-			alloc_offsets[i] = fs_info->zone_size;
+			info->alloc_offset = fs_info->zone_size;
 			break;
 		default:
 			/* Partially used zone */
-			alloc_offsets[i] =
-					((zone.wp - zone.start) << SECTOR_SHIFT);
+			info->alloc_offset = ((zone.wp - zone.start) << SECTOR_SHIFT);
 			break;
 		}
 	}
@@ -943,7 +945,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 		goto out;
 	}
-	cache->alloc_offset = alloc_offsets[0];
+	cache->alloc_offset = zone_info[0].alloc_offset;
 
 out:
 	/* An extent is allocated after the write pointer */
@@ -957,7 +959,7 @@ out:
 	if (!ret)
 		cache->write_offset = cache->alloc_offset;
 
-	kfree(alloc_offsets);
+	kfree(zone_info);
 	return ret;
 }
 
-- 
2.48.1


