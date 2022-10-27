Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4A60F5E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiJ0LHX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiJ0LHW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 07:07:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C440BCA
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 04:07:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C9F31FDF7;
        Thu, 27 Oct 2022 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666868839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgTz8/9S31208jTTNCsCGbh9NW5VQays0mwx+VDXf30=;
        b=gPGMMfF9AC/Z/IQTcO6C3CBk44qILRF1lb0jr+fRk5eQgHQ9CTmw/rlNUdWGq7h0FuNuIe
        IDDxZG08re1zLKtarLyoh9187jVDV/E3oLPS2C7XGMrsLfqRlxGD29q2z8uJfXF1dbtcqq
        WcFL+OPb0PgsSPXCrDvZ/AQ/jjQwz6A=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2219D2C141;
        Thu, 27 Oct 2022 11:07:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8DE4EDA79B; Thu, 27 Oct 2022 13:07:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: merge struct extent_page_data to btrfs_bio_ctrl
Date:   Thu, 27 Oct 2022 13:07:05 +0200
Message-Id: <b666aba9b9fe053b28512a742595ad307a56e88b.1666868739.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666868739.git.dsterba@suse.com>
References: <cover.1666868739.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The two structures appear on the same call paths, btrfs_bio_ctrl is
embedded in extent_page_data and we pass bio_ctrl to some functions.
After merging there are fewer indirections and we have only one control
structure. The packing remains same.

The btrfs_bio_ctrl was selected as the target structure as the operation
is closer to bio processing.

Structure layout:

struct btrfs_bio_ctrl {
        struct bio *               bio;                  /*     0     8 */
        int                        mirror_num;           /*     8     4 */
        enum btrfs_compression_type compress_type;       /*    12     4 */
        u32                        len_to_stripe_boundary; /*    16     4 */
        u32                        len_to_oe_boundary;   /*    20     4 */
        btrfs_bio_end_io_t         end_io_func;          /*    24     8 */
        bool                       extent_locked;        /*    32     1 */
        bool                       sync_io;              /*    33     1 */

        /* size: 40, cachelines: 1, members: 8 */
        /* padding: 6 */
        /* last cacheline: 40 bytes */
};

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 117 +++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f83610d3491..fbd0c8432c10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -98,16 +98,14 @@ struct btrfs_bio_ctrl {
 	u32 len_to_stripe_boundary;
 	u32 len_to_oe_boundary;
 	btrfs_bio_end_io_t end_io_func;
-};
 
-struct extent_page_data {
-	struct btrfs_bio_ctrl bio_ctrl;
-	/* tells writepage not to lock the state bits for this range
-	 * it still does the unlocking
+	/*
+	 * Tell writepage not to lock the state bits for this range, it still
+	 * does the unlocking.
 	 */
 	bool extent_locked;
 
-	/* tells the submit_bio code to use REQ_SYNC */
+	/* Tell the submit_bio code to use REQ_SYNC */
 	bool sync_io;
 };
 
@@ -144,11 +142,11 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 }
 
 /*
- * Submit or fail the current bio in an extent_page_data structure.
+ * Submit or fail the current bio in the bio_ctrl structure.
  */
-static void submit_write_bio(struct extent_page_data *epd, int ret)
+static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
 {
-	struct bio *bio = epd->bio_ctrl.bio;
+	struct bio *bio = bio_ctrl->bio;
 
 	if (!bio)
 		return;
@@ -157,9 +155,9 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
 		ASSERT(ret < 0);
 		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
 		/* The bio is owned by the end_io handler now */
-		epd->bio_ctrl.bio = NULL;
+		bio_ctrl->bio = NULL;
 	} else {
-		submit_one_bio(&epd->bio_ctrl);
+		submit_one_bio(bio_ctrl);
 	}
 }
 
@@ -2067,7 +2065,7 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct page *page,
 				 struct writeback_control *wbc,
-				 struct extent_page_data *epd,
+				 struct btrfs_bio_ctrl *bio_ctrl,
 				 loff_t i_size,
 				 int *nr_ret)
 {
@@ -2099,7 +2097,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 */
 	wbc->nr_to_write--;
 
-	epd->bio_ctrl.end_io_func = end_bio_extent_writepage;
+	bio_ctrl->end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
 		u64 disk_bytenr;
 		u64 em_end;
@@ -2193,7 +2191,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
 		ret = submit_extent_page(op | write_flags, wbc,
-					 &epd->bio_ctrl, disk_bytenr,
+					 bio_ctrl, disk_bytenr,
 					 page, iosize,
 					 cur - page_offset(page),
 					 0, false);
@@ -2233,7 +2231,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
  * Return <0 for error.
  */
 static int __extent_writepage(struct page *page, struct writeback_control *wbc,
-			      struct extent_page_data *epd)
+			      struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
@@ -2270,7 +2268,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		goto done;
 	}
 
-	if (!epd->extent_locked) {
+	if (!bio_ctrl->extent_locked) {
 		ret = writepage_delalloc(BTRFS_I(inode), page, wbc);
 		if (ret == 1)
 			return 0;
@@ -2278,7 +2276,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 			goto done;
 	}
 
-	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, epd, i_size,
+	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, bio_ctrl, i_size,
 				    &nr);
 	if (ret == 1)
 		return 0;
@@ -2322,9 +2320,9 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 */
 	if (PageError(page))
 		end_extent_writepage(page, ret, page_start, page_end);
-	if (epd->extent_locked) {
+	if (bio_ctrl->extent_locked) {
 		/*
-		 * If epd->extent_locked, it's from extent_write_locked_range(),
+		 * If bio_ctrl->extent_locked, it's from extent_write_locked_range(),
 		 * the page can either be locked by lock_page() or
 		 * process_one_page().
 		 * Let btrfs_page_unlock_writer() handle both cases.
@@ -2363,7 +2361,7 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  * Return <0 if something went wrong, no page is locked.
  */
 static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
-			  struct extent_page_data *epd)
+			  struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i, num_pages;
@@ -2371,17 +2369,17 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	int ret = 0;
 
 	if (!btrfs_try_tree_write_lock(eb)) {
-		submit_write_bio(epd, 0);
+		submit_write_bio(bio_ctrl, 0);
 		flush = 1;
 		btrfs_tree_lock(eb);
 	}
 
 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
-		if (!epd->sync_io)
+		if (!bio_ctrl->sync_io)
 			return 0;
 		if (!flush) {
-			submit_write_bio(epd, 0);
+			submit_write_bio(bio_ctrl, 0);
 			flush = 1;
 		}
 		while (1) {
@@ -2428,7 +2426,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 		if (!trylock_page(p)) {
 			if (!flush) {
-				submit_write_bio(epd, 0);
+				submit_write_bio(bio_ctrl, 0);
 				flush = 1;
 			}
 			lock_page(p);
@@ -2668,7 +2666,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
  */
 static int write_one_subpage_eb(struct extent_buffer *eb,
 				struct writeback_control *wbc,
-				struct extent_page_data *epd)
+				struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
@@ -2688,10 +2686,10 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
-	epd->bio_ctrl.end_io_func = end_bio_subpage_eb_writepage;
+	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
 
 	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-			&epd->bio_ctrl, eb->start, page, eb->len,
+			bio_ctrl, eb->start, page, eb->len,
 			eb->start - page_offset(page), 0, false);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
@@ -2714,7 +2712,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 
 static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			struct writeback_control *wbc,
-			struct extent_page_data *epd)
+			struct btrfs_bio_ctrl *bio_ctrl)
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
@@ -2723,7 +2721,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 	prepare_eb_write(eb);
 
-	epd->bio_ctrl.end_io_func = end_bio_extent_buffer_writepage;
+	bio_ctrl->end_io_func = end_bio_extent_buffer_writepage;
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
@@ -2732,7 +2730,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 &epd->bio_ctrl, disk_bytenr, p,
+					 bio_ctrl, disk_bytenr, p,
 					 PAGE_SIZE, 0, 0, false);
 		if (ret) {
 			set_btree_ioerr(p, eb);
@@ -2775,7 +2773,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
  */
 static int submit_eb_subpage(struct page *page,
 			     struct writeback_control *wbc,
-			     struct extent_page_data *epd)
+			     struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	int submitted = 0;
@@ -2828,7 +2826,7 @@ static int submit_eb_subpage(struct page *page,
 		if (!eb)
 			continue;
 
-		ret = lock_extent_buffer_for_io(eb, epd);
+		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
 		if (ret == 0) {
 			free_extent_buffer(eb);
 			continue;
@@ -2837,7 +2835,7 @@ static int submit_eb_subpage(struct page *page,
 			free_extent_buffer(eb);
 			goto cleanup;
 		}
-		ret = write_one_subpage_eb(eb, wbc, epd);
+		ret = write_one_subpage_eb(eb, wbc, bio_ctrl);
 		free_extent_buffer(eb);
 		if (ret < 0)
 			goto cleanup;
@@ -2847,7 +2845,7 @@ static int submit_eb_subpage(struct page *page,
 
 cleanup:
 	/* We hit error, end bio for the submitted extent buffers */
-	submit_write_bio(epd, ret);
+	submit_write_bio(bio_ctrl, ret);
 	return ret;
 }
 
@@ -2872,7 +2870,7 @@ static int submit_eb_subpage(struct page *page,
  * Return <0 for fatal error.
  */
 static int submit_eb_page(struct page *page, struct writeback_control *wbc,
-			  struct extent_page_data *epd,
+			  struct btrfs_bio_ctrl *bio_ctrl,
 			  struct extent_buffer **eb_context)
 {
 	struct address_space *mapping = page->mapping;
@@ -2884,7 +2882,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return 0;
 
 	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, wbc, epd);
+		return submit_eb_subpage(page, wbc, bio_ctrl);
 
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
@@ -2927,7 +2925,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 
 	*eb_context = eb;
 
-	ret = lock_extent_buffer_for_io(eb, epd);
+	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
 	if (ret <= 0) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
@@ -2942,7 +2940,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
-	ret = write_one_eb(eb, wbc, epd);
+	ret = write_one_eb(eb, wbc, bio_ctrl);
 	free_extent_buffer(eb);
 	if (ret < 0)
 		return ret;
@@ -2953,10 +2951,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb_context = NULL;
-	struct extent_page_data epd = {
-		.bio_ctrl = { 0 },
+	struct btrfs_bio_ctrl bio_ctrl = {
 		.extent_locked = 0,
-		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
+		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
 	};
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
@@ -2999,7 +2996,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			ret = submit_eb_page(page, wbc, &bio_ctrl, &eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -3060,18 +3057,18 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
-	submit_write_bio(&epd, ret);
+	submit_write_bio(&bio_ctrl, ret);
 
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
-/**
+/*
  * Walk the list of dirty pages of the given address space and write all of them.
  *
- * @mapping: address space structure to write
- * @wbc:     subtract the number of written pages from *@wbc->nr_to_write
- * @epd:     holds context for the write, namely the bio
+ * @mapping:   address space structure to write
+ * @wbc:       subtract the number of written pages from *@wbc->nr_to_write
+ * @bio_ctrl:  holds context for the write, namely the bio
  *
  * If a page is already under I/O, write_cache_pages() skips it, even
  * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
@@ -3083,7 +3080,7 @@ int btree_write_cache_pages(struct address_space *mapping,
  */
 static int extent_write_cache_pages(struct address_space *mapping,
 			     struct writeback_control *wbc,
-			     struct extent_page_data *epd)
+			     struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct inode *inode = mapping->host;
 	int ret = 0;
@@ -3164,7 +3161,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * tmpfs file mapping
 			 */
 			if (!trylock_page(page)) {
-				submit_write_bio(epd, 0);
+				submit_write_bio(bio_ctrl, 0);
 				lock_page(page);
 			}
 
@@ -3175,7 +3172,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				if (PageWriteback(page))
-					submit_write_bio(epd, 0);
+					submit_write_bio(bio_ctrl, 0);
 				wait_on_page_writeback(page);
 			}
 
@@ -3185,7 +3182,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
-			ret = __extent_writepage(page, wbc, epd);
+			ret = __extent_writepage(page, wbc, bio_ctrl);
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -3215,7 +3212,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		 * page in our current bio, and thus deadlock, so flush the
 		 * write bio here.
 		 */
-		submit_write_bio(epd, 0);
+		submit_write_bio(bio_ctrl, 0);
 		goto retry;
 	}
 
@@ -3241,8 +3238,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	u64 cur = start;
 	unsigned long nr_pages;
 	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
-	struct extent_page_data epd = {
-		.bio_ctrl = { 0 },
+	struct btrfs_bio_ctrl bio_ctrl = {
 		.extent_locked = 1,
 		.sync_io = 1,
 	};
@@ -3273,7 +3269,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		ASSERT(PageLocked(page));
 		ASSERT(PageDirty(page));
 		clear_page_dirty_for_io(page);
-		ret = __extent_writepage(page, &wbc_writepages, &epd);
+		ret = __extent_writepage(page, &wbc_writepages, &bio_ctrl);
 		ASSERT(ret <= 0);
 		if (ret < 0) {
 			found_error = true;
@@ -3283,7 +3279,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		cur = cur_end + 1;
 	}
 
-	submit_write_bio(&epd, found_error ? ret : 0);
+	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
 
 	wbc_detach_inode(&wbc_writepages);
 	if (found_error)
@@ -3296,10 +3292,9 @@ int extent_writepages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	int ret = 0;
-	struct extent_page_data epd = {
-		.bio_ctrl = { 0 },
+	struct btrfs_bio_ctrl bio_ctrl = {
 		.extent_locked = 0,
-		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
+		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
 	};
 
 	/*
@@ -3307,8 +3302,8 @@ int extent_writepages(struct address_space *mapping,
 	 * protect the write pointer updates.
 	 */
 	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
-	ret = extent_write_cache_pages(mapping, wbc, &epd);
-	submit_write_bio(&epd, ret);
+	ret = extent_write_cache_pages(mapping, wbc, &bio_ctrl);
+	submit_write_bio(&bio_ctrl, ret);
 	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
 	return ret;
 }
-- 
2.37.3

