Return-Path: <linux-btrfs+bounces-11501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42335A379CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F8C7A29E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53F154C12;
	Mon, 17 Feb 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D93cUbz1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3F15666D
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759879; cv=none; b=mSH0GloLbC/I3EkFcI155Y1t4Q2HXr64idZQCJEWU1c+0Yl9+ghoupZzVqvJSOzZxdPOZhgzeQkCGauH5lfUsdWEmKCeGahW6egmFoEIrZTkDrC9jhBLoTO1kYfKanyiUK7fNQajaQXTpmlr9QKeD58/D2f+1V6dezo+aOQ+5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759879; c=relaxed/simple;
	bh=O27OusdYNhsgxH74Swmaccj4rSCsOhnr5NYlFVkGR8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe3f+feTX0anv5UFUXsQzgHrP4rME8/iftDEBassS5Eu3Z5FyLmur1jVa1AaXIGNALZYlB9i9tq/oNZWYsEUUOmsZujZ5KkKa4ZQlVa4ds3M4UZgfabVR90U96nD3AU8p2kirfxVzemcLQqOLpKWwaNGjB4FIKaKxtAbFt6ctA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D93cUbz1; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759878; x=1771295878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O27OusdYNhsgxH74Swmaccj4rSCsOhnr5NYlFVkGR8s=;
  b=D93cUbz1G+9RWKh6N97ej3lRkgYe6NIaovejnG6p6WZ1/CvaYMY2/+Sv
   o2E/75W4PcXaYSrfulESpLed/dHEJ0yLhbrIIK9zBqqq/ln3jgrg8B5zS
   cUPnbF6EhsW8jfe5ZJxMvBeSfv8Ry/QUwxmKkLPYOrM2vadH5I0LzYOIR
   1nZieinAQscqKIKdbAjuogG7zSET6hue6tSF0Sd3Jce4+INBxmmUM3eiW
   Mu4mEMMYq5B4Q4jpagh5ijMnz8sGvd8dno/nTMhQPeXnE7PSOfztelmWu
   xJ94TTcUgheH1/AEBQjga7pKszgO2NPRPyn6H9HGQVuqE6StYAOGqdnhx
   Q==;
X-CSE-ConnectionGUID: PMTVCDNqSD+XAMoDRH25QQ==
X-CSE-MsgGUID: KByaIgELSouKsR71IO4gvA==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877184"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:55 +0800
IronPort-SDR: 67b2934c_RkR+3/ylI/l09Unp0vmTJYIEDV9ZkI82xpY4f3pD6GkTJFF
 ghiXrntSA7mg+X+GElHVVqZZsw+u9e2Q/h49kjQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:24 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:55 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/12] btrfs-progs: zoned: implement RAID0 zone info loading
Date: Mon, 17 Feb 2025 11:37:40 +0900
Message-ID: <fe79f2b06ad39bcec83f78ed7217b421d87b0370.1739756953.git.naohiro.aota@wdc.com>
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
 kernel-shared/zoned.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index e1cb57d938c5..66d76427d216 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -1062,6 +1062,36 @@ static int btrfs_load_block_group_raid1(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_load_block_group_raid0(struct btrfs_fs_info *fs_info,
+					struct btrfs_block_group *bg,
+					struct map_lookup *map,
+					struct zone_info *zone_info,
+					unsigned long *active)
+{
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if (test_bit(0, active) != test_bit(i, active)) {
+			return -EIO;
+		} else {
+			if (test_bit(0, active))
+				bg->zone_is_active = 1;
+		}
+		bg->zone_capacity += zone_info[i].capacity;
+		bg->alloc_offset += zone_info[i].alloc_offset;
+	}
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -1158,6 +1188,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	case BTRFS_BLOCK_GROUP_RAID1C4:
 		ret = btrfs_load_block_group_raid1(fs_info, cache, map, zone_info, active);
 		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		ret = btrfs_load_block_group_raid0(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 	default:
-- 
2.48.1


