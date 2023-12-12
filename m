Return-Path: <linux-btrfs+bounces-859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2622880EC15
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDD51F21582
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53760ED6;
	Tue, 12 Dec 2023 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K/Yb0BNO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18D18C;
	Tue, 12 Dec 2023 04:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384710; x=1733920710;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7IitFGc7/IJjyGbmbRVykpWQDNZ+Fz3j+hjcbSopc1E=;
  b=K/Yb0BNOsoES05ZFwy5REND1r1cIX9RQdVEIG9LTijrgsXON2l04Z1lQ
   TfNtO5+L7h5KB6bd7H65ckdAO5mzwuoAzZaFPpIkhLwEwyxTwPaok1Ork
   Urmh9V86MlwWFkK4kxGG5jusJWn4WYBx1s3d0cOnkmjFhVjQ43QzVxPTn
   1AZJ/rnkW0hP2K85p3lrjl9W+GDdomTJQIBweWLZFuTrWAe9dnn1SuZMT
   2PFcxQi9RDICzAI2D+pZbY0sXZUbFVmdJK9UIB+E3bFF6kbPEVv8zkCE/
   qKzs6MZvuhpv8y1I4lTb7Y9hX9pP4VJt9xDSj9SSE/mwt/lAdKhrfK/LM
   Q==;
X-CSE-ConnectionGUID: pD/fV8xhRcexNxFDJ//omg==
X-CSE-MsgGUID: kRCA0+rwTeq+zgKt6hj8XA==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629799"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:22 +0800
IronPort-SDR: R4NX11529yF01cq9XPPIhIyS2B7QsnjTifd/BKHds/GrkRATpWcmFwY/hURfE8oYNZiO6jb++j
 kD/zgcJI1pdg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:36 -0800
IronPort-SDR: 8J6ZDf1DDploJw+gY5lkK5JekK+E157uSfQee0KdypWrWGmB74LaZBDHO0y6h4YPSaEP7JcZ5L
 4oUfsuBCHBZg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:21 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:05 -0800
Subject: [PATCH 07/13] btrfs: reduce scope of data_stripes in
 btrfs_map_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-7-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1989;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=7IitFGc7/IJjyGbmbRVykpWQDNZ+Fz3j+hjcbSopc1E=;
 b=m4KZIBJGlht6nE4zqHrrx7BstIG8G4cLN/crwdkYixYRslsvpO2Vc38LmvGL3ofu+E3yGlXJQ
 06Jf6iwdjM6C2PklkZji0KGEd7Oih8sPYImBrGyVe0epBCfvmyAOGPr
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Reduce the scope of 'data_stripes' in btrfs_map_block(). While the change
allone doesn't make too much sense, it helps us factoring out a helper
function for the block mapping of RAID56 I/O.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9090bfc4fe38..bc0988d8bd56 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6480,7 +6480,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	struct btrfs_chunk_map *map;
 	struct btrfs_io_geometry io_geom = { };
 	u64 map_offset;
-	int data_stripes;
 	int i;
 	int ret = 0;
 	int num_copies;
@@ -6500,8 +6499,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	data_stripes = nr_data_stripes(map);
-
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, op, map_offset, &io_geom.stripe_nr,
@@ -6532,6 +6529,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_for_raid10(fs_info, map, op, &io_geom,
 				      dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		int data_stripes = nr_data_stripes(map);
+
 		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
 			/*
 			 * Needs full stripe mapping.
@@ -6643,7 +6642,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * modulo, to reduce one modulo call.
 		 */
 		bioc->full_stripe_logical = map->start +
-			btrfs_stripe_nr_to_offset(io_geom.stripe_nr * data_stripes);
+			btrfs_stripe_nr_to_offset(io_geom.stripe_nr *
+							nr_data_stripes(map));
 		for (int i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
 					    &bioc->stripes[i], map,

-- 
2.43.0


