Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9963DE6D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Aug 2021 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHCGoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 02:44:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbhHCGoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Aug 2021 02:44:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C814D20003
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Aug 2021 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627973032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/YyZ6HSSW4Y2UKWOIRY8ka/DaNhhZgjs9LLQagKrncY=;
        b=oMEHe32HsWR1nikCrHHyqijOkKms3oRFLoTuHbUxmq+ZCkIxQXxDEP7+kmEODGgrO68CXY
        ur2lQkD3Hc5NW9f9XnM/PjwQCtEiHzLuqh9lnfaKmuGNS0BQAdK12C5AWrE0SlnX7EXkik
        iZCwYWrbWxmEfLj9DnXmTbmmhuHG7G4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0DF8413709
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Aug 2021 06:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OwwGMKflCGHVTgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Aug 2021 06:43:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: properly cleanup the ordered extents if we hit critical error during bio assembly and submission
Date:   Tue,  3 Aug 2021 14:43:49 +0800
Message-Id: <20210803064349.201192-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
If we hit a critical error (mostly -ENOMEM) inside
__extent_writepage_io(), we could cause ordered extent hanging forever.

This will hang the filesystem.

[CAUSE]
If we hit a critical -ENOMEM error inside __extent_writepage_io(), the
error will be finally passed to extent_write_cache_pages() and it will
abort current writeback and no longer try to write back the remaining
pages.

The problem is, __extent_writepage() can call writepage_delalloc(),
which can allocated one or more ordered extents.

Such ordered extents can cross several pages, at most 128MiB in size.

But when later __extent_writepage_io() fails, we don't even know whether
we have allocated an ordered extent, nor its range.

Thus we don't properly cleanup the allocated ordered extent range, and
leave such ordered extent hanging there forever.

Thankfully, this can only happen for critical errors like -ENOMEM.

[FIX]
Introduce new members for struct extent_page_data, to record the start
and end bytenr of the ordered extent ranges we have allocated.

The range is not a perfect record, as it includes holes or clean pages.

But that is good enough for us to do cleanup.
The cleanup function will skip any uncached page, and only cleanup
ranges with PageOrdered bit set.

This is still not as accurate as the RFC "btrfs: eliminate the window
between run delalloc range and bio submission" which binds ordered
extent allocation and bio submission together.

But at least we can handle such hangling ordered extent now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 104 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1a6ac787faf..ab0cfdb98555 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -145,6 +145,27 @@ struct extent_page_data {
 
 	/* tells the submit_bio code to use REQ_SYNC */
 	unsigned int sync_io:1;
+
+	/*
+	 * The following three members are used for error handling.
+	 *
+	 * If we hit error assembling the bios, we still need to cleanup
+	 * the ordered extent. Those members are here to record the ordered
+	 * extent range and bio assembly progress.
+	 *
+	 * The first delalloc range file offset started by this writeback.
+	 * 0 means not initialized.
+	 */
+	u64 delalloc_start;
+
+	/*
+	 * The last delalloc range file offset started by this writeback.
+	 * 0 means not initialized.
+	 */
+	u64 delalloc_end;
+
+	/* The file offset of the start location to start bio assembly */
+	u64 next;
 };
 
 static int add_extent_changeset(struct extent_state *state, u32 bits,
@@ -3763,6 +3784,22 @@ static void update_nr_written(struct writeback_control *wbc,
 	wbc->nr_to_write -= nr_written;
 }
 
+static void update_epd_delalloc_range(struct extent_page_data *epd,
+				      u64 delalloc_start,
+				      u64 delalloc_end)
+{
+	/* Not initialized, used the values directly */
+	if (epd->delalloc_start == 0) {
+		epd->delalloc_start = delalloc_start;
+		epd->delalloc_end = delalloc_end;
+		return;
+	}
+
+	/* Update the existing range */
+	epd->delalloc_start = min(epd->delalloc_start, delalloc_start);
+	epd->delalloc_end = max(epd->delalloc_end, delalloc_end);
+}
+
 /*
  * helper for __extent_writepage, doing all of the delayed allocation setup.
  *
@@ -3775,6 +3812,7 @@ static void update_nr_written(struct writeback_control *wbc,
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc,
+		struct extent_page_data *epd,
 		u64 delalloc_start, unsigned long *nr_written)
 {
 	u64 page_end = delalloc_start + PAGE_SIZE - 1;
@@ -3800,6 +3838,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 					     page_offset(page), PAGE_SIZE);
 			return ret;
 		}
+
+		update_epd_delalloc_range(epd, delalloc_start, delalloc_end);
+
 		/*
 		 * delalloc_end is already one less than the total length, so
 		 * we don't subtract one from PAGE_SIZE
@@ -3931,6 +3972,12 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u64 dirty_range_end;
 		u32 iosize;
 
+		/*
+		 * Record current file offset into epd, so when error happens
+		 * we can cleanup the ordered extents properly.
+		 */
+		epd->next = cur;
+
 		if (cur >= i_size) {
 			btrfs_writepage_endio_finish_ordered(inode, page, cur,
 							     end, true);
@@ -4024,6 +4071,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			if (PageWriteback(page))
 				btrfs_page_clear_writeback(fs_info, page, cur,
 							   iosize);
+			break;
 		}
 
 		cur += iosize;
@@ -4039,6 +4087,42 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	return ret;
 }
 
+static void cleanup_ordered_ranges(struct btrfs_inode *inode,
+				   struct extent_page_data *epd,
+				   int ret)
+{
+	u64 cur = epd->next;
+
+	ASSERT(ret < 0);
+
+	/* Go through the remaining pages of the delalloc range */
+	while (cur < epd->delalloc_end) {
+		struct page *page;
+		u64 page_end = round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1;
+		u64 range_end = min(epd->delalloc_end, page_end);
+
+		page = find_lock_page(inode->vfs_inode.i_mapping,
+				      cur >> PAGE_SHIFT);
+		/*
+		 * The page can be invalidated, in that case we can just skip
+		 * to next page.
+		 */
+		if (!page)
+			goto next;
+
+		/*
+		 * end_extent_writepage() will call
+		 * btrfs_writepage_endio_finish_ordered() which will cleanup
+		 * ordered extent according to its page Ordered bit.
+		 */
+		end_extent_writepage(page, ret, cur, range_end);
+		unlock_page(page);
+		put_page(page);
+next:
+		cur = range_end + 1;
+	}
+}
+
 /*
  * the writepage semantics are similar to regular writepage.  extent
  * records are inserted to lock ranges in the tree, and as dirty areas
@@ -4053,7 +4137,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 {
 	struct inode *inode = page->mapping->host;
 	u64 start = page_offset(page);
-	u64 page_end = start + PAGE_SIZE - 1;
 	int ret;
 	int nr = 0;
 	size_t pg_offset;
@@ -4088,7 +4171,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	}
 
 	if (!epd->extent_locked) {
-		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
+		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, epd, start,
 					 &nr_written);
 		if (ret == 1)
 			return 0;
@@ -4132,20 +4215,17 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 * end_extent_writepage().
 	 * Error can still be properly passed to higher layer as page will
 	 * be set error, here we just don't handle the IO failure.
-	 *
-	 * NOTE: This is just a hotfix for subpage.
-	 * The root fix will be properly ending ordered extent when we hit
-	 * an error during writeback.
-	 *
-	 * But that needs a bigger refactoring, as we not only need to grab the
-	 * submitted OE, but also need to know exactly at which bytenr we hit
-	 * the error.
-	 * Currently the full page based __extent_writepage_io() is not
-	 * capable of that.
 	 */
 
 	unlock_page(page);
 	ASSERT(ret <= 0);
+	/*
+	 * We hit a critical error during bio submission, this will make us to
+	 * abort any later page writeback.
+	 * We need to cleanup the ordered extent we have added.
+	 */
+	if (ret < 0)
+		cleanup_ordered_ranges(BTRFS_I(inode), epd, ret);
 	return ret;
 }
 
-- 
2.32.0

