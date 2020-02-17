Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DA7160A72
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 07:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgBQGbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 01:31:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:46258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgBQGbg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 01:31:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55F05AD21
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:31:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: relocation: Use btrfs_backref_iterator infrastructure
Date:   Mon, 17 Feb 2020 14:31:11 +0800
Message-Id: <20200217063111.65941-4-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217063111.65941-1-wqu@suse.com>
References: <20200217063111.65941-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the core function of relocation, build_backref_tree, it needs to
iterate all backref items of one tree block.

We don't really want to spend our code and reviewers' time to going
through tons of supportive code just for the backref walk.

Use btrfs_backref_iterator infrastructure to do the loop.

The backref items look would be much more easier to read:

	ret = btrfs_backref_iterator_start(iterator, cur->bytenr);
	for (; ret == 0; ret = btrfs_backref_iterator_next(iterator)) {
		/* The really important work */
	}

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 195 ++++++++++++++----------------------------
 1 file changed, 64 insertions(+), 131 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b1365a516a25..499318acbfbf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -22,6 +22,7 @@
 #include "print-tree.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "backref.h"
 
 /*
  * backref_node, mapping_node and tree_block start with this
@@ -604,48 +605,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
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
 /*
  * build backref tree for a given tree block. root of the backref tree
  * corresponds the tree block, leaves of the backref tree correspond
@@ -665,10 +624,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 					struct btrfs_key *node_key,
 					int level, u64 bytenr)
 {
+	struct btrfs_backref_iterator *iterator;
 	struct backref_cache *cache = &rc->backref_cache;
-	struct btrfs_path *path1; /* For searching extent root */
-	struct btrfs_path *path2; /* For searching parent of TREE_BLOCK_REF */
-	struct extent_buffer *eb;
+	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
 	struct btrfs_root *root;
 	struct backref_node *cur;
 	struct backref_node *upper;
@@ -677,9 +635,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct backref_node *exist = NULL;
 	struct backref_edge *edge;
 	struct rb_node *rb_node;
-	struct btrfs_key key;
-	unsigned long end;
-	unsigned long ptr;
 	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
 	LIST_HEAD(useless);
 	int cowonly;
@@ -687,14 +642,16 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	int err = 0;
 	bool need_check = true;
 
-	path1 = btrfs_alloc_path();
-	path2 = btrfs_alloc_path();
-	if (!path1 || !path2) {
+	iterator = btrfs_backref_iterator_alloc(rc->extent_root->fs_info,
+						GFP_NOFS);
+	if (!iterator)
+		return ERR_PTR(-ENOMEM);
+	path = btrfs_alloc_path();
+	if (!path) {
 		err = -ENOMEM;
 		goto out;
 	}
-	path1->reada = READA_FORWARD;
-	path2->reada = READA_FORWARD;
+	path->reada = READA_FORWARD;
 
 	node = alloc_backref_node(cache);
 	if (!node) {
@@ -707,25 +664,28 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	node->lowest = 1;
 	cur = node;
 again:
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
+	ret = btrfs_backref_iterator_start(iterator, cur->bytenr);
 	if (ret < 0) {
 		err = ret;
 		goto out;
 	}
-	ASSERT(ret);
-	ASSERT(path1->slots[0]);
-
-	path1->slots[0]--;
 
+	/*
+	 * We skip the first btrfs_tree_block_info, as we don't use the key
+	 * stored in it, but fetch it from the tree block.
+	 */
+	if (btrfs_backref_has_tree_block_info(iterator)) {
+		ret = btrfs_backref_iterator_next(iterator);
+		if (ret < 0) {
+			err = ret;
+			goto out;
+		}
+		/* No extra backref? This means the tree block is corrupted */
+		if (ret > 0) {
+			err = -EUCLEAN;
+			goto out;
+		}
+	}
 	WARN_ON(cur->checked);
 	if (!list_empty(&cur->upper)) {
 		/*
@@ -747,42 +707,21 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		exist = NULL;
 	}
 
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
+	for (; ret == 0; ret = btrfs_backref_iterator_next(iterator)) {
+		struct extent_buffer *eb;
+		struct btrfs_key key;
+		int type;
 
-			btrfs_item_key_to_cpu(eb, &key, path1->slots[0]);
-			if (key.objectid != cur->bytenr) {
-				WARN_ON(exist);
-				break;
-			}
+		cond_resched();
+		eb = btrfs_backref_get_eb(iterator);
 
-			if (key.type == BTRFS_EXTENT_ITEM_KEY ||
-			    key.type == BTRFS_METADATA_ITEM_KEY) {
-				ret = find_inline_backref(eb, path1->slots[0],
-							  &ptr, &end);
-				if (ret)
-					goto next;
-			}
-		}
+		key.objectid = iterator->bytenr;
+		if (btrfs_backref_iterator_is_inline_ref(iterator)) {
+			struct btrfs_extent_inline_ref *iref;
 
-		if (ptr < end) {
 			/* update key for inline back ref */
-			struct btrfs_extent_inline_ref *iref;
-			int type;
-			iref = (struct btrfs_extent_inline_ref *)ptr;
+			iref = (struct btrfs_extent_inline_ref *)
+				iterator->cur_ptr;
 			type = btrfs_get_extent_inline_ref_type(eb, iref,
 							BTRFS_REF_TYPE_BLOCK);
 			if (type == BTRFS_REF_TYPE_INVALID) {
@@ -791,9 +730,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			}
 			key.type = type;
 			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
-
-			WARN_ON(key.type != BTRFS_TREE_BLOCK_REF_KEY &&
-				key.type != BTRFS_SHARED_BLOCK_REF_KEY);
+		} else {
+			key.type = iterator->cur_key.type;
+			key.offset = iterator->cur_key.offset;
 		}
 
 		/*
@@ -806,7 +745,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		     (key.type == BTRFS_SHARED_BLOCK_REF_KEY &&
 		      exist->bytenr == key.offset))) {
 			exist = NULL;
-			goto next;
+			continue;
 		}
 
 		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
@@ -852,7 +791,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			edge->node[LOWER] = cur;
 			edge->node[UPPER] = upper;
 
-			goto next;
+			continue;
 		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
 			err = -EINVAL;
 			btrfs_print_v0_err(rc->extent_root->fs_info);
@@ -860,7 +799,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 					      NULL);
 			goto out;
 		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
-			goto next;
+			continue;
 		}
 
 		/*
@@ -891,20 +830,20 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		level = cur->level + 1;
 
 		/* Search the tree to find parent blocks referring the block. */
-		path2->search_commit_root = 1;
-		path2->skip_locking = 1;
-		path2->lowest_level = level;
-		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
-		path2->lowest_level = 0;
+		path->search_commit_root = 1;
+		path->skip_locking = 1;
+		path->lowest_level = level;
+		ret = btrfs_search_slot(NULL, root, node_key, path, 0, 0);
+		path->lowest_level = 0;
 		if (ret < 0) {
 			err = ret;
 			goto out;
 		}
-		if (ret > 0 && path2->slots[level] > 0)
-			path2->slots[level]--;
+		if (ret > 0 && path->slots[level] > 0)
+			path->slots[level]--;
 
-		eb = path2->nodes[level];
-		if (btrfs_node_blockptr(eb, path2->slots[level]) !=
+		eb = path->nodes[level];
+		if (btrfs_node_blockptr(eb, path->slots[level]) !=
 		    cur->bytenr) {
 			btrfs_err(root->fs_info,
 	"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
@@ -920,7 +859,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 		/* Add all nodes and edges in the path */
 		for (; level < BTRFS_MAX_LEVEL; level++) {
-			if (!path2->nodes[level]) {
+			if (!path->nodes[level]) {
 				ASSERT(btrfs_root_bytenr(&root->root_item) ==
 				       lower->bytenr);
 				if (should_ignore_root(root))
@@ -936,7 +875,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				goto out;
 			}
 
-			eb = path2->nodes[level];
+			eb = path->nodes[level];
 			rb_node = tree_search(&cache->rb_root, eb->start);
 			if (!rb_node) {
 				upper = alloc_backref_node(cache);
@@ -993,20 +932,14 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			lower = upper;
 			upper = NULL;
 		}
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
+		btrfs_release_path(path);
+	}
+	if (ret < 0) {
+		err = ret;
+		goto out;
 	}
-	btrfs_release_path(path1);
+	ret = 0;
+	btrfs_backref_iterator_release(iterator);
 
 	cur->checked = 1;
 	WARN_ON(exist);
@@ -1124,8 +1057,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		}
 	}
 out:
-	btrfs_free_path(path1);
-	btrfs_free_path(path2);
+	btrfs_backref_iterator_free(iterator);
+	btrfs_free_path(path);
 	if (err) {
 		while (!list_empty(&useless)) {
 			lower = list_entry(useless.next,
-- 
2.25.0

