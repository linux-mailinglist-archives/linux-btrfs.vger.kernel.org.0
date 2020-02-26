Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBE16F7B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 06:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgBZF5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 00:57:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:36612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgBZF5M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 00:57:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A4ABAC65
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 05:57:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: relocation: Refactor tree backref processing into its own function
Date:   Wed, 26 Feb 2020 13:56:47 +0800
Message-Id: <20200226055652.24857-6-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200226055652.24857-1-wqu@suse.com>
References: <20200226055652.24857-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

build_backref_tree() function is painfully long, as it has 3 big parts:
- Tree backref handling
- Weaving backref nodes
- Useless nodes pruning

This patch will move the tree backref handling into its own function,
handle_one_tree_backref().

And inside that function, the main works are determined by the backref
key:
- BTRFS_SHARED_BLOCK_REF_KEY
  We know the parent node bytenr directly.
  If the parent is cached, or it's root, call it a day.
  If the parent is not cached, add it pending list.

- BTRFS_TREE_BLOCK_REF_KEY
  The most complex work.
  We need to grab the fs root, do a tree search to locate all its
  parent nodes, weaving all needed edges, and put all uncached edges to
  pending edge list.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 374 +++++++++++++++++++++---------------------
 1 file changed, 191 insertions(+), 183 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d81fa6d63129..812562e69315 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -631,6 +631,195 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
+static int handle_one_tree_backref(struct reloc_control *rc,
+				   struct list_head *useless_node,
+				   struct list_head *pending_edge,
+				   struct btrfs_path *path,
+				   struct btrfs_key *ref_key,
+				   struct btrfs_key *tree_key,
+				   struct backref_node *cur)
+{
+	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
+	struct backref_cache *cache = &rc->backref_cache;
+	struct backref_node *upper;
+	struct backref_node *lower;
+	struct backref_edge *edge;
+	struct extent_buffer *eb;
+	struct btrfs_root *root;
+	struct rb_node *rb_node;
+	bool need_check = true;
+	int level;
+	int ret = 0;
+
+	if (ref_key->type != BTRFS_TREE_BLOCK_REF_KEY &&
+	    ref_key->type != BTRFS_SHARED_BLOCK_REF_KEY)
+		return -EUCLEAN;
+
+	/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
+	if (ref_key->type == BTRFS_SHARED_BLOCK_REF_KEY) {
+
+		/* Only reloc root uses backref pointing to itself */
+		if (ref_key->objectid == ref_key->offset) {
+			root = find_reloc_root(rc, cur->bytenr);
+			if (WARN_ON(!root))
+				return -ENOENT;
+			cur->root = root;
+			return 0;
+		}
+
+		edge = alloc_backref_edge(cache);
+		if (!edge)
+			return -ENOMEM;
+
+		rb_node = tree_search(&cache->rb_root, ref_key->offset);
+		if (!rb_node) {
+			/* Parent node not yet cached */
+			upper = alloc_backref_node(cache);
+			if (!upper) {
+				free_backref_edge(cache, edge);
+				return -ENOMEM;
+			}
+			upper->bytenr = ref_key->offset;
+			upper->level = cur->level + 1;
+
+			/*
+			 *  backrefs for the upper level block isn't
+			 *  cached, add the block to pending list
+			 */
+			list_add_tail(&edge->list[UPPER], pending_edge);
+		} else {
+			/* Parent node already cached */
+			upper = rb_entry(rb_node, struct backref_node, rb_node);
+			ASSERT(upper->checked);
+			INIT_LIST_HEAD(&edge->list[UPPER]);
+		}
+		list_add_tail(&edge->list[LOWER], &cur->upper);
+		edge->node[LOWER] = cur;
+		edge->node[UPPER] = upper;
+		return 0;
+	}
+
+	/*
+	 * key.type == BTRFS_TREE_BLOCK_REF_KEY case, key->offset means the
+	 * root objectid, We need to search the tree to get its parent bytenr.
+	 */
+	root = read_fs_root(fs_info, ref_key->offset);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
+		cur->cowonly = 1;
+
+	/* Tree root */
+	if (btrfs_root_level(&root->root_item) == cur->level) {
+		ASSERT(btrfs_root_bytenr(&root->root_item) ==
+		       cur->bytenr);
+		if (should_ignore_root(root))
+			list_add(&cur->list, useless_node);
+		else
+			cur->root = root;
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
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && path->slots[level] > 0)
+		path->slots[level]--;
+
+	eb = path->nodes[level];
+	if (btrfs_node_blockptr(eb, path->slots[level]) != cur->bytenr) {
+		btrfs_err(fs_info,
+"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
+			  cur->bytenr, level - 1, root->root_key.objectid,
+			  tree_key->objectid, tree_key->type, tree_key->offset);
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
+			if (should_ignore_root(root))
+				list_add(&lower->list, useless_node);
+			else
+				lower->root = root;
+			break;
+		}
+		edge = alloc_backref_edge(cache);
+		if (!edge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		eb = path->nodes[level];
+		rb_node = tree_search(&cache->rb_root, eb->start);
+		if (!rb_node) {
+			upper = alloc_backref_node(cache);
+			if (!upper) {
+				free_backref_edge(cache, edge);
+				ret = -ENOMEM;
+				goto out;
+			}
+			upper->bytenr = eb->start;
+			upper->owner = btrfs_header_owner(eb);
+			upper->level = lower->level + 1;
+			if (!test_bit(BTRFS_ROOT_REF_COWS,
+				      &root->state))
+				upper->cowonly = 1;
+
+			/*
+			 * if we know the block isn't shared
+			 * we can void checking its backrefs.
+			 */
+			if (btrfs_block_can_be_shared(root, eb))
+				upper->checked = 0;
+			else
+				upper->checked = 1;
+
+			/*
+			 * add the block to pending list if we
+			 * need check its backrefs, we only do this once
+			 * while walking up a tree as we will catch
+			 * anything else later on.
+			 */
+			if (!upper->checked && need_check) {
+				need_check = false;
+				list_add_tail(&edge->list[UPPER], pending_edge);
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
+		if (rb_node)
+			break;
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
@@ -653,7 +842,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct btrfs_backref_iter *iter;
 	struct backref_cache *cache = &rc->backref_cache;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
-	struct btrfs_root *root;
 	struct backref_node *cur;
 	struct backref_node *upper;
 	struct backref_node *lower;
@@ -666,7 +854,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	int cowonly;
 	int ret;
 	int err = 0;
-	bool need_check = true;
 
 	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
 	if (!iter)
@@ -772,191 +959,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			continue;
 		}
 
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
-			continue;
-		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
-			err = -EINVAL;
-			btrfs_print_v0_err(rc->extent_root->fs_info);
-			btrfs_handle_fs_error(rc->extent_root->fs_info, err,
-					      NULL);
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
-		path->search_commit_root = 1;
-		path->skip_locking = 1;
-		path->lowest_level = level;
-		ret = btrfs_search_slot(NULL, root, node_key, path, 0, 0);
-		path->lowest_level = 0;
+		ret = handle_one_tree_backref(rc, &useless, &list, path,
+					      &key, node_key, cur);
 		if (ret < 0) {
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
-			eb = path->nodes[level];
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
-		btrfs_release_path(path);
 	}
 	if (ret < 0) {
 		err = ret;
-- 
2.25.1

