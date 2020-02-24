Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D38169E24
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 07:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBXGCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 01:02:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:34740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXGCQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 01:02:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5FEA9B259
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 06:02:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: relocation: Remove the open-coded goto loop for breadth-first search
Date:   Mon, 24 Feb 2020 14:02:00 +0800
Message-Id: <20200224060200.31323-4-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224060200.31323-1-wqu@suse.com>
References: <20200224060200.31323-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

build_backref_tree() uses "goto again;" to implement a breadth-first
search to build backref cache.

This patch will extract most of its work into a wrapper,
handle_one_tree_block(), and use a while() loop to implement the same
thing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 165 +++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f072d075a202..13eadbb1c552 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -846,65 +846,21 @@ static int handle_one_tree_backref(struct reloc_control *rc,
 	return ret;
 }
 
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
+static int handle_one_tree_block(struct reloc_control *rc,
+				 struct list_head *useless_node,
+				 struct list_head *pending_edge,
+				 struct btrfs_path *path,
+				 struct btrfs_backref_iter *iter,
+				 struct btrfs_key *node_key,
+				 struct backref_node *cur)
 {
-	struct btrfs_backref_iter *iter;
-	struct backref_cache *cache = &rc->backref_cache;
-	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
-	struct backref_node *cur;
-	struct backref_node *upper;
-	struct backref_node *lower;
-	struct backref_node *node = NULL;
-	struct backref_node *exist = NULL;
 	struct backref_edge *edge;
-	struct rb_node *rb_node;
-	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
-	LIST_HEAD(useless);
-	int cowonly;
+	struct backref_node *exist;
 	int ret;
-	int err = 0;
-
-	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
-	if (!iter)
-		return ERR_PTR(-ENOMEM);
-	path = btrfs_alloc_path();
-	if (!path) {
-		err = -ENOMEM;
-		goto out;
-	}
-	path->reada = READA_FORWARD;
-
-	node = alloc_backref_node(cache, bytenr, level);
-	if (!node) {
-		err = -ENOMEM;
-		goto out;
-	}
 
-	node->lowest = 1;
-	cur = node;
-again:
 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
-	if (ret < 0) {
-		err = ret;
-		goto out;
-	}
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * We skip the first btrfs_tree_block_info, as we don't use the key
@@ -912,13 +868,11 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	 */
 	if (btrfs_backref_has_tree_block_info(iter)) {
 		ret = btrfs_backref_iter_next(iter);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
 		/* No extra backref? This means the tree block is corrupted */
 		if (ret > 0) {
-			err = -EUCLEAN;
+			ret = -EUCLEAN;
 			goto out;
 		}
 	}
@@ -938,7 +892,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		 * check its backrefs
 		 */
 		if (!exist->checked)
-			list_add_tail(&edge->list[UPPER], &list);
+			list_add_tail(&edge->list[UPPER], pending_edge);
 	} else {
 		exist = NULL;
 	}
@@ -960,7 +914,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			type = btrfs_get_extent_inline_ref_type(eb, iref,
 							BTRFS_REF_TYPE_BLOCK);
 			if (type == BTRFS_REF_TYPE_INVALID) {
-				err = -EUCLEAN;
+				ret = -EUCLEAN;
 				goto out;
 			}
 			key.type = type;
@@ -983,29 +937,90 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			continue;
 		}
 
-		ret = handle_one_tree_backref(rc, &useless, &list, path,
+		ret = handle_one_tree_backref(rc, useless_node, pending_edge, path,
 					      &key, node_key, cur);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
 	}
-	if (ret < 0) {
-		err = ret;
+	if (ret < 0)
 		goto out;
-	}
 	ret = 0;
-	btrfs_backref_iter_release(iter);
-
 	cur->checked = 1;
 	WARN_ON(exist);
+out:
+	btrfs_backref_iter_release(iter);
+	return ret;
+}
 
-	/* the pending list isn't empty, take the first block to process */
-	if (!list_empty(&list)) {
-		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
-		list_del_init(&edge->list[UPPER]);
-		cur = edge->node[UPPER];
-		goto again;
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
+static noinline_for_stack
+struct backref_node *build_backref_tree(struct reloc_control *rc,
+					struct btrfs_key *node_key,
+					int level, u64 bytenr)
+{
+	struct btrfs_backref_iter *iter;
+	struct backref_cache *cache = &rc->backref_cache;
+	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
+	struct backref_node *cur;
+	struct backref_node *upper;
+	struct backref_node *lower;
+	struct backref_node *node = NULL;
+	struct backref_edge *edge;
+	struct rb_node *rb_node;
+	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
+	LIST_HEAD(useless);
+	int cowonly;
+	int ret;
+	int err = 0;
+
+	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+	path = btrfs_alloc_path();
+	if (!path) {
+		err = -ENOMEM;
+		goto out;
+	}
+	path->reada = READA_FORWARD;
+
+	node = alloc_backref_node(cache, bytenr, level);
+	if (!node) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	node->lowest = 1;
+	cur = node;
+
+	/* Breadth-first search to build backref cache */
+	while (1) {
+		ret = handle_one_tree_block(rc, &useless, &list, path, iter,
+					    node_key, cur);
+		if (ret < 0) {
+			err = ret;
+			goto out;
+		}
+		/* the pending list isn't empty, take the first block to process */
+		if (!list_empty(&list)) {
+			edge = list_entry(list.next, struct backref_edge, list[UPPER]);
+			list_del_init(&edge->list[UPPER]);
+			cur = edge->node[UPPER];
+		} else {
+			break;
+		}
 	}
 
 	/*
-- 
2.25.1

