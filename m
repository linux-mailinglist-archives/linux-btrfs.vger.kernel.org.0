Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07918176FDA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCCHPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:56912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbgCCHPl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D00BEAC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/19] btrfs: Rename backref_tree_panic() to backref_cache_panic(), and move it to backref.c
Date:   Tue,  3 Mar 2020 15:14:04 +0800
Message-Id: <20200303071409.57982-15-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
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
 fs/btrfs/backref.h    |  8 ++++++++
 fs/btrfs/relocation.c | 33 +++++++++++----------------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 2fb854b1d5f0..4a4c9070a38b 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -378,4 +378,12 @@ static inline void drop_backref_node(struct backref_cache *tree,
 void cleanup_backref_node(struct backref_cache *cache,
 			  struct backref_node *node);
 void backref_cache_cleanup(struct backref_cache *cache);
+
+static inline void backref_cache_panic(struct btrfs_fs_info *fs_info,
+				       u64 bytenr, int errno)
+{
+	btrfs_panic(fs_info, errno,
+		    "Inconsistency in backref cache found at offset %llu",
+		    bytenr);
+}
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 71df172b70bb..349e8e761e8d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -182,19 +182,6 @@ static void mapping_tree_init(struct mapping_tree *tree)
 	spin_lock_init(&tree->lock);
 }
 
-static void backref_tree_panic(struct rb_node *rb_node, int errno, u64 bytenr)
-{
-
-	struct btrfs_fs_info *fs_info = NULL;
-	struct backref_node *bnode = rb_entry(rb_node, struct backref_node,
-					      rb_node);
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
@@ -251,7 +238,7 @@ static void update_backref_node(struct backref_cache *cache,
 	node->bytenr = bytenr;
 	rb_node = simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, bytenr);
+		backref_cache_panic(cache->fs_info, bytenr, -EEXIST);
 }
 
 /*
@@ -778,8 +765,8 @@ static int finish_upper_links(struct backref_cache *cache,
 			rb_node = simple_insert(&cache->rb_root, upper->bytenr,
 						&upper->rb_node);
 			if (rb_node) {
-				backref_tree_panic(rb_node, -EEXIST,
-						   upper->bytenr);
+				backref_cache_panic(cache->fs_info,
+						upper->bytenr, -EEXIST);
 				return -EUCLEAN;
 			}
 		}
@@ -949,7 +936,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		rb_node = simple_insert(&cache->rb_root, node->bytenr,
 					&node->rb_node);
 		if (rb_node)
-			backref_tree_panic(rb_node, -EEXIST, node->bytenr);
+			backref_cache_panic(cache->fs_info, node->bytenr,
+					    -EEXIST);
 		list_add_tail(&node->lower, &cache->leaves);
 	}
 
@@ -1087,7 +1075,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	rb_node = simple_insert(&cache->rb_root, new_node->bytenr,
 				&new_node->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, new_node->bytenr);
+		backref_cache_panic(trans->fs_info, new_node->bytenr, -EEXIST);
 
 	if (!new_node->lowest) {
 		list_for_each_entry(new_edge, &new_node->lower, list[UPPER]) {
@@ -1199,7 +1187,7 @@ static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
 				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, node->bytenr);
+		backref_cache_panic(fs_info, node->bytenr, -EEXIST);
 	return 0;
 }
 
@@ -3285,7 +3273,8 @@ static int add_tree_block(struct reloc_control *rc,
 
 	rb_node = simple_insert(blocks, block->bytenr, &block->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, block->bytenr);
+		backref_cache_panic(rc->extent_root->fs_info, block->bytenr,
+				    -EEXIST);
 
 	return 0;
 }
@@ -3583,8 +3572,8 @@ static int find_data_references(struct reloc_control *rc,
 			rb_node = simple_insert(blocks, block->bytenr,
 						&block->rb_node);
 			if (rb_node)
-				backref_tree_panic(rb_node, -EEXIST,
-						   block->bytenr);
+				backref_cache_panic(fs_info, block->bytenr,
+						    -EEXIST);
 		}
 		if (counted)
 			added = 1;
-- 
2.25.1

