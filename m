Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31169193AEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgCZIeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgCZId7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9451CAC46
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:33:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/39] btrfs: Rename tree_entry to simple_node and export it
Date:   Thu, 26 Mar 2020 16:32:54 +0800
Message-Id: <20200326083316.48847-18-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
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
 fs/btrfs/relocation.c | 109 +++++++++++++-----------------------------
 3 files changed, 90 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 76858ec099d9..f3eae9e9f84b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -162,8 +162,10 @@ btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
  * present a tree block in the backref cache
  */
 struct btrfs_backref_node {
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
index ec7d28d63347..d62537792ac0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -24,6 +24,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "backref.h"
+#include "misc.h"
 
 /*
  * Relocation overview
@@ -72,21 +73,15 @@
  * The entry point of relocation is relocate_block_group() function.
  */
 
-/*
- * btrfs_backref_node, mapping_node and tree_block start with this
- */
-struct tree_entry {
-	struct rb_node rb_node;
-	u64 bytenr;
-};
-
 #define RELOCATION_RESERVED_NODES	256
 /*
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
 
@@ -99,8 +94,10 @@ struct mapping_tree {
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
@@ -293,48 +290,6 @@ static void free_backref_edge(struct btrfs_backref_cache *cache,
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
 
@@ -473,7 +428,7 @@ static void update_backref_node(struct btrfs_backref_cache *cache,
 	struct rb_node *rb_node;
 	rb_erase(&node->rb_node, &cache->rb_root);
 	node->bytenr = bytenr;
-	rb_node = tree_insert(&cache->rb_root, node->bytenr, &node->rb_node);
+	rb_node = simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, bytenr);
 }
@@ -598,7 +553,7 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 
 	ASSERT(rc);
 	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_search(&rc->reloc_root_tree.rb_root, bytenr);
+	rb_node = simple_search(&rc->reloc_root_tree.rb_root, bytenr);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct mapping_node, rb_node);
 		root = (struct btrfs_root *)node->data;
@@ -666,7 +621,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 	if (!edge)
 		return -ENOMEM;
 
-	rb_node = tree_search(&cache->rb_root, ref_key->offset);
+	rb_node = simple_search(&cache->rb_root, ref_key->offset);
 	if (!rb_node) {
 		/* Parent node not yet cached */
 		upper = alloc_backref_node(cache, ref_key->offset,
@@ -788,7 +743,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 		}
 
 		eb = path->nodes[level];
-		rb_node = tree_search(&cache->rb_root, eb->start);
+		rb_node = simple_search(&cache->rb_root, eb->start);
 		if (!rb_node) {
 			upper = alloc_backref_node(cache, eb->start,
 						   lower->level + 1);
@@ -994,8 +949,8 @@ static int finish_upper_links(struct btrfs_backref_cache *cache,
 
 	/* Insert this node to cache if it's not cowonly */
 	if (!start->cowonly) {
-		rb_node = tree_insert(&cache->rb_root, start->bytenr,
-				      &start->rb_node);
+		rb_node = simple_insert(&cache->rb_root, start->bytenr,
+					&start->rb_node);
 		if (rb_node)
 			backref_tree_panic(rb_node, -EEXIST, start->bytenr);
 		list_add_tail(&start->lower, &cache->leaves);
@@ -1062,8 +1017,8 @@ static int finish_upper_links(struct btrfs_backref_cache *cache,
 
 		/* Only cache non-cowonly (subvolume trees) tree blocks */
 		if (!upper->cowonly) {
-			rb_node = tree_insert(&cache->rb_root, upper->bytenr,
-					      &upper->rb_node);
+			rb_node = simple_insert(&cache->rb_root, upper->bytenr,
+						&upper->rb_node);
 			if (rb_node) {
 				backref_tree_panic(rb_node, -EEXIST,
 						   upper->bytenr);
@@ -1310,7 +1265,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	if (cache->last_trans > 0)
 		update_backref_cache(trans, cache);
 
-	rb_node = tree_search(&cache->rb_root, src->commit_root->start);
+	rb_node = simple_search(&cache->rb_root, src->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
 		if (node->detached)
@@ -1320,8 +1275,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	}
 
 	if (!node) {
-		rb_node = tree_search(&cache->rb_root,
-				      reloc_root->commit_root->start);
+		rb_node = simple_search(&cache->rb_root,
+					reloc_root->commit_root->start);
 		if (rb_node) {
 			node = rb_entry(rb_node, struct btrfs_backref_node,
 					rb_node);
@@ -1354,8 +1309,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 		list_add_tail(&new_node->lower, &cache->leaves);
 	}
 
-	rb_node = tree_insert(&cache->rb_root, new_node->bytenr,
-			      &new_node->rb_node);
+	rb_node = simple_insert(&cache->rb_root, new_node->bytenr,
+				&new_node->rb_node);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, new_node->bytenr);
 
@@ -1395,8 +1350,8 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	node->data = root;
 
 	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_insert(&rc->reloc_root_tree.rb_root,
-			      node->bytenr, &node->rb_node);
+	rb_node = simple_insert(&rc->reloc_root_tree.rb_root,
+				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
 		btrfs_panic(fs_info, -EEXIST,
@@ -1422,8 +1377,8 @@ static void __del_reloc_root(struct btrfs_root *root)
 
 	if (rc && root->node) {
 		spin_lock(&rc->reloc_root_tree.lock);
-		rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-				      root->commit_root->start);
+		rb_node = simple_search(&rc->reloc_root_tree.rb_root,
+					root->commit_root->start);
 		if (rb_node) {
 			node = rb_entry(rb_node, struct mapping_node, rb_node);
 			rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
@@ -1466,8 +1421,8 @@ static int __update_reloc_root(struct btrfs_root *root)
 	struct reloc_control *rc = fs_info->reloc_ctl;
 
 	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-			      root->commit_root->start);
+	rb_node = simple_search(&rc->reloc_root_tree.rb_root,
+				root->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct mapping_node, rb_node);
 		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
@@ -1480,8 +1435,8 @@ static int __update_reloc_root(struct btrfs_root *root)
 
 	spin_lock(&rc->reloc_root_tree.lock);
 	node->bytenr = root->node->start;
-	rb_node = tree_insert(&rc->reloc_root_tree.rb_root,
-			      node->bytenr, &node->rb_node);
+	rb_node = simple_insert(&rc->reloc_root_tree.rb_root,
+				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, node->bytenr);
@@ -3624,7 +3579,7 @@ static int add_tree_block(struct reloc_control *rc,
 	block->level = level;
 	block->key_ready = 0;
 
-	rb_node = tree_insert(blocks, block->bytenr, &block->rb_node);
+	rb_node = simple_insert(blocks, block->bytenr, &block->rb_node);
 	if (rb_node)
 		backref_tree_panic(rb_node, -EEXIST, block->bytenr);
 
@@ -3647,7 +3602,7 @@ static int __add_tree_block(struct reloc_control *rc,
 	if (tree_block_processed(bytenr, rc))
 		return 0;
 
-	if (tree_search(blocks, bytenr))
+	if (simple_search(blocks, bytenr))
 		return 0;
 
 	path = btrfs_alloc_path();
-- 
2.26.0

