Return-Path: <linux-btrfs+bounces-4303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5280A8A6BDB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DB3284EE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009712C48E;
	Tue, 16 Apr 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6HkFSmQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3612C485
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272898; cv=none; b=J7n5DuFa4koOdAPr7LLIkV3pMz7mth3UP88fk1VldGlG/jiazs1PwO7EPmXc6Nh+f+qPACxM9cagbheeEaECs92u5aXXwBuVP3U9/nymvUlKr7Bm5lAZRgbJXdFLGhiZiDlkWVCfaSjqAMYpaSnw8gzYwn++Z/wrjhLfNwZeH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272898; c=relaxed/simple;
	bh=D7WN/Nan/6C4UwT+O/48hCiAs3x475ZLUVYGG3graho=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Suo5hQBTXDZX02GDI1XYc6CpGV+lxssxvuQuGff4b/tH0SMrm/lmyYcIEHtFpI8zV8Zx3MrqzSDjHGJCOD0l/LVoMl5nM7+9008deZlJYhWq5gPDA9kYsxxwrpVrls5DpQtwjWJxktb+deNkkLiroekjU4BDsACB/jDE5ALJI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6HkFSmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84D3C113CE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713272898;
	bh=D7WN/Nan/6C4UwT+O/48hCiAs3x475ZLUVYGG3graho=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e6HkFSmQmlsycnBusshu8/VqaJRax5i/9ZObcr6OwFCZX1hxZ9RWMM44P5wD8G+ar
	 gpGtb0EX2m+op5M2fvvZaRV7NCd3FASK9p21JbaeUibbp37udaSRa1S37yx7ag1oOl
	 SBMhq+DC3JOYdp7l94PFFe9ShCYQkC9g+ossjh9Bj2hKCiJC+9UHMgTWMdYeAyRQLD
	 7BR36SrJN/iJZsKcFdHZfRwXfr77t48WBsvzWhgQCClc7epwXTWVTmsIXjXPc/FBXT
	 yXKRBaFXKvwUrzUJA1SCEg81ZHRCwweu0LWB3EQ0HNoFjO4pcBsJL/V5T6dtU/b7eX
	 0yZpJKipxn3pQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 03/10] btrfs: pass the extent map tree's inode to remove_extent_mapping()
Date: Tue, 16 Apr 2024 14:08:05 +0100
Message-Id: <10d9942cd5349cf6be9f31dbc9a447467df9edf9.1713267925.git.fdmanana@suse.com>
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

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
remove_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change remove_extent_mapping() to receive the inode instead of its
extent map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c              |  2 +-
 fs/btrfs/extent_map.c             | 22 +++++++++++++---------
 fs/btrfs/extent_map.h             |  2 +-
 fs/btrfs/tests/extent-map-tests.c | 19 ++++++++++---------
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 91122817f137..7b10f47d8f83 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2457,7 +2457,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 * hurts the fsync performance for workloads with a data
 			 * size that exceeds or is close to the system's memory).
 			 */
-			remove_extent_mapping(map, em);
+			remove_extent_mapping(btrfs_inode, em);
 			/* once for the rb tree */
 			free_extent_map(em);
 next:
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 7cda78d11d75..289669763965 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -449,16 +449,18 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 }
 
 /*
- * Remove an extent_map from the extent tree.
+ * Remove an extent_map from its inode's extent tree.
  *
- * @tree:	extent tree to remove from
+ * @inode:	the inode the extent map belongs to
  * @em:		extent map being removed
  *
- * Remove @em from @tree.  No reference counts are dropped, and no checks
- * are done to see if the range is in use.
+ * Remove @em from the extent tree of @inode.  No reference counts are dropped,
+ * and no checks are done to see if the range is in use.
  */
-void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
+void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
+
 	lockdep_assert_held_write(&tree->lock);
 
 	WARN_ON(em->flags & EXTENT_FLAG_PINNED);
@@ -633,8 +635,10 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
  * if needed. This avoids searching the tree, from the root down to the first
  * extent map, before each deletion.
  */
-static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
+static void drop_all_extent_maps_fast(struct btrfs_inode *inode)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
+
 	write_lock(&tree->lock);
 	while (!RB_EMPTY_ROOT(&tree->map.rb_root)) {
 		struct extent_map *em;
@@ -643,7 +647,7 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 		node = rb_first_cached(&tree->map);
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
-		remove_extent_mapping(tree, em);
+		remove_extent_mapping(inode, em);
 		free_extent_map(em);
 		cond_resched_rwlock_write(&tree->lock);
 	}
@@ -676,7 +680,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 	WARN_ON(end < start);
 	if (end == (u64)-1) {
 		if (start == 0 && !skip_pinned) {
-			drop_all_extent_maps_fast(em_tree);
+			drop_all_extent_maps_fast(inode);
 			return;
 		}
 		len = (u64)-1;
@@ -854,7 +858,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				ASSERT(!split);
 				btrfs_set_inode_full_sync(inode);
 			}
-			remove_extent_mapping(em_tree, em);
+			remove_extent_mapping(inode, em);
 		}
 
 		/*
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 732fc8d7e534..c3707461ff62 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -120,7 +120,7 @@ static inline u64 extent_map_end(const struct extent_map *em)
 void extent_map_tree_init(struct extent_map_tree *tree);
 struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
+void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em);
 int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 		     u64 new_logical);
 
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 9e9cb591c0f1..db6fb1a2c78f 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -11,8 +11,9 @@
 #include "../disk-io.h"
 #include "../block-group.h"
 
-static int free_extent_map_tree(struct extent_map_tree *em_tree)
+static int free_extent_map_tree(struct btrfs_inode *inode)
 {
+	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	struct rb_node *node;
 	int ret = 0;
@@ -21,7 +22,7 @@ static int free_extent_map_tree(struct extent_map_tree *em_tree)
 	while (!RB_EMPTY_ROOT(&em_tree->map.rb_root)) {
 		node = rb_first_cached(&em_tree->map);
 		em = rb_entry(node, struct extent_map, rb_node);
-		remove_extent_mapping(em_tree, em);
+		remove_extent_mapping(inode, em);
 
 #ifdef CONFIG_BTRFS_DEBUG
 		if (refcount_read(&em->refs) != 1) {
@@ -142,7 +143,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 	free_extent_map(em);
 out:
-	ret2 = free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
@@ -237,7 +238,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 	free_extent_map(em);
 out:
-	ret2 = free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
@@ -313,7 +314,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	}
 	free_extent_map(em);
 out:
-	ret2 = free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
@@ -435,7 +436,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	}
 	free_extent_map(em);
 out:
-	ret2 = free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
@@ -679,7 +680,7 @@ static int test_case_5(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	if (ret)
 		goto out;
 out:
-	ret2 = free_extent_map_tree(&inode->extent_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
@@ -738,7 +739,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	ret = 0;
 out:
 	free_extent_map(em);
-	ret2 = free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
@@ -871,7 +872,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	ret2 = unpin_extent_cache(inode, 0, SZ_16K, 0);
 	if (ret == 0)
 		ret = ret2;
-	ret2 = free_extent_map_tree(em_tree);
+	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
 
-- 
2.43.0


