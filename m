Return-Path: <linux-btrfs+bounces-856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646B80EC0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107FF281443
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD95FF1F;
	Tue, 12 Dec 2023 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qpnHGXKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D8CFF;
	Tue, 12 Dec 2023 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384702; x=1733920702;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8tSsg77Jh959a0uxcl1WAe3mo/6FrLyJjMAFBfZRrMM=;
  b=qpnHGXKdLzhvCpccNO0ZT0TkjStE99sWyiGGBm6CWYCnMGzZRKQ2/QYu
   IoawUGvGK7LbBOVDGF2a7NOYS5uwb5XUN4KMAC79T48tKdwsfnt8h7go8
   PEoN8fBAc74LLFDDpj39MnttmiIBWtzUkGgrFEZOgUlFvhwd2IsrQHuRY
   UL5KAxv1MsBjORhHNThGARcXDXH523ZR2Zk39lTVquyTGoXgdi5RyWmdp
   m8KkNw6uFlKW6ghvQUzgUP9GkG2YR5ruSRopKKJawxIOmGDqxhF4HsesU
   e47fOa9CKb+EiLtVYAFxSiYMYzdCHVwxAfNnqUB1QB7WEl+rFRaTkcYeo
   Q==;
X-CSE-ConnectionGUID: +fJ9JpiQRUO/saY3erqFjg==
X-CSE-MsgGUID: gDJS8AhiRnOVDxZfhomuGw==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629795"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:20 +0800
IronPort-SDR: O8vjKsrK2E1rtCUsHz872Qe5D5FukZVD00YqSvImHaVmCsRoeZLPzr52vvMFjOKfkSqe4o2XEb
 tRKhwaLCzaZg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:33 -0800
IronPort-SDR: QjNMLaPjJ6RXcxrvEibP4i0X1/swpg9MR3SOFacbK7LRNRnAdj0Skwno5EeuwTF0redLPIJUfx
 Quku+SPSvTnw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:18 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:03 -0800
Subject: [PATCH 05/13] btrfs: factor out block mapping for DUP profiles
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-5-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1714;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=8tSsg77Jh959a0uxcl1WAe3mo/6FrLyJjMAFBfZRrMM=;
 b=ARMrZTeHJQxstKrYpJ23CIAMX+dVKyPyZHzUPoWeD+Q73R5MetKwQKEkmJgxRP9IFb+oMVvUx
 DXVswOoPs5eD1Fx44sB2Wm00gdXokfMydHgYVc5Xna5c3fr8oWZIU+e
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of DUP, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f6f1e783b3c1..b0a5c53fba51 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6391,6 +6391,23 @@ static void map_blocks_for_raid1(struct btrfs_fs_info *fs_info,
 	io_geom->mirror_num = io_geom->stripe_index + 1;
 }
 
+static void map_blocks_for_dup(struct btrfs_chunk_map *map,
+			       enum btrfs_map_op op,
+			       struct btrfs_io_geometry *io_geom)
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
+	io_geom->mirror_num = 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6481,14 +6498,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_for_raid1(fs_info, map, op, &io_geom,
 				     dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		if (op != BTRFS_MAP_READ) {
-			io_geom.num_stripes = map->num_stripes;
-		} else if (io_geom.mirror_num) {
-			io_geom.stripe_index = io_geom.mirror_num - 1;
-		} else {
-			io_geom.mirror_num = 1;
-		}
-
+		map_blocks_for_dup(map, op, &io_geom);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		u32 factor = map->num_stripes / map->sub_stripes;
 

-- 
2.43.0


