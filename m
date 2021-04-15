Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4674236015D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhDOFFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhDOFFm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=if+i7HkSF1tgnbcTWkSY8O6ARv9MWJu/SGcvyEV9FFw=;
        b=nDhYX04NSwy5MU2k/Cih6wFrge0WhirIbpnU1jWivxpdpzThTQGZQcdTKC3DS7RLo3tAB0
        dmChN0Yje7UYbUaIKCJG17HoN5s5dw5sfxmTsYtXa1/i8ZWDQKDrQ9WWbew6HEmwbhMyZ2
        3KkM3sBq3bRzgjTXJ6tqaG+7WqgS4PM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1196BAF39
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/42] btrfs: pass bytenr directly to __process_pages_contig()
Date:   Thu, 15 Apr 2021 13:04:20 +0800
Message-Id: <20210415050448.267306-15-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparation for incoming subpage support, we need bytenr passed to
__process_pages_contig() directly, not the current page index.

So change the parameter and all callers to pass bytenr in.

With the modification, here we need to replace the old @index_ret with
@processed_end for __process_pages_contig(), but this brings a small
problem.

Normally we follow the inclusive return value, meaning @processed_end
should be the last byte we processed.

If parameter @start is 0, and we failed to lock any page, then we would
return @processed_end as -1, causing more problems for
__unlock_for_delalloc().

So here for @processed_end, we use two different return value patterns.
If we have locked any page, @processed_end will be the last byte of
locked page.
Or it will be @start otherwise.

This change will impact lock_delalloc_pages(), so it needs to check
@processed_end to only unlock the range if we have locked any.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 57 ++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac01f29b00c9..ff24db8513b4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1807,8 +1807,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 
 static int __process_pages_contig(struct address_space *mapping,
 				  struct page *locked_page,
-				  pgoff_t start_index, pgoff_t end_index,
-				  unsigned long page_ops, pgoff_t *index_ret);
+				  u64 start, u64 end, unsigned long page_ops,
+				  u64 *processed_end);
 
 static noinline void __unlock_for_delalloc(struct inode *inode,
 					   struct page *locked_page,
@@ -1821,7 +1821,7 @@ static noinline void __unlock_for_delalloc(struct inode *inode,
 	if (index == locked_page->index && end_index == index)
 		return;
 
-	__process_pages_contig(inode->i_mapping, locked_page, index, end_index,
+	__process_pages_contig(inode->i_mapping, locked_page, start, end,
 			       PAGE_UNLOCK, NULL);
 }
 
@@ -1831,19 +1831,19 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 					u64 delalloc_end)
 {
 	unsigned long index = delalloc_start >> PAGE_SHIFT;
-	unsigned long index_ret = index;
 	unsigned long end_index = delalloc_end >> PAGE_SHIFT;
+	u64 processed_end = delalloc_start;
 	int ret;
 
 	ASSERT(locked_page);
 	if (index == locked_page->index && index == end_index)
 		return 0;
 
-	ret = __process_pages_contig(inode->i_mapping, locked_page, index,
-				     end_index, PAGE_LOCK, &index_ret);
-	if (ret == -EAGAIN)
+	ret = __process_pages_contig(inode->i_mapping, locked_page, delalloc_start,
+				     delalloc_end, PAGE_LOCK, &processed_end);
+	if (ret == -EAGAIN && processed_end > delalloc_start)
 		__unlock_for_delalloc(inode, locked_page, delalloc_start,
-				      (u64)index_ret << PAGE_SHIFT);
+				      processed_end);
 	return ret;
 }
 
@@ -1938,12 +1938,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 static int __process_pages_contig(struct address_space *mapping,
 				  struct page *locked_page,
-				  pgoff_t start_index, pgoff_t end_index,
-				  unsigned long page_ops, pgoff_t *index_ret)
+				  u64 start, u64 end, unsigned long page_ops,
+				  u64 *processed_end)
 {
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
+	pgoff_t index = start_index;
 	unsigned long nr_pages = end_index - start_index + 1;
 	unsigned long pages_processed = 0;
-	pgoff_t index = start_index;
 	struct page *pages[16];
 	unsigned ret;
 	int err = 0;
@@ -1951,17 +1953,19 @@ static int __process_pages_contig(struct address_space *mapping,
 
 	if (page_ops & PAGE_LOCK) {
 		ASSERT(page_ops == PAGE_LOCK);
-		ASSERT(index_ret && *index_ret == start_index);
+		ASSERT(processed_end && *processed_end == start);
 	}
 
 	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
 		mapping_set_error(mapping, -EIO);
 
 	while (nr_pages > 0) {
-		ret = find_get_pages_contig(mapping, index,
+		int found_pages;
+
+		found_pages = find_get_pages_contig(mapping, index,
 				     min_t(unsigned long,
 				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (ret == 0) {
+		if (found_pages == 0) {
 			/*
 			 * Only if we're going to lock these pages,
 			 * can we find nothing at @index.
@@ -2004,13 +2008,27 @@ static int __process_pages_contig(struct address_space *mapping,
 			put_page(pages[i]);
 			pages_processed++;
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
+
+	}
 	return err;
 }
 
@@ -2021,8 +2039,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
 
 	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
-			       start >> PAGE_SHIFT, end >> PAGE_SHIFT,
-			       page_ops, NULL);
+			       start, end, page_ops, NULL);
 }
 
 /*
-- 
2.31.1

