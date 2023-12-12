Return-Path: <linux-btrfs+bounces-858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D180EC13
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6535B20EE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B760ECC;
	Tue, 12 Dec 2023 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k/PoXMnJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A92FD;
	Tue, 12 Dec 2023 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384703; x=1733920703;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=lXJp7Vki0//VmgCnvQn6BIvzp7MNt5URtbIDUaZNqA8=;
  b=k/PoXMnJEPt14NaJLdJka9Q5/mrcVvnCfg8Uky2u5yIfa0L6C3e3vRTW
   kHL49jDPt2EvPohCYwLW+vfnyKMuTD5DiGdhWNRRInLMuxAsKdIX0+pAy
   3yAw7mTI0dA1ccOb2GuHiJnV3irMem0pBJkbOs08sTZR2YoyELzpqGUcw
   aw3JWf7v0QzVd77w4VBGeRIVe730Vy1EyLeoqvolcdNEzCp2UTP6eRixZ
   eBMsETqHtUS1JQfDBcfFr4NhY+hTt9lWnDj5Zt+XyGX2mU2J+xWV3y9Nv
   4ZQYWyeBWOwbQ+3HVDJlAL2t1kiSZJyYaUdYNKIBuT8ewmCmcJEpzQwwR
   g==;
X-CSE-ConnectionGUID: daMNu9RUSHO9LoTO8c8C8A==
X-CSE-MsgGUID: 6DIaMXuuT7Smg3fvFVgwMQ==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629798"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:21 +0800
IronPort-SDR: wCyq9dJo0BJXILY179PkoUmorCzlwyiDBdNw/9YAT/U7sWKLr7PEg0MwxG1S+fhlOae0jeROwE
 CDZ5xJngEXHQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:34 -0800
IronPort-SDR: /h257Fekxf+NXY9HO8WkSWfXGX6nO92JgHLxMDvw5r8Xc1jottiO/IJr73IAlR2TiJmZSSMCqc
 +kPftaDVG9Ew==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:20 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:04 -0800
Subject: [PATCH 06/13] btrfs: factor out block mapping for RAID10
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-6-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=2605;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=lXJp7Vki0//VmgCnvQn6BIvzp7MNt5URtbIDUaZNqA8=;
 b=d8m+QckEF6cYQbcvWsipkYLVoLwlaSreKemUA+fZRMjVs7GRVPDazRslJqnJFWPgSoYlrbnUM
 87c5xvQ4hTFDUpyasUNrv+D3J/gffiOBSoS2DC+MlOpoCfsAGWstxTv
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID10, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b0a5c53fba51..9090bfc4fe38 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6408,6 +6408,35 @@ static void map_blocks_for_dup(struct btrfs_chunk_map *map,
 	io_geom->mirror_num = 1;
 }
 
+static void map_blocks_for_raid10(struct btrfs_fs_info *fs_info,
+				  struct btrfs_chunk_map *map,
+				  enum btrfs_map_op op,
+				  struct btrfs_io_geometry *io_geom,
+				  int replace)
+{
+	u32 factor = map->num_stripes / map->sub_stripes;
+	int old_stripe_index;
+
+	io_geom->stripe_index =
+		(io_geom->stripe_nr % factor) * map->sub_stripes;
+	io_geom->stripe_nr /= factor;
+
+	if (op != BTRFS_MAP_READ) {
+		io_geom->num_stripes = map->sub_stripes;
+		return;
+	}
+
+	if (io_geom->mirror_num) {
+		io_geom->stripe_index += io_geom->mirror_num - 1;
+		return;
+	}
+
+	old_stripe_index = io_geom->stripe_index;
+	io_geom->stripe_index =
+		find_live_mirror(fs_info, map, io_geom->stripe_index, replace);
+	io_geom->mirror_num = io_geom->stripe_index - old_stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6500,23 +6529,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
 		map_blocks_for_dup(map, op, &io_geom);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
-		u32 factor = map->num_stripes / map->sub_stripes;
-
-		io_geom.stripe_index = (io_geom.stripe_nr % factor) * map->sub_stripes;
-		io_geom.stripe_nr /= factor;
-
-		if (op != BTRFS_MAP_READ)
-			io_geom.num_stripes = map->sub_stripes;
-		else if (io_geom.mirror_num)
-			io_geom.stripe_index += io_geom.mirror_num - 1;
-		else {
-			int old_stripe_index = io_geom.stripe_index;
-			io_geom.stripe_index = find_live_mirror(fs_info, map,
-					      io_geom.stripe_index,
-					      dev_replace_is_ongoing);
-			io_geom.mirror_num = io_geom.stripe_index - old_stripe_index + 1;
-		}
-
+		map_blocks_for_raid10(fs_info, map, op, &io_geom,
+				      dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
 			/*

-- 
2.43.0


