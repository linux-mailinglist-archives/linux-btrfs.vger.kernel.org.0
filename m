Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6D294849
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440826AbgJUG1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQlmND4SXpiRAAqgKKdSzrzziEt9mtAut8198udfZg0=;
        b=W4DbKG7I6UO5WKpJo5bKv8xQVDnTsdstqvewORoyTYu5nJgYgRw1VcjjJoNKMzoyKw9v4i
        vqCiXCEp6/Vcmo9jsyGKmIsBcrXCUNj48GPQXA7TK+heMNICn0dYRM5ocKO0mbY/0GvYP4
        Ffww6CRf/bDB6yOgWjK8+P06vMTjRZc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4FCFAC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 45/68] btrfs: extent_io: prevent extent_state from being merged for btree io tree
Date:   Wed, 21 Oct 2020 14:25:31 +0800
Message-Id: <20201021062554.68132-46-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For incoming subpage metadata rw support, prevent extent_state from
being merged for btree io tree.

The main cause is set_extent_buffer_dirty().

In the following call chain, we could fall into the situation where we
have to call set_extent_dirty() with atomic context:

alloc_reserved_tree_block()
|- path->leave_spinning = 1;
|- btrfs_insert_empty_item()
   |- btrfs_search_slot()
   |  Now the path has all its tree block spinning locked
   |- setup_items_for_insert();
   |- btrfs_unlock_up_safe(path, 1);
   |  Now path->nodes[0] still spin locked
   |- btrfs_mark_buffer_dirty(leaf);
      |- set_extent_buffer_dirty()

Since set_extent_buffer_dirty() is in fact a pretty common call, just
fall back to GFP_ATOMIC allocation used in __set_extent_bit() may
exhause the pool sooner than we expected.

So this patch goes another direction, by not merging all extent_state
for subpage btree io tree.

Since for subpage btree io tree, all in tree extent buffers has
EXTENT_HAS_TREE_BLOCK bit set during its lifespan, as long as
extent_state is not merged, each extent buffer would has its own
extent_state, so that set/clear_extent_bit() can reuse existing extent
buffer extent_state, without allocating new memory.

The cost is obvious, around 150 bytes per subpage extent buffer.
But considering for subpage extent buffer, we saved 15 page pointers,
this should save 120 bytes, so the net cost is just 30 bytes per subpage
extent buffer, which should be acceptable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c        | 14 ++++++++++++--
 fs/btrfs/extent-io-tree.h | 14 ++++++++++++++
 fs/btrfs/extent_io.c      | 19 ++++++++++++++-----
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9aa68e2344e1..e466c30b52c8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2326,11 +2326,21 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	/*
 	 * For subpage size support, btree inode tracks EXTENT_UPTODATE for
 	 * its IO.
+	 *
+	 * And never merge extent states to make all set/clear operation never
+	 * to allocate memory, except the initial EXTENT_HAS_TREE_BLOCK bit.
+	 * This adds extra ~150 bytes for each extent buffer.
+	 *
+	 * TODO: Josef's rwsem rework on tree lock would kill the leave_spining
+	 * case, and then we can revert this behavior.
 	 */
-	if (btrfs_is_subpage(fs_info))
+	if (btrfs_is_subpage(fs_info)) {
 		BTRFS_I(inode)->io_tree.track_uptodate = true;
-	else
+		BTRFS_I(inode)->io_tree.never_merge = true;
+	} else {
 		BTRFS_I(inode)->io_tree.track_uptodate = false;
+		BTRFS_I(inode)->io_tree.never_merge = false;
+	}
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->io_tree.ops = &btree_extent_io_ops;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d3b21c732634..bb95c6b9ad82 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -71,6 +71,20 @@ struct extent_io_tree {
 	u64 dirty_bytes;
 	bool track_uptodate;
 
+	/*
+	 * Never to merge extent_state.
+	 *
+	 * This allows any set/clear function to be execute in atomic context
+	 * without allocating extra memory.
+	 * The cost is extra memory usage.
+	 *
+	 * Should only be used for subpage btree io tree, which mostly adds per
+	 * extent buffer memory usage.
+	 *
+	 * Default: false.
+	 */
+	bool never_merge;
+
 	/* Who owns this io tree, should be one of IO_TREE_* */
 	u8 owner;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 278154d405ea..f67d88586d05 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -286,6 +286,7 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&tree->lock);
 	tree->private_data = private_data;
 	tree->owner = owner;
+	tree->never_merge = false;
 	if (owner == IO_TREE_INODE_FILE_EXTENT)
 		lockdep_set_class(&tree->lock, &file_extent_tree_class);
 }
@@ -481,11 +482,18 @@ static inline struct rb_node *tree_search(struct extent_io_tree *tree,
 }
 
 /*
- * utility function to look for merge candidates inside a given range.
+ * Utility function to look for merge candidates inside a given range.
  * Any extents with matching state are merged together into a single
- * extent in the tree.  Extents with EXTENT_IO in their state field
- * are not merged because the end_io handlers need to be able to do
- * operations on them without sleeping (or doing allocations/splits).
+ * extent in the tree.
+ *
+ * Except the following cases:
+ * - extent_state with EXTENT_LOCK or EXTENT_BOUNDARY bit set
+ *   Those extents are not merged because end_io handlers need to be able
+ *   to do operations on them without sleeping (or doing allocations/splits)
+ *
+ * - extent_io_tree with never_merge bit set
+ *   Same reason as above, but extra call sites may have spinlock/rwlock hold,
+ *   and we don't want to abuse GFP_ATOMIC.
  *
  * This should be called with the tree lock held.
  */
@@ -495,7 +503,8 @@ static void merge_state(struct extent_io_tree *tree,
 	struct extent_state *other;
 	struct rb_node *other_node;
 
-	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY) ||
+	    tree->never_merge)
 		return;
 
 	other_node = rb_prev(&state->rb_node);
-- 
2.28.0

