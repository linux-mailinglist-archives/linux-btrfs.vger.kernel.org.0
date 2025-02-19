Return-Path: <linux-btrfs+bounces-11561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEEDA3B2F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747213B2493
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156D1C726D;
	Wed, 19 Feb 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xdq0aI6h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106D1C4A3B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951908; cv=none; b=J+PylQt7JzM9snbXTDisGNn9f1pu4BWIOYoL7G3zGclnKeczS0naEcuTM1xZ/F2TWq58VpnBpKSTjlVHsH3YOg5SSIk1N91AEA+KVOIoTHKFGrMyKn6pGhvzYKmwpLgZ98LBZ61/Ek+gvZ4MGuHJ4BptnvkvOVhxyPk2D5twmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951908; c=relaxed/simple;
	bh=wDB1LTf7zAX6T0ivV5OtwomJVIYYw7AEyMOTzV20grs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slpy0AjFWOLj+F3OSLhdEwwbODizGCNKqdpavASVG8ONgbiM9V9nROe5wMJlu/5icgnFCFN53uXPQpRd0egRm5ZHEQLrTxSfVFt5n+OX1NdjO9cBucR2NtolyhpF4QV4koXDBsC/9LYf/NWbH4DCrCEY9ktxbEUOP301XOXAhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xdq0aI6h; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951903; x=1771487903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDB1LTf7zAX6T0ivV5OtwomJVIYYw7AEyMOTzV20grs=;
  b=Xdq0aI6he8BEbRuos1D5bXf/aKOTLMpvpPeFQqRVlQ6tkBQ6oKnzVT5+
   qkBGcLAvE5taw8DaTwo/Cz0blYdsT49yZQIIAgbqziGCqtFIRHW1ydffJ
   IHQuu4PorjYqs0iWGn3++YcB6462uXPXsyHVtKJAv7ypFziJCpKeIjtUW
   yblQjItDIXWcIFndzNCoUBbKWnO8smsq0XnbM2Lue+XBIRbt5eknEGIGm
   zWYzg+IwMqWDwUVjBXQQec79FihRYHx38lglj4fSdp/YkxDxaCo7fUKE6
   YT0X/wtDsxrVX3vIk+bBYndhSO4BW2p2tewNdWKIc8aZhoq70lMXsfkFf
   w==;
X-CSE-ConnectionGUID: Xl+/Kmw8Td2bNL6PIo5NhA==
X-CSE-MsgGUID: MtrCYJiGQ7GVtlbtZXmKtQ==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310815"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:10 +0800
IronPort-SDR: 67b58157_aRMEhTKB5P5+gdTAjyGvBugdqhlGVCTibT+uJ30WdRaqzfO
 ReNhjwfBsEkxfSfmabhnnACFvICYMOnt4lqbhSQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:36 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:10 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 09/12] btrfs-progs: zoned: implement RAID1 zone info loading
Date: Wed, 19 Feb 2025 16:57:53 +0900
Message-ID: <95b5685c2d4a7f6bb7330b6b0baf4e92833eb605.1739951758.git.naohiro.aota@wdc.com>
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

Implement it just like the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index f0a44587679b..e3ee1dc941dc 100644
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
@@ -1112,6 +1156,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
+		ret = btrfs_load_block_group_raid1(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
 	case BTRFS_BLOCK_GROUP_RAID10:
 		/* Temporarily fails these case, until following commits. */
-- 
2.48.1


