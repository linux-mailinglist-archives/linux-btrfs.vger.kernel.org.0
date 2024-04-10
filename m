Return-Path: <linux-btrfs+bounces-4106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A193489F0E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E841C21FF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B115ECC4;
	Wed, 10 Apr 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDX8dB4w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2815ECD1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748535; cv=none; b=G1q9ZeTdPU0mjN6uaj+t4P63I+opAC32gRj9Q5vH3Usb2dH3pkZpP7qdDrxuLEaVefQ6yGAjkZaT9NLYKQn2lffXEN9qnVWrj4nysf/zgWCcGUrPG66WVPMQNNaRxErRZGqErKQhDl+PiCYWW4Dulj/V5VgEQG9VephoEwhEMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748535; c=relaxed/simple;
	bh=yi1U240R5KsRHltzNh0UfAUh7geoKvnxiKt1FKNDmoU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fg4889VmSeE8TrMdQsBKpZhX4Xg7GkNt63J6arYpQtqCy22bdAzut7/plMfGE6trL9c7ZNkpXKY19jsfw6DZM1jsIPlAQngHDl0gwueK2RcodZxHbnc7QyW7xvFFB4ewIchjIBIZMm1iHOLBCnhUoIwE/lzYO/S5Exm5VoVKPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDX8dB4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCD8C43390
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748535;
	bh=yi1U240R5KsRHltzNh0UfAUh7geoKvnxiKt1FKNDmoU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JDX8dB4w7qV4l5FgRFhnPFVemk/2jPq6QSxpfrQoBFLjksHcfhTdPB/Qv1nniqiJA
	 VxBwy/dQ0NC5chWkmDV9+3dBVP/lcRynNEzgIoa9bS+MwYjtQl7K4hcftZuOY6L86u
	 mILFbdWOtUo9m09ldycxbJpA5PFyPratq5H0dAK2SWtR9CupTS8tHwcKZhgXWFcnUL
	 cBNIyb5M66i/LYo2gwUDb84GLxtQeeWSbTdHglYekouNomGes5tsaU/NtpuMTnoXOM
	 IyNHbuqj0z3Q22+fc78M8IRqi/7w39QcFqo7GPApOcRZRrKtjEessZvZnmtSfzCD2y
	 3ffxByZhYzMZg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: add a global per cpu counter to track number of used extent maps
Date: Wed, 10 Apr 2024 12:28:40 +0100
Message-Id: <0f1a834bcb67f4c57885706b54e19d22e64b9ce7.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add a per cpu counter that tracks the total number of extent maps that are
in extent trees of inodes that belong to fs trees. This is going to be
used in an upcoming change that adds a shrinker for extent maps. Only
extent maps for fs trees are considered, because for special trees such as
the data relocation tree we don't want to evict their extent maps which
are critical for the relocation to work, and since those are limited, it's
not a concern to have them in memory during the relocation of a block
group. Another case are extent maps for free space cache inodes, which
must always remain in memory, but those are limited (there's only one per
free space cache inode, which means one per block group).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c    |  6 ++++++
 fs/btrfs/extent_map.c | 38 +++++++++++++++++++++++++++-----------
 fs/btrfs/fs.h         |  2 ++
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0474e9b6d302..3c2d35b2062e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1269,6 +1269,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
+	ASSERT(percpu_counter_sum_positive(&fs_info->evictable_extent_maps) == 0);
+	percpu_counter_destroy(&fs_info->evictable_extent_maps);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
@@ -2848,6 +2850,10 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	if (ret)
 		return ret;
 
+	ret = percpu_counter_init(&fs_info->evictable_extent_maps, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+
 	ret = percpu_counter_init(&fs_info->dirty_metadata_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 15817b842c24..2fcf28148a81 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -76,6 +76,14 @@ static u64 range_end(u64 start, u64 len)
 	return start + len;
 }
 
+static void dec_evictable_extent_maps(struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(inode->root)))
+		percpu_counter_dec(&fs_info->evictable_extent_maps);
+}
+
 static int tree_insert(struct rb_root_cached *root, struct extent_map *em)
 {
 	struct rb_node **p = &root->rb_root.rb_node;
@@ -223,8 +231,9 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	return next->block_start == prev->block_start;
 }
 
-static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
+static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
 	struct extent_map *merge = NULL;
 	struct rb_node *rb;
 
@@ -258,6 +267,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
 			free_extent_map(merge);
+			dec_evictable_extent_maps(inode);
 		}
 	}
 
@@ -272,6 +282,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
 		free_extent_map(merge);
+		dec_evictable_extent_maps(inode);
 	}
 }
 
@@ -322,7 +333,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 	em->generation = gen;
 	em->flags &= ~EXTENT_FLAG_PINNED;
 
-	try_merge_map(tree, em);
+	try_merge_map(inode, em);
 
 out:
 	write_unlock(&tree->lock);
@@ -333,16 +344,14 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 {
-	struct extent_map_tree *tree = &inode->extent_tree;
-
-	lockdep_assert_held_write(&tree->lock);
+	lockdep_assert_held_write(&inode->extent_tree.lock);
 
 	em->flags &= ~EXTENT_FLAG_LOGGING;
 	if (extent_map_in_tree(em))
-		try_merge_map(tree, em);
+		try_merge_map(inode, em);
 }
 
-static inline void setup_extent_mapping(struct extent_map_tree *tree,
+static inline void setup_extent_mapping(struct btrfs_inode *inode,
 					struct extent_map *em,
 					int modified)
 {
@@ -351,9 +360,9 @@ static inline void setup_extent_mapping(struct extent_map_tree *tree,
 	ASSERT(list_empty(&em->list));
 
 	if (modified)
-		list_add(&em->list, &tree->modified_extents);
+		list_add(&em->list, &inode->extent_tree.modified_extents);
 	else
-		try_merge_map(tree, em);
+		try_merge_map(inode, em);
 }
 
 /*
@@ -373,6 +382,8 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 			      struct extent_map *em, int modified)
 {
 	struct extent_map_tree *tree = &inode->extent_tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
 	lockdep_assert_held_write(&tree->lock);
@@ -381,7 +392,10 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
-	setup_extent_mapping(tree, em, modified);
+	setup_extent_mapping(inode, em, modified);
+
+	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
+		percpu_counter_inc(&fs_info->evictable_extent_maps);
 
 	return 0;
 }
@@ -468,6 +482,8 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	if (!(em->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&em->list);
 	RB_CLEAR_NODE(&em->rb_node);
+
+	dec_evictable_extent_maps(inode);
 }
 
 static void replace_extent_mapping(struct btrfs_inode *inode,
@@ -486,7 +502,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->map);
 	RB_CLEAR_NODE(&cur->rb_node);
 
-	setup_extent_mapping(tree, new, modified);
+	setup_extent_mapping(inode, new, modified);
 }
 
 static struct extent_map *next_extent_map(const struct extent_map *em)
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 93f5c57ea4e3..534d30dafe32 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -630,6 +630,8 @@ struct btrfs_fs_info {
 	s32 dirty_metadata_batch;
 	s32 delalloc_batch;
 
+	struct percpu_counter evictable_extent_maps;
+
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
 
-- 
2.43.0


