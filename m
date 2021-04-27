Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE936CF1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhD0XFJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239185AbhD0XFI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iz3JsIC8StIW5QstckFW10BtFIpBW0Dxhsjd+6MEWoM=;
        b=sKUyonYXIXPa7Axcqg1iz23WZxIhqFcHPyjnZXnzAHUveyHVnN3doXQD8eRzV+1ZyVpLx5
        WN+MgjMyvxi2orIWJSMrUYVk+12RFXQqMKBDUzRkemCverO7Y4ao9ibTSb/x46HIdUHyic
        aDmGJh0cFjwbRtazg9Md+pnogBovfJY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A87F5ABED;
        Tue, 27 Apr 2021 23:04:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [Patch v2 13/42] btrfs: rename PagePrivate2 to PageOrdered inside btrfs
Date:   Wed, 28 Apr 2021 07:03:20 +0800
Message-Id: <20210427230349.369603-14-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inside btrfs, we use Private2 page status to indicate we have ordered
extent with pending IO for the sector.

But the page status name, Private2, tells us nothing about the bit
itself, so this patch will rename it to Ordered.
And with extra comment about the bit added, so reader who is still
uncertain about the page Ordered status, will find the comment pretty
easily.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h        | 11 ++++++++++
 fs/btrfs/extent_io.c    |  4 ++--
 fs/btrfs/extent_io.h    |  2 +-
 fs/btrfs/inode.c        | 45 ++++++++++++++++++++++-------------------
 fs/btrfs/ordered-data.c |  8 ++++----
 5 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 23fc9a56da32..5d352f6b61f4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3782,4 +3782,15 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 	return fs_info->zoned != 0;
 }
 
+/*
+ * Btrfs uses page status Private2 to indicate there is an ordered extent with
+ * unfinished IO.
+ *
+ * Rename the Private2 accessors to Ordered inside btrfs, to slightly improve
+ * the readability.
+ */
+#define PageOrdered(page)		PagePrivate2(page)
+#define SetPageOrdered(page)		SetPagePrivate2(page)
+#define ClearPageOrdered(page)		ClearPagePrivate2(page)
+
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e46c32289421..faee09a52dd5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1975,8 +1975,8 @@ static int __process_pages_contig(struct address_space *mapping,
 		}
 
 		for (i = 0; i < ret; i++) {
-			if (page_ops & PAGE_SET_PRIVATE2)
-				SetPagePrivate2(pages[i]);
+			if (page_ops & PAGE_SET_ORDERED)
+				SetPageOrdered(pages[i]);
 
 			if (locked_page && pages[i] == locked_page) {
 				put_page(pages[i]);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 78eeb0d59974..1d7bc27719da 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -39,7 +39,7 @@ enum {
 /* Page starts writeback, clear dirty bit and set writeback bit */
 #define PAGE_START_WRITEBACK	(1 << 1)
 #define PAGE_END_WRITEBACK	(1 << 2)
-#define PAGE_SET_PRIVATE2	(1 << 3)
+#define PAGE_SET_ORDERED	(1 << 3)
 #define PAGE_SET_ERROR		(1 << 4)
 #define PAGE_LOCK		(1 << 5)
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e1c248fdf592..0dab0a30f2a2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -170,7 +170,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		index++;
 		if (!page)
 			continue;
-		ClearPagePrivate2(page);
+		ClearPageOrdered(page);
 		put_page(page);
 	}
 
@@ -1156,15 +1156,16 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
-		/* we're not doing compressed IO, don't unlock the first
+		/*
+		 * We're not doing compressed IO, don't unlock the first
 		 * page (which the caller expects to stay locked), don't
 		 * clear any dirty bits and don't set any writeback bits
 		 *
-		 * Do set the Private2 bit so we know this page was properly
-		 * setup for writepage
+		 * Do set the Ordered (Private2) bit so we know this page was
+		 * properly setup for writepage.
 		 */
 		page_ops = unlock ? PAGE_UNLOCK : 0;
-		page_ops |= PAGE_SET_PRIVATE2;
+		page_ops |= PAGE_SET_ORDERED;
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
 					     locked_page,
@@ -1828,7 +1829,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
-					     PAGE_UNLOCK | PAGE_SET_PRIVATE2);
+					     PAGE_UNLOCK | PAGE_SET_ORDERED);
 
 		cur_offset = extent_end;
 
@@ -2576,7 +2577,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	lock_extent_bits(&inode->io_tree, page_start, page_end, &cached_state);
 
 	/* already ordered? We're done */
-	if (PagePrivate2(page))
+	if (PageOrdered(page))
 		goto out_reserved;
 
 	ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
@@ -2651,8 +2652,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_writepage_fixup *fixup;
 
-	/* this page is properly in the ordered list */
-	if (PagePrivate2(page))
+	/* This page has ordered extent covering it already */
+	if (PageOrdered(page))
 		return 0;
 
 	/*
@@ -8272,9 +8273,9 @@ static int btrfs_migratepage(struct address_space *mapping,
 	if (page_has_private(page))
 		attach_page_private(newpage, detach_page_private(page));
 
-	if (PagePrivate2(page)) {
-		ClearPagePrivate2(page);
-		SetPagePrivate2(newpage);
+	if (PageOrdered(page)) {
+		ClearPageOrdered(page);
+		SetPageOrdered(newpage);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
@@ -8301,9 +8302,10 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 * this page, nor bio can be submitted for this page.
 	 *
 	 * But already submitted bio can still be finished on this page.
-	 * Furthermore, endio function won't skip page which has Private2
-	 * already cleared, so it's possible for endio and invalidatepage
-	 * to do the same ordered extent accounting twice on one page.
+	 * Furthermore, endio function won't skip page which has Ordered
+	 * (private2) already cleared, so it's possible for endio and
+	 * invalidatepage to do the same ordered extent accounting twice
+	 * on one page.
 	 *
 	 * So here we wait any submitted bios to finish, so that we won't
 	 * do double ordered extent accounting on the same page.
@@ -8348,17 +8350,17 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 
 		range_end = min(ordered->file_offset + ordered->num_bytes - 1,
 				page_end);
-		if (!PagePrivate2(page)) {
+		if (!PageOrdered(page)) {
 			/*
-			 * If Private2 is cleared, it means endio has already
-			 * been executed for the range.
+			 * If Ordered (Private2) is cleared, it means endio has
+			 * already been executed for the range.
 			 * We can't delete the extent states as
 			 * btrfs_finish_ordered_io() may still use some of them.
 			 */
 			delete_states = false;
 			goto next;
 		}
-		ClearPagePrivate2(page);
+		ClearPageOrdered(page);
 
 		/*
 		 * IO on this page will never be started, so we need to account
@@ -8423,9 +8425,10 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 	/*
 	 * We have iterated through all OEs of the page, the page should not
-	 * have Private2 anymore, or the above iteration has something wrong.
+	 * have Ordered (Private2) anymore, or the above iteration has
+	 * something wrong.
 	 */
-	ASSERT(!PagePrivate2(page));
+	ASSERT(!PageOrdered(page));
 	if (!inode_evicting)
 		__btrfs_releasepage(page, GFP_NOFS);
 	ClearPageChecked(page);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 82574e3e62ec..d0f57739e942 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -391,16 +391,16 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 
 		if (page) {
 			/*
-			 * Private2 bit indicates whether we still have pending
-			 * io unfinished for the ordered extent.
+			 * Ordered (Private2) bit indicates whether we still
+			 * have pending io unfinished for the ordered extent.
 			 *
 			 * If no such bit, we need to skip to next range.
 			 */
-			if (!PagePrivate2(page)) {
+			if (!PageOrdered(page)) {
 				cur += len;
 				continue;
 			}
-			ClearPagePrivate2(page);
+			ClearPageOrdered(page);
 		}
 
 		/* Now we're fine to update the accounting */
-- 
2.31.1

