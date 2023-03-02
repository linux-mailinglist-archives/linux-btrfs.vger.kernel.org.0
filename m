Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226256A7E64
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCBJqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCBJqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:13 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DC1A4BB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750356; x=1709286356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ns1PI8o3llu401Dyqrmm9+7dNPsiMPwazAICcXX2m0s=;
  b=LBZNB4ZpZ+M/A/SsaZKWkZt8Y46ODg3H/pE7BOnscGvdygbaG6lyZL8A
   iXVWuXM6IAa3zCSYOs8SqAHP9vr9z8pSpci4VNKgasozVgzppOOO+4X/3
   2WSnjgoB9u9lkVwDP4ZU9av8zIYSkfmUhztXuaEi9LTuLJgKBZCxsxbdE
   +JIN7BR6wEG/MyP2j81qDw6HvZZmOyppudHhiSJogNdllJWdrj7RnDWST
   OsawXZDyhqFMg/hmdCikq0l/WqKruJbd+hz+TTkbadTbQJO4g0k4WTaDR
   0NovL/jErybfPDXBclMXFRCMvPVhshUHUUMLmmqx5FUeqCbGfDZX+wcQA
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939191"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:44 +0800
IronPort-SDR: x5KeIwYjzUeO2NkWp6X5DZCEeZLhQgttnICSUFbPgJ6f22WBzCPCtR5jlqjrqvK6yzQOyZUSeF
 JspXN4jDU1ZEVMFLRM4G5/L2haFUBbuk+n68+nrA0+fhdr7kMvQe/RqXqqM20lP9Aqj4tWg2gA
 KTjTIbu4M3WlBLWBwVRbCuJv+CYQsdUy44E1U8sScPsK78VgHk0ZzV1BP9wn3Yuj6usXQkyapS
 uUfxNsHSX+99ZyvUQ6XIRWeUbKPt1PfNu1cI9Ti080PUipnAxHcN82AnNjDEmyrdWDLU6oUgSA
 Vug=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:48 -0800
IronPort-SDR: WVAkz0yT5P0ParqCV6B4TJ83HpjGv1vePHCLXwLhz3qNn87XroGWW0VOavcilmy3wH2/PWkTYR
 QilbrX9zYvtbOd8P22qEe7BPwDw9ToU9/b3TLrXwPoYpyygGBuV+5Y8OAvxpgREZ7jg1lhFWkS
 Ju0HedUZvpaojENqpUUramKLWjvFtKNcAtxHqYZjEKxUxgSF9bX2Kn3XIhPPvC3W/Rzij4QMPC
 q1WSUnz+jPSqOzjLqy4Q7ii4whvMa+BCQWNo3B0DLhmClkiFPc7/mbDfSO5cdnpyUBy6vxvh4a
 2OQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 05/13] btrfs: delete stripe extent on extent deletion
Date:   Thu,  2 Mar 2023 01:45:27 -0800
Message-Id: <dadedb644d94a657515edc13ff5fd0c9e88f1683.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As each stripe extent is tied to an extent item, delete the stripe extent
once the corresponding extent item is deleted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c      |   8 ++
 fs/btrfs/raid-stripe-tree.c | 176 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |   5 +
 fs/btrfs/volumes.c          |  27 ++++--
 4 files changed, 209 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7441d784fe03..b08e7b4688e0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3238,6 +3238,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
+		if (is_data) {
+			ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+		}
+
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		if (ret) {
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9d3e7bffe6f8..f58b28157a9c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -124,6 +124,37 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 	}
 }
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	struct btrfs_path *path;
+	struct btrfs_key stripe_key;
+	int ret;
+
+	if (!stripe_root)
+		return 0;
+
+	stripe_key.objectid = start;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, stripe_root, &stripe_key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_del_item(trans, stripe_root, path);
+out:
+	btrfs_free_path(path);
+	return ret;
+
+}
+
 int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 len)
 {
@@ -202,3 +233,148 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+
+static bool btrfs_physical_from_ordered_stripe(struct btrfs_fs_info *fs_info,
+					      u64 logical, u64 *length,
+					      int num_stripes,
+					      struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_ordered_stripe *os;
+	u64 offset;
+	u64 found_end;
+	u64 end;
+	int i;
+
+	os = btrfs_lookup_ordered_stripe(fs_info, logical);
+	if (!os)
+		return false;
+
+	end = logical + *length;
+	found_end = os->logical + os->num_bytes;
+	if (end > found_end)
+		*length -= end - found_end;
+
+	for (i = 0; i < num_stripes; i++) {
+		if (os->stripes[i].dev != stripe->dev)
+			continue;
+
+		ASSERT(logical >= os->logical);
+		offset = logical - os->logical;
+		stripe->physical = os->stripes[i].physical + offset;
+		btrfs_put_ordered_stripe(fs_info, os);
+		break;
+	}
+
+	return true;
+}
+
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	int num_stripes = btrfs_bg_type_to_factor(map_type);
+	struct btrfs_stripe_extent *stripe_extent;
+	struct btrfs_key stripe_key;
+	struct btrfs_key found_key;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	u64 offset;
+	u64 found_logical;
+	u64 found_length;
+	u64 end;
+	u64 found_end;
+	int slot;
+	int ret;
+	int i;
+
+	/*
+	 * If we still have the stripe in the ordered stripe tree get it from
+	 * there
+	 */
+	if (btrfs_physical_from_ordered_stripe(fs_info, logical, length,
+					       num_stripes, stripe))
+		return 0;
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
+
+		if (found_logical > end)
+			break;
+
+		if (!in_range(logical, found_logical, found_length))
+			goto next;
+
+		offset = logical - found_logical;
+		found_end = found_logical + found_length;
+
+		/*
+		 * If we have a logically contiguous, but physically
+		 * noncontinuous range, we need to split the bio. Record the
+		 * length after which we must split the bio.
+		 */
+		if (end > found_end)
+			*length -= end - found_end;
+
+		stripe_extent =
+			btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+		for (i = 0; i < num_stripes; i++) {
+			if (btrfs_raid_stride_devid_nr(leaf,
+				       stripe_extent, i) != stripe->dev->devid)
+				continue;
+			stripe->physical = btrfs_raid_stride_physical_nr(leaf,
+						   stripe_extent, i) + offset;
+			ret = 0;
+			goto out;
+		}
+
+		/*
+		 * If we're here, we haven't found the requested devid in the
+		 * stripe.
+		 */
+		ret = -ENOENT;
+		goto out;
+next:
+		ret = btrfs_next_item(stripe_root, path);
+		if (ret)
+			break;
+	}
+
+out:
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret && ret != -EIO) {
+		btrfs_err(fs_info,
+			  "cannot find raid-stripe for logical [%llu, %llu]",
+			  logical, logical + *length);
+		btrfs_print_tree(leaf, 1);
+	}
+
+free_path:
+	btrfs_free_path(path);
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 60d3f8489cc9..9359df0ca3f1 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -22,6 +22,11 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 struct btrfs_io_stripe *stripe);
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_stripe *stripe);
 int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fee611d1b01d..b4b615421643 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -6286,12 +6287,21 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
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
+						    map->type, dst);
+
 	dst->physical = map->stripes[stripe_index].physical +
 			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+	return 0;
 }
 
 int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -6485,13 +6495,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			smap->dev = dev_replace->tgtdev;
 			smap->physical = physical_to_patch_in_first_stripe;
 			*mirror_num_ret = map->num_stripes + 1;
+			ret = 0;
 		} else {
-			set_io_stripe(smap, map, stripe_index, stripe_offset,
-				      stripe_nr);
+			ret = set_io_stripe(fs_info, op, logical, length, smap,
+					    map, stripe_index, stripe_offset,
+					    stripe_nr);
 			*mirror_num_ret = mirror_num;
 		}
 		*bioc_ret = NULL;
-		ret = 0;
 		goto out;
 	}
 
@@ -6522,7 +6533,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		bioc->full_stripe_logical = em->start +
 			((stripe_nr * data_stripes) << BTRFS_STRIPE_LEN_SHIFT);
 		for (i = 0; i < num_stripes; i++)
-			set_io_stripe(&bioc->stripes[i], map,
+			set_io_stripe(fs_info, op, logical, length,
+				      &bioc->stripes[i], map,
 				      (i + stripe_nr) % num_stripes,
 				      stripe_offset, stripe_nr);
 	} else {
@@ -6531,7 +6543,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * stripe into the bioc.
 		 */
 		for (i = 0; i < num_stripes; i++) {
-			set_io_stripe(&bioc->stripes[i], map, stripe_index,
+			set_io_stripe(fs_info, op, logical, length,
+				      &bioc->stripes[i], map, stripe_index,
 				      stripe_offset, stripe_nr);
 			stripe_index++;
 		}
-- 
2.39.1

