Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83341454E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhIVJia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 05:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234321AbhIVJiZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 05:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B7F860F70
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632303407;
        bh=NPTDYIMhwK1ItDdnfh94ihyAG+qxwAV3JMDqMqZHPu0=;
        h=From:To:Subject:Date:From;
        b=jB8Vazyegtayn6TzUE0ixl2H27O15iLa4VbAKwkvX3omwJrWIyR4yFlx+WmJrLIeH
         wo0kIzYG4Y0R8/J9vthOG3Wm/PAGtCMLGXG2zan7r+2I9F5JLmXHpJB5ejPXcZacq+
         4D6oAt4cVMs0rYcUytuaHsMh0EvEEBrpOK4g6PLUbMPX+dmOEdqjFH4P/xpGL8NGOL
         HlfVDA6hsRR5GCVvGzwbT1CNew9BDTFnWrC9RDX94WPvUnvTbJeeFmLrKkf7SKLL+D
         KJCEEhYyZops0bFPzCAH3rPNVYEd31Q+mm9dedZKBrZqM8GPbgXsxuaheVnof8CVvT
         +9OCONA8UusHw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: assert that extent buffers are write locked instead of only locked
Date:   Wed, 22 Sep 2021 10:36:45 +0100
Message-Id: <7869e87c5d9a7d079510e780ea6bc4a32b952a7b.1632303323.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We currently use lockdep_assert_held() at btrfs_assert_tree_locked(), and
that checks that we hold a lock either in read mode or write mode.

However in all contextes we use btrfs_assert_tree_locked(), we actually
want to check if we are holding a write lock on the extent buffer's rw
semaphore - it would be a bug if in any of those contextes we were holding
a read lock instead.

So change btrfs_assert_tree_locked() to use lockdep_assert_held_write()
instead and, to make it more explicit, rename btrfs_assert_tree_locked()
to btrfs_assert_tree_write_locked(), so that it's clear we want to check
we are holding a write lock.

For now there are no contextes where we want to assert that we must have
a read lock, but in case that is needed in the future, we can add a new
helper function that just calls out lockdep_assert_held_read().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c       | 8 ++++----
 fs/btrfs/disk-io.c     | 8 ++++----
 fs/btrfs/extent-tree.c | 4 ++--
 fs/btrfs/locking.h     | 7 ++++---
 fs/btrfs/xattr.c       | 2 +-
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7c4877b05c5f..a1e04aeb6570 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -395,7 +395,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	if (*cow_ret == buf)
 		unlock_orig = 1;
 
-	btrfs_assert_tree_locked(buf);
+	btrfs_assert_tree_write_locked(buf);
 
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 		trans->transid != fs_info->running_transaction->transid);
@@ -2534,7 +2534,7 @@ static void insert_ptr(struct btrfs_trans_handle *trans,
 	int ret;
 
 	BUG_ON(!path->nodes[level]);
-	btrfs_assert_tree_locked(path->nodes[level]);
+	btrfs_assert_tree_write_locked(path->nodes[level]);
 	lower = path->nodes[level];
 	nritems = btrfs_header_nritems(lower);
 	BUG_ON(slot > nritems);
@@ -2874,7 +2874,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (slot >= btrfs_header_nritems(upper) - 1)
 		return 1;
 
-	btrfs_assert_tree_locked(path->nodes[1]);
+	btrfs_assert_tree_write_locked(path->nodes[1]);
 
 	right = btrfs_read_node_slot(upper, slot + 1);
 	/*
@@ -3112,7 +3112,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (right_nritems == 0)
 		return 1;
 
-	btrfs_assert_tree_locked(path->nodes[1]);
+	btrfs_assert_tree_write_locked(path->nodes[1]);
 
 	left = btrfs_read_node_slot(path->nodes[1], slot - 1);
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b28638c79413..37637539c5ab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1036,7 +1036,7 @@ static int btree_set_page_dirty(struct page *page)
 		BUG_ON(!eb);
 		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 		BUG_ON(!atomic_read(&eb->refs));
-		btrfs_assert_tree_locked(eb);
+		btrfs_assert_tree_write_locked(eb);
 		return __set_page_dirty_nobuffers(page);
 	}
 	ASSERT(PagePrivate(page) && page->private);
@@ -1061,7 +1061,7 @@ static int btree_set_page_dirty(struct page *page)
 		ASSERT(eb);
 		ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 		ASSERT(atomic_read(&eb->refs));
-		btrfs_assert_tree_locked(eb);
+		btrfs_assert_tree_write_locked(eb);
 		free_extent_buffer(eb);
 
 		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits);
@@ -1125,7 +1125,7 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	if (btrfs_header_generation(buf) ==
 	    fs_info->running_transaction->transid) {
-		btrfs_assert_tree_locked(buf);
+		btrfs_assert_tree_write_locked(buf);
 
 		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
 			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
@@ -4481,7 +4481,7 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 	if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &buf->bflags)))
 		return;
 #endif
-	btrfs_assert_tree_locked(buf);
+	btrfs_assert_tree_write_locked(buf);
 	if (transid != fs_info->generation)
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
 			buf->start, transid, fs_info->generation);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4b3eaee716a..ec5de19f0acd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5836,13 +5836,13 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	btrfs_assert_tree_locked(parent);
+	btrfs_assert_tree_write_locked(parent);
 	parent_level = btrfs_header_level(parent);
 	atomic_inc(&parent->refs);
 	path->nodes[parent_level] = parent;
 	path->slots[parent_level] = btrfs_header_nritems(parent);
 
-	btrfs_assert_tree_locked(node);
+	btrfs_assert_tree_write_locked(node);
 	level = btrfs_header_level(node);
 	path->nodes[level] = node;
 	path->slots[level] = 0;
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index a2e1f1f5c6e3..bbc45534ae9a 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -96,11 +96,12 @@ struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
 
 #ifdef CONFIG_BTRFS_DEBUG
-static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
-	lockdep_assert_held(&eb->lock);
+static inline void btrfs_assert_tree_write_locked(struct extent_buffer *eb)
+{
+	lockdep_assert_held_write(&eb->lock);
 }
 #else
-static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
+static inline void btrfs_assert_tree_write_locked(struct extent_buffer *eb) { }
 #endif
 
 void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 8a4514283a4b..2837b4c8424d 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -138,7 +138,7 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		 * matches our target xattr, so lets check.
 		 */
 		ret = 0;
-		btrfs_assert_tree_locked(path->nodes[0]);
+		btrfs_assert_tree_write_locked(path->nodes[0]);
 		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
 		if (!di && !(flags & XATTR_REPLACE)) {
 			ret = -ENOSPC;
-- 
2.33.0

