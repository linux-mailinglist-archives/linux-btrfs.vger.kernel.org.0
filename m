Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2083A2F8BFD
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbhAPHRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:17:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbhAPHRN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:17:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkGUkfEed0KdSnnXqwvejbqJynWDHfb7s5OM6xbT2GE=;
        b=EhxA8sBR8RiTF0gqe3z2e0/wFLwv7jTY8IrLgqt4g5kFd7+c8TMVM/OWhQequU+keDVNCi
        lDXyr+NXMsaxHjG9gL1VqYmN539pzroQt46Nv4s/zbzCNtknB+aY4gBzzLeTHfHq4w+ppL
        2P1JVb8Reaxmgyr3KZ4kn2Batb2i0WY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE986B7F8
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:15:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 06/18] btrfs: support subpage for extent buffer page release
Date:   Sat, 16 Jan 2021 15:15:21 +0800
Message-Id: <20210116071533.105780-7-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_release_extent_buffer_pages(), we need to add extra handling
for subpage.

To do so, introduce a new helper, detach_extent_buffer_page(), to do
different handling for regular and subpage cases.

For subpage case, the new trick is about when to detach the page
private.

For unammped (dummy or cloned) ebs, we can detach the page private
immediately as the page can only be attached to one unmapped eb.

For mapped ebs, we have to ensure there are no eb in the page range
before we delete it, as page->private is shared between all ebs in the
same page.

But there is a subpage specific race, where we can race with extent
buffer allocation, and clear the page private while new eb is still
being utilized, like this:

  Extent buffer A is the new extent buffer which will be allocated,
  while extent buffer B is the last existing extent buffer of the page.

  		T1 (eb A) 	 |		T2 (eb B)
  -------------------------------+------------------------------
  alloc_extent_buffer()		 | btrfs_release_extent_buffer_pages()
  |- p = find_or_create_page()   | |
  |- attach_extent_buffer_page() | |
  |				 | |- detach_extent_buffer_page()
  |				 |    |- if (!page_range_has_eb())
  |				 |    |  No new eb in the page range yet
  |				 |    |  As new eb A hasn't yet been
  |				 |    |  inserted into radix tree.
  |				 |    |- btrfs_detach_subpage()
  |				 |       |- detach_page_private();
  |- radix_tree_insert()	 |

  Then we have a metadata eb whose page has no private bit.

To avoid such race, we introduce a subpage metadata specific member,
btrfs_subpage::under_alloc.

In alloc_extent_buffer() we set that bit with the critical section of
private_lock.
So that page_range_has_eb() will return true for
detach_extent_buffer_page(), and not to detach page private.

New helpers are introduced to do the start/end work:
- btrfs_page_start_meta_alloc()
- btrfs_page_end_meta_alloc()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 123 +++++++++++++++++++++++++++++++++++++------
 fs/btrfs/subpage.h   |  33 ++++++++++++
 2 files changed, 139 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b2f8ac5e9a9e..fb800f237099 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4997,25 +4997,55 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
-/*
- * Release all pages attached to the extent buffer.
- */
-static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+static bool page_range_has_eb(struct btrfs_fs_info *fs_info,
+			      struct page *page)
 {
-	int i;
-	int num_pages;
-	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
+	struct btrfs_subpage *subpage;
+	int ret;
 
-	BUG_ON(extent_buffer_under_io(eb));
+	lockdep_assert_held(&fs_info->buffer_lock);
+	lockdep_assert_held(&page->mapping->private_lock);
+	ASSERT(PAGE_SIZE / fs_info->nodesize <= BTRFS_SUBPAGE_BITMAP_SIZE);
 
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
+	/* We have eb under allocation in the page */
+	if (PagePrivate(page)) {
+		subpage = (struct btrfs_subpage *)page->private;
+		if (subpage->under_alloc)
+			return true;
+	}
+	ret = radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
+			page_offset(page) >> fs_info->sectorsize_bits,
+			PAGE_SIZE / fs_info->nodesize);
+	/*
+	 * Either no eb at all, or the first found eb is already beyond the
+	 * page end, then it means no eb in the page range.
+	 */
+	if (ret == 0 || gang[0]->start >= page_offset(page) + PAGE_SIZE)
+		return false;
+	return true;
+}
 
-		if (!page)
-			continue;
+static void detach_extent_buffer_page(struct extent_buffer *eb,
+				      struct page *page)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+
+	/*
+	 * For mapped eb, we're going to change the page private, which should be
+	 * done under the private_lock.
+	 */
+	if (mapped)
+		spin_lock(&page->mapping->private_lock);
+
+	if (!PagePrivate(page)) {
 		if (mapped)
-			spin_lock(&page->mapping->private_lock);
+			spin_unlock(&page->mapping->private_lock);
+		return;
+	}
+
+	if (fs_info->sectorsize == PAGE_SIZE) {
 		/*
 		 * We do this since we'll remove the pages after we've
 		 * removed the eb from the radix tree, so we could race
@@ -5034,9 +5064,54 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 */
 			detach_page_private(page);
 		}
-
 		if (mapped)
 			spin_unlock(&page->mapping->private_lock);
+		return;
+	}
+
+	/*
+	 * For subpage, we can have dummy eb with page private.
+	 * In this case, we can directly detach the private as such page is
+	 * only attached to one dummy eb, no sharing.
+	 */
+	if (!mapped) {
+		btrfs_detach_subpage(fs_info, page);
+		return;
+	}
+
+	/*
+	 * We can only detach the page private if there are no other eb in the
+	 * page range.
+	 *
+	 * We want an atomic snapshot of the radix tree, thus we go spinlock
+	 * other than RCU here.
+	 */
+	spin_lock(&fs_info->buffer_lock);
+	if (!page_range_has_eb(fs_info, page))
+		btrfs_detach_subpage(fs_info, page);
+	spin_unlock(&fs_info->buffer_lock);
+
+	spin_unlock(&page->mapping->private_lock);
+}
+
+/*
+ * Release all pages attached to the extent buffer.
+ */
+static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+{
+	int i;
+	int num_pages;
+
+	ASSERT(!extent_buffer_under_io(eb));
+
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		struct page *page = eb->pages[i];
+
+		if (!page)
+			continue;
+
+		detach_extent_buffer_page(eb, page);
 
 		/* One for when we allocated the page */
 		put_page(page);
@@ -5387,6 +5462,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_page(eb, p, prealloc);
 		ASSERT(!ret);
+		/*
+		 * To inform we have extra eb under allocation, so that
+		 * detach_extent_buffer_page() won't release the page private
+		 * when the eb hasn't yet been inserted into radix tree.
+		 */
+		btrfs_page_start_meta_alloc(fs_info, p);
 		spin_unlock(&mapping->private_lock);
 
 		WARN_ON(PageDirty(p));
@@ -5432,15 +5513,23 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_releasepage will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (i = 0; i < num_pages; i++)
+	for (i = 0; i < num_pages; i++) {
+		/*
+		 * The eb is in radix tree now, no longer needs the extra
+		 * indicator.
+		 */
+		btrfs_page_end_meta_alloc(fs_info, eb->pages[i]);
 		unlock_page(eb->pages[i]);
+	}
 	return eb;
 
 free_eb:
 	WARN_ON(!atomic_dec_and_test(&eb->refs));
 	for (i = 0; i < num_pages; i++) {
-		if (eb->pages[i])
+		if (eb->pages[i]) {
+			btrfs_page_end_meta_alloc(fs_info, eb->pages[i]);
 			unlock_page(eb->pages[i]);
+		}
 	}
 
 	btrfs_release_extent_buffer(eb);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index f701256dd1e2..d8b34879368d 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -25,6 +25,7 @@ struct btrfs_subpage {
 	spinlock_t lock;
 	union {
 		/* Structures only used by metadata */
+		bool under_alloc;
 		/* Structures only used by data */
 	};
 };
@@ -42,6 +43,38 @@ static inline int btrfs_alloc_subpage(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * To inform that the page is under metadata allocation, so that
+ * page private shouldn't be freed.
+ */
+static inline void btrfs_page_start_meta_alloc(struct btrfs_fs_info *fs_info,
+					       struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->mapping);
+
+	subpage = (struct btrfs_subpage *)page->private;
+	subpage->under_alloc = true;
+}
+
+static inline void btrfs_page_end_meta_alloc(struct btrfs_fs_info *fs_info,
+					     struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->mapping);
+
+	subpage = (struct btrfs_subpage *)page->private;
+	subpage->under_alloc = false;
+}
+
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 
-- 
2.30.0

