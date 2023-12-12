Return-Path: <linux-btrfs+bounces-865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC980EC25
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A041C20B39
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBA61681;
	Tue, 12 Dec 2023 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f6E0fY25"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB83D41;
	Tue, 12 Dec 2023 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384719; x=1733920719;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1sx5hgMgPsSIl/PcKUCTomxYnHRlrjaft92+/rRZzms=;
  b=f6E0fY25hsnP2yga+ylQzbCqK/UR6X2Xsb0mnfiiCBSuo97fbGxhQ87+
   OxguKuR5afnkNYdo9wXe5VMqSGECNIKNvtFuSpENv37EYncU1MPgvorU5
   1YWmGEaQ9/tNH4wSES01LO10XzVtvUp6s0PKq4oy+fBYx+WoArG0RUGar
   AMJSncZXtvxRX6oOmh6MNVA+MU9PZXn5875GZimBZp6oQB2CCud/vWZ6b
   Wp0dTRAx4jYevY8OIIrGj/tJFCO3iulRJgfLW+2ltcwrJHpXej+nvbU3j
   6SV51u1qLu6P+HhUyGngrJ4Ctmo164++FA1Syf7oEgMCV0w37ab+av9/V
   A==;
X-CSE-ConnectionGUID: /qRWF+KnSwCFVKLRZIxa8g==
X-CSE-MsgGUID: bH/lDlXUSBm7uax+SJcjLQ==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629812"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:31 +0800
IronPort-SDR: Zcu8iEFG+rshvP99Jva+7UOWTUW2pfp3Tjhvk9MgZC+WdDKXeOGdqFS1djHiDpDwiJQSzODyVu
 aPiWG1WmSbWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:44 -0800
IronPort-SDR: IF2uB1LFDxBsYDMIIthw1UW5SVEX6aIqG9iwKBTbl9ammZcgmjnlKLZ89KLkv9sYvZI4S8eqmc
 gmn75I9LcGRw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:30 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:11 -0800
Subject: [PATCH 13/13] btrfs: pass btrfs_io_geometry into btrfs_max_io_len
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-13-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=3139;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=1sx5hgMgPsSIl/PcKUCTomxYnHRlrjaft92+/rRZzms=;
 b=98BGK4uRkR7z1XT2ETsJTcnrBi4ui/+ejviC/yhcIxHKydQ9dXB3nF8e80OyU079RRKSHXrc2
 Id1MqTJEVTND+oxJjoxLazKkYbIjiFrraK+hyESN0v8aoNUkknEiHC+
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Instead of passing three individual members of 'struct btrfs_io_geometry'
into btrfs_max_io_len(), pass a pointer to btrfs_io_geometry.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c1fefe34a194..166750d279ee 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6277,16 +6277,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 }
 
 static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
-			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
-			    u64 *full_stripe_start)
+			    u64 offset, struct btrfs_io_geometry *io_geom)
 {
 	/*
 	 * Stripe_nr is the stripe where this block falls.  stripe_offset is
 	 * the offset of this block in its stripe.
 	 */
-	*stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
-	*stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
-	ASSERT(*stripe_offset < U32_MAX);
+	io_geom->stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
+	io_geom->stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
+	ASSERT(io_geom->stripe_offset < U32_MAX);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		unsigned long full_stripe_len =
@@ -6301,18 +6300,19 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 		 * to go rounddown(), not round_down(), as nr_data_stripes is
 		 * not ensured to be power of 2.
 		 */
-		*full_stripe_start =
-			btrfs_stripe_nr_to_offset(
-				rounddown(*stripe_nr, nr_data_stripes(map)));
+		io_geom->raid56_full_stripe_start = btrfs_stripe_nr_to_offset(
+			rounddown(io_geom->stripe_nr, nr_data_stripes(map)));
 
-		ASSERT(*full_stripe_start + full_stripe_len > offset);
-		ASSERT(*full_stripe_start <= offset);
+		ASSERT(io_geom->raid56_full_stripe_start + full_stripe_len >
+		       offset);
+		ASSERT(io_geom->raid56_full_stripe_start <= offset);
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
 		 */
 		if (op == BTRFS_MAP_WRITE)
-			return full_stripe_len - (offset - *full_stripe_start);
+			return full_stripe_len -
+			       (offset - io_geom->raid56_full_stripe_start);
 	}
 
 	/*
@@ -6320,7 +6320,7 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 	 * a single disk).
 	 */
 	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK)
-		return BTRFS_STRIPE_LEN - *stripe_offset;
+		return BTRFS_STRIPE_LEN - io_geom->stripe_offset;
 	return U64_MAX;
 }
 
@@ -6559,9 +6559,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
-	max_len = btrfs_max_io_len(map, op, map_offset, &io_geom.stripe_nr,
-				   &io_geom.stripe_offset,
-				   &io_geom.raid56_full_stripe_start);
+	max_len = btrfs_max_io_len(map, op, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);

-- 
2.43.0


