Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E172216D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFEIv0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEIv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:51:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AEBC7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VDHoB/G4+q0ufqrk+lINqHnAmjIbgPjD8Yo/6bnAOC8=; b=oswD1Da2qA/enIkRu0ADqUQr35
        4bjDZxztNeVIWhz0nNf+p5LQ9PzdhzCTutBnDH6Oj6TTrm4hyXL0Fe4W6J9roPHrwsYhOrLyPZ+QZ
        M9ysz0YcwNC3tjmV8Fma35r4jKKHs4d2kARpRwVdq1XsE0LslHGiqDIn9FfRNFUOfmZcC1Xpf3Vpy
        zpmnbDVCcdbjGFhr5r5hwcMtSB4XMh0cP3vIyejMtTIG9eQEbTMbbCljqhZg4djUiWtLZNwxHTleB
        XCdMp53hr1NQYpdPN6KL85ZGz2aOj4jjqSfdzaYT8U/G7KjoR1+sFNBTJ0R5EAldXaJ+MxGTNUMlE
        eSEPvqBA==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65vs-00ElHo-1y;
        Mon, 05 Jun 2023 08:51:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: factor out the per-zone logic from btrfs_load_block_group_zone_info
Date:   Mon,  5 Jun 2023 10:51:06 +0200
Message-Id: <20230605085108.580976-3-hch@lst.de>
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

Split out a helper for the body of the per-zone loop in
btrfs_load_block_group_zone_info to make the function easier to read and
modify.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 191 ++++++++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 93 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 397b8c962eab50..533cbe849cd60f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1282,19 +1282,108 @@ struct zone_info {
 	u64 alloc_offset;
 };
 
+static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
+				struct zone_info *info, unsigned long *active,
+				struct map_lookup *map)
+{
+	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	struct btrfs_device *device = map->stripes[zone_idx].dev;
+	int dev_replace_is_ongoing = 0;
+	unsigned int nofs_flag;
+	struct blk_zone zone;
+	int ret;
+
+	info->physical = map->stripes[zone_idx].physical;
+
+	if (!device->bdev) {
+		info->alloc_offset = WP_MISSING_DEV;
+		return 0;
+	}
+
+	/*
+	 * Consider a zone as active if we can allow any number of
+	 * active zones.
+	 */
+	if (!device->zone_info->max_active_zones)
+		__set_bit(zone_idx, active);
+
+	if (!btrfs_dev_is_sequential(device, info->physical)) {
+		info->alloc_offset = WP_CONVENTIONAL;
+		return 0;
+	}
+
+	/*
+	 * This zone will be used for allocation, so mark this zone non-empty.
+	 */
+	btrfs_dev_clear_zone_empty(device, info->physical);
+
+	down_read(&dev_replace->rwsem);
+	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
+	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
+		btrfs_dev_clear_zone_empty(dev_replace->tgtdev, info->physical);
+	up_read(&dev_replace->rwsem);
+
+	/*
+	 * The group is mapped to a sequential zone. Get the zone write pointer
+	 * to determine the allocation offset within the zone.
+	 */
+	WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+	nofs_flag = memalloc_nofs_save();
+	ret = btrfs_get_dev_zone(device, info->physical, &zone);
+	memalloc_nofs_restore(nofs_flag);
+	if (ret) {
+		if (ret != -EIO && ret != -EOPNOTSUPP)
+			return ret;
+		info->alloc_offset = WP_MISSING_DEV;
+		return 0;
+	}
+
+	if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		btrfs_err_in_rcu(fs_info,
+	"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
+			zone.start << SECTOR_SHIFT,
+			rcu_str_deref(device->name), device->devid);
+		return -EIO;
+	}
+
+	info->capacity = (zone.capacity << SECTOR_SHIFT);
+
+	switch (zone.cond) {
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+		btrfs_err(fs_info,
+		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
+			  info->physical >> device->zone_info->zone_size_shift,
+			  rcu_str_deref(device->name), device->devid);
+		info->alloc_offset = WP_MISSING_DEV;
+		break;
+	case BLK_ZONE_COND_EMPTY:
+		info->alloc_offset = 0;
+		break;
+	case BLK_ZONE_COND_FULL:
+		info->alloc_offset = info->capacity;
+		break;
+	default:
+		/* Partially used zone */
+		info->alloc_offset = ((zone.wp - zone.start) << SECTOR_SHIFT);
+		__set_bit(zone_idx, active);
+		break;
+	}
+
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
 	struct extent_map *em;
 	struct map_lookup *map;
-	struct btrfs_device *device;
 	u64 logical = cache->start;
 	u64 length = cache->length;
 	struct zone_info *zone_info = NULL;
 	int ret;
 	int i;
-	unsigned int nofs_flag;
 	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
@@ -1339,99 +1428,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		struct zone_info *info = zone_info + i;
-		bool is_sequential;
-		struct blk_zone zone;
-		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
-		int dev_replace_is_ongoing = 0;
-
-		device = map->stripes[i].dev;
-		info->physical = map->stripes[i].physical;
-
-		if (device->bdev == NULL) {
-			info->alloc_offset = WP_MISSING_DEV;
-			continue;
-		}
-
-		is_sequential = btrfs_dev_is_sequential(device, info->physical);
-		if (is_sequential)
-			num_sequential++;
-		else
-			num_conventional++;
-
-		/*
-		 * Consider a zone as active if we can allow any number of
-		 * active zones.
-		 */
-		if (!device->zone_info->max_active_zones)
-			__set_bit(i, active);
-
-		if (!is_sequential) {
-			info->alloc_offset = WP_CONVENTIONAL;
-			continue;
-		}
-
-		/*
-		 * This zone will be used for allocation, so mark this zone
-		 * non-empty.
-		 */
-		btrfs_dev_clear_zone_empty(device, info->physical);
-
-		down_read(&dev_replace->rwsem);
-		dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
-		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, info->physical);
-		up_read(&dev_replace->rwsem);
-
-		/*
-		 * The group is mapped to a sequential zone. Get the zone write
-		 * pointer to determine the allocation offset within the zone.
-		 */
-		WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
-		nofs_flag = memalloc_nofs_save();
-		ret = btrfs_get_dev_zone(device, info->physical, &zone);
-		memalloc_nofs_restore(nofs_flag);
-		if (ret == -EIO || ret == -EOPNOTSUPP) {
-			ret = 0;
-			info->alloc_offset = WP_MISSING_DEV;
-			continue;
-		} else if (ret) {
-			goto out;
-		}
-
-		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
-			btrfs_err_in_rcu(fs_info,
-	"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
-				zone.start << SECTOR_SHIFT,
-				rcu_str_deref(device->name), device->devid);
-			ret = -EIO;
+		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active,
+					   map);
+		if (ret)
 			goto out;
-		}
 
-		info->capacity = (zone.capacity << SECTOR_SHIFT);
-
-		switch (zone.cond) {
-		case BLK_ZONE_COND_OFFLINE:
-		case BLK_ZONE_COND_READONLY:
-			btrfs_err(fs_info,
-		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-				  info->physical >> device->zone_info->zone_size_shift,
-				  rcu_str_deref(device->name), device->devid);
-			info->alloc_offset = WP_MISSING_DEV;
-			break;
-		case BLK_ZONE_COND_EMPTY:
-			info->alloc_offset = 0;
-			break;
-		case BLK_ZONE_COND_FULL:
-			info->alloc_offset = info->capacity;
-			break;
-		default:
-			/* Partially used zone */
-			info->alloc_offset =
-					((zone.wp - zone.start) << SECTOR_SHIFT);
-			__set_bit(i, active);
-			break;
-		}
+		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			num_conventional++;
+		else
+			num_sequential++;
 	}
 
 	if (num_sequential > 0)
-- 
2.39.2

