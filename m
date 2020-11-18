Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428272B7993
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKRIxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:47650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKRIxh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAYWSbxWl4uls7k5AsHrvLlNpSM0BJ7NbJvg/bcx3Zg=;
        b=C8X4UIyxIq7NpL5Ri8j+WSQyJmqDibI4dqBljjRjYJ4ZwVUfsHMeQCQUCE9SDq0AkFnPEe
        D7FmbC47+mrai4/J4AxDuGZdKsj7lXcNtEnSJJL5ed61BV2vo20z8fBWt5uW9iVX2338e8
        vzq4T9D7W0rbk9l6OssTRCFN9sWbJU4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59F8FAE91
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/14] btrfs: extent_io: make attach_extent_buffer_page() to handle subpage case
Date:   Wed, 18 Nov 2020 16:53:09 +0800
Message-Id: <20201118085319.56668-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, we need to allocate new memory for each metadata page.

So we need to:
- Allow attach_extent_buffer_page() to return int
  To indicate allocation failure

- Prealloc page->private for alloc_extent_buffer()
  We don't want to call memory allocation with spinlock hold, so
  do preallocation before we acquire the spin lock.

- Handle subpage and regular case differently in
  attach_extent_buffer_page()
  For regular case, just do the usual thing.
  For subpage case, allocate new memory and update the tree_block
  bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 77 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2eaf09ff59ca..94101d1e04eb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3142,22 +3142,50 @@ static int submit_extent_page(unsigned int opf,
 	return ret;
 }
 
-static void attach_extent_buffer_page(struct extent_buffer *eb,
+static int attach_extent_buffer_page(struct extent_buffer *eb,
 				      struct page *page)
 {
-	/*
-	 * If the page is mapped to btree inode, we should hold the private
-	 * lock to prevent race.
-	 * For cloned or dummy extent buffers, their pages are not mapped and
-	 * will not race with any other ebs.
-	 */
-	if (page->mapping)
-		lockdep_assert_held(&page->mapping->private_lock);
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_subpage *subpage;
+	int start;
+	int nbits;
+	int ret;
 
-	if (!PagePrivate(page))
-		attach_page_private(page, eb);
-	else
-		WARN_ON(page->private != (unsigned long)eb);
+	if (!btrfs_is_subpage(fs_info)) {
+		/*
+		 * If the page is mapped to btree inode, we should hold the
+		 * private lock to prevent race.
+		 * For cloned or dummy extent buffers, their pages are not
+		 * mapped and will not race with any other ebs.
+		 */
+		if (page->mapping)
+			lockdep_assert_held(&page->mapping->private_lock);
+
+		if (!PagePrivate(page))
+			attach_page_private(page, eb);
+		else
+			WARN_ON(page->private != (unsigned long)eb);
+		return 0;
+	}
+
+	/* Already mapped, just update the existing range */
+	if (PagePrivate(page))
+		goto update_bitmap;
+
+	/* Do new allocation to attach subpage */
+	ret = btrfs_attach_subpage(fs_info, page);
+	if (ret < 0)
+		return ret;
+
+update_bitmap:
+	start = (eb->start - page_offset(page)) >> fs_info->sectorsize_bits;
+	nbits = eb->len >> fs_info->sectorsize_bits;
+
+	subpage = (struct btrfs_subpage *)page->private;
+	spin_lock_bh(&subpage->lock);
+	bitmap_set(subpage->tree_block_bitmap, start, nbits);
+	spin_unlock_bh(&subpage->lock);
+	return 0;
 }
 
 void set_page_extent_mapped(struct page *page)
@@ -5065,12 +5093,19 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		return NULL;
 
 	for (i = 0; i < num_pages; i++) {
+		int ret;
+
 		p = alloc_page(GFP_NOFS);
 		if (!p) {
 			btrfs_release_extent_buffer(new);
 			return NULL;
 		}
-		attach_extent_buffer_page(new, p);
+		ret = attach_extent_buffer_page(new, p);
+		if (ret < 0) {
+			put_page(p);
+			btrfs_release_extent_buffer(new);
+			return NULL;
+		}
 		WARN_ON(PageDirty(p));
 		SetPageUptodate(p);
 		new->pages[i] = p;
@@ -5354,6 +5389,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			goto free_eb;
 		}
 
+		/*
+		 * Preallocate page->private for subpage case, so that
+		 * we won't allocate memory with private_lock hold.
+		 */
+		ret = btrfs_attach_subpage(fs_info, p);
+		if (ret < 0) {
+			unlock_page(p);
+			put_page(p);
+			exists = ERR_PTR(-ENOMEM);
+			goto free_eb;
+		}
+
 		spin_lock(&mapping->private_lock);
 		exists = grab_extent_buffer_from_page(p);
 		if (exists) {
@@ -5362,8 +5409,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			put_page(p);
 			goto free_eb;
 		}
+		/* Should not fail, as we have attached the subpage already */
 		attach_extent_buffer_page(eb, p);
 		spin_unlock(&mapping->private_lock);
+
 		WARN_ON(PageDirty(p));
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
-- 
2.29.2

