Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974CD27DE24
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgI3B5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgI3B5O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCsQBMcW4SJhU+/UsLUy+uWecoTQnfXw0RIjNfGJC0A=;
        b=QsPJ4M/7bf3oNZXXiNgoNDA9cL3qYs7P6kpM8eyCO1nQv9u0YBow0lwK3IT10quuFLAbu5
        klFX+mkssJapfO/gsqGFKNU/Z1FE+pRlL+bhAJSI2sls6Mzllm+MCVNJeuI2sEXJ9JIvl3
        blwBrvoBVfB5mpNoGifKeaH1uD2m0Co=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 046C2AE07
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 43/49] btrfs: extent_io: add subpage support for clear_extent_buffer_dirty()
Date:   Wed, 30 Sep 2020 09:55:33 +0800
Message-Id: <20200930015539.48867-44-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage metadata, clear_extent_buffer_dirty() needs to clear
the page dirty if and only if all extent buffers in the page range are
no longer dirty.

This is pretty different from the exist clear_extent_buffer_dirty()
routine, so add a new helper function,
clear_subpage_extent_buffer_dirty() to do this for subpage metadata.

Also since the main part of clearing page dirty code is still the same,
extract that into btree_clear_page_dirty() so that it can be utilized
for both cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ae7ab7364115..07dec345f662 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5622,30 +5622,53 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	release_extent_buffer(eb);
 }
 
+static void btree_clear_page_dirty(struct page *page)
+{
+	ASSERT(PageDirty(page));
+
+	lock_page(page);
+	clear_page_dirty_for_io(page);
+	xa_lock_irq(&page->mapping->i_pages);
+	if (!PageDirty(page))
+		__xa_clear_mark(&page->mapping->i_pages,
+				page_index(page), PAGECACHE_TAG_DIRTY);
+	xa_unlock_irq(&page->mapping->i_pages);
+	ClearPageError(page);
+	unlock_page(page);
+}
+
+static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
+	struct page *page = eb->pages[0];
+	u64 page_start = page_offset(page);
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	int ret;
+
+	clear_extent_dirty(io_tree, eb->start, eb->start + eb->len - 1, NULL);
+	ret = test_range_bit(io_tree, page_start, page_end, EXTENT_DIRTY, 0, NULL);
+	/* All extent buffers in the page range is cleared now */
+	if (ret == 0 && PageDirty(page))
+		btree_clear_page_dirty(page);
+	WARN_ON(atomic_read(&eb->refs) == 0);
+}
+
 void clear_extent_buffer_dirty(const struct extent_buffer *eb)
 {
 	int i;
 	int num_pages;
 	struct page *page;
 
+	if (btrfs_is_subpage(eb->fs_info))
+		return clear_subpage_extent_buffer_dirty(eb);
 	num_pages = num_extent_pages(eb);
 
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 		if (!PageDirty(page))
 			continue;
-
-		lock_page(page);
-		WARN_ON(!PagePrivate(page));
-
-		clear_page_dirty_for_io(page);
-		xa_lock_irq(&page->mapping->i_pages);
-		if (!PageDirty(page))
-			__xa_clear_mark(&page->mapping->i_pages,
-					page_index(page), PAGECACHE_TAG_DIRTY);
-		xa_unlock_irq(&page->mapping->i_pages);
-		ClearPageError(page);
-		unlock_page(page);
+		btree_clear_page_dirty(page);
 	}
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
-- 
2.28.0

