Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33A6193AE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCZIdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbgCZIdv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8AB4AE24;
        Thu, 26 Mar 2020 08:33:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 12/39] btrfs: relocation: Remove the open-coded goto loop for breadth-first search
Date:   Thu, 26 Mar 2020 16:32:49 +0800
Message-Id: <20200326083316.48847-13-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

build_backref_tree() uses "goto again;" to implement a breadth-first
search to build backref cache.

This patch will extract most of its work into a wrapper,
handle_one_tree_block(), and use a do {} while() loop to implement the same
thing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 168 ++++++++++++++++++++++--------------------
 1 file changed, 88 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1ea184e8afb2..462b6df54b11 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -957,76 +957,31 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
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
+static int handle_one_tree_block(struct backref_cache *cache,
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
+	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct backref_edge *edge;
-	struct rb_node *rb_node;
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
 
-	node = alloc_backref_node(cache, bytenr, level);
-	if (!node) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	node->lowest = 1;
-	cur = node;
-again:
 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
-	if (ret < 0) {
-		err = ret;
-		goto out;
-	}
-
+	if (ret < 0)
+		return ret;
 	/*
 	 * We skip the first btrfs_tree_block_info, as we don't use the key
 	 * stored in it, but fetch it from the tree block.
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
@@ -1069,7 +1024,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			type = btrfs_get_extent_inline_ref_type(eb, iref,
 							BTRFS_REF_TYPE_BLOCK);
 			if (type == BTRFS_REF_TYPE_INVALID) {
-				err = -EUCLEAN;
+				ret = -EUCLEAN;
 				goto out;
 			}
 			key.type = type;
@@ -1095,16 +1050,13 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
 		if (key.type == BTRFS_SHARED_BLOCK_REF_KEY) {
 			ret = handle_direct_tree_backref(cache, &key, cur);
-			if (ret < 0) {
-				err = ret;
+			if (ret < 0)
 				goto out;
-			}
 			continue;
 		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			err = -EINVAL;
-			btrfs_print_v0_err(rc->extent_root->fs_info);
-			btrfs_handle_fs_error(rc->extent_root->fs_info, err,
-					      NULL);
+			ret = -EINVAL;
+			btrfs_print_v0_err(fs_info);
+			btrfs_handle_fs_error(fs_info, ret, NULL);
 			goto out;
 		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
 			continue;
@@ -1117,30 +1069,86 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		 */
 		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
 						   cur);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
-	}
-	if (ret < 0) {
-		err = ret;
-		goto out;
 	}
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
-	if (!list_empty(&cache->pending_edge)) {
-		edge = list_entry(cache->pending_edge.next,
-				  struct backref_edge, list[UPPER]);
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
 	}
 
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
+	do {
+		ret = handle_one_tree_block(cache, path, iter, node_key, cur);
+		if (ret < 0) {
+			err = ret;
+			goto out;
+		}
+		edge = list_first_entry_or_null(&cache->pending_edge,
+				struct backref_edge, list[UPPER]);
+		/*
+		 * the pending list isn't empty, take the first block to
+		 * process
+		 */
+		if (edge) {
+			list_del_init(&edge->list[UPPER]);
+			cur = edge->node[UPPER];
+		}
+	} while (edge);
+
 	/*
 	 * everything goes well, connect backref nodes and insert backref nodes
 	 * into the cache.
-- 
2.26.0

