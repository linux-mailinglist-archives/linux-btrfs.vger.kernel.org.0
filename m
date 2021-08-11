Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ABB3E938B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhHKOV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35979 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhHKOVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691656; x=1660227656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+nEsMisGz6VUscYrWXRfYuxXcHrximBLnC6rdppjmw=;
  b=PuzF3zALTK99ll46/XRAxDXYuEwbfbhb8+xX1+mBA5kflc1ArDUkhzpO
   z1KzgNXwv2yrcrhMATG45++9qU6VPKyy+LLX+bBkIQ1oizrxaeMR9OEUo
   KFxPGg5khhUvFAH8xFVFQUgzMCPc7d9gMy9HNXt3trqFMzFbyN82bY6K9
   eWOJ7soy1B1Fz/MXRGjQEoV6RRNPFQxVGf8gcK4F0vnr8zoATBFNviFh1
   QG2y8X3jYjUT8+MFulDjfV/X98spoz1BHzYduFF951PI1+dLOS65DJics
   nBHZEdXmm+XbNnc4YudZdRmUaLlmtWPkawkp9HavEq6wgzFs+q3NXDVCt
   A==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176937893"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:20:56 +0800
IronPort-SDR: 8tzTIkQpuZrzfz9OZZar9pLndLpPCL9uB/3vzwnGQGlQ4qAi8f6Brpuqbh5t0j3HdEJiMPkRYV
 OKrSc2b9aoLH4bEQi8YJEpDq6kPZ3wZ6+EUT9snf/pxUjSaF+nDN1FnFSwbqNiKP92+tfNIMX0
 vGZrSQvDdVO4gDFDN0ie1o2Jsylc9/S18VhENLHRdkdcFdPa0pDgbBQtwiAEUAQC4nkfngnClX
 fAJOg3hj5e2CISSdAjYsUPsuRpafO3JtTmh+1yG/BzurkGyYZYvzk4/p1lYUr/gqWKFOJbHv7X
 50hDYOkEKvD0YagGT7N/xZlr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:26 -0700
IronPort-SDR: 2rXqkc8fu/K2jgidscjSVR/99EJMLE7WRvXDPPOq6uaFzBOlQilENSC2p7LzZVTlk37t2/5D80
 Hxq8atAvI0MU3rcLOcUNPhQDazeTtU7ncF8iceo/+JivJ/ajlRQbCEy0vxZ3hBSOHntzHPmoNk
 pkx8GP0VfiY8nJmZ/RqSMCLfBKGZlqcWcYSngrBH9qBOFvIiCikZiPd0sMM6SEmljcPL2qbrko
 mvhNhs9RG6DhnfWULE5TRYfdORqq5o66hJOwy51Yn7UZCJBr9PQPrm8Umsh8zGUayYCStg1Vnb
 IUY=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:20:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/17] btrfs: zoned: implement active zone tracking
Date:   Wed, 11 Aug 2021 23:16:34 +0900
Message-Id: <3decf1b58d55d025879b5883bb7cf879572282d2.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add zone_is_active flag to btrfs_block_group. This flag indicates the
underlying zones are all active. Such zone active block groups are tracked
by fs_info->active_bg_list.

btrfs_dev_{set,clear}_active_zone() take responsibility for the underlying
device part. They set/clear the bitmap to indicate zone activeness and
count the number of zones we can activate left.

btrfs_zone_{activate,finish}() take responsibility for the logical part and
the list management. In addition, btrfs_zone_finish() wait for any writes
on it and send REQ_OP_ZONE_FINISH to the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      |  11 +++
 fs/btrfs/block-group.h      |   2 +
 fs/btrfs/ctree.h            |   3 +
 fs/btrfs/disk-io.c          |   2 +
 fs/btrfs/free-space-cache.c |   5 +-
 fs/btrfs/zoned.c            | 183 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h            |  12 +++
 7 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c94815cbd136..90c4279592a0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1898,6 +1898,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	INIT_LIST_HEAD(&cache->discard_list);
 	INIT_LIST_HEAD(&cache->dirty_list);
 	INIT_LIST_HEAD(&cache->io_list);
+	INIT_LIST_HEAD(&cache->active_bg_list);
 	btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
 	atomic_set(&cache->frozen, 0);
 	mutex_init(&cache->free_space_lock);
@@ -3843,6 +3844,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	spin_unlock(&info->unused_bgs_lock);
 
+	spin_lock(&info->zone_active_bgs_lock);
+	while (!list_empty(&info->zone_active_bgs)) {
+		block_group = list_first_entry(&info->zone_active_bgs,
+					       struct btrfs_block_group,
+					       active_bg_list);
+		list_del_init(&block_group->active_bg_list);
+		btrfs_put_block_group(block_group);
+	}
+	spin_unlock(&info->zone_active_bgs_lock);
+
 	spin_lock(&info->block_group_cache_lock);
 	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
 		block_group = rb_entry(n, struct btrfs_block_group,
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 265db2c316d3..f751b802b173 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -98,6 +98,7 @@ struct btrfs_block_group {
 	unsigned int to_copy:1;
 	unsigned int relocating_repair:1;
 	unsigned int chunk_item_inserted:1;
+	unsigned int zone_is_active:1;
 
 	int disk_cache_state;
 
@@ -205,6 +206,7 @@ struct btrfs_block_group {
 	u64 zone_capacity;
 	u64 meta_write_pointer;
 	struct map_lookup *physical_map;
+	struct list_head active_bg_list;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a898257ad2b5..bbe1a93a5d6e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1017,6 +1017,9 @@ struct btrfs_fs_info {
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
 
+	spinlock_t zone_active_bgs_lock;
+	struct list_head zone_active_bgs;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 74b8848de8da..88c7b2dcf78d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2883,6 +2883,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->buffer_lock);
 	spin_lock_init(&fs_info->unused_bgs_lock);
 	spin_lock_init(&fs_info->treelog_bg_lock);
+	spin_lock_init(&fs_info->zone_active_bgs_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->reclaim_bgs_lock);
@@ -2896,6 +2897,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
 	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
+	INIT_LIST_HEAD(&fs_info->zone_active_bgs);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 772485c39e45..e74e0ec1e3cc 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2763,9 +2763,10 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 	 * out the free space after the allocation offset.
 	 */
 	if (btrfs_is_zoned(fs_info)) {
-		btrfs_info(fs_info, "free space %llu",
+		btrfs_info(fs_info, "free space %llu active %d",
 			   block_group->zone_capacity -
-			   block_group->alloc_offset);
+			   block_group->alloc_offset,
+			   block_group->zone_is_active);
 		return;
 	}
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index cfc6d4337473..39468989a203 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -989,6 +989,41 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 	return pos;
 }
 
+static bool btrfs_dev_set_active_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+	unsigned int zno = pos >> zone_info->zone_size_shift;
+
+	/* We can use any number of zones */
+	if (!zone_info->max_active_zones)
+		return true;
+
+	if (!test_bit(zno, zone_info->active_zones)) {
+		/* Active zone left? */
+		if (atomic_dec_if_positive(&zone_info->active_zones_left) < 0)
+			return false;
+		if (test_and_set_bit(zno, zone_info->active_zones)) {
+			/* Someone already set the bit */
+			atomic_inc(&zone_info->active_zones_left);
+		}
+	}
+
+	return true;
+}
+
+static void btrfs_dev_clear_active_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+	unsigned int zno = pos >> zone_info->zone_size_shift;
+
+	/* We can use any number of zones */
+	if (!zone_info->max_active_zones)
+		return;
+
+	if (test_and_clear_bit(zno, zone_info->active_zones))
+		atomic_inc(&zone_info->active_zones_left);
+}
+
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes)
 {
@@ -1004,6 +1039,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 	*bytes = length;
 	while (length) {
 		btrfs_dev_set_zone_empty(device, physical);
+		btrfs_dev_clear_active_zone(device, physical);
 		physical += device->zone_info->zone_size;
 		length -= device->zone_info->zone_size;
 	}
@@ -1657,3 +1693,150 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 
 	return device;
 }
+
+/**
+ * btrfs_zone_activate - activate block group and underlying device zones
+ *
+ * @block_group: the block group to activate
+ *
+ * @return: true on success, false otherwise
+ */
+bool btrfs_zone_activate(struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 physical;
+	bool ret;
+
+	if (!btrfs_is_zoned(block_group->fs_info))
+		return true;
+
+	map = block_group->physical_map;
+	/* Currently support SINGLE profile only */
+	ASSERT(map->num_stripes == 1);
+	device = map->stripes[0].dev;
+	physical = map->stripes[0].physical;
+
+	if (!device->zone_info->max_active_zones)
+		return true;
+
+	spin_lock(&block_group->lock);
+
+	if (block_group->zone_is_active) {
+		ret = true;
+		goto out_unlock;
+	}
+
+	/* No space left */
+	if (block_group->alloc_offset == block_group->zone_capacity) {
+		ret = false;
+		goto out_unlock;
+	}
+
+	if (!btrfs_dev_set_active_zone(device, physical)) {
+		/* Cannot activate the zone */
+		ret = false;
+		goto out_unlock;
+	}
+
+	/* Successfully activated all the zones */
+	block_group->zone_is_active = 1;
+
+	spin_unlock(&block_group->lock);
+
+	/* for the active BG list */
+	btrfs_get_block_group(block_group);
+
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	ASSERT(list_empty(&block_group->active_bg_list));
+	list_add_tail(&block_group->active_bg_list, &fs_info->zone_active_bgs);
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+
+	return true;
+
+out_unlock:
+	spin_unlock(&block_group->lock);
+	return ret;
+}
+
+int btrfs_zone_finish(struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 physical;
+	int ret = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	map = block_group->physical_map;
+	/* Currently support SINGLE profile only */
+	ASSERT(map->num_stripes == 1);
+
+	device = map->stripes[0].dev;
+	physical = map->stripes[0].physical;
+
+	if (!device->zone_info->max_active_zones)
+		return 0;
+
+	spin_lock(&block_group->lock);
+	if (!block_group->zone_is_active) {
+		spin_unlock(&block_group->lock);
+		return 0;
+	}
+
+	/* Check if we have unwritten allocated space */
+	if ((block_group->flags &
+	     (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) &&
+	    block_group->alloc_offset > block_group->meta_write_pointer) {
+		spin_unlock(&block_group->lock);
+		return -EAGAIN;
+	}
+	spin_unlock(&block_group->lock);
+
+	ret = btrfs_inc_block_group_ro(block_group, false);
+	if (ret)
+		return ret;
+
+	/* Ensure all writes in this block group finish */
+	btrfs_wait_block_group_reservations(block_group);
+	/*
+	 * No need to wait nocow writers. Zoned btrfs does not allow
+	 * nocow anyway.
+	 */
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
+				 block_group->length);
+
+	spin_lock(&block_group->lock);
+	if (!block_group->zone_is_active) {
+		spin_unlock(&block_group->lock);
+		return 0;
+	}
+	block_group->zone_is_active = 0;
+	block_group->alloc_offset = block_group->zone_capacity;
+	block_group->free_space_ctl->free_space = 0;
+	btrfs_clear_treelog_bg(block_group);
+	spin_unlock(&block_group->lock);
+
+	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+			       physical >> SECTOR_SHIFT,
+			       device->zone_info->zone_size >> SECTOR_SHIFT,
+			       GFP_NOFS);
+	btrfs_dec_block_group_ro(block_group);
+
+	if (!ret) {
+		btrfs_dev_clear_active_zone(device, physical);
+
+		spin_lock(&fs_info->zone_active_bgs_lock);
+		ASSERT(!list_empty(&block_group->active_bg_list));
+		list_del_init(&block_group->active_bg_list);
+		spin_unlock(&fs_info->zone_active_bgs_lock);
+
+		/* for active_bg_list */
+		btrfs_put_block_group(block_group);
+	}
+
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 48628782e4b8..2345ecfa1805 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -69,6 +69,8 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
 struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
+bool btrfs_zone_activate(struct btrfs_block_group *block_group);
+int btrfs_zone_finish(struct btrfs_block_group *block_group);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -204,6 +206,16 @@ static inline struct btrfs_device *btrfs_zoned_get_device(
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline bool btrfs_zone_activate(struct btrfs_block_group *block_group)
+{
+	return true;
+}
+
+static inline int btrfs_zone_finish(struct btrfs_block_group *block_group)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.32.0

