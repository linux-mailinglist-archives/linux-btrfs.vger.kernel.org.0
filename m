Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8B2EB76F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbhAFBE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:04:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbhAFBE2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:04:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJxvfc9dmPdFAHwzNHSHXJCyqfb6mNorzuBl/Zm6Da8=;
        b=qYu40MgurT+gSV+oProw/ZG7T6Rgu7AhmCCv6lTBhkjsARwuU1JAAHzUPPZQYoqAxWmkTe
        i/6vhjEE6GHQwJjun47HalfRcmwPCSaZDmslJKRSHBxa+FZt7SL1g8aM0jVi9Ni4cvmc1n
        crjq94yhlXsdHnq3m+SqFRlvrfZPQ8A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C8D3AF8F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 21/22] btrfs: integrate page status update for read path into begin/end_page_read()
Date:   Wed,  6 Jan 2021 09:02:00 +0800
Message-Id: <20210106010201.37864-22-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
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
 fs/btrfs/extent_io.c | 38 +++++++++++++++++++----------
 fs/btrfs/subpage.h   | 57 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 335a0aa3a6ec..dfbf319fc01d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2839,8 +2839,17 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void endio_readpage_update_page_status(struct page *page, bool uptodate,
-					      u64 start, u32 len)
+static void begin_data_page_read(struct btrfs_fs_info *fs_info, struct page *page)
+{
+	ASSERT(PageLocked(page));
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page));
+	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
+}
+
+static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 
@@ -2856,7 +2865,12 @@ static void endio_readpage_update_page_status(struct page *page, bool uptodate,
 
 	if (fs_info->sectorsize == PAGE_SIZE)
 		unlock_page(page);
-	/* Subpage locking will be handled in later patches */
+	else if (is_data_inode(page->mapping->host))
+		/*
+		 * For subpage data, unlock the page if we're the last reader.
+		 * For subpage metadata, page lock is not utilized for read.
+		 */
+		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
 /*
@@ -2993,7 +3007,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		bio_offset += len;
 
 		/* Update page status and unlock */
-		endio_readpage_update_page_status(page, uptodate, start, len);
+		end_page_read(page, uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
@@ -3260,6 +3274,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      unsigned int read_flags, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 start = page_offset(page);
 	const u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3303,6 +3318,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			kunmap_atomic(userpage);
 		}
 	}
+	begin_data_page_read(fs_info, page);
 	while (cur <= end) {
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
@@ -3320,13 +3336,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			end_page_read(page, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR_OR_NULL(em)) {
-			SetPageError(page);
 			unlock_extent(tree, cur, end);
+			end_page_read(page, false, cur, end + 1 - cur);
 			break;
 		}
 		extent_offset = cur - em->start;
@@ -3409,6 +3426,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3418,6 +3436,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 				   EXTENT_UPTODATE, 1, NULL)) {
 			check_page_uptodate(tree, page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3426,8 +3445,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 * to date.  Error out
 		 */
 		if (block_start == EXTENT_MAP_INLINE) {
-			SetPageError(page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, false, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3444,19 +3463,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			nr++;
 			*bio_flags = this_bio_flag;
 		} else {
-			SetPageError(page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, false, cur, iosize);
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
 
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 25f6d0cd1a1e..5c4b5d2fd308 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -31,28 +31,22 @@ struct btrfs_subpage {
 			u16 tree_block_bitmap;
 		};
 		/* structures only used by data */
+		struct {
+			atomic_t readers;
+		};
 	};
 };
 
 int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
 
-/*
- * Convert the [start, start + len) range into a u16 bitmap
- *
- * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
- */
-static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
-			struct page *page, u64 start, u32 len)
+static inline void btrfs_subpage_assert(struct btrfs_fs_info *fs_info,
+					struct page *page, u64 start, u32 len)
 {
-	int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
-	int nbits = len >> fs_info->sectorsize_bits;
-
 	/* Basic checks */
 	ASSERT(PagePrivate(page) && page->private);
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
-
 	/*
 	 * The range check only works for mapped page, we can
 	 * still have unampped page like dummy extent buffer pages.
@@ -60,6 +54,21 @@ static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
 	if (page->mapping)
 		ASSERT(page_offset(page) <= start &&
 			start + len <= page_offset(page) + PAGE_SIZE);
+}
+
+/*
+ * Convert the [start, start + len) range into a u16 bitmap
+ *
+ * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
+ */
+static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
+			struct page *page, u64 start, u32 len)
+{
+	int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
+	int nbits = len >> fs_info->sectorsize_bits;
+
+	btrfs_subpage_assert(fs_info, page, start, len);
+
 	/*
 	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
 	 * first left shift to be calculated in unsigned long (u32), then
@@ -68,6 +77,32 @@ static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
 	return (u16)(((1UL << nbits) - 1) << bit_start);
 }
 
+static inline void btrfs_subpage_start_reader(struct btrfs_fs_info *fs_info,
+					      struct page *page, u64 start,
+					      u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	int nbits = len >> fs_info->sectorsize_bits;
+	int ret;
+
+	btrfs_subpage_assert(fs_info, page, start, len);
+
+	ret = atomic_add_return(nbits, &subpage->readers);
+	ASSERT(ret == nbits);
+}
+
+static inline void btrfs_subpage_end_reader(struct btrfs_fs_info *fs_info,
+			struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	int nbits = len >> fs_info->sectorsize_bits;
+
+	btrfs_subpage_assert(fs_info, page, start, len);
+	ASSERT(atomic_read(&subpage->readers) >= nbits);
+	if (atomic_sub_and_test(nbits, &subpage->readers))
+		unlock_page(page);
+}
+
 static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *fs_info,
 			struct page *page, u64 start, u32 len)
 {
-- 
2.29.2

