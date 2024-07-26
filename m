Return-Path: <linux-btrfs+bounces-6781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBFD93D929
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5E5284D68
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A25147C90;
	Fri, 26 Jul 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Z8i5kDqX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97804154456
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022642; cv=none; b=t1P5kcA6YBce3XniSXriLEWxun/RkOEwVNCEA5lrrmZuhmGnseioPGV5s7EJhYLGTSeLHW2iirU064pbSazvK6C6ZGvUhD9oDY36QrE8dsEzoWJ41r7adfmdJlXtwyYKGGXn8YRxv9hMEBjBBWQ1Lbk1FbRLIGrbgFVqQXVAQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022642; c=relaxed/simple;
	bh=PLJ29NEO52clYYfJGF9MwzhpdA0r4y0SLpuTLapXZzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9PKglynVK8xQ+QaUHbT7ITW330Z7/FHdwWsES7IgP0LV/bwdGWgIfD3kD/kZcrc4Ec9nO1gG+fX+LflwZVh7yt4Y+d1ayog82J3BM3VVFrqhXGzOLL7GhGP3rRtM+ra5DgeJ0HtYOlU2Qghgghg5QCyvKcDLASW8hxYsU8Lvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Z8i5kDqX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f8626780aso318567b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022640; x=1722627440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPUcVhMZZ/L8ca7G8wdv+jxTBowNruFOYlWCJrDk1kw=;
        b=Z8i5kDqXL/ySl1cibB8HCHrtHrq1RNe5yfBWKIX56GFcOKeLt2Cq4wqQAxgW6/9xuc
         G8ATKSjkxcnnx0XOuFJrLePTZEpzsvvIY/eqHxZstmkf/ZPVbIDQD9mc5qlciour0J3b
         q1ufHAuBKpkkSAfeKnf05OZSWLlBSrBVF/JJAzlQhjrqYzJy8VNyR+NO5vOLH/6jhN1b
         0eY6V6AbThqQA1oTuQAAYJ+VpVdHDsrrkMdFnSQ8aVmSB8FuIHWCzj4gHDdg5hwg8Ydy
         WHEP4AOSwQhJVcQv7ukctxZ95r2wqKK/1BGuYTNgKGCS+9IiVY8GEq/5bqJOR+xlBM6K
         4VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022640; x=1722627440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPUcVhMZZ/L8ca7G8wdv+jxTBowNruFOYlWCJrDk1kw=;
        b=AI8qmLF4yOhQjyEUPjEGPp+cQfrqOT0TOfMpuBCFDFExTF48N1K08wCrlnF/t4SltP
         cY3DEXWvnEcFg70M2h+J/+rntLcGFjh6x+ySUqm11wZrqk9CLbSt/ts/uEOFgEdTMD+2
         WnP8C7KLXgRE3X4j4NZmeCM97Sc4j4BHoHlSFn4Hch/OYIS6Sy7XkIMepe+XbKUXtrJL
         b11ucp8XluEuQBbFJoN7IX+/+PDUG/uq6Ti5GnDyWMvheXWzomBG+p1xp3IK914No1uU
         0PVTiQLJL5U4TKINQCQh2qwvslWSWpOWyWIiTcf2nnBKleAUL0mpcJ6n4qBmW67URJ4u
         gszQ==
X-Gm-Message-State: AOJu0YyOP5BttmPElmk64HQPfmXwYHiRxXpZY2n6QocfnQZvyIG46gf5
	RYfAkzSghw4dEuVxLIz7Esvb3jaDH41FBZc/QUPjdTTrKFzgZbUsKkCF6HxHaRxSG7/KWK8LQWy
	W
X-Google-Smtp-Source: AGHT+IHIyGMP/plNLHjncgsSyWNzJtkEGgRIfJN8bgN8roM5nwJJe6mTqJwZ8mNKnEAX+yj9nKELMg==
X-Received: by 2002:a81:a24e:0:b0:64a:d5fd:f19f with SMTP id 00721157ae682-67a072baa09mr8264117b3.18.1722022640583;
        Fri, 26 Jul 2024 12:37:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c806sm9903617b3.136.2024.07.26.12.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 41/46] btrfs: convert __get_extent_map to take a folio
Date: Fri, 26 Jul 2024 15:36:28 -0400
Message-ID: <2564fcf5127417ceb8b441e97da6cfe2cf75783e.1722022377.git.josef@toxicpanda.com>
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

Now that btrfs_get_extent takes a folio, update __get_extent_map to
take a folio as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2a80dfbc8248..4e9f0baba2ca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -968,8 +968,9 @@ void clear_page_extent_mapped(struct page *page)
 	folio_detach_private(folio);
 }
 
-static struct extent_map *__get_extent_map(struct inode *inode, struct page *page,
-		 u64 start, u64 len, struct extent_map **em_cached)
+static struct extent_map *__get_extent_map(struct inode *inode,
+					   struct folio *folio, u64 start,
+					   u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
 
@@ -987,7 +988,7 @@ static struct extent_map *__get_extent_map(struct inode *inode, struct page *pag
 		*em_cached = NULL;
 	}
 
-	em = btrfs_get_extent(BTRFS_I(inode), page_folio(page), start, len);
+	em = btrfs_get_extent(BTRFS_I(inode), folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
@@ -1050,8 +1051,8 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, iosize);
 			break;
 		}
-		em = __get_extent_map(inode, folio_page(folio, 0), cur,
-				      end - cur + 1, em_cached);
+		em = __get_extent_map(inode, folio, cur, end - cur + 1,
+				      em_cached);
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end, NULL);
 			end_folio_read(folio, false, cur, end + 1 - cur);
-- 
2.43.0


