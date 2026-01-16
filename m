Return-Path: <linux-btrfs+bounces-20622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913CCD2F9CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 11:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E48C308952F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 10:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3830DEDC;
	Fri, 16 Jan 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMecUBR/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534131D730
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559578; cv=none; b=FteORGu2fzQDjSHYKbWkbl/ygFG1O+UtJQ0xwsF3BuonyskhJkfjV0FmxkaxdMQI2/oNxqj8g6Ot9rRiyXDmuMi5fIPSZO6KqpxD6xAhp8VlHdVVEnG5iJIcuqwEASHxFzZ/fVJG42XJ+R3UqPWz+13hUsUFKCZyAtpSM1mRvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559578; c=relaxed/simple;
	bh=IMcfvbDdX9baFFfAWEbW6b96ibxVXF4KzU2r+KH0S+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nJBDfCO1QYy9IN63wulQmAYKbzDLVb8H2aW2G6E1SVgV6IxDMksndkwzJXzTsxwJHASPh6HZ5Owo3Kkh+wS44Fyx8YNfJ4lclvjVeTGMO59qCutLbfbBsLu3C4LMRPVywY/2Grs5CensKcJZz/gC0MDzThqDYwp4OxefN3VkeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMecUBR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390E5C19423
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768559577;
	bh=IMcfvbDdX9baFFfAWEbW6b96ibxVXF4KzU2r+KH0S+M=;
	h=From:To:Subject:Date:From;
	b=DMecUBR/Zgs4EHriCVtSvmMsiL6JykSndqzy685IC6FQllnobCGyxM2QtzkHo795Y
	 LeYaA4VtSLsRUbjAOb5gPrqqgefQI6W2N7CGtwEQQG5g0yRlkSvGJPamYDh6OVEABJ
	 YpCrE4IPR7w4TyvVf6ENsusSbrZ6iik4DhlM3SWIGnPMc213LH2TAygRYCTyWANGRl
	 gPg/PMl+lPH5sEa3601oOcWVX6m3jC9BZ1/F3+P3r1kQZepr9gByV06DpF0GB+7bgg
	 S3WbefBpfjJpBmNtq4cKD8i9OHEAMIgPcUBrh99cHrYYE6BoHNBz6wx0suNGRZ0MAl
	 yHk2I5sAaGcgw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Date: Fri, 16 Jan 2026 10:32:54 +0000
Message-ID: <f7afa4b2c9350b08695cc34cd917dea3bf766bce.1768559305.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a helper to calculate a block group's exclusive end offset, but
we only use it in some places. Update every site that open codes the
calculation to use the helper.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c                 | 21 ++++++++--------
 fs/btrfs/extent-tree.c                 |  9 ++++---
 fs/btrfs/free-space-cache.c            |  8 +++----
 fs/btrfs/free-space-tree.c             | 33 ++++++++++----------------
 fs/btrfs/scrub.c                       |  9 +++----
 fs/btrfs/tests/free-space-tree-tests.c |  4 ++--
 fs/btrfs/zoned.c                       |  9 +++----
 7 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9d64cc60a42b..9c5d930c22a9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -239,7 +239,7 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 
 	while (n) {
 		cache = rb_entry(n, struct btrfs_block_group, cache_node);
-		end = cache->start + cache->length - 1;
+		end = btrfs_block_group_end(cache) - 1;
 		start = cache->start;
 
 		if (bytenr < start) {
@@ -292,7 +292,7 @@ struct btrfs_block_group *btrfs_next_block_group(
 
 	/* If our block group was removed, we need a full search. */
 	if (RB_EMPTY_NODE(&cache->cache_node)) {
-		const u64 next_bytenr = cache->start + cache->length;
+		const u64 next_bytenr = btrfs_block_group_end(cache);
 
 		read_unlock(&fs_info->block_group_cache_lock);
 		btrfs_put_block_group(cache);
@@ -595,7 +595,7 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *extent_root;
 	u64 search_offset;
-	u64 search_end = block_group->start + block_group->length;
+	const u64 search_end = btrfs_block_group_end(block_group);
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key search_key;
 	int ret = 0;
@@ -711,6 +711,7 @@ static int load_block_group_size_class(struct btrfs_caching_control *caching_ctl
 static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 {
 	struct btrfs_block_group *block_group = caching_ctl->block_group;
+	const u64 block_group_end = btrfs_block_group_end(block_group);
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *extent_root;
 	BTRFS_PATH_AUTO_FREE(path);
@@ -807,7 +808,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 			continue;
 		}
 
-		if (key.objectid >= block_group->start + block_group->length)
+		if (key.objectid >= block_group_end)
 			break;
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
@@ -836,9 +837,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 		path->slots[0]++;
 	}
 
-	ret = btrfs_add_new_free_space(block_group, last,
-				       block_group->start + block_group->length,
-				       NULL);
+	ret = btrfs_add_new_free_space(block_group, last, block_group_end, NULL);
 out:
 	return ret;
 }
@@ -846,7 +845,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
 {
 	btrfs_clear_extent_bit(&bg->fs_info->excluded_extents, bg->start,
-			       bg->start + bg->length - 1, EXTENT_DIRTY, NULL);
+			       btrfs_block_group_end(bg) - 1, EXTENT_DIRTY, NULL);
 }
 
 static noinline void caching_thread(struct btrfs_work *work)
@@ -2247,7 +2246,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 		while (nr--) {
 			u64 len = min_t(u64, stripe_len,
-				cache->start + cache->length - logical[nr]);
+					btrfs_block_group_end(cache) - logical[nr]);
 
 			cache->bytes_super += len;
 			ret = btrfs_set_extent_bit(&fs_info->excluded_extents,
@@ -2445,7 +2444,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	} else if (cache->used == 0) {
 		cache->cached = BTRFS_CACHE_FINISHED;
 		ret = btrfs_add_new_free_space(cache, cache->start,
-					       cache->start + cache->length, NULL);
+					       btrfs_block_group_end(cache), NULL);
 		btrfs_free_excluded_extents(cache);
 		if (ret)
 			goto error;
@@ -3695,7 +3694,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		return -ENOENT;
 
 	/* An extent can not span multiple block groups. */
-	ASSERT(bytenr + num_bytes <= cache->start + cache->length);
+	ASSERT(bytenr + num_bytes <= btrfs_block_group_end(cache));
 
 	space_info = cache->space_info;
 	factor = btrfs_bg_type_to_factor(cache->flags);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 89495e6f8269..3b5c25cd54f1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2755,8 +2755,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		u64 len;
 		bool readonly;
 
-		if (!cache ||
-		    start >= cache->start + cache->length) {
+		if (!cache || start >= btrfs_block_group_end(cache)) {
 			if (cache)
 				btrfs_put_block_group(cache);
 			total_unpinned = 0;
@@ -2772,7 +2771,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			empty_cluster <<= 1;
 		}
 
-		len = cache->start + cache->length - start;
+		len = btrfs_block_group_end(cache) - start;
 		len = min(len, end + 1 - start);
 
 		if (return_free_space)
@@ -4569,7 +4568,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 		/* move on to the next group */
 		if (ffe_ctl->search_start + ffe_ctl->num_bytes >
-		    block_group->start + block_group->length) {
+		    btrfs_block_group_end(block_group)) {
 			btrfs_add_free_space_unused(block_group,
 					    ffe_ctl->found_offset,
 					    ffe_ctl->num_bytes);
@@ -6533,7 +6532,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		}
 
 		start = max(range->start, cache->start);
-		end = min(range_end, cache->start + cache->length);
+		end = min(range_end, btrfs_block_group_end(cache));
 
 		if (end - start >= range->minlen) {
 			if (!btrfs_block_group_done(cache)) {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f0f72850fab2..a0af24d62810 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1200,6 +1200,7 @@ static noinline_for_stack int write_pinned_extent_entries(
 			    int *entries)
 {
 	u64 start, extent_start, extent_end, len;
+	const u64 block_group_end = btrfs_block_group_end(block_group);
 	struct extent_io_tree *unpin = NULL;
 	int ret;
 
@@ -1217,19 +1218,18 @@ static noinline_for_stack int write_pinned_extent_entries(
 
 	start = block_group->start;
 
-	while (start < block_group->start + block_group->length) {
+	while (start < block_group_end) {
 		if (!btrfs_find_first_extent_bit(unpin, start,
 						 &extent_start, &extent_end,
 						 EXTENT_DIRTY, NULL))
 			return 0;
 
 		/* This pinned extent is out of our range */
-		if (extent_start >= block_group->start + block_group->length)
+		if (extent_start >= block_group_end)
 			return 0;
 
 		extent_start = max(extent_start, start);
-		extent_end = min(block_group->start + block_group->length,
-				 extent_end + 1);
+		extent_end = min(block_group_end, extent_end + 1);
 		len = extent_end - extent_start;
 
 		*entries += 1;
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index ac092898130f..aab125144ea2 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -220,7 +220,7 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		return 0;
 
 	start = block_group->start;
-	end = block_group->start + block_group->length;
+	end = btrfs_block_group_end(block_group);
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -360,7 +360,7 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 		return 0;
 
 	start = block_group->start;
-	end = block_group->start + block_group->length;
+	end = btrfs_block_group_end(block_group);
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -667,7 +667,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * Read the bit for the block immediately after the extent of space if
 	 * that block is within the block group.
 	 */
-	if (end < block_group->start + block_group->length) {
+	if (end < btrfs_block_group_end(block_group)) {
 		/* The next block may be in the next bitmap. */
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		if (end >= key.objectid + key.offset) {
@@ -940,7 +940,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 right:
 	/* Search for a neighbor on the right. */
-	if (end == block_group->start + block_group->length)
+	if (end == btrfs_block_group_end(block_group))
 		goto insert;
 	key.objectid = end;
 	key.type = (u8)-1;
@@ -1106,7 +1106,7 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * highest, block group).
 	 */
 	start = block_group->start;
-	end = block_group->start + block_group->length;
+	end = btrfs_block_group_end(block_group);
 	while (ret == 0) {
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -1479,7 +1479,7 @@ int btrfs_remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	}
 
 	start = block_group->start;
-	end = block_group->start + block_group->length;
+	end = btrfs_block_group_end(block_group);
 
 	key.objectid = end - 1;
 	key.type = (u8)-1;
@@ -1532,24 +1532,21 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 				   struct btrfs_path *path,
 				   u32 expected_extent_count)
 {
-	struct btrfs_block_group *block_group;
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_block_group *block_group = caching_ctl->block_group;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_key key;
 	bool prev_bit_set = false;
 	/* Initialize to silence GCC. */
 	u64 extent_start = 0;
-	u64 end, offset;
+	const u64 end = btrfs_block_group_end(block_group);
+	u64 offset;
 	u64 total_found = 0;
 	u32 extent_count = 0;
 	int ret;
 
-	block_group = caching_ctl->block_group;
-	fs_info = block_group->fs_info;
 	root = btrfs_free_space_root(block_group);
 
-	end = block_group->start + block_group->length;
-
 	while (1) {
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
@@ -1615,21 +1612,17 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 				   struct btrfs_path *path,
 				   u32 expected_extent_count)
 {
-	struct btrfs_block_group *block_group;
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_block_group *block_group = caching_ctl->block_group;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_key key;
-	u64 end;
+	const u64 end = btrfs_block_group_end(block_group);
 	u64 total_found = 0;
 	u32 extent_count = 0;
 	int ret;
 
-	block_group = caching_ctl->block_group;
-	fs_info = block_group->fs_info;
 	root = btrfs_free_space_root(block_group);
 
-	end = block_group->start + block_group->length;
-
 	while (1) {
 		u64 space_added;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2372084cf6c5..0bd4aebe1687 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1688,9 +1688,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	scrub_stripe_reset_bitmaps(stripe);
 
 	/* The range must be inside the bg. */
-	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length,
+	ASSERT(logical_start >= bg->start && logical_end <= btrfs_block_group_end(bg),
 	       "bg->start=%llu logical_start=%llu logical_end=%llu end=%llu",
-	       bg->start, logical_start, logical_end, bg->start + bg->length);
+	       bg->start, logical_start, logical_end, btrfs_block_group_end(bg));
 
 	ret = find_first_extent_item(extent_root, extent_path, logical_start,
 				     logical_len);
@@ -2319,7 +2319,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	int ret = 0;
 
 	/* The range must be inside the bg */
-	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
+	ASSERT(logical_start >= bg->start && logical_end <= btrfs_block_group_end(bg));
 
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
@@ -2411,12 +2411,13 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
 	const u64 logical_increment = simple_stripe_full_stripe_len(map);
 	const u64 orig_logical = simple_stripe_get_logical(map, bg, stripe_index);
 	const u64 orig_physical = map->stripes[stripe_index].physical;
+	const u64 end = btrfs_block_group_end(bg);
 	const int mirror_num = simple_stripe_mirror_num(map, stripe_index);
 	u64 cur_logical = orig_logical;
 	u64 cur_physical = orig_physical;
 	int ret = 0;
 
-	while (cur_logical < bg->start + bg->length) {
+	while (cur_logical < end) {
 		/*
 		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
 		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index c8822edd32e2..8dee057f41fd 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -49,7 +49,7 @@ static int __check_free_space_extents(struct btrfs_trans_handle *trans,
 	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
 		if (path->slots[0] != 0)
 			goto invalid;
-		end = cache->start + cache->length;
+		end = btrfs_block_group_end(cache);
 		i = 0;
 		while (++path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
 			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
@@ -216,7 +216,7 @@ static int test_remove_end(struct btrfs_trans_handle *trans,
 	int ret;
 
 	ret = __btrfs_remove_from_free_space_tree(trans, cache, path,
-				    cache->start + cache->length - alignment,
+				    btrfs_block_group_end(cache) - alignment,
 				    alignment);
 	if (ret) {
 		test_err("could not remove free space");
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e861eef5cd8..d6a2480d5dc1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1231,6 +1231,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
+	const u64 bg_end = btrfs_block_group_end(cache);
 	int ret;
 	u64 length;
 
@@ -1253,7 +1254,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 	if (!path)
 		return -ENOMEM;
 
-	key.objectid = cache->start + cache->length;
+	key.objectid = bg_end;
 	key.type = 0;
 	key.offset = 0;
 
@@ -1282,7 +1283,7 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
 		length = fs_info->nodesize;
 
 	if (unlikely(!(found_key.objectid >= cache->start &&
-		       found_key.objectid + length <= cache->start + cache->length))) {
+		       found_key.objectid + length <= bg_end))) {
 		return -EUCLEAN;
 	}
 	*offset_ret = found_key.objectid + length - cache->start;
@@ -2028,7 +2029,7 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 
 	if (block_group) {
 		if (block_group->start > eb->start ||
-		    block_group->start + block_group->length <= eb->start) {
+		    btrfs_block_group_end(block_group) <= eb->start) {
 			btrfs_put_block_group(block_group);
 			block_group = NULL;
 			ctx->zoned_bg = NULL;
@@ -2248,7 +2249,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	const u64 end = block_group->start + block_group->length;
+	const u64 end = btrfs_block_group_end(block_group);
 	struct extent_buffer *eb;
 	unsigned long index, start = (block_group->start >> fs_info->nodesize_bits);
 
-- 
2.47.2


