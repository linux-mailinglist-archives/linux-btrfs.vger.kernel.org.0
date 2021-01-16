Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD92F8BF9
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAPHQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 02:16:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:55972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbhAPHQi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 02:16:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610781351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4I2zDzKnp2EJsv2/i6cS6Rqzk5uTgvT2mC+pztUcVo=;
        b=E67SE5hz3PevKAn/pFuJBhggzvZf2COfaYteyJi300c1Guf6wkgoaEMKGGveG5vN92mJbr
        hFcyCFVKIsuPM18dEUCLyNR1p2br2cnoIZTVOixzgz1Zr0b5gAeUbZbiCj8ZN2fN2ZIwwx
        KafRKuZaHhiOwAMc3pj+T4r9BCYUeQ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10EC4B7F5
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 07:15:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to handle subpage case
Date:   Sat, 16 Jan 2021 15:15:19 +0800
Message-Id: <20210116071533.105780-5-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage case, we need to allocate new memory for each metadata page.

So we need to:
- Allow attach_extent_buffer_page() to return int
  To indicate allocation failure

- Prealloc btrfs_subpage structure for alloc_extent_buffer()
  We don't want to call memory allocation with spinlock hold, so
  do preallocation before we acquire mapping->private_lock.

- Handle subpage and regular case differently in
  attach_extent_buffer_page()
  For regular case, just do the usual thing.
  For subpage case, allocate new memory or use the preallocated memory.

For future subpage metadata, we will make more usage of radix tree to
grab extnet buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 75 ++++++++++++++++++++++++++++++++++++++------
 fs/btrfs/subpage.h   | 17 ++++++++++
 2 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a816ba4a8537..320731487ac0 100644
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
+				      struct page *page,
+				      struct btrfs_subpage *prealloc)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	int ret;
+
 	/*
 	 * If the page is mapped to btree inode, we should hold the private
 	 * lock to prevent race.
@@ -3152,10 +3157,32 @@ static void attach_extent_buffer_page(struct extent_buffer *eb,
 	if (page->mapping)
 		lockdep_assert_held(&page->mapping->private_lock);
 
-	if (!PagePrivate(page))
-		attach_page_private(page, eb);
-	else
-		WARN_ON(page->private != (unsigned long)eb);
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
+		kfree(prealloc);
+		return 0;
+	}
+
+	if (prealloc) {
+		/* Has preallocated memory for subpage */
+		spin_lock_init(&prealloc->lock);
+		attach_page_private(page, prealloc);
+	} else {
+		/* Do new allocation to attach subpage */
+		ret = btrfs_attach_subpage(fs_info, page);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 void set_page_extent_mapped(struct page *page)
@@ -5062,21 +5089,29 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	if (new == NULL)
 		return NULL;
 
+	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
+	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
+
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
 		copy_page(page_address(p), page_address(src->pages[i]));
 	}
 
-	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
-	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
 	return new;
 }
@@ -5308,12 +5343,28 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
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
+		 * Preallocate page->private for subpage case, so that
+		 * we won't allocate memory with private_lock hold.
+		 * The memory will be freed by attach_extent_buffer_page() or
+		 * freed manually if exit earlier.
+		 */
+		ret = btrfs_alloc_subpage(fs_info, &prealloc);
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
@@ -5321,10 +5372,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			unlock_page(p);
 			put_page(p);
 			mark_extent_buffer_accessed(exists, p);
+			kfree(prealloc);
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
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 96f3b226913e..f701256dd1e2 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -23,8 +23,25 @@
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
+	union {
+		/* Structures only used by metadata */
+		/* Structures only used by data */
+	};
 };
 
+/* For rare cases where we need to pre-allocate a btrfs_subpage structure */
+static inline int btrfs_alloc_subpage(struct btrfs_fs_info *fs_info,
+				      struct btrfs_subpage **ret)
+{
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return 0;
+
+	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
+	if (!*ret)
+		return -ENOMEM;
+	return 0;
+}
+
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 
-- 
2.30.0

