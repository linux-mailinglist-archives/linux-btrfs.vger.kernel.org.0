Return-Path: <linux-btrfs+bounces-4307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AE8A6BDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5E11F22668
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138F12C554;
	Tue, 16 Apr 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZo/LGfq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10812C53B
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272902; cv=none; b=NoVZSHMU/p7f25a5cqe24UgT8go7m6jlvOSGpTpSD0I7jvIseIg6Vi7WEmWjyheohxUgJsDmRYMF7dEaHnouNrVJ+qOQYkqtG+9i7cALE0MXFFIv6+hRkTsq1PRuydEqANIhZOplRYiSEk8zie0Fzk8yESmd8B3E5Z7Chc+GrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272902; c=relaxed/simple;
	bh=FyNoDu4578Eve0es0Is8E3lhvf6VxzRe7XHvR7LD2Z0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuhRkEMgD8Ipf5nRLNJd64Bc6LxbtLFYSZ7UtGfIODsqIL5TQSnaQ5FnI+u4Idgb5wBTUuxr5pU6uFHyormb/1h5F1a6NMkvxBwnHgG89dCqMJ3xkk3ZLcYpRdlbGr0GKsYdoi23B2pT8oS6medHWZnBhUgKSl6vIWosBEpxNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZo/LGfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453CC32783
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272902;
	bh=FyNoDu4578Eve0es0Is8E3lhvf6VxzRe7XHvR7LD2Z0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QZo/LGfqeJHFnkjkHWPEh9JzkoNSvt0bv05purjGQ//DJ1q3yPJPu/izhO8ym/JTi
	 CtBt3er/TiNyM0UNOu7w7ghgv9vBxxoFhIuw8oTXl1D+FWP3/0rItAO2HbwgIt1Avs
	 HSOB4v4/C3y3sOySAmwNENA+jplOpoQB/2VjICk28mtWmzzcpMl0Q6ow8preTnnG3t
	 zLNKiDdCPTkhXv15d/qy50RIsUHEeFNV/Z7hlGdtjTyquJEiEppqWeduV1RE+mrj6I
	 0QJj1xZIp6mv8ZHJU8C2IcMgnpdTf21DPOTqVd0WyEvm+a7brRJaiorj8Fu3bGWvkb
	 Iwv+r58EgVjTA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 07/10] btrfs: add a global per cpu counter to track number of used extent maps
Date: Tue, 16 Apr 2024 14:08:09 +0100
Message-Id: <5148d35a4b3dac4e02f963e59f2154c56edaae29.1713267925.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713267925.git.fdmanana@suse.com>
References: <cover.1713267925.git.fdmanana@suse.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c    |  9 +++++++++
 fs/btrfs/extent_map.c | 17 +++++++++++++++++
 fs/btrfs/fs.h         |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0474e9b6d302..bc9d1b48011e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1266,9 +1266,14 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;
+
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
+	if (percpu_counter_initialized(em_counter))
+		ASSERT(percpu_counter_sum_positive(em_counter) == 0);
+	percpu_counter_destroy(em_counter);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
@@ -2848,6 +2853,10 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
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
index 97a8e0484415..2fcf28148a81 100644
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
@@ -259,6 +267,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
 			free_extent_map(merge);
+			dec_evictable_extent_maps(inode);
 		}
 	}
 
@@ -273,6 +282,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
 		free_extent_map(merge);
+		dec_evictable_extent_maps(inode);
 	}
 }
 
@@ -372,6 +382,8 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 			      struct extent_map *em, int modified)
 {
 	struct extent_map_tree *tree = &inode->extent_tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
 	lockdep_assert_held_write(&tree->lock);
@@ -382,6 +394,9 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 
 	setup_extent_mapping(inode, em, modified);
 
+	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
+		percpu_counter_inc(&fs_info->evictable_extent_maps);
+
 	return 0;
 }
 
@@ -467,6 +482,8 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	if (!(em->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&em->list);
 	RB_CLEAR_NODE(&em->rb_node);
+
+	dec_evictable_extent_maps(inode);
 }
 
 static void replace_extent_mapping(struct btrfs_inode *inode,
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


