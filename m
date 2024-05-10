Return-Path: <linux-btrfs+bounces-4903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF8E8C2959
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64319287B98
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFA433A8;
	Fri, 10 May 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKlnEiY/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2C3FB0F
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362390; cv=none; b=rfDQ/290Jw2BPhRmM/ybmnB9E3bv+3lh/lYRvFG+NKDh1+Ac0qFJTguTH5dUEuF+UAAXXyYzgOlT0ReV3cafHzhBJvjRSDwPUExE8iRoU17eTAWE23+410E/SBSEsxLLTQ6VfT8lsmkFV8hUaBd+or14nEv6l1BA2dPZOx9EqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362390; c=relaxed/simple;
	bh=wSAHi18F4gyv2RMO2cU9GHf0Qo+2IpEw3OlLiso/zVw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kavN3gs2orr7zhkoQKk8+tR8HnwaYMv+iazFqu9dYgJRdqQbwYA5910jlNhLV/ZCB4DuK/A/sPJNBHY1smTj87/bhAanO4YnGgSYZn9pO9GlLDdQgRADEK4iCOZkRX45XIUQLExTYeTMTlTnvV9G3bY6H3oPtsKv8PFMNfn/3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKlnEiY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB413C113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362390;
	bh=wSAHi18F4gyv2RMO2cU9GHf0Qo+2IpEw3OlLiso/zVw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XKlnEiY/YIBqM7amA/HnUg4xb4srDyjeEIwCc10B0BUc0hLbzLn2pRvgjsYVl76wc
	 FPLbQ3ePhIt6rbOHZWmBhF2Y+sNnxTL0FKJeugWfNAV+1zaY97nZu+GLYmH14wZeGe
	 z/uskc7NWyYJUX8B0+2sB20CRaS7Ixkzxdofn0Zlye4FjZRXY4hbxjBshGAMDgbpIZ
	 RPP0ojYOaNL1WqvP6fUEs67stjKkWSCl22rJHWBKQiQVLLIyELmjHFt+3KRxNZJuPn
	 py8j13jbBVm8aWg7swoRdnXwR90CNgyZ3iupi/fXodfyKFYmSBT9QcNY7tfYFRjCKq
	 zU5ogn6ULB/LQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/10] btrfs: rename rb_root member of extent_map_tree from map to root
Date: Fri, 10 May 2024 18:32:57 +0100
Message-Id: <8f500216e8bb4020acfa192c7f826cbda922d2a7.1715362104.git.fdmanana@suse.com>
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

Currently we name the rb_root member of struct extent_map_tree as 'map',
which is odd and confusing. Since it's a root node, rename it to 'root'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c             | 22 +++++++++++-----------
 fs/btrfs/extent_map.h             |  2 +-
 fs/btrfs/tests/extent-map-tests.c |  6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 744e8952abb0..4bc41b0dd701 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -33,7 +33,7 @@ void __cold extent_map_exit(void)
  */
 void extent_map_tree_init(struct extent_map_tree *tree)
 {
-	tree->map = RB_ROOT_CACHED;
+	tree->root = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&tree->modified_extents);
 	rwlock_init(&tree->lock);
 }
@@ -265,7 +265,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->generation = max(em->generation, merge->generation);
 			em->flags |= EXTENT_FLAG_MERGED;
 
-			rb_erase_cached(&merge->rb_node, &tree->map);
+			rb_erase_cached(&merge->rb_node, &tree->root);
 			RB_CLEAR_NODE(&merge->rb_node);
 			free_extent_map(merge);
 			dec_evictable_extent_maps(inode);
@@ -278,7 +278,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		em->block_len += merge->block_len;
-		rb_erase_cached(&merge->rb_node, &tree->map);
+		rb_erase_cached(&merge->rb_node, &tree->root);
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
@@ -389,7 +389,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 
 	lockdep_assert_held_write(&tree->lock);
 
-	ret = tree_insert(&tree->map, em);
+	ret = tree_insert(&tree->root, em);
 	if (ret)
 		return ret;
 
@@ -410,7 +410,7 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
 	struct rb_node *prev_or_next = NULL;
 	u64 end = range_end(start, len);
 
-	rb_node = __tree_search(&tree->map.rb_root, start, &prev_or_next);
+	rb_node = __tree_search(&tree->root.rb_root, start, &prev_or_next);
 	if (!rb_node) {
 		if (prev_or_next)
 			rb_node = prev_or_next;
@@ -479,7 +479,7 @@ void remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *em)
 	lockdep_assert_held_write(&tree->lock);
 
 	WARN_ON(em->flags & EXTENT_FLAG_PINNED);
-	rb_erase_cached(&em->rb_node, &tree->map);
+	rb_erase_cached(&em->rb_node, &tree->root);
 	if (!(em->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&em->list);
 	RB_CLEAR_NODE(&em->rb_node);
@@ -500,7 +500,7 @@ static void replace_extent_mapping(struct btrfs_inode *inode,
 	ASSERT(extent_map_in_tree(cur));
 	if (!(cur->flags & EXTENT_FLAG_LOGGING))
 		list_del_init(&cur->list);
-	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->map);
+	rb_replace_node_cached(&cur->rb_node, &new->rb_node, &tree->root);
 	RB_CLEAR_NODE(&cur->rb_node);
 
 	setup_extent_mapping(inode, new, modified);
@@ -659,11 +659,11 @@ static void drop_all_extent_maps_fast(struct btrfs_inode *inode)
 	struct extent_map_tree *tree = &inode->extent_tree;
 
 	write_lock(&tree->lock);
-	while (!RB_EMPTY_ROOT(&tree->map.rb_root)) {
+	while (!RB_EMPTY_ROOT(&tree->root.rb_root)) {
 		struct extent_map *em;
 		struct rb_node *node;
 
-		node = rb_first_cached(&tree->map);
+		node = rb_first_cached(&tree->root);
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		remove_extent_mapping(inode, em);
@@ -1058,7 +1058,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 		return 0;
 
 	write_lock(&tree->lock);
-	node = rb_first_cached(&tree->map);
+	node = rb_first_cached(&tree->root);
 	while (node) {
 		struct extent_map *em;
 
@@ -1094,7 +1094,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 		 * lock and took it again.
 		 */
 		if (cond_resched_rwlock_write(&tree->lock))
-			node = rb_first_cached(&tree->map);
+			node = rb_first_cached(&tree->root);
 	}
 	write_unlock(&tree->lock);
 	up_read(&inode->i_mmap_lock);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 6d587111f73a..9c0793888d13 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -115,7 +115,7 @@ struct extent_map {
 };
 
 struct extent_map_tree {
-	struct rb_root_cached map;
+	struct rb_root_cached root;
 	struct list_head modified_extents;
 	rwlock_t lock;
 };
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index ba36794ba2d5..075e6930acda 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -19,8 +19,8 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 	int ret = 0;
 
 	write_lock(&em_tree->lock);
-	while (!RB_EMPTY_ROOT(&em_tree->map.rb_root)) {
-		node = rb_first_cached(&em_tree->map);
+	while (!RB_EMPTY_ROOT(&em_tree->root.rb_root)) {
+		node = rb_first_cached(&em_tree->root);
 		em = rb_entry(node, struct extent_map, rb_node);
 		remove_extent_mapping(inode, em);
 
@@ -551,7 +551,7 @@ static int validate_range(struct extent_map_tree *em_tree, int index)
 	struct rb_node *n;
 	int i;
 
-	for (i = 0, n = rb_first_cached(&em_tree->map);
+	for (i = 0, n = rb_first_cached(&em_tree->root);
 	     valid_ranges[index][i].len && n;
 	     i++, n = rb_next(n)) {
 		struct extent_map *entry = rb_entry(n, struct extent_map, rb_node);
-- 
2.43.0


