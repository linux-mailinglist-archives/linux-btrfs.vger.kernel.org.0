Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527F797F25
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjIGXQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjIGXQJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8483BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E254210DB;
        Thu,  7 Sep 2023 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJK7B/EHFiQw9UJ8+aYPk8c1y6OYiK3yX8oRYrUU0Fw=;
        b=eTH5rBTC1HXLfsdbUo1P5l4nFS0GKgM/hajCgKQcHStAIA9/Tmey1mV0P3wpbsYy3l8X64
        GMwBiaJheGP78OwGeOWChDdZ47e6UTcEk7yIO1hnBkqVT24Xy9NkGMF8NtwtIq5Gc9Gyzm
        zB1tsZebpaI3d/D/bwkLeN99DHfFdyg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 928A82C142;
        Thu,  7 Sep 2023 23:16:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA2EEDA8C5; Fri,  8 Sep 2023 01:09:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/10] btrfs: reduce arguments of helpers space accounting root item
Date:   Fri,  8 Sep 2023 01:09:33 +0200
Message-ID: <ec9f787e9b36be2e8240734d74f1fff4f68c78c9.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two helpers to increase used bytes of root items that add or
subtract one node size, we don't need to pass the argument for that.
Rename the function so it matches the root item member that gets
changed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 792f9e3afad8..6d18f6d5a8b3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -947,19 +947,19 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 	return 1;
 }
 
-static void root_add_used(struct btrfs_root *root, u32 size)
+static void root_add_used_bytes(struct btrfs_root *root)
 {
 	spin_lock(&root->accounting_lock);
 	btrfs_set_root_used(&root->root_item,
-			    btrfs_root_used(&root->root_item) + size);
+		btrfs_root_used(&root->root_item) + root->fs_info->nodesize);
 	spin_unlock(&root->accounting_lock);
 }
 
-static void root_sub_used(struct btrfs_root *root, u32 size)
+static void root_sub_used_bytes(struct btrfs_root *root)
 {
 	spin_lock(&root->accounting_lock);
 	btrfs_set_root_used(&root->root_item,
-			    btrfs_root_used(&root->root_item) - size);
+		btrfs_root_used(&root->root_item) - root->fs_info->nodesize);
 	spin_unlock(&root->accounting_lock);
 }
 
@@ -1075,7 +1075,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		/* once for the path */
 		free_extent_buffer(mid);
 
-		root_sub_used(root, mid->len);
+		root_sub_used_bytes(root);
 		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
 		free_extent_buffer_stale(mid);
@@ -1145,7 +1145,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 				right = NULL;
 				goto out;
 			}
-			root_sub_used(root, right->len);
+			root_sub_used_bytes(root);
 			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
 					      0, 1);
 			free_extent_buffer_stale(right);
@@ -1203,7 +1203,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			mid = NULL;
 			goto out;
 		}
-		root_sub_used(root, mid->len);
+		root_sub_used_bytes(root);
 		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
 		mid = NULL;
@@ -2937,7 +2937,6 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_path *path, int level)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 lower_gen;
 	struct extent_buffer *lower;
 	struct extent_buffer *c;
@@ -2960,7 +2959,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
-	root_add_used(root, fs_info->nodesize);
+	root_add_used_bytes(root);
 
 	btrfs_set_header_nritems(c, 1);
 	btrfs_set_node_key(c, &lower_key, 0);
@@ -3104,7 +3103,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
-	root_add_used(root, fs_info->nodesize);
+	root_add_used_bytes(root);
 	ASSERT(btrfs_header_level(c) == level);
 
 	ret = btrfs_tree_mod_log_eb_copy(split, c, 0, mid, c_nritems - mid);
@@ -3857,7 +3856,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
-	root_add_used(root, fs_info->nodesize);
+	root_add_used_bytes(root);
 
 	if (split == 0) {
 		if (mid <= slot) {
@@ -4530,7 +4529,7 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	 */
 	btrfs_unlock_up_safe(path, 0);
 
-	root_sub_used(root, leaf->len);
+	root_sub_used_bytes(root);
 
 	atomic_inc(&leaf->refs);
 	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
-- 
2.41.0

