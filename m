Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0711193AF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZIeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgCZIeP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66613AC46
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 25/39] btrfs: Rename backref_cache_cleanup() to btrfs_backref_release_cache() and move it to backref.c
Date:   Thu, 26 Mar 2020 16:33:02 +0800
Message-Id: <20200326083316.48847-26-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're releasing all existing nodes/edges, other than cleanup the
mess after error, "release" is a more proper naming here.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  3 +++
 fs/btrfs/relocation.c | 32 +-------------------------------
 3 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 5cab1b71d0b5..8dae00cfa69f 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2549,3 +2549,33 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 
 	btrfs_backref_drop_node(cache, node);
 }
+
+void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
+{
+	struct btrfs_backref_node *node;
+	int i;
+
+	while (!list_empty(&cache->detached)) {
+		node = list_entry(cache->detached.next,
+				  struct btrfs_backref_node, list);
+		btrfs_backref_cleanup_node(cache, node);
+	}
+
+	while (!list_empty(&cache->leaves)) {
+		node = list_entry(cache->leaves.next,
+				  struct btrfs_backref_node, lower);
+		btrfs_backref_cleanup_node(cache, node);
+	}
+
+	cache->last_trans = 0;
+
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
+		ASSERT(list_empty(&cache->pending[i]));
+	ASSERT(list_empty(&cache->pending_edge));
+	ASSERT(list_empty(&cache->useless_node));
+	ASSERT(list_empty(&cache->changed));
+	ASSERT(list_empty(&cache->detached));
+	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
+	ASSERT(!cache->nr_nodes);
+	ASSERT(!cache->nr_edges);
+}
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 5bc3700fea1d..c77de13570bc 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -362,4 +362,7 @@ static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
  */
 void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 				struct btrfs_backref_node *node);
+
+/* Release all nodes/edges from current cache */
+void btrfs_backref_release_cache(struct btrfs_backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 04d9b88d92aa..4649de9fd02a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -175,36 +175,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_cache_cleanup(struct btrfs_backref_cache *cache)
-{
-	struct btrfs_backref_node *node;
-	int i;
-
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct btrfs_backref_node, list);
-		btrfs_backref_cleanup_node(cache, node);
-	}
-
-	while (!list_empty(&cache->leaves)) {
-		node = list_entry(cache->leaves.next,
-				  struct btrfs_backref_node, lower);
-		btrfs_backref_cleanup_node(cache, node);
-	}
-
-	cache->last_trans = 0;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		ASSERT(list_empty(&cache->pending[i]));
-	ASSERT(list_empty(&cache->pending_edge));
-	ASSERT(list_empty(&cache->useless_node));
-	ASSERT(list_empty(&cache->changed));
-	ASSERT(list_empty(&cache->detached));
-	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
-	ASSERT(!cache->nr_nodes);
-	ASSERT(!cache->nr_edges);
-}
-
 static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
 {
 
@@ -3933,7 +3903,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	rc->create_reloc_tree = 0;
 	set_reloc_control(rc);
 
-	backref_cache_cleanup(&rc->backref_cache);
+	btrfs_backref_release_cache(&rc->backref_cache);
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
 
 	/*
-- 
2.26.0

