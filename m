Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA0176FE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCCHP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgCCHPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2D44CAC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/19] btrfs: Rename finish_upper_links() to backref_cache_finish_upper_links() and move it to backref.c
Date:   Tue,  3 Mar 2020 15:14:09 +0800
Message-Id: <20200303071409.57982-20-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This the the 2nd major part of generic backref cache. Move it to
backref.c so we can reuse it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 115 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |   2 +
 fs/btrfs/relocation.c | 117 +-----------------------------------------
 3 files changed, 118 insertions(+), 116 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e1a271c1e9f3..db0d9bc8d7b6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2863,3 +2863,118 @@ int backref_cache_add_one_tree_block(struct backref_cache *cache,
 	btrfs_backref_iter_release(iter);
 	return ret;
 }
+
+/*
+ * In handle_one_tree_backref(), we have only linked the lower node to the edge,
+ * but the upper node hasn't been linked to the edge.
+ * This means we can only iterate through backref_node::upper to reach parent
+ * edges, but not through backref_node::lower to reach children edges.
+ *
+ * This function will finish the backref_node::lower to related edges, so that
+ * backref cache can be bi-directionally iterated.
+ *
+ * Also, this will add the nodes to backref cache for next run.
+ */
+int backref_cache_finish_upper_links(struct backref_cache *cache,
+				     struct backref_node *start)
+{
+	struct list_head *useless_node = &cache->useless_node;
+	struct backref_edge *edge;
+	struct rb_node *rb_node;
+	LIST_HEAD(pending_edge);
+
+	/*
+	 * everything goes well, connect backref nodes and insert backref nodes
+	 * into the cache.
+	 */
+	ASSERT(start->checked);
+	if (!start->cowonly) {
+		rb_node = simple_insert(&cache->rb_root, start->bytenr,
+					&start->rb_node);
+		if (rb_node)
+			backref_cache_panic(cache->fs_info, start->bytenr,
+					    -EEXIST);
+		list_add_tail(&start->lower, &cache->leaves);
+	}
+
+	/*
+	 * Use breadth first search to iterate all related edges.
+	 *
+	 * The start point is all the edges of this node
+	 */
+	list_for_each_entry(edge, &start->upper, list[LOWER])
+		list_add_tail(&edge->list[UPPER], &pending_edge);
+
+	while (!list_empty(&pending_edge)) {
+		struct backref_node *upper;
+		struct backref_node *lower;
+		struct rb_node *rb_node;
+
+		edge = list_entry(pending_edge.next, struct backref_edge,
+				  list[UPPER]);
+		list_del_init(&edge->list[UPPER]);
+		upper = edge->node[UPPER];
+		lower = edge->node[LOWER];
+
+		/* Parent is detached, no need to keep any edges */
+		if (upper->detached) {
+			list_del(&edge->list[LOWER]);
+			free_backref_edge(cache, edge);
+
+			/* Lower node is orphan, queue for cleanup */
+			if (list_empty(&lower->upper))
+				list_add(&lower->list, useless_node);
+			continue;
+		}
+
+		/*
+		 * All new nodes added in current build_backref_tree() haven't
+		 * been linked to the cache rb tree.
+		 * So if we have upper->rb_node populated, this means a cache
+		 * hit. We only need to link the edge, as @upper and all its
+		 * parent have already been linked.
+		 */
+		if (!RB_EMPTY_NODE(&upper->rb_node)) {
+			if (upper->lowest) {
+				list_del_init(&upper->lower);
+				upper->lowest = 0;
+			}
+
+			list_add_tail(&edge->list[UPPER], &upper->lower);
+			continue;
+		}
+
+		/* Sanity check, we shouldn't have any unchecked nodes */
+		if (!upper->checked) {
+			ASSERT(0);
+			return -EUCLEAN;
+		}
+
+		/* Sanity check, cowonly node has non-cowonly parent */
+		if (start->cowonly != upper->cowonly) {
+			ASSERT(0);
+			return -EUCLEAN;
+		}
+
+		/* Only cache non-cowonly (subvolume trees) tree blocks */
+		if (!upper->cowonly) {
+			rb_node = simple_insert(&cache->rb_root, upper->bytenr,
+						&upper->rb_node);
+			if (rb_node) {
+				backref_cache_panic(cache->fs_info,
+						upper->bytenr, -EEXIST);
+				return -EUCLEAN;
+			}
+		}
+
+		list_add_tail(&edge->list[UPPER], &upper->lower);
+
+		/*
+		 * Also queue all the parent edges of this uncached node
+		 * to finish the upper linkage
+		 */
+		list_for_each_entry(edge, &upper->upper, list[LOWER])
+			list_add_tail(&edge->list[UPPER], &pending_edge);
+	}
+	return 0;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 6b8b48bf6958..99d61922bf6c 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -392,4 +392,6 @@ int backref_cache_add_one_tree_block(struct backref_cache *cache,
 				     struct btrfs_backref_iter *iter,
 				     struct btrfs_key *node_key,
 				     struct backref_node *cur);
+int backref_cache_finish_upper_links(struct backref_cache *cache,
+				     struct backref_node *start);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ac3ac0c7ac9e..67691c56ce99 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -384,121 +384,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
-/*
- * In handle_one_tree_backref(), we have only linked the lower node to the edge,
- * but the upper node hasn't been linked to the edge.
- * This means we can only iterate through backref_node::upper to reach parent
- * edges, but not through backref_node::lower to reach children edges.
- *
- * This function will finish the backref_node::lower to related edges, so that
- * backref cache can be bi-directionally iterated.
- *
- * Also, this will add the nodes to backref cache for next run.
- */
-static int finish_upper_links(struct backref_cache *cache,
-			      struct backref_node *start)
-{
-	struct list_head *useless_node = &cache->useless_node;
-	struct backref_edge *edge;
-	struct rb_node *rb_node;
-	LIST_HEAD(pending_edge);
-
-	/*
-	 * everything goes well, connect backref nodes and insert backref nodes
-	 * into the cache.
-	 */
-	ASSERT(start->checked);
-	if (!start->cowonly) {
-		rb_node = simple_insert(&cache->rb_root, start->bytenr,
-					&start->rb_node);
-		if (rb_node)
-			backref_cache_panic(cache->fs_info, start->bytenr,
-					    -EEXIST);
-		list_add_tail(&start->lower, &cache->leaves);
-	}
-
-	/*
-	 * Use breadth first search to iterate all related edges.
-	 *
-	 * The start point is all the edges of this node
-	 */
-	list_for_each_entry(edge, &start->upper, list[LOWER])
-		list_add_tail(&edge->list[UPPER], &pending_edge);
-
-	while (!list_empty(&pending_edge)) {
-		struct backref_node *upper;
-		struct backref_node *lower;
-		struct rb_node *rb_node;
-
-		edge = list_entry(pending_edge.next, struct backref_edge,
-				  list[UPPER]);
-		list_del_init(&edge->list[UPPER]);
-		upper = edge->node[UPPER];
-		lower = edge->node[LOWER];
-
-		/* Parent is detached, no need to keep any edges */
-		if (upper->detached) {
-			list_del(&edge->list[LOWER]);
-			free_backref_edge(cache, edge);
-
-			/* Lower node is orphan, queue for cleanup */
-			if (list_empty(&lower->upper))
-				list_add(&lower->list, useless_node);
-			continue;
-		}
-
-		/*
-		 * All new nodes added in current build_backref_tree() haven't
-		 * been linked to the cache rb tree.
-		 * So if we have upper->rb_node populated, this means a cache
-		 * hit. We only need to link the edge, as @upper and all its
-		 * parent have already been linked.
-		 */
-		if (!RB_EMPTY_NODE(&upper->rb_node)) {
-			if (upper->lowest) {
-				list_del_init(&upper->lower);
-				upper->lowest = 0;
-			}
-
-			list_add_tail(&edge->list[UPPER], &upper->lower);
-			continue;
-		}
-
-		/* Sanity check, we shouldn't have any unchecked nodes */
-		if (!upper->checked) {
-			ASSERT(0);
-			return -EUCLEAN;
-		}
-
-		/* Sanity check, cowonly node has non-cowonly parent */
-		if (start->cowonly != upper->cowonly) {
-			ASSERT(0);
-			return -EUCLEAN;
-		}
-
-		/* Only cache non-cowonly (subvolume trees) tree blocks */
-		if (!upper->cowonly) {
-			rb_node = simple_insert(&cache->rb_root, upper->bytenr,
-						&upper->rb_node);
-			if (rb_node) {
-				backref_cache_panic(cache->fs_info,
-						upper->bytenr, -EEXIST);
-				return -EUCLEAN;
-			}
-		}
-
-		list_add_tail(&edge->list[UPPER], &upper->lower);
-
-		/*
-		 * Also queue all the parent edges of this uncached node
-		 * to finish the upper linkage
-		 */
-		list_for_each_entry(edge, &upper->upper, list[LOWER])
-			list_add_tail(&edge->list[UPPER], &pending_edge);
-	}
-	return 0;
-}
-
 /*
  * For useless nodes, do two major clean ups:
  * - Cleanup the children edges and nodes
@@ -644,7 +529,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	}
 
 	/* Finish the upper linkage of newly added edges/nodes */
-	ret = finish_upper_links(cache, node);
+	ret = backref_cache_finish_upper_links(cache, node);
 	if (ret < 0) {
 		err = ret;
 		goto out;
-- 
2.25.1

