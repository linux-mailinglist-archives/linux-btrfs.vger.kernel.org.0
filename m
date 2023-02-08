Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE8468ED6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBHK6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBHK6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:02 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B512F35
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853880; x=1707389880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqrTELnrQRQRmRB1mPTAANP82bk/S5mEaquDVf0iSMA=;
  b=HIAu0JzSTF3N7yX/3yuj8YhJ6XWwLIHtrh0pYNMIBSnkq8F5tqbhvYBT
   UMCJgN1de8pzhfkNCamlzNaP47JcE8hknFtiiZQUVznVmJLOkZWoeHMOe
   ruCNAvvhUDFROzJI9+4vclsIpmscnxQAzabwnxDS1fStPpt1inTd4tvEY
   18cb11aq34md3DlrkuYRutYc1LrsoUFp/hez+8cOpjH/Kmfhvp737Y0Od
   HIkbixgFV5UFb8V5+aEJRTmvEuzFLgESz7eICp7gbVxrvLxQ2kH+vzfr/
   XLK0GEEXEpPuFTgNOgCPt1y7C+zSx0tHheiZ1FUsEAemt5JQFtK4eg2eh
   w==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115634"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:57:59 +0800
IronPort-SDR: Qn4CZRKsOM4mRy+61kZuPdKRA7MkZnfUsoyux4jc9dFf9qG3J7oOe0xN1DRVueFFzRzN59IquT
 g941tPDHZxO4MoO7X8ZL71k3yDcsMMLnGuUXgqAPY4JHy2xBji6KZZiA18FBItyO5mhkXtBlmw
 bCVjMwaGCcNQEVmamourFzquCg2lqhwLP4D2utxdmMT5YgJ46ZbS5aRFmIMkGAEi9mEWlt4n09
 bvjHTcTeIpX/5gYMm7ZhmBQcCEhAo0K89Q3wmWVPDRWvvlA5o5cWxBDdL0A9M9qyYGLh8VGbJy
 CjA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:15 -0800
IronPort-SDR: DIRrQCAt5/nZtbE0caho7gQ2MhzDFheiPykIILpEk/x9IcY8aDas623j+/ku4/6KT4zLSBRG6G
 SyfXsbucHXqjvaQcH+0S2rDVVBdtXR7ykjcEG8SW7Q4WscmrCoThp0E//MUT8mzCkDrzpbgrUo
 d4PEYua4b93210SZHCPbGjkYK4bh97WndQGrlomDwMtU69rS1GCVgVQJatkGK8Cwukn6fXn1QP
 L1kH/HCGdgZjPMzJ+nuqcAjZPqy86h/CGEfbtwelrQYTuYfEnzZ9sjKbL/jHyT5y1AHq/oKmZx
 lTA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:00 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 06/13] btrfs: lookup physical address from stripe extent
Date:   Wed,  8 Feb 2023 02:57:43 -0800
Message-Id: <f1ee4f592ce63640fec2caf9d1b5ce64da11a733.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 145 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |   3 +
 fs/btrfs/volumes.c          |  31 ++++++--
 3 files changed, 172 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index ff5787a19454..ba7015a8012c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -231,3 +231,148 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
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
+		offset = logical - os->logical;
+		ASSERT(offset >= 0);
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
index e7c0353e5655..7a784bb511ed 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -6311,12 +6312,21 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
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
@@ -6505,13 +6515,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
 
@@ -6523,8 +6534,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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

