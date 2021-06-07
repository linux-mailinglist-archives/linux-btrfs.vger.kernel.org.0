Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCA39D837
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFGJE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 05:04:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhFGJEy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 05:04:54 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74DD321A85;
        Mon,  7 Jun 2021 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623056582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1uo1AMGyrdadvU+yF7c7A7uXdbniv0bvskX5VkYSrZA=;
        b=s+iMJGDKF97wkDkP1RO1mijPLnrXSwC7SefNScBDeFJsZU+5s0gW6qlXQCam2sURVw8kxQ
        m7F94jeU9w032jIsdX83vVkzKDIQ7OFhpsLjI5vMIP44BuYUiNR3aFAxDz2vixqqdIACRL
        Mn0RWLl6Ks3/9l/LfyMMmjYqfcqrJdw=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id E28DEA3B84;
        Mon,  7 Jun 2021 09:03:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, Qu Wegruo <wqu@suse.com>
Subject: [PATCH] btrfs: fix a rare race between metadata endio and eb freeing
Date:   Mon,  7 Jun 2021 17:02:58 +0800
Message-Id: <20210607090258.253660-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a very rare ASSERT() triggering during full fstests run for
subpage rw support.

No extra reproduce so far.

The ASSERT() get triggered for metadata read in
btrfs_page_set_uptodate() inside end_page_read().

[CAUSE]
There is still a small race window for metadata only, the race could
happen like this:

                T1                  |              T2
------------------------------------+-----------------------------
end_bio_extent_readpage()           |
|- btrfs_validate_metadata_buffer() |
|  |- free_extent_buffer()          |
|     Still have 2 refs             |
|- end_page_read()                  |
   |- if (unlikely(PagePrivate())   |
   |  The page still has Private    |
   |                                | free_extent_buffer()
   |                                | |  Only one ref 1, will be
   |                                | |  released
   |                                | |- detach_extent_buffer_page()
   |                                |    |- btrfs_detach_subpage()
   |- btrfs_set_page_uptodate()     |
      The page no longer has Private|
      >>> ASSERT() triggered <<<    |

This race window is super small, thus pretty hard to hit, even with so
many runs of fstests.

But the race window is still there, we have to go another way to solve
it other than replying on random PagePrivate() check.

Data path is not affected, as data path will lock the page before read,
while unlock the page after the last read has finished, thus no race
window.

[FIX]
This patch will fix the bug by re-purpose btrfs_subpage::readers.

Now btrfs_subpage::readers will be a member shared by both metadata and
data.

For metadata path, we don't do the page unlock as metadata only relies on
extent locking.

At the same time, teach page_range_has_eb() to take into
btrfs_subpage::readers into consideration.

So that even if the last eb of a page get freed, page::private won't be
detached as long as there is still pending end_page_read() calls.

By this we eliminate the race window, this will slight increase the
metadata memory usage, as the page may not be released as frequently as
usual.
But it should not be a big deal.

Fixes: ***SPACEHOLDER**** ("btrfs: submit read time repair only for each corrupted sector")
Signed-off-by: Qu Wegruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 30 +++++++++---------------------
 fs/btrfs/subpage.c   | 19 +++++++++++++++----
 fs/btrfs/subpage.h   |  9 ++++++++-
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 77b59ca93419..2d3df12a2471 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2689,21 +2689,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
-	/*
-	 * For subapge metadata case, all btrfs_page_* helpers need page to
-	 * have page::private populated.
-	 * But we can have rare case where the last eb in the page is only
-	 * referred by the IO, and it gets released immediately after it's
-	 * read and verified.
-	 *
-	 * This can detach the page private completely.
-	 * In that case, we can just skip the page status update completely,
-	 * as the page has no eb anymore.
-	 */
-	if (fs_info->sectorsize < PAGE_SIZE && unlikely(!PagePrivate(page))) {
-		ASSERT(!is_data_inode(page->mapping->host));
-		return;
-	}
 	if (uptodate) {
 		btrfs_page_set_uptodate(fs_info, page, start, len);
 	} else {
@@ -2713,11 +2698,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 
 	if (fs_info->sectorsize == PAGE_SIZE)
 		unlock_page(page);
-	else if (is_data_inode(page->mapping->host))
-		/*
-		 * For subpage data, unlock the page if we're the last reader.
-		 * For subpage metadata, page lock is not utilized for read.
-		 */
+	else
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
@@ -5694,6 +5675,12 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
 		subpage = (struct btrfs_subpage *)page->private;
 		if (atomic_read(&subpage->eb_refs))
 			return true;
+		/*
+		 * Even there is no eb refs here, we may still have
+		 * end_page_read() call relying on page::private.
+		 */
+		if (atomic_read(&subpage->readers))
+			return true;
 	}
 	return false;
 }
@@ -5754,7 +5741,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 
 	/*
 	 * We can only detach the page private if there are no other ebs in the
-	 * page range.
+	 * page range and no unfinished IO.
 	 */
 	if (!page_range_has_eb(fs_info, page))
 		btrfs_detach_subpage(fs_info, page);
@@ -6472,6 +6459,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	check_buffer_tree_ref(eb);
 	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 
+	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(REQ_OP_READ | REQ_META, NULL, &bio_ctrl,
 				 page, eb->start, eb->len,
 				 eb->start - page_offset(page),
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 552410fba0bd..f8ebd1cfb025 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include "ctree.h"
 #include "subpage.h"
+#include "btrfs_inode.h"
 
 /*
  * Subpage (sectorsize < PAGE_SIZE) support overview:
@@ -185,12 +186,10 @@ void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	const int nbits = len >> fs_info->sectorsize_bits;
-	int ret;
 
 	btrfs_subpage_assert(fs_info, page, start, len);
 
-	ret = atomic_add_return(nbits, &subpage->readers);
-	ASSERT(ret == nbits);
+	atomic_add(nbits, &subpage->readers);
 }
 
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
@@ -198,10 +197,22 @@ void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	const int nbits = len >> fs_info->sectorsize_bits;
+	bool is_data;
+	bool last;
 
 	btrfs_subpage_assert(fs_info, page, start, len);
+	is_data = is_data_inode(page->mapping->host);
 	ASSERT(atomic_read(&subpage->readers) >= nbits);
-	if (atomic_sub_and_test(nbits, &subpage->readers))
+	last = atomic_sub_and_test(nbits, &subpage->readers);
+
+	/*
+	 * For data we need to unlock the page if the last read has finished.
+	 *
+	 * And please don't replace @last with atomic_sub_and_test() call
+	 * inside if () condition.
+	 * As we want the atomic_sub_and_test() to be always executed.
+	 */
+	if (is_data && last)
 		unlock_page(page);
 }
 
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 7188e9d2fbea..c122a54c2ddb 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -22,6 +22,14 @@ struct btrfs_subpage {
 	u16 error_bitmap;
 	u16 dirty_bitmap;
 	u16 writeback_bitmap;
+	/*
+	 * Both data and metadata needs to trace how many readers are for the
+	 * page.
+	 * Data relies on @readers to unlock the page when last reader finished.
+	 * While metadata doesn't need page unlock, it needs to prevent
+	 * page::private get cleared before the last end_page_read().
+	 */
+	atomic_t readers;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -32,7 +40,6 @@ struct btrfs_subpage {
 		atomic_t eb_refs;
 		/* Structures only used by data */
 		struct {
-			atomic_t readers;
 			atomic_t writers;
 
 			/* If a sector has pending ordered extent */
-- 
2.31.1

