Return-Path: <linux-btrfs+bounces-6777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D893D925
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B5A1F232F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99135153812;
	Fri, 26 Jul 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yO8/h7VA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F048558B7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022637; cv=none; b=ACWCEW8M7Ovwgs8AIRCjHXr3p7qGvYqteo+VRXAygWFMAACf+Uq1Y0kR3zL4ClesLZF1GfBei8zxqaUHpI4nHOGO2uizB5g5mseLDI4fH2IXIUZxglPLTV7CpLA9/nytDlVnQFcVtj3B140LYhMImZ/UZpTah3Zmyly3rRfMQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022637; c=relaxed/simple;
	bh=XqlwfmaVFe5J+bolmgGWz9FxsVuxHx0lGymGjzEj6Is=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e38Aje6JBT9LgmiMgxOgEgxWUJrlZ3Ap0ghdZJfXDL8Ooq4lRVsHXr7LgZTCvp4hRNWUAfo07YFs5RNZwmdmjYsWjxw49NRm1Fxx8jLLEl0bTtSAW8nR1pyi+axr5fXLCt7RzT62RIMsCVMW3rvuFwOCuzI1yhECJgOYJ7NTJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yO8/h7VA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66c7aeac627so407717b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022635; x=1722627435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eh9WsK9vEEAqGZ1xnhkwRSbLe82fmh0xBBwzgDkxLQI=;
        b=yO8/h7VA/nDSrrOKIvVgzbyiQonVIlCjCmUz/GxLhly1xfvpkVkGPzdC9W8devoa3b
         bcyJui1OPyGoAW+S07JiuFAtc6wleF2JcMl6n+Anc5B0fwSYGP6CpeXayXQ+tDUiDKqr
         yByJB4OHWvMoEPVvW7ObaI7b21cbvPytH2VryWCZlWHrvb96ASGINufmg3fvfpB7mRy+
         41NmEJPE8iP86KJULj3DE7oAPDKs2KOXDFurVd2ymlb9nWWWCCZfK0NtDX/+IpOR7uU5
         db7ft2RnFdd7ZSpKWdhD4FOPqWIaAZJ4WapsE/IeV8vHSAALxoF15W8uHIfA4PBYcjwq
         45AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022635; x=1722627435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh9WsK9vEEAqGZ1xnhkwRSbLe82fmh0xBBwzgDkxLQI=;
        b=m2LLnNZiEUoLAhRE+FRl9WlZKa7LH9Hat3rZ2eRsIHg4NO5c21MP3rcyfugdaypnFG
         54ezccl3wo+SDbfu/wbFtexLxz7snp1b2EdCBKDWQbEvVmOA+66lWescjpuMxU892zkv
         BTkmuVpjyZLy3vStI/EUBva7TnXeGDQb89VOz18qMVr7ts/D3sgiTdzuewTwmdQ4Iqwm
         kyI99gAJBMbm8fLhWQqhLReWVTATuSmYIHj2cKWl9dged93Obox73Z0JyiGt9W7RulQq
         h0KaNrNwHEA/Um5oSIyABjcVPjXCMNLNEzJ1j8c71n+3UTinUPqYNR2qe996w+SqWO18
         umyA==
X-Gm-Message-State: AOJu0YxMxGosQFGGCIB/XK4SrfcO63ituEcRuFZZRQjM9sSfeRUVmOnd
	iriYZFF+wzxUjGsckejdqjlD/Ma8KTSzs0DzDcnUYUgRQmpYqWhZ1e+e2iVPIagn3im3m37IGHi
	H
X-Google-Smtp-Source: AGHT+IEmRXQd8nq9bFqVylIvJXqMPRKM2whNd+AdA3JCY8ecz+zcKcKGQ3NSI0LYytj/ttm4kdu6Kw==
X-Received: by 2002:a0d:ef01:0:b0:64b:7e17:b339 with SMTP id 00721157ae682-67a06edcc9amr9399367b3.15.1722022635459;
        Fri, 26 Jul 2024 12:37:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8feasm9936407b3.18.2024.07.26.12.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 36/46] btrfs: convert btrfs_writepage_cow_fixup to use folio
Date: Fri, 26 Jul 2024 15:36:23 -0400
Message-ID: <731f88d939012cbde09a45ec30b0235134060336.1722022377.git.josef@toxicpanda.com>
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

Instead of a page, use a folio for btrfs_writepage_cow_fixup.  We
already have a folio at the only caller, and the fixup worker uses
folios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       | 31 ++++++++++++++++---------------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 5599b458a9a9..fc60c0cde479 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -598,7 +598,7 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 				    loff_t actual_len, u64 *alloc_hint);
 int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_folio,
 			     u64 start, u64 end, struct writeback_control *wbc);
-int btrfs_writepage_cow_fixup(struct page *page);
+int btrfs_writepage_cow_fixup(struct folio *folio);
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 					     int compress_type);
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f46a85888b9..ab5715de5f40 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1410,7 +1410,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	ASSERT(start >= folio_pos(folio) &&
 	       start + len <= folio_pos(folio) + folio_size(folio));
 
-	ret = btrfs_writepage_cow_fixup(&folio->page);
+	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret) {
 		/* Fixup worker will requeue */
 		folio_redirty_for_writepage(bio_ctrl->wbc, folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cd1b3e956d7f..9234ae84175a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2828,33 +2828,34 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 
 /*
  * There are a few paths in the higher layers of the kernel that directly
- * set the page dirty bit without asking the filesystem if it is a
+ * set the folio dirty bit without asking the filesystem if it is a
  * good idea.  This causes problems because we want to make sure COW
  * properly happens and the data=ordered rules are followed.
  *
  * In our case any range that doesn't have the ORDERED bit set
  * hasn't been properly setup for IO.  We kick off an async process
  * to fix it up.  The async helper will wait for ordered extents, set
- * the delalloc bit and make it safe to write the page.
+ * the delalloc bit and make it safe to write the folio.
  */
-int btrfs_writepage_cow_fixup(struct page *page)
+int btrfs_writepage_cow_fixup(struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_writepage_fixup *fixup;
 
-	/* This page has ordered extent covering it already */
-	if (PageOrdered(page))
+	/* This folio has ordered extent covering it already */
+	if (folio_test_ordered(folio))
 		return 0;
 
 	/*
-	 * PageChecked is set below when we create a fixup worker for this page,
-	 * don't try to create another one if we're already PageChecked()
+	 * folio_checked is set below when we create a fixup worker for this
+	 * folio, don't try to create another one if we're already
+	 * folio_test_checked.
 	 *
-	 * The extent_io writepage code will redirty the page if we send back
+	 * The extent_io writepage code will redirty the foio if we send back
 	 * EAGAIN.
 	 */
-	if (PageChecked(page))
+	if (folio_test_checked(folio))
 		return -EAGAIN;
 
 	fixup = kzalloc(sizeof(*fixup), GFP_NOFS);
@@ -2864,14 +2865,14 @@ int btrfs_writepage_cow_fixup(struct page *page)
 	/*
 	 * We are already holding a reference to this inode from
 	 * write_cache_pages.  We need to hold it because the space reservation
-	 * takes place outside of the page lock, and we can't trust
-	 * page->mapping outside of the page lock.
+	 * takes place outside of the folio lock, and we can't trust
+	 * page->mapping outside of the folio lock.
 	 */
 	ihold(inode);
-	btrfs_folio_set_checked(fs_info, page_folio(page), page_offset(page), PAGE_SIZE);
-	get_page(page);
+	btrfs_folio_set_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
+	folio_get(folio);
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL);
-	fixup->page = page;
+	fixup->page = &folio->page;
 	fixup->inode = BTRFS_I(inode);
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
 
-- 
2.43.0


