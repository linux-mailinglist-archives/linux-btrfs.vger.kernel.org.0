Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DBA1B37DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDVGui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:50:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDVGui (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:50:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AFB3FAC1D;
        Wed, 22 Apr 2020 06:50:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 05/26] fs: btrfs: Cross-port extent-cache.[ch] from btrfs-progs
Date:   Wed, 22 Apr 2020 14:49:48 +0800
Message-Id: <20200422065009.69392-6-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch implements an infrastructure to insert/search/merge an extent
range (with variable length).

This provides the basis for later extent buffer cache used in btrfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-cache.c | 318 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-cache.h | 104 +++++++++++++
 2 files changed, 422 insertions(+)
 create mode 100644 fs/btrfs/extent-cache.c
 create mode 100644 fs/btrfs/extent-cache.h

diff --git a/fs/btrfs/extent-cache.c b/fs/btrfs/extent-cache.c
new file mode 100644
index 000000000000..e7b055f55422
--- /dev/null
+++ b/fs/btrfs/extent-cache.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Cross-ported from the same named file of btrfs-progs.
+ *
+ * Minor modification to include headers.
+ */
+#include <linux/kernel.h>
+#include <linux/rbtree.h>
+#include <linux/errno.h>
+#include <linux/bug.h>
+#include <stdlib.h>
+#include "extent-cache.h"
+#include "common/rbtree-utils.h"
+
+struct cache_extent_search_range {
+	u64 objectid;
+	u64 start;
+	u64 size;
+};
+
+static int cache_tree_comp_range(struct rb_node *node, void *data)
+{
+	struct cache_extent *entry;
+	struct cache_extent_search_range *range;
+
+	range = (struct cache_extent_search_range *)data;
+	entry = rb_entry(node, struct cache_extent, rb_node);
+
+	if (entry->start + entry->size <= range->start)
+		return 1;
+	else if (range->start + range->size <= entry->start)
+		return -1;
+	else
+		return 0;
+}
+
+static int cache_tree_comp_nodes(struct rb_node *node1, struct rb_node *node2)
+{
+	struct cache_extent *entry;
+	struct cache_extent_search_range range;
+
+	entry = rb_entry(node2, struct cache_extent, rb_node);
+	range.start = entry->start;
+	range.size = entry->size;
+
+	return cache_tree_comp_range(node1, (void *)&range);
+}
+
+static int cache_tree_comp_range2(struct rb_node *node, void *data)
+{
+	struct cache_extent *entry;
+	struct cache_extent_search_range *range;
+
+	range = (struct cache_extent_search_range *)data;
+	entry = rb_entry(node, struct cache_extent, rb_node);
+
+	if (entry->objectid < range->objectid)
+		return 1;
+	else if (entry->objectid > range->objectid)
+		return -1;
+	else if (entry->start + entry->size <= range->start)
+		return 1;
+	else if (range->start + range->size <= entry->start)
+		return -1;
+	else
+		return 0;
+}
+
+static int cache_tree_comp_nodes2(struct rb_node *node1, struct rb_node *node2)
+{
+	struct cache_extent *entry;
+	struct cache_extent_search_range range;
+
+	entry = rb_entry(node2, struct cache_extent, rb_node);
+	range.objectid = entry->objectid;
+	range.start = entry->start;
+	range.size = entry->size;
+
+	return cache_tree_comp_range2(node1, (void *)&range);
+}
+
+void cache_tree_init(struct cache_tree *tree)
+{
+	tree->root = RB_ROOT;
+}
+
+static struct cache_extent *alloc_cache_extent(u64 start, u64 size)
+{
+	struct cache_extent *pe = malloc(sizeof(*pe));
+
+	if (!pe)
+		return pe;
+
+	pe->objectid = 0;
+	pe->start = start;
+	pe->size = size;
+	return pe;
+}
+
+int add_cache_extent(struct cache_tree *tree, u64 start, u64 size)
+{
+	struct cache_extent *pe = alloc_cache_extent(start, size);
+	int ret;
+
+	if (!pe)
+		return -ENOMEM;
+
+	ret = insert_cache_extent(tree, pe);
+	if (ret)
+		free(pe);
+
+	return ret;
+}
+
+int insert_cache_extent(struct cache_tree *tree, struct cache_extent *pe)
+{
+	return rb_insert(&tree->root, &pe->rb_node, cache_tree_comp_nodes);
+}
+
+int insert_cache_extent2(struct cache_tree *tree, struct cache_extent *pe)
+{
+	return rb_insert(&tree->root, &pe->rb_node, cache_tree_comp_nodes2);
+}
+
+struct cache_extent *lookup_cache_extent(struct cache_tree *tree,
+					 u64 start, u64 size)
+{
+	struct rb_node *node;
+	struct cache_extent *entry;
+	struct cache_extent_search_range range;
+
+	range.start = start;
+	range.size = size;
+	node = rb_search(&tree->root, &range, cache_tree_comp_range, NULL);
+	if (!node)
+		return NULL;
+
+	entry = rb_entry(node, struct cache_extent, rb_node);
+	return entry;
+}
+
+struct cache_extent *lookup_cache_extent2(struct cache_tree *tree,
+					 u64 objectid, u64 start, u64 size)
+{
+	struct rb_node *node;
+	struct cache_extent *entry;
+	struct cache_extent_search_range range;
+
+	range.objectid = objectid;
+	range.start = start;
+	range.size = size;
+	node = rb_search(&tree->root, &range, cache_tree_comp_range2, NULL);
+	if (!node)
+		return NULL;
+
+	entry = rb_entry(node, struct cache_extent, rb_node);
+	return entry;
+}
+
+struct cache_extent *search_cache_extent(struct cache_tree *tree, u64 start)
+{
+	struct rb_node *next;
+	struct rb_node *node;
+	struct cache_extent *entry;
+	struct cache_extent_search_range range;
+
+	range.start = start;
+	range.size = 1;
+	node = rb_search(&tree->root, &range, cache_tree_comp_range, &next);
+	if (!node)
+		node = next;
+	if (!node)
+		return NULL;
+
+	entry = rb_entry(node, struct cache_extent, rb_node);
+	return entry;
+}
+
+struct cache_extent *search_cache_extent2(struct cache_tree *tree,
+					 u64 objectid, u64 start)
+{
+	struct rb_node *next;
+	struct rb_node *node;
+	struct cache_extent *entry;
+	struct cache_extent_search_range range;
+
+	range.objectid = objectid;
+	range.start = start;
+	range.size = 1;
+	node = rb_search(&tree->root, &range, cache_tree_comp_range2, &next);
+	if (!node)
+		node = next;
+	if (!node)
+		return NULL;
+
+	entry = rb_entry(node, struct cache_extent, rb_node);
+	return entry;
+}
+
+struct cache_extent *first_cache_extent(struct cache_tree *tree)
+{
+	struct rb_node *node = rb_first(&tree->root);
+
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct cache_extent, rb_node);
+}
+
+struct cache_extent *last_cache_extent(struct cache_tree *tree)
+{
+	struct rb_node *node = rb_last(&tree->root);
+
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct cache_extent, rb_node);
+}
+
+struct cache_extent *prev_cache_extent(struct cache_extent *pe)
+{
+	struct rb_node *node = rb_prev(&pe->rb_node);
+
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct cache_extent, rb_node);
+}
+
+struct cache_extent *next_cache_extent(struct cache_extent *pe)
+{
+	struct rb_node *node = rb_next(&pe->rb_node);
+
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct cache_extent, rb_node);
+}
+
+void remove_cache_extent(struct cache_tree *tree, struct cache_extent *pe)
+{
+	rb_erase(&pe->rb_node, &tree->root);
+}
+
+void cache_tree_free_extents(struct cache_tree *tree,
+			     free_cache_extent free_func)
+{
+	struct cache_extent *ce;
+
+	while ((ce = first_cache_extent(tree))) {
+		remove_cache_extent(tree, ce);
+		free_func(ce);
+	}
+}
+
+static void free_extent_cache(struct cache_extent *pe)
+{
+	free(pe);
+}
+
+void free_extent_cache_tree(struct cache_tree *tree)
+{
+	cache_tree_free_extents(tree, free_extent_cache);
+}
+
+int add_merge_cache_extent(struct cache_tree *tree, u64 start, u64 size)
+{
+	struct cache_extent *cache;
+	struct cache_extent *next = NULL;
+	struct cache_extent *prev = NULL;
+	int next_merged = 0;
+	int prev_merged = 0;
+	int ret = 0;
+
+	if (cache_tree_empty(tree))
+		goto insert;
+
+	cache = search_cache_extent(tree, start);
+	if (!cache) {
+		/*
+		 * Either the tree is completely empty, or the no range after
+		 * start.
+		 * Either way, the last cache_extent should be prev.
+		 */
+		prev = last_cache_extent(tree);
+	} else if (start <= cache->start) {
+		next = cache;
+		prev = prev_cache_extent(cache);
+	} else {
+		prev = cache;
+		next = next_cache_extent(cache);
+	}
+
+	/*
+	 * Ensure the range to be inserted won't cover with existings
+	 * Or we will need extra loop to do merge
+	 */
+	BUG_ON(next && start + size > next->start);
+	BUG_ON(prev && prev->start + prev->size > start);
+
+	if (next && start + size == next->start) {
+		next_merged = 1;
+		next->size = next->start + next->size - start;
+		next->start = start;
+	}
+	if (prev && prev->start + prev->size == start) {
+		prev_merged = 1;
+		if (next_merged) {
+			next->size = next->start + next->size - prev->start;
+			next->start = prev->start;
+			remove_cache_extent(tree, prev);
+			free(prev);
+		} else {
+			prev->size = start + size - prev->start;
+		}
+	}
+insert:
+	if (!prev_merged && !next_merged)
+		ret = add_cache_extent(tree, start, size);
+	return ret;
+}
diff --git a/fs/btrfs/extent-cache.h b/fs/btrfs/extent-cache.h
new file mode 100644
index 000000000000..b6acd09fe983
--- /dev/null
+++ b/fs/btrfs/extent-cache.h
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Cross-ported from the same named file of btrfs-progs.
+ *
+ * Minor modification to include headers.
+ */
+#ifndef __BTRFS_EXTENT_CACHE_H__
+#define __BTRFS_EXTENT_CACHE_H__
+
+#include <linux/rbtree.h>
+#include <linux/types.h>
+
+struct cache_tree {
+	struct rb_root root;
+};
+
+struct cache_extent {
+	struct rb_node rb_node;
+	u64 objectid;
+	u64 start;
+	u64 size;
+};
+
+void cache_tree_init(struct cache_tree *tree);
+
+struct cache_extent *first_cache_extent(struct cache_tree *tree);
+struct cache_extent *last_cache_extent(struct cache_tree *tree);
+struct cache_extent *prev_cache_extent(struct cache_extent *pe);
+struct cache_extent *next_cache_extent(struct cache_extent *pe);
+
+/*
+ * Find a cache_extent which covers start.
+ *
+ * If not found, return next cache_extent if possible.
+ */
+struct cache_extent *search_cache_extent(struct cache_tree *tree, u64 start);
+
+/*
+ * Find a cache_extent which restrictly covers start.
+ *
+ * If not found, return NULL.
+ */
+struct cache_extent *lookup_cache_extent(struct cache_tree *tree,
+					 u64 start, u64 size);
+
+/*
+ * Add an non-overlap extent into cache tree
+ *
+ * If [start, start+size) overlap with existing one, it will return -EEXIST.
+ */
+int add_cache_extent(struct cache_tree *tree, u64 start, u64 size);
+
+/*
+ * Same with add_cache_extent, but with cache_extent strcut.
+ */
+int insert_cache_extent(struct cache_tree *tree, struct cache_extent *pe);
+void remove_cache_extent(struct cache_tree *tree, struct cache_extent *pe);
+
+static inline int cache_tree_empty(struct cache_tree *tree)
+{
+	return RB_EMPTY_ROOT(&tree->root);
+}
+
+typedef void (*free_cache_extent)(struct cache_extent *pe);
+
+void cache_tree_free_extents(struct cache_tree *tree,
+			     free_cache_extent free_func);
+
+#define FREE_EXTENT_CACHE_BASED_TREE(name, free_func)		\
+static void free_##name##_tree(struct cache_tree *tree)		\
+{								\
+	cache_tree_free_extents(tree, free_func);		\
+}
+
+void free_extent_cache_tree(struct cache_tree *tree);
+
+/*
+ * Search a cache_extent with same objectid, and covers start.
+ *
+ * If not found, return next if possible.
+ */
+struct cache_extent *search_cache_extent2(struct cache_tree *tree,
+					  u64 objectid, u64 start);
+/*
+ * Search a cache_extent with same objectid, and covers the range
+ * [start, start + size)
+ *
+ * If not found, return next cache_extent if possible.
+ */
+struct cache_extent *lookup_cache_extent2(struct cache_tree *tree,
+					  u64 objectid, u64 start, u64 size);
+int insert_cache_extent2(struct cache_tree *tree, struct cache_extent *pe);
+
+/*
+ * Insert a cache_extent range [start, start + size).
+ *
+ * This function may merge with existing cache_extent.
+ * NOTE: caller must ensure the inserted range won't cover with any existing
+ * range.
+ */
+int add_merge_cache_extent(struct cache_tree *tree, u64 start, u64 size);
+
+#endif
-- 
2.26.0

