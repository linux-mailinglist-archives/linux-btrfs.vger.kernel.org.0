Return-Path: <linux-btrfs+bounces-20204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AACFE303
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68F093004E22
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96123314B8;
	Wed,  7 Jan 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="zr+vZRP5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F632ED32
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795035; cv=none; b=n0RZq1SXv/iPaOHgI89JvJ5eOVTxpSOCOJF5cYSaYQl0S7yeL7EZupnTdGQ7fJTF5JQbxfVGVKJKCNB45O9k/+RCJUSyMdH+t0Nhz89uXHF8g+uqrgvtZm15/cTPQLAG6Aj8LZg01p0b/1ELqmnN1Yyx9f1CGTfjLIfWJfTLy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795035; c=relaxed/simple;
	bh=eLZ6aiTT/xYnj3LN3hDiuGuybC6vfSm9a2n4Yk7rCjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=frIWBaWFXzlLnivekQnrDjXwgHACnklRy6wUt7a4h+2g5CGRiYaK42D6u5IwJAEMYjDiLewWWx7/EjNwUbX/NPK1JScGPSuozYMMv3xVd1aohA7mdurG4Gsk/sCudfXdbPwgaHvcVFCvaXSRhlOz0eNPDh0wgrG3PeVno5RkYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=zr+vZRP5; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 7F6872F1870;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=knTLXDmCMBhFYTe7pCdkthKlS09G+BALYV5WKRroMww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zr+vZRP5MP0qlc7gdtpIb6JmqXWJ09m39tl61UrHriRq+1OPbjHqGPKwpVE6y/vpA
	 3voIcx1S17FfkcG0j3IlAA0Tb7usZ2hLl0k6SvY2oBqNcme3yRznZ3PppeQ10Zkt3v
	 r0ql2OWgJEY7RfhJMXQcKY0AaY2NW/9YtZqUpBmc=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 10/17] btrfs: handle deletions from remapped block group
Date: Wed,  7 Jan 2026 14:09:10 +0000
Message-ID: <20260107141015.25819-11-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the case where we free an extent from a block group that has the
REMAPPED flag set. Because the remap tree is orthogonal to the extent
tree, for data this may be within any number of identity remaps or
actual remaps. If we're freeing a metadata node, this will be wholly
inside one or the other.

btrfs_remove_extent_from_remap_tree() searches the remap tree for the
remaps that cover the range in question, then calls
remove_range_from_remap_tree() for each one, to punch a hole in the
remap and adjust the free-space tree.

For an identity remap, remove_range_from_remap_tree() will adjust the
block group's `identity_remap_count` if this changes. If it reaches
zero we mark the block group as fully remapped.

For an identity remap, remove_range_from_remap_tree() will adjust the
block group's `identity_remap_count` if this changes. If it reaches
zero we mark the block group as fully remapped.

Fully remapped block groups have their chunk stripes removed and their
device extents freed, which makes the disk space available again to the
chunk allocator. This happens asynchronously: in the cleaner thread for
sync discard and nodiscard, and (in a later patch) in the discard worker
for async discard.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c |  98 ++++++---
 fs/btrfs/block-group.h |   4 +
 fs/btrfs/disk-io.c     |   6 +
 fs/btrfs/extent-tree.c |  98 ++++++++-
 fs/btrfs/extent-tree.h |   2 +
 fs/btrfs/fs.h          |   4 +-
 fs/btrfs/relocation.c  | 453 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.h  |   5 +
 fs/btrfs/volumes.c     |  57 ++++--
 fs/btrfs/volumes.h     |   6 +
 10 files changed, 678 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4962d17a175e..0143b0290a72 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1067,6 +1067,29 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	return btrfs_del_item(trans, root, path);
 }
 
+void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *bg)
+{
+	int factor = btrfs_bg_type_to_factor(bg->flags);
+
+	spin_lock(&bg->space_info->lock);
+
+	if (btrfs_test_opt(bg->fs_info, ENOSPC_DEBUG)) {
+		WARN_ON(bg->space_info->total_bytes < bg->length);
+		WARN_ON(bg->space_info->bytes_readonly
+			< bg->length - bg->zone_unusable);
+		WARN_ON(bg->space_info->bytes_zone_unusable
+			< bg->zone_unusable);
+		WARN_ON(bg->space_info->disk_total < bg->length * factor);
+	}
+	bg->space_info->total_bytes -= bg->length;
+	bg->space_info->bytes_readonly -= (bg->length - bg->zone_unusable);
+	btrfs_space_info_update_bytes_zone_unusable(bg->space_info,
+						    -bg->zone_unusable);
+	bg->space_info->disk_total -= bg->length * factor;
+
+	spin_unlock(&bg->space_info->lock);
+}
+
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     struct btrfs_chunk_map *map)
 {
@@ -1078,7 +1101,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	struct kobject *kobj = NULL;
 	int ret;
 	int index;
-	int factor;
 	struct btrfs_caching_control *caching_ctl = NULL;
 	bool remove_map;
 	bool remove_rsv = false;
@@ -1087,7 +1109,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (!block_group)
 		return -ENOENT;
 
-	BUG_ON(!block_group->ro);
+	BUG_ON(!block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED));
 
 	trace_btrfs_remove_block_group(block_group);
 	/*
@@ -1099,7 +1121,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 				  block_group->length);
 
 	index = btrfs_bg_flags_to_raid_index(block_group->flags);
-	factor = btrfs_bg_type_to_factor(block_group->flags);
 
 	/* make sure this block group isn't part of an allocation cluster */
 	cluster = &fs_info->data_alloc_cluster;
@@ -1223,26 +1244,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	spin_lock(&block_group->space_info->lock);
 	list_del_init(&block_group->ro_list);
-
-	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
-		WARN_ON(block_group->space_info->total_bytes
-			< block_group->length);
-		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->length - block_group->zone_unusable);
-		WARN_ON(block_group->space_info->bytes_zone_unusable
-			< block_group->zone_unusable);
-		WARN_ON(block_group->space_info->disk_total
-			< block_group->length * factor);
-	}
-	block_group->space_info->total_bytes -= block_group->length;
-	block_group->space_info->bytes_readonly -=
-		(block_group->length - block_group->zone_unusable);
-	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
-						    -block_group->zone_unusable);
-	block_group->space_info->disk_total -= block_group->length * factor;
-
 	spin_unlock(&block_group->space_info->lock);
 
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED))
+		btrfs_remove_bg_from_sinfo(block_group);
+
 	/*
 	 * Remove the free space for the block group from the free space tree
 	 * and the block group's item from the extent tree before marking the
@@ -1576,8 +1582,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
-		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
-		    list_is_singular(&block_group->list)) {
+		if (btrfs_is_block_group_used(block_group) ||
+		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
+		    list_is_singular(&block_group->list) ||
+		    test_bit(BLOCK_GROUP_FLAG_FULLY_REMAPPED, &block_group->runtime_flags)) {
 			/*
 			 * We want to bail if we made new allocations or have
 			 * outstanding allocations in this block group.  We do
@@ -1618,9 +1626,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * needing to allocate extents from the block group.
 		 */
 		used = btrfs_space_info_used(space_info, true);
-		if ((space_info->total_bytes - block_group->length < used &&
-		     block_group->zone_unusable < block_group->length) ||
-		    has_unwritten_metadata(block_group)) {
+		if (((space_info->total_bytes - block_group->length < used &&
+		      block_group->zone_unusable < block_group->length) ||
+		     has_unwritten_metadata(block_group)) &&
+		    !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
@@ -1785,6 +1794,12 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 		btrfs_get_block_group(bg);
 		trace_btrfs_add_unused_block_group(bg);
 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
+	} else if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+		   bg->identity_remap_count == 0) {
+		/*
+		 * Leave fully remapped block groups on the
+		 * fully_remapped_bgs list.
+		 */
 	} else if (!test_bit(BLOCK_GROUP_FLAG_NEW, &bg->runtime_flags)) {
 		/* Pull out the block group from the reclaim_bgs list. */
 		trace_btrfs_add_unused_block_group(bg);
@@ -4594,6 +4609,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		list_del_init(&block_group->bg_list);
 		btrfs_put_block_group(block_group);
 	}
+
+	while (!list_empty(&info->fully_remapped_bgs)) {
+		block_group = list_first_entry(&info->fully_remapped_bgs,
+					       struct btrfs_block_group,
+					       bg_list);
+		list_del_init(&block_group->bg_list);
+		btrfs_put_block_group(block_group);
+	}
 	spin_unlock(&info->unused_bgs_lock);
 
 	spin_lock(&info->zone_active_bgs_lock);
@@ -4781,3 +4804,26 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
 		return false;
 	return true;
 }
+
+void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
+				  struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+
+	/*
+	 * The block group might already be on the unused_bgs list, remove it
+	 * if it is. It'll get readded after the async discard worker finishes,
+	 * or in btrfs_handle_fully_remapped_bgs() if we're not using async
+	 * discard.
+	 */
+	if (!list_empty(&bg->bg_list))
+		list_del(&bg->bg_list);
+	else
+		btrfs_get_block_group(bg);
+
+	list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
+
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4cee3448ded3..436d51a707a9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -92,6 +92,7 @@ enum btrfs_block_group_flags {
 	 * transaction.
 	 */
 	BLOCK_GROUP_FLAG_NEW,
+	BLOCK_GROUP_FLAG_FULLY_REMAPPED,
 };
 
 enum btrfs_caching_type {
@@ -336,6 +337,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group,
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
+void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *bg);
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     struct btrfs_chunk_map *map);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
@@ -407,5 +409,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class);
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
+void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
+				  struct btrfs_trans_handle *trans);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b03654ee91f5..ba500e3bf0d8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1495,6 +1495,10 @@ static int cleaner_kthread(void *arg)
 		 */
 		btrfs_run_defrag_inodes(fs_info);
 
+		if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
+		    !btrfs_test_opt(fs_info, DISCARD_ASYNC))
+			btrfs_handle_fully_remapped_bgs(fs_info);
+
 		/*
 		 * Acquires fs_info->reclaim_bgs_lock to avoid racing
 		 * with relocation (btrfs_relocate_chunk) and relocation
@@ -2835,6 +2839,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
 	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
+	INIT_LIST_HEAD(&fs_info->fully_remapped_bgs);
 	INIT_LIST_HEAD(&fs_info->zone_active_bgs);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
@@ -2890,6 +2895,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->chunk_mutex);
 	mutex_init(&fs_info->transaction_kthread_mutex);
 	mutex_init(&fs_info->cleaner_mutex);
+	mutex_init(&fs_info->remap_mutex);
 	mutex_init(&fs_info->ro_block_group_mutex);
 	init_rwsem(&fs_info->commit_root_sem);
 	init_rwsem(&fs_info->cleanup_work_sem);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3868a295be62..fef85ade017c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -41,6 +41,7 @@
 #include "tree-checker.h"
 #include "raid-stripe-tree.h"
 #include "delayed-inode.h"
+#include "relocation.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2844,6 +2845,73 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Complete the remapping of a block group by removing its chunk stripes and
+ * device extents, and adding it to the unused list if there's no longer any
+ * extents nominally within it.
+ */
+int btrfs_complete_bg_remapping(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_chunk_map *map;
+	int ret;
+
+	map = btrfs_get_chunk_map(fs_info, bg->start, 1);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	ret = btrfs_last_identity_remap_gone(map, bg);
+	if (ret) {
+		btrfs_free_chunk_map(map);
+		return ret;
+	}
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
+		if (!list_empty(&bg->bg_list)) {
+			list_del_init(&bg->bg_list);
+			btrfs_put_block_group(bg);
+		}
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		btrfs_mark_bg_unused(bg);
+	}
+
+	return 0;
+}
+
+void btrfs_handle_fully_remapped_bgs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_group *bg;
+	int ret;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	while (!list_empty(&fs_info->fully_remapped_bgs)) {
+		bg = list_first_entry(&fs_info->fully_remapped_bgs,
+				      struct btrfs_block_group, bg_list);
+		list_del_init(&bg->bg_list);
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		ret = btrfs_complete_bg_remapping(bg);
+		if (ret) {
+			btrfs_put_block_group(bg);
+			return;
+		}
+
+		btrfs_put_block_group(bg);
+		spin_lock(&fs_info->unused_bgs_lock);
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
+
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2996,11 +3064,23 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
 }
 
 static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
-				     u64 bytenr, struct btrfs_squota_delta *delta)
+				     u64 bytenr, struct btrfs_squota_delta *delta,
+				     struct btrfs_path *path)
 {
 	int ret;
+	bool remapped = false;
 	u64 num_bytes = delta->num_bytes;
 
+	/* Returns 1 on success and 0 on no-op. */
+	ret = btrfs_remove_extent_from_remap_tree(trans, path, bytenr,
+						  num_bytes);
+	if (unlikely(ret < 0)) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	} else if (ret == 1) {
+		remapped = true;
+	}
+
 	if (delta->is_data) {
 		struct btrfs_root *csum_root;
 
@@ -3024,10 +3104,16 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
-	if (unlikely(ret)) {
-		btrfs_abort_transaction(trans, ret);
-		return ret;
+	/*
+	 * If remapped, FST has already been taken care of in
+	 * remove_range_from_remap_tree().
+	 */
+	if (!remapped) {
+		ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
+		if (unlikely(ret)) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 
 	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
@@ -3386,7 +3472,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		ret = do_free_extent_accounting(trans, bytenr, &delta);
+		ret = do_free_extent_accounting(trans, bytenr, &delta, path);
 	}
 	btrfs_release_path(path);
 
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 71bb8109c969..d7b6aeb63656 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -163,5 +163,7 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
+void btrfs_handle_fully_remapped_bgs(struct btrfs_fs_info *fs_info);
+int btrfs_complete_bg_remapping(struct btrfs_block_group *bg);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index af11f2ce310a..b59bda3f8e62 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -579,6 +579,7 @@ struct btrfs_fs_info {
 	struct mutex transaction_kthread_mutex;
 	struct mutex cleaner_mutex;
 	struct mutex chunk_mutex;
+	struct mutex remap_mutex;
 
 	/*
 	 * This is taken to make sure we don't set block groups ro after the
@@ -832,10 +833,11 @@ struct btrfs_fs_info {
 	struct list_head reclaim_bgs;
 	int bg_reclaim_threshold;
 
-	/* Protects the lists unused_bgs and reclaim_bgs. */
+	/* Protects the lists unused_bgs, reclaim_bgs, and fully_remapped_bgs. */
 	spinlock_t unused_bgs_lock;
 	/* Protected by unused_bgs_lock. */
 	struct list_head unused_bgs;
+	struct list_head fully_remapped_bgs;
 	struct mutex unused_bg_unpin_mutex;
 	/* Protect block groups that are going to be deleted */
 	struct mutex reclaim_bgs_lock;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 525f45c668f6..e47234d5a156 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -37,6 +37,7 @@
 #include "super.h"
 #include "tree-checker.h"
 #include "raid-stripe-tree.h"
+#include "free-space-tree.h"
 
 /*
  * Relocation overview
@@ -3859,6 +3860,184 @@ static const char *stage_to_string(enum reloc_stage stage)
 	return "unknown";
 }
 
+static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
+					   struct btrfs_block_group *bg,
+					   s64 diff)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	bool bg_already_dirty = true, mark_unused = false;
+
+	spin_lock(&bg->lock);
+
+	bg->remap_bytes += diff;
+
+	if (bg->used == 0 && bg->remap_bytes == 0)
+		mark_unused = true;
+
+	spin_unlock(&bg->lock);
+
+	if (mark_unused)
+		btrfs_mark_bg_unused(bg);
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
+		bg_already_dirty = false;
+		btrfs_get_block_group(bg);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
+}
+
+static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
+				struct btrfs_chunk_map *chunk_map,
+				struct btrfs_path *path)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_chunk *chunk;
+	int ret;
+
+	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+	key.type = BTRFS_CHUNK_ITEM_KEY;
+	key.offset = chunk_map->start;
+
+	btrfs_reserve_chunk_metadata(trans, false);
+
+	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
+				0, 1);
+	if (ret) {
+		if (ret == 1) {
+			btrfs_release_path(path);
+			ret = -ENOENT;
+		}
+		btrfs_trans_release_chunk_metadata(trans);
+		return ret;
+	}
+
+	leaf = path->nodes[0];
+
+	chunk = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
+	btrfs_set_chunk_num_stripes(leaf, chunk, 0);
+	btrfs_set_chunk_sub_stripes(leaf, chunk, 0);
+
+	btrfs_truncate_item(trans, path, offsetof(struct btrfs_chunk, stripe),
+			    1);
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	btrfs_release_path(path);
+	btrfs_trans_release_chunk_metadata(trans);
+
+	return 0;
+}
+
+int btrfs_last_identity_remap_gone(struct btrfs_chunk_map *chunk_map,
+				   struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_trans_handle *trans;
+	int ret;
+	unsigned int num_items;
+	BTRFS_PATH_AUTO_FREE(path);
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/*
+	 * One item for each entry we're removing in the dev extents tree, and
+	 * another for each device. DUP chunks are all on one device,
+	 * everything else has one device per stripe.
+	 */
+	if (bg->flags & BTRFS_BLOCK_GROUP_DUP)
+		num_items = chunk_map->num_stripes + 1;
+	else
+		num_items = 2 * chunk_map->num_stripes;
+
+	trans = btrfs_start_transaction_fallback_global_rsv(fs_info->tree_root,
+							    num_items);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	ret = btrfs_remove_dev_extents(trans, chunk_map);
+	if (unlikely(ret)) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	mutex_lock(&trans->fs_info->chunk_mutex);
+
+	for (unsigned int i = 0; i < chunk_map->num_stripes; i++) {
+		ret = btrfs_update_device(trans, chunk_map->stripes[i].dev);
+		if (unlikely(ret)) {
+			mutex_unlock(&trans->fs_info->chunk_mutex);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&trans->fs_info->chunk_mutex);
+
+	write_lock(&trans->fs_info->mapping_tree_lock);
+	btrfs_chunk_map_device_clear_bits(chunk_map, CHUNK_ALLOCATED);
+	write_unlock(&trans->fs_info->mapping_tree_lock);
+
+	btrfs_remove_bg_from_sinfo(bg);
+
+	ret = remove_chunk_stripes(trans, chunk_map, path);
+	if (unlikely(ret)) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
+				        struct btrfs_block_group *bg, int delta)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	bool bg_already_dirty = true, mark_fully_remapped = false;
+
+	WARN_ON(delta < 0 && -delta > bg->identity_remap_count);
+
+	spin_lock(&bg->lock);
+
+	bg->identity_remap_count += delta;
+
+	if (bg->identity_remap_count == 0 &&
+	    !test_bit(BLOCK_GROUP_FLAG_FULLY_REMAPPED, &bg->runtime_flags)) {
+		set_bit(BLOCK_GROUP_FLAG_FULLY_REMAPPED, &bg->runtime_flags);
+		mark_fully_remapped = true;
+	}
+
+	spin_unlock(&bg->lock);
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
+		bg_already_dirty = false;
+		btrfs_get_block_group(bg);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
+
+	if (mark_fully_remapped)
+		btrfs_mark_bg_fully_remapped(bg, trans);
+}
+
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length)
 {
@@ -4467,3 +4646,277 @@ u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info)
 		logical = fs_info->reloc_ctl->block_group->start;
 	return logical;
 }
+
+static int insert_remap_item(struct btrfs_trans_handle *trans,
+			     struct btrfs_path *path, u64 old_addr, u64 length,
+			     u64 new_addr)
+{
+	int ret;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key key;
+	struct btrfs_remap_item remap = { 0 };
+
+	if (old_addr == new_addr) {
+		/* Add new identity remap item. */
+
+		key.objectid = old_addr;
+		key.type = BTRFS_IDENTITY_REMAP_KEY;
+		key.offset = length;
+
+		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
+					      path, &key, 0);
+		if (ret)
+			return ret;
+	} else {
+		/* Add new remap item. */
+
+		key.objectid = old_addr;
+		key.type = BTRFS_REMAP_KEY;
+		key.offset = length;
+
+		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
+					      path, &key,
+					      sizeof(struct btrfs_remap_item));
+		if (ret)
+			return ret;
+
+		btrfs_set_stack_remap_address(&remap, new_addr);
+
+		write_extent_buffer(path->nodes[0], &remap,
+			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+			sizeof(struct btrfs_remap_item));
+
+		btrfs_release_path(path);
+
+		/* Add new backref item. */
+
+		key.objectid = new_addr;
+		key.type = BTRFS_REMAP_BACKREF_KEY;
+		key.offset = length;
+
+		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
+					      path, &key,
+					      sizeof(struct btrfs_remap_item));
+		if (ret)
+			return ret;
+
+		btrfs_set_stack_remap_address(&remap, old_addr);
+
+		write_extent_buffer(path->nodes[0], &remap,
+			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+			sizeof(struct btrfs_remap_item));
+	}
+
+	btrfs_release_path(path);
+
+	return 0;
+}
+
+/*
+ * Punch a hole in the remap item or identity remap item pointed to by path,
+ * for the range [hole_start, hole_start + hole_length).
+ */
+static int remove_range_from_remap_tree(struct btrfs_trans_handle *trans,
+					struct btrfs_path *path,
+					struct btrfs_block_group *bg,
+					u64 hole_start, u64 hole_length)
+{
+	int ret;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_key key;
+	u64 hole_end, new_addr, remap_start, remap_length, remap_end;
+	u64 overlap_length;
+	bool is_identity_remap;
+	int identity_count_delta = 0;
+
+	hole_end = hole_start + hole_length;
+
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+	is_identity_remap = key.type == BTRFS_IDENTITY_REMAP_KEY;
+
+	remap_start = key.objectid;
+	remap_length = key.offset;
+
+	remap_end = remap_start + remap_length;
+
+	if (is_identity_remap) {
+		new_addr = remap_start;
+	} else {
+		struct btrfs_remap_item *remap_ptr;
+
+		remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
+					   struct btrfs_remap_item);
+		new_addr = btrfs_remap_address(leaf, remap_ptr);
+	}
+
+	/* Delete old item. */
+
+	ret = btrfs_del_item(trans, fs_info->remap_root, path);
+
+	btrfs_release_path(path);
+
+	if (ret)
+		return ret;
+
+	if (is_identity_remap) {
+		identity_count_delta = -1;
+	} else {
+		/* Remove backref. */
+
+		key.objectid = new_addr;
+		key.type = BTRFS_REMAP_BACKREF_KEY;
+		key.offset = remap_length;
+
+		ret = btrfs_search_slot(trans, fs_info->remap_root,
+					&key, path, -1, 1);
+		if (ret) {
+			if (ret == 1) {
+				btrfs_release_path(path);
+				ret = -ENOENT;
+			}
+			return ret;
+		}
+
+		ret = btrfs_del_item(trans, fs_info->remap_root, path);
+
+		btrfs_release_path(path);
+
+		if (ret)
+			return ret;
+	}
+
+	/* If hole_start > remap_start, re-add the start of the remap item. */
+	if (hole_start > remap_start) {
+		ret = insert_remap_item(trans, path, remap_start,
+					hole_start - remap_start, new_addr);
+		if (ret)
+			return ret;
+
+		if (is_identity_remap)
+			identity_count_delta++;
+	}
+
+	/* If hole_end < remap_end, re-add the end of the remap item. */
+	if (hole_end < remap_end) {
+		ret = insert_remap_item(trans, path, hole_end,
+				remap_end - hole_end,
+				hole_end - remap_start + new_addr);
+		if (ret)
+			return ret;
+
+		if (is_identity_remap)
+			identity_count_delta++;
+	}
+
+	if (identity_count_delta != 0)
+		adjust_identity_remap_count(trans, bg, identity_count_delta);
+
+	overlap_length = min_t(u64, hole_end, remap_end) -
+			 max_t(u64, hole_start, remap_start);
+
+	if (!is_identity_remap) {
+		struct btrfs_block_group *dest_bg;
+
+		dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
+
+		adjust_block_group_remap_bytes(trans, dest_bg, -overlap_length);
+
+		btrfs_put_block_group(dest_bg);
+
+		ret = btrfs_add_to_free_space_tree(trans,
+					     hole_start - remap_start + new_addr,
+					     overlap_length);
+		if (ret)
+			return ret;
+	}
+
+	ret = overlap_length;
+
+	return ret;
+}
+
+/*
+ * Returns 1 if remove_range_from_remap_tree() has been called successfully,
+ * 0 if block group wasn't remapped, and a negative number on error.
+ */
+int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
+					struct btrfs_path *path,
+					u64 bytenr, u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_key key, found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_block_group *bg;
+	int ret, length;
+
+	if (!(btrfs_super_incompat_flags(fs_info->super_copy) &
+	      BTRFS_FEATURE_INCOMPAT_REMAP_TREE))
+		return 0;
+
+	bg = btrfs_lookup_block_group(fs_info, bytenr);
+	if (!bg)
+		return 0;
+
+	mutex_lock(&fs_info->remap_mutex);
+
+	if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
+		mutex_unlock(&fs_info->remap_mutex);
+		btrfs_put_block_group(bg);
+		return 0;
+	}
+
+	do {
+		key.objectid = bytenr;
+		key.type = (u8)-1;
+		key.offset = (u64)-1;
+
+		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
+					-1, 1);
+		if (ret < 0)
+			goto end;
+
+		leaf = path->nodes[0];
+
+		if (path->slots[0] == 0) {
+			ret = -ENOENT;
+			goto end;
+		}
+
+		path->slots[0]--;
+
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		if (found_key.type != BTRFS_IDENTITY_REMAP_KEY &&
+		    found_key.type != BTRFS_REMAP_KEY) {
+			ret = -ENOENT;
+			goto end;
+		}
+
+		if (bytenr < found_key.objectid ||
+		    bytenr >= found_key.objectid + found_key.offset) {
+			ret = -ENOENT;
+			goto end;
+		}
+
+		length = remove_range_from_remap_tree(trans, path, bg, bytenr,
+						      num_bytes);
+		if (length < 0) {
+			ret = length;
+			goto end;
+		}
+
+		bytenr += length;
+		num_bytes -= length;
+	} while (num_bytes > 0);
+
+	ret = 1;
+
+end:
+	mutex_unlock(&fs_info->remap_mutex);
+
+	btrfs_put_block_group(bg);
+	btrfs_release_path(path);
+	return ret;
+}
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index b2ba83966650..0f4874f815db 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -33,5 +33,10 @@ bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
 int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
 			  u64 *length);
+int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
+					struct btrfs_path *path,
+					u64 bytenr, u64 num_bytes);
+int btrfs_last_identity_remap_gone(struct btrfs_chunk_map *chunk_map,
+				   struct btrfs_block_group *bg);
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 557ce56df800..46c5acc96725 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2923,8 +2923,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
-					struct btrfs_device *device)
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device)
 {
 	int ret;
 	BTRFS_PATH_AUTO_FREE(path);
@@ -3222,25 +3222,13 @@ static int remove_chunk_item(struct btrfs_trans_handle *trans,
 	return btrfs_free_chunk(trans, chunk_offset);
 }
 
-int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
+int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
+			     struct btrfs_chunk_map *map)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_chunk_map *map;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	u64 dev_extent_len = 0;
 	int i, ret = 0;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-
-	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
-	if (IS_ERR(map)) {
-		/*
-		 * This is a logic error, but we don't want to just rely on the
-		 * user having built with ASSERT enabled, so if ASSERT doesn't
-		 * do anything we still error out.
-		 */
-		DEBUG_WARN("errr %ld reading chunk map at offset %llu",
-			   PTR_ERR(map), chunk_offset);
-		return PTR_ERR(map);
-	}
 
 	/*
 	 * First delete the device extent items from the devices btree.
@@ -3261,7 +3249,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		if (unlikely(ret)) {
 			mutex_unlock(&fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
-			goto out;
+			return ret;
 		}
 
 		if (device->bytes_used > 0) {
@@ -3281,6 +3269,31 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
+	return 0;
+}
+
+int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_chunk_map *map;
+	int ret;
+
+	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	if (IS_ERR(map)) {
+		/*
+		 * This is a logic error, but we don't want to just rely on the
+		 * user having built with ASSERT enabled, so if ASSERT doesn't
+		 * do anything we still error out.
+		 */
+		DEBUG_WARN("errr %ld reading chunk map at offset %llu",
+			   PTR_ERR(map), chunk_offset);
+		return PTR_ERR(map);
+	}
+
+	ret = btrfs_remove_dev_extents(trans, map);
+	if (ret)
+		goto out;
+
 	/*
 	 * We acquire fs_info->chunk_mutex for 2 reasons:
 	 *
@@ -5417,7 +5430,7 @@ static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int
 	}
 }
 
-static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
+void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
 {
 	for (int i = 0; i < map->num_stripes; i++) {
 		struct btrfs_io_stripe *stripe = &map->stripes[i];
@@ -5434,7 +5447,7 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
 	write_lock(&fs_info->mapping_tree_lock);
 	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
 	RB_CLEAR_NODE(&map->rb_node);
-	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
+	btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
 	write_unlock(&fs_info->mapping_tree_lock);
 
 	/* Once for the tree reference. */
@@ -5470,7 +5483,7 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
 		return -EEXIST;
 	}
 	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
-	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
+	btrfs_chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
 	write_unlock(&fs_info->mapping_tree_lock);
 
 	return 0;
@@ -5826,7 +5839,7 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
 		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
 		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
 		RB_CLEAR_NODE(&map->rb_node);
-		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
+		btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
 		/* Once for the tree ref. */
 		btrfs_free_chunk_map(map);
 		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4117fabb248b..ccf0a459180d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -794,6 +794,8 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);
 int btrfs_nr_parity_stripes(u64 type);
 int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg);
+int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
+			     struct btrfs_chunk_map *map);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
@@ -905,6 +907,10 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device);
+void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map,
+				       unsigned int bits);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
-- 
2.51.2


