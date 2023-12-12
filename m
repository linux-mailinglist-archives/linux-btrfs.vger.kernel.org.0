Return-Path: <linux-btrfs+bounces-855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4BE80EC0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1761C20B21
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101E5FF1D;
	Tue, 12 Dec 2023 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xpt0TSnD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12BA10E;
	Tue, 12 Dec 2023 04:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384697; x=1733920697;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=URbmpvR20VX4btmngKh2nyV03iXD9B+5IvYzGplfqg8=;
  b=Xpt0TSnDghT+4+rwTyViw649yMN48LPpPk0lROp9GsKpBshM9zFDtoz2
   el8U5Maf36XttMANzMtXiYX3mFdI7QM497+OHFSiKDNLESybEg0azYjR1
   HX1Oo8fhytWIV+7LhgJvbmC9ubNx+N/wDsxynY3Ean+isTTMoUeDb0Th0
   vg+9JNjrzdGOJtPEdzDpAQShChjjZpf1PKWj3QP8vsHH5FTwOYINrUQwM
   kQl7V3uhFyQlhP+Pt38P6YZIgol5MpF8NkgOH7zniy3P0r/Xar+BNYBB6
   Lnr3CdpxJSKLApHG8M/MOWsUR9jeXLoxjE4N2sooP3RCQc0Ge0GGD5zHi
   g==;
X-CSE-ConnectionGUID: 6YVYmZvuSg2Z9Z95GqKcrA==
X-CSE-MsgGUID: xldAz7kiTb+E+/Pug4hOJg==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629787"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:15 +0800
IronPort-SDR: J06JVZNiQmtfl+MtlNWlqNrKxbD/juee6PHRaL40BhCOwBg0TFlRnN00HXXHPl6yCBptXdwurz
 1eGT70MRE8rA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:29 -0800
IronPort-SDR: MMwxy3aCgpBp7rU2yLVsHP/fYEvJiI+UHpkK+XTAZqqUmdyk8NY/cE8GN+sCaPOBdMA0mA4SQF
 5vzo3uKBMjeg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:14 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 12 Dec 2023 04:38:00 -0800
Subject: [PATCH 02/13] btrfs: re-introduce struct btrfs_io_geometry
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-2-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=11384;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=URbmpvR20VX4btmngKh2nyV03iXD9B+5IvYzGplfqg8=;
 b=bnwWZ1qmwgXoV9Z49QY0Hh1JKoUMiZJaZU94Ab0xKtNiy+wUa8Wz+BjDxLaRWzoaG7zc7bZul
 D67dSzPx+7SDUqe6P6KKUrGsWwHJZLdFhQwu4zHpi7HgUllqZYtPOJc
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Re-introduce struct btrfs_io_geometry, holding the necessary bits and
pieces needed in btrfs_map_block() to decide the I/O geometry of a specific
block mapping.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 156 +++++++++++++++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1011178a244c..d0e529b3fd39 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -41,6 +41,16 @@
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
+};
+
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.sub_stripes	= 2,
@@ -6393,28 +6403,22 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
 
 	num_copies = btrfs_num_copies(fs_info, logical, fs_info->sectorsize);
-	if (mirror_num > num_copies)
+	if (io_geom.mirror_num > num_copies)
 		return -EINVAL;
 
 	map = btrfs_get_chunk_map(fs_info, logical, *length);
@@ -6424,8 +6428,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	data_stripes = nr_data_stripes(map);
 
 	map_offset = logical - map->start;
-	max_len = btrfs_max_io_len(map, op, map_offset, &stripe_nr,
-				   &stripe_offset, &raid56_full_stripe_start);
+	io_geom.raid56_full_stripe_start = (u64)-1;
+	max_len = btrfs_max_io_len(map, op, map_offset, &io_geom.stripe_nr,
+				   &io_geom.stripe_offset,
+				   &io_geom.raid56_full_stripe_start);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);
@@ -6437,53 +6443,54 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (!dev_replace_is_ongoing)
 		up_read(&dev_replace->rwsem);
 
-	num_stripes = 1;
-	stripe_index = 0;
+	io_geom.num_stripes = 1;
+	io_geom.stripe_index = 0;
+	io_geom.mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
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
@@ -6495,29 +6502,33 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6525,19 +6536,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6555,11 +6566,12 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6579,7 +6591,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * It's still mostly the same as other profiles, just with extra rotation.
 	 */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK &&
-	    (op != BTRFS_MAP_READ || mirror_num > 1)) {
+	    (op != BTRFS_MAP_READ || io_geom.mirror_num > 1)) {
 		/*
 		 * For RAID56 @stripe_nr is already the number of full stripes
 		 * before us, which is also the rotation value (needs to modulo
@@ -6589,12 +6601,13 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6603,13 +6616,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
 
@@ -6620,18 +6635,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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


