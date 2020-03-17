Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C913187AF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCQIMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:42768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgCQIMh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 282B2ADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 23/39] btrfs: Rename remove_backref_node() to cleanup_backref_node() and move it to backref.c
Date:   Tue, 17 Mar 2020 16:11:09 +0800
Message-Id: <20200317081125.36289-24-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also add comment explaining the cleanup progress, to differ it from
drop_backref_node().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 38 ++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  9 ++++++++
 fs/btrfs/relocation.c | 51 ++++---------------------------------------
 3 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 77201948a583..2fd6100327d5 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2514,3 +2514,41 @@ struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
 		cache->nr_edges++;
 	return edge;
 }
+
+void cleanup_backref_node(struct backref_cache *cache,
+			  struct backref_node *node)
+{
+	struct backref_node *upper;
+	struct backref_edge *edge;
+
+	if (!node)
+		return;
+
+	BUG_ON(!node->lowest && !node->detached);
+	while (!list_empty(&node->upper)) {
+		edge = list_entry(node->upper.next, struct backref_edge,
+				  list[LOWER]);
+		upper = edge->node[UPPER];
+		list_del(&edge->list[LOWER]);
+		list_del(&edge->list[UPPER]);
+		free_backref_edge(cache, edge);
+
+		if (RB_EMPTY_NODE(&upper->rb_node)) {
+			BUG_ON(!list_empty(&node->upper));
+			drop_backref_node(cache, node);
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
+	drop_backref_node(cache, node);
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 5c0300bde7fa..a55e7cf77092 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -347,4 +347,13 @@ static inline void drop_backref_node(struct backref_cache *tree,
 	free_backref_node(tree, node);
 }
 
+/*
+ * Drop the backref node from cache, also cleaning up all its
+ * upper edges and any uncached nodes in the path.
+ *
+ * This cleanup happens bottom up, thus the node should either
+ * be the lowest node in the cache or detached node.
+ */
+void cleanup_backref_node(struct backref_cache *cache,
+			  struct backref_node *node);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1f656b07fe90..9d355cf41f08 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -161,9 +161,6 @@ struct reloc_control {
 #define MOVE_DATA_EXTENTS	0
 #define UPDATE_DATA_PTRS	1
 
-static void remove_backref_node(struct backref_cache *cache,
-				struct backref_node *node);
-
 static void mark_block_processed(struct reloc_control *rc,
 				 struct backref_node *node)
 {
@@ -193,13 +190,13 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
 				  struct backref_node, list);
-		remove_backref_node(cache, node);
+		cleanup_backref_node(cache, node);
 	}
 
 	while (!list_empty(&cache->leaves)) {
 		node = list_entry(cache->leaves.next,
 				  struct backref_node, lower);
-		remove_backref_node(cache, node);
+		cleanup_backref_node(cache, node);
 	}
 
 	cache->last_trans = 0;
@@ -275,46 +272,6 @@ static struct backref_node *walk_down_backref(struct backref_edge *edges[],
 	*index = 0;
 	return NULL;
 }
-/*
- * remove a backref node from the backref cache
- */
-static void remove_backref_node(struct backref_cache *cache,
-				struct backref_node *node)
-{
-	struct backref_node *upper;
-	struct backref_edge *edge;
-
-	if (!node)
-		return;
-
-	BUG_ON(!node->lowest && !node->detached);
-	while (!list_empty(&node->upper)) {
-		edge = list_entry(node->upper.next, struct backref_edge,
-				  list[LOWER]);
-		upper = edge->node[UPPER];
-		list_del(&edge->list[LOWER]);
-		list_del(&edge->list[UPPER]);
-		free_backref_edge(cache, edge);
-
-		if (RB_EMPTY_NODE(&upper->rb_node)) {
-			BUG_ON(!list_empty(&node->upper));
-			drop_backref_node(cache, node);
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
-	drop_backref_node(cache, node);
-}
 
 static void update_backref_node(struct backref_cache *cache,
 				struct backref_node *node, u64 bytenr)
@@ -352,7 +309,7 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 	while (!list_empty(&cache->detached)) {
 		node = list_entry(cache->detached.next,
 				  struct backref_node, list);
-		remove_backref_node(cache, node);
+		cleanup_backref_node(cache, node);
 	}
 
 	while (!list_empty(&cache->changed)) {
@@ -3032,7 +2989,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 	}
 out:
 	if (ret || node->level == 0 || node->cowonly)
-		remove_backref_node(&rc->backref_cache, node);
+		cleanup_backref_node(&rc->backref_cache, node);
 	return ret;
 }
 
-- 
2.25.1

