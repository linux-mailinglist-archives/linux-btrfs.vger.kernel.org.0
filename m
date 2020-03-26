Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779BE193AF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCZIeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgCZIeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5BEA7AFD8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 24/39] btrfs: Rename remove_backref_node() to btrfs_backref_cleanup_node() and move it to backref.c
Date:   Thu, 26 Mar 2020 16:33:01 +0800
Message-Id: <20200326083316.48847-25-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also add comment explaining the cleanup progress, to differ it from
btrfs_backref_drop_node().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 38 +++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  9 ++++++++
 fs/btrfs/relocation.c | 53 ++++---------------------------------------
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9475b6ccc7eb..5cab1b71d0b5 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2511,3 +2511,41 @@ struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 		cache->nr_edges++;
 	return edge;
 }
+
+void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
+				struct btrfs_backref_node *node)
+{
+	struct btrfs_backref_node *upper;
+	struct btrfs_backref_edge *edge;
+
+	if (!node)
+		return;
+
+	BUG_ON(!node->lowest && !node->detached);
+	while (!list_empty(&node->upper)) {
+		edge = list_entry(node->upper.next, struct btrfs_backref_edge,
+				  list[LOWER]);
+		upper = edge->node[UPPER];
+		list_del(&edge->list[LOWER]);
+		list_del(&edge->list[UPPER]);
+		btrfs_backref_free_edge(cache, edge);
+
+		if (RB_EMPTY_NODE(&upper->rb_node)) {
+			BUG_ON(!list_empty(&node->upper));
+			btrfs_backref_drop_node(cache, node);
+			node = upper;
+			node->lowest = 1;
+			continue;
+		}
+		/*
+		 * add the node to leaf node list if no other
+		 * child block cached.
+		 */
+		if (list_empty(&upper->lower)) {
+			list_add_tail(&upper->lower, &cache->leaves);
+			upper->lowest = 1;
+		}
+	}
+
+	btrfs_backref_drop_node(cache, node);
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 5e8d368d9a82..5bc3700fea1d 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -353,4 +353,13 @@ static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
 	btrfs_backref_free_node(tree, node);
 }
 
+/*
+ * Drop the backref node from cache, also cleaning up all its
+ * upper edges and any uncached nodes in the path.
+ *
+ * This cleanup happens bottom up, thus the node should either
+ * be the lowest node in the cache or detached node.
+ */
+void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
+				struct btrfs_backref_node *node);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fd94bd18f2ad..04d9b88d92aa 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -153,9 +153,6 @@ struct reloc_control {
 #define MOVE_DATA_EXTENTS	0
 #define UPDATE_DATA_PTRS	1
 
-static void remove_backref_node(struct btrfs_backref_cache *cache,
-				struct btrfs_backref_node *node);
-
 static void mark_block_processed(struct reloc_control *rc,
 				 struct btrfs_backref_node *node)
 {
@@ -186,13 +183,13 @@ static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
 				  struct btrfs_backref_node, list);
-		remove_backref_node(cache, node);
+		btrfs_backref_cleanup_node(cache, node);
 	}
 
 	while (!list_empty(&cache->leaves)) {
 		node = list_entry(cache->leaves.next,
 				  struct btrfs_backref_node, lower);
-		remove_backref_node(cache, node);
+		btrfs_backref_cleanup_node(cache, node);
 	}
 
 	cache->last_trans = 0;
@@ -268,46 +265,6 @@ static struct btrfs_backref_node *walk_down_backref(
 	*index = 0;
 	return NULL;
 }
-/*
- * remove a backref node from the backref cache
- */
-static void remove_backref_node(struct btrfs_backref_cache *cache,
-				struct btrfs_backref_node *node)
-{
-	struct btrfs_backref_node *upper;
-	struct btrfs_backref_edge *edge;
-
-	if (!node)
-		return;
-
-	BUG_ON(!node->lowest && !node->detached);
-	while (!list_empty(&node->upper)) {
-		edge = list_entry(node->upper.next, struct btrfs_backref_edge,
-				  list[LOWER]);
-		upper = edge->node[UPPER];
-		list_del(&edge->list[LOWER]);
-		list_del(&edge->list[UPPER]);
-		btrfs_backref_free_edge(cache, edge);
-
-		if (RB_EMPTY_NODE(&upper->rb_node)) {
-			BUG_ON(!list_empty(&node->upper));
-			btrfs_backref_drop_node(cache, node);
-			node = upper;
-			node->lowest = 1;
-			continue;
-		}
-		/*
-		 * add the node to leaf node list if no other
-		 * child block cached.
-		 */
-		if (list_empty(&upper->lower)) {
-			list_add_tail(&upper->lower, &cache->leaves);
-			upper->lowest = 1;
-		}
-	}
-
-	btrfs_backref_drop_node(cache, node);
-}
 
 static void update_backref_node(struct btrfs_backref_cache *cache,
 				struct btrfs_backref_node *node, u64 bytenr)
@@ -345,7 +302,7 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
 				  struct btrfs_backref_node, list);
-		remove_backref_node(cache, node);
+		btrfs_backref_cleanup_node(cache, node);
 	}
 
 	while (!list_empty(&cache->changed)) {
@@ -1120,7 +1077,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 			btrfs_backref_free_node(cache, lower);
 		}
 
-		remove_backref_node(cache, node);
+		btrfs_backref_cleanup_node(cache, node);
 		ASSERT(list_empty(&cache->useless_node) &&
 		       list_empty(&cache->pending_edge));
 		return ERR_PTR(err);
@@ -3088,7 +3045,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	}
 out:
 	if (ret || node->level == 0 || node->cowonly)
-		remove_backref_node(&rc->backref_cache, node);
+		btrfs_backref_cleanup_node(&rc->backref_cache, node);
 	return ret;
 }
 
-- 
2.26.0

