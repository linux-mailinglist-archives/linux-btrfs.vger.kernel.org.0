Return-Path: <linux-btrfs+bounces-9632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7589C848C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 09:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962941F21E1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B11F6662;
	Thu, 14 Nov 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XandHI7I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551E1F5858
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571486; cv=none; b=NeMkHM1pA1LvrDb+RfPiUXLhsP8P5ieVCAahnbbOJ1GwhPXSn+ZUiZWHjkVBcQfvT49ND29iQfp8EE1FwpDF1vyLUxICRuy4NstX5ymRhweAMKh9EBfrG7DwH0/qWSVvFAIcUo/w5iSdIFzFzSoFyIgHpSZsqbPly2fty2TDt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571486; c=relaxed/simple;
	bh=Raqc7b08m3fuDKYZISOjIAumeDI39ruqTKEy+n1to7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWBLHJEZNIOZFYSABxadWPyXeaEI5HUYuxlyUd0hN/bOP0jeRXhKGgXbWHeHSRtH8xS4AZSknZRcWMYvd7l9hltfeAWxzJ2mRd0+GHzHLcTDBK9nbWYU1q6VQivgFLmBABxkrZ2N8n/OGOGwovlYfaMv33/TyQZ8XLtaINmthxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XandHI7I; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731571485; x=1763107485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Raqc7b08m3fuDKYZISOjIAumeDI39ruqTKEy+n1to7M=;
  b=XandHI7I0N7fwSs5bE0fBCZ/E7P4lxob8XXOAqIG3hL/+nn4/yY1x5A9
   kIcQ3GFp/TXdmsCWyJYYPhkVv9wHUdapze14nEkkA7vCsujE3HC4NdYMP
   9EJ0ZGMJzgGvmxiKezfzfhUOOxEmFUrBzD7hTePoWixI1i+g7081nSYC9
   +H9ilUB9fFA6L9BSre9ZQTwFTSwDvjanKhuUBAJGfij2gQwkQ5JlUFry+
   rsOYEI7BSoUCQXk+zF3fJk+RW1bBtmPijVtkw1WieVGT6R8CRuQH97YLN
   3ucnkPEcFJHl1w+CO40OG8N7Fp+uPXeAcgJ9oZJL3etUiH78+1wzX3QPN
   Q==;
X-CSE-ConnectionGUID: kHzXkApMQm2uIdV/qdL0+Q==
X-CSE-MsgGUID: SccUFpd6RF2qF4x6beFi4w==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="31543761"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 16:04:44 +0800
IronPort-SDR: 6735a1da_Dv+17eXXVy1qHJU/49X5Zl8oBqVy9nYocC3PUUadlKMXv4f
 KimiVWz5xzSSRCaegglkx11b36pJXADhRLtcV5A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 23:08:11 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2024 00:04:42 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/3] btrfs: drop fs_info argument from btrfs_update_space_info_*
Date: Thu, 14 Nov 2024 17:04:28 +0900
Message-ID: <cdda2ce32c25aa6cfdf0a17039b65b4e05004130.1731571240.git.naohiro.aota@wdc.com>
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

Since commit e1e577aafe41 ("btrfs: store fs_info in space_info"), we have
the fs_info in a space_info. So, we can drop fs_info argument from
btrfs_update_space_info_*. There is no behavior change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c    | 16 ++++++----------
 fs/btrfs/block-rsv.c      | 10 +++-------
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delayed-ref.c    |  5 ++---
 fs/btrfs/extent-tree.c    | 10 +++-------
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/space-info.c     | 14 +++++---------
 fs/btrfs/space-info.h     |  9 ++++-----
 fs/btrfs/transaction.c    |  3 +--
 9 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4427c1b835e8..5be029734cfa 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1223,7 +1223,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	block_group->space_info->total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
-	btrfs_space_info_update_bytes_zone_unusable(fs_info, block_group->space_info,
+	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
 						    -block_group->zone_unusable);
 	block_group->space_info->disk_total -= block_group->length * factor;
 
@@ -1396,8 +1396,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes to readonly */
 			sinfo->bytes_readonly += cache->zone_unusable;
-			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
-								    -cache->zone_unusable);
+			btrfs_space_info_update_bytes_zone_unusable(sinfo, -cache->zone_unusable);
 			cache->zone_unusable = 0;
 		}
 		cache->ro++;
@@ -1645,8 +1644,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 
-		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
-						     -block_group->pinned);
+		btrfs_space_info_update_bytes_pinned(space_info, -block_group->pinned);
 		space_info->bytes_readonly += block_group->pinned;
 		block_group->pinned = 0;
 
@@ -3060,8 +3058,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 				(cache->alloc_offset - cache->used - cache->pinned -
 				 cache->reserved) +
 				(cache->length - cache->zone_capacity);
-			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
-								    cache->zone_unusable);
+			btrfs_space_info_update_bytes_zone_unusable(sinfo, cache->zone_unusable);
 			sinfo->bytes_readonly -= cache->zone_unusable;
 		}
 		num_bytes = cache->length - cache->reserved -
@@ -3699,7 +3696,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		old_val -= num_bytes;
 		cache->used = old_val;
 		cache->pinned += num_bytes;
-		btrfs_space_info_update_bytes_pinned(info, space_info, num_bytes);
+		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
 		space_info->bytes_used -= num_bytes;
 		space_info->disk_used -= num_bytes * factor;
 		if (READ_ONCE(space_info->periodic_reclaim))
@@ -3781,8 +3778,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 	space_info->bytes_reserved += num_bytes;
 	trace_btrfs_space_reservation(cache->fs_info, "space_info",
 				      space_info->flags, num_bytes, 1);
-	btrfs_space_info_update_bytes_may_use(cache->fs_info,
-					      space_info, -ram_bytes);
+	btrfs_space_info_update_bytes_may_use(space_info, -ram_bytes);
 	if (delalloc)
 		cache->delalloc_bytes += num_bytes;
 
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index a07b9594dc70..3f3608299c0b 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -150,9 +150,7 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 			spin_unlock(&dest->lock);
 		}
 		if (num_bytes)
-			btrfs_space_info_free_bytes_may_use(fs_info,
-							    space_info,
-							    num_bytes);
+			btrfs_space_info_free_bytes_may_use(space_info, num_bytes);
 	}
 	if (qgroup_to_release_ret)
 		*qgroup_to_release_ret = qgroup_to_release;
@@ -383,13 +381,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	if (block_rsv->reserved < block_rsv->size) {
 		num_bytes = block_rsv->size - block_rsv->reserved;
-		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-						      num_bytes);
+		btrfs_space_info_update_bytes_may_use(sinfo, num_bytes);
 		block_rsv->reserved = block_rsv->size;
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
-		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-						      -num_bytes);
+		btrfs_space_info_update_bytes_may_use(sinfo, -num_bytes);
 		block_rsv->reserved = block_rsv->size;
 		btrfs_try_granting_tickets(fs_info, sinfo);
 	}
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 7aa8a395d838..88e900e5a43d 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -176,7 +176,7 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
 	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
 
 	data_sinfo = fs_info->data_sinfo;
-	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
+	btrfs_space_info_free_bytes_may_use(data_sinfo, len);
 }
 
 /*
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 4d2ad5b66928..3e2b1121c4ff 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -254,7 +254,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	spin_unlock(&block_rsv->lock);
 
 	if (to_free > 0)
-		btrfs_space_info_free_bytes_may_use(fs_info, space_info, to_free);
+		btrfs_space_info_free_bytes_may_use(space_info, to_free);
 
 	if (refilled_bytes > 0)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv", 0,
@@ -1281,8 +1281,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 				spin_lock(&bg->space_info->lock);
 				spin_lock(&bg->lock);
 				bg->pinned += head->num_bytes;
-				btrfs_space_info_update_bytes_pinned(fs_info,
-								     bg->space_info,
+				btrfs_space_info_update_bytes_pinned(bg->space_info,
 								     head->num_bytes);
 				bg->reserved -= head->num_bytes;
 				bg->space_info->bytes_reserved -= head->num_bytes;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ce7c963dd0a6..9bbaa2b943e9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2571,13 +2571,10 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 			   struct btrfs_block_group *cache,
 			   u64 bytenr, u64 num_bytes, int reserved)
 {
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-
 	spin_lock(&cache->space_info->lock);
 	spin_lock(&cache->lock);
 	cache->pinned += num_bytes;
-	btrfs_space_info_update_bytes_pinned(fs_info, cache->space_info,
-					     num_bytes);
+	btrfs_space_info_update_bytes_pinned(cache->space_info, num_bytes);
 	if (reserved) {
 		cache->reserved -= num_bytes;
 		cache->space_info->bytes_reserved -= num_bytes;
@@ -2778,15 +2775,14 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_lock(&space_info->lock);
 		spin_lock(&cache->lock);
 		cache->pinned -= len;
-		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
+		btrfs_space_info_update_bytes_pinned(space_info, -len);
 		space_info->max_extent_size = 0;
 		if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
 		} else if (btrfs_is_zoned(fs_info)) {
 			/* Need reset before reusing in a zoned block group */
-			btrfs_space_info_update_bytes_zone_unusable(fs_info, space_info,
-								    len);
+			btrfs_space_info_update_bytes_zone_unusable(space_info, len);
 			readonly = true;
 		}
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 22b8e2764619..38716ffbca45 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1809,7 +1809,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 			bytes = range_bytes;
 
 		spin_lock(&sinfo->lock);
-		btrfs_space_info_update_bytes_may_use(fs_info, sinfo, bytes);
+		btrfs_space_info_update_bytes_may_use(sinfo, bytes);
 		spin_unlock(&sinfo->lock);
 
 		if (count > 0)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 93818339a9a9..7b3c514eb6f9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -316,7 +316,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	found->bytes_used += block_group->used;
 	found->disk_used += block_group->used * factor;
 	found->bytes_readonly += block_group->bytes_super;
-	btrfs_space_info_update_bytes_zone_unusable(info, found, block_group->zone_unusable);
+	btrfs_space_info_update_bytes_zone_unusable(found, block_group->zone_unusable);
 	if (block_group->length > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
@@ -489,9 +489,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 		if ((used + ticket->bytes <= space_info->total_bytes) ||
 		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
 					 flush)) {
-			btrfs_space_info_update_bytes_may_use(fs_info,
-							      space_info,
-							      ticket->bytes);
+			btrfs_space_info_update_bytes_may_use(space_info, ticket->bytes);
 			remove_ticket(space_info, ticket);
 			ticket->bytes = 0;
 			space_info->tickets_id++;
@@ -1690,8 +1688,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	if (!pending_tickets &&
 	    ((used + orig_bytes <= space_info->total_bytes) ||
 	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {
-		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
-						      orig_bytes);
+		btrfs_space_info_update_bytes_may_use(space_info, orig_bytes);
 		ret = 0;
 	}
 
@@ -1703,8 +1700,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	if (ret && unlikely(flush == BTRFS_RESERVE_FLUSH_EMERGENCY)) {
 		used = btrfs_space_info_used(space_info, false);
 		if (used + orig_bytes <= space_info->total_bytes) {
-			btrfs_space_info_update_bytes_may_use(fs_info, space_info,
-							      orig_bytes);
+			btrfs_space_info_update_bytes_may_use(space_info, orig_bytes);
 			ret = 0;
 		}
 	}
@@ -2099,7 +2095,7 @@ void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len)
 		u64 to_add = min(len, global_rsv->size - global_rsv->reserved);
 
 		global_rsv->reserved += to_add;
-		btrfs_space_info_update_bytes_may_use(fs_info, space_info, to_add);
+		btrfs_space_info_update_bytes_may_use(space_info, to_add);
 		if (global_rsv->reserved >= global_rsv->size)
 			global_rsv->full = 1;
 		len -= to_add;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 4c9e8aabee51..69071afc0d47 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -229,10 +229,10 @@ static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_i
  */
 #define DECLARE_SPACE_INFO_UPDATE(name, trace_name)			\
 static inline void							\
-btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
-			       struct btrfs_space_info *sinfo,		\
+btrfs_space_info_update_##name(struct btrfs_space_info *sinfo,		\
 			       s64 bytes)				\
 {									\
+	struct btrfs_fs_info *fs_info = sinfo->fs_info;			\
 	const u64 abs_bytes = (bytes < 0) ? -bytes : bytes;		\
 	lockdep_assert_held(&sinfo->lock);				\
 	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
@@ -275,13 +275,12 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 			 enum btrfs_reserve_flush_enum flush);
 
 static inline void btrfs_space_info_free_bytes_may_use(
-				struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				u64 num_bytes)
 {
 	spin_lock(&space_info->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
-	btrfs_try_granting_tickets(fs_info, space_info);
+	btrfs_space_info_update_bytes_may_use(space_info, -num_bytes);
+	btrfs_try_granting_tickets(space_info->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index dc0b837efd5d..15312013f2a3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -795,8 +795,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	if (num_bytes)
 		btrfs_block_rsv_release(fs_info, trans_rsv, num_bytes, NULL);
 	if (delayed_refs_bytes)
-		btrfs_space_info_free_bytes_may_use(fs_info, trans_rsv->space_info,
-						    delayed_refs_bytes);
+		btrfs_space_info_free_bytes_may_use(trans_rsv->space_info, delayed_refs_bytes);
 reserve_fail:
 	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 	return ERR_PTR(ret);
-- 
2.47.0


