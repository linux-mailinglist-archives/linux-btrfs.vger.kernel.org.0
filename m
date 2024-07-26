Return-Path: <linux-btrfs+bounces-6773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893B93D921
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD01C22E8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB11514DA;
	Fri, 26 Jul 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="p9JclY1y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31B14F115
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022633; cv=none; b=KbHnLzoMwHgxBFKjjU6lhlq8vdGrdehJl9UiHVsPJv2xCDsRJfPyj3RzThFYcJQHRPS/OIDPfwl6k57/3bv3AFfnpiu8PugFleV6j2C3p5ESlVEKOgFqhqGe2A+KWpVOXePjJmjUzvJaymhFJn/m3+lwluGOUq3B2xmSpQRajXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022633; c=relaxed/simple;
	bh=nsfM3zMcpVUyNL5Ean7WRsl0Oh1USVr/mqPHZrs9LfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7f0Vyx47mA5bmtyBz0vkE1WROdXM59T8ztp889HZHQhQMiFgu+dgaL6GrHkFrgDOPsWAFQ9af/NdLzKoLbnEVh1GYvrFz7cUdiIM5jDwdFzkIsOSQ0UZMXEuHeaLF42ZbgPzwMEGipFIQRjUdEWCzVm4zH5GJDiMzD7/Irl5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=p9JclY1y; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e08a538bf7bso27922276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022631; x=1722627431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNeFyrm8SB7ZMcTCebN8aon1cYbETgbo/mpbSpe5IDM=;
        b=p9JclY1yULlTorltrdXQwgHQ129EHEtJPPo4hs/QdkIHWhSNWsF8rvWJCEkvsslmI+
         EVH5BKhJfeofTeGrN6xVQ/CZIXPpqUfBgbZgWLFv+SP/CHOM/3O0+S8wolGgymyKthkQ
         JgkFBqOWAXQSqSzCS/FYPBHmEmYvYJOfCyxlgxmnpkujM7DxJ+o9J5jVGsz2QXnDAxqX
         pnqp4NchITV1aVZ5CljQOvxAB8+IaWBPe1f28Pesr4MKcc9Mkei9ZrQo6hR1v4kGHvBv
         R1r5liKHOcLKbHW7IfjjiTecl6jkQljLvT+Z/25x6gbs09canlnqKJllxcn8iD4fGMqQ
         RO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022631; x=1722627431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNeFyrm8SB7ZMcTCebN8aon1cYbETgbo/mpbSpe5IDM=;
        b=tNvAf7naS+2OKJrt7S9g1zsoNX8oXNchdFJtp1kPNbPUftHV3prJuWXZ55gFNUiZSk
         PhVnEHhHcQPLsXSLsAgklPzQoDkiKCfcY9jfQH0LGI2LtrOjdRcYgXMDn+nyRAewIwKp
         5dMZYx72GYptfCUZb9wNhsaTxHi1rRYwsimtCOHDjnPVR9KErmqEkjviO5RwcDMjoyND
         w9xPTbmrMJ22GebK1P2DeYdKeY7VGUMA3XClxd4H05tdAvb+Uqe1rC0YKRAUaGt3sZsd
         RhTDGpGie3tNWx9m+VCDA6ClnbUd9BTlmfsMsr/ZGgiK8rggyqMBX9tfRtHl8bW7lKj5
         IpNQ==
X-Gm-Message-State: AOJu0YzL0RCyVln8nw7GkfXOZpxAjdkayllxqYxOkaemkMfzd4PuilHa
	HS54TyxI3j3MH228AQuzydcolz5DFygByd2gQBEd+7kmQVp7bJwpCasknT5jPkE3/YcvXSCSZ8C
	I
X-Google-Smtp-Source: AGHT+IGdqGw9comAuy70AjVy8VcUDXnf3VQ+oqNmRyIdMGvk4ySrSxYgJ7VbXcSdGqIn7OGMVum75Q==
X-Received: by 2002:a05:6902:140f:b0:e0b:28f5:3ff7 with SMTP id 3f1490d57ef6-e0b5552689dmr619482276.4.1722022631248;
        Fri, 26 Jul 2024 12:37:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a940871sm879068276.59.2024.07.26.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 32/46] btrfs: convert btrfs_run_delalloc_range to take a folio
Date: Fri, 26 Jul 2024 15:36:19 -0400
Message-ID: <4e67606e76ff4bdd037909ba18c994b94354ab83.1722022377.git.josef@toxicpanda.com>
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

Now that every function that btrfs_run_delalloc_range calls takes a
folio, update it to take a folio and update the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       | 26 ++++++++++++--------------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 3056c8aed8ef..5599b458a9a9 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -596,7 +596,7 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 				    struct btrfs_trans_handle *trans, int mode,
 				    u64 start, u64 num_bytes, u64 min_size,
 				    loff_t actual_len, u64 *alloc_hint);
-int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
+int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_folio,
 			     u64 start, u64 end, struct writeback_control *wbc);
 int btrfs_writepage_cow_fixup(struct page *page);
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1faadf903e00..2f46a85888b9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1254,7 +1254,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 		if (ret >= 0) {
 			/* No errors hit so far, run the current delalloc range. */
-			ret = btrfs_run_delalloc_range(inode, &folio->page,
+			ret = btrfs_run_delalloc_range(inode, folio,
 						       found_start,
 						       found_start + found_len - 1,
 						       wbc);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 23ab3000c5fd..a16b9aba7f96 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2287,42 +2287,40 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
  * Function to process delayed allocation (create CoW) for ranges which are
  * being touched for the first time.
  */
-int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
+int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_folio,
 			     u64 start, u64 end, struct writeback_control *wbc)
 {
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 	int ret;
 
 	/*
-	 * The range must cover part of the @locked_page, or a return of 1
+	 * The range must cover part of the @locked_folio, or a return of 1
 	 * can confuse the caller.
 	 */
-	ASSERT(!(end <= page_offset(locked_page) ||
-		 start >= page_offset(locked_page) + PAGE_SIZE));
+	ASSERT(!(end <= folio_pos(locked_folio) ||
+		 start >= folio_pos(locked_folio) + folio_size(locked_folio)));
 
 	if (should_nocow(inode, start, end)) {
-		ret = run_delalloc_nocow(inode, page_folio(locked_page), start,
-					 end);
+		ret = run_delalloc_nocow(inode, locked_folio, start, end);
 		goto out;
 	}
 
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
-	    run_delalloc_compressed(inode, page_folio(locked_page), start, end,
-				    wbc))
+	    run_delalloc_compressed(inode, locked_folio, start, end, wbc))
 		return 1;
 
 	if (zoned)
-		ret = run_delalloc_cow(inode, page_folio(locked_page), start,
-				       end, wbc, true);
+		ret = run_delalloc_cow(inode, locked_folio, start, end, wbc,
+				       true);
 	else
-		ret = cow_file_range(inode, page_folio(locked_page), start, end,
-				     NULL, false, false);
+		ret = cow_file_range(inode, locked_folio, start, end, NULL,
+				     false, false);
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, page_folio(locked_page),
-					      start, end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, locked_folio, start,
+					      end - start + 1);
 	return ret;
 }
 
-- 
2.43.0


