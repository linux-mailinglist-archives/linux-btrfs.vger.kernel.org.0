Return-Path: <linux-btrfs+bounces-8767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A637997BF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 06:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A74283F23
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D219E99F;
	Thu, 10 Oct 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u+jpiedE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u+jpiedE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE31E480
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535597; cv=none; b=mXfAv3FOIitH3HE0iC4PxCq/nSe3aaZTl6yDLHNM3/Lws5l/V9A5IzhM+Z5BVrgDq/F3JdovrSu0lg5Yjr8A0uZCe8oIoHRDvE1hsXqXuppvzoZpvLlNgm3tDhbAKSbaLK4r6HeYWVZpxD645bhOoH24Efk3zoWDIt+T2O8cmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535597; c=relaxed/simple;
	bh=74SHctlON7fGdr/9/p4PfG2qxHvksCBKQgWsXDSXsLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwaMlf/1x5tWVk9+DXdMerjkW9pzTeaDEwPNQPINI0jYEqWp/asN9PYn7w1CSfnC2JJauuoKtSQS8m22D3XucyAb5lfIj3uRj0EvxbhIV4fBU4teq5Iw7Nna+w6jNUzJ31qgTtUojImJUCyoifIFzQuUUhPlQQesEkQHdU9Oyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u+jpiedE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u+jpiedE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEA7F21F81
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728535592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BokXWX3Pwnx5lKG6qFmhpulM8TPwXl20iOqKdJ7n4tQ=;
	b=u+jpiedE68ay8oupL80EqxKcCdt7jr8htv++y9TqrkoCX84F/KMPsDjXFvyBfzFIZIKBe3
	eATwJMv/jmo4R+rfgd8BWk3pVd92p2c6VipGzBLonVWrrJdREpbH7M9ifOzF+0YceSu8l8
	9+bRSkoFD2nMgsHsyKk9/aElw8io7y4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u+jpiedE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728535592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BokXWX3Pwnx5lKG6qFmhpulM8TPwXl20iOqKdJ7n4tQ=;
	b=u+jpiedE68ay8oupL80EqxKcCdt7jr8htv++y9TqrkoCX84F/KMPsDjXFvyBfzFIZIKBe3
	eATwJMv/jmo4R+rfgd8BWk3pVd92p2c6VipGzBLonVWrrJdREpbH7M9ifOzF+0YceSu8l8
	9+bRSkoFD2nMgsHsyKk9/aElw8io7y4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D5B31370C
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6M+yMCdcB2dZLQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make buffered write to copy one page a time
Date: Thu, 10 Oct 2024 15:16:12 +1030
Message-ID: <0d6f8e54faafe6dba9be2f72e6d0fca99951ddfd.1728532438.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: CEA7F21F81
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently the btrfs_buffered_write() is preparing multiple page a time,
allowing a better performance.

But the current trend is to support larger folio as an optimization,
instead of implementing a proprietary multi-page optimization.

This is inspired by generic_perform_write(), which is copying one folio
a time.

Such change will prepare us to migrate to implement the write_begin()
and write_end() call backs, and make every involved function a little
easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c             | 236 +++++++++++++-----------------------
 fs/btrfs/file.h             |   6 +-
 fs/btrfs/free-space-cache.c |  15 ++-
 3 files changed, 98 insertions(+), 159 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 160d77f8eb6f..fae59acb3b8a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -37,22 +37,21 @@
 #include "file.h"
 #include "super.h"
 
-/* simple helper to fault in pages and copy.  This should go away
+/*
+ * Simple helper to fault in page and copy.  This should go away
  * and be replaced with calls into generic code.
  */
 static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
-					 struct page **prepared_pages,
+					 struct page *page,
 					 struct iov_iter *i)
 {
 	size_t copied = 0;
 	size_t total_copied = 0;
-	int pg = 0;
 	int offset = offset_in_page(pos);
 
 	while (write_bytes > 0) {
-		size_t count = min_t(size_t,
-				     PAGE_SIZE - offset, write_bytes);
-		struct page *page = prepared_pages[pg];
+		size_t count = min_t(size_t, PAGE_SIZE - offset,
+				     write_bytes);
 		/*
 		 * Copy data from userspace to the current page
 		 */
@@ -63,7 +62,7 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 
 		/*
 		 * if we get a partial write, we can end up with
-		 * partially up to date pages.  These add
+		 * partially up to date page.  These add
 		 * a lot of complexity, so make sure they don't
 		 * happen by forcing this copy to be retried.
 		 *
@@ -82,10 +81,6 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 		write_bytes -= copied;
 		total_copied += copied;
 		offset += copied;
-		if (offset == PAGE_SIZE) {
-			pg++;
-			offset = 0;
-		}
 	}
 	return total_copied;
 }
@@ -93,27 +88,24 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 /*
  * unlocks pages after btrfs_file_write is done with them
  */
-static void btrfs_drop_pages(struct btrfs_fs_info *fs_info,
-			     struct page **pages, size_t num_pages,
-			     u64 pos, u64 copied)
+static void btrfs_drop_page(struct btrfs_fs_info *fs_info,
+			    struct page *page, u64 pos, u64 copied)
 {
-	size_t i;
 	u64 block_start = round_down(pos, fs_info->sectorsize);
 	u64 block_len = round_up(pos + copied, fs_info->sectorsize) - block_start;
 
 	ASSERT(block_len <= U32_MAX);
-	for (i = 0; i < num_pages; i++) {
-		/* page checked is some magic around finding pages that
-		 * have been modified without going through btrfs_set_page_dirty
-		 * clear it here. There should be no need to mark the pages
-		 * accessed as prepare_pages should have marked them accessed
-		 * in prepare_pages via find_or_create_page()
-		 */
-		btrfs_folio_clamp_clear_checked(fs_info, page_folio(pages[i]),
-						block_start, block_len);
-		unlock_page(pages[i]);
-		put_page(pages[i]);
-	}
+	/*
+	 * Page checked is some magic around finding pages that
+	 * have been modified without going through btrfs_set_page_dirty
+	 * clear it here. There should be no need to mark the pages
+	 * accessed as prepare_one_page() should have marked them accessed
+	 * in prepare_one_page() via find_or_create_page()
+	 */
+	btrfs_folio_clamp_clear_checked(fs_info, page_folio(page),
+					block_start, block_len);
+	unlock_page(page);
+	put_page(page);
 }
 
 /*
@@ -123,19 +115,17 @@ static void btrfs_drop_pages(struct btrfs_fs_info *fs_info,
  * - Mark modified pages as Uptodate/Dirty and not needing COW fixup
  * - Update inode size for past EOF write
  */
-int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
-		      loff_t pos, size_t write_bytes,
-		      struct extent_state **cached, bool noreserve)
+int btrfs_dirty_page(struct btrfs_inode *inode, struct page *page,
+		     loff_t pos, size_t write_bytes,
+		     struct extent_state **cached, bool noreserve)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
-	int i;
-	const int num_pages = (round_up(pos + write_bytes, PAGE_SIZE) -
-			       round_down(pos, PAGE_SIZE)) >> PAGE_SHIFT;
 	u64 num_bytes;
 	u64 start_pos;
 	u64 end_of_last_block;
 	u64 end_pos = pos + write_bytes;
+	struct folio *folio = page_folio(page);
 	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;
 
@@ -149,6 +139,8 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
 	ASSERT(num_bytes <= U32_MAX);
+	ASSERT(folio_pos(folio) <= pos &&
+	       folio_pos(folio) + folio_size(folio) >= pos + write_bytes);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
@@ -165,16 +157,9 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = pages[i];
-
-		btrfs_folio_clamp_set_uptodate(fs_info, page_folio(p),
-					       start_pos, num_bytes);
-		btrfs_folio_clamp_clear_checked(fs_info, page_folio(p),
-						start_pos, num_bytes);
-		btrfs_folio_clamp_set_dirty(fs_info, page_folio(p),
-					    start_pos, num_bytes);
-	}
+	btrfs_folio_clamp_set_uptodate(fs_info, folio, start_pos, num_bytes);
+	btrfs_folio_clamp_clear_checked(fs_info, folio, start_pos, num_bytes);
+	btrfs_folio_clamp_set_dirty(fs_info, folio, start_pos, num_bytes);
 
 	/*
 	 * we've only changed i_size in ram, and we haven't updated
@@ -922,62 +907,48 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
 }
 
 /*
- * this just gets pages into the page cache and locks them down.
+ * this just gets page into the page cache and locks them down.
  */
-static noinline int prepare_pages(struct inode *inode, struct page **pages,
-				  size_t num_pages, loff_t pos,
-				  size_t write_bytes, bool force_uptodate,
-				  bool nowait)
+static noinline int prepare_one_page(struct inode *inode, struct page **page_ret,
+				     loff_t pos, size_t write_bytes,
+				     bool force_uptodate, bool nowait)
 {
-	int i;
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
 	fgf_t fgp_flags = get_prepare_fgp_flags(nowait);
+	struct page *page;
 	int ret = 0;
-	int faili;
 
-	for (i = 0; i < num_pages; i++) {
 again:
-		pages[i] = pagecache_get_page(inode->i_mapping, index + i,
-					      fgp_flags, mask | __GFP_WRITE);
-		if (!pages[i]) {
-			faili = i - 1;
-			if (nowait)
-				ret = -EAGAIN;
-			else
-				ret = -ENOMEM;
-			goto fail;
-		}
-
-		ret = set_page_extent_mapped(pages[i]);
-		if (ret < 0) {
-			faili = i;
-			goto fail;
-		}
-
-		ret = prepare_uptodate_page(inode, pages[i], pos, write_bytes,
-					    force_uptodate);
-		if (ret) {
-			put_page(pages[i]);
-			if (!nowait && ret == -EAGAIN) {
-				ret = 0;
-				goto again;
-			}
-			faili = i - 1;
-			goto fail;
-		}
-		wait_on_page_writeback(pages[i]);
+	page = pagecache_get_page(inode->i_mapping, index, fgp_flags,
+				  mask | __GFP_WRITE);
+	if (!page) {
+		if (nowait)
+			ret = -EAGAIN;
+		else
+			ret = -ENOMEM;
+		return ret;
 	}
-
+	ret = set_page_extent_mapped(page);
+	if (ret < 0) {
+		unlock_page(page);
+		put_page(page);
+		return ret;
+	}
+	ret = prepare_uptodate_page(inode, page, pos, write_bytes,
+				    force_uptodate);
+	if (ret) {
+		/* The page is already unlocked. */
+		put_page(page);
+		if (!nowait && ret == -EAGAIN) {
+			ret = 0;
+			goto again;
+		}
+		return ret;
+	}
+	wait_on_page_writeback(page);
+	*page_ret = page;
 	return 0;
-fail:
-	while (faili >= 0) {
-		unlock_page(pages[faili]);
-		put_page(pages[faili]);
-		faili--;
-	}
-	return ret;
-
 }
 
 /*
@@ -988,19 +959,16 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
  * 1 - the extent is locked
  * 0 - the extent is not locked, and everything is OK
  * -EAGAIN - need re-prepare the pages
- * the other < 0 number - Something wrong happens
  */
 static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
-				size_t num_pages, loff_t pos,
-				size_t write_bytes,
+lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page *page,
+				loff_t pos, size_t write_bytes,
 				u64 *lockstart, u64 *lockend, bool nowait,
 				struct extent_state **cached_state)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 start_pos;
 	u64 last_pos;
-	int i;
 	int ret = 0;
 
 	start_pos = round_down(pos, fs_info->sectorsize);
@@ -1012,12 +980,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		if (nowait) {
 			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
 					     cached_state)) {
-				for (i = 0; i < num_pages; i++) {
-					unlock_page(pages[i]);
-					put_page(pages[i]);
-					pages[i] = NULL;
-				}
-
+				unlock_page(page);
+				put_page(page);
 				return -EAGAIN;
 			}
 		} else {
@@ -1031,10 +995,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		    ordered->file_offset <= last_pos) {
 			unlock_extent(&inode->io_tree, start_pos, last_pos,
 				      cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
+			unlock_page(page);
+			put_page(page);
 			btrfs_start_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
@@ -1048,11 +1010,10 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	}
 
 	/*
-	 * We should be called after prepare_pages() which should have locked
+	 * We should be called after prepare_one_page() which should have locked
 	 * all pages in the range.
 	 */
-	for (i = 0; i < num_pages; i++)
-		WARN_ON(!PageLocked(pages[i]));
+	WARN_ON(!PageLocked(page));
 
 	return ret;
 }
@@ -1196,20 +1157,17 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	loff_t pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct page **pages = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	u64 release_bytes = 0;
 	u64 lockstart;
 	u64 lockend;
 	size_t num_written = 0;
-	int nrptrs;
 	ssize_t ret;
-	bool only_release_metadata = false;
-	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
+	bool only_release_metadata = false;
 
 	if (nowait)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1227,32 +1185,22 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		goto out;
 
 	pos = iocb->ki_pos;
-	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
-			PAGE_SIZE / (sizeof(struct page *)));
-	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
-	nrptrs = max(nrptrs, 8);
-	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
 		size_t offset = offset_in_page(pos);
 		size_t sector_offset;
 		size_t write_bytes = min(iov_iter_count(i),
-					 nrptrs * (size_t)PAGE_SIZE -
-					 offset);
-		size_t num_pages;
+					 PAGE_SIZE - offset);
 		size_t reserve_bytes;
 		size_t copied;
 		size_t dirty_sectors;
 		size_t num_sectors;
+		struct page *page = NULL;
 		int extents_locked;
+		bool force_page_uptodate = false;
 
 		/*
-		 * Fault pages before locking them in prepare_pages
+		 * Fault pages before locking them in prepare_one_page()
 		 * to avoid recursive lock
 		 */
 		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
@@ -1291,8 +1239,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			only_release_metadata = true;
 		}
 
-		num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
-		WARN_ON(num_pages > nrptrs);
 		reserve_bytes = round_up(write_bytes + sector_offset,
 					 fs_info->sectorsize);
 		WARN_ON(reserve_bytes == 0);
@@ -1320,13 +1266,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		/*
-		 * This is going to setup the pages array with the number of
-		 * pages we want, so we don't really need to worry about the
-		 * contents of pages from loop to loop
-		 */
-		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes, force_page_uptodate, false);
+		ret = prepare_one_page(inode, &page, pos, write_bytes,
+				       force_page_uptodate, false);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -1334,8 +1275,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
+				BTRFS_I(inode), page,
+				pos, write_bytes, &lockstart,
 				&lockend, nowait, &cached_state);
 		if (extents_locked < 0) {
 			if (!nowait && extents_locked == -EAGAIN)
@@ -1347,20 +1288,13 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
+		copied = btrfs_copy_from_user(pos, write_bytes, page, i);
 
 		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
 		dirty_sectors = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
 
-		/*
-		 * if we have trouble faulting in the pages, fall
-		 * back to one page at a time
-		 */
-		if (copied < write_bytes)
-			nrptrs = 1;
-
 		if (copied == 0) {
 			force_page_uptodate = true;
 			dirty_sectors = 0;
@@ -1386,15 +1320,15 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		release_bytes = round_up(copied + sector_offset,
 					fs_info->sectorsize);
 
-		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
-					pos, copied,
-					&cached_state, only_release_metadata);
+		ret = btrfs_dirty_page(BTRFS_I(inode), page,
+					pos, copied, &cached_state,
+					only_release_metadata);
 
 		/*
 		 * If we have not locked the extent range, because the range's
 		 * start offset is >= i_size, we might still have a non-NULL
 		 * cached extent state, acquired while marking the extent range
-		 * as delalloc through btrfs_dirty_pages(). Therefore free any
+		 * as delalloc through btrfs_dirty_page(). Therefore free any
 		 * possible cached extent state to avoid a memory leak.
 		 */
 		if (extents_locked)
@@ -1405,7 +1339,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
-			btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
+			btrfs_drop_page(fs_info, page, pos, copied);
 			break;
 		}
 
@@ -1413,7 +1347,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		if (only_release_metadata)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
-		btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
+		btrfs_drop_page(fs_info, page, pos, copied);
 
 		cond_resched();
 
@@ -1421,8 +1355,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		num_written += copied;
 	}
 
-	kfree(pages);
-
 	if (release_bytes) {
 		if (only_release_metadata) {
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index c23d0bf42598..5316d971f6ef 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -34,9 +34,9 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			    const struct btrfs_ioctl_encoded_io_args *encoded);
 int btrfs_release_file(struct inode *inode, struct file *file);
-int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
-		      loff_t pos, size_t write_bytes,
-		      struct extent_state **cached, bool noreserve);
+int btrfs_dirty_page(struct btrfs_inode *inode, struct page *page,
+		     loff_t pos, size_t write_bytes,
+		     struct extent_state **cached, bool noreserve);
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end);
 int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d2db205b9f6..ec34b85dd0e5 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1387,6 +1387,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	int bitmaps = 0;
 	int ret;
 	int must_iput = 0;
+	int i_size;
 
 	if (!i_size_read(inode))
 		return -EIO;
@@ -1457,10 +1458,16 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	io_ctl_zero_remaining_pages(io_ctl);
 
 	/* Everything is written out, now we dirty the pages in the file. */
-	ret = btrfs_dirty_pages(BTRFS_I(inode), io_ctl->pages, 0, i_size_read(inode),
-				&cached_state, false);
-	if (ret)
-		goto out_nospc;
+	i_size = i_size_read(inode);
+	for (int i = 0; i < round_up(i_size, PAGE_SIZE) / PAGE_SIZE; i++) {
+		u64 dirty_start = i * PAGE_SIZE;
+		u64 dirty_len = min_t(u64, dirty_start + PAGE_SIZE, i_size) - dirty_start;
+
+		ret = btrfs_dirty_page(BTRFS_I(inode), io_ctl->pages[i],
+				       dirty_start, dirty_len, &cached_state, false);
+		if (ret < 0)
+			goto out_nospc;
+	}
 
 	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
 		up_write(&block_group->data_rwsem);
-- 
2.46.2


