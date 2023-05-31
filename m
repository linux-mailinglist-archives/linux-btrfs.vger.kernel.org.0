Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6B717699
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjEaGFz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjEaGFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6001122
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BF0s7T9jjp5y++9jrDQKmApJ8ELIrnZZ+2OaNRXxmH4=; b=HH5lwMvMesx/f7mVQn2QEkdq27
        DHfEEIQUKMZm/JfyW2/closnwN+USJKuQZRhH0fm+ebY0fEZfzLTmSlxOqv0U5WDIrujg4giIrRPc
        UCI/9i11u5fI8KCzH73wBdtdXejQ6c4wwJfC6lkr92KC3I2KWnb6TNdXj/cwCODCLYPSf/vTVG/RY
        N87BBw9i3cV7uIr8iq6u0oTdry/8HI6fM+0kHDj67V8o5k4QrAYnigLXnzL+pjZOFOArdvBQEJdoY
        yhBwbBXQviLWTgpwY1yXEWTFemaUP5L67Kqa+J8G/GmvSV1MbPQ98r9tsZB36f5z2jW26/CB84hhg
        Q2lL/kOA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Exz-00GF9M-0U;
        Wed, 31 May 2023 06:05:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs: don't redirty the locked page for extent_write_locked_range
Date:   Wed, 31 May 2023 08:05:03 +0200
Message-Id: <20230531060505.468704-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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
index f4d3c56b29009b..bc061b2ac55a12 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2210,8 +2210,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
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
@@ -2237,14 +2237,17 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
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
index c5fae3a7d911bf..00c468aea010a1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -178,7 +178,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+int extent_write_locked_range(struct inode *inode, struct page *locked_page,
+			      u64 start, u64 end,
 			      struct writeback_control *wbc);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 54b4b241b354fc..68ae20a3f785e3 100644
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

