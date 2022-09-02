Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40185AB962
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIBURP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIBURG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8BDC098
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r6so2355054qtx.6
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=J4Q0+2UlvPptsU6wqSy1AboUJJ+wa8hVYR0l2yQfhbY=;
        b=nzNnrfOKbhOEnLp2xgzwtUxryDy5tpxtXKegmdHus573kGSi9p7rWFDP18fxQi9N1A
         gFG+baOE01GGKtNYi9s6NkYqSbj+UMZ4waHp/PfFaAPRQKhDtntH2SEQvv3tgZzdB94l
         IyLl44ZytBzpgcBf+nH69PwxBQGqcmCrpII84if/cqZEyRiSeI3TUHsUksM9fiTeHL9J
         LxgAUNiTyxm7hQJH8iHpgcTjlwWw8qYaO4KfMZPbMjomu5RD/JKForM5tdM+wZa/wf3W
         EfK9DAxp2hoHD3o4NeFy1Kqpb0oI7QVgchBgOPx4vk+MiXPcfjlg7cOJmZ0lVH27NG6q
         dhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J4Q0+2UlvPptsU6wqSy1AboUJJ+wa8hVYR0l2yQfhbY=;
        b=HHGbYMlKCDh0x4iK7BHVKQCaEtiFKx4jt8iV4pjuBWY0eBL9pRz5s01Lv2bcoIz2F5
         t6n7OIXwBQaQXGcmyEJHA0ksie9eDyZp+q5yhJMYRLmUPep/RHRNDnOckapibpHTPF26
         EczOmaO6GOvUsgs3Bfv9LddAZnHNYW/irMOklKx3t68+pT1/Pw77VYrM5BCxkGi/ijBT
         Dz/gkRCWjjC8xW5aqR3DkyUX39pe5vq8jtjIoKfQt60VMV4La/Hqt9g27p/qR7X7M3ch
         nIyAy15b9XHcpY6HSvkx6Lwh0mG7jZO3b49KjIL6iPlwNpH4+KUJr7wJWCJxCIosJnPy
         LGPg==
X-Gm-Message-State: ACgBeo2tPqXzQw8sBbgGf2+v9F7OZzNmEuMaUDmfNNdjDBRiru55NCWO
        QsBF5bBKRz7sMy9TWUL5lyqFWt4u2Mftqg==
X-Google-Smtp-Source: AA6agR7S8FSysjtuQgzy6zy6kAlFMW4Wm9F/SnBh5S6XDQbDmxjBdlhl5UWWJAhJ/FppWrQbP3FUBA==
X-Received: by 2002:ac8:58d4:0:b0:344:5dbe:38a4 with SMTP id u20-20020ac858d4000000b003445dbe38a4mr30575293qta.381.1662149820158;
        Fri, 02 Sep 2022 13:17:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d16-20020ac86150000000b0033a5048464fsm1709312qtm.11.2022.09.02.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/31] btrfs: move the core extent_io_tree code into extent-io-tree.c
Date:   Fri,  2 Sep 2022 16:16:17 -0400
Message-Id: <c534c12c1dcf0821971b8918abced08aafd27055.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

This is a big patch unfortunately, all of this code is tightly coupled
together.  There is no code change at all, it is simply cut and paste
from extent_io.c into extent-io-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 1532 ++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c      | 1658 ++-----------------------------------
 2 files changed, 1596 insertions(+), 1594 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 7b8ac9b3bc55..850c4e1c83f5 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -4,6 +4,8 @@
 #include <trace/events/btrfs.h>
 #include "ctree.h"
 #include "extent-io-tree.h"
+#include "btrfs_inode.h"
+#include "misc.h"
 
 static struct kmem_cache *extent_state_cache;
 
@@ -43,12 +45,38 @@ static inline void btrfs_extent_state_leak_debug_check(void)
 		kmem_cache_free(extent_state_cache, state);
 	}
 }
+
+#define btrfs_debug_check_extent_io_range(tree, start, end)		\
+	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
+static inline void __btrfs_debug_check_extent_io_range(const char *caller,
+		struct extent_io_tree *tree, u64 start, u64 end)
+{
+	struct inode *inode = tree->private_data;
+	u64 isize;
+
+	if (!inode || !is_data_inode(inode))
+		return;
+
+	isize = i_size_read(inode);
+	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
+		btrfs_debug_rl(BTRFS_I(inode)->root->fs_info,
+		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
+			caller, btrfs_ino(BTRFS_I(inode)), isize, start, end);
+	}
+}
 #else
 #define btrfs_leak_debug_add_state(state)		do {} while (0)
 #define btrfs_leak_debug_del_state(state)		do {} while (0)
 #define btrfs_extent_state_leak_debug_check()		do {} while (0)
+#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
+struct tree_entry {
+	u64 start;
+	u64 end;
+	struct rb_node rb_node;
+};
+
 /*
  * For the file_extent_tree, we want to hold the inode lock when we lookup and
  * update the disk_i_size, but lockdep will complain because our io_tree we hold
@@ -142,6 +170,24 @@ void free_extent_state(struct extent_state *state)
 	}
 }
 
+static int add_extent_changeset(struct extent_state *state, u32 bits,
+				 struct extent_changeset *changeset,
+				 int set)
+{
+	int ret;
+
+	if (!changeset)
+		return 0;
+	if (set && (state->state & bits) == bits)
+		return 0;
+	if (!set && (state->state & bits) == 0)
+		return 0;
+	changeset->bytes_changed += state->end - state->start + 1;
+	ret = ulist_add(&changeset->range_changed, state->start, state->end,
+			GFP_ATOMIC);
+	return ret;
+}
+
 /* wrappers around set/clear extent bit */
 int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset)
@@ -187,6 +233,1492 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	return 1;
 }
 
+/**
+ * Search @tree for an entry that contains @offset. Such entry would have
+ * entry->start <= offset && entry->end >= offset.
+ *
+ * @tree:       the tree to search
+ * @offset:     offset that should fall within an entry in @tree
+ * @node_ret:   pointer where new node should be anchored (used when inserting an
+ *	        entry in the tree)
+ * @parent_ret: points to entry which would have been the parent of the entry,
+ *               containing @offset
+ *
+ * Return a pointer to the entry that contains @offset byte address and don't change
+ * @node_ret and @parent_ret.
+ *
+ * If no such entry exists, return pointer to entry that ends before @offset
+ * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
+ */
+static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
+					             u64 offset,
+						     struct rb_node ***node_ret,
+						     struct rb_node **parent_ret)
+{
+	struct rb_root *root = &tree->state;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *prev = NULL;
+	struct tree_entry *entry;
+
+	while (*node) {
+		prev = *node;
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+
+		if (offset < entry->start)
+			node = &(*node)->rb_left;
+		else if (offset > entry->end)
+			node = &(*node)->rb_right;
+		else
+			return *node;
+	}
+
+	if (node_ret)
+		*node_ret = node;
+	if (parent_ret)
+		*parent_ret = prev;
+
+	/* Search neighbors until we find the first one past the end */
+	while (prev && offset > entry->end) {
+		prev = rb_next(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+
+	return prev;
+}
+
+/*
+ * Inexact rb-tree search, return the next entry if @offset is not found
+ */
+static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
+{
+	return tree_search_for_insert(tree, offset, NULL, NULL);
+}
+
+/**
+ * Search offset in the tree or fill neighbor rbtree node pointers.
+ *
+ * @tree:      the tree to search
+ * @offset:    offset that should fall within an entry in @tree
+ * @next_ret:  pointer to the first entry whose range ends after @offset
+ * @prev_ret:  pointer to the first entry whose range begins before @offset
+ *
+ * Return a pointer to the entry that contains @offset byte address. If no
+ * such entry exists, then return NULL and fill @prev_ret and @next_ret.
+ * Otherwise return the found entry and other pointers are left untouched.
+ */
+static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
+					     u64 offset,
+					     struct rb_node **prev_ret,
+					     struct rb_node **next_ret)
+{
+	struct rb_root *root = &tree->state;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *prev = NULL;
+	struct rb_node *orig_prev = NULL;
+	struct tree_entry *entry;
+
+	ASSERT(prev_ret);
+	ASSERT(next_ret);
+
+	while (*node) {
+		prev = *node;
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+
+		if (offset < entry->start)
+			node = &(*node)->rb_left;
+		else if (offset > entry->end)
+			node = &(*node)->rb_right;
+		else
+			return *node;
+	}
+
+	orig_prev = prev;
+	while (prev && offset > entry->end) {
+		prev = rb_next(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+	*next_ret = prev;
+	prev = orig_prev;
+
+	entry = rb_entry(prev, struct tree_entry, rb_node);
+	while (prev && offset < entry->start) {
+		prev = rb_prev(prev);
+		entry = rb_entry(prev, struct tree_entry, rb_node);
+	}
+	*prev_ret = prev;
+
+	return NULL;
+}
+
+/*
+ * utility function to look for merge candidates inside a given range.
+ * Any extents with matching state are merged together into a single
+ * extent in the tree.  Extents with EXTENT_IO in their state field
+ * are not merged because the end_io handlers need to be able to do
+ * operations on them without sleeping (or doing allocations/splits).
+ *
+ * This should be called with the tree lock held.
+ */
+static void merge_state(struct extent_io_tree *tree,
+		        struct extent_state *state)
+{
+	struct extent_state *other;
+	struct rb_node *other_node;
+
+	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+		return;
+
+	other_node = rb_prev(&state->rb_node);
+	if (other_node) {
+		other = rb_entry(other_node, struct extent_state, rb_node);
+		if (other->end == state->start - 1 &&
+		    other->state == state->state) {
+			if (tree->private_data &&
+			    is_data_inode(tree->private_data))
+				btrfs_merge_delalloc_extent(tree->private_data,
+							    state, other);
+			state->start = other->start;
+			rb_erase(&other->rb_node, &tree->state);
+			RB_CLEAR_NODE(&other->rb_node);
+			free_extent_state(other);
+		}
+	}
+	other_node = rb_next(&state->rb_node);
+	if (other_node) {
+		other = rb_entry(other_node, struct extent_state, rb_node);
+		if (other->start == state->end + 1 &&
+		    other->state == state->state) {
+			if (tree->private_data &&
+			    is_data_inode(tree->private_data))
+				btrfs_merge_delalloc_extent(tree->private_data,
+							    state, other);
+			state->end = other->end;
+			rb_erase(&other->rb_node, &tree->state);
+			RB_CLEAR_NODE(&other->rb_node);
+			free_extent_state(other);
+		}
+	}
+}
+
+static void set_state_bits(struct extent_io_tree *tree,
+			   struct extent_state *state, u32 bits,
+			   struct extent_changeset *changeset);
+
+/*
+ * insert an extent_state struct into the tree.  'bits' are set on the
+ * struct before it is inserted.
+ *
+ * This may return -EEXIST if the extent is already there, in which case the
+ * state struct is freed.
+ *
+ * The tree lock is not taken internally.  This is a utility function and
+ * probably isn't what you want to call (see set/clear_extent_bit).
+ */
+static int insert_state(struct extent_io_tree *tree,
+			struct extent_state *state,
+			u32 bits, struct extent_changeset *changeset)
+{
+	struct rb_node **node;
+	struct rb_node *parent;
+	const u64 end = state->end;
+
+	set_state_bits(tree, state, bits, changeset);
+
+	node = &tree->state.rb_node;
+	while (*node) {
+		struct tree_entry *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct tree_entry, rb_node);
+
+		if (end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			btrfs_err(tree->fs_info,
+			       "found node %llu %llu on insert of %llu %llu",
+			       entry->start, entry->end, state->start, end);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+
+	merge_state(tree, state);
+	return 0;
+}
+
+/*
+ * Insert state to @tree to the location given by @node and @parent.
+ */
+static void insert_state_fast(struct extent_io_tree *tree,
+			      struct extent_state *state, struct rb_node **node,
+			      struct rb_node *parent, unsigned bits,
+			      struct extent_changeset *changeset)
+{
+	set_state_bits(tree, state, bits, changeset);
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+	merge_state(tree, state);
+}
+
+/*
+ * split a given extent state struct in two, inserting the preallocated
+ * struct 'prealloc' as the newly created second half.  'split' indicates an
+ * offset inside 'orig' where it should be split.
+ *
+ * Before calling,
+ * the tree has 'orig' at [orig->start, orig->end].  After calling, there
+ * are two extent state structs in the tree:
+ * prealloc: [orig->start, split - 1]
+ * orig: [ split, orig->end ]
+ *
+ * The tree locks are not taken by this function. They need to be held
+ * by the caller.
+ */
+static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
+		       struct extent_state *prealloc, u64 split)
+{
+	struct rb_node *parent = NULL;
+	struct rb_node **node;
+
+	if (tree->private_data && is_data_inode(tree->private_data))
+		btrfs_split_delalloc_extent(tree->private_data, orig, split);
+
+	prealloc->start = orig->start;
+	prealloc->end = split - 1;
+	prealloc->state = orig->state;
+	orig->start = split;
+
+	parent = &orig->rb_node;
+	node = &parent;
+	while (*node) {
+		struct tree_entry *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct tree_entry, rb_node);
+
+		if (prealloc->end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (prealloc->end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			free_extent_state(prealloc);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&prealloc->rb_node, parent, node);
+	rb_insert_color(&prealloc->rb_node, &tree->state);
+
+	return 0;
+}
+
+static struct extent_state *next_state(struct extent_state *state)
+{
+	struct rb_node *next = rb_next(&state->rb_node);
+	if (next)
+		return rb_entry(next, struct extent_state, rb_node);
+	else
+		return NULL;
+}
+
+/*
+ * utility function to clear some bits in an extent state struct.
+ * it will optionally wake up anyone waiting on this state (wake == 1).
+ *
+ * If no bits are set on the state struct after clearing things, the
+ * struct is freed and removed from the tree
+ */
+static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
+					    struct extent_state *state,
+					    u32 bits, int wake,
+					    struct extent_changeset *changeset)
+{
+	struct extent_state *next;
+	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
+	int ret;
+
+	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
+		u64 range = state->end - state->start + 1;
+		WARN_ON(range > tree->dirty_bytes);
+		tree->dirty_bytes -= range;
+	}
+
+	if (tree->private_data && is_data_inode(tree->private_data))
+		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
+
+	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
+	BUG_ON(ret < 0);
+	state->state &= ~bits_to_clear;
+	if (wake)
+		wake_up(&state->wq);
+	if (state->state == 0) {
+		next = next_state(state);
+		if (extent_state_in_tree(state)) {
+			rb_erase(&state->rb_node, &tree->state);
+			RB_CLEAR_NODE(&state->rb_node);
+			free_extent_state(state);
+		} else {
+			WARN_ON(1);
+		}
+	} else {
+		merge_state(tree, state);
+		next = next_state(state);
+	}
+	return next;
+}
+
+static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
+{
+	btrfs_panic(tree->fs_info, err,
+	"locking error: extent tree was modified by another thread while locked");
+}
+
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
+static void set_state_bits(struct extent_io_tree *tree,
+			   struct extent_state *state,
+			   u32 bits, struct extent_changeset *changeset)
+{
+	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
+	int ret;
+
+	if (tree->private_data && is_data_inode(tree->private_data))
+		btrfs_set_delalloc_extent(tree->private_data, state, bits);
+
+	if ((bits_to_set & EXTENT_DIRTY) && !(state->state & EXTENT_DIRTY)) {
+		u64 range = state->end - state->start + 1;
+		tree->dirty_bytes += range;
+	}
+	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
+	BUG_ON(ret < 0);
+	state->state |= bits_to_set;
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
+/*
+ * either insert or lock state struct between start and end use mask to tell
+ * us if waiting is desired.
+ */
+int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+		     struct extent_state **cached_state)
+{
+	int err;
+	u64 failed_start;
+
+	while (1) {
+		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
+				     EXTENT_LOCKED, &failed_start,
+				     cached_state, GFP_NOFS, NULL);
+		if (err == -EEXIST) {
+			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
+			start = failed_start;
+		} else
+			break;
+		WARN_ON(start > end);
+	}
+	return err;
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
+/**
+ * Find the first range that has @bits not set. This range could start before
+ * @start.
+ *
+ * @tree:      the tree to search
+ * @start:     offset at/after which the found extent should start
+ * @start_ret: records the beginning of the range
+ * @end_ret:   records the end of the range (inclusive)
+ * @bits:      the set of bits which must be unset
+ *
+ * Since unallocated range is also considered one which doesn't have the bits
+ * set it's possible that @end_ret contains -1, this happens in case the range
+ * spans (last_range_end, end of device]. In this case it's up to the caller to
+ * trim @end_ret to the appropriate size.
+ */
+void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, u32 bits)
+{
+	struct extent_state *state;
+	struct rb_node *node, *prev = NULL, *next;
+
+	spin_lock(&tree->lock);
+
+	/* Find first extent with bits cleared */
+	while (1) {
+		node = tree_search_prev_next(tree, start, &prev, &next);
+		if (!node && !next && !prev) {
+			/*
+			 * Tree is completely empty, send full range and let
+			 * caller deal with it
+			 */
+			*start_ret = 0;
+			*end_ret = -1;
+			goto out;
+		} else if (!node && !next) {
+			/*
+			 * We are past the last allocated chunk, set start at
+			 * the end of the last extent.
+			 */
+			state = rb_entry(prev, struct extent_state, rb_node);
+			*start_ret = state->end + 1;
+			*end_ret = -1;
+			goto out;
+		} else if (!node) {
+			node = next;
+		}
+		/*
+		 * At this point 'node' either contains 'start' or start is
+		 * before 'node'
+		 */
+		state = rb_entry(node, struct extent_state, rb_node);
+
+		if (in_range(start, state->start, state->end - state->start + 1)) {
+			if (state->state & bits) {
+				/*
+				 * |--range with bits sets--|
+				 *    |
+				 *    start
+				 */
+				start = state->end + 1;
+			} else {
+				/*
+				 * 'start' falls within a range that doesn't
+				 * have the bits set, so take its start as
+				 * the beginning of the desired range
+				 *
+				 * |--range with bits cleared----|
+				 *      |
+				 *      start
+				 */
+				*start_ret = state->start;
+				break;
+			}
+		} else {
+			/*
+			 * |---prev range---|---hole/unset---|---node range---|
+			 *                          |
+			 *                        start
+			 *
+			 *                        or
+			 *
+			 * |---hole/unset--||--first node--|
+			 * 0   |
+			 *    start
+			 */
+			if (prev) {
+				state = rb_entry(prev, struct extent_state,
+						 rb_node);
+				*start_ret = state->end + 1;
+			} else {
+				*start_ret = 0;
+			}
+			break;
+		}
+	}
+
+	/*
+	 * Find the longest stretch from start until an entry which has the
+	 * bits set
+	 */
+	while (1) {
+		state = rb_entry(node, struct extent_state, rb_node);
+		if (state->end >= start && !(state->state & bits)) {
+			*end_ret = state->end;
+		} else {
+			*end_ret = state->start - 1;
+			break;
+		}
+
+		node = rb_next(node);
+		if (!node)
+			break;
+	}
+out:
+	spin_unlock(&tree->lock);
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
 void __cold extent_state_free_cachep(void)
 {
 	btrfs_extent_state_leak_debug_check();
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5bfa14f2b5e3..c38d31b8b18f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -80,37 +80,11 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
-
-#define btrfs_debug_check_extent_io_range(tree, start, end)		\
-	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
-static inline void __btrfs_debug_check_extent_io_range(const char *caller,
-		struct extent_io_tree *tree, u64 start, u64 end)
-{
-	struct inode *inode = tree->private_data;
-	u64 isize;
-
-	if (!inode || !is_data_inode(inode))
-		return;
-
-	isize = i_size_read(inode);
-	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
-		btrfs_debug_rl(BTRFS_I(inode)->root->fs_info,
-		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
-			caller, btrfs_ino(BTRFS_I(inode)), isize, start, end);
-	}
-}
 #else
 #define btrfs_leak_debug_add_eb(eb)			do {} while (0)
 #define btrfs_leak_debug_del_eb(eb)			do {} while (0)
-#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
-struct tree_entry {
-	u64 start;
-	u64 end;
-	struct rb_node rb_node;
-};
-
 /*
  * Structure to record info about the bio being assembled, and other info like
  * how many bytes are there before stripe/ordered extent boundary.
@@ -126,1184 +100,85 @@ struct btrfs_bio_ctrl {
 struct extent_page_data {
 	struct btrfs_bio_ctrl bio_ctrl;
 	/* tells writepage not to lock the state bits for this range
-	 * it still does the unlocking
-	 */
-	unsigned int extent_locked:1;
-
-	/* tells the submit_bio code to use REQ_SYNC */
-	unsigned int sync_io:1;
-};
-
-static int add_extent_changeset(struct extent_state *state, u32 bits,
-				 struct extent_changeset *changeset,
-				 int set)
-{
-	int ret;
-
-	if (!changeset)
-		return 0;
-	if (set && (state->state & bits) == bits)
-		return 0;
-	if (!set && (state->state & bits) == 0)
-		return 0;
-	changeset->bytes_changed += state->end - state->start + 1;
-	ret = ulist_add(&changeset->range_changed, state->start, state->end,
-			GFP_ATOMIC);
-	return ret;
-}
-
-static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
-{
-	struct bio *bio;
-	struct bio_vec *bv;
-	struct inode *inode;
-	int mirror_num;
-
-	if (!bio_ctrl->bio)
-		return;
-
-	bio = bio_ctrl->bio;
-	bv = bio_first_bvec_all(bio);
-	inode = bv->bv_page->mapping->host;
-	mirror_num = bio_ctrl->mirror_num;
-
-	/* Caller should ensure the bio has at least some range added */
-	ASSERT(bio->bi_iter.bi_size);
-
-	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
-
-	if (!is_data_inode(inode))
-		btrfs_submit_metadata_bio(inode, bio, mirror_num);
-	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_submit_data_write_bio(inode, bio, mirror_num);
-	else
-		btrfs_submit_data_read_bio(inode, bio, mirror_num,
-					   bio_ctrl->compress_type);
-
-	/* The bio is owned by the end_io handler now */
-	bio_ctrl->bio = NULL;
-}
-
-/*
- * Submit or fail the current bio in an extent_page_data structure.
- */
-static void submit_write_bio(struct extent_page_data *epd, int ret)
-{
-	struct bio *bio = epd->bio_ctrl.bio;
-
-	if (!bio)
-		return;
-
-	if (ret) {
-		ASSERT(ret < 0);
-		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
-		/* The bio is owned by the end_io handler now */
-		epd->bio_ctrl.bio = NULL;
-	} else {
-		submit_one_bio(&epd->bio_ctrl);
-	}
-}
-
-int __init extent_buffer_init_cachep(void)
-{
-	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!extent_buffer_cache)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void __cold extent_buffer_free_cachep(void)
-{
-	/*
-	 * Make sure all delayed rcu free are flushed before we
-	 * destroy caches.
-	 */
-	rcu_barrier();
-	kmem_cache_destroy(extent_buffer_cache);
-}
-
-/**
- * Search @tree for an entry that contains @offset. Such entry would have
- * entry->start <= offset && entry->end >= offset.
- *
- * @tree:       the tree to search
- * @offset:     offset that should fall within an entry in @tree
- * @node_ret:   pointer where new node should be anchored (used when inserting an
- *	        entry in the tree)
- * @parent_ret: points to entry which would have been the parent of the entry,
- *               containing @offset
- *
- * Return a pointer to the entry that contains @offset byte address and don't change
- * @node_ret and @parent_ret.
- *
- * If no such entry exists, return pointer to entry that ends before @offset
- * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
- */
-static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
-					             u64 offset,
-						     struct rb_node ***node_ret,
-						     struct rb_node **parent_ret)
-{
-	struct rb_root *root = &tree->state;
-	struct rb_node **node = &root->rb_node;
-	struct rb_node *prev = NULL;
-	struct tree_entry *entry;
-
-	while (*node) {
-		prev = *node;
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-
-		if (offset < entry->start)
-			node = &(*node)->rb_left;
-		else if (offset > entry->end)
-			node = &(*node)->rb_right;
-		else
-			return *node;
-	}
-
-	if (node_ret)
-		*node_ret = node;
-	if (parent_ret)
-		*parent_ret = prev;
-
-	/* Search neighbors until we find the first one past the end */
-	while (prev && offset > entry->end) {
-		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-	}
-
-	return prev;
-}
-
-/*
- * Inexact rb-tree search, return the next entry if @offset is not found
- */
-static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
-{
-	return tree_search_for_insert(tree, offset, NULL, NULL);
-}
-
-/**
- * Search offset in the tree or fill neighbor rbtree node pointers.
- *
- * @tree:      the tree to search
- * @offset:    offset that should fall within an entry in @tree
- * @next_ret:  pointer to the first entry whose range ends after @offset
- * @prev_ret:  pointer to the first entry whose range begins before @offset
- *
- * Return a pointer to the entry that contains @offset byte address. If no
- * such entry exists, then return NULL and fill @prev_ret and @next_ret.
- * Otherwise return the found entry and other pointers are left untouched.
- */
-static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
-					     u64 offset,
-					     struct rb_node **prev_ret,
-					     struct rb_node **next_ret)
-{
-	struct rb_root *root = &tree->state;
-	struct rb_node **node = &root->rb_node;
-	struct rb_node *prev = NULL;
-	struct rb_node *orig_prev = NULL;
-	struct tree_entry *entry;
-
-	ASSERT(prev_ret);
-	ASSERT(next_ret);
-
-	while (*node) {
-		prev = *node;
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-
-		if (offset < entry->start)
-			node = &(*node)->rb_left;
-		else if (offset > entry->end)
-			node = &(*node)->rb_right;
-		else
-			return *node;
-	}
-
-	orig_prev = prev;
-	while (prev && offset > entry->end) {
-		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-	}
-	*next_ret = prev;
-	prev = orig_prev;
-
-	entry = rb_entry(prev, struct tree_entry, rb_node);
-	while (prev && offset < entry->start) {
-		prev = rb_prev(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
-	}
-	*prev_ret = prev;
-
-	return NULL;
-}
-
-/*
- * utility function to look for merge candidates inside a given range.
- * Any extents with matching state are merged together into a single
- * extent in the tree.  Extents with EXTENT_IO in their state field
- * are not merged because the end_io handlers need to be able to do
- * operations on them without sleeping (or doing allocations/splits).
- *
- * This should be called with the tree lock held.
- */
-static void merge_state(struct extent_io_tree *tree,
-		        struct extent_state *state)
-{
-	struct extent_state *other;
-	struct rb_node *other_node;
-
-	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
-		return;
-
-	other_node = rb_prev(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->end == state->start - 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->start = other->start;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
-	}
-	other_node = rb_next(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->start == state->end + 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->end = other->end;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
-	}
-}
-
-static void set_state_bits(struct extent_io_tree *tree,
-			   struct extent_state *state, u32 bits,
-			   struct extent_changeset *changeset);
-
-/*
- * insert an extent_state struct into the tree.  'bits' are set on the
- * struct before it is inserted.
- *
- * This may return -EEXIST if the extent is already there, in which case the
- * state struct is freed.
- *
- * The tree lock is not taken internally.  This is a utility function and
- * probably isn't what you want to call (see set/clear_extent_bit).
- */
-static int insert_state(struct extent_io_tree *tree,
-			struct extent_state *state,
-			u32 bits, struct extent_changeset *changeset)
-{
-	struct rb_node **node;
-	struct rb_node *parent;
-	const u64 end = state->end;
-
-	set_state_bits(tree, state, bits, changeset);
-
-	node = &tree->state.rb_node;
-	while (*node) {
-		struct tree_entry *entry;
-
-		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
-
-		if (end < entry->start) {
-			node = &(*node)->rb_left;
-		} else if (end > entry->end) {
-			node = &(*node)->rb_right;
-		} else {
-			btrfs_err(tree->fs_info,
-			       "found node %llu %llu on insert of %llu %llu",
-			       entry->start, entry->end, state->start, end);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&state->rb_node, parent, node);
-	rb_insert_color(&state->rb_node, &tree->state);
-
-	merge_state(tree, state);
-	return 0;
-}
-
-/*
- * Insert state to @tree to the location given by @node and @parent.
- */
-static void insert_state_fast(struct extent_io_tree *tree,
-			      struct extent_state *state, struct rb_node **node,
-			      struct rb_node *parent, unsigned bits,
-			      struct extent_changeset *changeset)
-{
-	set_state_bits(tree, state, bits, changeset);
-	rb_link_node(&state->rb_node, parent, node);
-	rb_insert_color(&state->rb_node, &tree->state);
-	merge_state(tree, state);
-}
-
-/*
- * split a given extent state struct in two, inserting the preallocated
- * struct 'prealloc' as the newly created second half.  'split' indicates an
- * offset inside 'orig' where it should be split.
- *
- * Before calling,
- * the tree has 'orig' at [orig->start, orig->end].  After calling, there
- * are two extent state structs in the tree:
- * prealloc: [orig->start, split - 1]
- * orig: [ split, orig->end ]
- *
- * The tree locks are not taken by this function. They need to be held
- * by the caller.
- */
-static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
-		       struct extent_state *prealloc, u64 split)
-{
-	struct rb_node *parent = NULL;
-	struct rb_node **node;
-
-	if (tree->private_data && is_data_inode(tree->private_data))
-		btrfs_split_delalloc_extent(tree->private_data, orig, split);
-
-	prealloc->start = orig->start;
-	prealloc->end = split - 1;
-	prealloc->state = orig->state;
-	orig->start = split;
-
-	parent = &orig->rb_node;
-	node = &parent;
-	while (*node) {
-		struct tree_entry *entry;
-
-		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
-
-		if (prealloc->end < entry->start) {
-			node = &(*node)->rb_left;
-		} else if (prealloc->end > entry->end) {
-			node = &(*node)->rb_right;
-		} else {
-			free_extent_state(prealloc);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&prealloc->rb_node, parent, node);
-	rb_insert_color(&prealloc->rb_node, &tree->state);
-
-	return 0;
-}
-
-static struct extent_state *next_state(struct extent_state *state)
-{
-	struct rb_node *next = rb_next(&state->rb_node);
-	if (next)
-		return rb_entry(next, struct extent_state, rb_node);
-	else
-		return NULL;
-}
-
-/*
- * utility function to clear some bits in an extent state struct.
- * it will optionally wake up anyone waiting on this state (wake == 1).
- *
- * If no bits are set on the state struct after clearing things, the
- * struct is freed and removed from the tree
- */
-static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
-					    struct extent_state *state,
-					    u32 bits, int wake,
-					    struct extent_changeset *changeset)
-{
-	struct extent_state *next;
-	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
-	int ret;
-
-	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		WARN_ON(range > tree->dirty_bytes);
-		tree->dirty_bytes -= range;
-	}
-
-	if (tree->private_data && is_data_inode(tree->private_data))
-		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
-
-	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
-	BUG_ON(ret < 0);
-	state->state &= ~bits_to_clear;
-	if (wake)
-		wake_up(&state->wq);
-	if (state->state == 0) {
-		next = next_state(state);
-		if (extent_state_in_tree(state)) {
-			rb_erase(&state->rb_node, &tree->state);
-			RB_CLEAR_NODE(&state->rb_node);
-			free_extent_state(state);
-		} else {
-			WARN_ON(1);
-		}
-	} else {
-		merge_state(tree, state);
-		next = next_state(state);
-	}
-	return next;
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
-static void set_state_bits(struct extent_io_tree *tree,
-			   struct extent_state *state,
-			   u32 bits, struct extent_changeset *changeset)
-{
-	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
-	int ret;
-
-	if (tree->private_data && is_data_inode(tree->private_data))
-		btrfs_set_delalloc_extent(tree->private_data, state, bits);
-
-	if ((bits_to_set & EXTENT_DIRTY) && !(state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		tree->dirty_bytes += range;
-	}
-	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
-	BUG_ON(ret < 0);
-	state->state |= bits_to_set;
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
+	 * it still does the unlocking
 	 */
-	if (state->start > start) {
-		u64 this_end;
-		if (end < last_start)
-			this_end = end;
-		else
-			this_end = last_start - 1;
+	unsigned int extent_locked:1;
 
-		prealloc = alloc_extent_state_atomic(prealloc);
-		if (!prealloc) {
-			err = -ENOMEM;
-			goto out;
-		}
+	/* tells the submit_bio code to use REQ_SYNC */
+	unsigned int sync_io:1;
+};
 
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
+static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
+{
+	struct bio *bio;
+	struct bio_vec *bv;
+	struct inode *inode;
+	int mirror_num;
 
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
-			extent_io_tree_panic(tree, err);
+	if (!bio_ctrl->bio)
+		return;
 
-		set_state_bits(tree, prealloc, bits, NULL);
-		cache_state(prealloc, cached_state);
-		clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
-		prealloc = NULL;
-		goto out;
-	}
+	bio = bio_ctrl->bio;
+	bv = bio_first_bvec_all(bio);
+	inode = bv->bv_page->mapping->host;
+	mirror_num = bio_ctrl->mirror_num;
 
-search_again:
-	if (start > end)
-		goto out;
-	spin_unlock(&tree->lock);
-	cond_resched();
-	first_iteration = false;
-	goto again;
+	/* Caller should ensure the bio has at least some range added */
+	ASSERT(bio->bi_iter.bi_size);
 
-out:
-	spin_unlock(&tree->lock);
-	if (prealloc)
-		free_extent_state(prealloc);
+	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
-	return err;
+	if (!is_data_inode(inode))
+		btrfs_submit_metadata_bio(inode, bio, mirror_num);
+	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_submit_data_write_bio(inode, bio, mirror_num);
+	else
+		btrfs_submit_data_read_bio(inode, bio, mirror_num,
+					   bio_ctrl->compress_type);
+
+	/* The bio is owned by the end_io handler now */
+	bio_ctrl->bio = NULL;
 }
 
 /*
- * either insert or lock state struct between start and end use mask to tell
- * us if waiting is desired.
+ * Submit or fail the current bio in an extent_page_data structure.
  */
-int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		     struct extent_state **cached_state)
+static void submit_write_bio(struct extent_page_data *epd, int ret)
 {
-	int err;
-	u64 failed_start;
+	struct bio *bio = epd->bio_ctrl.bio;
 
-	while (1) {
-		err = set_extent_bit(tree, start, end, EXTENT_LOCKED,
-				     EXTENT_LOCKED, &failed_start,
-				     cached_state, GFP_NOFS, NULL);
-		if (err == -EEXIST) {
-			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
-			start = failed_start;
-		} else
-			break;
-		WARN_ON(start > end);
+	if (!bio)
+		return;
+
+	if (ret) {
+		ASSERT(ret < 0);
+		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
+		/* The bio is owned by the end_io handler now */
+		epd->bio_ctrl.bio = NULL;
+	} else {
+		submit_one_bio(&epd->bio_ctrl);
 	}
-	return err;
+}
+
+int __init extent_buffer_init_cachep(void)
+{
+	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
+			sizeof(struct extent_buffer), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!extent_buffer_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void __cold extent_buffer_free_cachep(void)
+{
+	/*
+	 * Make sure all delayed rcu free are flushed before we
+	 * destroy caches.
+	 */
+	rcu_barrier();
+	kmem_cache_destroy(extent_buffer_cache);
 }
 
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
@@ -1337,295 +212,6 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
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
-/**
- * Find the first range that has @bits not set. This range could start before
- * @start.
- *
- * @tree:      the tree to search
- * @start:     offset at/after which the found extent should start
- * @start_ret: records the beginning of the range
- * @end_ret:   records the end of the range (inclusive)
- * @bits:      the set of bits which must be unset
- *
- * Since unallocated range is also considered one which doesn't have the bits
- * set it's possible that @end_ret contains -1, this happens in case the range
- * spans (last_range_end, end of device]. In this case it's up to the caller to
- * trim @end_ret to the appropriate size.
- */
-void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
-				 u64 *start_ret, u64 *end_ret, u32 bits)
-{
-	struct extent_state *state;
-	struct rb_node *node, *prev = NULL, *next;
-
-	spin_lock(&tree->lock);
-
-	/* Find first extent with bits cleared */
-	while (1) {
-		node = tree_search_prev_next(tree, start, &prev, &next);
-		if (!node && !next && !prev) {
-			/*
-			 * Tree is completely empty, send full range and let
-			 * caller deal with it
-			 */
-			*start_ret = 0;
-			*end_ret = -1;
-			goto out;
-		} else if (!node && !next) {
-			/*
-			 * We are past the last allocated chunk, set start at
-			 * the end of the last extent.
-			 */
-			state = rb_entry(prev, struct extent_state, rb_node);
-			*start_ret = state->end + 1;
-			*end_ret = -1;
-			goto out;
-		} else if (!node) {
-			node = next;
-		}
-		/*
-		 * At this point 'node' either contains 'start' or start is
-		 * before 'node'
-		 */
-		state = rb_entry(node, struct extent_state, rb_node);
-
-		if (in_range(start, state->start, state->end - state->start + 1)) {
-			if (state->state & bits) {
-				/*
-				 * |--range with bits sets--|
-				 *    |
-				 *    start
-				 */
-				start = state->end + 1;
-			} else {
-				/*
-				 * 'start' falls within a range that doesn't
-				 * have the bits set, so take its start as
-				 * the beginning of the desired range
-				 *
-				 * |--range with bits cleared----|
-				 *      |
-				 *      start
-				 */
-				*start_ret = state->start;
-				break;
-			}
-		} else {
-			/*
-			 * |---prev range---|---hole/unset---|---node range---|
-			 *                          |
-			 *                        start
-			 *
-			 *                        or
-			 *
-			 * |---hole/unset--||--first node--|
-			 * 0   |
-			 *    start
-			 */
-			if (prev) {
-				state = rb_entry(prev, struct extent_state,
-						 rb_node);
-				*start_ret = state->end + 1;
-			} else {
-				*start_ret = 0;
-			}
-			break;
-		}
-	}
-
-	/*
-	 * Find the longest stretch from start until an entry which has the
-	 * bits set
-	 */
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
-		if (state->end >= start && !(state->state & bits)) {
-			*end_ret = state->end;
-		} else {
-			*end_ret = state->start - 1;
-			break;
-		}
-
-		node = rb_next(node);
-		if (!node)
-			break;
-	}
-out:
-	spin_unlock(&tree->lock);
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
@@ -1907,66 +493,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -1994,62 +520,6 @@ static struct io_failure_record *get_failrec(struct btrfs_inode *inode,
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

