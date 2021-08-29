Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD03FA956
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhH2F00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbhH2F0Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FCE220016
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Hdm/u/MTeB74yfqNW4Eo+/HCwu5Jw1ZKjHxGPSUjes=;
        b=DLrCMSk0CEJVPebOqHomomY53pEc+bIFsCFi/QV+wQEF2/jxvS7m0qeg+R2/nYjP8q9AjK
        NQVIZhZYjhAEDgKpdl1OogJcxDnyiwROpAihsYHAhu0sk/kFS771UurqojL36bHF3m0t0N
        IJxhXH7/uh5/n9ouqRg1nsskqvnhtgY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D9B613964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IM9GEEsaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 25/26] btrfs: don't run delalloc range which is beyond the locked_page to prevent deadlock for subpage compression
Date:   Sun, 29 Aug 2021 13:24:57 +0800
Message-Id: <20210829052458.15454-26-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With experimental subpage compression enabled, a simple fsstress can
lead to self deadlock on page 720896:

        mkfs.btrfs -f -s 4k $dev > /dev/null
        mount $dev -o compress $mnt
        $fsstress -p 1 -n 100 -w -d $mnt -v -s 1625511156

[CAUSE]
If we have a file layout looks like below:

	0	32K	64K	96K	128K
	|//|		|///////////////|
	   4K
Then we run delalloc range for the inode, it will:

- Call find_lock_delalloc_range() with @delalloc_start = 0
  Then we got a delalloc range [0, 4K).

  This range will be CoWed.

- Call find_lock_delalloc_range() again with @delalloc_start = 4K
  Since find_lock_delalloc_range() never cares whether the range
  is still inside page range [0, 64K), it will return range [64K, 128K).

  This range meets the condition for subpage compression, will go
  through async cow path.

  And async cow path will return @page_started.

  But that @page_started is now for range [64K, 128K), not for range
  [0, 64K).

- writepage_dellloc() returned 1 for page [0, 64K)
  Thus page [0, 64K) will not be unlocked, nor its page dirty status
  will be cleared.

Next time when we try to lock page [0, 64K) we will deadlock, as there
is no one to release page [0, 64K).

This problem will never happen for regular page size as one page only
contains one sector.
After the first find_lock_delalloc_range() call, the @delalloc_end will
go beyond @page_end no matter if we found a delalloc range or not

Thus this bug only happens for subpage, as now we need multiple runs to
exhaust the delalloc range of a page.

[FIX]
Fix the problem by ensure the delalloc range we ran at least starts
inside @locked_page.

So that we will never got incorrect @page_started.

And to prevent such problem from happening again:

- Make find_lock_delalloc_range() to return false if the found range is
  beyond @end value passed in.

  Since @end will be utilized now, add an ASSERT() to ensure we pass
  correct @end into find_lock_delalloc_range().

  This also means, for selftest we needs to populate @end before calling
  find_lock_delalloc_range().

- New ASSERT() in find_lock_delalloc_range()
  Now we will make sure the @start/@end passed in at least covers part
  of the page.

- New ASSERT() in run_delalloc_range()
  To make sure the range at least starts inside @locked page.

- Use @delalloc_start as proper cursor, while @delalloc_end is always
  reset to @page_end.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c             | 36 ++++++++++++++++++++++++--------
 fs/btrfs/inode.c                 |  7 +++++++
 fs/btrfs/tests/extent-io-tests.c | 12 +++++------
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 44df7e142fb7..ac5fb3cd9922 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1975,10 +1975,18 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 
 /*
  * Find and lock a contiguous range of bytes in the file marked as delalloc, no
- * more than @max_bytes.  @Start and @end are used to return the range,
+ * more than @max_bytes.
  *
- * Return: true if we find something
- *         false if nothing was in the tree
+ * @start:	The original start bytenr to search.
+ *		Will store the extent range start bytenr.
+ * @end:	The original end bytenr of the search range
+ *		Will store the extent range end bytenr.
+ *
+ * Return true if we find a delalloc range which starts inside the original
+ * range, and @start/@end will store the delalloc range start/end.
+ *
+ * Return false if we can't find any delalloc range which starts inside the
+ * original range, and @start/@end will be the non-delalloc range start/end.
  */
 EXPORT_FOR_TESTS
 noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
@@ -1986,6 +1994,8 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    u64 *end)
 {
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
+	const u64 orig_start = *start;
+	const u64 orig_end = *end;
 	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
 	u64 delalloc_end;
@@ -1994,15 +2004,23 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	int ret;
 	int loops = 0;
 
+	/* Caller should pass a valid @end to indicate the search range end */
+	ASSERT(orig_end > orig_start);
+
+	/* The range should at least cover part of the page */
+	ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
+		 orig_end <= page_offset(locked_page)));
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
 	delalloc_end = 0;
 	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
 					  max_bytes, &cached_state);
-	if (!found || delalloc_end <= *start) {
+	if (!found || delalloc_end <= *start || delalloc_start > orig_end) {
 		*start = delalloc_start;
-		*end = delalloc_end;
+
+		/* @delalloc_end can be -1, never go beyond @orig_end */
+		*end = min(delalloc_end, orig_end);
 		free_extent_state(cached_state);
 		return false;
 	}
@@ -3780,16 +3798,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc,
 		unsigned long *nr_written)
 {
-	u64 page_end = page_offset(page) + PAGE_SIZE - 1;
-	bool found;
+	const u64 page_end = page_offset(page) + PAGE_SIZE - 1;
 	u64 delalloc_start = page_offset(page);
 	u64 delalloc_to_write = 0;
-	u64 delalloc_end = 0;
 	int ret;
 	int page_started = 0;
 
+	while (delalloc_start < page_end) {
+		u64 delalloc_end = page_end;
+		bool found;
 
-	while (delalloc_end < page_end) {
 		found = find_lock_delalloc_range(&inode->vfs_inode, page,
 					       &delalloc_start,
 					       &delalloc_end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa5c764fd1d4..241081e2cd5a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1965,6 +1965,13 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	int ret;
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
+	/*
+	 * The range must cover part of the @locked_page, or the returned
+	 * @page_started can confuse the caller.
+	 */
+	ASSERT(!(end <= page_offset(locked_page) ||
+		 start >= page_offset(locked_page) + PAGE_SIZE));
+
 	if (should_nocow(inode, start, end)) {
 		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 73e96d505f4f..c2e72e7a8ff0 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -112,7 +112,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 */
 	set_extent_delalloc(tmp, 0, sectorsize - 1, 0, NULL);
 	start = 0;
-	end = 0;
+	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
@@ -143,7 +143,7 @@ static int test_find_delalloc(u32 sectorsize)
 	}
 	set_extent_delalloc(tmp, sectorsize, max_bytes - 1, 0, NULL);
 	start = test_start;
-	end = 0;
+	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
@@ -177,14 +177,14 @@ static int test_find_delalloc(u32 sectorsize)
 		goto out_bits;
 	}
 	start = test_start;
-	end = 0;
+	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (found) {
 		test_err("found range when we shouldn't have");
 		goto out_bits;
 	}
-	if (end != (u64)-1) {
+	if (end != test_start + PAGE_SIZE - 1) {
 		test_err("did not return the proper end offset");
 		goto out_bits;
 	}
@@ -198,7 +198,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 */
 	set_extent_delalloc(tmp, max_bytes, total_dirty - 1, 0, NULL);
 	start = test_start;
-	end = 0;
+	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
 					 &end);
 	if (!found) {
@@ -233,7 +233,7 @@ static int test_find_delalloc(u32 sectorsize)
 	/* We unlocked it in the previous test */
 	lock_page(locked_page);
 	start = test_start;
-	end = 0;
+	end = start + PAGE_SIZE - 1;
 	/*
 	 * Currently if we fail to find dirty pages in the delalloc range we
 	 * will adjust max_bytes down to PAGE_SIZE and then re-search.  If
-- 
2.32.0

