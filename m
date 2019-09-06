Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706BEABE82
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbfIFRQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 13:16:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404375AbfIFRQI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Sep 2019 13:16:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76A36AE0C
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2019 17:16:06 +0000 (UTC)
From:   Mark Fasheh <mfasheh@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 3/3] btrfs: move useless node processing out of build_backref_cache
Date:   Fri,  6 Sep 2019 10:15:33 -0700
Message-Id: <20190906171533.618-4-mfasheh@suse.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190906171533.618-1-mfasheh@suse.com>
References: <20190906171533.618-1-mfasheh@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Mark Fasheh <mfasheh@suse.de>

The backref cache has to clean up nodes referring to tree leaves. It is
trivial to pull that code into it's own function, which is what I do here.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/btrfs/backref-cache.c | 82 +++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/backref-cache.c b/fs/btrfs/backref-cache.c
index ff0d49ca6e26..93632480b8d8 100644
--- a/fs/btrfs/backref-cache.c
+++ b/fs/btrfs/backref-cache.c
@@ -336,6 +336,51 @@ int find_inline_backref(struct extent_buffer *leaf, int slot,
 	return 0;
 }
 
+/*
+ * process useless backref nodes. backref nodes for tree leaves are
+ * deleted from the cache. backref nodes for upper level tree blocks
+ * are left in the cache to avoid unnecessary backref lookup.
+ */
+static void process_useless_backrefs(struct reloc_control *rc,
+				     struct backref_node *node,
+				     struct list_head *useless)
+{
+	struct backref_node *lower;
+	struct backref_node *upper;
+	struct backref_edge *edge;
+
+	while (!list_empty(useless)) {
+		upper = list_entry(useless->next, struct backref_node, list);
+		list_del_init(&upper->list);
+		ASSERT(list_empty(&upper->upper));
+		if (upper == node)
+			node = NULL;
+		if (upper->lowest) {
+			list_del_init(&upper->lower);
+			upper->lowest = 0;
+		}
+		while (!list_empty(&upper->lower)) {
+			edge = list_entry(upper->lower.next,
+					  struct backref_edge, list[UPPER]);
+			list_del(&edge->list[UPPER]);
+			list_del(&edge->list[LOWER]);
+			lower = edge->node[LOWER];
+			free_backref_edge(&rc->backref_cache, edge);
+
+			if (list_empty(&lower->upper))
+				list_add(&lower->list, useless);
+		}
+		__mark_block_processed(rc, upper);
+		if (upper->level > 0) {
+			list_add(&upper->list, &rc->backref_cache.detached);
+			upper->detached = 1;
+		} else {
+			rb_erase(&upper->rb_node, &rc->backref_cache.rb_root);
+			free_backref_node(&rc->backref_cache, upper);
+		}
+	}
+}
+
 #define SEARCH_COMPLETE	1
 #define SEARCH_NEXT	2
 static int find_next_ref(struct btrfs_root *extent_root, u64 cur_bytenr,
@@ -797,42 +842,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		list_for_each_entry(edge, &upper->upper, list[LOWER])
 			list_add_tail(&edge->list[UPPER], &list);
 	}
-	/*
-	 * process useless backref nodes. backref nodes for tree leaves
-	 * are deleted from the cache. backref nodes for upper level
-	 * tree blocks are left in the cache to avoid unnecessary backref
-	 * lookup.
-	 */
-	while (!list_empty(&useless)) {
-		upper = list_entry(useless.next, struct backref_node, list);
-		list_del_init(&upper->list);
-		ASSERT(list_empty(&upper->upper));
-		if (upper == node)
-			node = NULL;
-		if (upper->lowest) {
-			list_del_init(&upper->lower);
-			upper->lowest = 0;
-		}
-		while (!list_empty(&upper->lower)) {
-			edge = list_entry(upper->lower.next,
-					  struct backref_edge, list[UPPER]);
-			list_del(&edge->list[UPPER]);
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			free_backref_edge(cache, edge);
 
-			if (list_empty(&lower->upper))
-				list_add(&lower->list, &useless);
-		}
-		__mark_block_processed(rc, upper);
-		if (upper->level > 0) {
-			list_add(&upper->list, &cache->detached);
-			upper->detached = 1;
-		} else {
-			rb_erase(&upper->rb_node, &cache->rb_root);
-			free_backref_node(cache, upper);
-		}
-	}
+	process_useless_backrefs(rc, node, &useless);
+
 out:
 	btrfs_free_path(path1);
 	btrfs_free_path(path2);
-- 
2.22.1

