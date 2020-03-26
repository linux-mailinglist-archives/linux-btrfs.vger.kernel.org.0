Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02D193AF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCZIeE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgCZIeD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27F2DAC46
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/39] btrfs: Rename alloc_backref_node() to btrfs_backref_alloc_node() and move it backref.c
Date:   Thu, 26 Mar 2020 16:32:56 +0800
Message-Id: <20200326083316.48847-20-wqu@suse.com>
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
 fs/btrfs/backref.c    | 20 ++++++++++++++++++++
 fs/btrfs/backref.h    |  2 ++
 fs/btrfs/relocation.c | 31 ++++++-------------------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 997f609c97f8..079de971f302 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2480,3 +2480,23 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
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
index 25a0b1a5ce32..54364fbec65b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -274,4 +274,6 @@ struct btrfs_backref_cache {
 
 void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 			      struct btrfs_backref_cache *cache, int is_reloc);
+struct btrfs_backref_node *btrfs_backref_alloc_node(
+		struct btrfs_backref_cache *cache, u64 bytenr, int level);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1fa7c4a67f3d..4f22e9bd8e3c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -208,26 +208,6 @@ static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
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
@@ -608,7 +588,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 	rb_node = simple_search(&cache->rb_root, ref_key->offset);
 	if (!rb_node) {
 		/* Parent node not yet cached */
-		upper = alloc_backref_node(cache, ref_key->offset,
+		upper = btrfs_backref_alloc_node(cache, ref_key->offset,
 					   cur->level + 1);
 		if (!upper) {
 			free_backref_edge(cache, edge);
@@ -729,8 +709,8 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
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
@@ -1134,7 +1114,7 @@ struct btrfs_backref_node *build_backref_tree(struct reloc_control *rc,
 		goto out;
 	}
 
-	node = alloc_backref_node(cache, bytenr, level);
+	node = btrfs_backref_alloc_node(cache, bytenr, level);
 	if (!node) {
 		err = -ENOMEM;
 		goto out;
@@ -1271,7 +1251,8 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	if (!node)
 		return 0;
 
-	new_node = alloc_backref_node(cache, dest->node->start, node->level);
+	new_node = btrfs_backref_alloc_node(cache, dest->node->start,
+					    node->level);
 	if (!new_node)
 		return -ENOMEM;
 
-- 
2.26.0

