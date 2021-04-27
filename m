Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6636CF28
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbhD0XFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238340AbhD0XFb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9J7PRQld4sCkbRBTcy7qoYcypXJKMZq31SeZbuJqJM=;
        b=DDmMLWOnc0PRiTVkfz0KxxeGmvMxEqtQ4nX1WTi6E2AO6gQbj/7DcaWi98Borivt+pVJLP
        B+ieHT++y3gxe3o6nLJ/gdeS4quYXI/5MsQZurevVnn754TTcrNdnAWwsPh9BLCK6hkDWH
        uF2hQ+rLkm95VSMYlfBbxZKQcwoklps=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCECBAC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 23/42] btrfs: make page Ordered bit to be subpage compatible
Date:   Wed, 28 Apr 2021 07:03:30 +0800
Message-Id: <20210427230349.369603-24-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This involves the following modication:
- Ordered extent creation
  This is done in process_one_page(), now PAGE_SET_ORDERED will call
  subpage helper to do the work.

- endio functions
  This is done in btrfs_mark_ordered_io_finished().

- btrfs_invalidatepage()

Now the usage of page Ordered flag for ordered extent accounting is fully
subpage compatible.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/inode.c        | 12 +++++++++---
 fs/btrfs/ordered-data.c |  5 +++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 006ac1ffb9a4..62d64b33e856 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1827,7 +1827,7 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 	len = end + 1 - start;
 
 	if (page_ops & PAGE_SET_ORDERED)
-		SetPageOrdered(page);
+		btrfs_page_clamp_set_ordered(fs_info, page, start, len);
 
 	if (page == locked_page)
 		return 1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0dab0a30f2a2..c5125698bc09 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -51,6 +51,7 @@
 #include "block-group.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "subpage.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -170,7 +171,8 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		index++;
 		if (!page)
 			continue;
-		ClearPageOrdered(page);
+		btrfs_page_clear_ordered(inode->root->fs_info, page,
+					 page_offset(page), PAGE_SIZE);
 		put_page(page);
 	}
 
@@ -8290,6 +8292,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct extent_state *cached_state = NULL;
 	u64 page_start = page_offset(page);
@@ -8325,6 +8328,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		struct btrfs_ordered_extent *ordered;
 		bool delete_states;
 		u64 range_end;
+		u32 range_len;
 
 		ordered = btrfs_lookup_first_ordered_range(inode, cur, page_end + 1 - cur);
 		if (!ordered) {
@@ -8350,7 +8354,9 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 
 		range_end = min(ordered->file_offset + ordered->num_bytes - 1,
 				page_end);
-		if (!PageOrdered(page)) {
+		ASSERT(range_end + 1 - cur < U32_MAX);
+		range_len = range_end + 1 - cur;
+		if (!btrfs_page_test_ordered(fs_info, page, cur, range_len)) {
 			/*
 			 * If Ordered (Private2) is cleared, it means endio has
 			 * already been executed for the range.
@@ -8360,7 +8366,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 			delete_states = false;
 			goto next;
 		}
-		ClearPageOrdered(page);
+		btrfs_page_clear_ordered(fs_info, page, cur, range_len);
 
 		/*
 		 * IO on this page will never be started, so we need to account
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index d0f57739e942..8d1775754807 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -16,6 +16,7 @@
 #include "compression.h"
 #include "delalloc-space.h"
 #include "qgroup.h"
+#include "subpage.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
@@ -396,11 +397,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			 *
 			 * If no such bit, we need to skip to next range.
 			 */
-			if (!PageOrdered(page)) {
+			if (!btrfs_page_test_ordered(fs_info, page, cur, len)) {
 				cur += len;
 				continue;
 			}
-			ClearPageOrdered(page);
+			btrfs_page_clear_ordered(fs_info, page, cur, len);
 		}
 
 		/* Now we're fine to update the accounting */
-- 
2.31.1

