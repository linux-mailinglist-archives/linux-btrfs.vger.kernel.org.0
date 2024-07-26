Return-Path: <linux-btrfs+bounces-6784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C40393D92C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A0284FED
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B71552FE;
	Fri, 26 Jul 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wLpEiSBl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC768154BEB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022645; cv=none; b=kPx6rXAatAngd17SY9vW+yKR/VihYXD6J93z3WqY3bClVPE9ZJth0WC6RvbdWisVJWwp4xOSm70HCiy2aW7ge6Rr1KLmWRyoiqrooAXZPXKUtv6G0XLwbSGQE2Y19BhYWEOK0DwSo1j3HzSjPhzhSMra6ZBvcAna3UfC2xY57RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022645; c=relaxed/simple;
	bh=1ukRFTHBXzQDwdqZTMPmiLVbxm5h2A6hbbk/Qx87Ehk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/LNgpMqKkSBfoa/m5l/qOg25p3SPJWEfO5HQ+eYcsCefu4IJEQBuM3c6rBKyboMIDsYK1Ag3M0vHsK6ZH7oT13VwcQBB2BFE7zYgE5p1Q3jAxXOI3tnmJj3cFM5OyKKoaXckxdiymIrULLq4AMhKBh2UPH9I5Hf8MzLkXVWdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wLpEiSBl; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0b10e8b6b7so38463276.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022643; x=1722627443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGNJUeIXrd5N6wQzpzOyY2v+zHYUKNT6NIwGolqwReQ=;
        b=wLpEiSBlpe3YBGKoPuQ4BqnbWsDnCRhkW6nMQAlJIlm/yzogsxHKErTZ3NPguvrI6X
         e9YjyRLqxAD+eEbZDb3GRPi+xv11ARKR6zExWAmzQu+PhHYnuXZ4xUp1taH/1e7BsQzK
         pImhYXCR8rcfNg9Qix5vupb3HnLvAE1p8QW2cIgOlleLIf+2QXMDugrd4JCH0alvXHD6
         7+B8WSXMn9KpuQOtpREKj3vuT4P6WoPDkoONrg5sAmQidcH/anJtG2qlZi8gWI1bCnsu
         OCn4ElCK8PMxATi96C6vIpZttWrZbfOYSZSBkV9GHAPjrVmJ6bhNSdjMwnP6MX/GMP/1
         fJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022643; x=1722627443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGNJUeIXrd5N6wQzpzOyY2v+zHYUKNT6NIwGolqwReQ=;
        b=L0Hb2PB9LL21RVSufRPMo68ra6x2h1B9h1yGFJq5WaavXI0kidlJ2+LRuZZZBQeRWZ
         x4wADo1Baqd9pl3bgXIehrPf8A4IiDMxs+jDeQjnoMaCB+9dpzI/eheGdfKtnzGC9QYW
         H+tX7pOZ1R5rk0ljJZaGD7Ad/+/xzqvkKladeTvrpa5tjkw4//1IXMrkTJDMYAwIo+/X
         SRd0dOevWAshqBn54sCUyDx8Z3VgFs0AJwV9Yp2ZLw4Z+cXPE8eaWW4XDfg0bIEipfAY
         8UuZqpftntwRz23WKnMhfp80EufZHYbezsw53zQRjBFNnjql2qIjUcWBevRrnMjaYuGg
         q+vw==
X-Gm-Message-State: AOJu0Yz1+o+mZKe+vkGnqqbuyVBVa8cCzR+EblMy7hhFp1PQAVdNtjF6
	LbiXip1IuNOiXyzzl3h1DIZYkBGQ9Gus31nB1gwz/GSos5fS+rEiGMlbjTb+sgQf8YLW/Am4maO
	N
X-Google-Smtp-Source: AGHT+IGIZheH/Zs8eWd6GxJ3KLEDU9r0CClxj7o+gRh6RJ1/mgpSh8qkAqvIm2WVsZ9LpyhrLMKZUA==
X-Received: by 2002:a25:a305:0:b0:e03:63d0:4516 with SMTP id 3f1490d57ef6-e0b5460dcddmr579019276.57.1722022642725;
        Fri, 26 Jul 2024 12:37:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a70d174sm845794276.47.2024.07.26.12.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 43/46] btrfs: convert wait_subpage_spinlock to only use a folio
Date: Fri, 26 Jul 2024 15:36:30 -0400
Message-ID: <2c87d2780fd99842891de98c8d2337ea2436333d.1722022377.git.josef@toxicpanda.com>
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

Currently this already uses a folio for most things, update it to take a
folio and update all the page usage with the corresponding folio usage.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0cdb0b86e670..80022a8c718e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7186,13 +7186,12 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
  * for subpage spinlock.  So this function is to spin and wait for subpage
  * spinlock.
  */
-static void wait_subpage_spinlock(struct page *page)
+static void wait_subpage_spinlock(struct folio *folio)
 {
-	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
-	struct folio *folio = page_folio(page);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, page->mapping))
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
@@ -7221,7 +7220,7 @@ static int btrfs_launder_folio(struct folio *folio)
 static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (try_release_extent_mapping(&folio->page, gfp_flags)) {
-		wait_subpage_spinlock(&folio->page);
+		wait_subpage_spinlock(folio);
 		clear_page_extent_mapped(&folio->page);
 		return true;
 	}
@@ -7282,7 +7281,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	 * do double ordered extent accounting on the same folio.
 	 */
 	folio_wait_writeback(folio);
-	wait_subpage_spinlock(&folio->page);
+	wait_subpage_spinlock(folio);
 
 	/*
 	 * For subpage case, we have call sites like
-- 
2.43.0


