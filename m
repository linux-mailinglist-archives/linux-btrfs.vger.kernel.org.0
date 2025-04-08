Return-Path: <linux-btrfs+bounces-12881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1867A813B9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0758C1BA7EE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F023E23F;
	Tue,  8 Apr 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSwll+Ae"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3F23DEAD
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133585; cv=none; b=ecHTAw5clbPyFppLJiQwEWYHEr/yfspgqjQ221R3PbDSKkCukvNBZsYLO3OWpysL+cDGx7nub378VsD9xkF8tNxfeDq20JyMzjNn/EudoxGPDAG5g9ZHdQdcHrwyEfVbwfOY742TVM6D1XQbye27lKUjpCXhYpbgujXe5ndBjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133585; c=relaxed/simple;
	bh=/LrqWAOhzY2V7+n6CKXVUDDz4cU/Uro7ycY7B+PWoVQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cebnvaRZB1C46PQuvy5T5rWDuuOHMBYVeWA7SsIaWujZro5j7KvkZpNlTrOLsHgbaEkBy9Gmt8i0tYystydDJtesyXYEYYaElk7dH3HcdR0VAb+PEYF5WUy//oxkrcohT8NH9TFZ4EDgeMj86J+lX6Ht8aR2omXAu2W7n+K3PEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSwll+Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72FCC4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133584;
	bh=/LrqWAOhzY2V7+n6CKXVUDDz4cU/Uro7ycY7B+PWoVQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JSwll+AefWv8cGnqEyUvxA7wQJqdjdgWKb+YuIgrzl0rY73zCOrQLpfaA6EGF2Mx2
	 GxOED7LrIZTevyf4O6SP1cHakh8JBeJUrVAPSgGjo74NETxjDuKo4hk02rrZyrPXdJ
	 GLluu3rxk6Yxs0gtcQajEJiFW/ySaMVnCS/BQ868SHMvyssAV9HXaH6KJXs2I+i5xR
	 stW3blJm0YQaoc1hEgh138WYaPMvh/Mw3YsVtOlsOzbeMLos6TA1WX96kXXuJQFONN
	 xC6GCedTKSQ+xxg0zWUQ6jDErTzKcgFz6PpKyVf8Q88C1V07jxT982aKwsN0gdM/c+
	 l8eCwFYNfHv1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: rename extent map functions to get block start, end and check if in tree
Date: Tue,  8 Apr 2025 18:32:55 +0100
Message-Id: <ff4d2bdb51fc46a0a232545120784234ed3396e1.1744130413.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744130413.git.fdmanana@suse.com>
References: <cover.1744130413.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These functions are exported and don't have a 'btrfs_' prefix in their
names, which goes against coding style conventions. Rename them to have
such prefix, making it clear they are from btrfs and avoiding pontential
collisions in the future with functions defined elsewhere outside btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c            |  4 +--
 fs/btrfs/defrag.c                 |  4 +--
 fs/btrfs/direct-io.c              |  4 +--
 fs/btrfs/extent_io.c              | 21 +++++++-------
 fs/btrfs/extent_map.c             | 48 +++++++++++++++----------------
 fs/btrfs/extent_map.h             |  6 ++--
 fs/btrfs/file.c                   |  6 ++--
 fs/btrfs/inode.c                  | 14 ++++-----
 fs/btrfs/tests/extent-map-tests.c | 14 ++++-----
 fs/btrfs/tests/inode-tests.c      | 27 ++++++++---------
 fs/btrfs/tree-log.c               |  4 +--
 11 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 09c7c35554a7..95344cb74d89 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -510,8 +510,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * to this compressed extent on disk.
 		 */
 		if (!em || cur < em->start ||
-		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
-		    (extent_map_block_start(em) >> SECTOR_SHIFT) !=
+		    (cur + fs_info->sectorsize > btrfs_extent_map_end(em)) ||
+		    (btrfs_extent_map_block_start(em) >> SECTOR_SHIFT) !=
 		    orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			btrfs_unlock_extent(tree, cur, page_end, NULL);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 5909740b2ce9..8cb225ab1c17 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1074,7 +1074,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 
 add:
 		last_is_target = true;
-		range_len = min(extent_map_end(em), start + len) - cur;
+		range_len = min(btrfs_extent_map_end(em), start + len) - cur;
 		/*
 		 * This one is a good target, check if it can be merged into
 		 * last range of the target list.
@@ -1105,7 +1105,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		list_add_tail(&new->list, target_list);
 
 next:
-		cur = extent_map_end(em);
+		cur = btrfs_extent_map_end(em);
 		free_extent_map(em);
 	}
 	if (ret < 0) {
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 045497c8118a..2daf0c524500 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -246,7 +246,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		else
 			type = BTRFS_ORDERED_NOCOW;
 		len = min(len, em->len - (start - em->start));
-		block_start = extent_map_block_start(em) + (start - em->start);
+		block_start = btrfs_extent_map_block_start(em) + (start - em->start);
 
 		if (can_nocow_extent(BTRFS_I(inode), start, &len, &file_extent,
 				     false) == 1) {
@@ -558,7 +558,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->type = IOMAP_HOLE;
 	} else {
-		iomap->addr = extent_map_block_start(em) + (start - em->start);
+		iomap->addr = btrfs_extent_map_block_start(em) + (start - em->start);
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7778feb88b62..391c5499a444 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -890,8 +890,8 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 
 	if (*em_cached) {
 		em = *em_cached;
-		if (extent_map_in_tree(em) && start >= em->start &&
-		    start < extent_map_end(em)) {
+		if (btrfs_extent_map_in_tree(em) && start >= em->start &&
+		    start < btrfs_extent_map_end(em)) {
 			refcount_inc(&em->refs);
 			return em;
 		}
@@ -967,7 +967,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			return PTR_ERR(em);
 		}
 		extent_offset = cur - em->start;
-		BUG_ON(extent_map_end(em) <= cur);
+		BUG_ON(btrfs_extent_map_end(em) <= cur);
 		BUG_ON(end < cur);
 
 		compress_type = btrfs_extent_map_compression(em);
@@ -975,12 +975,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
-			disk_bytenr = extent_map_block_start(em) + extent_offset;
+			disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
 
 		if (em->flags & EXTENT_FLAG_PREALLOC)
 			block_start = EXTENT_MAP_HOLE;
 		else
-			block_start = extent_map_block_start(em);
+			block_start = btrfs_extent_map_block_start(em);
 
 		/*
 		 * If we have a file range that points to a compressed extent
@@ -1537,13 +1537,13 @@ static int submit_one_sector(struct btrfs_inode *inode,
 		return PTR_ERR(em);
 
 	extent_offset = filepos - em->start;
-	em_end = extent_map_end(em);
+	em_end = btrfs_extent_map_end(em);
 	ASSERT(filepos <= em_end);
 	ASSERT(IS_ALIGNED(em->start, sectorsize));
 	ASSERT(IS_ALIGNED(em->len, sectorsize));
 
-	block_start = extent_map_block_start(em);
-	disk_bytenr = extent_map_block_start(em) + extent_offset;
+	block_start = btrfs_extent_map_block_start(em);
+	disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
 
 	ASSERT(!btrfs_extent_map_is_compressed(em));
 	ASSERT(block_start != EXTENT_MAP_HOLE);
@@ -2677,7 +2677,8 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 			break;
 		}
 		if (btrfs_test_range_bit_exists(io_tree, em->start,
-						extent_map_end(em) - 1, EXTENT_LOCKED))
+						btrfs_extent_map_end(em) - 1,
+						EXTENT_LOCKED))
 			goto next;
 		/*
 		 * If it's not in the list of modified extents, used by a fast
@@ -2708,7 +2709,7 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		/* Once for the inode's extent map tree. */
 		free_extent_map(em);
 next:
-		start = extent_map_end(em);
+		start = btrfs_extent_map_end(em);
 		write_unlock(&extent_tree->lock);
 
 		/* Once for us, for the lookup_extent_mapping() reference. */
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index ccf69308ffb2..e91ce1402473 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -63,7 +63,7 @@ void free_extent_map(struct extent_map *em)
 	if (!em)
 		return;
 	if (refcount_dec_and_test(&em->refs)) {
-		WARN_ON(extent_map_in_tree(em));
+		WARN_ON(btrfs_extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
 		kmem_cache_free(extent_map_cache, em);
 	}
@@ -102,19 +102,19 @@ static int tree_insert(struct rb_root *root, struct extent_map *em)
 
 		if (em->start < entry->start)
 			p = &(*p)->rb_left;
-		else if (em->start >= extent_map_end(entry))
+		else if (em->start >= btrfs_extent_map_end(entry))
 			p = &(*p)->rb_right;
 		else
 			return -EEXIST;
 	}
 
 	orig_parent = parent;
-	while (parent && em->start >= extent_map_end(entry)) {
+	while (parent && em->start >= btrfs_extent_map_end(entry)) {
 		parent = rb_next(parent);
 		entry = rb_entry(parent, struct extent_map, rb_node);
 	}
 	if (parent)
-		if (end > entry->start && em->start < extent_map_end(entry))
+		if (end > entry->start && em->start < btrfs_extent_map_end(entry))
 			return -EEXIST;
 
 	parent = orig_parent;
@@ -124,7 +124,7 @@ static int tree_insert(struct rb_root *root, struct extent_map *em)
 		entry = rb_entry(parent, struct extent_map, rb_node);
 	}
 	if (parent)
-		if (end > entry->start && em->start < extent_map_end(entry))
+		if (end > entry->start && em->start < btrfs_extent_map_end(entry))
 			return -EEXIST;
 
 	rb_link_node(&em->rb_node, orig_parent, p);
@@ -154,14 +154,14 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 
 		if (offset < entry->start)
 			n = n->rb_left;
-		else if (offset >= extent_map_end(entry))
+		else if (offset >= btrfs_extent_map_end(entry))
 			n = n->rb_right;
 		else
 			return n;
 	}
 
 	orig_prev = prev;
-	while (prev && offset >= extent_map_end(prev_entry)) {
+	while (prev && offset >= btrfs_extent_map_end(prev_entry)) {
 		prev = rb_next(prev);
 		prev_entry = rb_entry(prev, struct extent_map, rb_node);
 	}
@@ -195,7 +195,7 @@ static inline u64 extent_map_block_len(const struct extent_map *em)
 
 static inline u64 extent_map_block_end(const struct extent_map *em)
 {
-	const u64 block_start = extent_map_block_start(em);
+	const u64 block_start = btrfs_extent_map_block_start(em);
 	const u64 block_end = block_start + extent_map_block_len(em);
 
 	if (block_end < block_start)
@@ -230,7 +230,7 @@ static bool can_merge_extent_map(const struct extent_map *em)
 /* Check to see if two extent_map structs are adjacent and safe to merge. */
 static bool mergeable_maps(const struct extent_map *prev, const struct extent_map *next)
 {
-	if (extent_map_end(prev) != next->start)
+	if (btrfs_extent_map_end(prev) != next->start)
 		return false;
 
 	/*
@@ -242,7 +242,7 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 		return false;
 
 	if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)
-		return extent_map_block_start(next) == extent_map_block_end(prev);
+		return btrfs_extent_map_block_start(next) == extent_map_block_end(prev);
 
 	/* HOLES and INLINE extents. */
 	return next->disk_bytenr == prev->disk_bytenr;
@@ -454,7 +454,7 @@ void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 	lockdep_assert_held_write(&inode->extent_tree.lock);
 
 	em->flags &= ~EXTENT_FLAG_LOGGING;
-	if (extent_map_in_tree(em))
+	if (btrfs_extent_map_in_tree(em))
 		try_merge_map(inode, em);
 }
 
@@ -527,7 +527,7 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
 
 	em = rb_entry(rb_node, struct extent_map, rb_node);
 
-	if (strict && !(end > em->start && start < extent_map_end(em)))
+	if (strict && !(end > em->start && start < btrfs_extent_map_end(em)))
 		return NULL;
 
 	refcount_inc(&em->refs);
@@ -605,7 +605,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 	validate_extent_map(fs_info, new);
 
 	WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
-	ASSERT(extent_map_in_tree(cur));
+	ASSERT(btrfs_extent_map_in_tree(cur));
 	if (!(cur->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&cur->list);
 	rb_replace_node(&cur->rb_node, &new->rb_node, &tree->root);
@@ -651,7 +651,7 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 	u64 end;
 	u64 start_diff;
 
-	if (map_start < em->start || map_start >= extent_map_end(em))
+	if (map_start < em->start || map_start >= btrfs_extent_map_end(em))
 		return -EINVAL;
 
 	if (existing->start > map_start) {
@@ -662,10 +662,10 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
 		next = next_extent_map(prev);
 	}
 
-	start = prev ? extent_map_end(prev) : em->start;
+	start = prev ? btrfs_extent_map_end(prev) : em->start;
 	start = max_t(u64, start, em->start);
-	end = next ? next->start : extent_map_end(em);
-	end = min_t(u64, end, extent_map_end(em));
+	end = next ? next->start : btrfs_extent_map_end(em);
+	end = min_t(u64, end, btrfs_extent_map_end(em));
 	start_diff = start - em->start;
 	em->start = start;
 	em->len = end - start;
@@ -725,7 +725,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 		 * extent causing the -EEXIST.
 		 */
 		if (start >= existing->start &&
-		    start < extent_map_end(existing)) {
+		    start < btrfs_extent_map_end(existing)) {
 			free_extent_map(em);
 			*em_in = existing;
 			ret = 0;
@@ -743,7 +743,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 				*em_in = NULL;
 				btrfs_warn(fs_info,
 "extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu",
-					   existing->start, extent_map_end(existing),
+					   existing->start, btrfs_extent_map_end(existing),
 					   orig_start, orig_start + orig_len, start);
 			}
 			free_extent_map(existing);
@@ -834,7 +834,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 	while (em) {
 		/* extent_map_end() returns exclusive value (last byte + 1). */
-		const u64 em_end = extent_map_end(em);
+		const u64 em_end = btrfs_extent_map_end(em);
 		struct extent_map *next_em = NULL;
 		u64 gen;
 		unsigned long flags;
@@ -925,7 +925,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->ram_bytes = split->len;
 			}
 
-			if (extent_map_in_tree(em)) {
+			if (btrfs_extent_map_in_tree(em)) {
 				replace_extent_mapping(inode, em, split, modified);
 			} else {
 				int ret;
@@ -940,7 +940,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split = NULL;
 		}
 remove_em:
-		if (extent_map_in_tree(em)) {
+		if (btrfs_extent_map_in_tree(em)) {
 			/*
 			 * If the extent map is still in the tree it means that
 			 * either of the following is true:
@@ -1007,7 +1007,7 @@ int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 	struct extent_map_tree *tree = &inode->extent_tree;
 	int ret;
 
-	ASSERT(!extent_map_in_tree(new_em));
+	ASSERT(!btrfs_extent_map_in_tree(new_em));
 
 	/*
 	 * The caller has locked an appropriate file range in the inode's io
@@ -1093,7 +1093,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	/* Insert the middle extent_map. */
 	split_mid->start = em->start + pre;
 	split_mid->len = em->len - pre;
-	split_mid->disk_bytenr = extent_map_block_start(em) + pre;
+	split_mid->disk_bytenr = btrfs_extent_map_block_start(em) + pre;
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
 	split_mid->ram_bytes = split_mid->len;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 6aecb132c874..de7d14fbaee2 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -145,12 +145,12 @@ static inline bool btrfs_extent_map_is_compressed(const struct extent_map *em)
 			     EXTENT_FLAG_COMPRESS_ZSTD)) != 0;
 }
 
-static inline int extent_map_in_tree(const struct extent_map *em)
+static inline int btrfs_extent_map_in_tree(const struct extent_map *em)
 {
 	return !RB_EMPTY_NODE(&em->rb_node);
 }
 
-static inline u64 extent_map_block_start(const struct extent_map *em)
+static inline u64 btrfs_extent_map_block_start(const struct extent_map *em)
 {
 	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
 		if (btrfs_extent_map_is_compressed(em))
@@ -160,7 +160,7 @@ static inline u64 extent_map_block_start(const struct extent_map *em)
 	return em->disk_bytenr;
 }
 
-static inline u64 extent_map_end(const struct extent_map *em)
+static inline u64 btrfs_extent_map_end(const struct extent_map *em)
 {
 	if (em->start + em->len < em->start)
 		return (u64)-1;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 57c5d12a0ff3..b5f262536bc5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2915,7 +2915,7 @@ static int btrfs_zero_range(struct inode *inode,
 		ASSERT(IS_ALIGNED(alloc_start, sectorsize));
 		len = offset + len - alloc_start;
 		offset = alloc_start;
-		alloc_hint = extent_map_block_start(em) + em->len;
+		alloc_hint = btrfs_extent_map_block_start(em) + em->len;
 	}
 	free_extent_map(em);
 
@@ -3143,8 +3143,8 @@ static long btrfs_fallocate(struct file *file, int mode,
 			ret = PTR_ERR(em);
 			break;
 		}
-		last_byte = min(extent_map_end(em), alloc_end);
-		actual_end = min_t(u64, extent_map_end(em), offset + len);
+		last_byte = min(btrfs_extent_map_end(em), alloc_end);
+		actual_end = min_t(u64, btrfs_extent_map_end(em), offset + len);
 		last_byte = ALIGN(last_byte, blocksize);
 		if (em->disk_bytenr == EXTENT_MAP_HOLE ||
 		    (cur_offset >= inode->i_size &&
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d9c60bf4a18d..3a9877ee91b7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1214,11 +1214,11 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 			free_extent_map(em);
 			em = search_extent_mapping(em_tree, 0, 0);
 			if (em && em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-				alloc_hint = extent_map_block_start(em);
+				alloc_hint = btrfs_extent_map_block_start(em);
 			if (em)
 				free_extent_map(em);
 		} else {
-			alloc_hint = extent_map_block_start(em);
+			alloc_hint = btrfs_extent_map_block_start(em);
 			free_extent_map(em);
 		}
 	}
@@ -2678,7 +2678,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 					   search_start + em_len - 1,
 					   EXTENT_DELALLOC_NEW, cached_state);
 next:
-		search_start = extent_map_end(em);
+		search_start = btrfs_extent_map_end(em);
 		free_extent_map(em);
 		if (ret)
 			return ret;
@@ -5005,7 +5005,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			em = NULL;
 			break;
 		}
-		last_byte = min(extent_map_end(em), block_end);
+		last_byte = min(btrfs_extent_map_end(em), block_end);
 		last_byte = ALIGN(last_byte, fs_info->sectorsize);
 		hole_size = last_byte - cur_offset;
 
@@ -7015,7 +7015,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 insert:
 	ret = 0;
 	btrfs_release_path(path);
-	if (em->start > start || extent_map_end(em) <= start) {
+	if (em->start > start || btrfs_extent_map_end(em) <= start) {
 		btrfs_err(fs_info,
 			  "bad extent! em: [%llu %llu] passed [%llu %llu]",
 			  em->start, em->len, start, len);
@@ -9414,7 +9414,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	 * We only want to return up to EOF even if the extent extends beyond
 	 * that.
 	 */
-	encoded->len = min_t(u64, extent_map_end(em),
+	encoded->len = min_t(u64, btrfs_extent_map_end(em),
 			     inode->vfs_inode.i_size) - iocb->ki_pos;
 	if (em->disk_bytenr == EXTENT_MAP_HOLE ||
 	    (em->flags & EXTENT_FLAG_PREALLOC)) {
@@ -9442,7 +9442,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_em;
 		encoded->compression = ret;
 	} else {
-		*disk_bytenr = extent_map_block_start(em) + (start - em->start);
+		*disk_bytenr = btrfs_extent_map_block_start(em) + (start - em->start);
 		if (encoded->len > count)
 			encoded->len = count;
 		/*
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 609bb6c9c087..2c3cfa9479ab 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -137,7 +137,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		ret = -ENOENT;
 		goto out;
 	}
-	if (em->start != 0 || extent_map_end(em) != SZ_16K ||
+	if (em->start != 0 || btrfs_extent_map_end(em) != SZ_16K ||
 	    em->disk_bytenr != 0 || em->disk_num_bytes != SZ_16K) {
 		test_err(
 "case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu disk_bytenr %llu disk_num_bytes %llu",
@@ -235,7 +235,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		ret = -ENOENT;
 		goto out;
 	}
-	if (em->start != 0 || extent_map_end(em) != SZ_1K ||
+	if (em->start != 0 || btrfs_extent_map_end(em) != SZ_1K ||
 	    em->disk_bytenr != EXTENT_MAP_INLINE) {
 		test_err(
 "case2 [0 1K]: ret %d return a wrong em (start %llu len %llu disk_bytenr %llu",
@@ -312,8 +312,8 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	 * Since bytes within em are contiguous, em->block_start is identical to
 	 * em->start.
 	 */
-	if (start < em->start || start + len > extent_map_end(em) ||
-	    em->start != extent_map_block_start(em)) {
+	if (start < em->start || start + len > btrfs_extent_map_end(em) ||
+	    em->start != btrfs_extent_map_block_start(em)) {
 		test_err(
 "case3 [%llu %llu): ret %d em (start %llu len %llu disk_bytenr %llu block_len %llu)",
 			 start, start + len, ret, em->start, em->len,
@@ -438,7 +438,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		ret = -ENOENT;
 		goto out;
 	}
-	if (start < em->start || start + len > extent_map_end(em)) {
+	if (start < em->start || start + len > btrfs_extent_map_end(em)) {
 		test_err(
 "case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu disk_bytenr %llu disk_num_bytes %llu)",
 			 start, start + len, ret, em->start, em->len,
@@ -870,9 +870,9 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 
-	if (extent_map_block_start(em) != SZ_32K + SZ_4K) {
+	if (btrfs_extent_map_block_start(em) != SZ_32K + SZ_4K) {
 		test_err("em->block_start is %llu, expected 36K",
-				extent_map_block_start(em));
+			 btrfs_extent_map_block_start(em));
 		goto out;
 	}
 
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 6aa0f92f8c02..1e2118e96ba1 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -389,7 +389,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	disk_bytenr = extent_map_block_start(em);
+	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
 	free_extent_map(em);
@@ -441,9 +441,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	disk_bytenr += (em->start - orig_start);
-	if (extent_map_block_start(em) != disk_bytenr) {
+	if (btrfs_extent_map_block_start(em) != disk_bytenr) {
 		test_err("wrong block start, want %llu, have %llu",
-			 disk_bytenr, extent_map_block_start(em));
+			 disk_bytenr, btrfs_extent_map_block_start(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -502,7 +502,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
-	disk_bytenr = extent_map_block_start(em);
+	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
 	free_extent_map(em);
@@ -531,9 +531,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start - orig_start, em->offset);
 		goto out;
 	}
-	if (extent_map_block_start(em) != disk_bytenr + em->offset) {
+	if (btrfs_extent_map_block_start(em) != disk_bytenr + em->offset) {
 		test_err("unexpected block start, wanted %llu, have %llu",
-			 disk_bytenr + em->offset, extent_map_block_start(em));
+			 disk_bytenr + em->offset, btrfs_extent_map_block_start(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -564,9 +564,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start, em->offset, orig_start);
 		goto out;
 	}
-	if (extent_map_block_start(em) != disk_bytenr + em->offset) {
+	if (btrfs_extent_map_block_start(em) != disk_bytenr + em->offset) {
 		test_err("unexpected block start, wanted %llu, have %llu",
-			 disk_bytenr + em->offset, extent_map_block_start(em));
+			 disk_bytenr + em->offset, btrfs_extent_map_block_start(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -635,7 +635,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 BTRFS_COMPRESS_ZLIB, btrfs_extent_map_compression(em));
 		goto out;
 	}
-	disk_bytenr = extent_map_block_start(em);
+	disk_bytenr = btrfs_extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
 	free_extent_map(em);
@@ -671,9 +671,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (extent_map_block_start(em) != disk_bytenr) {
+	if (btrfs_extent_map_block_start(em) != disk_bytenr) {
 		test_err("block start does not match, want %llu got %llu",
-			 disk_bytenr, extent_map_block_start(em));
+			 disk_bytenr, btrfs_extent_map_block_start(em));
 		goto out;
 	}
 	if (em->start != offset || em->len != 2 * sectorsize) {
@@ -865,8 +865,9 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		test_err("got an error when we shouldn't have");
 		goto out;
 	}
-	if (extent_map_block_start(em) != sectorsize) {
-		test_err("expected a real extent, got %llu", extent_map_block_start(em));
+	if (btrfs_extent_map_block_start(em) != sectorsize) {
+		test_err("expected a real extent, got %llu",
+			 btrfs_extent_map_block_start(em));
 		goto out;
 	}
 	if (em->start != sectorsize || em->len != sectorsize) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d5e95ab2c9fd..88ef4b9c2c1f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4657,7 +4657,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	}
 
 	/* block start is already adjusted for the file extent offset. */
-	block_start = extent_map_block_start(em);
+	block_start = btrfs_extent_map_block_start(em);
 	csum_root = btrfs_csum_root(trans->fs_info, block_start);
 	ret = btrfs_lookup_csums_list(csum_root, block_start + csum_offset,
 				      block_start + csum_offset + csum_len - 1,
@@ -4692,7 +4692,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	enum btrfs_compression_type compress_type;
 	u64 extent_offset = em->offset;
-	u64 block_start = extent_map_block_start(em);
+	u64 block_start = btrfs_extent_map_block_start(em);
 	u64 block_len;
 	int ret;
 
-- 
2.45.2


