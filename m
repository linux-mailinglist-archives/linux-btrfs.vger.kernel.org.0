Return-Path: <linux-btrfs+bounces-4904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDF8C295A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6261FB25775
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60EA43ADE;
	Fri, 10 May 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEirSpRo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225A433C5
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362392; cv=none; b=Sdia/dxiBuVKC6jwpdjJKtpTGmFo0daGV0M2JaEA7YHr0DvoGtcsXXKY+PuqrRUWDn4QT+6tkCpk7tJymATEoDUIHOA8/S85J9Wg7o+1owAZnxY2jahTvk5biXFJBqjtH+l8Nj1i2NzfRBY2E/4F2kvJ61zKAHXpvbXQDODrtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362392; c=relaxed/simple;
	bh=vaPaq+O4thdTC1ajFjlDnKocjqbxYvqsdgtPuP9AA1o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcIKd0/WLDahJwT/NvluOQ85B5AiZhWLSmDVyoAzBpEoC96gTpy012QuyAChObTHG9+duMNm8gKjjdnohRkrm3L498wGf15QETK1evIaMpjOU1mDnqd+3oPMoiKWVRYCZrBzewsqYSDe7Tl+gc4zLC1X5mYbc8r9U1/x0XdiIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEirSpRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A8CC2BBFC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362391;
	bh=vaPaq+O4thdTC1ajFjlDnKocjqbxYvqsdgtPuP9AA1o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HEirSpRoDluifISwf5np4S4fRDajW6IogzKqDiF8p53I+V5H+SNV7k/7rHJTRyTop
	 aCNxpBJTJamYWLGk38OgNOWZxqzGVZ70h6YGyoUUMYMjv5X2M4GofrL9JVG3jL5Xwv
	 AB+7N+iatetb7b8a0zW/SwIiyEytbNDfXwtjeKbKxbaPcKI1FRbJRssT6bXH7Eej31
	 1GOhOeMkk1AlyeU3sFR88ImyfFAF8Ah2uRi9/t8sMcNxNU/dq8ZRJnxkRrnlvKClTj
	 krK0EXP3kZSdNZpWUh/q49Rxy65Qzjrj6lCDtV82L/xqLwUSAVq6uTzCzZaU5xFp7G
	 xmkIapQk+5dpQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/10] btrfs: use a regular rb_root instead of cached rb_root for extent_map_tree
Date: Fri, 10 May 2024 18:32:58 +0100
Message-Id: <37b63a8da723a934b72c5fe00b49922fcec5f5c7.1715362104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715362104.git.fdmanana@suse.com>
References: <cover.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are currently using a cached rb_root (struct rb_root_cached) for the
rb root of struct extent_map_tree. This does't offer much of an advantage
here because:

1) It's only advantage over the regular rb_root is that it caches a
   pointer to the left most node (first node), so a call to
   rb_first_cached() doesn't have to chase pointers until it reaches
   the left most node;

2) We only have two scenarios that access left most node with
   rb_first_cached():

      When dropping all extent maps from an inode, during inode eviction;

      When iterating over extent maps during the extent map shrinker;

3) In both cases we keep removing extent maps, which causes deletion of
   the left most node so rb_erase_cached() has to call rb_next() to find
   out what's the next left most node and assign it to
   struct rb_root_cached::rb_leftmost;

4) We can do that ourselves in those two uses cases and stop using a
   rb_root_cached rb tree and use instead a regular rb_root rb tree.

   This reduces the size of struct extent_map_tree by 8 bytes and, since
   this structure is embedded in struct btrfs_inode, it also reduces the
   size of that structure by 8 bytes.

   So on a 64 bits platform the size of btrfs_inode is reduced from 1032
   bytes down to 1024 bytes.

   This means we will be able to have 4 inodes per 4K page instead of 3.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c             | 48 +++++++++++++++++--------------
 fs/btrfs/extent_map.h             |  2 +-
 fs/btrfs/tests/extent-map-tests.c |  6 ++--
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 4bc41b0dd701..35e163152dbc 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -33,7 +33,7 @@ void __cold extent_map_exit(void)
  */
 void extent_map_tree_init(struct extent_map_tree *tree)
 {
-	tree->root = RB_ROOT_CACHED;
+	tree->root = RB_ROOT;
 	INIT_LIST_HEAD(&tree->modified_extents);
 	rwlock_init(&tree->lock);
 }
@@ -85,27 +85,24 @@ static void dec_evictable_extent_maps(struct btrfs_inode *inode)
 		percpu_counter_dec(&fs_info->evictable_extent_maps);
 }
 
-static int tree_insert(struct rb_root_cached *root, struct extent_map *em)
+static int tree_insert(struct rb_root *root, struct extent_map *em)
 {
-	struct rb_node **p = &root->rb_root.rb_node;
+	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	struct extent_map *entry = NULL;
 	struct rb_node *orig_parent = NULL;
 	u64 end = range_end(em->start, em->len);
-	bool leftmost = true;
 
 	while (*p) {
 		parent = *p;
 		entry = rb_entry(parent, struct extent_map, rb_node);
 
-		if (em->start < entry->start) {
+		if (em->start < entry->start)
 			p = &(*p)->rb_left;
-		} else if (em->start >= extent_map_end(entry)) {
+		else if (em->start >= extent_map_end(entry))
 			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
+		else
 			return -EEXIST;
-		}
 	}
 
 	orig_parent = parent;
@@ -128,7 +125,7 @@ static int tree_insert(struct rb_root_cached *root, struct extent_map *em)
 			return -EEXIST;
 
 	rb_link_node(&em->rb_node, orig_parent, p);
-	rb_insert_color_cached(&em->rb_node, root, leftmost);
+	rb_insert_color(&em->rb_node, root);
 	return 0;
 }
 
@@ -265,7 +262,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->generation = max(em->generation, merge->generation);
 			em->flags |= EXTENT_FLAG_MERGED;
 
-			rb_erase_cached(&merge->rb_node, &tree->root);
+			rb_erase(&merge->rb_node, &tree->root);
 			RB_CLEAR_NODE(&merge->rb_node);
 			free_extent_map(merge);
 			dec_evictable_extent_maps(inode);
@@ -278,7 +275,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
-		rb_erase_cached(&merge->rb_node, &tree->root);
+		rb_erase(&merge->rb_node, &tree->root);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
@@ -410,7 +407,7 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
 	struct rb_node *prev_or_next = NULL;
 	u64 end = range_end(start, len);
 
-	rb_node = __tree_search(&tree->root.rb_root, start, &prev_or_next);
+	rb_node = __tree_search(&tree->root, start, &prev_or_next);
 	if (!rb_node) {
 		if (prev_or_next)
 			rb_node = prev_or_next;
@@ -479,7 +476,7 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	lockdep_assert_held_write(&tree->lock);
 
 	WARN_ON(em->flags & EXTENT_FLAG_PINNED);
-	rb_erase_cached(&em->rb_node, &tree->root);
+	rb_erase(&em->rb_node, &tree->root);
 	if (!(em->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&em->list);
 	RB_CLEAR_NODE(&em->rb_node);
@@ -500,7 +497,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 	ASSERT(extent_map_in_tree(cur));
 	if (!(cur->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&cur->list);
-	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->root);
+	rb_replace_node(&cur->rb_node, &new->rb_node, &tree->root);
 	RB_CLEAR_NODE(&cur->rb_node);
 
 	setup_extent_mapping(inode, new, modified);
@@ -657,18 +654,23 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 static void drop_all_extent_maps_fast(struct btrfs_inode *inode)
 {
 	struct extent_map_tree *tree = &inode->extent_tree;
+	struct rb_node *node;
 
 	write_lock(&tree->lock);
-	while (!RB_EMPTY_ROOT(&tree->root.rb_root)) {
+	node = rb_first(&tree->root);
+	while (node) {
 		struct extent_map *em;
-		struct rb_node *node;
+		struct rb_node *next = rb_next(node);
 
-		node = rb_first_cached(&tree->root);
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		remove_extent_mapping(inode, em);
 		free_extent_map(em);
-		cond_resched_rwlock_write(&tree->lock);
+
+		if (cond_resched_rwlock_write(&tree->lock))
+			node = rb_first(&tree->root);
+		else
+			node = next;
 	}
 	write_unlock(&tree->lock);
 }
@@ -1058,12 +1060,12 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 		return 0;
 
 	write_lock(&tree->lock);
-	node = rb_first_cached(&tree->root);
+	node = rb_first(&tree->root);
 	while (node) {
+		struct rb_node *next = rb_next(node);
 		struct extent_map *em;
 
 		em = rb_entry(node, struct extent_map, rb_node);
-		node = rb_next(node);
 		(*scanned)++;
 
 		if (em->flags & EXTENT_FLAG_PINNED)
@@ -1094,7 +1096,9 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 		 * lock and took it again.
 		 */
 		if (cond_resched_rwlock_write(&tree->lock))
-			node = rb_first_cached(&tree->root);
+			node = rb_first(&tree->root);
+		else
+			node = next;
 	}
 	write_unlock(&tree->lock);
 	up_read(&inode->i_mmap_lock);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 9c0793888d13..9144721b88a5 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -115,7 +115,7 @@ struct extent_map {
 };
 
 struct extent_map_tree {
-	struct rb_root_cached root;
+	struct rb_root root;
 	struct list_head modified_extents;
 	rwlock_t lock;
 };
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 075e6930acda..c511a1297956 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -19,8 +19,8 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 	int ret = 0;
 
 	write_lock(&em_tree->lock);
-	while (!RB_EMPTY_ROOT(&em_tree->root.rb_root)) {
-		node = rb_first_cached(&em_tree->root);
+	while (!RB_EMPTY_ROOT(&em_tree->root)) {
+		node = rb_first(&em_tree->root);
 		em = rb_entry(node, struct extent_map, rb_node);
 		remove_extent_mapping(inode, em);
 
@@ -551,7 +551,7 @@ static int validate_range(struct extent_map_tree *em_tree, int index)
 	struct rb_node *n;
 	int i;
 
-	for (i = 0, n = rb_first_cached(&em_tree->root);
+	for (i = 0, n = rb_first(&em_tree->root);
 	     valid_ranges[index][i].len && n;
 	     i++, n = rb_next(n)) {
 		struct extent_map *entry = rb_entry(n, struct extent_map, rb_node);
-- 
2.43.0


