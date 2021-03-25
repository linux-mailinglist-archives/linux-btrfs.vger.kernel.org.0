Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD73489ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCYHPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhCYHPJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/l97Nl0GztO8SVDESN5IlgIyMNxWJuMno2c2VIMPq1c=;
        b=vGc9/XHBPcp16fa1oB0W4w0OO7QAdsh2HHz1bi7g/YJnQpbJE+Y2++lfu+h2dLlrkXs+18
        753hnVpZDfLHUzZL3SX4Nm24XvwVrsz720RqBj9pY9QR1ENnhJ9CAGfyD2us2VU0zrijhG
        5tmOG/5J9KSVXv1z7LzEg2/cAwd3juo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A1DCAA55
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 04/13] btrfs: refactor how we iterate ordered extent in btrfs_invalidatepage()
Date:   Thu, 25 Mar 2021 15:14:36 +0800
Message-Id: <20210325071445.90896-5-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_invalidatepage(), we need to iterate through all ordered
extents and finish them.

This involved a loop to exhaust all ordered extents, but that loop is
implemented using again: label and goto.

Refactor the code by:
- Use a while() loop
- Extract the code to finish/dec an ordered extent into its own function
  The new function, invalidate_ordered_extent(), will handle the
  extent locking, extent bit update, and to finish/dec ordered extent.

In fact, for regular sectorsize == PAGE_SIZE case, there can only be at
most one ordered extent for one page, thus the code is from ancient
subpage preparation patchset.

But there is a bug hidden inside the ordered extent finish/dec part.

This patch will remove the ability to handle multiple ordered extent,
and add extra ASSERT() to make sure for regular sectorsize we won't have
anything wrong.

For the proper subpage support, it will be added in later patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 122 +++++++++++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d777f67d366b..99dcadd31870 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8355,17 +8355,72 @@ static int btrfs_migratepage(struct address_space *mapping,
 }
 #endif
 
+/*
+ * Helper to finish/dec one ordered extent for btrfs_invalidatepage().
+ *
+ * Return true if the ordered extent is finished.
+ * Return false otherwise
+ */
+static bool invalidate_ordered_extent(struct btrfs_inode *inode,
+				      struct btrfs_ordered_extent *ordered,
+				      struct page *page,
+				      struct extent_state **cached_state,
+				      bool inode_evicting)
+{
+	u64 start = page_offset(page);
+	u64 end = page_offset(page) + PAGE_SIZE - 1;
+	u32 len = PAGE_SIZE;
+	bool completed_ordered = false;
+
+	/*
+	 * For regular sectorsize == PAGE_SIZE, if the ordered extent covers
+	 * the page, then it must cover the full page.
+	 */
+	ASSERT(ordered->file_offset <= start &&
+	       ordered->file_offset + ordered->num_bytes > end);
+	/*
+	 * IO on this page will never be started, so we need to account
+	 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
+	 * here, must leave that up for the ordered extent completion.
+	 */
+	if (!inode_evicting)
+		clear_extent_bit(&inode->io_tree, start, end,
+				 EXTENT_DELALLOC | EXTENT_LOCKED |
+				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 1, 0,
+				 cached_state);
+	/*
+	 * Whoever cleared the private bit is responsible for the
+	 * finish_ordered_io
+	 */
+	if (TestClearPagePrivate2(page)) {
+		spin_lock_irq(&inode->ordered_tree.lock);
+		set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+		ordered->truncated_len = min(ordered->truncated_len,
+					     start - ordered->file_offset);
+		spin_unlock_irq(&inode->ordered_tree.lock);
+
+		if (btrfs_dec_test_ordered_pending(inode, &ordered, start, len, 1)) {
+			btrfs_finish_ordered_io(ordered);
+			completed_ordered = true;
+		}
+	}
+	btrfs_put_ordered_extent(ordered);
+	if (!inode_evicting) {
+		*cached_state = NULL;
+		lock_extent_bits(&inode->io_tree, start, end, cached_state);
+	}
+	return completed_ordered;
+}
+
 static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	struct extent_io_tree *tree = &inode->io_tree;
-	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	u64 page_start = page_offset(page);
 	u64 page_end = page_start + PAGE_SIZE - 1;
-	u64 start;
-	u64 end;
+	u64 cur;
 	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
 	bool found_ordered = false;
 	bool completed_ordered = false;
@@ -8387,51 +8442,24 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	if (!inode_evicting)
 		lock_extent_bits(tree, page_start, page_end, &cached_state);
 
-	start = page_start;
-again:
-	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
-	if (ordered) {
-		found_ordered = true;
-		end = min(page_end,
-			  ordered->file_offset + ordered->num_bytes - 1);
-		/*
-		 * IO on this page will never be started, so we need to account
-		 * for any ordered extents now. Don't clear EXTENT_DELALLOC_NEW
-		 * here, must leave that up for the ordered extent completion.
-		 */
-		if (!inode_evicting)
-			clear_extent_bit(tree, start, end,
-					 EXTENT_DELALLOC |
-					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
-					 EXTENT_DEFRAG, 1, 0, &cached_state);
-		/*
-		 * whoever cleared the private bit is responsible
-		 * for the finish_ordered_io
-		 */
-		if (TestClearPagePrivate2(page)) {
-			spin_lock_irq(&inode->ordered_tree.lock);
-			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-			ordered->truncated_len = min(ordered->truncated_len,
-					start - ordered->file_offset);
-			spin_unlock_irq(&inode->ordered_tree.lock);
-
-			if (btrfs_dec_test_ordered_pending(inode, &ordered,
-							   start,
-							   end - start + 1, 1)) {
-				btrfs_finish_ordered_io(ordered);
-				completed_ordered = true;
-			}
-		}
-		btrfs_put_ordered_extent(ordered);
-		if (!inode_evicting) {
-			cached_state = NULL;
-			lock_extent_bits(tree, start, end,
-					 &cached_state);
-		}
+	cur = page_start;
+	/* Iterate through all the ordered extents covering the page */
+	while (cur < page_end) {
+		struct btrfs_ordered_extent *ordered;
 
-		start = end + 1;
-		if (start < page_end)
-			goto again;
+		ordered = btrfs_lookup_ordered_range(inode, cur,
+				page_end - cur + 1);
+		if (ordered) {
+			cur = ordered->file_offset + ordered->num_bytes;
+
+			found_ordered = true;
+			completed_ordered = invalidate_ordered_extent(inode,
+					ordered, page, &cached_state,
+					inode_evicting);
+		} else {
+			/* Exhausted all ordered extents */
+			break;
+		}
 	}
 
 	/*
-- 
2.30.1

