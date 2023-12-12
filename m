Return-Path: <linux-btrfs+bounces-857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E05C80EC0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AD1C20AD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066160EC4;
	Tue, 12 Dec 2023 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="llIIDe5i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045BBF7;
	Tue, 12 Dec 2023 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384701; x=1733920701;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ebYL8Lh5wqUhbEP90Uoh61na4d5uGMM/U9hqcqH7K+Y=;
  b=llIIDe5iYhVc6CGXipW7lrSD0wsp+4eBaAF6cvBqv9J/T6cQivUXsl01
   ZQjrf0/LQWT67gNoJ/WTNNy0tvVcfnTGF27hXj4WORI07uaqhH9NyEbBy
   ad7ChXXNuSN/x3dg1DOEFMWiEQD+IoawZmP94hHsG9fTs/6rtAQQtYe1y
   NFtoybuNP3LQjJMfPigcYgZo0cxtekKJK0AhwMZ08AMNWh6X6wrUIr9A1
   nRnmUrcl3tvg8x/0oLe/xAecljc9FGeE0LEJwAFOr+BTuEc7xM+Y3zbfn
   7akC9kFnMmemiR+Zt1JXwRN3gnZDALn0eURbFVZHNy3EBLRcM9KAOtLLg
   A==;
X-CSE-ConnectionGUID: V4Y9g6jFSFOPS/tGQSNYmQ==
X-CSE-MsgGUID: A6l7RrrfQ5ajfXSA0bNwew==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629789"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:18 +0800
IronPort-SDR: 5cgj/ywiWV1Xwx4jbZTECYaN6dHkn5CkPYWosv1NDLNiEfvi08dgPPeaQKoSUUtkjJChRfUPKD
 wAuVHpYSM1LQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:31 -0800
IronPort-SDR: caHHQ/Iaccr62S3pNOUgNTh8l3uYglaMj0x4HVxvGpZtXY+6837I9w98bidSfHIQscu4pe5hf5
 yWya5NCITmMQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:17 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:02 -0800
Subject: [PATCH 04/13] btrfs: factor out RAID1 block mapping
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-4-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=2028;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=ebYL8Lh5wqUhbEP90Uoh61na4d5uGMM/U9hqcqH7K+Y=;
 b=LM6TyK9cR63cC+HyWnjRomzXJyTGYo2mmltNAh+lgwQBnk7ytBOsp2hupb0maiwPSgQ6vPgjs
 5QuN8YthKA/CNWcncr9R7cqJwsG5f2JH0K3BL1ve3bjqYFBPFWKNGrw
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID1, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a5d85a77da25..f6f1e783b3c1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6372,6 +6372,25 @@ static void map_blocks_for_raid0(struct btrfs_chunk_map *map,
 		io_geom->mirror_num = 1;
 }
 
+static void map_blocks_for_raid1(struct btrfs_fs_info *fs_info,
+				 struct btrfs_chunk_map *map,
+				 enum btrfs_map_op op,
+				 struct btrfs_io_geometry *io_geom, int replace)
+{
+	if (op != BTRFS_MAP_READ) {
+		io_geom->num_stripes = map->num_stripes;
+		return;
+	}
+
+	if (io_geom->mirror_num) {
+		io_geom->stripe_index = io_geom->mirror_num - 1;
+		return;
+	}
+
+	io_geom->stripe_index = find_live_mirror(fs_info, map, 0, replace);
+	io_geom->mirror_num = io_geom->stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6459,16 +6478,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
 		map_blocks_for_raid0(map, op, &io_geom);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
-		if (op != BTRFS_MAP_READ) {
-			io_geom.num_stripes = map->num_stripes;
-		} else if (io_geom.mirror_num) {
-			io_geom.stripe_index = io_geom.mirror_num - 1;
-		} else {
-			io_geom.stripe_index = find_live_mirror(fs_info, map, 0,
-					    dev_replace_is_ongoing);
-			io_geom.mirror_num = io_geom.stripe_index + 1;
-		}
-
+		map_blocks_for_raid1(fs_info, map, op, &io_geom,
+				     dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
 		if (op != BTRFS_MAP_READ) {
 			io_geom.num_stripes = map->num_stripes;

-- 
2.43.0


