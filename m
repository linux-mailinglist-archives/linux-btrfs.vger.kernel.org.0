Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7168C2B799C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKRIxy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 03:53:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:47908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgKRIxy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 03:53:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605689632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uo+SVRPicMQyS4HCR5gkngoKafxbEVBkHafBfAFsYzk=;
        b=ujy1QW2r9RwjoeE96er0mfBOzCKa/w7EkDIeOrQl1sLpasp0gJvlXUVJQZnV4DeKE0L7/1
        CKamAEuptl02DY7nQ+k8NR/l7yqFgrHDcy3+0zL7diO+QI0x/Bc0b1MGjGAsAWxqTG/mvP
        XInXpSDDA4AKwSD0w7K7skIncVbUsnA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 424E1AD71
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 08:53:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/14] btrfs: integrate page status update for read path into begin/end_page_read()
Date:   Wed, 18 Nov 2020 16:53:18 +0800
Message-Id: <20201118085319.56668-14-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118085319.56668-1-wqu@suse.com>
References: <20201118085319.56668-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs data page read path, the page status update are handled in two
different locations:

  btrfs_do_read_page()
  {
	while (cur <= end) {
		/* No need to read from disk */
		if (HOLE/PREALLOC/INLINE){
			memset();
			set_extent_uptodate();
			continue;
		}
		/* Read from disk */
		ret = submit_extent_page(end_bio_extent_readpage);
  }

  end_bio_extent_readpage()
  {
	endio_readpage_uptodate_page_status();
  }

This is fine for sectorsize == PAGE_SIZE case, as for above loop we
should only hit one branch and then exit.

But for subpage, there are more works to be done in page status update:
- Page Unlock condition
  Unlike regular page size == sectorsize case, we can no longer just
  unlock a page.
  Only the last reader of the page can unlock the page.
  This means, we can unlock the page either in the while() loop, or in
  the endio function.

- Page uptodate condition
  Since we have multiple sectors to read for a page, we can only mark
  the full page uptodate if all sectors are uptodate.

To handle both subpage and regular cases, introduce a pair of functions
to help handling page status update:

- being_page_read()
  For regular case, it does nothing.
  For subpage case, it update the reader counters so that later
  end_page_read() can know who is the last one to unlock the page.

- end_page_read()
  This is just endio_readpage_uptodate_page_status() renamed.
  The original name is a little too long and too specific for endio.

  The only new trick added is the condition for page unlock.
  Now for subage data, we unlock the page if we're the last reader.

This does not only provide the basis for subpage data read, but also
hide the special handling of page read from the main read loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 45 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/extent_io.h |  1 +
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3d1dee27db8a..0b484df67dc3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2847,8 +2847,19 @@ endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void endio_readpage_update_page_status(struct page *page, bool uptodate,
-					      u64 start, u64 end)
+static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	if (!btrfs_is_subpage(fs_info))
+		return;
+
+	ASSERT(PagePrivate(page) && page->private);
+	subpage = (struct btrfs_subpage *)page->private;
+	atomic_set(&subpage->readers, PAGE_SIZE >> fs_info->sectorsize_bits);
+}
+
+static void end_page_read(struct page *page, bool uptodate, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	struct btrfs_subpage *subpage;
@@ -2874,7 +2885,7 @@ static void endio_readpage_update_page_status(struct page *page, bool uptodate,
 	ASSERT(PagePrivate(page) && page->private);
 	subpage = (struct btrfs_subpage *)page->private;
 	bit_start = (start - page_offset(page)) >> fs_info->sectorsize_bits;
-	nbits = fs_info->nodesize >> fs_info->sectorsize_bits;
+	nbits = (end + 1 - start) >> fs_info->sectorsize_bits;
 
 	if (!uptodate) {
 		spin_lock_bh(&subpage->lock);
@@ -2899,7 +2910,14 @@ static void endio_readpage_update_page_status(struct page *page, bool uptodate,
 		ClearPageError(page);
 	if (all_uptodate)
 		SetPageUptodate(page);
-	return;
+
+	/*
+	 * For data, we still do page unlock, but that only happens when we're
+	 * the last reader of the page.
+	 */
+	if (page->mapping->host != fs_info->btree_inode &&
+	    atomic_sub_and_test(nbits, &subpage->readers))
+		unlock_page(page);
 }
 
 /*
@@ -3029,7 +3047,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		}
 		bio_offset += len;
 
-		endio_readpage_update_page_status(page, uptodate, start, end);
+		end_page_read(page, uptodate, start, end);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
@@ -3306,6 +3324,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      unsigned int read_flags, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 start = page_offset(page);
 	const u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3349,6 +3368,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			kunmap_atomic(userpage);
 		}
 	}
+	begin_page_read(fs_info, page);
 	while (cur <= end) {
 		bool force_bio_submit = false;
 		u64 offset;
@@ -3366,13 +3386,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			end_page_read(page, true, cur, cur + iosize - 1);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR_OR_NULL(em)) {
-			SetPageError(page);
 			unlock_extent(tree, cur, end);
+			end_page_read(page, false, cur, end);
 			break;
 		}
 		extent_offset = cur - em->start;
@@ -3455,6 +3476,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			end_page_read(page, true, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3464,6 +3486,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 				   EXTENT_UPTODATE, 1, NULL)) {
 			check_page_uptodate(tree, page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, true, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3472,8 +3495,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 * to date.  Error out
 		 */
 		if (block_start == EXTENT_MAP_INLINE) {
-			SetPageError(page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, false, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3490,19 +3513,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			nr++;
 			*bio_flags = this_bio_flag;
 		} else {
-			SetPageError(page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, false, cur, cur + iosize - 1);
 			goto out;
 		}
 		cur = cur + iosize;
 		pg_offset += iosize;
 	}
 out:
-	if (!nr) {
-		if (!PageError(page))
-			SetPageUptodate(page);
-		unlock_page(page);
-	}
 	return ret;
 }
 
@@ -5456,6 +5474,7 @@ int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page)
 		return -ENOMEM;
 
 	spin_lock_init(&subpage->lock);
+	atomic_set(&subpage->readers, 0);
 	attach_page_private(page, subpage);
 	return 0;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 01ec178a1ab9..e050490056a6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -314,6 +314,7 @@ struct btrfs_subpage {
 	DECLARE_BITMAP(tree_block_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
 	DECLARE_BITMAP(uptodate_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
 	DECLARE_BITMAP(error_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE);
+	atomic_t readers;
 };
 
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
-- 
2.29.2

