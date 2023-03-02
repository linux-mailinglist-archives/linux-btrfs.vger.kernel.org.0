Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660F6A7E6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCBJqh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCBJqV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:21 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F743E62A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750374; x=1709286374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyibukDYjfz1DN8fDxXm7wqjfLtI9+eGKnDdK3jfjgc=;
  b=i+xNpcGGAMamZjMfR071tadvH5j6AjcKivmpYgOLP3/Ixz6GReCTE/Qa
   zXUjPRjRpxWNxa1BjQzMp0uJb9fUA3BqoQcgGzTPqj8nvF6GKkbyhqqMb
   GkXRIs3mLBq60Qrmc44logII7RHStG85JrzuX6fbOrhVwi+Q1bm7lKvCi
   aFapd4tIkohJd8Wg5nm+abyNo2L9FnANgI+VHRnq5OgQ9+W779MVOzqgB
   WawfTySpsoMpevEIMbo7uWE2j/+kbDiY46yQraw09QuemyLSXO09dPfI7
   59l9H1GS2RFsKlxgo2+ZJoSUH3WX/BfOvDzeYOFrke41WfwM9ZOqhiejr
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939195"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:46 +0800
IronPort-SDR: 5CgrjAf9YVylLDfghheW+QX+4XkOT5A8taAhoIe0FxoCUKEaI76BFCHBzpDZC2tiY/zkNJXpZY
 qJUpPLY6JYkeThg68H3dIe9B1saZm7Ssf8J0uNnTeBiKgbDBxrCLBYb6qM4TFgOxwJ6FNSP6sH
 yI+jvM2EvQE8GoD8pQzWECBQ+v9B9ggkc2SeqG5UbXV68HYhRXIcq9ImBjTGbSxI26LSctG1U4
 N497Kdi+s8EeodJPp/FJvrzm5C1FLXcBJKVl/H8aO/hE0/mutFwCpUpm541D1YWT0rKrNdO/XW
 G10=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:51 -0800
IronPort-SDR: bE8d4Lc4HsDRCEVO0A70vhpOcm8EH7BrmIZkZVHAvQrr7CKXt38aLEn9bbULm4cMXaiQhUtYoH
 xBSmuk+HkqMbztX0G1t4qfCpk1ABElPmTM4IKaSOCLAnZbcNBGNEC/TCvgq4WCCBerVZx74RzU
 i4Aek3Zi7wT2Fx5ikxeBD88+XS6TB7LYuYJByGOS5g+R3muHZRFJQsHTGWv1cF0z45QtpMLLHp
 S8VPzFKVRD+HanznZIHWywwZYr4DnH1qW6ALYM8VARDUOE0S10zqy67HY7JxGrlHaHs/ggfB6n
 J+4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:47 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 08/13] btrfs: zoned: allow zoned RAID
Date:   Thu,  2 Mar 2023 01:45:30 -0800
Message-Id: <ebeec16e6356d82ffe3ac0d97f8560392461d93e.1677750131.git.johannes.thumshirn@wdc.com>
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

When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
data block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c |   4 ++
 fs/btrfs/raid-stripe-tree.h |  10 ++++
 fs/btrfs/volumes.c          |   5 +-
 fs/btrfs/zoned.c            | 116 +++++++++++++++++++++++++++++++++++-
 4 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index f58b28157a9c..836299fe0ebe 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -270,10 +270,12 @@ static bool btrfs_physical_from_ordered_stripe(struct btrfs_fs_info *fs_info,
 
 int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 				 u64 logical, u64 *length, u64 map_type,
+				 u32 stripe_index,
 				 struct btrfs_io_stripe *stripe)
 {
 	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
 	int num_stripes = btrfs_bg_type_to_factor(map_type);
+	const bool is_dup = map_type & BTRFS_BLOCK_GROUP_DUP;
 	struct btrfs_stripe_extent *stripe_extent;
 	struct btrfs_key stripe_key;
 	struct btrfs_key found_key;
@@ -345,6 +347,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 			if (btrfs_raid_stride_devid_nr(leaf,
 				       stripe_extent, i) != stripe->dev->devid)
 				continue;
+			if (is_dup && (stripe_index - 1) != i)
+				continue;
 			stripe->physical = btrfs_raid_stride_physical_nr(leaf,
 						   stripe_extent, i) + offset;
 			ret = 0;
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 9359df0ca3f1..c7f6c5377aaa 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -24,6 +24,7 @@ struct btrfs_ordered_stripe {
 
 int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 				 u64 logical, u64 *length, u64 map_type,
+				 u32 stripe_index,
 				 struct btrfs_io_stripe *stripe);
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
 			     u64 length);
@@ -50,9 +51,18 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 	if (type != BTRFS_BLOCK_GROUP_DATA)
 		return false;
 
+	if (profile & BTRFS_BLOCK_GROUP_DUP)
+		return true;
+
 	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
 		return true;
 
+	if (profile & BTRFS_BLOCK_GROUP_RAID0)
+		return true;
+
+	if (profile & BTRFS_BLOCK_GROUP_RAID10)
+		return true;
+
 	return false;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 80baabdef153..ae92567e1275 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6297,7 +6297,8 @@ static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (op == BTRFS_MAP_READ &&
 	    btrfs_need_stripe_tree_update(fs_info, map->type))
 		return btrfs_get_raid_extent_offset(fs_info, logical, length,
-						    map->type, dst);
+						    map->type, stripe_index,
+						    dst);
 
 	dst->physical = map->stripes[stripe_index].physical +
 			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
@@ -6488,6 +6489,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
+	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
+	      op != BTRFS_MAP_READ) &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
 	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7e6cfc7a2918..5328a600f526 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1476,8 +1476,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
-		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
-			btrfs_err(fs_info, "zoned: profile DUP not yet supported on data bg");
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info, "zoned: data DUP profile needs stripe_root");
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1515,8 +1516,116 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_capacity = min(caps[0], caps[1]);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data %s needs stripe_root",
+				  btrfs_bg_type_to_raid_name(map->type));
+			ret = -EIO;
+			goto out;
+
+		}
+
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if ((alloc_offsets[0] != alloc_offsets[i]) &&
+			    !btrfs_test_opt(fs_info, DEGRADED)) {
+				btrfs_err(fs_info,
+					  "zoned: write pointer offset mismatch of zones in %s profile",
+					  btrfs_bg_type_to_raid_name(map->type));
+				ret = -EIO;
+				goto out;
+			}
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_test_opt(fs_info, DEGRADED) &&
+				    !btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			/*
+			 * In case a device is missing we have a cap of 0, so don't
+			 * use it.
+			 */
+			cache->zone_capacity = min_not_zero(caps[0], caps[i]);
+		}
+
+		if (alloc_offsets[0] != WP_MISSING_DEV)
+			cache->alloc_offset = alloc_offsets[0];
+		else
+			cache->alloc_offset = alloc_offsets[i - 1];
+		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data %s needs stripe_root",
+				  btrfs_bg_type_to_raid_name(map->type));
+			ret = -EIO;
+			goto out;
+
+		}
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			cache->zone_capacity += caps[i];
+			cache->alloc_offset += alloc_offsets[i];
+
+		}
+		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
+		if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+		    !btrfs_stripe_tree_root(fs_info)) {
+			btrfs_err(fs_info,
+				  "zoned: data %s needs stripe_root",
+				  btrfs_bg_type_to_raid_name(map->type));
+			ret = -EIO;
+			goto out;
+
+		}
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if (test_bit(0, active) != test_bit(i, active)) {
+				if (!btrfs_zone_activate(cache)) {
+					ret = -EIO;
+					goto out;
+				}
+			} else {
+				if (test_bit(0, active))
+					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+						&cache->runtime_flags);
+			}
+			if ((i % map->sub_stripes) == 0) {
+				cache->zone_capacity += caps[i];
+				cache->alloc_offset += alloc_offsets[i];
+			}
+
+		}
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 		/* non-single profiles are not supported yet */
@@ -1893,6 +2002,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
 
+		if (!device->zone_info)
+			continue;
+
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
-- 
2.39.1

