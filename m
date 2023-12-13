Return-Path: <linux-btrfs+bounces-929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC681150A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539041F20FAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0932EAFB;
	Wed, 13 Dec 2023 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i6yZLI7W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AEE107;
	Wed, 13 Dec 2023 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478594; x=1734014594;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=k/eSjTGoN725k3LZy+WZVmCNR9DvRAZuWjLXRQb2ZVo=;
  b=i6yZLI7WoRfc6IANfbDlojCNQ/f/XOTQb40S2dpTUn3c9TvFWp78feQq
   HfiMDal8qp/9nIoDuOCl+HkchLDxYxLkxeh1HhzaknGXDVnHoCF1mRuv0
   9/p2y0axZIRDfA8l/41Y5dtSvRwllsk/yCT/WAd/tAMNzXcy7x4fTVOda
   ea0JaFM5T1UMITQaR6E8dggg18962EkQ3PpI9FKS207Ovo5pE0Lp19yIf
   XiTVB820IK4JzvX/EXUz+g8zoh/KFlCUPeXH8ZiyqZiaB8oM2Qs4HjNcI
   XyqJKHVhnX2VLR5PoFPxMlLmAO1eUTDAQAMu+fpknst04GUPQhyyCkRex
   Q==;
X-CSE-ConnectionGUID: Vhjy7St+RmqxN4ifySrVjQ==
X-CSE-MsgGUID: 429hW5lOTuib3QA+JrmxTw==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802965"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:14 +0800
IronPort-SDR: NUVmos8vm9cR2oQ4Djni4qHbuIkxqcyumoZpCZC5PsUbne0f8HIrCLuk/2ehSQd+jPSC+jJNL8
 T5jyxTmaiy2Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:26 -0800
IronPort-SDR: c/s0/YKZMafYfky/XtrydRIzOSGnTzsxNh3F/dDJvjUDtMUqdUa0v9pxypBd9+Wk2oogwsW7Tk
 Mmfp2cs1adPA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:13 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:43:01 -0800
Subject: [PATCH v2 06/13] btrfs: factor out block mapping for RAID10
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-6-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=2601;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=k/eSjTGoN725k3LZy+WZVmCNR9DvRAZuWjLXRQb2ZVo=;
 b=eGKcEIqKJEY7oDZiWFy+6o9xNILU5E60gvfBeHaPRV+52HMOLFF4IzrNtknxLTtgz1N/yakLW
 xIDvxy671pBBC4jAqdH8oNLTRB4FGQuNVSZUWHqH3psw4mEc4///jgn
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
index fe2807bb0935..4c9c130cdfd0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6408,6 +6408,35 @@ static void map_blocks_dup(struct btrfs_chunk_map *map,
 	io_geom->mirror_num = 1;
 }
 
+static void map_blocks_raid10(struct btrfs_fs_info *fs_info,
+				  struct btrfs_chunk_map *map,
+				  struct btrfs_io_geometry *io_geom,
+				  bool dev_replace_is_ongoing)
+{
+	u32 factor = map->num_stripes / map->sub_stripes;
+	int old_stripe_index;
+
+	io_geom->stripe_index =
+		(io_geom->stripe_nr % factor) * map->sub_stripes;
+	io_geom->stripe_nr /= factor;
+
+	if (io_geom->op != BTRFS_MAP_READ) {
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
+	io_geom->stripe_index = find_live_mirror(fs_info, map,
+						 io_geom->stripe_index,
+						 dev_replace_is_ongoing);
+	io_geom->mirror_num = io_geom->stripe_index - old_stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6502,23 +6531,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
 		map_blocks_dup(map, &io_geom);
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
+		map_blocks_raid10(fs_info, map, &io_geom,
+				  dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
 			/*

-- 
2.43.0


