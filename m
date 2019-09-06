Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A3ABE83
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405961AbfIFRQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 13:16:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404253AbfIFRQN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Sep 2019 13:16:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02F86AD4B
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2019 17:16:04 +0000 (UTC)
From:   Mark Fasheh <mfasheh@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 1/3] btrfs: Move backref cache code out of relocation.c
Date:   Fri,  6 Sep 2019 10:15:31 -0700
Message-Id: <20190906171533.618-2-mfasheh@suse.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190906171533.618-1-mfasheh@suse.com>
References: <20190906171533.618-1-mfasheh@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Mark Fasheh <mfasheh@suse.de>

No functional changes are made here, we simply move the backref cache out of
relocation.c and into it's own file, backref-cache.c.  We also add the
headers relocation.h and backref-cache.h.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/btrfs/Makefile        |    2 +-
 fs/btrfs/backref-cache.c |  883 ++++++++++++++++++++++++++++++++
 fs/btrfs/backref-cache.h |  113 +++++
 fs/btrfs/relocation.c    | 1027 +-------------------------------------
 fs/btrfs/relocation.h    |   85 ++++
 5 files changed, 1090 insertions(+), 1020 deletions(-)
 create mode 100644 fs/btrfs/backref-cache.c
 create mode 100644 fs/btrfs/backref-cache.h
 create mode 100644 fs/btrfs/relocation.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 76a843198bcb..197eed65e051 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o
+	   block-rsv.o delalloc-space.o backref-cache.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
new file mode 100644
index 000000000000..d0f6530f23b8
--- /dev/null
+++ b/fs/btrfs/backref-cache.c
@@ -0,0 +1,883 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2009 Oracle.  All rights reserved.
+ */
+#include <linux/sched.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
+#include <linux/blkdev.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+#include "ctree.h"
+#include "disk-io.h"
+#include "transaction.h"
+#include "volumes.h"
+#include "locking.h"
+#include "btrfs_inode.h"
+#include "async-thread.h"
+#include "free-space-cache.h"
+#include "inode-map.h"
+#include "qgroup.h"
+#include "print-tree.h"
+#include "relocation.h"
+
+#include "backref-cache.h"
+
+void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
+{
+
+	struct btrfs_fs_info *fs_info = NULL;
+	struct backref_node *bnode = rb_entry(rb_node, struct backref_node,
+					      rb_node);
+	if (bnode->root)
+		fs_info = bnode->root->fs_info;
+	btrfs_panic(fs_info, errno,
+		    "Inconsistency in backref cache found at offset %llu",
+		    bytenr);
+}
+
+void backref_cache_init(struct backref_cache *cache)
+{
+	int i;
+	cache->rb_root = RB_ROOT;
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
+		INIT_LIST_HEAD(&cache->pending[i]);
+	INIT_LIST_HEAD(&cache->changed);
+	INIT_LIST_HEAD(&cache->detached);
+	INIT_LIST_HEAD(&cache->leaves);
+}
+
+void backref_cache_cleanup(struct backref_cache *cache)
+{
+	struct backref_node *node;
+	int i;
+
+	while (!list_empty(&cache->detached)) {
+		node = list_entry(cache->detached.next,
+				  struct backref_node, list);
+		remove_backref_node(cache, node);
+	}
+
+	while (!list_empty(&cache->leaves)) {
+		node = list_entry(cache->leaves.next,
+				  struct backref_node, lower);
+		remove_backref_node(cache, node);
+	}
+
+	cache->last_trans = 0;
+
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
+		ASSERT(list_empty(&cache->pending[i]));
+	ASSERT(list_empty(&cache->changed));
+	ASSERT(list_empty(&cache->detached));
+	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
+	ASSERT(!cache->nr_nodes);
+	ASSERT(!cache->nr_edges);
+}
+
+struct backref_node *alloc_backref_node(struct backref_cache *cache)
+{
+	struct backref_node *node;
+
+	node = kzalloc(sizeof(*node), GFP_NOFS);
+	if (node) {
+		INIT_LIST_HEAD(&node->list);
+		INIT_LIST_HEAD(&node->upper);
+		INIT_LIST_HEAD(&node->lower);
+		RB_CLEAR_NODE(&node->rb_node);
+		cache->nr_nodes++;
+	}
+	return node;
+}
+
+void free_backref_node(struct backref_cache *cache, struct backref_node *node)
+{
+	if (node) {
+		cache->nr_nodes--;
+		kfree(node);
+	}
+}
+
+struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
+{
+	struct backref_edge *edge;
+
+	edge = kzalloc(sizeof(*edge), GFP_NOFS);
+	if (edge)
+		cache->nr_edges++;
+	return edge;
+}
+
+void free_backref_edge(struct backref_cache *cache, struct backref_edge *edge)
+{
+	if (edge) {
+		cache->nr_edges--;
+		kfree(edge);
+	}
+}
+
+
+void unlock_node_buffer(struct backref_node *node)
+{
+	if (node->locked) {
+		btrfs_tree_unlock(node->eb);
+		node->locked = 0;
+	}
+}
+
+void drop_node_buffer(struct backref_node *node)
+{
+	if (node->eb) {
+		unlock_node_buffer(node);
+		free_extent_buffer(node->eb);
+		node->eb = NULL;
+	}
+}
+
+static void drop_backref_node(struct backref_cache *tree,
+			      struct backref_node *node)
+{
+	BUG_ON(!list_empty(&node->upper));
+
+	drop_node_buffer(node);
+	list_del(&node->list);
+	list_del(&node->lower);
+	if (!RB_EMPTY_NODE(&node->rb_node))
+		rb_erase(&node->rb_node, &tree->rb_root);
+	free_backref_node(tree, node);
+}
+
+/*
+ * remove a backref node from the backref cache
+ */
+void remove_backref_node(struct backref_cache *cache, struct backref_node *node)
+{
+	struct backref_node *upper;
+	struct backref_edge *edge;
+
+	if (!node)
+		return;
+
+	BUG_ON(!node->lowest && !node->detached);
+	while (!list_empty(&node->upper)) {
+		edge = list_entry(node->upper.next, struct backref_edge,
+				  list[LOWER]);
+		upper = edge->node[UPPER];
+		list_del(&edge->list[LOWER]);
+		list_del(&edge->list[UPPER]);
+		free_backref_edge(cache, edge);
+
+		if (RB_EMPTY_NODE(&upper->rb_node)) {
+			BUG_ON(!list_empty(&node->upper));
+			drop_backref_node(cache, node);
+			node = upper;
+			node->lowest = 1;
+			continue;
+		}
+		/*
+		 * add the node to leaf node list if no other
+		 * child block cached.
+		 */
+		if (list_empty(&upper->lower)) {
+			list_add_tail(&upper->lower, &cache->leaves);
+			upper->lowest = 1;
+		}
+	}
+
+	drop_backref_node(cache, node);
+}
+
+void update_backref_node(struct backref_cache *cache, struct backref_node *node,
+			 u64 bytenr)
+{
+	struct rb_node *rb_node;
+	rb_erase(&node->rb_node, &cache->rb_root);
+	node->bytenr = bytenr;
+	rb_node = tree_insert(&cache->rb_root, node->bytenr, &node->rb_node);
+	if (rb_node)
+		backref_tree_panic(rb_node, -EEXIST, bytenr);
+}
+
+/*
+ * update backref cache after a transaction commit
+ */
+int update_backref_cache(struct btrfs_trans_handle *trans,
+			 struct backref_cache *cache)
+{
+	struct backref_node *node;
+	int level = 0;
+
+	if (cache->last_trans == 0) {
+		cache->last_trans = trans->transid;
+		return 0;
+	}
+
+	if (cache->last_trans == trans->transid)
+		return 0;
+
+	/*
+	 * detached nodes are used to avoid unnecessary backref
+	 * lookup. transaction commit changes the extent tree.
+	 * so the detached nodes are no longer useful.
+	 */
+	while (!list_empty(&cache->detached)) {
+		node = list_entry(cache->detached.next,
+				  struct backref_node, list);
+		remove_backref_node(cache, node);
+	}
+
+	while (!list_empty(&cache->changed)) {
+		node = list_entry(cache->changed.next,
+				  struct backref_node, list);
+		list_del_init(&node->list);
+		BUG_ON(node->pending);
+		update_backref_node(cache, node, node->new_bytenr);
+	}
+
+	/*
+	 * some nodes can be left in the pending list if there were
+	 * errors during processing the pending nodes.
+	 */
+	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
+		list_for_each_entry(node, &cache->pending[level], list) {
+			BUG_ON(!node->pending);
+			if (node->bytenr == node->new_bytenr)
+				continue;
+			update_backref_node(cache, node, node->new_bytenr);
+		}
+	}
+
+	cache->last_trans = 0;
+	return 1;
+}
+
+static int should_ignore_root(struct btrfs_root *root)
+{
+	struct btrfs_root *reloc_root;
+
+	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+		return 0;
+
+	reloc_root = root->reloc_root;
+	if (!reloc_root)
+		return 0;
+
+	if (btrfs_root_last_snapshot(&reloc_root->root_item) ==
+	    root->fs_info->running_transaction->transid - 1)
+		return 0;
+	/*
+	 * if there is reloc tree and it was created in previous
+	 * transaction backref lookup can find the reloc tree,
+	 * so backref node for the fs tree root is useless for
+	 * relocation.
+	 */
+	return 1;
+}
+
+/*
+ * find reloc tree by address of tree root
+ */
+static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
+					  u64 bytenr)
+{
+	struct rb_node *rb_node;
+	struct mapping_node *node;
+	struct btrfs_root *root = NULL;
+
+	spin_lock(&rc->reloc_root_tree.lock);
+	rb_node = tree_search(&rc->reloc_root_tree.rb_root, bytenr);
+	if (rb_node) {
+		node = rb_entry(rb_node, struct mapping_node, rb_node);
+		root = (struct btrfs_root *)node->data;
+	}
+	spin_unlock(&rc->reloc_root_tree.lock);
+	return root;
+}
+
+static noinline_for_stack
+int find_inline_backref(struct extent_buffer *leaf, int slot,
+			unsigned long *ptr, unsigned long *end)
+{
+	struct btrfs_key key;
+	struct btrfs_extent_item *ei;
+	struct btrfs_tree_block_info *bi;
+	u32 item_size;
+
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+
+	item_size = btrfs_item_size_nr(leaf, slot);
+	if (item_size < sizeof(*ei)) {
+		btrfs_print_v0_err(leaf->fs_info);
+		btrfs_handle_fs_error(leaf->fs_info, -EINVAL, NULL);
+		return 1;
+	}
+	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+	WARN_ON(!(btrfs_extent_flags(leaf, ei) &
+		  BTRFS_EXTENT_FLAG_TREE_BLOCK));
+
+	if (key.type == BTRFS_EXTENT_ITEM_KEY &&
+	    item_size <= sizeof(*ei) + sizeof(*bi)) {
+		WARN_ON(item_size < sizeof(*ei) + sizeof(*bi));
+		return 1;
+	}
+	if (key.type == BTRFS_METADATA_ITEM_KEY &&
+	    item_size <= sizeof(*ei)) {
+		WARN_ON(item_size < sizeof(*ei));
+		return 1;
+	}
+
+	if (key.type == BTRFS_EXTENT_ITEM_KEY) {
+		bi = (struct btrfs_tree_block_info *)(ei + 1);
+		*ptr = (unsigned long)(bi + 1);
+	} else {
+		*ptr = (unsigned long)(ei + 1);
+	}
+	*end = (unsigned long)ei + item_size;
+	return 0;
+}
+
+
+/*
+ * build backref tree for a given tree block. root of the backref tree
+ * corresponds the tree block, leaves of the backref tree correspond
+ * roots of b-trees that reference the tree block.
+ *
+ * the basic idea of this function is check backrefs of a given block
+ * to find upper level blocks that reference the block, and then check
+ * backrefs of these upper level blocks recursively. the recursion stop
+ * when tree root is reached or backrefs for the block is cached.
+ *
+ * NOTE: if we find backrefs for a block are cached, we know backrefs
+ * for all upper level blocks that directly/indirectly reference the
+ * block are also cached.
+ */
+struct backref_node *build_backref_tree(struct reloc_control *rc,
+					struct btrfs_key *node_key,
+					int level, u64 bytenr)
+{
+	struct backref_cache *cache = &rc->backref_cache;
+	struct btrfs_path *path1; /* For searching extent root */
+	struct btrfs_path *path2; /* For searching parent of TREE_BLOCK_REF */
+	struct extent_buffer *eb;
+	struct btrfs_root *root;
+	struct backref_node *cur;
+	struct backref_node *upper;
+	struct backref_node *lower;
+	struct backref_node *node = NULL;
+	struct backref_node *exist = NULL;
+	struct backref_edge *edge;
+	struct rb_node *rb_node;
+	struct btrfs_key key;
+	unsigned long end;
+	unsigned long ptr;
+	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
+	LIST_HEAD(useless);
+	int cowonly;
+	int ret;
+	int err = 0;
+	bool need_check = true;
+
+	path1 = btrfs_alloc_path();
+	path2 = btrfs_alloc_path();
+	if (!path1 || !path2) {
+		err = -ENOMEM;
+		goto out;
+	}
+	path1->reada = READA_FORWARD;
+	path2->reada = READA_FORWARD;
+
+	node = alloc_backref_node(cache);
+	if (!node) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	node->bytenr = bytenr;
+	node->level = level;
+	node->lowest = 1;
+	cur = node;
+again:
+	end = 0;
+	ptr = 0;
+	key.objectid = cur->bytenr;
+	key.type = BTRFS_METADATA_ITEM_KEY;
+	key.offset = (u64)-1;
+
+	path1->search_commit_root = 1;
+	path1->skip_locking = 1;
+	ret = btrfs_search_slot(NULL, rc->extent_root, &key, path1,
+				0, 0);
+	if (ret < 0) {
+		err = ret;
+		goto out;
+	}
+	ASSERT(ret);
+	ASSERT(path1->slots[0]);
+
+	path1->slots[0]--;
+
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
+			list_add_tail(&edge->list[UPPER], &list);
+	} else {
+		exist = NULL;
+	}
+
+	while (1) {
+		cond_resched();
+		eb = path1->nodes[0];
+
+		if (ptr >= end) {
+			if (path1->slots[0] >= btrfs_header_nritems(eb)) {
+				ret = btrfs_next_leaf(rc->extent_root, path1);
+				if (ret < 0) {
+					err = ret;
+					goto out;
+				}
+				if (ret > 0)
+					break;
+				eb = path1->nodes[0];
+			}
+
+			btrfs_item_key_to_cpu(eb, &key, path1->slots[0]);
+			if (key.objectid != cur->bytenr) {
+				WARN_ON(exist);
+				break;
+			}
+
+			if (key.type == BTRFS_EXTENT_ITEM_KEY ||
+			    key.type == BTRFS_METADATA_ITEM_KEY) {
+				ret = find_inline_backref(eb, path1->slots[0],
+							  &ptr, &end);
+				if (ret)
+					goto next;
+			}
+		}
+
+		if (ptr < end) {
+			/* update key for inline back ref */
+			struct btrfs_extent_inline_ref *iref;
+			int type;
+			iref = (struct btrfs_extent_inline_ref *)ptr;
+			type = btrfs_get_extent_inline_ref_type(eb, iref,
+							BTRFS_REF_TYPE_BLOCK);
+			if (type == BTRFS_REF_TYPE_INVALID) {
+				err = -EUCLEAN;
+				goto out;
+			}
+			key.type = type;
+			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
+
+			WARN_ON(key.type != BTRFS_TREE_BLOCK_REF_KEY &&
+				key.type != BTRFS_SHARED_BLOCK_REF_KEY);
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
+			goto next;
+		}
+
+		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
+		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
+			if (key.objectid == key.offset) {
+				/*
+				 * Only root blocks of reloc trees use backref
+				 * pointing to itself.
+				 */
+				root = find_reloc_root(rc, cur->bytenr);
+				ASSERT(root);
+				cur->root = root;
+				break;
+			}
+
+			edge = alloc_backref_edge(cache);
+			if (!edge) {
+				err = -ENOMEM;
+				goto out;
+			}
+			rb_node = tree_search(&cache->rb_root, key.offset);
+			if (!rb_node) {
+				upper = alloc_backref_node(cache);
+				if (!upper) {
+					free_backref_edge(cache, edge);
+					err = -ENOMEM;
+					goto out;
+				}
+				upper->bytenr = key.offset;
+				upper->level = cur->level + 1;
+				/*
+				 *  backrefs for the upper level block isn't
+				 *  cached, add the block to pending list
+				 */
+				list_add_tail(&edge->list[UPPER], &list);
+			} else {
+				upper = rb_entry(rb_node, struct backref_node,
+						 rb_node);
+				ASSERT(upper->checked);
+				INIT_LIST_HEAD(&edge->list[UPPER]);
+			}
+			list_add_tail(&edge->list[LOWER], &cur->upper);
+			edge->node[LOWER] = cur;
+			edge->node[UPPER] = upper;
+
+			goto next;
+		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
+			err = -EINVAL;
+			btrfs_print_v0_err(rc->extent_root->fs_info);
+			btrfs_handle_fs_error(rc->extent_root->fs_info, err,
+					      NULL);
+			goto out;
+		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
+			goto next;
+		}
+
+		/*
+		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
+		 * means the root objectid. We need to search the tree to get
+		 * its parent bytenr.
+		 */
+		root = read_fs_root(rc->extent_root->fs_info, key.offset);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
+			goto out;
+		}
+
+		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+			cur->cowonly = 1;
+
+		if (btrfs_root_level(&root->root_item) == cur->level) {
+			/* tree root */
+			ASSERT(btrfs_root_bytenr(&root->root_item) ==
+			       cur->bytenr);
+			if (should_ignore_root(root))
+				list_add(&cur->list, &useless);
+			else
+				cur->root = root;
+			break;
+		}
+
+		level = cur->level + 1;
+
+		/* Search the tree to find parent blocks referring the block. */
+		path2->search_commit_root = 1;
+		path2->skip_locking = 1;
+		path2->lowest_level = level;
+		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
+		path2->lowest_level = 0;
+		if (ret < 0) {
+			err = ret;
+			goto out;
+		}
+		if (ret > 0 && path2->slots[level] > 0)
+			path2->slots[level]--;
+
+		eb = path2->nodes[level];
+		if (btrfs_node_blockptr(eb, path2->slots[level]) !=
+		    cur->bytenr) {
+			btrfs_err(root->fs_info,
+	"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
+				  cur->bytenr, level - 1,
+				  root->root_key.objectid,
+				  node_key->objectid, node_key->type,
+				  node_key->offset);
+			err = -ENOENT;
+			goto out;
+		}
+		lower = cur;
+		need_check = true;
+
+		/* Add all nodes and edges in the path */
+		for (; level < BTRFS_MAX_LEVEL; level++) {
+			if (!path2->nodes[level]) {
+				ASSERT(btrfs_root_bytenr(&root->root_item) ==
+				       lower->bytenr);
+				if (should_ignore_root(root))
+					list_add(&lower->list, &useless);
+				else
+					lower->root = root;
+				break;
+			}
+
+			edge = alloc_backref_edge(cache);
+			if (!edge) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			eb = path2->nodes[level];
+			rb_node = tree_search(&cache->rb_root, eb->start);
+			if (!rb_node) {
+				upper = alloc_backref_node(cache);
+				if (!upper) {
+					free_backref_edge(cache, edge);
+					err = -ENOMEM;
+					goto out;
+				}
+				upper->bytenr = eb->start;
+				upper->owner = btrfs_header_owner(eb);
+				upper->level = lower->level + 1;
+				if (!test_bit(BTRFS_ROOT_REF_COWS,
+					      &root->state))
+					upper->cowonly = 1;
+
+				/*
+				 * if we know the block isn't shared
+				 * we can void checking its backrefs.
+				 */
+				if (btrfs_block_can_be_shared(root, eb))
+					upper->checked = 0;
+				else
+					upper->checked = 1;
+
+				/*
+				 * add the block to pending list if we
+				 * need check its backrefs, we only do this once
+				 * while walking up a tree as we will catch
+				 * anything else later on.
+				 */
+				if (!upper->checked && need_check) {
+					need_check = false;
+					list_add_tail(&edge->list[UPPER],
+						      &list);
+				} else {
+					if (upper->checked)
+						need_check = true;
+					INIT_LIST_HEAD(&edge->list[UPPER]);
+				}
+			} else {
+				upper = rb_entry(rb_node, struct backref_node,
+						 rb_node);
+				ASSERT(upper->checked);
+				INIT_LIST_HEAD(&edge->list[UPPER]);
+				if (!upper->owner)
+					upper->owner = btrfs_header_owner(eb);
+			}
+			list_add_tail(&edge->list[LOWER], &lower->upper);
+			edge->node[LOWER] = lower;
+			edge->node[UPPER] = upper;
+
+			if (rb_node)
+				break;
+			lower = upper;
+			upper = NULL;
+		}
+		btrfs_release_path(path2);
+next:
+		if (ptr < end) {
+			ptr += btrfs_extent_inline_ref_size(key.type);
+			if (ptr >= end) {
+				WARN_ON(ptr > end);
+				ptr = 0;
+				end = 0;
+			}
+		}
+		if (ptr >= end)
+			path1->slots[0]++;
+	}
+	btrfs_release_path(path1);
+
+	cur->checked = 1;
+	WARN_ON(exist);
+
+	/* the pending list isn't empty, take the first block to process */
+	if (!list_empty(&list)) {
+		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
+		list_del_init(&edge->list[UPPER]);
+		cur = edge->node[UPPER];
+		goto again;
+	}
+
+	/*
+	 * everything goes well, connect backref nodes and insert backref nodes
+	 * into the cache.
+	 */
+	ASSERT(node->checked);
+	cowonly = node->cowonly;
+	if (!cowonly) {
+		rb_node = tree_insert(&cache->rb_root, node->bytenr,
+				      &node->rb_node);
+		if (rb_node)
+			backref_tree_panic(rb_node, -EEXIST, node->bytenr);
+		list_add_tail(&node->lower, &cache->leaves);
+	}
+
+	list_for_each_entry(edge, &node->upper, list[LOWER])
+		list_add_tail(&edge->list[UPPER], &list);
+
+	while (!list_empty(&list)) {
+		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
+		list_del_init(&edge->list[UPPER]);
+		upper = edge->node[UPPER];
+		if (upper->detached) {
+			list_del(&edge->list[LOWER]);
+			lower = edge->node[LOWER];
+			free_backref_edge(cache, edge);
+			if (list_empty(&lower->upper))
+				list_add(&lower->list, &useless);
+			continue;
+		}
+
+		if (!RB_EMPTY_NODE(&upper->rb_node)) {
+			if (upper->lowest) {
+				list_del_init(&upper->lower);
+				upper->lowest = 0;
+			}
+
+			list_add_tail(&edge->list[UPPER], &upper->lower);
+			continue;
+		}
+
+		if (!upper->checked) {
+			/*
+			 * Still want to blow up for developers since this is a
+			 * logic bug.
+			 */
+			ASSERT(0);
+			err = -EINVAL;
+			goto out;
+		}
+		if (cowonly != upper->cowonly) {
+			ASSERT(0);
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (!cowonly) {
+			rb_node = tree_insert(&cache->rb_root, upper->bytenr,
+					      &upper->rb_node);
+			if (rb_node)
+				backref_tree_panic(rb_node, -EEXIST,
+						   upper->bytenr);
+		}
+
+		list_add_tail(&edge->list[UPPER], &upper->lower);
+
+		list_for_each_entry(edge, &upper->upper, list[LOWER])
+			list_add_tail(&edge->list[UPPER], &list);
+	}
+	/*
+	 * process useless backref nodes. backref nodes for tree leaves
+	 * are deleted from the cache. backref nodes for upper level
+	 * tree blocks are left in the cache to avoid unnecessary backref
+	 * lookup.
+	 */
+	while (!list_empty(&useless)) {
+		upper = list_entry(useless.next, struct backref_node, list);
+		list_del_init(&upper->list);
+		ASSERT(list_empty(&upper->upper));
+		if (upper == node)
+			node = NULL;
+		if (upper->lowest) {
+			list_del_init(&upper->lower);
+			upper->lowest = 0;
+		}
+		while (!list_empty(&upper->lower)) {
+			edge = list_entry(upper->lower.next,
+					  struct backref_edge, list[UPPER]);
+			list_del(&edge->list[UPPER]);
+			list_del(&edge->list[LOWER]);
+			lower = edge->node[LOWER];
+			free_backref_edge(cache, edge);
+
+			if (list_empty(&lower->upper))
+				list_add(&lower->list, &useless);
+		}
+		__mark_block_processed(rc, upper);
+		if (upper->level > 0) {
+			list_add(&upper->list, &cache->detached);
+			upper->detached = 1;
+		} else {
+			rb_erase(&upper->rb_node, &cache->rb_root);
+			free_backref_node(cache, upper);
+		}
+	}
+out:
+	btrfs_free_path(path1);
+	btrfs_free_path(path2);
+	if (err) {
+		while (!list_empty(&useless)) {
+			lower = list_entry(useless.next,
+					   struct backref_node, list);
+			list_del_init(&lower->list);
+		}
+		while (!list_empty(&list)) {
+			edge = list_first_entry(&list, struct backref_edge,
+						list[UPPER]);
+			list_del(&edge->list[UPPER]);
+			list_del(&edge->list[LOWER]);
+			lower = edge->node[LOWER];
+			upper = edge->node[UPPER];
+			free_backref_edge(cache, edge);
+
+			/*
+			 * Lower is no longer linked to any upper backref nodes
+			 * and isn't in the cache, we can free it ourselves.
+			 */
+			if (list_empty(&lower->upper) &&
+			    RB_EMPTY_NODE(&lower->rb_node))
+				list_add(&lower->list, &useless);
+
+			if (!RB_EMPTY_NODE(&upper->rb_node))
+				continue;
+
+			/* Add this guy's upper edges to the list to process */
+			list_for_each_entry(edge, &upper->upper, list[LOWER])
+				list_add_tail(&edge->list[UPPER], &list);
+			if (list_empty(&upper->upper))
+				list_add(&upper->list, &useless);
+		}
+
+		while (!list_empty(&useless)) {
+			lower = list_entry(useless.next,
+					   struct backref_node, list);
+			list_del_init(&lower->list);
+			if (lower == node)
+				node = NULL;
+			free_backref_node(cache, lower);
+		}
+
+		free_backref_node(cache, node);
+		return ERR_PTR(err);
+	}
+	ASSERT(!node || !node->detached);
+	return node;
+}
+
+void mark_block_processed(struct reloc_control *rc, u64 bytenr, u32 blocksize)
+{
+	set_extent_bits(&rc->processed_blocks, bytenr, bytenr + blocksize - 1,
+			EXTENT_DIRTY);
+}
+
+void __mark_block_processed(struct reloc_control *rc, struct backref_node *node)
+{
+	u32 blocksize;
+	if (node->level == 0 ||
+	    in_block_group(node->bytenr, rc->block_group)) {
+		blocksize = rc->extent_root->fs_info->nodesize;
+		mark_block_processed(rc, node->bytenr, blocksize);
+	}
+	node->processed = 1;
+}
diff --git a/fs/btrfs/backref-cache.h b/fs/btrfs/backref-cache.h
new file mode 100644
index 000000000000..549eb891b9f8
--- /dev/null
+++ b/fs/btrfs/backref-cache.h
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 SUSE.  All rights reserved.
+ */
+
+#ifndef BTRFS_BACKREF_CACHE_H
+#define BTRFS_BACKREF_CACHE_H
+
+/*
+ * present a tree block in the backref cache
+ */
+struct backref_node {
+	struct rb_node rb_node;
+	u64 bytenr;
+
+	u64 new_bytenr;
+	/* objectid of tree block owner, can be not uptodate */
+	u64 owner;
+	/* link to pending, changed or detached list */
+	struct list_head list;
+	/* list of upper level blocks reference this block */
+	struct list_head upper;
+	/* list of child blocks in the cache */
+	struct list_head lower;
+	/* NULL if this node is not tree root */
+	struct btrfs_root *root;
+	/* extent buffer got by COW the block */
+	struct extent_buffer *eb;
+	/* level of tree block */
+	unsigned int level:8;
+	/* is the block in non-reference counted tree */
+	unsigned int cowonly:1;
+	/* 1 if no child node in the cache */
+	unsigned int lowest:1;
+	/* is the extent buffer locked */
+	unsigned int locked:1;
+	/* has the block been processed */
+	unsigned int processed:1;
+	/* have backrefs of this block been checked */
+	unsigned int checked:1;
+	/*
+	 * 1 if corresponding block has been cowed but some upper
+	 * level block pointers may not point to the new location
+	 */
+	unsigned int pending:1;
+	/*
+	 * 1 if the backref node isn't connected to any other
+	 * backref node.
+	 */
+	unsigned int detached:1;
+};
+
+/*
+ * present a block pointer in the backref cache
+ */
+struct backref_edge {
+	struct list_head list[2];
+	struct backref_node *node[2];
+};
+
+#define LOWER	0
+#define UPPER	1
+
+struct backref_cache {
+	/* red black tree of all backref nodes in the cache */
+	struct rb_root rb_root;
+	/* for passing backref nodes to btrfs_reloc_cow_block */
+	struct backref_node *path[BTRFS_MAX_LEVEL];
+	/*
+	 * list of blocks that have been cowed but some block
+	 * pointers in upper level blocks may not reflect the
+	 * new location
+	 */
+	struct list_head pending[BTRFS_MAX_LEVEL];
+	/* list of backref nodes with no child node */
+	struct list_head leaves;
+	/* list of blocks that have been cowed in current transaction */
+	struct list_head changed;
+	/* list of detached backref node. */
+	struct list_head detached;
+
+	u64 last_trans;
+
+	int nr_nodes;
+	int nr_edges;
+};
+
+void backref_cache_init(struct backref_cache *cache);
+void backref_cache_cleanup(struct backref_cache *cache);
+struct backref_node *alloc_backref_node(struct backref_cache *cache);
+void free_backref_node(struct backref_cache *cache,
+		       struct backref_node *node);
+struct backref_edge *alloc_backref_edge(struct backref_cache *cache);
+void free_backref_edge(struct backref_cache *cache, struct backref_edge *edge);
+void unlock_node_buffer(struct backref_node *node);
+void drop_node_buffer(struct backref_node *node);
+void remove_backref_node(struct backref_cache *cache, struct backref_node *node);
+void update_backref_node(struct backref_cache *cache, struct backref_node *node,
+			 u64 bytenr);
+int update_backref_cache(struct btrfs_trans_handle *trans,
+			 struct backref_cache *cache);
+
+/* for relocation.c */
+void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr);
+void mark_block_processed(struct reloc_control *rc, u64 bytenr, u32 blocksize);
+void __mark_block_processed(struct reloc_control *rc, struct backref_node *node);
+struct reloc_control;
+
+struct backref_node *build_backref_tree(struct reloc_control *rc,
+					struct btrfs_key *node_key,
+					int level, u64 bytenr);
+
+#endif /* BTRFS_BACKREF_CACHE_H */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7f219851fa23..a669f26a504a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -21,6 +21,8 @@
 #include "qgroup.h"
 #include "print-tree.h"
 #include "delalloc-space.h"
+#include "backref-cache.h"
+#include "relocation.h"
 
 /*
  * backref_node, mapping_node and tree_block start with this
@@ -29,101 +31,8 @@ struct tree_entry {
 	struct rb_node rb_node;
 	u64 bytenr;
 };
-
-/*
- * present a tree block in the backref cache
- */
-struct backref_node {
-	struct rb_node rb_node;
-	u64 bytenr;
-
-	u64 new_bytenr;
-	/* objectid of tree block owner, can be not uptodate */
-	u64 owner;
-	/* link to pending, changed or detached list */
-	struct list_head list;
-	/* list of upper level blocks reference this block */
-	struct list_head upper;
-	/* list of child blocks in the cache */
-	struct list_head lower;
-	/* NULL if this node is not tree root */
-	struct btrfs_root *root;
-	/* extent buffer got by COW the block */
-	struct extent_buffer *eb;
-	/* level of tree block */
-	unsigned int level:8;
-	/* is the block in non-reference counted tree */
-	unsigned int cowonly:1;
-	/* 1 if no child node in the cache */
-	unsigned int lowest:1;
-	/* is the extent buffer locked */
-	unsigned int locked:1;
-	/* has the block been processed */
-	unsigned int processed:1;
-	/* have backrefs of this block been checked */
-	unsigned int checked:1;
-	/*
-	 * 1 if corresponding block has been cowed but some upper
-	 * level block pointers may not point to the new location
-	 */
-	unsigned int pending:1;
-	/*
-	 * 1 if the backref node isn't connected to any other
-	 * backref node.
-	 */
-	unsigned int detached:1;
-};
-
-/*
- * present a block pointer in the backref cache
- */
-struct backref_edge {
-	struct list_head list[2];
-	struct backref_node *node[2];
-};
-
-#define LOWER	0
-#define UPPER	1
 #define RELOCATION_RESERVED_NODES	256
 
-struct backref_cache {
-	/* red black tree of all backref nodes in the cache */
-	struct rb_root rb_root;
-	/* for passing backref nodes to btrfs_reloc_cow_block */
-	struct backref_node *path[BTRFS_MAX_LEVEL];
-	/*
-	 * list of blocks that have been cowed but some block
-	 * pointers in upper level blocks may not reflect the
-	 * new location
-	 */
-	struct list_head pending[BTRFS_MAX_LEVEL];
-	/* list of backref nodes with no child node */
-	struct list_head leaves;
-	/* list of blocks that have been cowed in current transaction */
-	struct list_head changed;
-	/* list of detached backref node. */
-	struct list_head detached;
-
-	u64 last_trans;
-
-	int nr_nodes;
-	int nr_edges;
-};
-
-/*
- * map address of tree root to tree
- */
-struct mapping_node {
-	struct rb_node rb_node;
-	u64 bytenr;
-	void *data;
-};
-
-struct mapping_tree {
-	struct rb_root rb_root;
-	spinlock_t lock;
-};
-
 /*
  * present a tree block to process
  */
@@ -135,151 +44,14 @@ struct tree_block {
 	unsigned int key_ready:1;
 };
 
-#define MAX_EXTENTS 128
-
-struct file_extent_cluster {
-	u64 start;
-	u64 end;
-	u64 boundary[MAX_EXTENTS];
-	unsigned int nr;
-};
-
-struct reloc_control {
-	/* block group to relocate */
-	struct btrfs_block_group_cache *block_group;
-	/* extent tree */
-	struct btrfs_root *extent_root;
-	/* inode for moving data */
-	struct inode *data_inode;
-
-	struct btrfs_block_rsv *block_rsv;
-
-	struct backref_cache backref_cache;
-
-	struct file_extent_cluster cluster;
-	/* tree blocks have been processed */
-	struct extent_io_tree processed_blocks;
-	/* map start of tree root to corresponding reloc tree */
-	struct mapping_tree reloc_root_tree;
-	/* list of reloc trees */
-	struct list_head reloc_roots;
-	/* list of subvolume trees that get relocated */
-	struct list_head dirty_subvol_roots;
-	/* size of metadata reservation for merging reloc trees */
-	u64 merging_rsv_size;
-	/* size of relocated tree nodes */
-	u64 nodes_relocated;
-	/* reserved size for block group relocation*/
-	u64 reserved_bytes;
-
-	u64 search_start;
-	u64 extents_found;
-
-	unsigned int stage:8;
-	unsigned int create_reloc_tree:1;
-	unsigned int merge_reloc_tree:1;
-	unsigned int found_file_extent:1;
-};
-
-/* stages of data relocation */
-#define MOVE_DATA_EXTENTS	0
-#define UPDATE_DATA_PTRS	1
-
-static void remove_backref_node(struct backref_cache *cache,
-				struct backref_node *node);
-static void __mark_block_processed(struct reloc_control *rc,
-				   struct backref_node *node);
-
 static void mapping_tree_init(struct mapping_tree *tree)
 {
 	tree->rb_root = RB_ROOT;
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_cache_init(struct backref_cache *cache)
-{
-	int i;
-	cache->rb_root = RB_ROOT;
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		INIT_LIST_HEAD(&cache->pending[i]);
-	INIT_LIST_HEAD(&cache->changed);
-	INIT_LIST_HEAD(&cache->detached);
-	INIT_LIST_HEAD(&cache->leaves);
-}
-
-static void backref_cache_cleanup(struct backref_cache *cache)
-{
-	struct backref_node *node;
-	int i;
-
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct backref_node, list);
-		remove_backref_node(cache, node);
-	}
-
-	while (!list_empty(&cache->leaves)) {
-		node = list_entry(cache->leaves.next,
-				  struct backref_node, lower);
-		remove_backref_node(cache, node);
-	}
-
-	cache->last_trans = 0;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		ASSERT(list_empty(&cache->pending[i]));
-	ASSERT(list_empty(&cache->changed));
-	ASSERT(list_empty(&cache->detached));
-	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
-	ASSERT(!cache->nr_nodes);
-	ASSERT(!cache->nr_edges);
-}
-
-static struct backref_node *alloc_backref_node(struct backref_cache *cache)
-{
-	struct backref_node *node;
-
-	node = kzalloc(sizeof(*node), GFP_NOFS);
-	if (node) {
-		INIT_LIST_HEAD(&node->list);
-		INIT_LIST_HEAD(&node->upper);
-		INIT_LIST_HEAD(&node->lower);
-		RB_CLEAR_NODE(&node->rb_node);
-		cache->nr_nodes++;
-	}
-	return node;
-}
-
-static void free_backref_node(struct backref_cache *cache,
-			      struct backref_node *node)
-{
-	if (node) {
-		cache->nr_nodes--;
-		kfree(node);
-	}
-}
-
-static struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
-{
-	struct backref_edge *edge;
-
-	edge = kzalloc(sizeof(*edge), GFP_NOFS);
-	if (edge)
-		cache->nr_edges++;
-	return edge;
-}
-
-static void free_backref_edge(struct backref_cache *cache,
-			      struct backref_edge *edge)
-{
-	if (edge) {
-		cache->nr_edges--;
-		kfree(edge);
-	}
-}
-
-static struct rb_node *tree_insert(struct rb_root *root, u64 bytenr,
-				   struct rb_node *node)
+struct rb_node *tree_insert(struct rb_root *root, u64 bytenr,
+			    struct rb_node *node)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
@@ -302,7 +74,7 @@ static struct rb_node *tree_insert(struct rb_root *root, u64 bytenr,
 	return NULL;
 }
 
-static struct rb_node *tree_search(struct rb_root *root, u64 bytenr)
+struct rb_node *tree_search(struct rb_root *root, u64 bytenr)
 {
 	struct rb_node *n = root->rb_node;
 	struct tree_entry *entry;
@@ -320,19 +92,6 @@ static struct rb_node *tree_search(struct rb_root *root, u64 bytenr)
 	return NULL;
 }
 
-static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
-{
-
-	struct btrfs_fs_info *fs_info = NULL;
-	struct backref_node *bnode = rb_entry(rb_node, struct backref_node,
-					      rb_node);
-	if (bnode->root)
-		fs_info = bnode->root->fs_info;
-	btrfs_panic(fs_info, errno,
-		    "Inconsistency in backref cache found at offset %llu",
-		    bytenr);
-}
-
 /*
  * walk up backref nodes until reach node presents tree root
  */
@@ -381,185 +140,7 @@ static struct backref_node *walk_down_backref(struct backref_edge *edges[],
 	return NULL;
 }
 
-static void unlock_node_buffer(struct backref_node *node)
-{
-	if (node->locked) {
-		btrfs_tree_unlock(node->eb);
-		node->locked = 0;
-	}
-}
-
-static void drop_node_buffer(struct backref_node *node)
-{
-	if (node->eb) {
-		unlock_node_buffer(node);
-		free_extent_buffer(node->eb);
-		node->eb = NULL;
-	}
-}
-
-static void drop_backref_node(struct backref_cache *tree,
-			      struct backref_node *node)
-{
-	BUG_ON(!list_empty(&node->upper));
-
-	drop_node_buffer(node);
-	list_del(&node->list);
-	list_del(&node->lower);
-	if (!RB_EMPTY_NODE(&node->rb_node))
-		rb_erase(&node->rb_node, &tree->rb_root);
-	free_backref_node(tree, node);
-}
-
-/*
- * remove a backref node from the backref cache
- */
-static void remove_backref_node(struct backref_cache *cache,
-				struct backref_node *node)
-{
-	struct backref_node *upper;
-	struct backref_edge *edge;
-
-	if (!node)
-		return;
-
-	BUG_ON(!node->lowest && !node->detached);
-	while (!list_empty(&node->upper)) {
-		edge = list_entry(node->upper.next, struct backref_edge,
-				  list[LOWER]);
-		upper = edge->node[UPPER];
-		list_del(&edge->list[LOWER]);
-		list_del(&edge->list[UPPER]);
-		free_backref_edge(cache, edge);
-
-		if (RB_EMPTY_NODE(&upper->rb_node)) {
-			BUG_ON(!list_empty(&node->upper));
-			drop_backref_node(cache, node);
-			node = upper;
-			node->lowest = 1;
-			continue;
-		}
-		/*
-		 * add the node to leaf node list if no other
-		 * child block cached.
-		 */
-		if (list_empty(&upper->lower)) {
-			list_add_tail(&upper->lower, &cache->leaves);
-			upper->lowest = 1;
-		}
-	}
-
-	drop_backref_node(cache, node);
-}
-
-static void update_backref_node(struct backref_cache *cache,
-				struct backref_node *node, u64 bytenr)
-{
-	struct rb_node *rb_node;
-	rb_erase(&node->rb_node, &cache->rb_root);
-	node->bytenr = bytenr;
-	rb_node = tree_insert(&cache->rb_root, node->bytenr, &node->rb_node);
-	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, bytenr);
-}
-
-/*
- * update backref cache after a transaction commit
- */
-static int update_backref_cache(struct btrfs_trans_handle *trans,
-				struct backref_cache *cache)
-{
-	struct backref_node *node;
-	int level = 0;
-
-	if (cache->last_trans == 0) {
-		cache->last_trans = trans->transid;
-		return 0;
-	}
-
-	if (cache->last_trans == trans->transid)
-		return 0;
-
-	/*
-	 * detached nodes are used to avoid unnecessary backref
-	 * lookup. transaction commit changes the extent tree.
-	 * so the detached nodes are no longer useful.
-	 */
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct backref_node, list);
-		remove_backref_node(cache, node);
-	}
-
-	while (!list_empty(&cache->changed)) {
-		node = list_entry(cache->changed.next,
-				  struct backref_node, list);
-		list_del_init(&node->list);
-		BUG_ON(node->pending);
-		update_backref_node(cache, node, node->new_bytenr);
-	}
-
-	/*
-	 * some nodes can be left in the pending list if there were
-	 * errors during processing the pending nodes.
-	 */
-	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
-		list_for_each_entry(node, &cache->pending[level], list) {
-			BUG_ON(!node->pending);
-			if (node->bytenr == node->new_bytenr)
-				continue;
-			update_backref_node(cache, node, node->new_bytenr);
-		}
-	}
-
-	cache->last_trans = 0;
-	return 1;
-}
-
-
-static int should_ignore_root(struct btrfs_root *root)
-{
-	struct btrfs_root *reloc_root;
-
-	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
-		return 0;
-
-	reloc_root = root->reloc_root;
-	if (!reloc_root)
-		return 0;
-
-	if (btrfs_root_last_snapshot(&reloc_root->root_item) ==
-	    root->fs_info->running_transaction->transid - 1)
-		return 0;
-	/*
-	 * if there is reloc tree and it was created in previous
-	 * transaction backref lookup can find the reloc tree,
-	 * so backref node for the fs tree root is useless for
-	 * relocation.
-	 */
-	return 1;
-}
-/*
- * find reloc tree by address of tree root
- */
-static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
-					  u64 bytenr)
-{
-	struct rb_node *rb_node;
-	struct mapping_node *node;
-	struct btrfs_root *root = NULL;
-
-	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_search(&rc->reloc_root_tree.rb_root, bytenr);
-	if (rb_node) {
-		node = rb_entry(rb_node, struct mapping_node, rb_node);
-		root = (struct btrfs_root *)node->data;
-	}
-	spin_unlock(&rc->reloc_root_tree.lock);
-	return root;
-}
-
-static int is_cowonly_root(u64 root_objectid)
+int is_cowonly_root(u64 root_objectid)
 {
 	if (root_objectid == BTRFS_ROOT_TREE_OBJECTID ||
 	    root_objectid == BTRFS_EXTENT_TREE_OBJECTID ||
@@ -574,8 +155,7 @@ static int is_cowonly_root(u64 root_objectid)
 	return 0;
 }
 
-static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_objectid)
+struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info, u64 root_objectid)
 {
 	struct btrfs_key key;
 
@@ -589,577 +169,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
-static noinline_for_stack
-int find_inline_backref(struct extent_buffer *leaf, int slot,
-			unsigned long *ptr, unsigned long *end)
-{
-	struct btrfs_key key;
-	struct btrfs_extent_item *ei;
-	struct btrfs_tree_block_info *bi;
-	u32 item_size;
-
-	btrfs_item_key_to_cpu(leaf, &key, slot);
-
-	item_size = btrfs_item_size_nr(leaf, slot);
-	if (item_size < sizeof(*ei)) {
-		btrfs_print_v0_err(leaf->fs_info);
-		btrfs_handle_fs_error(leaf->fs_info, -EINVAL, NULL);
-		return 1;
-	}
-	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
-	WARN_ON(!(btrfs_extent_flags(leaf, ei) &
-		  BTRFS_EXTENT_FLAG_TREE_BLOCK));
-
-	if (key.type == BTRFS_EXTENT_ITEM_KEY &&
-	    item_size <= sizeof(*ei) + sizeof(*bi)) {
-		WARN_ON(item_size < sizeof(*ei) + sizeof(*bi));
-		return 1;
-	}
-	if (key.type == BTRFS_METADATA_ITEM_KEY &&
-	    item_size <= sizeof(*ei)) {
-		WARN_ON(item_size < sizeof(*ei));
-		return 1;
-	}
-
-	if (key.type == BTRFS_EXTENT_ITEM_KEY) {
-		bi = (struct btrfs_tree_block_info *)(ei + 1);
-		*ptr = (unsigned long)(bi + 1);
-	} else {
-		*ptr = (unsigned long)(ei + 1);
-	}
-	*end = (unsigned long)ei + item_size;
-	return 0;
-}
-
-/*
- * build backref tree for a given tree block. root of the backref tree
- * corresponds the tree block, leaves of the backref tree correspond
- * roots of b-trees that reference the tree block.
- *
- * the basic idea of this function is check backrefs of a given block
- * to find upper level blocks that reference the block, and then check
- * backrefs of these upper level blocks recursively. the recursion stop
- * when tree root is reached or backrefs for the block is cached.
- *
- * NOTE: if we find backrefs for a block are cached, we know backrefs
- * for all upper level blocks that directly/indirectly reference the
- * block are also cached.
- */
-static noinline_for_stack
-struct backref_node *build_backref_tree(struct reloc_control *rc,
-					struct btrfs_key *node_key,
-					int level, u64 bytenr)
-{
-	struct backref_cache *cache = &rc->backref_cache;
-	struct btrfs_path *path1; /* For searching extent root */
-	struct btrfs_path *path2; /* For searching parent of TREE_BLOCK_REF */
-	struct extent_buffer *eb;
-	struct btrfs_root *root;
-	struct backref_node *cur;
-	struct backref_node *upper;
-	struct backref_node *lower;
-	struct backref_node *node = NULL;
-	struct backref_node *exist = NULL;
-	struct backref_edge *edge;
-	struct rb_node *rb_node;
-	struct btrfs_key key;
-	unsigned long end;
-	unsigned long ptr;
-	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
-	LIST_HEAD(useless);
-	int cowonly;
-	int ret;
-	int err = 0;
-	bool need_check = true;
-
-	path1 = btrfs_alloc_path();
-	path2 = btrfs_alloc_path();
-	if (!path1 || !path2) {
-		err = -ENOMEM;
-		goto out;
-	}
-	path1->reada = READA_FORWARD;
-	path2->reada = READA_FORWARD;
-
-	node = alloc_backref_node(cache);
-	if (!node) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	node->bytenr = bytenr;
-	node->level = level;
-	node->lowest = 1;
-	cur = node;
-again:
-	end = 0;
-	ptr = 0;
-	key.objectid = cur->bytenr;
-	key.type = BTRFS_METADATA_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	path1->search_commit_root = 1;
-	path1->skip_locking = 1;
-	ret = btrfs_search_slot(NULL, rc->extent_root, &key, path1,
-				0, 0);
-	if (ret < 0) {
-		err = ret;
-		goto out;
-	}
-	ASSERT(ret);
-	ASSERT(path1->slots[0]);
-
-	path1->slots[0]--;
-
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
-			list_add_tail(&edge->list[UPPER], &list);
-	} else {
-		exist = NULL;
-	}
-
-	while (1) {
-		cond_resched();
-		eb = path1->nodes[0];
-
-		if (ptr >= end) {
-			if (path1->slots[0] >= btrfs_header_nritems(eb)) {
-				ret = btrfs_next_leaf(rc->extent_root, path1);
-				if (ret < 0) {
-					err = ret;
-					goto out;
-				}
-				if (ret > 0)
-					break;
-				eb = path1->nodes[0];
-			}
-
-			btrfs_item_key_to_cpu(eb, &key, path1->slots[0]);
-			if (key.objectid != cur->bytenr) {
-				WARN_ON(exist);
-				break;
-			}
-
-			if (key.type == BTRFS_EXTENT_ITEM_KEY ||
-			    key.type == BTRFS_METADATA_ITEM_KEY) {
-				ret = find_inline_backref(eb, path1->slots[0],
-							  &ptr, &end);
-				if (ret)
-					goto next;
-			}
-		}
-
-		if (ptr < end) {
-			/* update key for inline back ref */
-			struct btrfs_extent_inline_ref *iref;
-			int type;
-			iref = (struct btrfs_extent_inline_ref *)ptr;
-			type = btrfs_get_extent_inline_ref_type(eb, iref,
-							BTRFS_REF_TYPE_BLOCK);
-			if (type == BTRFS_REF_TYPE_INVALID) {
-				err = -EUCLEAN;
-				goto out;
-			}
-			key.type = type;
-			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
-
-			WARN_ON(key.type != BTRFS_TREE_BLOCK_REF_KEY &&
-				key.type != BTRFS_SHARED_BLOCK_REF_KEY);
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
-			goto next;
-		}
-
-		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
-		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
-			if (key.objectid == key.offset) {
-				/*
-				 * Only root blocks of reloc trees use backref
-				 * pointing to itself.
-				 */
-				root = find_reloc_root(rc, cur->bytenr);
-				ASSERT(root);
-				cur->root = root;
-				break;
-			}
-
-			edge = alloc_backref_edge(cache);
-			if (!edge) {
-				err = -ENOMEM;
-				goto out;
-			}
-			rb_node = tree_search(&cache->rb_root, key.offset);
-			if (!rb_node) {
-				upper = alloc_backref_node(cache);
-				if (!upper) {
-					free_backref_edge(cache, edge);
-					err = -ENOMEM;
-					goto out;
-				}
-				upper->bytenr = key.offset;
-				upper->level = cur->level + 1;
-				/*
-				 *  backrefs for the upper level block isn't
-				 *  cached, add the block to pending list
-				 */
-				list_add_tail(&edge->list[UPPER], &list);
-			} else {
-				upper = rb_entry(rb_node, struct backref_node,
-						 rb_node);
-				ASSERT(upper->checked);
-				INIT_LIST_HEAD(&edge->list[UPPER]);
-			}
-			list_add_tail(&edge->list[LOWER], &cur->upper);
-			edge->node[LOWER] = cur;
-			edge->node[UPPER] = upper;
-
-			goto next;
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			err = -EINVAL;
-			btrfs_print_v0_err(rc->extent_root->fs_info);
-			btrfs_handle_fs_error(rc->extent_root->fs_info, err,
-					      NULL);
-			goto out;
-		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
-			goto next;
-		}
-
-		/*
-		 * key.type == BTRFS_TREE_BLOCK_REF_KEY, inline ref offset
-		 * means the root objectid. We need to search the tree to get
-		 * its parent bytenr.
-		 */
-		root = read_fs_root(rc->extent_root->fs_info, key.offset);
-		if (IS_ERR(root)) {
-			err = PTR_ERR(root);
-			goto out;
-		}
-
-		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
-			cur->cowonly = 1;
-
-		if (btrfs_root_level(&root->root_item) == cur->level) {
-			/* tree root */
-			ASSERT(btrfs_root_bytenr(&root->root_item) ==
-			       cur->bytenr);
-			if (should_ignore_root(root))
-				list_add(&cur->list, &useless);
-			else
-				cur->root = root;
-			break;
-		}
-
-		level = cur->level + 1;
-
-		/* Search the tree to find parent blocks referring the block. */
-		path2->search_commit_root = 1;
-		path2->skip_locking = 1;
-		path2->lowest_level = level;
-		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
-		path2->lowest_level = 0;
-		if (ret < 0) {
-			err = ret;
-			goto out;
-		}
-		if (ret > 0 && path2->slots[level] > 0)
-			path2->slots[level]--;
-
-		eb = path2->nodes[level];
-		if (btrfs_node_blockptr(eb, path2->slots[level]) !=
-		    cur->bytenr) {
-			btrfs_err(root->fs_info,
-	"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
-				  cur->bytenr, level - 1,
-				  root->root_key.objectid,
-				  node_key->objectid, node_key->type,
-				  node_key->offset);
-			err = -ENOENT;
-			goto out;
-		}
-		lower = cur;
-		need_check = true;
-
-		/* Add all nodes and edges in the path */
-		for (; level < BTRFS_MAX_LEVEL; level++) {
-			if (!path2->nodes[level]) {
-				ASSERT(btrfs_root_bytenr(&root->root_item) ==
-				       lower->bytenr);
-				if (should_ignore_root(root))
-					list_add(&lower->list, &useless);
-				else
-					lower->root = root;
-				break;
-			}
-
-			edge = alloc_backref_edge(cache);
-			if (!edge) {
-				err = -ENOMEM;
-				goto out;
-			}
-
-			eb = path2->nodes[level];
-			rb_node = tree_search(&cache->rb_root, eb->start);
-			if (!rb_node) {
-				upper = alloc_backref_node(cache);
-				if (!upper) {
-					free_backref_edge(cache, edge);
-					err = -ENOMEM;
-					goto out;
-				}
-				upper->bytenr = eb->start;
-				upper->owner = btrfs_header_owner(eb);
-				upper->level = lower->level + 1;
-				if (!test_bit(BTRFS_ROOT_REF_COWS,
-					      &root->state))
-					upper->cowonly = 1;
-
-				/*
-				 * if we know the block isn't shared
-				 * we can void checking its backrefs.
-				 */
-				if (btrfs_block_can_be_shared(root, eb))
-					upper->checked = 0;
-				else
-					upper->checked = 1;
-
-				/*
-				 * add the block to pending list if we
-				 * need check its backrefs, we only do this once
-				 * while walking up a tree as we will catch
-				 * anything else later on.
-				 */
-				if (!upper->checked && need_check) {
-					need_check = false;
-					list_add_tail(&edge->list[UPPER],
-						      &list);
-				} else {
-					if (upper->checked)
-						need_check = true;
-					INIT_LIST_HEAD(&edge->list[UPPER]);
-				}
-			} else {
-				upper = rb_entry(rb_node, struct backref_node,
-						 rb_node);
-				ASSERT(upper->checked);
-				INIT_LIST_HEAD(&edge->list[UPPER]);
-				if (!upper->owner)
-					upper->owner = btrfs_header_owner(eb);
-			}
-			list_add_tail(&edge->list[LOWER], &lower->upper);
-			edge->node[LOWER] = lower;
-			edge->node[UPPER] = upper;
-
-			if (rb_node)
-				break;
-			lower = upper;
-			upper = NULL;
-		}
-		btrfs_release_path(path2);
-next:
-		if (ptr < end) {
-			ptr += btrfs_extent_inline_ref_size(key.type);
-			if (ptr >= end) {
-				WARN_ON(ptr > end);
-				ptr = 0;
-				end = 0;
-			}
-		}
-		if (ptr >= end)
-			path1->slots[0]++;
-	}
-	btrfs_release_path(path1);
-
-	cur->checked = 1;
-	WARN_ON(exist);
-
-	/* the pending list isn't empty, take the first block to process */
-	if (!list_empty(&list)) {
-		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
-		list_del_init(&edge->list[UPPER]);
-		cur = edge->node[UPPER];
-		goto again;
-	}
-
-	/*
-	 * everything goes well, connect backref nodes and insert backref nodes
-	 * into the cache.
-	 */
-	ASSERT(node->checked);
-	cowonly = node->cowonly;
-	if (!cowonly) {
-		rb_node = tree_insert(&cache->rb_root, node->bytenr,
-				      &node->rb_node);
-		if (rb_node)
-			backref_tree_panic(rb_node, -EEXIST, node->bytenr);
-		list_add_tail(&node->lower, &cache->leaves);
-	}
-
-	list_for_each_entry(edge, &node->upper, list[LOWER])
-		list_add_tail(&edge->list[UPPER], &list);
-
-	while (!list_empty(&list)) {
-		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
-		list_del_init(&edge->list[UPPER]);
-		upper = edge->node[UPPER];
-		if (upper->detached) {
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
-			if (list_empty(&lower->upper))
-				list_add(&lower->list, &useless);
-			continue;
-		}
-
-		if (!RB_EMPTY_NODE(&upper->rb_node)) {
-			if (upper->lowest) {
-				list_del_init(&upper->lower);
-				upper->lowest = 0;
-			}
-
-			list_add_tail(&edge->list[UPPER], &upper->lower);
-			continue;
-		}
-
-		if (!upper->checked) {
-			/*
-			 * Still want to blow up for developers since this is a
-			 * logic bug.
-			 */
-			ASSERT(0);
-			err = -EINVAL;
-			goto out;
-		}
-		if (cowonly != upper->cowonly) {
-			ASSERT(0);
-			err = -EINVAL;
-			goto out;
-		}
-
-		if (!cowonly) {
-			rb_node = tree_insert(&cache->rb_root, upper->bytenr,
-					      &upper->rb_node);
-			if (rb_node)
-				backref_tree_panic(rb_node, -EEXIST,
-						   upper->bytenr);
-		}
-
-		list_add_tail(&edge->list[UPPER], &upper->lower);
-
-		list_for_each_entry(edge, &upper->upper, list[LOWER])
-			list_add_tail(&edge->list[UPPER], &list);
-	}
-	/*
-	 * process useless backref nodes. backref nodes for tree leaves
-	 * are deleted from the cache. backref nodes for upper level
-	 * tree blocks are left in the cache to avoid unnecessary backref
-	 * lookup.
-	 */
-	while (!list_empty(&useless)) {
-		upper = list_entry(useless.next, struct backref_node, list);
-		list_del_init(&upper->list);
-		ASSERT(list_empty(&upper->upper));
-		if (upper == node)
-			node = NULL;
-		if (upper->lowest) {
-			list_del_init(&upper->lower);
-			upper->lowest = 0;
-		}
-		while (!list_empty(&upper->lower)) {
-			edge = list_entry(upper->lower.next,
-					  struct backref_edge, list[UPPER]);
-			list_del(&edge->list[UPPER]);
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
-
-			if (list_empty(&lower->upper))
-				list_add(&lower->list, &useless);
-		}
-		__mark_block_processed(rc, upper);
-		if (upper->level > 0) {
-			list_add(&upper->list, &cache->detached);
-			upper->detached = 1;
-		} else {
-			rb_erase(&upper->rb_node, &cache->rb_root);
-			free_backref_node(cache, upper);
-		}
-	}
-out:
-	btrfs_free_path(path1);
-	btrfs_free_path(path2);
-	if (err) {
-		while (!list_empty(&useless)) {
-			lower = list_entry(useless.next,
-					   struct backref_node, list);
-			list_del_init(&lower->list);
-		}
-		while (!list_empty(&list)) {
-			edge = list_first_entry(&list, struct backref_edge,
-						list[UPPER]);
-			list_del(&edge->list[UPPER]);
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			upper = edge->node[UPPER];
-			free_backref_edge(cache, edge);
-
-			/*
-			 * Lower is no longer linked to any upper backref nodes
-			 * and isn't in the cache, we can free it ourselves.
-			 */
-			if (list_empty(&lower->upper) &&
-			    RB_EMPTY_NODE(&lower->rb_node))
-				list_add(&lower->list, &useless);
-
-			if (!RB_EMPTY_NODE(&upper->rb_node))
-				continue;
-
-			/* Add this guy's upper edges to the list to process */
-			list_for_each_entry(edge, &upper->upper, list[LOWER])
-				list_add_tail(&edge->list[UPPER], &list);
-			if (list_empty(&upper->upper))
-				list_add(&upper->list, &useless);
-		}
-
-		while (!list_empty(&useless)) {
-			lower = list_entry(useless.next,
-					   struct backref_node, list);
-			list_del_init(&lower->list);
-			if (lower == node)
-				node = NULL;
-			free_backref_node(cache, lower);
-		}
-
-		free_backref_node(cache, node);
-		return ERR_PTR(err);
-	}
-	ASSERT(!node || !node->detached);
-	return node;
-}
-
 /*
  * helper to add backref node for the newly created snapshot.
  * the backref node is created by cloning backref node that
@@ -1552,8 +561,7 @@ static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
 	return NULL;
 }
 
-static int in_block_group(u64 bytenr,
-			  struct btrfs_block_group_cache *block_group)
+int in_block_group(u64 bytenr, struct btrfs_block_group_cache *block_group)
 {
 	if (bytenr >= block_group->key.objectid &&
 	    bytenr < block_group->key.objectid + block_group->key.offset)
@@ -2926,25 +1934,6 @@ static int finish_pending_nodes(struct btrfs_trans_handle *trans,
 	return err;
 }
 
-static void mark_block_processed(struct reloc_control *rc,
-				 u64 bytenr, u32 blocksize)
-{
-	set_extent_bits(&rc->processed_blocks, bytenr, bytenr + blocksize - 1,
-			EXTENT_DIRTY);
-}
-
-static void __mark_block_processed(struct reloc_control *rc,
-				   struct backref_node *node)
-{
-	u32 blocksize;
-	if (node->level == 0 ||
-	    in_block_group(node->bytenr, rc->block_group)) {
-		blocksize = rc->extent_root->fs_info->nodesize;
-		mark_block_processed(rc, node->bytenr, blocksize);
-	}
-	node->processed = 1;
-}
-
 /*
  * mark a block and all blocks directly/indirectly reference the block
  * as processed.
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
new file mode 100644
index 000000000000..6f6b0d85ea45
--- /dev/null
+++ b/fs/btrfs/relocation.h
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 SUSE.  All rights reserved.
+ */
+
+#ifndef BTRFS_RELOCATION_H
+#define BTRFS_RELOCATION_H
+
+#include "backref-cache.h"
+
+/*
+ * map address of tree root to tree
+ */
+struct mapping_node {
+	struct rb_node rb_node;
+	u64 bytenr;
+	void *data;
+};
+
+struct mapping_tree {
+	struct rb_root rb_root;
+	spinlock_t lock;
+};
+
+#define MAX_EXTENTS 128
+
+struct file_extent_cluster {
+	u64 start;
+	u64 end;
+	u64 boundary[MAX_EXTENTS];
+	unsigned int nr;
+};
+
+struct reloc_control {
+	/* block group to relocate */
+	struct btrfs_block_group_cache *block_group;
+	/* extent tree */
+	struct btrfs_root *extent_root;
+	/* inode for moving data */
+	struct inode *data_inode;
+
+	struct btrfs_block_rsv *block_rsv;
+
+	struct backref_cache backref_cache;
+
+	struct file_extent_cluster cluster;
+	/* tree blocks have been processed */
+	struct extent_io_tree processed_blocks;
+	/* map start of tree root to corresponding reloc tree */
+	struct mapping_tree reloc_root_tree;
+	/* list of reloc trees */
+	struct list_head reloc_roots;
+	/* list of subvolume trees that get relocated */
+	struct list_head dirty_subvol_roots;
+	/* size of metadata reservation for merging reloc trees */
+	u64 merging_rsv_size;
+	/* size of relocated tree nodes */
+	u64 nodes_relocated;
+	/* reserved size for block group relocation*/
+	u64 reserved_bytes;
+
+	u64 search_start;
+	u64 extents_found;
+
+	unsigned int stage:8;
+	unsigned int create_reloc_tree:1;
+	unsigned int merge_reloc_tree:1;
+	unsigned int found_file_extent:1;
+};
+
+/* stages of data relocation */
+#define MOVE_DATA_EXTENTS	0
+#define UPDATE_DATA_PTRS	1
+
+/* for backref-cache.c */
+int is_cowonly_root(u64 root_objectid);
+struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
+				u64 root_objectid);
+int in_block_group(u64 bytenr, struct btrfs_block_group_cache *block_group);
+
+struct rb_node *tree_insert(struct rb_root *root, u64 bytenr,
+			    struct rb_node *node);
+struct rb_node *tree_search(struct rb_root *root, u64 bytenr);
+
+#endif /* BTRFS_RELOCATION_H */
-- 
2.22.1

