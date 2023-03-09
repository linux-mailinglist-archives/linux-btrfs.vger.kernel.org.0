Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80316B1F5C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCIJHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCIJGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094339B8D
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oTvudiTt4/QTfvP+6AolqzpL2LobYg5m/w+70HyF4Mw=; b=lDoSeAjt2p6JbvbZt67gU6++HO
        aPoMxXm7aEFI5P/mKV2H+k5YmdzuwSBSkPJHY4xq4iCj+GpxxYl4BDnWCUFMvryJ0Z36Q4PrnkA4g
        Qa2v2wkbeOw2HjjGaaHvfl0U67c9xhBCPmlt0JumaTM/ZYQGUVOYwPaH78lpQRlfe2edPlGpdGw/P
        oy03mpCHUkowUHD+KPgm3sWpzBEUXkIXRtCk0rzOPojC+58bZGuQ2EsH19zMn7qPefXWhsMg/pWbc
        twe4oLGowP/tc+S0usJJmDVyW0A2eR7ONTpm4P3ZQ+ls8zIZfahHC+jVM6WIxoPEUexTykPTmkn9o
        poGEvoBA==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEG-008hnR-3R; Thu, 09 Mar 2023 09:06:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/20] btrfs: submit a writeback bio per extent_buffer
Date:   Thu,  9 Mar 2023 10:05:16 +0100
Message-Id: <20230309090526.332550-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Stop trying to cluster writes of multiple extent_buffers into a single
bio.  There is no need for that as the blk_plug mechanism used all the
way up in writeback_inodes_wb gives us the same I/O pattern even with
multiple bios.  Removing the clustering simplifies
lock_extent_buffer_for_io a lot and will also allow passing the eb
as private data to the end I/O handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 102 ++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1e8670d7fc2e71..ffcc700ea52196 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1626,41 +1626,24 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
 /*
  * Lock extent buffer status and pages for writeback.
  *
- * May try to flush write bio if we can't get the lock.
- *
  * Return %false if the extent buffer doesn't need to be submitted (e.g. the
  * extent buffer is not dirty)
  * Return %true is the extent buffer is submitted to bio.
  */
 static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
-				      struct btrfs_bio_ctrl *bio_ctrl)
+				      struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int i, num_pages;
-	int flush = 0;
 	bool ret = false;
+	int i;
 
-	if (!btrfs_try_tree_write_lock(eb)) {
-		submit_write_bio(bio_ctrl, 0);
-		flush = 1;
-		btrfs_tree_lock(eb);
-	}
-
-	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
+	btrfs_tree_lock(eb);
+	while (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
-		if (bio_ctrl->wbc->sync_mode != WB_SYNC_ALL)
+		if (wbc->sync_mode != WB_SYNC_ALL)
 			return false;
-		if (!flush) {
-			submit_write_bio(bio_ctrl, 0);
-			flush = 1;
-		}
-		while (1) {
-			wait_on_extent_buffer_writeback(eb);
-			btrfs_tree_lock(eb);
-			if (!test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags))
-				break;
-			btrfs_tree_unlock(eb);
-		}
+		wait_on_extent_buffer_writeback(eb);
+		btrfs_tree_lock(eb);
 	}
 
 	/*
@@ -1692,19 +1675,8 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
 	if (!ret || fs_info->nodesize < PAGE_SIZE)
 		return ret;
 
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
-
-		if (!trylock_page(p)) {
-			if (!flush) {
-				submit_write_bio(bio_ctrl, 0);
-				flush = 1;
-			}
-			lock_page(p);
-		}
-	}
-
+	for (i = 0; i < num_extent_pages(eb); i++)
+		lock_page(eb->pages[i]);
 	return ret;
 }
 
@@ -1934,11 +1906,16 @@ static void prepare_eb_write(struct extent_buffer *eb)
  * Page locking is only utilized at minimum to keep the VMM code happy.
  */
 static void write_one_subpage_eb(struct extent_buffer *eb,
-				 struct btrfs_bio_ctrl *bio_ctrl)
+				 struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
 	bool no_dirty_ebs = false;
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = wbc,
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
+		.end_io_func = end_bio_subpage_eb_writepage,
+	};
 
 	prepare_eb_write(eb);
 
@@ -1952,40 +1929,43 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
-	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
-
-	submit_extent_page(bio_ctrl, eb->start, page, eb->len,
+	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
 			   eb->start - page_offset(page));
 	unlock_page(page);
+	submit_one_bio(&bio_ctrl);
 	/*
 	 * Submission finished without problem, if no range of the page is
 	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
 	 */
 	if (no_dirty_ebs)
-		bio_ctrl->wbc->nr_to_write--;
+		wbc->nr_to_write--;
 }
 
 static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
-			struct btrfs_bio_ctrl *bio_ctrl)
+					    struct writeback_control *wbc)
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = wbc,
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
+		.end_io_func = end_bio_extent_buffer_writepage,
+	};
 
 	prepare_eb_write(eb);
 
-	bio_ctrl->end_io_func = end_bio_extent_buffer_writepage;
-
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		submit_extent_page(bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
+		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
 		disk_bytenr += PAGE_SIZE;
-		bio_ctrl->wbc->nr_to_write--;
+		wbc->nr_to_write--;
 		unlock_page(p);
 	}
+	submit_one_bio(&bio_ctrl);
 }
 
 /*
@@ -2002,7 +1982,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  * Return >=0 for the number of submitted extent buffers.
  * Return <0 for fatal error.
  */
-static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
+static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	int submitted = 0;
@@ -2054,8 +2034,8 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 		if (!eb)
 			continue;
 
-		if (lock_extent_buffer_for_io(eb, bio_ctrl)) {
-			write_one_subpage_eb(eb, bio_ctrl);
+		if (lock_extent_buffer_for_io(eb, wbc)) {
+			write_one_subpage_eb(eb, wbc);
 			submitted++;
 		}
 		free_extent_buffer(eb);
@@ -2083,7 +2063,7 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
+static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
@@ -2095,7 +2075,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		return 0;
 
 	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, bio_ctrl);
+		return submit_eb_subpage(page, wbc);
 
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
@@ -2128,8 +2108,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
 		 */
-		if (bio_ctrl->wbc->sync_mode == WB_SYNC_ALL &&
-		    !bio_ctrl->wbc->for_sync)
+		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 			ret = -EAGAIN;
 		else
 			ret = 0;
@@ -2139,12 +2118,12 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 
 	*eb_context = eb;
 
-	if (!lock_extent_buffer_for_io(eb, bio_ctrl)) {
+	if (!lock_extent_buffer_for_io(eb, wbc)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
 			btrfs_put_block_group(cache);
 		free_extent_buffer(eb);
-		return ret;
+		return 0;
 	}
 	if (cache) {
 		/*
@@ -2153,7 +2132,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
-	write_one_eb(eb, bio_ctrl);
+	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
 	return 1;
 }
@@ -2162,11 +2141,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb_context = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = {
-		.wbc = wbc,
-		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
-		.extent_locked = 0,
-	};
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -2208,7 +2182,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, &bio_ctrl, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2269,8 +2243,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
-	submit_write_bio(&bio_ctrl, ret);
-
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
-- 
2.39.2

