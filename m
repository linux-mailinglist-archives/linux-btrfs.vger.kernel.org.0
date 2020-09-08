Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A70260C7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgIHHxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgIHHxT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4A2DAE67
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:53:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/17] btrfs: introduce subpage_eb_mapping for extent buffers
Date:   Tue,  8 Sep 2020 15:52:28 +0800
Message-Id: <20200908075230.86856-16-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the design blockage for subpage support is the btree inode
page::private mapping.

Currently page::private for btree inode is a pointer to extent buffer
who owns this page.
This is fine for sectorsize == PAGE_SIZE case, but not suitable for
subpage size support, as in that case one page can hold multiple tree
blocks.

So to support subpage, here we introduce a new structure,
subpage_eb_mapping, to record how many extent buffers are referring to
one page.

It uses a bitmap (at most 16 bits used) to record tree blocks, and a
extent buffer pointers array (at most 16 too) to record the owners.

This patch will modify the following functions to add subpage support
using subpage_eb_mapping structure:
- attach_extent_buffer_page()
- detach_extent_buffer_page()
- grab_extent_buffer_from_page()
- try_release_extent_buffer()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 221 ++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/extent_io.h |   3 +
 2 files changed, 212 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a83b63ecc5f8..87b3bb781532 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -29,6 +29,34 @@ static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
 static struct bio_set btrfs_bioset;
 
+/* Upper limit of how many extent buffers can be stored in one page */
+#define SUBPAGE_NR_EXTENT_BUFFERS (SZ_64K / SZ_4K)
+/*
+ * Structure for subpage support, recording the page -> extent buffer mapping
+ *
+ * For subpage support, one 64K page can contain several tree blocks, other than
+ * 1:1 page <-> extent buffer mapping from sectorsize == PAGE_SIZE case.
+ */
+struct subpage_eb_mapping {
+	/*
+	 * Which range has extent buffer.
+	 *
+	 * One bit represents one sector, bit nr represents the offset in page.
+	 * At most 16 bits are utilized.
+	 */
+	unsigned long bitmap;
+
+	/* We only support 64K PAGE_SIZE system to mount 4K sectorsize fs */
+	struct extent_buffer *buffers[SUBPAGE_NR_EXTENT_BUFFERS];
+};
+
+struct btrfs_fs_info *page_to_fs_info(struct page *page)
+{
+	ASSERT(page && page->mapping);
+
+	return BTRFS_I(page->mapping->host)->root->fs_info;
+}
+
 static inline bool extent_state_in_tree(const struct extent_state *state)
 {
 	return !RB_EMPTY_NODE(&state->rb_node);
@@ -3098,12 +3126,50 @@ static int submit_extent_page(unsigned int opf,
 	return ret;
 }
 
+static void attach_subpage_mapping(struct extent_buffer *eb,
+				   struct page *page,
+				   struct subpage_eb_mapping *mapping)
+{
+	u32 sectorsize = eb->fs_info->sectorsize;
+	u32 nodesize = eb->fs_info->nodesize;
+	int index_start = (eb->start - page_offset(page)) / sectorsize;
+	int nr_bits = nodesize / sectorsize;
+	int i;
+
+	ASSERT(mapping);
+	if (!PagePrivate(page)) {
+		/* Attach mapping to page::private and initialize */
+		memset(mapping, 0, sizeof(*mapping));
+		attach_page_private(page, mapping);
+	} else {
+		/* Use the existing page::private as mapping */
+		kfree(mapping);
+		mapping = (struct subpage_eb_mapping *) page->private;
+	}
+
+	/* Set the bitmap and pointers */
+	for (i = index_start; i < index_start + nr_bits; i++) {
+		set_bit(i, &mapping->bitmap);
+		mapping->buffers[i] = eb;
+	}
+}
+
 static void attach_extent_buffer_page(struct extent_buffer *eb,
-				      struct page *page)
+				      struct page *page,
+				      struct subpage_eb_mapping *mapping)
 {
+	bool subpage = (eb->fs_info->sectorsize < PAGE_SIZE);
 	if (page->mapping)
 		assert_spin_locked(&page->mapping->private_lock);
 
+	if (subpage && page->mapping) {
+		attach_subpage_mapping(eb, page, mapping);
+		return;
+	}
+	/*
+	 * Anonymous page and sectorsize == PAGE_SIZE uses page::private as a
+	 * pointer to eb directly.
+	 */
 	if (!PagePrivate(page))
 		attach_page_private(page, eb);
 	else
@@ -4928,16 +4994,61 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
+static void detach_subpage_mapping(struct extent_buffer *eb, struct page *page)
+{
+	struct subpage_eb_mapping *mapping;
+	u32 sectorsize = eb->fs_info->sectorsize;
+	int start_index;
+	int nr_bits = eb->fs_info->nodesize / sectorsize;
+	int i;
+
+	/* Page already detached */
+	if (!PagePrivate(page))
+		return;
+
+	assert_spin_locked(&page->mapping->private_lock);
+	ASSERT(eb->start >= page_offset(page) &&
+	       eb->start < page_offset(page) + PAGE_SIZE);
+
+	mapping = (struct subpage_eb_mapping *)page->private;
+	start_index = (eb->start - page_offset(page)) / sectorsize;
+
+	for (i = start_index; i < start_index + nr_bits; i++) {
+		if (test_bit(i, &mapping->bitmap) &&
+		    mapping->buffers[i] == eb) {
+			clear_bit(i, &mapping->bitmap);
+			mapping->buffers[i] = NULL;
+		}
+	}
+
+	/* Are we the last owner ? */
+	if (mapping->bitmap == 0) {
+		kfree(mapping);
+		detach_page_private(page);
+		/* One for the first time allocated the page */
+		put_page(page);
+	}
+}
+
 static void detach_extent_buffer_page(struct extent_buffer *eb,
 				      struct page *page)
 {
 	bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+	bool subpage = (eb->fs_info->sectorsize < PAGE_SIZE);
 
 	if (!page)
 		return;
 
 	if (mapped)
 		spin_lock(&page->mapping->private_lock);
+
+	if (subpage && page->mapping) {
+		detach_subpage_mapping(eb, page);
+		if (mapped)
+			spin_unlock(&page->mapping->private_lock);
+		return;
+	}
+
 	if (PagePrivate(page) && page->private == (unsigned long)eb) {
 		BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 		BUG_ON(PageDirty(page));
@@ -5035,7 +5146,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 			btrfs_release_extent_buffer(new);
 			return NULL;
 		}
-		attach_extent_buffer_page(new, p);
+		attach_extent_buffer_page(new, p, NULL);
 		WARN_ON(PageDirty(p));
 		SetPageUptodate(p);
 		new->pages[i] = p;
@@ -5243,8 +5354,31 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
  * The function here is to ensure we have proper locking and detect such race
  * so we won't allocating an eb twice.
  */
-static struct extent_buffer *grab_extent_buffer_from_page(struct page *page)
+static struct extent_buffer *grab_extent_buffer_from_page(struct page *page,
+							  u64 bytenr)
 {
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+	bool subpage = (fs_info->sectorsize < PAGE_SIZE);
+
+	if (!PagePrivate(page))
+		return NULL;
+
+	if (subpage) {
+		struct subpage_eb_mapping *mapping;
+		u32 sectorsize = fs_info->sectorsize;
+		int start_index;
+
+		ASSERT(bytenr >= page_offset(page) &&
+		       bytenr < page_offset(page) + PAGE_SIZE);
+
+		start_index = (bytenr - page_offset(page)) / sectorsize;
+		mapping = (struct subpage_eb_mapping *)page->private;
+
+		if (test_bit(start_index, &mapping->bitmap))
+			return mapping->buffers[start_index];
+		return NULL;
+	}
+
 	/*
 	 * For PAGE_SIZE == sectorsize case, a btree_inode page should have its
 	 * private pointer as extent buffer who owns this page.
@@ -5263,6 +5397,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *exists = NULL;
 	struct page *p;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	struct subpage_eb_mapping *subpage_mapping = NULL;
+	bool subpage = (fs_info->sectorsize < PAGE_SIZE);
 	int uptodate = 1;
 	int ret;
 
@@ -5286,6 +5422,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
 
+	if (subpage) {
+		subpage_mapping = kmalloc(sizeof(*subpage_mapping), GFP_NOFS);
+		if (!mapping) {
+			exists = ERR_PTR(-ENOMEM);
+			goto free_eb;
+		}
+	}
+
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++, index++) {
 		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
@@ -5296,7 +5440,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 		spin_lock(&mapping->private_lock);
 		if (PagePrivate(p)) {
-			exists = grab_extent_buffer_from_page(p);
+			exists = grab_extent_buffer_from_page(p, start);
 			if (exists && atomic_inc_not_zero(&exists->refs)) {
 				spin_unlock(&mapping->private_lock);
 				unlock_page(p);
@@ -5306,16 +5450,19 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			}
 			exists = NULL;
 
-			/*
-			 * Do this so attach doesn't complain and we need to
-			 * drop the ref the old guy had.
-			 */
-			ClearPagePrivate(p);
-			WARN_ON(PageDirty(p));
-			put_page(p);
+			if (!subpage) {
+				/*
+				 * Do this so attach doesn't complain and we
+				 * need to drop the ref the old guy had.
+				 */
+				ClearPagePrivate(p);
+				WARN_ON(PageDirty(p));
+				put_page(p);
+			}
 		}
-		attach_extent_buffer_page(eb, p);
+		attach_extent_buffer_page(eb, p, subpage_mapping);
 		spin_unlock(&mapping->private_lock);
+		subpage_mapping = NULL;
 		WARN_ON(PageDirty(p));
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
@@ -5365,6 +5512,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 free_eb:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
+	kfree(subpage_mapping);
 	for (i = 0; i < num_pages; i++) {
 		if (eb->pages[i])
 			unlock_page(eb->pages[i]);
@@ -6158,8 +6306,49 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	}
 }
 
+int try_release_subpage_ebs(struct page *page)
+{
+	struct subpage_eb_mapping *mapping;
+	int i;
+
+	assert_spin_locked(&page->mapping->private_lock);
+	if (!PagePrivate(page))
+		return 1;
+
+	mapping = (struct subpage_eb_mapping *)page->private;
+	for (i = 0; i < SUBPAGE_NR_EXTENT_BUFFERS && PagePrivate(page); i++) {
+		struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+		struct extent_buffer *eb;
+		int ret;
+
+		if (!test_bit(i, &mapping->bitmap))
+			continue;
+
+		eb = mapping->buffers[i];
+		spin_unlock(&page->mapping->private_lock);
+		spin_lock(&eb->refs_lock);
+		ret = release_extent_buffer(eb);
+		spin_lock(&page->mapping->private_lock);
+
+		/*
+		 * Extent buffer can't be freed yet, must jump to next slot
+		 * and avoid calling release_extent_buffer().
+		 */
+		if (!ret)
+			i += (fs_info->nodesize / fs_info->sectorsize - 1);
+	}
+	/*
+	 * detach_subpage_mapping() from release_extent_buffer() has detached
+	 * all ebs from this page. All related ebs are released.
+	 */
+	if (!PagePrivate(page))
+		return 1;
+	return 0;
+}
+
 int try_release_extent_buffer(struct page *page)
 {
+	bool subpage = (page_to_fs_info(page)->sectorsize < PAGE_SIZE);
 	struct extent_buffer *eb;
 
 	/*
@@ -6172,6 +6361,14 @@ int try_release_extent_buffer(struct page *page)
 		return 1;
 	}
 
+	if (subpage) {
+		int ret;
+
+		ret = try_release_subpage_ebs(page);
+		spin_unlock(&page->mapping->private_lock);
+		return ret;
+	}
+
 	eb = (struct extent_buffer *)page->private;
 	BUG_ON(!eb);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e16c5449ba48..6593b6883438 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -184,6 +184,9 @@ static inline int extent_compress_type(unsigned long bio_flags)
 	return bio_flags >> EXTENT_BIO_FLAG_SHIFT;
 }
 
+/* Unable to inline it due to the requirement for both ASSERT() and BTRFS_I() */
+struct btrfs_fs_info *page_to_fs_info(struct page *page);
+
 struct extent_map_tree;
 
 typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
-- 
2.28.0

