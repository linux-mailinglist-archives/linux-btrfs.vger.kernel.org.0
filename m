Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AE38BFCE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhEUGoZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhEUGn4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:43:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpxEedIwdLwukFe+ay3XE+HAsPFU06P4A7o7WJoj5iM=;
        b=IBsW9rFMADBMKoosNLHfffsnOAb5PPJeaCaL8os4V9P6XiCYG2O2baxdSYnufyNWaWN9/L
        cYUklnIRIAt5EwdxbDTZ9H0J9WTfx8HRljYzL9ti8x+fXWOtxZk8yf6/jtb267WJ0a6MF9
        1E+gEAhsXJUPqiNknPP4oEnsgwpJoqQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AAC7AD5C
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:41:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 14/31] btrfs: make __extent_writepage_io() only submit dirty range for subpage
Date:   Fri, 21 May 2021 14:40:33 +0800
Message-Id: <20210521064050.191164-15-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

__extent_writepage_io() function originally just iterate through all the
extent maps of a page, and submit any regular extents.

This is fine for sectorsize == PAGE_SIZE case, as if a page is dirty, we
need to submit the only sector contained in the page.

But for subpage case, one dirty page can contain several clean sectors
with at least one dirty sector.

If __extent_writepage_io() still submit all regular extent maps, it can
submit data which is already written to disk.
And since such already written data won't have corresponding ordered
extents, it will trigger a BUG_ON() in btrfs_csum_one_bio().

Change the behavior of __extent_writepage_io() by finding the first
dirty byte in the page, and only submit the dirty range other than the
full extent.

Since we're also here, also modify the following calls to be subpage
compatible:
- SetPageError()
- end_page_writeback()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 100 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a635c844617c..bb5e9f73ad2b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3789,6 +3789,74 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	return 0;
 }
 
+/*
+ * To find the first byte we need to write.
+ *
+ * For subpage, one page can contain several sectors, and
+ * __extent_writepage_io() will just grab all extent maps in the page
+ * range and try to submit all non-inline/non-compressed extents.
+ *
+ * This is a big problem for subpage, we shouldn't re-submit already written
+ * data at all.
+ * This function will lookup subpage dirty bit to find which range we really
+ * need to submit.
+ *
+ * Return the next dirty range in [@start, @end).
+ * If no dirty range is found, @start will be page_offset(page) + PAGE_SIZE.
+ */
+static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
+				 struct page *page, u64 *start, u64 *end)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	u64 orig_start = *start;
+	u16 dirty_bitmap;
+	unsigned long flags;
+	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize;
+	int first_bit_set;
+	int first_bit_zero;
+
+	/*
+	 * For regular sector size == page size case, since one page only
+	 * contains one sector, we return the page offset directly.
+	 */
+	if (fs_info->sectorsize == PAGE_SIZE) {
+		*start = page_offset(page);
+		*end = page_offset(page) + PAGE_SIZE;
+		return;
+	}
+
+	/* We should have the page locked, but just in case */
+	spin_lock_irqsave(&subpage->lock, flags);
+	dirty_bitmap = subpage->dirty_bitmap;
+	spin_unlock_irqrestore(&subpage->lock, flags);
+
+	/* Set bits lower than @nbits with 0 */
+	dirty_bitmap &= ~((1 << nbits) - 1);
+
+	first_bit_set = ffs(dirty_bitmap);
+	/* No dirty range found */
+	if (first_bit_set == 0) {
+		*start = page_offset(page) + PAGE_SIZE;
+		return;
+	}
+
+	ASSERT(first_bit_set > 0 && first_bit_set <= BTRFS_SUBPAGE_BITMAP_SIZE);
+	*start = page_offset(page) + (first_bit_set - 1) * fs_info->sectorsize;
+
+	/* Set all bits lower than @nbits to 1 for ffz() */
+	dirty_bitmap |= ((1 << nbits) - 1);
+
+	first_bit_zero = ffz(dirty_bitmap);
+	if (first_bit_zero == 0 || first_bit_zero > BTRFS_SUBPAGE_BITMAP_SIZE) {
+		*end = page_offset(page) + PAGE_SIZE;
+		return;
+	}
+	ASSERT(first_bit_zero > 0 &&
+	       first_bit_zero <= BTRFS_SUBPAGE_BITMAP_SIZE);
+	*end = page_offset(page) + first_bit_zero * fs_info->sectorsize;
+	ASSERT(*end > *start);
+}
+
 /*
  * helper for __extent_writepage.  This calls the writepage start hooks,
  * and does the loop to map the page into extents and bios.
@@ -3836,6 +3904,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	while (cur <= end) {
 		u64 disk_bytenr;
 		u64 em_end;
+		u64 dirty_range_start = cur;
+		u64 dirty_range_end;
 		u32 iosize;
 
 		if (cur >= i_size) {
@@ -3843,9 +3913,17 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 							     end, 1);
 			break;
 		}
+
+		find_next_dirty_byte(fs_info, page, &dirty_range_start,
+				     &dirty_range_end);
+		if (cur < dirty_range_start) {
+			cur = dirty_range_start;
+			continue;
+		}
+
 		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
 		if (IS_ERR_OR_NULL(em)) {
-			SetPageError(page);
+			btrfs_page_set_error(fs_info, page, cur, end - cur + 1);
 			ret = PTR_ERR_OR_ZERO(em);
 			break;
 		}
@@ -3860,8 +3938,11 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		disk_bytenr = em->block_start + extent_offset;
 
-		/* Note that em_end from extent_map_end() is exclusive */
-		iosize = min(em_end, end + 1) - cur;
+		/*
+		 * Note that em_end from extent_map_end() and dirty_range_end from
+		 * find_next_dirty_byte() are all exclusive
+		 */
+		iosize = min(min(em_end, end + 1), dirty_range_end) - cur;
 
 		if (btrfs_use_zone_append(inode, em))
 			opf = REQ_OP_ZONE_APPEND;
@@ -3891,6 +3972,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
+		/*
+		 * Although the PageDirty bit is cleared before entering this
+		 * function, subpage dirty bit is not cleared.
+		 * So clear subpage dirty bit here so next time we won't
+		 * submit page for range already written to disk.
+		 */
+		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
+
 		ret = submit_extent_page(opf | write_flags, wbc,
 					 &epd->bio_ctrl, page,
 					 disk_bytenr, iosize,
@@ -3898,9 +3987,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 					 end_bio_extent_writepage,
 					 0, 0, false);
 		if (ret) {
-			SetPageError(page);
+			btrfs_page_set_error(fs_info, page, cur, iosize);
 			if (PageWriteback(page))
-				end_page_writeback(page);
+				btrfs_page_clear_writeback(fs_info, page, cur,
+							   iosize);
 		}
 
 		cur += iosize;
-- 
2.31.1

