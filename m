Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4138BFC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhEUGny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:43:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234467AbhEUGm1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:42:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QATExfCUf3J+e5cZIe2WK2lef4CickjkZYd9of5Qq4A=;
        b=dlj++btk5jtfoyfOaHzA+R5oWj502rIZWrKGLnwbJbLpS2p9AcKpBTffCJde86iCz5K3mx
        xm9OH2SkaXll0U4rVjRRUiyI+qqanpq3Z+3WJ0OK//Cv3Aj0jVIvNMXAA13BAO/BX2fUX4
        1cVnCBKnlbpvhDVMNIjao/Dq7X48Vk8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E4FFAC1A;
        Fri, 21 May 2021 06:40:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 02/31] btrfs: refactor the page status update into process_one_page()
Date:   Fri, 21 May 2021 14:40:21 +0800
Message-Id: <20210521064050.191164-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In __process_pages_contig() we update page status according to page_ops.

That update process is a bunch of if () {} branches, which lies inside
two loops, this makes it pretty hard to expand for later subpage
operations.

So this patch will extract this operations into its own function,
process_one_pages().

Also since we're refactoring __process_pages_contig(), also move the new
helper and __process_pages_contig() before the first caller of them, to
remove the forward declaration.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 206 +++++++++++++++++++++++--------------------
 1 file changed, 109 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c2914f851692..aa112a51b0d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1808,10 +1808,118 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 	return found;
 }
 
+/*
+ * Process one page for __process_pages_contig().
+ *
+ * Return >0 if we hit @page == @locked_page.
+ * Return 0 if we updated the page status.
+ * Return -EGAIN if the we need to try again.
+ * (For PAGE_LOCK case but got dirty page or page not belong to mapping)
+ */
+static int process_one_page(struct address_space *mapping,
+			    struct page *page, struct page *locked_page,
+			    unsigned long page_ops)
+{
+	if (page_ops & PAGE_SET_ORDERED)
+		SetPageOrdered(page);
+
+	if (page == locked_page)
+		return 1;
+
+	if (page_ops & PAGE_SET_ERROR)
+		SetPageError(page);
+	if (page_ops & PAGE_START_WRITEBACK) {
+		clear_page_dirty_for_io(page);
+		set_page_writeback(page);
+	}
+	if (page_ops & PAGE_END_WRITEBACK)
+		end_page_writeback(page);
+	if (page_ops & PAGE_LOCK) {
+		lock_page(page);
+		if (!PageDirty(page) || page->mapping != mapping) {
+			unlock_page(page);
+			return -EAGAIN;
+		}
+	}
+	if (page_ops & PAGE_UNLOCK)
+		unlock_page(page);
+	return 0;
+}
+
 static int __process_pages_contig(struct address_space *mapping,
 				  struct page *locked_page,
 				  u64 start, u64 end, unsigned long page_ops,
-				  u64 *processed_end);
+				  u64 *processed_end)
+{
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
+	pgoff_t index = start_index;
+	unsigned long nr_pages = end_index - start_index + 1;
+	unsigned long pages_processed = 0;
+	struct page *pages[16];
+	int err = 0;
+	int i;
+
+	if (page_ops & PAGE_LOCK) {
+		ASSERT(page_ops == PAGE_LOCK);
+		ASSERT(processed_end && *processed_end == start);
+	}
+
+	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
+		mapping_set_error(mapping, -EIO);
+
+	while (nr_pages > 0) {
+		int found_pages;
+
+		found_pages = find_get_pages_contig(mapping, index,
+				     min_t(unsigned long,
+				     nr_pages, ARRAY_SIZE(pages)), pages);
+		if (found_pages == 0) {
+			/*
+			 * Only if we're going to lock these pages,
+			 * can we find nothing at @index.
+			 */
+			ASSERT(page_ops & PAGE_LOCK);
+			err = -EAGAIN;
+			goto out;
+		}
+
+		for (i = 0; i < found_pages; i++) {
+			int process_ret;
+
+			process_ret = process_one_page(mapping, pages[i],
+					locked_page, page_ops);
+			if (process_ret < 0) {
+				for (; i < found_pages; i++)
+					put_page(pages[i]);
+				err = -EAGAIN;
+				goto out;
+			}
+			put_page(pages[i]);
+			pages_processed++;
+		}
+		nr_pages -= found_pages;
+		index += found_pages;
+		cond_resched();
+	}
+out:
+	if (err && processed_end) {
+		/*
+		 * Update @processed_end. I know this is awful since it has
+		 * two different return value patterns (inclusive vs exclusive).
+		 *
+		 * But the exclusive pattern is necessary if @start is 0, or we
+		 * underflow and check against processed_end won't work as
+		 * expected.
+		 */
+		if (pages_processed)
+			*processed_end = min(end,
+			((u64)(start_index + pages_processed) << PAGE_SHIFT) - 1);
+		else
+			*processed_end = start;
+	}
+	return err;
+}
 
 static noinline void __unlock_for_delalloc(struct inode *inode,
 					   struct page *locked_page,
@@ -1939,102 +2047,6 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	return found;
 }
 
-static int __process_pages_contig(struct address_space *mapping,
-				  struct page *locked_page,
-				  u64 start, u64 end, unsigned long page_ops,
-				  u64 *processed_end)
-{
-	pgoff_t start_index = start >> PAGE_SHIFT;
-	pgoff_t end_index = end >> PAGE_SHIFT;
-	pgoff_t index = start_index;
-	unsigned long nr_pages = end_index - start_index + 1;
-	unsigned long pages_processed = 0;
-	struct page *pages[16];
-	unsigned ret;
-	int err = 0;
-	int i;
-
-	if (page_ops & PAGE_LOCK) {
-		ASSERT(page_ops == PAGE_LOCK);
-		ASSERT(processed_end && *processed_end == start);
-	}
-
-	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
-		mapping_set_error(mapping, -EIO);
-
-	while (nr_pages > 0) {
-		int found_pages;
-
-		found_pages = find_get_pages_contig(mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (found_pages == 0) {
-			/*
-			 * Only if we're going to lock these pages,
-			 * can we find nothing at @index.
-			 */
-			ASSERT(page_ops & PAGE_LOCK);
-			err = -EAGAIN;
-			goto out;
-		}
-
-		for (i = 0; i < ret; i++) {
-			if (page_ops & PAGE_SET_ORDERED)
-				SetPageOrdered(pages[i]);
-
-			if (locked_page && pages[i] == locked_page) {
-				put_page(pages[i]);
-				pages_processed++;
-				continue;
-			}
-			if (page_ops & PAGE_START_WRITEBACK) {
-				clear_page_dirty_for_io(pages[i]);
-				set_page_writeback(pages[i]);
-			}
-			if (page_ops & PAGE_SET_ERROR)
-				SetPageError(pages[i]);
-			if (page_ops & PAGE_END_WRITEBACK)
-				end_page_writeback(pages[i]);
-			if (page_ops & PAGE_UNLOCK)
-				unlock_page(pages[i]);
-			if (page_ops & PAGE_LOCK) {
-				lock_page(pages[i]);
-				if (!PageDirty(pages[i]) ||
-				    pages[i]->mapping != mapping) {
-					unlock_page(pages[i]);
-					for (; i < ret; i++)
-						put_page(pages[i]);
-					err = -EAGAIN;
-					goto out;
-				}
-			}
-			put_page(pages[i]);
-			pages_processed++;
-		}
-		nr_pages -= found_pages;
-		index += found_pages;
-		cond_resched();
-	}
-out:
-	if (err && processed_end) {
-		/*
-		 * Update @processed_end. I know this is awful since it has
-		 * two different return value patterns (inclusive vs exclusive).
-		 *
-		 * But the exclusive pattern is necessary if @start is 0, or we
-		 * underflow and check against processed_end won't work as
-		 * expected.
-		 */
-		if (pages_processed)
-			*processed_end = min(end,
-			((u64)(start_index + pages_processed) << PAGE_SHIFT) - 1);
-		else
-			*processed_end = start;
-
-	}
-	return err;
-}
-
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 clear_bits, unsigned long page_ops)
-- 
2.31.1

