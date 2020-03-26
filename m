Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45772193AEC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZId4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbgCZIdz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16472ACAE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:33:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/39] btrfs: relocation: Add btrfs_ prefix for backref_node/edge/cache
Date:   Thu, 26 Mar 2020 16:32:52 +0800
Message-Id: <20200326083316.48847-16-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those three structures are the main elements of backref cache. Add the
"btrfs_" prefix for later export.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 282 +++++++++++++++++++++---------------------
 1 file changed, 143 insertions(+), 139 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 663b782f8de1..94a000ea2759 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -73,7 +73,7 @@
  */
 
 /*
- * backref_node, mapping_node and tree_block start with this
+ * btrfs_backref_node, mapping_node and tree_block start with this
  */
 struct tree_entry {
 	struct rb_node rb_node;
@@ -83,7 +83,7 @@ struct tree_entry {
 /*
  * present a tree block in the backref cache
  */
-struct backref_node {
+struct btrfs_backref_node {
 	struct rb_node rb_node;
 	u64 bytenr;
 
@@ -138,10 +138,11 @@ struct backref_node {
 /*
  * present an edge connecting upper and lower backref nodes.
  */
-struct backref_edge {
+struct btrfs_backref_edge {
 	/*
-	 * list[LOWER] is linked to backref_node::upper of lower level node,
-	 * and list[UPPER] is linked to backref_node::lower of upper level node.
+	 * list[LOWER] is linked to btrfs_backref_node::upper of lower level
+	 * node, and list[UPPER] is linked to btrfs_backref_node::lower of
+	 * upper level node.
 	 *
 	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
 	 * linking list[UPPER] to its upper level nodes.
@@ -149,15 +150,15 @@ struct backref_edge {
 	struct list_head list[2];
 
 	/* Two related nodes */
-	struct backref_node *node[2];
+	struct btrfs_backref_node *node[2];
 };
 
 
-struct backref_cache {
+struct btrfs_backref_cache {
 	/* red black tree of all backref nodes in the cache */
 	struct rb_root rb_root;
 	/* for passing backref nodes to btrfs_reloc_cow_block */
-	struct backref_node *path[BTRFS_MAX_LEVEL];
+	struct btrfs_backref_node *path[BTRFS_MAX_LEVEL];
 	/*
 	 * list of blocks that have been cowed but some block
 	 * pointers in upper level blocks may not reflect the
@@ -237,7 +238,7 @@ struct reloc_control {
 
 	struct btrfs_block_rsv *block_rsv;
 
-	struct backref_cache backref_cache;
+	struct btrfs_backref_cache backref_cache;
 
 	struct file_extent_cluster cluster;
 	/* tree blocks have been processed */
@@ -268,11 +269,11 @@ struct reloc_control {
 #define MOVE_DATA_EXTENTS	0
 #define UPDATE_DATA_PTRS	1
 
-static void remove_backref_node(struct backref_cache *cache,
-				struct backref_node *node);
+static void remove_backref_node(struct btrfs_backref_cache *cache,
+				struct btrfs_backref_node *node);
 
 static void mark_block_processed(struct reloc_control *rc,
-				 struct backref_node *node)
+				 struct btrfs_backref_node *node)
 {
 	u32 blocksize;
 
@@ -294,7 +295,7 @@ static void mapping_tree_init(struct mapping_tree *tree)
 }
 
 static void backref_cache_init(struct btrfs_fs_info *fs_info,
-			       struct backref_cache *cache, int is_reloc)
+			       struct btrfs_backref_cache *cache, int is_reloc)
 {
 	int i;
 	cache->rb_root = RB_ROOT;
@@ -309,20 +310,20 @@ static void backref_cache_init(struct btrfs_fs_info *fs_info,
 	cache->is_reloc = is_reloc;
 }
 
-static void backref_cache_cleanup(struct backref_cache *cache)
+static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
 {
-	struct backref_node *node;
+	struct btrfs_backref_node *node;
 	int i;
 
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
-				  struct backref_node, list);
+				  struct btrfs_backref_node, list);
 		remove_backref_node(cache, node);
 	}
 
 	while (!list_empty(&cache->leaves)) {
 		node = list_entry(cache->leaves.next,
-				  struct backref_node, lower);
+				  struct btrfs_backref_node, lower);
 		remove_backref_node(cache, node);
 	}
 
@@ -339,10 +340,10 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static struct backref_node *alloc_backref_node(struct backref_cache *cache,
-						u64 bytenr, int level)
+static struct btrfs_backref_node *alloc_backref_node(
+		struct btrfs_backref_cache *cache, u64 bytenr, int level)
 {
-	struct backref_node *node;
+	struct btrfs_backref_node *node;
 
 	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
 	node = kzalloc(sizeof(*node), GFP_NOFS);
@@ -359,8 +360,8 @@ static struct backref_node *alloc_backref_node(struct backref_cache *cache,
 	return node;
 }
 
-static void free_backref_node(struct backref_cache *cache,
-			      struct backref_node *node)
+static void free_backref_node(struct btrfs_backref_cache *cache,
+			      struct btrfs_backref_node *node)
 {
 	if (node) {
 		cache->nr_nodes--;
@@ -369,9 +370,10 @@ static void free_backref_node(struct backref_cache *cache,
 	}
 }
 
-static struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
+static struct btrfs_backref_edge *alloc_backref_edge(
+		struct btrfs_backref_cache *cache)
 {
-	struct backref_edge *edge;
+	struct btrfs_backref_edge *edge;
 
 	edge = kzalloc(sizeof(*edge), GFP_NOFS);
 	if (edge)
@@ -381,9 +383,9 @@ static struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
 
 #define		LINK_LOWER	(1 << 0)
 #define		LINK_UPPER	(1 << 1)
-static void link_backref_edge(struct backref_edge *edge,
-			      struct backref_node *lower,
-			      struct backref_node *upper,
+static void link_backref_edge(struct btrfs_backref_edge *edge,
+			      struct btrfs_backref_node *lower,
+			      struct btrfs_backref_node *upper,
 			      int link_which)
 {
 	ASSERT(upper && lower && upper->level == lower->level + 1);
@@ -395,8 +397,8 @@ static void link_backref_edge(struct backref_edge *edge,
 		list_add_tail(&edge->list[UPPER], &upper->lower);
 }
 
-static void free_backref_edge(struct backref_cache *cache,
-			      struct backref_edge *edge)
+static void free_backref_edge(struct btrfs_backref_cache *cache,
+			      struct btrfs_backref_edge *edge)
 {
 	if (edge) {
 		cache->nr_edges--;
@@ -450,8 +452,8 @@ static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
 {
 
 	struct btrfs_fs_info *fs_info = NULL;
-	struct backref_node *bnode = rb_entry(rb_node, struct backref_node,
-					      rb_node);
+	struct btrfs_backref_node *bnode = rb_entry(rb_node,
+			struct btrfs_backref_node, rb_node);
 	if (bnode->root)
 		fs_info = bnode->root->fs_info;
 	btrfs_panic(fs_info, errno,
@@ -462,16 +464,16 @@ static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
 /*
  * walk up backref nodes until reach node presents tree root
  */
-static struct backref_node *walk_up_backref(struct backref_node *node,
-					    struct backref_edge *edges[],
-					    int *index)
+static struct btrfs_backref_node *walk_up_backref(
+		struct btrfs_backref_node *node,
+		struct btrfs_backref_edge *edges[], int *index)
 {
-	struct backref_edge *edge;
+	struct btrfs_backref_edge *edge;
 	int idx = *index;
 
 	while (!list_empty(&node->upper)) {
 		edge = list_entry(node->upper.next,
-				  struct backref_edge, list[LOWER]);
+				  struct btrfs_backref_edge, list[LOWER]);
 		edges[idx++] = edge;
 		node = edge->node[UPPER];
 	}
@@ -483,11 +485,11 @@ static struct backref_node *walk_up_backref(struct backref_node *node,
 /*
  * walk down backref nodes to find start of next reference path
  */
-static struct backref_node *walk_down_backref(struct backref_edge *edges[],
-					      int *index)
+static struct btrfs_backref_node *walk_down_backref(
+		struct btrfs_backref_edge *edges[], int *index)
 {
-	struct backref_edge *edge;
-	struct backref_node *lower;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_node *lower;
 	int idx = *index;
 
 	while (idx > 0) {
@@ -498,7 +500,7 @@ static struct backref_node *walk_down_backref(struct backref_edge *edges[],
 			continue;
 		}
 		edge = list_entry(edge->list[LOWER].next,
-				  struct backref_edge, list[LOWER]);
+				  struct btrfs_backref_edge, list[LOWER]);
 		edges[idx - 1] = edge;
 		*index = idx;
 		return edge->node[UPPER];
@@ -507,7 +509,7 @@ static struct backref_node *walk_down_backref(struct backref_edge *edges[],
 	return NULL;
 }
 
-static void unlock_node_buffer(struct backref_node *node)
+static void unlock_node_buffer(struct btrfs_backref_node *node)
 {
 	if (node->locked) {
 		btrfs_tree_unlock(node->eb);
@@ -515,7 +517,7 @@ static void unlock_node_buffer(struct backref_node *node)
 	}
 }
 
-static void drop_node_buffer(struct backref_node *node)
+static void drop_node_buffer(struct btrfs_backref_node *node)
 {
 	if (node->eb) {
 		unlock_node_buffer(node);
@@ -524,8 +526,8 @@ static void drop_node_buffer(struct backref_node *node)
 	}
 }
 
-static void drop_backref_node(struct backref_cache *tree,
-			      struct backref_node *node)
+static void drop_backref_node(struct btrfs_backref_cache *tree,
+			      struct btrfs_backref_node *node)
 {
 	BUG_ON(!list_empty(&node->upper));
 
@@ -540,18 +542,18 @@ static void drop_backref_node(struct backref_cache *tree,
 /*
  * remove a backref node from the backref cache
  */
-static void remove_backref_node(struct backref_cache *cache,
-				struct backref_node *node)
+static void remove_backref_node(struct btrfs_backref_cache *cache,
+				struct btrfs_backref_node *node)
 {
-	struct backref_node *upper;
-	struct backref_edge *edge;
+	struct btrfs_backref_node *upper;
+	struct btrfs_backref_edge *edge;
 
 	if (!node)
 		return;
 
 	BUG_ON(!node->lowest && !node->detached);
 	while (!list_empty(&node->upper)) {
-		edge = list_entry(node->upper.next, struct backref_edge,
+		edge = list_entry(node->upper.next, struct btrfs_backref_edge,
 				  list[LOWER]);
 		upper = edge->node[UPPER];
 		list_del(&edge->list[LOWER]);
@@ -578,8 +580,8 @@ static void remove_backref_node(struct backref_cache *cache,
 	drop_backref_node(cache, node);
 }
 
-static void update_backref_node(struct backref_cache *cache,
-				struct backref_node *node, u64 bytenr)
+static void update_backref_node(struct btrfs_backref_cache *cache,
+				struct btrfs_backref_node *node, u64 bytenr)
 {
 	struct rb_node *rb_node;
 	rb_erase(&node->rb_node, &cache->rb_root);
@@ -593,9 +595,9 @@ static void update_backref_node(struct backref_cache *cache,
  * update backref cache after a transaction commit
  */
 static int update_backref_cache(struct btrfs_trans_handle *trans,
-				struct backref_cache *cache)
+				struct btrfs_backref_cache *cache)
 {
-	struct backref_node *node;
+	struct btrfs_backref_node *node;
 	int level = 0;
 
 	if (cache->last_trans == 0) {
@@ -613,13 +615,13 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	 */
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
-				  struct backref_node, list);
+				  struct btrfs_backref_node, list);
 		remove_backref_node(cache, node);
 	}
 
 	while (!list_empty(&cache->changed)) {
 		node = list_entry(cache->changed.next,
-				  struct backref_node, list);
+				  struct btrfs_backref_node, list);
 		list_del_init(&node->list);
 		BUG_ON(node->pending);
 		update_backref_node(cache, node, node->new_bytenr);
@@ -742,12 +744,12 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
  *		type is btrfs_inline_ref_type, offset is
  *		btrfs_inline_ref_offset.
  */
-static int handle_direct_tree_backref(struct backref_cache *cache,
+static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 				      struct btrfs_key *ref_key,
-				      struct backref_node *cur)
+				      struct btrfs_backref_node *cur)
 {
-	struct backref_edge *edge;
-	struct backref_node *upper;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_node *upper;
 	struct rb_node *rb_node;
 
 	ASSERT(ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY);
@@ -794,7 +796,7 @@ static int handle_direct_tree_backref(struct backref_cache *cache,
 		list_add_tail(&edge->list[UPPER], &cache->pending_edge);
 	} else {
 		/* Parent node already cached */
-		upper = rb_entry(rb_node, struct backref_node,
+		upper = rb_entry(rb_node, struct btrfs_backref_node,
 				 rb_node);
 		ASSERT(upper->checked);
 		INIT_LIST_HEAD(&edge->list[UPPER]);
@@ -815,16 +817,16 @@ static int handle_direct_tree_backref(struct backref_cache *cache,
  * @path:	A clean (released) path, to avoid allocating path everytime
  *		the function get called.
  */
-static int handle_indirect_tree_backref(struct backref_cache *cache,
+static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 					struct btrfs_path *path,
 					struct btrfs_key *ref_key,
 					struct btrfs_key *tree_key,
-					struct backref_node *cur)
+					struct btrfs_backref_node *cur)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct backref_node *upper;
-	struct backref_node *lower;
-	struct backref_edge *edge;
+	struct btrfs_backref_node *upper;
+	struct btrfs_backref_node *lower;
+	struct btrfs_backref_edge *edge;
 	struct extent_buffer *eb;
 	struct btrfs_root *root;
 	struct rb_node *rb_node;
@@ -937,7 +939,8 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 				INIT_LIST_HEAD(&edge->list[UPPER]);
 			}
 		} else {
-			upper = rb_entry(rb_node, struct backref_node, rb_node);
+			upper = rb_entry(rb_node, struct btrfs_backref_node,
+					 rb_node);
 			ASSERT(upper->checked);
 			INIT_LIST_HEAD(&edge->list[UPPER]);
 			if (!upper->owner)
@@ -957,15 +960,15 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 	return ret;
 }
 
-static int handle_one_tree_block(struct backref_cache *cache,
+static int handle_one_tree_block(struct btrfs_backref_cache *cache,
 				 struct btrfs_path *path,
 				 struct btrfs_backref_iter *iter,
 				 struct btrfs_key *node_key,
-				 struct backref_node *cur)
+				 struct btrfs_backref_node *cur)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct backref_edge *edge;
-	struct backref_node *exist;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_node *exist;
 	int ret;
 
 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
@@ -992,7 +995,7 @@ static int handle_one_tree_block(struct backref_cache *cache,
 		 * backref of type BTRFS_TREE_BLOCK_REF_KEY
 		 */
 		ASSERT(list_is_singular(&cur->upper));
-		edge = list_entry(cur->upper.next, struct backref_edge,
+		edge = list_entry(cur->upper.next, struct btrfs_backref_edge,
 				  list[LOWER]);
 		ASSERT(list_empty(&edge->list[UPPER]));
 		exist = edge->node[UPPER];
@@ -1083,19 +1086,20 @@ static int handle_one_tree_block(struct backref_cache *cache,
 /*
  * In handle_one_tree_backref(), we have only linked the lower node to the edge,
  * but the upper node hasn't been linked to the edge.
- * This means we can only iterate through backref_node::upper to reach parent
- * edges, but not through backref_node::lower to reach children edges.
+ * This means we can only iterate through btrfs_backref_node::upper to reach
+ * parent edges, but not through btrfs_backref_node::lower to reach children
+ * edges.
  *
- * This function will finish the backref_node::lower to related edges, so that
- * backref cache can be bi-directionally iterated.
+ * This function will finish the btrfs_backref_node::lower to related edges,
+ * so that backref cache can be bi-directionally iterated.
  *
  * Also, this will add the nodes to backref cache for next run.
  */
-static int finish_upper_links(struct backref_cache *cache,
-			      struct backref_node *start)
+static int finish_upper_links(struct btrfs_backref_cache *cache,
+			      struct btrfs_backref_node *start)
 {
 	struct list_head *useless_node = &cache->useless_node;
-	struct backref_edge *edge;
+	struct btrfs_backref_edge *edge;
 	struct rb_node *rb_node;
 	LIST_HEAD(pending_edge);
 
@@ -1119,12 +1123,12 @@ static int finish_upper_links(struct backref_cache *cache,
 		list_add_tail(&edge->list[UPPER], &pending_edge);
 
 	while (!list_empty(&pending_edge)) {
-		struct backref_node *upper;
-		struct backref_node *lower;
+		struct btrfs_backref_node *upper;
+		struct btrfs_backref_node *lower;
 		struct rb_node *rb_node;
 
-		edge = list_first_entry(&pending_edge, struct backref_edge,
-				  list[UPPER]);
+		edge = list_first_entry(&pending_edge,
+				struct btrfs_backref_edge, list[UPPER]);
 		list_del_init(&edge->list[UPPER]);
 		upper = edge->node[UPPER];
 		lower = edge->node[LOWER];
@@ -1205,16 +1209,16 @@ static int finish_upper_links(struct backref_cache *cache,
  * Return true if @node is in the @useless_nodes list.
  */
 static bool handle_useless_nodes(struct reloc_control *rc,
-				 struct backref_node *node)
+				 struct btrfs_backref_node *node)
 {
-	struct backref_cache *cache = &rc->backref_cache;
+	struct btrfs_backref_cache *cache = &rc->backref_cache;
 	struct list_head *useless_node = &cache->useless_node;
 	bool ret = false;
 
 	while (!list_empty(useless_node)) {
-		struct backref_node *cur;
+		struct btrfs_backref_node *cur;
 
-		cur = list_first_entry(useless_node, struct backref_node,
+		cur = list_first_entry(useless_node, struct btrfs_backref_node,
 				 list);
 		list_del_init(&cur->list);
 
@@ -1232,11 +1236,11 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 
 		/* Cleanup the lower edges */
 		while (!list_empty(&cur->lower)) {
-			struct backref_edge *edge;
-			struct backref_node *lower;
+			struct btrfs_backref_edge *edge;
+			struct btrfs_backref_node *lower;
 
 			edge = list_entry(cur->lower.next,
-					  struct backref_edge, list[UPPER]);
+					struct btrfs_backref_edge, list[UPPER]);
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
@@ -1280,18 +1284,18 @@ static bool handle_useless_nodes(struct reloc_control *rc,
  * block are also cached.
  */
 static noinline_for_stack
-struct backref_node *build_backref_tree(struct reloc_control *rc,
-					struct btrfs_key *node_key,
-					int level, u64 bytenr)
+struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
+					      struct btrfs_key *node_key,
+					      int level, u64 bytenr)
 {
 	struct btrfs_backref_iter *iter;
-	struct backref_cache *cache = &rc->backref_cache;
+	struct btrfs_backref_cache *cache = &rc->backref_cache;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
-	struct backref_node *cur;
-	struct backref_node *upper;
-	struct backref_node *lower;
-	struct backref_node *node = NULL;
-	struct backref_edge *edge;
+	struct btrfs_backref_node *cur;
+	struct btrfs_backref_node *upper;
+	struct btrfs_backref_node *lower;
+	struct btrfs_backref_node *node = NULL;
+	struct btrfs_backref_edge *edge;
 	int ret;
 	int err = 0;
 
@@ -1321,7 +1325,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			goto out;
 		}
 		edge = list_first_entry_or_null(&cache->pending_edge,
-				struct backref_edge, list[UPPER]);
+				struct btrfs_backref_edge, list[UPPER]);
 		/*
 		 * the pending list isn't empty, take the first block to
 		 * process
@@ -1347,12 +1351,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	if (err) {
 		while (!list_empty(&cache->useless_node)) {
 			lower = list_first_entry(&cache->useless_node,
-					   struct backref_node, list);
+					   struct btrfs_backref_node, list);
 			list_del_init(&lower->list);
 		}
 		while (!list_empty(&cache->pending_edge)) {
 			edge = list_first_entry(&cache->pending_edge,
-					struct backref_edge, list[UPPER]);
+					struct btrfs_backref_edge, list[UPPER]);
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
@@ -1380,7 +1384,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 		while (!list_empty(&cache->useless_node)) {
 			lower = list_first_entry(&cache->useless_node,
-					   struct backref_node, list);
+					   struct btrfs_backref_node, list);
 			list_del_init(&lower->list);
 			if (lower == node)
 				node = NULL;
@@ -1409,11 +1413,11 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *dest)
 {
 	struct btrfs_root *reloc_root = src->reloc_root;
-	struct backref_cache *cache = &rc->backref_cache;
-	struct backref_node *node = NULL;
-	struct backref_node *new_node;
-	struct backref_edge *edge;
-	struct backref_edge *new_edge;
+	struct btrfs_backref_cache *cache = &rc->backref_cache;
+	struct btrfs_backref_node *node = NULL;
+	struct btrfs_backref_node *new_node;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_edge *new_edge;
 	struct rb_node *rb_node;
 
 	if (cache->last_trans > 0)
@@ -1421,7 +1425,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 
 	rb_node = tree_search(&cache->rb_root, src->commit_root->start);
 	if (rb_node) {
-		node = rb_entry(rb_node, struct backref_node, rb_node);
+		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
 		if (node->detached)
 			node = NULL;
 		else
@@ -1432,7 +1436,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 		rb_node = tree_search(&cache->rb_root,
 				      reloc_root->commit_root->start);
 		if (rb_node) {
-			node = rb_entry(rb_node, struct backref_node,
+			node = rb_entry(rb_node, struct btrfs_backref_node,
 					rb_node);
 			BUG_ON(node->detached);
 		}
@@ -1478,7 +1482,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 fail:
 	while (!list_empty(&new_node->lower)) {
 		new_edge = list_entry(new_node->lower.next,
-				      struct backref_edge, list[UPPER]);
+				      struct btrfs_backref_edge, list[UPPER]);
 		list_del(&new_edge->list[UPPER]);
 		free_backref_edge(cache, new_edge);
 	}
@@ -2853,10 +2857,10 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 static noinline_for_stack
 struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 				     struct reloc_control *rc,
-				     struct backref_node *node,
-				     struct backref_edge *edges[])
+				     struct btrfs_backref_node *node,
+				     struct btrfs_backref_edge *edges[])
 {
-	struct backref_node *next;
+	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
 
@@ -2916,12 +2920,12 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
  * counted. return -ENOENT if the block is root of reloc tree.
  */
 static noinline_for_stack
-struct btrfs_root *select_one_root(struct backref_node *node)
+struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 {
-	struct backref_node *next;
+	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	struct btrfs_root *fs_root = NULL;
-	struct backref_edge *edges[BTRFS_MAX_LEVEL - 1];
+	struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
 	int index = 0;
 
 	next = node;
@@ -2953,12 +2957,12 @@ struct btrfs_root *select_one_root(struct backref_node *node)
 
 static noinline_for_stack
 u64 calcu_metadata_size(struct reloc_control *rc,
-			struct backref_node *node, int reserve)
+			struct btrfs_backref_node *node, int reserve)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct backref_node *next = node;
-	struct backref_edge *edge;
-	struct backref_edge *edges[BTRFS_MAX_LEVEL - 1];
+	struct btrfs_backref_node *next = node;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
 	u64 num_bytes = 0;
 	int index = 0;
 
@@ -2976,7 +2980,7 @@ u64 calcu_metadata_size(struct reloc_control *rc,
 				break;
 
 			edge = list_entry(next->upper.next,
-					  struct backref_edge, list[LOWER]);
+					struct btrfs_backref_edge, list[LOWER]);
 			edges[index++] = edge;
 			next = edge->node[UPPER];
 		}
@@ -2987,7 +2991,7 @@ u64 calcu_metadata_size(struct reloc_control *rc,
 
 static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 				  struct reloc_control *rc,
-				  struct backref_node *node)
+				  struct btrfs_backref_node *node)
 {
 	struct btrfs_root *root = rc->extent_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -3035,14 +3039,14 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
  */
 static int do_relocation(struct btrfs_trans_handle *trans,
 			 struct reloc_control *rc,
-			 struct backref_node *node,
+			 struct btrfs_backref_node *node,
 			 struct btrfs_key *key,
 			 struct btrfs_path *path, int lowest)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct backref_node *upper;
-	struct backref_edge *edge;
-	struct backref_edge *edges[BTRFS_MAX_LEVEL - 1];
+	struct btrfs_backref_node *upper;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
 	struct btrfs_root *root;
 	struct extent_buffer *eb;
 	u32 blocksize;
@@ -3198,7 +3202,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 static int link_to_upper(struct btrfs_trans_handle *trans,
 			 struct reloc_control *rc,
-			 struct backref_node *node,
+			 struct btrfs_backref_node *node,
 			 struct btrfs_path *path)
 {
 	struct btrfs_key key;
@@ -3212,15 +3216,15 @@ static int finish_pending_nodes(struct btrfs_trans_handle *trans,
 				struct btrfs_path *path, int err)
 {
 	LIST_HEAD(list);
-	struct backref_cache *cache = &rc->backref_cache;
-	struct backref_node *node;
+	struct btrfs_backref_cache *cache = &rc->backref_cache;
+	struct btrfs_backref_node *node;
 	int level;
 	int ret;
 
 	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
 		while (!list_empty(&cache->pending[level])) {
 			node = list_entry(cache->pending[level].next,
-					  struct backref_node, list);
+					  struct btrfs_backref_node, list);
 			list_move_tail(&node->list, &list);
 			BUG_ON(!node->pending);
 
@@ -3240,11 +3244,11 @@ static int finish_pending_nodes(struct btrfs_trans_handle *trans,
  * as processed.
  */
 static void update_processed_blocks(struct reloc_control *rc,
-				    struct backref_node *node)
+				    struct btrfs_backref_node *node)
 {
-	struct backref_node *next = node;
-	struct backref_edge *edge;
-	struct backref_edge *edges[BTRFS_MAX_LEVEL - 1];
+	struct btrfs_backref_node *next = node;
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
 	int index = 0;
 
 	while (next) {
@@ -3259,7 +3263,7 @@ static void update_processed_blocks(struct reloc_control *rc,
 				break;
 
 			edge = list_entry(next->upper.next,
-					  struct backref_edge, list[LOWER]);
+					struct btrfs_backref_edge, list[LOWER]);
 			edges[index++] = edge;
 			next = edge->node[UPPER];
 		}
@@ -3304,7 +3308,7 @@ static int get_tree_block_key(struct btrfs_fs_info *fs_info,
  */
 static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				struct reloc_control *rc,
-				struct backref_node *node,
+				struct btrfs_backref_node *node,
 				struct btrfs_key *key,
 				struct btrfs_path *path)
 {
@@ -3366,7 +3370,7 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 			 struct reloc_control *rc, struct rb_root *blocks)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
-	struct backref_node *node;
+	struct btrfs_backref_node *node;
 	struct btrfs_path *path;
 	struct tree_block *block;
 	struct tree_block *next;
@@ -4785,7 +4789,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct reloc_control *rc;
-	struct backref_node *node;
+	struct btrfs_backref_node *node;
 	int first_cow = 0;
 	int level;
 	int ret = 0;
-- 
2.26.0

