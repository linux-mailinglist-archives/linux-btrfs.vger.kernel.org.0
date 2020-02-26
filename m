Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF416F7B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 06:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBZF5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 00:57:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:36654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgBZF5Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 00:57:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13AD6ACA1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 05:57:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: relocation: Refactor the finishing part of upper linkage into finish_upper_links()
Date:   Wed, 26 Feb 2020 13:56:51 +0800
Message-Id: <20200226055652.24857-10-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200226055652.24857-1-wqu@suse.com>
References: <20200226055652.24857-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After handle_one_tree_backref(), all newly added (not cached) edges and
nodes have the following features:

- Only backref_edge::list[LOWER] is linked.
  This means, we can only iterate from botton to top, not the other
  direction.

- Newly added nodes are not added to cache rb_tree yet

So to finish the backref cache, we still need to finish the links and
add all nodes into backref cache rb_tree.

This patch will refactor the existing code into finish_upper_links(),
add more comments of each branch, and why we need to do all these works.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 163 +++++++++++++++++++++++++++---------------
 1 file changed, 107 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 13eadbb1c552..37aa5db6b13a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -952,6 +952,106 @@ static int handle_one_tree_block(struct reloc_control *rc,
 	return ret;
 }
 
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
+static int finish_upper_links(struct backref_cache *cache,
+			      struct backref_node *start,
+			      struct list_head *useless_node)
+{
+	struct backref_edge *edge;
+	LIST_HEAD(pending_edge);
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
+			rb_node = tree_insert(&cache->rb_root, upper->bytenr,
+					      &upper->rb_node);
+			if (rb_node) {
+				backref_tree_panic(rb_node, -EEXIST,
+						   upper->bytenr);
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
+
 /*
  * build backref tree for a given tree block. root of the backref tree
  * corresponds the tree block, leaves of the backref tree correspond
@@ -982,7 +1082,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct rb_node *rb_node;
 	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
 	LIST_HEAD(useless);
-	int cowonly;
 	int ret;
 	int err = 0;
 
@@ -1028,8 +1127,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	 * into the cache.
 	 */
 	ASSERT(node->checked);
-	cowonly = node->cowonly;
-	if (!cowonly) {
+	if (!node->cowonly) {
 		rb_node = tree_insert(&cache->rb_root, node->bytenr,
 				      &node->rb_node);
 		if (rb_node)
@@ -1037,60 +1135,13 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		list_add_tail(&node->lower, &cache->leaves);
 	}
 
-	list_for_each_entry(edge, &node->upper, list[LOWER])
-		list_add_tail(&edge->list[UPPER], &list);
-
-	while (!list_empty(&list)) {
-		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
-		list_del_init(&edge->list[UPPER]);
-		upper = edge->node[UPPER];
-		if (upper->detached) {
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
-			if (list_empty(&lower->upper))
-				list_add(&lower->list, &useless);
-			continue;
-		}
-
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
-		if (!upper->checked) {
-			/*
-			 * Still want to blow up for developers since this is a
-			 * logic bug.
-			 */
-			ASSERT(0);
-			err = -EINVAL;
-			goto out;
-		}
-		if (cowonly != upper->cowonly) {
-			ASSERT(0);
-			err = -EINVAL;
-			goto out;
-		}
-
-		if (!cowonly) {
-			rb_node = tree_insert(&cache->rb_root, upper->bytenr,
-					      &upper->rb_node);
-			if (rb_node)
-				backref_tree_panic(rb_node, -EEXIST,
-						   upper->bytenr);
-		}
-
-		list_add_tail(&edge->list[UPPER], &upper->lower);
-
-		list_for_each_entry(edge, &upper->upper, list[LOWER])
-			list_add_tail(&edge->list[UPPER], &list);
+	/* Finish the upper linkage of newly added edges/nodes */
+	ret = finish_upper_links(cache, node, &useless);
+	if (ret < 0) {
+		err = ret;
+		goto out;
 	}
+
 	/*
 	 * process useless backref nodes. backref nodes for tree leaves
 	 * are deleted from the cache. backref nodes for upper level
-- 
2.25.1

