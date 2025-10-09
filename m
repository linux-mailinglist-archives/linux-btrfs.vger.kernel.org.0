Return-Path: <linux-btrfs+bounces-17586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D7ABC8D34
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967334F884D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD22E6CA3;
	Thu,  9 Oct 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="ZfMgx4bs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36492E228D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009306; cv=none; b=e/IQTmY/sboGgvuM0Vtu9RviMm9oxuUiuOX9/KEODCd6qcQ91axZemLfwAPxsUAR5q5hnDIS00VFdVaulw/YNugSIhMAXdXR6zdNKT6C8GZHSw8FEbeBxLLLrzi2AkbuDueoKvS/q5KyJ7w58EHsXPJFsMz09VjOjKXftfwNLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009306; c=relaxed/simple;
	bh=9h99B6R/C3dBUyJ0PY4pCGEsFcYzbt9hV2oDVmdrTsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=fdUBcFPEutoB5QbY2Qy1TRWkCe4Dqcss9zYDmQaabysPHykIYxwqXa6NJpglo5amJGlhxJdVBtyPr9SDgWVuw6n8ZXv6XmQGx6JbxqU8ksyq5tCPimVhzdAy1YqYPdFZQMJ5i99/J7V3vff5Hu5kOvA4cayTWRxqIxnUNuBoCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=ZfMgx4bs; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id E04F32C565D;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=xOjuu12BjyvmlRXsWco1qnJYlPpuoc8o8a4H/6mqChE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZfMgx4bshMpbvHKo9S4GF5dbvi5llNB7bHc0O2kozince1mqTQB0/83wo0y6e8l5I
	 4JNcxii/Yp6bSDliP2pf1bdWo8mR2f2ONkaBQmp1GULAni4txoSfKa907/l0YoTRkg
	 7KF+msGw7UM65RrIsL0kJi+CNHLy05uetPGQtZFE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 16/17] btrfs: handle discarding fully-remapped block groups
Date: Thu,  9 Oct 2025 12:28:11 +0100
Message-ID: <20251009112814.13942-17-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
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
 fs/btrfs/block-group.c      |  2 +
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/discard.c          | 61 +++++++++++++++++++++++++----
 fs/btrfs/extent-tree.c      |  4 ++
 fs/btrfs/free-space-cache.c | 77 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  1 +
 fs/btrfs/transaction.c      |  8 ++--
 7 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3f7c45d17415..a7dfa6c95223 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4828,4 +4828,6 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 
 	spin_unlock(&fs_info->unused_bgs_lock);
 
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c6866a57ea24..3c086fbb0a7c 100644
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
index 2b7b1e440bc8..421f48a6603a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -241,8 +241,17 @@ static struct btrfs_block_group *peek_discard_list(
 	block_group = find_next_block_group(discard_ctl, now);
 
 	if (block_group && now >= block_group->discard_eligible_time) {
+		bool unused;
+
+		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
+			unused = block_group->remap_bytes == 0 &&
+				 block_group->identity_remap_count == 0;
+		} else {
+			unused = block_group->used == 0;
+		}
+
 		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
-		    block_group->used != 0) {
+		    !unused) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
 				/*
@@ -267,7 +276,15 @@ static struct btrfs_block_group *peek_discard_list(
 		}
 		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
 			block_group->discard_cursor = block_group->start;
-			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
+
+			if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+			    unused) {
+				block_group->discard_state =
+					BTRFS_DISCARD_FULLY_REMAPPED;
+			} else {
+				block_group->discard_state =
+					BTRFS_DISCARD_EXTENTS;
+			}
 		}
 	}
 	if (block_group) {
@@ -370,10 +387,19 @@ void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 			      struct btrfs_block_group *block_group)
 {
+	bool unused;
+
 	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	if (block_group->used == 0 && block_group->remap_bytes == 0)
+	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
+		unused = block_group->remap_bytes == 0 &&
+			 block_group->identity_remap_count == 0;
+	} else {
+		unused = block_group->used == 0;
+	}
+
+	if (unused)
 		add_to_discard_unused_list(discard_ctl, block_group);
 	else
 		add_to_discard_list(discard_ctl, block_group);
@@ -468,9 +494,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
 				      struct btrfs_block_group *block_group)
 {
+	bool unused;
+
 	remove_from_discard_list(discard_ctl, block_group);
 
-	if (block_group->used == 0) {
+	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
+		unused = block_group->remap_bytes == 0 &&
+			 block_group->identity_remap_count == 0;
+	} else {
+		unused = block_group->used == 0;
+	}
+
+	if (unused) {
 		if (btrfs_is_free_space_trimmed(block_group))
 			btrfs_mark_bg_unused(block_group);
 		else
@@ -524,7 +559,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	/* Perform discarding */
 	minlen = discard_minlen[discard_index];
 
-	if (discard_state == BTRFS_DISCARD_BITMAPS) {
+	switch (discard_state) {
+	case BTRFS_DISCARD_BITMAPS: {
 		u64 maxlen = 0;
 
 		/*
@@ -541,17 +577,28 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
index 2e3074612f39..03674d171ec0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2870,6 +2870,10 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
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
index 6387f8d1c3a1..56f27487b632 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -29,6 +29,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "super.h"
+#include "relocation.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
@@ -3063,6 +3064,12 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	struct rb_node *node;
 	bool ret = true;
 
+	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    block_group->remap_bytes == 0 &&
+	    block_group->identity_remap_count == 0) {
+		return true;
+	}
+
 	spin_lock(&ctl->tree_lock);
 	node = rb_first(&ctl->free_space_offset);
 
@@ -3827,6 +3834,76 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	return ret;
 }
 
+void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	int ret = 0;
+	u64 bytes;
+	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
+	u64 end = btrfs_block_group_end(bg);
+	struct btrfs_trans_handle *trans;
+	struct btrfs_chunk_map *map;
+
+	while (bg->discard_cursor < end) {
+		u64 trimmed;
+
+		bytes = end - bg->discard_cursor;
+
+		if (max_discard_size &&
+			bytes >= (max_discard_size +
+				BTRFS_ASYNC_DISCARD_MIN_FILTER)) {
+			bytes = max_discard_size;
+		}
+
+		ret = btrfs_discard_extent(fs_info, bg->discard_cursor, bytes,
+					   &trimmed, false);
+		if (ret || trimmed == 0)
+			return;
+
+		bg->discard_cursor += trimmed;
+
+		if (btrfs_trim_interrupted())
+			return;
+
+		cond_resched();
+	}
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
+		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
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
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 6ce91397afe6..b0a5254ba214 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2438,9 +2438,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret)
 		goto unlock_reloc;
 
-	ret = btrfs_handle_fully_remapped_bgs(trans);
-	if (ret)
-		goto unlock_reloc;
+	if (!btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+		ret = btrfs_handle_fully_remapped_bgs(trans);
+		if (ret)
+			goto unlock_reloc;
+	}
 
 	/*
 	 * make sure none of the code above managed to slip in a
-- 
2.49.1


