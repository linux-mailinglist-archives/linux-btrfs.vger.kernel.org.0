Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636E5BCE0E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiISOGv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiISOGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA731DEE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9B6B81B6A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C5FC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596405;
        bh=NRHCCiEzG0URpGaDiIqTqjhwo6wRmZNstzCaMaoY/fg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TljWU7GlSqBnVNsaDS/go2seUqQP7Ra1JJgICuQFnGsZlHOYTTLasVGK+HI3PGgd1
         IUY3hssF/UnNXskFCz7VlH6+0s7kWdnUMzRn69sFYSjiAA/JLQWLsy/V6vdaG0eMlv
         xueIfPRCBHKEsMjTWnb46RI/bx4pT4gUo5SS77rmQCX8QRiQhs+GH2cAoFR+iUjTuq
         ZEikplN4JfBonfkdlupTmbcKMMr8K0EUeiUMjy5SwWj/5sM/ncOEi/ZSJchiPsdb3m
         tLT1WksKLzBK1o7BFULQFUsfRVWM9SB7NmPh7C1Eya6BcRJ/MBCaFzg5hrIfeUQZT0
         VQ0cxzfK2d+bQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/13] btrfs: move btrfs_drop_extent_cache() to extent_map.c
Date:   Mon, 19 Sep 2022 15:06:29 +0100
Message-Id: <a22aca81113a1d986882f093ad6e9912d1c558e5.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_drop_extent_cache() doesn't really belong at file.c
because what it does is drop a range of extent maps for a file range.
It directly allocates and manipulates extent maps, by dropping, spliting
and replacing them in an extent map tree, so it should be located at
extent_map.c, where all manipulations of an extent map tree and its extent
maps are supposed to be done.

So move it out of file.c and into extent_map.c. Additionally do the
following changes:

1) Rename it into btrfs_drop_extent_map_range(), as this makes it more
   clear about what it does. The term "cache" is a bit confusing as it's
   not widely used, "extent maps" or "extent mapping" is much more common;

2) Change its 'skip_pinned' argument from int to bool;

3) Turn several of its local variables from int to bool, since they are
   used as booleans;

4) Move the declaration of some variables out of the function's main
   scope and into the scopes where they are used;

5) Remove pointless assignment of false to 'modified' early in the while
   loop, as later that variable is set and it's not used before that
   second assignment;

6) Remove checks for NULL before calling free_extent_map().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h             |   2 -
 fs/btrfs/extent_map.c        | 192 +++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_map.h        |   5 +
 fs/btrfs/file.c              | 190 +---------------------------------
 fs/btrfs/free-space-cache.c  |   2 +-
 fs/btrfs/inode.c             |  59 ++++++-----
 fs/btrfs/relocation.c        |   8 +-
 fs/btrfs/tests/inode-tests.c |   2 +-
 8 files changed, 237 insertions(+), 223 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8b7b7a212da0..691a14fd3335 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3534,8 +3534,6 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
-void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
-			     int skip_pinned);
 extern const struct file_operations btrfs_file_operations;
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d5640e695e6b..587e0298bfab 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -7,6 +7,7 @@
 #include "volumes.h"
 #include "extent_map.h"
 #include "compression.h"
+#include "btrfs_inode.h"
 
 
 static struct kmem_cache *extent_map_cache;
@@ -658,3 +659,194 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 	ASSERT(ret == 0 || ret == -EEXIST);
 	return ret;
 }
+
+/*
+ * Drop all extent maps in a given range.
+ *
+ * @inode:       The target inode.
+ * @start:       Start offset of the range.
+ * @end:         End offset of the range (inclusive value).
+ * @skip_pinned: Indicate if pinned extent maps should be ignored or not.
+ *
+ * This drops all the extent maps that intersect the given range [@start, @end].
+ * Extent maps that partially overlap the range and extend behind or beyond it,
+ * are split.
+ * The caller should have locked an appropriate file range in the inode's io
+ * tree before calling this function.
+ */
+void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
+				 bool skip_pinned)
+{
+	struct extent_map *split = NULL;
+	struct extent_map *split2 = NULL;
+	struct extent_map_tree *em_tree = &inode->extent_tree;
+	u64 len = end - start + 1;
+	bool testend = true;
+
+	WARN_ON(end < start);
+	if (end == (u64)-1) {
+		len = (u64)-1;
+		testend = false;
+	}
+	while (1) {
+		struct extent_map *em;
+		u64 gen;
+		unsigned long flags;
+		bool ends_after_range = false;
+		bool no_splits = false;
+		bool modified;
+		bool compressed;
+
+		if (!split)
+			split = alloc_extent_map();
+		if (!split2)
+			split2 = alloc_extent_map();
+		if (!split || !split2)
+			no_splits = true;
+
+		write_lock(&em_tree->lock);
+		em = lookup_extent_mapping(em_tree, start, len);
+		if (!em) {
+			write_unlock(&em_tree->lock);
+			break;
+		}
+		if (testend && em->start + em->len > start + len)
+			ends_after_range = true;
+		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
+			if (ends_after_range) {
+				free_extent_map(em);
+				write_unlock(&em_tree->lock);
+				break;
+			}
+			start = em->start + em->len;
+			if (testend)
+				len = start + len - (em->start + em->len);
+			free_extent_map(em);
+			write_unlock(&em_tree->lock);
+			continue;
+		}
+		flags = em->flags;
+		gen = em->generation;
+		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
+		clear_bit(EXTENT_FLAG_LOGGING, &flags);
+		modified = !list_empty(&em->list);
+		if (no_splits)
+			goto next;
+
+		if (em->start < start) {
+			split->start = em->start;
+			split->len = start - em->start;
+
+			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
+				split->orig_start = em->orig_start;
+				split->block_start = em->block_start;
+
+				if (compressed)
+					split->block_len = em->block_len;
+				else
+					split->block_len = split->len;
+				split->orig_block_len = max(split->block_len,
+						em->orig_block_len);
+				split->ram_bytes = em->ram_bytes;
+			} else {
+				split->orig_start = split->start;
+				split->block_len = 0;
+				split->block_start = em->block_start;
+				split->orig_block_len = 0;
+				split->ram_bytes = split->len;
+			}
+
+			split->generation = gen;
+			split->flags = flags;
+			split->compress_type = em->compress_type;
+			replace_extent_mapping(em_tree, em, split, modified);
+			free_extent_map(split);
+			split = split2;
+			split2 = NULL;
+		}
+		if (ends_after_range) {
+			split->start = start + len;
+			split->len = em->start + em->len - (start + len);
+			split->block_start = em->block_start;
+			split->flags = flags;
+			split->compress_type = em->compress_type;
+			split->generation = gen;
+
+			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
+				split->orig_block_len = max(em->block_len,
+						    em->orig_block_len);
+
+				split->ram_bytes = em->ram_bytes;
+				if (compressed) {
+					split->block_len = em->block_len;
+					split->orig_start = em->orig_start;
+				} else {
+					const u64 diff = start + len - em->start;
+
+					split->block_len = split->len;
+					split->block_start += diff;
+					split->orig_start = em->orig_start;
+				}
+			} else {
+				split->ram_bytes = split->len;
+				split->orig_start = split->start;
+				split->block_len = 0;
+				split->orig_block_len = 0;
+			}
+
+			if (extent_map_in_tree(em)) {
+				replace_extent_mapping(em_tree, em, split,
+						       modified);
+			} else {
+				int ret;
+
+				ret = add_extent_mapping(em_tree, split,
+							 modified);
+				/* Logic error, shouldn't happen. */
+				ASSERT(ret == 0);
+				if (WARN_ON(ret != 0) && modified)
+					btrfs_set_inode_full_sync(inode);
+			}
+			free_extent_map(split);
+			split = NULL;
+		}
+next:
+		if (extent_map_in_tree(em)) {
+			/*
+			 * If the extent map is still in the tree it means that
+			 * either of the following is true:
+			 *
+			 * 1) It fits entirely in our range (doesn't end beyond
+			 *    it or starts before it);
+			 *
+			 * 2) It starts before our range and/or ends after our
+			 *    range, and we were not able to allocate the extent
+			 *    maps for split operations, @split and @split2.
+			 *
+			 * If we are at case 2) then we just remove the entire
+			 * extent map - this is fine since if anyone needs it to
+			 * access the subranges outside our range, will just
+			 * load it again from the subvolume tree's file extent
+			 * item. However if the extent map was in the list of
+			 * modified extents, then we must mark the inode for a
+			 * full fsync, otherwise a fast fsync will miss this
+			 * extent if it's new and needs to be logged.
+			 */
+			if ((em->start < start || ends_after_range) && modified) {
+				ASSERT(no_splits);
+				btrfs_set_inode_full_sync(inode);
+			}
+			remove_extent_mapping(em_tree, em);
+		}
+		write_unlock(&em_tree->lock);
+
+		/* Once for us. */
+		free_extent_map(em);
+		/* And once for the tree. */
+		free_extent_map(em);
+	}
+
+	free_extent_map(split);
+	free_extent_map(split2);
+}
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index d2fa32ffe304..17f4a9bbee7f 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -63,6 +63,8 @@ struct extent_map_tree {
 	rwlock_t lock;
 };
 
+struct btrfs_inode;
+
 static inline int extent_map_in_tree(const struct extent_map *em)
 {
 	return !RB_EMPTY_NODE(&em->rb_node);
@@ -104,5 +106,8 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 			     struct extent_map_tree *em_tree,
 			     struct extent_map **em_in, u64 start, u64 len);
+void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
+				 u64 start, u64 end,
+				 bool skip_pinned);
 
 #endif
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e52292cf8bc..793c95dc8df5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -498,190 +498,6 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	return 0;
 }
 
-/*
- * this drops all the extents in the cache that intersect the range
- * [start, end].  Existing extents are split as required.
- */
-void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
-			     int skip_pinned)
-{
-	struct extent_map *em;
-	struct extent_map *split = NULL;
-	struct extent_map *split2 = NULL;
-	struct extent_map_tree *em_tree = &inode->extent_tree;
-	u64 len = end - start + 1;
-	u64 gen;
-	int ret;
-	int testend = 1;
-	unsigned long flags;
-	int compressed = 0;
-	bool modified;
-
-	WARN_ON(end < start);
-	if (end == (u64)-1) {
-		len = (u64)-1;
-		testend = 0;
-	}
-	while (1) {
-		bool ends_after_range = false;
-		int no_splits = 0;
-
-		modified = false;
-		if (!split)
-			split = alloc_extent_map();
-		if (!split2)
-			split2 = alloc_extent_map();
-		if (!split || !split2)
-			no_splits = 1;
-
-		write_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, start, len);
-		if (!em) {
-			write_unlock(&em_tree->lock);
-			break;
-		}
-		if (testend && em->start + em->len > start + len)
-			ends_after_range = true;
-		flags = em->flags;
-		gen = em->generation;
-		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
-			if (ends_after_range) {
-				free_extent_map(em);
-				write_unlock(&em_tree->lock);
-				break;
-			}
-			start = em->start + em->len;
-			if (testend)
-				len = start + len - (em->start + em->len);
-			free_extent_map(em);
-			write_unlock(&em_tree->lock);
-			continue;
-		}
-		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
-		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
-		clear_bit(EXTENT_FLAG_LOGGING, &flags);
-		modified = !list_empty(&em->list);
-		if (no_splits)
-			goto next;
-
-		if (em->start < start) {
-			split->start = em->start;
-			split->len = start - em->start;
-
-			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_start = em->orig_start;
-				split->block_start = em->block_start;
-
-				if (compressed)
-					split->block_len = em->block_len;
-				else
-					split->block_len = split->len;
-				split->orig_block_len = max(split->block_len,
-						em->orig_block_len);
-				split->ram_bytes = em->ram_bytes;
-			} else {
-				split->orig_start = split->start;
-				split->block_len = 0;
-				split->block_start = em->block_start;
-				split->orig_block_len = 0;
-				split->ram_bytes = split->len;
-			}
-
-			split->generation = gen;
-			split->flags = flags;
-			split->compress_type = em->compress_type;
-			replace_extent_mapping(em_tree, em, split, modified);
-			free_extent_map(split);
-			split = split2;
-			split2 = NULL;
-		}
-		if (ends_after_range) {
-			u64 diff = start + len - em->start;
-
-			split->start = start + len;
-			split->len = em->start + em->len - (start + len);
-			split->flags = flags;
-			split->compress_type = em->compress_type;
-			split->generation = gen;
-
-			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_block_len = max(em->block_len,
-						    em->orig_block_len);
-
-				split->ram_bytes = em->ram_bytes;
-				if (compressed) {
-					split->block_len = em->block_len;
-					split->block_start = em->block_start;
-					split->orig_start = em->orig_start;
-				} else {
-					split->block_len = split->len;
-					split->block_start = em->block_start
-						+ diff;
-					split->orig_start = em->orig_start;
-				}
-			} else {
-				split->ram_bytes = split->len;
-				split->orig_start = split->start;
-				split->block_len = 0;
-				split->block_start = em->block_start;
-				split->orig_block_len = 0;
-			}
-
-			if (extent_map_in_tree(em)) {
-				replace_extent_mapping(em_tree, em, split,
-						       modified);
-			} else {
-				ret = add_extent_mapping(em_tree, split,
-							 modified);
-				/* Logic error, shouldn't happen. */
-				ASSERT(ret == 0);
-				if (WARN_ON(ret != 0) && modified)
-					btrfs_set_inode_full_sync(inode);
-			}
-			free_extent_map(split);
-			split = NULL;
-		}
-next:
-		if (extent_map_in_tree(em)) {
-			/*
-			 * If the extent map is still in the tree it means that
-			 * either of the following is true:
-			 *
-			 * 1) It fits entirely in our range (doesn't end beyond
-			 *    it or starts before it);
-			 *
-			 * 2) It starts before our range and/or ends after our
-			 *    range, and we were not able to allocate the extent
-			 *    maps for split operations, @split and @split2.
-			 *
-			 * If we are at case 2) then we just remove the entire
-			 * extent map - this is fine since if anyone needs it to
-			 * access the subranges outside our range, will just
-			 * load it again from the subvolume tree's file extent
-			 * item. However if the extent map was in the list of
-			 * modified extents, then we must mark the inode for a
-			 * full fsync, otherwise a fast fsync will miss this
-			 * extent if it's new and needs to be logged.
-			 */
-			if ((em->start < start || ends_after_range) && modified) {
-				ASSERT(no_splits);
-				btrfs_set_inode_full_sync(inode);
-			}
-			remove_extent_mapping(em_tree, em);
-		}
-		write_unlock(&em_tree->lock);
-
-		/* once for us */
-		free_extent_map(em);
-		/* once for the tree*/
-		free_extent_map(em);
-	}
-	if (split)
-		free_extent_map(split);
-	if (split2)
-		free_extent_map(split2);
-}
-
 /*
  * this is very complex, but the basic idea is to drop all extents
  * in the range start - end.  hint_block is filled in with a block number
@@ -739,7 +555,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	}
 
 	if (args->drop_cache)
-		btrfs_drop_extent_cache(inode, args->start, args->end - 1, 0);
+		btrfs_drop_extent_map_range(inode, args->start, args->end - 1, false);
 
 	if (args->start >= inode->disk_i_size && !args->replace_extent)
 		modify_tree = 0;
@@ -2549,7 +2365,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 	hole_em = alloc_extent_map();
 	if (!hole_em) {
-		btrfs_drop_extent_cache(inode, offset, end - 1, 0);
+		btrfs_drop_extent_map_range(inode, offset, end - 1, false);
 		btrfs_set_inode_full_sync(inode);
 	} else {
 		hole_em->start = offset;
@@ -2564,7 +2380,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->generation = trans->transid;
 
 		do {
-			btrfs_drop_extent_cache(inode, offset, end - 1, 0);
+			btrfs_drop_extent_map_range(inode, offset, end - 1, false);
 			write_lock(&em_tree->lock);
 			ret = add_extent_mapping(em_tree, hole_em, 1);
 			write_unlock(&em_tree->lock);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7859eeca484c..f4023651dd68 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -349,7 +349,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	truncate_pagecache(vfs_inode, 0);
 
 	lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
-	btrfs_drop_extent_cache(inode, 0, (u64)-1, 0);
+	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
 
 	/*
 	 * We skip the throttling logic for free space cache inodes, so we don't
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6fde13f62c1d..4cb5a00c7533 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1024,7 +1024,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				       1 << BTRFS_ORDERED_COMPRESSED,
 				       async_extent->compress_type);
 	if (ret) {
-		btrfs_drop_extent_cache(inode, start, end, 0);
+		btrfs_drop_extent_map_range(inode, start, end, false);
 		goto out_free_reserve;
 	}
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -1254,7 +1254,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	}
 
 	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
-	btrfs_drop_extent_cache(inode, start, start + num_bytes - 1, 0);
+	btrfs_drop_extent_map_range(inode, start, start + num_bytes - 1, false);
 
 	/*
 	 * Relocation relies on the relocated extents to have exactly the same
@@ -1319,8 +1319,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * skip current ordered extent.
 			 */
 			if (ret)
-				btrfs_drop_extent_cache(inode, start,
-						start + ram_size - 1, 0);
+				btrfs_drop_extent_map_range(inode, start,
+							    start + ram_size - 1,
+							    false);
 		}
 
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -1360,7 +1361,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	return ret;
 
 out_drop_extent_cache:
-	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
+	btrfs_drop_extent_map_range(inode, start, start + ram_size - 1, false);
 out_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
@@ -2099,8 +2100,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					1 << BTRFS_ORDERED_PREALLOC,
 					BTRFS_COMPRESS_NONE);
 			if (ret) {
-				btrfs_drop_extent_cache(inode, cur_offset,
-							nocow_end, 0);
+				btrfs_drop_extent_map_range(inode, cur_offset,
+							    nocow_end, false);
 				goto error;
 			}
 		} else {
@@ -3358,8 +3359,8 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			unwritten_start += logical_len;
 		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
 
-		/* Drop the cache for the part of the extent we didn't write. */
-		btrfs_drop_extent_cache(inode, unwritten_start, end, 0);
+		/* Drop extent maps for the part of the extent we didn't write. */
+		btrfs_drop_extent_map_range(inode, unwritten_start, end, false);
 
 		/*
 		 * If the ordered extent had an IOERR or something else went
@@ -5088,8 +5089,9 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			if (err)
 				break;
 
-			btrfs_drop_extent_cache(inode, cur_offset,
-						cur_offset + hole_size - 1, 0);
+			btrfs_drop_extent_map_range(inode, cur_offset,
+						    cur_offset + hole_size - 1,
+						    false);
 			hole_em = alloc_extent_map();
 			if (!hole_em) {
 				btrfs_set_inode_full_sync(inode);
@@ -5112,9 +5114,9 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 				write_unlock(&em_tree->lock);
 				if (err != -EEXIST)
 					break;
-				btrfs_drop_extent_cache(inode, cur_offset,
-							cur_offset +
-							hole_size - 1, 0);
+				btrfs_drop_extent_map_range(inode, cur_offset,
+						    cur_offset + hole_size - 1,
+						    false);
 			}
 			free_extent_map(hole_em);
 		} else {
@@ -7084,7 +7086,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	if (ret) {
 		if (em) {
 			free_extent_map(em);
-			btrfs_drop_extent_cache(inode, start, start + len - 1, 0);
+			btrfs_drop_extent_map_range(inode, start,
+						    start + len - 1, false);
 		}
 		em = ERR_PTR(ret);
 	}
@@ -7382,8 +7385,8 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	}
 
 	do {
-		btrfs_drop_extent_cache(inode, em->start,
-					em->start + em->len - 1, 0);
+		btrfs_drop_extent_map_range(inode, em->start,
+					    em->start + em->len - 1, false);
 		write_lock(&em_tree->lock);
 		ret = add_extent_mapping(em_tree, em, 1);
 		write_unlock(&em_tree->lock);
@@ -8641,9 +8644,9 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		 * size is not block aligned since we will be keeping the last
 		 * block of the extent just the way it is.
 		 */
-		btrfs_drop_extent_cache(BTRFS_I(inode),
-					ALIGN(new_size, fs_info->sectorsize),
-					(u64)-1, 0);
+		btrfs_drop_extent_map_range(BTRFS_I(inode),
+					    ALIGN(new_size, fs_info->sectorsize),
+					    (u64)-1, false);
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
 
@@ -8816,7 +8819,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 void btrfs_test_destroy_inode(struct inode *inode)
 {
-	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
+	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 #endif
@@ -8878,7 +8881,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	}
 	btrfs_qgroup_check_reserved_leak(inode);
 	inode_tree_del(inode);
-	btrfs_drop_extent_cache(inode, 0, (u64)-1, 0);
+	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
 	btrfs_inode_clear_file_extent_range(inode, 0, (u64)-1);
 	btrfs_put_root(inode->root);
 }
@@ -9947,8 +9950,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			break;
 		}
 
-		btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
-					cur_offset + ins.offset -1, 0);
+		btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
+					    cur_offset + ins.offset - 1, false);
 
 		em = alloc_extent_map();
 		if (!em) {
@@ -9972,9 +9975,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			write_unlock(&em_tree->lock);
 			if (ret != -EEXIST)
 				break;
-			btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
-						cur_offset + ins.offset - 1,
-						0);
+			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
+						    cur_offset + ins.offset - 1,
+						    false);
 		}
 		free_extent_map(em);
 next:
@@ -10802,7 +10805,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
 	if (ret) {
-		btrfs_drop_extent_cache(inode, start, end, 0);
+		btrfs_drop_extent_map_range(inode, start, end, false);
 		goto out_free_reserved;
 	}
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d87020ae5810..1b4a61df5b7c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1124,8 +1124,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				if (!ret)
 					continue;
 
-				btrfs_drop_extent_cache(BTRFS_I(inode),
-						key.offset,	end, 1);
+				btrfs_drop_extent_map_range(BTRFS_I(inode),
+							    key.offset, end, true);
 				unlock_extent(&BTRFS_I(inode)->io_tree,
 					      key.offset, end, NULL);
 			}
@@ -1567,7 +1567,7 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 
 		/* the lock_extent waits for read_folio to complete */
 		lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
-		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 1);
+		btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, true);
 		unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 	}
 	return 0;
@@ -2913,7 +2913,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 			free_extent_map(em);
 			break;
 		}
-		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
+		btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
 	}
 	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 	return ret;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index b1c88dd187cb..625f7d398368 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -267,7 +267,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	free_extent_map(em);
-	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
+	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 
 	/*
 	 * All of the magic numbers are based on the mapping setup in
-- 
2.35.1

