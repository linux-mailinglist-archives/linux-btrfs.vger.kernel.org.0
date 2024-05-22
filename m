Return-Path: <linux-btrfs+bounces-5214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3958CC7A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3BF1C20DA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B937E112;
	Wed, 22 May 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa608Fhu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0228F0
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716408963; cv=none; b=rEiYQ22SoiRGtQLMp31gqsAuVKzWBsxfeHpwSCYYUI3R3S9MWL2mOXoBdoNti1wdlG9daO/Jcwl5Nfo/LWk1fP6FCdYobO12Zc5nOIlYe0M8zA995aCgk2MEO/n1DAPyLlmbnF3itg7+a7SVJzcf+d79SNp3LbltgSQDG8S49YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716408963; c=relaxed/simple;
	bh=78JtMFwQ37JzqANYwE+eE+yEluOtb7ypr8K8bss8fSI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SXiUriw2J02svLc1mBy6+dSpE2Kk0mOK9oDqwIocZhQNYjx5AfDkeDFfpozscHwra4GPEQnwDJlqsfGhVCeA67zFblIg2Y+KBtfBkzu9fijIatVm2YsiF6bqNIwu/ZpSBU2IFvP/5MuIz1Kzkixb4VHs1GgS7VjLiHzY+8m98p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa608Fhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DE9C2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 20:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716408962;
	bh=78JtMFwQ37JzqANYwE+eE+yEluOtb7ypr8K8bss8fSI=;
	h=From:To:Subject:Date:From;
	b=pa608FhuGdcpXKyA/lcIN2nS6BLNagkWasSAPXSfMihHX8k3ANwjC14lp2GPq4cW6
	 xFPf3+/HM2fc/n1c294i3WW8hSGGM4fFzRPicTVHB/j5sncS8u/3MzLB/tGtUDf1CJ
	 jV6r+LS567t0W9XmZgwcVSR/3zMN5xjcqQztVDXOQ9NlQdVMUvVPLegCNwdQHJSF+i
	 Ff2MlxU6tbLwaqSQVYRDr1kQZSpBXJE0fF7NiorsGL2qNtPUSS23+0q7P8J2F6PZ3X
	 K8jRsn+IXGcNUa0V+B/VHDJ2j/WZx4KHq+S5NN4+Qh/P84xgqiSxl338YuxO1klnMr
	 XizTCioRn0JXw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move fiemap code into its own file
Date: Wed, 22 May 2024 21:15:59 +0100
Message-Id: <d7579e89a2926ae126ba42794de3e7c39726f6eb.1716408773.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently the core of the fiemap code lives in extent_io.c, which does
not make any sense because it's not related to extent IO at all (and it
was not as well before the big rewrite of fiemap I did some time ago).
The entry point for fiemap, btrfs_fiemap(), lives in inode.c since it's
an inode operation.

Since there's a significant amount of fiemap code, move all of it into a
dedicated file, including its entry point inode.c:btrfs_fiemap().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/Makefile    |   2 +-
 fs/btrfs/extent_io.c | 871 ----------------------------------------
 fs/btrfs/extent_io.h |   2 -
 fs/btrfs/fiemap.c    | 930 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fiemap.h    |  11 +
 fs/btrfs/inode.c     |  52 +--
 6 files changed, 943 insertions(+), 925 deletions(-)
 create mode 100644 fs/btrfs/fiemap.c
 create mode 100644 fs/btrfs/fiemap.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 525af975f61c..50b19d15e956 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
 	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
-	   lru_cache.o raid-stripe-tree.o
+	   lru_cache.o raid-stripe-tree.o fiemap.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bf50301ee528..f2898f45a4d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2470,877 +2470,6 @@ bool try_release_extent_mapping(struct page *page, gfp_t mask)
 	return try_release_extent_state(io_tree, page, mask);
 }
 
-struct btrfs_fiemap_entry {
-	u64 offset;
-	u64 phys;
-	u64 len;
-	u32 flags;
-};
-
-/*
- * Indicate the caller of emit_fiemap_extent() that it needs to unlock the file
- * range from the inode's io tree, unlock the subvolume tree search path, flush
- * the fiemap cache and relock the file range and research the subvolume tree.
- * The value here is something negative that can't be confused with a valid
- * errno value and different from 1 because that's also a return value from
- * fiemap_fill_next_extent() and also it's often used to mean some btree search
- * did not find a key, so make it some distinct negative value.
- */
-#define BTRFS_FIEMAP_FLUSH_CACHE (-(MAX_ERRNO + 1))
-
-/*
- * Used to:
- *
- * - Cache the next entry to be emitted to the fiemap buffer, so that we can
- *   merge extents that are contiguous and can be grouped as a single one;
- *
- * - Store extents ready to be written to the fiemap buffer in an intermediary
- *   buffer. This intermediary buffer is to ensure that in case the fiemap
- *   buffer is memory mapped to the fiemap target file, we don't deadlock
- *   during btrfs_page_mkwrite(). This is because during fiemap we are locking
- *   an extent range in order to prevent races with delalloc flushing and
- *   ordered extent completion, which is needed in order to reliably detect
- *   delalloc in holes and prealloc extents. And this can lead to a deadlock
- *   if the fiemap buffer is memory mapped to the file we are running fiemap
- *   against (a silly, useless in practice scenario, but possible) because
- *   btrfs_page_mkwrite() will try to lock the same extent range.
- */
-struct fiemap_cache {
-	/* An array of ready fiemap entries. */
-	struct btrfs_fiemap_entry *entries;
-	/* Number of entries in the entries array. */
-	int entries_size;
-	/* Index of the next entry in the entries array to write to. */
-	int entries_pos;
-	/*
-	 * Once the entries array is full, this indicates what's the offset for
-	 * the next file extent item we must search for in the inode's subvolume
-	 * tree after unlocking the extent range in the inode's io tree and
-	 * releasing the search path.
-	 */
-	u64 next_search_offset;
-	/*
-	 * This matches struct fiemap_extent_info::fi_mapped_extents, we use it
-	 * to count ourselves emitted extents and stop instead of relying on
-	 * fiemap_fill_next_extent() because we buffer ready fiemap entries at
-	 * the @entries array, and we want to stop as soon as we hit the max
-	 * amount of extents to map, not just to save time but also to make the
-	 * logic at extent_fiemap() simpler.
-	 */
-	unsigned int extents_mapped;
-	/* Fields for the cached extent (unsubmitted, not ready, extent). */
-	u64 offset;
-	u64 phys;
-	u64 len;
-	u32 flags;
-	bool cached;
-};
-
-static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
-			      struct fiemap_cache *cache)
-{
-	for (int i = 0; i < cache->entries_pos; i++) {
-		struct btrfs_fiemap_entry *entry = &cache->entries[i];
-		int ret;
-
-		ret = fiemap_fill_next_extent(fieinfo, entry->offset,
-					      entry->phys, entry->len,
-					      entry->flags);
-		/*
-		 * Ignore 1 (reached max entries) because we keep track of that
-		 * ourselves in emit_fiemap_extent().
-		 */
-		if (ret < 0)
-			return ret;
-	}
-	cache->entries_pos = 0;
-
-	return 0;
-}
-
-/*
- * Helper to submit fiemap extent.
- *
- * Will try to merge current fiemap extent specified by @offset, @phys,
- * @len and @flags with cached one.
- * And only when we fails to merge, cached one will be submitted as
- * fiemap extent.
- *
- * Return value is the same as fiemap_fill_next_extent().
- */
-static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
-				struct fiemap_cache *cache,
-				u64 offset, u64 phys, u64 len, u32 flags)
-{
-	struct btrfs_fiemap_entry *entry;
-	u64 cache_end;
-
-	/* Set at the end of extent_fiemap(). */
-	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
-
-	if (!cache->cached)
-		goto assign;
-
-	/*
-	 * When iterating the extents of the inode, at extent_fiemap(), we may
-	 * find an extent that starts at an offset behind the end offset of the
-	 * previous extent we processed. This happens if fiemap is called
-	 * without FIEMAP_FLAG_SYNC and there are ordered extents completing
-	 * after we had to unlock the file range, release the search path, emit
-	 * the fiemap extents stored in the buffer (cache->entries array) and
-	 * the lock the remainder of the range and re-search the btree.
-	 *
-	 * For example we are in leaf X processing its last item, which is the
-	 * file extent item for file range [512K, 1M[, and after
-	 * btrfs_next_leaf() releases the path, there's an ordered extent that
-	 * completes for the file range [768K, 2M[, and that results in trimming
-	 * the file extent item so that it now corresponds to the file range
-	 * [512K, 768K[ and a new file extent item is inserted for the file
-	 * range [768K, 2M[, which may end up as the last item of leaf X or as
-	 * the first item of the next leaf - in either case btrfs_next_leaf()
-	 * will leave us with a path pointing to the new extent item, for the
-	 * file range [768K, 2M[, since that's the first key that follows the
-	 * last one we processed. So in order not to report overlapping extents
-	 * to user space, we trim the length of the previously cached extent and
-	 * emit it.
-	 *
-	 * Upon calling btrfs_next_leaf() we may also find an extent with an
-	 * offset smaller than or equals to cache->offset, and this happens
-	 * when we had a hole or prealloc extent with several delalloc ranges in
-	 * it, but after btrfs_next_leaf() released the path, delalloc was
-	 * flushed and the resulting ordered extents were completed, so we can
-	 * now have found a file extent item for an offset that is smaller than
-	 * or equals to what we have in cache->offset. We deal with this as
-	 * described below.
-	 */
-	cache_end = cache->offset + cache->len;
-	if (cache_end > offset) {
-		if (offset == cache->offset) {
-			/*
-			 * We cached a dealloc range (found in the io tree) for
-			 * a hole or prealloc extent and we have now found a
-			 * file extent item for the same offset. What we have
-			 * now is more recent and up to date, so discard what
-			 * we had in the cache and use what we have just found.
-			 */
-			goto assign;
-		} else if (offset > cache->offset) {
-			/*
-			 * The extent range we previously found ends after the
-			 * offset of the file extent item we found and that
-			 * offset falls somewhere in the middle of that previous
-			 * extent range. So adjust the range we previously found
-			 * to end at the offset of the file extent item we have
-			 * just found, since this extent is more up to date.
-			 * Emit that adjusted range and cache the file extent
-			 * item we have just found. This corresponds to the case
-			 * where a previously found file extent item was split
-			 * due to an ordered extent completing.
-			 */
-			cache->len = offset - cache->offset;
-			goto emit;
-		} else {
-			const u64 range_end = offset + len;
-
-			/*
-			 * The offset of the file extent item we have just found
-			 * is behind the cached offset. This means we were
-			 * processing a hole or prealloc extent for which we
-			 * have found delalloc ranges (in the io tree), so what
-			 * we have in the cache is the last delalloc range we
-			 * found while the file extent item we found can be
-			 * either for a whole delalloc range we previously
-			 * emmitted or only a part of that range.
-			 *
-			 * We have two cases here:
-			 *
-			 * 1) The file extent item's range ends at or behind the
-			 *    cached extent's end. In this case just ignore the
-			 *    current file extent item because we don't want to
-			 *    overlap with previous ranges that may have been
-			 *    emmitted already;
-			 *
-			 * 2) The file extent item starts behind the currently
-			 *    cached extent but its end offset goes beyond the
-			 *    end offset of the cached extent. We don't want to
-			 *    overlap with a previous range that may have been
-			 *    emmitted already, so we emit the currently cached
-			 *    extent and then partially store the current file
-			 *    extent item's range in the cache, for the subrange
-			 *    going the cached extent's end to the end of the
-			 *    file extent item.
-			 */
-			if (range_end <= cache_end)
-				return 0;
-
-			if (!(flags & (FIEMAP_EXTENT_ENCODED | FIEMAP_EXTENT_DELALLOC)))
-				phys += cache_end - offset;
-
-			offset = cache_end;
-			len = range_end - cache_end;
-			goto emit;
-		}
-	}
-
-	/*
-	 * Only merges fiemap extents if
-	 * 1) Their logical addresses are continuous
-	 *
-	 * 2) Their physical addresses are continuous
-	 *    So truly compressed (physical size smaller than logical size)
-	 *    extents won't get merged with each other
-	 *
-	 * 3) Share same flags
-	 */
-	if (cache->offset + cache->len  == offset &&
-	    cache->phys + cache->len == phys  &&
-	    cache->flags == flags) {
-		cache->len += len;
-		return 0;
-	}
-
-emit:
-	/* Not mergeable, need to submit cached one */
-
-	if (cache->entries_pos == cache->entries_size) {
-		/*
-		 * We will need to research for the end offset of the last
-		 * stored extent and not from the current offset, because after
-		 * unlocking the range and releasing the path, if there's a hole
-		 * between that end offset and this current offset, a new extent
-		 * may have been inserted due to a new write, so we don't want
-		 * to miss it.
-		 */
-		entry = &cache->entries[cache->entries_size - 1];
-		cache->next_search_offset = entry->offset + entry->len;
-		cache->cached = false;
-
-		return BTRFS_FIEMAP_FLUSH_CACHE;
-	}
-
-	entry = &cache->entries[cache->entries_pos];
-	entry->offset = cache->offset;
-	entry->phys = cache->phys;
-	entry->len = cache->len;
-	entry->flags = cache->flags;
-	cache->entries_pos++;
-	cache->extents_mapped++;
-
-	if (cache->extents_mapped == fieinfo->fi_extents_max) {
-		cache->cached = false;
-		return 1;
-	}
-assign:
-	cache->cached = true;
-	cache->offset = offset;
-	cache->phys = phys;
-	cache->len = len;
-	cache->flags = flags;
-
-	return 0;
-}
-
-/*
- * Emit last fiemap cache
- *
- * The last fiemap cache may still be cached in the following case:
- * 0		      4k		    8k
- * |<- Fiemap range ->|
- * |<------------  First extent ----------->|
- *
- * In this case, the first extent range will be cached but not emitted.
- * So we must emit it before ending extent_fiemap().
- */
-static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
-				  struct fiemap_cache *cache)
-{
-	int ret;
-
-	if (!cache->cached)
-		return 0;
-
-	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
-				      cache->len, cache->flags);
-	cache->cached = false;
-	if (ret > 0)
-		ret = 0;
-	return ret;
-}
-
-static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
-{
-	struct extent_buffer *clone = path->nodes[0];
-	struct btrfs_key key;
-	int slot;
-	int ret;
-
-	path->slots[0]++;
-	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
-		return 0;
-
-	/*
-	 * Add a temporary extra ref to an already cloned extent buffer to
-	 * prevent btrfs_next_leaf() freeing it, we want to reuse it to avoid
-	 * the cost of allocating a new one.
-	 */
-	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
-	atomic_inc(&clone->refs);
-
-	ret = btrfs_next_leaf(inode->root, path);
-	if (ret != 0)
-		goto out;
-
-	/*
-	 * Don't bother with cloning if there are no more file extent items for
-	 * our inode.
-	 */
-	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY) {
-		ret = 1;
-		goto out;
-	}
-
-	/*
-	 * Important to preserve the start field, for the optimizations when
-	 * checking if extents are shared (see extent_fiemap()).
-	 *
-	 * We must set ->start before calling copy_extent_buffer_full().  If we
-	 * are on sub-pagesize blocksize, we use ->start to determine the offset
-	 * into the folio where our eb exists, and if we update ->start after
-	 * the fact then any subsequent reads of the eb may read from a
-	 * different offset in the folio than where we originally copied into.
-	 */
-	clone->start = path->nodes[0]->start;
-	/* See the comment at fiemap_search_slot() about why we clone. */
-	copy_extent_buffer_full(clone, path->nodes[0]);
-
-	slot = path->slots[0];
-	btrfs_release_path(path);
-	path->nodes[0] = clone;
-	path->slots[0] = slot;
-out:
-	if (ret)
-		free_extent_buffer(clone);
-
-	return ret;
-}
-
-/*
- * Search for the first file extent item that starts at a given file offset or
- * the one that starts immediately before that offset.
- * Returns: 0 on success, < 0 on error, 1 if not found.
- */
-static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path,
-			      u64 file_offset)
-{
-	const u64 ino = btrfs_ino(inode);
-	struct btrfs_root *root = inode->root;
-	struct extent_buffer *clone;
-	struct btrfs_key key;
-	int slot;
-	int ret;
-
-	key.objectid = ino;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = file_offset;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	if (ret > 0 && path->slots[0] > 0) {
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
-		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
-			path->slots[0]--;
-	}
-
-	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-		ret = btrfs_next_leaf(root, path);
-		if (ret != 0)
-			return ret;
-
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
-			return 1;
-	}
-
-	/*
-	 * We clone the leaf and use it during fiemap. This is because while
-	 * using the leaf we do expensive things like checking if an extent is
-	 * shared, which can take a long time. In order to prevent blocking
-	 * other tasks for too long, we use a clone of the leaf. We have locked
-	 * the file range in the inode's io tree, so we know none of our file
-	 * extent items can change. This way we avoid blocking other tasks that
-	 * want to insert items for other inodes in the same leaf or b+tree
-	 * rebalance operations (triggered for example when someone is trying
-	 * to push items into this leaf when trying to insert an item in a
-	 * neighbour leaf).
-	 * We also need the private clone because holding a read lock on an
-	 * extent buffer of the subvolume's b+tree will make lockdep unhappy
-	 * when we check if extents are shared, as backref walking may need to
-	 * lock the same leaf we are processing.
-	 */
-	clone = btrfs_clone_extent_buffer(path->nodes[0]);
-	if (!clone)
-		return -ENOMEM;
-
-	slot = path->slots[0];
-	btrfs_release_path(path);
-	path->nodes[0] = clone;
-	path->slots[0] = slot;
-
-	return 0;
-}
-
-/*
- * Process a range which is a hole or a prealloc extent in the inode's subvolume
- * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a prealloc
- * extent. The end offset (@end) is inclusive.
- */
-static int fiemap_process_hole(struct btrfs_inode *inode,
-			       struct fiemap_extent_info *fieinfo,
-			       struct fiemap_cache *cache,
-			       struct extent_state **delalloc_cached_state,
-			       struct btrfs_backref_share_check_ctx *backref_ctx,
-			       u64 disk_bytenr, u64 extent_offset,
-			       u64 extent_gen,
-			       u64 start, u64 end)
-{
-	const u64 i_size = i_size_read(&inode->vfs_inode);
-	u64 cur_offset = start;
-	u64 last_delalloc_end = 0;
-	u32 prealloc_flags = FIEMAP_EXTENT_UNWRITTEN;
-	bool checked_extent_shared = false;
-	int ret;
-
-	/*
-	 * There can be no delalloc past i_size, so don't waste time looking for
-	 * it beyond i_size.
-	 */
-	while (cur_offset < end && cur_offset < i_size) {
-		u64 delalloc_start;
-		u64 delalloc_end;
-		u64 prealloc_start;
-		u64 prealloc_len = 0;
-		bool delalloc;
-
-		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
-							delalloc_cached_state,
-							&delalloc_start,
-							&delalloc_end);
-		if (!delalloc)
-			break;
-
-		/*
-		 * If this is a prealloc extent we have to report every section
-		 * of it that has no delalloc.
-		 */
-		if (disk_bytenr != 0) {
-			if (last_delalloc_end == 0) {
-				prealloc_start = start;
-				prealloc_len = delalloc_start - start;
-			} else {
-				prealloc_start = last_delalloc_end + 1;
-				prealloc_len = delalloc_start - prealloc_start;
-			}
-		}
-
-		if (prealloc_len > 0) {
-			if (!checked_extent_shared && fieinfo->fi_extents_max) {
-				ret = btrfs_is_data_extent_shared(inode,
-								  disk_bytenr,
-								  extent_gen,
-								  backref_ctx);
-				if (ret < 0)
-					return ret;
-				else if (ret > 0)
-					prealloc_flags |= FIEMAP_EXTENT_SHARED;
-
-				checked_extent_shared = true;
-			}
-			ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
-						 disk_bytenr + extent_offset,
-						 prealloc_len, prealloc_flags);
-			if (ret)
-				return ret;
-			extent_offset += prealloc_len;
-		}
-
-		ret = emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
-					 delalloc_end + 1 - delalloc_start,
-					 FIEMAP_EXTENT_DELALLOC |
-					 FIEMAP_EXTENT_UNKNOWN);
-		if (ret)
-			return ret;
-
-		last_delalloc_end = delalloc_end;
-		cur_offset = delalloc_end + 1;
-		extent_offset += cur_offset - delalloc_start;
-		cond_resched();
-	}
-
-	/*
-	 * Either we found no delalloc for the whole prealloc extent or we have
-	 * a prealloc extent that spans i_size or starts at or after i_size.
-	 */
-	if (disk_bytenr != 0 && last_delalloc_end < end) {
-		u64 prealloc_start;
-		u64 prealloc_len;
-
-		if (last_delalloc_end == 0) {
-			prealloc_start = start;
-			prealloc_len = end + 1 - start;
-		} else {
-			prealloc_start = last_delalloc_end + 1;
-			prealloc_len = end + 1 - prealloc_start;
-		}
-
-		if (!checked_extent_shared && fieinfo->fi_extents_max) {
-			ret = btrfs_is_data_extent_shared(inode,
-							  disk_bytenr,
-							  extent_gen,
-							  backref_ctx);
-			if (ret < 0)
-				return ret;
-			else if (ret > 0)
-				prealloc_flags |= FIEMAP_EXTENT_SHARED;
-		}
-		ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
-					 disk_bytenr + extent_offset,
-					 prealloc_len, prealloc_flags);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
-					  struct btrfs_path *path,
-					  u64 *last_extent_end_ret)
-{
-	const u64 ino = btrfs_ino(inode);
-	struct btrfs_root *root = inode->root;
-	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *ei;
-	struct btrfs_key key;
-	u64 disk_bytenr;
-	int ret;
-
-	/*
-	 * Lookup the last file extent. We're not using i_size here because
-	 * there might be preallocation past i_size.
-	 */
-	ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
-	/* There can't be a file extent item at offset (u64)-1 */
-	ASSERT(ret != 0);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * For a non-existing key, btrfs_search_slot() always leaves us at a
-	 * slot > 0, except if the btree is empty, which is impossible because
-	 * at least it has the inode item for this inode and all the items for
-	 * the root inode 256.
-	 */
-	ASSERT(path->slots[0] > 0);
-	path->slots[0]--;
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-	if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
-		/* No file extent items in the subvolume tree. */
-		*last_extent_end_ret = 0;
-		return 0;
-	}
-
-	/*
-	 * For an inline extent, the disk_bytenr is where inline data starts at,
-	 * so first check if we have an inline extent item before checking if we
-	 * have an implicit hole (disk_bytenr == 0).
-	 */
-	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
-		*last_extent_end_ret = btrfs_file_extent_end(path);
-		return 0;
-	}
-
-	/*
-	 * Find the last file extent item that is not a hole (when NO_HOLES is
-	 * not enabled). This should take at most 2 iterations in the worst
-	 * case: we have one hole file extent item at slot 0 of a leaf and
-	 * another hole file extent item as the last item in the previous leaf.
-	 * This is because we merge file extent items that represent holes.
-	 */
-	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
-	while (disk_bytenr == 0) {
-		ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
-		if (ret < 0) {
-			return ret;
-		} else if (ret > 0) {
-			/* No file extent items that are not holes. */
-			*last_extent_end_ret = 0;
-			return 0;
-		}
-		leaf = path->nodes[0];
-		ei = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
-	}
-
-	*last_extent_end_ret = btrfs_file_extent_end(path);
-	return 0;
-}
-
-int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
-		  u64 start, u64 len)
-{
-	const u64 ino = btrfs_ino(inode);
-	struct extent_state *cached_state = NULL;
-	struct extent_state *delalloc_cached_state = NULL;
-	struct btrfs_path *path;
-	struct fiemap_cache cache = { 0 };
-	struct btrfs_backref_share_check_ctx *backref_ctx;
-	u64 last_extent_end;
-	u64 prev_extent_end;
-	u64 range_start;
-	u64 range_end;
-	const u64 sectorsize = inode->root->fs_info->sectorsize;
-	bool stopped = false;
-	int ret;
-
-	cache.entries_size = PAGE_SIZE / sizeof(struct btrfs_fiemap_entry);
-	cache.entries = kmalloc_array(cache.entries_size,
-				      sizeof(struct btrfs_fiemap_entry),
-				      GFP_KERNEL);
-	backref_ctx = btrfs_alloc_backref_share_check_ctx();
-	path = btrfs_alloc_path();
-	if (!cache.entries || !backref_ctx || !path) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-restart:
-	range_start = round_down(start, sectorsize);
-	range_end = round_up(start + len, sectorsize);
-	prev_extent_end = range_start;
-
-	lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
-
-	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
-	if (ret < 0)
-		goto out_unlock;
-	btrfs_release_path(path);
-
-	path->reada = READA_FORWARD;
-	ret = fiemap_search_slot(inode, path, range_start);
-	if (ret < 0) {
-		goto out_unlock;
-	} else if (ret > 0) {
-		/*
-		 * No file extent item found, but we may have delalloc between
-		 * the current offset and i_size. So check for that.
-		 */
-		ret = 0;
-		goto check_eof_delalloc;
-	}
-
-	while (prev_extent_end < range_end) {
-		struct extent_buffer *leaf = path->nodes[0];
-		struct btrfs_file_extent_item *ei;
-		struct btrfs_key key;
-		u64 extent_end;
-		u64 extent_len;
-		u64 extent_offset = 0;
-		u64 extent_gen;
-		u64 disk_bytenr = 0;
-		u64 flags = 0;
-		int extent_type;
-		u8 compression;
-
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
-			break;
-
-		extent_end = btrfs_file_extent_end(path);
-
-		/*
-		 * The first iteration can leave us at an extent item that ends
-		 * before our range's start. Move to the next item.
-		 */
-		if (extent_end <= range_start)
-			goto next_item;
-
-		backref_ctx->curr_leaf_bytenr = leaf->start;
-
-		/* We have in implicit hole (NO_HOLES feature enabled). */
-		if (prev_extent_end < key.offset) {
-			const u64 hole_end = min(key.offset, range_end) - 1;
-
-			ret = fiemap_process_hole(inode, fieinfo, &cache,
-						  &delalloc_cached_state,
-						  backref_ctx, 0, 0, 0,
-						  prev_extent_end, hole_end);
-			if (ret < 0) {
-				goto out_unlock;
-			} else if (ret > 0) {
-				/* fiemap_fill_next_extent() told us to stop. */
-				stopped = true;
-				break;
-			}
-
-			/* We've reached the end of the fiemap range, stop. */
-			if (key.offset >= range_end) {
-				stopped = true;
-				break;
-			}
-		}
-
-		extent_len = extent_end - key.offset;
-		ei = btrfs_item_ptr(leaf, path->slots[0],
-				    struct btrfs_file_extent_item);
-		compression = btrfs_file_extent_compression(leaf, ei);
-		extent_type = btrfs_file_extent_type(leaf, ei);
-		extent_gen = btrfs_file_extent_generation(leaf, ei);
-
-		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
-			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
-			if (compression == BTRFS_COMPRESS_NONE)
-				extent_offset = btrfs_file_extent_offset(leaf, ei);
-		}
-
-		if (compression != BTRFS_COMPRESS_NONE)
-			flags |= FIEMAP_EXTENT_ENCODED;
-
-		if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-			flags |= FIEMAP_EXTENT_DATA_INLINE;
-			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
-			ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
-						 extent_len, flags);
-		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
-			ret = fiemap_process_hole(inode, fieinfo, &cache,
-						  &delalloc_cached_state,
-						  backref_ctx,
-						  disk_bytenr, extent_offset,
-						  extent_gen, key.offset,
-						  extent_end - 1);
-		} else if (disk_bytenr == 0) {
-			/* We have an explicit hole. */
-			ret = fiemap_process_hole(inode, fieinfo, &cache,
-						  &delalloc_cached_state,
-						  backref_ctx, 0, 0, 0,
-						  key.offset, extent_end - 1);
-		} else {
-			/* We have a regular extent. */
-			if (fieinfo->fi_extents_max) {
-				ret = btrfs_is_data_extent_shared(inode,
-								  disk_bytenr,
-								  extent_gen,
-								  backref_ctx);
-				if (ret < 0)
-					goto out_unlock;
-				else if (ret > 0)
-					flags |= FIEMAP_EXTENT_SHARED;
-			}
-
-			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
-						 disk_bytenr + extent_offset,
-						 extent_len, flags);
-		}
-
-		if (ret < 0) {
-			goto out_unlock;
-		} else if (ret > 0) {
-			/* emit_fiemap_extent() told us to stop. */
-			stopped = true;
-			break;
-		}
-
-		prev_extent_end = extent_end;
-next_item:
-		if (fatal_signal_pending(current)) {
-			ret = -EINTR;
-			goto out_unlock;
-		}
-
-		ret = fiemap_next_leaf_item(inode, path);
-		if (ret < 0) {
-			goto out_unlock;
-		} else if (ret > 0) {
-			/* No more file extent items for this inode. */
-			break;
-		}
-		cond_resched();
-	}
-
-check_eof_delalloc:
-	if (!stopped && prev_extent_end < range_end) {
-		ret = fiemap_process_hole(inode, fieinfo, &cache,
-					  &delalloc_cached_state, backref_ctx,
-					  0, 0, 0, prev_extent_end, range_end - 1);
-		if (ret < 0)
-			goto out_unlock;
-		prev_extent_end = range_end;
-	}
-
-	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
-		const u64 i_size = i_size_read(&inode->vfs_inode);
-
-		if (prev_extent_end < i_size) {
-			u64 delalloc_start;
-			u64 delalloc_end;
-			bool delalloc;
-
-			delalloc = btrfs_find_delalloc_in_range(inode,
-								prev_extent_end,
-								i_size - 1,
-								&delalloc_cached_state,
-								&delalloc_start,
-								&delalloc_end);
-			if (!delalloc)
-				cache.flags |= FIEMAP_EXTENT_LAST;
-		} else {
-			cache.flags |= FIEMAP_EXTENT_LAST;
-		}
-	}
-
-out_unlock:
-	unlock_extent(&inode->io_tree, range_start, range_end, &cached_state);
-
-	if (ret == BTRFS_FIEMAP_FLUSH_CACHE) {
-		btrfs_release_path(path);
-		ret = flush_fiemap_cache(fieinfo, &cache);
-		if (ret)
-			goto out;
-		len -= cache.next_search_offset - start;
-		start = cache.next_search_offset;
-		goto restart;
-	} else if (ret < 0) {
-		goto out;
-	}
-
-	/*
-	 * Must free the path before emitting to the fiemap buffer because we
-	 * may have a non-cloned leaf and if the fiemap buffer is memory mapped
-	 * to a file, a write into it (through btrfs_page_mkwrite()) may trigger
-	 * waiting for an ordered extent that in order to complete needs to
-	 * modify that leaf, therefore leading to a deadlock.
-	 */
-	btrfs_free_path(path);
-	path = NULL;
-
-	ret = flush_fiemap_cache(fieinfo, &cache);
-	if (ret)
-		goto out;
-
-	ret = emit_last_fiemap_cache(fieinfo, &cache);
-out:
-	free_extent_state(delalloc_cached_state);
-	kfree(cache.entries);
-	btrfs_free_backref_share_ctx(backref_ctx);
-	btrfs_free_path(path);
-	return ret;
-}
-
 static void __free_extent_buffer(struct extent_buffer *eb)
 {
 	kmem_cache_free(extent_buffer_cache, eb);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index dca6b12769ec..ecf89424502e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -242,8 +242,6 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
 void btrfs_readahead(struct readahead_control *rac);
-int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
-		  u64 start, u64 len);
 int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
 void clear_page_extent_mapped(struct page *page);
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
new file mode 100644
index 000000000000..8f95f3e44e99
--- /dev/null
+++ b/fs/btrfs/fiemap.c
@@ -0,0 +1,930 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "backref.h"
+#include "btrfs_inode.h"
+#include "fiemap.h"
+#include "file.h"
+#include "file-item.h"
+
+struct btrfs_fiemap_entry {
+	u64 offset;
+	u64 phys;
+	u64 len;
+	u32 flags;
+};
+
+/*
+ * Indicate the caller of emit_fiemap_extent() that it needs to unlock the file
+ * range from the inode's io tree, unlock the subvolume tree search path, flush
+ * the fiemap cache and relock the file range and research the subvolume tree.
+ * The value here is something negative that can't be confused with a valid
+ * errno value and different from 1 because that's also a return value from
+ * fiemap_fill_next_extent() and also it's often used to mean some btree search
+ * did not find a key, so make it some distinct negative value.
+ */
+#define BTRFS_FIEMAP_FLUSH_CACHE (-(MAX_ERRNO + 1))
+
+/*
+ * Used to:
+ *
+ * - Cache the next entry to be emitted to the fiemap buffer, so that we can
+ *   merge extents that are contiguous and can be grouped as a single one;
+ *
+ * - Store extents ready to be written to the fiemap buffer in an intermediary
+ *   buffer. This intermediary buffer is to ensure that in case the fiemap
+ *   buffer is memory mapped to the fiemap target file, we don't deadlock
+ *   during btrfs_page_mkwrite(). This is because during fiemap we are locking
+ *   an extent range in order to prevent races with delalloc flushing and
+ *   ordered extent completion, which is needed in order to reliably detect
+ *   delalloc in holes and prealloc extents. And this can lead to a deadlock
+ *   if the fiemap buffer is memory mapped to the file we are running fiemap
+ *   against (a silly, useless in practice scenario, but possible) because
+ *   btrfs_page_mkwrite() will try to lock the same extent range.
+ */
+struct fiemap_cache {
+	/* An array of ready fiemap entries. */
+	struct btrfs_fiemap_entry *entries;
+	/* Number of entries in the entries array. */
+	int entries_size;
+	/* Index of the next entry in the entries array to write to. */
+	int entries_pos;
+	/*
+	 * Once the entries array is full, this indicates what's the offset for
+	 * the next file extent item we must search for in the inode's subvolume
+	 * tree after unlocking the extent range in the inode's io tree and
+	 * releasing the search path.
+	 */
+	u64 next_search_offset;
+	/*
+	 * This matches struct fiemap_extent_info::fi_mapped_extents, we use it
+	 * to count ourselves emitted extents and stop instead of relying on
+	 * fiemap_fill_next_extent() because we buffer ready fiemap entries at
+	 * the @entries array, and we want to stop as soon as we hit the max
+	 * amount of extents to map, not just to save time but also to make the
+	 * logic at extent_fiemap() simpler.
+	 */
+	unsigned int extents_mapped;
+	/* Fields for the cached extent (unsubmitted, not ready, extent). */
+	u64 offset;
+	u64 phys;
+	u64 len;
+	u32 flags;
+	bool cached;
+};
+
+static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
+			      struct fiemap_cache *cache)
+{
+	for (int i = 0; i < cache->entries_pos; i++) {
+		struct btrfs_fiemap_entry *entry = &cache->entries[i];
+		int ret;
+
+		ret = fiemap_fill_next_extent(fieinfo, entry->offset,
+					      entry->phys, entry->len,
+					      entry->flags);
+		/*
+		 * Ignore 1 (reached max entries) because we keep track of that
+		 * ourselves in emit_fiemap_extent().
+		 */
+		if (ret < 0)
+			return ret;
+	}
+	cache->entries_pos = 0;
+
+	return 0;
+}
+
+/*
+ * Helper to submit fiemap extent.
+ *
+ * Will try to merge current fiemap extent specified by @offset, @phys,
+ * @len and @flags with cached one.
+ * And only when we fails to merge, cached one will be submitted as
+ * fiemap extent.
+ *
+ * Return value is the same as fiemap_fill_next_extent().
+ */
+static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
+				struct fiemap_cache *cache,
+				u64 offset, u64 phys, u64 len, u32 flags)
+{
+	struct btrfs_fiemap_entry *entry;
+	u64 cache_end;
+
+	/* Set at the end of extent_fiemap(). */
+	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
+
+	if (!cache->cached)
+		goto assign;
+
+	/*
+	 * When iterating the extents of the inode, at extent_fiemap(), we may
+	 * find an extent that starts at an offset behind the end offset of the
+	 * previous extent we processed. This happens if fiemap is called
+	 * without FIEMAP_FLAG_SYNC and there are ordered extents completing
+	 * after we had to unlock the file range, release the search path, emit
+	 * the fiemap extents stored in the buffer (cache->entries array) and
+	 * the lock the remainder of the range and re-search the btree.
+	 *
+	 * For example we are in leaf X processing its last item, which is the
+	 * file extent item for file range [512K, 1M[, and after
+	 * btrfs_next_leaf() releases the path, there's an ordered extent that
+	 * completes for the file range [768K, 2M[, and that results in trimming
+	 * the file extent item so that it now corresponds to the file range
+	 * [512K, 768K[ and a new file extent item is inserted for the file
+	 * range [768K, 2M[, which may end up as the last item of leaf X or as
+	 * the first item of the next leaf - in either case btrfs_next_leaf()
+	 * will leave us with a path pointing to the new extent item, for the
+	 * file range [768K, 2M[, since that's the first key that follows the
+	 * last one we processed. So in order not to report overlapping extents
+	 * to user space, we trim the length of the previously cached extent and
+	 * emit it.
+	 *
+	 * Upon calling btrfs_next_leaf() we may also find an extent with an
+	 * offset smaller than or equals to cache->offset, and this happens
+	 * when we had a hole or prealloc extent with several delalloc ranges in
+	 * it, but after btrfs_next_leaf() released the path, delalloc was
+	 * flushed and the resulting ordered extents were completed, so we can
+	 * now have found a file extent item for an offset that is smaller than
+	 * or equals to what we have in cache->offset. We deal with this as
+	 * described below.
+	 */
+	cache_end = cache->offset + cache->len;
+	if (cache_end > offset) {
+		if (offset == cache->offset) {
+			/*
+			 * We cached a dealloc range (found in the io tree) for
+			 * a hole or prealloc extent and we have now found a
+			 * file extent item for the same offset. What we have
+			 * now is more recent and up to date, so discard what
+			 * we had in the cache and use what we have just found.
+			 */
+			goto assign;
+		} else if (offset > cache->offset) {
+			/*
+			 * The extent range we previously found ends after the
+			 * offset of the file extent item we found and that
+			 * offset falls somewhere in the middle of that previous
+			 * extent range. So adjust the range we previously found
+			 * to end at the offset of the file extent item we have
+			 * just found, since this extent is more up to date.
+			 * Emit that adjusted range and cache the file extent
+			 * item we have just found. This corresponds to the case
+			 * where a previously found file extent item was split
+			 * due to an ordered extent completing.
+			 */
+			cache->len = offset - cache->offset;
+			goto emit;
+		} else {
+			const u64 range_end = offset + len;
+
+			/*
+			 * The offset of the file extent item we have just found
+			 * is behind the cached offset. This means we were
+			 * processing a hole or prealloc extent for which we
+			 * have found delalloc ranges (in the io tree), so what
+			 * we have in the cache is the last delalloc range we
+			 * found while the file extent item we found can be
+			 * either for a whole delalloc range we previously
+			 * emmitted or only a part of that range.
+			 *
+			 * We have two cases here:
+			 *
+			 * 1) The file extent item's range ends at or behind the
+			 *    cached extent's end. In this case just ignore the
+			 *    current file extent item because we don't want to
+			 *    overlap with previous ranges that may have been
+			 *    emmitted already;
+			 *
+			 * 2) The file extent item starts behind the currently
+			 *    cached extent but its end offset goes beyond the
+			 *    end offset of the cached extent. We don't want to
+			 *    overlap with a previous range that may have been
+			 *    emmitted already, so we emit the currently cached
+			 *    extent and then partially store the current file
+			 *    extent item's range in the cache, for the subrange
+			 *    going the cached extent's end to the end of the
+			 *    file extent item.
+			 */
+			if (range_end <= cache_end)
+				return 0;
+
+			if (!(flags & (FIEMAP_EXTENT_ENCODED | FIEMAP_EXTENT_DELALLOC)))
+				phys += cache_end - offset;
+
+			offset = cache_end;
+			len = range_end - cache_end;
+			goto emit;
+		}
+	}
+
+	/*
+	 * Only merges fiemap extents if
+	 * 1) Their logical addresses are continuous
+	 *
+	 * 2) Their physical addresses are continuous
+	 *    So truly compressed (physical size smaller than logical size)
+	 *    extents won't get merged with each other
+	 *
+	 * 3) Share same flags
+	 */
+	if (cache->offset + cache->len  == offset &&
+	    cache->phys + cache->len == phys  &&
+	    cache->flags == flags) {
+		cache->len += len;
+		return 0;
+	}
+
+emit:
+	/* Not mergeable, need to submit cached one */
+
+	if (cache->entries_pos == cache->entries_size) {
+		/*
+		 * We will need to research for the end offset of the last
+		 * stored extent and not from the current offset, because after
+		 * unlocking the range and releasing the path, if there's a hole
+		 * between that end offset and this current offset, a new extent
+		 * may have been inserted due to a new write, so we don't want
+		 * to miss it.
+		 */
+		entry = &cache->entries[cache->entries_size - 1];
+		cache->next_search_offset = entry->offset + entry->len;
+		cache->cached = false;
+
+		return BTRFS_FIEMAP_FLUSH_CACHE;
+	}
+
+	entry = &cache->entries[cache->entries_pos];
+	entry->offset = cache->offset;
+	entry->phys = cache->phys;
+	entry->len = cache->len;
+	entry->flags = cache->flags;
+	cache->entries_pos++;
+	cache->extents_mapped++;
+
+	if (cache->extents_mapped == fieinfo->fi_extents_max) {
+		cache->cached = false;
+		return 1;
+	}
+assign:
+	cache->cached = true;
+	cache->offset = offset;
+	cache->phys = phys;
+	cache->len = len;
+	cache->flags = flags;
+
+	return 0;
+}
+
+/*
+ * Emit last fiemap cache
+ *
+ * The last fiemap cache may still be cached in the following case:
+ * 0		      4k		    8k
+ * |<- Fiemap range ->|
+ * |<------------  First extent ----------->|
+ *
+ * In this case, the first extent range will be cached but not emitted.
+ * So we must emit it before ending extent_fiemap().
+ */
+static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
+				  struct fiemap_cache *cache)
+{
+	int ret;
+
+	if (!cache->cached)
+		return 0;
+
+	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
+				      cache->len, cache->flags);
+	cache->cached = false;
+	if (ret > 0)
+		ret = 0;
+	return ret;
+}
+
+static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *path)
+{
+	struct extent_buffer *clone = path->nodes[0];
+	struct btrfs_key key;
+	int slot;
+	int ret;
+
+	path->slots[0]++;
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0]))
+		return 0;
+
+	/*
+	 * Add a temporary extra ref to an already cloned extent buffer to
+	 * prevent btrfs_next_leaf() freeing it, we want to reuse it to avoid
+	 * the cost of allocating a new one.
+	 */
+	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
+	atomic_inc(&clone->refs);
+
+	ret = btrfs_next_leaf(inode->root, path);
+	if (ret != 0)
+		goto out;
+
+	/*
+	 * Don't bother with cloning if there are no more file extent items for
+	 * our inode.
+	 */
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	if (key.objectid != btrfs_ino(inode) || key.type != BTRFS_EXTENT_DATA_KEY) {
+		ret = 1;
+		goto out;
+	}
+
+	/*
+	 * Important to preserve the start field, for the optimizations when
+	 * checking if extents are shared (see extent_fiemap()).
+	 *
+	 * We must set ->start before calling copy_extent_buffer_full().  If we
+	 * are on sub-pagesize blocksize, we use ->start to determine the offset
+	 * into the folio where our eb exists, and if we update ->start after
+	 * the fact then any subsequent reads of the eb may read from a
+	 * different offset in the folio than where we originally copied into.
+	 */
+	clone->start = path->nodes[0]->start;
+	/* See the comment at fiemap_search_slot() about why we clone. */
+	copy_extent_buffer_full(clone, path->nodes[0]);
+
+	slot = path->slots[0];
+	btrfs_release_path(path);
+	path->nodes[0] = clone;
+	path->slots[0] = slot;
+out:
+	if (ret)
+		free_extent_buffer(clone);
+
+	return ret;
+}
+
+/*
+ * Search for the first file extent item that starts at a given file offset or
+ * the one that starts immediately before that offset.
+ * Returns: 0 on success, < 0 on error, 1 if not found.
+ */
+static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path,
+			      u64 file_offset)
+{
+	const u64 ino = btrfs_ino(inode);
+	struct btrfs_root *root = inode->root;
+	struct extent_buffer *clone;
+	struct btrfs_key key;
+	int slot;
+	int ret;
+
+	key.objectid = ino;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = file_offset;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	if (ret > 0 && path->slots[0] > 0) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
+		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
+			path->slots[0]--;
+	}
+
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+		ret = btrfs_next_leaf(root, path);
+		if (ret != 0)
+			return ret;
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
+			return 1;
+	}
+
+	/*
+	 * We clone the leaf and use it during fiemap. This is because while
+	 * using the leaf we do expensive things like checking if an extent is
+	 * shared, which can take a long time. In order to prevent blocking
+	 * other tasks for too long, we use a clone of the leaf. We have locked
+	 * the file range in the inode's io tree, so we know none of our file
+	 * extent items can change. This way we avoid blocking other tasks that
+	 * want to insert items for other inodes in the same leaf or b+tree
+	 * rebalance operations (triggered for example when someone is trying
+	 * to push items into this leaf when trying to insert an item in a
+	 * neighbour leaf).
+	 * We also need the private clone because holding a read lock on an
+	 * extent buffer of the subvolume's b+tree will make lockdep unhappy
+	 * when we check if extents are shared, as backref walking may need to
+	 * lock the same leaf we are processing.
+	 */
+	clone = btrfs_clone_extent_buffer(path->nodes[0]);
+	if (!clone)
+		return -ENOMEM;
+
+	slot = path->slots[0];
+	btrfs_release_path(path);
+	path->nodes[0] = clone;
+	path->slots[0] = slot;
+
+	return 0;
+}
+
+/*
+ * Process a range which is a hole or a prealloc extent in the inode's subvolume
+ * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a prealloc
+ * extent. The end offset (@end) is inclusive.
+ */
+static int fiemap_process_hole(struct btrfs_inode *inode,
+			       struct fiemap_extent_info *fieinfo,
+			       struct fiemap_cache *cache,
+			       struct extent_state **delalloc_cached_state,
+			       struct btrfs_backref_share_check_ctx *backref_ctx,
+			       u64 disk_bytenr, u64 extent_offset,
+			       u64 extent_gen,
+			       u64 start, u64 end)
+{
+	const u64 i_size = i_size_read(&inode->vfs_inode);
+	u64 cur_offset = start;
+	u64 last_delalloc_end = 0;
+	u32 prealloc_flags = FIEMAP_EXTENT_UNWRITTEN;
+	bool checked_extent_shared = false;
+	int ret;
+
+	/*
+	 * There can be no delalloc past i_size, so don't waste time looking for
+	 * it beyond i_size.
+	 */
+	while (cur_offset < end && cur_offset < i_size) {
+		u64 delalloc_start;
+		u64 delalloc_end;
+		u64 prealloc_start;
+		u64 prealloc_len = 0;
+		bool delalloc;
+
+		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
+							delalloc_cached_state,
+							&delalloc_start,
+							&delalloc_end);
+		if (!delalloc)
+			break;
+
+		/*
+		 * If this is a prealloc extent we have to report every section
+		 * of it that has no delalloc.
+		 */
+		if (disk_bytenr != 0) {
+			if (last_delalloc_end == 0) {
+				prealloc_start = start;
+				prealloc_len = delalloc_start - start;
+			} else {
+				prealloc_start = last_delalloc_end + 1;
+				prealloc_len = delalloc_start - prealloc_start;
+			}
+		}
+
+		if (prealloc_len > 0) {
+			if (!checked_extent_shared && fieinfo->fi_extents_max) {
+				ret = btrfs_is_data_extent_shared(inode,
+								  disk_bytenr,
+								  extent_gen,
+								  backref_ctx);
+				if (ret < 0)
+					return ret;
+				else if (ret > 0)
+					prealloc_flags |= FIEMAP_EXTENT_SHARED;
+
+				checked_extent_shared = true;
+			}
+			ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
+						 disk_bytenr + extent_offset,
+						 prealloc_len, prealloc_flags);
+			if (ret)
+				return ret;
+			extent_offset += prealloc_len;
+		}
+
+		ret = emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
+					 delalloc_end + 1 - delalloc_start,
+					 FIEMAP_EXTENT_DELALLOC |
+					 FIEMAP_EXTENT_UNKNOWN);
+		if (ret)
+			return ret;
+
+		last_delalloc_end = delalloc_end;
+		cur_offset = delalloc_end + 1;
+		extent_offset += cur_offset - delalloc_start;
+		cond_resched();
+	}
+
+	/*
+	 * Either we found no delalloc for the whole prealloc extent or we have
+	 * a prealloc extent that spans i_size or starts at or after i_size.
+	 */
+	if (disk_bytenr != 0 && last_delalloc_end < end) {
+		u64 prealloc_start;
+		u64 prealloc_len;
+
+		if (last_delalloc_end == 0) {
+			prealloc_start = start;
+			prealloc_len = end + 1 - start;
+		} else {
+			prealloc_start = last_delalloc_end + 1;
+			prealloc_len = end + 1 - prealloc_start;
+		}
+
+		if (!checked_extent_shared && fieinfo->fi_extents_max) {
+			ret = btrfs_is_data_extent_shared(inode,
+							  disk_bytenr,
+							  extent_gen,
+							  backref_ctx);
+			if (ret < 0)
+				return ret;
+			else if (ret > 0)
+				prealloc_flags |= FIEMAP_EXTENT_SHARED;
+		}
+		ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
+					 disk_bytenr + extent_offset,
+					 prealloc_len, prealloc_flags);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int fiemap_find_last_extent_offset(struct btrfs_inode *inode,
+					  struct btrfs_path *path,
+					  u64 *last_extent_end_ret)
+{
+	const u64 ino = btrfs_ino(inode);
+	struct btrfs_root *root = inode->root;
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *ei;
+	struct btrfs_key key;
+	u64 disk_bytenr;
+	int ret;
+
+	/*
+	 * Lookup the last file extent. We're not using i_size here because
+	 * there might be preallocation past i_size.
+	 */
+	ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
+	/* There can't be a file extent item at offset (u64)-1 */
+	ASSERT(ret != 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * For a non-existing key, btrfs_search_slot() always leaves us at a
+	 * slot > 0, except if the btree is empty, which is impossible because
+	 * at least it has the inode item for this inode and all the items for
+	 * the root inode 256.
+	 */
+	ASSERT(path->slots[0] > 0);
+	path->slots[0]--;
+	leaf = path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+	if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
+		/* No file extent items in the subvolume tree. */
+		*last_extent_end_ret = 0;
+		return 0;
+	}
+
+	/*
+	 * For an inline extent, the disk_bytenr is where inline data starts at,
+	 * so first check if we have an inline extent item before checking if we
+	 * have an implicit hole (disk_bytenr == 0).
+	 */
+	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+	if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
+		*last_extent_end_ret = btrfs_file_extent_end(path);
+		return 0;
+	}
+
+	/*
+	 * Find the last file extent item that is not a hole (when NO_HOLES is
+	 * not enabled). This should take at most 2 iterations in the worst
+	 * case: we have one hole file extent item at slot 0 of a leaf and
+	 * another hole file extent item as the last item in the previous leaf.
+	 * This is because we merge file extent items that represent holes.
+	 */
+	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+	while (disk_bytenr == 0) {
+		ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
+		if (ret < 0) {
+			return ret;
+		} else if (ret > 0) {
+			/* No file extent items that are not holes. */
+			*last_extent_end_ret = 0;
+			return 0;
+		}
+		leaf = path->nodes[0];
+		ei = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_extent_item);
+		disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+	}
+
+	*last_extent_end_ret = btrfs_file_extent_end(path);
+	return 0;
+}
+
+static int extent_fiemap(struct btrfs_inode *inode,
+			 struct fiemap_extent_info *fieinfo,
+			 u64 start, u64 len)
+{
+	const u64 ino = btrfs_ino(inode);
+	struct extent_state *cached_state = NULL;
+	struct extent_state *delalloc_cached_state = NULL;
+	struct btrfs_path *path;
+	struct fiemap_cache cache = { 0 };
+	struct btrfs_backref_share_check_ctx *backref_ctx;
+	u64 last_extent_end;
+	u64 prev_extent_end;
+	u64 range_start;
+	u64 range_end;
+	const u64 sectorsize = inode->root->fs_info->sectorsize;
+	bool stopped = false;
+	int ret;
+
+	cache.entries_size = PAGE_SIZE / sizeof(struct btrfs_fiemap_entry);
+	cache.entries = kmalloc_array(cache.entries_size,
+				      sizeof(struct btrfs_fiemap_entry),
+				      GFP_KERNEL);
+	backref_ctx = btrfs_alloc_backref_share_check_ctx();
+	path = btrfs_alloc_path();
+	if (!cache.entries || !backref_ctx || !path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+restart:
+	range_start = round_down(start, sectorsize);
+	range_end = round_up(start + len, sectorsize);
+	prev_extent_end = range_start;
+
+	lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+
+	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
+	if (ret < 0)
+		goto out_unlock;
+	btrfs_release_path(path);
+
+	path->reada = READA_FORWARD;
+	ret = fiemap_search_slot(inode, path, range_start);
+	if (ret < 0) {
+		goto out_unlock;
+	} else if (ret > 0) {
+		/*
+		 * No file extent item found, but we may have delalloc between
+		 * the current offset and i_size. So check for that.
+		 */
+		ret = 0;
+		goto check_eof_delalloc;
+	}
+
+	while (prev_extent_end < range_end) {
+		struct extent_buffer *leaf = path->nodes[0];
+		struct btrfs_file_extent_item *ei;
+		struct btrfs_key key;
+		u64 extent_end;
+		u64 extent_len;
+		u64 extent_offset = 0;
+		u64 extent_gen;
+		u64 disk_bytenr = 0;
+		u64 flags = 0;
+		int extent_type;
+		u8 compression;
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
+			break;
+
+		extent_end = btrfs_file_extent_end(path);
+
+		/*
+		 * The first iteration can leave us at an extent item that ends
+		 * before our range's start. Move to the next item.
+		 */
+		if (extent_end <= range_start)
+			goto next_item;
+
+		backref_ctx->curr_leaf_bytenr = leaf->start;
+
+		/* We have in implicit hole (NO_HOLES feature enabled). */
+		if (prev_extent_end < key.offset) {
+			const u64 hole_end = min(key.offset, range_end) - 1;
+
+			ret = fiemap_process_hole(inode, fieinfo, &cache,
+						  &delalloc_cached_state,
+						  backref_ctx, 0, 0, 0,
+						  prev_extent_end, hole_end);
+			if (ret < 0) {
+				goto out_unlock;
+			} else if (ret > 0) {
+				/* fiemap_fill_next_extent() told us to stop. */
+				stopped = true;
+				break;
+			}
+
+			/* We've reached the end of the fiemap range, stop. */
+			if (key.offset >= range_end) {
+				stopped = true;
+				break;
+			}
+		}
+
+		extent_len = extent_end - key.offset;
+		ei = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_file_extent_item);
+		compression = btrfs_file_extent_compression(leaf, ei);
+		extent_type = btrfs_file_extent_type(leaf, ei);
+		extent_gen = btrfs_file_extent_generation(leaf, ei);
+
+		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
+			disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
+			if (compression == BTRFS_COMPRESS_NONE)
+				extent_offset = btrfs_file_extent_offset(leaf, ei);
+		}
+
+		if (compression != BTRFS_COMPRESS_NONE)
+			flags |= FIEMAP_EXTENT_ENCODED;
+
+		if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+			flags |= FIEMAP_EXTENT_DATA_INLINE;
+			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
+			ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
+						 extent_len, flags);
+		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
+			ret = fiemap_process_hole(inode, fieinfo, &cache,
+						  &delalloc_cached_state,
+						  backref_ctx,
+						  disk_bytenr, extent_offset,
+						  extent_gen, key.offset,
+						  extent_end - 1);
+		} else if (disk_bytenr == 0) {
+			/* We have an explicit hole. */
+			ret = fiemap_process_hole(inode, fieinfo, &cache,
+						  &delalloc_cached_state,
+						  backref_ctx, 0, 0, 0,
+						  key.offset, extent_end - 1);
+		} else {
+			/* We have a regular extent. */
+			if (fieinfo->fi_extents_max) {
+				ret = btrfs_is_data_extent_shared(inode,
+								  disk_bytenr,
+								  extent_gen,
+								  backref_ctx);
+				if (ret < 0)
+					goto out_unlock;
+				else if (ret > 0)
+					flags |= FIEMAP_EXTENT_SHARED;
+			}
+
+			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
+						 disk_bytenr + extent_offset,
+						 extent_len, flags);
+		}
+
+		if (ret < 0) {
+			goto out_unlock;
+		} else if (ret > 0) {
+			/* emit_fiemap_extent() told us to stop. */
+			stopped = true;
+			break;
+		}
+
+		prev_extent_end = extent_end;
+next_item:
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out_unlock;
+		}
+
+		ret = fiemap_next_leaf_item(inode, path);
+		if (ret < 0) {
+			goto out_unlock;
+		} else if (ret > 0) {
+			/* No more file extent items for this inode. */
+			break;
+		}
+		cond_resched();
+	}
+
+check_eof_delalloc:
+	if (!stopped && prev_extent_end < range_end) {
+		ret = fiemap_process_hole(inode, fieinfo, &cache,
+					  &delalloc_cached_state, backref_ctx,
+					  0, 0, 0, prev_extent_end, range_end - 1);
+		if (ret < 0)
+			goto out_unlock;
+		prev_extent_end = range_end;
+	}
+
+	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
+		const u64 i_size = i_size_read(&inode->vfs_inode);
+
+		if (prev_extent_end < i_size) {
+			u64 delalloc_start;
+			u64 delalloc_end;
+			bool delalloc;
+
+			delalloc = btrfs_find_delalloc_in_range(inode,
+								prev_extent_end,
+								i_size - 1,
+								&delalloc_cached_state,
+								&delalloc_start,
+								&delalloc_end);
+			if (!delalloc)
+				cache.flags |= FIEMAP_EXTENT_LAST;
+		} else {
+			cache.flags |= FIEMAP_EXTENT_LAST;
+		}
+	}
+
+out_unlock:
+	unlock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+
+	if (ret == BTRFS_FIEMAP_FLUSH_CACHE) {
+		btrfs_release_path(path);
+		ret = flush_fiemap_cache(fieinfo, &cache);
+		if (ret)
+			goto out;
+		len -= cache.next_search_offset - start;
+		start = cache.next_search_offset;
+		goto restart;
+	} else if (ret < 0) {
+		goto out;
+	}
+
+	/*
+	 * Must free the path before emitting to the fiemap buffer because we
+	 * may have a non-cloned leaf and if the fiemap buffer is memory mapped
+	 * to a file, a write into it (through btrfs_page_mkwrite()) may trigger
+	 * waiting for an ordered extent that in order to complete needs to
+	 * modify that leaf, therefore leading to a deadlock.
+	 */
+	btrfs_free_path(path);
+	path = NULL;
+
+	ret = flush_fiemap_cache(fieinfo, &cache);
+	if (ret)
+		goto out;
+
+	ret = emit_last_fiemap_cache(fieinfo, &cache);
+out:
+	free_extent_state(delalloc_cached_state);
+	kfree(cache.entries);
+	btrfs_free_backref_share_ctx(backref_ctx);
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		 u64 start, u64 len)
+{
+	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
+	int ret;
+
+	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * fiemap_prep() called filemap_write_and_wait() for the whole possible
+	 * file range (0 to LLONG_MAX), but that is not enough if we have
+	 * compression enabled. The first filemap_fdatawrite_range() only kicks
+	 * in the compression of data (in an async thread) and will return
+	 * before the compression is done and writeback is started. A second
+	 * filemap_fdatawrite_range() is needed to wait for the compression to
+	 * complete and writeback to start. We also need to wait for ordered
+	 * extents to complete, because our fiemap implementation uses mainly
+	 * file extent items to list the extents, searching for extent maps
+	 * only for file ranges with holes or prealloc extents to figure out
+	 * if we have delalloc in those ranges.
+	 */
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		ret = btrfs_wait_ordered_range(btrfs_inode, 0, LLONG_MAX);
+		if (ret)
+			return ret;
+	}
+
+	btrfs_inode_lock(btrfs_inode, BTRFS_ILOCK_SHARED);
+
+	/*
+	 * We did an initial flush to avoid holding the inode's lock while
+	 * triggering writeback and waiting for the completion of IO and ordered
+	 * extents. Now after we locked the inode we do it again, because it's
+	 * possible a new write may have happened in between those two steps.
+	 */
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		ret = btrfs_wait_ordered_range(btrfs_inode, 0, LLONG_MAX);
+		if (ret) {
+			btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
+			return ret;
+		}
+	}
+
+	ret = extent_fiemap(btrfs_inode, fieinfo, start, len);
+	btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
+
+	return ret;
+}
diff --git a/fs/btrfs/fiemap.h b/fs/btrfs/fiemap.h
new file mode 100644
index 000000000000..cfd74b35988f
--- /dev/null
+++ b/fs/btrfs/fiemap.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FIEMAP_H
+#define BTRFS_FIEMAP_H
+
+#include <linux/fiemap.h>
+
+int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		 u64 start, u64 len);
+
+#endif /* BTRFS_FIEMAP_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4410b463c6a..ab16b4ff3612 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -70,6 +70,7 @@
 #include "orphan.h"
 #include "backref.h"
 #include "raid-stripe-tree.h"
+#include "fiemap.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -7929,57 +7930,6 @@ struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
 }
 
-static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-			u64 start, u64 len)
-{
-	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
-	int	ret;
-
-	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
-	if (ret)
-		return ret;
-
-	/*
-	 * fiemap_prep() called filemap_write_and_wait() for the whole possible
-	 * file range (0 to LLONG_MAX), but that is not enough if we have
-	 * compression enabled. The first filemap_fdatawrite_range() only kicks
-	 * in the compression of data (in an async thread) and will return
-	 * before the compression is done and writeback is started. A second
-	 * filemap_fdatawrite_range() is needed to wait for the compression to
-	 * complete and writeback to start. We also need to wait for ordered
-	 * extents to complete, because our fiemap implementation uses mainly
-	 * file extent items to list the extents, searching for extent maps
-	 * only for file ranges with holes or prealloc extents to figure out
-	 * if we have delalloc in those ranges.
-	 */
-	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
-		ret = btrfs_wait_ordered_range(btrfs_inode, 0, LLONG_MAX);
-		if (ret)
-			return ret;
-	}
-
-	btrfs_inode_lock(btrfs_inode, BTRFS_ILOCK_SHARED);
-
-	/*
-	 * We did an initial flush to avoid holding the inode's lock while
-	 * triggering writeback and waiting for the completion of IO and ordered
-	 * extents. Now after we locked the inode we do it again, because it's
-	 * possible a new write may have happened in between those two steps.
-	 */
-	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
-		ret = btrfs_wait_ordered_range(btrfs_inode, 0, LLONG_MAX);
-		if (ret) {
-			btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
-			return ret;
-		}
-	}
-
-	ret = extent_fiemap(btrfs_inode, fieinfo, start, len);
-	btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
-
-	return ret;
-}
-
 /*
  * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
-- 
2.43.0


