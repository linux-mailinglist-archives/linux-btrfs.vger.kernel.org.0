Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433D029484B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440832AbgJUG1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLH/ETAZLXoXbqKFrQv8hJtA0ThpJ2qJcyW+qv6f3Zk=;
        b=sp1w9n8lgXoU5DY6PtSr9XIvUSPK9SBtQR7yxGh0vq6CE5vl+rnrTyRv9zMCME4JduBpGM
        tf9z4zZNv5JbyGs1DbsNmFYA/jWxle4XFqZrcMdgArCbgvmlSzu0xKGq+VZgVb/2wdCan9
        A3w22KjtWCz/74FCQ+9gS/qWbuDeHqA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DFA3AC8C
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 47/68] btrfs: extent_io: add subpage support for clear_extent_buffer_dirty()
Date:   Wed, 21 Oct 2020 14:25:33 +0800
Message-Id: <20201021062554.68132-48-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index 2cb9abdb0d60..76123d0f416a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5762,30 +5762,53 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
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

