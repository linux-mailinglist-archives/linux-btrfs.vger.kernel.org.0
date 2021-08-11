Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E083E938D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhHKOVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35979 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhHKOVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691659; x=1660227659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEFzRrszix1l6/flV4/Vc8Vbl2iM2mpVhEcj9YgXBHs=;
  b=hXhhN6+Zr/O48ODL3+PjJJ9IcfXvHRMijxORG7q8vL5NcGKTa17Z2dGC
   tA2seR7sHHFGYB8EAQ+STo0aoWCjVQz6lq82+nj2NAABx5YtntDVZY2e2
   GDSq0zyh5hCzTs8TDxUrmxHwcrbkGOzpquRR629eprbOkMSehxsif4svw
   mwEqnvsJGH+xpcZRITjsB/0KWP5n83u/+uZoaS0UYnYKx1ugyFmOKzlQA
   O88+TKvO4VAdwkmZHvkDhF1CVV4ZlRn4tKJXWpSC/z8piqId4Br4lm+Lh
   bBh4ANHeI8id151eMZ/2TVdV/I2CKRJosst0C/2O7YSYLbEQmzjbD39Lk
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937896"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:57 +0800
IronPort-SDR: hKclg5GTtOM+5aVnr4eJ17Rk1I4bg+moztezXzChVSo1sku/+YRPgCpGzEIux9pJCfAeHtHnaZ
 TEbI9kN39Zj0vYWZZAnd/QChaCaOB1YGsVBhSnlQ5BaPtyPpa8gol/pRI39+Wap2RUKBqiWdCM
 oaZZSuZklfhAbhfDrIzvjh6HqaxvTv6t0uVNXf8+nxwtmYfw2/Bz2DA1EhUrwpBaj6jIyqdGtb
 Yg9SO9o0oW1BQLsgQ6xdY0RwESCv+3aS0YnC8qVFGG4h19SwOvpmZNxB9S9VhY7hGBqJrid3nf
 LL+RTZVDbs21dinxjs9MPWbq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:28 -0700
IronPort-SDR: 54gQQmasViOzuUtirGlerAt6MfVMWsuSZmsKUrdMWvm3OiN6ZNSLQXyDKNk5sjxILx7Wdb+a1i
 +y6DPf3WIURpShY27RcjfVEabXU/XmOvlaOdmXz56zjALjMAt9gQZpPUHy15uDrQ+D4ofnyHnP
 yQW5zARrTgeiu6dool6GeH1VyVntq7GchLIYrkD4qBsU7mJh03WSwbCv4S3vvcEjkWV995AVPp
 4e3vU9mjgF878uWizVws/t8GkMKn1dbEg5WnGPxc8UKrdU85Z/aR3ApHtqtaWDYbTA35BQx7Vs
 Wys=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/17] btrfs: zoned: load active zone info for block group
Date:   Wed, 11 Aug 2021 23:16:35 +0900
Message-Id: <39157881e58cda60e4f5672dc87e9a2384bd4a5d.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Load activeness of underlying zones of a block group. When underlying zones
are active, we add the block group to the fs_info->zone_active_bgs list.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 39468989a203..f3c31159fb2e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1170,6 +1170,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
 	u64 *caps = NULL;
+	unsigned long *active = NULL;
 	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
@@ -1215,6 +1216,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
+	active = bitmap_zalloc(map->num_stripes, GFP_NOFS);
+	if (!active) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
@@ -1298,8 +1305,16 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 			/* Partially used zone */
 			alloc_offsets[i] =
 					((zone.wp - zone.start) << SECTOR_SHIFT);
+			__set_bit(i, active);
 			break;
 		}
+
+		/*
+		 * Consider a zone as active if we can allow any number of
+		 * active zones.
+		 */
+		if (!device->zone_info->max_active_zones)
+			__set_bit(i, active);
 	}
 
 	if (num_sequential > 0)
@@ -1347,6 +1362,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 		cache->alloc_offset = alloc_offsets[0];
 		cache->zone_capacity = caps[0];
+		cache->zone_is_active = test_bit(0, active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 	case BTRFS_BLOCK_GROUP_RAID1:
@@ -1362,6 +1378,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
+	if (cache->zone_is_active) {
+		btrfs_get_block_group(cache);
+		spin_lock(&fs_info->zone_active_bgs_lock);
+		list_add_tail(&cache->active_bg_list,
+			      &fs_info->zone_active_bgs);
+		spin_unlock(&fs_info->zone_active_bgs_lock);
+	}
+
 out:
 	if (cache->alloc_offset > fs_info->zone_size) {
 		btrfs_err(fs_info,
@@ -1393,6 +1417,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		kfree(cache->physical_map);
 		cache->physical_map = NULL;
 	}
+	bitmap_free(active);
 	kfree(caps);
 	kfree(alloc_offsets);
 	free_extent_map(em);
-- 
2.32.0

