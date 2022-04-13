Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F874FF9F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiDMPXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiDMPXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51023E5CB
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D6061D1D
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A6BC385A8
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863248;
        bh=pAehwj0TEwWwtDINvOG8V2JZ0kKyGfKoBUXvsWg85I4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uYN/fH1W+W9VYbHhpnSbpQZao+mAgo46iUwOuvTlRyexcnafXJ+e1OTEK2IBaI0u+
         nphq/w179Kmb6bi9sImp7eWDUQcquUD2AGK1EPvRoF7FXxcoGIOxGYJAc/kuhmVbLG
         JRbXtaMhrysZ7taEPV2ihJOa+Tyx10LLq2LX6BVVrDZtR3pJZ7083U24o8INstPO0J
         0Kpq/XkK7TUIbbn6AUTYKXT+hWk9bCsDyjL9+AHi9Fb+PB3IBjeZWoOXNODw+Ke5a6
         Mt7UUN098xXUQnjigVcoTEGqJqcYGJlgCsovjZoDJsAMJ4U4BdBqVTdtdQu8jVNGzw
         pTt1JLw47Fp7Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: use rbtree with leftmost node cached for tracking lowest block group
Date:   Wed, 13 Apr 2022 16:20:40 +0100
Message-Id: <a3ecb78fd63413dc736b13c6ab102ffb932f0d79.1649862853.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649862853.git.fdmanana@suse.com>
References: <cover.1649862853.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We keep track of the start offset of the block group with the lowest start
offset at fs_info->first_logical_byte. This requires explicitly updating
that field everytime we add, delete or lookup a block group to/from the
red black tree at fs_info->block_group_cache_tree.

Since the block group with the lowest start address happens to always be
the one that is the leftmost node of the tree, we can use a red black tree
that caches the left most node. Then when we need the start address of
that block group, we can just quickly get the leftmost node in the tree
and extract the start offset of that node's block group. This avoids the
need to explicitly keep track of that address in the dedicated member
fs_info->first_logical_byte, and it also allows the next patch in the
series to switch the lock that protects the red black tree from a spin
lock to a read/write lock - without this change it would be tricky
because block group searches also update fs_info->first_logical_byte.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c      | 30 ++++++++++++------------------
 fs/btrfs/ctree.h            |  3 +--
 fs/btrfs/disk-io.c          |  3 +--
 fs/btrfs/extent-tree.c      | 22 +++++++++-------------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/free-space-tree.c  |  2 +-
 6 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7bf10afab89c..a91938ab7ff8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -168,11 +168,12 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct btrfs_block_group *cache;
+	bool leftmost = true;
 
 	ASSERT(block_group->length != 0);
 
 	spin_lock(&info->block_group_cache_lock);
-	p = &info->block_group_cache_tree.rb_node;
+	p = &info->block_group_cache_tree.rb_root.rb_node;
 
 	while (*p) {
 		parent = *p;
@@ -181,6 +182,7 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 			p = &(*p)->rb_left;
 		} else if (block_group->start > cache->start) {
 			p = &(*p)->rb_right;
+			leftmost = false;
 		} else {
 			spin_unlock(&info->block_group_cache_lock);
 			return -EEXIST;
@@ -188,11 +190,8 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	}
 
 	rb_link_node(&block_group->cache_node, parent, p);
-	rb_insert_color(&block_group->cache_node,
-			&info->block_group_cache_tree);
-
-	if (info->first_logical_byte > block_group->start)
-		info->first_logical_byte = block_group->start;
+	rb_insert_color_cached(&block_group->cache_node,
+			       &info->block_group_cache_tree, leftmost);
 
 	spin_unlock(&info->block_group_cache_lock);
 
@@ -211,7 +210,7 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 	u64 end, start;
 
 	spin_lock(&info->block_group_cache_lock);
-	n = info->block_group_cache_tree.rb_node;
+	n = info->block_group_cache_tree.rb_root.rb_node;
 
 	while (n) {
 		cache = rb_entry(n, struct btrfs_block_group, cache_node);
@@ -233,11 +232,8 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 			break;
 		}
 	}
-	if (ret) {
+	if (ret)
 		btrfs_get_block_group(ret);
-		if (bytenr == 0 && info->first_logical_byte > ret->start)
-			info->first_logical_byte = ret->start;
-	}
 	spin_unlock(&info->block_group_cache_lock);
 
 	return ret;
@@ -958,15 +954,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		goto out;
 
 	spin_lock(&fs_info->block_group_cache_lock);
-	rb_erase(&block_group->cache_node,
-		 &fs_info->block_group_cache_tree);
+	rb_erase_cached(&block_group->cache_node,
+			&fs_info->block_group_cache_tree);
 	RB_CLEAR_NODE(&block_group->cache_node);
 
 	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
-	if (fs_info->first_logical_byte == block_group->start)
-		fs_info->first_logical_byte = (u64)-1;
 	spin_unlock(&fs_info->block_group_cache_lock);
 
 	down_write(&block_group->space_info->groups_sem);
@@ -4014,11 +4008,11 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	spin_unlock(&info->zone_active_bgs_lock);
 
 	spin_lock(&info->block_group_cache_lock);
-	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
+	while ((n = rb_last(&info->block_group_cache_tree.rb_root)) != NULL) {
 		block_group = rb_entry(n, struct btrfs_block_group,
 				       cache_node);
-		rb_erase(&block_group->cache_node,
-			 &info->block_group_cache_tree);
+		rb_erase_cached(&block_group->cache_node,
+				&info->block_group_cache_tree);
 		RB_CLEAR_NODE(&block_group->cache_node);
 		spin_unlock(&info->block_group_cache_lock);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bc6b6a70791d..d4a9110d5174 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -680,8 +680,7 @@ struct btrfs_fs_info {
 
 	/* block group cache stuff */
 	spinlock_t block_group_cache_lock;
-	u64 first_logical_byte;
-	struct rb_root block_group_cache_tree;
+	struct rb_root_cached block_group_cache_tree;
 
 	/* keep track of unallocated space */
 	atomic64_t free_chunk_space;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2bc867d35308..252de49cba05 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3231,8 +3231,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_async_reclaim_work(fs_info);
 
 	spin_lock_init(&fs_info->block_group_cache_lock);
-	fs_info->block_group_cache_tree = RB_ROOT;
-	fs_info->first_logical_byte = (u64)-1;
+	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
 
 	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
 			    IO_TREE_FS_EXCLUDED_EXTENTS, NULL);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2a718727541c..cd79a5f4c643 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2494,23 +2494,19 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 
 static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_block_group *cache;
-	u64 bytenr;
+	struct rb_node *leftmost;
+	u64 bytenr = 0;
 
 	spin_lock(&fs_info->block_group_cache_lock);
-	bytenr = fs_info->first_logical_byte;
-	spin_unlock(&fs_info->block_group_cache_lock);
-
-	if (bytenr < (u64)-1)
-		return bytenr;
-
 	/* Get the block group with the lowest logical start address. */
-	cache = btrfs_lookup_first_block_group(fs_info, 0);
-	if (!cache)
-		return 0;
+	leftmost = rb_first_cached(&fs_info->block_group_cache_tree);
+	if (leftmost) {
+		struct btrfs_block_group *bg;
 
-	bytenr = cache->start;
-	btrfs_put_block_group(cache);
+		bg = rb_entry(leftmost, struct btrfs_block_group, cache_node);
+		bytenr = bg->start;
+	}
+	spin_unlock(&fs_info->block_group_cache_lock);
 
 	return bytenr;
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ef84bc5030cd..f7adee6fa05e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -4072,7 +4072,7 @@ static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
 
 	btrfs_info(fs_info, "cleaning free space cache v1");
 
-	node = rb_first(&fs_info->block_group_cache_tree);
+	node = rb_first_cached(&fs_info->block_group_cache_tree);
 	while (node) {
 		block_group = rb_entry(node, struct btrfs_block_group, cache_node);
 		ret = btrfs_remove_free_space_inode(trans, NULL, block_group);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 0ae54d8c10d6..1bf89aa67216 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1178,7 +1178,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		goto abort;
 	}
 
-	node = rb_first(&fs_info->block_group_cache_tree);
+	node = rb_first_cached(&fs_info->block_group_cache_tree);
 	while (node) {
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
-- 
2.35.1

