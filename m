Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59848294826
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440728AbgJUG0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:42716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440725AbgJUG0X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkJnHkjRGv5xVQjiOoPJ4yNmrnt5iUJgNIk6BvQvbns=;
        b=ZmQGzxZuRbAfnQDZRW2wxgrUE+L5Or+tD8wjC8R+9+cnxSUsZql2UePxj1smk8TATPpYIe
        pdiNjS2Rq/TYAZtG4pXJXv3vpzlxbUfkUDxvGJi8iTneq3shaZCMNHGj6hTae7GwbTEsfC
        a/3GGR9w7gVGMpc84nhRjaHO9UCP5vw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8ED1BAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 10/68] btrfs: extent_io: remove the forward declaration and rename __process_pages_contig
Date:   Wed, 21 Oct 2020 14:24:56 +0800
Message-Id: <20201021062554.68132-11-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need to do forward declaration for __process_pages_contig(),
so move it before it get first called.

Since we are here, also remove the "__" prefix since there is no special
meaning for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 180 +++++++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 85 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3f95c67f0c92..d5e03977c9c8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1814,10 +1814,98 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 	return found;
 }
 
-static int __process_pages_contig(struct address_space *mapping,
-				  struct page *locked_page,
-				  pgoff_t start_index, pgoff_t end_index,
-				  unsigned long page_ops, pgoff_t *index_ret);
+/*
+ * A helper to update contiguous pages status according to @page_ops.
+ *
+ * @mapping:		The address space of the pages
+ * @locked_page:	The already locked page. Mostly for inline extent
+ * 			handling
+ * @start_index:	The start page index.
+ * @end_inde:		The last page index.
+ * @pages_opts:		The operations to be done
+ * @index_ret:		The last handled page index (for error case)
+ *
+ * Return 0 if every page is handled properly.
+ * Return <0 if something wrong happened, and update @index_ret.
+ */
+static int process_pages_contig(struct address_space *mapping,
+				struct page *locked_page,
+				pgoff_t start_index, pgoff_t end_index,
+				unsigned long page_ops, pgoff_t *index_ret)
+{
+	unsigned long nr_pages = end_index - start_index + 1;
+	unsigned long pages_locked = 0;
+	pgoff_t index = start_index;
+	struct page *pages[16];
+	unsigned ret;
+	int err = 0;
+	int i;
+
+	if (page_ops & PAGE_LOCK) {
+		ASSERT(page_ops == PAGE_LOCK);
+		ASSERT(index_ret && *index_ret == start_index);
+	}
+
+	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
+		mapping_set_error(mapping, -EIO);
+
+	while (nr_pages > 0) {
+		ret = find_get_pages_contig(mapping, index,
+				     min_t(unsigned long,
+				     nr_pages, ARRAY_SIZE(pages)), pages);
+		if (ret == 0) {
+			/*
+			 * Only if we're going to lock these pages,
+			 * can we find nothing at @index.
+			 */
+			ASSERT(page_ops & PAGE_LOCK);
+			err = -EAGAIN;
+			goto out;
+		}
+
+		for (i = 0; i < ret; i++) {
+			if (page_ops & PAGE_SET_PRIVATE2)
+				SetPagePrivate2(pages[i]);
+
+			if (locked_page && pages[i] == locked_page) {
+				put_page(pages[i]);
+				pages_locked++;
+				continue;
+			}
+			if (page_ops & PAGE_CLEAR_DIRTY)
+				clear_page_dirty_for_io(pages[i]);
+			if (page_ops & PAGE_SET_WRITEBACK)
+				set_page_writeback(pages[i]);
+			if (page_ops & PAGE_SET_ERROR)
+				SetPageError(pages[i]);
+			if (page_ops & PAGE_END_WRITEBACK)
+				end_page_writeback(pages[i]);
+			if (page_ops & PAGE_UNLOCK)
+				unlock_page(pages[i]);
+			if (page_ops & PAGE_LOCK) {
+				lock_page(pages[i]);
+				if (!PageDirty(pages[i]) ||
+				    pages[i]->mapping != mapping) {
+					unlock_page(pages[i]);
+					for (; i < ret; i++)
+						put_page(pages[i]);
+					err = -EAGAIN;
+					goto out;
+				}
+			}
+			put_page(pages[i]);
+			pages_locked++;
+		}
+		nr_pages -= ret;
+		index += ret;
+		cond_resched();
+	}
+out:
+	if (err && index_ret)
+		*index_ret = start_index + pages_locked - 1;
+	return err;
+}
+
 
 static noinline void __unlock_for_delalloc(struct inode *inode,
 					   struct page *locked_page,
@@ -1830,7 +1918,7 @@ static noinline void __unlock_for_delalloc(struct inode *inode,
 	if (index == locked_page->index && end_index == index)
 		return;
 
-	__process_pages_contig(inode->i_mapping, locked_page, index, end_index,
+	process_pages_contig(inode->i_mapping, locked_page, index, end_index,
 			       PAGE_UNLOCK, NULL);
 }
 
@@ -1848,7 +1936,7 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 	if (index == locked_page->index && index == end_index)
 		return 0;
 
-	ret = __process_pages_contig(inode->i_mapping, locked_page, index,
+	ret = process_pages_contig(inode->i_mapping, locked_page, index,
 				     end_index, PAGE_LOCK, &index_ret);
 	if (ret == -EAGAIN)
 		__unlock_for_delalloc(inode, locked_page, delalloc_start,
@@ -1945,84 +2033,6 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	return found;
 }
 
-static int __process_pages_contig(struct address_space *mapping,
-				  struct page *locked_page,
-				  pgoff_t start_index, pgoff_t end_index,
-				  unsigned long page_ops, pgoff_t *index_ret)
-{
-	unsigned long nr_pages = end_index - start_index + 1;
-	unsigned long pages_locked = 0;
-	pgoff_t index = start_index;
-	struct page *pages[16];
-	unsigned ret;
-	int err = 0;
-	int i;
-
-	if (page_ops & PAGE_LOCK) {
-		ASSERT(page_ops == PAGE_LOCK);
-		ASSERT(index_ret && *index_ret == start_index);
-	}
-
-	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
-		mapping_set_error(mapping, -EIO);
-
-	while (nr_pages > 0) {
-		ret = find_get_pages_contig(mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (ret == 0) {
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
-			if (page_ops & PAGE_SET_PRIVATE2)
-				SetPagePrivate2(pages[i]);
-
-			if (locked_page && pages[i] == locked_page) {
-				put_page(pages[i]);
-				pages_locked++;
-				continue;
-			}
-			if (page_ops & PAGE_CLEAR_DIRTY)
-				clear_page_dirty_for_io(pages[i]);
-			if (page_ops & PAGE_SET_WRITEBACK)
-				set_page_writeback(pages[i]);
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
-			pages_locked++;
-		}
-		nr_pages -= ret;
-		index += ret;
-		cond_resched();
-	}
-out:
-	if (err && index_ret)
-		*index_ret = start_index + pages_locked - 1;
-	return err;
-}
-
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  unsigned clear_bits,
@@ -2030,7 +2040,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 {
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
 
-	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
+	process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
 			       start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 			       page_ops, NULL);
 }
-- 
2.28.0

