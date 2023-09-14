Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670AB7A0A65
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbjINQHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241832AbjINQHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761C1FF6;
        Thu, 14 Sep 2023 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707631; x=1726243631;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Yq+4Hu/kdBSP8VJdQwG78yDoI9jI2RynIMJjvJLIy94=;
  b=A/QLWn8PtwmLHxQfzqWyjUfSsjmr7FBeM59QB/RzgurtvMHfsq1avHJ1
   G5lNyRV9HlSQhTOyi2rzoCFaeRHCDK8F4cwJeESOJxC98Xo8HlRzk8giW
   Nzp2eGNmX2aBXw3iH5JEa8QlWw11uA7WGP8r60PVE6cvgLVabirpevpzl
   G5wvBt2zHJyjSpcGYP5cSZB1178HZTaIxlPFbQ2zCVhqkxl7lO3TgIxcB
   sQaZMFOT1c8TKzesbBcF0t1jtyM9brMvRZbQb1uloONKBsBZL/MfJaWhc
   MVxoZSEXc2q8ktwrqIwNuSB59BpOxgrprc1i0DHTPcflaNWgH8fnuwoTE
   w==;
X-CSE-ConnectionGUID: Iut/BNnCRaeqxqH+Gu7spg==
X-CSE-MsgGUID: X2G1SwEQTrq8AMIgJJs+Ow==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490542"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:11 +0800
IronPort-SDR: Ju45+fAcGm3z7wBNcpujAQMTNjKtDbFoIy2SoopXKMwQeYLuNrXVwvAFgjP781R3CWotgHVoCA
 1Y51Y2iTqQrbYsb+0NatG0DoxyASL67d5BaYIys6KTY3bfeR8nR9TJ9aMkJL+INt1ApI+8Wg4Z
 XUpLlvq2TtTbJutgrHXZMXkhiNycFgOUulMiglURmf7+DmEGN10sgVF147QYVGUnD8BsCVqDuu
 ZlFKWifWUv8VK3URfBB3+ZMfNXocKtEVgS/gX0sRAiT51knFJWuwMMqkW3XTPFiRWr8N+2o2m6
 LEE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:12 -0700
IronPort-SDR: 7KFfHeqB3pVLAGnO5MoHZqYGW8JZiY0jQCyzFiARJKPxWy4i7NlUqYnY8vFtDTNtnGms3TQKms
 Aa+BSNhVPBhNe7EpBfvBYTZ9Fstics5R5VzbKJgeu7IQspbpe6sTLT3D95NQJGoPqrbIhqp6Dv
 df352WZlI8mK3kxCvg8uNHWmr/BVRP3Bh4v9ymaIeBkmZv6mln+eJoiOVV3t0wwrLIHIJPyzk4
 x9tGyA6UihyCTLFsS94O00HKxLVOQ1C8d5NOgVRJgGWFQF4b3xf50Ky7tcllRGUPS0FvVp0/sf
 rmY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:00 -0700
Subject: [PATCH v9 05/11] btrfs: lookup physical address from stripe extent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-5-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=7981;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Yq+4Hu/kdBSP8VJdQwG78yDoI9jI2RynIMJjvJLIy94=;
 b=YMHja8RXU4rXaUWJY+fd8fQ3bW8/YarmpaFn2P4+kjg1CzAsGNBxT+tL3YZIqGZPBQf9Z2GAE
 0VBaKGHYDRbDT38AizsnZGnWeW5IQRGMT2OcSfiQaU2P62emlpq4QJq
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lookup the physical address from the raid stripe tree when a read on an
RAID volume formatted with the raid stripe tree was attempted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 130 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  11 ++++
 fs/btrfs/volumes.c          |  37 ++++++++++---
 3 files changed, 169 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 517bc08803f1..697a6e1fd255 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -303,3 +303,133 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 u32 stripe_index,
+				 struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_stripe_extent *stripe_extent;
+	struct btrfs_key stripe_key;
+	struct btrfs_key found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	const u64 end = logical + *length;
+	int num_stripes;
+	u8 encoding;
+	u64 offset;
+	u64 found_logical;
+	u64 found_length;
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
+	if (encoding != btrfs_bg_flags_to_raid_index(map_type)) {
+		ret = -EUCLEAN;
+		btrfs_handle_fs_error(fs_info, ret,
+				      "on-disk stripe encoding %d doesn't match RAID index %d",
+				      encoding,
+				      btrfs_bg_flags_to_raid_index(map_type));
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
index b3a127c997c8..5d9629a815c1 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -13,6 +13,10 @@ struct btrfs_trans_handle;
 
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
index c2bac87912c7..2326dbcf85f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -6309,12 +6310,22 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
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
@@ -6531,11 +6542,11 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
 
@@ -6566,21 +6577,29 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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

