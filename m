Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A32418FE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhI0HYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhI0HY2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E9B420090
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4VgA9ZYHwPlTd8AkyVZhUu3UX5VWs1uFa32wRpZU70=;
        b=oj3GSgoG2B6qrOhfRKXfnh6q2WQrc6EkMfuCZqk5lpR7tkrVugikHvMR0n7RzTcFEBiV+c
        Ha/uE3OSMEbJMMlWSqTFCkN90BrbVYtXBpEVquBtCG0yMbBKg3XhlFosYacuc9IuhyxspL
        sDdKBZl7HNYmTIBwgE17VosvTcCQZos=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E83E913A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qMWILElxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 23/26] btrfs: teach __extent_writepage() to handle locked page differently
Date:   Mon, 27 Sep 2021 15:22:05 +0800
Message-Id: <20210927072208.21634-24-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pages passed to __extent_writepage() are always locked, but they may be
locked by different functions.

There are two types of locked page for __extent_writepage():

- Page locked by plain lock_page()
  It should not have any subpage::writers count.
  Can be unlocked by unlock_page().
  This is the most common locked page for __extent_writepage() called
  inside extent_write_cache_pages() or extent_write_full_page().
  Rarer cases includes the @locked_page from extent_write_locked_range().

- Page locked by lock_delalloc_pages()
  There is only one caller, all pages except @locked_page for
  extent_write_locked_range().
  In this case, we have to call subpage helper to handle the case.

So here we introduce a helper, btrfs_page_unlock_writer(), to allow
__extent_writepage() to unlock different locked pages.

And since for all other callers of __extent_writepage() their pages are
ensured to be locked by lock_page(), also add an extra check for
epd::extent_locked to unlock such pages directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 15 ++++++++++++++-
 fs/btrfs/subpage.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h   |  2 ++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f05d8896d1ad..8da38f50479d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4051,6 +4051,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 			      struct extent_page_data *epd)
 {
 	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u64 page_start = page_offset(page);
 	const u64 page_end = page_start + PAGE_SIZE - 1;
 	int ret;
@@ -4139,7 +4140,19 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 */
 	if (PageError(page))
 		end_extent_writepage(page, ret, page_start, page_end);
-	unlock_page(page);
+	if (epd->extent_locked) {
+		/*
+		 * If epd->extent_locked, it's from extent_write_locked_range(),
+		 * the page can either be locked by lock_page() or
+		 * process_one_page().
+		 * Let btrfs_page_unlock_writer() to handle both cases.
+		 */
+		ASSERT(wbc);
+		btrfs_page_unlock_writer(fs_info, page, wbc->range_start,
+					 wbc->range_end + 1 - wbc->range_start);
+	} else {
+		unlock_page(page);
+	}
 	ASSERT(ret <= 0);
 	return ret;
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 2bea6766d84e..50b3d96289ca 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -691,3 +691,46 @@ void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	ASSERT(PagePrivate(page) && page->private);
 	ASSERT(subpage_test_bitmap_all_zero(fs_info, subpage, dirty));
 }
+
+/*
+ * Helper to handle different locked page with different page size
+ * - Page locked by plain lock_page()
+ *   It should not have any subpage::writers count.
+ *   Can be unlocked by unlock_page().
+ *   This is the most common locked page for __extent_writepage() called
+ *   inside extent_write_cache_pages() or extent_write_full_page().
+ *   Rarer cases includes the @locked_page from extent_write_locked_range().
+ *
+ * - Page locked by lock_delalloc_pages()
+ *   There is only one caller, all pages except @locked_page for
+ *   extent_write_locked_range().
+ *   In this case, we have to call subpage helper to handle the case.
+ */
+void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
+			      u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage;
+
+	ASSERT(PageLocked(page));
+	/* For regular page size case, we just unlock the page */
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return unlock_page(page);
+
+	ASSERT(PagePrivate(page) && page->private);
+	subpage = (struct btrfs_subpage *)page->private;
+
+	/*
+	 * For subpage case, there are two types of locked page.
+	 * With or without writers number.
+	 *
+	 * Since we own the page lock, no one else could touch
+	 * subpage::writers and are we safe to do several atomic operations
+	 * without spinlock.
+	 */
+	if (atomic_read(&subpage->writers))
+		/* No writers, locked by plain lock_page() */
+		return unlock_page(page);
+
+	/* Have writers, use proper subpage helper to end it */
+	btrfs_page_end_writer_lock(fs_info, page, start, len);
+}
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 46224f959c34..7accb5c40d33 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -150,5 +150,7 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 
 void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 				 struct page *page);
+void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
+			      u64 start, u32 len);
 
 #endif
-- 
2.33.0

