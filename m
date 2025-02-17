Return-Path: <linux-btrfs+bounces-11500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BBA379D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849E91890A8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156BF137C35;
	Mon, 17 Feb 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o8XOz+js"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBF154C12
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759879; cv=none; b=Xfb/cvokJgyy3ZsSgR/Pt9IvB6sVzCtG2A+ESamUF4pwSzMszwCmJc3rFKlGrNdGC7TqF9d6asi+FGLbkOLLZO97zZjShrvuyPXgvuG3xy50+o7BGqjROk+vzLDMyETiBHo3y9xZeVjvUShtsotTbExOoGteJZVjfYyMtx94Tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759879; c=relaxed/simple;
	bh=CMmAxJYBEeYSWdkyk9Atzxou6BUDtKaGCsLgPRb7+8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1IUYDUH7V/LUE0CKe2lJcIe9v5jSE8KCK1Bk3MwF0UGGOOhrLVhSXc9GYihIibr09xu2lZXcKzFo/ulKAYRXFN8UwsDyaYHuMXz910t6dxjQqp55fgsj18MSmldrOEiDq+gQUlxf9YFlbgT/mM5ay0zo9RRj2Tn2zL7NnWWOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o8XOz+js; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759877; x=1771295877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMmAxJYBEeYSWdkyk9Atzxou6BUDtKaGCsLgPRb7+8Q=;
  b=o8XOz+js2ypM9KhqSCQUHVnhQoliJD73NTPsrf1zpkN2LqUXffBZypSa
   58QlJZL+fzhLFowfAgZGGuDgjGz0jE6fhKPgUhjgnMUKDCoPDiZMwecbt
   Df2l56bOp/S2UjH7AaZs5s73lupOzJ57oMHcMxnJPzc9jds63yhpD/smP
   zLMZoVCJzyhRTuUlc6GJ55Gc7yZmBYN3NDKVbV2+Kfg/6ndY0rzYgXIKC
   IQTjXe1VAKaLfjei/ePewf18BBoutbwc6ykPh5iOD13paWWh5gKFjtaIi
   RGC0Gp4iTmKJpNcGdJlqnYZ1KwIZaABtR8v27ducumi6nnuCESxgZW0xB
   A==;
X-CSE-ConnectionGUID: yAJXi5A3RomVV5dWsP19FA==
X-CSE-MsgGUID: dbI5h4H1Smi7uiB6AvuVzQ==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877182"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:55 +0800
IronPort-SDR: 67b2934b_ZJbcG9xHvZX4l3Sg+joiIkaJOxg4L18iyt6ByCHAJ8V+bDa
 juh43FC1scZ9BGfBc+r1c5Zth4ohM/bIDBdfVzw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:23 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:54 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 09/12] btrfs-progs: zoned: implement RAID1 zone info loading
Date: Mon, 17 Feb 2025 11:37:39 +0900
Message-ID: <55ebdaf57d776bbe07d493c01316d56421e15772.1739756953.git.naohiro.aota@wdc.com>
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

Implement it just like the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index dd1ddd01cfba..e1cb57d938c5 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -1018,6 +1018,50 @@ static int btrfs_load_block_group_dup(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_load_block_group_raid1(struct btrfs_fs_info *fs_info,
+					struct btrfs_block_group *bg,
+					struct map_lookup *map,
+					struct zone_info *zone_info,
+					unsigned long *active)
+{
+	int i;
+
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
+	/* In case a device is missing we have a cap of 0, so don't use it. */
+	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
+
+	for (i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if (zone_info[0].alloc_offset != zone_info[i].alloc_offset) {
+			btrfs_err(fs_info,
+			"zoned: write pointer offset mismatch of zones in %s profile",
+				  btrfs_bg_type_to_raid_name(map->type));
+			return -EIO;
+		}
+		if (test_bit(0, active) != test_bit(i, active)) {
+			return -EIO;
+		} else {
+			if (test_bit(0, active))
+				bg->zone_is_active = 1;
+		}
+	}
+
+	if (zone_info[0].alloc_offset != WP_MISSING_DEV)
+		bg->alloc_offset = zone_info[0].alloc_offset;
+	else
+		bg->alloc_offset = zone_info[i - 1].alloc_offset;
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -1109,6 +1153,11 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	case BTRFS_BLOCK_GROUP_DUP:
 		ret = btrfs_load_block_group_dup(fs_info, cache, map, zone_info, active);
 		break;
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		ret = btrfs_load_block_group_raid1(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 	default:
-- 
2.48.1


