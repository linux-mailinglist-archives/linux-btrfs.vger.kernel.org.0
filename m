Return-Path: <linux-btrfs+bounces-6758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECB93D912
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56161C224BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D5149E0A;
	Fri, 26 Jul 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0OPHXX/V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2981149DF8
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022618; cv=none; b=pnC70GFkf6JrI3soa59WcEIn0riqZfDlZcujHiis2R840Bi5oImrMQsA6L2Mkt/jTvbIploL6g4U2tOvY/e/YXtIcVccUhGMYTKFJ0wI8zcEv912ztAJOGuZDn5UPtBdPkDlnUqFEMaUx1uiqB/4vI/PlD9FHmf50JaM2D+X2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022618; c=relaxed/simple;
	bh=EQLT9UHl2BuRaB4EnsHxnSlmspZ9yLCIcp8BqcZJkKY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJvYbbNPCaCkStOc3NCJrpikzjdAqB7ULjLOs3E8Hujxi1vOZKbd/llbCRGg2dTRDg3BCHeke/LYpjcwYjH4HwB+w/VXTVSymejO9XDmFB2zJypvAvi/+fO/bkt810iN7xliLEt+29k+mTnd2rDgODY6yPMwTiwih/mnsBQe35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0OPHXX/V; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-663dd13c0bbso430937b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022615; x=1722627415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbayNxnh4cJQ1XDfQFZ8ECG4+Cqe8aWPiSA4REoJK/0=;
        b=0OPHXX/V/j/u+5CG3JlTVxox4mH6gMLuG5DK6KzQyDHEkGlOgubO9xSB3pg0x86aW9
         7bkuvIKqBy1rrf9BXhmP58QFRbgfGm08lRv5VOJApOlAeAK5/5ggNpmQgk7lcFqs9Il9
         jifIVCjJCwFAPZRPYdte4Ro8i2MKWCFMp0ROC3p8Tzh7bwKIE2cvf7dTnAaI5j1SZZMG
         gYgrpHxLNPilJHxapbeCw72mr9LLrbvjZUAz74KwBeUjLDfOI+1xpHboF7S58z9sVAQf
         P58dO3HlH5kh/vRuJdespduVqTF14WKUbvMbzJo0Z2M47w2EEoKGb6/CLNBiy8Bq0wqP
         iwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022615; x=1722627415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbayNxnh4cJQ1XDfQFZ8ECG4+Cqe8aWPiSA4REoJK/0=;
        b=dYIFSQdq/1zN1TNpCNgCRTJn3Kvq1lSWqeOlizuOHXFfkbS+onMoy1d2RdouhJnkOh
         2/kEYDQ7Bhsq9dGw1rvfkmW9ZKENXygMxviPa+NsqGn/vk/q25obDxosaFE+q/2+FzKQ
         5DstNfotDhmz5h61zqMonAj8FOZgRbT5ZYcBBGeD2tQL4uVXmMdFITmFi2SR23vjugjh
         b4ve46YFwjc5uqaA0F89vH/ah3xtmtyxg4daMdPuMBXmfGEH33BdZMrUV1rgdvCDVokQ
         Q+iO2LbcNlAOZbaVIYgCxDwyJ7lYk830zgUq927OZzJfvOwtawo2T3TWw53MfwAVqyCo
         /gNg==
X-Gm-Message-State: AOJu0Yz2xRvCVuAirQfPaCZjRxwTZA7pVPTkb+nsDfxaR0E9YKtx9P/P
	XNM3zvgZ2RN/VvvAfNfThjxNTZ+UpfD1yAvOpZdSoSZYxDGX8kvszV4jPqMXHycVFsB/HLMt8qz
	C
X-Google-Smtp-Source: AGHT+IEESv7bODAkIcxl0a31wYu7lpmAyG5AU95psCN2JUyvTMylpLN5itvBDkS7Np0cCrUxqycNCQ==
X-Received: by 2002:a05:690c:3346:b0:632:7161:d16c with SMTP id 00721157ae682-67a090a5e7dmr9535427b3.28.1722022615412;
        Fri, 26 Jul 2024 12:36:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd90dcsm10109327b3.1.2024.07.26.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 17/46] btrfs: convert find_lock_delalloc_range to use a folio
Date: Fri, 26 Jul 2024 15:36:04 -0400
Message-ID: <cf41ce4033628f869f482f1ad5a3e5dd2b1b1ee7.1722022376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing in a page for locked_page, pass in the folio instead.
We only use the folio itself to validate some range assumptions, and
then pass it into other functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c             | 28 ++++++++++++++--------------
 fs/btrfs/extent_io.h             |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 10 +++++-----
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 382558fe1032..def12bb8b34d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -304,8 +304,8 @@ static noinline int lock_delalloc_pages(struct inode *inode,
  */
 EXPORT_FOR_TESTS
 noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
-				    struct page *locked_page, u64 *start,
-				    u64 *end)
+						 struct folio *locked_folio,
+						 u64 *start, u64 *end)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
@@ -323,9 +323,9 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* Caller should pass a valid @end to indicate the search range end */
 	ASSERT(orig_end > orig_start);
 
-	/* The range should at least cover part of the page */
-	ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
-		 orig_end <= page_offset(locked_page)));
+	/* The range should at least cover part of the folio */
+	ASSERT(!(orig_start >= folio_pos(locked_folio) + folio_size(locked_folio) ||
+		 orig_end <= folio_pos(locked_folio)));
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
@@ -342,25 +342,25 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	}
 
 	/*
-	 * start comes from the offset of locked_page.  We have to lock
-	 * pages in order, so we can't process delalloc bytes before
-	 * locked_page
+	 * start comes from the offset of locked_folio.  We have to lock
+	 * folios in order, so we can't process delalloc bytes before
+	 * locked_folio
 	 */
 	if (delalloc_start < *start)
 		delalloc_start = *start;
 
 	/*
-	 * make sure to limit the number of pages we try to lock down
+	 * make sure to limit the number of folios we try to lock down
 	 */
 	if (delalloc_end + 1 - delalloc_start > max_bytes)
 		delalloc_end = delalloc_start + max_bytes - 1;
 
-	/* step two, lock all the pages after the page that has start */
-	ret = lock_delalloc_pages(inode, locked_page,
+	/* step two, lock all the folioss after the folios that has start */
+	ret = lock_delalloc_pages(inode, &locked_folio->page,
 				  delalloc_start, delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
-		/* some of the pages are gone, lets avoid looping by
+		/* some of the folios are gone, lets avoid looping by
 		 * shortening the size of the delalloc range we're searching
 		 */
 		free_extent_state(cached_state);
@@ -384,7 +384,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 	unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
-		__unlock_for_delalloc(inode, locked_page,
+		__unlock_for_delalloc(inode, &locked_folio->page,
 			      delalloc_start, delalloc_end);
 		cond_resched();
 		goto again;
@@ -1209,7 +1209,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
-		if (!find_lock_delalloc_range(&inode->vfs_inode, &folio->page,
+		if (!find_lock_delalloc_range(&inode->vfs_inode, folio,
 					      &delalloc_start, &delalloc_end)) {
 			delalloc_start = delalloc_end + 1;
 			continue;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index dceebd76c7d1..1dd295e1b5a5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -368,7 +368,7 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-			     struct page *locked_page, u64 *start,
+			      struct folio *locked_folio, u64 *start,
 			     u64 *end);
 #endif
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 865d4af4b303..0a2dbfaaf49e 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -180,7 +180,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL);
 	start = 0;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, locked_page, &start,
+	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
 					 &end);
 	if (!found) {
 		test_err("should have found at least one delalloc");
@@ -211,7 +211,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, locked_page, &start,
+	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
 					 &end);
 	if (!found) {
 		test_err("couldn't find delalloc in our range");
@@ -245,7 +245,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	}
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, locked_page, &start,
+	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
 					 &end);
 	if (found) {
 		test_err("found range when we shouldn't have");
@@ -266,7 +266,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
-	found = find_lock_delalloc_range(inode, locked_page, &start,
+	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
 					 &end);
 	if (!found) {
 		test_err("didn't find our range");
@@ -307,7 +307,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 	 * this changes at any point in the future we will need to fix this
 	 * tests expected behavior.
 	 */
-	found = find_lock_delalloc_range(inode, locked_page, &start,
+	found = find_lock_delalloc_range(inode, page_folio(locked_page), &start,
 					 &end);
 	if (!found) {
 		test_err("didn't find our range");
-- 
2.43.0


