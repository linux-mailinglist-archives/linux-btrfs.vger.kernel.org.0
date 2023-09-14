Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47737A0A67
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbjINQHg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbjINQHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C71FC0;
        Thu, 14 Sep 2023 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707633; x=1726243633;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=d42cqIbxUEKquSGYYk3w7AaeNWr6XkbxX7jX+1lrcSo=;
  b=jmbVSmtJtHnOCE8OJ/jJIZIpeQA1y7J+rmnkzVDJDkR2ul4vkMx8p1bj
   +gVqr4fFXnA3WmfhHYdrEkHPXTX2XP8STblejG1TcS0QWOtt17nYkU0s8
   jaIJEPLom/MzPj86iZySvkzl47/E55U6io2UHKbmdANnbMq+YgFkPcjYx
   skVqXVfN+p1vv4LlF2ohegDCRS3k93PohFV520pzsw+e8E/lQd46RJQJk
   Xt21rdB5LhTdViJflWoU/scU2cOQW8MP5B9AL16f03u5UyMnJqly2y9Xg
   VsBEz02gJEgQP4sm5QDR5L5QBEOyAWZteMcM98nq+vOaj+E/4FFOdXPOv
   A==;
X-CSE-ConnectionGUID: 0uOTb0vlSEKK3KzsROHjqQ==
X-CSE-MsgGUID: A/zWuJGlQEKHl+e3YSgVqA==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490548"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:13 +0800
IronPort-SDR: tE8UV3isZTCeH8JBePxSF48I6xApbZ1v5lROxiXoV2WOJP/aiaWfa5CqJfPIyziyZ3el4PE1Ay
 7ugOjKT2wfWKIuO9liiCJgKyAMheujaGRsGDVCLqWUNigyNB9Lsxm3wzXPFWuuCMvJHxfHW5Am
 tX4FY+CCW5DDNbEgT1yFiUpJEZLIpJ6srA6AQAuVG6YVwdfqBAJNpwUHZ2KPsukKS34wwCJbLY
 pEw+Y8pqDq3MQKDYZi6Ij/S0F+Fcs/m4oUX0srj1zKm8E/nkvq1tnG4MTFkFe1lSdKhT8hk4Y6
 vyA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:14 -0700
IronPort-SDR: +CvEQs5BsLVIGqrJTcYE4ynxuB6mAsOW32+/ktK2G+qnaqNoOsaHOCA1meZtH54DhD6PD7ua2y
 LxE80qHHk9E5wJ9udvAndm7GJibMTl3flaUMJhhG5GzI0udbWToFcw7wLpXuuVmmf6B7Ims6Cc
 qqr+t3O0YLJGBAfXchgnhc7O1VYxvKSFqBeL+axmn5NdQwNuGajdUtVgn3CF4TbYM9viKO0adv
 fvcoUk4RnNMdH5T8Qt7HR/jkbtyTa/e8IEbyda12y71VCsXkcN9WYxfPF1cDW9jUWON9FrAS2K
 8oQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:02 -0700
Subject: [PATCH v9 07/11] btrfs: zoned: allow zoned RAID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-7-15d423829637@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=7309;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=d42cqIbxUEKquSGYYk3w7AaeNWr6XkbxX7jX+1lrcSo=;
 b=4/dBOqQnXE+SB9BAc5TTUm8Hj74OPgfEK2eZ0jSSAYeQEGSnsoYpo5DiQkBY1JNdG6XLmyNsX
 xALtVkIJA/PCryIF+haERYDDbxiG6ErT2y5g3+Zd4xoSRQBYR+fVcKd
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
data block-groups. For meta-data block-groups, we don't actually need
anything special, as all meta-data I/O is protected by the
btrfs_zoned_meta_io_lock() already.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.h |   7 ++-
 fs/btrfs/volumes.c          |   2 +
 fs/btrfs/zoned.c            | 144 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 5d9629a815c1..f31292ab9030 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -6,6 +6,11 @@
 #ifndef BTRFS_RAID_STRIPE_TREE_H
 #define BTRFS_RAID_STRIPE_TREE_H
 
+#define BTRFS_RST_SUPP_BLOCK_GROUP_MASK		(BTRFS_BLOCK_GROUP_DUP |\
+						 BTRFS_BLOCK_GROUP_RAID1_MASK |\
+						 BTRFS_BLOCK_GROUP_RAID0 |\
+						 BTRFS_BLOCK_GROUP_RAID10)
+
 struct btrfs_io_context;
 struct btrfs_io_stripe;
 struct btrfs_ordered_extent;
@@ -32,7 +37,7 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 	if (type != BTRFS_BLOCK_GROUP_DATA)
 		return false;
 
-	if (profile & BTRFS_BLOCK_GROUP_RAID1_MASK)
+	if (profile & BTRFS_RST_SUPP_BLOCK_GROUP_MASK)
 		return true;
 
 	return false;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2326dbcf85f6..dc311e38eb11 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6541,6 +6541,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * I/O context structure.
 	 */
 	if (smap && num_alloc_stripes == 1 &&
+	    !(btrfs_need_stripe_tree_update(fs_info, map->type) &&
+	      op != BTRFS_MAP_READ) &&
 	    !((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1)) {
 		ret = set_io_stripe(fs_info, op, logical, length, smap, map,
 				    stripe_index, stripe_offset, stripe_nr);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d05510cb2cb2..ce2846c944d2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1397,9 +1397,11 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 				      struct zone_info *zone_info,
 				      unsigned long *active)
 {
-	if (map->type & BTRFS_BLOCK_GROUP_DATA) {
-		btrfs_err(bg->fs_info,
-			  "zoned: profile DUP not yet supported on data bg");
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data DUP profile needs stripe_root");
 		return -EINVAL;
 	}
 
@@ -1433,6 +1435,133 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
 	return 0;
 }
 
+static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
+					struct map_lookup *map,
+					struct zone_info *zone_info,
+					unsigned long *active)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	int i;
+
+	if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs stripe_root",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+
+	}
+
+	for (i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if ((zone_info[0].alloc_offset != zone_info[i].alloc_offset) &&
+		    !btrfs_test_opt(fs_info, DEGRADED)) {
+			btrfs_err(fs_info,
+				  "zoned: write pointer offset mismatch of zones in %s profile",
+				  btrfs_bg_type_to_raid_name(map->type));
+			return -EIO;
+		}
+		if (test_bit(0, active) != test_bit(i, active)) {
+			if (!btrfs_test_opt(fs_info, DEGRADED) &&
+			    !btrfs_zone_activate(bg)) {
+				return -EIO;
+			}
+		} else {
+			if (test_bit(0, active))
+				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+					&bg->runtime_flags);
+		}
+		/*
+		 * In case a device is missing we have a cap of 0, so don't
+		 * use it.
+		 */
+		bg->zone_capacity = min_not_zero(zone_info[0].capacity,
+						 zone_info[1].capacity);
+	}
+
+	if (zone_info[0].alloc_offset != WP_MISSING_DEV)
+		bg->alloc_offset = zone_info[0].alloc_offset;
+	else
+		bg->alloc_offset = zone_info[i - 1].alloc_offset;
+
+	return 0;
+}
+
+static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
+					struct map_lookup *map,
+					struct zone_info *zone_info,
+					unsigned long *active)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs stripe_root",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+
+	}
+
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if (test_bit(0, active) != test_bit(i, active)) {
+			if (!btrfs_zone_activate(bg))
+				return -EIO;
+		} else {
+			if (test_bit(0, active))
+				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+					&bg->runtime_flags);
+		}
+		bg->zone_capacity += zone_info[i].capacity;
+		bg->alloc_offset += zone_info[i].alloc_offset;
+	}
+
+	return 0;
+}
+
+static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
+					struct map_lookup *map,
+					struct zone_info *zone_info,
+					unsigned long *active)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+
+	if (map->type & BTRFS_BLOCK_GROUP_DATA &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs stripe_root",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+
+	}
+
+	for (int i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+
+		if (test_bit(0, active) != test_bit(i, active)) {
+			if (!btrfs_zone_activate(bg))
+				return -EIO;
+		} else {
+			if (test_bit(0, active))
+				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+					&bg->runtime_flags);
+		}
+
+		if ((i % map->sub_stripes) == 0) {
+			bg->zone_capacity += zone_info[i].capacity;
+			bg->alloc_offset += zone_info[i].alloc_offset;
+		}
+	}
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -1525,11 +1654,18 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = btrfs_load_block_group_dup(cache, map, zone_info, active);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
+		ret = btrfs_load_block_group_raid1(cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID0:
+		ret = btrfs_load_block_group_raid0(cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID10:
+		ret = btrfs_load_block_group_raid10(cache, map, zone_info, active);
+		break;
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
-		/* non-single profiles are not supported yet */
 	default:
 		btrfs_err(fs_info, "zoned: profile %s not yet supported",
 			  btrfs_bg_type_to_raid_name(map->type));

-- 
2.41.0

