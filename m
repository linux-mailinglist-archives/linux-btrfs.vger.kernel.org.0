Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E671E36AC2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhDZG3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhDZG3D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418502; x=1650954502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=815W11zYf3RRQCcQUxj1SXGqRFUWYkBCGH6U2OMgS6I=;
  b=JLblOSP5T24zXj2o4HnsY0CBo+8I1scswPg+S2tQG4TQDohD5+nF0nfE
   Hqyr0fI7ae+DKC0JkkebHvaUxBwS/ejfQebIeTKq93bzeL+eimixlnzxQ
   VM0v160nmJqr0dJVuDJ8DCPrkwdXGdMXCXpNyxxRXQtBoCJgSvofydqca
   ZyovHl5n/29PlL+uieEcO0Ded2pzTXF/5ePiUOy5B4F3GH++Z4kBpGl6Z
   pxf/PXIoCojca6waaCybTW+Nlk0PZsV812G8yM9DbCASe7hh+c0/DBSkr
   Wh9qO0QBWoOFrjzPhUDhqRyhXybJJENO6BArwogoxIRcxm2s0XOWLKuQ7
   g==;
IronPort-SDR: pLtDTHDoCaKrRuQPZhdymL+L1jhLcw+cIXKsXugRJj6Fupv/g0/0nyDNldjvL10g39Hz4aZijs
 BBzasivN75yXc74vVOuWYBfNPI5SLnOYdvEgXKPmJBPOcjkSsZiqiANASjeO/h+z/N2Nk15Wp5
 xOKCOMdn6I8aSTIvXOt0an2F4tKRVCIc09O+HWL6heNL3K8yGn4wAoBSTXCN3l4RMj0YcvE/GV
 7wp+ks4TMFSPb6KVT5V9vl3DQZTxWY3mFCdc15PqJ1hkCHLKOOb8TcK9ovOL25RDj4W/5FRKKW
 s/Y=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788126"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:22 +0800
IronPort-SDR: +L5dgeRo6P3QhtT4Ew9bqjOSBe4+gcMKCF6cgG82bRfmIqDHOsijIUt39HYArjQRE46YsJMdl/
 hq6QxLNXB4iR3WfCT5IOB6ZTU2RR4Ccf6uJ2iayT3V0AVFDmLVF1mB4eJqO/fp4HMiMePm/+Fl
 YpIGggeJs7vHcj35TjVGsItDkuNSYMBKhE84wc2+u2x14b4w24BH56OX2P9mfGTJL9NPr9ynce
 M9ihLWrxN1G5s/PGJSpdt36GXZY1o6OQtHSM3bigUWHCnwOJb9IbKFhoFfXR5s/yMlgVxKOABb
 UfaMpTns/m3wIfG1OFhYELzE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:46 -0700
IronPort-SDR: SJ/y91c6/zHyhSaaUNBMx1WzG0OSeD/1zBlfM/KCEHnh752Nd0g7ZI3U3rOiEiKDDKCezfP8e+
 D/ZK2oDEC9q04no0LsoNJE5drOBdK8Iz2ajTC61H3Uw9/zx5D5547LVq9ggKgZlqE8vjULxyFR
 UIikzGQLr/p1/12+PI8RYQUb1nxjZb60CreAsDjljvZKZffs4CEAvZFuR/CbgIhGDzS/q2R6YR
 acg/FsppLJmKM5T9O+KYZmpdmh/P0Pcj9H5Dk+1GAz6EQ1KIJXDnvUCbKvfoSiq1VS0rBtL1Pt
 EVI=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/26] btrfs-progs: zoned: load zone's allocation offset
Date:   Mon, 26 Apr 2021 15:27:28 +0900
Message-Id: <545865d98227b802f24a39393f9297c6d7799c6a.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A zoned filesystem must allocate blocks at the zones' write pointer. The
device's write pointer position can be mapped to a logical address within a
block group. To facilitate this, add an "alloc_offset" to the block-group
to track the logical addresses of the write pointer.

This logical address is populated in btrfs_load_block_group_zone_info()
from the write pointers of corresponding zones.

For now, zoned filesystems the single profile. Supporting non-single
profile with zone append writing is not trivial. For example, in the DUP
profile, we send a zone append writing IO to two zones on a device. The
device reply with written LBAs for the IOs. If the offsets of the returned
addresses from the beginning of the zone are different, then it results in
different logical addresses.

We need fine-grained logical to physical mapping to support such separated
physical address issue. Since it should require additional metadata type,
disable non-single profiles for now.

This commit supports the case all the zones in a block group are
sequential. The next patch will handle the case having a conventional zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h       |   6 ++
 kernel-shared/extent-tree.c |   8 +++
 kernel-shared/zoned.c       | 133 ++++++++++++++++++++++++++++++++++++
 kernel-shared/zoned.h       |   8 +++
 4 files changed, 155 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5023db474784..a68c8bd38bd2 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1134,6 +1134,12 @@ struct btrfs_block_group {
 
 	/* For dirty block groups */
 	struct list_head dirty_list;
+
+	/*
+	 * Allocation offset for the block group to implement sequential
+	 * allocation. This is used only with ZONED mode enabled.
+	 */
+	u64 alloc_offset;
 };
 
 struct btrfs_device;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5b1fbe10283a..ec5ea9a8e090 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -31,6 +31,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/free-space-cache.h"
 #include "kernel-shared/free-space-tree.h"
+#include "kernel-shared/zoned.h"
 #include "common/utils.h"
 
 #define PENDING_EXTENT_INSERT 0
@@ -2704,6 +2705,10 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	}
 	cache->space_info = space_info;
 
+	ret = btrfs_load_block_group_zone_info(fs_info, cache);
+	if (ret)
+		return ret;
+
 	btrfs_add_block_group_cache(fs_info, cache);
 	return 0;
 }
@@ -2761,6 +2766,9 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->start = chunk_offset;
 	cache->length = size;
 
+	ret = btrfs_load_block_group_zone_info(fs_info, cache);
+	BUG_ON(ret);
+
 	cache->used = bytes_used;
 	cache->flags = type;
 	INIT_LIST_HEAD(&cache->dirty_list);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index e828d633619a..8b51115e667f 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -14,6 +14,10 @@
 
 /* Maximum number of zones to report per ioctl(BLKREPORTZONE) call */
 #define BTRFS_REPORT_NR_ZONES   4096
+/* Invalid allocation pointer value for missing devices */
+#define WP_MISSING_DEV ((u64)-1)
+/* Pseudo write pointer value for conventional zone */
+#define WP_CONVENTIONAL ((u64)-2)
 
 /*
  * Location of the first zone of superblock logging zone pairs.
@@ -650,6 +654,135 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 	return pos;
 }
 
+int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group *cache)
+{
+	struct btrfs_device *device;
+	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct cache_extent *ce;
+	struct map_lookup *map;
+	u64 logical = cache->start;
+	u64 length = cache->length;
+	u64 physical = 0;
+	int ret = 0;
+	int i;
+	u64 *alloc_offsets = NULL;
+	u32 num_sequential = 0, num_conventional = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	/* Sanity check */
+	if (logical == BTRFS_BLOCK_RESERVED_1M_FOR_SUPER) {
+		if (length + SZ_1M != fs_info->zone_size) {
+			error("zoned: unaligned initial system block group");
+			return -EIO;
+		}
+	} else if (!IS_ALIGNED(length, fs_info->zone_size)) {
+		error("zoned: unaligned block group at %llu + %llu", logical,
+		      length);
+		return -EIO;
+	}
+
+	/* Get the chunk mapping */
+	ce = search_cache_extent(&map_tree->cache_tree, logical);
+	if (!ce) {
+		error("zoned: failed to find block group at %llu", logical);
+		return -ENOENT;
+	}
+	map = container_of(ce, struct map_lookup, ce);
+
+	alloc_offsets = calloc(map->num_stripes, sizeof(*alloc_offsets));
+	if (!alloc_offsets) {
+		error("zoned: failed to allocate alloc_offsets");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < map->num_stripes; i++) {
+		bool is_sequential;
+		struct blk_zone zone;
+
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
+
+		if (device->fd == -1) {
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		}
+
+		is_sequential = btrfs_dev_is_sequential(device, physical);
+		if (is_sequential)
+			num_sequential++;
+		else
+			num_conventional++;
+
+		if (!is_sequential) {
+			alloc_offsets[i] = WP_CONVENTIONAL;
+			continue;
+		}
+
+		/*
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
+		zone = device->zone_info->zones[physical / fs_info->zone_size];
+
+		switch (zone.cond) {
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+			error(
+		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
+			      physical / fs_info->zone_size, device->name,
+			      device->devid);
+			alloc_offsets[i] = WP_MISSING_DEV;
+			break;
+		case BLK_ZONE_COND_EMPTY:
+			alloc_offsets[i] = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+			alloc_offsets[i] = fs_info->zone_size;
+			break;
+		default:
+			/* Partially used zone */
+			alloc_offsets[i] =
+					((zone.wp - zone.start) << SECTOR_SHIFT);
+			break;
+		}
+	}
+
+	if (num_conventional > 0) {
+		/*
+		 * Since conventional zones do not have a write pointer, we
+		 * cannot determine alloc_offset from the pointer
+		 */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+		cache->alloc_offset = alloc_offsets[0];
+		break;
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID0:
+	case BTRFS_BLOCK_GROUP_RAID10:
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* non-single profiles are not supported yet */
+	default:
+		error("zoned: profile %s not yet supported",
+		      btrfs_group_profile_str(map->type));
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	free(alloc_offsets);
+	return ret;
+}
+
 #endif
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 29c203f45ada..45d77c8daa69 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -85,6 +85,8 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
+int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group *cache);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -114,6 +116,12 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	return true;
 }
 
+static inline int btrfs_load_block_group_zone_info(
+	struct btrfs_fs_info *fs_info, struct btrfs_block_group *cache)
+{
+	return 0;
+}
+
 #endif /* BTRFS_ZONED */
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

