Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444E872216C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjFEIvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEIvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:51:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD686CD
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PhBaVNC3lEXE7PqJcRyIguoJ81/Rkq5QobDbT3gpf2o=; b=EVCBs+nzNElGsK5XMkGU28+haQ
        Xf4wN/vNj71FBHT/sU/VpI4mzzxTkO2P0yGPGKOm21R8OPo9aRljlChIwn5a4SXolPt1o+PVpm9va
        X4l+UMd//gQc4VFxLZv5G6r45cx81hTnvaMvDZvdkjBiLPsHXQCdfx5OOvV8rl2Q8dNwfYCpFfBMS
        2kVOQPRzNk07fX54WEIvrdFKS65QNN6CwLbFmIs7Abs1OgzenjjAes4sSK5XhHY+oJzK2mF2IsSh2
        fXpfzQsxHvKP56h7PdKjuMB23WTzfUkkRVLlbEhfa0fI5rILj9WY6Jzgibux2JYezaBiu5q/xH0+h
        H/95m+yw==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65vk-00ElG6-31;
        Mon, 05 Jun 2023 08:51:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: introduce a zone_info struct to structure btrfs_load_block_group_zone_info
Date:   Mon,  5 Jun 2023 10:51:05 +0200
Message-Id: <20230605085108.580976-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605085108.580976-1-hch@lst.de>
References: <20230605085108.580976-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new zone_info structure to hold per-zone information in
btrfs_load_block_group_zone_info and prepare for breaking out helpers
from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 84 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1f5497b9b2695c..397b8c962eab50 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1276,6 +1276,12 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	return ret;
 }
 
+struct zone_info {
+	u64 physical;
+	u64 capacity;
+	u64 alloc_offset;
+};
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -1285,12 +1291,10 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	struct btrfs_device *device;
 	u64 logical = cache->start;
 	u64 length = cache->length;
+	struct zone_info *zone_info = NULL;
 	int ret;
 	int i;
 	unsigned int nofs_flag;
-	u64 *alloc_offsets = NULL;
-	u64 *caps = NULL;
-	u64 *physical = NULL;
 	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
@@ -1322,20 +1326,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
-	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets), GFP_NOFS);
-	if (!alloc_offsets) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	caps = kcalloc(map->num_stripes, sizeof(*caps), GFP_NOFS);
-	if (!caps) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	physical = kcalloc(map->num_stripes, sizeof(*physical), GFP_NOFS);
-	if (!physical) {
+	zone_info = kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
+	if (!zone_info) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1347,20 +1339,21 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
+		struct zone_info *info = zone_info + i;
 		bool is_sequential;
 		struct blk_zone zone;
 		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
-		physical[i] = map->stripes[i].physical;
+		info->physical = map->stripes[i].physical;
 
 		if (device->bdev == NULL) {
-			alloc_offsets[i] = WP_MISSING_DEV;
+			info->alloc_offset = WP_MISSING_DEV;
 			continue;
 		}
 
-		is_sequential = btrfs_dev_is_sequential(device, physical[i]);
+		is_sequential = btrfs_dev_is_sequential(device, info->physical);
 		if (is_sequential)
 			num_sequential++;
 		else
@@ -1374,7 +1367,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			__set_bit(i, active);
 
 		if (!is_sequential) {
-			alloc_offsets[i] = WP_CONVENTIONAL;
+			info->alloc_offset = WP_CONVENTIONAL;
 			continue;
 		}
 
@@ -1382,25 +1375,25 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * This zone will be used for allocation, so mark this zone
 		 * non-empty.
 		 */
-		btrfs_dev_clear_zone_empty(device, physical[i]);
+		btrfs_dev_clear_zone_empty(device, info->physical);
 
 		down_read(&dev_replace->rwsem);
 		dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, physical[i]);
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, info->physical);
 		up_read(&dev_replace->rwsem);
 
 		/*
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
 		 */
-		WARN_ON(!IS_ALIGNED(physical[i], fs_info->zone_size));
+		WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
 		nofs_flag = memalloc_nofs_save();
-		ret = btrfs_get_dev_zone(device, physical[i], &zone);
+		ret = btrfs_get_dev_zone(device, info->physical, &zone);
 		memalloc_nofs_restore(nofs_flag);
 		if (ret == -EIO || ret == -EOPNOTSUPP) {
 			ret = 0;
-			alloc_offsets[i] = WP_MISSING_DEV;
+			info->alloc_offset = WP_MISSING_DEV;
 			continue;
 		} else if (ret) {
 			goto out;
@@ -1415,26 +1408,26 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			goto out;
 		}
 
-		caps[i] = (zone.capacity << SECTOR_SHIFT);
+		info->capacity = (zone.capacity << SECTOR_SHIFT);
 
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
 			btrfs_err(fs_info,
 		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-				  physical[i] >> device->zone_info->zone_size_shift,
+				  info->physical >> device->zone_info->zone_size_shift,
 				  rcu_str_deref(device->name), device->devid);
-			alloc_offsets[i] = WP_MISSING_DEV;
+			info->alloc_offset = WP_MISSING_DEV;
 			break;
 		case BLK_ZONE_COND_EMPTY:
-			alloc_offsets[i] = 0;
+			info->alloc_offset = 0;
 			break;
 		case BLK_ZONE_COND_FULL:
-			alloc_offsets[i] = caps[i];
+			info->alloc_offset = info->capacity;
 			break;
 		default:
 			/* Partially used zone */
-			alloc_offsets[i] =
+			info->alloc_offset =
 					((zone.wp - zone.start) << SECTOR_SHIFT);
 			__set_bit(i, active);
 			break;
@@ -1462,15 +1455,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case 0: /* single */
-		if (alloc_offsets[0] == WP_MISSING_DEV) {
+		if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
 			btrfs_err(fs_info,
 			"zoned: cannot recover write pointer for zone %llu",
-				physical[0]);
+				zone_info[0].physical);
 			ret = -EIO;
 			goto out;
 		}
-		cache->alloc_offset = alloc_offsets[0];
-		cache->zone_capacity = caps[0];
+		cache->alloc_offset = zone_info[0].alloc_offset;
+		cache->zone_capacity = zone_info[0].capacity;
 		if (test_bit(0, active))
 			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
 		break;
@@ -1480,21 +1473,21 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			ret = -EINVAL;
 			goto out;
 		}
-		if (alloc_offsets[0] == WP_MISSING_DEV) {
+		if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
 			btrfs_err(fs_info,
 			"zoned: cannot recover write pointer for zone %llu",
-				physical[0]);
+				zone_info[0].physical);
 			ret = -EIO;
 			goto out;
 		}
-		if (alloc_offsets[1] == WP_MISSING_DEV) {
+		if (zone_info[1].alloc_offset == WP_MISSING_DEV) {
 			btrfs_err(fs_info,
 			"zoned: cannot recover write pointer for zone %llu",
-				physical[1]);
+				zone_info[1].physical);
 			ret = -EIO;
 			goto out;
 		}
-		if (alloc_offsets[0] != alloc_offsets[1]) {
+		if (zone_info[0].alloc_offset != zone_info[1].alloc_offset) {
 			btrfs_err(fs_info,
 			"zoned: write pointer offset mismatch of zones in DUP profile");
 			ret = -EIO;
@@ -1510,8 +1503,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
 					&cache->runtime_flags);
 		}
-		cache->alloc_offset = alloc_offsets[0];
-		cache->zone_capacity = min(caps[0], caps[1]);
+		cache->alloc_offset = zone_info[0].alloc_offset;
+		cache->zone_capacity = min(zone_info[0].capacity,
+					   zone_info[1].capacity);
 		break;
 	case BTRFS_BLOCK_GROUP_RAID1:
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -1564,9 +1558,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->physical_map = NULL;
 	}
 	bitmap_free(active);
-	kfree(physical);
-	kfree(caps);
-	kfree(alloc_offsets);
+	kfree(zone_info);
 	free_extent_map(em);
 
 	return ret;
-- 
2.39.2

