Return-Path: <linux-btrfs+bounces-9633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7161F9C848D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 09:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80321F212B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DEC1F7091;
	Thu, 14 Nov 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XQuRrZoq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7D1F6686
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571488; cv=none; b=s4imYc6b6UrKTGYNddnGhzDhOPhg92f+MV0Yctxd3GHXXtJPiJYHu2mwjClUGQFlV3owCaxCdQ3adXQXSSim2GGYQUsiWmGIgABN/vVqhvHF5rfFXfphYK7tTuK1XM8ZVzze69y+8iwgmPcuDYMkRNY4TVTpCq91HoYn2MxsnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571488; c=relaxed/simple;
	bh=/qKspSoNrijAjosztYEfSEVwQ6+wchTrIuHCfl+DERk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcCnUX26u/BjoMccHg7BNcx4gsjEKmq8bA9k811dtYnFCliJBTphpyss9452EW/btsqbki89SSoAVwTFrgafoXW3AdjLLxfm5ckC0KwMtxXx9NSNkqE6HqV3fMMnXmSdkSP/6c3L9xbbNCL74KblM0IBFtZu5D39rPc9e1uBOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XQuRrZoq; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731571487; x=1763107487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qKspSoNrijAjosztYEfSEVwQ6+wchTrIuHCfl+DERk=;
  b=XQuRrZoq7LsjUJHHjNepMO32bPKLKDWq2F67aVTsluSS7m8yFaptBFxU
   gObReF24youZ1t2nj/ysv6jcPo2kEpdr2lfxQlBO53Wz2kkVyWeunKDRi
   kDsBh3Ophi70n5epHs9+CiLfe/loSR0O5fzXJxcZZSdr8NvWrybMTGFU9
   uJGbOq7wRzOTviWHZOt65m7mXi7ZCeo5CIijkEKjTbq2hfqYky9CFNd1b
   0huruaJbSjEXldgl1pvne2Bm6K8eU7HgT4falsmjhDs76YZVKQ6OFdNks
   DQAicPZ6BcDrIO1zvU5/Dzgo8tL/HEiXWMj72nz/n+RtO8ThYGlxGBj2o
   w==;
X-CSE-ConnectionGUID: FEDbaTLaTs+Qys0my561tg==
X-CSE-MsgGUID: 6jJcHgGSQOWcBBaB5BjHXA==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="31543764"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 16:04:45 +0800
IronPort-SDR: 6735a1db_HcLGGzyyHTrta7pcgAFcrRVNcuEBbX5wG75I2kZB5aR6CH6
 3i2e8z5lkXcspMiIStA6MF/dr3Vx6W6dAp2K9KQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 23:08:12 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2024 00:04:43 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Date: Thu, 14 Nov 2024 17:04:29 +0900
Message-ID: <a452ed2c524c5b67aa7523ae5130d35fbef2207e.1731571240.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731571240.git.naohiro.aota@wdc.com>
References: <cover.1731571240.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the zoned mode, once used and freed region is still not reusable after the
freeing. The underlying zone needs to be reset before reusing. Btrfs resets a
zone when it removes a block group, and then new block group is allocated on
the zones to reuse the zones. But, it is sometime too late to catch up with a
write side.

This commit introduces a new space-info reclaim method ZONE_RESET. That will
pick a block group from the unused list and reset its zone to reuse the
zone_unusable space. It is faster than removing the block group and re-creating
a new block group on the same zones.

For the first implementation, the ZONE_RESET is only applied to a block group
whose region is fully zone_unusable. Reclaiming partial zone_unusable block
group could be implemented later.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c        |  28 +++++++-
 fs/btrfs/space-info.h        |   5 ++
 fs/btrfs/zoned.c             | 124 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h             |   7 ++
 include/trace/events/btrfs.h |   3 +-
 5 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7b3c514eb6f9..981da9e1b009 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -14,6 +14,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "zoned.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
@@ -127,6 +128,14 @@
  *     churn a lot and we can avoid making some extent tree modifications if we
  *     are able to delay for as long as possible.
  *
+ *   RESET_ZONES
+ *     This state works only for the zoned mode. On the zoned mode, we cannot
+ *     reuse once allocated then freed region until we reset the zone, due to
+ *     the sequential write zone requirement. The RESET_ZONES state resets the
+ *     zones of an unused block group and let btrfs reuse the space. The reusing
+ *     is faster than removing the block group and allocating another block
+ *     group on the zones.
+ *
  *   ALLOC_CHUNK
  *     We will skip this the first time through space reservation, because of
  *     overcommit and we don't want to have a lot of useless metadata space when
@@ -832,6 +841,9 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		 */
 		ret = btrfs_commit_current_transaction(root);
 		break;
+	case RESET_ZONES:
+		ret = btrfs_reset_unused_block_groups(space_info, num_bytes);
+		break;
 	default:
 		ret = -ENOSPC;
 		break;
@@ -1084,9 +1096,14 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	enum btrfs_flush_state flush_state;
 	int commit_cycles = 0;
 	u64 last_tickets_id;
+	enum btrfs_flush_state final_state;
 
 	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	if (btrfs_is_zoned(fs_info))
+		final_state = RESET_ZONES;
+	else
+		final_state = COMMIT_TRANS;
 
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
@@ -1139,7 +1156,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 		if (flush_state == ALLOC_CHUNK_FORCE && !commit_cycles)
 			flush_state++;
 
-		if (flush_state > COMMIT_TRANS) {
+		if (flush_state > final_state) {
 			commit_cycles++;
 			if (commit_cycles > 2) {
 				if (maybe_fail_all_tickets(fs_info, space_info)) {
@@ -1153,7 +1170,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 			}
 		}
 		spin_unlock(&space_info->lock);
-	} while (flush_state <= COMMIT_TRANS);
+	} while (flush_state <= final_state);
 }
 
 /*
@@ -1284,6 +1301,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
  *   This is where we reclaim all of the pinned space generated by running the
  *   iputs
  *
+ * RESET_ZONES
+ *   This state works only for the zoned mode. We scan the unused block
+ *   group list and reset the zones and reuse the block group.
+ *
  * ALLOC_CHUNK_FORCE
  *   For data we start with alloc chunk force, however we could have been full
  *   before, and then the transaction commit could have freed new block groups,
@@ -1293,6 +1314,7 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_FULL,
 	RUN_DELAYED_IPUTS,
 	COMMIT_TRANS,
+	RESET_ZONES,
 	ALLOC_CHUNK_FORCE,
 };
 
@@ -1384,6 +1406,7 @@ void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
 static const enum btrfs_flush_state priority_flush_states[] = {
 	FLUSH_DELAYED_ITEMS_NR,
 	FLUSH_DELAYED_ITEMS,
+	RESET_ZONES,
 	ALLOC_CHUNK,
 };
 
@@ -1397,6 +1420,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	FLUSH_DELALLOC_FULL,
 	ALLOC_CHUNK,
 	COMMIT_TRANS,
+	RESET_ZONES,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 69071afc0d47..a96efdb5e681 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -79,6 +79,10 @@ enum btrfs_reserve_flush_enum {
 	BTRFS_RESERVE_FLUSH_EMERGENCY,
 };
 
+/*
+ * Please be aware that the order of enum values will be the order of the reclaim
+ * process in btrfs_async_reclaim_metadata_space().
+ */
 enum btrfs_flush_state {
 	FLUSH_DELAYED_ITEMS_NR	= 1,
 	FLUSH_DELAYED_ITEMS	= 2,
@@ -91,6 +95,7 @@ enum btrfs_flush_state {
 	ALLOC_CHUNK_FORCE	= 9,
 	RUN_DELAYED_IPUTS	= 10,
 	COMMIT_TRANS		= 11,
+	RESET_ZONES		= 12,
 };
 
 struct btrfs_space_info {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index cb32966380f5..a294617dc25d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2648,3 +2648,127 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
+
+/*
+ * Reset the zones of unused block groups from @space_info->bytes_zone_unusable.
+ *
+ * This one resets the zones of a block group, so we can reuse the region
+ * without removing the block group. On the other hand, btrfs_delete_unused_bgs()
+ * just removes a block group and frees up the underlying zones. So, we still
+ * need to allocate a new block group to reuse the zones.
+ *
+ * Resetting is faster than deleting/recreating a block group. It is similar
+ * to freeing the logical space on the regular mode. However, we cannot change
+ * the block group's profile with this operation.
+ *
+ * @space_info:	the space to work on
+ * @num_bytes:	targeting reclaim bytes
+ */
+int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	const sector_t zone_size_sectors = fs_info->zone_size >> SECTOR_SHIFT;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	while (num_bytes > 0) {
+		struct btrfs_chunk_map *map;
+		struct btrfs_block_group *bg = NULL;
+		bool found = false;
+		u64 reclaimed = 0;
+
+		/*
+		 * Here, we choose a fully zone_unusable block group. It's
+		 * technically possible to reset a partly zone_unusable block
+		 * group, which still has some free space left. However,
+		 * handling that needs to cope with the allocation side, which
+		 * makes the logic more complex. So, let's handle the easy case
+		 * for now.
+		 */
+		spin_lock(&fs_info->unused_bgs_lock);
+		list_for_each_entry(bg, &fs_info->unused_bgs, bg_list) {
+			if ((bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) != space_info->flags)
+				continue;
+
+			/*
+			 * Use trylock to avoid locking order violation. In
+			 * btrfs_reclaim_bgs_work(), the lock order is
+			 * &bg->lock -> &fs_info->unused_bgs_lock. We skips a
+			 * block group, if we cannot take its lock.
+			 */
+			if (!spin_trylock(&bg->lock))
+				continue;
+			if (btrfs_is_block_group_used(bg) || bg->zone_unusable < bg->length) {
+				spin_unlock(&bg->lock);
+				continue;
+			}
+			spin_unlock(&bg->lock);
+			found = true;
+			break;
+		}
+		if (!found) {
+			spin_unlock(&fs_info->unused_bgs_lock);
+			return 0;
+		}
+
+		list_del_init(&bg->bg_list);
+		btrfs_put_block_group(bg);
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		/*
+		 * Since the block group is fully zone_unusable and we cannot
+		 * allocate anymore from this block group, we don't need to set
+		 * this block group read-only.
+		 */
+
+		down_read(&fs_info->dev_replace.rwsem);
+		map = bg->physical_map;
+		for (int i = 0; i < map->num_stripes; i++) {
+			struct btrfs_io_stripe *stripe = &map->stripes[i];
+			unsigned int nofs_flags;
+			int ret;
+
+			nofs_flags = memalloc_nofs_save();
+			ret = blkdev_zone_mgmt(stripe->dev->bdev, REQ_OP_ZONE_RESET,
+					       stripe->physical >> SECTOR_SHIFT,
+					       zone_size_sectors);
+			memalloc_nofs_restore(nofs_flags);
+
+			if (ret) {
+				up_read(&fs_info->dev_replace.rwsem);
+				return ret;
+			}
+		}
+		up_read(&fs_info->dev_replace.rwsem);
+
+		spin_lock(&space_info->lock);
+		spin_lock(&bg->lock);
+		ASSERT(!btrfs_is_block_group_used(bg));
+		if (bg->ro) {
+			spin_unlock(&bg->lock);
+			spin_unlock(&space_info->lock);
+			continue;
+		}
+
+		reclaimed = bg->alloc_offset;
+		bg->zone_unusable = bg->length - bg->zone_capacity;
+		bg->alloc_offset = 0;
+		/*
+		 * This holds because we currently reset fully used then freed
+		 * block group.
+		 */
+		ASSERT(reclaimed == bg->zone_capacity);
+		bg->free_space_ctl->free_space += reclaimed;
+		space_info->bytes_zone_unusable -= reclaimed;
+		spin_unlock(&bg->lock);
+		btrfs_return_free_space(space_info, reclaimed);
+		spin_unlock(&space_info->lock);
+
+		if (num_bytes <= reclaimed)
+			break;
+		num_bytes -= reclaimed;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 7612e6572605..9672bf4c3335 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -96,6 +96,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
 int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
+int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes);
 #else /* CONFIG_BLK_DEV_ZONED */
 
 static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
@@ -265,6 +266,12 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 
 static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info) { }
 
+static inline int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info,
+						  u64 num_bytes)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 4df93ca9b7a8..549ab3b41961 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -100,7 +100,8 @@ struct find_free_extent_ctl;
 	EM( ALLOC_CHUNK,		"ALLOC_CHUNK")			\
 	EM( ALLOC_CHUNK_FORCE,		"ALLOC_CHUNK_FORCE")		\
 	EM( RUN_DELAYED_IPUTS,		"RUN_DELAYED_IPUTS")		\
-	EMe(COMMIT_TRANS,		"COMMIT_TRANS")
+	EM( COMMIT_TRANS,		"COMMIT_TRANS")			\
+	EMe(RESET_ZONES,		"RESET_ZONES")
 
 /*
  * First define the enums in the above macros to be exported to userspace via
-- 
2.47.0


