Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2046249C5A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiAZI7q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 03:59:46 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbiAZI7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187586; x=1674723586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RuRvHdePduPq0jBMBOuMJJORQvw0ilIInwK8TI6ctRs=;
  b=g/GbNPR3hcmfz6XWdZ6nqyOu/RqkTfp3RAR/MyV7qJcFYp34i7rcLEqE
   cb+pSn1KOtM4rhA1SYjgY3tjsJFRI0JnbXQDtMZeQL/IxR0FVbZsQeQ7g
   P0gUJ7iXWn0xfqb5oKZpVL+s4CXdk17ny4ftyyL7n4OwV9/6/jv+vQ/pJ
   sVt7AFcV4XHc4pyGlIVD9ypoOhzCWZh8aWO6jyOH9ilQUj3BoFgj7gM5K
   vvey5cU21NG3P6WYcc0wO/mPGIas/yvZghyvpcJX3pFf+5OBEPERr+aUV
   CHmYnbtT0YCFiYoYJb1d+oOolNF4eF6f2rnjDZau7KOT+w+sTRwcnSTK0
   w==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="192406585"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 16:59:46 +0800
IronPort-SDR: kAqpClybUgx1i9WSh72XdZ6fLGkyuay2x4uLLo7Y/w0td3gplyN83gfqr43S4ppGfWEtGK54J/
 SFgx2rXNiT4nv0kc3Fg5eHDw2/pMV/dXiAzEP98PgeOd6M72CACy/2zKX9OtqK4OLJbxOdGeyI
 ql0Ak3W4QCgSvLCbByXl8Ab7y1IvEDRDQuWffeuSFwq/m8HgrgzCt4JQrUC6MQ+icsoQ+OpUHw
 1MFLhkIDXDQnARu8kCTDIIkRXrkscPqAygTz4FwUV2YGdP2xbLY3f0OC1+hPuWXM4Lq3FegHyB
 vHNX/t0JSOLR2jLO6K1SQtuS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:31:50 -0800
IronPort-SDR: kb/kFhL7szpqHjDFDQQo+Dz/LloYO9vtGEGUZZnHJ0xYUUmwJezUjR8QgqoWgn9HoBu/6tPnDM
 JKb32tVE/43AE2cevVS4owlzCKaj3Kb/zdlAG2Q002396XyZ0c3/yrL4R7mN7BxqlgmEToJUDP
 KN9OQy84pIumgt/pp8xyqvbScoXOSMmXptI3aMEnREnjQe+2+WjY1p0BViILVsmMDwEHkMbtMz
 hWTTjClM9Ql6MdLjqMP+sr6e09fBrsxo3cII59jaZz8p/9RrRjYOm2+rDm803E0q6Q2rwpA/WZ
 jk0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 00:59:46 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: zoned: prepare for allowing DUP on zoned
Date:   Wed, 26 Jan 2022 00:59:32 -0800
Message-Id: <e9a827fbb3e77f402494bfe2e73b5a7be4f703c9.1643185812.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643185812.git.johannes.thumshirn@wdc.com>
References: <cover.1643185812.git.johannes.thumshirn@wdc.com>
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

