Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6B5B41E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIIVyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiIIVyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:20 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9F1079C8
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:15 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g16so2200864qkl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=FSrH+5w2vszyBc1JEauTslffrT2IF61FPhSKZKyeJFo=;
        b=aj3whDJ5AFt2Djaqv0pjXBdnEE5KWDsFu7uUMOnMmVwd7jjq0y7fYhErG3iUmzUSNy
         87ZW5ZR8TgJNdEbsPemEt2/8uXv1kSmoul3Bmaf2eYFdhWFp3gp11NjtrfEPjtjiYto5
         xQ8OLOWbtShbO9Q+7rCdcpV+qsdNlq3V1G/7/oHSD77Px4MZF61tw0VsHnPwtrqbCNZD
         h4y66gII9elxW4JtdHLVl36pB6UnAKcJ+ewMOVWOSdHHL4BK2gjgZh/WMuy8w+VzHqGA
         cevTbSfUEEM484ZKd0+qe9m/DnAVVpZd4H9ajZKYOoTlb/wgxe1C+kc/yv8WLEgvShp3
         S93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FSrH+5w2vszyBc1JEauTslffrT2IF61FPhSKZKyeJFo=;
        b=hj02mw8QvwhNdnpROAZf5iED0EAGFEi6sSkUZ73GRgxZE7XakVPPZNFRjykW3ByGAO
         z2qvl4hNe6XlGF0sKM97kzrK+OYNhFLJsA/zBQnzqd3WzbsdcV0SXZQiEuQ1wkUD8MwN
         B6LU18JWDbYa1z2KTGlNV74MqviQi3nuNjmUymQnX+GNWGlMOfw44pllziwMT5VpMll4
         TCUV/GIy5TgQga+EmdDVLJoVTknOqZmDTckwygEs+YALw9WI+gRVQjAurISEPXzciSnm
         If++TFoICITDvo9xjMSju4JkcmgsDXx4eCFpeLxZc294uvfQ32TfH/rTlz5F3j54Exjt
         FupA==
X-Gm-Message-State: ACgBeo1ThW/kVXQXr8GNVPaEvbVandM16CUw/MCXFnbEQOqsFmEjGFHi
        rqRlLZ7MNYxcUliAAkSnD4XYQr42siC5Qw==
X-Google-Smtp-Source: AA6agR4ZKg1X0q0OBa4c18C6mD23sRv3U5WxFw+WmEeWsyBgjcdEtX3HdPWMu2bJ+G7/fwW7TaCUOA==
X-Received: by 2002:a05:620a:919:b0:6bc:6a30:2e22 with SMTP id v25-20020a05620a091900b006bc6a302e22mr12071554qkv.702.1662760454034;
        Fri, 09 Sep 2022 14:54:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b006bbda80595asm1547473qkp.5.2022.09.09.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/36] btrfs: move core extent_io_tree functions to extent-io-tree.c
Date:   Fri,  9 Sep 2022 17:53:29 -0400
Message-Id: <3efcedc29cb34257fecff32bd1bce297a6c02358.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is still huge, but unfortunately I cannot make it smaller without
renaming tree_search() and changing all the callers to use the new name,
then moving those chunks and then changing the name back.  This feels
like too much churn for code movement, so I've limited this to only
things that called tree_search().  With this patch all of the
extent_io_tree code is now in extent-io-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 996 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c      | 996 --------------------------------------
 2 files changed, 996 insertions(+), 996 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 468b373c4359..322909cf3040 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -287,6 +287,20 @@ struct rb_node *tree_search_prev_next(struct extent_io_tree *tree, u64 offset,
 	return NULL;
 }
 
+/*
+ * Inexact rb-tree search, return the next entry if @offset is not found
+ */
+static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
+{
+	return tree_search_for_insert(tree, offset, NULL, NULL);
+}
+
+static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
+{
+	btrfs_panic(tree->fs_info, err,
+	"locking error: extent tree was modified by another thread while locked");
+}
+
 /*
  * utility function to look for merge candidates inside a given range.
  * Any extents with matching state are merged together into a single
@@ -511,6 +525,872 @@ struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	return next;
 }
 
+/*
+ * clear some bits on a range in the tree.  This may require splitting
+ * or inserting elements in the tree, so the gfp mask is used to
+ * indicate which allocations or sleeping are allowed.
+ *
+ * pass 'wake' == 1 to kick any sleepers, and 'delete' == 1 to remove
+ * the given range from the tree regardless of state (ie for truncate).
+ *
+ * the range [start, end] is inclusive.
+ *
+ * This takes the tree lock, and returns 0 on success and < 0 on error.
+ */
+int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, int wake, int delete,
+		       struct extent_state **cached_state,
+		       gfp_t mask, struct extent_changeset *changeset)
+{
+	struct extent_state *state;
+	struct extent_state *cached;
+	struct extent_state *prealloc = NULL;
+	struct rb_node *node;
+	u64 last_end;
+	int err;
+	int clear = 0;
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
+
+	if (bits & EXTENT_DELALLOC)
+		bits |= EXTENT_NORESERVE;
+
+	if (delete)
+		bits |= ~EXTENT_CTLBITS;
+
+	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+		clear = 1;
+again:
+	if (!prealloc && gfpflags_allow_blocking(mask)) {
+		/*
+		 * Don't care for allocation failure here because we might end
+		 * up not needing the pre-allocated extent state at all, which
+		 * is the case if we only have in the tree extent states that
+		 * cover our input range and don't cover too any other range.
+		 * If we end up needing a new extent state we allocate it later.
+		 */
+		prealloc = alloc_extent_state(mask);
+	}
+
+	spin_lock(&tree->lock);
+	if (cached_state) {
+		cached = *cached_state;
+
+		if (clear) {
+			*cached_state = NULL;
+			cached_state = NULL;
+		}
+
+		if (cached && extent_state_in_tree(cached) &&
+		    cached->start <= start && cached->end > start) {
+			if (clear)
+				refcount_dec(&cached->refs);
+			state = cached;
+			goto hit_next;
+		}
+		if (clear)
+			free_extent_state(cached);
+	}
+	/*
+	 * this search will find the extents that end after
+	 * our range starts
+	 */
+	node = tree_search(tree, start);
+	if (!node)
+		goto out;
+	state = rb_entry(node, struct extent_state, rb_node);
+hit_next:
+	if (state->start > end)
+		goto out;
+	WARN_ON(state->end < start);
+	last_end = state->end;
+
+	/* the state doesn't have the wanted bits, go ahead */
+	if (!(state->state & bits)) {
+		state = next_state(state);
+		goto next;
+	}
+
+	/*
+	 *     | ---- desired range ---- |
+	 *  | state | or
+	 *  | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip
+	 * bits on second half.
+	 *
+	 * If the extent we found extends past our range, we
+	 * just split and search again.  It'll get split again
+	 * the next time though.
+	 *
+	 * If the extent we found is inside our range, we clear
+	 * the desired bit on it.
+	 */
+
+	if (state->start < start) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		BUG_ON(!prealloc);
+		err = split_state(tree, state, prealloc, start);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			state = clear_state_bit(tree, state, bits, wake, changeset);
+			goto next;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 * We need to split the extent, and clear the bit
+	 * on the first half
+	 */
+	if (state->start <= end && state->end > end) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		BUG_ON(!prealloc);
+		err = split_state(tree, state, prealloc, end + 1);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		if (wake)
+			wake_up(&state->wq);
+
+		clear_state_bit(tree, prealloc, bits, wake, changeset);
+
+		prealloc = NULL;
+		goto out;
+	}
+
+	state = clear_state_bit(tree, state, bits, wake, changeset);
+next:
+	if (last_end == (u64)-1)
+		goto out;
+	start = last_end + 1;
+	if (start <= end && state && !need_resched())
+		goto hit_next;
+
+search_again:
+	if (start > end)
+		goto out;
+	spin_unlock(&tree->lock);
+	if (gfpflags_allow_blocking(mask))
+		cond_resched();
+	goto again;
+
+out:
+	spin_unlock(&tree->lock);
+	if (prealloc)
+		free_extent_state(prealloc);
+
+	return 0;
+
+}
+
+static void wait_on_state(struct extent_io_tree *tree,
+			  struct extent_state *state)
+		__releases(tree->lock)
+		__acquires(tree->lock)
+{
+	DEFINE_WAIT(wait);
+	prepare_to_wait(&state->wq, &wait, TASK_UNINTERRUPTIBLE);
+	spin_unlock(&tree->lock);
+	schedule();
+	spin_lock(&tree->lock);
+	finish_wait(&state->wq, &wait);
+}
+
+/*
+ * waits for one or more bits to clear on a range in the state tree.
+ * The range [start, end] is inclusive.
+ * The tree lock is taken by this function
+ */
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
+{
+	struct extent_state *state;
+	struct rb_node *node;
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+
+	spin_lock(&tree->lock);
+again:
+	while (1) {
+		/*
+		 * this search will find all the extents that end after
+		 * our range starts
+		 */
+		node = tree_search(tree, start);
+process_node:
+		if (!node)
+			break;
+
+		state = rb_entry(node, struct extent_state, rb_node);
+
+		if (state->start > end)
+			goto out;
+
+		if (state->state & bits) {
+			start = state->start;
+			refcount_inc(&state->refs);
+			wait_on_state(tree, state);
+			free_extent_state(state);
+			goto again;
+		}
+		start = state->end + 1;
+
+		if (start > end)
+			break;
+
+		if (!cond_resched_lock(&tree->lock)) {
+			node = rb_next(node);
+			goto process_node;
+		}
+	}
+out:
+	spin_unlock(&tree->lock);
+}
+
+static void cache_state_if_flags(struct extent_state *state,
+				 struct extent_state **cached_ptr,
+				 unsigned flags)
+{
+	if (cached_ptr && !(*cached_ptr)) {
+		if (!flags || (state->state & flags)) {
+			*cached_ptr = state;
+			refcount_inc(&state->refs);
+		}
+	}
+}
+
+static void cache_state(struct extent_state *state,
+			struct extent_state **cached_ptr)
+{
+	return cache_state_if_flags(state, cached_ptr,
+				    EXTENT_LOCKED | EXTENT_BOUNDARY);
+}
+
+/* find the first state struct with 'bits' set after 'start', and
+ * return it.  tree->lock must be held.  NULL will returned if
+ * nothing was found after 'start'
+ */
+static struct extent_state *
+find_first_extent_bit_state(struct extent_io_tree *tree, u64 start, u32 bits)
+{
+	struct rb_node *node;
+	struct extent_state *state;
+
+	/*
+	 * this search will find all the extents that end after
+	 * our range starts.
+	 */
+	node = tree_search(tree, start);
+	if (!node)
+		goto out;
+
+	while (1) {
+		state = rb_entry(node, struct extent_state, rb_node);
+		if (state->end >= start && (state->state & bits))
+			return state;
+
+		node = rb_next(node);
+		if (!node)
+			break;
+	}
+out:
+	return NULL;
+}
+
+/*
+ * Find the first offset in the io tree with one or more @bits set.
+ *
+ * Note: If there are multiple bits set in @bits, any of them will match.
+ *
+ * Return 0 if we find something, and update @start_ret and @end_ret.
+ * Return 1 if we found nothing.
+ */
+int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
+			  struct extent_state **cached_state)
+{
+	struct extent_state *state;
+	int ret = 1;
+
+	spin_lock(&tree->lock);
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (state->end == start - 1 && extent_state_in_tree(state)) {
+			while ((state = next_state(state)) != NULL) {
+				if (state->state & bits)
+					goto got_it;
+			}
+			free_extent_state(*cached_state);
+			*cached_state = NULL;
+			goto out;
+		}
+		free_extent_state(*cached_state);
+		*cached_state = NULL;
+	}
+
+	state = find_first_extent_bit_state(tree, start, bits);
+got_it:
+	if (state) {
+		cache_state_if_flags(state, cached_state, 0);
+		*start_ret = state->start;
+		*end_ret = state->end;
+		ret = 0;
+	}
+out:
+	spin_unlock(&tree->lock);
+	return ret;
+}
+
+/**
+ * Find a contiguous area of bits
+ *
+ * @tree:      io tree to check
+ * @start:     offset to start the search from
+ * @start_ret: the first offset we found with the bits set
+ * @end_ret:   the final contiguous range of the bits that were set
+ * @bits:      bits to look for
+ *
+ * set_extent_bit and clear_extent_bit can temporarily split contiguous ranges
+ * to set bits appropriately, and then merge them again.  During this time it
+ * will drop the tree->lock, so use this helper if you want to find the actual
+ * contiguous area for given bits.  We will search to the first bit we find, and
+ * then walk down the tree until we find a non-contiguous area.  The area
+ * returned will be the full contiguous area with the bits set.
+ */
+int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+			       u64 *start_ret, u64 *end_ret, u32 bits)
+{
+	struct extent_state *state;
+	int ret = 1;
+
+	spin_lock(&tree->lock);
+	state = find_first_extent_bit_state(tree, start, bits);
+	if (state) {
+		*start_ret = state->start;
+		*end_ret = state->end;
+		while ((state = next_state(state)) != NULL) {
+			if (state->start > (*end_ret + 1))
+				break;
+			*end_ret = state->end;
+		}
+		ret = 0;
+	}
+	spin_unlock(&tree->lock);
+	return ret;
+}
+
+/*
+ * find a contiguous range of bytes in the file marked as delalloc, not
+ * more than 'max_bytes'.  start and end are used to return the range,
+ *
+ * true is returned if we find something, false if nothing was in the tree
+ */
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state)
+{
+	struct rb_node *node;
+	struct extent_state *state;
+	u64 cur_start = *start;
+	bool found = false;
+	u64 total_bytes = 0;
+
+	spin_lock(&tree->lock);
+
+	/*
+	 * this search will find all the extents that end after
+	 * our range starts.
+	 */
+	node = tree_search(tree, cur_start);
+	if (!node) {
+		*end = (u64)-1;
+		goto out;
+	}
+
+	while (1) {
+		state = rb_entry(node, struct extent_state, rb_node);
+		if (found && (state->start != cur_start ||
+			      (state->state & EXTENT_BOUNDARY))) {
+			goto out;
+		}
+		if (!(state->state & EXTENT_DELALLOC)) {
+			if (!found)
+				*end = state->end;
+			goto out;
+		}
+		if (!found) {
+			*start = state->start;
+			*cached_state = state;
+			refcount_inc(&state->refs);
+		}
+		found = true;
+		*end = state->end;
+		cur_start = state->end + 1;
+		node = rb_next(node);
+		total_bytes += state->end - state->start + 1;
+		if (total_bytes >= max_bytes)
+			break;
+		if (!node)
+			break;
+	}
+out:
+	spin_unlock(&tree->lock);
+	return found;
+}
+
+/*
+ * set some bits on a range in the tree.  This may require allocations or
+ * sleeping, so the gfp mask is used to indicate what is allowed.
+ *
+ * If any of the exclusive bits are set, this will fail with -EEXIST if some
+ * part of the range already has the desired bits set.  The start of the
+ * existing range is returned in failed_start in this case.
+ *
+ * [start, end] is inclusive This takes the tree lock.
+ */
+int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+		   u32 exclusive_bits, u64 *failed_start,
+		   struct extent_state **cached_state, gfp_t mask,
+		   struct extent_changeset *changeset)
+{
+	struct extent_state *state;
+	struct extent_state *prealloc = NULL;
+	struct rb_node *node;
+	struct rb_node **p;
+	struct rb_node *parent;
+	int err = 0;
+	u64 last_start;
+	u64 last_end;
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
+
+	if (exclusive_bits)
+		ASSERT(failed_start);
+	else
+		ASSERT(failed_start == NULL);
+again:
+	if (!prealloc && gfpflags_allow_blocking(mask)) {
+		/*
+		 * Don't care for allocation failure here because we might end
+		 * up not needing the pre-allocated extent state at all, which
+		 * is the case if we only have in the tree extent states that
+		 * cover our input range and don't cover too any other range.
+		 * If we end up needing a new extent state we allocate it later.
+		 */
+		prealloc = alloc_extent_state(mask);
+	}
+
+	spin_lock(&tree->lock);
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (state->start <= start && state->end > start &&
+		    extent_state_in_tree(state)) {
+			node = &state->rb_node;
+			goto hit_next;
+		}
+	}
+	/*
+	 * this search will find all the extents that end after
+	 * our range starts.
+	 */
+	node = tree_search_for_insert(tree, start, &p, &parent);
+	if (!node) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		BUG_ON(!prealloc);
+		prealloc->start = start;
+		prealloc->end = end;
+		insert_state_fast(tree, prealloc, p, parent, bits, changeset);
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		goto out;
+	}
+	state = rb_entry(node, struct extent_state, rb_node);
+hit_next:
+	last_start = state->start;
+	last_end = state->end;
+
+	/*
+	 * | ---- desired range ---- |
+	 * | state |
+	 *
+	 * Just lock what we found and keep going
+	 */
+	if (state->start == start && state->end <= end) {
+		if (state->state & exclusive_bits) {
+			*failed_start = state->start;
+			err = -EEXIST;
+			goto out;
+		}
+
+		set_state_bits(tree, state, bits, changeset);
+		cache_state(state, cached_state);
+		merge_state(tree, state);
+		if (last_end == (u64)-1)
+			goto out;
+		start = last_end + 1;
+		state = next_state(state);
+		if (start < end && state && state->start == start &&
+		    !need_resched())
+			goto hit_next;
+		goto search_again;
+	}
+
+	/*
+	 *     | ---- desired range ---- |
+	 * | state |
+	 *   or
+	 * | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip bits on
+	 * second half.
+	 *
+	 * If the extent we found extends past our
+	 * range, we just split and search again.  It'll get split
+	 * again the next time though.
+	 *
+	 * If the extent we found is inside our range, we set the
+	 * desired bit on it.
+	 */
+	if (state->start < start) {
+		if (state->state & exclusive_bits) {
+			*failed_start = start;
+			err = -EEXIST;
+			goto out;
+		}
+
+		/*
+		 * If this extent already has all the bits we want set, then
+		 * skip it, not necessary to split it or do anything with it.
+		 */
+		if ((state->state & bits) == bits) {
+			start = state->end + 1;
+			cache_state(state, cached_state);
+			goto search_again;
+		}
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		BUG_ON(!prealloc);
+		err = split_state(tree, state, prealloc, start);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			set_state_bits(tree, state, bits, changeset);
+			cache_state(state, cached_state);
+			merge_state(tree, state);
+			if (last_end == (u64)-1)
+				goto out;
+			start = last_end + 1;
+			state = next_state(state);
+			if (start < end && state && state->start == start &&
+			    !need_resched())
+				goto hit_next;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *     | state | or               | state |
+	 *
+	 * There's a hole, we need to insert something in it and
+	 * ignore the extent we found.
+	 */
+	if (state->start > start) {
+		u64 this_end;
+		if (end < last_start)
+			this_end = end;
+		else
+			this_end = last_start - 1;
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		BUG_ON(!prealloc);
+
+		/*
+		 * Avoid to free 'prealloc' if it can be merged with
+		 * the later extent.
+		 */
+		prealloc->start = start;
+		prealloc->end = this_end;
+		err = insert_state(tree, prealloc, bits, changeset);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		start = this_end + 1;
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 * We need to split the extent, and set the bit
+	 * on the first half
+	 */
+	if (state->start <= end && state->end > end) {
+		if (state->state & exclusive_bits) {
+			*failed_start = start;
+			err = -EEXIST;
+			goto out;
+		}
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		BUG_ON(!prealloc);
+		err = split_state(tree, state, prealloc, end + 1);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		set_state_bits(tree, prealloc, bits, changeset);
+		cache_state(prealloc, cached_state);
+		merge_state(tree, prealloc);
+		prealloc = NULL;
+		goto out;
+	}
+
+search_again:
+	if (start > end)
+		goto out;
+	spin_unlock(&tree->lock);
+	if (gfpflags_allow_blocking(mask))
+		cond_resched();
+	goto again;
+
+out:
+	spin_unlock(&tree->lock);
+	if (prealloc)
+		free_extent_state(prealloc);
+
+	return err;
+
+}
+
+/**
+ * convert_extent_bit - convert all bits in a given range from one bit to
+ * 			another
+ * @tree:	the io tree to search
+ * @start:	the start offset in bytes
+ * @end:	the end offset in bytes (inclusive)
+ * @bits:	the bits to set in this range
+ * @clear_bits:	the bits to clear in this range
+ * @cached_state:	state that we're going to cache
+ *
+ * This will go through and set bits for the given range.  If any states exist
+ * already in this range they are set with the given bit and cleared of the
+ * clear_bits.  This is only meant to be used by things that are mergeable, ie
+ * converting from say DELALLOC to DIRTY.  This is not meant to be used with
+ * boundary bits like LOCK.
+ *
+ * All allocations are done with GFP_NOFS.
+ */
+int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, u32 clear_bits,
+		       struct extent_state **cached_state)
+{
+	struct extent_state *state;
+	struct extent_state *prealloc = NULL;
+	struct rb_node *node;
+	struct rb_node **p;
+	struct rb_node *parent;
+	int err = 0;
+	u64 last_start;
+	u64 last_end;
+	bool first_iteration = true;
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+	trace_btrfs_convert_extent_bit(tree, start, end - start + 1, bits,
+				       clear_bits);
+
+again:
+	if (!prealloc) {
+		/*
+		 * Best effort, don't worry if extent state allocation fails
+		 * here for the first iteration. We might have a cached state
+		 * that matches exactly the target range, in which case no
+		 * extent state allocations are needed. We'll only know this
+		 * after locking the tree.
+		 */
+		prealloc = alloc_extent_state(GFP_NOFS);
+		if (!prealloc && !first_iteration)
+			return -ENOMEM;
+	}
+
+	spin_lock(&tree->lock);
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (state->start <= start && state->end > start &&
+		    extent_state_in_tree(state)) {
+			node = &state->rb_node;
+			goto hit_next;
+		}
+	}
+
+	/*
+	 * this search will find all the extents that end after
+	 * our range starts.
+	 */
+	node = tree_search_for_insert(tree, start, &p, &parent);
+	if (!node) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+		prealloc->start = start;
+		prealloc->end = end;
+		insert_state_fast(tree, prealloc, p, parent, bits, NULL);
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		goto out;
+	}
+	state = rb_entry(node, struct extent_state, rb_node);
+hit_next:
+	last_start = state->start;
+	last_end = state->end;
+
+	/*
+	 * | ---- desired range ---- |
+	 * | state |
+	 *
+	 * Just lock what we found and keep going
+	 */
+	if (state->start == start && state->end <= end) {
+		set_state_bits(tree, state, bits, NULL);
+		cache_state(state, cached_state);
+		state = clear_state_bit(tree, state, clear_bits, 0, NULL);
+		if (last_end == (u64)-1)
+			goto out;
+		start = last_end + 1;
+		if (start < end && state && state->start == start &&
+		    !need_resched())
+			goto hit_next;
+		goto search_again;
+	}
+
+	/*
+	 *     | ---- desired range ---- |
+	 * | state |
+	 *   or
+	 * | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip bits on
+	 * second half.
+	 *
+	 * If the extent we found extends past our
+	 * range, we just split and search again.  It'll get split
+	 * again the next time though.
+	 *
+	 * If the extent we found is inside our range, we set the
+	 * desired bit on it.
+	 */
+	if (state->start < start) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = split_state(tree, state, prealloc, start);
+		if (err)
+			extent_io_tree_panic(tree, err);
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			set_state_bits(tree, state, bits, NULL);
+			cache_state(state, cached_state);
+			state = clear_state_bit(tree, state, clear_bits, 0, NULL);
+			if (last_end == (u64)-1)
+				goto out;
+			start = last_end + 1;
+			if (start < end && state && state->start == start &&
+			    !need_resched())
+				goto hit_next;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *     | state | or               | state |
+	 *
+	 * There's a hole, we need to insert something in it and
+	 * ignore the extent we found.
+	 */
+	if (state->start > start) {
+		u64 this_end;
+		if (end < last_start)
+			this_end = end;
+		else
+			this_end = last_start - 1;
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		/*
+		 * Avoid to free 'prealloc' if it can be merged with
+		 * the later extent.
+		 */
+		prealloc->start = start;
+		prealloc->end = this_end;
+		err = insert_state(tree, prealloc, bits, NULL);
+		if (err)
+			extent_io_tree_panic(tree, err);
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		start = this_end + 1;
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 * We need to split the extent, and set the bit
+	 * on the first half
+	 */
+	if (state->start <= end && state->end > end) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = split_state(tree, state, prealloc, end + 1);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		set_state_bits(tree, prealloc, bits, NULL);
+		cache_state(prealloc, cached_state);
+		clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
+		prealloc = NULL;
+		goto out;
+	}
+
+search_again:
+	if (start > end)
+		goto out;
+	spin_unlock(&tree->lock);
+	cond_resched();
+	first_iteration = false;
+	goto again;
+
+out:
+	spin_unlock(&tree->lock);
+	if (prealloc)
+		free_extent_state(prealloc);
+
+	return err;
+}
+
 /**
  * Find the first range that has @bits not set. This range could start before
  * @start.
@@ -628,6 +1508,122 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	spin_unlock(&tree->lock);
 }
 
+/*
+ * count the number of bytes in the tree that have a given bit(s)
+ * set.  This can be fairly slow, except for EXTENT_DIRTY which is
+ * cached.  The total number found is returned.
+ */
+u64 count_range_bits(struct extent_io_tree *tree,
+		     u64 *start, u64 search_end, u64 max_bytes,
+		     u32 bits, int contig)
+{
+	struct rb_node *node;
+	struct extent_state *state;
+	u64 cur_start = *start;
+	u64 total_bytes = 0;
+	u64 last = 0;
+	int found = 0;
+
+	if (WARN_ON(search_end <= cur_start))
+		return 0;
+
+	spin_lock(&tree->lock);
+	if (cur_start == 0 && bits == EXTENT_DIRTY) {
+		total_bytes = tree->dirty_bytes;
+		goto out;
+	}
+	/*
+	 * this search will find all the extents that end after
+	 * our range starts.
+	 */
+	node = tree_search(tree, cur_start);
+	if (!node)
+		goto out;
+
+	while (1) {
+		state = rb_entry(node, struct extent_state, rb_node);
+		if (state->start > search_end)
+			break;
+		if (contig && found && state->start > last + 1)
+			break;
+		if (state->end >= cur_start && (state->state & bits) == bits) {
+			total_bytes += min(search_end, state->end) + 1 -
+				       max(cur_start, state->start);
+			if (total_bytes >= max_bytes)
+				break;
+			if (!found) {
+				*start = max(cur_start, state->start);
+				found = 1;
+			}
+			last = state->end;
+		} else if (contig && found) {
+			break;
+		}
+		node = rb_next(node);
+		if (!node)
+			break;
+	}
+out:
+	spin_unlock(&tree->lock);
+	return total_bytes;
+}
+
+/*
+ * searches a range in the state tree for a given mask.
+ * If 'filled' == 1, this returns 1 only if every extent in the tree
+ * has the bits set.  Otherwise, 1 is returned if any bit in the
+ * range is found set.
+ */
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, int filled, struct extent_state *cached)
+{
+	struct extent_state *state = NULL;
+	struct rb_node *node;
+	int bitset = 0;
+
+	spin_lock(&tree->lock);
+	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
+	    cached->end > start)
+		node = &cached->rb_node;
+	else
+		node = tree_search(tree, start);
+	while (node && start <= end) {
+		state = rb_entry(node, struct extent_state, rb_node);
+
+		if (filled && state->start > start) {
+			bitset = 0;
+			break;
+		}
+
+		if (state->start > end)
+			break;
+
+		if (state->state & bits) {
+			bitset = 1;
+			if (!filled)
+				break;
+		} else if (filled) {
+			bitset = 0;
+			break;
+		}
+
+		if (state->end == (u64)-1)
+			break;
+
+		start = state->end + 1;
+		if (start > end)
+			break;
+		node = rb_next(node);
+		if (!node) {
+			if (filled)
+				bitset = 0;
+			break;
+		}
+	}
+	spin_unlock(&tree->lock);
+	return bitset;
+}
+
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fd2506c9be03..8644072303df 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -181,714 +181,6 @@ void __cold extent_buffer_free_cachep(void)
 	kmem_cache_destroy(extent_buffer_cache);
 }
 
-/*
- * Inexact rb-tree search, return the next entry if @offset is not found
- */
-static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
-{
-	return tree_search_for_insert(tree, offset, NULL, NULL);
-}
-
-static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
-{
-	btrfs_panic(tree->fs_info, err,
-	"locking error: extent tree was modified by another thread while locked");
-}
-
-/*
- * clear some bits on a range in the tree.  This may require splitting
- * or inserting elements in the tree, so the gfp mask is used to
- * indicate which allocations or sleeping are allowed.
- *
- * pass 'wake' == 1 to kick any sleepers, and 'delete' == 1 to remove
- * the given range from the tree regardless of state (ie for truncate).
- *
- * the range [start, end] is inclusive.
- *
- * This takes the tree lock, and returns 0 on success and < 0 on error.
- */
-int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		       u32 bits, int wake, int delete,
-		       struct extent_state **cached_state,
-		       gfp_t mask, struct extent_changeset *changeset)
-{
-	struct extent_state *state;
-	struct extent_state *cached;
-	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
-	u64 last_end;
-	int err;
-	int clear = 0;
-
-	btrfs_debug_check_extent_io_range(tree, start, end);
-	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
-
-	if (bits & EXTENT_DELALLOC)
-		bits |= EXTENT_NORESERVE;
-
-	if (delete)
-		bits |= ~EXTENT_CTLBITS;
-
-	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
-		clear = 1;
-again:
-	if (!prealloc && gfpflags_allow_blocking(mask)) {
-		/*
-		 * Don't care for allocation failure here because we might end
-		 * up not needing the pre-allocated extent state at all, which
-		 * is the case if we only have in the tree extent states that
-		 * cover our input range and don't cover too any other range.
-		 * If we end up needing a new extent state we allocate it later.
-		 */
-		prealloc = alloc_extent_state(mask);
-	}
-
-	spin_lock(&tree->lock);
-	if (cached_state) {
-		cached = *cached_state;
-
-		if (clear) {
-			*cached_state = NULL;
-			cached_state = NULL;
-		}
-
-		if (cached && extent_state_in_tree(cached) &&
-		    cached->start <= start && cached->end > start) {
-			if (clear)
-				refcount_dec(&cached->refs);
-			state = cached;
-			goto hit_next;
-		}
-		if (clear)
-			free_extent_state(cached);
-	}
-	/*
-	 * this search will find the extents that end after
-	 * our range starts
-	 */
-	node = tree_search(tree, start);
-	if (!node)
-		goto out;
-	state = rb_entry(node, struct extent_state, rb_node);
-hit_next:
-	if (state->start > end)
-		goto out;
-	WARN_ON(state->end < start);
-	last_end = state->end;
-
-	/* the state doesn't have the wanted bits, go ahead */
-	if (!(state->state & bits)) {
-		state = next_state(state);
-		goto next;
-	}
-
-	/*
-	 *     | ---- desired range ---- |
-	 *  | state | or
-	 *  | ------------- state -------------- |
-	 *
-	 * We need to split the extent we found, and may flip
-	 * bits on second half.
-	 *
-	 * If the extent we found extends past our range, we
-	 * just split and search again.  It'll get split again
-	 * the next time though.
-	 *
-	 * If the extent we found is inside our range, we clear
-	 * the desired bit on it.
-	 */
-
-	if (state->start < start) {
-		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
-		err = split_state(tree, state, prealloc, start);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
-		prealloc = NULL;
-		if (err)
-			goto out;
-		if (state->end <= end) {
-			state = clear_state_bit(tree, state, bits, wake, changeset);
-			goto next;
-		}
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 *                        | state |
-	 * We need to split the extent, and clear the bit
-	 * on the first half
-	 */
-	if (state->start <= end && state->end > end) {
-		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
-		if (wake)
-			wake_up(&state->wq);
-
-		clear_state_bit(tree, prealloc, bits, wake, changeset);
-
-		prealloc = NULL;
-		goto out;
-	}
-
-	state = clear_state_bit(tree, state, bits, wake, changeset);
-next:
-	if (last_end == (u64)-1)
-		goto out;
-	start = last_end + 1;
-	if (start <= end && state && !need_resched())
-		goto hit_next;
-
-search_again:
-	if (start > end)
-		goto out;
-	spin_unlock(&tree->lock);
-	if (gfpflags_allow_blocking(mask))
-		cond_resched();
-	goto again;
-
-out:
-	spin_unlock(&tree->lock);
-	if (prealloc)
-		free_extent_state(prealloc);
-
-	return 0;
-
-}
-
-static void wait_on_state(struct extent_io_tree *tree,
-			  struct extent_state *state)
-		__releases(tree->lock)
-		__acquires(tree->lock)
-{
-	DEFINE_WAIT(wait);
-	prepare_to_wait(&state->wq, &wait, TASK_UNINTERRUPTIBLE);
-	spin_unlock(&tree->lock);
-	schedule();
-	spin_lock(&tree->lock);
-	finish_wait(&state->wq, &wait);
-}
-
-/*
- * waits for one or more bits to clear on a range in the state tree.
- * The range [start, end] is inclusive.
- * The tree lock is taken by this function
- */
-void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
-{
-	struct extent_state *state;
-	struct rb_node *node;
-
-	btrfs_debug_check_extent_io_range(tree, start, end);
-
-	spin_lock(&tree->lock);
-again:
-	while (1) {
-		/*
-		 * this search will find all the extents that end after
-		 * our range starts
-		 */
-		node = tree_search(tree, start);
-process_node:
-		if (!node)
-			break;
-
-		state = rb_entry(node, struct extent_state, rb_node);
-
-		if (state->start > end)
-			goto out;
-
-		if (state->state & bits) {
-			start = state->start;
-			refcount_inc(&state->refs);
-			wait_on_state(tree, state);
-			free_extent_state(state);
-			goto again;
-		}
-		start = state->end + 1;
-
-		if (start > end)
-			break;
-
-		if (!cond_resched_lock(&tree->lock)) {
-			node = rb_next(node);
-			goto process_node;
-		}
-	}
-out:
-	spin_unlock(&tree->lock);
-}
-
-static void cache_state_if_flags(struct extent_state *state,
-				 struct extent_state **cached_ptr,
-				 unsigned flags)
-{
-	if (cached_ptr && !(*cached_ptr)) {
-		if (!flags || (state->state & flags)) {
-			*cached_ptr = state;
-			refcount_inc(&state->refs);
-		}
-	}
-}
-
-static void cache_state(struct extent_state *state,
-			struct extent_state **cached_ptr)
-{
-	return cache_state_if_flags(state, cached_ptr,
-				    EXTENT_LOCKED | EXTENT_BOUNDARY);
-}
-
-/*
- * set some bits on a range in the tree.  This may require allocations or
- * sleeping, so the gfp mask is used to indicate what is allowed.
- *
- * If any of the exclusive bits are set, this will fail with -EEXIST if some
- * part of the range already has the desired bits set.  The start of the
- * existing range is returned in failed_start in this case.
- *
- * [start, end] is inclusive This takes the tree lock.
- */
-int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
-		   u32 exclusive_bits, u64 *failed_start,
-		   struct extent_state **cached_state, gfp_t mask,
-		   struct extent_changeset *changeset)
-{
-	struct extent_state *state;
-	struct extent_state *prealloc = NULL;
-	struct rb_node *node;
-	struct rb_node **p;
-	struct rb_node *parent;
-	int err = 0;
-	u64 last_start;
-	u64 last_end;
-
-	btrfs_debug_check_extent_io_range(tree, start, end);
-	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
-
-	if (exclusive_bits)
-		ASSERT(failed_start);
-	else
-		ASSERT(failed_start == NULL);
-again:
-	if (!prealloc && gfpflags_allow_blocking(mask)) {
-		/*
-		 * Don't care for allocation failure here because we might end
-		 * up not needing the pre-allocated extent state at all, which
-		 * is the case if we only have in the tree extent states that
-		 * cover our input range and don't cover too any other range.
-		 * If we end up needing a new extent state we allocate it later.
-		 */
-		prealloc = alloc_extent_state(mask);
-	}
-
-	spin_lock(&tree->lock);
-	if (cached_state && *cached_state) {
-		state = *cached_state;
-		if (state->start <= start && state->end > start &&
-		    extent_state_in_tree(state)) {
-			node = &state->rb_node;
-			goto hit_next;
-		}
-	}
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search_for_insert(tree, start, &p, &parent);
-	if (!node) {
-		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
-		prealloc->start = start;
-		prealloc->end = end;
-		insert_state_fast(tree, prealloc, p, parent, bits, changeset);
-		cache_state(prealloc, cached_state);
-		prealloc = NULL;
-		goto out;
-	}
-	state = rb_entry(node, struct extent_state, rb_node);
-hit_next:
-	last_start = state->start;
-	last_end = state->end;
-
-	/*
-	 * | ---- desired range ---- |
-	 * | state |
-	 *
-	 * Just lock what we found and keep going
-	 */
-	if (state->start == start && state->end <= end) {
-		if (state->state & exclusive_bits) {
-			*failed_start = state->start;
-			err = -EEXIST;
-			goto out;
-		}
-
-		set_state_bits(tree, state, bits, changeset);
-		cache_state(state, cached_state);
-		merge_state(tree, state);
-		if (last_end == (u64)-1)
-			goto out;
-		start = last_end + 1;
-		state = next_state(state);
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
-	 * We need to split the extent we found, and may flip bits on
-	 * second half.
-	 *
-	 * If the extent we found extends past our
-	 * range, we just split and search again.  It'll get split
-	 * again the next time though.
-	 *
-	 * If the extent we found is inside our range, we set the
-	 * desired bit on it.
-	 */
-	if (state->start < start) {
-		if (state->state & exclusive_bits) {
-			*failed_start = start;
-			err = -EEXIST;
-			goto out;
-		}
-
-		/*
-		 * If this extent already has all the bits we want set, then
-		 * skip it, not necessary to split it or do anything with it.
-		 */
-		if ((state->state & bits) == bits) {
-			start = state->end + 1;
-			cache_state(state, cached_state);
-			goto search_again;
-		}
-
-		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
-		err = split_state(tree, state, prealloc, start);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
-		prealloc = NULL;
-		if (err)
-			goto out;
-		if (state->end <= end) {
-			set_state_bits(tree, state, bits, changeset);
-			cache_state(state, cached_state);
-			merge_state(tree, state);
-			if (last_end == (u64)-1)
-				goto out;
-			start = last_end + 1;
-			state = next_state(state);
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
-	 * There's a hole, we need to insert something in it and
-	 * ignore the extent we found.
-	 */
-	if (state->start > start) {
-		u64 this_end;
-		if (end < last_start)
-			this_end = end;
-		else
-			this_end = last_start - 1;
-
-		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
-
-		/*
-		 * Avoid to free 'prealloc' if it can be merged with
-		 * the later extent.
-		 */
-		prealloc->start = start;
-		prealloc->end = this_end;
-		err = insert_state(tree, prealloc, bits, changeset);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
-		cache_state(prealloc, cached_state);
-		prealloc = NULL;
-		start = this_end + 1;
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 *                        | state |
-	 * We need to split the extent, and set the bit
-	 * on the first half
-	 */
-	if (state->start <= end && state->end > end) {
-		if (state->state & exclusive_bits) {
-			*failed_start = start;
-			err = -EEXIST;
-			goto out;
-		}
-
-		prealloc = alloc_extent_state_atomic(prealloc);
-		BUG_ON(!prealloc);
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
-		set_state_bits(tree, prealloc, bits, changeset);
-		cache_state(prealloc, cached_state);
-		merge_state(tree, prealloc);
-		prealloc = NULL;
-		goto out;
-	}
-
-search_again:
-	if (start > end)
-		goto out;
-	spin_unlock(&tree->lock);
-	if (gfpflags_allow_blocking(mask))
-		cond_resched();
-	goto again;
-
-out:
-	spin_unlock(&tree->lock);
-	if (prealloc)
-		free_extent_state(prealloc);
-
-	return err;
-
-}
-
-/**
- * convert_extent_bit - convert all bits in a given range from one bit to
- * 			another
- * @tree:	the io tree to search
- * @start:	the start offset in bytes
- * @end:	the end offset in bytes (inclusive)
- * @bits:	the bits to set in this range
- * @clear_bits:	the bits to clear in this range
- * @cached_state:	state that we're going to cache
- *
- * This will go through and set bits for the given range.  If any states exist
- * already in this range they are set with the given bit and cleared of the
- * clear_bits.  This is only meant to be used by things that are mergeable, ie
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
-	struct rb_node *node;
-	struct rb_node **p;
-	struct rb_node *parent;
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
-		    extent_state_in_tree(state)) {
-			node = &state->rb_node;
-			goto hit_next;
-		}
-	}
-
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search_for_insert(tree, start, &p, &parent);
-	if (!node) {
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
-	state = rb_entry(node, struct extent_state, rb_node);
-hit_next:
-	last_start = state->start;
-	last_end = state->end;
-
-	/*
-	 * | ---- desired range ---- |
-	 * | state |
-	 *
-	 * Just lock what we found and keep going
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
-	 * We need to split the extent we found, and may flip bits on
-	 * second half.
-	 *
-	 * If the extent we found extends past our
-	 * range, we just split and search again.  It'll get split
-	 * again the next time though.
-	 *
-	 * If the extent we found is inside our range, we set the
-	 * desired bit on it.
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
-	 * There's a hole, we need to insert something in it and
-	 * ignore the extent we found.
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
-		 * Avoid to free 'prealloc' if it can be merged with
-		 * the later extent.
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
-	 * We need to split the extent, and set the bit
-	 * on the first half
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
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
 	unsigned long index = start >> PAGE_SHIFT;
@@ -920,178 +212,6 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 	}
 }
 
-/* find the first state struct with 'bits' set after 'start', and
- * return it.  tree->lock must be held.  NULL will returned if
- * nothing was found after 'start'
- */
-static struct extent_state *
-find_first_extent_bit_state(struct extent_io_tree *tree, u64 start, u32 bits)
-{
-	struct rb_node *node;
-	struct extent_state *state;
-
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search(tree, start);
-	if (!node)
-		goto out;
-
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
-		if (state->end >= start && (state->state & bits))
-			return state;
-
-		node = rb_next(node);
-		if (!node)
-			break;
-	}
-out:
-	return NULL;
-}
-
-/*
- * Find the first offset in the io tree with one or more @bits set.
- *
- * Note: If there are multiple bits set in @bits, any of them will match.
- *
- * Return 0 if we find something, and update @start_ret and @end_ret.
- * Return 1 if we found nothing.
- */
-int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, u32 bits,
-			  struct extent_state **cached_state)
-{
-	struct extent_state *state;
-	int ret = 1;
-
-	spin_lock(&tree->lock);
-	if (cached_state && *cached_state) {
-		state = *cached_state;
-		if (state->end == start - 1 && extent_state_in_tree(state)) {
-			while ((state = next_state(state)) != NULL) {
-				if (state->state & bits)
-					goto got_it;
-			}
-			free_extent_state(*cached_state);
-			*cached_state = NULL;
-			goto out;
-		}
-		free_extent_state(*cached_state);
-		*cached_state = NULL;
-	}
-
-	state = find_first_extent_bit_state(tree, start, bits);
-got_it:
-	if (state) {
-		cache_state_if_flags(state, cached_state, 0);
-		*start_ret = state->start;
-		*end_ret = state->end;
-		ret = 0;
-	}
-out:
-	spin_unlock(&tree->lock);
-	return ret;
-}
-
-/**
- * Find a contiguous area of bits
- *
- * @tree:      io tree to check
- * @start:     offset to start the search from
- * @start_ret: the first offset we found with the bits set
- * @end_ret:   the final contiguous range of the bits that were set
- * @bits:      bits to look for
- *
- * set_extent_bit and clear_extent_bit can temporarily split contiguous ranges
- * to set bits appropriately, and then merge them again.  During this time it
- * will drop the tree->lock, so use this helper if you want to find the actual
- * contiguous area for given bits.  We will search to the first bit we find, and
- * then walk down the tree until we find a non-contiguous area.  The area
- * returned will be the full contiguous area with the bits set.
- */
-int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
-			       u64 *start_ret, u64 *end_ret, u32 bits)
-{
-	struct extent_state *state;
-	int ret = 1;
-
-	spin_lock(&tree->lock);
-	state = find_first_extent_bit_state(tree, start, bits);
-	if (state) {
-		*start_ret = state->start;
-		*end_ret = state->end;
-		while ((state = next_state(state)) != NULL) {
-			if (state->start > (*end_ret + 1))
-				break;
-			*end_ret = state->end;
-		}
-		ret = 0;
-	}
-	spin_unlock(&tree->lock);
-	return ret;
-}
-
-/*
- * find a contiguous range of bytes in the file marked as delalloc, not
- * more than 'max_bytes'.  start and end are used to return the range,
- *
- * true is returned if we find something, false if nothing was in the tree
- */
-bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
-			       u64 *end, u64 max_bytes,
-			       struct extent_state **cached_state)
-{
-	struct rb_node *node;
-	struct extent_state *state;
-	u64 cur_start = *start;
-	bool found = false;
-	u64 total_bytes = 0;
-
-	spin_lock(&tree->lock);
-
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search(tree, cur_start);
-	if (!node) {
-		*end = (u64)-1;
-		goto out;
-	}
-
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
-		if (found && (state->start != cur_start ||
-			      (state->state & EXTENT_BOUNDARY))) {
-			goto out;
-		}
-		if (!(state->state & EXTENT_DELALLOC)) {
-			if (!found)
-				*end = state->end;
-			goto out;
-		}
-		if (!found) {
-			*start = state->start;
-			*cached_state = state;
-			refcount_inc(&state->refs);
-		}
-		found = true;
-		*end = state->end;
-		cur_start = state->end + 1;
-		node = rb_next(node);
-		total_bytes += state->end - state->start + 1;
-		if (total_bytes >= max_bytes)
-			break;
-		if (!node)
-			break;
-	}
-out:
-	spin_unlock(&tree->lock);
-	return found;
-}
-
 /*
  * Process one page for __process_pages_contig().
  *
@@ -1373,66 +493,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			       start, end, page_ops, NULL);
 }
 
-/*
- * count the number of bytes in the tree that have a given bit(s)
- * set.  This can be fairly slow, except for EXTENT_DIRTY which is
- * cached.  The total number found is returned.
- */
-u64 count_range_bits(struct extent_io_tree *tree,
-		     u64 *start, u64 search_end, u64 max_bytes,
-		     u32 bits, int contig)
-{
-	struct rb_node *node;
-	struct extent_state *state;
-	u64 cur_start = *start;
-	u64 total_bytes = 0;
-	u64 last = 0;
-	int found = 0;
-
-	if (WARN_ON(search_end <= cur_start))
-		return 0;
-
-	spin_lock(&tree->lock);
-	if (cur_start == 0 && bits == EXTENT_DIRTY) {
-		total_bytes = tree->dirty_bytes;
-		goto out;
-	}
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search(tree, cur_start);
-	if (!node)
-		goto out;
-
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
-		if (state->start > search_end)
-			break;
-		if (contig && found && state->start > last + 1)
-			break;
-		if (state->end >= cur_start && (state->state & bits) == bits) {
-			total_bytes += min(search_end, state->end) + 1 -
-				       max(cur_start, state->start);
-			if (total_bytes >= max_bytes)
-				break;
-			if (!found) {
-				*start = max(cur_start, state->start);
-				found = 1;
-			}
-			last = state->end;
-		} else if (contig && found) {
-			break;
-		}
-		node = rb_next(node);
-		if (!node)
-			break;
-	}
-out:
-	spin_unlock(&tree->lock);
-	return total_bytes;
-}
-
 static int insert_failrec(struct btrfs_inode *inode,
 			  struct io_failure_record *failrec)
 {
@@ -1460,62 +520,6 @@ static struct io_failure_record *get_failrec(struct btrfs_inode *inode,
 	return failrec;
 }
 
-/*
- * searches a range in the state tree for a given mask.
- * If 'filled' == 1, this returns 1 only if every extent in the tree
- * has the bits set.  Otherwise, 1 is returned if any bit in the
- * range is found set.
- */
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, int filled, struct extent_state *cached)
-{
-	struct extent_state *state = NULL;
-	struct rb_node *node;
-	int bitset = 0;
-
-	spin_lock(&tree->lock);
-	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
-	    cached->end > start)
-		node = &cached->rb_node;
-	else
-		node = tree_search(tree, start);
-	while (node && start <= end) {
-		state = rb_entry(node, struct extent_state, rb_node);
-
-		if (filled && state->start > start) {
-			bitset = 0;
-			break;
-		}
-
-		if (state->start > end)
-			break;
-
-		if (state->state & bits) {
-			bitset = 1;
-			if (!filled)
-				break;
-		} else if (filled) {
-			bitset = 0;
-			break;
-		}
-
-		if (state->end == (u64)-1)
-			break;
-
-		start = state->end + 1;
-		if (start > end)
-			break;
-		node = rb_next(node);
-		if (!node) {
-			if (filled)
-				bitset = 0;
-			break;
-		}
-	}
-	spin_unlock(&tree->lock);
-	return bitset;
-}
-
 static int free_io_failure(struct btrfs_inode *inode,
 			   struct io_failure_record *rec)
 {
-- 
2.26.3

