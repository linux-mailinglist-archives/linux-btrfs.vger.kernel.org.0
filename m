Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6A18F2BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgCWKZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgCWKZo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A91E2AF79
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 25/40] btrfs: Rename backref_cache_cleanup() to btrfs_backref_release_cache() and move it to backref.c
Date:   Mon, 23 Mar 2020 18:24:01 +0800
Message-Id: <20200323102416.112862-26-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
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
index 0c8950750682..e1bf23b2bbcd 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2553,3 +2553,33 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 
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
index 068a28c8e37b..60ee191a71fe 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -358,4 +358,7 @@ static inline void btrfs_backref_drop_node(struct btrfs_backref_cache *tree,
  */
 void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 				struct btrfs_backref_node *node);
+
+/* Release all nodes/edges from current cache */
+void btrfs_backref_release_cache(struct btrfs_backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4c687318f70b..2f241b542f6b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -182,36 +182,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
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
 
@@ -4082,7 +4052,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	rc->create_reloc_tree = 0;
 	set_reloc_control(rc);
 
-	backref_cache_cleanup(&rc->backref_cache);
+	btrfs_backref_release_cache(&rc->backref_cache);
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1);
 
 	err = prepare_to_merge(rc, err);
-- 
2.25.2

