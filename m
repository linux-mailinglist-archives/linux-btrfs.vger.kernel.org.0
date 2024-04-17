Return-Path: <linux-btrfs+bounces-4363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811CA8A8609
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9681F226B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF401422C7;
	Wed, 17 Apr 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d2ZqnFp2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104413A265
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364576; cv=none; b=cs8qCH48eCKwG+nSgudSQSvK2isdjdOH6TkEiCaeBorrYA7oAFyln3cEzdifaKnMAB78+n3Br0JWbHA8QYlzPquEQ8pw+5a59iBWz0JgsNoZkNKFpFbG9+kRIvOj4HVfu2fu+EsEYndeoIbxZRGAvcJQlQFJdBc7yH8H5cDZ6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364576; c=relaxed/simple;
	bh=lIJeEDcKILQVjBQnlVNn9tmEJ70mLgziM0k/V/uafN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca/Xps8ceWWA0mpVQeYz2WRh92shY5t+Wou/fqxQ5np7PbcKKm2/Fx5yedCFV0a9NRhZSvRxfCR5KkHNyDx/QQGEpbnl13sbv/Z0OR8eD/dtCioS5m6bJxefRLeL158CS6tzyBmZWtfCUwQ0wuJDmZsfNuvhX3fK4qTVHCntrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d2ZqnFp2; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-434925427c6so21909631cf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364574; x=1713969374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VGkqAoXTQ2oHa57gANyYrDf03wmc4JWQxuxHSVnr00=;
        b=d2ZqnFp2Y7dafzqZzO2GRgzRUeIud+ZpIL/at2ZQ2Z62zgXQzVsCiNfaZN8ITyCP9Y
         9qzda8BTxW6wLvKGDgpzSHs00X/9ySlBEuExHmc+Ko6+6oWwI9zqyniuezeSQWsmK6Bj
         +1vM+938hautXqLkpoxYxPhS/WUee/6UsK78yr9Z9dXt+kmlUFzjeC1w2fCe+hNR/ne7
         2L/Ynj5t3TzVNq98RFsq1ZlGqdrCD4M7ke5wjs+h5iQDWx2dVcqmK4cCg+6YBbdcgZAQ
         cPIeVy0Ksq7QRgzY0xIDOaDgFb4RFI+hDXi/PP3LaPK5w6OtzLs2a6jp7qYkl+w1t+cW
         KrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364574; x=1713969374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VGkqAoXTQ2oHa57gANyYrDf03wmc4JWQxuxHSVnr00=;
        b=Lr0KDnLHWI3e66aapcUfwz0YiUJJeiyiWbLBPbLk+SAbpOhCqC7pTKHxEA/NtWhcO3
         PXGnVCe43zgwtI5PZqZxnmYLwOMk6OV6MZMaFzaH+kYZlhJWlUHXQLCW32qNQkQ9cU2S
         B5wfQuE2LKRS9umjwb4jlSYy3wf7lle4vTuI4bD7iKnIZgGWH1jzimbpGEnYojBRp4ku
         ms0C9gMYOOEY3gRtUbiwZxf62NSOMrOfoAvyNnsQ/JGjtR6gfkgf/sImZQwOrBcxhPWq
         B2ovO9WKDC4Qb0qOzzRg86zEhflliVArtOrTLAi4rYFy4/Kh7b+LdRsLHCspn2X+A8wN
         v+cA==
X-Gm-Message-State: AOJu0Ywxyrl6PCBtNAPkqTFtghapTDNoZSRtEbtMriv75ilwSfK5IuaW
	pMQRRodZmwQORjB6X8kIR4+AzZbY6NH4QL6Hba5bNf6h2LbHkqj6F3TxDUTYPxY9eM9zR0jUJOk
	Y
X-Google-Smtp-Source: AGHT+IHEyfXQNojGXuKSNWnkuhLAWlTirXgln08NhGqlDaqKLmwyxUcJDwRx6MmYbmXD19ZISSgTVw==
X-Received: by 2002:a05:622a:1a0d:b0:437:87f9:5ad2 with SMTP id f13-20020a05622a1a0d00b0043787f95ad2mr676066qtb.45.1713364573904;
        Wed, 17 Apr 2024 07:36:13 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m25-20020ac84459000000b004377f87147bsm272836qtn.69.2024.04.17.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 06/17] btrfs: push the extent lock into btrfs_run_delalloc_range
Date: Wed, 17 Apr 2024 10:35:50 -0400
Message-ID: <1d2952b7fccde719e25867471e61a0126e77e3b6.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to limit the scope of the extent lock to be around operations
that can change in flight.  Currently we hold the extent lock through
the entire writepage operation, which isn't really necessary.

We want to protect to make sure nobody has updated DELALLOC.  In
find_lock_delalloc_range we must lock the range in order to validate the
contents of our io_tree.  However once we've done that we're safe to
unlock the range and continue, as we have the page lock already held for
the range.

We are protected from all operations at this point.

* mmap() - we're holding the page lock, thus are protected.
* buffered writes - again, we're protected because we take the page lock
  for the first and last page in our range for buffered writes so we
  won't create new delalloc ranges in this area.
* direct IO - we invalidate pagecache before attempting to write a new
  area, which requires the page lock, so again are protected once we're
  holding the page lock on this range.

Additionally this behavior actually already exists for compressed, we
unlock the range as soon as we start to process the async extents, and
re-lock it during compression.  So this is completely safe, and makes
the locking more consistent.

Make this simple by just pushing the extent lock into
btrfs_run_delalloc_range.  From there followup patches will push the
lock further down into its users.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 5 ++---
 fs/btrfs/inode.c     | 5 +++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b10f47d8f83..c09f46f969b1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -396,15 +396,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, cached_state);
+
+	unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
-		unlock_extent(tree, delalloc_start, delalloc_end,
-			      &cached_state);
 		__unlock_for_delalloc(inode, locked_page,
 			      delalloc_start, delalloc_end);
 		cond_resched();
 		goto again;
 	}
-	free_extent_state(cached_state);
 	*start = delalloc_start;
 	*end = delalloc_end;
 out_failed:
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ba74476ac423..2083005f2828 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2249,6 +2249,11 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 	int ret;
 
+	/*
+	 * We're unlocked by the different fill functions below.
+	 */
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	/*
 	 * The range must cover part of the @locked_page, or a return of 1
 	 * can confuse the caller.
-- 
2.43.0


