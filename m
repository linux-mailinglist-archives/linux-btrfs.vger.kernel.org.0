Return-Path: <linux-btrfs+bounces-18359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD4C0C220
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 08:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375E23B9ABC
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFD2DEA8E;
	Mon, 27 Oct 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TG+E3KTx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B12DE718
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550155; cv=none; b=IdoPWdGOuGxT6eaMSZcwcqlfFXcU5lTJHbzzL+fVd7LuWugKbHr8opq4ity356+gfa0IPYQLUQLV6LqLOYl+uEn0/PQ98wPYRpH9+Fs/a1PEl+TRFVO2ndJoOG4V25f1s0zLV2dQelnYSrFO7MOpK0IA2sPYGMiZYzNnNnEXWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550155; c=relaxed/simple;
	bh=4AYMjqPSwDV+YJCsweLYphTURTDt1NUY4GEavVtl0Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWU3eDn4WiwpJTxvS6muOe2CbLrRDQ46B8YfdJklmepS90ROyrkJBcraLnb38ORJJ2EGCNM5JV4H1unTr1JmP8z+Pz0BXpI4Wz4FsnetosW/xEjgQE8Zm58c1IoeAeTWq3lNmQSCmAkP0gFB6P0hoJP35dXoAY/bbJ2g3nZ3Bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TG+E3KTx; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761550154; x=1793086154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4AYMjqPSwDV+YJCsweLYphTURTDt1NUY4GEavVtl0Jw=;
  b=TG+E3KTx841I7DKq9SCSPl5pFTlfEZk39kNv2H4/ujbazXmrs63u3xnG
   gtrjwKKbLo55lc6gVZbKLS8E/K+INmPs9NUqkeSrZIjQHdeF85u01w099
   CTIa4MI5mDNbI0uregM+hAVFzuoaI75OQcAqaz92kKw5hfHu65q9qpu5j
   YbMSPqCVihnk0u+UBmbPsk6th51yePdwPR/ihNeVU0LO2DYK1tcXWvOR9
   C93MQjaZTlZ9JZvEeIzejZbG2JRBk/sXNssiLbvSlXx9vQFxS/v++QUYK
   nPK5SIG2Z00d/xZmzVet+/nNEHH+1PX1DRusT2c9qpOn58juaRV394AKV
   w==;
X-CSE-ConnectionGUID: fIrq+76dRImtVWykt5z+lw==
X-CSE-MsgGUID: zwTv7gGhTPSMZtfQQFw1yg==
X-IronPort-AV: E=Sophos;i="6.19,258,1754928000"; 
   d="scan'208";a="130947255"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2025 15:29:04 +0800
IronPort-SDR: 68ff1f40_1Qp9v/TaHzOIrLMS5CPARZiYrqNSqHZ3Z2OgMiBGgtoCPBY
 3dQPTsEM15ncJ979EkgMR9w/duwqrygAGOM6SXw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2025 00:29:05 -0700
WDCIronportException: Internal
Received: from wdap-xbhuzc2r95.ad.shared (HELO naota-xeon) ([10.224.105.146])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Oct 2025 00:29:04 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: fix stripe width calculation
Date: Mon, 27 Oct 2025 16:27:58 +0900
Message-ID: <20251027072758.1066720-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027072758.1066720-1-naohiro.aota@wdc.com>
References: <20251027072758.1066720-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stripe offset calculation in the zoned code for raid0 and raid10
wrongly uses map->stripe_size to calculate it. In fact, map->stripe_size is
the size of the device extent composing the block group, which always is
the zone_size on the zoned setup.

Fix it by using BTRFS_STRIPE_LEN and BTRFS_STRIPE_LEN_SHIFT. Also, optimize
the calculation a bit by doing the common calculation only once.

Fixes: c0d90a79e8e6 ("btrfs: zoned: fix alloc_offset calculation for partly conventional block groups")
CC: stable@vger.kernel.org # 6.17+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 58 +++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f20a9b83b7e1..4c53990cc0ef 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1523,6 +1523,8 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 					u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 stripe_nr = 0, stripe_offset = 0;
+	u32 stripe_index = 0;
 
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
@@ -1530,28 +1532,27 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	if (last_alloc) {
+		u32 factor = map->num_stripes;
+
+		stripe_nr = last_alloc >> BTRFS_STRIPE_LEN_SHIFT;
+		stripe_offset = last_alloc & BTRFS_STRIPE_LEN_MASK;
+		stripe_index = stripe_nr % factor;
+		stripe_nr /= factor;
+	}
+
 	for (int i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
 
 		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
-			u64 stripe_nr, full_stripe_nr;
-			u64 stripe_offset;
-			int stripe_index;
 
-			stripe_nr = div64_u64(last_alloc, map->stripe_size);
-			stripe_offset = stripe_nr * map->stripe_size;
-			full_stripe_nr = div_u64(stripe_nr, map->num_stripes);
-			div_u64_rem(stripe_nr, map->num_stripes, &stripe_index);
-
-			zone_info[i].alloc_offset =
-				full_stripe_nr * map->stripe_size;
+			zone_info[i].alloc_offset = btrfs_stripe_nr_to_offset(stripe_nr);
 
 			if (stripe_index > i)
-				zone_info[i].alloc_offset += map->stripe_size;
+				zone_info[i].alloc_offset += BTRFS_STRIPE_LEN;
 			else if (stripe_index == i)
-				zone_info[i].alloc_offset +=
-					(last_alloc - stripe_offset);
+				zone_info[i].alloc_offset += stripe_offset;
 		}
 
 		if (test_bit(0, active) != test_bit(i, active)) {
@@ -1575,6 +1576,8 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 					 u64 last_alloc)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 stripe_nr = 0, stripe_offset = 0;
+	u32 stripe_index = 0;
 
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
@@ -1582,6 +1585,15 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		return -EINVAL;
 	}
 
+	if (last_alloc) {
+		u32 factor = map->num_stripes / map->sub_stripes;
+
+		stripe_nr = last_alloc >> BTRFS_STRIPE_LEN_SHIFT;
+		stripe_offset = last_alloc & BTRFS_STRIPE_LEN_MASK;
+		stripe_index = stripe_nr % factor;
+		stripe_nr /= factor;
+	}
+
 	for (int i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
@@ -1595,26 +1607,12 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
 		}
 
 		if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
-			u64 stripe_nr, full_stripe_nr;
-			u64 stripe_offset;
-			int stripe_index;
-
-			stripe_nr = div64_u64(last_alloc, map->stripe_size);
-			stripe_offset = stripe_nr * map->stripe_size;
-			full_stripe_nr = div_u64(stripe_nr,
-					 map->num_stripes / map->sub_stripes);
-			div_u64_rem(stripe_nr,
-				    (map->num_stripes / map->sub_stripes),
-				    &stripe_index);
-
-			zone_info[i].alloc_offset =
-				full_stripe_nr * map->stripe_size;
+			zone_info[i].alloc_offset = btrfs_stripe_nr_to_offset(stripe_nr);
 
 			if (stripe_index > (i / map->sub_stripes))
-				zone_info[i].alloc_offset += map->stripe_size;
+				zone_info[i].alloc_offset += BTRFS_STRIPE_LEN;
 			else if (stripe_index == (i / map->sub_stripes))
-				zone_info[i].alloc_offset +=
-					(last_alloc - stripe_offset);
+				zone_info[i].alloc_offset += stripe_offset;
 		}
 
 		if ((i % map->sub_stripes) == 0) {
-- 
2.51.1


