Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E906B9C60
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCNQ7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCNQ7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6D8480C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F3Ldg6G7ZZxZJ1IdTC0e6dwfRrkKRcaIfLMWejjX3SQ=; b=fa3coABEPDjLa/qifjt37cTshd
        KZZjYLclRnFVGVhcdtC8+zfhHqEhkDRV1uInAYF9KhDIhqQVLHBWHWfhULFEv2sxLYtr0D3bpPIHk
        ZG8GuI8KcMc/Gw3WYxUPT1lLE+EsgqfiHZ2x2hwa+CjZ/RSwEiC2tF3U4xNOeZM7Y+/xXHfA5x84Q
        5yfy6XgBpC4nAlWPNoVqwUT8svJr6khFmT89s2kVzJ80agnUiQJtv8aj7Hs+qCpOvg6ienUJDWNwe
        7tuQtTR4lMz82KPV6ROPNp3L2n2xsrli5TV7Xzc3RfYmfVEz1defJV6tYD/w4OumQI4LpQ4jjpnu4
        pq4Zjrtg==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7zy-00AvqF-3C;
        Tue, 14 Mar 2023 16:59:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: remove irq disabling for subpage.list_lock
Date:   Tue, 14 Mar 2023 17:59:06 +0100
Message-Id: <20230314165910.373347-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Subpage state isn't modified from irq context any more, so remove
the irq disabling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   |  7 ++---
 fs/btrfs/extent_io.c | 12 ++++----
 fs/btrfs/inode.c     |  4 +--
 fs/btrfs/subpage.c   | 65 ++++++++++++++++++--------------------------
 4 files changed, 36 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 494081dda5fc66..638eed9023492e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -789,17 +789,16 @@ static bool btree_dirty_folio(struct address_space *mapping,
 
 	ASSERT(subpage->dirty_bitmap);
 	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
-		unsigned long flags;
 		u64 cur;
 		u16 tmp = (1 << cur_bit);
 
-		spin_lock_irqsave(&subpage->lock, flags);
+		spin_lock(&subpage->lock);
 		if (!(tmp & subpage->dirty_bitmap)) {
-			spin_unlock_irqrestore(&subpage->lock, flags);
+			spin_unlock(&subpage->lock);
 			cur_bit++;
 			continue;
 		}
-		spin_unlock_irqrestore(&subpage->lock, flags);
+		spin_unlock(&subpage->lock);
 		cur = page_start + cur_bit * fs_info->sectorsize;
 
 		eb = find_extent_buffer(fs_info, cur);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1221f699ffc596..b0f74c741aa7a9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1385,7 +1385,6 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage_info *spi = fs_info->subpage_info;
 	u64 orig_start = *start;
 	/* Declare as unsigned long so we can use bitmap ops */
-	unsigned long flags;
 	int range_start_bit;
 	int range_end_bit;
 
@@ -1403,10 +1402,10 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 			  (offset_in_page(orig_start) >> fs_info->sectorsize_bits);
 
 	/* We should have the page locked, but just in case */
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end_bit,
 			       spi->dirty_offset + spi->bitmap_nr_bits);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 
 	range_start_bit -= spi->dirty_offset;
 	range_end_bit -= spi->dirty_offset;
@@ -2080,7 +2079,6 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
 		struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 		struct extent_buffer *eb;
-		unsigned long flags;
 		u64 start;
 
 		/*
@@ -2092,10 +2090,10 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 			spin_unlock(&page->mapping->private_lock);
 			break;
 		}
-		spin_lock_irqsave(&subpage->lock, flags);
+		spin_lock(&subpage->lock);
 		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
 			      subpage->bitmaps)) {
-			spin_unlock_irqrestore(&subpage->lock, flags);
+			spin_unlock(&subpage->lock);
 			spin_unlock(&page->mapping->private_lock);
 			bit_start++;
 			continue;
@@ -2109,7 +2107,7 @@ static int submit_eb_subpage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
 		 * spin locks, so call find_extent_buffer_nolock().
 		 */
 		eb = find_extent_buffer_nolock(fs_info, start);
-		spin_unlock_irqrestore(&subpage->lock, flags);
+		spin_unlock(&subpage->lock);
 		spin_unlock(&page->mapping->private_lock);
 
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 33f0ec14703a3d..cccaab4aa9cd91 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7900,8 +7900,8 @@ static void wait_subpage_spinlock(struct page *page)
 	 * Here we just acquire the spinlock so that all existing callers
 	 * should exit and we're safe to release/invalidate the page.
 	 */
-	spin_lock_irq(&subpage->lock);
-	spin_unlock_irq(&subpage->lock);
+	spin_lock(&subpage->lock);
+	spin_unlock(&subpage->lock);
 }
 
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index dd46b978ac2cfc..3a47aeed419503 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -415,13 +415,12 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							uptodate, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, subpage, uptodate))
 		SetPageUptodate(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
@@ -430,12 +429,11 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							uptodate, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	ClearPageUptodate(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_set_error(const struct btrfs_fs_info *fs_info,
@@ -444,12 +442,11 @@ void btrfs_subpage_set_error(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							error, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	SetPageError(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_clear_error(const struct btrfs_fs_info *fs_info,
@@ -458,13 +455,12 @@ void btrfs_subpage_clear_error(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							error, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, error))
 		ClearPageError(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
@@ -473,11 +469,10 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							dirty, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 	set_page_dirty(page);
 }
 
@@ -497,14 +492,13 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							dirty, start, len);
-	unsigned long flags;
 	bool last = false;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, dirty))
 		last = true;
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 	return last;
 }
 
@@ -524,12 +518,11 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							writeback, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	set_page_writeback(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
@@ -538,15 +531,14 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							writeback, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, writeback)) {
 		ASSERT(PageWriteback(page));
 		end_page_writeback(page);
 	}
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
@@ -555,12 +547,11 @@ void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							ordered, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	SetPageOrdered(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
@@ -569,13 +560,12 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							ordered, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, ordered))
 		ClearPageOrdered(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
@@ -584,13 +574,12 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							checked, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, subpage, checked))
 		SetPageChecked(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
@@ -599,12 +588,11 @@ void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
 							checked, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&subpage->lock, flags);
+	spin_lock(&subpage->lock);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	ClearPageChecked(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
+	spin_unlock(&subpage->lock);
 }
 
 /*
@@ -618,13 +606,12 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private; \
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,	\
 						name, start, len);	\
-	unsigned long flags;						\
 	bool ret;							\
 									\
-	spin_lock_irqsave(&subpage->lock, flags);			\
+	spin_lock(&subpage->lock);					\
 	ret = bitmap_test_range_all_set(subpage->bitmaps, start_bit,	\
 				len >> fs_info->sectorsize_bits);	\
-	spin_unlock_irqrestore(&subpage->lock, flags);			\
+	spin_unlock(&subpage->lock);					\
 	return ret;							\
 }
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
-- 
2.39.2

