Return-Path: <linux-btrfs+bounces-6775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308593D923
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B615285A44
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1D1527AF;
	Fri, 26 Jul 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i1f2ij/M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24015099D
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022635; cv=none; b=WqdZ2eZAfkYbehKf5VlzznMiOJWnqkeE/hV3oZqBbFJaJ+byzmmtPS0jKdz2pgRxlBq2SDnbgsKFv2kF5RWzi/hgYyJ2kfSR3RY2nHFNYPYXV33Og/2vyeJYW8Ruf3JLN1l5d1w4jbUBeRxBcJs4sJmlcq7bprT9F0bkbqqXHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022635; c=relaxed/simple;
	bh=xZkxTBvrEGBvnKqxi15p94+Tq0G60Q85AQA3RDENQBg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN0cSGrMobTyUY0zVTek2zjHFrtUlTnHWnI8B7OQG/onVQLLilbChVv3rNohg2P5fu0zTlTR5Xf7mdw2GNnV3rnaefG2PuSd80vAuz7dUu/4kyk941kBg6XM5CS1PMLtBnNAFlr6WJ/miSjorLVh2wpEGRZJqvwrpri+KqGe4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i1f2ij/M; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-661369ff30aso253687b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022633; x=1722627433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=me0VKgAN2KFbNoR9iuS3kpxAOxLpUE7CuuHfYYTFvoE=;
        b=i1f2ij/MvRQveNPqfab37RcFrxwmF2Dng3kzRBoKEnLseQh8KMezqRv0Fx7S+E0m8L
         QkZoMpT0soNw6niRyJ9W26eat8JW18spwQw+X0KSwJKmsEiTN//9uoXDWlgTzbsWy9lp
         Hr6AyrBgrvOD5IarmE4Utv+jQWPuJJDLp9jxnXZ58zfb6z5PdUeJ9iHayXD8JsvVnh4M
         2WbAq1OsnRKHe7U7rka6xH/OO+R+YoUH7T2+kWf/5iKbmsnDXxJayWy13dKf2Udn2OCX
         JN+pxpTykOYaodw/zoLGuqasnMe0d0toGcytCdBrJLRkM/6vy3C0I0FlGsN6TzUFn5kg
         pDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022633; x=1722627433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me0VKgAN2KFbNoR9iuS3kpxAOxLpUE7CuuHfYYTFvoE=;
        b=sYQnbPx98lpR8uI3hFiARnbQ3H0vv1WobU8dqSrT3izb+N8ejFjEvx/7MmNy9Kw1Qg
         0Sh/Dbt3QiUuVj9yg51gZTTDpNmFlqpGM9rqj41NeBiSSNDSJWlax67bJ51DYt62FvWW
         vI9DZEUJ2hLzJhmudaJQ59eWP0nXJSw6JgkrKHohX733VGygAY6ffqWSIxv0ggMtr9sv
         pALbuIQlna4o4mh2Qpe2YH/ZLVh1cR9E6gW9RE7BzFyXZeEcBqTm1ZdwsQQsHObuOv9/
         E9zIhxzQofeu92We94bHEwPHDGqLxH9/i3exzfXKCZt058mV9AXSYrjUk2BpLDDFzg0m
         pFdQ==
X-Gm-Message-State: AOJu0Yy0Ph/tc9nss6qOHgsESZvneQ616/yjjkI2u3FtLUr7o8+Jc4Bo
	hPH2PqT2C4x4iM7uox+mtX3is2vX/wsFU3KVBt1kjMR8nMwDKir20kK78PjdVEFC67D2XXNPgty
	o
X-Google-Smtp-Source: AGHT+IGRHzZH4ksuMdpWFonmucn25KjCH46B7I5KPbjyonWeRbAVYIPl6p7iRKNNAQjeKKWEVE4hLQ==
X-Received: by 2002:a81:87c7:0:b0:62f:4149:7604 with SMTP id 00721157ae682-67a053e0700mr9699887b3.4.1722022633240;
        Fri, 26 Jul 2024 12:37:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab4cfbsm9949047b3.122.2024.07.26.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 34/46] btrfs: convert submit_uncompressed_range to take a folio
Date: Fri, 26 Jul 2024 15:36:21 -0400
Message-ID: <c40e88a958d5169a375a1885512cf1eb59d89d9a.1722022377.git.josef@toxicpanda.com>
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

This mostly uses folios already, update it to take a folio and update
the rest of the function to use the folio instead of the page.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fbb21deef54c..737af2d6bebe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1122,7 +1122,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 
 static void submit_uncompressed_range(struct btrfs_inode *inode,
 				      struct async_extent *async_extent,
-				      struct page *locked_page)
+				      struct folio *locked_folio)
 {
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
@@ -1135,23 +1135,22 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 	};
 
 	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	ret = run_delalloc_cow(inode, page_folio(locked_page), start, end,
+	ret = run_delalloc_cow(inode, locked_folio, start, end,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, page_folio(locked_page),
+		btrfs_cleanup_ordered_extents(inode, locked_folio,
 					      start, end - start + 1);
-		if (locked_page) {
-			const u64 page_start = page_offset(locked_page);
+		if (locked_folio) {
+			const u64 page_start = folio_pos(locked_folio);
 
-			set_page_writeback(locked_page);
-			end_page_writeback(locked_page);
-			btrfs_mark_ordered_io_finished(inode,
-						       page_folio(locked_page),
+			folio_start_writeback(locked_folio);
+			folio_end_writeback(locked_folio);
+			btrfs_mark_ordered_io_finished(inode, locked_folio,
 						       page_start, PAGE_SIZE,
 						       !ret);
-			mapping_set_error(locked_page->mapping, ret);
-			unlock_page(locked_page);
+			mapping_set_error(locked_folio->mapping, ret);
+			folio_unlock(locked_folio);
 		}
 	}
 }
@@ -1191,7 +1190,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
-		submit_uncompressed_range(inode, async_extent, &locked_folio->page);
+		submit_uncompressed_range(inode, async_extent, locked_folio);
 		goto done;
 	}
 
@@ -1206,8 +1205,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * non-contiguous space for the uncompressed size instead.  So
 		 * fall back to uncompressed.
 		 */
-		submit_uncompressed_range(inode, async_extent,
-					  &locked_folio->page);
+		submit_uncompressed_range(inode, async_extent, locked_folio);
 		goto done;
 	}
 
-- 
2.43.0


