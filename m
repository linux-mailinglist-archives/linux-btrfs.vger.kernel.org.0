Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA1187AF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCQIMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:42910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQIMt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 110A2ADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 28/39] btrfs: Rename handle_one_tree_block() to backref_cache_add_one_tree_block() and move it to backref.c
Date:   Tue, 17 Mar 2020 16:11:14 +0800
Message-Id: <20200317081125.36289-29-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is the major part of backref cache build process, move it
to backref.c so we can reuse it later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 356 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |   6 +
 fs/btrfs/relocation.c | 362 +-----------------------------------------
 3 files changed, 366 insertions(+), 358 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 32af6f17d230..013e833bf5bc 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -13,6 +13,7 @@
 #include "transaction.h"
 #include "delayed-ref.h"
 #include "locking.h"
+#include "misc.h"
 
 /* Just an arbitrary number so we can be sure this happened */
 #define BACKREF_FOUND_SHARED 6
@@ -2582,3 +2583,358 @@ void backref_cache_release(struct backref_cache *cache)
 	ASSERT(!cache->nr_nodes);
 	ASSERT(!cache->nr_edges);
 }
+
+/*
+ * Handle direct tree backref.
+ *
+ * Direct tree backref means, the backref item shows its parent bytenr
+ * directly. This is for SHARED_BLOCK_REF backref (keyed or inlined).
+ *
+ * @ref_key:	The converted backref key.
+ * 		For keyed backref, it's the item key.
+ * 		For inlined backref, objectid is the bytenr,
+ * 		type is btrfs_inline_ref_type, offset is
+ * 		btrfs_inline_ref_offset.
+ */
+static int handle_direct_tree_backref(struct backref_cache *cache,
+				      struct btrfs_key *ref_key,
+				      struct backref_node *cur)
+{
+	struct backref_edge *edge;
+	struct backref_node *upper;
+	struct rb_node *rb_node;
+
+	ASSERT(ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY);
+
+	/* Only reloc root uses backref pointing to itself */
+	if (ref_key->objectid == ref_key->offset) {
+		struct btrfs_root *root;
+
+		cur->is_reloc_root = 1;
+		/* Only reloc backref cache cares exact root */
+		if (cache->is_reloc) {
+			root = find_reloc_root(cache->fs_info, cur->bytenr);
+			if (WARN_ON(!root))
+				return -ENOENT;
+			cur->root = root;
+		} else {
+			/*
+			 * For generic purpose backref cache, reloc root node
+			 * is useless.
+			 */
+			list_add(&cur->list, &cache->useless_node);
+		}
+		return 0;
+	}
+
+	edge = alloc_backref_edge(cache);
+	if (!edge)
+		return -ENOMEM;
+
+	rb_node = simple_search(&cache->rb_root, ref_key->offset);
+	if (!rb_node) {
+		/* Parent node not yet cached */
+		upper = alloc_backref_node(cache, ref_key->offset,
+					   cur->level + 1);
+		if (!upper) {
+			free_backref_edge(cache, edge);
+			return -ENOMEM;
+		}
+
+		/*
+		 *  backrefs for the upper level block isn't
+		 *  cached, add the block to pending list
+		 */
+		list_add_tail(&edge->list[UPPER], &cache->pending_edge);
+	} else {
+		/* Parent node already cached */
+		upper = rb_entry(rb_node, struct backref_node,
+				 rb_node);
+		ASSERT(upper->checked);
+		INIT_LIST_HEAD(&edge->list[UPPER]);
+	}
+	link_backref_edge(edge, cur, upper, LINK_LOWER);
+	return 0;
+}
+
+/*
+ * Handle indirect tree backref.
+ *
+ * Indirect tree backref means, we only know which tree the node belongs to.
+ * Need to do a tree search to find out parents. This is for TREE_BLOCK_REF
+ * backref (keyed or inlined).
+ *
+ * @ref_key:	The same as @ref_key in  handle_direct_tree_backref()
+ * @tree_key:	The first key of this tree block.
+ * @path:	A clean (released) path, to avoid allocating path everytime
+ * 		the function get called.
+ */
+static int handle_indirect_tree_backref(struct backref_cache *cache,
+					struct btrfs_path *path,
+					struct btrfs_key *ref_key,
+					struct btrfs_key *tree_key,
+					struct backref_node *cur)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct backref_node *upper;
+	struct backref_node *lower;
+	struct backref_edge *edge;
+	struct extent_buffer *eb;
+	struct btrfs_root *root;
+	struct btrfs_key root_key;
+	struct rb_node *rb_node;
+	int level;
+	bool need_check = true;
+	int ret;
+
+	root_key.objectid = ref_key->offset;
+	root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root_key.offset = (u64)-1;
+	root = btrfs_get_fs_root(fs_info, &root_key, false);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+		cur->cowonly = 1;
+
+	if (btrfs_root_level(&root->root_item) == cur->level) {
+		/* tree root */
+		ASSERT(btrfs_root_bytenr(&root->root_item) ==
+		       cur->bytenr);
+		if (should_ignore_reloc_root(root)) {
+			btrfs_put_root(root);
+			list_add(&cur->list, &cache->useless_node);
+		} else {
+			cur->root = root;
+		}
+		return 0;
+	}
+
+	level = cur->level + 1;
+
+	/* Search the tree to find parent blocks referring the block. */
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+	path->lowest_level = level;
+	ret = btrfs_search_slot(NULL, root, tree_key, path, 0, 0);
+	path->lowest_level = 0;
+	if (ret < 0) {
+		btrfs_put_root(root);
+		return ret;
+	}
+	if (ret > 0 && path->slots[level] > 0)
+		path->slots[level]--;
+
+	eb = path->nodes[level];
+	if (btrfs_node_blockptr(eb, path->slots[level]) != cur->bytenr) {
+		btrfs_err(fs_info,
+"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
+			  cur->bytenr, level - 1, root->root_key.objectid,
+			  tree_key->objectid, tree_key->type, tree_key->offset);
+		btrfs_put_root(root);
+		ret = -ENOENT;
+		goto out;
+	}
+	lower = cur;
+
+	/* Add all nodes and edges in the path */
+	for (; level < BTRFS_MAX_LEVEL; level++) {
+		if (!path->nodes[level]) {
+			ASSERT(btrfs_root_bytenr(&root->root_item) ==
+			       lower->bytenr);
+			if (should_ignore_reloc_root(root)) {
+				btrfs_put_root(root);
+				list_add(&lower->list, &cache->useless_node);
+			} else {
+				lower->root = root;
+			}
+			break;
+		}
+
+		edge = alloc_backref_edge(cache);
+		if (!edge) {
+			btrfs_put_root(root);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		eb = path->nodes[level];
+		rb_node = simple_search(&cache->rb_root, eb->start);
+		if (!rb_node) {
+			upper = alloc_backref_node(cache, eb->start,
+						   lower->level + 1);
+			if (!upper) {
+				btrfs_put_root(root);
+				free_backref_edge(cache, edge);
+				ret = -ENOMEM;
+				goto out;
+			}
+			upper->owner = btrfs_header_owner(eb);
+			if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+				upper->cowonly = 1;
+
+			/*
+			 * if we know the block isn't shared we can void
+			 * checking its backrefs.
+			 */
+			if (btrfs_block_can_be_shared(root, eb))
+				upper->checked = 0;
+			else
+				upper->checked = 1;
+
+			/*
+			 * add the block to pending list if we need check its
+			 * backrefs, we only do this once while walking up a
+			 * tree as we will catch anything else later on.
+			 */
+			if (!upper->checked && need_check) {
+				need_check = false;
+				list_add_tail(&edge->list[UPPER],
+					      &cache->pending_edge);
+			} else {
+				if (upper->checked)
+					need_check = true;
+				INIT_LIST_HEAD(&edge->list[UPPER]);
+			}
+		} else {
+			upper = rb_entry(rb_node, struct backref_node, rb_node);
+			ASSERT(upper->checked);
+			INIT_LIST_HEAD(&edge->list[UPPER]);
+			if (!upper->owner)
+				upper->owner = btrfs_header_owner(eb);
+		}
+		link_backref_edge(edge, lower, upper, LINK_LOWER);
+
+		if (rb_node) {
+			btrfs_put_root(root);
+			break;
+		}
+		lower = upper;
+		upper = NULL;
+	}
+out:
+	btrfs_release_path(path);
+	return ret;
+}
+
+int backref_cache_add_tree_block(struct backref_cache *cache,
+				 struct btrfs_path *path,
+				 struct btrfs_backref_iter *iter,
+				 struct btrfs_key *node_key,
+				 struct backref_node *cur)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+ 	struct backref_edge *edge;
+	struct backref_node *exist;
+ 	int ret;
+
+ 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
+	if (ret < 0)
+		return ret;
+	/*
+	 * We skip the first btrfs_tree_block_info, as we don't use the key
+	 * stored in it, but fetch it from the tree block.
+	 */
+	if (btrfs_backref_has_tree_block_info(iter)) {
+		ret = btrfs_backref_iter_next(iter);
+		if (ret < 0)
+			goto out;
+		/* No extra backref? This means the tree block is corrupted */
+		if (ret > 0) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+	WARN_ON(cur->checked);
+	if (!list_empty(&cur->upper)) {
+		/*
+		 * the backref was added previously when processing
+		 * backref of type BTRFS_TREE_BLOCK_REF_KEY
+		 */
+		ASSERT(list_is_singular(&cur->upper));
+		edge = list_entry(cur->upper.next, struct backref_edge,
+				  list[LOWER]);
+		ASSERT(list_empty(&edge->list[UPPER]));
+		exist = edge->node[UPPER];
+		/*
+		 * add the upper level block to pending list if we need
+		 * check its backrefs
+		 */
+		if (!exist->checked)
+			list_add_tail(&edge->list[UPPER], &cache->pending_edge);
+	} else {
+		exist = NULL;
+	}
+
+	for (; ret == 0; ret = btrfs_backref_iter_next(iter)) {
+		struct extent_buffer *eb;
+		struct btrfs_key key;
+		int type;
+
+		cond_resched();
+		eb = btrfs_backref_get_eb(iter);
+
+		key.objectid = iter->bytenr;
+		if (btrfs_backref_iter_is_inline_ref(iter)) {
+			struct btrfs_extent_inline_ref *iref;
+
+			/* update key for inline back ref */
+			iref = (struct btrfs_extent_inline_ref *)
+				((unsigned long)iter->cur_ptr);
+			type = btrfs_get_extent_inline_ref_type(eb, iref,
+							BTRFS_REF_TYPE_BLOCK);
+			if (type == BTRFS_REF_TYPE_INVALID) {
+				ret = -EUCLEAN;
+				goto out;
+			}
+			key.type = type;
+			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
+		} else {
+			key.type = iter->cur_key.type;
+			key.offset = iter->cur_key.offset;
+		}
+
+		/*
+		 * Parent node found and matches current inline ref, no need to
+		 * rebuild this node for this inline ref.
+		 */
+		if (exist &&
+		    ((key.type == BTRFS_TREE_BLOCK_REF_KEY &&
+		      exist->owner == key.offset) ||
+		     (key.type == BTRFS_SHARED_BLOCK_REF_KEY &&
+		      exist->bytenr == key.offset))) {
+			exist = NULL;
+			continue;
+		}
+
+		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
+		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
+			ret = handle_direct_tree_backref(cache, &key, cur);
+			if (ret < 0)
+				goto out;
+			continue;
+		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
+			ret = -EINVAL;
+			btrfs_print_v0_err(fs_info);
+			btrfs_handle_fs_error(fs_info, ret, NULL);
+			goto out;
+		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
+			continue;
+		}
+
+		/*
+		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
+		 * means the root objectid. We need to search the tree to get
+		 * its parent bytenr.
+		 */
+		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
+						   cur);
+		if (ret < 0)
+			goto out;
+	}
+	ret = 0;
+	cur->checked = 1;
+	WARN_ON(exist);
+out:
+	btrfs_backref_iter_release(iter);
+	return ret;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index bd5ba061e772..b17bc8d5411a 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -365,4 +365,10 @@ static inline void backref_cache_panic(struct btrfs_fs_info *fs_info,
 		    "Inconsistency in backref cache found at offset %llu",
 		    bytenr);
 }
+
+int backref_cache_add_tree_block(struct backref_cache *cache,
+				 struct btrfs_path *path,
+				 struct btrfs_backref_iter *iter,
+				 struct btrfs_key *node_key,
+				 struct backref_node *cur);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4026de5e36e3..d133a7df90cf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -384,363 +384,8 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * Handle direct tree backref.
- *
- * Direct tree backref means, the backref item shows its parent bytenr
- * directly. This is for SHARED_BLOCK_REF backref (keyed or inlined).
- *
- * @ref_key:	The converted backref key.
- * 		For keyed backref, it's the item key.
- * 		For inlined backref, objectid is the bytenr,
- * 		type is btrfs_inline_ref_type, offset is
- * 		btrfs_inline_ref_offset.
- */
-static int handle_direct_tree_backref(struct backref_cache *cache,
-				      struct btrfs_key *ref_key,
-				      struct backref_node *cur)
-{
-	struct backref_edge *edge;
-	struct backref_node *upper;
-	struct rb_node *rb_node;
-
-	ASSERT(ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY);
-
-	/* Only reloc root uses backref pointing to itself */
-	if (ref_key->objectid == ref_key->offset) {
-		struct btrfs_root *root;
-
-		cur->is_reloc_root = 1;
-		/* Only reloc backref cache cares exact root */
-		if (cache->is_reloc) {
-			root = find_reloc_root(cache->fs_info, cur->bytenr);
-			if (WARN_ON(!root))
-				return -ENOENT;
-			cur->root = root;
-		} else {
-			/*
-			 * For generic purpose backref cache, reloc root node
-			 * is useless.
-			 */
-			list_add(&cur->list, &cache->useless_node);
-		}
-		return 0;
-	}
-
-	edge = alloc_backref_edge(cache);
-	if (!edge)
-		return -ENOMEM;
-
-	rb_node = simple_search(&cache->rb_root, ref_key->offset);
-	if (!rb_node) {
-		/* Parent node not yet cached */
-		upper = alloc_backref_node(cache, ref_key->offset,
-					   cur->level + 1);
-		if (!upper) {
-			free_backref_edge(cache, edge);
-			return -ENOMEM;
-		}
-
-		/*
-		 *  backrefs for the upper level block isn't
-		 *  cached, add the block to pending list
-		 */
-		list_add_tail(&edge->list[UPPER], &cache->pending_edge);
-	} else {
-		/* Parent node already cached */
-		upper = rb_entry(rb_node, struct backref_node,
-				 rb_node);
-		ASSERT(upper->checked);
-		INIT_LIST_HEAD(&edge->list[UPPER]);
-	}
-	link_backref_edge(edge, cur, upper, LINK_LOWER);
-	return 0;
-}
-
-/*
- * Handle indirect tree backref.
- *
- * Indirect tree backref means, we only know which tree the node belongs to.
- * Need to do a tree search to find out parents. This is for TREE_BLOCK_REF
- * backref (keyed or inlined).
- *
- * @ref_key:	The same as @ref_key in  handle_direct_tree_backref()
- * @tree_key:	The first key of this tree block.
- * @path:	A clean (released) path, to avoid allocating path everytime
- * 		the function get called.
- */
-static int handle_indirect_tree_backref(struct backref_cache *cache,
-					struct btrfs_path *path,
-					struct btrfs_key *ref_key,
-					struct btrfs_key *tree_key,
-					struct backref_node *cur)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct backref_node *upper;
-	struct backref_node *lower;
-	struct backref_edge *edge;
-	struct extent_buffer *eb;
-	struct btrfs_root *root;
-	struct btrfs_key root_key;
-	struct rb_node *rb_node;
-	int level;
-	bool need_check = true;
-	int ret;
-
-	root_key.objectid = ref_key->offset;
-	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
-	root = btrfs_get_fs_root(fs_info, &root_key, false);
-	if (IS_ERR(root))
-		return PTR_ERR(root);
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
-		cur->cowonly = 1;
-
-	if (btrfs_root_level(&root->root_item) == cur->level) {
-		/* tree root */
-		ASSERT(btrfs_root_bytenr(&root->root_item) ==
-		       cur->bytenr);
-		if (should_ignore_reloc_root(root)) {
-			btrfs_put_root(root);
-			list_add(&cur->list, &cache->useless_node);
-		} else {
-			cur->root = root;
-		}
-		return 0;
-	}
-
-	level = cur->level + 1;
-
-	/* Search the tree to find parent blocks referring the block. */
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-	path->lowest_level = level;
-	ret = btrfs_search_slot(NULL, root, tree_key, path, 0, 0);
-	path->lowest_level = 0;
-	if (ret < 0) {
-		btrfs_put_root(root);
-		return ret;
-	}
-	if (ret > 0 && path->slots[level] > 0)
-		path->slots[level]--;
-
-	eb = path->nodes[level];
-	if (btrfs_node_blockptr(eb, path->slots[level]) != cur->bytenr) {
-		btrfs_err(fs_info,
-"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
-			  cur->bytenr, level - 1, root->root_key.objectid,
-			  tree_key->objectid, tree_key->type, tree_key->offset);
-		btrfs_put_root(root);
-		ret = -ENOENT;
-		goto out;
-	}
-	lower = cur;
-
-	/* Add all nodes and edges in the path */
-	for (; level < BTRFS_MAX_LEVEL; level++) {
-		if (!path->nodes[level]) {
-			ASSERT(btrfs_root_bytenr(&root->root_item) ==
-			       lower->bytenr);
-			if (should_ignore_reloc_root(root)) {
-				btrfs_put_root(root);
-				list_add(&lower->list, &cache->useless_node);
-			} else {
-				lower->root = root;
-			}
-			break;
-		}
-
-		edge = alloc_backref_edge(cache);
-		if (!edge) {
-			btrfs_put_root(root);
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		eb = path->nodes[level];
-		rb_node = simple_search(&cache->rb_root, eb->start);
-		if (!rb_node) {
-			upper = alloc_backref_node(cache, eb->start,
-						   lower->level + 1);
-			if (!upper) {
-				btrfs_put_root(root);
-				free_backref_edge(cache, edge);
-				ret = -ENOMEM;
-				goto out;
-			}
-			upper->owner = btrfs_header_owner(eb);
-			if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
-				upper->cowonly = 1;
-
-			/*
-			 * if we know the block isn't shared we can void
-			 * checking its backrefs.
-			 */
-			if (btrfs_block_can_be_shared(root, eb))
-				upper->checked = 0;
-			else
-				upper->checked = 1;
-
-			/*
-			 * add the block to pending list if we need check its
-			 * backrefs, we only do this once while walking up a
-			 * tree as we will catch anything else later on.
-			 */
-			if (!upper->checked && need_check) {
-				need_check = false;
-				list_add_tail(&edge->list[UPPER],
-					      &cache->pending_edge);
-			} else {
-				if (upper->checked)
-					need_check = true;
-				INIT_LIST_HEAD(&edge->list[UPPER]);
-			}
-		} else {
-			upper = rb_entry(rb_node, struct backref_node, rb_node);
-			ASSERT(upper->checked);
-			INIT_LIST_HEAD(&edge->list[UPPER]);
-			if (!upper->owner)
-				upper->owner = btrfs_header_owner(eb);
-		}
-		link_backref_edge(edge, lower, upper, LINK_LOWER);
-
-		if (rb_node) {
-			btrfs_put_root(root);
-			break;
-		}
-		lower = upper;
-		upper = NULL;
-	}
-out:
-	btrfs_release_path(path);
-	return ret;
-}
-
-static int handle_one_tree_block(struct backref_cache *cache,
-				 struct btrfs_path *path,
-				 struct btrfs_backref_iter *iter,
-				 struct btrfs_key *node_key,
-				 struct backref_node *cur)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
- 	struct backref_edge *edge;
-	struct backref_node *exist;
- 	int ret;
-
- 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
-	if (ret < 0)
-		return ret;
-	/*
-	 * We skip the first btrfs_tree_block_info, as we don't use the key
-	 * stored in it, but fetch it from the tree block.
-	 */
-	if (btrfs_backref_has_tree_block_info(iter)) {
-		ret = btrfs_backref_iter_next(iter);
-		if (ret < 0)
-			goto out;
-		/* No extra backref? This means the tree block is corrupted */
-		if (ret > 0) {
-			ret = -EUCLEAN;
-			goto out;
-		}
-	}
-	WARN_ON(cur->checked);
-	if (!list_empty(&cur->upper)) {
-		/*
-		 * the backref was added previously when processing
-		 * backref of type BTRFS_TREE_BLOCK_REF_KEY
-		 */
-		ASSERT(list_is_singular(&cur->upper));
-		edge = list_entry(cur->upper.next, struct backref_edge,
-				  list[LOWER]);
-		ASSERT(list_empty(&edge->list[UPPER]));
-		exist = edge->node[UPPER];
-		/*
-		 * add the upper level block to pending list if we need
-		 * check its backrefs
-		 */
-		if (!exist->checked)
-			list_add_tail(&edge->list[UPPER], &cache->pending_edge);
-	} else {
-		exist = NULL;
-	}
-
-	for (; ret == 0; ret = btrfs_backref_iter_next(iter)) {
-		struct extent_buffer *eb;
-		struct btrfs_key key;
-		int type;
-
-		cond_resched();
-		eb = btrfs_backref_get_eb(iter);
-
-		key.objectid = iter->bytenr;
-		if (btrfs_backref_iter_is_inline_ref(iter)) {
-			struct btrfs_extent_inline_ref *iref;
-
-			/* update key for inline back ref */
-			iref = (struct btrfs_extent_inline_ref *)
-				((unsigned long)iter->cur_ptr);
-			type = btrfs_get_extent_inline_ref_type(eb, iref,
-							BTRFS_REF_TYPE_BLOCK);
-			if (type == BTRFS_REF_TYPE_INVALID) {
-				ret = -EUCLEAN;
-				goto out;
-			}
-			key.type = type;
-			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
-		} else {
-			key.type = iter->cur_key.type;
-			key.offset = iter->cur_key.offset;
-		}
-
-		/*
-		 * Parent node found and matches current inline ref, no need to
-		 * rebuild this node for this inline ref.
-		 */
-		if (exist &&
-		    ((key.type == BTRFS_TREE_BLOCK_REF_KEY &&
-		      exist->owner == key.offset) ||
-		     (key.type == BTRFS_SHARED_BLOCK_REF_KEY &&
-		      exist->bytenr == key.offset))) {
-			exist = NULL;
-			continue;
-		}
-
-		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
-		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
-			ret = handle_direct_tree_backref(cache, &key, cur);
-			if (ret < 0)
-				goto out;
-			continue;
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			ret = -EINVAL;
-			btrfs_print_v0_err(fs_info);
-			btrfs_handle_fs_error(fs_info, ret, NULL);
-			goto out;
-		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
-			continue;
-		}
-
-		/*
-		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
-		 * means the root objectid. We need to search the tree to get
-		 * its parent bytenr.
-		 */
-		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
-						   cur);
-		if (ret < 0)
-			goto out;
-	}
-	ret = 0;
-	cur->checked = 1;
-	WARN_ON(exist);
-out:
-	btrfs_backref_iter_release(iter);
-	return ret;
-}
-
-/*
- * In handle_one_tree_backref(), we have only linked the lower node to the edge,
- * but the upper node hasn't been linked to the edge.
+ * In backref_cache_add_tree_block(), we have only linked the lower node to the
+ * edge, but the upper node hasn't been linked to the edge.
  * This means we can only iterate through backref_node::upper to reach parent
  * edges, but not through backref_node::lower to reach children edges.
  *
@@ -975,7 +620,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 	/* Breadth-first search to build backref cache */
 	do {
-		ret = handle_one_tree_block(cache, path, iter, node_key, cur);
+		ret = backref_cache_add_tree_block(cache, path, iter, node_key,
+						   cur);
 		if (ret < 0) {
 			err = ret;
 			goto out;
-- 
2.25.1

