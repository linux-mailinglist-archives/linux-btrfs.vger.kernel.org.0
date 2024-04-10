Return-Path: <linux-btrfs+bounces-4104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E089F0DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB9B1C20ABC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AA15ECC6;
	Wed, 10 Apr 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snyU7jui"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480A15E811
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748533; cv=none; b=W+tWeRy0wHmIfMNBk2ooYbKjpqg0oeEp6xTNMWYrDkcpuwkoLnXibJyzAbiHvww46MTEuWCYnlbxuaLvXiYBczCsV81vVyWovfAivY867tQg0IKnle61D4pTC4VXQaTeMQf9bWDbX9lGxEVsLrOjCzIlpDoaCZsYpvVyhgjbdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748533; c=relaxed/simple;
	bh=UVWYw3W3rDJm0/srJaDKzeRQOjrXVoWlqIdhZKi3XHg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWfbUMUyI0kz/YZV/227bhcVuHaEuEEFDzgZ/8Dv7JPHQcISHBgfH/MEud3wbQ80O+hwZ/aqGY1tlyUpSso7dYUgpqVlqJvBaPGvzWmCo91SbGx02DUop+3EqvdENPBd+OXtY82hc1lHcI3VNO6MX6AqET9oDNjYZWsVHBy8QV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snyU7jui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AE7C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748533;
	bh=UVWYw3W3rDJm0/srJaDKzeRQOjrXVoWlqIdhZKi3XHg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=snyU7juiLXbGPNdAM5uNZfvqZDcBmLuldmB0l40JUuQBRUVvY08xXGxgTUMzcdacB
	 plBQDBSUppdqXS6B4WK1tZZBLf0NAtvIUayfRXksGPClRDjPu9e5SHKX4ZiMw0Xlpm
	 qs6qKhkTbuV6mBs8v+fQ74iPrDuBdEmWgD23bB3LGBgIq85EIvYOjZEykgfT+M8ETA
	 hK1hRQd+07C1lqrr1UhgTaA8zIP4qYsJoD0PQZXIJ3mpBY5AeQ6ycpalP9Cz+RBuCm
	 zuZBmu+r3sfI2I9MVvKfBxvRGdP+S4XYyXUMyLBL5qx3/emFEfHtLzugVd0w9538+p
	 ZXWOi/9oxjVpA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: pass the extent map tree's inode to remove_extent_mapping()
Date: Wed, 10 Apr 2024 12:28:38 +0100
Message-Id: <43e4e4a75ef530348f4bb1fa65614f6d2df9c757.1712748143.git.fdmanana@suse.com>
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

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
remove_extent_mapping().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change remove_extent_mapping() to receive the inode instead of its
extent map tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c              |  2 +-
 fs/btrfs/extent_map.c             | 22 +++++++++++++---------
 fs/btrfs/extent_map.h             |  2 +-
 fs/btrfs/tests/extent-map-tests.c | 19 ++++++++++---------
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d90330f26827..1b236fc3f411 100644
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


