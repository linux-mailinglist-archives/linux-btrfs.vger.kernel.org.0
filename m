Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53F2DDDCA
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 06:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgLRFSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 00:18:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:50168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgLRFR6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 00:17:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608268631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jog37eS/bHZvEdo2I9/HiP16V62jZRmfDvx7UsztW+Y=;
        b=HIDXkgQlht+tN/zP8ygJXBkZ8hACfM+PhzZhkYoM78ikYC+Ifa0T9qD+kd8D7J2yGTT2SH
        tQWFZ5LJWtKLSOvP4JEOzDYINrUQJh4K3oXkcQOz9L4oTE61OVKwB0LPnj2CMbJxXxSRkR
        nm1bXqhceXdKdE2LsSIdWvOml5kKfzA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EC37B735
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 05:17:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: refactor btrfs_dec_test_* functions for ordered extents
Date:   Fri, 18 Dec 2020 13:17:01 +0800
Message-Id: <20201218051701.62262-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218051701.62262-1-wqu@suse.com>
References: <20201218051701.62262-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The refactors involves the following modifications:
- Return bool instead of int

- Reduce the width of @io_size for btrfs_dec_test_ordered_pending()
  Function btrfs_dec_test_ordered_pending() is only supposed to handle
  at most one page, thus u32 for @io_size is enough.
  Also added ASSERT()s for such width reduce.

  For btrfs_dev_test_first_ordered_pending(), btrfs_dio_iomap_end() is
  the only blockage, since its @length is loff_t and I'm not that
  confident that @length can be contained in U32, thus
  btrfs_dev_test_first_ordered_pending() still uses u64 for its @iosize.

- Parameter rename for @cached of btrfs_dec_test_first_ordered_pending()
  For btrfs_dec_test_first_ordered_pending(), @cached is only used to
  return the finished ordered extent.
  Rename it to @finished_ret.

- Comments update
  * Change one stale comment
    Which still refers to btrfs_dec_test_ordered_pending(), but the
    context is calling  btrfs_dec_test_first_ordered_pending().
  * Follow the common comment style for both functions
    Add more detailed descriptions for parameters and the return value
  * Move the reason why test_and_set_bit() is used into the call sites

- Change how the return value is calculated
  The most anti-human part of the return value is:

    if (...)
	ret = 1;
    ...
    return ret == 0;

  This means, when we set ret to 1, the function returns 0.
  Change the local variable name to @finished, and directly return the
  value of it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c        |  7 ++-
 fs/btrfs/ordered-data.c | 98 ++++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.h | 10 ++---
 3 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fa9fbed36ec9..ab110552daef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2920,6 +2920,7 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
 
 	ClearPagePrivate2(page);
+	ASSERT(end - start + 1 < U32_MAX);
 	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
 					    end - start + 1, uptodate))
 		return;
@@ -7793,10 +7794,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 					NULL);
 			btrfs_queue_work(wq, &ordered->work);
 		}
-		/*
-		 * If btrfs_dec_test_ordered_pending does not find any ordered
-		 * extent in the range, we can exit.
-		 */
+		/* No ordered extent found in the range, exit. */
 		if (ordered_offset == last_offset)
 			return;
 		/*
@@ -8216,6 +8214,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				ordered->truncated_len = new_len;
 			spin_unlock_irq(&tree->lock);
 
+			ASSERT(end - start + 1 < U32_MAX);
 			if (btrfs_dec_test_ordered_pending(inode, &ordered,
 							   start,
 							   end - start + 1, 1)) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 79d366a36223..f9dff5c90a27 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -297,26 +297,33 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 }
 
 /*
- * this is used to account for finished IO across a given range
- * of the file.  The IO may span ordered extents.  If
- * a given ordered_extent is completely done, 1 is returned, otherwise
- * 0.
+ * Finish io for one ordered extent across a given range.
+ * The range can contain several ordered extents.
  *
- * test_and_set_bit on a flag in the struct btrfs_ordered_extent is used
- * to make sure this function only returns 1 once for a given ordered extent.
+ * @found_ret:	 Return the finished ordered extent
+ * @file_offset: File offset for the finished io
+ * 		 Will also be updated to one byte past the range that is
+ * 		 recordered as finished. This allows caller to walk forward.
+ * @io_size:	 Length of the finish io range
+ * @uptodate:	 If the IO finishes without problem.
  *
- * file_offset is updated to one byte past the range that is recorded as
- * complete.  This allows you to walk forward in the file.
+ * Return true if any ordered extent is finished in the range, and update
+ * @found_ret and @file_offset.
+ * Return false otherwise.
+ *
+ * NOTE: Although The range can cross multiple ordered extents, only one
+ * ordered extent will be updated during one call. The caller is responsible
+ * to iterate all ordered extents in the range.
  */
-int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **cached,
+bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
+				   struct btrfs_ordered_extent **finished_ret,
 				   u64 *file_offset, u64 io_size, int uptodate)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	int ret;
+	bool finished = false;
 	unsigned long flags;
 	u64 dec_end;
 	u64 dec_start;
@@ -324,16 +331,12 @@ int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 
 	spin_lock_irqsave(&tree->lock, flags);
 	node = tree_search(tree, *file_offset);
-	if (!node) {
-		ret = 1;
+	if (!node)
 		goto out;
-	}
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-	if (!offset_in_entry(entry, *file_offset)) {
-		ret = 1;
+	if (!offset_in_entry(entry, *file_offset))
 		goto out;
-	}
 
 	dec_start = max(*file_offset, entry->file_offset);
 	dec_end = min(*file_offset + io_size,
@@ -354,39 +357,48 @@ int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 		set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
 
 	if (entry->bytes_left == 0) {
-		ret = test_and_set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
+		/* Ensure only one caller can get true returned. */
+		finished = !test_and_set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
 		/* test_and_set_bit implies a barrier */
 		cond_wake_up_nomb(&entry->wait);
-	} else {
-		ret = 1;
 	}
 out:
-	if (!ret && cached && entry) {
-		*cached = entry;
+	if (finished && finished_ret && entry) {
+		*finished_ret = entry;
 		refcount_inc(&entry->refs);
 	}
 	spin_unlock_irqrestore(&tree->lock, flags);
-	return ret == 0;
+	return finished;
 }
 
 /*
- * this is used to account for finished IO across a given range
- * of the file.  The IO should not span ordered extents.  If
- * a given ordered_extent is completely done, 1 is returned, otherwise
- * 0.
+ * Finish io for one ordered extent across a given range.
+ * The range can only contain one ordered extent.
+ *
+ * @cached:	 The cached ordered extent.
+ * 		 If not NULL, we can skip the tree search and use the ordered
+ * 		 extent directly.
+ * 		 Will also be used to store the finished ordered extent.
+ * @file_offset: File offset for the finished io
+ * @io_size:	 Length of the finish io range
+ * @uptodate:	 If the IO finishes without problem.
  *
- * test_and_set_bit on a flag in the struct btrfs_ordered_extent is used
- * to make sure this function only returns 1 once for a given ordered extent.
+ * Return true if the ordered extent is finished in the range, and update
+ * @cached.
+ * Return false otherwise.
+ *
+ * NOTE: The range can NOT cross multiple ordered extents.
+ * Thus caller should ensure the range is no larger than one sector.
  */
-int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **cached,
-				   u64 file_offset, u64 io_size, int uptodate)
+bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
+				    struct btrfs_ordered_extent **cached,
+				    u64 file_offset, u32 io_size, int uptodate)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
-	int ret;
+	bool finished = false;
 
 	spin_lock_irqsave(&tree->lock, flags);
 	if (cached && *cached) {
@@ -395,21 +407,18 @@ int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 	}
 
 	node = tree_search(tree, file_offset);
-	if (!node) {
-		ret = 1;
+	if (!node)
 		goto out;
-	}
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
 have_entry:
-	if (!offset_in_entry(entry, file_offset)) {
-		ret = 1;
+	if (!offset_in_entry(entry, file_offset))
 		goto out;
-	}
 
 	if (io_size > entry->bytes_left) {
+		ASSERT(0);
 		btrfs_crit(inode->root->fs_info,
-			   "bad ordered accounting left %llu size %llu",
+			   "bad ordered accounting left %llu size %u",
 		       entry->bytes_left, io_size);
 	}
 	entry->bytes_left -= io_size;
@@ -417,19 +426,18 @@ int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 		set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
 
 	if (entry->bytes_left == 0) {
-		ret = test_and_set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
+		/* Ensure only one caller can get true returned. */
+		finished = !test_and_set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
 		/* test_and_set_bit implies a barrier */
 		cond_wake_up_nomb(&entry->wait);
-	} else {
-		ret = 1;
 	}
 out:
-	if (!ret && cached && entry) {
+	if (finished && cached && entry) {
 		*cached = entry;
 		refcount_inc(&entry->refs);
 	}
 	spin_unlock_irqrestore(&tree->lock, flags);
-	return ret == 0;
+	return finished;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 0bfa82b58e23..3ee987cd402d 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -152,11 +152,11 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
-int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **cached,
-				   u64 file_offset, u64 io_size, int uptodate);
-int btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **cached,
+bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
+				    struct btrfs_ordered_extent **cached,
+				    u64 file_offset, u32 io_size, int uptodate);
+bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
+				   struct btrfs_ordered_extent **finished_ret,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-- 
2.29.2

