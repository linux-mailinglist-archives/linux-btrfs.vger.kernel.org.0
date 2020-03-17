Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D177187AF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQIMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgCQIMk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34F43AEF1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 24/39] btrfs: Rename backref_cache_cleanup() to backref_cache_release() and move it to backref.c
Date:   Tue, 17 Mar 2020 16:11:10 +0800
Message-Id: <20200317081125.36289-25-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
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
 fs/btrfs/backref.h    |  1 +
 fs/btrfs/relocation.c | 32 +-------------------------------
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 2fd6100327d5..32af6f17d230 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2552,3 +2552,33 @@ void cleanup_backref_node(struct backref_cache *cache,
 
 	drop_backref_node(cache, node);
 }
+
+void backref_cache_release(struct backref_cache *cache)
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
index a55e7cf77092..9ac76ffefd41 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -356,4 +356,5 @@ static inline void drop_backref_node(struct backref_cache *tree,
  */
 void cleanup_backref_node(struct backref_cache *cache,
 			  struct backref_node *node);
+void backref_cache_release(struct backref_cache *cache);
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9d355cf41f08..e9b18cba1b41 100644
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
 
@@ -4076,7 +4046,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	rc->create_reloc_tree = 0;
 	set_reloc_control(rc);
 
-	backref_cache_cleanup(&rc->backref_cache);
+	backref_cache_release(&rc->backref_cache);
 	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1);
 
 	err = prepare_to_merge(rc, err);
-- 
2.25.1

