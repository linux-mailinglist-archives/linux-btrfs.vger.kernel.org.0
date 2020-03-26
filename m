Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F7193AE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCZIdf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgCZIdf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75775AD08;
        Thu, 26 Mar 2020 08:33:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 05/39] btrfs: relocation: Add backref_cache::pending_edge and backref_cache::useless_node members
Date:   Thu, 26 Mar 2020 16:32:42 +0800
Message-Id: <20200326083316.48847-6-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These two new members will act the same as the existing local lists,
@useless and @list in build_backref_tree().

Currently build_backref_tree() is only executed serially, thus moving
such local list into backref_cache is still safe.

Also since we're here, use list_first_entry() to replace a lot of
list_entry() calls after !list_empty().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 74 +++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7171e80454ba..108ea3d428bc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -158,6 +158,12 @@ struct backref_cache {
 
 	int nr_nodes;
 	int nr_edges;
+
+	/* The list of unchecked backref edges during backref cache build */
+	struct list_head pending_edge;
+
+	/* The list of useless backref nodes during backref cache build */
+	struct list_head useless_node;
 };
 
 /*
@@ -269,6 +275,8 @@ static void backref_cache_init(struct backref_cache *cache)
 	INIT_LIST_HEAD(&cache->changed);
 	INIT_LIST_HEAD(&cache->detached);
 	INIT_LIST_HEAD(&cache->leaves);
+	INIT_LIST_HEAD(&cache->pending_edge);
+	INIT_LIST_HEAD(&cache->useless_node);
 }
 
 static void backref_cache_cleanup(struct backref_cache *cache)
@@ -292,6 +300,8 @@ static void backref_cache_cleanup(struct backref_cache *cache)
 
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
 		ASSERT(list_empty(&cache->pending[i]));
+	ASSERT(list_empty(&cache->pending_edge));
+	ASSERT(list_empty(&cache->useless_node));
 	ASSERT(list_empty(&cache->changed));
 	ASSERT(list_empty(&cache->detached));
 	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
@@ -698,8 +708,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct backref_node *exist = NULL;
 	struct backref_edge *edge;
 	struct rb_node *rb_node;
-	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
-	LIST_HEAD(useless);
 	int cowonly;
 	int ret;
 	int err = 0;
@@ -763,7 +771,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		 * check its backrefs
 		 */
 		if (!exist->checked)
-			list_add_tail(&edge->list[UPPER], &list);
+			list_add_tail(&edge->list[UPPER], &cache->pending_edge);
 	} else {
 		exist = NULL;
 	}
@@ -841,7 +849,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				 *  backrefs for the upper level block isn't
 				 *  cached, add the block to pending list
 				 */
-				list_add_tail(&edge->list[UPPER], &list);
+				list_add_tail(&edge->list[UPPER],
+					      &cache->pending_edge);
 			} else {
 				upper = rb_entry(rb_node, struct backref_node,
 						 rb_node);
@@ -883,7 +892,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			       cur->bytenr);
 			if (should_ignore_root(root)) {
 				btrfs_put_root(root);
-				list_add(&cur->list, &useless);
+				list_add(&cur->list, &cache->useless_node);
 			} else {
 				cur->root = root;
 			}
@@ -929,7 +938,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				       lower->bytenr);
 				if (should_ignore_root(root)) {
 					btrfs_put_root(root);
-					list_add(&lower->list, &useless);
+					list_add(&lower->list,
+						 &cache->useless_node);
 				} else {
 					lower->root = root;
 				}
@@ -978,7 +988,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 				if (!upper->checked && need_check) {
 					need_check = false;
 					list_add_tail(&edge->list[UPPER],
-						      &list);
+						      &cache->pending_edge);
 				} else {
 					if (upper->checked)
 						need_check = true;
@@ -1016,8 +1026,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	WARN_ON(exist);
 
 	/* the pending list isn't empty, take the first block to process */
-	if (!list_empty(&list)) {
-		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
+	if (!list_empty(&cache->pending_edge)) {
+		edge = list_entry(cache->pending_edge.next,
+				  struct backref_edge, list[UPPER]);
 		list_del_init(&edge->list[UPPER]);
 		cur = edge->node[UPPER];
 		goto again;
@@ -1038,10 +1049,11 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	}
 
 	list_for_each_entry(edge, &node->upper, list[LOWER])
-		list_add_tail(&edge->list[UPPER], &list);
+		list_add_tail(&edge->list[UPPER], &cache->pending_edge);
 
-	while (!list_empty(&list)) {
-		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
+	while (!list_empty(&cache->pending_edge)) {
+		edge = list_first_entry(&cache->pending_edge,
+				struct backref_edge, list[UPPER]);
 		list_del_init(&edge->list[UPPER]);
 		upper = edge->node[UPPER];
 		if (upper->detached) {
@@ -1049,7 +1061,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			lower = edge->node[LOWER];
 			free_backref_edge(cache, edge);
 			if (list_empty(&lower->upper))
-				list_add(&lower->list, &useless);
+				list_add(&lower->list, &cache->useless_node);
 			continue;
 		}
 
@@ -1089,7 +1101,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		list_add_tail(&edge->list[UPPER], &upper->lower);
 
 		list_for_each_entry(edge, &upper->upper, list[LOWER])
-			list_add_tail(&edge->list[UPPER], &list);
+			list_add_tail(&edge->list[UPPER], &cache->pending_edge);
 	}
 	/*
 	 * process useless backref nodes. backref nodes for tree leaves
@@ -1097,8 +1109,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	 * tree blocks are left in the cache to avoid unnecessary backref
 	 * lookup.
 	 */
-	while (!list_empty(&useless)) {
-		upper = list_entry(useless.next, struct backref_node, list);
+	while (!list_empty(&cache->useless_node)) {
+		upper = list_first_entry(&cache->useless_node,
+				   struct backref_node, list);
 		list_del_init(&upper->list);
 		ASSERT(list_empty(&upper->upper));
 		if (upper == node)
@@ -1108,7 +1121,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			upper->lowest = 0;
 		}
 		while (!list_empty(&upper->lower)) {
-			edge = list_entry(upper->lower.next,
+			edge = list_first_entry(&upper->lower,
 					  struct backref_edge, list[UPPER]);
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
@@ -1116,7 +1129,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			free_backref_edge(cache, edge);
 
 			if (list_empty(&lower->upper))
-				list_add(&lower->list, &useless);
+				list_add(&lower->list, &cache->useless_node);
 		}
 		mark_block_processed(rc, upper);
 		if (upper->level > 0) {
@@ -1131,14 +1144,14 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
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
@@ -1151,20 +1164,21 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
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
+			lower = list_first_entry(&cache->useless_node,
 					   struct backref_node, list);
 			list_del_init(&lower->list);
 			if (lower == node)
@@ -1173,9 +1187,13 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		}
 
 		remove_backref_node(cache, node);
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
2.26.0

