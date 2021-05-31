Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F9D395771
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhEaIxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhEaIxJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDrvP7Rf8C19HqpseUuyPpbDwoHzaafvNkFpl0YGBUc=;
        b=odCZjmJ073ddnR3S5eooOiIIkpzRbBcyTb87jCBzRI43eDTcjUQILHbGEm6FlJ/tBvacOR
        I52eLs9P+mIuyoo0CG5tPUYqV4So+QxSsUwts/PsrAKEpAeHN9BkYgbXrC2WNNCFkswe5g
        AzsZo/Vne/h7PEx7RGtxcE7ehQyUkWE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 546BFB2E9
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 10/30] btrfs: make page Ordered bit to be subpage compatible
Date:   Mon, 31 May 2021 16:50:46 +0800
Message-Id: <20210531085106.259490-11-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
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

- btrfs_cleanup_ordered_extents()
  Use the subpage page helper, and add an extra branch to exit if the
  locked page have covered the full range.

Now the usage of page Ordered flag for ordered extent accounting is fully
subpage compatible.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/inode.c        | 19 ++++++++++++++-----
 fs/btrfs/ordered-data.c |  5 +++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 531edee6e988..85effc6e4e91 100644
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
index ee1e923cb870..f14afce03759 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -51,6 +51,7 @@
 #include "block-group.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "subpage.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -191,18 +192,22 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		 * range, then __endio_write_update_ordered() will handle
 		 * the ordered extent accounting for the range.
 		 */
-		ClearPageOrdered(page);
+		btrfs_page_clamp_clear_ordered(inode->root->fs_info, page,
+					       offset, bytes);
 		put_page(page);
 	}
 
+	/* The locked page covers the full range, nothing needs to be done */
+	if (bytes + offset <= page_offset(locked_page) + PAGE_SIZE)
+		return;
 	/*
 	 * In case this page belongs to the delalloc range being instantiated
 	 * then skip it, since the first page of a range is going to be
 	 * properly cleaned up by the caller of run_delalloc_range
 	 */
 	if (page_start >= offset && page_end <= (offset + bytes - 1)) {
-		offset += PAGE_SIZE;
-		bytes -= PAGE_SIZE;
+		bytes = offset + bytes - page_offset(locked_page) - PAGE_SIZE;
+		offset = page_offset(locked_page) + PAGE_SIZE;
 	}
 
 	return __endio_write_update_ordered(inode, offset, bytes, false);
@@ -8320,6 +8325,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_io_tree *tree = &inode->io_tree;
 	struct extent_state *cached_state = NULL;
 	u64 page_start = page_offset(page);
@@ -8355,6 +8361,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 		struct btrfs_ordered_extent *ordered;
 		bool delete_states;
 		u64 range_end;
+		u32 range_len;
 
 		ordered = btrfs_lookup_first_ordered_range(inode, cur,
 							   page_end + 1 - cur);
@@ -8381,7 +8388,9 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 
 		range_end = min(ordered->file_offset + ordered->num_bytes - 1,
 				page_end);
-		if (!PageOrdered(page)) {
+		ASSERT(range_end + 1 - cur < U32_MAX);
+		range_len = range_end + 1 - cur;
+		if (!btrfs_page_test_ordered(fs_info, page, cur, range_len)) {
 			/*
 			 * If Ordered (Private2) is cleared, it means endio has
 			 * already been executed for the range.
@@ -8391,7 +8400,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 			delete_states = false;
 			goto next;
 		}
-		ClearPageOrdered(page);
+		btrfs_page_clear_ordered(fs_info, page, cur, range_len);
 
 		/*
 		 * IO on this page will never be started, so we need to account
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b1b377ad99a0..6eb41b7c0c84 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -16,6 +16,7 @@
 #include "compression.h"
 #include "delalloc-space.h"
 #include "qgroup.h"
+#include "subpage.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
@@ -395,11 +396,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			 *
 			 * If there's no such bit, we need to skip to next range.
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

