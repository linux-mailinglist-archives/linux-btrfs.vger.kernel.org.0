Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB9699A2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBPQfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBPQfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:35:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478844ECE8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZmCp5UzzTfP3B3R7/edLq0LjWQq90xViSrZe1H8SNOQ=; b=Ox5s09tJc/Zo5LmAtuubKnc8kX
        jDGSVjNbLyU38f0orz19uu6PADQ1sF7W7NCMHng9OkfqwIu7fxaCMgMkidt0LZMtlCHh/zkd6gOBg
        gWc212rHDLMNfl+2nbKU6/4pW5NkdH8Ixa7vTJzbbQvEJWkPnjxcgg7W614/zhNSOjk4pBxA2v4xE
        rAYeNcWsjScu+yTNwuAmkuCyH63OwEvyyTw2tK6TZ3Pp211eehUWg5wZYl/KhzPE+ISFBrt6FrnbW
        KC9txur6Tn9YGNToZQJnMTOftMv1YlssQaBW2JgzTFlReM2M97GqUYp0HarJG3aSWXNvTGnlMuvXu
        3Flzcdxg==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDr-00BD3x-HA; Thu, 16 Feb 2023 16:35:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: remove the submit_extent_page return value
Date:   Thu, 16 Feb 2023 17:34:34 +0100
Message-Id: <20230216163437.2370948-10-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216163437.2370948-1-hch@lst.de>
References: <20230216163437.2370948-1-hch@lst.de>
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

submit_extent_page always returns 0.  Change it to a void return type
and all the unreachable error handling code in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 156 ++++++++++---------------------------------
 1 file changed, 35 insertions(+), 121 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 10134db6057443..4b27cc50f8b926 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1010,9 +1010,9 @@ static void alloc_new_bio(struct btrfs_inode *inode,
  * The mirror number for this IO should already be initizlied in
  * @bio_ctrl->mirror_num.
  */
-static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
-			      u64 disk_bytenr, struct page *page,
-			      size_t size, unsigned long pg_offset)
+static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
+			       u64 disk_bytenr, struct page *page,
+			       size_t size, unsigned long pg_offset)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	unsigned int cur = pg_offset;
@@ -1061,7 +1061,6 @@ static int submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
 		}
 		cur += added;
 	}
-	return 0;
 }
 
 static int attach_extent_buffer_page(struct extent_buffer *eb,
@@ -1194,7 +1193,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		unlock_extent(tree, start, end, NULL);
 		btrfs_page_set_error(fs_info, page, start, PAGE_SIZE);
 		unlock_page(page);
-		goto out;
+		return ret;
 	}
 
 	if (page->index == last_byte >> PAGE_SHIFT) {
@@ -1225,8 +1224,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end, NULL);
 			end_page_read(page, false, cur, end + 1 - cur);
-			ret = PTR_ERR(em);
-			break;
+			return PTR_ERR(em);
 		}
 		extent_offset = cur - em->start;
 		BUG_ON(extent_map_end(em) <= cur);
@@ -1316,22 +1314,13 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
-		ret = submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
-					 pg_offset);
-		if (ret) {
-			/*
-			 * We have to unlock the remaining range, or the page
-			 * will never be unlocked.
-			 */
-			unlock_extent(tree, cur, end, NULL);
-			end_page_read(page, false, cur, end + 1 - cur);
-			goto out;
-		}
+		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
+				   pg_offset);
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
@@ -1622,19 +1611,9 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 */
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
-		ret = submit_extent_page(bio_ctrl, disk_bytenr, page,
-					 iosize, cur - page_offset(page));
-		if (ret) {
-			has_error = true;
-			if (!saved_ret)
-				saved_ret = ret;
-
-			btrfs_page_set_error(fs_info, page, cur, iosize);
-			if (PageWriteback(page))
-				btrfs_page_clear_writeback(fs_info, page, cur,
-							   iosize);
-		}
-
+		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
+				   cur - page_offset(page));
+		ret = 0;
 		cur += iosize;
 		nr++;
 	}
@@ -2092,13 +2071,12 @@ static void prepare_eb_write(struct extent_buffer *eb)
  * Unlike the work in write_one_eb(), we rely completely on extent locking.
  * Page locking is only utilized at minimum to keep the VMM code happy.
  */
-static int write_one_subpage_eb(struct extent_buffer *eb,
-				struct btrfs_bio_ctrl *bio_ctrl)
+static void write_one_subpage_eb(struct extent_buffer *eb,
+				 struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct page *page = eb->pages[0];
 	bool no_dirty_ebs = false;
-	int ret;
 
 	prepare_eb_write(eb);
 
@@ -2114,17 +2092,8 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 
 	bio_ctrl->end_io_func = end_bio_subpage_eb_writepage;
 
-	ret = submit_extent_page(bio_ctrl, eb->start, page, eb->len,
-			eb->start - page_offset(page));
-	if (ret) {
-		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
-		set_btree_ioerr(page, eb);
-		unlock_page(page);
-
-		if (atomic_dec_and_test(&eb->io_pages))
-			end_extent_buffer_writeback(eb);
-		return -EIO;
-	}
+	submit_extent_page(bio_ctrl, eb->start, page, eb->len,
+			   eb->start - page_offset(page));
 	unlock_page(page);
 	/*
 	 * Submission finished without problem, if no range of the page is
@@ -2132,15 +2101,13 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	 */
 	if (no_dirty_ebs)
 		bio_ctrl->wbc->nr_to_write--;
-	return ret;
 }
 
-static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
+static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			struct btrfs_bio_ctrl *bio_ctrl)
 {
 	u64 disk_bytenr = eb->start;
 	int i, num_pages;
-	int ret = 0;
 
 	prepare_eb_write(eb);
 
@@ -2152,31 +2119,11 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
-		ret = submit_extent_page(bio_ctrl, disk_bytenr, p,
-					 PAGE_SIZE, 0);
-		if (ret) {
-			set_btree_ioerr(p, eb);
-			if (PageWriteback(p))
-				end_page_writeback(p);
-			if (atomic_sub_and_test(num_pages - i, &eb->io_pages))
-				end_extent_buffer_writeback(eb);
-			ret = -EIO;
-			break;
-		}
+		submit_extent_page(bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
 		disk_bytenr += PAGE_SIZE;
 		bio_ctrl->wbc->nr_to_write--;
 		unlock_page(p);
 	}
-
-	if (unlikely(ret)) {
-		for (; i < num_pages; i++) {
-			struct page *p = eb->pages[i];
-			clear_page_dirty_for_io(p);
-			unlock_page(p);
-		}
-	}
-
-	return ret;
 }
 
 /*
@@ -2256,10 +2203,8 @@ static int submit_eb_subpage(struct page *page,
 			free_extent_buffer(eb);
 			goto cleanup;
 		}
-		ret = write_one_subpage_eb(eb, bio_ctrl);
+		write_one_subpage_eb(eb, bio_ctrl);
 		free_extent_buffer(eb);
-		if (ret < 0)
-			goto cleanup;
 		submitted++;
 	}
 	return submitted;
@@ -2362,10 +2307,8 @@ static int submit_eb_page(struct page *page,
 		btrfs_schedule_zone_finish_bg(cache, eb);
 		btrfs_put_block_group(cache);
 	}
-	ret = write_one_eb(eb, bio_ctrl);
+	write_one_eb(eb, bio_ctrl);
 	free_extent_buffer(eb);
-	if (ret < 0)
-		return ret;
 	return 1;
 }
 
@@ -4386,7 +4329,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		.mirror_num = mirror_num,
 		.parent_check = check,
 	};
-	int ret = 0;
+	int ret;
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
 	ASSERT(PagePrivate(page));
@@ -4404,14 +4347,13 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 			return ret;
 	}
 
-	ret = 0;
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
 	    PageUptodate(page) ||
 	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
 			      &cached_state);
-		return ret;
+		return 0;
 	}
 
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
@@ -4423,27 +4365,19 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-	ret = submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
-				 eb->start - page_offset(page));
-	if (ret) {
-		/*
-		 * In the endio function, if we hit something wrong we will
-		 * increase the io_pages, so here we need to decrease it for
-		 * error path.
-		 */
-		atomic_dec(&eb->io_pages);
-	}
+	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
+			   eb->start - page_offset(page));
 	submit_one_bio(&bio_ctrl);
-	if (ret || wait != WAIT_COMPLETE) {
+	if (wait != WAIT_COMPLETE) {
 		free_extent_state(cached_state);
-		return ret;
+		return 0;
 	}
 
 	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
 			EXTENT_LOCKED, &cached_state);
 	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
-		ret = -EIO;
-	return ret;
+		return -EIO;
+	return 0;
 }
 
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
@@ -4451,8 +4385,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 {
 	int i;
 	struct page *page;
-	int err;
-	int ret = 0;
 	int locked_pages = 0;
 	int all_uptodate = 1;
 	int num_pages;
@@ -4526,27 +4458,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		page = eb->pages[i];
 
 		if (!PageUptodate(page)) {
-			if (ret) {
-				atomic_dec(&eb->io_pages);
-				unlock_page(page);
-				continue;
-			}
-
 			ClearPageError(page);
-			err = submit_extent_page(&bio_ctrl,
-						 page_offset(page), page,
-						 PAGE_SIZE, 0);
-			if (err) {
-				/*
-				 * We failed to submit the bio so it's the
-				 * caller's responsibility to perform cleanup
-				 * i.e unlock page/set error bit.
-				 */
-				ret = err;
-				SetPageError(page);
-				unlock_page(page);
-				atomic_dec(&eb->io_pages);
-			}
+			submit_extent_page(&bio_ctrl, page_offset(page), page,
+					   PAGE_SIZE, 0);
 		} else {
 			unlock_page(page);
 		}
@@ -4554,17 +4468,17 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 
 	submit_one_bio(&bio_ctrl);
 
-	if (ret || wait != WAIT_COMPLETE)
-		return ret;
+	if (wait != WAIT_COMPLETE)
+		return 0;
 
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
-			ret = -EIO;
+			return -EIO;
 	}
 
-	return ret;
+	return 0;
 
 unlock_exit:
 	while (locked_pages > 0) {
@@ -4572,7 +4486,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		page = eb->pages[locked_pages];
 		unlock_page(page);
 	}
-	return ret;
+	return 0;
 }
 
 static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
-- 
2.39.1

