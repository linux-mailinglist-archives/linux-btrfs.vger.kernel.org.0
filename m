Return-Path: <linux-btrfs+bounces-2920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93BD86C8A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC7E1C21398
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9A7CF23;
	Thu, 29 Feb 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgrGGZMM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6F7CF16
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207787; cv=none; b=IIXSBI89e1gvTYZiby7/8Cp3T8oIGxzc2axkAsVQD1n8fLOoIpG163scVkaqKrCA8UeiCV3n4VK7ugNYEFnIzcicQi6Ng8mdhEIYI9OT1qdQWWx83CJb+3/VWzaOGP//lTOpzVo4vl1T1OzkmTa1IveaEjEsVbDq6bUZ31Qi940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207787; c=relaxed/simple;
	bh=iGwkuavtu4ef/GJjzoWyDet9ln+oGHe5PasTzFTiTis=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svS1PuOy2GpHiE2KDUNlDSELwFT8xBJg6p07cOZ9oy2a+MQ/QlBdyw5Degku0S0krQjj0pz+tFfpP6Cilo3DxGsGWBxr7Vq0KWFTeIoQ0VcE+nd1vFPgWFaYYo0z6/cdtL4TWTP0KDz/dt3q7T5r3G78ot2mlJkyABKFZusYh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgrGGZMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740F1C43390
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207787;
	bh=iGwkuavtu4ef/GJjzoWyDet9ln+oGHe5PasTzFTiTis=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IgrGGZMMH6sIxbfH7hjXWzppRkrd8vMA36SyTgCeQhqv462SxW/aUetW5f5T5VY9W
	 MaIsVGf4DcdOeVl6gzwMMh6AXga2JKvw120pATC/mFyOGXemurblLhPzeONsB7+Ijq
	 PpHVMAoGEsH5y1/Gz8vmNTxxU00aY/8reJQ85FIU9epwwQDpvWGs6nQGEgOD0FWOFc
	 kanMn3D7oTDYgcl7UiR6Y6b6JTow9RWHCSwNSashDGilcTVXqpniRH40lLfxHmNPqe
	 b3B+LoUyFFHBRY0xSboN6q/8Ay96Nb/TkK49q7SqZUpmQOouOoAIaVlTShceRk3VeD
	 pz5Eb0T+bv+KQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix race when detecting delalloc ranges during fiemap
Date: Thu, 29 Feb 2024 11:56:21 +0000
Message-Id: <e8adcaa33401c80963b03f114ce73bf7436ec49f.1709202499.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709202499.git.fdmanana@suse.com>
References: <cover.1709202499.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

For fiemap we recently stopped locking the target extent range for the
whole duration of the fiemap call, in order to avoid a deadlock in a
scenario where the fiemap buffer happens to be a memory mapped range of
the same file. This use case is very unlikely to be useful in practice but
it may be triggered by fuzz testing (syzbot, etc).

This however introduced a race that makes us miss delalloc ranges for
file regions that are currently holes, so the caller of fiemap will not
be aware that there's data for some file regions. This can be quite
serious for some use cases - for example in coreutils versions before 9.0,
the cp program used fiemap to detect holes and data in the source file,
copying only regions with data (extents or delalloc) from the source file
to the destination file in order to preserve holes (see the documentation
for its --sparse command line option). This means that if cp was used
with a source file that had delalloc in a hole, the destination file could
end up without that data, which is effectively a data loss issue, if it
happened to hit the race described below.

The race happens like this:

1) Fiemap is called, without the FIEMAP_FLAG_SYNC flag, for a file that
   has delalloc in the file range [64M, 65M[, which is currently a hole;

2) Fiemap locks the inode in shared mode, then starts iterating the
   inode's subvolume tree searching for file extent items, without having
   the whole fiemap target range locked in the inode's io tree - the
   change introduced recently by commit b0ad381fa769 ("btrfs: fix
   deadlock with fiemap and extent locking"). It only locks ranges in
   the io tree when it finds a hole or prealloc extent since that
   commit;

3) Note that fiemap clones each leaf before using it, and this is to
   avoid deadlocks when locking a file range in the inode's io tree and
   the fiemap buffer is memory mapped to some file, because writing
   to the page with btrfs_page_mkwrite() will wait on any ordered extent
   for the page's range and the ordered extent needs to lock the range
   and may need to modify the same leaf, therefore leading to a deadlock
   on the leaf;

4) While iterating the file extent items in the cloned leaf before
   finding the hole in the range [64M, 65M[, the delalloc in that range
   is flushed and its ordered extent completes - meaning the corresponding
   file extent item is in the inode's subvolume tree, but not present in
   the cloned leaf that fiemap is iterating over;

5) When fiemap finds the hole in the [64M, 65M[ range by seeing the gap in
   the cloned leaf (or a file extent item with disk_bytenr == 0 in case
   the NO_HOLES feature is not enabled), it will lock that file range in
   the inode's io tree and then search for delalloc by checking for the
   EXTENT_DELALLOC bit in the io tree for that range and ordered extents
   (with btrfs_find_delalloc_in_range()). But it finds nothing since the
   delalloc in that range was already flushed and the ordered extent
   completed and is gone - as a result fiemap will not report that there's
   delalloc or an extent for the range [64M, 65M[, so user space will be
   mislead into thinking that there's a hole in that range.

This could actually be sporadically triggered with test case generic/094
from fstests, which reports a missing extent/delalloc range like this:

   generic/094 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/094.out.bad)
       --- tests/generic/094.out	2020-06-10 19:29:03.830519425 +0100
       +++ /home/fdmanana/git/hub/xfstests/results//generic/094.out.bad	2024-02-28 11:00:00.381071525 +0000
       @@ -1,3 +1,9 @@
        QA output created by 094
        fiemap run with sync
        fiemap run without sync
       +ERROR: couldn't find extent at 7
       +map is 'HHDDHPPDPHPH'
       +logical: [       5..       6] phys:   301517..  301518 flags: 0x800 tot: 2
       +logical: [       8..       8] phys:   301520..  301520 flags: 0x800 tot: 1
       ...
       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/094.out /home/fdmanana/git/hub/xfstests/results//generic/094.out.bad'  to see the entire diff)

So in order to fix this, while still avoiding deadlocks in the case where
the fiemap buffer is memory mapped to the same file, change fiemap to work
like the following:

1) Always lock the whole range in the inode's io tree before starting to
   iterate the inode's subvolume tree searching for file extent items,
   just like we did before commit b0ad381fa769 ("btrfs: fix deadlock with
   fiemap and extent locking");

2) Now instead of writing to the fiemap buffer everytime we have an extent
   to report, write instead to a temporary buffer (1 page), and when that
   buffer becomes full, stop iterating the file extent items, unlock the
   range in the io tree, release the search path, submit all the entries
   kept in that buffer to the fiemap buffer, and then resume the search
   for file extent items after locking again the remainder of the range in
   the io tree.

   The buffer having a size of a page, allows for 146 entries in a system
   with 4K pages. This is a large enough value to have a good performance
   by avoiding too many restarts of the search for file extent items.
   In other words this preserves the huge performance gains made in the
   last two years to fiemap, while avoiding the deadlocks in case the
   fiemap buffer is memory mapped to the same file (useless in practice,
   but possible and exercised by fuzz testing and syzbot).

Fixes: b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 221 +++++++++++++++++++++++++++++++------------
 1 file changed, 160 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 65e4c8fc89b1..e7cfffc4e7b5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2451,12 +2451,65 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	return try_release_extent_state(tree, page, mask);
 }
 
+struct btrfs_fiemap_entry {
+	u64 offset;
+	u64 phys;
+	u64 len;
+	u32 flags;
+};
+
 /*
- * To cache previous fiemap extent
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
  *
- * Will be used for merging fiemap extent
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
  */
 struct fiemap_cache {
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
 	u64 offset;
 	u64 phys;
 	u64 len;
@@ -2464,6 +2517,28 @@ struct fiemap_cache {
 	bool cached;
 };
 
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
 /*
  * Helper to submit fiemap extent.
  *
@@ -2478,8 +2553,8 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 				struct fiemap_cache *cache,
 				u64 offset, u64 phys, u64 len, u32 flags)
 {
+	struct btrfs_fiemap_entry *entry;
 	u64 cache_end;
-	int ret = 0;
 
 	/* Set at the end of extent_fiemap(). */
 	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
@@ -2492,7 +2567,9 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	 * find an extent that starts at an offset behind the end offset of the
 	 * previous extent we processed. This happens if fiemap is called
 	 * without FIEMAP_FLAG_SYNC and there are ordered extents completing
-	 * while we call btrfs_next_leaf() (through fiemap_next_leaf_item()).
+	 * after we had to unlock the file range, release the search path, emit
+	 * the fiemap extents stored in the buffer (cache->entries array) and
+	 * the lock the remainder of the range and re-search the btree.
 	 *
 	 * For example we are in leaf X processing its last item, which is the
 	 * file extent item for file range [512K, 1M[, and after
@@ -2605,11 +2682,35 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 
 emit:
 	/* Not mergeable, need to submit cached one */
-	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
-				      cache->len, cache->flags);
-	cache->cached = false;
-	if (ret)
-		return ret;
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
 assign:
 	cache->cached = true;
 	cache->offset = offset;
@@ -2735,8 +2836,8 @@ static int fiemap_search_slot(struct btrfs_inode *inode, struct btrfs_path *path
 	 * neighbour leaf).
 	 * We also need the private clone because holding a read lock on an
 	 * extent buffer of the subvolume's b+tree will make lockdep unhappy
-	 * when we call fiemap_fill_next_extent(), because that may cause a page
-	 * fault when filling the user space buffer with fiemap data.
+	 * when we check if extents are shared, as backref walking may need to
+	 * lock the same leaf we are processing.
 	 */
 	clone = btrfs_clone_extent_buffer(path->nodes[0]);
 	if (!clone)
@@ -2776,34 +2877,16 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 	 * it beyond i_size.
 	 */
 	while (cur_offset < end && cur_offset < i_size) {
-		struct extent_state *cached_state = NULL;
 		u64 delalloc_start;
 		u64 delalloc_end;
 		u64 prealloc_start;
-		u64 lockstart;
-		u64 lockend;
 		u64 prealloc_len = 0;
 		bool delalloc;
 
-		lockstart = round_down(cur_offset, inode->root->fs_info->sectorsize);
-		lockend = round_up(end, inode->root->fs_info->sectorsize);
-
-		/*
-		 * We are only locking for the delalloc range because that's the
-		 * only thing that can change here.  With fiemap we have a lock
-		 * on the inode, so no buffered or direct writes can happen.
-		 *
-		 * However mmaps and normal page writeback will cause this to
-		 * change arbitrarily.  We have to lock the extent lock here to
-		 * make sure that nobody messes with the tree while we're doing
-		 * btrfs_find_delalloc_in_range.
-		 */
-		lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
 							delalloc_cached_state,
 							&delalloc_start,
 							&delalloc_end);
-		unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 		if (!delalloc)
 			break;
 
@@ -2971,6 +3054,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len)
 {
 	const u64 ino = btrfs_ino(inode);
+	struct extent_state *cached_state = NULL;
 	struct extent_state *delalloc_cached_state = NULL;
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
@@ -2983,26 +3067,33 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	bool stopped = false;
 	int ret;
 
+	cache.entries_size = PAGE_SIZE / sizeof(struct btrfs_fiemap_entry);
+	cache.entries = kmalloc_array(cache.entries_size,
+				      sizeof(struct btrfs_fiemap_entry),
+				      GFP_KERNEL);
 	backref_ctx = btrfs_alloc_backref_share_check_ctx();
 	path = btrfs_alloc_path();
-	if (!backref_ctx || !path) {
+	if (!cache.entries || !backref_ctx || !path) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+restart:
 	range_start = round_down(start, sectorsize);
 	range_end = round_up(start + len, sectorsize);
 	prev_extent_end = range_start;
 
+	lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 	btrfs_release_path(path);
 
 	path->reada = READA_FORWARD;
 	ret = fiemap_search_slot(inode, path, range_start);
 	if (ret < 0) {
-		goto out;
+		goto out_unlock;
 	} else if (ret > 0) {
 		/*
 		 * No file extent item found, but we may have delalloc between
@@ -3049,7 +3140,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  backref_ctx, 0, 0, 0,
 						  prev_extent_end, hole_end);
 			if (ret < 0) {
-				goto out;
+				goto out_unlock;
 			} else if (ret > 0) {
 				/* fiemap_fill_next_extent() told us to stop. */
 				stopped = true;
@@ -3105,7 +3196,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 								  extent_gen,
 								  backref_ctx);
 				if (ret < 0)
-					goto out;
+					goto out_unlock;
 				else if (ret > 0)
 					flags |= FIEMAP_EXTENT_SHARED;
 			}
@@ -3116,9 +3207,9 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (ret < 0) {
-			goto out;
+			goto out_unlock;
 		} else if (ret > 0) {
-			/* fiemap_fill_next_extent() told us to stop. */
+			/* emit_fiemap_extent() told us to stop. */
 			stopped = true;
 			break;
 		}
@@ -3127,12 +3218,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 next_item:
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
-			goto out;
+			goto out_unlock;
 		}
 
 		ret = fiemap_next_leaf_item(inode, path);
 		if (ret < 0) {
-			goto out;
+			goto out_unlock;
 		} else if (ret > 0) {
 			/* No more file extent items for this inode. */
 			break;
@@ -3141,22 +3232,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 check_eof_delalloc:
-	/*
-	 * Release (and free) the path before emitting any final entries to
-	 * fiemap_fill_next_extent() to keep lockdep happy. This is because
-	 * once we find no more file extent items exist, we may have a
-	 * non-cloned leaf, and fiemap_fill_next_extent() can trigger page
-	 * faults when copying data to the user space buffer.
-	 */
-	btrfs_free_path(path);
-	path = NULL;
-
 	if (!stopped && prev_extent_end < range_end) {
 		ret = fiemap_process_hole(inode, fieinfo, &cache,
 					  &delalloc_cached_state, backref_ctx,
 					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
-			goto out;
+			goto out_unlock;
 		prev_extent_end = range_end;
 	}
 
@@ -3164,28 +3245,16 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
-			struct extent_state *cached_state = NULL;
 			u64 delalloc_start;
 			u64 delalloc_end;
-			u64 lockstart;
-			u64 lockend;
 			bool delalloc;
 
-			lockstart = round_down(prev_extent_end, sectorsize);
-			lockend = round_up(i_size, sectorsize);
-
-			/*
-			 * See the comment in fiemap_process_hole as to why
-			 * we're doing the locking here.
-			 */
-			lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			delalloc = btrfs_find_delalloc_in_range(inode,
 								prev_extent_end,
 								i_size - 1,
 								&delalloc_cached_state,
 								&delalloc_start,
 								&delalloc_end);
-			unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 			if (!delalloc)
 				cache.flags |= FIEMAP_EXTENT_LAST;
 		} else {
@@ -3193,9 +3262,39 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 	}
 
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
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 out:
 	free_extent_state(delalloc_cached_state);
+	kfree(cache.entries);
 	btrfs_free_backref_share_ctx(backref_ctx);
 	btrfs_free_path(path);
 	return ret;
-- 
2.40.1


