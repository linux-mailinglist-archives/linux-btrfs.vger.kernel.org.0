Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC943176FCA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgCCHO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:14:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:56568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbgCCHO3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:14:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D44AB19C
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:14:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/19] btrfs: Rename tree_entry to simple_node and export it
Date:   Tue,  3 Mar 2020 15:13:52 +0800
Message-Id: <20200303071409.57982-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Structure tree_entry provides a very simple rb_tree which only uses
bytenr as search index.

That tree_entry is used in 3 structures: backref_node, mapping_node and
tree_block.

Since we're going to make backref_node independnt from relocation, it's
a good time to extract the tree_entry into simple_node, and export it
into misc.h.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    |   6 ++-
 fs/btrfs/misc.h       |  54 +++++++++++++++++++++
 fs/btrfs/relocation.c | 109 ++++++++++++++----------------------------
 3 files changed, 94 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 3cf79fafdf07..923788fa03ef 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -179,8 +179,10 @@ btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
  * present a tree block in the backref cache
  */
 struct backref_node {
-	struct rb_node rb_node;
-	u64 bytenr;
+	struct {
+		struct rb_node rb_node;
+		u64 bytenr;
+	}; /* Use simple_node for search/insert */
 
 	u64 new_bytenr;
 	/* objectid of tree block owner, can be not uptodate */
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 72bab64ecf60..d199bfdb210e 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <asm/div64.h>
+#include <linux/rbtree.h>
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
@@ -58,4 +59,57 @@ static inline bool has_single_bit_set(u64 n)
 	return is_power_of_two_u64(n);
 }
 
+/*
+ * Simple bytenr based rb_tree relate structures
+ *
+ * Any structure wants to use bytenr as single search index should have their
+ * structure start with these members.
+ */
+struct simple_node {
+	struct rb_node rb_node;
+	u64 bytenr;
+};
+
+static inline struct rb_node *simple_search(struct rb_root *root, u64 bytenr)
+{
+	struct rb_node *n = root->rb_node;
+	struct simple_node *entry;
+
+	while (n) {
+		entry = rb_entry(n, struct simple_node, rb_node);
+
+		if (bytenr < entry->bytenr)
+			n = n->rb_left;
+		else if (bytenr > entry->bytenr)
+			n = n->rb_right;
+		else
+			return n;
+	}
+	return NULL;
+}
+
+static inline struct rb_node *simple_insert(struct rb_root *root, u64 bytenr,
+					    struct rb_node *node)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct simple_node *entry;
+
+	while (*p) {
+		parent = *p;
+		entry = rb_entry(parent, struct simple_node, rb_node);
+
+		if (bytenr < entry->bytenr)
+			p = &(*p)->rb_left;
+		else if (bytenr > entry->bytenr)
+			p = &(*p)->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, root);
+	return NULL;
+}
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8d939c7837c8..50348a58bb43 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -23,6 +23,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "backref.h"
+#include "misc.h"
 
 #define RELOCATION_RESERVED_NODES	256
 
@@ -85,8 +86,10 @@ struct tree_entry {
  * map address of tree root to tree
  */
 struct mapping_node {
-	struct rb_node rb_node;
-	u64 bytenr;
+	struct {
+		struct rb_node rb_node;
+		u64 bytenr;
+	}; /* Use simle_node for search_insert */
 	void *data;
 };
 
@@ -99,8 +102,10 @@ struct mapping_tree {
  * present a tree block to process
  */
 struct tree_block {
-	struct rb_node rb_node;
-	u64 bytenr;
+	struct {
+		struct rb_node rb_node;
+		u64 bytenr;
+	}; /* Use simple_node for search/insert */
 	struct btrfs_key key;
 	unsigned int level:8;
 	unsigned int key_ready:1;
@@ -284,48 +289,6 @@ static void free_backref_edge(struct backref_cache *cache,
 	}
 }
 
-static struct rb_node *tree_insert(struct rb_root *root, u64 bytenr,
-				   struct rb_node *node)
-{
-	struct rb_node **p = &root->rb_node;
-	struct rb_node *parent = NULL;
-	struct tree_entry *entry;
-
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
-
-		if (bytenr < entry->bytenr)
-			p = &(*p)->rb_left;
-		else if (bytenr > entry->bytenr)
-			p = &(*p)->rb_right;
-		else
-			return parent;
-	}
-
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, root);
-	return NULL;
-}
-
-static struct rb_node *tree_search(struct rb_root *root, u64 bytenr)
-{
-	struct rb_node *n = root->rb_node;
-	struct tree_entry *entry;
-
-	while (n) {
-		entry = rb_entry(n, struct tree_entry, rb_node);
-
-		if (bytenr < entry->bytenr)
-			n = n->rb_left;
-		else if (bytenr > entry->bytenr)
-			n = n->rb_right;
-		else
-			return n;
-	}
-	return NULL;
-}
-
 static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
 {
 
@@ -464,7 +427,7 @@ static void update_backref_node(struct backref_cache *cache,
 	struct rb_node *rb_node;
 	rb_erase(&node->rb_node, &cache->rb_root);
 	node->bytenr = bytenr;
-	rb_node = tree_insert(&cache->rb_root, node->bytenr, &node->rb_node);
+	rb_node = simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, bytenr);
 }
@@ -588,7 +551,7 @@ static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
 	struct btrfs_root *root = NULL;
 
 	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_search(&rc->reloc_root_tree.rb_root, bytenr);
+	rb_node = simple_search(&rc->reloc_root_tree.rb_root, bytenr);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct mapping_node, rb_node);
 		root = (struct btrfs_root *)node->data;
@@ -649,7 +612,7 @@ static int handle_one_tree_backref(struct reloc_control *rc,
 		if (!edge)
 			return -ENOMEM;
 
-		rb_node = tree_search(&cache->rb_root, ref_key->offset);
+		rb_node = simple_search(&cache->rb_root, ref_key->offset);
 		if (!rb_node) {
 			/* Parent node not yet cached */
 			upper = alloc_backref_node(cache, ref_key->offset,
@@ -746,7 +709,7 @@ static int handle_one_tree_backref(struct reloc_control *rc,
 		}
 
 		eb = path->nodes[level];
-		rb_node = tree_search(&cache->rb_root, eb->start);
+		rb_node = simple_search(&cache->rb_root, eb->start);
 		if (!rb_node) {
 			upper = alloc_backref_node(cache, eb->start,
 						   lower->level + 1);
@@ -988,8 +951,8 @@ static int finish_upper_links(struct backref_cache *cache,
 
 		/* Only cache non-cowonly (subvolume trees) tree blocks */
 		if (!upper->cowonly) {
-			rb_node = tree_insert(&cache->rb_root, upper->bytenr,
-					      &upper->rb_node);
+			rb_node = simple_insert(&cache->rb_root, upper->bytenr,
+						&upper->rb_node);
 			if (rb_node) {
 				backref_tree_panic(rb_node, -EEXIST,
 						   upper->bytenr);
@@ -1158,8 +1121,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	 */
 	ASSERT(node->checked);
 	if (!node->cowonly) {
-		rb_node = tree_insert(&cache->rb_root, node->bytenr,
-				      &node->rb_node);
+		rb_node = simple_insert(&cache->rb_root, node->bytenr,
+					&node->rb_node);
 		if (rb_node)
 			backref_tree_panic(rb_node, -EEXIST, node->bytenr);
 		list_add_tail(&node->lower, &cache->leaves);
@@ -1247,7 +1210,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	if (cache->last_trans > 0)
 		update_backref_cache(trans, cache);
 
-	rb_node = tree_search(&cache->rb_root, src->commit_root->start);
+	rb_node = simple_search(&cache->rb_root, src->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct backref_node, rb_node);
 		if (node->detached)
@@ -1257,8 +1220,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	}
 
 	if (!node) {
-		rb_node = tree_search(&cache->rb_root,
-				      reloc_root->commit_root->start);
+		rb_node = simple_search(&cache->rb_root,
+					reloc_root->commit_root->start);
 		if (rb_node) {
 			node = rb_entry(rb_node, struct backref_node,
 					rb_node);
@@ -1291,8 +1254,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 		list_add_tail(&new_node->lower, &cache->leaves);
 	}
 
-	rb_node = tree_insert(&cache->rb_root, new_node->bytenr,
-			      &new_node->rb_node);
+	rb_node = simple_insert(&cache->rb_root, new_node->bytenr,
+				&new_node->rb_node);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, new_node->bytenr);
 
@@ -1332,8 +1295,8 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	node->data = root;
 
 	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_insert(&rc->reloc_root_tree.rb_root,
-			      node->bytenr, &node->rb_node);
+	rb_node = simple_insert(&rc->reloc_root_tree.rb_root,
+				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
 		btrfs_panic(fs_info, -EEXIST,
@@ -1358,8 +1321,8 @@ static void __del_reloc_root(struct btrfs_root *root)
 
 	if (rc && root->node) {
 		spin_lock(&rc->reloc_root_tree.lock);
-		rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-				      root->node->start);
+		rb_node = simple_search(&rc->reloc_root_tree.rb_root,
+					root->node->start);
 		if (rb_node) {
 			node = rb_entry(rb_node, struct mapping_node, rb_node);
 			rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
@@ -1388,8 +1351,8 @@ static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
 	struct reloc_control *rc = fs_info->reloc_ctl;
 
 	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-			      root->node->start);
+	rb_node = simple_search(&rc->reloc_root_tree.rb_root,
+				root->node->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct mapping_node, rb_node);
 		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
@@ -1402,8 +1365,8 @@ static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
 
 	spin_lock(&rc->reloc_root_tree.lock);
 	node->bytenr = new_bytenr;
-	rb_node = tree_insert(&rc->reloc_root_tree.rb_root,
-			      node->bytenr, &node->rb_node);
+	rb_node = simple_insert(&rc->reloc_root_tree.rb_root,
+				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, node->bytenr);
@@ -3490,7 +3453,7 @@ static int add_tree_block(struct reloc_control *rc,
 	block->level = level;
 	block->key_ready = 0;
 
-	rb_node = tree_insert(blocks, block->bytenr, &block->rb_node);
+	rb_node = simple_insert(blocks, block->bytenr, &block->rb_node);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, block->bytenr);
 
@@ -3513,7 +3476,7 @@ static int __add_tree_block(struct reloc_control *rc,
 	if (tree_block_processed(bytenr, rc))
 		return 0;
 
-	if (tree_search(blocks, bytenr))
+	if (simple_search(blocks, bytenr))
 		return 0;
 
 	path = btrfs_alloc_path();
@@ -3717,7 +3680,7 @@ static int find_data_references(struct reloc_control *rc,
 		counted = 0;
 	else
 		counted = 1;
-	rb_node = tree_search(blocks, leaf->start);
+	rb_node = simple_search(blocks, leaf->start);
 	if (rb_node) {
 		if (counted)
 			added = 1;
@@ -3743,7 +3706,7 @@ static int find_data_references(struct reloc_control *rc,
 				counted = 0;
 			else
 				counted = 1;
-			rb_node = tree_search(blocks, leaf->start);
+			rb_node = simple_search(blocks, leaf->start);
 			if (rb_node) {
 				if (counted)
 					added = 1;
@@ -3787,8 +3750,8 @@ static int find_data_references(struct reloc_control *rc,
 			btrfs_item_key_to_cpu(leaf, &block->key, 0);
 			block->level = 0;
 			block->key_ready = 1;
-			rb_node = tree_insert(blocks, block->bytenr,
-					      &block->rb_node);
+			rb_node = simple_insert(blocks, block->bytenr,
+						&block->rb_node);
 			if (rb_node)
 				backref_tree_panic(rb_node, -EEXIST,
 						   block->bytenr);
-- 
2.25.1

