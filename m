Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8232D5416
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgLJGlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 01:41:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:44728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgLJGla (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 01:41:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607582382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GALDEq99Z8S+mHFMraFZOk/xU7D2UbhDTLXmSzVvz44=;
        b=V7A67/TW3ko7xe5EmHNplIAakkXmnE3ZLxODAMZXR8kS9tWWVHcDCnpyO8m+Ef5ZCuYbuI
        iDOHauEK/sD9VlwiDHTEH2QnSp+LoKcJwKL5TcxqTQwqpSRKub5Ee5WbYhE5mIiDH24V6K
        bSlXlOeuN4sQzyZ8c9+v8QKgaWEZVDU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AA4BAD9F
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 06:39:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/18] btrfs: integrate page status update for read path into begin/end_page_read()
Date:   Thu, 10 Dec 2020 14:39:04 +0800
Message-Id: <20201210063905.75727-18-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210063905.75727-1-wqu@suse.com>
References: <20201210063905.75727-1-wqu@suse.com>
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
 fs/btrfs/extent_io.c | 39 +++++++++++++++++++++++++-----------
 fs/btrfs/subpage.h   | 47 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e4ed9c453ae..56174e7f0ae8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2841,8 +2841,18 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void endio_readpage_update_page_status(struct page *page, bool uptodate,
-					      u64 start, u64 end)
+static void begin_data_page_read(struct btrfs_fs_info *fs_info, struct page *page)
+{
+	ASSERT(PageLocked(page));
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return;
+
+	ASSERT(PagePrivate(page) && page->private);
+	ASSERT(page->mapping->host != fs_info->btree_inode);
+	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
+}
+
+static void end_page_read(struct page *page, bool uptodate, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	u32 len;
@@ -2860,7 +2870,12 @@ static void endio_readpage_update_page_status(struct page *page, bool uptodate,
 
 	if (fs_info->sectorsize == PAGE_SIZE)
 		unlock_page(page);
-	/* Subpage locking will be handled in later patches */
+	else if (page->mapping->host != fs_info->btree_inode)
+		/*
+		 * For subpage data, unlock the page if we're the last reader.
+		 * For subpage metadata, page lock is not utilized for read.
+		 */
+		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
 /*
@@ -2997,7 +3012,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		bio_offset += len;
 
 		/* Update page status and unlock */
-		endio_readpage_update_page_status(page, uptodate, start, end);
+		end_page_read(page, uptodate, start, end);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
@@ -3265,6 +3280,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      unsigned int read_flags, u64 *prev_em_start)
 {
 	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 start = page_offset(page);
 	const u64 end = start + PAGE_SIZE - 1;
 	u64 cur = start;
@@ -3308,6 +3324,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			kunmap_atomic(userpage);
 		}
 	}
+	begin_data_page_read(fs_info, page);
 	while (cur <= end) {
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
@@ -3325,13 +3342,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
@@ -3414,6 +3432,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
+			end_page_read(page, true, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3423,6 +3442,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 				   EXTENT_UPTODATE, 1, NULL)) {
 			check_page_uptodate(tree, page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, true, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3431,8 +3451,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 * to date.  Error out
 		 */
 		if (block_start == EXTENT_MAP_INLINE) {
-			SetPageError(page);
 			unlock_extent(tree, cur, cur + iosize - 1);
+			end_page_read(page, false, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3449,19 +3469,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
 
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 8592234d773e..6c801ef00d2d 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -31,6 +31,9 @@ struct btrfs_subpage {
 			u16 tree_block_bitmap;
 		};
 		/* structures only used by data */
+		struct {
+			atomic_t readers;
+		};
 	};
 };
 
@@ -48,6 +51,17 @@ static inline void btrfs_subpage_clamp_range(struct page *page,
 		     orig_start + orig_len) - *start;
 }
 
+static inline void btrfs_subpage_assert(struct btrfs_fs_info *fs_info,
+					struct page *page, u64 start, u32 len)
+{
+	/* Basic checks */
+	ASSERT(PagePrivate(page) && page->private);
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
+	ASSERT(page_offset(page) <= start &&
+	       start + len <= page_offset(page) + PAGE_SIZE);
+}
+
 /*
  * Convert the [start, start + len) range into a u16 bitmap
  *
@@ -59,12 +73,8 @@ static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
 	int bit_start = (start - page_offset(page)) >> fs_info->sectorsize_bits;
 	int nbits = len >> fs_info->sectorsize_bits;
 
-	/* Basic checks */
-	ASSERT(PagePrivate(page) && page->private);
-	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(len, fs_info->sectorsize));
-	ASSERT(page_offset(page) <= start &&
-	       start + len <= page_offset(page) + PAGE_SIZE);
+	btrfs_subpage_assert(fs_info, page, start, len);
+
 	/*
 	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
 	 * first left shift to be calculated in unsigned long (u32), then
@@ -73,6 +83,31 @@ static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
 	return (u16)(((1UL << nbits) - 1) << bit_start);
 }
 
+static inline void btrfs_subpage_start_reader(struct btrfs_fs_info *fs_info,
+					      struct page *page, u64 start,
+					      u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	int nbits = len >> fs_info->sectorsize_bits;
+
+	btrfs_subpage_assert(fs_info, page, start, len);
+
+	ASSERT(atomic_read(&subpage->readers) == 0);
+	atomic_set(&subpage->readers, nbits);
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

