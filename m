Return-Path: <linux-btrfs+bounces-864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E180EC23
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8951C20A6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CB6167C;
	Tue, 12 Dec 2023 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fLh+RUuT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E171BB;
	Tue, 12 Dec 2023 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384717; x=1733920717;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gaUiVpID3qEMvXDQr81RAhFpDwEigiqNGfWmpFKH2NQ=;
  b=fLh+RUuTIwU4mFkFqkZumE0x/WXyXngJK3dePnsIcBP7975vRpt3kmAH
   hP+xNvIVQWrMSBPutnGInzDlVei6HbPZFG5ckVbW7ZF7pK5gmo8B9Dlu6
   HJIz19wh15L6CXdQ6hsLle4noIsptlv+Lbka48nFJyFh7aFfqTUOne5fo
   PRnPbQSXyT0DPG07L0ouOYJNjI3nmippb+aETjCiLkEE12HkTWdoz1Gc9
   k/joIMoYdZWKEHX/zGN2ECjcKet6vptPnwUD+3YJRLKKO/5jzgNuwDIbA
   rcIgw8/3WKvNxCvSfb9qNFONYkSBKyxOtoPp+CjhdfPOlueK6KiRNzGlL
   w==;
X-CSE-ConnectionGUID: UBsURaulR7m/419IDXBUwQ==
X-CSE-MsgGUID: NIU47k/7Qkq6VQW4MmuQVA==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629809"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:29 +0800
IronPort-SDR: eDu+MFhi/3vSWcj9l82fhNEPjsUwGNMwjLvhiT1Eog2yG574DLB1YcO1+ZBLvvw+YdSTInEmsH
 HoAyYzcHQ2Mw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:43 -0800
IronPort-SDR: Tc0wOz5i5neycLbDMuj5vFhD/Rrzx2Ol9kgrFhhV3Cd8EHKiOaYy/3ot1sPrMm+QwtfwvkdnUw
 Xotqf2XxxZCg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:28 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:10 -0800
Subject: [PATCH 12/13] btrfs: pass struct btrfs_io_geometry to
 set_io_stripe
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-12-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=2493;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=gaUiVpID3qEMvXDQr81RAhFpDwEigiqNGfWmpFKH2NQ=;
 b=aa5BsgAOxVPVF21/gmUmm8xaPTnvJNyoGCbjrpDaCs5K8w1CO0L5u+UYy28uyLz5A2I8o28QU
 uc6ygA9K52mCWSt9N/t2M2K+htEMzabGk+Hh+5gTV1uMUXGy+rkI3mn
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Instead of passing three members of 'struct btrfs_io_geometry' into
set_io_stripe() pass a pointer to the whole structure and then get the needed
members out of btrfs_io_geometry.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7df991a81c4b..c1fefe34a194 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6326,17 +6326,19 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 
 static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			 u64 logical, u64 *length, struct btrfs_io_stripe *dst,
-			 struct btrfs_chunk_map *map, u32 stripe_index,
-			 u64 stripe_offset, u64 stripe_nr)
+			 struct btrfs_chunk_map *map,
+			 struct btrfs_io_geometry *io_geom)
 {
-	dst->dev = map->stripes[stripe_index].dev;
+	dst->dev = map->stripes[io_geom->stripe_index].dev;
 
 	if (op == BTRFS_MAP_READ && btrfs_need_stripe_tree_update(fs_info, map->type))
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
 
@@ -6634,8 +6636,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op,
 			      io_geom.mirror_num)) {
 		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
-				    io_geom.stripe_index, io_geom.stripe_offset,
-				    io_geom.stripe_nr);
+				    &io_geom);
 		if (mirror_num_ret)
 			*mirror_num_ret = io_geom.mirror_num;
 		*bioc_ret = NULL;
@@ -6688,10 +6689,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 */
 		for (i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
-					    &bioc->stripes[i], map,
-					    io_geom.stripe_index,
-					    io_geom.stripe_offset,
-					    io_geom.stripe_nr);
+					    &bioc->stripes[i], map, &io_geom);
 			if (ret < 0)
 				break;
 			io_geom.stripe_index++;

-- 
2.43.0


