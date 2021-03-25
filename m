Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E13489F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCYHPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhCYHPW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBQc8zKiKqGsjulBg8bz5lJtIvIIqShtvogk6D9Zdtg=;
        b=rQJCZQi/ZrM+2NzEzSj00z1JxZlx8uHF0TO1Cb11BWaNyWOvezABzylyBSycPBTKz23B9E
        qZfhXTy1RQH3sNvqHE2Hu4d8LHOGGiml/MtxrNYveTyHhXm2q8QndlPNSqlMWf8BRRbeRn
        ODALmbU1BIidsk4rz9MHIFkTKlkDcrs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AFF2AD4A
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/13] btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
Date:   Thu, 25 Mar 2021 15:14:43 +0800
Message-Id: <20210325071445.90896-12-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For set_extent_buffer_dirty() to support subpage sized metadata, just
call btrfs_page_set_dirty() to handle both cases.

For clear_extent_buffer_dirty(), it needs to clear the page dirty if and
only if all extent buffers in the page range are no longer dirty.
Also do the same for page error.

This is pretty different from the exist clear_extent_buffer_dirty()
routine, so add a new helper function,
clear_subpage_extent_buffer_dirty() to do this for subpage metadata.

Also since the main part of clearing page dirty code is still the same,
extract that into btree_clear_page_dirty() so that it can be utilized
for both cases.

But there is a special race between set_extent_buffer_dirty() and
clear_extent_buffer_dirty(), where we can clear the page dirty.

[POSSIBLE RACE WINDOW]
For the race window between clear_subpage_extent_buffer_dirty() and
set_extent_buffer_dirty(), due to the fact that we can't call
clear_page_dirty_for_io() under subpage spin lock, we can race like
below:

   T1 (eb1 in the same page)	|  T2 (eb2 in the same page)
 -------------------------------+------------------------------
 set_extent_buffer_dirty()	| clear_extent_buffer_dirty()
 |- was_dirty = false;		| |- clear_subpagE_extent_buffer_dirty()
 |				|    |- btrfs_clear_and_test_dirty()
 |				|    |  Since eb2 is the last dirty page
 |				|    |  we got:
 |				|    |  last == true;
 |				|    |
 |- btrfs_page_set_dirty()	|    |
 |  We set the page dirty and   |    |
 |  subpage dirty bitmap	|    |
 |				|    |- if (last)
 |				|    |  Since we don't have subpage lock
 |				|    |  hold, now @last is no longer
 |				|    |  correct
 |				|    |- btree_clear_page_dirty()
 |				|	Now PageDirty == false, even we
 |				|       have dirty_bitmap not zero.
 |- ASSERT(PageDirty());	|
    ^^^^ CRASH

The solution here is to also lock the eb->pages[0] for subpage case of
set_extent_buffer_dirty(), to prevent racing with
clear_extent_buffer_dirty().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 65 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 24e1cd00e15e..6844d951f2c1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5814,28 +5814,51 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	release_extent_buffer(eb);
 }
 
+static void btree_clear_page_dirty(struct page *page)
+{
+	ASSERT(PageDirty(page));
+	ASSERT(PageLocked(page));
+	clear_page_dirty_for_io(page);
+	xa_lock_irq(&page->mapping->i_pages);
+	if (!PageDirty(page))
+		__xa_clear_mark(&page->mapping->i_pages,
+				page_index(page), PAGECACHE_TAG_DIRTY);
+	xa_unlock_irq(&page->mapping->i_pages);
+}
+
+static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct page *page = eb->pages[0];
+	bool last;
+
+	/* btree_clear_page_dirty() needs page locked */
+	lock_page(page);
+	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, eb->start,
+						  eb->len);
+	if (last)
+		btree_clear_page_dirty(page);
+	unlock_page(page);
+	WARN_ON(atomic_read(&eb->refs) == 0);
+}
+
 void clear_extent_buffer_dirty(const struct extent_buffer *eb)
 {
 	int i;
 	int num_pages;
 	struct page *page;
 
+	if (eb->fs_info->sectorsize < PAGE_SIZE)
+		return clear_subpage_extent_buffer_dirty(eb);
+
 	num_pages = num_extent_pages(eb);
 
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 		if (!PageDirty(page))
 			continue;
-
 		lock_page(page);
-		WARN_ON(!PagePrivate(page));
-
-		clear_page_dirty_for_io(page);
-		xa_lock_irq(&page->mapping->i_pages);
-		if (!PageDirty(page))
-			__xa_clear_mark(&page->mapping->i_pages,
-					page_index(page), PAGECACHE_TAG_DIRTY);
-		xa_unlock_irq(&page->mapping->i_pages);
+		btree_clear_page_dirty(page);
 		ClearPageError(page);
 		unlock_page(page);
 	}
@@ -5856,10 +5879,28 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 	WARN_ON(atomic_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 
-	if (!was_dirty)
-		for (i = 0; i < num_pages; i++)
-			set_page_dirty(eb->pages[i]);
+	if (!was_dirty) {
+		bool subpage = eb->fs_info->sectorsize < PAGE_SIZE;
 
+		/*
+		 * For subpage case, we can have other extent buffers in the
+		 * same page, and in clear_subpage_extent_buffer_dirty() we
+		 * have to clear page dirty without subapge lock hold.
+		 * This can cause race where our page gets dirty cleared after
+		 * we just set it.
+		 *
+		 * Thankfully, clear_subpage_extent_buffer_dirty() has locked
+		 * its page for other reasons, we can use page lock to
+		 * prevent above race.
+		 */
+		if (subpage)
+			lock_page(eb->pages[0]);
+		for (i = 0; i < num_pages; i++)
+			btrfs_page_set_dirty(eb->fs_info, eb->pages[i],
+					     eb->start, eb->len);
+		if (subpage)
+			unlock_page(eb->pages[0]);
+	}
 #ifdef CONFIG_BTRFS_DEBUG
 	for (i = 0; i < num_pages; i++)
 		ASSERT(PageDirty(eb->pages[i]));
-- 
2.30.1

