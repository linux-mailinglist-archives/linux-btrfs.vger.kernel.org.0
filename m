Return-Path: <linux-btrfs+bounces-854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF280EC07
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E403B1F21379
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E605FF17;
	Tue, 12 Dec 2023 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X4RI3YDr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02BC124;
	Tue, 12 Dec 2023 04:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384697; x=1733920697;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WzAokk5ODdjvW4/f5P8YZlwWo7Vx235+0DogRPEc7kw=;
  b=X4RI3YDrHQyqxVDlOnZmj97gXJ4qkSVChz/lUN51Ajht0aTsKyOjRT9E
   W+2OFcANC19E9n00VQo1/0VD/xb+R1sOwvF+w9uzbgHQNVFJdrV0H3QEa
   Fm+OAzpphoIHCUle1xyyLXdq2im5DcaDWVizRzyK7tPvingxhPVEbPv9Q
   xmZk3UOtEahjYTLmG9ao9LsS8vZ4ysfOWUj5N+VrrGxHRCsp8bLBGWQTP
   9SSXQzw2UV/MGKKFxQ4MAg5Yf36WKzBl0IS3FfIQKgrwJW1S5RVzUFtIb
   doJWpHMmWUT5nC/wrfWrDYugb+K1KyVdpbxDfgEatH7QpR3LootVYOVLE
   w==;
X-CSE-ConnectionGUID: 89DOXQceR2iiczdLWR+a7g==
X-CSE-MsgGUID: olgMV74wSRWuyRbOb6+cjQ==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629788"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:17 +0800
IronPort-SDR: AmG5PtdcC1XRMmn4LP41gXKp7NBB8qUfOVV/XEhRLkyXSeXF+5AxK3QjfV/oW6hcy11Qazc4vO
 I8v/Xtbndh0A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:30 -0800
IronPort-SDR: WH8nRobKMIPo/vxAN7+p3ZQVzg9jIb3Q7237p4t2hGYkt9qzsrF6aAtsa7Ml56sCqf5qqV/HWp
 +bjsBGj+MPag==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:16 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:01 -0800
Subject: [PATCH 03/13] btrfs: factor out block-mapping for RAID0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-3-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1575;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=WzAokk5ODdjvW4/f5P8YZlwWo7Vx235+0DogRPEc7kw=;
 b=/uz+vboQJqlbSQp3k+ds0ZfHHXV5k4xJ4As2oVMMjU3ZQ9l5n7fgGn5bPoK5+6++oONxXvg5o
 5C58tm0DFHxDubj2hCz6XrGnqkUIT5seSpC14Q2Y6/u3lvoeq7ga/uv
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID0, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d0e529b3fd39..a5d85a77da25 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6362,6 +6362,16 @@ static bool is_single_device_io(struct btrfs_fs_info *fs_info,
 	return true;
 }
 
+static void map_blocks_for_raid0(struct btrfs_chunk_map *map,
+				 enum btrfs_map_op op,
+				 struct btrfs_io_geometry *io_geom)
+{
+	io_geom->stripe_index = io_geom->stripe_nr % map->num_stripes;
+	io_geom->stripe_nr /= map->num_stripes;
+	if (op == BTRFS_MAP_READ)
+		io_geom->mirror_num = 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6447,10 +6457,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom.stripe_index = 0;
 	io_geom.mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
-		io_geom.stripe_nr /= map->num_stripes;
-		if (op == BTRFS_MAP_READ)
-			io_geom.mirror_num = 1;
+		map_blocks_for_raid0(map, op, &io_geom);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
 		if (op != BTRFS_MAP_READ) {
 			io_geom.num_stripes = map->num_stripes;

-- 
2.43.0


