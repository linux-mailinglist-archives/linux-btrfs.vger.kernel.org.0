Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607242E05E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 07:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLVGAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 01:00:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:35490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLVGAS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 01:00:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608616771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhGeU0f+l9dVvMW24iTq+amFO3jLJ6BxpK+3zQb/0N4=;
        b=fzw6COLSjocxkNnKQUeie3J/Lmo2hDknERgAmtPWJdfPEpQkppQaL6HELV2/e5LD1i/SHy
        fqoTbfJUhxZQ0g3CHRz3HYeqPI3z8Em++WjnN2TShmqp7kT9M8BqMBzjP3+5pCL2jFkuAJ
        q84mTIgOtrMenB59lRvHRBzgxLPF40M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCFBCAE66
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 05:59:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: refactor btrfs_dec_test_* functions for ordered extents
Date:   Tue, 22 Dec 2020 13:59:24 +0800
Message-Id: <20201222055924.64724-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201222055924.64724-1-wqu@suse.com>
References: <20201222055924.64724-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The refactors involves the following modifications:
- Return bool instead of int

- Parameter update for @cached of btrfs_dec_test_first_ordered_pending()
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
 fs/btrfs/inode.c        |  5 +--
 fs/btrfs/ordered-data.c | 99 ++++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.h | 10 ++---
 3 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fa9fbed36ec9..93979bdddbd6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7793,10 +7793,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
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
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 79d366a36223..e10ab81e85d8 100644
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
+ *
+ * Return true if the ordered extent is finished in the range, and update
+ * @cached.
+ * Return false otherwise.
  *
- * test_and_set_bit on a flag in the struct btrfs_ordered_extent is used
- * to make sure this function only returns 1 once for a given ordered extent.
+ * NOTE: The range can NOT cross multiple ordered extents.
+ * Thus caller should ensure the range doesn't cross ordered extents.
  */
-int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **cached,
-				   u64 file_offset, u64 io_size, int uptodate)
+bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
+				    struct btrfs_ordered_extent **cached,
+				    u64 file_offset, u64 io_size, int uptodate)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
-	int ret;
+	bool finished = false;
 
 	spin_lock_irqsave(&tree->lock, flags);
 	if (cached && *cached) {
@@ -395,41 +407,36 @@ int btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
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
 
-	if (io_size > entry->bytes_left) {
+	if (io_size > entry->bytes_left)
 		btrfs_crit(inode->root->fs_info,
 			   "bad ordered accounting left %llu size %llu",
 		       entry->bytes_left, io_size);
-	}
+
 	entry->bytes_left -= io_size;
 	if (!uptodate)
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
index 0bfa82b58e23..46194c2c05d4 100644
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
+				    u64 file_offset, u64 io_size, int uptodate);
+bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
+				   struct btrfs_ordered_extent **finished_ret,
 				   u64 *file_offset, u64 io_size,
 				   int uptodate);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-- 
2.29.2

