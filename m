Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5334360177
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhDOFGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhDOFGc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFHFBhbeu1B9LUl9dZOp22stHAsoSgGTGMS66evy0F4=;
        b=dSxJBuk/0EW/4GhFI09WjCPbDJzaLbxmFCk8h2Wbal02xKxPdcMAMlnlJpTzl4fOlvzv9O
        IyJij7Wu7MZWpV+jfzWdPAjto4Qdt+b6Xoh/a/rRAnLS2J7xxkrrrJJ9jgtQ+714O/nGNs
        9dY2cXwY6z4hCfFUUx+5sV1Pvfsi3y0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9329EAFEA
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:06:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 40/42] btrfs: refactor submit_extent_page() to make bio and its flag tracing easier
Date:   Thu, 15 Apr 2021 13:04:46 +0800
Message-Id: <20210415050448.267306-41-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a lot of code inside extent_io.c needs both "struct bio
**bio_ret" and "unsigned long prev_bio_flags", along with some parameter
like "unsigned long bio_flags".

Such strange parameter is here for bio assembly.

For example, we have such inode page layout:

0	4K	8K	12K
|<-- Extent A-->|<- EB->|

Then what we do is:
- Page [0, 4K)
  *bio_ret = NULL
  So we allocate a new bio to bio_ret,
  Add page [0, 4K) to *bio_ret.

- Page [4K, 8K)
  *bio_ret != NULL
  We found this page is continuous to *bio_ret,
  and if we're not at stripe boundary, we
  add page [4K, 8K) to *bio_ret.

- Page [8K, 12K)
  *bio_ret != NULL
  But we found this page is not continuous, so
  we submit *bio_ret, then allocate a new bio,
  and add page [8K, 12K) to the new bio.

This means we need to record both the bio and its bio_flag, but we
record them manually using those strange parameter list, other than
encapsulate them into their own structure.

So this patch will introduce a new structure, btrfs_bio_ctrl, to record
both the bio, and its bio_flags.

Also, in above case, for all pages added to the bio, we need to check if
the new page crosses stripe boundary.
This check itself can be time consuming, and we don't really need to do
that for each page.

This patch also integrate the stripe boundary check into btrfs_bio_ctrl.
When a new bio is allocated, the stripe and ordered extent boundary is
also calculated, so no matter how large the bio will be, we only
calculate the boundaries once, to save some CPU time.

The following functions/structures are affected:
- struct extent_page_data
  Replace its bio pointer with structure btrfs_bio_ctrl (embedded
  structure, not pointer)

- end_write_bio()
- flush_write_bio()
  Just change how bio is fetched

- btrfs_bio_add_page()
  Use pre-calculated boundaries instead of re-calculating them.
  And use @bio_ctrl to replace @bio and @prev_bio_flags.

- calc_bio_boundaries()
  New function

- submit_extent_page() callers
- btrfs_do_readpage() callers
- contiguous_readpages() callers
  To Use @bio_ctrl to raplace @bio and @prev_bio_flags, and how to grab
  bio.

- btrfs_bio_fits_in_ordered_extent()
  Removed, as now the ordered extent size limit is done at bio
  allocation time, no need to check for each page range.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h     |   2 -
 fs/btrfs/extent_io.c | 212 +++++++++++++++++++++++++++----------------
 fs/btrfs/extent_io.h |  13 ++-
 fs/btrfs/inode.c     |  36 +-------
 4 files changed, 152 insertions(+), 111 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f8d1e495deda..deb781a8cf92 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3134,8 +3134,6 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
-bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
-				      unsigned int size);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 81931c02c0e4..4afc3949e6e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -136,7 +136,7 @@ struct tree_entry {
 };
 
 struct extent_page_data {
-	struct bio *bio;
+	struct btrfs_bio_ctrl bio_ctrl;
 	/* tells writepage not to lock the state bits for this range
 	 * it still does the unlocking
 	 */
@@ -185,10 +185,12 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 /* Cleanup unsubmitted bios */
 static void end_write_bio(struct extent_page_data *epd, int ret)
 {
-	if (epd->bio) {
-		epd->bio->bi_status = errno_to_blk_status(ret);
-		bio_endio(epd->bio);
-		epd->bio = NULL;
+	struct bio *bio = epd->bio_ctrl.bio;
+
+	if (bio) {
+		bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(bio);
+		epd->bio_ctrl.bio = NULL;
 	}
 }
 
@@ -201,9 +203,10 @@ static void end_write_bio(struct extent_page_data *epd, int ret)
 static int __must_check flush_write_bio(struct extent_page_data *epd)
 {
 	int ret = 0;
+	struct bio *bio = epd->bio_ctrl.bio;
 
-	if (epd->bio) {
-		ret = submit_one_bio(epd->bio, 0, 0);
+	if (bio) {
+		ret = submit_one_bio(bio, 0, 0);
 		/*
 		 * Clean up of epd->bio is handled by its endio function.
 		 * And endio is either triggered by successful bio execution
@@ -211,7 +214,7 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 		 * So at this point, no matter what happened, we don't need
 		 * to clean up epd->bio.
 		 */
-		epd->bio = NULL;
+		epd->bio_ctrl.bio = NULL;
 	}
 	return ret;
 }
@@ -3204,42 +3207,100 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
  *
  * Return true if successfully page added. Otherwise, return false.
  */
-static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
+static bool btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
+			       struct page *page,
 			       u64 disk_bytenr, unsigned int size,
 			       unsigned int pg_offset,
-			       unsigned long prev_bio_flags,
 			       unsigned long bio_flags)
 {
+	struct bio *bio = bio_ctrl->bio;
+	u32 bio_size = bio->bi_iter.bi_size;
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 	bool contig;
 	int ret;
 
-	if (prev_bio_flags != bio_flags)
+	ASSERT(bio);
+	/* The limit should be calculated when bio_ctrl->bio is allocated */
+	ASSERT(bio_ctrl->len_to_oe_boundary &&
+	       bio_ctrl->len_to_stripe_boundary);
+	if (bio_ctrl->bio_flags != bio_flags)
 		return false;
 
-	if (prev_bio_flags & EXTENT_BIO_COMPRESSED)
+	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED)
 		contig = bio->bi_iter.bi_sector == sector;
 	else
 		contig = bio_end_sector(bio) == sector;
 	if (!contig)
 		return false;
 
-	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
+	if (bio_size + size > bio_ctrl->len_to_oe_boundary ||
+	    bio_size + size > bio_ctrl->len_to_stripe_boundary)
 		return false;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct page *first_page = bio_first_bvec_all(bio)->bv_page;
-
-		if (!btrfs_bio_fits_in_ordered_extent(first_page, bio, size))
-			return false;
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
 		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
-	} else {
+	else
 		ret = bio_add_page(bio, page, size, pg_offset);
-	}
 
 	return ret == size;
 }
 
+static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
+			       struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_io_geometry geom;
+	struct btrfs_ordered_extent *ordered;
+	struct extent_map *em;
+	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
+	int ret;
+
+	/*
+	 * Pages for compressed extent are never submitted to disk directly,
+	 * thus it has no real boundary, just set them to U32_MAX.
+	 *
+	 * The split happens for real compressed bio, which happens in
+	 * btrfs_submit_compressed_read/write().
+	 */
+	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED) {
+		bio_ctrl->len_to_oe_boundary = U32_MAX;
+		bio_ctrl->len_to_stripe_boundary = U32_MAX;
+		return 0;
+	}
+	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
+				    logical, &geom);
+	if (ret < 0) {
+		free_extent_map(em);
+		return ret;
+	}
+	if (geom.len > U32_MAX)
+		bio_ctrl->len_to_stripe_boundary = U32_MAX;
+	else
+		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
+
+	if (!btrfs_is_zoned(fs_info) ||
+	    bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
+		bio_ctrl->len_to_oe_boundary = U32_MAX;
+		return 0;
+	}
+
+	ASSERT(fs_info->max_zone_append_size > 0);
+	/* Ordered extent not yet created, so we're good */
+	ordered = btrfs_lookup_ordered_extent(inode, logical);
+	if (!ordered) {
+		bio_ctrl->len_to_oe_boundary = U32_MAX;
+		return 0;
+	}
+
+	bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
+		ordered->disk_bytenr + ordered->disk_num_bytes - logical);
+	btrfs_put_ordered_extent(ordered);
+	return 0;
+}
+
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
@@ -3256,12 +3317,11 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
  */
 static int submit_extent_page(unsigned int opf,
 			      struct writeback_control *wbc,
+			      struct btrfs_bio_ctrl *bio_ctrl,
 			      struct page *page, u64 disk_bytenr,
 			      size_t size, unsigned long pg_offset,
-			      struct bio **bio_ret,
 			      bio_end_io_t end_io_func,
 			      int mirror_num,
-			      unsigned long prev_bio_flags,
 			      unsigned long bio_flags,
 			      bool force_bio_submit)
 {
@@ -3272,21 +3332,19 @@ static int submit_extent_page(unsigned int opf,
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	ASSERT(bio_ret);
+	ASSERT(bio_ctrl);
 
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
-	if (*bio_ret) {
-		bio = *bio_ret;
+	if (bio_ctrl->bio) {
+		bio = bio_ctrl->bio;
 		if (force_bio_submit ||
-		    !btrfs_bio_add_page(bio, page, disk_bytenr, io_size,
-					pg_offset, prev_bio_flags, bio_flags)) {
-			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
-			if (ret < 0) {
-				*bio_ret = NULL;
+		    !btrfs_bio_add_page(bio_ctrl, page, disk_bytenr, io_size,
+					pg_offset, bio_flags)) {
+			ret = submit_one_bio(bio, mirror_num, bio_ctrl->bio_flags);
+			bio_ctrl->bio = NULL;
+			if (ret < 0)
 				return ret;
-			}
-			bio = NULL;
 		} else {
 			if (wbc)
 				wbc_account_cgroup_owner(wbc, page, io_size);
@@ -3324,7 +3382,9 @@ static int submit_extent_page(unsigned int opf,
 		free_extent_map(em);
 	}
 
-	*bio_ret = bio;
+	bio_ctrl->bio = bio;
+	bio_ctrl->bio_flags = bio_flags;
+	ret = calc_bio_boundaries(bio_ctrl, inode);
 
 	return ret;
 }
@@ -3437,7 +3497,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
  * return 0 on success, otherwise return error
  */
 int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
-		      struct bio **bio, unsigned long *bio_flags,
+		      struct btrfs_bio_ctrl *bio_ctrl,
 		      unsigned int read_flags, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
@@ -3622,15 +3682,13 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 page, disk_bytenr, iosize,
-					 pg_offset, bio,
+					 bio_ctrl, page, disk_bytenr, iosize,
+					 pg_offset,
 					 end_bio_extent_readpage, 0,
-					 *bio_flags,
 					 this_bio_flag,
 					 force_bio_submit);
 		if (!ret) {
 			nr++;
-			*bio_flags = this_bio_flag;
 		} else {
 			unlock_extent(tree, cur, cur + iosize - 1);
 			end_page_read(page, false, cur, iosize);
@@ -3644,11 +3702,10 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 }
 
 static inline void contiguous_readpages(struct page *pages[], int nr_pages,
-					     u64 start, u64 end,
-					     struct extent_map **em_cached,
-					     struct bio **bio,
-					     unsigned long *bio_flags,
-					     u64 *prev_em_start)
+					u64 start, u64 end,
+					struct extent_map **em_cached,
+					struct btrfs_bio_ctrl *bio_ctrl,
+					u64 *prev_em_start)
 {
 	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
 	int index;
@@ -3656,7 +3713,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
-		btrfs_do_readpage(pages[index], em_cached, bio, bio_flags,
+		btrfs_do_readpage(pages[index], em_cached, bio_ctrl,
 				  REQ_RAHEAD, prev_em_start);
 		put_page(pages[index]);
 	}
@@ -3945,11 +4002,12 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 */
 		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
 
-		ret = submit_extent_page(opf | write_flags, wbc, page,
+		ret = submit_extent_page(opf | write_flags, wbc,
+					 &epd->bio_ctrl, page,
 					 disk_bytenr, iosize,
-					 cur - page_offset(page), &epd->bio,
+					 cur - page_offset(page),
 					 end_bio_extent_writepage,
-					 0, 0, 0, false);
+					 0, 0, false);
 		if (ret) {
 			btrfs_page_set_error(fs_info, page, cur, iosize);
 			if (PageWriteback(page))
@@ -4391,10 +4449,10 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
 	if (no_dirty_ebs)
 		clear_page_dirty_for_io(page);
 
-	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc, page,
-			eb->start, eb->len, eb->start - page_offset(page),
-			&epd->bio, end_bio_extent_buffer_writepage, 0, 0, 0,
-			false);
+	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
+			&epd->bio_ctrl, page, eb->start, eb->len,
+			eb->start - page_offset(page),
+			end_bio_extent_buffer_writepage, 0, 0, false);
 	if (ret) {
 		btrfs_subpage_clear_writeback(fs_info, page, eb->start,
 					      eb->len);
@@ -4456,10 +4514,10 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 		clear_page_dirty_for_io(p);
 		set_page_writeback(p);
 		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 p, disk_bytenr, PAGE_SIZE, 0,
-					 &epd->bio,
+					 &epd->bio_ctrl, p, disk_bytenr,
+					 PAGE_SIZE, 0,
 					 end_bio_extent_buffer_writepage,
-					 0, 0, 0, false);
+					 0, 0, false);
 		if (ret) {
 			set_btree_ioerr(p, eb);
 			if (PageWriteback(p))
@@ -4675,7 +4733,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 {
 	struct extent_buffer *eb_context = NULL;
 	struct extent_page_data epd = {
-		.bio = NULL,
+		.bio_ctrl = { 0 },
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
@@ -4957,7 +5015,7 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 {
 	int ret;
 	struct extent_page_data epd = {
-		.bio = NULL,
+		.bio_ctrl = { 0 },
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
@@ -4984,7 +5042,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		PAGE_SHIFT;
 
 	struct extent_page_data epd = {
-		.bio = NULL,
+		.bio_ctrl = { 0 },
 		.extent_locked = 1,
 		.sync_io = mode == WB_SYNC_ALL,
 	};
@@ -5027,7 +5085,7 @@ int extent_writepages(struct address_space *mapping,
 {
 	int ret = 0;
 	struct extent_page_data epd = {
-		.bio = NULL,
+		.bio_ctrl = { 0 },
 		.extent_locked = 0,
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
@@ -5044,8 +5102,7 @@ int extent_writepages(struct address_space *mapping,
 
 void extent_readahead(struct readahead_control *rac)
 {
-	struct bio *bio = NULL;
-	unsigned long bio_flags = 0;
+	struct btrfs_bio_ctrl bio_ctrl = { 0 };
 	struct page *pagepool[16];
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
@@ -5056,14 +5113,14 @@ void extent_readahead(struct readahead_control *rac)
 		u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
 
 		contiguous_readpages(pagepool, nr, contig_start, contig_end,
-				&em_cached, &bio, &bio_flags, &prev_em_start);
+				&em_cached, &bio_ctrl, &prev_em_start);
 	}
 
 	if (em_cached)
 		free_extent_map(em_cached);
 
-	if (bio) {
-		if (submit_one_bio(bio, 0, bio_flags))
+	if (bio_ctrl.bio) {
+		if (submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags))
 			return;
 	}
 }
@@ -6338,7 +6395,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
 	struct page *page = eb->pages[0];
-	struct bio *bio = NULL;
+	struct btrfs_bio_ctrl bio_ctrl = { 0 };
 	int ret = 0;
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
@@ -6371,9 +6428,10 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	check_buffer_tree_ref(eb);
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
-	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, page, eb->start,
-				 eb->len, eb->start - page_offset(page), &bio,
-				 end_bio_extent_readpage, mirror_num, 0, 0,
+	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, &bio_ctrl,
+				 page, eb->start, eb->len,
+				 eb->start - page_offset(page),
+				 end_bio_extent_readpage, mirror_num, 0,
 				 true);
 	if (ret) {
 		/*
@@ -6383,10 +6441,11 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		 */
 		atomic_dec(&eb->io_pages);
 	}
-	if (bio) {
+	if (bio_ctrl.bio) {
 		int tmp;
 
-		tmp = submit_one_bio(bio, mirror_num, 0);
+		tmp = submit_one_bio(bio_ctrl.bio, mirror_num, 0);
+		bio_ctrl.bio = NULL;
 		if (tmp < 0)
 			return tmp;
 	}
@@ -6409,8 +6468,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	int all_uptodate = 1;
 	int num_pages;
 	unsigned long num_reads = 0;
-	struct bio *bio = NULL;
-	unsigned long bio_flags = 0;
+	struct btrfs_bio_ctrl bio_ctrl = { 0 };
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
@@ -6474,9 +6532,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 
 			ClearPageError(page);
 			err = submit_extent_page(REQ_OP_READ | REQ_META, NULL,
-					 page, page_offset(page), PAGE_SIZE, 0,
-					 &bio, end_bio_extent_readpage,
-					 mirror_num, 0, 0, false);
+					 &bio_ctrl, page, page_offset(page),
+					 PAGE_SIZE, 0, end_bio_extent_readpage,
+					 mirror_num, 0, false);
 			if (err) {
 				/*
 				 * We failed to submit the bio so it's the
@@ -6493,8 +6551,10 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 		}
 	}
 
-	if (bio) {
-		err = submit_one_bio(bio, mirror_num, bio_flags);
+	if (bio_ctrl.bio) {
+		err = submit_one_bio(bio_ctrl.bio, mirror_num,
+				     bio_ctrl.bio_flags);
+		bio_ctrl.bio = NULL;
 		if (err)
 			return err;
 	}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 32a0d541144e..1d7bc27719da 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -101,6 +101,17 @@ struct extent_buffer {
 #endif
 };
 
+/*
+ * Structure to record info about the bio being assembled, and other
+ * info like how many bytes there are before stripe/ordered extent boundary.
+ */
+struct btrfs_bio_ctrl {
+	struct bio *bio;
+	unsigned long bio_flags;
+	u32 len_to_stripe_boundary;
+	u32 len_to_oe_boundary;
+};
+
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
@@ -169,7 +180,7 @@ int try_release_extent_buffer(struct page *page);
 int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 				unsigned long bio_flags);
 int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
-		      struct bio **bio, unsigned long *bio_flags,
+		      struct btrfs_bio_ctrl *bio_ctrl,
 		      unsigned int read_flags, u64 *prev_em_start);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5030bbf3a667..077c0aa4f846 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2266,33 +2266,6 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
-bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
-				      unsigned int size)
-{
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_ordered_extent *ordered;
-	u64 len = bio->bi_iter.bi_size + size;
-	bool ret = true;
-
-	ASSERT(btrfs_is_zoned(fs_info));
-	ASSERT(fs_info->max_zone_append_size > 0);
-	ASSERT(bio_op(bio) == REQ_OP_ZONE_APPEND);
-
-	/* Ordered extent not yet created, so we're good */
-	ordered = btrfs_lookup_ordered_extent(inode, page_offset(page));
-	if (!ordered)
-		return ret;
-
-	if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) + len >
-	    ordered->disk_bytenr + ordered->disk_num_bytes)
-		ret = false;
-
-	btrfs_put_ordered_extent(ordered);
-
-	return ret;
-}
-
 static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 					   struct bio *bio, loff_t file_offset)
 {
@@ -8257,15 +8230,14 @@ int btrfs_readpage(struct file *file, struct page *page)
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	unsigned long bio_flags = 0;
-	struct bio *bio = NULL;
+	struct btrfs_bio_ctrl bio_ctrl = { 0 };
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = btrfs_do_readpage(page, NULL, &bio, &bio_flags, 0, NULL);
-	if (bio)
-		ret = submit_one_bio(bio, 0, bio_flags);
+	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
+	if (bio_ctrl.bio)
+		ret = submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
 	return ret;
 }
 
-- 
2.31.1

