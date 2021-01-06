Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6D2EB761
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbhAFBDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:45894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbhAFBDn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6NbeVeopv5Vl2Mx1z+vFK4mSAAZMFjUOdTCBgk4Uno=;
        b=i4kieWI7GUH4bzmOG0yO8eYrGc8JSg+e5eEYD7ScSUoVC3ES1h2Fozeq1Gk6+LqDx/Bz93
        +ISEyD9WPMMTl83ouQkCsPjOdHw7lCc852Qk2ePkgvNPF011toJ9Yp2t2cLEJSEjzPQQ/h
        Ofgw/kUZExLPqo3ijEMWMLMdrCRYFcg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCF41AF48
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/22] btrfs: extent_io: support subpage for extent buffer page release
Date:   Wed,  6 Jan 2021 09:01:49 +0800
Message-Id: <20210106010201.37864-11-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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
This part is handled by the subpage helper,
btrfs_subpage_clear_and_test_tree_block().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 57 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/subpage.h   | 24 +++++++++++++++++++
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9b6b8f6b6da3..3158461ebf4c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4991,25 +4991,13 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
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
+	bool last = false;
 
-		if (!page)
-			continue;
-		if (mapped)
-			spin_lock(&page->mapping->private_lock);
+	if (fs_info->sectorsize == PAGE_SIZE) {
 		/*
 		 * We do this since we'll remove the pages after we've
 		 * removed the eb from the radix tree, so we could race
@@ -5028,6 +5016,41 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 */
 			detach_page_private(page);
 		}
+		return;
+	}
+
+	ASSERT(PagePrivate(page));
+	/*
+	 * For subpage case, clear the range in tree_block_bitmap,
+	 * and if we're the last one, detach private completely.
+	 */
+	last = btrfs_subpage_clear_and_test_tree_block(fs_info, page,
+					eb->start, eb->len);
+	if (last)
+		btrfs_detach_subpage(fs_info, page);
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
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index e49d4a7329e1..c1556b3b68f3 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -78,4 +78,28 @@ static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
+/*
+ * Clear the bits in tree_block_bitmap and return if we're the last bit set
+ * int tree_block_bitmap.
+ *
+ * Return true if we're the last bits in the tree_block_bitmap.
+ * Return false otherwise.
+ */
+static inline bool btrfs_subpage_clear_and_test_tree_block(
+			struct btrfs_fs_info *fs_info, struct page *page,
+			u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+	unsigned long flags;
+	bool last = false;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->tree_block_bitmap &= ~tmp;
+	if (subpage->tree_block_bitmap == 0)
+		last = true;
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	return last;
+}
+
 #endif /* BTRFS_SUBPAGE_H */
-- 
2.29.2

