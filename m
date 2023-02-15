Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E2697E71
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBOOeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBOOeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:06 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30F37F15
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471643; x=1708007643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFVhtYJj3xd2FV2UwuwJM8XGjl+thv//67Y6H5Fz5P8=;
  b=dLs7VAN9d0gLoOr4oMfWNyOB8i8se1X2CisB0XhXdsL3oebGr2VS2JWd
   U2GLkoXQmvDNKCe76EfGU/RxZdeNZuNGMml6T7q60LT3BW4i5koRJEfht
   4um23z5EmKVsl1dSHZ/B5MmOMtUWPTOUWVpj7PG7gZ/G6vjfnCirlEB9a
   KESyJJWyX0c2DyaIicdquDjoIWpzQ2JMdJdBFcuXpSRZfmhesz4xc9YqQ
   7ixd+XMu2yZjBMQF/lyWsNH61cQwDPAOJOhUUNQ825MkkG8jiKwCwfzGe
   gOJZkGCYYEKPGpQfKL08P9P8rLE5FkC4ijfaCLFJefHb0u6ubgnUaA4cv
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394069"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:44 +0800
IronPort-SDR: D3GT1YeoxTwf4MCQG4my7SbNuBahCEljOWmRw9r2a8n5IfieLM7rtKmwkua/nevVehPOgi4sSi
 tIXRJrB54cna7aTnLB3bXYjjokc2WmIW3cDqI1tmhL0vTnRCQMxsZGSDl/uA9xYSEQBzwJxKgI
 jld9d64ya/YEHbx2qQ8SyX4MMKJQHva7Zs4Wafu0x7aE8dQchz1gCulnGPhfArGZ8kW/Azee5D
 xjUO9PvTtRsqoQBUJWGT6RrHsN3xdMmvwS5lEwYm/kmdMX8+JA6UmbZ/lsdFqmUl/4Fa5Wkldy
 N8g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:06 -0800
IronPort-SDR: XH+/BzWaXFuLsLQlevAR0DyZ1zOtbetOcyH1G+UeFLgMa2JgTuxx5teAw7nHlpToPMpyedHw8n
 B8Z9fn4CgRFqEvlKPU5/tV6LKL4l7U4bhC/Y9ms6Sv+ts4TbLMYFxoQkRdEsLSFKeUuq5fpFuJ
 Sz+Rwrj6S3fkLT7c2FBGHyfRRfwcSXJMge5MWVPF2JXybXQb2uWG9AsTEs78FnXpRn4rzGM2wJ
 9hSb3+FX5hKju/kUkdEm1IGGbGD99SZFCAJ5kGtEYa0GUOluLq3alCMH+wMVM0s+PoGEbiA2KW
 ozE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 06/13] btrfs: lookup physical address from stripe extent
Date:   Wed, 15 Feb 2023 06:33:27 -0800
Message-Id: <781dfa6fe45c62122c814f17fee8e1287b5566eb.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
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

Lookup the physical address from the raid stripe tree when a read on an
RAID volume formatted with the raid stripe tree was attempted.

If the requested logical address was not found in the stripe tree, it may
still be in the in-memory ordered stripe tree, so fallback to searching
the ordered stripe tree in this case.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 145 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |   3 +
 fs/btrfs/volumes.c          |  31 ++++++--
 3 files changed, 172 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 8912389d7c2f..f58b28157a9c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -233,3 +233,148 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
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
index 12d2f588b22d..9359df0ca3f1 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -22,6 +22,9 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 struct btrfs_io_stripe *stripe);
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 597aaac12254..10e1173097dc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -6324,12 +6325,21 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 	return U64_MAX;
 }
 
-static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
-		          u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
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
 			stripe_offset + stripe_nr * map->stripe_len;
+	return 0;
 }
 
 int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
@@ -6518,13 +6528,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			smap->dev = dev_replace->tgtdev;
 			smap->physical = physical_to_patch_in_first_stripe;
 			*mirror_num_ret = map->num_stripes + 1;
+			ret = 0;
 		} else {
-			set_io_stripe(smap, map, stripe_index, stripe_offset,
-				      stripe_nr);
 			*mirror_num_ret = mirror_num;
+			ret = set_io_stripe(fs_info, op, logical, length, smap,
+					    map, stripe_index, stripe_offset,
+					    stripe_nr);
 		}
 		*bioc_ret = NULL;
-		ret = 0;
 		goto out;
 	}
 
@@ -6536,8 +6547,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 
 	for (i = 0; i < num_stripes; i++) {
-		set_io_stripe(&bioc->stripes[i], map, stripe_index, stripe_offset,
-			      stripe_nr);
+		ret = set_io_stripe(fs_info, op, logical, length,
+				 &bioc->stripes[i], map, stripe_index,
+				 stripe_offset, stripe_nr);
+		if (ret) {
+			btrfs_put_bioc(bioc);
+			goto out;
+		}
+
 		stripe_index++;
 	}
 
-- 
2.39.0

