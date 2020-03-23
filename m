Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FAA18F2C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCWKZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:39288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgCWKZz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 084CAAF79
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 31/40] btrfs: relocation: Move error handling of build_backref_tree() to backref.c
Date:   Mon, 23 Mar 2020 18:24:07 +0800
Message-Id: <20200323102416.112862-32-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The error cleanup will be extracted as a new function,
btrfs_backref_error_cleanup(), and moved to backref.c and exported for
later usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 54 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  3 +++
 fs/btrfs/relocation.c | 48 +-------------------------------------
 3 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 3ecf336bd53b..25944dbe037c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3042,3 +3042,57 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 	}
 	return 0;
 }
+
+void btrfs_backref_error_cleanup(struct btrfs_backref_cache *cache,
+				 struct btrfs_backref_node *node)
+{
+	struct btrfs_backref_node *lower;
+	struct btrfs_backref_node *upper;
+	struct btrfs_backref_edge *edge;
+
+	while (!list_empty(&cache->useless_node)) {
+		lower = list_first_entry(&cache->useless_node,
+				   struct btrfs_backref_node, list);
+		list_del_init(&lower->list);
+	}
+	while (!list_empty(&cache->pending_edge)) {
+		edge = list_first_entry(&cache->pending_edge,
+				struct btrfs_backref_edge, list[UPPER]);
+		list_del(&edge->list[UPPER]);
+		list_del(&edge->list[LOWER]);
+		lower = edge->node[LOWER];
+		upper = edge->node[UPPER];
+		btrfs_backref_free_edge(cache, edge);
+
+		/*
+		 * Lower is no longer linked to any upper backref nodes
+		 * and isn't in the cache, we can free it ourselves.
+		 */
+		if (list_empty(&lower->upper) &&
+		    RB_EMPTY_NODE(&lower->rb_node))
+			list_add(&lower->list, &cache->useless_node);
+
+		if (!RB_EMPTY_NODE(&upper->rb_node))
+			continue;
+
+		/* Add this guy's upper edges to the list to process */
+		list_for_each_entry(edge, &upper->upper, list[LOWER])
+			list_add_tail(&edge->list[UPPER],
+				      &cache->pending_edge);
+		if (list_empty(&upper->upper))
+			list_add(&upper->list, &cache->useless_node);
+	}
+
+	while (!list_empty(&cache->useless_node)) {
+		lower = list_first_entry(&cache->useless_node,
+				   struct btrfs_backref_node, list);
+		list_del_init(&lower->list);
+		if (lower == node)
+			node = NULL;
+		btrfs_backref_free_node(cache, lower);
+	}
+
+	btrfs_backref_free_node(cache, node);
+	ASSERT(list_empty(&cache->useless_node) &&
+	       list_empty(&cache->pending_edge));
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 220547590a3b..0185f5b8b85c 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -390,4 +390,7 @@ int btrfs_backref_add_tree_node(struct btrfs_backref_cache *cache,
 /* Finish the upwards linkage created by btrfs_backref_add_tree_node(). */
 int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 				     struct btrfs_backref_node *start);
+
+void btrfs_backref_error_cleanup(struct btrfs_backref_cache *cache,
+				 struct btrfs_backref_node *node);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 24ce9f8fd168..9503618c1889 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -480,8 +480,6 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 	struct btrfs_backref_cache *cache = &rc->backref_cache;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
 	struct btrfs_backref_node *cur;
-	struct btrfs_backref_node *upper;
-	struct btrfs_backref_node *lower;
 	struct btrfs_backref_node *node = NULL;
 	struct btrfs_backref_edge *edge;
 	int ret;
@@ -539,51 +537,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 	btrfs_backref_iter_free(iter);
 	btrfs_free_path(path);
 	if (err) {
-		while (!list_empty(&cache->useless_node)) {
-			lower = list_first_entry(&cache->useless_node,
-					   struct btrfs_backref_node, list);
-			list_del_init(&lower->list);
-		}
-		while (!list_empty(&cache->pending_edge)) {
-			edge = list_first_entry(&cache->pending_edge,
-					struct btrfs_backref_edge, list[UPPER]);
-			list_del(&edge->list[UPPER]);
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			upper = edge->node[UPPER];
-			btrfs_backref_free_edge(cache, edge);
-
-			/*
-			 * Lower is no longer linked to any upper backref nodes
-			 * and isn't in the cache, we can free it ourselves.
-			 */
-			if (list_empty(&lower->upper) &&
-			    RB_EMPTY_NODE(&lower->rb_node))
-				list_add(&lower->list, &cache->useless_node);
-
-			if (!RB_EMPTY_NODE(&upper->rb_node))
-				continue;
-
-			/* Add this guy's upper edges to the list to process */
-			list_for_each_entry(edge, &upper->upper, list[LOWER])
-				list_add_tail(&edge->list[UPPER],
-					      &cache->pending_edge);
-			if (list_empty(&upper->upper))
-				list_add(&upper->list, &cache->useless_node);
-		}
-
-		while (!list_empty(&cache->useless_node)) {
-			lower = list_first_entry(&cache->useless_node,
-					   struct btrfs_backref_node, list);
-			list_del_init(&lower->list);
-			if (lower == node)
-				node = NULL;
-			btrfs_backref_free_node(cache, lower);
-		}
-
-		btrfs_backref_free_node(cache, node);
-		ASSERT(list_empty(&cache->useless_node) &&
-		       list_empty(&cache->pending_edge));
+		btrfs_backref_error_cleanup(cache, node);
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);
-- 
2.25.2

