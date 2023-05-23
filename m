Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E270D6FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjEWIQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjEWIPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B01FC2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RXcVEABuxW8v9vpji885TPLM7LKQN+cNGKerBlCmARk=; b=AThCsUSfjIQHLYt+8H+1CZxWXw
        XhEongclLcFV7Q1F7hXR4xnzOg3XlURii1MAtL4UnGHAWMek0rAI5Un/oLOEk+qiM6VUC8JFWLQPY
        VXaH1gvVTIQSeeyg4V8p6vVx9xeEvwgNAINxITZKTqdZ4et8fz4Dk0Xr1LPlH25QnjnCGJ6tQSR0M
        3WE/m1Y8rt5B9udgMViP8L82ysYhQ4hDuMu1Gan2W1Dah55d3gGepxGryFrgl7R2j36Q3rdVK7F7e
        jtRJteNGp30p9wuv7DDtSlyqKfBeGlYGrc9i6Vrgm1zPn69jlUDBWt2VACRhdZd8fICqHxNQC4XCt
        9AzSKSSg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9g-009OZh-1u;
        Tue, 23 May 2023 08:14:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs: don't redirty the locked page for extent_write_locked_range
Date:   Tue, 23 May 2023 10:13:20 +0200
Message-Id: <20230523081322.331337-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of redirtying the locked page before calling
extent_write_locked_range, just pass a locked_page argument similar to
many other functions in the btrfs writeback code, and then exclude the
locked page from clearing the dirty bit in extent_write_locked_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 17 ++++++++++-------
 fs/btrfs/extent_io.h |  3 ++-
 fs/btrfs/inode.c     | 25 ++++++-------------------
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 885089afb43ecf..77f0e405280736 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2209,8 +2209,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			      struct writeback_control *wbc)
+int extent_write_locked_range(struct inode *inode, struct page *locked_page,
+			      u64 start, u64 end, struct writeback_control *wbc)
 {
 	bool found_error = false;
 	int first_error = 0;
@@ -2236,14 +2236,17 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
+
 		/*
-		 * All pages in the range are locked since
-		 * btrfs_run_delalloc_range(), thus there is no way to clear
-		 * the page dirty flag.
+		 * All pages have been locked by btrfs_run_delalloc_range(),
+		 * thus the dirty bit can't have been cleared.
 		 */
 		ASSERT(PageLocked(page));
-		ASSERT(PageDirty(page));
-		clear_page_dirty_for_io(page);
+		if (page != locked_page) {
+			/* already cleared by extent_write_cache_pages */
+			ASSERT(PageDirty(page));
+			clear_page_dirty_for_io(page);
+		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
 					    i_size, &nr);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index eb97043672ebec..daef9374c2095f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -177,7 +177,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+int extent_write_locked_range(struct inode *inode, struct page *locked_page,
+			      u64 start, u64 end,
 			      struct writeback_control *wbc);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed137746af82ee..786b88ac0fdd35 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1088,17 +1088,9 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 cleanup_and_bail_uncompressed:
 	/*
 	 * No compression, but we still need to write the pages in the file
-	 * we've been given so far.  redirty the locked page if it corresponds
-	 * to our extent and set things up for the async work queue to run
-	 * cow_file_range to do the normal delalloc dance.
+	 * we've been given so far.  Set things up for the async work queue to
+	 * run cow_file_range to do the normal delalloc dance.
 	 */
-	if (async_chunk->locked_page &&
-	    (page_offset(async_chunk->locked_page) >= start &&
-	     page_offset(async_chunk->locked_page)) <= end) {
-		__set_page_dirty_nobuffers(async_chunk->locked_page);
-		/* unlocked later on in the async handlers */
-	}
-
 	if (redirty)
 		extent_range_redirty_for_io(&inode->vfs_inode, start, end);
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
@@ -1169,7 +1161,8 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 
 	/* All pages will be unlocked, including @locked_page */
 	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	ret = extent_write_locked_range(&inode->vfs_inode, start, end, &wbc);
+	ret = extent_write_locked_range(&inode->vfs_inode, locked_page, start,
+					end, &wbc);
 	wbc_detach_inode(&wbc);
 	return ret;
 }
@@ -1829,7 +1822,6 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 {
 	u64 done_offset = end;
 	int ret;
-	bool locked_page_done = false;
 
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end, page_started,
@@ -1852,13 +1844,8 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 			continue;
 		}
 
-		if (!locked_page_done) {
-			__set_page_dirty_nobuffers(locked_page);
-			account_page_redirty(locked_page);
-		}
-		locked_page_done = true;
-		extent_write_locked_range(&inode->vfs_inode, start, done_offset,
-					  wbc);
+		extent_write_locked_range(&inode->vfs_inode, locked_page, start,
+					  done_offset, wbc);
 		start = done_offset + 1;
 	}
 
-- 
2.39.2

