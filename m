Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66093303800
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 09:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAZIfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 03:35:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390266AbhAZIfN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:35:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jcmy/XmGoylj3U5xizcB6Lric8m2b3fuLB8TBTIM7pk=;
        b=AyWoRbNp8CVqcRIGP2KhWntvh4Zd5bT+Zq+CzOpb3cX4ElG9+GYIjDc+20sBSSzlp03bGD
        zngHpJ6zZ/yJz9vELZbW6w4gIne8sEwM7fqMLmnDbYAYKoXmeeJmCfojLJzrCThuV5ra8X
        pcUIJt7v6FNcREQuLEcvegPqkn4qxyU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5345AF39;
        Tue, 26 Jan 2021 08:34:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 04/18] btrfs: make attach_extent_buffer_page() handle subpage case
Date:   Tue, 26 Jan 2021 16:33:48 +0800
Message-Id: <20210126083402.142577-5-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, we need to allocate additional memory for each
metadata page.

So we need to:

- Allow attach_extent_buffer_page() to return int to indicate allocation
  failure

- Allow manually pre-allocate subpage memory for alloc_extent_buffer()
  As we don't want to use GFP_ATOMIC under spinlock, we introduce
  btrfs_alloc_subpage() and btrfs_free_subpage() functions for this
  purpose.
  (The simple wrap for btrfs_free_subpage() is for later convert to
   kmem_cache. Already internally tested without problem)

- Preallocate btrfs_subpage structure for alloc_extent_buffer()
  We don't want to call memory allocation with spinlock held, so
  do preallocation before we acquire mapping->private_lock.

- Handle subpage and regular case differently in
  attach_extent_buffer_page()
  For regular case, no change, just do the usual thing.
  For subpage case, allocate new memory or use the preallocated memory.

For future subpage metadata, we will make use of radix tree to grab
extent buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 69 +++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/subpage.c   | 30 +++++++++++++++----
 fs/btrfs/subpage.h   | 10 +++++++
 3 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a56391839aca..ea105cb69e3a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -24,6 +24,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "subpage.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -3140,9 +3141,13 @@ static int submit_extent_page(unsigned int opf,
 	return ret;
 }
 
-static void attach_extent_buffer_page(struct extent_buffer *eb,
-				      struct page *page)
+static int attach_extent_buffer_page(struct extent_buffer *eb,
+				     struct page *page,
+				     struct btrfs_subpage *prealloc)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	int ret = 0;
+
 	/*
 	 * If the page is mapped to btree inode, we should hold the private
 	 * lock to prevent race.
@@ -3152,10 +3157,28 @@ static void attach_extent_buffer_page(struct extent_buffer *eb,
 	if (page->mapping)
 		lockdep_assert_held(&page->mapping->private_lock);
 
-	if (!PagePrivate(page))
-		attach_page_private(page, eb);
+	if (fs_info->sectorsize == PAGE_SIZE) {
+		if (!PagePrivate(page))
+			attach_page_private(page, eb);
+		else
+			WARN_ON(page->private != (unsigned long)eb);
+		return 0;
+	}
+
+	/* Already mapped, just free prealloc */
+	if (PagePrivate(page)) {
+		btrfs_free_subpage(prealloc);
+		return 0;
+	}
+
+	if (prealloc)
+		/* Has preallocated memory for subpage */
+		attach_page_private(page, prealloc);
 	else
-		WARN_ON(page->private != (unsigned long)eb);
+		/* Do new allocation to attach subpage */
+		ret = btrfs_attach_subpage(fs_info, page,
+					   BTRFS_SUBPAGE_METADATA);
+	return ret;
 }
 
 void set_page_extent_mapped(struct page *page)
@@ -5070,12 +5093,19 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	for (i = 0; i < num_pages; i++) {
+		int ret;
+
 		p = alloc_page(GFP_NOFS);
 		if (!p) {
 			btrfs_release_extent_buffer(new);
 			return NULL;
 		}
-		attach_extent_buffer_page(new, p);
+		ret = attach_extent_buffer_page(new, p, NULL);
+		if (ret < 0) {
+			put_page(p);
+			btrfs_release_extent_buffer(new);
+			return NULL;
+		}
 		WARN_ON(PageDirty(p));
 		SetPageUptodate(p);
 		new->pages[i] = p;
@@ -5313,12 +5343,33 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++, index++) {
+		struct btrfs_subpage *prealloc = NULL;
+
 		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
 		if (!p) {
 			exists = ERR_PTR(-ENOMEM);
 			goto free_eb;
 		}
 
+		/*
+		 * Preallocate page->private for subpage case, so that we won't
+		 * allocate memory with private_lock hold.  The memory will be
+		 * freed by attach_extent_buffer_page() or freed manually if
+		 * we exit earlier.
+		 *
+		 * Although we have ensured one subpage eb can only have one
+		 * page, but it may change in the future for 16K page size
+		 * support, so we still preallocate the memory in the loop.
+		 */
+		ret = btrfs_alloc_subpage(fs_info, &prealloc,
+					  BTRFS_SUBPAGE_METADATA);
+		if (ret < 0) {
+			unlock_page(p);
+			put_page(p);
+			exists = ERR_PTR(ret);
+			goto free_eb;
+		}
+
 		spin_lock(&mapping->private_lock);
 		exists = grab_extent_buffer(p);
 		if (exists) {
@@ -5326,10 +5377,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			unlock_page(p);
 			put_page(p);
 			mark_extent_buffer_accessed(exists, p);
+			btrfs_free_subpage(prealloc);
 			goto free_eb;
 		}
-		attach_extent_buffer_page(eb, p);
+		/* Should not fail, as we have preallocated the memory */
+		ret = attach_extent_buffer_page(eb, p, prealloc);
+		ASSERT(!ret);
 		spin_unlock(&mapping->private_lock);
+
 		WARN_ON(PageDirty(p));
 		eb->pages[i] = p;
 		if (!PageUptodate(p))
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index a3e5b6a13d54..61b28dfca20c 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -7,7 +7,8 @@
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct page *page, enum btrfs_subpage_type type)
 {
-	struct btrfs_subpage *subpage;
+	struct btrfs_subpage *subpage = NULL;
+	int ret;
 
 	/*
 	 * We have cases like a dummy extent buffer page, which is not mappped
@@ -19,11 +20,9 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
 		return 0;
 
-	subpage = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
-	if (!subpage)
-		return -ENOMEM;
-
-	spin_lock_init(&subpage->lock);
+	ret = btrfs_alloc_subpage(fs_info, &subpage, type);
+	if (ret < 0)
+		return ret;
 	attach_page_private(page, subpage);
 	return 0;
 }
@@ -39,5 +38,24 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 
 	subpage = (struct btrfs_subpage *)detach_page_private(page);
 	ASSERT(subpage);
+	btrfs_free_subpage(subpage);
+}
+
+int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
+			struct btrfs_subpage **ret,
+			enum btrfs_subpage_type type)
+{
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return 0;
+
+	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
+	if (!*ret)
+		return -ENOMEM;
+	spin_lock_init(&(*ret)->lock);
+	return 0;
+}
+
+void btrfs_free_subpage(struct btrfs_subpage *subpage)
+{
 	kfree(subpage);
 }
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 676280bc7562..7ba544bcc9c6 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -18,6 +18,10 @@
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
+	union {
+		/* Structures only used by metadata */
+		/* Structures only used by data */
+	};
 };
 
 enum btrfs_subpage_type {
@@ -30,4 +34,10 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 			  struct page *page);
 
+/* Allocate additional data where page represents more than one sector */
+int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
+			struct btrfs_subpage **ret,
+			enum btrfs_subpage_type type);
+void btrfs_free_subpage(struct btrfs_subpage *subpage);
+
 #endif
-- 
2.30.0

