Return-Path: <linux-btrfs+bounces-5088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E33108C8FA9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 07:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FA31F216EB
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 05:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F119DDA6;
	Sat, 18 May 2024 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cULLT0D9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cULLT0D9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C3D268
	for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716008894; cv=none; b=uw0n17ZLI6PxW4IHgOCwT8gjb9BMNYLlEruPklwBPRdda31d2zfqKvUef64k7mzV9hdZZJ4n5mZV1m3qd0EzWGyqKJbWdfsWL9DKC8qljzHf2ph2DhSfzsDgxUA071YY3ulg/Qhvk7PYro6Ab6Z6+3ycuf+afMSDBSXLFhdo6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716008894; c=relaxed/simple;
	bh=pG1tGnX4HZutE+Xd6nz8Cm3W08CjjYmVroxLVyrI+8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3d7SBOEtwefBL8vatCBRiQDFzThmVaLjCQWW0MvUmJY4SmBGr5aEL/Pl6JW9CdN4ze6pbz8khL4vLzDLFI4JoPqi9PLi/rPpK7ijN0camttSgqQV+njkEHR+8JVlw1dywFIMUBd0+VI2P3Pq1V8p7ZytylNLNc/x2Hzqn6Pf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cULLT0D9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cULLT0D9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02D6E219BC;
	Sat, 18 May 2024 05:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdyvgpUsT6Q7KAuNVdo0qTgem+PI/b//uRyFzErN0rM=;
	b=cULLT0D9xURxdl3MNh6df8sX7fSNNOIbh2q3zGewUKwtaeglr9CmDjNKe/gQIvDfrdPyaK
	qdg2xVp4Uj/0EEl33QUwyRCv8Hbem0EzzPIfwJKL/4nb7qKxjhc5RhsR8kTcz+WnMXoUsU
	fEoRJKzCPDr7aCfkof+XuxvyiwLzZzc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdyvgpUsT6Q7KAuNVdo0qTgem+PI/b//uRyFzErN0rM=;
	b=cULLT0D9xURxdl3MNh6df8sX7fSNNOIbh2q3zGewUKwtaeglr9CmDjNKe/gQIvDfrdPyaK
	qdg2xVp4Uj/0EEl33QUwyRCv8Hbem0EzzPIfwJKL/4nb7qKxjhc5RhsR8kTcz+WnMXoUsU
	fEoRJKzCPDr7aCfkof+XuxvyiwLzZzc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6528013942;
	Sat, 18 May 2024 05:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WH2oBLg3SGbnXgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 18 May 2024 05:08:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com,
	josef@toxicpanda.com
Subject: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for writepage_delalloc()
Date: Sat, 18 May 2024 14:37:41 +0930
Message-ID: <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716008374.git.wqu@suse.com>
References: <cover.1716008374.git.wqu@suse.com>
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

If we have a subpage range like this for a 16K page with 4K sectorsize:

    0     4K     8K     12K     16K
    |/////|      |//////|       |

    |/////| = dirty range

Currently writepage_delalloc() would go through the following steps:

- lock range [0, 4K)
- run delalloc range for [0, 4K)
- lock range [8K, 12K)
- run delalloc range for [8K 12K)

So far it's fine for regular subpage writeback, as
btrfs_run_delalloc_range() can only go into one of run_delalloc_nocow(),
cow_file_range() and run_delalloc_compressed().

But there is a special pitfall for zoned subpage, where we will go
through run_delalloc_cow(), which would create the ordered extent for the
range and immediately submit the range.
This would unlock the whole page range, causing all kinds of different
ASSERT()s related to locked page.

This patch would address the page unlocking problem of run_delalloc_cow(),
by changing the workflow to the following one:

- lock range [0, 4K)
- lock range [8K, 12K)
- run delalloc range for [0, 4K)
- run delalloc range for [8K, 12K)

So that run_delalloc_cow() can only unlock the full page until the
last lock user released.

To do that, this patch would:

- Utilizing subpage locked bitmap
  So for every delalloc range we found, call
  btrfs_folio_set_writer_lock() to populate the subpage locked bitmap,
  and later btrfs_folio_end_all_writers() if the page is fully unlocked.

  So we know there is a delalloc range that needs to be run later.

- Save the @delalloc_end as @last_delalloc_end inside
  writepage_delalloc()
  Since subpage locked bitmap is only for ranges inside the page,
  meanwhile we can have delalloc range ends beyond our page boundary,
  we have to save the @last_delalloc_end just in case it's beyond our
  page boundary.

Although there is one extra point to notice:

- We need to handle errors in previous iteration
  Since we can have multiple locked delalloc ranges thus we have to call
  run_delalloc_ranges() multiple times.
  If we hit an error half way, we still need to unlock the remaining
  ranges.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 77 ++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/subpage.c   |  6 ++++
 2 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8a4a7d00795f..b6dc9308105d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1226,13 +1226,22 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc)
 {
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
+	struct folio *folio = page_folio(page);
 	const u64 page_start = page_offset(page);
 	const u64 page_end = page_start + PAGE_SIZE - 1;
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
 
+	/* Lock all (subpage) dealloc ranges inside the page first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
 		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
@@ -1240,15 +1249,68 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
-
-		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
-					       delalloc_end, wbc);
-		if (ret < 0)
-			return ret;
-
+		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
+					    min(delalloc_end, page_end) + 1 -
+					    delalloc_start);
+		last_delalloc_end = delalloc_end;
 		delalloc_start = delalloc_end + 1;
 	}
+	delalloc_start = page_start;
+	/* Run the delalloc ranges for above locked ranges. */
+	while (last_delalloc_end && delalloc_start < page_end) {
+		u64 found_start;
+		u32 found_len;
+		bool found;
 
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
+		}
+		if (!found)
+			break;
+		/*
+		 * The subpage range covers the last sector, the delalloc range may
+		 * end beyonds the page boundary, use the saved delalloc_end
+		 * instead.
+		 */
+		if (found_start + found_len >= page_end)
+			found_len = last_delalloc_end + 1 - found_start;
+
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
+	}
+	if (ret < 0)
+		return ret;
+
+	if (last_delalloc_end)
+		delalloc_end = last_delalloc_end;
+	else
+		delalloc_end = page_end;
 	/*
 	 * delalloc_end is already one less than the total length, so
 	 * we don't subtract one from PAGE_SIZE
@@ -1520,7 +1582,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
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


