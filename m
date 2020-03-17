Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA21187AE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQIMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCQIMR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A0BFADA1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 14/39] btrfs: relocation: Refactor the useless nodes handling into its own function
Date:   Tue, 17 Mar 2020 16:11:00 +0800
Message-Id: <20200317081125.36289-15-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will also add some comment for the cleanup up.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 112 ++++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d85c02e9d8f7..83f846dc9171 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1191,6 +1191,79 @@ static int finish_upper_links(struct backref_cache *cache,
 	return 0;
 }
 
+/*
+ * For useless nodes, do two major clean ups:
+ * - Cleanup the children edges and nodes
+ *   If child node is also orphan (no parent) during cleanup, then the
+ *   child node will also be cleaned up.
+ *
+ * - Freeing up leaves (level 0), keeps nodes detached
+ *   For nodes, the node is still cached as "detached"
+ *
+ * Return false if @node is not in the @useless_nodes list.
+ * Return true if @node is in the @useless_nodes list.
+ */
+static bool handle_useless_nodes(struct reloc_control *rc,
+				 struct backref_node *node)
+{
+	struct backref_cache *cache = &rc->backref_cache;
+	struct list_head *useless_node = &cache->useless_node;
+	bool ret = false;
+
+	while (!list_empty(useless_node)) {
+		struct backref_node *cur;
+
+		cur = list_first_entry(useless_node, struct backref_node,
+				 list);
+		list_del_init(&cur->list);
+
+		/* Only tree root nodes can be added to @useless_nodes */
+		ASSERT(list_empty(&cur->upper));
+
+		if (cur == node)
+			ret = true;
+
+		/* The node is the lowest node */
+		if (cur->lowest) {
+			list_del_init(&cur->lower);
+			cur->lowest = 0;
+		}
+
+		/* Cleanup the lower edges */
+		while (!list_empty(&cur->lower)) {
+			struct backref_edge *edge;
+			struct backref_node *lower;
+
+			edge = list_entry(cur->lower.next,
+					  struct backref_edge, list[UPPER]);
+			list_del(&edge->list[UPPER]);
+			list_del(&edge->list[LOWER]);
+			lower = edge->node[LOWER];
+			free_backref_edge(cache, edge);
+
+			/* Child node is also orphan, queue for cleanup */
+			if (list_empty(&lower->upper))
+				list_add(&lower->list, useless_node);
+		}
+		/* Mark this block processed for relocation */
+		mark_block_processed(rc, cur);
+
+		/*
+		 * Backref nodes for tree leaves are deleted from the cache.
+		 * Backref nodes for upper level tree blocks are left in the
+		 * cache to avoid unnecessary backref lookup.
+		 */
+		if (cur->level > 0) {
+			list_add(&cur->list, &cache->detached);
+			cur->detached = 1;
+		} else {
+			rb_erase(&cur->rb_node, &cache->rb_root);
+			free_backref_node(cache, cur);
+		}
+	}
+	return ret;
+}
+
 /*
  * build backref tree for a given tree block. root of the backref tree
  * corresponds the tree block, leaves of the backref tree correspond
@@ -1263,43 +1336,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		goto out;
 	}
 
-	/*
-	 * process useless backref nodes. backref nodes for tree leaves
-	 * are deleted from the cache. backref nodes for upper level
-	 * tree blocks are left in the cache to avoid unnecessary backref
-	 * lookup.
-	 */
-	while (!list_empty(&cache->useless_node)) {
-		upper = list_first_entry(&cache->useless_node,
-				   struct backref_node, list);
-		list_del_init(&upper->list);
-		ASSERT(list_empty(&upper->upper));
-		if (upper == node)
-			node = NULL;
-		if (upper->lowest) {
-			list_del_init(&upper->lower);
-			upper->lowest = 0;
-		}
-		while (!list_empty(&upper->lower)) {
-			edge = list_first_entry(&upper->lower,
-					  struct backref_edge, list[UPPER]);
-			list_del(&edge->list[UPPER]);
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
-
-			if (list_empty(&lower->upper))
-				list_add(&lower->list, &cache->useless_node);
-		}
-		mark_block_processed(rc, upper);
-		if (upper->level > 0) {
-			list_add(&upper->list, &cache->detached);
-			upper->detached = 1;
-		} else {
-			rb_erase(&upper->rb_node, &cache->rb_root);
-			free_backref_node(cache, upper);
-		}
-	}
+	if (handle_useless_nodes(rc, node))
+		node = NULL;
 out:
 	btrfs_backref_iter_free(iter);
 	btrfs_free_path(path);
-- 
2.25.1

