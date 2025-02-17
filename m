Return-Path: <linux-btrfs+bounces-11494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A19A379CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CDE188FDF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C921531F9;
	Mon, 17 Feb 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qmcKHPB2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77216145323
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759875; cv=none; b=VkRdh2U01dmYAoHz+Dt83j8vTnJrvKGGfTMyKaxuF2zsfjC1kaMML8WOZCpsePw0+lrnOecg3yIhEDsU/ihda4LO92jufKQS8uu3cJVWxqJMRXnuBSpcD0iy64MVrGyslIaFyO8Yc6JjqXhItqLGhDR4PaznGtjRgZsQby52R58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759875; c=relaxed/simple;
	bh=6t5MgUF49kRf9OwZbGpXEVELI8+Fg7uXQvdw4/3oE58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjIaUmu9zykFRtMTAsMzbjH5zsv+E2hjUzhUv0r9XszgrN5k00y2NmyWzvvTSrG0YoWp5X1BbE4AV0IjY+Vrpag4rNPUH10rRghXpm2PEdnOTntQVheEJxHG5l47v/FeUtkexvQxm3qnGYCNf9XDI8PEYCJw02TuBj7jzHA2Kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qmcKHPB2; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759874; x=1771295874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6t5MgUF49kRf9OwZbGpXEVELI8+Fg7uXQvdw4/3oE58=;
  b=qmcKHPB223CkCcN2jLE75uKnEWs9vq30OANB9Mcxhb20cShKC0SL1yIM
   s+UWitZEOy5ML1cV3GuDg0LotuMLNJxNO0hUnbWenCcW7TieTGaHzIajK
   /I4ZGhfzwfww7WWva0dcFI48IzIO/vR4KplGlasaqluTwDH/COSmTV1Nm
   bnOWPAEn3NLxM+OTw0R3ikZAX1wZ+AfNLq6qdXDPKr4Zydedq3rN6RXMS
   IVO3/RNpHvI0AEU/KGOWxnAdw1TGWw2NZuJkE+hVxHgDlANRdqHdMgeHE
   G2X7+Bb8poT0fogk82e6dDYX6TY1BrWbVfZoHdT1tisEKvJc6Zx6FkAEX
   Q==;
X-CSE-ConnectionGUID: E5dxU8MCQCyFbuUysFwWHQ==
X-CSE-MsgGUID: zdPhd1rHQRiRYWO0F9naAg==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877174"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:50 +0800
IronPort-SDR: 67b29346_uF1hsDUbxRRN0ueBdVFdAZSaB+x2xnMC6Dp6qzpuVjiQP12
 Kr9KexjCtWyOirveHxMWnY3qyCRYiuqBZkvHeFw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:18 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:50 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 03/12] btrfs-progs: zoned: support zone capacity
Date: Mon, 17 Feb 2025 11:37:33 +0900
Message-ID: <8c68704eca02321ab9577d4a1e96eb83751fbc35.1739756953.git.naohiro.aota@wdc.com>
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

The userland tools did not load and use the zone capacity. Support it properly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h       | 1 +
 kernel-shared/extent-tree.c | 2 +-
 kernel-shared/zoned.c       | 9 ++++++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 8c923be96705..a6aa10a690bb 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -285,6 +285,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 write_offset;
+	u64 zone_capacity;
 
 	u64 global_root_id;
 };
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 20eef4f3df7b..2b7a962f294b 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -300,7 +300,7 @@ again:
 		goto new_group;
 
 	if (btrfs_is_zoned(root->fs_info)) {
-		if (cache->length - cache->alloc_offset < num)
+		if (cache->zone_capacity - cache->alloc_offset < num)
 			goto new_group;
 		*start_ret = cache->start + cache->alloc_offset;
 		cache->alloc_offset += num;
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index b06774482cfd..319ee88d5b06 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -776,7 +776,7 @@ static int calculate_alloc_pointer(struct btrfs_fs_info *fs_info,
 		length = fs_info->nodesize;
 
 	if (!(found_key.objectid >= cache->start &&
-	       found_key.objectid + length <= cache->start + cache->length)) {
+	       found_key.objectid + length <= cache->start + cache->zone_capacity)) {
 		ret = -EUCLEAN;
 		goto out;
 	}
@@ -830,6 +830,7 @@ bool zoned_profile_supported(u64 map_type, bool rst)
 
 struct zone_info {
 	u64 physical;
+	u64 capacity;
 	u64 alloc_offset;
 };
 
@@ -894,6 +895,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		if (!is_sequential) {
 			num_conventional++;
 			info->alloc_offset = WP_CONVENTIONAL;
+			info->capacity = device->zone_info->zone_size;
 			continue;
 		}
 
@@ -904,6 +906,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
 		zone = device->zone_info->zones[info->physical / fs_info->zone_size];
 
+		info->capacity = (zone.capacity << SECTOR_SHIFT);
+
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
@@ -927,6 +931,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	}
 
 	if (num_conventional > 0) {
+		/* Zone capacity is always zone size in emulation */
+		cache->zone_capacity = cache->length;
 		ret = calculate_alloc_pointer(fs_info, cache, &last_alloc);
 		if (ret || map->num_stripes == num_conventional) {
 			if (!ret)
@@ -946,6 +952,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 	cache->alloc_offset = zone_info[0].alloc_offset;
+	cache->zone_capacity = zone_info[0].capacity;
 
 out:
 	/* An extent is allocated after the write pointer */
-- 
2.48.1


