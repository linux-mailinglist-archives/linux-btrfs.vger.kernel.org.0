Return-Path: <linux-btrfs+bounces-935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA40811512
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82791C21193
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EB315A2;
	Wed, 13 Dec 2023 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kmYLvyMj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9365113;
	Wed, 13 Dec 2023 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478603; x=1734014603;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eZt1O9QucdaQ99WccyAeIMWXNVcbEm/Y3+q0saMB1e4=;
  b=kmYLvyMjHizh3TsdZFSbhXlm77dPnp7ST3LJS+X5GkGe2otFHSVWRYL+
   7eqU/aI7osADAFMyeWZqhliRcddSjsO6ygZ0fxSkJlmH8GO7rxc9Gb/RO
   FjMp9o8RZROgNn96Al8nFe1QtKl0feUsDIxZiraf2L769r8PbYGmNwaSO
   0DWhNKdiatwsCCAOp+WzrA5dKS6wDEmAT5ITjeZmaDm+IU3N/0ADBXfoF
   qV0sfUJdb3k/TgkPN6xUSgnmAYmeY1XlLzwdVVnw8Z9sPV7oggYUG1J38
   LCuDfWozEoBYw35YAxhCUrAit1ffdFVdDcrMkfSVimFR1al8t2uJhZmzn
   w==;
X-CSE-ConnectionGUID: UiNuIYSbTj+0pO70I3pRrw==
X-CSE-MsgGUID: s9FO/aUeQkyvOyC0yD1ThQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580769"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:22 +0800
IronPort-SDR: ctGPnXkYGwXbRolnSzBm89i7vg3m3zdNMdvCeF26KmMh2AR9p9+LPa4rDdMT5wdv/UUSlrssbX
 yx9zFGXMjpAw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:34 -0800
IronPort-SDR: n1d5fkQCkaI8Fdxj7iL1ktPusJ8p+V4vkMrytCZTeuAigmV32ihbqQhQ8BM1D9HqUyagPCYDGp
 NCmBpl3MpoCQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:21 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:43:07 -0800
Subject: [PATCH v2 12/13] btrfs: pass struct btrfs_io_geometry to
 set_io_stripe
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-12-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=2892;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=eZt1O9QucdaQ99WccyAeIMWXNVcbEm/Y3+q0saMB1e4=;
 b=g41Ospujk+QFP0sv8LXM/Gi1HPxraC4KaS5+vr9p2XRrIj+7JcgZIcoTnZd1cpUmQmL0imz3A
 vWBspq5WS/UC5cvDkzyu03wXNWGML/vtQXAofqiYT/5bC46CRLtmDkj
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Instead of passing three members of 'struct btrfs_io_geometry' into
set_io_stripe() pass a pointer to the whole structure and then get the needed
members out of btrfs_io_geometry.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5e4885a01796..440ac0c1c907 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6325,19 +6325,22 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 	return U64_MAX;
 }
 
-static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-			 u64 logical, u64 *length, struct btrfs_io_stripe *dst,
-			 struct btrfs_chunk_map *map, u32 stripe_index,
-			 u64 stripe_offset, u64 stripe_nr)
+static int set_io_stripe(struct btrfs_fs_info *fs_info, u64 logical,
+			 u64 *length, struct btrfs_io_stripe *dst,
+			 struct btrfs_chunk_map *map,
+			 struct btrfs_io_geometry *io_geom)
 {
-	dst->dev = map->stripes[stripe_index].dev;
+	dst->dev = map->stripes[io_geom->stripe_index].dev;
 
-	if (op == BTRFS_MAP_READ && btrfs_need_stripe_tree_update(fs_info, map->type))
+	if (io_geom->op == BTRFS_MAP_READ &&
+	    btrfs_need_stripe_tree_update(fs_info, map->type))
 		return btrfs_get_raid_extent_offset(fs_info, logical, length,
-						    map->type, stripe_index, dst);
+						    map->type,
+						    io_geom->stripe_index, dst);
 
-	dst->physical = map->stripes[stripe_index].physical +
-			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
+	dst->physical = map->stripes[io_geom->stripe_index].physical +
+			io_geom->stripe_offset +
+			btrfs_stripe_nr_to_offset(io_geom->stripe_nr);
 	return 0;
 }
 
@@ -6638,9 +6641,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 */
 	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op,
 			      io_geom.mirror_num)) {
-		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
-				    io_geom.stripe_index, io_geom.stripe_offset,
-				    io_geom.stripe_nr);
+		ret = set_io_stripe(fs_info, logical, length, smap, map,
+				    &io_geom);
 		if (mirror_num_ret)
 			*mirror_num_ret = io_geom.mirror_num;
 		*bioc_ret = NULL;
@@ -6692,11 +6694,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * stripe into the bioc.
 		 */
 		for (i = 0; i < io_geom.num_stripes; i++) {
-			ret = set_io_stripe(fs_info, op, logical, length,
-					    &bioc->stripes[i], map,
-					    io_geom.stripe_index,
-					    io_geom.stripe_offset,
-					    io_geom.stripe_nr);
+			ret = set_io_stripe(fs_info, logical, length,
+					    &bioc->stripes[i], map, &io_geom);
 			if (ret < 0)
 				break;
 			io_geom.stripe_index++;

-- 
2.43.0


