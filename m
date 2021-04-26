Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16336AC2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhDZG3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhDZG3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418501; x=1650954501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1bbY8I/2hypVGf5Ode6E+LRJwrvwQY2dcTWOw7/OAEk=;
  b=XFhdafAOXsr6TNh6cNwbZ+7mL+1tJdGkGKAxO8AxLJItLVG1rBxX/pVF
   Hf/lflDbXG32LAX1KNPGfSKSthx59oJ/LOg37r1qZk2ynUuO7qGW1A6hn
   54X55w1QeVoAey7ymFpVqIyLIuUzdJitSTjJ58t/THCpapdpvvl7O/+gi
   4q0/lOqrHpZbRf4XvNGHjL+XK9YdgODLedHrBaOW2ZQUg3JIYFZZcALSl
   CGUfku2EwTCOgsXgUNpXxxj+6MU4shFsfEYGtpTHJ63Jl7Rce4ZJ8WDIf
   Ul6mWOwMWSi/fnLGqjvIb26DQZ4Ss4t0lFuApCtQ7FG+VVC5MBRXzerZ4
   A==;
IronPort-SDR: 8H3SEPP12ckVu6BLSU09PiJKq5DyLjXnESchwtqY10VxlSeASs6Hrf8BdnGsLwVC8hqhYgeqwY
 GxDxSBCkd0mNoS+LLpy9f8sDNwoL1p7lRK4xW8qCTPzyDenFKyEqxFNqF+n0IduuJ8qhOxOLD4
 iaatzAFFwRuVN5GsM09Umj3Mq3TTCAJkbZF5YuVD73x6qOXaLIn6zZv+1PfGrxT1mvqhV2XQF6
 QI9bauS9YcrATsPkfp9iPx4f6xhPTHgkcV3sQ1h0ShRBUvxlT/7AsFs4piTIXEwq+4PAnmiG1r
 sXY=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788125"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:20 +0800
IronPort-SDR: qL0SBH+qrDkqA//qGEOX6qPf4WEf0HCeBcLO0/8iwqs22YNGN0AxzqTYgKzkQopCOipLD1Mjp6
 isg3mMKYlEYjkcJv9O3PLy2qev/K+eFfSvaqsP+Rplvgnse29OQeZ/jYOHTtxmSY5MlWeJIKyk
 tajrSe7OhXHJAaDs2diq8WXRCacJZxRCMz5oyehUUFl5xVt+lNWTrn5LFd4Zz0kzKgIr6as13q
 k/PWSJSj4wwqk3sy4gK2DwH6Ay780yl7uwC9S3z2cjDUuUT0kmkDgtqELepPyQj/VHGdGzdLrh
 KPt9v+F9HRtQkPkc/jKdbYu7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:45 -0700
IronPort-SDR: oou90oOZTL1wLAc55wjJ2aRl7a+u6PCElki0Xtjf8zPJQMmBAudAR43BSbD6+EyKWz4aAIbLoQ
 5wLuc29zYcOSs3Xt9pfZ5Ofu+NX4Su4q7tSgOE86f0LGppptgdYViqcWJ7NhIZphbwQGOmoXPp
 mkXzJuJOGjx56dKsaLpG3WoUs+6dcg5mkIml4HYy8L3ILQ9oiuNjXl1zLWaPLNZw8xNAcnzQlD
 GxnYg1K1EyZ8AJWbNrghsiBJISNttWCRJS3ibXWQfJOJ6uon0SjOmeuyFq/BiOJ5MeAhbqYkI+
 Q60=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/26] btrfs-progs: zoned: implement zoned chunk allocator
Date:   Mon, 26 Apr 2021 15:27:27 +0900
Message-Id: <b60a5f40ae0072ba9c7f1ba03036a703bb6b81ec.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Implement a zoned chunk and device extent allocator. One device zone
becomes a device extent so that a zone reset affects only this device
extent and does not change the state of blocks in the neighbor device
extents.

To implement the allocator, we need to extend the following functions for
a zoned filesystem.

- init_alloc_chunk_ctl
- dev_extent_search_start
- dev_extent_hole_check
- decide_stripe_size

Here, dev_extent_hole_check() is newly introduced to check the validity of
a hole found.

init_alloc_chunk_ctl_zoned() is mostly the same as regular one. It always
set the stripe_size to the zone size and aligns the parameters to the zone
size.

dev_extent_search_start() only aligns the start offset to zone boundaries.
We don't care about the first 1MB like in regular filesystem because we
anyway reserve the first two zones for superblock logging.

dev_extent_hole_check_zoned() checks if zones in given hole are either
conventional or empty sequential zones. Also, it skips zones reserved for
superblock logging.

With the change to the hole, the new hole may now contain pending extents.
So, in this case, loop again to check that.

Finally, decide_stripe_size_zoned() should shrink the number of devices
instead of stripe size because we need to honor stripe_size == zone_size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kerncompat.h            |   2 +
 kernel-shared/volumes.c | 143 ++++++++++++++++++++++++++++++++++++++--
 kernel-shared/volumes.h |   1 +
 kernel-shared/zoned.c   | 139 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/zoned.h   |  51 ++++++++++++++
 5 files changed, 332 insertions(+), 4 deletions(-)

diff --git a/kerncompat.h b/kerncompat.h
index d37edfe7fdac..c58e8a27430f 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -28,6 +28,7 @@
 #include <assert.h>
 #include <stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <stdint.h>
 
 #include <features.h>
@@ -358,6 +359,7 @@ do {					\
 
 /* Alignment check */
 #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
 
 static inline int is_power_of_2(unsigned long n)
 {
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 63530a99b41c..ecfc63265f35 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -162,6 +162,8 @@ struct alloc_chunk_ctl {
 	u64 max_chunk_size;
 	int total_devs;
 	u64 dev_offset;
+	int nparity;
+	int ncopies;
 };
 
 struct stripe {
@@ -457,6 +459,8 @@ int btrfs_scan_one_device(int fd, const char *path,
 
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 {
+	u64 zone_size;
+
 	switch (device->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		/*
@@ -465,11 +469,72 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 		 * make sure to start at an offset of at least 1MB.
 		 */
 		return max(start, BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		zone_size = device->zone_info->zone_size;
+		return ALIGN(max_t(u64, start, zone_size), zone_size);
 	default:
 		BUG();
 	}
 }
 
+static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
+					u64 *hole_start, u64 *hole_size,
+					u64 num_bytes)
+{
+	u64 zone_size = device->zone_info->zone_size;
+	u64 pos;
+	bool changed = false;
+
+	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+
+	while (*hole_size > 0) {
+		pos = btrfs_find_allocatable_zones(device, *hole_start,
+						   *hole_start + *hole_size,
+						   num_bytes);
+		if (pos != *hole_start) {
+			*hole_size = *hole_start + *hole_size - pos;
+			*hole_start = pos;
+			changed = true;
+			if (*hole_size < num_bytes)
+				break;
+		}
+
+		*hole_start += zone_size;
+		*hole_size -= zone_size;
+		changed = true;
+	}
+
+	return changed;
+}
+
+/**
+ * dev_extent_hole_check - check if specified hole is suitable for allocation
+ * @device:	the device which we have the hole
+ * @hole_start: starting position of the hole
+ * @hole_size:	the size of the hole
+ * @num_bytes:	the size of the free space that we need
+ *
+ * This function may modify @hole_start and @hole_size to reflect the suitable
+ * position for allocation. Returns true if hole position is updated, false
+ * otherwise.
+ */
+static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
+				  u64 *hole_size, u64 num_bytes)
+{
+	switch (device->fs_devices->chunk_alloc_policy) {
+	case BTRFS_CHUNK_ALLOC_REGULAR:
+		/* No check */
+		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return dev_extent_hole_check_zoned(device, hole_start,
+						   hole_size, num_bytes);
+	default:
+		BUG();
+	}
+
+	return false;
+}
+
 /*
  * find_free_dev_extent_start - find free space in the specified device
  * @device:	  the device which we search the free space in
@@ -507,6 +572,10 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int ret;
 	int slot;
 	struct extent_buffer *l;
+	u64 zone_size = 0;
+
+	if (device->zone_info)
+		zone_size = device->zone_info->zone_size;
 
 	search_start = dev_extent_search_start(device, search_start);
 
@@ -517,6 +586,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	max_hole_start = search_start;
 	max_hole_size = 0;
 
+again:
 	if (search_start >= search_end) {
 		ret = -ENOSPC;
 		goto out;
@@ -562,11 +632,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 		if (key.offset > search_start) {
 			hole_size = key.offset - search_start;
+			dev_extent_hole_check(device, &search_start, &hole_size,
+					      num_bytes);
 
-			/*
-			 * Have to check before we set max_hole_start, otherwise
-			 * we could end up sending back this offset anyway.
-			 */
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
 				max_hole_size = hole_size;
@@ -603,6 +671,12 @@ next:
 	 * search_end may be smaller than search_start.
 	 */
 	if (search_end > search_start) {
+		if (dev_extent_hole_check(device, &search_start, &hole_size,
+					  num_bytes)) {
+			btrfs_release_path(path);
+			goto again;
+		}
+
 		hole_size = search_end - search_start;
 
 		if (hole_size > max_hole_size) {
@@ -618,6 +692,7 @@ next:
 		ret = 0;
 
 out:
+	ASSERT(zone_size == 0 || IS_ALIGNED(max_hole_start, zone_size));
 	btrfs_free_path(path);
 	*start = max_hole_start;
 	if (len)
@@ -646,6 +721,11 @@ int btrfs_insert_dev_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 
+	/* Check alignment to zone for a zoned block device */
+	ASSERT(!device->zone_info ||
+	       device->zone_info->model != ZONED_HOST_MANAGED ||
+	       IS_ALIGNED(start, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -1052,6 +1132,38 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
 	ctl->max_chunk_size = min(percent_max, ctl->max_chunk_size);
 }
 
+static void init_alloc_chunk_ctl_policy_zoned(struct btrfs_fs_info *info,
+					      struct alloc_chunk_ctl *ctl)
+{
+	u64 type = ctl->type;
+	u64 zone_size = info->zone_size;
+	int min_num_stripes = ctl->min_stripes * ctl->num_stripes;
+	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
+	u64 min_chunk_size = min_data_stripes * zone_size;
+
+	ctl->stripe_size = zone_size;
+	ctl->min_stripe_size = zone_size;
+	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+			ctl->max_chunk_size = SZ_16M;
+			ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
+		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
+			ctl->max_chunk_size = 10ULL * SZ_1G;
+			ctl->max_stripes = BTRFS_MAX_DEVS(info);
+		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+			/* for larger filesystems, use larger metadata chunks */
+			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+				ctl->max_chunk_size = SZ_1G;
+			else
+				ctl->max_chunk_size = SZ_256M;
+			ctl->max_stripes = BTRFS_MAX_DEVS(info);
+		}
+	}
+
+	ctl->max_chunk_size = round_down(ctl->max_chunk_size, zone_size);
+	ctl->max_chunk_size = max(ctl->max_chunk_size, min_chunk_size);
+}
+
 static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 				 struct alloc_chunk_ctl *ctl)
 {
@@ -1066,11 +1178,16 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	ctl->max_chunk_size = 4 * ctl->stripe_size;
 	ctl->total_devs = btrfs_super_num_devices(info->super_copy);
 	ctl->dev_offset = 0;
+	ctl->nparity = btrfs_raid_array[type].nparity;
+	ctl->ncopies = btrfs_raid_array[type].ncopies;
 
 	switch (info->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(info, ctl);
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		init_alloc_chunk_ctl_policy_zoned(info, ctl);
+		break;
 	default:
 		BUG();
 	}
@@ -1113,12 +1230,27 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 	return 0;
 }
 
+static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl)
+{
+	if (chunk_bytes_by_type(ctl) > ctl->max_chunk_size) {
+		/* stripe_size is fixed in ZONED. Reduce num_stripes instead. */
+		ctl->num_stripes = ctl->max_chunk_size * ctl->ncopies /
+			ctl->stripe_size;
+		if (ctl->num_stripes < ctl->min_stripes)
+			return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int decide_stripe_size(struct btrfs_fs_info *info,
 			      struct alloc_chunk_ctl *ctl)
 {
 	switch (info->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return decide_stripe_size_regular(ctl);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return decide_stripe_size_zoned(ctl);
 	default:
 		BUG();
 	}
@@ -1140,6 +1272,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	int index;
 	struct btrfs_key key;
 	u64 offset;
+	u64 zone_size = info->zone_size;
 
 	if (!ctl->start) {
 		ret = find_next_chunk(info, &offset);
@@ -1192,6 +1325,8 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 			BUG_ON(ret);
 		}
 
+		ASSERT(!zone_size || IS_ALIGNED(dev_offset, zone_size));
+
 		device->bytes_used += ctl->stripe_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index a64288d566d8..5a85a6c0bc6f 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -74,6 +74,7 @@ struct btrfs_device {
 
 enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
+	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
 struct btrfs_fs_devices {
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 1b235dc0a1c9..e828d633619a 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -512,6 +512,144 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	return ret_sz;
 }
 
+/*
+ * btrfs_check_allocatable_zones - check if spcecifeid region is
+ *                                 suitable for allocation
+ * @device:	the device to allocate a region
+ * @pos:	the position of the region
+ * @num_bytes:	the size of the region
+ *
+ * In non-ZONED device, anywhere is suitable for allocation. In ZONED
+ * device, check if
+ * 1) the region is not on non-empty sequential zones,
+ * 2) all zones in the region have the same zone type,
+ * 3) it does not contain super block location
+ */
+bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
+				   u64 num_bytes)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u64 nzones, begin, end;
+	u64 sb_pos;
+	bool is_sequential;
+	int shift;
+	int i;
+
+	if (!zinfo || zinfo->model == ZONED_NONE)
+		return true;
+
+	nzones = num_bytes / zinfo->zone_size;
+	begin = pos / zinfo->zone_size;
+	end = begin + nzones;
+
+	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+
+	if (end > zinfo->nr_zones)
+		return false;
+
+	shift = ilog2(zinfo->zone_size);
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		sb_pos = sb_zone_number(shift, i);
+		if (!(end < sb_pos || sb_pos + 1 < begin))
+			return false;
+	}
+
+	is_sequential = btrfs_dev_is_sequential(device, pos);
+
+	while (num_bytes) {
+		if (is_sequential && !btrfs_dev_is_empty_zone(device, pos))
+			return false;
+		if (is_sequential != btrfs_dev_is_sequential(device, pos))
+			return false;
+
+		pos += zinfo->zone_size;
+		num_bytes -= zinfo->zone_size;
+	}
+
+	return true;
+}
+
+/**
+ * btrfs_find_allocatable_zones - find allocatable zones within a given region
+ *
+ * @device:	the device to allocate a region on
+ * @hole_start: the position of the hole to allocate the region
+ * @num_bytes:	size of wanted region
+ * @hole_end:	the end of the hole
+ * @return:	position of allocatable zones
+ *
+ * Allocatable region should not contain any superblock locations.
+ */
+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
+				 u64 hole_end, u64 num_bytes)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	int shift = ilog2(zinfo->zone_size);
+	u64 nzones = num_bytes >> shift;
+	u64 pos = hole_start;
+	u64 begin, end;
+	bool is_sequential;
+	bool have_sb;
+	int i;
+
+	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+
+	while (pos < hole_end) {
+		begin = pos >> shift;
+		end = begin + nzones;
+
+		if (end > zinfo->nr_zones)
+			return hole_end;
+
+		/*
+		 * The zones must be all sequential (and empty), or
+		 * conventional zones
+		 */
+		is_sequential = btrfs_dev_is_sequential(device, pos);
+		for (i = 0; i < end - begin; i++) {
+			u64 zone_offset = pos + ((u64)i << shift);
+
+			if ((is_sequential &&
+			     !btrfs_dev_is_empty_zone(device, zone_offset)) ||
+			    (is_sequential !=
+			     btrfs_dev_is_sequential(device, zone_offset))) {
+				pos += zinfo->zone_size;
+				continue;
+			}
+		}
+
+		have_sb = false;
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			u32 sb_zone;
+			u64 sb_pos;
+
+			sb_zone = sb_zone_number(shift, i);
+			if (!(end <= sb_zone ||
+			      sb_zone + BTRFS_NR_SB_LOG_ZONES <= begin)) {
+				have_sb = true;
+				pos = ((u64)sb_zone + BTRFS_NR_SB_LOG_ZONES) << shift;
+				break;
+			}
+
+			/* We also need to exclude regular superblock positions */
+			sb_pos = btrfs_sb_offset(i);
+			if (!(pos + num_bytes <= sb_pos ||
+			      sb_pos + BTRFS_SUPER_INFO_SIZE <= pos)) {
+				have_sb = true;
+				pos = ALIGN(sb_pos + BTRFS_SUPER_INFO_SIZE,
+					    zinfo->zone_size);
+				break;
+			}
+		}
+		if (!have_sb)
+			break;
+	}
+
+	return pos;
+}
+
 #endif
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
@@ -691,6 +829,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 out:
 	return ret;
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 82e3096eab8a..29c203f45ada 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -7,6 +7,7 @@
 
 #include <stdbool.h>
 #include "kerncompat.h"
+#include "kernel-shared/volumes.h"
 
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
@@ -56,7 +57,34 @@ static inline size_t sbwrite(int fd, void *buf, off_t offset)
 {
 	return btrfs_sb_io(fd, buf, offset, WRITE);
 }
+
+static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
+				      u64 bytenr)
+{
+	unsigned int zno;
+
+	if (!zinfo || zinfo->model == ZONED_NONE)
+		return false;
+
+	zno = bytenr / zinfo->zone_size;
+	return zinfo->zones[zno].type == BLK_ZONE_TYPE_SEQWRITE_REQ;
+}
+
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	unsigned int zno;
+
+	if (!zone_is_sequential(zinfo, pos))
+		return true;
+
+	zno = pos / zinfo->zone_size;
+	return zinfo->zones[zno].cond == BLK_ZONE_COND_EMPTY;
+}
+
 int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
+				 u64 hole_end, u64 num_bytes);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -68,6 +96,29 @@ static inline int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
 	return 0;
 }
 
+static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
+				      u64 bytenr)
+{
+	return false;
+}
+
+static inline u64 btrfs_find_allocatable_zones(struct btrfs_device *device,
+					       u64 hole_start, u64 hole_end,
+					       u64 num_bytes)
+{
+	return hole_start;
+}
+
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	return true;
+}
+
 #endif /* BTRFS_ZONED */
 
+static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	return zone_is_sequential(device->zone_info, pos);
+}
+
 #endif /* __BTRFS_ZONED_H__ */
-- 
2.31.1

