Return-Path: <linux-btrfs+bounces-931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5B81150E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB581F21ABC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40582FC5D;
	Wed, 13 Dec 2023 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NyZ3MJKX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49121F5;
	Wed, 13 Dec 2023 06:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478598; x=1734014598;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JrLC6otdJpNPxBMTEGtJC5+A4K6Kf+scnbb6ZiQ1bcM=;
  b=NyZ3MJKX4ayoKXA81odEQhAGJtDl2WRtko/nXlYOYZNgnsn8a8kTSmr5
   sQ/AAaiWJRxM28kUfL0FN2mhaF19XlBgE84yMivXBFuFjQ2vStrkjThI1
   0ks+I4NY0+ubVb44GWPV7Q4kQ/Ymh6Wwyy6We0N0HeYM43IR26/kz80HF
   h1RnOJaqqnhsjwM9cI2RSrd0SVCGy8QiIxzG/ebBDEzj5EuWSmapzQ3Bx
   Labgvp0Av1Fx8EtPH9YlSJKTQMOnxrLJWbti4b1Dr0rKHFuRfpzJ4xO5F
   lLmZ+ZyqedBisPDozTlaT4ZPJmLH6YcemQfcA1zGlxxNSJcRGRwQtREKW
   w==;
X-CSE-ConnectionGUID: ModD/G22Tb6H3dDQmnAG1A==
X-CSE-MsgGUID: 5pr2wx8QRQiuTuRVW5F4HA==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580758"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:18 +0800
IronPort-SDR: 3QbjBlfbIFqCPWx5EZ1PD3MXbVfd8VGMdibjiHnnmFEpE+HXFuPo4wkxtmQEHK1MwezGsrDhpJ
 twHPojFYFMAg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:29 -0800
IronPort-SDR: 0e2xv/lp+/Uo5Obqqegq+kFah03nY2x0azHvdUub5ucRxjXix6DpwUxJqgW8ttRGFvy6zzpw1Q
 VfZ7S57gFRcg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:16 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:43:03 -0800
Subject: [PATCH v2 08/13] btrfs: factor out block mapping for RAID5/6
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-8-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=4380;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=JrLC6otdJpNPxBMTEGtJC5+A4K6Kf+scnbb6ZiQ1bcM=;
 b=hNSvkQw//aHD+11hnf5wXBYQNAWrLOptg4mI7qL3TM5DCyXRbJDcMiW8sfTJ6Pb36YbGPDOpM
 NIxB4YdUYWIA1u+Cs+KodZNRjcsa+n+uk6ukNdWS0mTiDlIHqfdFAC9
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID5 and RAID6, factor out a helper
calculating this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 96 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3a6a2f71d364..55614a9eb8a5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6437,6 +6437,56 @@ static void map_blocks_raid10(struct btrfs_fs_info *fs_info,
 	io_geom->mirror_num = io_geom->stripe_index - old_stripe_index + 1;
 }
 
+static void map_blocks_raid56_write(struct btrfs_chunk_map *map,
+				    struct btrfs_io_geometry *io_geom,
+				    u64 logical, u64 *length)
+{
+	int data_stripes = nr_data_stripes(map);
+
+	/*
+	 * Needs full stripe mapping.
+	 *
+	 * Push stripe_nr back to the start of the full stripe
+	 * For those cases needing a full stripe, @stripe_nr
+	 * is the full stripe number.
+	 *
+	 * Originally we go raid56_full_stripe_start / full_stripe_len,
+	 * but that can be expensive.  Here we just divide
+	 * @stripe_nr with @data_stripes.
+	 */
+	io_geom->stripe_nr /= data_stripes;
+
+	/* RAID[56] write or recovery. Return all stripes */
+	io_geom->num_stripes = map->num_stripes;
+	io_geom->max_errors = btrfs_chunk_max_errors(map);
+
+	/* Return the length to the full stripe end */
+	*length = min(logical + *length,
+		      io_geom->raid56_full_stripe_start + map->start +
+		      btrfs_stripe_nr_to_offset(data_stripes)) -
+		logical;
+	io_geom->stripe_index = 0;
+	io_geom->stripe_offset = 0;
+}
+
+static void map_blocks_raid56_read(struct btrfs_chunk_map *map,
+				   struct btrfs_io_geometry *io_geom)
+{
+	int data_stripes = nr_data_stripes(map);
+
+	ASSERT(io_geom->mirror_num <= 1);
+	/* Just grab the data stripe directly. */
+	io_geom->stripe_index = io_geom->stripe_nr % data_stripes;
+	io_geom->stripe_nr /= data_stripes;
+
+	/* We distribute the parity blocks across stripes */
+	io_geom->stripe_index =
+		(io_geom->stripe_nr + io_geom->stripe_index) % map->num_stripes;
+
+	if (io_geom->op == BTRFS_MAP_READ && io_geom->mirror_num < 1)
+		io_geom->mirror_num = 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6531,48 +6581,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_raid10(fs_info, map, &io_geom,
 				  dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		int data_stripes = nr_data_stripes(map);
-
-		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
-			/*
-			 * Needs full stripe mapping.
-			 *
-			 * Push stripe_nr back to the start of the full stripe
-			 * For those cases needing a full stripe, @stripe_nr
-			 * is the full stripe number.
-			 *
-			 * Originally we go raid56_full_stripe_start / full_stripe_len,
-			 * but that can be expensive.  Here we just divide
-			 * @stripe_nr with @data_stripes.
-			 */
-			io_geom.stripe_nr /= data_stripes;
-
-			/* RAID[56] write or recovery. Return all stripes */
-			io_geom.num_stripes = map->num_stripes;
-			io_geom.max_errors = btrfs_chunk_max_errors(map);
-
-			/* Return the length to the full stripe end */
-			*length = min(logical + *length,
-				      io_geom.raid56_full_stripe_start +
-					      map->start +
-					      btrfs_stripe_nr_to_offset(
-						      data_stripes)) -
-				  logical;
-			io_geom.stripe_index = 0;
-			io_geom.stripe_offset = 0;
-		} else {
-			ASSERT(io_geom.mirror_num <= 1);
-			/* Just grab the data stripe directly. */
-			io_geom.stripe_index = io_geom.stripe_nr % data_stripes;
-			io_geom.stripe_nr /= data_stripes;
-
-			/* We distribute the parity blocks across stripes */
-			io_geom.stripe_index =
-				(io_geom.stripe_nr + io_geom.stripe_index) %
-					map->num_stripes;
-			if (op == BTRFS_MAP_READ && io_geom.mirror_num < 1)
-				io_geom.mirror_num = 1;
-		}
+		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1)
+			map_blocks_raid56_write(map, &io_geom, logical, length);
+		else
+			map_blocks_raid56_read(map, &io_geom);
 	} else {
 		/*
 		 * After this, stripe_nr is the number of stripes on this

-- 
2.43.0


