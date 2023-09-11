Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17179BBAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355596AbjIKWBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjIKMwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:39 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE1E40;
        Mon, 11 Sep 2023 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436755; x=1725972755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRvvWdjtbEYuAkkq1cMd1cz7TCumuqP5svgnqRV+38s=;
  b=Sh0DWtz5l23SfbrsD6HhkR9TBe7w5scn1fQgDg8TtW1PtqGhBvjRk8sc
   0Z/h05SSUwFqCwWNipDmARXFgbxA9kC/yA43L6rOkdHAxDrEz+tl3djoS
   dWOg0Z/MMHVH18ih/ILxSG9SMz7kLRDqLYYhqCPUDhE7CQctRYs85Am9V
   HuF/cNh6yUjslUGs0KKGw+xXA4GDKOQmokoEUVLjbSec8vjiSCP0BIalT
   SYpANv8PsovTWtukNAIiyLFGsI6fqOEOH80IPn7pRXecKNOLbwxwRgPaz
   hq51YcJD+ghMNN2DMOhEx8OzAFNP5P6D1tcyTTzqGzq+OfbLifS1qYcLV
   A==;
X-CSE-ConnectionGUID: Z3Qz3oS6Q9OdOqaKk+MeMA==
X-CSE-MsgGUID: XgUAcItHSIqEe7z66pEuaQ==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594396"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:35 +0800
IronPort-SDR: GrBQCx/Jp6BJOeyol65iZ+lhJuyECy1PkNptiuTv5yBk5wAtOdfv6sREDl9nmIMrlXzV4zJOmm
 Y0al2fUdko7T96lgMOKAT50Fabc+AUW5GnsZ0lgh9Ge3oWCsQJLPHTtmHMRkchl9vSRlGmgBCY
 xr+cWeWvw97xHczElWuawtJKOt5hfRRydj3SkRuTtwVX/npckgjfa1k2rXsjnvWXifJe0Hq2kR
 KpU9biygObfp+WNJPNY+ZvSP1pKQK8STnS1GX+NAPA/N8W27hcGl5BID0FHPmafSLU8rwZhHyx
 Jv8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:05:19 -0700
IronPort-SDR: NiTBUCr4z4SFaBV5dhYJ7XEQXGJyI+GoN2Z9Dxs+OLwGxNu6mA1H3OulWg3/0Dlpti20JpKLYM
 VhUpS7NIvTy8yI3hbaZWVnoAn6p5iPIcBcrFXdiTDZ6dceZRMBX9cEQ9/G0Fh93III9Ooqe1oX
 vbFI4I4tUr+PB72Scn22H5Hcs2iQtzysNyNjCk9/9YfHGhc7JuGptiGVBjFuyOACjotGf3LK3N
 ubnH0man6OyPH5F+8f/0KY+I4Dv8tZVQz6953vG/88CtK9Y1qDkRzRCV6Mf54zjiV4vl7JrkFV
 oR8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:31 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/11] btrfs: lookup physical address from stripe extent
Date:   Mon, 11 Sep 2023 05:52:06 -0700
Message-ID: <20230911-raid-stripe-tree-v8-5-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=8982; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=aRvvWdjtbEYuAkkq1cMd1cz7TCumuqP5svgnqRV+38s=; b=OmZOx7p6p8oaDM6P9eM436W7XiJ8t7EFfYjke1U2ftBx4v/hl9xBnN/d0Iu4MuZSiJwoAfR3V rhrgeadB5dyDT35rUEj7AN8UchEhngIaXrIbRzdHPYa+F3UL1GFQI6T
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lookup the physical address from the raid stripe tree when a read on an
RAID volume formatted with the raid stripe tree was attempted.

If the requested logical address was not found in the stripe tree, it may
still be in the in-memory ordered stripe tree, so fallback to searching
the ordered stripe tree in this case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  11 +++
 fs/btrfs/volumes.c          |  37 ++++++++---
 3 files changed, 198 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 5b12f40877b5..7ed02e4b79ec 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -324,3 +324,162 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+
+static bool btrfs_check_for_extent(struct btrfs_fs_info *fs_info, u64 logical,
+				   u64 length, struct btrfs_path *path)
+{
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
+	struct btrfs_key key;
+	int ret;
+
+	btrfs_release_path(path);
+
+	key.objectid = logical;
+	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = length;
+
+	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
+
+	return ret;
+}
+
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 u32 stripe_index,
+				 struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	struct btrfs_stripe_extent *stripe_extent;
+	struct btrfs_key stripe_key;
+	struct btrfs_key found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	int num_stripes;
+	u8 encoding;
+	u64 offset;
+	u64 found_logical;
+	u64 found_length;
+	u64 end;
+	u64 found_end;
+	int slot;
+	int ret;
+	int i;
+
+	stripe_key.objectid = logical;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
+	if (ret < 0)
+		goto free_path;
+	if (ret) {
+		if (path->slots[0] != 0)
+			path->slots[0]--;
+	}
+
+	end = logical + *length;
+
+	while (1) {
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		found_logical = found_key.objectid;
+		found_length = found_key.offset;
+		found_end = found_logical + found_length;
+
+		if (found_logical > end) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		if (in_range(logical, found_logical, found_length))
+			break;
+
+		ret = btrfs_next_item(stripe_root, path);
+		if (ret)
+			goto out;
+	}
+
+	offset = logical - found_logical;
+
+	/*
+	 * If we have a logically contiguous, but physically noncontinuous
+	 * range, we need to split the bio. Record the length after which we
+	 * must split the bio.
+	 */
+	if (end > found_end)
+		*length -= end - found_end;
+
+	num_stripes = btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
+	stripe_extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+	encoding = btrfs_stripe_extent_encoding(leaf, stripe_extent);
+
+	if (encoding != btrfs_bg_type_to_raid_encoding(map_type)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	for (i = 0; i < num_stripes; i++) {
+		struct btrfs_raid_stride *stride = &stripe_extent->strides[i];
+		u64 devid = btrfs_raid_stride_devid(leaf, stride);
+		u64 len = btrfs_raid_stride_length(leaf, stride);
+		u64 physical = btrfs_raid_stride_physical(leaf, stride);
+
+		if (offset >= len) {
+			offset -= len;
+
+			if (offset >= BTRFS_STRIPE_LEN)
+				continue;
+		}
+
+		if (devid != stripe->dev->devid)
+			continue;
+
+		if ((map_type & BTRFS_BLOCK_GROUP_DUP) && stripe_index != i)
+			continue;
+
+		stripe->physical = physical + offset;
+
+		ret = 0;
+		goto free_path;
+	}
+
+	/*
+	 * If we're here, we haven't found the requested devid in the stripe.
+	 */
+	ret = -ENOENT;
+out:
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret && ret != -EIO) {
+		/*
+		 * Check if the range we're looking for is actually backed by
+		 * an extent. This can happen, e.g. when scrub is running on a
+		 * block-group and the extent it is trying to scrub get's
+		 * deleted in the meantime. Although scrub is setting the
+		 * block-group to read-only, deletion of extents are still
+		 * allowed. If the extent is gone, simply return ENOENT and be
+		 * good.
+		 */
+		if (btrfs_check_for_extent(fs_info, logical, *length, path)) {
+			ret = -ENOENT;
+			goto free_path;
+		}
+
+		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
+			btrfs_print_tree(leaf, 1);
+		btrfs_err(fs_info,
+			  "cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
+			  logical, logical + *length, stripe->dev->devid,
+			  btrfs_bg_type_to_raid_name(map_type));
+	}
+free_path:
+	btrfs_free_path(path);
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 7560dc501a65..40aa553ae8aa 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -13,6 +13,10 @@ struct btrfs_io_stripe;
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 u32 stripe_index,
+				 struct btrfs_io_stripe *stripe);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_extent *ordered_extent);
 
@@ -33,4 +37,11 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 
 	return false;
 }
+
+static inline int btrfs_num_raid_stripes(u32 item_size)
+{
+	return (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
+		sizeof(struct btrfs_raid_stride);
+}
+
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0c0fd4eb4848..7c25f5c77788 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -6206,12 +6207,22 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 	return U64_MAX;
 }
 
-static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
-			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
+static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
+		      u64 logical, u64 *length, struct btrfs_io_stripe *dst,
+		      struct map_lookup *map, u32 stripe_index,
+		      u64 stripe_offset, u64 stripe_nr)
 {
 	dst->dev = map->stripes[stripe_index].dev;
+
+	if (op == BTRFS_MAP_READ &&
+	    btrfs_need_stripe_tree_update(fs_info, map->type))
+		return btrfs_get_raid_extent_offset(fs_info, logical, length,
+						    map->type, stripe_index,
+						    dst);
+
 	dst->physical = map->stripes[stripe_index].physical +
 			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
+	return 0;
 }
 
 /*
@@ -6428,11 +6439,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 */
 	if (smap && num_alloc_stripes == 1 &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
-		set_io_stripe(smap, map, stripe_index, stripe_offset, stripe_nr);
+		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
+				    stripe_index, stripe_offset, stripe_nr);
 		if (mirror_num_ret)
 			*mirror_num_ret = mirror_num;
 		*bioc_ret = NULL;
-		ret = 0;
 		goto out;
 	}
 
@@ -6463,21 +6474,29 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		bioc->full_stripe_logical = em->start +
 			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
 		for (i = 0; i < num_stripes; i++)
-			set_io_stripe(&bioc->stripes[i], map,
-				      (i + stripe_nr) % num_stripes,
-				      stripe_offset, stripe_nr);
+			ret = set_io_stripe(fs_info, op, logical, length,
+					    &bioc->stripes[i], map,
+					    (i + stripe_nr) % num_stripes,
+					    stripe_offset, stripe_nr);
 	} else {
 		/*
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
 		for (i = 0; i < num_stripes; i++) {
-			set_io_stripe(&bioc->stripes[i], map, stripe_index,
-				      stripe_offset, stripe_nr);
+			ret = set_io_stripe(fs_info, op, logical, length,
+					    &bioc->stripes[i], map, stripe_index,
+					    stripe_offset, stripe_nr);
 			stripe_index++;
 		}
 	}
 
+	if (ret) {
+		*bioc_ret = NULL;
+		btrfs_put_bioc(bioc);
+		goto out;
+	}
+
 	if (op != BTRFS_MAP_READ)
 		max_errors = btrfs_chunk_max_errors(map);
 

-- 
2.41.0

