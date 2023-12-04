Return-Path: <linux-btrfs+bounces-585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E46803A11
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87C428109E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17DA2E853;
	Mon,  4 Dec 2023 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQhJHSs3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1392E84A
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C165EC433C8
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706848;
	bh=8u7go4DmqZeOuk29T2KEuDIOCkvOm6/kAjA7hIrfTFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lQhJHSs3PZbIYQydJVbLrKE9Hmp0ZokPPA3s1zzi4GM1EDrL6WvTbftSZaqnXGHoJ
	 5+Vp5RTLn/Uj9rul8/UVmMVPKfwp+IgcsL4BCiAqPcg5rXde8Xgqm+wtO+c0L7DbRL
	 RylXYtjCuNUPppAtM2mJfkhZk+PeU5spb48bV6EEghptM9HYwTBkhtw/9OzSwHCssa
	 w/ITdS+sEogTZI2+WhnKI+iNpRPDLdZSxs6XzQqf+Y0At//Uq5zYGgMHokO8r0OObV
	 1JVlZL1cXJFWf3QK5gKqMIEE06g8AmKb7M2kWTuSKA1C/gjqLukNH64fL5PmkRa51p
	 9a0CtpRPO7AeQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/11] btrfs: use the flags of an extent map to identify the compression type
Date: Mon,  4 Dec 2023 16:20:33 +0000
Message-Id: <64a0b8f04f170d4e1f0219bd975a6246e7b61b35.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently, in struct extent_map, we use an unsigned int (32 bits) to
identify the compression type of an extent and an unsigned long (64 bits
on a 64 bits platform, 32 bits otherwise) for flags. We are only using
6 different flags, so an unsigned long is excessive and we can use flags
to identify the compression type instead of using a dedicated 32 bits
field.

We can easily have tens or hundreds of thousands (or more) of extent maps
on busy and large filesystems, specially with compression enabled or many
or large files with tons of small extents. So it's convenient to have the
extent_map structure as small as possible in order to use less memory.

So removed the compression type field from struct extent_map, use flags
to identify the compression type and shorten the flags field from an
unsigned long to a u32. This saves 8 bytes (on 64 bits platforms) and
reduces the size of the structure from 136 bytes down to 128 bytes, using
now only two cache lines, and increases the number of extent maps we can
have per 4K page from 30 to 32. By using a u32 for the flags instead of
an unsigned long, we no longer use test_bit(), set_bit() and clear_bit(),
but that level of atomicity is not needed as most flags are never cleared
once set (before adding an extent map to the tree), and the ones that can
be cleared or set after an extent map is added to the tree, are always
performed while holding the write lock on the extent map tree, while the
reader holds a lock on the tree or tests for a flag that never changes
once the extent map is in the tree (such as compression flags).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c            |  4 +--
 fs/btrfs/defrag.c                 |  8 ++---
 fs/btrfs/extent_io.c              | 13 ++++---
 fs/btrfs/extent_map.c             | 51 ++++++++++++--------------
 fs/btrfs/extent_map.h             | 58 +++++++++++++++++++++++++-----
 fs/btrfs/file-item.c              |  9 ++---
 fs/btrfs/file.c                   | 10 +++---
 fs/btrfs/inode.c                  | 33 ++++++++---------
 fs/btrfs/relocation.c             |  2 +-
 fs/btrfs/tests/extent-map-tests.c |  4 +--
 fs/btrfs/tests/inode-tests.c      | 60 +++++++++++++++----------------
 fs/btrfs/tree-log.c               | 16 +++++----
 include/trace/events/btrfs.h      | 21 ++++++-----
 13 files changed, 158 insertions(+), 131 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 05595d113ff8..2d9974c283c6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -584,7 +584,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		goto out;
 	}
 
-	ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
+	ASSERT(extent_map_is_compressed(em));
 	compressed_len = em->block_len;
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
@@ -596,7 +596,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->compressed_len = compressed_len;
-	cb->compress_type = em->compress_type;
+	cb->compress_type = extent_map_compression(em);
 	cb->orig_bbio = bbio;
 
 	free_extent_map(em);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 9bcb60c68c58..a9a068af8d6e 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -775,7 +775,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 * this em, as either we don't care about the generation, or the
 	 * merged extent map will be rejected anyway.
 	 */
-	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
+	if (em && (em->flags & EXTENT_FLAG_MERGED) &&
 	    newer_than && em->generation >= newer_than) {
 		free_extent_map(em);
 		em = NULL;
@@ -802,7 +802,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 static u32 get_extent_max_capacity(const struct btrfs_fs_info *fs_info,
 				   const struct extent_map *em)
 {
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
+	if (extent_map_is_compressed(em))
 		return BTRFS_MAX_COMPRESSED;
 	return fs_info->max_extent_size;
 }
@@ -828,7 +828,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	/* No more em or hole */
 	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
 		goto out;
-	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
+	if (next->flags & EXTENT_FLAG_PREALLOC)
 		goto out;
 	/*
 	 * If the next extent is at its max capacity, defragging current extent
@@ -998,7 +998,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 
 		/* Skip holes and preallocated extents. */
 		if (em->block_start == EXTENT_MAP_HOLE ||
-		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+		    (em->flags & EXTENT_FLAG_PREALLOC))
 			goto next;
 
 		/* Skip older extent */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0143bf63044c..774282a9e1d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1032,8 +1032,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		BUG_ON(extent_map_end(em) <= cur);
 		BUG_ON(end < cur);
 
-		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
-			compress_type = em->compress_type;
+		compress_type = extent_map_compression(em);
 
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		iosize = ALIGN(iosize, blocksize);
@@ -1042,7 +1041,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		else
 			disk_bytenr = em->block_start + extent_offset;
 		block_start = em->block_start;
-		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+		if (em->flags & EXTENT_FLAG_PREALLOC)
 			block_start = EXTENT_MAP_HOLE;
 
 		/*
@@ -1079,7 +1078,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 * is a corner case so we prioritize correctness over
 		 * non-optimal behavior (submitting 2 bios for the same extent).
 		 */
-		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) &&
+		if (compress_type != BTRFS_COMPRESS_NONE &&
 		    prev_em_start && *prev_em_start != (u64)-1 &&
 		    *prev_em_start != em->start)
 			force_bio_submit = true;
@@ -1358,7 +1357,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		block_start = em->block_start;
 		disk_bytenr = em->block_start + extent_offset;
 
-		ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
+		ASSERT(!extent_map_is_compressed(em));
 		ASSERT(block_start != EXTENT_MAP_HOLE);
 		ASSERT(block_start != EXTENT_MAP_INLINE);
 
@@ -2359,7 +2358,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 				write_unlock(&map->lock);
 				break;
 			}
-			if (test_bit(EXTENT_FLAG_PINNED, &em->flags) ||
+			if ((em->flags & EXTENT_FLAG_PINNED) ||
 			    em->start != start) {
 				write_unlock(&map->lock);
 				free_extent_map(em);
@@ -2376,7 +2375,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 * extra reference on the em.
 			 */
 			if (list_empty(&em->list) ||
-			    test_bit(EXTENT_FLAG_LOGGING, &em->flags))
+			    (em->flags & EXTENT_FLAG_LOGGING))
 				goto remove_em;
 			/*
 			 * If it's in the list of modified extents, remove it
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 650ab88ad7dc..f9478be9011a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -50,7 +50,6 @@ struct extent_map *alloc_extent_map(void)
 	if (!em)
 		return NULL;
 	RB_CLEAR_NODE(&em->rb_node);
-	em->compress_type = BTRFS_COMPRESS_NONE;
 	refcount_set(&em->refs, 1);
 	INIT_LIST_HEAD(&em->list);
 	return em;
@@ -189,14 +188,14 @@ static inline u64 extent_map_block_end(const struct extent_map *em)
 
 static bool can_merge_extent_map(const struct extent_map *em)
 {
-	if (test_bit(EXTENT_FLAG_PINNED, &em->flags))
+	if (em->flags & EXTENT_FLAG_PINNED)
 		return false;
 
 	/* Don't merge compressed extents, we need to know their actual size. */
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
+	if (extent_map_is_compressed(em))
 		return false;
 
-	if (test_bit(EXTENT_FLAG_LOGGING, &em->flags))
+	if (em->flags & EXTENT_FLAG_LOGGING)
 		return false;
 
 	/*
@@ -258,7 +257,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 			em->mod_len = (em->mod_len + em->mod_start) - merge->mod_start;
 			em->mod_start = merge->mod_start;
 			em->generation = max(em->generation, merge->generation);
-			set_bit(EXTENT_FLAG_MERGED, &em->flags);
+			em->flags |= EXTENT_FLAG_MERGED;
 
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
@@ -276,7 +275,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
 		em->generation = max(em->generation, merge->generation);
-		set_bit(EXTENT_FLAG_MERGED, &em->flags);
+		em->flags |= EXTENT_FLAG_MERGED;
 		free_extent_map(merge);
 	}
 }
@@ -319,13 +318,13 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 			   em->start, start, len, gen);
 
 	em->generation = gen;
-	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+	em->flags &= ~EXTENT_FLAG_PINNED;
 	em->mod_start = em->start;
 	em->mod_len = em->len;
 
-	if (test_bit(EXTENT_FLAG_FILLING, &em->flags)) {
+	if (em->flags & EXTENT_FLAG_FILLING) {
 		prealloc = true;
-		clear_bit(EXTENT_FLAG_FILLING, &em->flags);
+		em->flags &= ~EXTENT_FLAG_FILLING;
 	}
 
 	try_merge_map(tree, em);
@@ -346,7 +345,7 @@ void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
 {
 	lockdep_assert_held_write(&tree->lock);
 
-	clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
+	em->flags &= ~EXTENT_FLAG_LOGGING;
 	if (extent_map_in_tree(em))
 		try_merge_map(tree, em);
 }
@@ -471,9 +470,9 @@ void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
 {
 	lockdep_assert_held_write(&tree->lock);
 
-	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &em->flags));
+	WARN_ON(em->flags & EXTENT_FLAG_PINNED);
 	rb_erase_cached(&em->rb_node, &tree->map);
-	if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
+	if (!(em->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&em->list);
 	RB_CLEAR_NODE(&em->rb_node);
 }
@@ -485,9 +484,9 @@ static void replace_extent_mapping(struct extent_map_tree *tree,
 {
 	lockdep_assert_held_write(&tree->lock);
 
-	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &cur->flags));
+	WARN_ON(cur->flags & EXTENT_FLAG_PINNED);
 	ASSERT(extent_map_in_tree(cur));
-	if (!test_bit(EXTENT_FLAG_LOGGING, &cur->flags))
+	if (!(cur->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&cur->list);
 	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->map);
 	RB_CLEAR_NODE(&cur->rb_node);
@@ -550,7 +549,7 @@ static noinline int merge_extent_mapping(struct extent_map_tree *em_tree,
 	em->start = start;
 	em->len = end - start;
 	if (em->block_start < EXTENT_MAP_LAST_BYTE &&
-	    !test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+	    !extent_map_is_compressed(em)) {
 		em->block_start += start_diff;
 		em->block_len = em->len;
 	}
@@ -653,8 +652,7 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 
 		node = rb_first_cached(&tree->map);
 		em = rb_entry(node, struct extent_map, rb_node);
-		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
-		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
+		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		remove_extent_mapping(tree, em);
 		free_extent_map(em);
 		cond_resched_rwlock_write(&tree->lock);
@@ -730,19 +728,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			}
 		}
 
-		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
+		if (skip_pinned && (em->flags & EXTENT_FLAG_PINNED)) {
 			start = em_end;
 			goto next;
 		}
 
 		flags = em->flags;
-		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		/*
 		 * In case we split the extent map, we want to preserve the
 		 * EXTENT_FLAG_LOGGING flag on our extent map, but we don't want
 		 * it on the new extent maps.
 		 */
-		clear_bit(EXTENT_FLAG_LOGGING, &flags);
+		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		modified = !list_empty(&em->list);
 
 		/*
@@ -753,7 +750,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			goto remove_em;
 
 		gen = em->generation;
-		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		compressed = extent_map_is_compressed(em);
 
 		if (em->start < start) {
 			if (!split) {
@@ -786,7 +783,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 
 			split->generation = gen;
 			split->flags = flags;
-			split->compress_type = em->compress_type;
 			replace_extent_mapping(em_tree, em, split, modified);
 			free_extent_map(split);
 			split = split2;
@@ -803,7 +799,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->len = em_end - end;
 			split->block_start = em->block_start;
 			split->flags = flags;
-			split->compress_type = em->compress_type;
 			split->generation = gen;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
@@ -969,14 +964,14 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	}
 
 	ASSERT(em->len == len);
-	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
+	ASSERT(!extent_map_is_compressed(em));
 	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
-	ASSERT(test_bit(EXTENT_FLAG_PINNED, &em->flags));
-	ASSERT(!test_bit(EXTENT_FLAG_LOGGING, &em->flags));
+	ASSERT(em->flags & EXTENT_FLAG_PINNED);
+	ASSERT(!(em->flags & EXTENT_FLAG_LOGGING));
 	ASSERT(!list_empty(&em->list));
 
 	flags = em->flags;
-	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+	em->flags &= ~EXTENT_FLAG_PINNED;
 
 	/* First, replace the em with a new extent_map starting from * em->start */
 	split_pre->start = em->start;
@@ -987,7 +982,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->orig_block_len = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
-	split_pre->compress_type = em->compress_type;
 	split_pre->generation = em->generation;
 
 	replace_extent_mapping(em_tree, em, split_pre, 1);
@@ -1006,7 +1000,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->orig_block_len = split_mid->block_len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
-	split_mid->compress_type = em->compress_type;
 	split_mid->generation = em->generation;
 	add_extent_mapping(em_tree, split_mid, 1);
 
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 44dc0cb310ea..e380fc08bbe4 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -5,6 +5,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include "compression.h"
 
 #define EXTENT_MAP_LAST_BYTE ((u64)-4)
 #define EXTENT_MAP_HOLE ((u64)-3)
@@ -13,18 +14,24 @@
 /* bits for the extent_map::flags field */
 enum {
 	/* this entry not yet on disk, don't free it */
-	EXTENT_FLAG_PINNED,
-	EXTENT_FLAG_COMPRESSED,
+	ENUM_BIT(EXTENT_FLAG_PINNED),
+	ENUM_BIT(EXTENT_FLAG_COMPRESS_ZLIB),
+	ENUM_BIT(EXTENT_FLAG_COMPRESS_LZO),
+	ENUM_BIT(EXTENT_FLAG_COMPRESS_ZSTD),
 	/* pre-allocated extent */
-	EXTENT_FLAG_PREALLOC,
+	ENUM_BIT(EXTENT_FLAG_PREALLOC),
 	/* Logging this extent */
-	EXTENT_FLAG_LOGGING,
+	ENUM_BIT(EXTENT_FLAG_LOGGING),
 	/* Filling in a preallocated extent */
-	EXTENT_FLAG_FILLING,
+	ENUM_BIT(EXTENT_FLAG_FILLING),
 	/* This em is merged from two or more physically adjacent ems */
-	EXTENT_FLAG_MERGED,
+	ENUM_BIT(EXTENT_FLAG_MERGED),
 };
 
+/*
+ * Keep this structure as compact as possible, as we can have really large
+ * amounts of allocated extent maps at any time.
+ */
 struct extent_map {
 	struct rb_node rb_node;
 
@@ -45,9 +52,8 @@ struct extent_map {
 	 * For non-merged extents, it's from btrfs_file_extent_item::generation.
 	 */
 	u64 generation;
-	unsigned long flags;
+	u32 flags;
 	refcount_t refs;
-	unsigned int compress_type;
 	struct list_head list;
 };
 
@@ -59,6 +65,42 @@ struct extent_map_tree {
 
 struct btrfs_inode;
 
+static inline void extent_map_set_compression(struct extent_map *em,
+					      enum btrfs_compression_type type)
+{
+	if (type == BTRFS_COMPRESS_ZLIB)
+		em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
+	else if (type == BTRFS_COMPRESS_LZO)
+		em->flags |= EXTENT_FLAG_COMPRESS_LZO;
+	else if (type == BTRFS_COMPRESS_ZSTD)
+		em->flags |= EXTENT_FLAG_COMPRESS_ZSTD;
+}
+
+static inline enum btrfs_compression_type extent_map_compression(const struct extent_map *em)
+{
+	if (em->flags & EXTENT_FLAG_COMPRESS_ZLIB)
+		return BTRFS_COMPRESS_ZLIB;
+
+	if (em->flags & EXTENT_FLAG_COMPRESS_LZO)
+		return BTRFS_COMPRESS_LZO;
+
+	if (em->flags & EXTENT_FLAG_COMPRESS_ZSTD)
+		return BTRFS_COMPRESS_ZSTD;
+
+	return BTRFS_COMPRESS_NONE;
+}
+
+/*
+ * More efficient way to determine if extent is compressed, instead of using
+ * 'extent_map_compression() != BTRFS_COMPRESS_NONE'.
+ */
+static inline bool extent_map_is_compressed(const struct extent_map *em)
+{
+	return (em->flags & (EXTENT_FLAG_COMPRESS_ZLIB |
+			     EXTENT_FLAG_COMPRESS_LZO |
+			     EXTENT_FLAG_COMPRESS_ZSTD)) != 0;
+}
+
 static inline int extent_map_in_tree(const struct extent_map *em)
 {
 	return !RB_EMPTY_NODE(&em->rb_node);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 45cae356e89b..ff0030d26744 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1294,8 +1294,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			return;
 		}
 		if (compress_type != BTRFS_COMPRESS_NONE) {
-			set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
-			em->compress_type = compress_type;
+			extent_map_set_compression(em, compress_type);
 			em->block_start = bytenr;
 			em->block_len = em->orig_block_len;
 		} else {
@@ -1303,7 +1302,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			em->block_start = bytenr;
 			em->block_len = em->len;
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
-				set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
+				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
@@ -1315,9 +1314,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		 */
 		em->orig_start = EXTENT_MAP_HOLE;
 		em->block_len = (u64)-1;
-		em->compress_type = compress_type;
-		if (compress_type != BTRFS_COMPRESS_NONE)
-			set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		extent_map_set_compression(em, compress_type);
 	} else {
 		btrfs_err(fs_info,
 			  "unknown file extent item type %d, inode %llu, offset %llu, "
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e9c4b947a5aa..15c5fc0db5a6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2150,7 +2150,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
 		hole_em->orig_block_len = 0;
-		hole_em->compress_type = BTRFS_COMPRESS_NONE;
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
@@ -2839,7 +2838,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 
 	if (em->block_start == EXTENT_MAP_HOLE)
 		ret = RANGE_BOUNDARY_HOLE;
-	else if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+	else if (em->flags & EXTENT_FLAG_PREALLOC)
 		ret = RANGE_BOUNDARY_PREALLOC_EXTENT;
 	else
 		ret = RANGE_BOUNDARY_WRITTEN_EXTENT;
@@ -2879,8 +2878,7 @@ static int btrfs_zero_range(struct inode *inode,
 	 * extents and holes, we drop all the existing extents and allocate a
 	 * new prealloc extent, so that we get a larger contiguous disk extent.
 	 */
-	if (em->start <= alloc_start &&
-	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+	if (em->start <= alloc_start && (em->flags & EXTENT_FLAG_PREALLOC)) {
 		const u64 em_end = em->start + em->len;
 
 		if (em_end >= offset + len) {
@@ -2915,7 +2913,7 @@ static int btrfs_zero_range(struct inode *inode,
 			goto out;
 		}
 
-		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		if (em->flags & EXTENT_FLAG_PREALLOC) {
 			free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
@@ -3136,7 +3134,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		last_byte = ALIGN(last_byte, blocksize);
 		if (em->block_start == EXTENT_MAP_HOLE ||
 		    (cur_offset >= inode->i_size &&
-		     !test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
+		     !(em->flags & EXTENT_FLAG_PREALLOC))) {
 			const u64 range_len = last_byte - cur_offset;
 
 			ret = add_falloc_range(&reserve_list, cur_offset, range_len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f7f48c2f0276..9ccff342ed42 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4898,7 +4898,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 		last_byte = ALIGN(last_byte, fs_info->sectorsize);
 		hole_size = last_byte - cur_offset;
 
-		if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		if (!(em->flags & EXTENT_FLAG_PREALLOC)) {
 			struct extent_map *hole_em;
 
 			err = maybe_insert_hole(inode, cur_offset, hole_size);
@@ -4926,7 +4926,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->block_len = 0;
 			hole_em->orig_block_len = 0;
 			hole_em->ram_bytes = hole_size;
-			hole_em->compress_type = BTRFS_COMPRESS_NONE;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
 			err = btrfs_replace_extent_map_range(inode, hole_em, true);
@@ -7274,13 +7273,11 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->orig_block_len = orig_block_len;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
-	set_bit(EXTENT_FLAG_PINNED, &em->flags);
-	if (type == BTRFS_ORDERED_PREALLOC) {
-		set_bit(EXTENT_FLAG_FILLING, &em->flags);
-	} else if (type == BTRFS_ORDERED_COMPRESSED) {
-		set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
-		em->compress_type = compress_type;
-	}
+	em->flags |= EXTENT_FLAG_PINNED;
+	if (type == BTRFS_ORDERED_PREALLOC)
+		em->flags |= EXTENT_FLAG_FILLING;
+	else if (type == BTRFS_ORDERED_COMPRESSED)
+		extent_map_set_compression(em, compress_type);
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -7320,10 +7317,10 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	 * just use the extent.
 	 *
 	 */
-	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) ||
+	if ((em->flags & EXTENT_FLAG_PREALLOC) ||
 	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
 	     em->block_start != EXTENT_MAP_HOLE)) {
-		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+		if (em->flags & EXTENT_FLAG_PREALLOC)
 			type = BTRFS_ORDERED_PREALLOC;
 		else
 			type = BTRFS_ORDERED_NOCOW;
@@ -7558,7 +7555,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * to buffered IO.  Don't blame me, this is the price we pay for using
 	 * the generic code.
 	 */
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) ||
+	if (extent_map_is_compressed(em) ||
 	    em->block_start == EXTENT_MAP_INLINE) {
 		free_extent_map(em);
 		/*
@@ -7654,7 +7651,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * that, since we have locked only the parts we are performing I/O in.
 	 */
 	if ((em->block_start == EXTENT_MAP_HOLE) ||
-	    (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) && !write)) {
+	    ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->type = IOMAP_HOLE;
 	} else {
@@ -9654,7 +9651,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->block_len = ins.offset;
 		em->orig_block_len = ins.offset;
 		em->ram_bytes = ins.offset;
-		set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
+		em->flags |= EXTENT_FLAG_PREALLOC;
 		em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
@@ -10135,12 +10132,12 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	encoded->len = min_t(u64, extent_map_end(em),
 			     inode->vfs_inode.i_size) - iocb->ki_pos;
 	if (em->block_start == EXTENT_MAP_HOLE ||
-	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+	    (em->flags & EXTENT_FLAG_PREALLOC)) {
 		disk_bytenr = EXTENT_MAP_HOLE;
 		count = min_t(u64, count, encoded->len);
 		encoded->len = count;
 		encoded->unencoded_len = count;
-	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+	} else if (extent_map_is_compressed(em)) {
 		disk_bytenr = em->block_start;
 		/*
 		 * Bail if the buffer isn't large enough to return the whole
@@ -10155,7 +10152,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		encoded->unencoded_len = em->ram_bytes;
 		encoded->unencoded_offset = iocb->ki_pos - em->orig_start;
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
-							     em->compress_type);
+							       extent_map_compression(em));
 		if (ret < 0)
 			goto out_em;
 		encoded->compression = ret;
@@ -10703,7 +10700,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			ret = -EINVAL;
 			goto out;
 		}
-		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+		if (extent_map_is_compressed(em)) {
 			btrfs_warn(fs_info, "swapfile must not be compressed");
 			ret = -EINVAL;
 			goto out;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f5d9e5f74a52..78c2770eb52f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2951,7 +2951,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	em->len = end + 1 - start;
 	em->block_len = em->len;
 	em->block_start = block_start;
-	set_bit(EXTENT_FLAG_PINNED, &em->flags);
+	em->flags |= EXTENT_FLAG_PINNED;
 
 	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 	ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, false);
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 59bbf714225c..253cce7ffecf 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -480,7 +480,7 @@ static int add_compressed_extent(struct btrfs_fs_info *fs_info,
 	em->len = len;
 	em->block_start = block_start;
 	em->block_len = SZ_4K;
-	set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+	em->flags |= EXTENT_FLAG_COMPRESS_ZLIB;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
@@ -763,7 +763,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info)
 	em->len = SZ_16K;
 	em->block_start = 0;
 	em->block_len = SZ_4K;
-	set_bit(EXTENT_FLAG_PINNED, &em->flags);
+	em->flags |= EXTENT_FLAG_PINNED;
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 492d69d2fa73..9957de9f7806 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -211,9 +211,9 @@ static void setup_file_extents(struct btrfs_root *root, u32 sectorsize)
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, slot);
 }
 
-static unsigned long prealloc_only = 0;
-static unsigned long compressed_only = 0;
-static unsigned long vacancy_only = 0;
+static u32 prealloc_only = 0;
+static u32 compressed_only = 0;
+static u32 vacancy_only = 0;
 
 static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 {
@@ -305,7 +305,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	/*
@@ -332,7 +332,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -355,7 +355,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != em->start) {
@@ -383,7 +383,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != em->start) {
@@ -412,7 +412,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -434,7 +434,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != orig_start) {
@@ -468,7 +468,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != prealloc_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 prealloc_only, em->flags);
 		goto out;
 	}
@@ -497,7 +497,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != prealloc_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 prealloc_only, em->flags);
 		goto out;
 	}
@@ -527,7 +527,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != orig_start) {
@@ -560,7 +560,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != prealloc_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 prealloc_only, em->flags);
 		goto out;
 	}
@@ -595,7 +595,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != compressed_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 compressed_only, em->flags);
 		goto out;
 	}
@@ -604,9 +604,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start, em->orig_start);
 		goto out;
 	}
-	if (em->compress_type != BTRFS_COMPRESS_ZLIB) {
+	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
 		test_err("unexpected compress type, wanted %d, got %d",
-			 BTRFS_COMPRESS_ZLIB, em->compress_type);
+			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -629,7 +629,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != compressed_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 compressed_only, em->flags);
 		goto out;
 	}
@@ -638,9 +638,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start, em->orig_start);
 		goto out;
 	}
-	if (em->compress_type != BTRFS_COMPRESS_ZLIB) {
+	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
 		test_err("unexpected compress type, wanted %d, got %d",
-			 BTRFS_COMPRESS_ZLIB, em->compress_type);
+			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
 		goto out;
 	}
 	disk_bytenr = em->block_start;
@@ -664,7 +664,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != em->start) {
@@ -692,7 +692,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != compressed_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 compressed_only, em->flags);
 		goto out;
 	}
@@ -701,9 +701,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 em->start, orig_start);
 		goto out;
 	}
-	if (em->compress_type != BTRFS_COMPRESS_ZLIB) {
+	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
 		test_err("unexpected compress type, wanted %d, got %d",
-			 BTRFS_COMPRESS_ZLIB, em->compress_type);
+			 BTRFS_COMPRESS_ZLIB, extent_map_compression(em));
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -726,7 +726,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != em->start) {
@@ -758,7 +758,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != vacancy_only) {
-		test_err("unexpected flags set, want %lu have %lu",
+		test_err("unexpected flags set, want %u have %u",
 			 vacancy_only, em->flags);
 		goto out;
 	}
@@ -786,7 +786,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, want 0 have %lu", em->flags);
+		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
 	if (em->orig_start != em->start) {
@@ -866,7 +866,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != vacancy_only) {
-		test_err("wrong flags, wanted %lu, have %lu", vacancy_only,
+		test_err("wrong flags, wanted %u, have %u", vacancy_only,
 			 em->flags);
 		goto out;
 	}
@@ -888,7 +888,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	if (em->flags != 0) {
-		test_err("unexpected flags set, wanted 0 got %lu",
+		test_err("unexpected flags set, wanted 0 got %u",
 			 em->flags);
 		goto out;
 	}
@@ -1095,8 +1095,8 @@ int btrfs_test_inodes(u32 sectorsize, u32 nodesize)
 
 	test_msg("running inode tests");
 
-	set_bit(EXTENT_FLAG_COMPRESSED, &compressed_only);
-	set_bit(EXTENT_FLAG_PREALLOC, &prealloc_only);
+	compressed_only |= EXTENT_FLAG_COMPRESS_ZLIB;
+	prealloc_only |= EXTENT_FLAG_PREALLOC;
 
 	ret = test_btrfs_get_extent(sectorsize, nodesize);
 	if (ret)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index bee065851185..331fc7429952 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4519,7 +4519,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	if (inode->flags & BTRFS_INODE_NODATASUM ||
-	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags) ||
+	    (em->flags & EXTENT_FLAG_PREALLOC) ||
 	    em->block_start == EXTENT_MAP_HOLE)
 		return 0;
 
@@ -4582,7 +4582,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 		return 0;
 
 	/* If we're compressed we have to save the entire range of csums. */
-	if (em->compress_type) {
+	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
 		csum_len = max(em->block_len, em->orig_block_len);
 	} else {
@@ -4622,18 +4622,20 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item fi = { 0 };
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
+	enum btrfs_compression_type compress_type;
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
 
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
-	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+	if (em->flags & EXTENT_FLAG_PREALLOC)
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_PREALLOC);
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
 	block_len = max(em->block_len, em->orig_block_len);
-	if (em->compress_type != BTRFS_COMPRESS_NONE) {
+	compress_type = extent_map_compression(em);
+	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
 		btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len);
 	} else if (em->block_start < EXTENT_MAP_LAST_BYTE) {
@@ -4645,7 +4647,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_offset(&fi, extent_offset);
 	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
 	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
-	btrfs_set_stack_file_extent_compression(&fi, em->compress_type);
+	btrfs_set_stack_file_extent_compression(&fi, compress_type);
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
@@ -4858,13 +4860,13 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 			continue;
 
 		/* We log prealloc extents beyond eof later. */
-		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) &&
+		if ((em->flags & EXTENT_FLAG_PREALLOC) &&
 		    em->start >= i_size_read(&inode->vfs_inode))
 			continue;
 
 		/* Need a ref to keep it from getting evicted from cache */
 		refcount_inc(&em->refs);
-		set_bit(EXTENT_FLAG_LOGGING, &em->flags);
+		em->flags |= EXTENT_FLAG_LOGGING;
 		list_add_tail(&em->list, &extents);
 		num++;
 	}
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 31da1456f953..90b0222390e5 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -272,11 +272,13 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
 
 #define show_map_flags(flag)						\
 	__print_flags(flag, "|",					\
-		{ (1 << EXTENT_FLAG_PINNED), 		"PINNED" 	},\
-		{ (1 << EXTENT_FLAG_COMPRESSED), 	"COMPRESSED" 	},\
-		{ (1 << EXTENT_FLAG_PREALLOC), 		"PREALLOC" 	},\
-		{ (1 << EXTENT_FLAG_LOGGING),	 	"LOGGING" 	},\
-		{ (1 << EXTENT_FLAG_FILLING),		"FILLING"	})
+		{ EXTENT_FLAG_PINNED,		"PINNED"	},\
+		{ EXTENT_FLAG_COMPRESS_ZLIB,	"COMPRESS_ZLIB"	},\
+		{ EXTENT_FLAG_COMPRESS_LZO,	"COMPRESS_LZO"	},\
+		{ EXTENT_FLAG_COMPRESS_ZSTD,	"COMPRESS_ZSTD"	},\
+		{ EXTENT_FLAG_PREALLOC,		"PREALLOC"	},\
+		{ EXTENT_FLAG_LOGGING,		"LOGGING"	},\
+		{ EXTENT_FLAG_FILLING,		"FILLING"	})
 
 TRACE_EVENT_CONDITION(btrfs_get_extent,
 
@@ -295,9 +297,8 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__field(	u64,  orig_start	)
 		__field(	u64,  block_start	)
 		__field(	u64,  block_len		)
-		__field(	unsigned long,  flags	)
+		__field(	u32,  flags		)
 		__field(	int,  refs		)
-		__field(	unsigned int,  compress_type	)
 	),
 
 	TP_fast_assign_btrfs(root->fs_info,
@@ -310,13 +311,11 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__entry->block_len	= map->block_len;
 		__entry->flags		= map->flags;
 		__entry->refs		= refcount_read(&map->refs);
-		__entry->compress_type	= map->compress_type;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu "
 		  "orig_start=%llu block_start=%llu(%s) "
-		  "block_len=%llu flags=%s refs=%u "
-		  "compress_type=%u",
+		  "block_len=%llu flags=%s refs=%u",
 		  show_root_type(__entry->root_objectid),
 		  __entry->ino,
 		  __entry->start,
@@ -325,7 +324,7 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		  show_map_type(__entry->block_start),
 		  __entry->block_len,
 		  show_map_flags(__entry->flags),
-		  __entry->refs, __entry->compress_type)
+		  __entry->refs)
 );
 
 TRACE_EVENT(btrfs_handle_em_exist,
-- 
2.40.1


