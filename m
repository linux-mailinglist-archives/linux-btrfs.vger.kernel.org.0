Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0471269DE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIOFgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIOFgU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61043AEA2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/19] btrfs: implement subpage metadata read and its endio function
Date:   Tue, 15 Sep 2020 13:35:30 +0800
Message-Id: <20200915053532.63279-18-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage metadata read, since we're completely relying on io tree
other than page bits, its read submission and endio function is
different from the original page size.

For submission part:
- Do extent locking/waiting
  Instead of page locking/waiting, since we don't rely on page bits anymore.

- Submit extent page directly
  To simply the process, as all the metadata read is always contained in
  one page.

For endio part:
- Do extent locking/waiting

This behavior has a small problem that, extent locking/waiting are all
going to allocate memory, thus they can all fail.

Currently we're using GFP_ATOMIC, but still we may hit ENOSPC someday.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  89 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.c | 101 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2ef35eb7a6e1..1de5a0fef2f5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -645,6 +645,92 @@ static int btrfs_check_extent_buffer(struct extent_buffer *eb)
 	return ret;
 }
 
+static int btree_read_subpage_endio_hook(struct page *page, u64 start, u64 end,
+					 int mirror)
+{
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	struct extent_buffer *eb;
+	int reads_done;
+	int ret = 0;
+
+	if (!IS_ALIGNED(start, fs_info->sectorsize) ||
+	    !IS_ALIGNED(end - start + 1, fs_info->sectorsize) ||
+	    !IS_ALIGNED(end - start + 1, fs_info->nodesize)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info, "invalid tree read bytenr");
+		return -EUCLEAN;
+	}
+
+	/*
+	 * We don't allow bio merge for subpage metadata read, so we should
+	 * only get one eb for each endio hook.
+	 */
+	ASSERT(end == start + fs_info->nodesize - 1);
+	ASSERT(PagePrivate(page));
+
+	rcu_read_lock();
+	eb = radix_tree_lookup(&fs_info->buffer_radix,
+			       start / fs_info->sectorsize);
+	rcu_read_unlock();
+
+	/*
+	 * When we are reading one tree block, eb must have been
+	 * inserted into the radix tree. If not something is wrong.
+	 */
+	if (!eb) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info,
+			"can't find extent buffer for bytenr %llu",
+			start);
+		return -EUCLEAN;
+	}
+	/*
+	 * The pending IO might have been the only thing that kept
+	 * this buffer in memory.  Make sure we have a ref for all
+	 * this other checks
+	 */
+	atomic_inc(&eb->refs);
+
+	reads_done = atomic_dec_and_test(&eb->io_pages);
+	/* Subpage read must finish in page read */
+	ASSERT(reads_done);
+
+	eb->read_mirror= mirror;
+	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
+		ret = -EIO;
+		goto err;
+	}
+	ret = btrfs_check_extent_buffer(eb);
+	if (ret < 0)
+		goto err;
+
+	if (test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
+		btree_readahead_hook(eb, ret);
+
+	set_extent_buffer_uptodate(eb);
+
+	free_extent_buffer(eb);
+
+	/*
+	 * Since we don't use PageLocked() but extent_io_tree lock to lock the
+	 * range, we need to unlock the range here.
+	 */
+	unlock_extent(io_tree, start, end);
+	return ret;
+err:
+	/*
+	 * our io error hook is going to dec the io pages
+	 * again, we have to make sure it has something to
+	 * decrement
+	 */
+	atomic_inc(&eb->io_pages);
+	clear_extent_buffer_uptodate(eb);
+	free_extent_buffer(eb);
+	unlock_extent(io_tree, start, end);
+	return ret;
+}
+
 static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 				      u64 phy_offset, struct page *page,
 				      u64 start, u64 end, int mirror)
@@ -653,6 +739,9 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	int ret = 0;
 	bool reads_done;
 
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
+		return btree_read_subpage_endio_hook(page, start, end, mirror);
+
 	/* Metadata pages that goes through IO should all have private set */
 	ASSERT(PagePrivate(page) && page->private);
 	eb = (struct extent_buffer *)page->private;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2af6786e6ab4..75437a55a986 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2923,7 +2923,13 @@ static void end_bio_extent_readpage(struct bio *bio)
 			ClearPageUptodate(page);
 			SetPageError(page);
 		}
-		unlock_page(page);
+
+		/*
+		 * For subpage metadata read, we don't have page locked, but
+		 * rely on EXTENT_LOCKED bit to handle lock completely.
+		 */
+		if (!(fs_info->sectorsize < PAGE_SIZE && !data_inode))
+			unlock_page(page);
 		offset += len;
 
 		if (unlikely(!uptodate)) {
@@ -3064,6 +3070,14 @@ static int submit_extent_page(unsigned int opf,
 		else
 			contig = bio_end_sector(bio) == sector;
 
+		/*
+		 * For subpage metadata read, never merge request, so that
+		 * we get endio hook called on each metadata read.
+		 */
+		if (page_to_fs_info(page)->sectorsize < PAGE_SIZE &&
+		    tree->owner == IO_TREE_BTREE_IO)
+			ASSERT(force_bio_submit);
+
 		ASSERT(tree->ops);
 		if (btrfs_bio_fits_in_stripe(page, page_size, bio, bio_flags))
 			can_merge = false;
@@ -5593,6 +5607,15 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 	int num_pages;
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	/* For subpage eb, we don't set page bits, but extent_io_tree bits */
+	if (eb->fs_info->sectorsize < PAGE_SIZE) {
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+
+		clear_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
+				  EXTENT_UPTODATE);
+		return;
+	}
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
@@ -5608,6 +5631,20 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	int num_pages;
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+
+	/*
+	 * For subpage size, we ignore page bits, but need to set io tree range
+	 * uptodate
+	 */
+	if (eb->fs_info->sectorsize < PAGE_SIZE) {
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+
+		set_extent_uptodate(io_tree, eb->start, eb->start + eb->len - 1,
+				    NULL, GFP_ATOMIC);
+		return;
+	}
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
@@ -5615,6 +5652,65 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	struct page *page = eb->pages[0];
+	struct bio *bio = NULL;
+	int ret = 0;
+
+	/* We don't lock page, but only extent_io_tree for btree inode*/
+	if (wait == WAIT_NONE) {
+		ret = try_lock_extent(io_tree, eb->start,
+				      eb->start + eb->len - 1);
+		if (ret == 0)
+			return ret;
+	} else {
+		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = 0;
+	atomic_set(&eb->io_pages, 1);
+	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
+	    test_range_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			   EXTENT_UPTODATE, 1, NULL)) {
+		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
+		return ret;
+	}
+
+	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, page, eb->start,
+				 eb->len, eb->start - page_offset(page), &bio,
+				 end_bio_extent_readpage, mirror_num, 0, 0,
+				 true);
+	if (ret) {
+		/*
+		 * In the endio function, if we hit something wrong we will
+		 * increase the io_pages, so here we need to decrease it for error
+		 * path.
+		 */
+		atomic_dec(&eb->io_pages);
+	}
+	if (bio) {
+		int tmp;
+
+		tmp = submit_one_bio(bio, mirror_num, 0);
+		if (tmp < 0)
+			return tmp;
+	}
+	if (ret || wait != WAIT_COMPLETE)
+		return ret;
+
+	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			EXTENT_LOCKED);
+	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+		ret = -EIO;
+	return ret;
+}
+
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 {
 	int i;
@@ -5631,6 +5727,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
 
+	if (eb->fs_info->sectorsize < PAGE_SIZE)
+		return read_extent_buffer_subpage(eb, wait, mirror_num);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-- 
2.28.0

