Return-Path: <linux-btrfs+bounces-11493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C761A379C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0BC3AF25D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752A14EC62;
	Mon, 17 Feb 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cpiw1o/T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAB20328
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759875; cv=none; b=JeDHUWl0EqHsIG+KnMjr9WV068qWXEtCcOiYTZiLSAyAKekRuLJngdt43WMABqoppT6DjoRW+IU3CbezA1F3MhVsNOL3pQPUN9QmtHaDINEt8ctzmqG/i4HVukMQfWPFr/9xeg79T0hOQuTC/C8E4CUPUpaz0DfQzR8WGkajNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759875; c=relaxed/simple;
	bh=MppZ9PrHLju78y/W9D+X52JUgf00fP8+kOtxv7KfvY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqVCGZDOh7M6bS8mibH44zfIBGd1o51gZYDfD+8Qnqw6xCXLbkzPnwSl5lhNmDO3bM740JqGMLrDxUpl4oL1ch4OT4wxX0F/TnvVSaDnYZ7yj9QVPJu1ECrhct8uu/UdIZu08IiznR01YXmh4RyJmVfj3IL72XtT9vwSn5JIJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cpiw1o/T; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759873; x=1771295873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MppZ9PrHLju78y/W9D+X52JUgf00fP8+kOtxv7KfvY4=;
  b=Cpiw1o/TFByyi/hQUpDtVKpAUOlSVmLtP1yQKiWOpw7FPvJqAw68EcWU
   aftC+JBvLrI/r9XTSFsYGqxgUgXk0vxZVRMa+auNFiQDNl01fM2oKCSrc
   +7iHCMO05L/8tWobwn6Un6Znmg+pK94LlYeqk9u661gGwwZ7sh/xBFDw9
   +31Bn8wD29UZ455yKtEGwWZWI/kngYPvEQvjjBhzAFPOxofeWFh/gOPFZ
   nYgTYz/g+X34AWoPxO5CiQRERLjtTLVbDNIItKpod/8NKI2SaKLjgH7wn
   MovKEcei4U3GJFzWrmFwCk9i8JMJj6943R/hee1+zSKG0fPfTji9kVnyL
   A==;
X-CSE-ConnectionGUID: 42NaB2UNTs+LY46hsEM2GQ==
X-CSE-MsgGUID: 00tLDPUHQkSPYtVFSKeZYw==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877173"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:49 +0800
IronPort-SDR: 67b29345_Po5Lrquxd8R9/fcQr3q7EyzNRbadNmtIDdYqRK973D37kcu
 LFNmYxSHBtH2vGWnaXpE8fTV6QANv6hIvRsKisQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:17 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:49 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/12] btrfs-progs: zoned: introduce a zone_info struct in btrfs_load_block_group_zone_info
Date: Mon, 17 Feb 2025 11:37:32 +0900
Message-ID: <48e5d55e3d4e773cb7952ac14978466dcf93a32a.1739756953.git.naohiro.aota@wdc.com>
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


