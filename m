Return-Path: <linux-btrfs+bounces-11499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C59A379D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBE4164D5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87FF17A58F;
	Mon, 17 Feb 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nEMopIgK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC8154BF0
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759879; cv=none; b=Ffv53RTzsjPw5CatZHhv6mcv1Ltw0vH/di0fUMpPmPtc3n76r18qlMBK4JccVoLldK8mT8KMy/xPSwKNnz/uuczcQvhrXvmHu0bmlvgAPqQWhfi0osy46Dl2bxPVZY3IxslCPzqvkp5AMM9fzfFcMbKzi3CNMdWGcnUyK+S/B74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759879; c=relaxed/simple;
	bh=XyRsHkETUyYYLNR4SHzQnv3YJprO43QSz2YZfBfOO2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPHbAo3w+5LLxe8IXGRHtGWmEDgtLHQInPOfqAxM5v5c2I0g06QlxSdQhTnSjEWFv2xuNu5z0IcxIrLdOqyHrXIsFctcMhZJ5AOHnN+Vt8IaFvU2IwCDTJT7D+gV0fW+PMQMzJTaS0WqDo2pg3TtCEzRA63jO6UDFFWDCIOUud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nEMopIgK; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759877; x=1771295877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XyRsHkETUyYYLNR4SHzQnv3YJprO43QSz2YZfBfOO2Q=;
  b=nEMopIgKamH2sSJo/Z7wC8TLmAehtVsupfhPt5/4Hxn8PlgAHtoPJEH7
   c1woa3qjL7ND3zeElzvQEEn78HJw1DVIcpGGT3QkQo0gBa37T/sKmj2tG
   9nLOLYX5aD0O7CYS2VZEq0apOhR1OcSiAwPmxPjBi8T9V9O4+QA1Fxbl/
   /Ddbj6r4ucytfMiLhgOeUE7dtC5YllpJ5z0NwBMK4DpuYDjRFh+v5yJ9f
   hz4CfHbdjVxnEiyRzsOVLuX1HBL3/IABgwURFXklCiPOrftK6klvmkLwJ
   YDFJuqOfwBYYC+6JNuz1uACqPOFQ4Z+CC8ZoS4Ga13Zw+/skOmR85ceL0
   A==;
X-CSE-ConnectionGUID: qDe+u9bBRxGYlRdPz0Tq2g==
X-CSE-MsgGUID: Ty/OQZ5iS9a+oNgl8r/rLA==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877181"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:54 +0800
IronPort-SDR: 67b2934a_Wi79Xbj582gJW1MkgeJF5QuzlrAfv97VXyNXBjNeRhZpVZ4
 hPcjfXkjdPT0PfIYOVkD2xpjKdbJq09PTySfTGg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:22 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:53 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 08/12] btrfs-progs: zoned: implement DUP zone info loading
Date: Mon, 17 Feb 2025 11:37:38 +0900
Message-ID: <ed5c00373869a363dc8a83df3297235eb84b648e.1739756953.git.naohiro.aota@wdc.com>
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

DUP support is added like the kernel side.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 3bc7d6ba1924..dd1ddd01cfba 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -977,6 +977,46 @@ static int btrfs_load_block_group_single(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_load_block_group_dup(struct btrfs_fs_info *fs_info,
+				      struct btrfs_block_group *bg,
+				      struct map_lookup *map,
+				      struct zone_info *zone_info,
+				      unsigned long *active)
+{
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data DUP profile needs raid-stripe-tree");
+		return -EINVAL;
+	}
+
+	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
+
+	if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[0].physical);
+		return -EIO;
+	}
+	if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(fs_info,
+			  "zoned: cannot recover write pointer for zone %llu",
+			  zone_info[1].physical);
+		return -EIO;
+	}
+	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
+		btrfs_err(fs_info,
+			  "zoned: write pointer offset mismatch of zones in DUP profile");
+		return -EIO;
+	}
+
+	if (test_bit(0, active) != test_bit(1, active)) {
+		return -EIO;
+	} else if (test_bit(0, active)) {
+		bg->zone_is_active = 1;
+	}
+
+	bg->alloc_offset = zone_info[0].alloc_offset;
+	return 0;
+}
 
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
@@ -1066,6 +1106,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	case 0: /* single */
 		ret = btrfs_load_block_group_single(fs_info, cache, &zone_info[0], active);
 		break;
+	case BTRFS_BLOCK_GROUP_DUP:
+		ret = btrfs_load_block_group_dup(fs_info, cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 	default:
-- 
2.48.1


