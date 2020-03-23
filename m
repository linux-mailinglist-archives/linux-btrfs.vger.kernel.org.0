Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6550518F2AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgCWKY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:24:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgCWKY7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A6A8ADF1;
        Mon, 23 Mar 2020 10:24:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/40] btrfs: relocation: Use wrapper to replace open-coded edge linking
Date:   Mon, 23 Mar 2020 18:23:46 +0800
Message-Id: <20200323102416.112862-11-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since backref_edge is used to connect upper and lower backref nodes, and
need to access both nodes, some code can look pretty nasty:

		list_add_tail(&edge->list[LOWER], &cur->upper);

The above code will link @cur to the LOWER side of the edge, while both
"LOWER" and "upper" words show up.
This can sometimes be very confusing for reader to grasp.

This patch introduce a new wrapper, link_backref_edge(), to handle the
linking behavior.
Which also has extra ASSERT() to ensure caller won't pass wrong nodes
in.

Also, this updates the comment of related lists of backref_node and
backref_edge, to make it more clear that each list points to what.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 53 ++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 652476a5cef2..d3d46590a733 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -91,10 +91,12 @@ struct backref_node {
 	u64 owner;
 	/* link to pending, changed or detached list */
 	struct list_head list;
-	/* list of upper level blocks reference this block */
+
+	/* List of upper level edges, which links this node to its parent(s) */
 	struct list_head upper;
-	/* list of child blocks in the cache */
+	/* List of lower level edges, which links this node to its child(ren) */
 	struct list_head lower;
+
 	/* NULL if this node is not tree root */
 	struct btrfs_root *root;
 	/* extent buffer got by COW the block */
@@ -129,17 +131,26 @@ struct backref_node {
 	unsigned int is_reloc_root:1;
 };
 
+#define LOWER	0
+#define UPPER	1
+#define RELOCATION_RESERVED_NODES	256
 /*
- * present a block pointer in the backref cache
+ * present an edge connecting upper and lower backref nodes.
  */
 struct backref_edge {
+	/*
+	 * list[LOWER] is linked to backref_node::upper of lower level node,
+	 * and list[UPPER] is linked to backref_node::lower of upper level node.
+	 *
+	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
+	 * linking list[UPPER] to its upper level nodes.
+	 */
 	struct list_head list[2];
+
+	/* Two related nodes */
 	struct backref_node *node[2];
 };
 
-#define LOWER	0
-#define UPPER	1
-#define RELOCATION_RESERVED_NODES	256
 
 struct backref_cache {
 	/* red black tree of all backref nodes in the cache */
@@ -362,6 +373,22 @@ static struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
 	return edge;
 }
 
+#define		LINK_LOWER	(1 << 0)
+#define		LINK_UPPER	(1 << 1)
+static void link_backref_edge(struct backref_edge *edge,
+			      struct backref_node *lower,
+			      struct backref_node *upper,
+			      int link_which)
+{
+	ASSERT(upper && lower && upper->level == lower->level + 1);
+	edge->node[LOWER] = lower;
+	edge->node[UPPER] = upper;
+	if (link_which & LINK_LOWER)
+		list_add_tail(&edge->list[LOWER], &lower->upper);
+	if (link_which & LINK_UPPER)
+		list_add_tail(&edge->list[UPPER], &upper->lower);
+}
+
 static void free_backref_edge(struct backref_cache *cache,
 			      struct backref_edge *edge)
 {
@@ -767,9 +794,7 @@ static int handle_direct_tree_backref(struct backref_cache *cache,
 		ASSERT(upper->checked);
 		INIT_LIST_HEAD(&edge->list[UPPER]);
 	}
-	list_add_tail(&edge->list[LOWER], &cur->upper);
-	edge->node[LOWER] = cur;
-	edge->node[UPPER] = upper;
+	link_backref_edge(edge, cur, upper, LINK_LOWER);
 	return 0;
 }
 
@@ -915,9 +940,7 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 			if (!upper->owner)
 				upper->owner = btrfs_header_owner(eb);
 		}
-		list_add_tail(&edge->list[LOWER], &lower->upper);
-		edge->node[LOWER] = lower;
-		edge->node[UPPER] = upper;
+		link_backref_edge(edge, lower, upper, LINK_LOWER);
 
 		if (rb_node) {
 			btrfs_put_root(root);
@@ -1341,10 +1364,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 			if (!new_edge)
 				goto fail;
 
-			new_edge->node[UPPER] = new_node;
-			new_edge->node[LOWER] = edge->node[LOWER];
-			list_add_tail(&new_edge->list[UPPER],
-				      &new_node->lower);
+			link_backref_edge(new_edge, edge->node[LOWER], new_node,
+					  LINK_UPPER);
 		}
 	} else {
 		list_add_tail(&new_node->lower, &cache->leaves);
-- 
2.25.2

