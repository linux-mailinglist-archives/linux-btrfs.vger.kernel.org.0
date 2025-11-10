Return-Path: <linux-btrfs+bounces-18841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59577C48483
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6FD04EF727
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03429B793;
	Mon, 10 Nov 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="3tpNLJqc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B629B8E0
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794932; cv=none; b=Guy6LPBm9p6OnwuceeSZ65MK/toHMr/gHxqt1Y3HxF1aIBYkYSvBXbjygBSPH35hAG+1vTdemyF50S7G6cQa3QZNJdqxD6pCLweddtgZXgAHshKQbdRqqAlzdhPcS41Y995A53dsWHcZnrBQ01d4xO/UnRlMx8FEST9vLrgjd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794932; c=relaxed/simple;
	bh=tyLdTLcz8Pocbmh5Gn9PwOS3+Mfvl4AeITaME+jHiGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=A091TBowdWMkaXHl/WXTuoPBUzx8y9W/YeH3cUV2D3bUVdyEecV2doLQP0kFMP4yhMgDKS5uJXGnBWsV+p2Or2jjOzIFTKoxEU+FRLXI53aU6OKR6Hq2hZ85DjuBxUYPtDkTYI/VdYxZ8iWinvAhR+x69ylp1VZBtk0fDHh8hL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=3tpNLJqc; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 6352E2D8F97;
	Mon, 10 Nov 2025 17:15:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762794915;
	bh=Ai1YatS5XR4Azv5LO/aRM2bnwwPNhE0v5QmQ2lSdi0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=3tpNLJqcDTkEFz/jxjbi2O0kTMI9Q34m/CA5mQ//jcJPbrP74Rgdnimtu7EcB9hYO
	 8jvSOqI4mhJNqAwnSa+m7H+ekU+HlDHcpSv4SBY4ZanIYNiKAEbSZzXAeMssrJqhH4
	 UlJQ4vCmWcBk5uIbw0sw5rg1CJ9ACHFt6AwFLYUM=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v5 15/16] btrfs: handle discarding fully-remapped block groups
Date: Mon, 10 Nov 2025 17:14:39 +0000
Message-ID: <20251110171511.20900-16-mark@harmstone.com>
In-Reply-To: <20251110171511.20900-1-mark@harmstone.com>
References: <20251110171511.20900-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Discard normally works by iterating over the free-space entries of a
block group. This doesn't work for fully-remapped block groups, as we
removed their free-space entries when we started relocation.

For sync discard, call btrfs_discard_extent() when we commit the
transaction in which the last identity remap was removed.

For async discard, add a new function btrfs_trim_fully_remapped_block_group()
to be called by the discard worker, which iterates over the block
group's range using the normal async discard rules. Once we reach the
end, remove the chunk's stripes and device extents to get back its free
space.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c      |  3 ++
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/discard.c          | 57 ++++++++++++++++++++++++----
 fs/btrfs/extent-tree.c      | 11 ++++++
 fs/btrfs/free-space-cache.c | 75 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  1 +
 6 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7e9c3222beb6..b8ace5118d79 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4850,4 +4850,7 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 	list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
 
 	spin_unlock(&fs_info->unused_bgs_lock);
+
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4522074a45c2..b0b16efea19a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -49,6 +49,7 @@ enum btrfs_discard_state {
 	BTRFS_DISCARD_EXTENTS,
 	BTRFS_DISCARD_BITMAPS,
 	BTRFS_DISCARD_RESET_CURSOR,
+	BTRFS_DISCARD_FULLY_REMAPPED,
 };
 
 /*
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index ee5f5b2788e1..f9890037395a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -215,6 +215,27 @@ static struct btrfs_block_group *find_next_block_group(
 	return ret_block_group;
 }
 
+/*
+ * Returns whether a block group is empty.
+ *
+ * @block_group: block_group of interest
+ *
+ * "Empty" here means that there are no extents physically located within the
+ * device extents corresponding to this block group.
+ *
+ * For a remapped block group, this means that all of its identity remaps have
+ * been removed. For a non-remapped block group, this means that no extents
+ * have an address within its range, and that nothing has been remapped to be
+ * within it.
+ */
+static bool block_group_is_empty(struct btrfs_block_group *block_group)
+{
+	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)
+		return block_group->identity_remap_count == 0;
+	else
+		return block_group->used == 0 && block_group->remap_bytes == 0;
+}
+
 /*
  * Look up next block group and set it for use.
  *
@@ -241,8 +262,10 @@ static struct btrfs_block_group *peek_discard_list(
 	block_group = find_next_block_group(discard_ctl, now);
 
 	if (block_group && now >= block_group->discard_eligible_time) {
+		bool empty = block_group_is_empty(block_group);
+
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
-		    block_group->used != 0) {
+		    !empty) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
 				/*
@@ -267,7 +290,15 @@ static struct btrfs_block_group *peek_discard_list(
 		}
 		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
 			block_group->discard_cursor = block_group->start;
-			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
+
+			if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+			    empty) {
+				block_group->discard_state =
+					BTRFS_DISCARD_FULLY_REMAPPED;
+			} else {
+				block_group->discard_state =
+					BTRFS_DISCARD_EXTENTS;
+			}
 		}
 	}
 	if (block_group) {
@@ -373,7 +404,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	if (block_group->used == 0 && block_group->remap_bytes == 0)
+	if (block_group_is_empty(block_group))
 		add_to_discard_unused_list(discard_ctl, block_group);
 	else
 		add_to_discard_list(discard_ctl, block_group);
@@ -470,7 +501,7 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 {
 	remove_from_discard_list(discard_ctl, block_group);
 
-	if (block_group->used == 0) {
+	if (block_group_is_empty(block_group)) {
 		if (btrfs_is_free_space_trimmed(block_group))
 			btrfs_mark_bg_unused(block_group);
 		else
@@ -524,7 +555,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	/* Perform discarding */
 	minlen = discard_minlen[discard_index];
 
-	if (discard_state == BTRFS_DISCARD_BITMAPS) {
+	switch (discard_state) {
+	case BTRFS_DISCARD_BITMAPS: {
 		u64 maxlen = 0;
 
 		/*
@@ -541,17 +573,28 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				       btrfs_block_group_end(block_group),
 				       minlen, maxlen, true);
 		discard_ctl->discard_bitmap_bytes += trimmed;
-	} else {
+
+		break;
+	}
+
+	case BTRFS_DISCARD_FULLY_REMAPPED:
+		btrfs_trim_fully_remapped_block_group(block_group);
+		break;
+
+	default:
 		btrfs_trim_block_group_extents(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
 				       minlen, true);
 		discard_ctl->discard_extent_bytes += trimmed;
+
+		break;
 	}
 
 	/* Determine next steps for a block_group */
 	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
-		if (discard_state == BTRFS_DISCARD_BITMAPS) {
+		if (discard_state == BTRFS_DISCARD_BITMAPS ||
+		    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
 			btrfs_finish_discard_pass(discard_ctl, block_group);
 		} else {
 			block_group->discard_cursor = block_group->start;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index aacf983ccf73..6764ba02f531 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2859,6 +2859,13 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
 	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
 		struct btrfs_chunk_map *map;
 
+		/* for async discard the below gets done in discard job */
+		if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+			btrfs_discard_queue_work(&fs_info->discard_ctl,
+						 block_group);
+			continue;
+		}
+
 		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
 		if (IS_ERR(map))
 			return PTR_ERR(map);
@@ -2869,6 +2876,10 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
 			return ret;
 		}
 
+		if (!TRANS_ABORTED(trans))
+			btrfs_discard_extent(fs_info, block_group->start,
+					     block_group->length, NULL, false);
+
 		/*
 		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
 		 * won't run a second time.
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 30507fa8ad80..60101cb93e3d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -29,6 +29,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "super.h"
+#include "relocation.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
@@ -3066,6 +3067,11 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	struct rb_node *node;
 	bool ret = true;
 
+	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    block_group->identity_remap_count == 0) {
+		return true;
+	}
+
 	spin_lock(&ctl->tree_lock);
 	node = rb_first(&ctl->free_space_offset);
 
@@ -3834,6 +3840,75 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	return ret;
 }
 
+void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	int ret = 0;
+	u64 bytes, trimmed;
+	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
+	u64 end = btrfs_block_group_end(bg);
+	struct btrfs_trans_handle *trans;
+	struct btrfs_chunk_map *map;
+
+	bytes = end - bg->discard_cursor;
+
+	if (max_discard_size &&
+		bytes >= (max_discard_size +
+			BTRFS_ASYNC_DISCARD_MIN_FILTER)) {
+		bytes = max_discard_size;
+	}
+
+	ret = btrfs_discard_extent(fs_info, bg->discard_cursor, bytes, &trimmed,
+				   false);
+	if (ret)
+		return;
+
+	bg->discard_cursor += trimmed;
+
+	if (bg->discard_cursor < end)
+		return;
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans))
+		return;
+
+	map = btrfs_get_chunk_map(fs_info, bg->start, 1);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		btrfs_abort_transaction(trans, ret);
+		return;
+	}
+
+	ret = btrfs_last_identity_remap_gone(trans, map, bg);
+	if (ret) {
+		btrfs_free_chunk_map(map);
+		btrfs_abort_transaction(trans, ret);
+		return;
+	}
+
+	btrfs_end_transaction(trans);
+
+	/*
+	 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
+	 * won't run a second time.
+	 */
+	map->num_stripes = 0;
+
+	btrfs_free_chunk_map(map);
+
+	if (bg->used == 0) {
+		spin_lock(&fs_info->unused_bgs_lock);
+		if (list_empty(&bg->bg_list)) {
+			btrfs_get_block_group(bg);
+			list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
+		} else {
+			list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
+		}
+		spin_unlock(&fs_info->unused_bgs_lock);
+	}
+}
+
 /*
  * If we break out of trimming a bitmap prematurely, we should reset the
  * trimming bit.  In a rather contrived case, it's possible to race here so
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 9f1dbfdee8ca..33fc3b245648 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -166,6 +166,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 				   u64 *trimmed, u64 start, u64 end, u64 minlen,
 				   u64 maxlen, bool async);
+void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg);
 
 bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
 int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active);
-- 
2.51.0


