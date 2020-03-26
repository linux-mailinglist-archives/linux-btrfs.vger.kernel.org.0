Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEA193B04
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCZIea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgCZIea (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6DE17AD08
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 30/39] btrfs: Rename finish_upper_links() to btrfs_backref_finish_upper_links() and move it to backref.c
Date:   Thu, 26 Mar 2020 16:33:07 +0800
Message-Id: <20200326083316.48847-31-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
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
 fs/btrfs/backref.c    | 102 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |   5 ++
 fs/btrfs/relocation.c | 116 +-----------------------------------------
 3 files changed, 108 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index b13cf6e144c8..5bc8c7d6145e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2935,3 +2935,105 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 	btrfs_backref_iter_release(iter);
 	return ret;
 }
+
+int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
+				     struct btrfs_backref_node *start)
+{
+	struct list_head *useless_node = &cache->useless_node;
+	struct btrfs_backref_edge *edge;
+	struct rb_node *rb_node;
+	LIST_HEAD(pending_edge);
+
+	ASSERT(start->checked);
+
+	/* Insert this node to cache if it's not cowonly */
+	if (!start->cowonly) {
+		rb_node = simple_insert(&cache->rb_root, start->bytenr,
+					&start->rb_node);
+		if (rb_node)
+			btrfs_backref_panic(cache->fs_info, start->bytenr,
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
+		struct btrfs_backref_node *upper;
+		struct btrfs_backref_node *lower;
+		struct rb_node *rb_node;
+
+		edge = list_first_entry(&pending_edge,
+				struct btrfs_backref_edge, list[UPPER]);
+		list_del_init(&edge->list[UPPER]);
+		upper = edge->node[UPPER];
+		lower = edge->node[LOWER];
+
+		/* Parent is detached, no need to keep any edges */
+		if (upper->detached) {
+			list_del(&edge->list[LOWER]);
+			btrfs_backref_free_edge(cache, edge);
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
+				btrfs_backref_panic(cache->fs_info,
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
index 929342b99e2b..415ab4a05bd8 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -379,6 +379,7 @@ static inline void btrfs_backref_panic(struct btrfs_fs_info *fs_info,
  *
  * NOTE: Even if the function returned 0, @cur is not yet cached as its upper
  *	 links aren't yet bi-directional. Needs to finish such links.
+ *	 Use btrfs_backref_finish_upper_links() to finish such linkage.
  *
  * @path:	Released path for indirect tree backref lookup
  * @iter:	Released backref iter for extent tree search
@@ -389,4 +390,8 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 				struct btrfs_backref_iter *iter,
 				struct btrfs_key *node_key,
 				struct btrfs_backref_node *cur);
+
+/* Finish the upwards linkage created by btrfs_backref_add_tree_node(). */
+int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
+				     struct btrfs_backref_node *start);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d8ab93425b16..cd2037421406 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -377,120 +377,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
-/*
- * In handle_one_tree_backref(), we have only linked the lower node to the edge,
- * but the upper node hasn't been linked to the edge.
- * This means we can only iterate through btrfs_backref_node::upper to reach
- * parent edges, but not through btrfs_backref_node::lower to reach children
- * edges.
- *
- * This function will finish the btrfs_backref_node::lower to related edges,
- * so that backref cache can be bi-directionally iterated.
- *
- * Also, this will add the nodes to backref cache for next run.
- */
-static int finish_upper_links(struct btrfs_backref_cache *cache,
-			      struct btrfs_backref_node *start)
-{
-	struct list_head *useless_node = &cache->useless_node;
-	struct btrfs_backref_edge *edge;
-	struct rb_node *rb_node;
-	LIST_HEAD(pending_edge);
-
-	ASSERT(start->checked);
-
-	/* Insert this node to cache if it's not cowonly */
-	if (!start->cowonly) {
-		rb_node = simple_insert(&cache->rb_root, start->bytenr,
-					&start->rb_node);
-		if (rb_node)
-			btrfs_backref_panic(cache->fs_info, start->bytenr,
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
-		struct btrfs_backref_node *upper;
-		struct btrfs_backref_node *lower;
-		struct rb_node *rb_node;
-
-		edge = list_first_entry(&pending_edge,
-				struct btrfs_backref_edge, list[UPPER]);
-		list_del_init(&edge->list[UPPER]);
-		upper = edge->node[UPPER];
-		lower = edge->node[LOWER];
-
-		/* Parent is detached, no need to keep any edges */
-		if (upper->detached) {
-			list_del(&edge->list[LOWER]);
-			btrfs_backref_free_edge(cache, edge);
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
-				btrfs_backref_panic(cache->fs_info,
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
@@ -633,7 +519,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 	} while (edge);
 
 	/* Finish the upper linkage of newly added edges/nodes */
-	ret = finish_upper_links(cache, node);
+	ret = btrfs_backref_finish_upper_links(cache, node);
 	if (ret < 0) {
 		err = ret;
 		goto out;
-- 
2.26.0

