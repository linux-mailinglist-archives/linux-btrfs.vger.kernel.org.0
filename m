Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6D6A45CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjB0PRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjB0PRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB6227A3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rNuu5XEaNXyHYVQM9a5VMQA2mwJY/68wafv/dEgfpLI=; b=psyI3yR8FiQSIP29RQZ/JHy817
        gblaF0Vlf5AJXrhH1z9iS9YOlrN315cz7uve6hdIjjpSbyjUSRCcRQT26aRbaxoWUx5eRYels3Zf9
        JYyVPqaa6BkqEtOZRiGA1hn48Bp+Ivz3H/o9jWcVo7cTwcGFUotwCV14bbnG+CrfiXrFF8BPcPFYe
        2ePJSEx4b3s8PlCw6VkfFIIJS3myW0G1fwhzCK+BeEpdQUXf59nK21kB+uPNFvMbkNsO+0DYO/dHC
        ikURiuzrX/cCM41VhVuV1vU2wnjYPQkvdRpcMaV4TnF3WdfANhtLGNmxk4+mxcb/zfeU1apSGrAcj
        +xVFxcyQ==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFS-00AAsx-PO; Mon, 27 Feb 2023 15:17:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/12] btrfs: add a wbc pointer to struct btrfs_bio_ctrl
Date:   Mon, 27 Feb 2023 08:16:57 -0700
Message-Id: <20230227151704.1224688-6-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
References: <20230227151704.1224688-1-hch@lst.de>
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

Instead of passing down the wbc pointer the deep callchain, just
add it to the btrfs_bio_ctrl structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 81 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 432fd231935acc..1de56abd7308c7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -103,6 +103,7 @@ struct btrfs_bio_ctrl {
 	u32 len_to_oe_boundary;
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
+	struct writeback_control *wbc;
 
 	/*
 	 * This is for metadata read, to provide the extra needed verification
@@ -971,7 +972,6 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 
 static void alloc_new_bio(struct btrfs_inode *inode,
 			  struct btrfs_bio_ctrl *bio_ctrl,
-			  struct writeback_control *wbc,
 			  u64 disk_bytenr, u32 offset, u64 file_offset,
 			  enum btrfs_compression_type compress_type)
 {
@@ -993,7 +993,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->compress_type = compress_type;
 	calc_bio_boundaries(bio_ctrl, inode, file_offset);
 
-	if (wbc) {
+	if (bio_ctrl->wbc) {
 		/*
 		 * Pick the last added device to support cgroup writeback.  For
 		 * multi-device file systems this means blk-cgroup policies have
@@ -1001,12 +1001,11 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 		 * This is a bit odd but has been like that for a long time.
 		 */
 		bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
-		wbc_init_bio(wbc, bio);
+		wbc_init_bio(bio_ctrl->wbc, bio);
 	}
 }
 
 /*
- * @wbc:	optional writeback control for io accounting
  * @disk_bytenr: logical bytenr where the write will be
  * @page:	page to add to the bio
  * @size:	portion of page that we want to write to
@@ -1019,8 +1018,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  * The mirror number for this IO should already be initizlied in
  * @bio_ctrl->mirror_num.
  */
-static int submit_extent_page(struct writeback_control *wbc,
-			      struct btrfs_bio_ctrl *bio_ctrl,
+static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 			      u64 disk_bytenr, struct page *page,
 			      size_t size, unsigned long pg_offset,
 			      enum btrfs_compression_type compress_type)
@@ -1041,7 +1039,7 @@ static int submit_extent_page(struct writeback_control *wbc,
 
 		/* Allocate new bio if needed */
 		if (!bio_ctrl->bio) {
-			alloc_new_bio(inode, bio_ctrl, wbc, disk_bytenr,
+			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
 				      offset, page_offset(page) + cur,
 				      compress_type);
 		}
@@ -1063,8 +1061,8 @@ static int submit_extent_page(struct writeback_control *wbc,
 			ASSERT(added == 0 || added == size - offset);
 
 		/* At least we added some page, update the account */
-		if (wbc && added)
-			wbc_account_cgroup_owner(wbc, page, added);
+		if (bio_ctrl->wbc && added)
+			wbc_account_cgroup_owner(bio_ctrl->wbc, page, added);
 
 		/* We have reached boundary, submit right now */
 		if (added < size - offset) {
@@ -1324,7 +1322,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
-		ret = submit_extent_page(NULL, bio_ctrl, disk_bytenr, page, iosize,
+		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
 					 pg_offset, this_bio_flag);
 		if (ret) {
 			/*
@@ -1511,7 +1509,6 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
  */
 static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct page *page,
-				 struct writeback_control *wbc,
 				 struct btrfs_bio_ctrl *bio_ctrl,
 				 loff_t i_size,
 				 int *nr_ret)
@@ -1531,7 +1528,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	ret = btrfs_writepage_cow_fixup(page);
 	if (ret) {
 		/* Fixup worker will requeue */
-		redirty_page_for_writepage(wbc, page);
+		redirty_page_for_writepage(bio_ctrl->wbc, page);
 		unlock_page(page);
 		return 1;
 	}
@@ -1540,7 +1537,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
 	 */
-	wbc->nr_to_write--;
+	bio_ctrl->wbc->nr_to_write--;
 
 	bio_ctrl->end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
@@ -1631,7 +1628,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 */
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
-		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, page,
+		ret = submit_extent_page(bio_ctrl, disk_bytenr, page,
 					 iosize, cur - page_offset(page), 0);
 		if (ret) {
 			has_error = true;
@@ -1668,7 +1665,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
  * Return 0 if everything goes well.
  * Return <0 for error.
  */
-static int __extent_writepage(struct page *page, struct writeback_control *wbc,
+static int __extent_writepage(struct page *page,
 			      struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct folio *folio = page_folio(page);
@@ -1682,7 +1679,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
 
-	trace___extent_writepage(page, inode, wbc);
+	trace___extent_writepage(page, inode, bio_ctrl->wbc);
 
 	WARN_ON(!PageLocked(page));
 
@@ -1707,14 +1704,14 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!bio_ctrl->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc);
+		ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
 		if (ret == 1)
 			return 0;
 		if (ret)
 			goto done;
 	}
 
-	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, bio_ctrl, i_size,
+	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size,
 				    &nr);
 	if (ret == 1)
 		return 0;
@@ -1759,6 +1756,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	if (PageError(page))
 		end_extent_writepage(page, ret, page_start, page_end);
 	if (bio_ctrl->extent_locked) {
+		struct writeback_control *wbc = bio_ctrl->wbc;
+
 		/*
 		 * If bio_ctrl->extent_locked, it's from extent_write_locked_range(),
 		 * the page can either be locked by lock_page() or
@@ -1799,7 +1798,6 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  * Return <0 if something went wrong, no page is locked.
  */
 static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
-			  struct writeback_control *wbc,
 			  struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -1815,7 +1813,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
-		if (wbc->sync_mode != WB_SYNC_ALL)
+		if (bio_ctrl->wbc->sync_mode != WB_SYNC_ALL)
 			return 0;
 		if (!flush) {
 			submit_write_bio(bio_ctrl, 0);
@@ -2101,7 +2099,6 @@ static void prepare_eb_write(struct extent_buffer *eb)
  * Page locking is only utilized at minimum to keep the VMM code happy.
  */
 static int write_one_subpage_eb(struct extent_buffer *eb,
-				struct writeback_control *wbc,
 				struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -2123,7 +2120,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 
 	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
 
-	ret = submit_extent_page(wbc, bio_ctrl, eb->start, page, eb->len,
+	ret = submit_extent_page(bio_ctrl, eb->start, page, eb->len,
 			eb->start - page_offset(page), 0);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
@@ -2140,12 +2137,11 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
 	 */
 	if (no_dirty_ebs)
-		wbc->nr_to_write--;
+		bio_ctrl->wbc->nr_to_write--;
 	return ret;
 }
 
 static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
-			struct writeback_control *wbc,
 			struct btrfs_bio_ctrl *bio_ctrl)
 {
 	u64 disk_bytenr = eb->start;
@@ -2162,7 +2158,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		ret = submit_extent_page(wbc, bio_ctrl, disk_bytenr, p,
+		ret = submit_extent_page(bio_ctrl, disk_bytenr, p,
 					 PAGE_SIZE, 0, 0);
 		if (ret) {
 			set_btree_ioerr(p, eb);
@@ -2174,7 +2170,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 			break;
 		}
 		disk_bytenr += PAGE_SIZE;
-		wbc->nr_to_write--;
+		bio_ctrl->wbc->nr_to_write--;
 		unlock_page(p);
 	}
 
@@ -2204,7 +2200,6 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
  * Return <0 for fatal error.
  */
 static int submit_eb_subpage(struct page *page,
-			     struct writeback_control *wbc,
 			     struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
@@ -2258,7 +2253,7 @@ static int submit_eb_subpage(struct page *page,
 		if (!eb)
 			continue;
 
-		ret = lock_extent_buffer_for_io(eb, wbc, bio_ctrl);
+		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
 		if (ret == 0) {
 			free_extent_buffer(eb);
 			continue;
@@ -2267,7 +2262,7 @@ static int submit_eb_subpage(struct page *page,
 			free_extent_buffer(eb);
 			goto cleanup;
 		}
-		ret = write_one_subpage_eb(eb, wbc, bio_ctrl);
+		ret = write_one_subpage_eb(eb, bio_ctrl);
 		free_extent_buffer(eb);
 		if (ret < 0)
 			goto cleanup;
@@ -2301,7 +2296,7 @@ static int submit_eb_subpage(struct page *page,
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct writeback_control *wbc,
+static int submit_eb_page(struct page *page,
 			  struct btrfs_bio_ctrl *bio_ctrl,
 			  struct extent_buffer **eb_context)
 {
@@ -2314,7 +2309,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return 0;
 
 	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return submit_eb_subpage(page, wbc, bio_ctrl);
+		return submit_eb_subpage(page, bio_ctrl);
 
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
@@ -2347,7 +2342,8 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
 		 */
-		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
+		if (bio_ctrl->wbc->sync_mode == WB_SYNC_ALL &&
+		    !bio_ctrl->wbc->for_sync)
 			ret = -EAGAIN;
 		else
 			ret = 0;
@@ -2357,7 +2353,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 
 	*eb_context = eb;
 
-	ret = lock_extent_buffer_for_io(eb, wbc, bio_ctrl);
+	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
 	if (ret <= 0) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
@@ -2372,7 +2368,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
-	ret = write_one_eb(eb, wbc, bio_ctrl);
+	ret = write_one_eb(eb, bio_ctrl);
 	free_extent_buffer(eb);
 	if (ret < 0)
 		return ret;
@@ -2384,6 +2380,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 {
 	struct extent_buffer *eb_context = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = wbc,
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 		.extent_locked = 0,
 	};
@@ -2428,7 +2425,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			ret = submit_eb_page(page, wbc, &bio_ctrl, &eb_context);
+			ret = submit_eb_page(page, &bio_ctrl, &eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2511,9 +2508,9 @@ int btree_write_cache_pages(struct address_space *mapping,
  * existing IO to complete.
  */
 static int extent_write_cache_pages(struct address_space *mapping,
-			     struct writeback_control *wbc,
 			     struct btrfs_bio_ctrl *bio_ctrl)
 {
+	struct writeback_control *wbc = bio_ctrl->wbc;
 	struct inode *inode = mapping->host;
 	int ret = 0;
 	int done = 0;
@@ -2614,7 +2611,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
-			ret = __extent_writepage(page, wbc, bio_ctrl);
+			ret = __extent_writepage(page, bio_ctrl);
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -2679,6 +2676,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		.no_cgroup_owner = 1,
 	};
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = &wbc_writepages,
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(&wbc_writepages),
 		.extent_locked = 1,
 	};
@@ -2701,7 +2699,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		ASSERT(PageLocked(page));
 		ASSERT(PageDirty(page));
 		clear_page_dirty_for_io(page);
-		ret = __extent_writepage(page, &wbc_writepages, &bio_ctrl);
+		ret = __extent_writepage(page, &bio_ctrl);
 		ASSERT(ret <= 0);
 		if (ret < 0) {
 			found_error = true;
@@ -2725,6 +2723,7 @@ int extent_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int ret = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
+		.wbc = wbc,
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 		.extent_locked = 0,
 	};
@@ -2734,7 +2733,7 @@ int extent_writepages(struct address_space *mapping,
 	 * protect the write pointer updates.
 	 */
 	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
-	ret = extent_write_cache_pages(mapping, wbc, &bio_ctrl);
+	ret = extent_write_cache_pages(mapping, &bio_ctrl);
 	submit_write_bio(&bio_ctrl, ret);
 	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
 	return ret;
@@ -4430,7 +4429,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	ret = submit_extent_page(NULL, &bio_ctrl, eb->start, page, eb->len,
+	ret = submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
 				 eb->start - page_offset(page), 0);
 	if (ret) {
 		/*
@@ -4540,7 +4539,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			}
 
 			ClearPageError(page);
-			err = submit_extent_page(NULL, &bio_ctrl,
+			err = submit_extent_page(&bio_ctrl,
 						 page_offset(page), page,
 						 PAGE_SIZE, 0, 0);
 			if (err) {
-- 
2.39.1

