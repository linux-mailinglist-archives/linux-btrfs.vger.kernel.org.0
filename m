Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1029E3F1932
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhHSM2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46903 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbhHSM2A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376044; x=1660912044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cj6mvTNy0HkoJyN6EDUTxpktbYOs0GV/xjub79eZZfM=;
  b=NW2x/TVEf24zVpk0Uco9JGIXI0VCJkgj5WJNFcZEdzRS7a3UYO5cb+Z0
   AO5GLKzIef7yqgHt/uHS88tZOiazuBgPuCFEtIP/sHr5uyb5mNoq+LwQE
   nojGqKgiNcld9MOZ8cKB8PvgBt+iXwpHJHK2/L9+J5PdWNm31ddyffF85
   tIMrzVdPbARZ1x83o3YQfj2yGdJAx8L9OPRCje6w/+kjUkGMxgdf2Zwkm
   PDEc54I++t8NRS+rMoCnWCRuMLSIBDIYA/F+Vnf9MfGYUZnqD89svU5RN
   12PAxnb/m9d6v9ynzMhEUORcnuBod7J0jKwfPmpsb0K33IO5FKo2ubW4f
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773629"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:23 +0800
IronPort-SDR: IzbT9km28V4WjstqPNhsiwv4X/fWqlwy2PFaaxBFvRRaG4E+miIWwlkf3Wmk0QVPZdadr2Sr6N
 lVVP7FyHROgudxsMcE3Qx/LDIokwdZpJ/fXWChe62stSj4Ytn15iKjDy1tOixDZtuyk3WHTwu7
 JpfEC0JB/ZSg5WVnXZ87rm+ItTW9Ef4dRbfnFwnmoQjIh/pHDUTFwlOY8ovyMMGjjNCuMGuYIU
 EGC/DKkwZUJ9vOEa6MJgnyDN2j02JZwr5aPpPxJ8aK+zwF9ACKmEY6C9CWSeon8M6vGwr8TRqn
 MBh7nW1eBo9gPk2KMWcsWcQP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:31 -0700
IronPort-SDR: laQiiwnxQajqwjQW1akqUmP9VcknluBy1bssuYaUCKAnPnPCluya4IcMD3GVtdr4uYSmSB7SRA
 q8X3Iqa44fLQ35Y7281X5nplWw99MrdnY989Mr4sP9yFifhGcTOVXO6brvswtJGWzkvlGnq/OO
 Gw5A5MD2YcpQX2OA9a7k4GYatZ7ecqpcCqZYCID0lO166T2cmhrILZQzXBJkhXW9pkHqFXGNWw
 4YrAoY+lCz2A3vMHrQT+60Ql61E5Os2tog98ij41OuQIT5crvLpNZsDwwxz/2eAhXgkR/e+yLX
 k/A=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 15/17] btrfs: zoned: avoid chunk allocation if active block group has enough space
Date:   Thu, 19 Aug 2021 21:19:22 +0900
Message-Id: <e084ccec159d9e5b1e4015b46cc09c7876e2fa30.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current extent allocator tries to allocate a new block group when the
existing block groups do not have enough space. On a ZNS device, a new
block group means a new active zone. If the number of active zones has
already reached the max_active_zones, activating a new zone needs to finish
an existing zone, leading to wasting the free space there.

So, instead, it should reuse the existing active block groups as much as
possible when we can't activate any other zones without sacrificing an
already activated block group.

While at it, I converted find_free_extent_update_loop() to check the
found_extent() case early and made the other conditions simpler.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 27 ++++++++++++++++++++-------
 fs/btrfs/zoned.c       | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  8 ++++++++
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1daa432673c4..b11097f557f8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3478,6 +3478,7 @@ struct find_free_extent_ctl {
 	/* Basic allocation info */
 	u64 ram_bytes;
 	u64 num_bytes;
+	u64 min_alloc_size;
 	u64 empty_size;
 	u64 flags;
 	int delalloc;
@@ -3946,18 +3947,29 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	    ffe_ctl->have_caching_bg && !ffe_ctl->orig_have_caching_bg)
 		ffe_ctl->orig_have_caching_bg = true;
 
-	if (!ins->objectid && ffe_ctl->loop >= LOOP_CACHING_WAIT &&
-	    ffe_ctl->have_caching_bg)
-		return 1;
-
-	if (!ins->objectid && ++(ffe_ctl->index) < BTRFS_NR_RAID_TYPES)
-		return 1;
-
 	if (ins->objectid) {
 		found_extent(ffe_ctl, ins);
 		return 0;
 	}
 
+	if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size &&
+	    !btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->index)) {
+		/*
+		 * If we have enough free space left in an already active
+		 * block group and we can't activate any other zone now,
+		 * retry the active ones with a smaller allocation size.
+		 * Returning early from here will tell
+		 * btrfs_reserve_extent() to haven the size.
+		 */
+		return -ENOSPC;
+	}
+
+	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
+		return 1;
+
+	if (++(ffe_ctl->index) < BTRFS_NR_RAID_TYPES)
+		return 1;
+
 	/*
 	 * LOOP_CACHING_NOWAIT, search partially cached block groups, kicking
 	 *			caching kthreads as we move along
@@ -4434,6 +4446,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 	ffe_ctl.ram_bytes = ram_bytes;
 	ffe_ctl.num_bytes = num_bytes;
+	ffe_ctl.min_alloc_size = min_alloc_size;
 	ffe_ctl.empty_size = empty_size;
 	ffe_ctl.flags = flags;
 	ffe_ctl.delalloc = delalloc;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 441cdd4c507f..74f98d38abcc 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1878,3 +1878,35 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 
 	return ret;
 }
+
+bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
+			     int raid_index)
+{
+	struct btrfs_device *device;
+	bool ret = false;
+
+	if (!btrfs_is_zoned(fs_devices->fs_info))
+		return true;
+
+	/* Non-single profiles are not supported yet */
+	if (raid_index != BTRFS_RAID_SINGLE)
+		return false;
+
+	/* Check if there is a device with active zones left */
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		struct btrfs_zoned_device_info *zinfo = device->zone_info;
+
+		if (!device->bdev)
+			continue;
+
+		if (!zinfo->max_active_zones ||
+		    atomic_read(&zinfo->active_zones_left)) {
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 2345ecfa1805..ade6588c4ccd 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -71,6 +71,8 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
 bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
+bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
+			     int raid_index);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -216,6 +218,12 @@ static inline int btrfs_zone_finish(struct btrfs_block_group *block_group)
 	return 0;
 }
 
+static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
+					   int raid_index)
+{
+	return true;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.33.0

