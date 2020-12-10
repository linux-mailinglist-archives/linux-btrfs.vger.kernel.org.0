Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02F2D53F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgLJGkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:40:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:44472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgLJGkm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PS6dSHAIgpQp1wVFQuVvNGYMN1y1oFvnZ+gsJPVcpLc=;
        b=ktjbPVJQEsgVpFA7PrgjP56sRUeHqDB2j0zbYB9DTJqtovRi3UMAPHkfBw8mwiutfs+lWb
        hAwIWkjdBRa4G1utQgeYN28XhDmvTEOyftEnnctkk+MjXOcerSQ/4opwH0GGnBbbz1g/r0
        V9QpmIKNrDVqdAmyYR498bnp45WoZq4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56FA1AD19
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/18] btrfs: extent_io: make attach_extent_buffer_page() to handle subpage case
Date:   Thu, 10 Dec 2020 14:38:53 +0800
Message-Id: <20201210063905.75727-7-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
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

  The bitmap update will be handled by new subpage specific helper,
  btrfs_subpage_set_tree_block().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 69 +++++++++++++++++++++++++++++++++++---------
 fs/btrfs/subpage.h   | 44 ++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6350c2687c7e..51dd7ec3c2b3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -24,6 +24,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "subpage.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -3142,22 +3143,41 @@ static int submit_extent_page(unsigned int opf,
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
+	int ret;
 
-	if (!PagePrivate(page))
-		attach_page_private(page, eb);
-	else
-		WARN_ON(page->private != (unsigned long)eb);
+	if (fs_info->sectorsize == PAGE_SIZE) {
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
+	btrfs_subpage_set_tree_block(fs_info, page, eb->start, eb->len);
+	return 0;
 }
 
 void set_page_extent_mapped(struct page *page)
@@ -5067,12 +5087,19 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
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
@@ -5321,6 +5348,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
@@ -5329,8 +5368,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 96f3b226913e..c2ce603e7848 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -23,9 +23,53 @@
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
+	union {
+		/* Structures only used by metadata */
+		struct {
+			u16 tree_block_bitmap;
+		};
+		/* structures only used by data */
+	};
 };
 
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 
+/*
+ * Convert the [start, start + len) range into a u16 bitmap
+ *
+ * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
+ */
+static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
+			struct page *page, u64 start, u32 len)
+{
+	int bit_start = (start - page_offset(page)) >> fs_info->sectorsize_bits;
+	int nbits = len >> fs_info->sectorsize_bits;
+
+	/* Basic checks */
+	ASSERT(PagePrivate(page) && page->private);
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
+	ASSERT(page_offset(page) <= start &&
+	       start + len <= page_offset(page) + PAGE_SIZE);
+	/*
+	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
+	 * first left shift to be calculated in unsigned long (u32), then
+	 * truncate the result to u16.
+	 */
+	return (u16)(((1UL << nbits) - 1) << bit_start);
+}
+
+static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *fs_info,
+			struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	unsigned long flags;
+	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	subpage->tree_block_bitmap |= tmp;
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
 #endif /* BTRFS_SUBPAGE_H */
-- 
2.29.2

