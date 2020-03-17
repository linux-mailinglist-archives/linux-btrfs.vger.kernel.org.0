Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8F187AF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCQIMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQIMl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EBD78AE3C
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 25/39] btrfs: Rename backref_tree_panic() to backref_cache_panic(), and move it to backref.c
Date:   Tue, 17 Mar 2020 16:11:11 +0800
Message-Id: <20200317081125.36289-26-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
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
index 9ac76ffefd41..bd5ba061e772 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -357,4 +357,12 @@ static inline void drop_backref_node(struct backref_cache *tree,
 void cleanup_backref_node(struct backref_cache *cache,
 			  struct backref_node *node);
 void backref_cache_release(struct backref_cache *cache);
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
index e9b18cba1b41..f0291177525c 100644
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
@@ -772,7 +759,8 @@ static int finish_upper_links(struct backref_cache *cache,
 		rb_node = simple_insert(&cache->rb_root, start->bytenr,
 					&start->rb_node);
 		if (rb_node)
-			backref_tree_panic(rb_node, -EEXIST, start->bytenr);
+			backref_cache_panic(cache->fs_info, start->bytenr,
+					    -EEXIST);
 		list_add_tail(&start->lower, &cache->leaves);
 	}
 
@@ -840,8 +828,8 @@ static int finish_upper_links(struct backref_cache *cache,
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
@@ -1130,7 +1118,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	rb_node = simple_insert(&cache->rb_root, new_node->bytenr,
 				&new_node->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, new_node->bytenr);
+		backref_cache_panic(trans->fs_info, new_node->bytenr, -EEXIST);
 
 	if (!new_node->lowest) {
 		list_for_each_entry(new_edge, &new_node->lower, list[UPPER]) {
@@ -1242,7 +1230,7 @@ static int __update_reloc_root(struct btrfs_root *root, u64 new_bytenr)
 				node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, node->bytenr);
+		backref_cache_panic(fs_info, node->bytenr, -EEXIST);
 	return 0;
 }
 
@@ -3328,7 +3316,8 @@ static int add_tree_block(struct reloc_control *rc,
 
 	rb_node = simple_insert(blocks, block->bytenr, &block->rb_node);
 	if (rb_node)
-		backref_tree_panic(rb_node, -EEXIST, block->bytenr);
+		backref_cache_panic(rc->extent_root->fs_info, block->bytenr,
+				    -EEXIST);
 
 	return 0;
 }
@@ -3626,8 +3615,8 @@ static int find_data_references(struct reloc_control *rc,
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

