Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42A2B799B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgKRIxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRIxw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGgYqM4sh5iqAPoGDfcQql8JeD4VfBTdoN6LgNP+qMc=;
        b=Hk4uRcPfHGj7GT7l1WMiqKcaZIQDcsiMpy+S5gp1Up0d3xieKg0w9qmCDoCZDdo2ONZG8G
        WWc0CKv+nxXTvQJRc8OfghEK4y4fIScAl02+gDekFFjKlR5ntN/a/ZLEJ+pLf99ZRazkzz
        CFo29ETV+LLpyiXQi6SxNrsN3cL6i5k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EB2DAD2F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/14] btrfs: introduce btrfs_subpage for data inodes
Date:   Wed, 18 Nov 2020 16:53:17 +0800
Message-Id: <20201118085319.56668-13-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage sector size, data also need extra info to make sure
which sectors in a page are uptodate/dirty/...

This patch will make pages for data inodes to get btrfs_subpage
structure attached, and detached when the page is freed.

This patch also slightly changes the timing when
set_page_extent_mapped() to make sure:
- We have page->mapping set
  page->mapping->host is used to grab btrfs_fs_info, thus we can only
  call this function after page is mapped to an inode.

  One call site attaches pages to inode manually, thus we have to modify
  the timing of set_page_extent_mapped() a little.

- As soon as possible, before other operations
  Since memory allocation can fail, we have to do extra error handling.
  Calling set_page_extent_mapped() as soon as possible can simply the
  error handling for several call sites.

The idea is pretty much the same as iomap_page, but with more bitmaps
for btrfs specific cases.

Currently the plan is to switch iomap if iomap can provide sector
aligned write back (only write back dirty sectors, but not the full
page, data balance require this feature).

So we will stick to btrfs specific bitmap for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c      | 10 ++++++--
 fs/btrfs/extent_io.c        | 47 +++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.h        |  3 ++-
 fs/btrfs/file.c             | 10 +++++---
 fs/btrfs/free-space-cache.c | 15 +++++++++---
 fs/btrfs/inode.c            | 12 ++++++----
 fs/btrfs/ioctl.c            |  5 +++-
 fs/btrfs/reflink.c          |  5 +++-
 fs/btrfs/relocation.c       | 12 ++++++++--
 9 files changed, 98 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3fb6fde2ca13..f0b119a910a4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -542,13 +542,19 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			goto next;
 		}
 
-		end = last_offset + PAGE_SIZE - 1;
 		/*
 		 * at this point, we have a locked page in the page cache
 		 * for these bytes in the file.  But, we have to make
 		 * sure they map to this compressed extent on disk.
 		 */
-		set_page_extent_mapped(page);
+		ret = set_page_extent_mapped(page);
+		if (ret < 0) {
+			unlock_page(page);
+			put_page(page);
+			break;
+		}
+
+		end = last_offset + PAGE_SIZE - 1;
 		lock_extent(tree, last_offset, end);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, last_offset,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 236de0b6b20a..3d1dee27db8a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3232,10 +3232,40 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
 	return 0;
 }
 
-void set_page_extent_mapped(struct page *page)
+int __must_check set_page_extent_mapped(struct page *page)
 {
-	if (!PagePrivate(page))
+	struct btrfs_fs_info *fs_info;
+
+	ASSERT(page->mapping);
+
+	if (PagePrivate(page))
+		return 0;
+
+	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	if (!btrfs_is_subpage(fs_info)) {
 		attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
+		return 0;
+	}
+
+	return btrfs_attach_subpage(fs_info, page);
+}
+
+void clear_page_extent_mapped(struct page *page)
+{
+	struct btrfs_fs_info *fs_info;
+
+	ASSERT(page->mapping);
+
+	if (!PagePrivate(page))
+		return;
+
+	fs_info = btrfs_sb(page->mapping->host->i_sb);
+	if (!btrfs_is_subpage(fs_info)) {
+		detach_page_private(page);
+		return;
+	}
+
+	btrfs_detach_subpage(fs_info, page);
 }
 
 static struct extent_map *
@@ -3292,7 +3322,12 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	unsigned long this_bio_flag = 0;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
-	set_page_extent_mapped(page);
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		unlock_extent(tree, start, end);
+		SetPageError(page);
+		goto out;
+	}
 
 	if (!PageUptodate(page)) {
 		if (cleancache_get_page(page) == 0) {
@@ -3737,7 +3772,11 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 		flush_dcache_page(page);
 	}
 
-	set_page_extent_mapped(page);
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		SetPageError(page);
+		goto done;
+	}
 
 	if (!epd->extent_locked) {
 		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b4d0e39ebceb..01ec178a1ab9 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -181,7 +181,8 @@ int btree_write_cache_pages(struct address_space *mapping,
 void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len);
-void set_page_extent_mapped(struct page *page);
+int __must_check set_page_extent_mapped(struct page *page);
+void clear_page_extent_mapped(struct page *page);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 69147091f219..41188b751808 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1370,6 +1370,12 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 			goto fail;
 		}
 
+		err = set_page_extent_mapped(pages[i]);
+		if (err < 0) {
+			faili = i;
+			goto fail;
+		}
+
 		if (i == 0)
 			err = prepare_uptodate_page(inode, pages[i], pos,
 						    force_uptodate);
@@ -1467,10 +1473,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	 * We'll call btrfs_dirty_pages() later on, and that will flip around
 	 * delalloc bits and dirty the pages as required.
 	 */
-	for (i = 0; i < num_pages; i++) {
-		set_page_extent_mapped(pages[i]);
+	for (i = 0; i < num_pages; i++)
 		WARN_ON(!PageLocked(pages[i]));
-	}
 
 	return ret;
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 58bd2d3e54db..115e2a7fe74a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -385,11 +385,22 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 	int i;
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
+		int ret;
+
 		page = find_or_create_page(inode->i_mapping, i, mask);
 		if (!page) {
 			io_ctl_drop_pages(io_ctl);
 			return -ENOMEM;
 		}
+
+		ret = set_page_extent_mapped(page);
+		if (ret < 0) {
+			unlock_page(page);
+			put_page(page);
+			io_ctl_drop_pages(io_ctl);
+			return -ENOMEM;
+		}
+
 		io_ctl->pages[i] = page;
 		if (uptodate && !PageUptodate(page)) {
 			btrfs_readpage(NULL, page);
@@ -409,10 +420,8 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 		}
 	}
 
-	for (i = 0; i < io_ctl->num_pages; i++) {
+	for (i = 0; i < io_ctl->num_pages; i++)
 		clear_page_dirty_for_io(io_ctl->pages[i]);
-		set_page_extent_mapped(io_ctl->pages[i]);
-	}
 
 	return 0;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 750aa3770d8f..b9918214cd23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4717,6 +4717,9 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 		ret = -ENOMEM;
 		goto out;
 	}
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto out_unlock;
 
 	if (!PageUptodate(page)) {
 		ret = btrfs_readpage(NULL, page);
@@ -4734,7 +4737,6 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	wait_on_page_writeback(page);
 
 	lock_extent_bits(io_tree, block_start, block_end, &cached_state);
-	set_page_extent_mapped(page);
 
 	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), block_start);
 	if (ordered) {
@@ -8118,7 +8120,7 @@ static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	int ret = try_release_extent_mapping(page, gfp_flags);
 	if (ret == 1)
-		detach_page_private(page);
+		clear_page_extent_mapped(page);
 	return ret;
 }
 
@@ -8277,7 +8279,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	ClearPageChecked(page);
-	detach_page_private(page);
+	clear_page_extent_mapped(page);
 }
 
 /*
@@ -8356,7 +8358,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	wait_on_page_writeback(page);
 
 	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
-	set_page_extent_mapped(page);
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto out_unlock;
 
 	/*
 	 * we can't set the delalloc bits if there are pending ordered
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2904f92c3813..56cc26d0e6db 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1307,6 +1307,10 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		if (!page)
 			break;
 
+		ret = set_page_extent_mapped(page);
+		if (ret < 0)
+			break;
+
 		page_start = page_offset(page);
 		page_end = page_start + PAGE_SIZE - 1;
 		while (1) {
@@ -1428,7 +1432,6 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	for (i = 0; i < i_done; i++) {
 		clear_page_dirty_for_io(pages[i]);
 		ClearPageChecked(pages[i]);
-		set_page_extent_mapped(pages[i]);
 		set_page_dirty(pages[i]);
 		unlock_page(pages[i]);
 		put_page(pages[i]);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 4bbc5f52b752..6f20536494e8 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -81,7 +81,10 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 		goto out_unlock;
 	}
 
-	set_page_extent_mapped(page);
+	ret = set_page_extent_mapped(page);
+	if (ret < 0)
+		goto out_unlock;
+
 	clear_extent_bit(&inode->io_tree, file_offset, range_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, NULL);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c5774a8e6ff7..c353b85f7027 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2699,6 +2699,16 @@ static int relocate_file_extent_cluster(struct inode *inode,
 				goto out;
 			}
 		}
+		ret = set_page_extent_mapped(page);
+		if (ret < 0) {
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+						PAGE_SIZE, true);
+			btrfs_delalloc_release_extents(BTRFS_I(inode),
+						PAGE_SIZE);
+			unlock_page(page);
+			put_page(page);
+			goto out;
+		}
 
 		if (PageReadahead(page)) {
 			page_cache_async_readahead(inode->i_mapping,
@@ -2726,8 +2736,6 @@ static int relocate_file_extent_cluster(struct inode *inode,
 
 		lock_extent(&BTRFS_I(inode)->io_tree, page_start, page_end);
 
-		set_page_extent_mapped(page);
-
 		if (nr < cluster->nr &&
 		    page_start + offset == cluster->boundary[nr]) {
 			set_extent_bits(&BTRFS_I(inode)->io_tree,
-- 
2.29.2

