Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE714FF9EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiDMPXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiDMPXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17B427D8
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB1B61D32
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267DEC385A3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863249;
        bh=EvWOz/Q2XKmqpgiDG3QHBatx6A8QEefPr0h6MbmQ3e0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WnW1JOCUSx9KufjewWsZSQpham4B8wHH9RhUSNA9jXaq3pN8pCUjTy443DvY7Ypt8
         52vlJlqSIt8lAYXbEPGV5+RVWMtwBreXgoSJhR2z0Dje08wSNCC7nVwpIKfaJa5AXb
         KJW5VuGUv/94qgL1jiurhcReSm8V0j0ReZ4b8io5nP7o4lie/a6X8CMnS1gtSpD8jT
         4LhwKEOdW1JGp0a/o8mS5q+lwCJslWE25KfDBjK7ypQ5U6ggo6wtlUF7AQ+tQmXr6g
         oZsGM9Mhx/XsMRh9QA0LR/RmOY1QfLvlZOds+ykI/Qovsx7+tO1l7XBvVEilbdzC6d
         JgicN3stIlvTw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: use a read/write lock for protecting the block groups tree
Date:   Wed, 13 Apr 2022 16:20:41 +0100
Message-Id: <72f679d9841d81206bac09ff65e61ee8f00f909b.1649862853.git.fdmanana@suse.com>
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

Currently we use a spin lock to protect the red black tree that we use to
track block groups. Most accesses to that tree are actually read only and
for large filesystems, with thousands of block groups, it actually has
a bad impact on performance, as concurrent read only searches on the tree
are serialized.

Read only searches on the tree are very frequent and done when:

1) Pinning and unpinning extents, as we need to lookup the respective
   block group from the tree;

2) Freeing the last reference of a tree block, regardless if we pin the
   underlying extent or add it back to free space cache/tree;

3) During NOCOW writes, both buffered IO and direct IO, we need to check
   if the block group that contains an extent is read only or not and to
   increment the number of NOCOW writers in the block group. For those
   operations we need to search for the block group in the tree.
   Similarly, after creating the ordered extent for the NOCOW write, we
   need to decrement the number of NOCOW writers from the same block
   group, which requires searching for it in the tree;

4) Decreasing the number of extent revervations in a block group;

5) When allocating extents and freeing reserved extents;

6) Adding and removing free space to the free space tree;

7) When releasing delalloc bytes during ordered extent completion;

8) When relocating a block group;

9) During fitrim, to iterate over the block groups;

10) etc;

Write accesses to the tree, to add or remove block groups, are much less
frequent as they happen only when allocating a new block group or when
deleting a block group.

We also use the same spin lock to protect the list of currently caching
block groups. Additions to this list are made when we need to cache a
block group, because we don't have a free space cache for it (or we have
but it's invalid), and removals from this list are done when caching of
the block group's free space finishes. These cases are also not very
common, but when they happen, they happen only once when the filesystem
is mounted.

So switch the lock that protects the tree of block groups from a spinning
lock to a read/write lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 40 ++++++++++++++++++++--------------------
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent-tree.c |  4 ++--
 fs/btrfs/transaction.c |  4 ++--
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a91938ab7ff8..2c42ce00b84d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -172,7 +172,7 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 
 	ASSERT(block_group->length != 0);
 
-	spin_lock(&info->block_group_cache_lock);
+	write_lock(&info->block_group_cache_lock);
 	p = &info->block_group_cache_tree.rb_root.rb_node;
 
 	while (*p) {
@@ -184,7 +184,7 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 			p = &(*p)->rb_right;
 			leftmost = false;
 		} else {
-			spin_unlock(&info->block_group_cache_lock);
+			write_unlock(&info->block_group_cache_lock);
 			return -EEXIST;
 		}
 	}
@@ -193,7 +193,7 @@ static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 	rb_insert_color_cached(&block_group->cache_node,
 			       &info->block_group_cache_tree, leftmost);
 
-	spin_unlock(&info->block_group_cache_lock);
+	write_unlock(&info->block_group_cache_lock);
 
 	return 0;
 }
@@ -209,7 +209,7 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 	struct rb_node *n;
 	u64 end, start;
 
-	spin_lock(&info->block_group_cache_lock);
+	read_lock(&info->block_group_cache_lock);
 	n = info->block_group_cache_tree.rb_root.rb_node;
 
 	while (n) {
@@ -234,7 +234,7 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 	}
 	if (ret)
 		btrfs_get_block_group(ret);
-	spin_unlock(&info->block_group_cache_lock);
+	read_unlock(&info->block_group_cache_lock);
 
 	return ret;
 }
@@ -263,13 +263,13 @@ struct btrfs_block_group *btrfs_next_block_group(
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct rb_node *node;
 
-	spin_lock(&fs_info->block_group_cache_lock);
+	read_lock(&fs_info->block_group_cache_lock);
 
 	/* If our block group was removed, we need a full search. */
 	if (RB_EMPTY_NODE(&cache->cache_node)) {
 		const u64 next_bytenr = cache->start + cache->length;
 
-		spin_unlock(&fs_info->block_group_cache_lock);
+		read_unlock(&fs_info->block_group_cache_lock);
 		btrfs_put_block_group(cache);
 		cache = btrfs_lookup_first_block_group(fs_info, next_bytenr); return cache;
 	}
@@ -280,7 +280,7 @@ struct btrfs_block_group *btrfs_next_block_group(
 		btrfs_get_block_group(cache);
 	} else
 		cache = NULL;
-	spin_unlock(&fs_info->block_group_cache_lock);
+	read_unlock(&fs_info->block_group_cache_lock);
 	return cache;
 }
 
@@ -768,10 +768,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	cache->has_caching_ctl = 1;
 	spin_unlock(&cache->lock);
 
-	spin_lock(&fs_info->block_group_cache_lock);
+	write_lock(&fs_info->block_group_cache_lock);
 	refcount_inc(&caching_ctl->count);
 	list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups);
-	spin_unlock(&fs_info->block_group_cache_lock);
+	write_unlock(&fs_info->block_group_cache_lock);
 
 	btrfs_get_block_group(cache);
 
@@ -953,7 +953,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	spin_lock(&fs_info->block_group_cache_lock);
+	write_lock(&fs_info->block_group_cache_lock);
 	rb_erase_cached(&block_group->cache_node,
 			&fs_info->block_group_cache_tree);
 	RB_CLEAR_NODE(&block_group->cache_node);
@@ -961,7 +961,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
-	spin_unlock(&fs_info->block_group_cache_lock);
+	write_unlock(&fs_info->block_group_cache_lock);
 
 	down_write(&block_group->space_info->groups_sem);
 	/*
@@ -986,7 +986,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
 	if (block_group->has_caching_ctl) {
-		spin_lock(&fs_info->block_group_cache_lock);
+		write_lock(&fs_info->block_group_cache_lock);
 		if (!caching_ctl) {
 			struct btrfs_caching_control *ctl;
 
@@ -1000,7 +1000,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		}
 		if (caching_ctl)
 			list_del_init(&caching_ctl->list);
-		spin_unlock(&fs_info->block_group_cache_lock);
+		write_unlock(&fs_info->block_group_cache_lock);
 		if (caching_ctl) {
 			/* Once for the caching bgs list and once for us. */
 			btrfs_put_caching_control(caching_ctl);
@@ -3970,14 +3970,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_caching_control *caching_ctl;
 	struct rb_node *n;
 
-	spin_lock(&info->block_group_cache_lock);
+	write_lock(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
 		caching_ctl = list_entry(info->caching_block_groups.next,
 					 struct btrfs_caching_control, list);
 		list_del(&caching_ctl->list);
 		btrfs_put_caching_control(caching_ctl);
 	}
-	spin_unlock(&info->block_group_cache_lock);
+	write_unlock(&info->block_group_cache_lock);
 
 	spin_lock(&info->unused_bgs_lock);
 	while (!list_empty(&info->unused_bgs)) {
@@ -4007,14 +4007,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	spin_unlock(&info->zone_active_bgs_lock);
 
-	spin_lock(&info->block_group_cache_lock);
+	write_lock(&info->block_group_cache_lock);
 	while ((n = rb_last(&info->block_group_cache_tree.rb_root)) != NULL) {
 		block_group = rb_entry(n, struct btrfs_block_group,
 				       cache_node);
 		rb_erase_cached(&block_group->cache_node,
 				&info->block_group_cache_tree);
 		RB_CLEAR_NODE(&block_group->cache_node);
-		spin_unlock(&info->block_group_cache_lock);
+		write_unlock(&info->block_group_cache_lock);
 
 		down_write(&block_group->space_info->groups_sem);
 		list_del(&block_group->list);
@@ -4037,9 +4037,9 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		ASSERT(block_group->swap_extents == 0);
 		btrfs_put_block_group(block_group);
 
-		spin_lock(&info->block_group_cache_lock);
+		write_lock(&info->block_group_cache_lock);
 	}
-	spin_unlock(&info->block_group_cache_lock);
+	write_unlock(&info->block_group_cache_lock);
 
 	btrfs_release_global_block_rsv(info);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d4a9110d5174..55dee124ee44 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -679,7 +679,7 @@ struct btrfs_fs_info {
 	struct radix_tree_root fs_roots_radix;
 
 	/* block group cache stuff */
-	spinlock_t block_group_cache_lock;
+	rwlock_t block_group_cache_lock;
 	struct rb_root_cached block_group_cache_tree;
 
 	/* keep track of unallocated space */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 252de49cba05..2689e8589627 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3230,7 +3230,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(fs_info);
 
-	spin_lock_init(&fs_info->block_group_cache_lock);
+	rwlock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
 
 	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cd79a5f4c643..963160a0c393 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2497,7 +2497,7 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 	struct rb_node *leftmost;
 	u64 bytenr = 0;
 
-	spin_lock(&fs_info->block_group_cache_lock);
+	read_lock(&fs_info->block_group_cache_lock);
 	/* Get the block group with the lowest logical start address. */
 	leftmost = rb_first_cached(&fs_info->block_group_cache_tree);
 	if (leftmost) {
@@ -2506,7 +2506,7 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 		bg = rb_entry(leftmost, struct btrfs_block_group, cache_node);
 		bytenr = bg->start;
 	}
-	spin_unlock(&fs_info->block_group_cache_lock);
+	read_unlock(&fs_info->block_group_cache_lock);
 
 	return bytenr;
 }
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b008c5110958..875b801ab3d7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -221,7 +221,7 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 	 * the caching thread will re-start it's search from 3, and thus find
 	 * the hole from [4,6) to add to the free space cache.
 	 */
-	spin_lock(&fs_info->block_group_cache_lock);
+	write_lock(&fs_info->block_group_cache_lock);
 	list_for_each_entry_safe(caching_ctl, next,
 				 &fs_info->caching_block_groups, list) {
 		struct btrfs_block_group *cache = caching_ctl->block_group;
@@ -234,7 +234,7 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 			cache->last_byte_to_unpin = caching_ctl->progress;
 		}
 	}
-	spin_unlock(&fs_info->block_group_cache_lock);
+	write_unlock(&fs_info->block_group_cache_lock);
 	up_write(&fs_info->commit_root_sem);
 }
 
-- 
2.35.1

