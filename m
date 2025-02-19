Return-Path: <linux-btrfs+bounces-11557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA6A3B2F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 09:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B70D172097
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D412F1C5F1F;
	Wed, 19 Feb 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mPk9/wFE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E861C5D6F
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951905; cv=none; b=u9K9c+6VznuBwcShqqqZjLwjVxHrZftoexB2niZhxJEc+35eg0q/+4UPbJclBxc7uhDP5aT2b5EPWqwr7RgJdyaHa7KkZE6V1O4GY4A8qDba3vNf45Dd02ObJcEAS1a9ntKUa2hnBWJwelC/1Fx3txe/dgbv7bFKjJltisVBAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951905; c=relaxed/simple;
	bh=7upQIkgKUuxpYyu2GxV6ghyvxI+5dqpWALw7zr7sWOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUz3Lnd58dEKu+8uiu6xY5Bid94UeyYwyvrFfqd/YvX7Kn/wZHT+oBPeE3YrbibnJAexynANm8grPaaDZF/6BLOHRdU8HlrTRkKHkljl7cooSO+ESJ2/YkQbuSoLVuu75eEf7NcehE1fZVKmTobXNy14drIFmSMT+bQBg9EtuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mPk9/wFE; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951903; x=1771487903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7upQIkgKUuxpYyu2GxV6ghyvxI+5dqpWALw7zr7sWOg=;
  b=mPk9/wFEUgeZILJwS2IBF6gHqAmxVj3O0jBqMdZbslmo5ghfokO+99CP
   +CPDTQdLfwOuZKStQkQ8EgLKO6BVViSSofljPWZ89/YwS94bZg7MC9+JB
   HQy6yfy1EOVHKeWPdapf5sJZie7rcYSJ7fE43JOQTKCynvHsEo2lfDWeV
   92eNMsmGkr4geUlxuA9prPK0cCbgoTIQqSnpPpwZrgzbt0HR63DSfN0V2
   yKuYkE99BFkLYxBAbl1Q19ydC5m94sGwo+LFLxTw8szwUDK311pqb5FL6
   ERF4moLLNJ4XRtzVPJpBi8rtYVQFYdtDXyM9edCA1EAFvc4pK2sH7ZmmY
   w==;
X-CSE-ConnectionGUID: 6P3CgM4bT+a7ZsUT/kKcMA==
X-CSE-MsgGUID: C5KB7Q4vTN+HvsbyF/YxpA==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310816"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:11 +0800
IronPort-SDR: 67b58158_NpU+86LiAo7inLwKkkhE0SaKplaId7hDGc17oGAjQ5mapxk
 uKWBmLIEwlyqc6CFhhgLp82sK8du8aktYmDuxog==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:36 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:10 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 10/12] btrfs-progs: zoned: implement RAID0 zone info loading
Date: Wed, 19 Feb 2025 16:57:54 +0900
Message-ID: <851b1454917770a0a9aed84564d0ecc2596c85a8.1739951758.git.naohiro.aota@wdc.com>
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
 kernel-shared/zoned.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index e3ee1dc941dc..10e59b837efd 100644
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
@@ -1159,6 +1189,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = btrfs_load_block_group_raid1(fs_info, cache, map, zone_info, active);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
+		ret = btrfs_load_block_group_raid0(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
 		/* Temporarily fails these case, until following commits. */
 		fallthrough;
-- 
2.48.1


