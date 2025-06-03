Return-Path: <linux-btrfs+bounces-14414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0128ACC9A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F2A3A58A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4774023C4E3;
	Tue,  3 Jun 2025 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELeJvyEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB223BF83
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962236; cv=none; b=J5XMcl3FeGPJ1Tv693KaIQ4uDaCqUEbTGgYrWqbvbDEzzQUeDmK5Ou+snYiz1wPQ0Bopc8Vzq15qVQ81uDJofCh6M2YHegCu0dGQKKp9C0TWKZhc5YdrXTVBaJHEVUJTl2wQBM/KIXuZfvTKOqGT20I6RlS2Hrsi8iNYrzZKg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962236; c=relaxed/simple;
	bh=K0vlJheGfMPjKpQJOhvwFy/I74GW6aSIZivyzqLvMY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udEPHHOGefZkE17fviwqb3BH8mcFgWNlpTJLvzaLiYof+g+cX5GSQMSGM0oaGkbGHgtPjRpxaTBdKnOR+97SHfNqjkZLF3YqQJi+wclSXZcqU6Nipf9EzCkg3AEEJEbQKiogMJSdp2blgrIGVYssqSVmvapYyKRlTon15wp+zoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELeJvyEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEB5C4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962235;
	bh=K0vlJheGfMPjKpQJOhvwFy/I74GW6aSIZivyzqLvMY8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ELeJvyEBBwQzvb+zbS8OgTy0xZoTVV0lVRhvkPXS2Rwg08zLAH4yU6Br122kujJMS
	 neEdfQ7aOlC22yUi6cgiZ340ox9yJCDgxjC5ogJmIRs3q8T8Tjj4xY6QN9zCRydhdS
	 J4LntJ7DLD1i5WRTO70xyJhkXXcplDjKC8T8+ewMpuw5J0mDFShpaH6X9uQerpEHcC
	 y1CfLEO7BYP9gOkgBu55q1akvkviENGIVxH/Y4lmPZhUHnqlebpL/PJAtOiSKwMEiX
	 egDs5LIEBjUY7F4WsZwq1AfypznrmS7oPOc7e9TgSShK2RrsLFtUJUnEw/L1QFgTug
	 wmKtfqkZkcyMw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use refcount_t type for the extent buffer reference counter
Date: Tue,  3 Jun 2025 15:50:27 +0100
Message-ID: <16aba0aee59de1d8aed25486df34491c605e3b33.1748962110.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748962110.git.fdmanana@suse.com>
References: <cover.1748962110.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using a bare atomic, use the refcount_t type, which despite
being a structure that contains only an atomic, has an API that checks
for underflows and other hazards. This doesn't change the size of the
extent_buffer structure.

This removes the need to do things like this:

    WARN_ON(atomic_read(&eb->refs) == 0);
    if (atomic_dec_and_test(&eb->refs)) {
        (...)
    }

And do just:

    if (refcount_dec_and_test(&eb->refs)) {
        (...)
    }

Since refcount_dec_and_test() already triggers a warning when we decrement
a ref count that has a value of 0 (or below zero).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c             | 14 +++++------
 fs/btrfs/extent-tree.c       |  2 +-
 fs/btrfs/extent_io.c         | 45 ++++++++++++++++++------------------
 fs/btrfs/extent_io.h         |  2 +-
 fs/btrfs/fiemap.c            |  2 +-
 fs/btrfs/print-tree.c        |  2 +-
 fs/btrfs/qgroup.c            |  6 ++---
 fs/btrfs/relocation.c        |  4 ++--
 fs/btrfs/tree-log.c          |  4 ++--
 fs/btrfs/zoned.c             |  2 +-
 include/trace/events/btrfs.h |  2 +-
 11 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 94c4ed1b99d0..1b36ee2d8044 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -198,7 +198,7 @@ struct extent_buffer *btrfs_root_node(struct btrfs_root *root)
 		 * the inc_not_zero dance and if it doesn't work then
 		 * synchronize_rcu and try again.
 		 */
-		if (atomic_inc_not_zero(&eb->refs)) {
+		if (refcount_inc_not_zero(&eb->refs)) {
 			rcu_read_unlock();
 			break;
 		}
@@ -560,7 +560,7 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 			btrfs_abort_transaction(trans, ret);
 			goto error_unlock_cow;
 		}
-		atomic_inc(&cow->refs);
+		refcount_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
 		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
@@ -1092,7 +1092,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	/* update the path */
 	if (left) {
 		if (btrfs_header_nritems(left) > orig_slot) {
-			atomic_inc(&left->refs);
+			refcount_inc(&left->refs);
 			/* left was locked after cow */
 			path->nodes[level] = left;
 			path->slots[level + 1] -= 1;
@@ -1696,7 +1696,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 
 	if (p->search_commit_root) {
 		b = root->commit_root;
-		atomic_inc(&b->refs);
+		refcount_inc(&b->refs);
 		level = btrfs_header_level(b);
 		/*
 		 * Ensure that all callers have set skip_locking when
@@ -2894,7 +2894,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	free_extent_buffer(old);
 
 	add_root_to_dirty_list(root);
-	atomic_inc(&c->refs);
+	refcount_inc(&c->refs);
 	path->nodes[level] = c;
 	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
@@ -4451,7 +4451,7 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 
 	root_sub_used_bytes(root);
 
-	atomic_inc(&leaf->refs);
+	refcount_inc(&leaf->refs);
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
 	if (ret < 0)
@@ -4536,7 +4536,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			 * for possible call to btrfs_del_ptr below
 			 */
 			slot = path->slots[1];
-			atomic_inc(&leaf->refs);
+			refcount_inc(&leaf->refs);
 			/*
 			 * We want to be able to at least push one item to the
 			 * left neighbour leaf, and that's the first item.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2c122f9f8280..46d4963a8241 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6348,7 +6348,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 
 	btrfs_assert_tree_write_locked(parent);
 	parent_level = btrfs_header_level(parent);
-	atomic_inc(&parent->refs);
+	refcount_inc(&parent->refs);
 	path->nodes[parent_level] = parent;
 	path->slots[parent_level] = btrfs_header_nritems(parent);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 022c67c01689..ec1333dea064 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -77,7 +77,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 				      struct extent_buffer, leak_list);
 		pr_err(
 	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
-		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
+		       eb->start, eb->len, refcount_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
 		WARN_ON_ONCE(1);
@@ -1961,7 +1961,7 @@ static inline struct extent_buffer *find_get_eb(struct xa_state *xas, unsigned l
 	if (!eb)
 		return NULL;
 
-	if (!atomic_inc_not_zero(&eb->refs)) {
+	if (!refcount_inc_not_zero(&eb->refs)) {
 		xas_reset(xas);
 		goto retry;
 	}
@@ -2012,7 +2012,7 @@ static struct extent_buffer *find_extent_buffer_nolock(
 
 	rcu_read_lock();
 	eb = xa_load(&fs_info->buffer_tree, index);
-	if (eb && !atomic_inc_not_zero(&eb->refs))
+	if (eb && !refcount_inc_not_zero(&eb->refs))
 		eb = NULL;
 	rcu_read_unlock();
 	return eb;
@@ -2842,7 +2842,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
 	btrfs_leak_debug_add_eb(eb);
 
 	spin_lock_init(&eb->refs_lock);
-	atomic_set(&eb->refs, 1);
+	refcount_set(&eb->refs, 1);
 
 	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
 
@@ -2975,13 +2975,13 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 	 * once io is initiated, TREE_REF can no longer be cleared, so that is
 	 * the moment at which any such race is best fixed.
 	 */
-	refs = atomic_read(&eb->refs);
+	refs = refcount_read(&eb->refs);
 	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
 		return;
 
 	spin_lock(&eb->refs_lock);
 	if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_inc(&eb->refs);
+		refcount_inc(&eb->refs);
 	spin_unlock(&eb->refs_lock);
 }
 
@@ -3047,7 +3047,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(ret);
 	}
 	if (exists) {
-		if (!atomic_inc_not_zero(&exists->refs)) {
+		if (!refcount_inc_not_zero(&exists->refs)) {
 			/* The extent buffer is being freed, retry. */
 			xa_unlock_irq(&fs_info->buffer_tree);
 			goto again;
@@ -3092,7 +3092,7 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * just overwrite folio private.
 	 */
 	exists = folio_get_private(folio);
-	if (atomic_inc_not_zero(&exists->refs))
+	if (refcount_inc_not_zero(&exists->refs))
 		return exists;
 
 	WARN_ON(folio_test_dirty(folio));
@@ -3363,7 +3363,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 	if (existing_eb) {
-		if (!atomic_inc_not_zero(&existing_eb->refs)) {
+		if (!refcount_inc_not_zero(&existing_eb->refs)) {
 			xa_unlock_irq(&fs_info->buffer_tree);
 			goto again;
 		}
@@ -3392,7 +3392,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 
 out:
-	WARN_ON(!atomic_dec_and_test(&eb->refs));
+	WARN_ON(!refcount_dec_and_test(&eb->refs));
 
 	/*
 	 * Any attached folios need to be detached before we unlock them.  This
@@ -3438,8 +3438,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 {
 	lockdep_assert_held(&eb->refs_lock);
 
-	WARN_ON(atomic_read(&eb->refs) == 0);
-	if (atomic_dec_and_test(&eb->refs)) {
+	if (refcount_dec_and_test(&eb->refs)) {
 		struct btrfs_fs_info *fs_info = eb->fs_info;
 
 		spin_unlock(&eb->refs_lock);
@@ -3485,7 +3484,7 @@ void free_extent_buffer(struct extent_buffer *eb)
 	if (!eb)
 		return;
 
-	refs = atomic_read(&eb->refs);
+	refs = refcount_read(&eb->refs);
 	while (1) {
 		if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
 			if (refs == 1)
@@ -3495,16 +3494,16 @@ void free_extent_buffer(struct extent_buffer *eb)
 		}
 
 		/* Optimization to avoid locking eb->refs_lock. */
-		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
+		if (atomic_try_cmpxchg(&eb->refs.refs, &refs, refs - 1))
 			return;
 	}
 
 	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) == 2 &&
+	if (refcount_read(&eb->refs) == 2 &&
 	    test_bit(EXTENT_BUFFER_STALE, &eb->bflags) &&
 	    !extent_buffer_under_io(eb) &&
 	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
+		refcount_dec(&eb->refs);
 
 	/*
 	 * I know this is terrible, but it's temporary until we stop tracking
@@ -3521,9 +3520,9 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	spin_lock(&eb->refs_lock);
 	set_bit(EXTENT_BUFFER_STALE, &eb->bflags);
 
-	if (atomic_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
+	if (refcount_read(&eb->refs) == 2 && !extent_buffer_under_io(eb) &&
 	    test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
-		atomic_dec(&eb->refs);
+		refcount_dec(&eb->refs);
 	release_extent_buffer(eb);
 }
 
@@ -3581,7 +3580,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			btree_clear_folio_dirty_tag(folio);
 		folio_unlock(folio);
 	}
-	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(refcount_read(&eb->refs) == 0);
 }
 
 void set_extent_buffer_dirty(struct extent_buffer *eb)
@@ -3592,7 +3591,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 
 	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
 
-	WARN_ON(atomic_read(&eb->refs) == 0);
+	WARN_ON(refcount_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
@@ -3718,7 +3717,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
-	atomic_inc(&eb->refs);
+	refcount_inc(&eb->refs);
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_READ | REQ_META, eb->fs_info,
@@ -4313,7 +4312,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * won't disappear out from under us.
 		 */
 		spin_lock(&eb->refs_lock);
-		if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 			spin_unlock(&eb->refs_lock);
 			continue;
 		}
@@ -4379,7 +4378,7 @@ int try_release_extent_buffer(struct folio *folio)
 	 * this page.
 	 */
 	spin_lock(&eb->refs_lock);
-	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+	if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
 		spin_unlock(&eb->refs_lock);
 		spin_unlock(&folio->mapping->i_private_lock);
 		return 0;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e36e8d6a00bc..65bb87f1dce6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -98,7 +98,7 @@ struct extent_buffer {
 	void *addr;
 
 	spinlock_t refs_lock;
-	atomic_t refs;
+	refcount_t refs;
 	int read_mirror;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index 43bf0979fd53..7935586a9dbd 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -320,7 +320,7 @@ static int fiemap_next_leaf_item(struct btrfs_inode *inode, struct btrfs_path *p
 	 * the cost of allocating a new one.
 	 */
 	ASSERT(test_bit(EXTENT_BUFFER_UNMAPPED, &clone->bflags));
-	atomic_inc(&clone->refs);
+	refcount_inc(&clone->refs);
 
 	ret = btrfs_next_leaf(inode->root, path);
 	if (ret != 0)
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index fc821aa446f0..21605b03f511 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -223,7 +223,7 @@ static void print_eb_refs_lock(const struct extent_buffer *eb)
 {
 #ifdef CONFIG_BTRFS_DEBUG
 	btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
-		   atomic_read(&eb->refs), eb->lock_owner, current->pid);
+		   refcount_read(&eb->refs), eb->lock_owner, current->pid);
 #endif
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 90685812ee56..a1afc549c404 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2338,7 +2338,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 		btrfs_item_key_to_cpu(dst_path->nodes[dst_level], &key, 0);
 
 	/* For src_path */
-	atomic_inc(&src_eb->refs);
+	refcount_inc(&src_eb->refs);
 	src_path->nodes[root_level] = src_eb;
 	src_path->slots[root_level] = dst_path->slots[root_level];
 	src_path->locks[root_level] = 0;
@@ -2571,7 +2571,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	/* For dst_path */
-	atomic_inc(&dst_eb->refs);
+	refcount_inc(&dst_eb->refs);
 	dst_path->nodes[level] = dst_eb;
 	dst_path->slots[level] = 0;
 	dst_path->locks[level] = 0;
@@ -2663,7 +2663,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	 * walk back up the tree (adjusting slot pointers as we go)
 	 * and restart the search process.
 	 */
-	atomic_inc(&root_eb->refs);	/* For path */
+	refcount_inc(&root_eb->refs);	/* For path */
 	path->nodes[root_level] = root_eb;
 	path->slots[root_level] = 0;
 	path->locks[root_level] = 0; /* so release_path doesn't try to unlock */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0b73f58db33f..d7ec1d72821c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1524,7 +1524,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_root_level(root_item);
-		atomic_inc(&reloc_root->node->refs);
+		refcount_inc(&reloc_root->node->refs);
 		path->nodes[level] = reloc_root->node;
 		path->slots[level] = 0;
 	} else {
@@ -4347,7 +4347,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_backref_drop_node_buffer(node);
-		atomic_inc(&cow->refs);
+		refcount_inc(&cow->refs);
 		node->eb = cow;
 		node->new_bytenr = cow->start;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4e6a054682e3..34ed9b2b1b83 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2719,7 +2719,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 	level = btrfs_header_level(log->node);
 	orig_level = level;
 	path->nodes[level] = log->node;
-	atomic_inc(&log->node->refs);
+	refcount_inc(&log->node->refs);
 	path->slots[level] = 0;
 
 	while (1) {
@@ -3683,7 +3683,7 @@ static int clone_leaf(struct btrfs_path *path, struct btrfs_log_ctx *ctx)
 	 * Add extra ref to scratch eb so that it is not freed when callers
 	 * release the path, so we can reuse it later if needed.
 	 */
-	atomic_inc(&ctx->scratch_eb->refs);
+	refcount_inc(&ctx->scratch_eb->refs);
 
 	return 0;
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 19710634d63f..d416df1e0d2c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2427,7 +2427,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 
 	/* For the work */
 	btrfs_get_block_group(bg);
-	atomic_inc(&eb->refs);
+	refcount_inc(&eb->refs);
 	bg->last_eb = eb;
 	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
 	queue_work(system_unbound_wq, &bg->zone_finish_work);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index bebc252db865..a32305044371 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1095,7 +1095,7 @@ TRACE_EVENT(btrfs_cow_block,
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->root_objectid	= btrfs_root_id(root);
 		__entry->buf_start	= buf->start;
-		__entry->refs		= atomic_read(&buf->refs);
+		__entry->refs		= refcount_read(&buf->refs);
 		__entry->cow_start	= cow->start;
 		__entry->buf_level	= btrfs_header_level(buf);
 		__entry->cow_level	= btrfs_header_level(cow);
-- 
2.47.2


