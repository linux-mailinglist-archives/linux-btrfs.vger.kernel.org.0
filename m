Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B74187AF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQIMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgCQIMe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD7A6ADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 22/39] btrfs: Move drop_backref_node() and needed facilities to backref.h
Date:   Tue, 17 Mar 2020 16:11:08 +0800
Message-Id: <20200317081125.36289-23-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
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
 fs/btrfs/backref.h    | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/relocation.c | 31 -------------------------------
 2 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 99d8a9301bc1..5c0300bde7fa 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -310,4 +310,41 @@ static inline void free_backref_edge(struct backref_cache *cache,
 	}
 }
 
+static inline void unlock_node_buffer(struct backref_node *node)
+{
+	if (node->locked) {
+		btrfs_tree_unlock(node->eb);
+		node->locked = 0;
+	}
+}
+
+static inline void drop_node_buffer(struct backref_node *node)
+{
+	if (node->eb) {
+		unlock_node_buffer(node);
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
+static inline void drop_backref_node(struct backref_cache *tree,
+				     struct backref_node *node)
+{
+	BUG_ON(!list_empty(&node->upper));
+
+	drop_node_buffer(node);
+	list_del(&node->list);
+	list_del(&node->lower);
+	if (!RB_EMPTY_NODE(&node->rb_node))
+		rb_erase(&node->rb_node, &tree->rb_root);
+	free_backref_node(tree, node);
+}
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bb46e2e38c4f..1f656b07fe90 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -275,37 +275,6 @@ static struct backref_node *walk_down_backref(struct backref_edge *edges[],
 	*index = 0;
 	return NULL;
 }
-
-static void unlock_node_buffer(struct backref_node *node)
-{
-	if (node->locked) {
-		btrfs_tree_unlock(node->eb);
-		node->locked = 0;
-	}
-}
-
-static void drop_node_buffer(struct backref_node *node)
-{
-	if (node->eb) {
-		unlock_node_buffer(node);
-		free_extent_buffer(node->eb);
-		node->eb = NULL;
-	}
-}
-
-static void drop_backref_node(struct backref_cache *tree,
-			      struct backref_node *node)
-{
-	BUG_ON(!list_empty(&node->upper));
-
-	drop_node_buffer(node);
-	list_del(&node->list);
-	list_del(&node->lower);
-	if (!RB_EMPTY_NODE(&node->rb_node))
-		rb_erase(&node->rb_node, &tree->rb_root);
-	free_backref_node(tree, node);
-}
-
 /*
  * remove a backref node from the backref cache
  */
-- 
2.25.1

