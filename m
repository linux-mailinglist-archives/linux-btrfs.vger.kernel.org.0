Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43B63E9390
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhHKOVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 10:21:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64262 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhHKOVZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 10:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628691662; x=1660227662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8w4RAOjUPA20HScXK3Yt59VVSfPX0uMg0+X+awM1CjY=;
  b=G0ar5I2xkAjpA/0PfrQPe3K3YIpu2mwEOex262e8GtnVHa8xa/wAsP5j
   R97AncCQuZ6qbrg19VKgs7oivrx+fbzvepZPO4H4cpNj5K4WmIZRJlhPL
   zWqrkDcRg5ZafABodBvsp4V0PbStj9Rvh0/38jEr64Hc6sm+4fqnTp1Fc
   /KIqq9Db7UgUQejh3WbqyumnWhk2Yv2riwUIclwrXkpXyJJG/+IUN9yf7
   i1d04nfal8nsD6uiKFOnoueajeDrSlbqCO+BP2HSLxqkeZBCp1wfGO+A6
   asqKf8cOuuJNq6zvB33TFR++Djxrwla2bIxuiW+ohvAXaBd6XX3a9+8wy
   g==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="288506682"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 22:21:02 +0800
IronPort-SDR: L/uxX8YFl+X6M4cVO6ezdq2bfaCAZoEdynoQO3O1JmSlRohvbIR+Da42BjrRtFSiBVwLcsqxeO
 LGNul078h1ORhiA/5WZOGQEhIPj25TMxPg/nfoRob6He9m/NpkJNoxh4mTM5gREj8ADqxT2xl7
 3nKcxntwuWyjpbGasVPWPAmf9UtLRFGCx/1dw3IAufTd4ZE7LEOfjStx5cLnTdc/BZJ81WDTtT
 x5FM6+s2TgtQ/r+0ifor6rsJY99eqTIlEH0H03kfI5ZcPYt04Lr8bZoXA6tSyKyzWnJUlEYj74
 lk1hP2WgyX9lRlSTH/iWQ1p1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:56:32 -0700
IronPort-SDR: /nzF8WDgotykZS466CLiYMtHCbeMuePed09il8f6TQTkzeSUUoS1g2CJ/bP+sKYFN2D6hTTPep
 znJmwDCZb7JhEVzQa6JAHHvyv6XnvhtqWRB0rtUgjV6RDy1j6EMq0Zk/zEfB9g7YEI2hl2eSZn
 Tu/Zn8foTyPNgTGYCkDCRy5+uLufxkRTIDQwuBMk+o1CNVfG2kFrPR8xwNxBxhiPWUPgKxK8wL
 dI7xCDX1grPXDUrNdIwEsVcpdGL3SzFD+fQZMpOHD6tt99rph35wXQLtCsUKJvZtf2sfM1J537
 Hw8=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Aug 2021 07:21:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 15/17] btrfs: zoned: avoid chunk allocation if active block group has enough space
Date:   Wed, 11 Aug 2021 23:16:39 +0900
Message-Id: <088da5a824e90055b7171b4c47e7c42d073c050d.1628690222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628690222.git.naohiro.aota@wdc.com>
References: <cover.1628690222.git.naohiro.aota@wdc.com>
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
index f3c31159fb2e..850662d103e9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1865,3 +1865,35 @@ int btrfs_zone_finish(struct btrfs_block_group *block_group)
 
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
2.32.0

