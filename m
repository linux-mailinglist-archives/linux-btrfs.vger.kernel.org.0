Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB87304653
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbhAZRYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:24:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:54952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbhAZIgN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:36:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13aFCCcUtHPUu+iy8fSvDhPEur7dZXoO4NdVC76/ofo=;
        b=ieS3vLsjazuY81EoP0BkoPVbsD03jXdbu9+vimusXizHrh8LTUETFMaJZrxj+yvchKcRUN
        /7Mo8gC/wG0DSkvfhpqF3BIXmXeUhWSgzK8yEHaxZnv3KQeFvz/4MCQQWKnW/41yQWuHwy
        C9fLQDZk6+BUjcVWAP+1QlSviZWL2Tk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9BB5AF3D;
        Tue, 26 Jan 2021 08:34:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 06/18] btrfs: support subpage for extent buffer page release
Date:   Tue, 26 Jan 2021 16:33:50 +0800
Message-Id: <20210126083402.142577-7-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_release_extent_buffer_pages(), we need to add extra handling
for subpage.

Introduce a helper, detach_extent_buffer_page(), to do different
handling for regular and subpage cases.

For subpage case, handle detaching page private.

For unmapped (dummy or cloned) ebs, we can detach the page private
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

To avoid such race, we introduce a subpage metadata-specific member,
btrfs_subpage::eb_refs.

In alloc_extent_buffer() we increase eb_refs in the critical section of
private_lock.  Then page_range_has_eb() will return true for
detach_extent_buffer_page(), and will not detach page private.

The section is marked by:

- btrfs_page_inc_eb_refs()
- btrfs_page_dec_eb_refs()

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 94 +++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/subpage.c   | 42 ++++++++++++++++++++
 fs/btrfs/subpage.h   | 13 +++++-
 3 files changed, 133 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 16a29f63cfd1..118874926179 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4993,25 +4993,39 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
-/*
- * Release all pages attached to the extent buffer.
- */
-static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
 {
-	int i;
-	int num_pages;
-	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+	struct btrfs_subpage *subpage;
 
-	BUG_ON(extent_buffer_under_io(eb));
+	lockdep_assert_held(&page->mapping->private_lock);
 
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
+	if (PagePrivate(page)) {
+		subpage = (struct btrfs_subpage *)page->private;
+		if (atomic_read(&subpage->eb_refs))
+			return true;
+	}
+	return false;
+}
 
-		if (!page)
-			continue;
+static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+
+	/*
+	 * For mapped eb, we're going to change the page private, which should
+	 * be done under the private_lock.
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
@@ -5030,9 +5044,49 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
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
+	 * For subpage, we can have dummy eb with page private.  In this case,
+	 * we can directly detach the private as such page is only attached to
+	 * one dummy eb, no sharing.
+	 */
+	if (!mapped) {
+		btrfs_detach_subpage(fs_info, page);
+		return;
+	}
+
+	btrfs_page_dec_eb_refs(fs_info, page);
+
+	/*
+	 * We can only detach the page private if there are no other ebs in the
+	 * page range.
+	 */
+	if (!page_range_has_eb(fs_info, page))
+		btrfs_detach_subpage(fs_info, page);
+
+	spin_unlock(&page->mapping->private_lock);
+}
+
+/* Release all pages attached to the extent buffer */
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
@@ -5392,6 +5446,16 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_page(eb, p, prealloc);
 		ASSERT(!ret);
+		/*
+		 * To inform we have extra eb under allocation, so that
+		 * detach_extent_buffer_page() won't release the page private
+		 * when the eb hasn't yet been inserted into radix tree.
+		 *
+		 * The ref will be decreased when the eb released the page, in
+		 * detach_extent_buffer_page().
+		 * Thus needs no special handling in error path.
+		 */
+		btrfs_page_inc_eb_refs(fs_info, p);
 		spin_unlock(&mapping->private_lock);
 
 		WARN_ON(PageDirty(p));
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 61b28dfca20c..a2a21fa0ea35 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -52,6 +52,8 @@ int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	if (!*ret)
 		return -ENOMEM;
 	spin_lock_init(&(*ret)->lock);
+	if (type == BTRFS_SUBPAGE_METADATA)
+		atomic_set(&(*ret)->eb_refs, 0);
 	return 0;
 }
 
@@ -59,3 +61,43 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage)
 {
 	kfree(subpage);
 }
+
+/*
+ * Increase the eb_refs of current subpage.
+ *
+ * This is important for eb allocation, to prevent race with last eb freeing
+ * of the same page.
+ * With the eb_refs increased before the eb inserted into radix tree,
+ * detach_extent_buffer_page() won't detach the page private while we're still
+ * allocating the extent buffer.
+ */
+void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
+			    struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->mapping);
+	lockdep_assert_held(&page->mapping->private_lock);
+
+	subpage = (struct btrfs_subpage *)page->private;
+	atomic_inc(&subpage->eb_refs);
+}
+
+void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
+			    struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->mapping);
+	lockdep_assert_held(&page->mapping->private_lock);
+
+	subpage = (struct btrfs_subpage *)page->private;
+	ASSERT(atomic_read(&subpage->eb_refs));
+	atomic_dec(&subpage->eb_refs);
+}
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 7ba544bcc9c6..eef2ecae77e0 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -4,6 +4,7 @@
 #define BTRFS_SUBPAGE_H
 
 #include <linux/spinlock.h>
+#include <linux/refcount.h>
 
 /*
  * Maximum page size we support is 64K, minimum sector size is 4K, u16 bitmap
@@ -19,7 +20,13 @@ struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
 	union {
-		/* Structures only used by metadata */
+		/*
+		 * Structures only used by metadata
+		 *
+		 * @eb_refs should only be operated under private_lock, as it
+		 * manages whether the subpage can be detached.
+		 */
+		atomic_t eb_refs;
 		/* Structures only used by data */
 	};
 };
@@ -40,4 +47,8 @@ int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 			enum btrfs_subpage_type type);
 void btrfs_free_subpage(struct btrfs_subpage *subpage);
 
+void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
+			    struct page *page);
+void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
+			    struct page *page);
 #endif
-- 
2.30.0

