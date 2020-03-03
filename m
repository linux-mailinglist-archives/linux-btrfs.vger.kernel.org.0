Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E60176FD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCCHPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:56892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbgCCHPj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33484B016
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/19] btrfs: Move backref_cache_cleanup() to backref.c
Date:   Tue,  3 Mar 2020 15:14:03 +0800
Message-Id: <20200303071409.57982-14-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c    | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  1 +
 fs/btrfs/relocation.c | 30 ------------------------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 4f0e8ab1d9cf..02455b3bbc35 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2528,3 +2528,33 @@ void cleanup_backref_node(struct backref_cache *cache,
 
 	drop_backref_node(cache, node);
 }
+
+void backref_cache_cleanup(struct backref_cache *cache)
+{
+	struct backref_node *node;
+	int i;
+
+	while (!list_empty(&cache->detached)) {
+		node = list_entry(cache->detached.next,
+				  struct backref_node, list);
+		cleanup_backref_node(cache, node);
+	}
+
+	while (!list_empty(&cache->leaves)) {
+		node = list_entry(cache->leaves.next,
+				  struct backref_node, lower);
+		cleanup_backref_node(cache, node);
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
index 1c34a8dbee2f..2fb854b1d5f0 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -377,4 +377,5 @@ static inline void drop_backref_node(struct backref_cache *tree,
  */
 void cleanup_backref_node(struct backref_cache *cache,
 			  struct backref_node *node);
+void backref_cache_cleanup(struct backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2050414884fb..71df172b70bb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -182,36 +182,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_cache_cleanup(struct backref_cache *cache)
-{
-	struct backref_node *node;
-	int i;
-
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct backref_node, list);
-		cleanup_backref_node(cache, node);
-	}
-
-	while (!list_empty(&cache->leaves)) {
-		node = list_entry(cache->leaves.next,
-				  struct backref_node, lower);
-		cleanup_backref_node(cache, node);
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
 
-- 
2.25.1

