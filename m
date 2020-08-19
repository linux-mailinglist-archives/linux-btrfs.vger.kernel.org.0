Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3582494AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 07:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHSFxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 01:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgHSFxx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 01:53:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95873AC24
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 05:54:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: switch btrfs_buffered_write() to page-by-page pace
Date:   Wed, 19 Aug 2020 13:53:44 +0800
Message-Id: <20200819055344.50784-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, btrfs_buffered_write() do page copy in a 8 pages
batch.

While for EXT4, it uses generic_perform_write() which does page by page
copy.

This 8 pages batch behavior makes a lot of things more complex:
- More complex error handling
  Now we need to handle all errors for half written case.

- More complex advance check
  Since for 8 pages, we need to consider cases like 4 pages copied.
  This makes we need to release reserved space for the untouched 4
  pages.

- More wrappers for multi-pages operations
  The most obvious one is btrfs_copy_from_user(), which introduces way
  more complexity than we need.

This patch will change the behavior by going to the page-by-page pace,
each time we only reserve space for one page, do one page copy.

There are still a lot of complexity remained, mostly for short copy,
non-uptodate page and extent locking.
But that's more or less the same as the generic_perform_write().

The performance is the same for 4K block size buffered write, but has an
obvious impact when using multiple pages siuzed block size:

The test involves writing a 128MiB file, which is smaller than 1/8th of
the system memory.
		Speed (MiB/sec)		Ops (ops/sec)
Unpatched:	931.498			14903.9756
Patched:	447.606			7161.6806

In fact, if we account the execution time of btrfs_buffered_write(),
meta/data rsv and later page dirty takes way more time than memory copy:

Patched:
 nr_runs          = 32768
 total_prepare_ns = 66908022
 total_copy_ns    = 75532103
 total_cleanup_ns = 135749090

Unpatched:
 nr_runs          = 2176
 total_prepare_ns = 7425773
 total_copy_ns    = 87780898
 total_cleanup_ns = 37704811

The patched behavior is now similar to EXT4, the buffered write remain
mostly unchanged for from 4K blocksize and larger.

On the other hand, XFS uses iomap, which supports multi-page reserve and
copy, leading to similar performance of unpatched btrfs.

It looks like that we'd better go iomap routine other than the
generic_perform_write().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

The performance drop is enough for this patch to be discarded.
---
 fs/btrfs/file.c | 293 ++++++++++++------------------------------------
 1 file changed, 72 insertions(+), 221 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bbfc8819cf28..be595da9bc05 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -379,60 +379,6 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-/* simple helper to fault in pages and copy.  This should go away
- * and be replaced with calls into generic code.
- */
-static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
-					 struct page **prepared_pages,
-					 struct iov_iter *i)
-{
-	size_t copied = 0;
-	size_t total_copied = 0;
-	int pg = 0;
-	int offset = offset_in_page(pos);
-
-	while (write_bytes > 0) {
-		size_t count = min_t(size_t,
-				     PAGE_SIZE - offset, write_bytes);
-		struct page *page = prepared_pages[pg];
-		/*
-		 * Copy data from userspace to the current page
-		 */
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, count);
-
-		/* Flush processor's dcache for this page */
-		flush_dcache_page(page);
-
-		/*
-		 * if we get a partial write, we can end up with
-		 * partially up to date pages.  These add
-		 * a lot of complexity, so make sure they don't
-		 * happen by forcing this copy to be retried.
-		 *
-		 * The rest of the btrfs_file_write code will fall
-		 * back to page at a time copies after we return 0.
-		 */
-		if (!PageUptodate(page) && copied < count)
-			copied = 0;
-
-		iov_iter_advance(i, copied);
-		write_bytes -= copied;
-		total_copied += copied;
-
-		/* Return to btrfs_file_write_iter to fault page */
-		if (unlikely(copied == 0))
-			break;
-
-		if (copied < PAGE_SIZE - offset) {
-			offset += copied;
-		} else {
-			pg++;
-			offset = 0;
-		}
-	}
-	return total_copied;
-}
-
 /*
  * unlocks pages after btrfs_file_write is done with them
  */
@@ -443,8 +389,8 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 		/* page checked is some magic around finding pages that
 		 * have been modified without going through btrfs_set_page_dirty
 		 * clear it here. There should be no need to mark the pages
-		 * accessed as prepare_pages should have marked them accessed
-		 * in prepare_pages via find_or_create_page()
+		 * accessed as prepare_pages() should have marked them accessed
+		 * in prepare_pages() via find_or_create_page()
 		 */
 		ClearPageChecked(pages[i]);
 		unlock_page(pages[i]);
@@ -1400,58 +1346,6 @@ static int prepare_uptodate_page(struct inode *inode,
 	return 0;
 }
 
-/*
- * this just gets pages into the page cache and locks them down.
- */
-static noinline int prepare_pages(struct inode *inode, struct page **pages,
-				  size_t num_pages, loff_t pos,
-				  size_t write_bytes, bool force_uptodate)
-{
-	int i;
-	unsigned long index = pos >> PAGE_SHIFT;
-	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
-	int err = 0;
-	int faili;
-
-	for (i = 0; i < num_pages; i++) {
-again:
-		pages[i] = find_or_create_page(inode->i_mapping, index + i,
-					       mask | __GFP_WRITE);
-		if (!pages[i]) {
-			faili = i - 1;
-			err = -ENOMEM;
-			goto fail;
-		}
-
-		if (i == 0)
-			err = prepare_uptodate_page(inode, pages[i], pos,
-						    force_uptodate);
-		if (!err && i == num_pages - 1)
-			err = prepare_uptodate_page(inode, pages[i],
-						    pos + write_bytes, false);
-		if (err) {
-			put_page(pages[i]);
-			if (err == -EAGAIN) {
-				err = 0;
-				goto again;
-			}
-			faili = i - 1;
-			goto fail;
-		}
-		wait_on_page_writeback(pages[i]);
-	}
-
-	return 0;
-fail:
-	while (faili >= 0) {
-		unlock_page(pages[faili]);
-		put_page(pages[faili]);
-		faili--;
-	}
-	return err;
-
-}
-
 /*
  * This function locks the extent and properly waits for data=ordered extents
  * to finish before allowing the pages to be modified if need.
@@ -1619,6 +1513,38 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
+static int prepare_one_page(struct inode *inode, struct page **page_ret,
+			    loff_t pos, size_t write_bytes, bool force_uptodate)
+{
+	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping) | __GFP_WRITE;
+	struct page *page;
+	int ret;
+
+again:
+	page = find_or_create_page(inode->i_mapping, pos >> PAGE_SHIFT, mask);
+	if (!page)
+		return -ENOMEM;
+
+	/*
+	 * We need the page uptodate for the following cases:
+	 * - Write range only covers part of the page
+	 * - We got a short copy on non-uptodate page in previous run
+	 */
+	if ((!(offset_in_page(pos) == 0 && write_bytes == PAGE_SIZE) ||
+	     force_uptodate) && !PageUptodate(page)) {
+		ret = prepare_uptodate_page(inode, page, pos, true);
+		if (ret) {
+			put_page(page);
+			if (ret == -EAGAIN)
+				goto again;
+			return ret;
+		}
+		wait_on_page_writeback(page);
+	}
+	*page_ret = page;
+	return 0;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1626,45 +1552,26 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct page **pages = NULL;
+	struct page *page = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	u64 release_bytes = 0;
 	u64 lockstart;
 	u64 lockend;
 	size_t num_written = 0;
-	int nrptrs;
 	int ret = 0;
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 
-	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
-			PAGE_SIZE / (sizeof(struct page *)));
-	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
-	nrptrs = max(nrptrs, 8);
-	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
 		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
 		size_t write_bytes = min(iov_iter_count(i),
-					 nrptrs * (size_t)PAGE_SIZE -
-					 offset);
-		size_t num_pages = DIV_ROUND_UP(write_bytes + offset,
-						PAGE_SIZE);
-		size_t reserve_bytes;
-		size_t dirty_pages;
+					 PAGE_SIZE - offset);
+		size_t reserve_bytes = PAGE_SIZE;
 		size_t copied;
-		size_t dirty_sectors;
-		size_t num_sectors;
 		int extents_locked;
 
-		WARN_ON(num_pages > nrptrs);
-
 		/*
-		 * Fault pages before locking them in prepare_pages
+		 * Fault pages before locking them in prepare_page()
 		 * to avoid recursive lock
 		 */
 		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
@@ -1673,37 +1580,27 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 
 		only_release_metadata = false;
-		sector_offset = pos & (fs_info->sectorsize - 1);
-		reserve_bytes = round_up(write_bytes + sector_offset,
-				fs_info->sectorsize);
 
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
 						  &data_reserved, pos,
 						  write_bytes);
 		if (ret < 0) {
+			size_t tmp = write_bytes;
 			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
-						   &write_bytes) > 0) {
+						   &tmp) > 0) {
+				ASSERT(tmp == write_bytes);
 				/*
 				 * For nodata cow case, no need to reserve
 				 * data space.
 				 */
 				only_release_metadata = true;
-				/*
-				 * our prealloc extent may be smaller than
-				 * write_bytes, so scale down.
-				 */
-				num_pages = DIV_ROUND_UP(write_bytes + offset,
-							 PAGE_SIZE);
-				reserve_bytes = round_up(write_bytes +
-							 sector_offset,
-							 fs_info->sectorsize);
+				reserve_bytes = 0;
 			} else {
 				break;
 			}
 		}
 
-		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
 				reserve_bytes);
 		if (ret) {
@@ -1716,16 +1613,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			break;
 		}
 
-		release_bytes = reserve_bytes;
 again:
-		/*
-		 * This is going to setup the pages array with the number of
-		 * pages we want, so we don't really need to worry about the
-		 * contents of pages from loop to loop
-		 */
-		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes,
-				    force_page_uptodate);
+		ret = prepare_one_page(inode, &page, pos, write_bytes,
+				       force_page_uptodate);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -1733,9 +1623,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 
 		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
-				&lockend, &cached_state);
+				BTRFS_I(inode), &page, 1, pos, write_bytes,
+				&lockstart, &lockend, &cached_state);
 		if (extents_locked < 0) {
 			if (extents_locked == -EAGAIN)
 				goto again;
@@ -1745,57 +1634,38 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			break;
 		}
 
-		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
-
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
-
-		/*
-		 * if we have trouble faulting in the pages, fall
-		 * back to one page at a time
-		 */
-		if (copied < write_bytes)
-			nrptrs = 1;
+		copied = iov_iter_copy_from_user_atomic(page, i, offset,
+							write_bytes);
+		flush_dcache_page(page);
 
-		if (copied == 0) {
+		if (!PageUptodate(page) && copied < write_bytes) {
+			/*
+			 * Short write on non-uptodate page, we must retry and
+			 * force the page uptodate in next run.
+			 */
+			copied = 0;
 			force_page_uptodate = true;
-			dirty_sectors = 0;
-			dirty_pages = 0;
 		} else {
+			/* Next run doesn't need forced uptodate */
 			force_page_uptodate = false;
-			dirty_pages = DIV_ROUND_UP(copied + offset,
-						   PAGE_SIZE);
 		}
 
-		if (num_sectors > dirty_sectors) {
-			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors <<
-						fs_info->sb->s_blocksize_bits;
-			if (only_release_metadata) {
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							release_bytes, true);
-			} else {
-				u64 __pos;
+		iov_iter_advance(i, copied);
 
-				__pos = round_down(pos,
-						   fs_info->sectorsize) +
-					(dirty_pages << PAGE_SHIFT);
+		if (copied > 0) {
+			ret = btrfs_dirty_pages(BTRFS_I(inode), &page, 1, pos,
+						copied, &cached_state);
+		} else {
+			/* No bytes copied, need to free reserved space */
+			if (only_release_metadata)
+				btrfs_delalloc_release_metadata(BTRFS_I(inode),
+						reserve_bytes, true);
+			else
 				btrfs_delalloc_release_space(BTRFS_I(inode),
-						data_reserved, __pos,
-						release_bytes, true);
-			}
+						data_reserved, pos, write_bytes,
+						true);
 		}
 
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-
-		if (copied > 0)
-			ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
-						dirty_pages, pos, copied,
-						&cached_state);
-
 		/*
 		 * If we have not locked the extent range, because the range's
 		 * start offset is >= i_size, we might still have a non-NULL
@@ -1811,26 +1681,22 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
-			btrfs_drop_pages(pages, num_pages);
+			btrfs_drop_pages(&page, 1);
 			break;
 		}
 
-		release_bytes = 0;
-		if (only_release_metadata)
+		if (only_release_metadata) {
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
-
-		if (only_release_metadata && copied > 0) {
 			lockstart = round_down(pos,
 					       fs_info->sectorsize);
-			lockend = round_up(pos + copied,
-					   fs_info->sectorsize) - 1;
+			lockend = lockstart + PAGE_SIZE - 1;
 
 			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
 				       lockend, EXTENT_NORESERVE, NULL,
 				       NULL, GFP_NOFS);
 		}
 
-		btrfs_drop_pages(pages, num_pages);
+		btrfs_drop_pages(&page, 1);
 
 		cond_resched();
 
@@ -1840,21 +1706,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		num_written += copied;
 	}
 
-	kfree(pages);
-
-	if (release_bytes) {
-		if (only_release_metadata) {
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					release_bytes, true);
-		} else {
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved,
-					round_down(pos, fs_info->sectorsize),
-					release_bytes, true);
-		}
-	}
-
 	extent_changeset_free(data_reserved);
 	return num_written ? num_written : ret;
 }
-- 
2.28.0

