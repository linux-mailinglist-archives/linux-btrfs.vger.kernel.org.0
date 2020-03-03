Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49675176FCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCCHPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:56750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgCCHPP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1145CAC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/19] btrfs: relocation: Add backref_cache::pending_edge and backref_cache::useless_node members
Date:   Tue,  3 Mar 2020 15:13:54 +0800
Message-Id: <20200303071409.57982-5-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two new members will act the same as the existing local lists,
@useless and @list in build_backref_tree().

This would kill two parameters for handle_one_tree_backref(),
handle_one_tree_block(), finish_upper_links() and
handle_useless_nodes().

Currently build_backref_tree() is only executed serially, thus moving
such local list into backref_cache is still safe.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    |  6 ++++
 fs/btrfs/relocation.c | 64 ++++++++++++++++++++++++-------------------
 2 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index fbb08b5429ca..4ad1193c78e0 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -280,6 +280,12 @@ struct backref_cache {
 	 * to generic backref cache.
 	 */
 	unsigned int is_reloc;
+
+	/* The list of unchecked backref edges during backref cache build */
+	struct list_head pending_edge;
+
+	/* The list of useless backref nodes during backref cache build */
+	struct list_head useless_node;
 };
 
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 374efb117387..413a83d1d9f1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -195,6 +195,8 @@ static void backref_cache_init(struct backref_cache *cache, int is_reloc)
 	INIT_LIST_HEAD(&cache->detached);
 	INIT_LIST_HEAD(&cache->leaves);
 	cache->is_reloc = is_reloc;
+	INIT_LIST_HEAD(&cache->pending_edge);
+	INIT_LIST_HEAD(&cache->useless_node);
 }
 
 static void backref_cache_cleanup(struct backref_cache *cache)
@@ -218,6 +220,8 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
 		ASSERT(list_empty(&cache->pending[i]));
+	ASSERT(list_empty(&cache->pending_edge));
+	ASSERT(list_empty(&cache->useless_node));
 	ASSERT(list_empty(&cache->changed));
 	ASSERT(list_empty(&cache->detached));
 	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
@@ -576,8 +580,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 }
 
 static int handle_one_tree_backref(struct reloc_control *rc,
-				   struct list_head *useless_node,
-				   struct list_head *pending_edge,
 				   struct btrfs_path *path,
 				   struct btrfs_key *ref_key,
 				   struct btrfs_key *tree_key,
@@ -585,6 +587,8 @@ static int handle_one_tree_backref(struct reloc_control *rc,
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
 	struct backref_cache *cache = &rc->backref_cache;
+	struct list_head *useless_node = &cache->useless_node;
+	struct list_head *pending_edge = &cache->pending_edge;
 	struct backref_node *upper;
 	struct backref_node *lower;
 	struct backref_edge *edge;
@@ -774,13 +778,12 @@ static int handle_one_tree_backref(struct reloc_control *rc,
 }
 
 static int handle_one_tree_block(struct reloc_control *rc,
-				 struct list_head *useless_node,
-				 struct list_head *pending_edge,
 				 struct btrfs_path *path,
 				 struct btrfs_backref_iter *iter,
 				 struct btrfs_key *node_key,
 				 struct backref_node *cur)
 {
+	struct backref_cache *cache = &rc->backref_cache;
 	struct backref_edge *edge;
 	struct backref_node *exist;
 	int ret;
@@ -819,7 +822,7 @@ static int handle_one_tree_block(struct reloc_control *rc,
 		 * check its backrefs
 		 */
 		if (!exist->checked)
-			list_add_tail(&edge->list[UPPER], pending_edge);
+			list_add_tail(&edge->list[UPPER], &cache->pending_edge);
 	} else {
 		exist = NULL;
 	}
@@ -864,8 +867,7 @@ static int handle_one_tree_block(struct reloc_control *rc,
 			continue;
 		}
 
-		ret = handle_one_tree_backref(rc, useless_node, pending_edge, path,
-					      &key, node_key, cur);
+		ret = handle_one_tree_backref(rc, path, &key, node_key, cur);
 		if (ret < 0)
 			goto out;
 	}
@@ -891,9 +893,9 @@ static int handle_one_tree_block(struct reloc_control *rc,
  * Also, this will add the nodes to backref cache for next run.
  */
 static int finish_upper_links(struct backref_cache *cache,
-			      struct backref_node *start,
-			      struct list_head *useless_node)
+			      struct backref_node *start)
 {
+	struct list_head *useless_node = &cache->useless_node;
 	struct backref_edge *edge;
 	LIST_HEAD(pending_edge);
 
@@ -992,10 +994,10 @@ static int finish_upper_links(struct backref_cache *cache,
  * Return true if @node is in the @useless_nodes list.
  */
 static bool handle_useless_nodes(struct reloc_control *rc,
-				 struct list_head *useless_nodes,
 				 struct backref_node *node)
 {
 	struct backref_cache *cache = &rc->backref_cache;
+	struct list_head *useless_nodes = &cache->useless_node;
 	bool ret = false;
 
 	while (!list_empty(useless_nodes)) {
@@ -1080,11 +1082,12 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct backref_node *node = NULL;
 	struct backref_edge *edge;
 	struct rb_node *rb_node;
-	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
-	LIST_HEAD(useless);
 	int ret;
 	int err = 0;
 
+	ASSERT(list_empty(&cache->useless_node) &&
+	       list_empty(&cache->pending_edge));
+
 	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
@@ -1106,15 +1109,15 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 
 	/* Breadth-first search to build backref cache */
 	while (1) {
-		ret = handle_one_tree_block(rc, &useless, &list, path, iter,
-					    node_key, cur);
+		ret = handle_one_tree_block(rc, path, iter, node_key, cur);
 		if (ret < 0) {
 			err = ret;
 			goto out;
 		}
 		/* the pending list isn't empty, take the first block to process */
-		if (!list_empty(&list)) {
-			edge = list_entry(list.next, struct backref_edge, list[UPPER]);
+		if (!list_empty(&cache->pending_edge)) {
+			edge = list_entry(cache->pending_edge.next,
+					  struct backref_edge, list[UPPER]);
 			list_del_init(&edge->list[UPPER]);
 			cur = edge->node[UPPER];
 		} else {
@@ -1136,26 +1139,26 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	}
 
 	/* Finish the upper linkage of newly added edges/nodes */
-	ret = finish_upper_links(cache, node, &useless);
+	ret = finish_upper_links(cache, node);
 	if (ret < 0) {
 		err = ret;
 		goto out;
 	}
 
-	if (handle_useless_nodes(rc, &useless, node))
+	if (handle_useless_nodes(rc, node))
 		node = NULL;
 out:
 	btrfs_backref_iter_free(iter);
 	btrfs_free_path(path);
 	if (err) {
-		while (!list_empty(&useless)) {
-			lower = list_entry(useless.next,
+		while (!list_empty(&cache->useless_node)) {
+			lower = list_first_entry(&cache->useless_node,
 					   struct backref_node, list);
 			list_del_init(&lower->list);
 		}
-		while (!list_empty(&list)) {
-			edge = list_first_entry(&list, struct backref_edge,
-						list[UPPER]);
+		while (!list_empty(&cache->pending_edge)) {
+			edge = list_first_entry(&cache->pending_edge,
+					struct backref_edge, list[UPPER]);
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
@@ -1168,20 +1171,21 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			 */
 			if (list_empty(&lower->upper) &&
 			    RB_EMPTY_NODE(&lower->rb_node))
-				list_add(&lower->list, &useless);
+				list_add(&lower->list, &cache->useless_node);
 
 			if (!RB_EMPTY_NODE(&upper->rb_node))
 				continue;
 
 			/* Add this guy's upper edges to the list to process */
 			list_for_each_entry(edge, &upper->upper, list[LOWER])
-				list_add_tail(&edge->list[UPPER], &list);
+				list_add_tail(&edge->list[UPPER],
+					      &cache->pending_edge);
 			if (list_empty(&upper->upper))
-				list_add(&upper->list, &useless);
+				list_add(&upper->list, &cache->useless_node);
 		}
 
-		while (!list_empty(&useless)) {
-			lower = list_entry(useless.next,
+		while (!list_empty(&cache->useless_node)) {
+			lower = list_entry(cache->useless_node.next,
 					   struct backref_node, list);
 			list_del_init(&lower->list);
 			if (lower == node)
@@ -1190,9 +1194,13 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		}
 
 		free_backref_node(cache, node);
+		ASSERT(list_empty(&cache->useless_node) &&
+		       list_empty(&cache->pending_edge));
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);
+	ASSERT(list_empty(&cache->useless_node) &&
+	       list_empty(&cache->pending_edge));
 	return node;
 }
 
-- 
2.25.1

