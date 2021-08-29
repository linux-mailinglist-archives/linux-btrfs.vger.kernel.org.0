Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C293FA945
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhH2F0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbhH2F0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FCB621D68
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njfTHUB8zLg08la2hNUVqBTZk4x3qaVSUqwSeqAwF8c=;
        b=D16syrYA4OdnA2n5xlvW8siKy/DLw6Qnj/4JOOpYWJPe2AzCtigRrdiCYfPQlohnNeyUxj
        TdntnXwdxK0OI2uETHF2+eg9mu/L+KxPTpmXoasHQNbzAjZ/kE5yf6l3AkZ1gFLuOqotXq
        dqLcpLcmQ6Om2C3aSwrYBmQmsnNiDNY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9D78513964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KFj5FzUaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/26] btrfs: add subpage checked bitmap to make PageChecked flag to be subpage compatible
Date:   Sun, 29 Aug 2021 13:24:39 +0800
Message-Id: <20210829052458.15454-8-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although in btrfs we have very limited usage of PageChecked flag, it's
still some page flag not yet subpage compatible.

Fix it by introducing btrfs_subpage::checked_offset to do the convert.

For most call sites, especially for free-space cache, COW fixup and
btrfs_invalidatepage(), they all work in full page mode anyway.

For other call sites, they work as subpage compatible mode.

Some call sites need extra modification:

- btrfs_drop_pages()
  Needs extra parameter to get the real range we need to clear checked
  flag.

  Also since btrfs_drop_pages() will accept pages beyond the dirtied
  range, update btrfs_subpage_clamp_range() to handle such case
  by setting @len to 0 if the page is beyond target range.

- btrfs_invalidatepage()
  We need to call subpage helper before calling __btrfs_releasepage(),
  or it will trigger ASSERT() as page->private will be cleared.

- btrfs_verify_data_csum()
  In theory we don't need the io_bio->csum check anymore, but it's
  won't hurt.
  Just change the comment.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c      | 11 +++++++--
 fs/btrfs/file.c             | 20 ++++++++++++----
 fs/btrfs/free-space-cache.c |  6 ++++-
 fs/btrfs/inode.c            | 30 +++++++++++------------
 fs/btrfs/reflink.c          |  2 +-
 fs/btrfs/subpage.c          | 48 +++++++++++++++++++++++++++++++++++--
 fs/btrfs/subpage.h          |  2 ++
 7 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ad5064fe81a5..79379fa741b8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -29,6 +29,7 @@
 #include "extent_io.h"
 #include "extent_map.h"
 #include "zoned.h"
+#include "subpage.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
@@ -296,8 +297,14 @@ static void end_compressed_bio_read(struct bio *bio)
 		 * checked so the end_io handlers know about it
 		 */
 		ASSERT(!bio_flagged(bio, BIO_CLONED));
-		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all)
-			SetPageChecked(bvec->bv_page);
+		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
+			u64 bvec_start = page_offset(bvec->bv_page) +
+					 bvec->bv_offset;
+
+			btrfs_page_set_checked(btrfs_sb(cb->inode->i_sb),
+					bvec->bv_page, bvec_start,
+					bvec->bv_len);
+		}
 
 		bio_endio(cb->orig_bio);
 	}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..03986354a0cc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -437,9 +437,16 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 /*
  * unlocks pages after btrfs_file_write is done with them
  */
-static void btrfs_drop_pages(struct page **pages, size_t num_pages)
+static void btrfs_drop_pages(struct btrfs_fs_info *fs_info,
+			     struct page **pages, size_t num_pages,
+			     u64 pos, u64 copied)
 {
 	size_t i;
+	u64 block_start = round_down(pos, fs_info->sectorsize);
+	u64 block_len = round_up(pos + copied, fs_info->sectorsize) -
+			block_start;
+
+	ASSERT(block_len <= U32_MAX);
 	for (i = 0; i < num_pages; i++) {
 		/* page checked is some magic around finding pages that
 		 * have been modified without going through btrfs_set_page_dirty
@@ -447,7 +454,8 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 		 * accessed as prepare_pages should have marked them accessed
 		 * in prepare_pages via find_or_create_page()
 		 */
-		ClearPageChecked(pages[i]);
+		btrfs_page_clamp_clear_checked(fs_info, pages[i], block_start,
+					       block_len);
 		unlock_page(pages[i]);
 		put_page(pages[i]);
 	}
@@ -504,7 +512,8 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		struct page *p = pages[i];
 
 		btrfs_page_clamp_set_uptodate(fs_info, p, start_pos, num_bytes);
-		ClearPageChecked(p);
+		btrfs_page_clamp_clear_checked(fs_info, p, start_pos,
+					       num_bytes);
 		btrfs_page_clamp_set_dirty(fs_info, p, start_pos, num_bytes);
 	}
 
@@ -1845,7 +1854,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
-			btrfs_drop_pages(pages, num_pages);
+			btrfs_drop_pages(fs_info, pages, num_pages, pos,
+					 copied);
 			break;
 		}
 
@@ -1853,7 +1863,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (only_release_metadata)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
-		btrfs_drop_pages(pages, num_pages);
+		btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
 
 		cond_resched();
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d26819b1cf6..f3fee88c8ee0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -22,6 +22,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "discard.h"
+#include "subpage.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
@@ -411,7 +412,10 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
 		if (io_ctl->pages[i]) {
-			ClearPageChecked(io_ctl->pages[i]);
+			btrfs_page_clear_checked(io_ctl->fs_info,
+					io_ctl->pages[i],
+					page_offset(io_ctl->pages[i]),
+					PAGE_SIZE);
 			unlock_page(io_ctl->pages[i]);
 			put_page(io_ctl->pages[i]);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6760ec78df6b..fdcb1b0fabb8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2759,7 +2759,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		clear_page_dirty_for_io(page);
 		SetPageError(page);
 	}
-	ClearPageChecked(page);
+	btrfs_page_clear_checked(inode->root->fs_info, page,
+				 page_start, PAGE_SIZE);
 	unlock_page(page);
 	put_page(page);
 	kfree(fixup);
@@ -2814,7 +2815,7 @@ int btrfs_writepage_cow_fixup(struct page *page)
 	 * page->mapping outside of the page lock.
 	 */
 	ihold(inode);
-	SetPageChecked(page);
+	btrfs_page_set_checked(fs_info, page, page_offset(page), PAGE_SIZE);
 	get_page(page);
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
 	fixup->page = page;
@@ -3263,27 +3264,23 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 				    struct page *page, u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	const u32 sectorsize = root->fs_info->sectorsize;
 	u32 pg_off;
 	unsigned int result = 0;
 
-	if (PageChecked(page)) {
-		ClearPageChecked(page);
+	if (btrfs_page_test_checked(fs_info, page, start, end + 1 - start)) {
+		btrfs_page_clear_checked(fs_info, page, start, end + 1 - start);
 		return 0;
 	}
 
 	/*
-	 * For subpage case, above PageChecked is not safe as it's not subpage
-	 * compatible.
-	 * But for now only cow fixup and compressed read utilize PageChecked
-	 * flag, while in this context we can easily use io_bio->csum to
-	 * determine if we really need to do csum verification.
-	 *
-	 * So for now, just exit if io_bio->csum is NULL, as it means it's
-	 * compressed read, and its compressed data csum has already been
-	 * verified.
+	 * This only happens for NODATASUM or compressed read.
+	 * Normally this should be covered by above check for compressed read
+	 * or the next check for NODATASUM.
+	 * Just do a quicker exit here.
 	 */
 	if (io_bio->csum == NULL)
 		return 0;
@@ -5104,7 +5101,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 				     len);
 		flush_dcache_page(page);
 	}
-	ClearPageChecked(page);
+	btrfs_page_clear_checked(fs_info, page, block_start,
+				 block_end + 1 - block_start);
 	btrfs_page_set_dirty(fs_info, page, block_start, block_end + 1 - block_start);
 	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
 
@@ -8694,9 +8692,9 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 * did something wrong.
 	 */
 	ASSERT(!PageOrdered(page));
+	btrfs_page_clear_checked(fs_info, page, page_offset(page), PAGE_SIZE);
 	if (!inode_evicting)
 		__btrfs_releasepage(page, GFP_NOFS);
-	ClearPageChecked(page);
 	clear_page_extent_mapped(page);
 }
 
@@ -8840,7 +8838,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
 		flush_dcache_page(page);
 	}
-	ClearPageChecked(page);
+	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
 	btrfs_page_set_dirty(fs_info, page, page_start, end + 1 - page_start);
 	btrfs_page_set_uptodate(fs_info, page, page_start, end + 1 - page_start);
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index c71e49782e86..e0f93b357548 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -138,7 +138,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	}
 
 	btrfs_page_set_uptodate(fs_info, page, file_offset, block_size);
-	ClearPageChecked(page);
+	btrfs_page_clear_checked(fs_info, page, file_offset, block_size);
 	btrfs_page_set_dirty(fs_info, page, file_offset, block_size);
 out_unlock:
 	if (page) {
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 51f873a680ea..2bea6766d84e 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -88,6 +88,9 @@ void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sector
 	subpage_info->ordered_offset = cur;
 	cur += nr_bits;
 
+	subpage_info->checked_offset = cur;
+	cur += nr_bits;
+
 	subpage_info->total_nr_bits = cur;
 }
 
@@ -255,8 +258,16 @@ static void btrfs_subpage_clamp_range(struct page *page, u64 *start, u32 *len)
 	u32 orig_len = *len;
 
 	*start = max_t(u64, page_offset(page), orig_start);
-	*len = min_t(u64, page_offset(page) + PAGE_SIZE,
-		     orig_start + orig_len) - *start;
+	/*
+	 * For certain call sites like btrfs_drop_pages(), we may have pages
+	 * beyond the target range. In that case, just set @len to 0, subpage
+	 * helpers can handle @len == 0 without any problem.
+	 */
+	if (page_offset(page) >= orig_start + orig_len)
+		*len = 0;
+	else
+		*len = min_t(u64, page_offset(page) + PAGE_SIZE,
+			     orig_start + orig_len) - *start;
 }
 
 void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
@@ -532,6 +543,36 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
 		ClearPageOrdered(page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
+
+void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+							checked, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	if (subpage_test_bitmap_all_set(fs_info, subpage, checked))
+		SetPageChecked(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
+void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
+		struct page *page, u64 start, u32 len)
+{
+	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+							checked, start, len);
+	unsigned long flags;
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	ClearPageChecked(page);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
+
 /*
  * Unlike set/clear which is dependent on each page status, for test all bits
  * are tested in the same way.
@@ -557,6 +598,7 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(writeback);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(ordered);
+IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
@@ -627,6 +669,8 @@ IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
 			 PageWriteback);
 IMPLEMENT_BTRFS_PAGE_OPS(ordered, SetPageOrdered, ClearPageOrdered,
 			 PageOrdered);
+IMPLEMENT_BTRFS_PAGE_OPS(checked, SetPageChecked, ClearPageChecked,
+			 PageChecked);
 
 /*
  * Make sure not only the page dirty bit is cleared, but also subpage dirty bit
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index ac4dd64ed257..46224f959c34 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -36,6 +36,7 @@ struct btrfs_subpage_info {
 	unsigned int dirty_offset;
 	unsigned int writeback_offset;
 	unsigned int ordered_offset;
+	unsigned int checked_offset;
 };
 
 /*
@@ -142,6 +143,7 @@ DECLARE_BTRFS_SUBPAGE_OPS(error);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
 DECLARE_BTRFS_SUBPAGE_OPS(writeback);
 DECLARE_BTRFS_SUBPAGE_OPS(ordered);
+DECLARE_BTRFS_SUBPAGE_OPS(checked);
 
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len);
-- 
2.32.0

