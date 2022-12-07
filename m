Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71208645C60
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLGOXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLGOWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DBDC6
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422952; x=1701958952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0ZTd/RpKjVoy//MBiizPiq+G7nv/G0p+3WhawVgfmY=;
  b=DJWphbMIh4kzQpjt7cAR9xMD4hgP+WYU/8YAhM74XXaLBHdAQFOLMzmM
   9L0s4BoFlWk87PGF6TCJ5ijocg71qJxJ/CXw0tzGuL0U68xE2YC76LfYL
   RtwKsgTsJe34bllEklU+kr+j5Ku7ZlzuIE7dLw9hRuHGPntygOa1Whz2T
   P009oW3fbnFb+dXiKrjKHD5vYkYOlJxqslxhpF05+wI8eMrWR8dFwMk+H
   fBIKR/BuJ1FSG8jW69k1k+owuixt2sFdVu6XV1xvYGP9lOTAVwA6Crc+6
   PD+o17+RpHS5mxHGSKtEto8Hac0lTLVFrUCdIcrFhaNTexgcyYcgw5qij
   g==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099485"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:31 +0800
IronPort-SDR: oRLm1A1laTS1tu+jgAfMN+HDNfB+RlwMFwJFmqx5kSaIHjrCA6IvjpONnQ6y4c7ZeJFsbswbw4
 BtRvL+GYGdXy1QrdSi+w66bQ1W4920EY1LnaXpHVbmaJagZ3qJRmFp2gAZhnbqzMNRWO3Fayru
 24t8Q1/EeqlgDZs1iYEqXkqC3M3cDpI75ndosmmQehz7/2nlpLkxTROiX+jkGO/TYvWn6QFNMY
 En3hz/e8hclYSZlj4Dazc9VzMMw0DWgTzoiwAnT/KTJcrYQhxcPeEpEQZ9zXplo0BWxrAY2s26
 s2g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:18 -0800
IronPort-SDR: HYh6ZkGb7Ye/y5PPes8DyHZVrJUrLMAU+zcMfI/Xc9CGdulrHUwkvXCpen28mLFdo+bdIXazqa
 ty3CHf2XF8U17PGPPoucDN5hwenjmTN4SwjbXDI0j7W+OaRhhgQDudpVbkerDT6B5UAeGgKU1E
 W39qH44nhBR3ns0zK+QMA5vx80NB6B3Gi7wvRyOjhNZEf3/AOwz9M8msdNJrpthZvhzmxxsgYb
 f+XedXySWiahxHhhTJr8aYainXqCKA+2REMmbNkOu7FJatSPeRfRSQR0VN/nIhBuL5mxFMZ+1b
 BBM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 5/9] btrfs: lookup physical address from stripe extent
Date:   Wed,  7 Dec 2022 06:22:14 -0800
Message-Id: <5d6898573c5a2fde78564a195489971b48fdf21a.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670422590.git.johannes.thumshirn@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/raid-stripe-tree.c | 143 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |   3 +
 fs/btrfs/volumes.c          |  31 ++++++--
 3 files changed, 170 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 4f516f71c4cf..c57dfe9f5c86 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -224,3 +224,146 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
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
+		goto out;
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
+	btrfs_free_path(path);
+
+	return ret;
+}
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 2b1e3fd9029e..d227299e8865 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -21,6 +21,9 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
+				 u64 logical, u64 *length, u64 map_type,
+				 struct btrfs_io_stripe *stripe);
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 78b721251a09..be4f5075214c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
@@ -6298,12 +6299,21 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
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
@@ -6492,13 +6502,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
 
@@ -6510,8 +6521,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
2.38.1

