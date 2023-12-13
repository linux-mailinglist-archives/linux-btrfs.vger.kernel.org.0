Return-Path: <linux-btrfs+bounces-927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7C4811507
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FA31F2182B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630D2F86D;
	Wed, 13 Dec 2023 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JyF3WpfZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE3F3;
	Wed, 13 Dec 2023 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478592; x=1734014592;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DVkLebp/jq2o9nPLKBH36Ylzg4UHswQI1Rt/5sJXbtI=;
  b=JyF3WpfZFnrGLd2wOOttzdXcI02AKRQR8U+/EnWOg1cmDT4rPVgTh6rL
   X143AyI587MLYxD9bOdvycJb+V5cqFM2WSO4+kFxxKFu0ykMbw+ucVMkH
   wwMku8VfyYiY32aX/48l58AsoFUQeMmtecI36uMd2fmAqf7QhGyZUKX7u
   L4o4lKU8sEE0IsQmTVqht9/v6w61/EC1edntnSA/4GIpgh+tpDglg6S8p
   r7R6Aj1wrmuCTREv8frceRdf0GpbGOJLLxtYxlpC+tDZ7oxoupgow1xsH
   Qx9GkJGH8I0ccwtyxMOU7mIvaIUW4wUte9fGyDrRmGOWC5P+QNBvIEZFS
   g==;
X-CSE-ConnectionGUID: OrrUzAxyQDCplnkLgDsnEw==
X-CSE-MsgGUID: nKJB3GZCQK6JDRStopihqQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802956"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:12 +0800
IronPort-SDR: sxwvuniB2EqbXaM9zqPJ0F2Rf9hj9/HuzkLgPrTYHXeONtGeh9ed7LHEZPzY9M4Hfp0huihwwO
 iw6PoBuTshlA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:24 -0800
IronPort-SDR: mBAKFcxwrFzfAj2Vom8gDZqGSIAYT3F+pNQ4WUosCO/psNqVrevXsPYu5WI2NFJ7LO1tX4YCKh
 JU3dwU9wAMVQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:11 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:42:59 -0800
Subject: [PATCH v2 04/13] btrfs: factor out RAID1 block mapping
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-4-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=2037;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=DVkLebp/jq2o9nPLKBH36Ylzg4UHswQI1Rt/5sJXbtI=;
 b=1youUuYANsh3hL/Mdb6+hv235E6Q8ipshOVB79p0pzI7PCmvrwARxCxk7rgvYcjGQZwztsVG6
 //mH5cnu9pzC/MruV7UKKmV9hCGAOgDFkdz+rCb5omSvb2Gd2TaDiCT
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID1, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1d2e6fb7b9bf..c11fb6db4679 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6372,6 +6372,26 @@ static void map_blocks_raid0(struct btrfs_chunk_map *map,
 		io_geom->mirror_num = 1;
 }
 
+static void map_blocks_raid1(struct btrfs_fs_info *fs_info,
+			     struct btrfs_chunk_map *map,
+			     struct btrfs_io_geometry *io_geom,
+			     bool dev_replace_is_ongoing)
+{
+	if (io_geom->op != BTRFS_MAP_READ) {
+		io_geom->num_stripes = map->num_stripes;
+		return;
+	}
+
+	if (io_geom->mirror_num) {
+		io_geom->stripe_index = io_geom->mirror_num - 1;
+		return;
+	}
+
+	io_geom->stripe_index = find_live_mirror(fs_info, map, 0,
+						 dev_replace_is_ongoing);
+	io_geom->mirror_num = io_geom->stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6461,16 +6481,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
 		map_blocks_raid0(map, &io_geom);
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
+		map_blocks_raid1(fs_info, map, &io_geom,
+				 dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
 		if (op != BTRFS_MAP_READ) {
 			io_geom.num_stripes = map->num_stripes;

-- 
2.43.0


