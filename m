Return-Path: <linux-btrfs+bounces-925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF188114FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F261F21845
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D22F52A;
	Wed, 13 Dec 2023 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N41Le6Kx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B99DD;
	Wed, 13 Dec 2023 06:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478590; x=1734014590;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kCWRP4ScRPyTqiJ4MDp9iTyJnJWsDUgaRphcdVMeqP4=;
  b=N41Le6KxFn1+00e4QkNJYWknHyiC5pUZlCIMXZl1JleqpUahAZlo1Q3S
   c06LK5bQA2/g0ot0tLej1i9/cERf0NOpphmxCAJ7eZqS/jpcZ6OZzATWm
   c7E370XqTda7YgF/nfcR2nF3PKSXxG6g7j2wcIHgeCxmQgk9ePOufLgJw
   0C1sLz7qkhzLYe8u3njnFwQKBSMxB9G3HR2C5fSiyvfhnA9Laof+hywgR
   5/9l2s83g4w4NSJ8UreIib1HM5BTwQwUEWnQllmKZrPL6XjKiaM3efWX9
   DZxvnnT/tpX402YvnsPfaCB9F+i4Z6W0iNWcCXGttr/NbknHmPPTJyFZs
   g==;
X-CSE-ConnectionGUID: rxeWZ6TySI6feA77rUiLtA==
X-CSE-MsgGUID: oJw4pwKgRxye/OJealKLtA==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802945"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:09 +0800
IronPort-SDR: FWVbcpiYP1oJc9svd3OUOlP063r4p9weCnI58aYtoI/Jwtl6e2tD2wzFH2vhFQrBNIqXgMSmf9
 YjZkfrBVP/KA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:21 -0800
IronPort-SDR: Sdqk3/eBzRzzkp2HGk8fT6lwuLwp1XheEUB6rD5taGVGQtS9g2aGj/uFym8ECulRPJu571htm7
 Mz5ocnGzDYDw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:09 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 06:42:57 -0800
Subject: [PATCH v2 02/13] btrfs: re-introduce struct btrfs_io_geometry
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-2-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=11440;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=kCWRP4ScRPyTqiJ4MDp9iTyJnJWsDUgaRphcdVMeqP4=;
 b=OFP/4/oB9kN+9QYp7QGL72N2aaB/7kQePUB5cM8B57xxcsjfqxEKzWkE0ZgWdL3QvXQU4ufHk
 wFQ2RN9N/S+Am1+6rQ+f7CW/Uplka857APsWBc8ByWin+H4jp6VfSbR
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Re-introduce struct btrfs_io_geometry, holding the necessary bits and
pieces needed in btrfs_map_block() to decide the I/O geometry of a specific
block mapping.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 159 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 89 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1011178a244c..ea830ff0c0e3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -41,6 +41,17 @@
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
 
+struct btrfs_io_geometry {
+	u32 stripe_index;
+	u32 stripe_nr;
+	int mirror_num;
+	int num_stripes;
+	u64 stripe_offset;
+	u64 raid56_full_stripe_start;
+	int max_errors;
+	enum btrfs_map_op op;
+};
+
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.sub_stripes	= 2,
@@ -6393,28 +6404,27 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		    struct btrfs_io_stripe *smap, int *mirror_num_ret)
 {
 	struct btrfs_chunk_map *map;
+	struct btrfs_io_geometry io_geom = { };
 	u64 map_offset;
-	u64 stripe_offset;
-	u32 stripe_nr;
-	u32 stripe_index;
 	int data_stripes;
 	int i;
 	int ret = 0;
-	int mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
-	int num_stripes;
 	int num_copies;
-	int max_errors = 0;
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int dev_replace_is_ongoing = 0;
 	u16 num_alloc_stripes;
-	u64 raid56_full_stripe_start = (u64)-1;
 	u64 max_len;
 
 	ASSERT(bioc_ret);
 
+	io_geom.mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
+	io_geom.num_stripes = 1;
+	io_geom.stripe_index = 0;
+	io_geom.op = op;
+
 	num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
-	if (mirror_num > num_copies)
+	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
 
 	map = btrfs_get_chunk_map(fs_info, logical, *length);
@@ -6424,8 +6434,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	data_stripes = nr_data_stripes(map);
 
 	map_offset = logical - map->start;
-	max_len = btrfs_max_io_len(map, op, map_offset, &stripe_nr,
-				   &stripe_offset, &raid56_full_stripe_start);
+	io_geom.raid56_full_stripe_start = (u64)-1;
+	max_len = btrfs_max_io_len(map, io_geom.op, map_offset, &io_geom.stripe_nr,
+				   &io_geom.stripe_offset,
+				   &io_geom.raid56_full_stripe_start);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);
@@ -6437,53 +6449,51 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (!dev_replace_is_ongoing)
 		up_read(&dev_replace->rwsem);
 
-	num_stripes = 1;
-	stripe_index = 0;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-		stripe_index = stripe_nr % map->num_stripes;
-		stripe_nr /= map->num_stripes;
+		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
+		io_geom.stripe_nr /= map->num_stripes;
 		if (op == BTRFS_MAP_READ)
-			mirror_num = 1;
+			io_geom.mirror_num = 1;
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
 		if (op != BTRFS_MAP_READ) {
-			num_stripes = map->num_stripes;
-		} else if (mirror_num) {
-			stripe_index = mirror_num - 1;
+			io_geom.num_stripes = map->num_stripes;
+		} else if (io_geom.mirror_num) {
+			io_geom.stripe_index = io_geom.mirror_num - 1;
 		} else {
-			stripe_index = find_live_mirror(fs_info, map, 0,
+			io_geom.stripe_index = find_live_mirror(fs_info, map, 0,
 					    dev_replace_is_ongoing);
-			mirror_num = stripe_index + 1;
+			io_geom.mirror_num = io_geom.stripe_index + 1;
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
 		if (op != BTRFS_MAP_READ) {
-			num_stripes = map->num_stripes;
-		} else if (mirror_num) {
-			stripe_index = mirror_num - 1;
+			io_geom.num_stripes = map->num_stripes;
+		} else if (io_geom.mirror_num) {
+			io_geom.stripe_index = io_geom.mirror_num - 1;
 		} else {
-			mirror_num = 1;
+			io_geom.mirror_num = 1;
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		u32 factor = map->num_stripes / map->sub_stripes;
 
-		stripe_index = (stripe_nr % factor) * map->sub_stripes;
-		stripe_nr /= factor;
+		io_geom.stripe_index = (io_geom.stripe_nr % factor) * map->sub_stripes;
+		io_geom.stripe_nr /= factor;
 
 		if (op != BTRFS_MAP_READ)
-			num_stripes = map->sub_stripes;
-		else if (mirror_num)
-			stripe_index += mirror_num - 1;
+			io_geom.num_stripes = map->sub_stripes;
+		else if (io_geom.mirror_num)
+			io_geom.stripe_index += io_geom.mirror_num - 1;
 		else {
-			int old_stripe_index = stripe_index;
-			stripe_index = find_live_mirror(fs_info, map,
-					      stripe_index,
+			int old_stripe_index = io_geom.stripe_index;
+			io_geom.stripe_index = find_live_mirror(fs_info, map,
+					      io_geom.stripe_index,
 					      dev_replace_is_ongoing);
-			mirror_num = stripe_index - old_stripe_index + 1;
+			io_geom.mirror_num = io_geom.stripe_index - old_stripe_index + 1;
 		}
 
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		if (op != BTRFS_MAP_READ || mirror_num > 1) {
+		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
 			/*
 			 * Needs full stripe mapping.
 			 *
@@ -6495,29 +6505,33 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			 * but that can be expensive.  Here we just divide
 			 * @stripe_nr with @data_stripes.
 			 */
-			stripe_nr /= data_stripes;
+			io_geom.stripe_nr /= data_stripes;
 
 			/* RAID[56] write or recovery. Return all stripes */
-			num_stripes = map->num_stripes;
-			max_errors = btrfs_chunk_max_errors(map);
+			io_geom.num_stripes = map->num_stripes;
+			io_geom.max_errors = btrfs_chunk_max_errors(map);
 
 			/* Return the length to the full stripe end */
 			*length = min(logical + *length,
-				      raid56_full_stripe_start + map->start +
-				      btrfs_stripe_nr_to_offset(data_stripes)) -
+				      io_geom.raid56_full_stripe_start +
+					      map->start +
+					      btrfs_stripe_nr_to_offset(
+						      data_stripes)) -
 				  logical;
-			stripe_index = 0;
-			stripe_offset = 0;
+			io_geom.stripe_index = 0;
+			io_geom.stripe_offset = 0;
 		} else {
-			ASSERT(mirror_num <= 1);
+			ASSERT(io_geom.mirror_num <= 1);
 			/* Just grab the data stripe directly. */
-			stripe_index = stripe_nr % data_stripes;
-			stripe_nr /= data_stripes;
+			io_geom.stripe_index = io_geom.stripe_nr % data_stripes;
+			io_geom.stripe_nr /= data_stripes;
 
 			/* We distribute the parity blocks across stripes */
-			stripe_index = (stripe_nr + stripe_index) % map->num_stripes;
-			if (op == BTRFS_MAP_READ && mirror_num < 1)
-				mirror_num = 1;
+			io_geom.stripe_index =
+				(io_geom.stripe_nr + io_geom.stripe_index) %
+					map->num_stripes;
+			if (op == BTRFS_MAP_READ && io_geom.mirror_num < 1)
+				io_geom.mirror_num = 1;
 		}
 	} else {
 		/*
@@ -6525,19 +6539,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
-		stripe_index = stripe_nr % map->num_stripes;
-		stripe_nr /= map->num_stripes;
-		mirror_num = stripe_index + 1;
+		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
+		io_geom.stripe_nr /= map->num_stripes;
+		io_geom.mirror_num = io_geom.stripe_index + 1;
 	}
-	if (stripe_index >= map->num_stripes) {
+	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
-			   stripe_index, map->num_stripes);
+			   io_geom.stripe_index, map->num_stripes);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	num_alloc_stripes = num_stripes;
+	num_alloc_stripes = io_geom.num_stripes;
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    op != BTRFS_MAP_READ)
 		/*
@@ -6555,11 +6569,12 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op,
-			      mirror_num)) {
+			      io_geom.mirror_num)) {
 		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
-				    stripe_index, stripe_offset, stripe_nr);
+				    io_geom.stripe_index, io_geom.stripe_offset,
+				    io_geom.stripe_nr);
 		if (mirror_num_ret)
-			*mirror_num_ret = mirror_num;
+			*mirror_num_ret = io_geom.mirror_num;
 		*bioc_ret = NULL;
 		goto out;
 	}
@@ -6579,7 +6594,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * It's still mostly the same as other profiles, just with extra rotation.
 	 */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK &&
-	    (op != BTRFS_MAP_READ || mirror_num > 1)) {
+	    (op != BTRFS_MAP_READ || io_geom.mirror_num > 1)) {
 		/*
 		 * For RAID56 @stripe_nr is already the number of full stripes
 		 * before us, which is also the rotation value (needs to modulo
@@ -6589,12 +6604,13 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * modulo, to reduce one modulo call.
 		 */
 		bioc->full_stripe_logical = map->start +
-			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
-		for (int i = 0; i < num_stripes; i++) {
+			btrfs_stripe_nr_to_offset(io_geom.stripe_nr * data_stripes);
+		for (int i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
 					    &bioc->stripes[i], map,
-					    (i + stripe_nr) % num_stripes,
-					    stripe_offset, stripe_nr);
+					    (i + io_geom.stripe_nr) % io_geom.num_stripes,
+					    io_geom.stripe_offset,
+					    io_geom.stripe_nr);
 			if (ret < 0)
 				break;
 		}
@@ -6603,13 +6619,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
-		for (i = 0; i < num_stripes; i++) {
+		for (i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
-					    &bioc->stripes[i], map, stripe_index,
-					    stripe_offset, stripe_nr);
+					    &bioc->stripes[i], map,
+					    io_geom.stripe_index,
+					    io_geom.stripe_offset,
+					    io_geom.stripe_nr);
 			if (ret < 0)
 				break;
-			stripe_index++;
+			io_geom.stripe_index++;
 		}
 	}
 
@@ -6620,18 +6638,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 
 	if (op != BTRFS_MAP_READ)
-		max_errors = btrfs_chunk_max_errors(map);
+		io_geom.max_errors = btrfs_chunk_max_errors(map);
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    op != BTRFS_MAP_READ) {
 		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
-					  &num_stripes, &max_errors);
+					  &io_geom.num_stripes,
+					  &io_geom.max_errors);
 	}
 
 	*bioc_ret = bioc;
-	bioc->num_stripes = num_stripes;
-	bioc->max_errors = max_errors;
-	bioc->mirror_num = mirror_num;
+	bioc->num_stripes = io_geom.num_stripes;
+	bioc->max_errors = io_geom.max_errors;
+	bioc->mirror_num = io_geom.mirror_num;
 
 out:
 	if (dev_replace_is_ongoing) {

-- 
2.43.0


