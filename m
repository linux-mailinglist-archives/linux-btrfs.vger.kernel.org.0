Return-Path: <linux-btrfs+bounces-6767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E031E93D91B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB11F24914
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4733D14D433;
	Fri, 26 Jul 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="j0on9Cx+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B314B07E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022627; cv=none; b=JvBzfbHz4FnL2XNlyEiIhiKmdz55eFEwG9qlj74+3smJLfmr+wfEuKhl1RzwIpDPu/+akB6MFbILw+bx9PdeSA8MArCbJXRjcbHREE8ymlnyo3eNgpaNgsZnngkjwJnZKJp9B+hy6yqaRB9IK6SZ6pOtPIb43UiGtYaKZ22i+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022627; c=relaxed/simple;
	bh=vXyvCy9R3VXC6mPRxu++SmDUun7t57RrlhAOIT8TxcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRvKl9wzd6JYqPd2rQR4mesP5cEGHQVKTMPlHu1Q+m6m00iShU6lEo4UpRoeoSEKDCUdogQBJqIMUJ3nECz786AVOtHTdOmAbQqBHhtds83vFO1vdHcxNe/MNOr2pMbSS/T4udCBofpAgJ0ekOGL3cwCvD9OvHdiYAguwYW1wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=j0on9Cx+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66ca536621cso369297b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022625; x=1722627425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhWXIGntr/PMq1tVx+zlZ/pm4fOlxeQXlCf+Q9Tbx04=;
        b=j0on9Cx+KdTKgL8QqR5BwDkgMLnlC7tee2miIWNVrsmVytYxqF8S6nGx1IFC5Bkv3d
         wHfQCINvnuMs+0nOQ0RW4frwYJN0Sp90prMZ+htnuNofWXcEoeI2lhOAGnkMAtRvTM/Q
         tLKChpgJFwXJmaaK7bnvH/3MhLNG+FimCyf4Rw+Cm/8HFU43vGlQsncn6Al5mljCAeRa
         CXBKzT+RIrMz9oBbRPXqYjnqimLv/UvoxjV49QvBmOImKABmkHaMNmEz+Z5mqlGm+KrL
         jQP6uCN524MjREIb0KO4Ad6K5WPJ+Bg9VyEjdHwzrG998jKKTyn6aBNSMKKxntpEcG/l
         f/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022625; x=1722627425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhWXIGntr/PMq1tVx+zlZ/pm4fOlxeQXlCf+Q9Tbx04=;
        b=mzJnXQXR1NBvsz+ypIJOH1T9gIA6AuC4jllALFSChbtt49ng16mOWYh+LbeZTG1QaX
         SU0CZoqcBQRXbigxC4oTB2NeYFtzV00kyldwLg6LCK13mV7hJ9gPCaisI2L0qS11Ob9m
         PQrm4rL1RbHGnbKbRhLJe9LiXaVA2Lwgo9Ku4h53o5t3kRh69cA7i3HeL7B5KVz3l7uu
         98BZbZkBKAnk/cK+AtjpqVuJ1rBw3kyPya80wYwU4wQHsh21DRIgf3FwAiwudVeCW8Wl
         WaJjNfB4m7KMuE963J/vld3X7zTyn7ghmuNDetIzMFaPgs1p3J41W+nUui1bZh6MFOiG
         Rk/w==
X-Gm-Message-State: AOJu0YzAm+UW+hN8GcrccN9KtZkhNK/QlRlmbwAhTQneItbFL/CMTqlA
	yxajdN6bt99y7+YOI9K0xyTP8xdr2dvAcyttAOGXJhLCdiI+rXPvWosGs9gzd3nK4x0KdXlFYdW
	T
X-Google-Smtp-Source: AGHT+IGTplk3+d2nGjdAOPwplc+F9StrfP+fcANMVsx26/93lRxO1S3GgEgyBBYJ0XZoYM7huanNXQ==
X-Received: by 2002:a05:690c:3346:b0:632:7161:d16c with SMTP id 00721157ae682-67a090a5e7dmr9539897b3.28.1722022624823;
        Fri, 26 Jul 2024 12:37:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024a59sm9929857b3.92.2024.07.26.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 26/46] btrfs: convert cow_file_range to take a folio
Date: Fri, 26 Jul 2024 15:36:13 -0400
Message-ID: <bc37f6c805d3195479dba308c8a34779edcbdabe.1722022377.git.josef@toxicpanda.com>
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

Convert this to take a folio and pass it into all of the various cleanup
functions.  Update the callers to pass in a folio instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7f2875c99883..9fc15b881dba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1307,21 +1307,21 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * allocate extents on disk for the range, and create ordered data structs
  * in ram to track those extents.
  *
- * locked_page is the page that writepage had locked already.  We use
+ * locked_folio is the folio that writepage had locked already.  We use
  * it to make sure we don't do extra locks or unlocks.
  *
- * When this function fails, it unlocks all pages except @locked_page.
+ * When this function fails, it unlocks all pages except @locked_folio.
  *
  * When this function successfully creates an inline extent, it returns 1 and
- * unlocks all pages including locked_page and starts I/O on them.
- * (In reality inline extents are limited to a single page, so locked_page is
+ * unlocks all pages including locked_folio and starts I/O on them.
+ * (In reality inline extents are limited to a single page, so locked_folio is
  * the only page handled anyway).
  *
  * When this function succeed and creates a normal extent, the page locking
  * status depends on the passed in flags:
  *
  * - If @keep_locked is set, all pages are kept locked.
- * - Else all pages except for @locked_page are unlocked.
+ * - Else all pages except for @locked_folio are unlocked.
  *
  * When a failure happens in the second or later iteration of the
  * while-loop, the ordered extents created in previous iterations are kept
@@ -1330,8 +1330,8 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * example.
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
-				   struct page *locked_page, u64 start, u64 end,
-				   u64 *done_offset,
+				   struct folio *locked_folio, u64 start,
+				   u64 end, u64 *done_offset,
 				   bool keep_locked, bool no_inline)
 {
 	struct btrfs_root *root = inode->root;
@@ -1364,9 +1364,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	if (!no_inline) {
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, page_folio(locked_page),
-					    start, end, 0, BTRFS_COMPRESS_NONE,
-					    NULL, false);
+		ret = cow_file_range_inline(inode, locked_folio, start, end, 0,
+					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret <= 0) {
 			/*
 			 * We succeeded, return 1 so the caller knows we're done
@@ -1502,7 +1501,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		page_ops |= PAGE_SET_ORDERED;
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
-					     page_folio(locked_page), &cached,
+					     locked_folio, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
 		if (num_bytes < cur_alloc_size)
@@ -1555,14 +1554,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * function.
 	 *
 	 * However, in case of @keep_locked, we still need to unlock the pages
-	 * (except @locked_page) to ensure all the pages are unlocked.
+	 * (except @locked_folio) to ensure all the pages are unlocked.
 	 */
 	if (keep_locked && orig_start < start) {
-		if (!locked_page)
+		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
-					     page_folio(locked_page), NULL, 0,
-					     page_ops);
+					     locked_folio, NULL, 0, page_ops);
 	}
 
 	/*
@@ -1585,8 +1583,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
 					     start + cur_alloc_size - 1,
-					     page_folio(locked_page), &cached,
-					     clear_bits,
+					     locked_folio, &cached, clear_bits,
 					     page_ops);
 		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 		start += cur_alloc_size;
@@ -1600,9 +1597,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 */
 	if (start < end) {
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
-		extent_clear_unlock_delalloc(inode, start, end,
-					     page_folio(locked_page), &cached,
-					     clear_bits, page_ops);
+		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
+					     &cached, clear_bits, page_ops);
 		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 	}
 	return ret;
@@ -1755,7 +1751,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 	int ret;
 
 	while (start <= end) {
-		ret = cow_file_range(inode, &locked_folio->page, start, end,
+		ret = cow_file_range(inode, locked_folio, start, end,
 				     &done_offset, true, false);
 		if (ret)
 			return ret;
@@ -1837,7 +1833,8 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	 * is written out and unlocked directly and a normal NOCOW extent
 	 * doesn't work.
 	 */
-	ret = cow_file_range(inode, locked_page, start, end, NULL, false, true);
+	ret = cow_file_range(inode, page_folio(locked_page), start, end, NULL,
+			     false, true);
 	ASSERT(ret != 1);
 	return ret;
 }
@@ -2314,8 +2311,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		ret = run_delalloc_cow(inode, page_folio(locked_page), start,
 				       end, wbc, true);
 	else
-		ret = cow_file_range(inode, locked_page, start, end, NULL,
-				     false, false);
+		ret = cow_file_range(inode, page_folio(locked_page), start, end,
+				     NULL, false, false);
 
 out:
 	if (ret < 0)
-- 
2.43.0


