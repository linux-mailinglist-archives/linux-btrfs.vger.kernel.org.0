Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAD269DE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIOFgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIOFgR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:36:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A6FDAD52
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/19] btrfs: use extent_io_tree to handle subpage extent buffer allocation
Date:   Tue, 15 Sep 2020 13:35:29 +0800
Message-Id: <20200915053532.63279-17-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs uses page::private as an indicator of who owns the
extent buffer, this method won't really work on subpage support, as one
page can contain several tree blocks (up to 16 for 4K node size and 64K
page size).

Instead, here we utilize btree extent io tree to handle them.
Now EXTENT_NEW means we have an extent buffer for the range.

This will affects the following functions:
- alloc_extent_buffer()
  Now for subpage we never use page->private to grab an existing eb.
  Instead, we rely on extra safenet in alloc_extent_buffer() to detect two
  callers on the same eb.

- btrfs_release_extent_buffer_pages()
  Now for subpage, we clear the EXTENT_NEW bit first, then check if the
  remaining range in the page has EXTENT_NEW bit.
  If not, then clear the private bit for the page.

- attach_extent_buffer_page()
  Now we set EXTENT_NEW bit for the new extent buffer to be attached,
  and set the page private, with NULL as page::private.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 12 +++++++
 fs/btrfs/disk-io.c     |  7 ++++
 fs/btrfs/extent_io.c   | 79 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index c47b6c6fea9f..cff818e0c406 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -217,6 +217,18 @@ static inline struct btrfs_inode *BTRFS_I(const struct inode *inode)
 	return container_of(inode, struct btrfs_inode, vfs_inode);
 }
 
+static inline struct btrfs_fs_info *page_to_fs_info(struct page *page)
+{
+	ASSERT(page->mapping);
+	return BTRFS_I(page->mapping->host)->root->fs_info;
+}
+
+static inline struct extent_io_tree
+*info_to_btree_io_tree(struct btrfs_fs_info *fs_info)
+{
+	return &BTRFS_I(fs_info->btree_inode)->io_tree;
+}
+
 static inline unsigned long btrfs_inode_hash(u64 objectid,
 					     const struct btrfs_root *root)
 {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b526adf20f3e..2ef35eb7a6e1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2120,6 +2120,13 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	inode->i_mapping->a_ops = &btree_aops;
 
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
+	/*
+	 * This extent io tree is subpage metadata specific.
+	 *
+	 * It uses the following bits to represent new meaning:
+	 * - EXTENT_NEW:	Has extent buffer allocated
+	 * - EXTENT_UPTODATE	Has latest metadata read from disk
+	 */
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
 			    IO_TREE_BTREE_IO, inode);
 	BTRFS_I(inode)->io_tree.track_uptodate = false;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 16fe9f4313a1..2af6786e6ab4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3116,6 +3116,20 @@ static void attach_extent_buffer_page(struct extent_buffer *eb,
 	if (page->mapping)
 		assert_spin_locked(&page->mapping->private_lock);
 
+	if (eb->fs_info->sectorsize < PAGE_SIZE && page->mapping) {
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+
+		if (!PagePrivate(page))
+			attach_page_private(page, NULL);
+
+		/* EXTENT_NEW represents we have an extent buffer */
+		set_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+				EXTENT_NEW, NULL, NULL, GFP_ATOMIC);
+		eb->pages[0] = page;
+		return;
+	}
+
 	if (!PagePrivate(page))
 		attach_page_private(page, eb);
 	else
@@ -4943,6 +4957,37 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
+static void detach_extent_buffer_subpage(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	struct page *page = eb->pages[0];
+	bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+	int ret;
+
+	if (!page)
+		return;
+
+	if (mapped)
+		spin_lock(&page->mapping->private_lock);
+
+	/*
+	 * Clear the EXTENT_NEW bit from io tree, to indicate that there is
+	 * no longer an extent buffer in the range.
+	 */
+	__clear_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			   EXTENT_NEW, 0, 0, NULL, GFP_ATOMIC, NULL);
+
+	/* Test if we still have other extent buffer in the page range */
+	ret = test_range_bit(io_tree, round_down(eb->start, PAGE_SIZE),
+			     round_down(eb->start, PAGE_SIZE) + PAGE_SIZE - 1,
+			     EXTENT_NEW, 0, NULL);
+	if (!ret)
+		detach_page_private(eb->pages[0]);
+	if (mapped)
+		spin_unlock(&page->mapping->private_lock);
+}
+
 /*
  * Release all pages attached to the extent buffer.
  */
@@ -4954,6 +4999,9 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 
 	BUG_ON(extent_buffer_under_io(eb));
 
+	if (eb->fs_info->sectorsize < PAGE_SIZE)
+		return detach_extent_buffer_subpage(eb);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = eb->pages[i];
@@ -5248,6 +5296,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *exists = NULL;
 	struct page *p;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	bool subpage = (fs_info->sectorsize < PAGE_SIZE);
 	int uptodate = 1;
 	int ret;
 
@@ -5280,7 +5329,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		if (PagePrivate(p)) {
+		if (PagePrivate(p) && !subpage) {
 			/*
 			 * We could have already allocated an eb for this page
 			 * and attached one so lets see if we can get a ref on
@@ -5321,8 +5370,21 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * we could crash.
 		 */
 	}
-	if (uptodate)
+	if (uptodate && !subpage)
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	/*
+	 * For subpage, we must check extent_io_tree to get if the eb is really
+	 * UPTODATE, as the page bit is no longer reliable as we can do subpage
+	 * read.
+	 */
+	if (subpage) {
+		struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+
+		ret = test_range_bit(io_tree, eb->start, eb->start + eb->len - 1,
+				     EXTENT_UPTODATE, 1, NULL);
+		if (ret)
+			set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	}
 again:
 	ret = radix_tree_preload(GFP_NOFS);
 	if (ret) {
@@ -5361,6 +5423,19 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		if (eb->pages[i])
 			unlock_page(eb->pages[i]);
 	}
+	/*
+	 * For subpage case, btrfs_release_extent_buffer() will clear the
+	 * EXTENT_NEW bit if there is a page, and EXTENT_NEW bit represents
+	 * we have an extent buffer in that range.
+	 *
+	 * Since we're here because we hit a race with another caller, who
+	 * succeeded in inserting the eb, we shouldn't clear that EXTENT_NEW
+	 * bit. So here we cleanup the page manually.
+	 */
+	if (subpage) {
+		put_page(eb->pages[0]);
+		eb->pages[i] = NULL;
+	}
 
 	btrfs_release_extent_buffer(eb);
 	return exists;
-- 
2.28.0

