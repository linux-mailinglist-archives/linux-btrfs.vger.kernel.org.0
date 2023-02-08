Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AA268ED67
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBHK6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBHK6D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:03 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8753513538
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853882; x=1707389882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4jlg4v/7Iq8bHhberMtgSbo8vYGpRLrYipOjTT9yAU=;
  b=jHSSbHk67dMsmUm4Ni1ZT8i/ZypWtbbaQi/n4XtLQWImzGdVpcYP92VH
   KBP4zKnr+kx9DMfDo6seUvhgNf6GtDUOjIpv3XyVkE/oyU4W7pznksljl
   w+XVz7il7RGJJG0QeXKACJQqJjfdcHrNC+ipl+E61K91guG7JX76K85Og
   jAOiPjWOjDi8lVKtkMElLxmBp7MB/dFT66snmVBUXOdS+DFhGl1XvtEhL
   2DhphqP5RvCFDGrJPljybrukRd1ZRVwq/17szFBmBjgPxD17LP2Vx+ycx
   NS4NEIpnHVaI9UQr5nZbSj5v9dvPNezvbILQyjxymf+/9SiS5iej0aaqD
   w==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115638"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:01 +0800
IronPort-SDR: nYOh7JaBQ2MaiynWaGhRP4l4hy6xAh1Ecc3x+JUiKsCd/2GuaTL4sYbrkFfHVdGGqNQVocPl+u
 g/JO/tL6NOoYFsAWAdF+vVx9Iyy9fWLbkiSWPsGk2JPr6Et48CMvIr1c32pGX5Tv19hvAu4oq1
 TtIRZy9FmwrUZOMwdC0MtzATUJw60l3au6VH8R5/hzjqaom76I4q6KfI0AlyTTIXcM5YyG+T8K
 gchz0742VBn4SEAWzwLgnMWDd3gAKAe4kCkaoE/kYbqjAax1TJalaBDhRIa5PN3/swT/E+Fl9I
 /wk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:16 -0800
IronPort-SDR: NWm5MLkJ0KZf6ZQ3WHghNrOfc7rxBw+/QtkbDfbdb1+PMRMN1jpe7PYxB6Be8RmrQNNgsy287m
 6JpwbGwPsUQNlxxv94DFnGe2nC3PRi1YKh4HwV+abR2ocrxA/YauKM9LQXE3nDnoYxYkPuDXE8
 KDJxd+3uLfFYDAfXV6H2TLa3UNa5DRqCAwsuCZqPgSs60wo5ZrsK6XzVonhkUUoGj3hJJdwICF
 VAitOQ34S7Rb4btm2rWI70kI2yzjTIYfoJMtU641VMEHSIbYYj38B1K9TOAtkH9HTg07MdiTp2
 Aps=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:01 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 08/13] btrfs: zoned: allow zoned RAID
Date:   Wed,  8 Feb 2023 02:57:45 -0800
Message-Id: <946bf77cc07eba1b536466c6da1ce8c575865e7e.1675853489.git.johannes.thumshirn@wdc.com>
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

When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
data block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c |  4 ++++
 fs/btrfs/raid-stripe-tree.h | 10 +++++++++
 fs/btrfs/volumes.c          |  5 ++++-
 fs/btrfs/zoned.c            | 45 +++++++++++++++++++++++++++++++++++--
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index ba7015a8012c..1eaa97378d1c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -268,10 +268,12 @@ static bool btrfs_physical_from_ordered_stripe(struct btrfs_fs_info *fs_info,
 
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
@@ -343,6 +345,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
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
index 7a784bb511ed..ef626f932af5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6322,7 +6322,8 @@ static int set_io_stripe(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (op == BTRFS_MAP_READ &&
 	    btrfs_need_stripe_tree_update(fs_info, map->type))
 		return btrfs_get_raid_extent_offset(fs_info, logical, length,
-						    map->type, dst);
+						    map->type, stripe_index,
+						    dst);
 
 	dst->physical = map->stripes[stripe_index].physical +
 			stripe_offset + stripe_nr * map->stripe_len;
@@ -6508,6 +6509,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
+	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
+	      op != BTRFS_MAP_READ) &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1) &&
 	    (!need_full_stripe(op) || !dev_replace_is_ongoing ||
 	     !dev_replace->tgtdev)) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ed49150e6e6f..9796f76cffd6 100644
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
@@ -1515,8 +1516,48 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->zone_capacity = min(caps[0], caps[1]);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 	case BTRFS_BLOCK_GROUP_RAID0:
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
+
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+
+			if (i == 0)
+				continue;
+
+			if (alloc_offsets[0] != alloc_offsets[i]) {
+				btrfs_err(fs_info,
+					  "zoned: write pointer offset mismatch of zones in RAID profile");
+				ret = -EIO;
+				goto out;
+			}
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
+			cache->zone_capacity = min(caps[0], caps[i]);
+		}
+		cache->alloc_offset = alloc_offsets[0];
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
 		/* non-single profiles are not supported yet */
-- 
2.39.0

