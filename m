Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2113918F2B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgCWKZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWKZZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC00BAFC8
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/40] btrfs: Rename alloc_backref_node() to btrfs_backref_alloc_node() and move it backref.c
Date:   Mon, 23 Mar 2020 18:23:55 +0800
Message-Id: <20200323102416.112862-20-wqu@suse.com>
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
 fs/btrfs/backref.c    | 20 ++++++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 31 ++++++-------------------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 3a54226b22da..9050fa545a54 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2484,3 +2484,23 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 	cache->fs_info = fs_info;
 	cache->is_reloc = is_reloc;
 }
+
+struct btrfs_backref_node *btrfs_backref_alloc_node(
+		struct btrfs_backref_cache *cache, u64 bytenr, int level)
+{
+	struct btrfs_backref_node *node;
+
+	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
+	node = kzalloc(sizeof(*node), GFP_NOFS);
+	if (!node)
+		return node;
+	INIT_LIST_HEAD(&node->list);
+	INIT_LIST_HEAD(&node->upper);
+	INIT_LIST_HEAD(&node->lower);
+	RB_CLEAR_NODE(&node->rb_node);
+	cache->nr_nodes++;
+
+	node->level = level;
+	node->bytenr = bytenr;
+	return node;
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 39b1532413aa..6e2b7b4a99e5 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -270,4 +270,6 @@ struct btrfs_backref_cache {
 
 void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 			      struct btrfs_backref_cache *cache, int is_reloc);
+struct btrfs_backref_node *btrfs_backref_alloc_node(
+		struct btrfs_backref_cache *cache, u64 bytenr, int level);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b7536deb6d5e..4b670ae6a0fb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -215,26 +215,6 @@ static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-static struct btrfs_backref_node *alloc_backref_node(
-		struct btrfs_backref_cache *cache, u64 bytenr, int level)
-{
-	struct btrfs_backref_node *node;
-
-	ASSERT(level >= 0 && level < BTRFS_MAX_LEVEL);
-	node = kzalloc(sizeof(*node), GFP_NOFS);
-	if (!node)
-		return node;
-	INIT_LIST_HEAD(&node->list);
-	INIT_LIST_HEAD(&node->upper);
-	INIT_LIST_HEAD(&node->lower);
-	RB_CLEAR_NODE(&node->rb_node);
-	cache->nr_nodes++;
-
-	node->level = level;
-	node->bytenr = bytenr;
-	return node;
-}
-
 static void free_backref_node(struct btrfs_backref_cache *cache,
 			      struct btrfs_backref_node *node)
 {
@@ -615,7 +595,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 	rb_node = simple_search(&cache->rb_root, ref_key->offset);
 	if (!rb_node) {
 		/* Parent node not yet cached */
-		upper = alloc_backref_node(cache, ref_key->offset,
+		upper = btrfs_backref_alloc_node(cache, ref_key->offset,
 					   cur->level + 1);
 		if (!upper) {
 			free_backref_edge(cache, edge);
@@ -737,8 +717,8 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 		eb = path->nodes[level];
 		rb_node = simple_search(&cache->rb_root, eb->start);
 		if (!rb_node) {
-			upper = alloc_backref_node(cache, eb->start,
-						   lower->level + 1);
+			upper = btrfs_backref_alloc_node(cache, eb->start,
+							 lower->level + 1);
 			if (!upper) {
 				btrfs_put_root(root);
 				free_backref_edge(cache, edge);
@@ -1143,7 +1123,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 	}
 	path->reada = READA_FORWARD;
 
-	node = alloc_backref_node(cache, bytenr, level);
+	node = btrfs_backref_alloc_node(cache, bytenr, level);
 	if (!node) {
 		err = -ENOMEM;
 		goto out;
@@ -1280,7 +1260,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	if (!node)
 		return 0;
 
-	new_node = alloc_backref_node(cache, dest->node->start, node->level);
+	new_node = btrfs_backref_alloc_node(cache, dest->node->start,
+					    node->level);
 	if (!new_node)
 		return -ENOMEM;
 
-- 
2.25.2

