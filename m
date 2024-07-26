Return-Path: <linux-btrfs+bounces-6757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E48AC93D911
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C84E1F248F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F913AD23;
	Fri, 26 Jul 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KodP7esd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47218149C79
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022616; cv=none; b=U3KCYJdgvFmy82s+5LlTnqlPWWvf20FJ337XDSqVtgUDttyPgNpSiteUBY4KLmXCGZF3ro0LSG4JxWScxdk0e6zUceS0GoZeHiEaNf8lxBnx4xTP9dwpatR+uVsI56E3ezf9bPRsr52QG3j4IDN86BngFfIdl7QmrU1DQYtf28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022616; c=relaxed/simple;
	bh=z0J9OLU/Qf9HSdUgztK/1/M8Ro0zZ+5iF3X8mvsFDlE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndmQXftUHoojRKtHnOTi0tJT3J4kB1fXYdXJs3PH+9+MFieTLD+2u6K6bbs5FkMht1eC3yRdfoc8ueb5BcAsS1p1iOg80IDm01A+QSmNbSQpnbNNU5JwCVEoYGAiNKAvV7bCpzNzgaLaH4W+WRJFa/aHi2IiS604X/3pq3GDW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KodP7esd; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66526e430e0so373817b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022614; x=1722627414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mryCiiI3DzqdyEiwL6B0Sb6EH1sXDmGlzAexz+XtQuQ=;
        b=KodP7esd4MwhiEv849MN0qSCFINePf5ojjg4bgt0JjssPwagQT4blKvgylmnwCE7OL
         fXFHJ+972bcxHRR3lG0vmj9PlAA6zw5dXcWJNopt3Kacui80ew+L+KPPKbanONtDwO+q
         jiYbPDLMSnAcjqvuSUG0iUjP2AdDOKlvjlmiTQ4x4viUO2GPAMlabCWxWh3c0nRy67zv
         dYII0gTCZMMgNDb1buj5JmCkpHkNuL0RpjHiYJm6U4at/kPG6fKSIWM1KKnmhspFvR85
         1GMcYr3ZG6RpqSZJjEbPljf1N5olOrQ0DFJKqbx5dG7pgA/o0KTCHAuYgrPBwnLi+lYd
         RfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022614; x=1722627414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mryCiiI3DzqdyEiwL6B0Sb6EH1sXDmGlzAexz+XtQuQ=;
        b=BAZ1MiWwXU3jwZndcI9z8WlfyUNTcelbcBDtOIKs7Q5eo90+L1UIuGUUKOzK4SJ1PF
         NdPm6aTHNxTFIQzdU1WFNC6/vDM1WZvQ7aMYHz7ayPq0A7aI4xzbNx+xEXYa5tsh+eLA
         00SO8w8sxjMR6YVSI+YhdT+YQAB5jVczA81J9a7FJ98ZrtbX9RxPiFmjKH24UljTDpM5
         2ICS+Mx6ULK5Kua4rqZDGSnnU5g2ecZ9c56xpkjcMSttMbK68VuhRBG2UICAZO4fVKtj
         6gZBs9qBYxXwkDuG+pKBDWO6A2ZC88Ar1zuOiz2gOxNNUDw3tHNSUVY9CrLhfZPOE6WG
         Iy9Q==
X-Gm-Message-State: AOJu0Yy5eBeg44Qtaj44ZMrCFSGqfPtm2hgTA4lHXXiCMXi8iWX5xuJ1
	29XuLYVGLmWU7sSctVWbLrp8iKGOm0O69/DCQolElE8Pyl6IW1iEt93urW27GD9/CZSRYuDEHxQ
	w
X-Google-Smtp-Source: AGHT+IHJUkgmwGaAPR1Unr4ITZeeDTOAXd9Pz7JauekhKJAAfzaz2oSiTF4TO5lxpvEXD1D1z26/FA==
X-Received: by 2002:a0d:d206:0:b0:64b:8e82:1f9 with SMTP id 00721157ae682-67a0644372amr9395887b3.18.1722022614181;
        Fri, 26 Jul 2024 12:36:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024d7bsm10044287b3.83.2024.07.26.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 16/46] btrfs: convert writepage_delalloc to take a folio
Date: Fri, 26 Jul 2024 15:36:03 -0400
Message-ID: <0d68fc276f4b7a6983008a8e4ee4cd7fe4491a4d.1722022376.git.josef@toxicpanda.com>
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

We already use a folio heavily in this function, pass the folio in
directly and use it everywhere, only passing the page down to functions
that do not take a folio yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 56bf87ac5f6c..382558fe1032 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1188,13 +1188,13 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
  * This returns < 0 if there were errors (page still locked)
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
-		struct page *page, struct writeback_control *wbc)
+						 struct folio *folio,
+						 struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
-	struct folio *folio = page_folio(page);
-	const bool is_subpage = btrfs_is_subpage(fs_info, page->mapping);
-	const u64 page_start = page_offset(page);
-	const u64 page_end = page_start + PAGE_SIZE - 1;
+	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
+	const u64 page_start = folio_pos(folio);
+	const u64 page_end = page_start + folio_size(folio) - 1;
 	/*
 	 * Save the last found delalloc end. As the delalloc end can go beyond
 	 * page boundary, thus we cannot rely on subpage bitmap to locate the
@@ -1206,10 +1206,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_to_write = 0;
 	int ret = 0;
 
-	/* Lock all (subpage) delalloc ranges inside the page first. */
+	/* Lock all (subpage) delalloc ranges inside the folio first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
-		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
+		if (!find_lock_delalloc_range(&inode->vfs_inode, &folio->page,
 					      &delalloc_start, &delalloc_end)) {
 			delalloc_start = delalloc_end + 1;
 			continue;
@@ -1234,7 +1234,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		if (!is_subpage) {
 			/*
 			 * For non-subpage case, the found delalloc range must
-			 * cover this page and there must be only one locked
+			 * cover this folio and there must be only one locked
 			 * delalloc range.
 			 */
 			found_start = page_start;
@@ -1248,7 +1248,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			break;
 		/*
 		 * The subpage range covers the last sector, the delalloc range may
-		 * end beyond the page boundary, use the saved delalloc_end
+		 * end beyond the folio boundary, use the saved delalloc_end
 		 * instead.
 		 */
 		if (found_start + found_len >= page_end)
@@ -1256,7 +1256,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 		if (ret >= 0) {
 			/* No errors hit so far, run the current delalloc range. */
-			ret = btrfs_run_delalloc_range(inode, page, found_start,
+			ret = btrfs_run_delalloc_range(inode, &folio->page,
+						       found_start,
 						       found_start + found_len - 1,
 						       wbc);
 		} else {
@@ -1266,15 +1267,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			 */
 			unlock_extent(&inode->io_tree, found_start,
 				      found_start + found_len - 1, NULL);
-			__unlock_for_delalloc(&inode->vfs_inode, page, found_start,
+			__unlock_for_delalloc(&inode->vfs_inode, &folio->page,
+					      found_start,
 					      found_start + found_len - 1);
 		}
 
 		/*
 		 * We can hit btrfs_run_delalloc_range() with >0 return value.
 		 *
-		 * This happens when either the IO is already done and page
-		 * unlocked (inline) or the IO submission and page unlock would
+		 * This happens when either the IO is already done and folio
+		 * unlocked (inline) or the IO submission and folio unlock would
 		 * be handled as async (compression).
 		 *
 		 * Inline is only possible for regular sectorsize for now.
@@ -1282,14 +1284,14 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		 * Compression is possible for both subpage and regular cases,
 		 * but even for subpage compression only happens for page aligned
 		 * range, thus the found delalloc range must go beyond current
-		 * page.
+		 * folio.
 		 */
 		if (ret > 0)
 			ASSERT(!is_subpage || found_start + found_len >= page_end);
 
 		/*
-		 * Above btrfs_run_delalloc_range() may have unlocked the page,
-		 * thus for the last range, we cannot touch the page anymore.
+		 * Above btrfs_run_delalloc_range() may have unlocked the folio,
+		 * thus for the last range, we cannot touch the folio anymore.
 		 */
 		if (found_start + found_len >= last_delalloc_end + 1)
 			break;
@@ -1312,7 +1314,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 	/*
 	 * If btrfs_run_dealloc_range() already started I/O and unlocked
-	 * the pages, we just need to account for them here.
+	 * the folios, we just need to account for them here.
 	 */
 	if (ret == 1) {
 		wbc->nr_to_write -= delalloc_to_write;
@@ -1549,7 +1551,7 @@ static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ct
 	if (ret < 0)
 		goto done;
 
-	ret = writepage_delalloc(BTRFS_I(inode), &folio->page, bio_ctrl->wbc);
+	ret = writepage_delalloc(BTRFS_I(inode), folio, bio_ctrl->wbc);
 	if (ret == 1)
 		return 0;
 	if (ret)
-- 
2.43.0


