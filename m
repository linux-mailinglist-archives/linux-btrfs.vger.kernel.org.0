Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69018F2AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgCWKY4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:24:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgCWKY4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:24:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C476FADF1;
        Mon, 23 Mar 2020 10:24:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 09/40] btrfs: relocation: Refactor indirect tree backref processing into its own function
Date:   Mon, 23 Mar 2020 18:23:45 +0800
Message-Id: <20200323102416.112862-10-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The processing of indirect tree backref (TREE_BLOCK_REF) is the most
complex work.

We need to grab the fs root, do a tree search to locate all its parent
nodes, linking all needed edges, and put all uncached edges to
pending edge list.

This is definitely worthy a helper function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 295 +++++++++++++++++++++++-------------------
 1 file changed, 160 insertions(+), 135 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ea4126d167a8..652476a5cef2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -773,6 +773,164 @@ static int handle_direct_tree_backref(struct backref_cache *cache,
 	return 0;
 }
 
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
+ *		the function get called.
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
+	struct rb_node *rb_node;
+	int level;
+	bool need_check = true;
+	int ret;
+
+	root = read_fs_root(fs_info, ref_key->offset);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+		cur->cowonly = 1;
+
+	if (btrfs_root_level(&root->root_item) == cur->level) {
+		/* tree root */
+		ASSERT(btrfs_root_bytenr(&root->root_item) ==
+		       cur->bytenr);
+		if (should_ignore_root(root)) {
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
+			if (should_ignore_root(root)) {
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
+		rb_node = tree_search(&cache->rb_root, eb->start);
+		if (!rb_node) {
+			upper = alloc_backref_node(cache);
+			if (!upper) {
+				btrfs_put_root(root);
+				free_backref_edge(cache, edge);
+				ret = -ENOMEM;
+				goto out;
+			}
+			upper->bytenr = eb->start;
+			upper->owner = btrfs_header_owner(eb);
+			upper->level = lower->level + 1;
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
+		list_add_tail(&edge->list[LOWER], &lower->upper);
+		edge->node[LOWER] = lower;
+		edge->node[UPPER] = upper;
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
 /*
  * build backref tree for a given tree block. root of the backref tree
  * corresponds the tree block, leaves of the backref tree correspond
@@ -795,7 +953,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct btrfs_backref_iter *iter;
 	struct backref_cache *cache = &rc->backref_cache;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
-	struct btrfs_root *root;
 	struct backref_node *cur;
 	struct backref_node *upper;
 	struct backref_node *lower;
@@ -806,7 +963,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	int cowonly;
 	int ret;
 	int err = 0;
-	bool need_check = true;
 
 	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
 	if (!iter)
@@ -936,143 +1092,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		 * means the root objectid. We need to search the tree to get
 		 * its parent bytenr.
 		 */
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
-			if (should_ignore_root(root)) {
-				btrfs_put_root(root);
-				list_add(&cur->list, &cache->useless_node);
-			} else {
-				cur->root = root;
-			}
-			break;
-		}
-
-		level = cur->level + 1;
-
-		/* Search the tree to find parent blocks referring the block. */
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
-		path->lowest_level = level;
-		ret = btrfs_search_slot(NULL, root, node_key, path, 0, 0);
-		path->lowest_level = 0;
+		ret = handle_indirect_tree_backref(cache, path, &key, node_key,
+						   cur);
 		if (ret < 0) {
-			btrfs_put_root(root);
 			err = ret;
 			goto out;
 		}
-		if (ret > 0 && path->slots[level] > 0)
-			path->slots[level]--;
-
-		eb = path->nodes[level];
-		if (btrfs_node_blockptr(eb, path->slots[level]) !=
-		    cur->bytenr) {
-			btrfs_err(root->fs_info,
-	"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
-				  cur->bytenr, level - 1,
-				  root->root_key.objectid,
-				  node_key->objectid, node_key->type,
-				  node_key->offset);
-			btrfs_put_root(root);
-			err = -ENOENT;
-			goto out;
-		}
-		lower = cur;
-		need_check = true;
-
-		/* Add all nodes and edges in the path */
-		for (; level < BTRFS_MAX_LEVEL; level++) {
-			if (!path->nodes[level]) {
-				ASSERT(btrfs_root_bytenr(&root->root_item) ==
-				       lower->bytenr);
-				if (should_ignore_root(root)) {
-					btrfs_put_root(root);
-					list_add(&lower->list,
-						 &cache->useless_node);
-				} else {
-					lower->root = root;
-				}
-				break;
-			}
-
-			edge = alloc_backref_edge(cache);
-			if (!edge) {
-				btrfs_put_root(root);
-				err = -ENOMEM;
-				goto out;
-			}
-
-			eb = path->nodes[level];
-			rb_node = tree_search(&cache->rb_root, eb->start);
-			if (!rb_node) {
-				upper = alloc_backref_node(cache);
-				if (!upper) {
-					btrfs_put_root(root);
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
-						      &cache->pending_edge);
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
-			if (rb_node) {
-				btrfs_put_root(root);
-				break;
-			}
-			lower = upper;
-			upper = NULL;
-		}
-		btrfs_release_path(path);
 	}
 	if (ret < 0) {
 		err = ret;
-- 
2.25.2

