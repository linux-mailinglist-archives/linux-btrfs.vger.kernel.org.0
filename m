Return-Path: <linux-btrfs+bounces-4911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DB8C2DE6
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 02:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD551C214E3
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790379FD;
	Sat, 11 May 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kUHC2Axa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kUHC2Axa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739A23A9
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386544; cv=none; b=j6gX2+Rn4AONpCNrwcY4rQGBtvRhyJVNgPcCsoIi/Uqc16esBoBax7wtb0Bkn7aZAfAZnVDQp85kWUrnXrxQkIURZYd4E8T/nykdSoPvVSvFg4d4+h3LmQkjnqOi8jrepD4MzLAlXLu9yQc5z9P68g6HHzRfbcaQHRpA4LQIa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386544; c=relaxed/simple;
	bh=zcwQnc95aQkgRhJ23ltnCB1OsFJyfmAys5UDKddh4Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+tInn1FiPRVDMYocXfldVaevoWdgpsuek6urlvUUXHbCv8lNbQXym1+hMsgA6mBNK7klLctKOuRlg8XqE3ORkt14GAJImPc58ClPhZ35w8O1Nj1ee6Z5npX+HnsBxGS89sky5sNofRp4fJ1GPloQz2/So5K1ig9ptXYWYLzxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kUHC2Axa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kUHC2Axa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 774F622A39;
	Sat, 11 May 2024 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdQ/wruY6/oXNAXHTgJlhxNTOxIgiADHG5ygFKFwi70=;
	b=kUHC2AxaDNe2RjzcTNCCX93UAoYkzVPwhvTTocWuC6zHY3qZ4bLF0C4RIKCPGmvMwR6D9h
	dzv/FPr0EeaomeSnuloU9jhnmzCf89JO/5FdbXi+vKcFV8QzQK6kRLEvkdDCyUVNJDSgDX
	D1ORsAF0nsr4o9vpqOWC+y1PSrgPwEo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdQ/wruY6/oXNAXHTgJlhxNTOxIgiADHG5ygFKFwi70=;
	b=kUHC2AxaDNe2RjzcTNCCX93UAoYkzVPwhvTTocWuC6zHY3qZ4bLF0C4RIKCPGmvMwR6D9h
	dzv/FPr0EeaomeSnuloU9jhnmzCf89JO/5FdbXi+vKcFV8QzQK6kRLEvkdDCyUVNJDSgDX
	D1ORsAF0nsr4o9vpqOWC+y1PSrgPwEo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E15CC13A3D;
	Sat, 11 May 2024 00:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wO/OJqq4PmYcPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 May 2024 00:15:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH v4 4/6] btrfs: migrate writepage_delalloc() to use subpage helpers
Date: Sat, 11 May 2024 09:45:20 +0930
Message-ID: <5b2f0242b7084194f4481739dac4bf9270f8f25a.1715386434.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715386434.git.wqu@suse.com>
References: <cover.1715386434.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

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
index 6f237c77699a..b6dc9308105d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1213,101 +1213,6 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
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
@@ -1322,16 +1227,21 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1339,48 +1249,68 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1652,7 +1582,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
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
index 3c957d03324e..81b862d7ab53 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -862,6 +862,7 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio)
 {
+	struct btrfs_subpage *subpage = folio_get_private(folio);
 	u64 folio_start = folio_pos(folio);
 	u64 cur = folio_start;
 
@@ -871,6 +872,11 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
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
2.45.0


