Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8743C395775
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEaIxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhEaIxR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622451096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43PEo+gzBeP5yD9Jt0ObqVMgVbR92jMBAn/svCQBSp8=;
        b=qnRqzKbVnEzEMZVcGL+1DHgzTWNWRM3+IY33ZBuN3ZJOk2byDdPbgdCfoh8OXYeLjzOI+3
        zc8S6T4Kr+Y0278pUcIIxuBIhicDbAw5YT/tzA+H5miKrVpXINW+Frj9REeoU95fee4j2U
        yrDPF67yXUBBtqX3+KPykOb/PqGwi9o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B02DB49B
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 08:51:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 14/30] btrfs: make __extent_writepage_io() only submit dirty range for subpage
Date:   Mon, 31 May 2021 16:50:50 +0800
Message-Id: <20210531085106.259490-15-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
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
index 439aace2f5e0..1909979d41de 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3783,6 +3783,74 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -3830,6 +3898,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	while (cur <= end) {
 		u64 disk_bytenr;
 		u64 em_end;
+		u64 dirty_range_start = cur;
+		u64 dirty_range_end;
 		u32 iosize;
 
 		if (cur >= i_size) {
@@ -3837,9 +3907,17 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
@@ -3854,8 +3932,11 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		disk_bytenr = em->block_start + extent_offset;
 
-		/* Note that em_end from extent_map_end() is exclusive */
-		iosize = min(em_end, end + 1) - cur;
+		/*
+		 * Note that em_end from extent_map_end() and dirty_range_end from
+		 * find_next_dirty_byte() are all exclusive
+		 */
+		iosize = min(min(em_end, end + 1), dirty_range_end) - cur;
 
 		if (btrfs_use_zone_append(inode, em->block_start))
 			opf = REQ_OP_ZONE_APPEND;
@@ -3885,6 +3966,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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
@@ -3892,9 +3981,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
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

