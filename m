Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A46B8B16
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCNGRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNGRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DBF77C94
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K+tR+e/pzfkKSNDm8HuiiKOMNlX5UWB+76wzv378VQM=; b=Tc+GIxFHOnFwuwKDfj+5dAPasp
        gdn++gXqtpMUE/GsO91odvUQXcl5nmss3ZEgRY7DfPdxgYFPhhiT/UIJsfb8drZEAav25L0Ht4SQ4
        Cvr57n5gYIfYb3FW3rh8LEOgfOgVDW2roS3PA8BXVQVaa0uHTOIiiiAh2Aa2Bh4ytRNAIxW9AavCY
        yqlYgYu0vzxDTuHQAPn4xwlowITB+EvMJ72k6lvBNQsAFaX5ImVz0yxebVD3PF5JmOSkryW01qs74
        qVHDTKGNsKxH9RQDRQspuapl23HUCAoRZjKyvBPVjZLun+B27HTyh/BdHqdqxcg1pNKW5V0h89rMH
        /bXrm5tQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyY-009Amp-Sq; Tue, 14 Mar 2023 06:17:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 11/21] btrfs: submit a writeback bio per extent_buffer
Date:   Tue, 14 Mar 2023 07:16:45 +0100
Message-Id: <20230314061655.245340-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 102 ++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 08e4e53f42e8a7..2d28744793c28d 100644
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
 
@@ -1935,11 +1907,16 @@ static void prepare_eb_write(struct extent_buffer *eb)
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
 
@@ -1953,40 +1930,43 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
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
@@ -2003,7 +1983,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
  * Return >=0 for the number of submitted extent buffers.
  * Return <0 for fatal error.
  */
-static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
+static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	int submitted = 0;
@@ -2055,8 +2035,8 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 		if (!eb)
 			continue;
 
-		if (lock_extent_buffer_for_io(eb, bio_ctrl)) {
-			write_one_subpage_eb(eb, bio_ctrl);
+		if (lock_extent_buffer_for_io(eb, wbc)) {
+			write_one_subpage_eb(eb, wbc);
 			submitted++;
 		}
 		free_extent_buffer(eb);
@@ -2084,7 +2064,7 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
+static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
@@ -2096,7 +2076,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		return 0;
 
 	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, bio_ctrl);
+		return submit_eb_subpage(page, wbc);
 
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
@@ -2129,8 +2109,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
 		 */
-		if (bio_ctrl->wbc->sync_mode == WB_SYNC_ALL &&
-		    !bio_ctrl->wbc->for_sync)
+		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
 			ret = -EAGAIN;
 		else
 			ret = 0;
@@ -2140,12 +2119,12 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 
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
@@ -2154,7 +2133,7 @@ static int submit_eb_page(struct page *page, struct btrfs_bio_ctrl *bio_ctrl,
 		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
-	write_one_eb(eb, bio_ctrl);
+	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
 	return 1;
 }
@@ -2163,11 +2142,6 @@ int btree_write_cache_pages(struct address_space *mapping,
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
@@ -2209,7 +2183,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, &bio_ctrl, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2270,8 +2244,6 @@ int btree_write_cache_pages(struct address_space *mapping,
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

