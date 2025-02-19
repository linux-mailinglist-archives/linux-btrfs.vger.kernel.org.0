Return-Path: <linux-btrfs+bounces-11553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103FA3B2ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 08:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32C816D183
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5741C5D55;
	Wed, 19 Feb 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qqJOaKg7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86041C3029
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951898; cv=none; b=kKG35VdgcAoGGUgqFoVDd0YwicO36jWzftTtj+Xq8bqskLYwPRlQxs37ExZeQ3zZ8en4QZv6U3Lf7tEoSnjzdUoO2uJhCGy9Vs2Jtm8ruqAb0WWv6qSSEH0ImkkVQQh95oQ986ox6SbvnyMlxxnGNAiPHD+1OS2iVZupi7uo52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951898; c=relaxed/simple;
	bh=6t5MgUF49kRf9OwZbGpXEVELI8+Fg7uXQvdw4/3oE58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKWf067z3Gmz+Lw/KZj6u8INOsK5HiBxG8GnoHmik5Qp3t1pdl+4zg3Ps0Rvu+plJL4vF5G8LMCKsap8LbAA11qy6yqfYYZwmYXm6cMBf7RgG2a80Hvq4cb+M/qCt6yQa8MWzG7U6ZXlN4r5lKLoJZkQFFyCPrUaCliy+U3BlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qqJOaKg7; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739951892; x=1771487892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6t5MgUF49kRf9OwZbGpXEVELI8+Fg7uXQvdw4/3oE58=;
  b=qqJOaKg7hJbw3w20MFRZm5S179GMdnpnQF5GXCcDpLV/ixV15r6nyWfx
   r8AXx1t9I0SV0y1w3uKn2yjQYr91j44H//Yw8Nv36qa2YZP8Q7Qc33mkr
   bl2NQ4o0qpEmEKm+BbSXVdIM7OGvSJJf7xEfls48fDeb9nJ2bBM82gA4o
   uIX26ShTEXApp+43rqWRW+430i7Sa2nxhqzrfz0DxBz3qOnZZWtN3veQb
   VeaxK2Lf2sIRVDjHCJNxicGTRboMZTcGVh8T8kNoMwgyrODFpEgTBTZhi
   wZI3DWgMw3hYkmvA77H91SWJDjjSwvJtUPgDqr6b0fByrBfzopF78T9z9
   Q==;
X-CSE-ConnectionGUID: QTdtT2OQTCOIjeZsko/tJg==
X-CSE-MsgGUID: 9SXZX4muRa61zIw2i8oX2w==
X-IronPort-AV: E=Sophos;i="6.13,298,1732550400"; 
   d="scan'208";a="38310804"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2025 15:58:06 +0800
IronPort-SDR: 67b58153_yHmizFlOWuGy27Vg3OmDUYewfQaT/bJ6+j/VF9xi8wxTrOg
 YTLPTcZqN413ys+QkPnpX8JE95umbaXldPGJK0A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 22:59:31 -0800
WDCIronportException: Internal
Received: from 5cg20343qs.ad.shared (HELO naota-xeon..) ([10.224.109.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2025 23:58:05 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 03/12] btrfs-progs: zoned: support zone capacity
Date: Wed, 19 Feb 2025 16:57:47 +0900
Message-ID: <8c68704eca02321ab9577d4a1e96eb83751fbc35.1739951758.git.naohiro.aota@wdc.com>
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


