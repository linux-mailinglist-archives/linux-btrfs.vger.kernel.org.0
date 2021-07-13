Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C793C6A54
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhGMGSa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36756 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhGMGSa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C87A9221FB
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHtZLg6H5j3jB1na8MdQGajfVVBvYUJ3WpanM3ueKNc=;
        b=MTjhHZrTuU8OKg+HL1NZMO1nwd2u8wOne0utswHU4Bf95o3NdeqQ1JbsfX6AL4sry9sxod
        OuDqlnpbfUvfRfpCKsG/4tNhLeRlE4o8Omsqv7rF5T5U5ZKZeBG96dkixHtjx9LzDi0Aer
        ARCEWiNQEEBbGDqJtIx9r1K7Wdk7hRo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 12191139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iGqBMYov7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/27] btrfs: cleanup for extent_write_locked_range()
Date:   Tue, 13 Jul 2021 14:15:05 +0800
Message-Id: <20210713061516.163318-17-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several cleanups for extent_write_locked_range(), most of them
are pure cleanups, but with some preparation for future subpage support.

- Add a proper comment for which call sites are suitable
  Unlike regular synchronized extent write back, if async cow or zoned
  cow happens, we have all pages in the range still locked.

  Thus for those (only) two call sites, we need this function to submit
  page content into bios and submit them.

- Remove @mode parameter
  All the existing two call sites pass WB_SYNC_ALL. No need for @mode
  parameter.

- Better error handling
  Currently if we hit an error during the page iteration loop, we
  overwrite @ret, causing only the last error can be recorded.

  Here we add @found_error and @first_error variable to record if we hit
  any error, and the first error we hit.
  So the first error won't get lost.

- Don't reuse @start as the cursor
  We reuse the parameter @start as the cursor to iterate the range, not
  a big problem, but since we're here, introduce a proper @cur as the
  cursor.

- Remove impossible branch
  Since all pages are still locked after the ordered extent is inserted,
  there is no way that pages can get its dirty bit cleared.
  Remove the branch where page is not dirty and replace it with an
  ASSERT().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++++++++----------------
 fs/btrfs/extent_io.h |  3 +--
 fs/btrfs/inode.c     |  4 ++--
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ad15a092574..583cfc89f2af 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5045,23 +5045,29 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 	return ret;
 }
 
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			      int mode)
+/*
+ * Submit the pages in the range to bio for call sites which delalloc range
+ * has already be ran (aka, ordered extent inserted) and all pages are still
+ * locked.
+ */
+int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 {
+	bool found_error = false;
+	int first_error = 0;
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
+	u64 cur = start;
 	unsigned long nr_pages = (end - start + PAGE_SIZE) >>
 		PAGE_SHIFT;
-
 	struct extent_page_data epd = {
 		.bio_ctrl = { 0 },
 		.extent_locked = 1,
-		.sync_io = mode == WB_SYNC_ALL,
+		.sync_io = 1,
 	};
 	struct writeback_control wbc_writepages = {
-		.sync_mode	= mode,
 		.nr_to_write	= nr_pages * 2,
+		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
 		.range_end	= end + 1,
 		/* We're called from an async helper function */
@@ -5070,26 +5076,33 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 	};
 
 	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
-	while (start <= end) {
-		page = find_get_page(mapping, start >> PAGE_SHIFT);
-		if (clear_page_dirty_for_io(page))
-			ret = __extent_writepage(page, &wbc_writepages, &epd);
-		else {
-			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
-					page, start, start + PAGE_SIZE - 1, 1);
-			unlock_page(page);
+	while (cur <= end) {
+		page = find_get_page(mapping, cur >> PAGE_SHIFT);
+		/*
+		 * All pages in the range are locked since
+		 * btrfs_run_delalloc_range(), thus there is no way to clear
+		 * the page dirty flag.
+		 */
+		ASSERT(PageDirty(page));
+		clear_page_dirty_for_io(page);
+		ret = __extent_writepage(page, &wbc_writepages, &epd);
+		ASSERT(ret <= 0);
+		if (ret < 0) {
+			found_error = true;
+			first_error = ret;
 		}
 		put_page(page);
-		start += PAGE_SIZE;
+		cur += PAGE_SIZE;
 	}
 
-	ASSERT(ret <= 0);
-	if (ret == 0)
+	if (!found_error)
 		ret = flush_write_bio(&epd);
 	else
 		end_write_bio(&epd, ret);
 
 	wbc_detach_inode(&wbc_writepages);
+	if (found_error)
+		return first_error;
 	return ret;
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..3f7f83a91976 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -183,8 +183,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      struct btrfs_bio_ctrl *bio_ctrl,
 		      unsigned int read_flags, u64 *prev_em_start);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			      int mode);
+int extent_write_locked_range(struct inode *inode, u64 start, u64 end);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7931c4a5bc5d..94449a6da16b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -873,7 +873,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 		 */
 		if (!page_started && !ret)
 			extent_write_locked_range(&inode->vfs_inode, start,
-						  end, WB_SYNC_ALL);
+						  end);
 		else if (ret && async_chunk->locked_page)
 			unlock_page(async_chunk->locked_page);
 		kfree(async_extent);
@@ -1460,7 +1460,7 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 
 	__set_page_dirty_nobuffers(locked_page);
 	account_page_redirty(locked_page);
-	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
+	extent_write_locked_range(&inode->vfs_inode, start, end);
 	*page_started = 1;
 
 	return 0;
-- 
2.32.0

