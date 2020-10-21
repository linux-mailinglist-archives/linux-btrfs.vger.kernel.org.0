Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36CF29483E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440799AbgJUG1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440793AbgJUG1P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLGKZpaAbbPVK4VM1PuL7b7jn4nOQwMa4IKYX1IdJfI=;
        b=NeZeXYV4bAPx4fUiWkPFfayxpg6kh6O6BDPpssGl98G3n0ruLMrN03Rijnx+ceQfOu/VWn
        mdT5LjBL76y23HnE3wEGnTl5ig6zRYOCvDMKdzBGDTgwf1VFhMDNdRkRjvYaQB9ISRj83a
        MqI2WEhEjCVIEMyytf5tftAkkoEwYlc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 42952AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 34/68] btrfs: extent_io: use extent_io_tree to handle subpage extent buffer allocation
Date:   Wed, 21 Oct 2020 14:25:20 +0800
Message-Id: <20201021062554.68132-35-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs uses page::private as an indicator of who owns the
extent buffer, this method won't really work on subpage support, as one
page can contain several tree blocks (up to 16 for 4K node size and 64K
page size).

Instead, here we utilize btree extent io tree to handle them.
For btree io tree, we introduce a new bit, EXTENT_HAS_TREE_BLOCK to
indicate that we have an in-tree extent buffer for the range.

This will affects the following functions:
- alloc_extent_buffer()
  Now for subpage we never use page->private to grab an existing eb.
  Instead, we rely on extra safenet in alloc_extent_buffer() to detect two
  callers on the same eb.

- btrfs_release_extent_buffer_pages()
  Now for subpage, we clear the EXTENT_HAS_TREE_BLOCK bit first, then
  check if the remaining range in the page has EXTENT_HAS_TREE_BLOCK bit.
  If not, then clear the private bit for the page.

- attach_extent_buffer_page()
  Now we set EXTENT_HAS_TREE_BLOCK bit for the new extent buffer to be
  attached, and set the page private, with NULL as page::private.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h    | 12 ++++++
 fs/btrfs/extent-io-tree.h |  2 +-
 fs/btrfs/extent_io.c      | 80 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 3 deletions(-)

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
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 176e0e8e1f7c..bdafac1bd15f 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -23,7 +23,7 @@ struct io_failure_record;
 #define EXTENT_CLEAR_DATA_RESV	(1U << 13)
 #define EXTENT_DELALLOC_NEW	(1U << 14)
 
-/* For subpage btree io tree, to indicate there is an extent buffer */
+/* For subpage btree io tree, indicates there is an in-tree extent buffer */
 #define EXTENT_HAS_TREE_BLOCK	(1U << 15)
 
 #define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a7e4d3c65162..d899a75db977 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3163,6 +3163,18 @@ static void attach_extent_buffer_page(struct extent_buffer *eb,
 	if (page->mapping)
 		assert_spin_locked(&page->mapping->private_lock);
 
+	if (btrfs_is_subpage(eb->fs_info) && page->mapping) {
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+
+		if (!PagePrivate(page))
+			attach_page_private(page, NULL);
+
+		set_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+				EXTENT_HAS_TREE_BLOCK, NULL, GFP_ATOMIC);
+		return;
+	}
+
 	if (!PagePrivate(page))
 		attach_page_private(page, eb);
 	else
@@ -4984,6 +4996,36 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
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
+	__clear_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
+			   EXTENT_HAS_TREE_BLOCK, NULL, GFP_ATOMIC, NULL);
+
+	/* Test if we still have other extent buffer in the page range */
+	ret = test_range_bit(io_tree, round_down(eb->start, PAGE_SIZE),
+			     round_down(eb->start, PAGE_SIZE) + PAGE_SIZE - 1,
+			     EXTENT_HAS_TREE_BLOCK, 0, NULL);
+	if (!ret)
+		detach_page_private(eb->pages[0]);
+	if (mapped)
+		spin_unlock(&page->mapping->private_lock);
+
+	/* One for when we allocated the page */
+	put_page(page);
+}
+
 /*
  * Release all pages attached to the extent buffer.
  */
@@ -4995,6 +5037,9 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 
 	BUG_ON(extent_buffer_under_io(eb));
 
+	if (btrfs_is_subpage(eb->fs_info) && mapped)
+		return detach_extent_buffer_subpage(eb);
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = eb->pages[i];
@@ -5289,6 +5334,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *exists = NULL;
 	struct page *p;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	bool subpage = btrfs_is_subpage(fs_info);
 	int uptodate = 1;
 	int ret;
 
@@ -5321,7 +5367,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		spin_lock(&mapping->private_lock);
-		if (PagePrivate(p)) {
+		/*
+		 * Subpage support doesn't use page::private at all, so we
+		 * completely rely on the radix insert lock to prevent two
+		 * ebs allocated for the same bytenr.
+		 */
+		if (PagePrivate(p) && !subpage) {
 			/*
 			 * We could have already allocated an eb for this page
 			 * and attached one so lets see if we can get a ref on
@@ -5362,8 +5413,21 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * we could crash.
 		 */
 	}
-	if (uptodate)
+	if (uptodate) {
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	} else if (subpage) {
+		/*
+		 * For subpage, we must check extent_io_tree to get if the eb
+		 * is really uptodate, as the page uptodate is only set if the
+		 * whole page is uptodate.
+		 * We can still have uptodate range in the page.
+		 */
+		struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+
+		if (test_range_bit(io_tree, eb->start, eb->start + eb->len - 1,
+				   EXTENT_UPTODATE, 1, NULL))
+			set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	}
 again:
 	ret = radix_tree_preload(GFP_NOFS);
 	if (ret) {
@@ -5402,6 +5466,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		if (eb->pages[i])
 			unlock_page(eb->pages[i]);
 	}
+	/*
+	 * For subpage case, btrfs_release_extent_buffer() will clear the
+	 * EXTENT_HAS_TREE_BLOCK bit if there is a page.
+	 *
+	 * Since we're here because we hit a race with another caller, who
+	 * succeeded in inserting the eb, we shouldn't clear that
+	 * EXTENT_HAS_TREE_BLOCK bit. So here we cleanup the page manually.
+	 */
+	if (subpage) {
+		put_page(eb->pages[0]);
+		eb->pages[i] = NULL;
+	}
 
 	btrfs_release_extent_buffer(eb);
 	return exists;
-- 
2.28.0

