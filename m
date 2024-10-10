Return-Path: <linux-btrfs+bounces-8768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0114997BF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 06:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FCAB22700
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61B19EED4;
	Thu, 10 Oct 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DM0p+PYv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DM0p+PYv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513716A395
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535598; cv=none; b=Wjwn50/P/hE7ZWUd25HQ/2huZD8f2a0rWkthZVJyPIAnV7IR+4wYXbSH7VLL75lBrIJrAgOi2tXyO8Ho1LvWJogLIrovbUo9gOfLFMRXWlFOYqwDVu1QgshycQ+fvn3ybNc/60pk44eQaTY2HvtaORLaAmGgcuEQEshi2pxutXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535598; c=relaxed/simple;
	bh=Ocb7a88L9Mx+un4PRlNc63WPykjWSTtvvUvkZjuDkGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtCNeKd13dOQeWx/8IUtgDGH7L7mM4Qv45jZeqkZXS/3udlv962PrNoo/kTgZzSHjRLjFIiTILOb4GwEP6NNRurOKHGSI/YFMl9P/63sGFAZNsove0llllhMXZ0nwhKG/SLRb0gLGV2dgrnp6rkL3KLAjaMJdX1m0sbIASE2E7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DM0p+PYv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DM0p+PYv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1EE621F88
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728535594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mhehq/tQdyBrem++aUiSqGStsvad5x1m920QzrvwgU=;
	b=DM0p+PYv9gG/GxbPTLC7YYUObiUap4sA2wjnNiXiAwXUlA8Ajx4NnuPJM0PXb0D4QQxAo3
	rsujqDC64KrhbxDJkNTmkUjj5lqp8R1r+00egNFJoMvsLZ1iiKMR5+meUH9EfYjsiZyCxB
	7rI9YEypuRClqotPyXoZbgmd9RW+hKI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DM0p+PYv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728535594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mhehq/tQdyBrem++aUiSqGStsvad5x1m920QzrvwgU=;
	b=DM0p+PYv9gG/GxbPTLC7YYUObiUap4sA2wjnNiXiAwXUlA8Ajx4NnuPJM0PXb0D4QQxAo3
	rsujqDC64KrhbxDJkNTmkUjj5lqp8R1r+00egNFJoMvsLZ1iiKMR5+meUH9EfYjsiZyCxB
	7rI9YEypuRClqotPyXoZbgmd9RW+hKI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E1A51370C
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHL/AClcB2dZLQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: convert btrfs_buffered_write() to use folio interface
Date: Thu, 10 Oct 2024 15:16:13 +1030
Message-ID: <5e61ad52d4d7518b9f2a795cee4bd3fa4e514fae.1728532438.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728532438.git.wqu@suse.com>
References: <cover.1728532438.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1EE621F88
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The buffered write path is still heavily utilizing the old page
interface.

Since we have convert it to do a page-by-page copying, it's much easier
to convert all involved functions to folio interface, this involves:

- btrfs_copy_from_user()
- btrfs_drop_folio()
- prepare_uptodate_page()
- prepare_one_page()
- lock_and_cleanup_extent_if_need()
- btrfs_dirty_page()

All involved function will be changed to accept a folio parameter, and
if the word "page" is in the function name, change that to "folio" too.

The function btrfs_dirty_page() is exported for v1 space cache, convert
v1 cache call site to convert its page to folio for the new interface.

And there is a small enhancement for prepare_one_folio(), instead of
manually waiting for the page writeback, let __filemap_get_folio() to
handle that by using FGP_WRITEBEGIN, which implies
(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c             | 121 ++++++++++++++++--------------------
 fs/btrfs/file.h             |   6 +-
 fs/btrfs/free-space-cache.c |   4 +-
 3 files changed, 60 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fae59acb3b8a..1c8f6f8602ff 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -42,7 +42,7 @@
  * and be replaced with calls into generic code.
  */
 static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
-					 struct page *page,
+					 struct folio *folio,
 					 struct iov_iter *i)
 {
 	size_t copied = 0;
@@ -55,10 +55,10 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 		/*
 		 * Copy data from userspace to the current page
 		 */
-		copied = copy_page_from_iter_atomic(page, offset, count, i);
+		copied = copy_folio_from_iter_atomic(folio, offset, count, i);
 
 		/* Flush processor's dcache for this page */
-		flush_dcache_page(page);
+		flush_dcache_folio(folio);
 
 		/*
 		 * if we get a partial write, we can end up with
@@ -70,7 +70,7 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 		 * back to page at a time copies after we return 0.
 		 */
 		if (unlikely(copied < count)) {
-			if (!PageUptodate(page)) {
+			if (!folio_test_uptodate(folio)) {
 				iov_iter_revert(i, copied);
 				copied = 0;
 			}
@@ -88,24 +88,24 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 /*
  * unlocks pages after btrfs_file_write is done with them
  */
-static void btrfs_drop_page(struct btrfs_fs_info *fs_info,
-			    struct page *page, u64 pos, u64 copied)
+static void btrfs_drop_folio(struct btrfs_fs_info *fs_info,
+			     struct folio *folio, u64 pos, u64 copied)
 {
 	u64 block_start = round_down(pos, fs_info->sectorsize);
 	u64 block_len = round_up(pos + copied, fs_info->sectorsize) - block_start;
 
 	ASSERT(block_len <= U32_MAX);
 	/*
-	 * Page checked is some magic around finding pages that
-	 * have been modified without going through btrfs_set_page_dirty
-	 * clear it here. There should be no need to mark the pages
-	 * accessed as prepare_one_page() should have marked them accessed
-	 * in prepare_one_page() via find_or_create_page()
+	 * Folio checked is some magic around finding folios that
+	 * have been modified without going through btrfs_dirty_folio().
+	 * Clear it here. There should be no need to mark the pages
+	 * accessed as prepare_one_folio() should have marked them accessed
+	 * in prepare_one_folio() via find_or_create_page()
 	 */
-	btrfs_folio_clamp_clear_checked(fs_info, page_folio(page),
+	btrfs_folio_clamp_clear_checked(fs_info, folio,
 					block_start, block_len);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 /*
@@ -115,9 +115,9 @@ static void btrfs_drop_page(struct btrfs_fs_info *fs_info,
  * - Mark modified pages as Uptodate/Dirty and not needing COW fixup
  * - Update inode size for past EOF write
  */
-int btrfs_dirty_page(struct btrfs_inode *inode, struct page *page,
-		     loff_t pos, size_t write_bytes,
-		     struct extent_state **cached, bool noreserve)
+int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio,
+		      loff_t pos, size_t write_bytes,
+		      struct extent_state **cached, bool noreserve)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
@@ -125,7 +125,6 @@ int btrfs_dirty_page(struct btrfs_inode *inode, struct page *page,
 	u64 start_pos;
 	u64 end_of_last_block;
 	u64 end_pos = pos + write_bytes;
-	struct folio *folio = page_folio(page);
 	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;
 
@@ -841,11 +840,10 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
  * on error we return an unlocked page and the error value
  * on success we return a locked page and 0
  */
-static int prepare_uptodate_page(struct inode *inode,
-				 struct page *page, u64 pos,
-				 u64 len, bool force_uptodate)
+static int prepare_uptodate_folio(struct inode *inode,
+				  struct folio *folio, u64 pos,
+				  u64 len, bool force_uptodate)
 {
-	struct folio *folio = page_folio(page);
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
 	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
 	int ret = 0;
@@ -876,23 +874,13 @@ static int prepare_uptodate_page(struct inode *inode,
 	 * The private flag check is essential for subpage as we need to store
 	 * extra bitmap using folio private.
 	 */
-	if (page->mapping != inode->i_mapping || !folio_test_private(folio)) {
+	if (folio->mapping != inode->i_mapping || !folio_test_private(folio)) {
 		folio_unlock(folio);
 		return -EAGAIN;
 	}
 	return 0;
 }
 
-static fgf_t get_prepare_fgp_flags(bool nowait)
-{
-	fgf_t fgp_flags = FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
-
-	if (nowait)
-		fgp_flags |= FGP_NOWAIT;
-
-	return fgp_flags;
-}
-
 static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
 {
 	gfp_t gfp;
@@ -909,45 +897,46 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
 /*
  * this just gets page into the page cache and locks them down.
  */
-static noinline int prepare_one_page(struct inode *inode, struct page **page_ret,
-				     loff_t pos, size_t write_bytes,
-				     bool force_uptodate, bool nowait)
+static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_ret,
+				      loff_t pos, size_t write_bytes,
+				      bool force_uptodate, bool nowait)
 {
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
-	fgf_t fgp_flags = get_prepare_fgp_flags(nowait);
-	struct page *page;
+	fgf_t fgp_flags = nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN;
+	struct folio *folio;
 	int ret = 0;
 
 again:
-	page = pagecache_get_page(inode->i_mapping, index, fgp_flags,
-				  mask | __GFP_WRITE);
-	if (!page) {
+	folio = __filemap_get_folio(inode->i_mapping, index, fgp_flags,
+				    mask);
+	if (IS_ERR(folio)) {
 		if (nowait)
 			ret = -EAGAIN;
 		else
-			ret = -ENOMEM;
+			ret = PTR_ERR(folio);
 		return ret;
 	}
-	ret = set_page_extent_mapped(page);
+	/* Only support page sized folio yet. */
+	ASSERT(folio_order(folio) == 0);
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return ret;
 	}
-	ret = prepare_uptodate_page(inode, page, pos, write_bytes,
-				    force_uptodate);
+	ret = prepare_uptodate_folio(inode, folio, pos, write_bytes,
+				     force_uptodate);
 	if (ret) {
 		/* The page is already unlocked. */
-		put_page(page);
+		folio_put(folio);
 		if (!nowait && ret == -EAGAIN) {
 			ret = 0;
 			goto again;
 		}
 		return ret;
 	}
-	wait_on_page_writeback(page);
-	*page_ret = page;
+	*folio_ret = folio;
 	return 0;
 }
 
@@ -961,7 +950,7 @@ static noinline int prepare_one_page(struct inode *inode, struct page **page_ret
  * -EAGAIN - need re-prepare the pages
  */
 static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page *page,
+lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 				loff_t pos, size_t write_bytes,
 				u64 *lockstart, u64 *lockend, bool nowait,
 				struct extent_state **cached_state)
@@ -980,8 +969,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page *page,
 		if (nowait) {
 			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
 					     cached_state)) {
-				unlock_page(page);
-				put_page(page);
+				folio_unlock(folio);
+				folio_put(folio);
 				return -EAGAIN;
 			}
 		} else {
@@ -995,8 +984,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page *page,
 		    ordered->file_offset <= last_pos) {
 			unlock_extent(&inode->io_tree, start_pos, last_pos,
 				      cached_state);
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			btrfs_start_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
@@ -1010,10 +999,10 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page *page,
 	}
 
 	/*
-	 * We should be called after prepare_one_page() which should have locked
+	 * We should be called after prepare_one_folio() which should have locked
 	 * all pages in the range.
 	 */
-	WARN_ON(!PageLocked(page));
+	WARN_ON(!folio_test_locked(folio));
 
 	return ret;
 }
@@ -1195,12 +1184,12 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		size_t copied;
 		size_t dirty_sectors;
 		size_t num_sectors;
-		struct page *page = NULL;
+		struct folio *folio = NULL;
 		int extents_locked;
 		bool force_page_uptodate = false;
 
 		/*
-		 * Fault pages before locking them in prepare_one_page()
+		 * Fault pages before locking them in prepare_one_folio()
 		 * to avoid recursive lock
 		 */
 		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
@@ -1266,8 +1255,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		ret = prepare_one_page(inode, &page, pos, write_bytes,
-				       force_page_uptodate, false);
+		ret = prepare_one_folio(inode, &folio, pos, write_bytes,
+					force_page_uptodate, false);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -1275,7 +1264,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), page,
+				BTRFS_I(inode), folio,
 				pos, write_bytes, &lockstart,
 				&lockend, nowait, &cached_state);
 		if (extents_locked < 0) {
@@ -1288,7 +1277,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		copied = btrfs_copy_from_user(pos, write_bytes, page, i);
+		copied = btrfs_copy_from_user(pos, write_bytes, folio, i);
 
 		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
 		dirty_sectors = round_up(copied + sector_offset,
@@ -1320,7 +1309,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		release_bytes = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 
-		ret = btrfs_dirty_page(BTRFS_I(inode), page,
+		ret = btrfs_dirty_folio(BTRFS_I(inode), folio,
 					pos, copied, &cached_state,
 					only_release_metadata);
 
@@ -1339,7 +1328,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
-			btrfs_drop_page(fs_info, page, pos, copied);
+			btrfs_drop_folio(fs_info, folio, pos, copied);
 			break;
 		}
 
@@ -1347,7 +1336,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		if (only_release_metadata)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
-		btrfs_drop_page(fs_info, page, pos, copied);
+		btrfs_drop_folio(fs_info, folio, pos, copied);
 
 		cond_resched();
 
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 5316d971f6ef..b7f290d56357 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -34,9 +34,9 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			    const struct btrfs_ioctl_encoded_io_args *encoded);
 int btrfs_release_file(struct inode *inode, struct file *file);
-int btrfs_dirty_page(struct btrfs_inode *inode, struct page *page,
-		     loff_t pos, size_t write_bytes,
-		     struct extent_state **cached, bool noreserve);
+int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio,
+		      loff_t pos, size_t write_bytes,
+		      struct extent_state **cached, bool noreserve);
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end);
 int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ec34b85dd0e5..40476d882685 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1463,8 +1463,8 @@ static int __btrfs_write_out_cache(struct inode *inode,
 		u64 dirty_start = i * PAGE_SIZE;
 		u64 dirty_len = min_t(u64, dirty_start + PAGE_SIZE, i_size) - dirty_start;
 
-		ret = btrfs_dirty_page(BTRFS_I(inode), io_ctl->pages[i],
-				       dirty_start, dirty_len, &cached_state, false);
+		ret = btrfs_dirty_folio(BTRFS_I(inode), page_folio(io_ctl->pages[i]),
+				        dirty_start, dirty_len, &cached_state, false);
 		if (ret < 0)
 			goto out_nospc;
 	}
-- 
2.46.2


