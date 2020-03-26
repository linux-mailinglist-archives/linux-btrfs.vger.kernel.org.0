Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569CC193AF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgCZIeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgCZIeS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9555ACCE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 26/39] btrfs: Rename backref_tree_panic() to btrfs_backref_panic(), and move it to backref.c
Date:   Thu, 26 Mar 2020 16:33:03 +0800
Message-Id: <20200326083316.48847-27-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also change the parameter, since all callers can easily grab an fs_info,
there is no need for all the dancing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.h    |  9 +++++++++
 fs/btrfs/relocation.c | 29 +++++++++--------------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index c77de13570bc..c355ca816349 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -365,4 +365,13 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 
 /* Release all nodes/edges from current cache */
 void btrfs_backref_release_cache(struct btrfs_backref_cache *cache);
+
+static inline void btrfs_backref_panic(struct btrfs_fs_info *fs_info,
+				       u64 bytenr, int errno)
+{
+	btrfs_panic(fs_info, errno,
+		    "Inconsistency in backref cache found at offset %llu",
+		    bytenr);
+}
+
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4649de9fd02a..5448cc2f1b28 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -175,19 +175,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
-{
-
-	struct btrfs_fs_info *fs_info = NULL;
-	struct btrfs_backref_node *bnode = rb_entry(rb_node,
-			struct btrfs_backref_node, rb_node);
-	if (bnode->root)
-		fs_info = bnode->root->fs_info;
-	btrfs_panic(fs_info, errno,
-		    "Inconsistency in backref cache found at offset %llu",
-		    bytenr);
-}
-
 /*
  * walk up backref nodes until reach node presents tree root
  */
@@ -244,7 +231,7 @@ static void update_backref_node(struct btrfs_backref_cache *cache,
 	node->bytenr = bytenr;
 	rb_node = simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, bytenr);
+		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
 }
 
 /*
@@ -766,7 +753,8 @@ static int finish_upper_links(struct btrfs_backref_cache *cache,
 		rb_node = simple_insert(&cache->rb_root, start->bytenr,
 					&start->rb_node);
 		if (rb_node)
-			backref_tree_panic(rb_node, -EEXIST, start->bytenr);
+			btrfs_backref_panic(cache->fs_info, start->bytenr,
+					    -EEXIST);
 		list_add_tail(&start->lower, &cache->leaves);
 	}
 
@@ -834,8 +822,8 @@ static int finish_upper_links(struct btrfs_backref_cache *cache,
 			rb_node = simple_insert(&cache->rb_root, upper->bytenr,
 						&upper->rb_node);
 			if (rb_node) {
-				backref_tree_panic(rb_node, -EEXIST,
-						   upper->bytenr);
+				btrfs_backref_panic(cache->fs_info,
+						upper->bytenr, -EEXIST);
 				return -EUCLEAN;
 			}
 		}
@@ -1127,7 +1115,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	rb_node = simple_insert(&cache->rb_root, new_node->bytenr,
 				&new_node->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, new_node->bytenr);
+		btrfs_backref_panic(trans->fs_info, new_node->bytenr, -EEXIST);
 
 	if (!new_node->lowest) {
 		list_for_each_entry(new_edge, &new_node->lower, list[UPPER]) {
@@ -1254,7 +1242,7 @@ static int __update_reloc_root(struct btrfs_root *root)
 				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, node->bytenr);
+		btrfs_backref_panic(fs_info, node->bytenr, -EEXIST);
 	return 0;
 }
 
@@ -3396,7 +3384,8 @@ static int add_tree_block(struct reloc_control *rc,
 
 	rb_node = simple_insert(blocks, block->bytenr, &block->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, block->bytenr);
+		btrfs_backref_panic(rc->extent_root->fs_info, block->bytenr,
+				    -EEXIST);
 
 	return 0;
 }
-- 
2.26.0

