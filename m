Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1A3F191C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhHSM1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46871 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376028; x=1660912028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6BxxfhE6yJfXIxYSIJEVj9WicS6L5jJXwSNgqrmtjI=;
  b=RILnBUQJNC+LtfQxIlqvVzdGdTk3JdfLACcsidi8KdFx5WwpC4NlooR6
   l1GkX1eKsjX3ALCb7U2SEKMpQ8AXpJp61Zqk2ZwIjJj8x4zA8k+lp0Zvz
   CdCNLrGKHYd7tdOaXbdcshjtatjK4W5qT5NLeyFLvBxQGX5NN347JJHaA
   hBEVeXn0C0u4KVkiur9F/YXxLO5zG1VV7TsjpsoMJi5gD7igdJPcy0vo8
   MFikml9r2D4Rl5tEyH08NvjbQ24BCPFemLBb2s3vkRH3+em2uoGWL+pHI
   5X3EVXHQsgj/wXXGi1G7WnNw7ex6twV8TmtMYhDcpdNLz1JDlNfDz9m6V
   A==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773521"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:08 +0800
IronPort-SDR: vcx2gXll197pPwCZsmZ5J3zpXsrBiSqCJYuBsGhHSjU0Qcp9xmmtO7cl+cp53NV08KG8GKUAIU
 vsvtHoBk91V0sJUicdUISXeMgIFr+E5si1N3U5D85qQYE1YkSYPQ3zfAgGUKIemJxa04hLiA9e
 9zFHXDShPXTK+GD3ejfTu+S/DXOJxX7iBCgRTBmGNmFqBpheK03yPlMz0rCN9IHoLvcLge7O6V
 wSuD7GxygS5lVJUVldlpwTKeQJP+akxLnyGxGsJ/+3dZxBc06tFJvMyc3oLeRd+G56IW1v6bQ4
 gd+08FFA3M94FDr8+zBGrdl+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:16 -0700
IronPort-SDR: 3h9WQSmutzbKX9IyUZ77MkcJ/0IOZ7RVUjIpsXeU1+Tqe70HtQRaXZ84CurAPTSu/L5X+eCL+9
 CZvD7PqEB+IBtGIJJ1pO9c7cAxb5L4kvn3b7hvVrF0jSH6VeVsx/GaHMlEl9mBqLOD+KrAG/Pl
 1BbFlJEI8+Imxn8AlAd9+x6FbQ7l5P9fD2kVLyr0+E7hI+FpNeHrgSCJfRaJZa9iaankOp9LhU
 DyGs4b20Jl6drVlGER96Ym2CXtP5xkPtkr3uqZFbxsRS0bvhFkRDa6v75zumiqxnEUQ0n7i+3i
 620=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 01/17] btrfs: zoned: load zone capacity information from devices
Date:   Thu, 19 Aug 2021 21:19:08 +0900
Message-Id: <e9838065577ce7c6f030ec3254bd001355ae0bb1.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ZNS specification introduces the concept of a Zone Capacity.  A zone
capacity is an additional per-zone attribute that indicates the number of
usable logical blocks within each zone, starting from the first logical
block of each zone. It is always smaller or equal to the zone size.

With the SINGLE profile, we can set a block group's "capacity" as the same
as the underlying zone's Zone Capacity. We will limit the allocation not
to exceed in a following commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/zoned.c       | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c72a71efcb18..2db40a005512 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -202,6 +202,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 zone_unusable;
+	u64 zone_capacity;
 	u64 meta_write_pointer;
 };
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 47af1ab3bf12..32f444c7ec76 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1039,6 +1039,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 *caps = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
@@ -1069,6 +1070,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return -ENOMEM;
 	}
 
+	caps = kcalloc(map->num_stripes, sizeof(*caps), GFP_NOFS);
+	if (!caps) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
@@ -1131,6 +1138,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 
+		caps[i] = zone.capacity << SECTOR_SHIFT;
+
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
@@ -1144,7 +1153,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			alloc_offsets[i] = 0;
 			break;
 		case BLK_ZONE_COND_FULL:
-			alloc_offsets[i] = fs_info->zone_size;
+			alloc_offsets[i] = caps[i];
 			break;
 		default:
 			/* Partially used zone */
@@ -1169,6 +1178,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * calculate_alloc_pointer() which takes extent buffer
 		 * locks to avoid deadlock.
 		 */
+
+		/* Zone capacity is always zone size in emulation */
+		cache->zone_capacity = cache->length;
 		if (new) {
 			cache->alloc_offset = 0;
 			goto out;
@@ -1195,6 +1207,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 		cache->alloc_offset = alloc_offsets[0];
+		cache->zone_capacity = caps[0];
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 	case BTRFS_BLOCK_GROUP_RAID1:
@@ -1218,6 +1231,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		ret = -EIO;
 	}
 
+	if (cache->alloc_offset > cache->zone_capacity) {
+		btrfs_err(fs_info,
+"zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
+			  cache->alloc_offset, cache->zone_capacity,
+			  cache->start);
+		ret = -EIO;
+	}
+
 	/* An extent is allocated after the write pointer */
 	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
 		btrfs_err(fs_info,
@@ -1229,6 +1250,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	if (!ret)
 		cache->meta_write_pointer = cache->alloc_offset + cache->start;
 
+	kfree(caps);
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
-- 
2.33.0

