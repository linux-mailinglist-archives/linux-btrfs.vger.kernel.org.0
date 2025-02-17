Return-Path: <linux-btrfs+bounces-11503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB14A379D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 03:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29C2188273F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 02:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208A1632D7;
	Mon, 17 Feb 2025 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N07n+YRu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652E634EC
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759881; cv=none; b=JMMAU21S8UqyUFaoH/2k7qENSnHbTI3RNK3bygsE//fTIEtVoFc3pyx29exbNttlH6WEr27WygY9OfzQH18rMdX4JJKKW7i0UhH59T6GqsR8cIovgpll1SkBRgs4gnZgAQ+JSXgKkfGwh748gOUjQvrY2dnCQ2UveZpZwkV3m3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759881; c=relaxed/simple;
	bh=rE7EPQMY/i12LbqPqDYzxx0lVd1FxSol+C69vuSJYjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBxQ1saY7CwbxJiDrzUjju65VcGmjA3Gbzb18qIdaCEUd6JJnrlkokDKUuEpbTTQifAwD8Osa+cq2lYHIrOvyOTgbB8P/dDnMkf6EuPJfNtVFMkDV45hOJzWJdK+1AlHoZHsxe36R3LkIqWqqTpnf0mMIFor1+q5sFyov9UlK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N07n+YRu; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739759879; x=1771295879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rE7EPQMY/i12LbqPqDYzxx0lVd1FxSol+C69vuSJYjc=;
  b=N07n+YRuJF2Z5BpYHf03Z0DNEq4D2S62wHfGZgEy09jRhtzvjOH2pVuy
   fKKQ0j/4mTxWoPa1eoeIdVkO5tpY/Nzk1N1gddLpdHCvCaFFdnxX8DTzc
   3za+ifYCpzfj5IaoUVDq/AE67kw0wU9J0tw+RSGpYU6suk2K1IXEd7GBc
   r/QQdOm/BcmuvZbUED29PmRF8zjIC0N8dL7c1vm1GTYFdZ6dWcd2Lga1N
   q1YVMlLy/qrK8DWHqY5ELicu21Zv11Cb01xPqJXdnTotLyn+M+mMhb0Jl
   g+ko/MfGuTWsJ8NMpFYgasOBotf/7U+7G/SESiUHFwbS9xdTr7Nqc5eEm
   A==;
X-CSE-ConnectionGUID: 2oNZMPlNTyKNHg1RRu5yKQ==
X-CSE-MsgGUID: Z6pqOqviSlG12UhWQjQhNQ==
X-IronPort-AV: E=Sophos;i="6.13,291,1732550400"; 
   d="scan'208";a="39877188"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2025 10:37:57 +0800
IronPort-SDR: 67b2934d_xvmQIvbDnZWomafTOcFmH5x8Gsh7Uvmv9rISFetVxOHBHG5
 +fq26VI+fG48h6q9/DorRpa3GmSJzUYoZAVWLPg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2025 17:39:25 -0800
WDCIronportException: Internal
Received: from 5cg2075f7l.ad.shared (HELO naota-xeon..) ([10.224.109.184])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2025 18:37:57 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/12] btrfs-progs: zoned: fix alloc_offset calculation for partly conventional block groups
Date: Mon, 17 Feb 2025 11:37:42 +0900
Message-ID: <df493a54f69f6d7fdc031e69c47682827dce4fc6.1739756953.git.naohiro.aota@wdc.com>
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

When one of two zones composing a DUP block group is a conventional zone, we
have the zone_info[i]->alloc_offset = WP_CONVENTIONAL. That will, of course,
not match the write pointer of the other zone, and fails that block group.

This commit solves that issue by properly recovering the emulated write pointer
from the last allocated extent. The offset for the SINGLE, DUP, and RAID1 are
straight-forward: it is same as the end of last allocated extent. The RAID0 and
RAID10 are a bit tricky that we need to do the math of striping.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 65 +++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 484bade1d2ed..d96311af70b2 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -981,7 +981,7 @@ static int btrfs_load_block_group_dup(struct btrfs_fs_info *fs_info,
 				      struct btrfs_block_group *bg,
 				      struct map_lookup *map,
 				      struct zone_info *zone_info,
-				      unsigned long *active)
+				      unsigned long *active, u64 last_alloc)
 {
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data DUP profile needs raid-stripe-tree");
@@ -1002,6 +1002,12 @@ static int btrfs_load_block_group_dup(struct btrfs_fs_info *fs_info,
 			  zone_info[1].physical);
 		return -EIO;
 	}
+
+	if (zone_info[0].alloc_offset == WP_CONVENTIONAL)
+		zone_info[0].alloc_offset = last_alloc;
+	if (zone_info[1].alloc_offset == WP_CONVENTIONAL)
+		zone_info[1].alloc_offset = last_alloc;
+
 	if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
 		btrfs_err(fs_info,
 			  "zoned: write pointer offset mismatch of zones in DUP profile");
@@ -1022,7 +1028,7 @@ static int btrfs_load_block_group_raid1(struct btrfs_fs_info *fs_info,
 					struct btrfs_block_group *bg,
 					struct map_lookup *map,
 					struct zone_info *zone_info,
-					unsigned long *active)
+					unsigned long *active, u64 last_alloc)
 {
 	int i;
 
@@ -1036,9 +1042,10 @@ static int btrfs_load_block_group_raid1(struct btrfs_fs_info *fs_info,
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
 	for (i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
-		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			zone_info[i].alloc_offset = last_alloc;
 
 		if (zone_info[0].alloc_offset != zone_info[i].alloc_offset) {
 			btrfs_err(fs_info,
@@ -1066,7 +1073,7 @@ static int btrfs_load_block_group_raid0(struct btrfs_fs_info *fs_info,
 					struct btrfs_block_group *bg,
 					struct map_lookup *map,
 					struct zone_info *zone_info,
-					unsigned long *active)
+					unsigned long *active, u64 last_alloc)
 {
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
@@ -1075,9 +1082,24 @@ static int btrfs_load_block_group_raid0(struct btrfs_fs_info *fs_info,
 	}
 
 	for (int i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
-		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
+			u64 stripe_nr, full_stripe_nr;
+			u64 stripe_offset;
+			int stripe_index;
+
+			stripe_nr = last_alloc / map->stripe_len;
+			stripe_offset = stripe_nr * map->stripe_len;
+			full_stripe_nr = stripe_nr / map->num_stripes;
+			stripe_index = stripe_nr % map->num_stripes;
+
+			zone_info[i].alloc_offset = full_stripe_nr * map->stripe_len;
+			if (stripe_index > i)
+				zone_info[i].alloc_offset += map->stripe_len;
+			else if (stripe_index == i)
+				zone_info[i].alloc_offset += (last_alloc - stripe_offset);
+		}
 
 		if (test_bit(0, active) != test_bit(i, active)) {
 			return -EIO;
@@ -1096,7 +1118,7 @@ static int btrfs_load_block_group_raid10(struct btrfs_fs_info *fs_info,
 					 struct btrfs_block_group *bg,
 					 struct map_lookup *map,
 					 struct zone_info *zone_info,
-					 unsigned long *active)
+					 unsigned long *active, u64 last_alloc)
 {
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
@@ -1105,9 +1127,24 @@ static int btrfs_load_block_group_raid10(struct btrfs_fs_info *fs_info,
 	}
 
 	for (int i = 0; i < map->num_stripes; i++) {
-		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
-		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
+			u64 stripe_nr, full_stripe_nr;
+			u64 stripe_offset;
+			int stripe_index;
+
+			stripe_nr = last_alloc / map->stripe_len;
+			stripe_offset = stripe_nr * map->stripe_len;
+			full_stripe_nr = stripe_nr / (map->num_stripes / map->sub_stripes);
+			stripe_index = stripe_nr % (map->num_stripes / map->sub_stripes);
+
+			zone_info[i].alloc_offset = full_stripe_nr * map->stripe_len;
+			if (stripe_index > (i / map->sub_stripes))
+				zone_info[i].alloc_offset += map->stripe_len;
+			else if (stripe_index == (i / map->sub_stripes))
+				zone_info[i].alloc_offset += (last_alloc - stripe_offset);
+		}
 
 		if (test_bit(0, active) != test_bit(i, active)) {
 			return -EIO;
@@ -1214,18 +1251,18 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 		ret = btrfs_load_block_group_single(fs_info, cache, &zone_info[0], active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
-		ret = btrfs_load_block_group_dup(fs_info, cache, map, zone_info, active);
+		ret = btrfs_load_block_group_dup(fs_info, cache, map, zone_info, active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID1C3:
 	case BTRFS_BLOCK_GROUP_RAID1C4:
-		ret = btrfs_load_block_group_raid1(fs_info, cache, map, zone_info, active);
+		ret = btrfs_load_block_group_raid1(fs_info, cache, map, zone_info, active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
-		ret = btrfs_load_block_group_raid0(fs_info, cache, map, zone_info, active);
+		ret = btrfs_load_block_group_raid0(fs_info, cache, map, zone_info, active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
-		ret = btrfs_load_block_group_raid10(fs_info, cache, map, zone_info, active);
+		ret = btrfs_load_block_group_raid10(fs_info, cache, map, zone_info, active, last_alloc);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
-- 
2.48.1


