Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571A4187AF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgCQIMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQIMx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B836ADBB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 30/39] btrfs: relocation: Move error handling of build_backref_tree() to backref.c
Date:   Tue, 17 Mar 2020 16:11:16 +0800
Message-Id: <20200317081125.36289-31-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The error cleanup will be extracted as a new function,
backref_cache_error_cleanup(), and moved to backref.c and exported for
later usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 54 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 48 +-------------------------------------
 3 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 0a1cfa4433d3..435982da3991 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3052,3 +3052,57 @@ int backref_cache_finish_upper_links(struct backref_cache *cache,
 	return 0;
 }
 
+/* Cleanup the already inserted orphan backref nodes related to @node. */
+void backref_cache_error_cleanup(struct backref_cache *cache,
+				 struct backref_node *node)
+{
+	struct backref_node *lower;
+	struct backref_node *upper;
+	struct backref_edge *edge;
+
+	while (!list_empty(&cache->useless_node)) {
+		lower = list_first_entry(&cache->useless_node,
+				   struct backref_node, list);
+		list_del_init(&lower->list);
+	}
+	while (!list_empty(&cache->pending_edge)) {
+		edge = list_first_entry(&cache->pending_edge,
+				struct backref_edge, list[UPPER]);
+		list_del(&edge->list[UPPER]);
+		list_del(&edge->list[LOWER]);
+		lower = edge->node[LOWER];
+		upper = edge->node[UPPER];
+		free_backref_edge(cache, edge);
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
+				   struct backref_node, list);
+		list_del_init(&lower->list);
+		if (lower == node)
+			node = NULL;
+		free_backref_node(cache, lower);
+	}
+
+	free_backref_node(cache, node);
+	ASSERT(list_empty(&cache->useless_node) &&
+	       list_empty(&cache->pending_edge));
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index c6c9f536c359..72b959377a14 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -373,4 +373,6 @@ int backref_cache_add_tree_block(struct backref_cache *cache,
 				 struct backref_node *cur);
 int backref_cache_finish_upper_links(struct backref_cache *cache,
 				     struct backref_node *start);
+void backref_cache_error_cleanup(struct backref_cache *cache,
+				 struct backref_node *node);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ad3896dcdb48..466f90f7fb26 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -479,8 +479,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	struct backref_cache *cache = &rc->backref_cache;
 	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
 	struct backref_node *cur;
-	struct backref_node *upper;
-	struct backref_node *lower;
 	struct backref_node *node = NULL;
 	struct backref_edge *edge;
 	int ret;
@@ -535,51 +533,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 	btrfs_backref_iter_free(iter);
 	btrfs_free_path(path);
 	if (err) {
-		while (!list_empty(&cache->useless_node)) {
-			lower = list_first_entry(&cache->useless_node,
-					   struct backref_node, list);
-			list_del_init(&lower->list);
-		}
-		while (!list_empty(&cache->pending_edge)) {
-			edge = list_first_entry(&cache->pending_edge,
-					struct backref_edge, list[UPPER]);
-			list_del(&edge->list[UPPER]);
-			list_del(&edge->list[LOWER]);
-			lower = edge->node[LOWER];
-			upper = edge->node[UPPER];
-			free_backref_edge(cache, edge);
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
-					   struct backref_node, list);
-			list_del_init(&lower->list);
-			if (lower == node)
-				node = NULL;
-			free_backref_node(cache, lower);
-		}
-
-		free_backref_node(cache, node);
-		ASSERT(list_empty(&cache->useless_node) &&
-		       list_empty(&cache->pending_edge));
+		backref_cache_error_cleanup(cache, node);
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);
-- 
2.25.1

