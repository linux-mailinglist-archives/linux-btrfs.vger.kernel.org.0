Return-Path: <linux-btrfs+bounces-6776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60C93D924
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55F31F23B30
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58615351B;
	Fri, 26 Jul 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="P9vs0QUY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B2152160
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022636; cv=none; b=YQ4AVGwsKkS5FOUTMnDkxO8L/MSWGSTzY/3NDJg5Bw2entp76VILROar3UaJQuSdbmrM25LMu0eFA13oQW3NQKRbye4jI4bYsaOenVqCjYtY71Uw+m7QgMiM2THczTCo8ufdHCFlg0BfgdnZMlZYHq+vuHGU+RNpM1W0jIUsnNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022636; c=relaxed/simple;
	bh=WbKQNr3nFvtMUMDJ+qPYfoFfJeDxtvjxl32cHWMKx54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h51ID6yI3yUzAhcaTpGWIMRbgI3Yj6OaW6wak+P10uapZvqqe9OsQ4CfdVPzwHBYwEx0Zstgemti0JEprDr4pDP041IsMmEeM6GIH09qpox8vZtc+/zn+F6siNmMBoQeRdsS1idulg4Hxjwrg6p/6R0ODTUz5I5vIYHLu+cTZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=P9vs0QUY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65f8626780aso317817b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022634; x=1722627434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQJvLEfWkqq8rtFI9HcDlFrYqn6E4JTJ+NOi0KklxKc=;
        b=P9vs0QUY3Ncyc3z6vWrrhvVYenyCT6oT/bMgP4e8sWhnIhMlsC06/7yIXc2bdpodmH
         x4N1KPElh2ruOnz0EIOlYlWwbIWRlvoknbh4AGl5CNPznk1XqvMthWQ4uYUKehVNG2KY
         fVg7iKDyv1EcVm85GkBkYSHNKOjIvsfMyWzMT/ETvGSlAvPpZNbsOonAu9PDk79zg5lC
         oztdz4bFGwCRsPhAVoy8MeUY66NJ+CHZiVJa8A/BKDj1DCFFbknhkdilbIM0lw6MrHxF
         5/uhP7C4Uww0unmMvCGgEXKVAl+Tolp2rlgxsc6f+57roM8Atwxb9Ro0lxDaE8jdbeJN
         uoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022634; x=1722627434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQJvLEfWkqq8rtFI9HcDlFrYqn6E4JTJ+NOi0KklxKc=;
        b=BZfhQ//WlvfrqESrI6iobixWKHzngK8B4v9SOrPWMb6PAJNmmWJ+iSfZUvkRBGo37w
         PWJLHGQV2ezByusZwO57rOGok9XGxhctg2S/exXf//LUf4PX6NW4G0qNaD5s2QZdBcrq
         dKAJ/Fd6/BidNG0W7NfnAl3fIuralJYMBCncD60bL+h3AN5/TFtwE2VMv8dQdfWG7MVA
         h1133el5cLV7moNcNBzDDnam1J/I5P0hDXNYUU7dHGKd4I6XNnSSoMN17Fn9Mz/UtkFG
         FiCkomjLlnv3IIJhAiON8x7DtVRWDONzaKznkdJnfbzJ5NWf9lQ6PfigeHurWW4EIhHO
         GIbg==
X-Gm-Message-State: AOJu0Yzb/iy5ksezY0zKe4Yd826o7vezWf9vEn/GzmcyDdaOLF3WoEOj
	LLmMcbd/PI3cVw5tkImd01+JGcRX/kK7sruZvG2o82Qh7h5N4C36pxhNf2wy9HhkruX9A8ZRPdj
	0
X-Google-Smtp-Source: AGHT+IHQ/H+Ktou04IBt3iLugMSYtYrNYrAEiL4sw0HlcXsUk02gGk/DMpLfGIbAo++GujaM7BbMnQ==
X-Received: by 2002:a81:bb45:0:b0:664:f825:93ca with SMTP id 00721157ae682-67a085165f9mr9645157b3.25.1722022634311;
        Fri, 26 Jul 2024 12:37:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e824sm9962377b3.37.2024.07.26.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 35/46] btrfs: convert btrfs_writepage_fixup_worker to use a folio
Date: Fri, 26 Jul 2024 15:36:22 -0400
Message-ID: <8f66d16a4f3e23fdfe0aea25cc495c41cda1d4b6.1722022377.git.josef@toxicpanda.com>
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

This function heavily messes with pages, instead update it to use a
folio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 54 +++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 737af2d6bebe..cd1b3e956d7f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2708,49 +2708,51 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	struct page *page = fixup->page;
+	struct folio *folio = page_folio(page);
 	struct btrfs_inode *inode = fixup->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 page_start = page_offset(page);
-	u64 page_end = page_offset(page) + PAGE_SIZE - 1;
+	u64 page_start = folio_pos(folio);
+	u64 page_end = folio_pos(folio) + folio_size(folio) - 1;
 	int ret = 0;
 	bool free_delalloc_space = true;
 
 	/*
 	 * This is similar to page_mkwrite, we need to reserve the space before
-	 * we take the page lock.
+	 * we take the folio lock.
 	 */
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
-					   PAGE_SIZE);
+					   folio_size(folio));
 again:
-	lock_page(page);
+	folio_lock(folio);
 
 	/*
-	 * Before we queued this fixup, we took a reference on the page.
-	 * page->mapping may go NULL, but it shouldn't be moved to a different
+	 * Before we queued this fixup, we took a reference on the folio.
+	 * folio->mapping may go NULL, but it shouldn't be moved to a different
 	 * address space.
 	 */
-	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
+	if (!folio->mapping || !folio_test_dirty(folio) ||
+	    !folio_test_checked(folio)) {
 		/*
 		 * Unfortunately this is a little tricky, either
 		 *
-		 * 1) We got here and our page had already been dealt with and
+		 * 1) We got here and our folio had already been dealt with and
 		 *    we reserved our space, thus ret == 0, so we need to just
 		 *    drop our space reservation and bail.  This can happen the
 		 *    first time we come into the fixup worker, or could happen
 		 *    while waiting for the ordered extent.
-		 * 2) Our page was already dealt with, but we happened to get an
+		 * 2) Our folio was already dealt with, but we happened to get an
 		 *    ENOSPC above from the btrfs_delalloc_reserve_space.  In
 		 *    this case we obviously don't have anything to release, but
-		 *    because the page was already dealt with we don't want to
-		 *    mark the page with an error, so make sure we're resetting
+		 *    because the folio was already dealt with we don't want to
+		 *    mark the folio with an error, so make sure we're resetting
 		 *    ret to 0.  This is why we have this check _before_ the ret
 		 *    check, because we do not want to have a surprise ENOSPC
-		 *    when the page was already properly dealt with.
+		 *    when the folio was already properly dealt with.
 		 */
 		if (!ret) {
-			btrfs_delalloc_release_extents(inode, PAGE_SIZE);
+			btrfs_delalloc_release_extents(inode, folio_size(folio));
 			btrfs_delalloc_release_space(inode, data_reserved,
-						     page_start, PAGE_SIZE,
+						     page_start, folio_size(folio),
 						     true);
 		}
 		ret = 0;
@@ -2758,7 +2760,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	}
 
 	/*
-	 * We can't mess with the page state unless it is locked, so now that
+	 * We can't mess with the folio state unless it is locked, so now that
 	 * it is locked bail if we failed to make our space reservation.
 	 */
 	if (ret)
@@ -2767,14 +2769,14 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 
 	/* already ordered? We're done */
-	if (PageOrdered(page))
+	if (folio_test_ordered(folio))
 		goto out_reserved;
 
 	ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
 	if (ordered) {
 		unlock_extent(&inode->io_tree, page_start, page_end,
 			      &cached_state);
-		unlock_page(page);
+		folio_unlock(folio);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
@@ -2792,7 +2794,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 *
 	 * The page was dirty when we started, nothing should have cleaned it.
 	 */
-	BUG_ON(!PageDirty(page));
+	BUG_ON(!folio_test_dirty(folio));
 	free_delalloc_space = false;
 out_reserved:
 	btrfs_delalloc_release_extents(inode, PAGE_SIZE);
@@ -2806,14 +2808,14 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * We hit ENOSPC or other errors.  Update the mapping and page
 		 * to reflect the errors and clean the page.
 		 */
-		mapping_set_error(page->mapping, ret);
-		btrfs_mark_ordered_io_finished(inode, page_folio(page),
-					       page_start, PAGE_SIZE, !ret);
-		clear_page_dirty_for_io(page);
+		mapping_set_error(folio->mapping, ret);
+		btrfs_mark_ordered_io_finished(inode, folio, page_start,
+					       folio_size(folio), !ret);
+		folio_clear_dirty_for_io(folio);
 	}
-	btrfs_folio_clear_checked(fs_info, page_folio(page), page_start, PAGE_SIZE);
-	unlock_page(page);
-	put_page(page);
+	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
+	folio_unlock(folio);
+	folio_put(folio);
 	kfree(fixup);
 	extent_changeset_free(data_reserved);
 	/*
-- 
2.43.0


