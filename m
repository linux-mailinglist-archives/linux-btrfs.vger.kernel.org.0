Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4D27DE03
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgI3B4K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:49840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3B4J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaDb83mY1Pgo031yykI/EvSI0K3g87Yh/Tx9r1dlER4=;
        b=VInqcMNDN2/WENS9Z3OdZDxqIQ+kNPLJg89VMYaKQNL/bDoZfxp9SNzLnFoHJH/Kgc+NC5
        1mq8afqOfTLb04sCnSlxJtVuODKeo39FAgeEjM6lkDtsyM3ReTmf8oRp0r1mVN8gpCw4mf
        ib/IqVLSPg+LIKdkqOZw9g7lpDvDPdg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10BEBAF99
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/49] btrfs: extent_io: make process_pages_contig() to accept bytenr directly
Date:   Wed, 30 Sep 2020 09:55:01 +0800
Message-Id: <20200930015539.48867-12-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of page index, accept bytenr directly for
process_pages_contig().

This allows process_pages_contig() to accept ranges which is not aligned
to page size, while still report accurate @end_ret.

Currently we still only accept page aligned values, but this provides
the basis for later subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 78 ++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 07f8117ddbb4..d35eae29bc80 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1810,46 +1810,58 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 	return found;
 }
 
+static int calc_bytes_processed(struct page *page, u64 range_start)
+{
+	u64 page_start = page_offset(page);
+	u64 real_start = max(range_start, page_start);
+
+	return page_start + PAGE_SIZE - real_start;
+}
+
 /*
  * A helper to update contiguous pages status according to @page_ops.
  *
  * @mapping:		The address space of the pages
  * @locked_page:	The already locked page. Mostly for inline extent
  * 			handling
- * @start_index:	The start page index.
- * @end_inde:		The last page index.
+ * @start:		The start file offset
+ * @end:		The end file offset (inclusive)
  * @pages_opts:		The operations to be done
- * @index_ret:		The last handled page index (for error case)
+ * @end_ret:		The last handled inclusive file offset (for error case)
  *
  * Return 0 if every page is handled properly.
- * Return <0 if something wrong happened, and update @index_ret.
+ * Return <0 if something wrong happened, and update @end_ret.
  */
 static int process_pages_contig(struct address_space *mapping,
 				struct page *locked_page,
-				pgoff_t start_index, pgoff_t end_index,
-				unsigned long page_ops, pgoff_t *index_ret)
+				u64 start, u64 end,
+				unsigned long page_ops, u64 *end_ret)
 {
-	unsigned long nr_pages = end_index - start_index + 1;
-	unsigned long pages_processed = 0;
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
+	u64 processed_end = start - 1;
+	unsigned long nr_pages = end_index - start_index + 1;
 	struct page *pages[16];
-	unsigned ret;
 	int err = 0;
 	int i;
 
+	ASSERT(IS_ALIGNED(start, PAGE_SIZE) && IS_ALIGNED(end + 1, PAGE_SIZE));
 	if (page_ops & PAGE_LOCK) {
 		ASSERT(page_ops == PAGE_LOCK);
-		ASSERT(index_ret && *index_ret == start_index);
+		ASSERT(end_ret && *end_ret == start - 1);
 	}
 
 	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
 		mapping_set_error(mapping, -EIO);
 
 	while (nr_pages > 0) {
-		ret = find_get_pages_contig(mapping, index,
+		unsigned found_pages;
+
+		found_pages = find_get_pages_contig(mapping, index,
 				     min_t(unsigned long,
 				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (ret == 0) {
+		if (found_pages == 0) {
 			/*
 			 * Only if we're going to lock these pages,
 			 * can we find nothing at @index.
@@ -1859,13 +1871,14 @@ static int process_pages_contig(struct address_space *mapping,
 			goto out;
 		}
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < found_pages; i++) {
 			if (page_ops & PAGE_SET_PRIVATE2)
 				SetPagePrivate2(pages[i]);
 
 			if (locked_page && pages[i] == locked_page) {
 				put_page(pages[i]);
-				pages_processed++;
+				processed_end +=
+					calc_bytes_processed(pages[i], start);
 				continue;
 			}
 			if (page_ops & PAGE_CLEAR_DIRTY)
@@ -1883,22 +1896,22 @@ static int process_pages_contig(struct address_space *mapping,
 				if (!PageDirty(pages[i]) ||
 				    pages[i]->mapping != mapping) {
 					unlock_page(pages[i]);
-					for (; i < ret; i++)
+					for (; i < found_pages; i++)
 						put_page(pages[i]);
 					err = -EAGAIN;
 					goto out;
 				}
 			}
 			put_page(pages[i]);
-			pages_processed++;
+			processed_end += calc_bytes_processed(pages[i], start);
 		}
-		nr_pages -= ret;
-		index += ret;
+		nr_pages -= found_pages;
+		index += found_pages;
 		cond_resched();
 	}
 out:
-	if (err && index_ret)
-		*index_ret = start_index + pages_processed - 1;
+	if (err && end_ret)
+		*end_ret = processed_end;
 	return err;
 }
 
@@ -1907,15 +1920,12 @@ static noinline void __unlock_for_delalloc(struct inode *inode,
 					   struct page *locked_page,
 					   u64 start, u64 end)
 {
-	unsigned long index = start >> PAGE_SHIFT;
-	unsigned long end_index = end >> PAGE_SHIFT;
-
 	ASSERT(locked_page);
-	if (index == locked_page->index && end_index == index)
+	if (end < start)
 		return;
 
-	process_pages_contig(inode->i_mapping, locked_page, index, end_index,
-			       PAGE_UNLOCK, NULL);
+	process_pages_contig(inode->i_mapping, locked_page, start, end,
+			     PAGE_UNLOCK, NULL);
 }
 
 static noinline int lock_delalloc_pages(struct inode *inode,
@@ -1923,20 +1933,19 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 					u64 delalloc_start,
 					u64 delalloc_end)
 {
-	unsigned long index = delalloc_start >> PAGE_SHIFT;
-	unsigned long index_ret = index;
-	unsigned long end_index = delalloc_end >> PAGE_SHIFT;
+	u64 processed_end = delalloc_start - 1;
 	int ret;
 
 	ASSERT(locked_page);
-	if (index == locked_page->index && index == end_index)
+	if (delalloc_end < delalloc_start)
 		return 0;
 
-	ret = process_pages_contig(inode->i_mapping, locked_page, index,
-				     end_index, PAGE_LOCK, &index_ret);
+	ret = process_pages_contig(inode->i_mapping, locked_page,
+				   delalloc_start, delalloc_end, PAGE_LOCK,
+				   &processed_end);
 	if (ret == -EAGAIN)
 		__unlock_for_delalloc(inode, locked_page, delalloc_start,
-				      (u64)index_ret << PAGE_SHIFT);
+				      processed_end);
 	return ret;
 }
 
@@ -2037,8 +2046,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
 
 	process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
-			       start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-			       page_ops, NULL);
+			     start, end, page_ops, NULL);
 }
 
 /*
-- 
2.28.0

