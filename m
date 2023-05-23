Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559470D6FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjEWIQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjEWIPi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C610CB
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ym/X4IBTOCkWhaX4HEgReWoCdFBnxHnxm66YSKoUFIk=; b=dWNUGrS6nKFmsP8LC8WC3vZBKO
        j99VuKCnseoiwHu187Zj5NT1UZtctX9qdpRaWX1L+qnvowWXXcUJSUv7rH6m8gXELbFXXLA3LR/2q
        xsHDI9EU676CnMuJ7tPewF5wDibd4NDXc5O7ygVnLSt/ILY4ExQpS8RyWL8quEoSVQE/7wjtk5jh0
        790J5KQZn8HB1r5PlZ5W/SiEd9gpYjxbJnBzAuEg9gJRnWvkNxWtsGOLxFCT/fgNX7Aw2I0aWLYkq
        /CGko+HcpqDhDagoukHI9L3+zD3MUhO86BtGx+Fv0sWFAIm2Z9t9ilE1QUaLmupF8PYNQIJRsRkDa
        r0Y0koBg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9P-009OVl-26;
        Tue, 23 May 2023 08:13:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs: stop setting PageError in the data I/O path
Date:   Tue, 23 May 2023 10:13:14 +0200
Message-Id: <20230523081322.331337-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PageError is not used by the VFS/MM and deprecated.  Btrfs now only sets
the flag and never clears it for data pages, so just remove all places
setting it, and the subpage error bit.

Note that the error propagation for superblock writes still uses
PageError for now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 24 +++++-------------------
 fs/btrfs/inode.c     |  3 ---
 fs/btrfs/subpage.c   | 34 ----------------------------------
 fs/btrfs/subpage.h   | 10 ++++------
 4 files changed, 9 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d7b31888efa17a..28610ed0fae913 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -223,8 +223,6 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 
 	if (page_ops & PAGE_SET_ORDERED)
 		btrfs_page_clamp_set_ordered(fs_info, page, start, len);
-	if (page_ops & PAGE_SET_ERROR)
-		btrfs_page_clamp_set_error(fs_info, page, start, len);
 	if (page_ops & PAGE_START_WRITEBACK) {
 		btrfs_page_clamp_clear_dirty(fs_info, page, start, len);
 		btrfs_page_clamp_set_writeback(fs_info, page, start, len);
@@ -497,12 +495,10 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
-	if (uptodate && btrfs_verify_page(page, start)) {
+	if (uptodate && btrfs_verify_page(page, start))
 		btrfs_page_set_uptodate(fs_info, page, start, len);
-	} else {
+	else
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
-		btrfs_page_set_error(fs_info, page, start, len);
-	}
 
 	if (!btrfs_is_subpage(fs_info, page))
 		unlock_page(page);
@@ -530,7 +526,6 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 		len = end + 1 - start;
 
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
-		btrfs_page_set_error(fs_info, page, start, len);
 		ret = err < 0 ? err : -EIO;
 		mapping_set_error(page->mapping, ret);
 	}
@@ -1059,7 +1054,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	ret = set_page_extent_mapped(page);
 	if (ret < 0) {
 		unlock_extent(tree, start, end, NULL);
-		btrfs_page_set_error(fs_info, page, start, PAGE_SIZE);
 		unlock_page(page);
 		return ret;
 	}
@@ -1263,11 +1257,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		}
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
 				delalloc_end, &page_started, &nr_written, wbc);
-		if (ret) {
-			btrfs_page_set_error(inode->root->fs_info, page,
-					     page_offset(page), PAGE_SIZE);
+		if (ret)
 			return ret;
-		}
+
 		/*
 		 * delalloc_end is already one less than the total length, so
 		 * we don't subtract one from PAGE_SIZE
@@ -1420,7 +1412,6 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
 		if (IS_ERR(em)) {
-			btrfs_page_set_error(fs_info, page, cur, end - cur + 1);
 			ret = PTR_ERR_OR_ZERO(em);
 			goto out_error;
 		}
@@ -1519,9 +1510,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 
 	WARN_ON(!PageLocked(page));
 
-	btrfs_page_clear_error(btrfs_sb(inode->i_sb), page,
-			       page_offset(page), PAGE_SIZE);
-
 	pg_offset = offset_in_page(i_size);
 	if (page->index > end_index ||
 	   (page->index == end_index && !pg_offset)) {
@@ -1534,10 +1522,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 		memzero_page(page, pg_offset, PAGE_SIZE - pg_offset);
 
 	ret = set_page_extent_mapped(page);
-	if (ret < 0) {
-		SetPageError(page);
+	if (ret < 0)
 		goto done;
-	}
 
 	if (!bio_ctrl->extent_locked) {
 		ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4d4ac0428ee74..35b99fde75abb1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1153,8 +1153,6 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 			const u64 page_start = page_offset(locked_page);
 			const u64 page_end = page_start + PAGE_SIZE - 1;
 
-			btrfs_page_set_error(inode->root->fs_info, locked_page,
-					     page_start, PAGE_SIZE);
 			set_page_writeback(locked_page);
 			end_page_writeback(locked_page);
 			end_extent_writepage(locked_page, ret, page_start, page_end);
@@ -3028,7 +3026,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		mapping_set_error(page->mapping, ret);
 		end_extent_writepage(page, ret, page_start, page_end);
 		clear_page_dirty_for_io(page);
-		SetPageError(page);
 	}
 	btrfs_page_clear_checked(inode->root->fs_info, page, page_start, PAGE_SIZE);
 	unlock_page(page);
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 045117ca0ddc43..9e9a5e26a15736 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -100,9 +100,6 @@ void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sector
 	subpage_info->uptodate_offset = cur;
 	cur += nr_bits;
 
-	subpage_info->error_offset = cur;
-	cur += nr_bits;
-
 	subpage_info->dirty_offset = cur;
 	cur += nr_bits;
 
@@ -416,35 +413,6 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-void btrfs_subpage_set_error(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
-							error, start, len);
-	unsigned long flags;
-
-	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	SetPageError(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
-void btrfs_subpage_clear_error(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
-							error, start, len);
-	unsigned long flags;
-
-	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_zero(fs_info, subpage, error))
-		ClearPageError(page);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
 void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len)
 {
@@ -606,7 +574,6 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 	return ret;							\
 }
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
-IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(writeback);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(ordered);
@@ -674,7 +641,6 @@ bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
 			 PageUptodate);
-IMPLEMENT_BTRFS_PAGE_OPS(error, SetPageError, ClearPageError, PageError);
 IMPLEMENT_BTRFS_PAGE_OPS(dirty, set_page_dirty, clear_page_dirty_for_io,
 			 PageDirty);
 IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 0e80ad33690466..998c1b78066e53 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -8,17 +8,17 @@
 /*
  * Extra info for subpapge bitmap.
  *
- * For subpage we pack all uptodate/error/dirty/writeback/ordered bitmaps into
+ * For subpage we pack all uptodate/dirty/writeback/ordered bitmaps into
  * one larger bitmap.
  *
  * This structure records how they are organized in the bitmap:
  *
- * /- uptodate_offset	/- error_offset	/- dirty_offset
+ * /- uptodate_offset	/- dirty_offset	/- ordered_offset
  * |			|		|
  * v			v		v
- * |u|u|u|u|........|u|u|e|e|.......|e|e| ...	|o|o|
+ * |u|u|u|u|........|u|u|d|d|.......|d|d|o|o|.......|o|o|
  * |<- bitmap_nr_bits ->|
- * |<--------------- total_nr_bits ---------------->|
+ * |<----------------- total_nr_bits ------------------>|
  */
 struct btrfs_subpage_info {
 	/* Number of bits for each bitmap */
@@ -32,7 +32,6 @@ struct btrfs_subpage_info {
 	 * @bitmap_size, which is calculated from PAGE_SIZE / sectorsize.
 	 */
 	unsigned int uptodate_offset;
-	unsigned int error_offset;
 	unsigned int dirty_offset;
 	unsigned int writeback_offset;
 	unsigned int ordered_offset;
@@ -141,7 +140,6 @@ bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len);
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
-DECLARE_BTRFS_SUBPAGE_OPS(error);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
 DECLARE_BTRFS_SUBPAGE_OPS(writeback);
 DECLARE_BTRFS_SUBPAGE_OPS(ordered);
-- 
2.39.2

