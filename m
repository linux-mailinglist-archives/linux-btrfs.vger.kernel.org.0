Return-Path: <linux-btrfs+bounces-18842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1FC48465
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 18:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433A33ACA87
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 17:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873C2BCF43;
	Mon, 10 Nov 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="4H1oEIoo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF429BD9B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794932; cv=none; b=YLctizyc6uZucq+VCsbmqiD1ZxAajDiVzkMGtvfdmhCFRt6wiFmyUk6BwhS773X7Hb9eUZCHoBlUtl+fWWzw4cYVQpZQ7IyFsgEXhXH+ah/pJvNeNH2ar98pz8leDAZVLafv3Edjh/GNYjBu84P83HTZBRBZXLIV6TzLFyG+0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794932; c=relaxed/simple;
	bh=YkSYEgNEBBq9ZO5rFzs2OVQXpE5BuXYDAFwa1PxQxFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=HWyM37+Edh7e2hLHlKQds/HrTthmYLj5deEFZQA62/yEIPnFSr8CNRS/IVZleq6KtPyNaR6u0nKze0k8ejJs4xi31BQ4texC0eVRucRTps9QQ+2FOXItZuLHeKnMouxkh2aLhZg8LixaniQfqd6t2eeYQsikCdA/402RRdLZtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=4H1oEIoo; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 6BFA12D8F98;
	Mon, 10 Nov 2025 17:15:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762794915;
	bh=8FA3kWv+mveN+k4WNMt61VNbM4QlRd1fvYuvsR+/pIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=4H1oEIoo132DmA7dFTEX68I+oVT8wvnM5mtheFilhvwIlZYup2PKh4DrR1qQ0AUen
	 4rwQSFYoP9N/J9ME6a7+2vkAACzTckcB+TTnN1X7MGdVTJrGTD24ey7osXGzBK6uVe
	 jMYei/LwvJVA/NuZChm6bXcG5Tqu4lSfZ2QKVMT4=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v5 16/16] btrfs: populate fully_remapped_bgs_list on mount
Date: Mon, 10 Nov 2025 17:14:40 +0000
Message-ID: <20251110171511.20900-17-mark@harmstone.com>
In-Reply-To: <20251110171511.20900-1-mark@harmstone.com>
References: <20251110171511.20900-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function btrfs_populate_fully_remapped_bgs_list() which gets
called on mount, which looks for fully remapped block groups
(i.e. identity_remap_count == 0) which haven't yet had their chunk
stripes and device extents removed.

This happens when a filesystem is unmounted while async discard has not
yet finished, as otherwise the data range occupied by the chunk stripes
would be permanently unusable.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c      | 82 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h      |  2 +
 fs/btrfs/disk-io.c          |  9 ++++
 fs/btrfs/free-space-cache.c |  7 ++++
 fs/btrfs/relocation.c       |  4 ++
 5 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b8ace5118d79..18a6b0984ce9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4851,6 +4851,86 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 
 	spin_unlock(&fs_info->unused_bgs_lock);
 
-	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+		spin_lock(&bg->lock);
+		set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
+			&bg->runtime_flags);
+		spin_unlock(&bg->lock);
+
 		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
+	}
+}
+
+/*
+ * Compare the block group and chunk trees, and find any fully-remapped block
+ * groups which haven't yet had their chunk stripes and device extents removed,
+ * and put them on the fully_remapped_bgs list so this gets done.
+ *
+ * This happens when a block group becomes fully remapped, i.e. its last
+ * identity mapping is removed, and the volume is unmounted before async
+ * discard has finished. It's important this gets done as until it is the
+ * chunk's stripes are dead space.
+ */
+int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info)
+{
+	struct rb_node *node_bg, *node_chunk;
+
+	node_bg = rb_first_cached(&fs_info->block_group_cache_tree);
+	node_chunk = rb_first_cached(&fs_info->mapping_tree);
+
+	while (node_bg && node_chunk) {
+		struct btrfs_block_group *bg;
+		struct btrfs_chunk_map *map;
+
+		bg = rb_entry(node_bg, struct btrfs_block_group, cache_node);
+		map = rb_entry(node_chunk, struct btrfs_chunk_map, rb_node);
+
+		ASSERT(bg->start == map->start);
+
+		if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED))
+			goto next;
+
+		if (bg->identity_remap_count != 0)
+			goto next;
+
+		if (map->num_stripes == 0)
+			goto next;
+
+		spin_lock(&fs_info->unused_bgs_lock);
+
+		if (list_empty(&bg->bg_list)) {
+			btrfs_get_block_group(bg);
+			list_add_tail(&bg->bg_list,
+				      &fs_info->fully_remapped_bgs);
+		} else {
+			list_move_tail(&bg->bg_list,
+				       &fs_info->fully_remapped_bgs);
+		}
+
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		/*
+		 * Ideally we'd want to call btrfs_discard_queue_work() here,
+		 * but it'd do nothing as the discard worker hasn't been
+		 * started yet.
+		 *
+		 * The block group will get added to the discard list when
+		 * btrfs_handle_fully_remapped_bgs() gets called, when we
+		 * commit the first transaction.
+		 */
+		if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+			spin_lock(&bg->lock);
+			set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
+				&bg->runtime_flags);
+			spin_unlock(&bg->lock);
+		}
+
+next:
+		node_bg = rb_next(node_bg);
+		node_chunk = rb_next(node_chunk);
+	}
+
+	ASSERT(!node_bg && !node_chunk);
+
+	return 0;
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b0b16efea19a..03e8ad8a2ec7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -93,6 +93,7 @@ enum btrfs_block_group_flags {
 	 * transaction.
 	 */
 	BLOCK_GROUP_FLAG_NEW,
+	BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
 };
 
 enum btrfs_caching_type {
@@ -416,5 +417,6 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
 void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 				  struct btrfs_trans_handle *trans);
+int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 908f706cf409..27f3cfc0145d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3645,6 +3645,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		ret = btrfs_populate_fully_remapped_bgs_list(fs_info);
+		if (ret) {
+			btrfs_err(fs_info,
+			"failed to populate fully_remapped_bgs list: %d", ret);
+			goto fail_sysfs;
+		}
+	}
+
 	btrfs_zoned_reserve_data_reloc_bg(fs_info);
 	btrfs_free_zone_cache(fs_info);
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 60101cb93e3d..0987e3750301 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3068,6 +3068,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	bool ret = true;
 
 	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    !test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &block_group->runtime_flags) &&
 	    block_group->identity_remap_count == 0) {
 		return true;
 	}
@@ -3851,6 +3852,11 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_chunk_map *map;
 
+	if (!test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags)) {
+		bg->discard_cursor = end;
+		goto skip_discard;
+	}
+
 	bytes = end - bg->discard_cursor;
 
 	if (max_discard_size &&
@@ -3897,6 +3903,7 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 
 	btrfs_free_chunk_map(map);
 
+skip_discard:
 	if (bg->used == 0) {
 		spin_lock(&fs_info->unused_bgs_lock);
 		if (list_empty(&bg->bg_list)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 840336965f32..3de0434413bf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4760,6 +4760,10 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
 
 	btrfs_remove_bg_from_sinfo(bg);
 
+	spin_lock(&bg->lock);
+	clear_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags);
+	spin_unlock(&bg->lock);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-- 
2.51.0


