Return-Path: <linux-btrfs+bounces-2485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF31859BE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 07:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0632B20968
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D120327;
	Mon, 19 Feb 2024 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OfPF/irP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OfPF/irP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726820305
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322931; cv=none; b=OwaTkh46Lv7zpuAKQda99ZhU6f1TBkaHOOweXadAccroHBKVZVgVjp7OgrXS/DJ8zdIjTBHENRE7ePj/VoT1oLecZxL+SFOrEQH102BaH3V9Mro6GBDSHE0y55n5WDiMG91qvFbBHwB6QWQAn9Zfs5D6y12L5QOa3pkG++CG3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322931; c=relaxed/simple;
	bh=/qzu7El7NjgfrYP0SjByKAPmVJZntDHAc4W+9AbSsR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUo4DXbFfy9eGEwqDUSJzfBYnOMLnPzSC8PR7v14gAUK2fGqO1E5Nz8weaEOvUOhOz8zEEBfxYzFtu0l0kekVG2ttKAzMyoaToIggUh9bOkn+7UvPKenHhuLrKH2/pljqw8wBC50xE3/N6my3Rg12mUOhVVNcYYppX2PP6oOxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OfPF/irP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OfPF/irP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B27F321F78
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6vigV5uAsAeBB7X8wW8+dttDSHn8WsVR2JA8F20i9o=;
	b=OfPF/irPxHZDI2f9pu+2F+BB2BYp613mDUK+UKMpFhb6Q6+lhjGy5SH1WAHq3c2tLams7u
	fscNir8McvP5u/uobDieyiXFTSyy6YRrDcag5ZXWG3LxJOaDPJAdiVSWvg+FFEHqJSUsGQ
	e6ZK3JfId/VPnewKiXI3/6SrDXeLtqU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6vigV5uAsAeBB7X8wW8+dttDSHn8WsVR2JA8F20i9o=;
	b=OfPF/irPxHZDI2f9pu+2F+BB2BYp613mDUK+UKMpFhb6Q6+lhjGy5SH1WAHq3c2tLams7u
	fscNir8McvP5u/uobDieyiXFTSyy6YRrDcag5ZXWG3LxJOaDPJAdiVSWvg+FFEHqJSUsGQ
	e6ZK3JfId/VPnewKiXI3/6SrDXeLtqU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C044513585
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KNDHHG7w0mXcJQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: migrate writepage_delalloc() to use subpage helpers
Date: Mon, 19 Feb 2024 16:38:37 +1030
Message-ID: <a55a05914ee860eb53dafaad491b176fd5969cdf.1708322044.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708322044.git.wqu@suse.com>
References: <cover.1708322044.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.987];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Currently writepage_delalloc() is using a list based solution to save
locked subpage ranges, but that would introduce extra memory allocation
thus extra error paths.

On the other hand, we already have subpage locked bitmap and helpers to
set and find a subpage locked range, we can use those helpers to record
locked subpage ranges without allocating new memory.

Although we still have several small pitfalls:

- We still need to record the last delalloc range end
  This is because subpage bitmap can only record ranges inside the page,
  while the last delalloc range end can go beyond the page boundary.

- We still need to handle errors in previous iteration
  Since we can have multiple locked delalloc ranges thus we have to call
  run_delalloc_ranges() multiple times.
  If we hit an error half way, we still need to unlock the remaining
  ranges.

- We can not longer touch the page if we have run the last delalloc
  range.
  This is for zoned subpage support, as for non-zoned subpage, the async
  submission can only happen for full page aligned ranges.

  For zoned subpage, if we hit the last delalloc range, it would unlock
  the full page, and if we continue to do the search,
  btrfs_subpage_find_writer_locked() would throw an ASSERT() as the
  page is no longer locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 195 ++++++++++++++-----------------------------
 fs/btrfs/subpage.c   |   6 ++
 2 files changed, 69 insertions(+), 132 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e79676422c16..522bfa9670b3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1185,101 +1185,6 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	}
 }
 
-struct locked_delalloc_range {
-	struct list_head list;
-	u64 delalloc_start;
-	u32 delalloc_len;
-};
-
-/*
- * Save the locked delalloc range.
- *
- * This is for subpage only, as for regular sectorsize, there will be at most
- * one locked delalloc range for a page.
- */
-struct locked_delalloc_list {
-	u64 last_delalloc_start;
-	u32 last_delalloc_len;
-	struct list_head head;
-};
-
-static void init_locked_delalloc_list(struct locked_delalloc_list *locked_list)
-{
-	INIT_LIST_HEAD(&locked_list->head);
-	locked_list->last_delalloc_start = 0;
-	locked_list->last_delalloc_len = 0;
-}
-
-static void release_locked_delalloc_list(struct locked_delalloc_list *locked_list)
-{
-	while (!list_empty(&locked_list->head)) {
-		struct locked_delalloc_range *entry;
-
-		entry = list_entry(locked_list->head.next,
-				   struct locked_delalloc_range, list);
-
-		list_del_init(&entry->list);
-		kfree(entry);
-	}
-}
-
-static int add_locked_delalloc_range(struct btrfs_fs_info *fs_info,
-				     struct locked_delalloc_list *locked_list,
-				     u64 start, u32 len)
-{
-	struct locked_delalloc_range *entry;
-
-	entry = kmalloc(sizeof(*entry), GFP_NOFS);
-	if (!entry)
-		return -ENOMEM;
-
-	if (locked_list->last_delalloc_len == 0) {
-		locked_list->last_delalloc_start = start;
-		locked_list->last_delalloc_len = len;
-		return 0;
-	}
-	/* The new entry must be beyond the current one. */
-	ASSERT(start >= locked_list->last_delalloc_start +
-			locked_list->last_delalloc_len);
-
-	/* Only subpage case can have more than one delalloc ranges inside a page. */
-	ASSERT(fs_info->sectorsize < PAGE_SIZE);
-
-	entry->delalloc_start = locked_list->last_delalloc_start;
-	entry->delalloc_len = locked_list->last_delalloc_len;
-	locked_list->last_delalloc_start = start;
-	locked_list->last_delalloc_len = len;
-	list_add_tail(&entry->list, &locked_list->head);
-	return 0;
-}
-
-static void __cold unlock_one_locked_delalloc_range(struct btrfs_inode *binode,
-						    struct page *locked_page,
-						    u64 start, u32 len)
-{
-	u64 delalloc_end = start + len - 1;
-
-	unlock_extent(&binode->io_tree, start, delalloc_end, NULL);
-	__unlock_for_delalloc(&binode->vfs_inode, locked_page, start,
-			      delalloc_end);
-}
-
-static void unlock_locked_delalloc_list(struct btrfs_inode *binode,
-					struct page *locked_page,
-					struct locked_delalloc_list *locked_list)
-{
-	struct locked_delalloc_range *entry;
-
-	list_for_each_entry(entry, &locked_list->head, list)
-		unlock_one_locked_delalloc_range(binode, locked_page,
-				entry->delalloc_start, entry->delalloc_len);
-	if (locked_list->last_delalloc_len) {
-		unlock_one_locked_delalloc_range(binode, locked_page,
-				locked_list->last_delalloc_start,
-				locked_list->last_delalloc_len);
-	}
-}
-
 /*
  * helper for __extent_writepage, doing all of the delayed allocation setup.
  *
@@ -1294,16 +1199,21 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
+	struct folio *folio = page_folio(page);
 	const u64 page_start = page_offset(page);
 	const u64 page_end = page_start + PAGE_SIZE - 1;
-	struct locked_delalloc_list locked_list;
-	struct locked_delalloc_range *entry;
+	/*
+	 * Saves the last found delalloc end. As the delalloc end can go beyond
+	 * page boundary, thus we can not rely on subpage bitmap to locate
+	 * the last dealloc end.
+	 */
+	u64 last_delalloc_end = 0;
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
 	int ret = 0;
 
-	init_locked_delalloc_list(&locked_list);
+	/* Lock all (subpage) dealloc ranges inside the page first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
 		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
@@ -1311,48 +1221,68 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
-		ret = add_locked_delalloc_range(fs_info, &locked_list,
-				delalloc_start, delalloc_end + 1 - delalloc_start);
-		if (ret < 0) {
-			unlock_locked_delalloc_list(inode, page, &locked_list);
-			release_locked_delalloc_list(&locked_list);
-			return ret;
-		}
-
+		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
+					    min(delalloc_end, page_end) + 1 -
+					    delalloc_start);
+		last_delalloc_end = delalloc_end;
 		delalloc_start = delalloc_end + 1;
 	}
-	list_for_each_entry(entry, &locked_list.head, list) {
-		delalloc_end = entry->delalloc_start + entry->delalloc_len - 1;
+	delalloc_start = page_start;
+	/* Run the delalloc ranges for above locked ranges. */
+	while (last_delalloc_end && delalloc_start < page_end) {
+		u64 found_start;
+		u32 found_len;
+		bool found;
 
-		/*
-		 * Hit error in the previous run, cleanup the locked
-		 * extents/pages.
-		 */
-		if (ret < 0) {
-			unlock_one_locked_delalloc_range(inode, page,
-					entry->delalloc_start, entry->delalloc_len);
-			continue;
+		if (!btrfs_is_subpage(fs_info, page->mapping)) {
+			/*
+			 * For non-subpage case, the found delalloc range must
+			 * cover this page and there must be only one locked
+			 * delalloc range.
+			 */
+			found_start = page_start;
+			found_len = last_delalloc_end + 1 - found_start;
+			found = true;
+		} else {
+			found = btrfs_subpage_find_writer_locked(fs_info, folio,
+					delalloc_start, &found_start, &found_len);
 		}
-		ret = btrfs_run_delalloc_range(inode, page, entry->delalloc_start,
-					       delalloc_end, wbc);
-	}
-	if (locked_list.last_delalloc_len) {
-		delalloc_end = locked_list.last_delalloc_start +
-			       locked_list.last_delalloc_len - 1;
+		if (!found)
+			break;
+		/*
+		 * The subpage range covers the last sector, the delalloc range may
+		 * end beyonds the page boundary, use the saved delalloc_end
+		 * instead.
+		 */
+		if (found_start + found_len >= page_end)
+			found_len = last_delalloc_end + 1 - found_start;
 
-		if (ret < 0)
-			unlock_one_locked_delalloc_range(inode, page,
-					locked_list.last_delalloc_start,
-					locked_list.last_delalloc_len);
-		else
-			ret = btrfs_run_delalloc_range(inode, page,
-					locked_list.last_delalloc_start,
-					delalloc_end, wbc);
+		if (ret < 0) {
+			/* Cleanup the remaining locked ranges. */
+			unlock_extent(&inode->io_tree, found_start,
+				      found_start + found_len - 1, NULL);
+			__unlock_for_delalloc(&inode->vfs_inode, page, found_start,
+					      found_start + found_len - 1);
+		} else {
+			ret = btrfs_run_delalloc_range(inode, page, found_start,
+						       found_start + found_len - 1, wbc);
+		}
+		/*
+		 * Above btrfs_run_delalloc_range() may have unlocked the page,
+		 * Thus for the last range, we can not touch the page anymore.
+		 */
+		if (found_start + found_len >= last_delalloc_end + 1)
+			break;
+
+		delalloc_start = found_start + found_len;
 	}
-	release_locked_delalloc_list(&locked_list);
 	if (ret < 0)
 		return ret;
 
+	if (last_delalloc_end)
+		delalloc_end = last_delalloc_end;
+	else
+		delalloc_end = page_end;
 	/*
 	 * delalloc_end is already one less than the total length, so
 	 * we don't subtract one from PAGE_SIZE
@@ -1624,7 +1554,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 					       PAGE_SIZE, !ret);
 		mapping_set_error(page->mapping, ret);
 	}
-	unlock_page(page);
+
+	btrfs_folio_end_all_writers(inode_to_fs_info(inode), folio);
 	ASSERT(ret <= 0);
 	return ret;
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 162a10eee3fd..8793c6f6edc1 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -865,6 +865,7 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio)
 {
+	struct btrfs_subpage *subpage = folio_get_private(folio);
 	u64 folio_start = folio_pos(folio);
 	u64 cur = folio_start;
 
@@ -874,6 +875,11 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
 		return;
 	}
 
+	/* The page has no new delalloc range locked on it. Just plain unlock. */
+	if (atomic_read(&subpage->writers) == 0) {
+		folio_unlock(folio);
+		return;
+	}
 	while (cur < folio_start + PAGE_SIZE) {
 		u64 found_start;
 		u32 found_len;
-- 
2.43.2


