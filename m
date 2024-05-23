Return-Path: <linux-btrfs+bounces-5243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404518CCCBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 09:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B179D1F21FF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C913CA9C;
	Thu, 23 May 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I87XDzTK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I87XDzTK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC413C9AD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447985; cv=none; b=CDiNN5fqU1V4gsPLHddGdrJ0Yj/66EuUwliDJiccIAdsndCs15lCYsmpM1BpDao+FadwcWhvBDooIDfoHo5h781BBfsGncv0KuuNV6KKCi9Sz9/w71yw6woTrpSSp068RPnMtfXyiW8/O3e1PzwgYRC3C7JEqBhC3ixF+41FDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447985; c=relaxed/simple;
	bh=R/4/YeYrLs/yPGHvImvZSMu7LTXDu53uH9Ony4z4Tqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcfGtkHiJTuIahrm/zJJKV5rNFSpY42dBBy4s1AZf5fRZwcrpaqMyT5X0uZRDcNBiBcr2cw5C42XduzBrghB2WIbme/AbEu8wIo+3+bKMsfZBAyr4UPeoHp5/ZR2juz4v7Pha64Sk0Z6haiFMQP1czD3RtO+DfNXBCFP358XWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I87XDzTK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I87XDzTK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3EE1FF7B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lrEdGRguSPR4qShMLKko8CWKzzucT2T64fHN+EuuOI=;
	b=I87XDzTKP9u7+TuhcfRf0S+j8+OvCeS8Uqf8xU/iDxQyD8jwK9Vvhufp6D2sgcVbE6dkRz
	DveHm/vJpYbm9no7UfPwA9ivfHHm6dTjyYi1pUsDjfK9pPrMfTkg7PjMy0Pwh4inIWxq/i
	RTJsaw6anJLuXrBf2ZiZUfaEAB/WEI8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lrEdGRguSPR4qShMLKko8CWKzzucT2T64fHN+EuuOI=;
	b=I87XDzTKP9u7+TuhcfRf0S+j8+OvCeS8Uqf8xU/iDxQyD8jwK9Vvhufp6D2sgcVbE6dkRz
	DveHm/vJpYbm9no7UfPwA9ivfHHm6dTjyYi1pUsDjfK9pPrMfTkg7PjMy0Pwh4inIWxq/i
	RTJsaw6anJLuXrBf2ZiZUfaEAB/WEI8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B34513A7D
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDP0M+bqTmb0bwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 3/5] btrfs: lock subpage ranges in one go for writepage_delalloc()
Date: Thu, 23 May 2024 16:35:44 +0930
Message-ID: <ba811149845a3a5ae5110020d400fe6c8841771e.1716445070.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716445070.git.wqu@suse.com>
References: <cover.1716445070.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
 fs/btrfs/extent_io.c | 104 ++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/subpage.c   |   6 +++
 2 files changed, 103 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 938061e0ce01..338067ce724a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1226,13 +1226,23 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc)
 {
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
+	struct folio *folio = page_folio(page);
+	const bool is_subpage = btrfs_is_subpage(fs_info, page->mapping);
 	const u64 page_start = page_offset(page);
 	const u64 page_end = page_start + PAGE_SIZE - 1;
+	/*
+	 * Saves the last found delalloc end. As the delalloc end can go beyond
+	 * page boundary, thus we can not rely on subpage bitmap to locate
+	 * the last delalloc end.
+	 */
+	u64 last_delalloc_end = 0;
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
 	int ret = 0;
 
+	/* Lock all (subpage) delalloc ranges inside the page first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
 		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
@@ -1240,15 +1250,94 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
 
+	if (!last_delalloc_end)
+		goto out;
+
+	/* Run the delalloc ranges for above locked ranges. */
+	while (delalloc_start < page_end) {
+		u64 found_start;
+		u32 found_len;
+		bool found;
+
+		if (!is_subpage) {
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
+		if (likely(ret >= 0)) {
+			/* No errors hit so far, run the current delalloc range. */
+			ret = btrfs_run_delalloc_range(inode, page, found_start,
+						       found_start + found_len - 1, wbc);
+		} else {
+			/*
+			 * We hit error during previous delalloc range, has to cleanup
+			 * the remaining locked ranges.
+			 */
+			unlock_extent(&inode->io_tree, found_start,
+				      found_start + found_len - 1, NULL);
+			__unlock_for_delalloc(&inode->vfs_inode, page, found_start,
+					      found_start + found_len - 1);
+		}
+
+		/*
+		 * We can hit btrfs_run_delalloc_range() with >0 return value.
+		 *
+		 * This happens when either the IO is already done and page
+		 * unlocked (inline) or the IO submission and page unlock would
+		 * be handled async (compression).
+		 *
+		 * Inline is only possible for regular sectorsize for now.
+		 *
+		 * Compression is possible for both subpage and regular cases,
+		 * but even for subpage compression only happens for page aligned
+		 * range, thus the found delalloc range must go beyond current
+		 * page.
+		 */
+		if (ret > 0)
+			ASSERT(!is_subpage || found_start + found_len >= page_end);
+
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
+out:
+	if (last_delalloc_end)
+		delalloc_end = last_delalloc_end;
+	else
+		delalloc_end = page_end;
 	/*
 	 * delalloc_end is already one less than the total length, so
 	 * we don't subtract one from PAGE_SIZE
@@ -1520,7 +1609,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
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
index 8bf83dd3313d..fe99a8ea94c0 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -868,6 +868,7 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio)
 {
+	struct btrfs_subpage *subpage = folio_get_private(folio);
 	u64 folio_start = folio_pos(folio);
 	u64 cur = folio_start;
 
@@ -877,6 +878,11 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
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
2.45.1


