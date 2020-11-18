Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3372B7995
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgKRIxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:47750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klisPb1jEVYBo0v/m8llSMZzfCSmkqvGx70w4zEb97M=;
        b=H2j4gxZpAiMOYQbg5RbfLEc9tLKlfcJe7HUbdWmVrnvyHne4Gw/Xw3VnxUlmUeJQVpPqdV
        MwP76BBnb1ve2cmQnCsOV+c7pTg2Mq2xpzWUxk26KrexdgxIsxHg8XRFEMYrLZ+wp4eUEh
        G0s7robMd2Yk0GrTDdRhvZX2WeKH3/0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F14FEAD71
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/14] btrfs: extent_io: support subpage for extent buffer page release
Date:   Wed, 18 Nov 2020 16:53:11 +0800
Message-Id: <20201118085319.56668-7-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_release_extent_buffer_pages(), we need to add extra handling
for subpage.

To do so, introduce a new helper, detach_extent_buffer_page(), to do
different handling for regular and subpage cases.

For subpage case, the new trick is to clear the range of current extent
buffer, and detach page private if and only if we're the last tree block
of the page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 70 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f424a26a695e..090acf0e6a59 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4999,25 +4999,12 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
-/*
- * Release all pages attached to the extent buffer.
- */
-static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+static void detach_extent_buffer_page(struct extent_buffer *eb,
+				      struct page *page)
 {
-	int i;
-	int num_pages;
-	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
-	BUG_ON(extent_buffer_under_io(eb));
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		struct page *page = eb->pages[i];
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 
-		if (!page)
-			continue;
-		if (mapped)
-			spin_lock(&page->mapping->private_lock);
+	if (!btrfs_is_subpage(fs_info)) {
 		/*
 		 * We do this since we'll remove the pages after we've
 		 * removed the eb from the radix tree, so we could race
@@ -5036,6 +5023,55 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 */
 			detach_page_private(page);
 		}
+	}
+
+	/*
+	 * For subpage case, clear the range in tree_block_bitmap,
+	 * and if we're the last one, detach private completely.
+	 */
+	if (PagePrivate(page)) {
+		struct btrfs_subpage *subpage;
+		int start = (eb->start - page_offset(page)) >>
+			    fs_info->sectorsize_bits;
+		int nbits = (eb->len) >> fs_info->sectorsize_bits;
+		bool last = false;
+
+		ASSERT(page_offset(page) <= eb->start &&
+		       eb->start + eb->len <= page_offset(page) + PAGE_SIZE);
+
+		subpage = (struct btrfs_subpage *)page->private;
+		spin_lock_bh(&subpage->lock);
+		bitmap_clear(subpage->tree_block_bitmap, start, nbits);
+		if (bitmap_empty(subpage->tree_block_bitmap,
+				 BTRFS_SUBPAGE_BITMAP_SIZE))
+			last = true;
+		spin_unlock_bh(&subpage->lock);
+		if (last)
+			btrfs_detach_subpage(fs_info, page);
+	}
+}
+
+/*
+ * Release all pages attached to the extent buffer.
+ */
+static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
+{
+	int i;
+	int num_pages;
+	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+
+	ASSERT(!extent_buffer_under_io(eb));
+
+	num_pages = num_extent_pages(eb);
+	for (i = 0; i < num_pages; i++) {
+		struct page *page = eb->pages[i];
+
+		if (!page)
+			continue;
+		if (mapped)
+			spin_lock(&page->mapping->private_lock);
+
+		detach_extent_buffer_page(eb, page);
 
 		if (mapped)
 			spin_unlock(&page->mapping->private_lock);
-- 
2.29.2

