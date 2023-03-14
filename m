Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5486B9C64
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCNRAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCNQ77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2A84815
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1FWaZ42lR63RfGcScR12OQ6/dDufBLi4LjxtCLWyXHc=; b=DW+kEpKV8LC0lKc8vvu2IB2cn4
        +Oqt6CrUTdAqJphBEGUmG1UN0dGhL9T1M/oUR/5/UcL3e4R61VOHPpAh+Q0BHtivg6XvJpZ9K2Jyj
        y8HW3gyZ5bI4fGd+tn9/b6SzG+mo7Kx6DnXaqZlBbUkxWAWNp0NR7IvqYRd77uDro3pvplk/pntTh
        LmUQ4Go2lBYSXVP1yt++/Jj4YnUO7r4GLhyKWS98Pc/fs0wfBJ6F9uaR4ukcZxjccORwJq1mIVQky
        dWCpG0Etg36wuVEztGDljrZzNlKsFlQBjW6gCGhA9NTmUKvMQk3l3s9cd3LF0Yh8L7S+749mr2AEV
        1r4lYvBg==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc80A-00Avtl-1c;
        Tue, 14 Mar 2023 16:59:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: remove irq_disabling for ordered_tree.lock
Date:   Tue, 14 Mar 2023 17:59:09 +0100
Message-Id: <20230314165910.373347-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The per-inode ordered extent list is not only accessed from process
context, so remove the irq disabling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        |  4 ++--
 fs/btrfs/ordered-data.c | 51 +++++++++++++++++++----------------------
 fs/btrfs/tree-log.c     |  4 ++--
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cccaab4aa9cd91..afa564f46c6452 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8050,11 +8050,11 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, &cached_state);
 
-		spin_lock_irq(&inode->ordered_tree.lock);
+		spin_lock(&inode->ordered_tree.lock);
 		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 		ordered->truncated_len = min(ordered->truncated_len,
 					     cur - ordered->file_offset);
-		spin_unlock_irq(&inode->ordered_tree.lock);
+		spin_unlock(&inode->ordered_tree.lock);
 
 		/*
 		 * If the ordered extent has finished, we're safe to delete all
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 48c7510df80a0d..4c913d1cf21b1d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -228,14 +228,14 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 
 	trace_btrfs_ordered_extent_add(inode, entry);
 
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	node = tree_insert(&tree->tree, file_offset,
 			   &entry->rb_node);
 	if (node)
 		btrfs_panic(fs_info, -EEXIST,
 				"inconsistency in ordered tree at offset %llu",
 				file_offset);
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 
 	spin_lock(&root->ordered_extent_lock);
 	list_add_tail(&entry->root_extent_list,
@@ -298,9 +298,9 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	struct btrfs_ordered_inode_tree *tree;
 
 	tree = &BTRFS_I(entry->inode)->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	list_add_tail(&sum->list, &entry->list);
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 }
 
 /*
@@ -324,14 +324,13 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 	u64 cur = file_offset;
 
 	if (page)
 		ASSERT(page->mapping && page_offset(page) <= file_offset &&
 		       file_offset + num_bytes <= page_offset(page) + PAGE_SIZE);
 
-	spin_lock_irqsave(&tree->lock, flags);
+	spin_lock(&tree->lock);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
 		u64 end;
@@ -424,13 +423,13 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			cond_wake_up(&entry->wait);
 			refcount_inc(&entry->refs);
 			trace_btrfs_ordered_extent_mark_finished(inode, entry);
-			spin_unlock_irqrestore(&tree->lock, flags);
+			spin_unlock(&tree->lock);
 			btrfs_finish_ordered_io(entry);
-			spin_lock_irqsave(&tree->lock, flags);
+			spin_lock(&tree->lock);
 		}
 		cur += len;
 	}
-	spin_unlock_irqrestore(&tree->lock, flags);
+	spin_unlock(&tree->lock);
 }
 
 /*
@@ -457,10 +456,9 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 	bool finished = false;
 
-	spin_lock_irqsave(&tree->lock, flags);
+	spin_lock(&tree->lock);
 	if (cached && *cached) {
 		entry = *cached;
 		goto have_entry;
@@ -497,7 +495,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
 	}
-	spin_unlock_irqrestore(&tree->lock, flags);
+	spin_unlock(&tree->lock);
 	return finished;
 }
 
@@ -567,7 +565,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				 fs_info->delalloc_batch);
 
 	tree = &btrfs_inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	node = &entry->rb_node;
 	rb_erase(node, &tree->tree);
 	RB_CLEAR_NODE(node);
@@ -575,7 +573,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 		tree->last = NULL;
 	set_bit(BTRFS_ORDERED_COMPLETE, &entry->flags);
 	pending = test_and_clear_bit(BTRFS_ORDERED_PENDING, &entry->flags);
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 
 	/*
 	 * The current running transaction is waiting on us, we need to let it
@@ -837,10 +835,9 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 
 	tree = &inode->ordered_tree;
-	spin_lock_irqsave(&tree->lock, flags);
+	spin_lock(&tree->lock);
 	node = tree_search(tree, file_offset);
 	if (!node)
 		goto out;
@@ -853,7 +850,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 		trace_btrfs_ordered_extent_lookup(inode, entry);
 	}
 out:
-	spin_unlock_irqrestore(&tree->lock, flags);
+	spin_unlock(&tree->lock);
 	return entry;
 }
 
@@ -868,7 +865,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 	struct btrfs_ordered_extent *entry = NULL;
 
 	tree = &inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	node = tree_search(tree, file_offset);
 	if (!node) {
 		node = tree_search(tree, file_offset + len);
@@ -895,7 +892,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_lookup_range(inode, entry);
 	}
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 	return entry;
 }
 
@@ -911,7 +908,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 
 	ASSERT(inode_is_locked(&inode->vfs_inode));
 
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	for (n = rb_first(&tree->tree); n; n = rb_next(n)) {
 		struct btrfs_ordered_extent *ordered;
 
@@ -925,7 +922,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 		refcount_inc(&ordered->refs);
 		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
 	}
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 }
 
 /*
@@ -940,7 +937,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	struct btrfs_ordered_extent *entry = NULL;
 
 	tree = &inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	node = tree_search(tree, file_offset);
 	if (!node)
 		goto out;
@@ -949,7 +946,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	refcount_inc(&entry->refs);
 	trace_btrfs_ordered_extent_lookup_first(inode, entry);
 out:
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 	return entry;
 }
 
@@ -972,7 +969,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	struct rb_node *next;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	node = tree->tree.rb_node;
 	/*
 	 * Here we don't want to use tree_search() which will use tree->last
@@ -1027,7 +1024,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
 	}
 
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 	return entry;
 }
 
@@ -1134,7 +1131,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 
 	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
 
-	spin_lock_irq(&tree->lock);
+	spin_lock(&tree->lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
 	rb_erase(node, &tree->tree);
@@ -1155,7 +1152,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 			"zoned: inconsistency in ordered tree at offset %llu",
 			    ordered->file_offset);
 
-	spin_unlock_irq(&tree->lock);
+	spin_unlock(&tree->lock);
 
 	if (pre)
 		ret = clone_ordered_extent(ordered, 0, pre);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9ab793b638a7b9..8cb0b700bf535b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4950,12 +4950,12 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		set_bit(BTRFS_ORDERED_LOGGED, &ordered->flags);
 
 		if (!test_bit(BTRFS_ORDERED_COMPLETE, &ordered->flags)) {
-			spin_lock_irq(&inode->ordered_tree.lock);
+			spin_lock(&inode->ordered_tree.lock);
 			if (!test_bit(BTRFS_ORDERED_COMPLETE, &ordered->flags)) {
 				set_bit(BTRFS_ORDERED_PENDING, &ordered->flags);
 				atomic_inc(&trans->transaction->pending_ordered);
 			}
-			spin_unlock_irq(&inode->ordered_tree.lock);
+			spin_unlock(&inode->ordered_tree.lock);
 		}
 		btrfs_put_ordered_extent(ordered);
 	}
-- 
2.39.2

