Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF59B18F2B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCWKZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:38516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWKZj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F7F2B22C
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 24/40] btrfs: Rename remove_backref_node() to btrfs_backref_cleanup_node() and move it to backref.c
Date:   Mon, 23 Mar 2020 18:24:00 +0800
Message-Id: <20200323102416.112862-25-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
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
 fs/btrfs/backref.c    | 38 ++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  9 ++++++++
 fs/btrfs/relocation.c | 51 ++++---------------------------------------
 3 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 2bf3bf2d7b85..0c8950750682 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2515,3 +2515,41 @@ struct btrfs_backref_edge *btrfs_backref_alloc_edge(
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
index a6d568449c88..068a28c8e37b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -349,4 +349,13 @@ static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
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
index 47649ff1052f..4c687318f70b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -160,9 +160,6 @@ struct reloc_control {
 #define MOVE_DATA_EXTENTS	0
 #define UPDATE_DATA_PTRS	1
 
-static void remove_backref_node(struct btrfs_backref_cache *cache,
-				struct btrfs_backref_node *node);
-
 static void mark_block_processed(struct reloc_control *rc,
 				 struct btrfs_backref_node *node)
 {
@@ -193,13 +190,13 @@ static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
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
@@ -275,46 +272,6 @@ static struct btrfs_backref_node *walk_down_backref(
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
@@ -352,7 +309,7 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
 				  struct btrfs_backref_node, list);
-		remove_backref_node(cache, node);
+		btrfs_backref_cleanup_node(cache, node);
 	}
 
 	while (!list_empty(&cache->changed)) {
@@ -3038,7 +2995,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	}
 out:
 	if (ret || node->level == 0 || node->cowonly)
-		remove_backref_node(&rc->backref_cache, node);
+		btrfs_backref_cleanup_node(&rc->backref_cache, node);
 	return ret;
 }
 
-- 
2.25.2

