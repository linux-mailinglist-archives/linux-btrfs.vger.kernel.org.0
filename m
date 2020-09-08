Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B1260C81
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgIHHxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbgIHHxG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9230BAE25
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:53:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/17] btrfs: refactor btrfs_release_extent_buffer_pages()
Date:   Tue,  8 Sep 2020 15:52:22 +0800
Message-Id: <20200908075230.86856-10-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have attach_extent_buffer_page() and it get utilized in
btrfs_clone_extent_buffer() and alloc_extent_buffer().

But in btrfs_release_extent_buffer_pages() we manually call
detach_page_private().

This is fine for current code, but if we're going to support subpage
size, we will do a lot of more work other than just calling
detach_page_private().

This patch will extract the main work of btrfs_clone_extent_buffer()
into detach_extent_buffer_page() so that later subpage size support can
put their own code into them.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 58 +++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3c8fe40f67fa..1cb41dab7a1d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4920,6 +4920,29 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
+static void detach_extent_buffer_page(struct extent_buffer *eb,
+				      struct page *page)
+{
+	bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+
+	if (!page)
+		return;
+
+	if (mapped)
+		spin_lock(&page->mapping->private_lock);
+	if (PagePrivate(page) && page->private == (unsigned long)eb) {
+		BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+		BUG_ON(PageDirty(page));
+		BUG_ON(PageWriteback(page));
+		/* We need to make sure we haven't be attached to a new eb. */
+		detach_page_private(page);
+	}
+	if (mapped)
+		spin_unlock(&page->mapping->private_lock);
+	/* One for when we allocated the page */
+	put_page(page);
+}
+
 /*
  * Release all pages attached to the extent buffer.
  */
@@ -4927,43 +4950,12 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 {
 	int i;
 	int num_pages;
-	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	BUG_ON(extent_buffer_under_io(eb));
 
 	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
-
-		if (!page)
-			continue;
-		if (mapped)
-			spin_lock(&page->mapping->private_lock);
-		/*
-		 * We do this since we'll remove the pages after we've
-		 * removed the eb from the radix tree, so we could race
-		 * and have this page now attached to the new eb.  So
-		 * only clear page_private if it's still connected to
-		 * this eb.
-		 */
-		if (PagePrivate(page) &&
-		    page->private == (unsigned long)eb) {
-			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-			BUG_ON(PageDirty(page));
-			BUG_ON(PageWriteback(page));
-			/*
-			 * We need to make sure we haven't be attached
-			 * to a new eb.
-			 */
-			detach_page_private(page);
-		}
-
-		if (mapped)
-			spin_unlock(&page->mapping->private_lock);
-
-		/* One for when we allocated the page */
-		put_page(page);
-	}
+	for (i = 0; i < num_pages; i++)
+		detach_extent_buffer_page(eb, eb->pages[i]);
 }
 
 /*
-- 
2.28.0

