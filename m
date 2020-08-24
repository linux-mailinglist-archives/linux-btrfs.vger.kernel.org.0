Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3924F28E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXGby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 02:31:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHXGby (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 02:31:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56811AE56
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 06:32:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: refactor btrfs_buffered_write() into process_one_batch()
Date:   Mon, 24 Aug 2020 14:31:38 +0800
Message-Id: <20200824063139.70880-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824063139.70880-1-wqu@suse.com>
References: <20200824063139.70880-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inside btrfs_buffered_write() we had a big chunk of code in the while()
loop.

Refactor this big chunk into process_one_batch(), which will do the main
job.

This refactor doesn't touch the functioniality at all, just make life
easier with more headroom for codes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 407 +++++++++++++++++++++++++-----------------------
 1 file changed, 216 insertions(+), 191 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c592350a5a82..c9516c079cc6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1402,7 +1402,10 @@ static int prepare_uptodate_page(struct inode *inode,
 }
 
 /*
- * this just gets pages into the page cache and locks them down.
+ * This just gets pages into the page cache and locks them down.
+ *
+ * @force_uptodate: Whether to force the first page uptodate.
+ *		    This happens after a short copy on non-uptodate page.
  */
 static noinline int prepare_pages(struct inode *inode, struct page **pages,
 				  size_t num_pages, loff_t pos,
@@ -1620,7 +1623,7 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
-/* Helper to get how many pages we should alloc for the batch */
+/* The helper to get how many pages we should alloc for the batch */
 static int get_nr_pages(struct btrfs_fs_info *fs_info, loff_t pos,
 			struct iov_iter *iov)
 {
@@ -1643,226 +1646,193 @@ static int get_nr_pages(struct btrfs_fs_info *fs_info, loff_t pos,
 	return nr_pages;
 }
 
-static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
-					       struct iov_iter *i)
+/*
+ * The helper to copy one batch of data from iov to pages.
+ *
+ * @pages:	The page pointer array we're going to use.
+ * @nrptrs:	The number of page pointers we can utilize
+ * @pos:	The position of this write, in bytes
+ * @iov:	The source of data.
+ * @force_uptodate: Do we need to force the first page uptodate.
+ * 		    true if previous run we hit a short copy.
+ *
+ * Return >0 as the bytes we copied, with iov advanced.
+ * Return 0 if we hit a short copy, and should force the next run to have the
+ * first page uptodate.
+ * Return <0 for error.
+ */
+static ssize_t process_one_batch(struct inode *inode, struct page **pages,
+			int nrptrs, loff_t pos, struct iov_iter *iov,
+			bool force_uptodate)
 {
-	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct page **pages = NULL;
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
+	size_t offset = offset_in_page(pos);
+	size_t sector_offset;
+	size_t write_bytes = min(iov_iter_count(iov),
+				 nrptrs * (size_t)PAGE_SIZE - offset);
+	size_t num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
+	size_t reserve_bytes;
+	size_t dirty_pages;
+	size_t copied = 0;
+	size_t dirty_sectors;
+	size_t num_sectors;
+	bool only_release_metadata = false;
 	u64 release_bytes = 0;
 	u64 lockstart;
 	u64 lockend;
-	size_t num_written = 0;
-	int nrptrs;
-	int ret = 0;
-	bool only_release_metadata = false;
-	bool force_page_uptodate = false;
-
-	nrptrs = get_nr_pages(fs_info, pos, i);
-	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
-	while (iov_iter_count(i) > 0) {
-		struct extent_state *cached_state = NULL;
-		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
-		size_t write_bytes = min(iov_iter_count(i),
-					 nrptrs * (size_t)PAGE_SIZE -
-					 offset);
-		size_t num_pages = DIV_ROUND_UP(write_bytes + offset,
-						PAGE_SIZE);
-		size_t reserve_bytes;
-		size_t dirty_pages;
-		size_t copied;
-		size_t dirty_sectors;
-		size_t num_sectors;
-		int extents_locked;
-
-		WARN_ON(num_pages > nrptrs);
+	int extents_locked;
+	int ret;
 
-		/*
-		 * Fault pages before locking them in prepare_pages
-		 * to avoid recursive lock
-		 */
-		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
-			ret = -EFAULT;
-			break;
-		}
+	WARN_ON(num_pages > nrptrs);
 
-		only_release_metadata = false;
-		sector_offset = pos & (fs_info->sectorsize - 1);
-		reserve_bytes = round_up(write_bytes + sector_offset,
-				fs_info->sectorsize);
+	/*
+	 * Fault pages before locking them in prepare_pages to avoid recursive
+	 * lock.
+	 */
+	if (unlikely(iov_iter_fault_in_readable(iov, write_bytes))) {
+		ret = -EFAULT;
+		goto out;
+	}
 
-		extent_changeset_release(data_reserved);
-		ret = btrfs_check_data_free_space(BTRFS_I(inode),
-						  &data_reserved, pos,
-						  write_bytes);
-		if (ret < 0) {
-			if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
-						   &write_bytes) > 0) {
-				/*
-				 * For nodata cow case, no need to reserve
-				 * data space.
-				 */
-				only_release_metadata = true;
-				/*
-				 * our prealloc extent may be smaller than
-				 * write_bytes, so scale down.
-				 */
-				num_pages = DIV_ROUND_UP(write_bytes + offset,
-							 PAGE_SIZE);
-				reserve_bytes = round_up(write_bytes +
-							 sector_offset,
-							 fs_info->sectorsize);
-			} else {
-				break;
-			}
-		}
+	sector_offset = pos & (fs_info->sectorsize - 1);
+	reserve_bytes = round_up(write_bytes + sector_offset,
+				 fs_info->sectorsize);
 
-		WARN_ON(reserve_bytes == 0);
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
-		if (ret) {
-			if (!only_release_metadata)
-				btrfs_free_reserved_data_space(BTRFS_I(inode),
-						data_reserved, pos,
-						write_bytes);
-			else
-				btrfs_check_nocow_unlock(BTRFS_I(inode));
-			break;
+	/* Reserve space for data and metadata */
+	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved, pos,
+					  write_bytes);
+	if (ret < 0) {
+		if (btrfs_check_nocow_lock(BTRFS_I(inode), pos,
+					   &write_bytes) > 0) {
+			/* Nodata cow case, no need to reserve data space. */
+			only_release_metadata = true;
+			/*
+			 * our prealloc extent may be smaller than
+			 * write_bytes, so scale down.
+			 */
+			num_pages = DIV_ROUND_UP(write_bytes + offset,
+						 PAGE_SIZE);
+			reserve_bytes = round_up(write_bytes + sector_offset,
+						 fs_info->sectorsize);
+		} else {
+			goto out;
 		}
+	}
 
-		release_bytes = reserve_bytes;
-again:
-		/*
-		 * This is going to setup the pages array with the number of
-		 * pages we want, so we don't really need to worry about the
-		 * contents of pages from loop to loop
-		 */
-		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes,
-				    force_page_uptodate);
-		if (ret) {
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			break;
-		}
+	WARN_ON(reserve_bytes == 0);
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserve_bytes);
+	if (ret) {
+		if (!only_release_metadata)
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
+					data_reserved, pos, write_bytes);
+		else
+			btrfs_check_nocow_unlock(BTRFS_I(inode));
+		goto out;
+	}
 
-		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
-				&lockend, &cached_state);
-		if (extents_locked < 0) {
-			if (extents_locked == -EAGAIN)
-				goto again;
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			ret = extents_locked;
-			break;
-		}
+	release_bytes = reserve_bytes;
 
-		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
+	/* Lock the pages and extent range */
+again:
+	/*
+	 * This is going to setup the pages array with the number of pages we
+	 * want, so we don't really need to worry about the contents of pages
+	 * from loop to loop.
+	 */
+	ret = prepare_pages(inode, pages, num_pages, pos, write_bytes,
+			    force_uptodate);
+	if (ret) {
+		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+		goto out;
+	}
 
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
+	extents_locked = lock_and_cleanup_extent_if_need(BTRFS_I(inode), pages,
+			num_pages, pos, write_bytes, &lockstart,
+			&lockend, &cached_state);
+	if (extents_locked < 0) {
+		if (extents_locked == -EAGAIN)
+			goto again;
+		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+		ret = extents_locked;
+		goto out;
+	}
 
-		/*
-		 * if we have trouble faulting in the pages, fall
-		 * back to one page at a time
-		 */
-		if (copied < write_bytes)
-			nrptrs = 1;
+	/* Copy the data from iov to pages */
+	copied = btrfs_copy_from_user(pos, write_bytes, pages, iov);
 
-		if (copied == 0) {
-			force_page_uptodate = true;
-			dirty_sectors = 0;
-			dirty_pages = 0;
-		} else {
-			force_page_uptodate = false;
-			dirty_pages = DIV_ROUND_UP(copied + offset,
-						   PAGE_SIZE);
-		}
+	num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
+	dirty_sectors = round_up(copied + sector_offset, fs_info->sectorsize);
+	dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
 
-		if (num_sectors > dirty_sectors) {
-			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors <<
-						fs_info->sb->s_blocksize_bits;
-			if (only_release_metadata) {
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							release_bytes, true);
-			} else {
-				u64 __pos;
+	if (copied == 0) {
+		dirty_sectors = 0;
+		dirty_pages = 0;
+	} else {
+		dirty_pages = DIV_ROUND_UP(copied + offset, PAGE_SIZE);
+	}
 
-				__pos = round_down(pos,
-						   fs_info->sectorsize) +
-					(dirty_pages << PAGE_SHIFT);
-				btrfs_delalloc_release_space(BTRFS_I(inode),
-						data_reserved, __pos,
+	if (num_sectors > dirty_sectors) {
+		/* release everything except the sectors we dirtied */
+		release_bytes -= dirty_sectors << fs_info->sb->s_blocksize_bits;
+		if (only_release_metadata) {
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
 						release_bytes, true);
-			}
-		}
-
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-
-		if (copied > 0)
-			ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
-						dirty_pages, pos, copied,
-						&cached_state);
-
-		/*
-		 * If we have not locked the extent range, because the range's
-		 * start offset is >= i_size, we might still have a non-NULL
-		 * cached extent state, acquired while marking the extent range
-		 * as delalloc through btrfs_dirty_pages(). Therefore free any
-		 * possible cached extent state to avoid a memory leak.
-		 */
-		if (extents_locked)
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     lockstart, lockend, &cached_state);
-		else
-			free_extent_state(cached_state);
+		} else {
+			u64 __pos;
 
-		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
-		if (ret) {
-			btrfs_drop_pages(pages, num_pages);
-			break;
+			__pos = round_down(pos, fs_info->sectorsize) +
+				(dirty_pages << PAGE_SHIFT);
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+					data_reserved, __pos,
+					release_bytes, true);
 		}
+	}
 
-		release_bytes = 0;
-		if (only_release_metadata)
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
+	release_bytes = round_up(copied + sector_offset, fs_info->sectorsize);
 
-		if (only_release_metadata && copied > 0) {
-			lockstart = round_down(pos,
-					       fs_info->sectorsize);
-			lockend = round_up(pos + copied,
-					   fs_info->sectorsize) - 1;
+	if (copied > 0)
+		ret = btrfs_dirty_pages(BTRFS_I(inode), pages, dirty_pages, pos,
+				copied, &cached_state);
 
-			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
-				       lockend, EXTENT_NORESERVE, NULL,
-				       NULL, GFP_NOFS);
-		}
+	/*
+	 * If we have not locked the extent range, because the range's
+	 * start offset is >= i_size, we might still have a non-NULL
+	 * cached extent state, acquired while marking the extent range
+	 * as delalloc through btrfs_dirty_pages(). Therefore free any
+	 * possible cached extent state to avoid a memory leak.
+	 */
+	if (extents_locked)
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
+				     lockstart, lockend, &cached_state);
+	else
+		free_extent_state(cached_state);
 
+	btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+	if (ret) {
 		btrfs_drop_pages(pages, num_pages);
+		goto out;
+	}
 
-		cond_resched();
+	release_bytes = 0;
+	if (only_release_metadata)
+		btrfs_check_nocow_unlock(BTRFS_I(inode));
 
-		balance_dirty_pages_ratelimited(inode->i_mapping);
+	if (only_release_metadata && copied > 0) {
+		lockstart = round_down(pos, fs_info->sectorsize);
+		lockend = round_up(pos + copied, fs_info->sectorsize) - 1;
 
-		pos += copied;
-		num_written += copied;
+		set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+				EXTENT_NORESERVE, NULL, NULL, GFP_NOFS);
 	}
 
-	kfree(pages);
+	btrfs_drop_pages(pages, num_pages);
 
+	cond_resched();
+
+	balance_dirty_pages_ratelimited(inode->i_mapping);
+out:
 	if (release_bytes) {
 		if (only_release_metadata) {
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
@@ -1876,7 +1846,62 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 	}
 
-	extent_changeset_free(data_reserved);
+	if (!copied && ret < 0)
+		return ret;
+	return copied;
+}
+
+static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
+					       struct iov_iter *i)
+{
+	struct file *file = iocb->ki_filp;
+	loff_t pos = iocb->ki_pos;
+	struct inode *inode = file_inode(file);
+	struct page **pages = NULL;
+	size_t num_written = 0;
+	int nrptrs;
+	int orig_nrptrs;
+	int ret = 0;
+	bool force_page_uptodate = false;
+
+	orig_nrptrs = get_nr_pages(BTRFS_I(inode)->root->fs_info, pos, i);
+	nrptrs = orig_nrptrs;
+	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	while (iov_iter_count(i) > 0) {
+		ssize_t copied;
+
+		copied = process_one_batch(inode, pages, nrptrs, pos, i,
+					   force_page_uptodate);
+		if (copied < 0)
+			break;
+
+		if (copied == 0) {
+			/*
+			 * We had a short copy on even the first page, need to
+			 * force the next page uptodate and fall back to page
+			 * by page pace.
+			 */
+			nrptrs = 1;
+			force_page_uptodate = true;
+		} else {
+			/*
+			 * Copy finished without problem. No longer need to
+			 * force next page uptodate, and revert to regular
+			 * multi-page pace.
+			 */
+			nrptrs = orig_nrptrs;
+			force_page_uptodate = false;
+		}
+
+		pos += copied;
+		num_written += copied;
+	}
+
+	kfree(pages);
+
 	return num_written ? num_written : ret;
 }
 
-- 
2.28.0

