Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF33772A3A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHGQM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjHGQMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587C9F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424773; x=1722960773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrpRx4Dl+vqEB9ZfZ/PllrAbwOLAIEFv2A2EzpCDMJI=;
  b=KRvx22TPs6gq/ahGSeqPNWVtVVLOZ3C7HgLGA4RyG2I6O1ktJmuWn6us
   4Fl7gt6P/TuSjcgPVM7f8YYODlXE50rM8SHHL4ej8tASSsJjSxiC8h9M9
   eX1MDjWLkjfCMGwcSTa8NFn+QW9I+6KMomiFgfQpiFfso4KCif3iZ3CYd
   xy/tpl/YFXAwdaPOFnAPSs3IZ7qDjrsnlklGsP9gwnWd/+MGq26x0Miys
   gxM4C1ZvNO99ak/6Tw5nKed6Xu9lJ3KQu7KhwIkPeTKOOdS86q77GbXU7
   VS1nHMvrVT1GNQidxkovfHpiqYYZPHpBNg2NaXcxKEMVevANDpGIoJ3LA
   w==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710997"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:52 +0800
IronPort-SDR: cQH9OCnkG29SBhTdVUd6Vs/nTlcePwClq+CPVWX8GEQdvcQyjwi87+ZvibjCYOz+x4+VZSBXHl
 4cI1UpCm36gWBi8meg2FWJSvQA0Z8zzlgcKCqZoJPR2hs7H1X/EtcJJ/0dB0m7bnvVH/i8N81D
 3/AJRTfYNuC7xTgHyewTxjlVleQW+sE+UvQl1d4ODuOTxjcHc5NKccijK9aduLWF/p8SRrBJXB
 kwgvCxndNcyJElcupurgK00UeElAhXzpv+vUPuli7g3O3Rbsugj97kmMkQhq+KyP7x6ulJhU+X
 yG0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:21 -0700
IronPort-SDR: OwOKK/ps63b9rHoxGZD7VN8RD4j5Ga7nZKeeLbGKKULhoJqpYqdKbUZDXoBXRBvcJpoJVc9VUS
 u0+Qo5jxQSfB1FdTKz5JQgk92Nd4G6LZDwkH/YYpqtblHqijnJOqIObCIrCRmil44qTGea/qlK
 uw9m+BlXnfJPovhr8+Od2SKQhN6/ziSxVBJHWd00xuEvfqaKzKJk87bQaMViSJKFKHwFl9PQXw
 ILkWKUB8tHLAs8/JWHkNLDrE/aXil8YKJgjSxEIDslbg98f1L9vTf372BKFOjLEbhtVEuOCZ/F
 wJM=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:53 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 06/10] btrfs: zoned: reserve zones for an active metadata/system block group
Date:   Tue,  8 Aug 2023 01:12:36 +0900
Message-ID: <4e44439e8c082a2f9007a4d23506f0a7e38aa86b.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ensure a metadata and system block group can be activated on write time, by
leaving a certain number of active zones when trying to activate a data
block group.

Zones for two metadata block groups (normal and tree-log) and one system
block group are reserved, according to the profile type: two zones per
block group on the DUP profile and one zone per block group otherwise.

The reservation must be freed once a non-data block group is allocated. If
not, we over-reserve the active zones and data block group activation will
suffer. For the dynamic reservation count, we need to manage the
reservation count per device.

The reservation count variable is protected by
fs_info->zone_active_bgs_lock.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c |  2 +
 fs/btrfs/zoned.c   | 97 +++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h   |  9 +++++
 3 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index da51e5750443..471bc20e5397 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3456,6 +3456,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	btrfs_free_zone_cache(fs_info);
 
+	btrfs_check_active_zone_reservation(fs_info);
+
 	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
 	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fd1458049b18..c9a1732469fd 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1889,6 +1889,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	struct map_lookup *map;
 	struct btrfs_device *device;
 	u64 physical;
+	bool is_data = (block_group->flags & BTRFS_BLOCK_GROUP_DATA);
 	bool ret;
 	int i;
 
@@ -1910,19 +1911,40 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		goto out_unlock;
 	}
 
+	spin_lock(&fs_info->zone_active_bgs_lock);
 	for (i = 0; i < map->num_stripes; i++) {
+		struct btrfs_zoned_device_info *zinfo;
+		int reserved = 0;
+
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
+		zinfo = device->zone_info;
 
-		if (device->zone_info->max_active_zones == 0)
+		if (zinfo->max_active_zones == 0)
 			continue;
 
+		if (is_data)
+			reserved = zinfo->reserved_active_zones;
+		/*
+		 * For the data block group, leave active zones for one
+		 * metadata block group and one system block group.
+		 */
+		if (atomic_read(&zinfo->active_zones_left) <= reserved) {
+			ret = false;
+			spin_unlock(&fs_info->zone_active_bgs_lock);
+			goto out_unlock;
+		}
+
 		if (!btrfs_dev_set_active_zone(device, physical)) {
 			/* Cannot activate the zone */
 			ret = false;
+			spin_unlock(&fs_info->zone_active_bgs_lock);
 			goto out_unlock;
 		}
+		if (!is_data)
+			zinfo->reserved_active_zones--;
 	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
 
 	/* Successfully activated all the zones */
 	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
@@ -2068,18 +2090,21 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *device = map->stripes[i].dev;
 		const u64 physical = map->stripes[i].physical;
+		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 
-		if (device->zone_info->max_active_zones == 0)
+		if (zinfo->max_active_zones == 0)
 			continue;
 
 		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
 				       physical >> SECTOR_SHIFT,
-				       device->zone_info->zone_size >> SECTOR_SHIFT,
+				       zinfo->zone_size >> SECTOR_SHIFT,
 				       GFP_NOFS);
 
 		if (ret)
 			return ret;
 
+		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
+			zinfo->reserved_active_zones++;
 		btrfs_dev_clear_active_zone(device, physical);
 	}
 
@@ -2118,8 +2143,10 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 
 	/* Check if there is a device with active zones left */
 	mutex_lock(&fs_info->chunk_mutex);
+	spin_lock(&fs_info->zone_active_bgs_lock);
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
+		int reserved = 0;
 
 		if (!device->bdev)
 			continue;
@@ -2129,17 +2156,21 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 			break;
 		}
 
+		if (flags & BTRFS_BLOCK_GROUP_DATA)
+			reserved = zinfo->reserved_active_zones;
+
 		switch (flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		case 0: /* single */
-			ret = (atomic_read(&zinfo->active_zones_left) >= 1);
+			ret = (atomic_read(&zinfo->active_zones_left) >= (1 + reserved));
 			break;
 		case BTRFS_BLOCK_GROUP_DUP:
-			ret = (atomic_read(&zinfo->active_zones_left) >= 2);
+			ret = (atomic_read(&zinfo->active_zones_left) >= (2 + reserved));
 			break;
 		}
 		if (ret)
 			break;
 	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	if (!ret)
@@ -2386,3 +2417,59 @@ int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 
 	return 0;
 }
+
+/*
+ * Check if we properly activated one metadata block group and one
+ * system block group.
+ */
+void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_block_group *block_group;
+	struct btrfs_device *device;
+	/* Reserve zones for normal SINGLE metadata and tree-log block group. */
+	unsigned int metadata_reserve = 2;
+	/* Reserve a zone for SINGLE system block group. */
+	unsigned int system_reserve = 1;
+
+	/*
+	 * This function is called from the mount context. So, there
+	 * is no parallel process touching the bits. No need for
+	 * read_seqretry().
+	 */
+	if (fs_info->avail_metadata_alloc_bits & BTRFS_BLOCK_GROUP_DUP)
+		metadata_reserve = 4;
+	if (fs_info->avail_system_alloc_bits & BTRFS_BLOCK_GROUP_DUP)
+		system_reserve = 2;
+
+	/* Apply the reservation on all the devices. */
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (!device->bdev)
+			continue;
+
+		device->zone_info->reserved_active_zones =
+			metadata_reserve + system_reserve;
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	/* Release reservation for currently active block groups. */
+	spin_lock(&fs_info->zone_active_bgs_lock);
+	list_for_each_entry(block_group, &fs_info->zone_active_bgs,
+			    active_bg_list) {
+		struct map_lookup *map = block_group->physical_map;
+		int i;
+
+		if (!(block_group->flags &
+		      (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)))
+			continue;
+
+		for (i = 0; i < map->num_stripes; i++) {
+			struct btrfs_zoned_device_info *zinfo =
+				map->stripes[i].dev->zone_info;
+
+			zinfo->reserved_active_zones--;
+		}
+	}
+	spin_unlock(&fs_info->zone_active_bgs_lock);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 74ec37a25808..03e140018f29 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -22,6 +22,12 @@ struct btrfs_zoned_device_info {
 	u8  zone_size_shift;
 	u32 nr_zones;
 	unsigned int max_active_zones;
+	/*
+	 * Reserved active zones for one metadata and one system block
+	 * group. It can vary per-device depending of the allocation
+	 * status.
+	 */
+	int reserved_active_zones;
 	atomic_t active_zones_left;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
@@ -78,6 +84,7 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info, bool do_finish);
+void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -252,6 +259,8 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.41.0

