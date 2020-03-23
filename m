Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9327218F2B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgCWKZc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWKZc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30ABFADF1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 22/40] btrfs: Rename free_backref_(node|edge) to btrfs_backref_free_(node|edge) and move them to backref.h
Date:   Mon, 23 Mar 2020 18:23:58 +0800
Message-Id: <20200323102416.112862-23-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    | 20 ++++++++++++++++++++
 fs/btrfs/relocation.c | 44 ++++++++++++-------------------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 70dfd8dd0cdd..6d583666b796 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -8,6 +8,7 @@
 
 #include <linux/btrfs.h>
 #include "ulist.h"
+#include "disk-io.h"
 #include "extent_io.h"
 
 struct inode_fs_paths {
@@ -290,4 +291,23 @@ static inline void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
 	if (link_which & LINK_UPPER)
 		list_add_tail(&edge->list[UPPER], &upper->lower);
 }
+static inline void btrfs_backref_free_node(struct btrfs_backref_cache *cache,
+					   struct btrfs_backref_node *node)
+{
+	if (node) {
+		cache->nr_nodes--;
+		btrfs_put_root(node->root);
+		kfree(node);
+	}
+}
+
+static inline void btrfs_backref_free_edge(struct btrfs_backref_cache *cache,
+					   struct btrfs_backref_edge *edge)
+{
+	if (edge) {
+		cache->nr_edges--;
+		kfree(edge);
+	}
+}
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ef06e6878747..fb0a94f21201 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -215,26 +215,6 @@ static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static void free_backref_node(struct btrfs_backref_cache *cache,
-			      struct btrfs_backref_node *node)
-{
-	if (node) {
-		cache->nr_nodes--;
-		btrfs_put_root(node->root);
-		kfree(node);
-	}
-}
-
-
-static void free_backref_edge(struct btrfs_backref_cache *cache,
-			      struct btrfs_backref_edge *edge)
-{
-	if (edge) {
-		cache->nr_edges--;
-		kfree(edge);
-	}
-}
-
 static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
 {
 
@@ -323,7 +303,7 @@ static void drop_backref_node(struct btrfs_backref_cache *tree,
 	list_del(&node->lower);
 	if (!RB_EMPTY_NODE(&node->rb_node))
 		rb_erase(&node->rb_node, &tree->rb_root);
-	free_backref_node(tree, node);
+	btrfs_backref_free_node(tree, node);
 }
 
 /*
@@ -345,7 +325,7 @@ static void remove_backref_node(struct btrfs_backref_cache *cache,
 		upper = edge->node[UPPER];
 		list_del(&edge->list[LOWER]);
 		list_del(&edge->list[UPPER]);
-		free_backref_edge(cache, edge);
+		btrfs_backref_free_edge(cache, edge);
 
 		if (RB_EMPTY_NODE(&upper->rb_node)) {
 			BUG_ON(!list_empty(&node->upper));
@@ -572,7 +552,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		upper = btrfs_backref_alloc_node(cache, ref_key->offset,
 					   cur->level + 1);
 		if (!upper) {
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 			return -ENOMEM;
 		}
 
@@ -695,7 +675,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 							 lower->level + 1);
 			if (!upper) {
 				btrfs_put_root(root);
-				free_backref_edge(cache, edge);
+				btrfs_backref_free_edge(cache, edge);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -924,7 +904,7 @@ static int finish_upper_links(struct btrfs_backref_cache *cache,
 		/* Parent is detached, no need to keep any edges */
 		if (upper->detached) {
 			list_del(&edge->list[LOWER]);
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 
 			/* Lower node is orphan, queue for cleanup */
 			if (list_empty(&lower->upper))
@@ -1032,7 +1012,7 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 
 			/* Child node is also orphan, queue for cleanup */
 			if (list_empty(&lower->upper))
@@ -1051,7 +1031,7 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 			cur->detached = 1;
 		} else {
 			rb_erase(&cur->rb_node, &cache->rb_root);
-			free_backref_node(cache, cur);
+			btrfs_backref_free_node(cache, cur);
 		}
 	}
 	return ret;
@@ -1150,7 +1130,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
 			upper = edge->node[UPPER];
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 
 			/*
 			 * Lower is no longer linked to any upper backref nodes
@@ -1177,10 +1157,10 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 			list_del_init(&lower->list);
 			if (lower == node)
 				node = NULL;
-			free_backref_node(cache, lower);
+			btrfs_backref_free_node(cache, lower);
 		}
 
-		free_backref_node(cache, node);
+		btrfs_backref_free_node(cache, node);
 		ASSERT(list_empty(&cache->useless_node) &&
 		       list_empty(&cache->pending_edge));
 		return ERR_PTR(err);
@@ -1274,9 +1254,9 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 		new_edge = list_entry(new_node->lower.next,
 				      struct btrfs_backref_edge, list[UPPER]);
 		list_del(&new_edge->list[UPPER]);
-		free_backref_edge(cache, new_edge);
+		btrfs_backref_free_edge(cache, new_edge);
 	}
-	free_backref_node(cache, new_node);
+	btrfs_backref_free_node(cache, new_node);
 	return -ENOMEM;
 }
 
-- 
2.25.2

