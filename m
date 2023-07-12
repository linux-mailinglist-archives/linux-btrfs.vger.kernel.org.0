Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FCA751118
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGLTX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGLTX5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 15:23:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8481FC1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 12:23:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DFC9421BBC;
        Wed, 12 Jul 2023 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689189834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=T87KboaB0Mss6PnpnrXgMrfnwGHPooM1KBGsj+38XCc=;
        b=gUIaobOfju1d5uWkhrsrL2Iz+0wEm/IkVzNS5WszTJaFJqDbFRyDowNTA4rCEdb7lXE2dR
        7tk30NRF8Gq+f8sNEUq+tHbkfaEK5TiHoUcGl8CxeQvA2SVspoPtk/kHcwsRy/XDamWW97
        sLLq5RjJNPTVXc7sCY01hdPJoygY6wM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CF3B72C142;
        Wed, 12 Jul 2023 19:23:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF789DA85A; Wed, 12 Jul 2023 21:17:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, vbabka@suse.cz, linux-mm@kvack.org
Subject: [PATCH] btrfs: disable slab merging in debug build
Date:   Wed, 12 Jul 2023 21:17:12 +0200
Message-Id: <20230712191712.18860-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The slab allocator newly allows to disable merging per-slab (since
commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag
SLAB_NO_MERGE")). Set this for all caches in debug build so we can
verify there are no leaks when module gets reloaded.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c          |  2 +-
 fs/btrfs/ctree.c            |  2 +-
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/delayed-inode.c    |  2 +-
 fs/btrfs/delayed-ref.c      |  8 ++++----
 fs/btrfs/extent-io-tree.c   |  2 +-
 fs/btrfs/extent_io.c        |  2 +-
 fs/btrfs/extent_map.c       |  2 +-
 fs/btrfs/free-space-cache.c |  3 ++-
 fs/btrfs/inode.c            |  3 ++-
 fs/btrfs/misc.h             | 10 ++++++++++
 fs/btrfs/ordered-data.c     |  2 +-
 fs/btrfs/transaction.c      |  3 ++-
 13 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 79336fa853db..0167c3aaf15d 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -200,7 +200,7 @@ int __init btrfs_prelim_ref_init(void)
 	btrfs_prelim_ref_cache = kmem_cache_create("btrfs_prelim_ref",
 					sizeof(struct prelim_ref),
 					0,
-					SLAB_MEM_SPREAD,
+					BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD,
 					NULL);
 	if (!btrfs_prelim_ref_cache)
 		return -ENOMEM;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a4cb4b642987..14fc47857caf 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5166,7 +5166,7 @@ int __init btrfs_ctree_init(void)
 {
 	btrfs_path_cachep = kmem_cache_create("btrfs_path",
 			sizeof(struct btrfs_path), 0,
-			SLAB_MEM_SPREAD, NULL);
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_path_cachep)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f2ff4cbe8656..bac993bb757e 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1370,7 +1370,7 @@ int __init btrfs_auto_defrag_init(void)
 {
 	btrfs_inode_defrag_cachep = kmem_cache_create("btrfs_inode_defrag",
 					sizeof(struct inode_defrag), 0,
-					SLAB_MEM_SPREAD,
+					BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD,
 					NULL);
 	if (!btrfs_inode_defrag_cachep)
 		return -ENOMEM;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6b457b010cbc..c0a6a1784697 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -31,7 +31,7 @@ int __init btrfs_delayed_inode_init(void)
 	delayed_node_cache = kmem_cache_create("btrfs_delayed_node",
 					sizeof(struct btrfs_delayed_node),
 					0,
-					SLAB_MEM_SPREAD,
+					BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD,
 					NULL);
 	if (!delayed_node_cache)
 		return -ENOMEM;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6a13cf00218b..d80ea0c52ccc 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1104,28 +1104,28 @@ int __init btrfs_delayed_ref_init(void)
 	btrfs_delayed_ref_head_cachep = kmem_cache_create(
 				"btrfs_delayed_ref_head",
 				sizeof(struct btrfs_delayed_ref_head), 0,
-				SLAB_MEM_SPREAD, NULL);
+				BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_delayed_ref_head_cachep)
 		goto fail;
 
 	btrfs_delayed_tree_ref_cachep = kmem_cache_create(
 				"btrfs_delayed_tree_ref",
 				sizeof(struct btrfs_delayed_tree_ref), 0,
-				SLAB_MEM_SPREAD, NULL);
+				BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_delayed_tree_ref_cachep)
 		goto fail;
 
 	btrfs_delayed_data_ref_cachep = kmem_cache_create(
 				"btrfs_delayed_data_ref",
 				sizeof(struct btrfs_delayed_data_ref), 0,
-				SLAB_MEM_SPREAD, NULL);
+				BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_delayed_data_ref_cachep)
 		goto fail;
 
 	btrfs_delayed_extent_op_cachep = kmem_cache_create(
 				"btrfs_delayed_extent_op",
 				sizeof(struct btrfs_delayed_extent_op), 0,
-				SLAB_MEM_SPREAD, NULL);
+				BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_delayed_extent_op_cachep)
 		goto fail;
 
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index a2315a4b8b75..3075d9439907 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1771,7 +1771,7 @@ int __init extent_state_init_cachep(void)
 {
 	extent_state_cache = kmem_cache_create("btrfs_extent_state",
 			sizeof(struct extent_state), 0,
-			SLAB_MEM_SPREAD, NULL);
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!extent_state_cache)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a845a90d46f7..094004c11a50 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -149,7 +149,7 @@ int __init extent_buffer_init_cachep(void)
 {
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
 			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!extent_buffer_cache)
 		return -ENOMEM;
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..d66f512613f7 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -17,7 +17,7 @@ int __init extent_map_init(void)
 {
 	extent_map_cache = kmem_cache_create("btrfs_extent_map",
 			sizeof(struct extent_map), 0,
-			SLAB_MEM_SPREAD, NULL);
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!extent_map_cache)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 880800418075..c5b70dbec245 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -4160,12 +4160,13 @@ int __init btrfs_free_space_init(void)
 {
 	btrfs_free_space_cachep = kmem_cache_create("btrfs_free_space",
 			sizeof(struct btrfs_free_space), 0,
-			SLAB_MEM_SPREAD, NULL);
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_free_space_cachep)
 		return -ENOMEM;
 
 	btrfs_free_space_bitmap_cachep = kmem_cache_create("btrfs_free_space_bitmap",
 							PAGE_SIZE, PAGE_SIZE,
+							BTRFS_DEBUG_SLAB_NO_MERGE |
 							SLAB_MEM_SPREAD, NULL);
 	if (!btrfs_free_space_bitmap_cachep) {
 		kmem_cache_destroy(btrfs_free_space_cachep);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b12850b31cb3..3bde49018530 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8723,7 +8723,8 @@ int __init btrfs_init_cachep(void)
 {
 	btrfs_inode_cachep = kmem_cache_create("btrfs_inode",
 			sizeof(struct btrfs_inode), 0,
-			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_RECLAIM_ACCOUNT |
+			SLAB_MEM_SPREAD | SLAB_ACCOUNT,
 			init_once);
 	if (!btrfs_inode_cachep)
 		goto fail;
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 005751a12911..9f667ab1a3d5 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -8,6 +8,16 @@
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
+/*
+ * Don't merge slabs in debug build so we can verify there are no leaks when
+ * reloading module.
+ */
+#ifdef CONFIG_BTRFS_DEBUG
+#define BTRFS_DEBUG_SLAB_NO_MERGE		SLAB_NO_MERGE
+#else
+#define BTRFS_DEBUG_SLAB_NO_MERGE		0
+#endif
+
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
 /*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a629532283bc..c7306e8bd877 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1245,7 +1245,7 @@ int __init ordered_data_init(void)
 {
 	btrfs_ordered_extent_cache = kmem_cache_create("btrfs_ordered_extent",
 				     sizeof(struct btrfs_ordered_extent), 0,
-				     SLAB_MEM_SPREAD,
+				     BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_MEM_SPREAD,
 				     NULL);
 	if (!btrfs_ordered_extent_cache)
 		return -ENOMEM;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cf306351b148..e7cfc992e02a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2641,7 +2641,8 @@ int __init btrfs_transaction_init(void)
 {
 	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
 			sizeof(struct btrfs_trans_handle), 0,
-			SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
+			BTRFS_DEBUG_SLAB_NO_MERGE | SLAB_TEMPORARY | SLAB_MEM_SPREAD,
+			NULL);
 	if (!btrfs_trans_handle_cachep)
 		return -ENOMEM;
 	return 0;
-- 
2.40.0

