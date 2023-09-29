Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E338A7B3A4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjI2S7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2S7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 14:59:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7921A4
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 11:59:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AE011F896;
        Fri, 29 Sep 2023 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696013950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ewHV02i9uXY+p4Q49DyKJxoE3a7XyAC2unm1hnKCog=;
        b=E7W3aL1WJC6VndKrbRGgBNA671rm2Kae1o/AHUreu09xxj0KhIlFDYS3QtOiMIs4CzLt8I
        XRD3nZjjyUlxsq6Q12/9sISEkV7SxCTmfbJ3D5kQB8WxrLt7Ee73wM0C3nG0gqB1cnmqGX
        GP74QV6R3VfwkRu1CgZoyDXT8cYTjnY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 184382C142;
        Fri, 29 Sep 2023 18:59:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ECF1EDA832; Fri, 29 Sep 2023 20:52:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: open code btrfs_ordered_inode_tree in btrfs_inode
Date:   Fri, 29 Sep 2023 20:52:31 +0200
Message-ID: <18c907bb057c5dbec6e61da3c135fb315b2bfe22.1696012550.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696012550.git.dsterba@suse.com>
References: <cover.1696012550.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The structure btrfs_ordered_inode_tree is used only in one place, in
btrfs_inode. The structure itself has a 4 byte hole which is wasted
space.

Move the btrfs_ordered_inode_tree members to btrfs_inode with a common
prefix 'ordered_tree_' where the hole can be utilized and shrink inode
size.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h  |   4 +-
 fs/btrfs/inode.c        |   8 ++-
 fs/btrfs/ordered-data.c | 122 ++++++++++++++++++----------------------
 fs/btrfs/ordered-data.h |  15 -----
 fs/btrfs/tree-log.c     |   4 +-
 5 files changed, 64 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index f2c928345d53..3a01443a9fe0 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -114,7 +114,9 @@ struct btrfs_inode {
 	struct mutex log_mutex;
 
 	/* used to order data wrt metadata */
-	struct btrfs_ordered_inode_tree ordered_tree;
+	spinlock_t ordered_tree_lock;
+	struct rb_root ordered_tree;
+	struct rb_node *ordered_tree_last;
 
 	/* list of all the delalloc inodes in the FS.  There are times we need
 	 * to write all the delalloc pages to disk, and this list is used
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2025a5f873b1..3b3aec302c33 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8011,11 +8011,11 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, &cached_state);
 
-		spin_lock_irq(&inode->ordered_tree.lock);
+		spin_lock_irq(&inode->ordered_tree_lock);
 		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 		ordered->truncated_len = min(ordered->truncated_len,
 					     cur - ordered->file_offset);
-		spin_unlock_irq(&inode->ordered_tree.lock);
+		spin_unlock_irq(&inode->ordered_tree_lock);
 
 		/*
 		 * If the ordered extent has finished, we're safe to delete all
@@ -8497,7 +8497,9 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
 	mutex_init(&ei->log_mutex);
-	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
+	spin_lock_init(&ei->ordered_tree_lock);
+	ei->ordered_tree = RB_ROOT;
+	ei->ordered_tree_last = NULL;
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b133ea0bc459..574e8a55e24a 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -124,25 +124,24 @@ static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
  * look find the first ordered struct that has this offset, otherwise
  * the first one less than this offset
  */
-static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
-					  u64 file_offset)
+static inline struct rb_node *ordered_tree_search(struct btrfs_inode *inode,
+						  u64 file_offset)
 {
-	struct rb_root *root = &tree->tree;
 	struct rb_node *prev = NULL;
 	struct rb_node *ret;
 	struct btrfs_ordered_extent *entry;
 
-	if (tree->last) {
-		entry = rb_entry(tree->last, struct btrfs_ordered_extent,
+	if (inode->ordered_tree_last) {
+		entry = rb_entry(inode->ordered_tree_last, struct btrfs_ordered_extent,
 				 rb_node);
 		if (in_range(file_offset, entry->file_offset, entry->num_bytes))
-			return tree->last;
+			return inode->ordered_tree_last;
 	}
-	ret = __tree_search(root, file_offset, &prev);
+	ret = __tree_search(&inode->ordered_tree, file_offset, &prev);
 	if (!ret)
 		ret = prev;
 	if (ret)
-		tree->last = ret;
+		inode->ordered_tree_last = ret;
 	return ret;
 }
 
@@ -209,7 +208,6 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 {
 	struct btrfs_inode *inode = BTRFS_I(entry->inode);
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *node;
@@ -222,13 +220,14 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 	/* One ref for the tree. */
 	refcount_inc(&entry->refs);
 
-	spin_lock_irq(&tree->lock);
-	node = tree_insert(&tree->tree, entry->file_offset, &entry->rb_node);
+	spin_lock_irq(&inode->ordered_tree_lock);
+	node = tree_insert(&inode->ordered_tree, entry->file_offset,
+			   &entry->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
 				"inconsistency in ordered tree at offset %llu",
 				entry->file_offset);
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 
 	spin_lock(&root->ordered_extent_lock);
 	list_add_tail(&entry->root_extent_list,
@@ -288,12 +287,11 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum)
 {
-	struct btrfs_ordered_inode_tree *tree;
+	struct btrfs_inode *inode = BTRFS_I(entry->inode);
 
-	tree = &BTRFS_I(entry->inode)->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock_irq(&inode->ordered_tree_lock);
 	list_add_tail(&sum->list, &entry->list);
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 }
 
 static void finish_ordered_fn(struct btrfs_work *work)
@@ -311,7 +309,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	lockdep_assert_held(&inode->ordered_tree.lock);
+	lockdep_assert_held(&inode->ordered_tree_lock);
 
 	if (page) {
 		ASSERT(page->mapping);
@@ -379,9 +377,9 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 
 	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
 
-	spin_lock_irqsave(&inode->ordered_tree.lock, flags);
+	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
 	ret = can_finish_ordered_extent(ordered, page, file_offset, len, uptodate);
-	spin_unlock_irqrestore(&inode->ordered_tree.lock, flags);
+	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
@@ -405,7 +403,6 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				    struct page *page, u64 file_offset,
 				    u64 num_bytes, bool uptodate)
 {
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
@@ -415,13 +412,13 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 					  file_offset + num_bytes - 1,
 					  uptodate);
 
-	spin_lock_irqsave(&tree->lock, flags);
+	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
 		u64 end;
 		u32 len;
 
-		node = tree_search(tree, cur);
+		node = ordered_tree_search(inode, cur);
 		/* No ordered extents at all */
 		if (!node)
 			break;
@@ -468,13 +465,13 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		len = end + 1 - cur;
 
 		if (can_finish_ordered_extent(entry, page, cur, len, uptodate)) {
-			spin_unlock_irqrestore(&tree->lock, flags);
+			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 			btrfs_queue_ordered_fn(entry);
-			spin_lock_irqsave(&tree->lock, flags);
+			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
 		}
 		cur += len;
 	}
-	spin_unlock_irqrestore(&tree->lock, flags);
+	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 }
 
 /*
@@ -498,19 +495,18 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size)
 {
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
 	bool finished = false;
 
-	spin_lock_irqsave(&tree->lock, flags);
+	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
 	if (cached && *cached) {
 		entry = *cached;
 		goto have_entry;
 	}
 
-	node = tree_search(tree, file_offset);
+	node = ordered_tree_search(inode, file_offset);
 	if (!node)
 		goto out;
 
@@ -541,7 +537,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
 	}
-	spin_unlock_irqrestore(&tree->lock, flags);
+	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 	return finished;
 }
 
@@ -579,7 +575,6 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				 struct btrfs_ordered_extent *entry)
 {
-	struct btrfs_ordered_inode_tree *tree;
 	struct btrfs_root *root = btrfs_inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *node;
@@ -610,16 +605,15 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
 				 fs_info->delalloc_batch);
 
-	tree = &btrfs_inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock_irq(&btrfs_inode->ordered_tree_lock);
 	node = &entry->rb_node;
-	rb_erase(node, &tree->tree);
+	rb_erase(node, &btrfs_inode->ordered_tree);
 	RB_CLEAR_NODE(node);
-	if (tree->last == node)
-		tree->last = NULL;
+	if (btrfs_inode->ordered_tree_last == node)
+		btrfs_inode->ordered_tree_last = NULL;
 	set_bit(BTRFS_ORDERED_COMPLETE, &entry->flags);
 	pending = test_and_clear_bit(BTRFS_ORDERED_PENDING, &entry->flags);
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&btrfs_inode->ordered_tree_lock);
 
 	/*
 	 * The current running transaction is waiting on us, we need to let it
@@ -876,14 +870,12 @@ int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len)
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
 							 u64 file_offset)
 {
-	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
 
-	tree = &inode->ordered_tree;
-	spin_lock_irqsave(&tree->lock, flags);
-	node = tree_search(tree, file_offset);
+	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	node = ordered_tree_search(inode, file_offset);
 	if (!node)
 		goto out;
 
@@ -895,7 +887,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 		trace_btrfs_ordered_extent_lookup(inode, entry);
 	}
 out:
-	spin_unlock_irqrestore(&tree->lock, flags);
+	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 	return entry;
 }
 
@@ -905,15 +897,13 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode, u64 file_offset, u64 len)
 {
-	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	tree = &inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
-	node = tree_search(tree, file_offset);
+	spin_lock_irq(&inode->ordered_tree_lock);
+	node = ordered_tree_search(inode, file_offset);
 	if (!node) {
-		node = tree_search(tree, file_offset + len);
+		node = ordered_tree_search(inode, file_offset + len);
 		if (!node)
 			goto out;
 	}
@@ -937,7 +927,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_lookup_range(inode, entry);
 	}
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -948,13 +938,12 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 					   struct list_head *list)
 {
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *n;
 
 	ASSERT(inode_is_locked(&inode->vfs_inode));
 
-	spin_lock_irq(&tree->lock);
-	for (n = rb_first(&tree->tree); n; n = rb_next(n)) {
+	spin_lock_irq(&inode->ordered_tree_lock);
+	for (n = rb_first(&inode->ordered_tree); n; n = rb_next(n)) {
 		struct btrfs_ordered_extent *ordered;
 
 		ordered = rb_entry(n, struct btrfs_ordered_extent, rb_node);
@@ -967,7 +956,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 		refcount_inc(&ordered->refs);
 		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
 	}
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 }
 
 /*
@@ -977,13 +966,11 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 {
-	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	tree = &inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
-	node = tree_search(tree, file_offset);
+	spin_lock_irq(&inode->ordered_tree_lock);
+	node = ordered_tree_search(inode, file_offset);
 	if (!node)
 		goto out;
 
@@ -991,7 +978,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	refcount_inc(&entry->refs);
 	trace_btrfs_ordered_extent_lookup_first(inode, entry);
 out:
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -1007,15 +994,14 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 			struct btrfs_inode *inode, u64 file_offset, u64 len)
 {
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct rb_node *cur;
 	struct rb_node *prev;
 	struct rb_node *next;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&tree->lock);
-	node = tree->tree.rb_node;
+	spin_lock_irq(&inode->ordered_tree_lock);
+	node = inode->ordered_tree.rb_node;
 	/*
 	 * Here we don't want to use tree_search() which will use tree->last
 	 * and screw up the search order.
@@ -1069,7 +1055,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
 	}
 
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irq(&inode->ordered_tree_lock);
 	return entry;
 }
 
@@ -1148,7 +1134,6 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 			struct btrfs_ordered_extent *ordered, u64 len)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
-	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 file_offset = ordered->file_offset;
@@ -1188,13 +1173,13 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	refcount_inc(&new->refs);
 
 	spin_lock_irq(&root->ordered_extent_lock);
-	spin_lock(&tree->lock);
+	spin_lock(&inode->ordered_tree_lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
-	rb_erase(node, &tree->tree);
+	rb_erase(node, &inode->ordered_tree);
 	RB_CLEAR_NODE(node);
-	if (tree->last == node)
-		tree->last = NULL;
+	if (inode->ordered_tree_last == node)
+		inode->ordered_tree_last = NULL;
 
 	ordered->file_offset += len;
 	ordered->disk_bytenr += len;
@@ -1225,18 +1210,19 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	}
 
 	/* Re-insert the node */
-	node = tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_node);
+	node = tree_insert(&inode->ordered_tree, ordered->file_offset,
+			   &ordered->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
 			"zoned: inconsistency in ordered tree at offset %llu",
 			ordered->file_offset);
 
-	node = tree_insert(&tree->tree, new->file_offset, &new->rb_node);
+	node = tree_insert(&inode->ordered_tree, new->file_offset, &new->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
 			"zoned: inconsistency in ordered tree at offset %llu",
 			new->file_offset);
-	spin_unlock(&tree->lock);
+	spin_unlock(&inode->ordered_tree_lock);
 
 	list_add_tail(&new->root_extent_list, &root->ordered_extents);
 	root->nr_ordered_extents++;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 1c51ac57e5df..567a6d3d4712 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -6,13 +6,6 @@
 #ifndef BTRFS_ORDERED_DATA_H
 #define BTRFS_ORDERED_DATA_H
 
-/* one of these per inode */
-struct btrfs_ordered_inode_tree {
-	spinlock_t lock;
-	struct rb_root tree;
-	struct rb_node *last;
-};
-
 struct btrfs_ordered_sum {
 	/*
 	 * Logical start address and length for of the blocks covered by
@@ -155,14 +148,6 @@ struct btrfs_ordered_extent {
 	struct list_head bioc_list;
 };
 
-static inline void
-btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
-{
-	spin_lock_init(&t->lock);
-	t->tree = RB_ROOT;
-	t->last = NULL;
-}
-
 int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent);
 int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6b98e0dbc0a4..2c4685316c43 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4917,12 +4917,12 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		set_bit(BTRFS_ORDERED_LOGGED, &ordered->flags);
 
 		if (!test_bit(BTRFS_ORDERED_COMPLETE, &ordered->flags)) {
-			spin_lock_irq(&inode->ordered_tree.lock);
+			spin_lock_irq(&inode->ordered_tree_lock);
 			if (!test_bit(BTRFS_ORDERED_COMPLETE, &ordered->flags)) {
 				set_bit(BTRFS_ORDERED_PENDING, &ordered->flags);
 				atomic_inc(&trans->transaction->pending_ordered);
 			}
-			spin_unlock_irq(&inode->ordered_tree.lock);
+			spin_unlock_irq(&inode->ordered_tree_lock);
 		}
 		btrfs_put_ordered_extent(ordered);
 	}
-- 
2.41.0

