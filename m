Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7849CB3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 14:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiAZNq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 08:46:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46304 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiAZNq3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643204788; x=1674740788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RuRvHdePduPq0jBMBOuMJJORQvw0ilIInwK8TI6ctRs=;
  b=ADlqCVs22VXtb7IUynUu6lDt+onxcx4cAU6vIp49iokwMBkgzcB2Cykj
   cmbP3XS8W897sLcIiRu5XnLfPQJLiL2Bsr1q3YDEJiOvDuD3WXtdbsMhh
   EvGQnXKa6tgpcFZYytru3F4YPXY/KoA/9FwIvUU/OGPQv1/lJ5fZHMP4L
   OOYGa5MOVQxbgKP6KCEeBX7adABaevyeadooZglbpkiFi9CsEWhn6Q4Yw
   GDqwnlzfBAz5ZUp8Gw7S8jRiLpubMpa7F4PwYpyJM/MAPTTOBYFo+koUM
   KVJ0vy0/xkv/iy+uPX4vvjPuMGb1JLAMnfD6lkZUTcDR3YjVvrUFSyzkc
   w==;
X-IronPort-AV: E=Sophos;i="5.88,318,1635177600"; 
   d="scan'208";a="190373108"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 21:46:28 +0800
IronPort-SDR: Yf8a5E0Le/FZ+LdHZ18odBgVUKBLAM+XCa+4oc3qLjZFUMg28KFBD01O+Hbaf8ouRdIczD4E+u
 6vVGvZP7og2vMVPEvobFEnqUKlqOeBXM3Lm7EbiYlmd1C4dp0pNSI4I5SLViFhVAZi2Gj+XdjP
 k5rlnRuMFXwc0s/gucRlNCnCqWO3rexiqaM4NmNb695VLbm2Ua2Gsf3Y07Q9Y2m5uWIWui2AvT
 sgJsr3wLCpp25RPUOjg7faESA8yQLVbZrD97E90jX0ZVCJpSJQtKc9FTMKzSFHXKXuBhEYyVzI
 bGBLGr6FTXVIQ4XtNuQQdWGx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:48 -0800
IronPort-SDR: g7reG1auSEuuqLm5/ZP/B8VpjHMe4fnh5rUP3KYsYNkaYWUZ+cLy15vkTOJlEh1gEmR8pUrXfz
 uB0Q3C/E20xypjM1ycED/JsS8LFE8IPTnSw7uNtUfvXClRjwjQ7q1judR0xodNIuCCLxrYOJQp
 4eIGFyivO3PjPN7mUm5Ix4hKEp1mFHqbcfOf2k1Kexqgq40Sx8x7XDTbhj8+rvHsfyUWggPEva
 kEn4RpTP/VmjraCr6cwQCpppvupQmog4Bifd723t3+vUh+aXfRSqiNEQlnDFROcBpYpaM1vjZ+
 fFI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 05:46:28 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: zoned: prepare for allowing DUP on zoned
Date:   Wed, 26 Jan 2022 05:46:22 -0800
Message-Id: <eeffdc168bf28bd88e68fa70012a9df91aa8be24.1643204608.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643204608.git.johannes.thumshirn@wdc.com>
References: <cover.1643204608.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allow for a block-group to be placed on more than one physical zone.

This is a preparation for allowing DUP profiles for meta-data on a zoned
file-system.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 987d2456d398..4f6f7afaa5a2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1215,12 +1215,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	struct btrfs_device *device;
 	u64 logical = cache->start;
 	u64 length = cache->length;
-	u64 physical = 0;
 	int ret;
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
 	u64 *caps = NULL;
+	u64 *physical = NULL;
 	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
@@ -1264,6 +1264,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
+	physical = kcalloc(map->num_stripes, sizeof(*physical), GFP_NOFS);
+	if (!physical) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	active = bitmap_zalloc(map->num_stripes, GFP_NOFS);
 	if (!active) {
 		ret = -ENOMEM;
@@ -1277,14 +1283,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
-		physical = map->stripes[i].physical;
+		physical[i] = map->stripes[i].physical;
 
 		if (device->bdev == NULL) {
 			alloc_offsets[i] = WP_MISSING_DEV;
 			continue;
 		}
 
-		is_sequential = btrfs_dev_is_sequential(device, physical);
+		is_sequential = btrfs_dev_is_sequential(device, physical[i]);
 		if (is_sequential)
 			num_sequential++;
 		else
@@ -1299,21 +1305,21 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * This zone will be used for allocation, so mark this zone
 		 * non-empty.
 		 */
-		btrfs_dev_clear_zone_empty(device, physical);
+		btrfs_dev_clear_zone_empty(device, physical[i]);
 
 		down_read(&dev_replace->rwsem);
 		dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
-			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, physical);
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, physical[i]);
 		up_read(&dev_replace->rwsem);
 
 		/*
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
 		 */
-		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
+		WARN_ON(!IS_ALIGNED(physical[i], fs_info->zone_size));
 		nofs_flag = memalloc_nofs_save();
-		ret = btrfs_get_dev_zone(device, physical, &zone);
+		ret = btrfs_get_dev_zone(device, physical[i], &zone);
 		memalloc_nofs_restore(nofs_flag);
 		if (ret == -EIO || ret == -EOPNOTSUPP) {
 			ret = 0;
@@ -1339,7 +1345,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		case BLK_ZONE_COND_READONLY:
 			btrfs_err(fs_info,
 		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-				  physical >> device->zone_info->zone_size_shift,
+				  physical[i] >> device->zone_info->zone_size_shift,
 				  rcu_str_deref(device->name), device->devid);
 			alloc_offsets[i] = WP_MISSING_DEV;
 			break;
@@ -1404,7 +1410,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		if (alloc_offsets[0] == WP_MISSING_DEV) {
 			btrfs_err(fs_info,
 			"zoned: cannot recover write pointer for zone %llu",
-				physical);
+				physical[0]);
 			ret = -EIO;
 			goto out;
 		}
@@ -1465,6 +1471,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->physical_map = NULL;
 	}
 	bitmap_free(active);
+	kfree(physical);
 	kfree(caps);
 	kfree(alloc_offsets);
 	free_extent_map(em);
-- 
2.31.1

