Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04925193AF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgCZIeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgCZIeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0C71ACAE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 23/39] btrfs: Rename drop_backref_node() to btrfs_backref_drop_node() and move its needed facilities to backref.h
Date:   Thu, 26 Mar 2020 16:33:00 +0800
Message-Id: <20200326083316.48847-24-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extra comment for drop_backref_node() as it has some similarity
with remove_backref_node(), thus we need extra comment explaining the
difference.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    | 39 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.c | 45 +++++++------------------------------------
 2 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 5464d0dc1669..5e8d368d9a82 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -314,4 +314,43 @@ static inline void btrfs_backref_free_edge(struct btrfs_backref_cache *cache,
 	}
 }
 
+static inline void btrfs_backref_unlock_node_buffer(
+		struct btrfs_backref_node *node)
+{
+	if (node->locked) {
+		btrfs_tree_unlock(node->eb);
+		node->locked = 0;
+	}
+}
+
+static inline void btrfs_backref_drop_node_buffer(
+		struct btrfs_backref_node *node)
+{
+	if (node->eb) {
+		btrfs_backref_unlock_node_buffer(node);
+		free_extent_buffer(node->eb);
+		node->eb = NULL;
+	}
+}
+
+/*
+ * Drop the backref node from cache without cleaning up its children
+ * edges.
+ *
+ * This can only be called on node without parent edges.
+ * The children edges are still kept as is.
+ */
+static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
+					   struct btrfs_backref_node *node)
+{
+	BUG_ON(!list_empty(&node->upper));
+
+	btrfs_backref_drop_node_buffer(node);
+	list_del(&node->list);
+	list_del(&node->lower);
+	if (!RB_EMPTY_NODE(&node->rb_node))
+		rb_erase(&node->rb_node, &tree->rb_root);
+	btrfs_backref_free_node(tree, node);
+}
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b09141f4d4c8..fd94bd18f2ad 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -268,37 +268,6 @@ static struct btrfs_backref_node *walk_down_backref(
 	*index = 0;
 	return NULL;
 }
-
-static void unlock_node_buffer(struct btrfs_backref_node *node)
-{
-	if (node->locked) {
-		btrfs_tree_unlock(node->eb);
-		node->locked = 0;
-	}
-}
-
-static void drop_node_buffer(struct btrfs_backref_node *node)
-{
-	if (node->eb) {
-		unlock_node_buffer(node);
-		free_extent_buffer(node->eb);
-		node->eb = NULL;
-	}
-}
-
-static void drop_backref_node(struct btrfs_backref_cache *tree,
-			      struct btrfs_backref_node *node)
-{
-	BUG_ON(!list_empty(&node->upper));
-
-	drop_node_buffer(node);
-	list_del(&node->list);
-	list_del(&node->lower);
-	if (!RB_EMPTY_NODE(&node->rb_node))
-		rb_erase(&node->rb_node, &tree->rb_root);
-	btrfs_backref_free_node(tree, node);
-}
-
 /*
  * remove a backref node from the backref cache
  */
@@ -322,7 +291,7 @@ static void remove_backref_node(struct btrfs_backref_cache *cache,
 
 		if (RB_EMPTY_NODE(&upper->rb_node)) {
 			BUG_ON(!list_empty(&node->upper));
-			drop_backref_node(cache, node);
+			btrfs_backref_drop_node(cache, node);
 			node = upper;
 			node->lowest = 1;
 			continue;
@@ -337,7 +306,7 @@ static void remove_backref_node(struct btrfs_backref_cache *cache,
 		}
 	}
 
-	drop_backref_node(cache, node);
+	btrfs_backref_drop_node(cache, node);
 }
 
 static void update_backref_node(struct btrfs_backref_cache *cache,
@@ -2844,7 +2813,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 				if (node->eb->start == bytenr)
 					goto next;
 			}
-			drop_node_buffer(upper);
+			btrfs_backref_drop_node_buffer(upper);
 		}
 
 		if (!upper->eb) {
@@ -2943,15 +2912,15 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 		}
 next:
 		if (!upper->pending)
-			drop_node_buffer(upper);
+			btrfs_backref_drop_node_buffer(upper);
 		else
-			unlock_node_buffer(upper);
+			btrfs_backref_unlock_node_buffer(upper);
 		if (err)
 			break;
 	}
 
 	if (!err && node->pending) {
-		drop_node_buffer(node);
+		btrfs_backref_drop_node_buffer(node);
 		list_move_tail(&node->list, &rc->backref_cache.changed);
 		node->pending = 0;
 	}
@@ -4575,7 +4544,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		BUG_ON(node->bytenr != buf->start &&
 		       node->new_bytenr != buf->start);
 
-		drop_node_buffer(node);
+		btrfs_backref_drop_node_buffer(node);
 		atomic_inc(&cow->refs);
 		node->eb = cow;
 		node->new_bytenr = cow->start;
-- 
2.26.0

