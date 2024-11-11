Return-Path: <linux-btrfs+bounces-9415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332A9C3934
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 08:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D051C21660
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3215EFA0;
	Mon, 11 Nov 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QGlxA4Aq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0C15B122
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311339; cv=none; b=rVtJRVsoc4jHiQ+emv4ZbZiHETG5ypurcf+/AfVwcZ9ijIjgNXKFfii9Wy+wuUEwj38Gec5qOSzI0o72acge+E6oWIuv+cy92x+euPfKJlJ8DEydjbH+7AReIR2jc3lUDWtyOb9sHo8SIqFJHiwpRDHcYJsnd9ZYg8Gy+TgcwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311339; c=relaxed/simple;
	bh=FITUMY0jxo0jCzNF2k6tAymcfhUhkcnfwMU577rhKJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbmTj1sBOGwGIK6fzUkcoD2Uaip/y1cb3yjE8GLWyPP8/2XdhK+7C+YCIteFVlrAnxUqlp+hct/Oq+fDhprVhianmn6i6p7hiDrpAUjWaDN+V7NrbXu+g/aAoL0YImfvdz4ewy19Pijh9kcpkwtwPwMq0G5PfajWJsESgHJ6+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QGlxA4Aq; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731311337; x=1762847337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FITUMY0jxo0jCzNF2k6tAymcfhUhkcnfwMU577rhKJU=;
  b=QGlxA4AqIp4jnxB3v6DgxjU2M725hpSNgZCK+ar0qWNpWKOAxf5dhGNs
   vzdFBnpveFhLnbtUFqooowl1UKjEnV52dBHvU/7zu+tXtnozL3k/o9QU+
   7DLjLSh//7rRsAIQwhhtzjFJnKnx/NwQli2w3RjVyFZ73ZdiTzu+t0sjG
   Vf4bnFP00FQdxdc1N+7JDZb/EvzZf6bqVeusSn1SjSK/rhZrlO5egL6QI
   jPSzYL+0q11G/v6yik6dOCXp9wHul772gTzJ41oJGlRn7n3ubZRT2Cpao
   W6H4ye8Wjbnz+mGerdNmjiakd1dv8KCmJBP1552tNaTw1h4ag6bIplHpj
   g==;
X-CSE-ConnectionGUID: Xk83Dm6FRYmUyjMdHJljRw==
X-CSE-MsgGUID: 2PxGnGhtSciU/hqbbHPayQ==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32235397"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 15:47:47 +0800
IronPort-SDR: 6731a81b_gwccyCw/q2zR8b78g9jpQzbymuXIndaLXf0gWnkYGGOti2+
 WXuz2xEgTR5y+Lav0Ad4sNAbyg6aPt1pe+TH9GA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 22:45:48 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.23])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2024 23:47:48 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: reclaim unused zone by zone resetting
Date: Mon, 11 Nov 2024 16:46:39 +0900
Message-ID: <72946446ca8eda4477e0a11ea0b9d15cb05aa1e1.1731310741.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731310741.git.naohiro.aota@wdc.com>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
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
 fs/btrfs/space-info.c        |  28 +++++++++-
 fs/btrfs/space-info.h        |   5 ++
 fs/btrfs/zoned.c             | 104 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h             |   7 +++
 include/trace/events/btrfs.h |   1 +
 5 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b94cd43d9495..8a0a347652f1 100644
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
index cb32966380f5..f939c2d7bb0b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2648,3 +2648,107 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
+
+/*
+ * Reset the zones of unused block groups to free up @space_info->bytes_zone_unusable.
+ *
+ * @space_info:	the space to work on
+ * @num_bytes:	targeting reclaim bytes
+ */
+int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
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
+		scoped_guard(spinlock, &fs_info->unused_bgs_lock) {
+			list_for_each_entry(bg, &fs_info->unused_bgs, bg_list) {
+				if ((bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) != space_info->flags)
+					continue;
+
+				if (!spin_trylock(&bg->lock))
+					continue;
+				if (btrfs_is_block_group_used(bg) ||
+				    bg->zone_unusable < bg->length) {
+					spin_unlock(&bg->lock);
+					continue;
+				}
+				spin_unlock(&bg->lock);
+				found = true;
+				break;
+			}
+			if (!found)
+				return 0;
+
+			list_del_init(&bg->bg_list);
+			btrfs_put_block_group(bg);
+		}
+
+		/*
+		 * Since the block group is fully zone_unusable and we cannot
+		 * allocate anymore from this block group, we don't need to set
+		 * this block group read-only.
+		 */
+
+		scoped_guard(rwsem_read, &fs_info->dev_replace.rwsem) {
+			const sector_t zone_size_sectors = fs_info->zone_size >> SECTOR_SHIFT;
+
+			map = bg->physical_map;
+			for (int i = 0; i < map->num_stripes; i++) {
+				struct btrfs_io_stripe *stripe = &map->stripes[i];
+				unsigned int nofs_flags;
+				int ret;
+
+				nofs_flags = memalloc_nofs_save();
+				ret = blkdev_zone_mgmt(stripe->dev->bdev, REQ_OP_ZONE_RESET,
+						       stripe->physical >> SECTOR_SHIFT,
+						       zone_size_sectors);
+				memalloc_nofs_restore(nofs_flags);
+
+				if (ret)
+					return ret;
+			}
+		}
+
+		scoped_guard(spinlock, &space_info->lock) {
+			scoped_guard(spinlock, &bg->lock) {
+				ASSERT(!btrfs_is_block_group_used(bg));
+				if (bg->ro)
+					continue;
+
+				reclaimed = bg->alloc_offset;
+				bg->zone_unusable = bg->length - bg->zone_capacity;
+				bg->alloc_offset = 0;
+				/*
+				 * This holds because we currently reset fully
+				 * used then freed BG.
+				 */
+				ASSERT(reclaimed == bg->zone_capacity);
+				bg->free_space_ctl->free_space += reclaimed;
+				space_info->bytes_zone_unusable -= reclaimed;
+			}
+			btrfs_return_free_space(space_info, reclaimed);
+		}
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
index 4df93ca9b7a8..aeaf079ff994 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -97,6 +97,7 @@ struct find_free_extent_ctl;
 	EM( FLUSH_DELALLOC_FULL,	"FLUSH_DELALLOC_FULL")		\
 	EM( FLUSH_DELAYED_REFS_NR,	"FLUSH_DELAYED_REFS_NR")	\
 	EM( FLUSH_DELAYED_REFS,		"FLUSH_DELAYED_REFS")		\
+	EM( RESET_ZONES,		"RESET_ZONES")			\
 	EM( ALLOC_CHUNK,		"ALLOC_CHUNK")			\
 	EM( ALLOC_CHUNK_FORCE,		"ALLOC_CHUNK_FORCE")		\
 	EM( RUN_DELAYED_IPUTS,		"RUN_DELAYED_IPUTS")		\
-- 
2.47.0


