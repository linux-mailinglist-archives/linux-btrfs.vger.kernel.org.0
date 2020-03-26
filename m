Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2A193AF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCZIeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgCZIeI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BDBB8AC46
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 22/39] btrfs: Rename free_backref_(node|edge) to btrfs_backref_free_(node|edge) and move them to backref.h
Date:   Thu, 26 Mar 2020 16:32:59 +0800
Message-Id: <20200326083316.48847-23-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    | 20 ++++++++++++++++++++
 fs/btrfs/relocation.c | 42 +++++++++++-------------------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index c09fd4024cc2..5464d0dc1669 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -8,6 +8,7 @@
 
 #include <linux/btrfs.h>
 #include "ulist.h"
+#include "disk-io.h"
 #include "extent_io.h"
 
 struct inode_fs_paths {
@@ -294,4 +295,23 @@ static inline void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
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
index 3a95f5cd353a..b09141f4d4c8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -208,26 +208,6 @@ static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
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
 
@@ -316,7 +296,7 @@ static void drop_backref_node(struct btrfs_backref_cache *tree,
 	list_del(&node->lower);
 	if (!RB_EMPTY_NODE(&node->rb_node))
 		rb_erase(&node->rb_node, &tree->rb_root);
-	free_backref_node(tree, node);
+	btrfs_backref_free_node(tree, node);
 }
 
 /*
@@ -338,7 +318,7 @@ static void remove_backref_node(struct btrfs_backref_cache *cache,
 		upper = edge->node[UPPER];
 		list_del(&edge->list[LOWER]);
 		list_del(&edge->list[UPPER]);
-		free_backref_edge(cache, edge);
+		btrfs_backref_free_edge(cache, edge);
 
 		if (RB_EMPTY_NODE(&upper->rb_node)) {
 			BUG_ON(!list_empty(&node->upper));
@@ -565,7 +545,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		upper = btrfs_backref_alloc_node(cache, ref_key->offset,
 					   cur->level + 1);
 		if (!upper) {
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 			return -ENOMEM;
 		}
 
@@ -687,7 +667,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 							 lower->level + 1);
 			if (!upper) {
 				btrfs_put_root(root);
-				free_backref_edge(cache, edge);
+				btrfs_backref_free_edge(cache, edge);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -916,7 +896,7 @@ static int finish_upper_links(struct btrfs_backref_cache *cache,
 		/* Parent is detached, no need to keep any edges */
 		if (upper->detached) {
 			list_del(&edge->list[LOWER]);
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 
 			/* Lower node is orphan, queue for cleanup */
 			if (list_empty(&lower->upper))
@@ -1024,7 +1004,7 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 
 			/* Child node is also orphan, queue for cleanup */
 			if (list_empty(&lower->upper))
@@ -1043,7 +1023,7 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 			cur->detached = 1;
 		} else {
 			rb_erase(&cur->rb_node, &cache->rb_root);
-			free_backref_node(cache, cur);
+			btrfs_backref_free_node(cache, cur);
 		}
 	}
 	return ret;
@@ -1141,7 +1121,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
 			upper = edge->node[UPPER];
-			free_backref_edge(cache, edge);
+			btrfs_backref_free_edge(cache, edge);
 
 			/*
 			 * Lower is no longer linked to any upper backref nodes
@@ -1168,7 +1148,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 			list_del_init(&lower->list);
 			if (lower == node)
 				node = NULL;
-			free_backref_node(cache, lower);
+			btrfs_backref_free_node(cache, lower);
 		}
 
 		remove_backref_node(cache, node);
@@ -1265,9 +1245,9 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
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
2.26.0

