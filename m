Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6D3D8900
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 09:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhG1Hjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 03:39:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47648 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhG1Hjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 03:39:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C3EE1FF53
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627457984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=I4P/O9vQ3lVjiqDxzssfaU5PcqQu96ZwLuU1KUswWxs=;
        b=XllEbKE1T17fZfmDNq3gGz5O1OSRaLVnz2BNIOLD9bbBCQjuFgrsnlWYIxTsRxpiq+oaoH
        4pnacBRTI1Z5W5RmwA5DrGm8k325BcVWCavAZY6HmVDoRYRrtYVI4a6cc4DvhXqGSIPuxW
        RYWmLDZd6yJmQk+dh+XpwoRdk0GqB3Y=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DB0EF13CF4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 07:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5/8oJ78JAWEKdgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 07:39:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: eliminate the window between run delalloc range and bio submission
Date:   Wed, 28 Jul 2021 15:39:41 +0800
Message-Id: <20210728073941.138177-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is still an RFC version, only non-compressed writeback is going
through the new code path, compressed writeback still goes through the
old path, but can be easily converted.

And there are some small bugs related to btrfs_finish_ordered_io() for
csum insertion, but no obvious crash during quick test group.

This patch will introduce a new function to writeback a page,
__extent_writepage_v2().

This function has the following differences compared to the existing
__extent_writepage()

- Keeps page locked until bio submission
  This makes the page content consistent between
  btrfs_run_delalloc_range() and bio submission.

  This would make code much simpler.

- Will always submit the whole delalloc range
  This provides much larger merged extents.
  But also larger latency.

- Better error handling
  Now we will properly handle error cases like failure during bio
  submission, as now we have full control on where the bio submission
  error happens and where the ordered extent is.

The disadvantage includes:

- Much longer page lock duration
  Now the page will only be unlocked after the bio submission.
  While previously, each page is only locked for
  btrfs_run_delalloc_range() and bio submission.

  I have already seen quite some performance impact for the quick test
  group.

  However this can be improved by:
  * Make btrfs_run_delalloc_range() to mark page writeback then unlock
    them
    This makes the behavior much similar to the existing one, but still
    keeps all the benefit.
    But need more changes as we enlarge the writeback lifespan.
    (needs more check for compression case)

- Much larger latency for btrfs_invalidatepage()
  Now the page can only be invalidated after its writeback is finishes.

  This is unavoidable, but I doubt if the latency for page invalidating
  is that important.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 260 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 253 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7438692a0660..7914372e4a02 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3921,11 +3921,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct writeback_control *wbc,
 				 struct extent_page_data *epd,
 				 loff_t i_size,
+				 u64 start, u64 end,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
 	u64 extent_offset;
 	u64 block_start;
@@ -4066,6 +4065,253 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	return ret;
 }
 
+static void cleanup_ordered_extent(struct btrfs_inode *inode,
+				   struct page *locked_page,
+				   u64 failed_offset,
+				   u64 delalloc_start,
+				   u32 delalloc_len)
+{
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	u64 cur = failed_offset;
+
+	ASSERT(failed_offset >= delalloc_start &&
+	       failed_offset < delalloc_start + delalloc_len);
+
+	while (cur < delalloc_start + delalloc_len) {
+		struct page *page;
+		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE,
+				  delalloc_start + delalloc_len) - 1;
+
+		page = find_get_page(mapping, cur >> PAGE_SHIFT);
+		ASSERT(page);
+		ASSERT(PageLocked(page));
+
+		btrfs_writepage_endio_finish_ordered(inode, page, cur, cur_end, 0);
+
+		cur = cur_end + 1;
+	}
+
+	/* Also unlock the pages in the delalloc range */
+	extent_clear_unlock_delalloc(inode, failed_offset,
+			delalloc_start + delalloc_len - 1, locked_page, 0,
+			PAGE_UNLOCK | PAGE_SET_ERROR);
+}
+
+static int submit_delalloc_range(struct btrfs_inode *inode,
+				 struct page *locked_page,
+				 struct writeback_control *wbc,
+				 struct extent_page_data *epd,
+				 loff_t i_size,
+				 u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	u64 cur = start;
+	int ret;
+
+	while (cur < start + len) {
+		struct page *page;
+		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE,
+				  start + len) - 1;
+		int nr_written = 0;
+
+		page = find_get_page(mapping, cur >> PAGE_SHIFT);
+		ASSERT(PageLocked(page));
+		ASSERT(PageDirty(page));
+
+		btrfs_page_clear_dirty(fs_info, page, cur, cur_end + 1 - cur);
+
+		ret = __extent_writepage_io(inode, page, wbc, epd, i_size,
+				cur, cur_end, &nr_written);
+		if (ret < 0)
+			goto out;
+
+		put_page(page);
+		cur = cur_end + 1;
+	}
+out:
+	ASSERT(ret <= 0);
+	if (ret < 0) {
+		cleanup_ordered_extent(inode, locked_page, cur, start, len);
+		end_write_bio(epd, ret);
+	} else {
+		extent_clear_unlock_delalloc(inode, start, start + len - 1,
+					     locked_page, 0, PAGE_UNLOCK);
+		ret = flush_write_bio(epd);
+	}
+	return ret;
+}
+
+/*
+ * The newer verions of __extent_writepage().
+ *
+ * Unlike the existing version, this version will keep all involved pages
+ * locked until marked writeback.
+ */
+static int __extent_writepage_v2(struct page *page,
+				 struct writeback_control *wbc,
+				 struct extent_page_data *epd)
+{
+	struct inode *inode = page->mapping->host;
+	bool delalloc_ran = false;
+	const u64 page_start = page_offset(page);
+	const u64 page_end = page_start + PAGE_SIZE - 1;
+	u64 cur = page_start;
+	int ret;
+	size_t pg_offset;
+	loff_t i_size = i_size_read(inode);
+	unsigned long end_index = i_size >> PAGE_SHIFT;
+	unsigned long nr_written = 0;
+
+	trace___extent_writepage(page, inode, wbc);
+
+	WARN_ON(!PageLocked(page));
+
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		/*
+		 * We can't call subpage helper here, as page private is not
+		 * yet initialized.
+		 */
+		SetPageError(page);
+		goto out;
+	}
+
+	btrfs_page_clear_error(btrfs_sb(inode->i_sb), page,
+			       page_offset(page), PAGE_SIZE);
+
+	pg_offset = offset_in_page(i_size);
+	if (page->index > end_index ||
+	   (page->index == end_index && !pg_offset)) {
+		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
+		unlock_page(page);
+		return 0;
+	}
+
+	if (page->index == end_index) {
+		memzero_page(page, pg_offset, PAGE_SIZE - pg_offset);
+		flush_dcache_page(page);
+	}
+
+	/* This version can't be called for extent_write_locked_range() */
+	ASSERT(!epd->extent_locked);
+
+	while (cur < page_end) {
+		u64 delalloc_start = cur;
+		u64 delalloc_end = page_end;
+		int page_started;
+		bool found;
+
+		found = find_lock_delalloc_range(inode, page, &delalloc_start,
+						 &delalloc_end);
+		if (!found) {
+			cur = delalloc_end + 1;
+			continue;
+		}
+		ASSERT(delalloc_start >= page_start &&
+		       delalloc_start <= page_end);
+		ASSERT(delalloc_end > page_start);
+
+		delalloc_ran = true;
+		/* Don't try to unlock the pages in the delalloc range */
+		ret = btrfs_run_delalloc_range(BTRFS_I(inode), page,
+				delalloc_start, delalloc_end, &page_started,
+				&nr_written, wbc, false);
+		if (ret) {
+			u32 range_len = min(page_end, delalloc_end) + 1 -
+					delalloc_start;
+			/*
+			 * When error happens, except the first page, all other
+			 * pages should have been unlocked by
+			 * btrfs_run_delalloc_range().
+			 */
+			btrfs_page_set_error(BTRFS_I(inode)->root->fs_info,
+					     page, delalloc_start, range_len);
+			goto out;
+		}
+		if (page_started) {
+			wbc->nr_to_write -= nr_written;
+
+			/*
+			 * Currently only two cases would start its pages:
+			 * - Inline
+			 *   This means we have finished all work, and page
+			 *   is already unlocked.
+			 *
+			 * - Compressed
+			 *   Subpage case only support full page compression
+			 *   anyway, the page will be unlocked by async cow.
+			 *
+			 * Either we, we're fine to return right now.
+			 */
+			return 0;
+		}
+
+		/* Submit the delalloc ranges */
+		ret = submit_delalloc_range(BTRFS_I(inode), page, wbc,
+				epd, i_size, delalloc_start,
+				delalloc_end + 1 - delalloc_start);
+		if (ret < 0)
+			goto out;
+
+		cur = delalloc_end + 1;
+	}
+
+	/*
+	 * This page is dirty but no delalloc range ran for it, this means this
+	 * page is marked dirty without proper filesystem awareness.
+	 *
+	 * Needs cow fixup for it.
+	 */
+	if (!delalloc_ran) {
+		ret = btrfs_writepage_cow_fixup(page);
+		if (ret) {
+			ret = 0;
+			/* Fixup worker will requeue */
+			redirty_page_for_writepage(wbc, page);
+			goto out;
+		}
+	}
+
+	/*
+	 * Here we used to have a check for PageError() and then set @ret and
+	 * call end_extent_writepage().
+	 *
+	 * But in fact setting @ret here will cause different error paths
+	 * between subpage and regualr sectorsize.
+	 *
+	 * For regular page size, we never submit current page, but only add
+	 * current page to current bio.
+	 * The bio submission can only happen in next page.
+	 * Thus if we hit the PageError() branch, @ret is already set to
+	 * non-zero value and will not get updated for regular sectorsize.
+	 *
+	 * But for subpage case, it's possible we submit part of current page,
+	 * thus can get PageError() set by submitted bio of the same page,
+	 * while our @ret is still 0.
+	 *
+	 * So here we unify the behavior and don't set @ret.
+	 * Error can still be properly passed to higher layer as page will
+	 * be set error, here we just don't handle the IO failure.
+	 *
+	 * NOTE: This is just a hotfix for subpage.
+	 * The root fix will be properly ending ordered extent when we hit
+	 * an error during writeback.
+	 *
+	 * But that needs a much bigger refactor, as we not only need to
+	 * grab the submitted OE, but also needs to know exactly at which
+	 * bytenr we hit an error.
+	 * Currently the full page based __extent_writepage_io() is not
+	 * capable for that.
+	 */
+	if (PageError(page))
+		end_extent_writepage(page, ret, page_start, page_end);
+
+out:
+	unlock_page(page);
+	return ret;
+}
+
 /*
  * the writepage semantics are similar to regular writepage.  extent
  * records are inserted to lock ranges in the tree, and as dirty areas
@@ -4123,7 +4369,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	ret = __extent_writepage_io(BTRFS_I(inode), page, wbc, epd, i_size,
-				    &nr);
+				    page_offset(page),
+				    page_offset(page) + PAGE_SIZE - 1, &nr);
 	if (ret == 1)
 		return 0;
 
@@ -5036,13 +5283,12 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				wait_on_page_writeback(page);
 			}
 
-			if (PageWriteback(page) ||
-			    !clear_page_dirty_for_io(page)) {
+			if (!PageDirty(page)) {
 				unlock_page(page);
 				continue;
 			}
 
-			ret = __extent_writepage(page, wbc, epd);
+			ret = __extent_writepage_v2(page, wbc, epd);
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -5093,7 +5339,7 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
 
-	ret = __extent_writepage(page, wbc, &epd);
+	ret = __extent_writepage_v2(page, wbc, &epd);
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-- 
2.32.0

