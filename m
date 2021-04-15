Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4F360158
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhDOFFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhDOFFd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Jh5KYaDVs/UMuklHgJ01fW0rzme04KUKKs8OX90qUY=;
        b=L23lmSOLEeaKU1oijXR+mP2itnhX4+VxyLSbBQY8CgVhHwi7p8IkLFmW9+M7UT8iRRL2RE
        I+L0BoGJmCuRXNVAYwkyFSNgQGuw7STJvgSYZz65emZxdgS1KRj5PIXwv8gNMZZF5XQCm4
        RxMXOON/yMc9fRVvKyhbYCrMcxnt6q8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B55AAF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/42] btrfs: refactor how we finish ordered extent io for endio functions
Date:   Thu, 15 Apr 2021 13:04:15 +0800
Message-Id: <20210415050448.267306-10-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs has two endio functions to mark certain io range finished for
ordered extents:
- __endio_write_update_ordered()
  This is for direct IO

- btrfs_writepage_endio_finish_ordered()
  This for buffered IO.

However they go different routines to handle ordered extent io:
- Whether to iterate through all ordered extents
  __endio_write_update_ordered() will but
  btrfs_writepage_endio_finish_ordered() will not.

  In fact, iterating through all ordered extents will benefit later
  subpage support, while for current PAGE_SIZE == sectorsize requirement
  those behavior makes no difference.

- Whether to update page Private2 flag
  __endio_write_update_ordered() will no update page Private2 flag as
  for iomap direct IO, the page can be not even mapped.
  While btrfs_writepage_endio_finish_ordered() will clear Private2 to
  prevent double accounting against btrfs_invalidatepage().

Those differences are pretty small, and the ordered extent iterations
codes in callers makes code much harder to read.

So this patch will introduce a new function,
btrfs_mark_ordered_io_finished(), to do the heavy lifting work:
- Iterate through all ordered extents in the range
- Do the ordered extent accounting
- Queue the work for finished ordered extent

This function has two new feature:
- Proper underflow detection and recover
  The old underflow detection will only detect the problem, then
  continue.
  No proper info like root/inode/ordered extent info, nor noisy enough
  to be caught by fstests.

  Furthermore when underflow happens, the ordered extent will never
  finish.

  New error detection will reset the bytes_left to 0, do proper
  kernel warning, and output extra info including root, ino, ordered
  extent range, the underflow value.

- Prevent double accounting based on Private2 flag
  Now if we find a range without Private2 flag, we will skip to next
  range.
  As that means someone else has already finished the accounting of
  ordered extent.
  This makes no difference for current code, but will be a critical part
  for incoming subpage support.

Now both endio functions only need to call that new function.

And since the only caller of btrfs_dec_test_first_ordered_pending() is
removed, also remove btrfs_dec_test_first_ordered_pending() completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c        |  55 +-----------
 fs/btrfs/ordered-data.c | 179 +++++++++++++++++++++++++++-------------
 fs/btrfs/ordered-data.h |   8 +-
 3 files changed, 129 insertions(+), 113 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 752f0c78e1df..645097bff5a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3063,25 +3063,11 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, int uptodate)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_ordered_extent *ordered_extent = NULL;
-	struct btrfs_workqueue *wq;
-
 	ASSERT(end + 1 - start < U32_MAX);
 	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
 
-	ClearPagePrivate2(page);
-	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
-					    end - start + 1, uptodate))
-		return;
-
-	if (btrfs_is_free_space_inode(inode))
-		wq = fs_info->endio_freespace_worker;
-	else
-		wq = fs_info->endio_write_workers;
-
-	btrfs_init_work(&ordered_extent->work, finish_ordered_fn, NULL, NULL);
-	btrfs_queue_work(wq, &ordered_extent->work);
+	btrfs_mark_ordered_io_finished(inode, page, start, end + 1 - start,
+				       finish_ordered_fn, uptodate);
 }
 
 /*
@@ -7959,42 +7945,9 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_ordered_extent *ordered = NULL;
-	struct btrfs_workqueue *wq;
-	u64 ordered_offset = offset;
-	u64 ordered_bytes = bytes;
-	u64 last_offset;
-
-	if (btrfs_is_free_space_inode(inode))
-		wq = fs_info->endio_freespace_worker;
-	else
-		wq = fs_info->endio_write_workers;
-
 	ASSERT(bytes < U32_MAX);
-	while (ordered_offset < offset + bytes) {
-		last_offset = ordered_offset;
-		if (btrfs_dec_test_first_ordered_pending(inode, &ordered,
-							 &ordered_offset,
-							 ordered_bytes,
-							 uptodate)) {
-			btrfs_init_work(&ordered->work, finish_ordered_fn, NULL,
-					NULL);
-			btrfs_queue_work(wq, &ordered->work);
-		}
-
-		/* No ordered extent found in the range, exit */
-		if (ordered_offset == last_offset)
-			return;
-		/*
-		 * Our bio might span multiple ordered extents. In this case
-		 * we keep going until we have accounted the whole dio.
-		 */
-		if (ordered_offset < offset + bytes) {
-			ordered_bytes = offset + bytes - ordered_offset;
-			ordered = NULL;
-		}
-	}
+	btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes,
+				       finish_ordered_fn, uptodate);
 }
 
 static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 8e6d9d906bdd..a0b625422f55 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -306,81 +306,144 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 }
 
 /*
- * Finish IO for one ordered extent across a given range.  The range can
- * contain several ordered extents.
+ * Mark all ordered extent io inside the specified range finished.
  *
- * @found_ret:	 Return the finished ordered extent
- * @file_offset: File offset for the finished IO
- * 		 Will also be updated to one byte past the range that is
- * 		 recordered as finished. This allows caller to walk forward.
- * @io_size:	 Length of the finish IO range
- * @uptodate:	 If the IO finished without problem
- *
- * Return true if any ordered extent is finished in the range, and update
- * @found_ret and @file_offset.
- * Return false otherwise.
+ * @page:	 The invovled page for the opeartion.
+ *		 For uncompressed buffered IO, the page status also needs to be
+ *		 updated to indicate whether the pending ordered io is
+ *		 finished.
+ *		 Can be NULL for direct IO and compressed write.
+ *		 In those cases, callers are ensured they won't execute
+ *		 the endio function twice.
+ * @finish_func: The function to be executed when all the IO of an ordered
+ *		 extent is finished.
  *
- * NOTE: Although The range can cross multiple ordered extents, only one
- * ordered extent will be updated during one call. The caller is responsible to
- * iterate all ordered extents in the range.
+ * This function is called for endio, thus the range must have ordered
+ * extent(s) covering it.
  */
-bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **finished_ret,
-				   u64 *file_offset, u32 io_size, int uptodate)
+void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
+				struct page *page, u64 file_offset,
+				u32 num_bytes, btrfs_func_t finish_func,
+				bool uptodate)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_workqueue *wq;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	bool finished = false;
 	unsigned long flags;
-	u64 dec_end;
-	u64 dec_start;
-	u32 to_dec;
+	u64 cur = file_offset;
+
+	if (btrfs_is_free_space_inode(inode))
+		wq = fs_info->endio_freespace_worker;
+	else
+		wq = fs_info->endio_write_workers;
+
+	if (page)
+		ASSERT(page->mapping && page_offset(page) <= file_offset &&
+			file_offset + num_bytes <= page_offset(page) + PAGE_SIZE);
 
 	spin_lock_irqsave(&tree->lock, flags);
-	node = tree_search(tree, *file_offset);
-	if (!node)
-		goto out;
+	while (cur < file_offset + num_bytes) {
+		u64 entry_end;
+		u64 end;
+		u32 len;
 
-	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-	if (!in_range(*file_offset, entry->file_offset, entry->num_bytes))
-		goto out;
+		node = tree_search(tree, cur);
+		/* No ordered extent at all */
+		if (!node)
+			break;
 
-	dec_start = max(*file_offset, entry->file_offset);
-	dec_end = min(*file_offset + io_size,
-		      entry->file_offset + entry->num_bytes);
-	*file_offset = dec_end;
-	if (dec_start > dec_end) {
-		btrfs_crit(fs_info, "bad ordering dec_start %llu end %llu",
-			   dec_start, dec_end);
-	}
-	to_dec = dec_end - dec_start;
-	if (to_dec > entry->bytes_left) {
-		btrfs_crit(fs_info,
-			   "bad ordered accounting left %u size %u",
-			   entry->bytes_left, to_dec);
-	}
-	entry->bytes_left -= to_dec;
-	if (!uptodate)
-		set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
+		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
+		entry_end = entry->file_offset + entry->num_bytes;
+		/*
+		 * |<-- OE --->|  |
+		 *		  cur
+		 * Go to next OE.
+		 */
+		if (cur >= entry_end) {
+			node = rb_next(node);
+			/* No more ordered extents, exit*/
+			if (!node)
+				break;
+			entry = rb_entry(node, struct btrfs_ordered_extent,
+					 rb_node);
+
+			/* Go next ordered extent and continue */
+			cur = entry->file_offset;
+			continue;
+		}
+		/*
+		 * |	|<--- OE --->|
+		 * cur
+		 * Go to the start of OE.
+		 */
+		if (cur < entry->file_offset) {
+			cur = entry->file_offset;
+			continue;
+		}
 
-	if (entry->bytes_left == 0) {
 		/*
-		 * Ensure only one caller can set the flag and finished_ret
-		 * accordingly
+		 * Now we are definitely inside one ordered extent.
+		 *
+		 * |<--- OE --->|
+		 *	|
+		 *	cur
 		 */
-		finished = !test_and_set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
-		/* test_and_set_bit implies a barrier */
-		cond_wake_up_nomb(&entry->wait);
-	}
-out:
-	if (finished && finished_ret && entry) {
-		*finished_ret = entry;
-		refcount_inc(&entry->refs);
+		end = min(entry->file_offset + entry->num_bytes,
+			  file_offset + num_bytes) - 1;
+		ASSERT(end + 1 - cur < U32_MAX);
+		len = end + 1 - cur;
+
+		if (page) {
+			/*
+			 * Private2 bit indicates whether we still have pending
+			 * io unfinished for the ordered extent.
+			 *
+			 * If no such bit, we need to skip to next range.
+			 */
+			if (!PagePrivate2(page)) {
+				cur += len;
+				continue;
+			}
+			ClearPagePrivate2(page);
+		}
+
+		/* Now we're fine to update the accounting */
+		if (unlikely(len > entry->bytes_left)) {
+			WARN_ON(1);
+			btrfs_crit(fs_info,
+"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%u to_dec=%u left=%u",
+				   inode->root->root_key.objectid,
+				   btrfs_ino(inode),
+				   entry->file_offset,
+				   entry->num_bytes,
+				   len, entry->bytes_left);
+			entry->bytes_left = 0;
+		} else {
+			entry->bytes_left -= len;
+		}
+
+		if (!uptodate)
+			set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
+
+		/*
+		 * All the IO of the ordered extent is finished, we need to queue
+		 * the finish_func to be executed.
+		 */
+		if (entry->bytes_left == 0) {
+			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
+			/* set_bit implies a barrier */
+			cond_wake_up_nomb(&entry->wait);
+			refcount_inc(&entry->refs);
+			spin_unlock_irqrestore(&tree->lock, flags);
+			btrfs_init_work(&entry->work, finish_func, NULL, NULL);
+			btrfs_queue_work(wq, &entry->work);
+			spin_lock_irqsave(&tree->lock, flags);
+		}
+		cur += len;
 	}
 	spin_unlock_irqrestore(&tree->lock, flags);
-	return finished;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 6906df0c946c..ccf0a81a566f 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -175,13 +175,13 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
+void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
+				struct page *page, u64 file_offset,
+				u32 num_bytes, btrfs_func_t finish_func,
+				bool uptodate);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u32 io_size, int uptodate);
-bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
-				   struct btrfs_ordered_extent **finished_ret,
-				   u64 *file_offset, u32 io_size,
-				   int uptodate);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 disk_bytenr, u64 num_bytes, u64 disk_num_bytes,
 			     int type);
-- 
2.31.1

