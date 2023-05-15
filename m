Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E99703DA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbjEOTX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbjEOTXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:23:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B378BD2EE
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rUVHQaxtQHKTTg38c9BwT9DVkb0g571xhIzdRFcekUA=; b=ET8TKu2HSIFmCtQUyF+aTEf85W
        9QFtLRmYYQeiQNDKOhGxYWF+hvnyEmz4hH2fnoaO5N20Tg+5L9ZDbcTocSonAqOB0NxRN7EalqQwo
        yjWce82bzLmbrY1U29QQTULt8utoT3j0b/CqAi0PRY/mt6+aRVnMrctZRUVbSEcb8F1mQHvdrJtk5
        8TmvptLEryjC6whLHE6BSKBr4au2ilYcAnHEzM4VA6WBCqiB8gSVgD+BHgw4S5Q/cJ2wt+IL1PpGZ
        rgYRGEEV1hYK78iq6OQkr9kJKOFMLCPseC7afy0HCpiMHDc4DcHjhoKvt3lwhXAoWr5NZkx7TSX8x
        BVfxmU7g==;
Received: from [2001:4bb8:188:2249:ad42:acf3:6731:a041] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pydmr-003HFT-31;
        Mon, 15 May 2023 19:23:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: remove convert_extent_bit
Date:   Mon, 15 May 2023 21:22:52 +0200
Message-Id: <20230515192256.29006-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515192256.29006-1-hch@lst.de>
References: <20230515192256.29006-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The last user of this function just went away, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent-io-tree.c    | 212 -----------------------------------
 fs/btrfs/extent-io-tree.h    |   4 -
 include/trace/events/btrfs.h |  41 -------
 3 files changed, 257 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 29a225836e286e..bfda8e1debee1e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1194,218 +1194,6 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 				cached_state, NULL, mask);
 }
 
-/*
- * Convert all bits in a given range from one bit to another
- *
- * @tree:	the io tree to search
- * @start:	the start offset in bytes
- * @end:	the end offset in bytes (inclusive)
- * @bits:	the bits to set in this range
- * @clear_bits:	the bits to clear in this range
- * @cached_state:	state that we're going to cache
- *
- * This will go through and set bits for the given range.  If any states exist
- * already in this range they are set with the given bit and cleared of the
- * clear_bits.  This is only meant to be used by things that are mergeable, ie.
- * converting from say DELALLOC to DIRTY.  This is not meant to be used with
- * boundary bits like LOCK.
- *
- * All allocations are done with GFP_NOFS.
- */
-int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, u32 clear_bits,
-		       struct extent_state **cached_state)
-{
-	struct extent_state *state;
-	struct extent_state *prealloc = NULL;
-	struct rb_node **p = NULL;
-	struct rb_node *parent = NULL;
-	int err = 0;
-	u64 last_start;
-	u64 last_end;
-	bool first_iteration = true;
-
-	btrfs_debug_check_extent_io_range(tree, start, end);
-	trace_btrfs_convert_extent_bit(tree, start, end - start + 1, bits,
-				       clear_bits);
-
-again:
-	if (!prealloc) {
-		/*
-		 * Best effort, don't worry if extent state allocation fails
-		 * here for the first iteration. We might have a cached state
-		 * that matches exactly the target range, in which case no
-		 * extent state allocations are needed. We'll only know this
-		 * after locking the tree.
-		 */
-		prealloc = alloc_extent_state(GFP_NOFS);
-		if (!prealloc && !first_iteration)
-			return -ENOMEM;
-	}
-
-	spin_lock(&tree->lock);
-	if (cached_state && *cached_state) {
-		state = *cached_state;
-		if (state->start <= start && state->end > start &&
-		    extent_state_in_tree(state))
-			goto hit_next;
-	}
-
-	/*
-	 * This search will find all the extents that end after our range
-	 * starts.
-	 */
-	state = tree_search_for_insert(tree, start, &p, &parent);
-	if (!state) {
-		prealloc = alloc_extent_state_atomic(prealloc);
-		if (!prealloc) {
-			err = -ENOMEM;
-			goto out;
-		}
-		prealloc->start = start;
-		prealloc->end = end;
-		insert_state_fast(tree, prealloc, p, parent, bits, NULL);
-		cache_state(prealloc, cached_state);
-		prealloc = NULL;
-		goto out;
-	}
-hit_next:
-	last_start = state->start;
-	last_end = state->end;
-
-	/*
-	 * | ---- desired range ---- |
-	 * | state |
-	 *
-	 * Just lock what we found and keep going.
-	 */
-	if (state->start == start && state->end <= end) {
-		set_state_bits(tree, state, bits, NULL);
-		cache_state(state, cached_state);
-		state = clear_state_bit(tree, state, clear_bits, 0, NULL);
-		if (last_end == (u64)-1)
-			goto out;
-		start = last_end + 1;
-		if (start < end && state && state->start == start &&
-		    !need_resched())
-			goto hit_next;
-		goto search_again;
-	}
-
-	/*
-	 *     | ---- desired range ---- |
-	 * | state |
-	 *   or
-	 * | ------------- state -------------- |
-	 *
-	 * We need to split the extent we found, and may flip bits on second
-	 * half.
-	 *
-	 * If the extent we found extends past our range, we just split and
-	 * search again.  It'll get split again the next time though.
-	 *
-	 * If the extent we found is inside our range, we set the desired bit
-	 * on it.
-	 */
-	if (state->start < start) {
-		prealloc = alloc_extent_state_atomic(prealloc);
-		if (!prealloc) {
-			err = -ENOMEM;
-			goto out;
-		}
-		err = split_state(tree, state, prealloc, start);
-		if (err)
-			extent_io_tree_panic(tree, err);
-		prealloc = NULL;
-		if (err)
-			goto out;
-		if (state->end <= end) {
-			set_state_bits(tree, state, bits, NULL);
-			cache_state(state, cached_state);
-			state = clear_state_bit(tree, state, clear_bits, 0, NULL);
-			if (last_end == (u64)-1)
-				goto out;
-			start = last_end + 1;
-			if (start < end && state && state->start == start &&
-			    !need_resched())
-				goto hit_next;
-		}
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 *     | state | or               | state |
-	 *
-	 * There's a hole, we need to insert something in it and ignore the
-	 * extent we found.
-	 */
-	if (state->start > start) {
-		u64 this_end;
-		if (end < last_start)
-			this_end = end;
-		else
-			this_end = last_start - 1;
-
-		prealloc = alloc_extent_state_atomic(prealloc);
-		if (!prealloc) {
-			err = -ENOMEM;
-			goto out;
-		}
-
-		/*
-		 * Avoid to free 'prealloc' if it can be merged with the later
-		 * extent.
-		 */
-		prealloc->start = start;
-		prealloc->end = this_end;
-		err = insert_state(tree, prealloc, bits, NULL);
-		if (err)
-			extent_io_tree_panic(tree, err);
-		cache_state(prealloc, cached_state);
-		prealloc = NULL;
-		start = this_end + 1;
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 *                        | state |
-	 *
-	 * We need to split the extent, and set the bit on the first half.
-	 */
-	if (state->start <= end && state->end > end) {
-		prealloc = alloc_extent_state_atomic(prealloc);
-		if (!prealloc) {
-			err = -ENOMEM;
-			goto out;
-		}
-
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
-		set_state_bits(tree, prealloc, bits, NULL);
-		cache_state(prealloc, cached_state);
-		clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
-		prealloc = NULL;
-		goto out;
-	}
-
-search_again:
-	if (start > end)
-		goto out;
-	spin_unlock(&tree->lock);
-	cond_resched();
-	first_iteration = false;
-	goto again;
-
-out:
-	spin_unlock(&tree->lock);
-	if (prealloc)
-		free_extent_state(prealloc);
-
-	return err;
-}
-
 /*
  * Find the first range that has @bits not set. This range could start before
  * @start.
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 0dae0a16a87cb7..1567ce11c10c9a 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -185,10 +185,6 @@ static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
 				EXTENT_DO_ACCOUNTING, cached);
 }
 
-int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, u32 clear_bits,
-		       struct extent_state **cached_state);
-
 static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
 				      u64 end, u32 extra_bits,
 				      struct extent_state **cached_state)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index aae33b9067b918..4f4a2006b4d5e3 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2129,47 +2129,6 @@ TRACE_EVENT(btrfs_clear_extent_bit,
 		__print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
 
-TRACE_EVENT(btrfs_convert_extent_bit,
-	TP_PROTO(const struct extent_io_tree *tree,
-		 u64 start, u64 len, unsigned set_bits, unsigned clear_bits),
-
-	TP_ARGS(tree, start, len, set_bits, clear_bits),
-
-	TP_STRUCT__entry_btrfs(
-		__field(	unsigned,	owner	)
-		__field(	u64,		ino	)
-		__field(	u64,		rootid	)
-		__field(	u64,		start	)
-		__field(	u64,		len	)
-		__field(	unsigned,	set_bits)
-		__field(	unsigned,	clear_bits)
-	),
-
-	TP_fast_assign_btrfs(tree->fs_info,
-		__entry->owner = tree->owner;
-		if (tree->inode) {
-			const struct btrfs_inode *inode = tree->inode;
-
-			__entry->ino	= btrfs_ino(inode);
-			__entry->rootid	= inode->root->root_key.objectid;
-		} else {
-			__entry->ino	= 0;
-			__entry->rootid	= 0;
-		}
-		__entry->start		= start;
-		__entry->len		= len;
-		__entry->set_bits	= set_bits;
-		__entry->clear_bits	= clear_bits;
-	),
-
-	TP_printk_btrfs(
-"io_tree=%s ino=%llu root=%llu start=%llu len=%llu set_bits=%s clear_bits=%s",
-		  __print_symbolic(__entry->owner, IO_TREE_OWNER), __entry->ino,
-		  __entry->rootid, __entry->start, __entry->len,
-		  __print_flags(__entry->set_bits , "|", EXTENT_FLAGS),
-		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
-);
-
 DECLARE_EVENT_CLASS(btrfs_dump_space_info,
 	TP_PROTO(struct btrfs_fs_info *fs_info,
 		 const struct btrfs_space_info *sinfo),
-- 
2.39.2

