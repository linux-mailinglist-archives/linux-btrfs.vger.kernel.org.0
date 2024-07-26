Return-Path: <linux-btrfs+bounces-6764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38E93D918
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B7AB2409B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A83D14A635;
	Fri, 26 Jul 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2eEaY6pz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13D4F218
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022624; cv=none; b=UerVzgfvg42Ed/3gKB0GB2diS3Ogn8dOfmXdxf0wiRnRz22BGBMFgvjKOh38yy76RIBOc83xhvobbDGdMr1S6xT9duPtPVO3mDaizV3k1fIzpotVRCf0dtP182bhdMeeJPnBiQQ8ejq5/iybkfbchBnQ10q4UbADB8gMAm2xk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022624; c=relaxed/simple;
	bh=fVkn7ZZNwEWhV8zvazU6X97QDpdJBEJJs3GhCg/1Q3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMDOdNCRunvVDT5Hw9n5cuKBWUfev0sfW7I7yElZNCJZcvReS9X58Hk3wA7BrlPJbbtrx4S06GHrCltgfx2gYB9G1JN+c+4VtZARefWzqa4rK9YhiPA1UmJyCk6ANXvhwyxf61ecnR+Au2I2wba5E5TTswlU79IREpJKtOqf6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2eEaY6pz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65f8626780aso315897b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022622; x=1722627422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsXB8DX4/GdX+DMyVL3t9hKrZVLik5IHtqIcuefl6X4=;
        b=2eEaY6pz93GHAP5ehADiGcCRuH8zAuwowC5N8mNzWgQ2ZZgOE0R7DJb5qfMlnSr8Rv
         8g6CB5tLu2eHaHnY9gNNrGPkkyMM6QGBW8sJ+AkV7iX8scJi13WEDPwc6JsGCElXM/c7
         AJ6ngSSREka8iToTigVgkgayueZnhXT4HeVdIORo1oQLrtt+KwyfP+ce7k9ttLeBHlT6
         uT8/onxIC15bJjWGvo83e+ILBro54+p1k/kkdziF+0Wm4pFpWqTL/MQomoOz8Fn5QSrG
         lKSYWzh6var84wzdYKWr+ctWRNmxtclgBI9T2JFFOTZvWoxTd2Rtjdv1CCcazB7QDPNj
         JXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022622; x=1722627422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsXB8DX4/GdX+DMyVL3t9hKrZVLik5IHtqIcuefl6X4=;
        b=tEVzs8fxKxqycmLGDxSmcA6eFJr7wvlIpiuze+FTRS4V9ABFopGD5FzcwsgfeZzgLO
         1JqVc/o4w/8mc7fdQleZZRmqm8iXhFHX/onzoL44nWMP6U8IAmhmYeDXOFT3yseo6sa2
         8YmgIPD7OBMYFfXsS0lXcDi0fDjDtgxzeU05XQYxtXdwcHWk/rNnaYzQppX0yUjqFsIB
         QlZaytxFuk+sTYQVoqbbYVclJb53bVAGTcwNgbYUJfLaVWLecoILpqLthD4j0gKSqnDU
         4+hF7m/LBqWcb0M/8RW5igiSrgOzkA7iyVUHT6aLEFsuv24vB1gsKVAl6cGg9oUGA99X
         QXwg==
X-Gm-Message-State: AOJu0YwpLg5n7uyPtItUoC3Refl/16No1REDcEJcCjZNYFXHOhoL0wSl
	2My+g3a8yLx4h9EqhVWkg8h2fwZ0hhFT5+iPwS6fkVClMHr4K+YN1RM8D05JNErYsPc241d0kwe
	6
X-Google-Smtp-Source: AGHT+IHTYY8GzdE0qmNDJxvItQemDRbL29ynSoDmyBNelZusPUxcRSkkL/2BVEd5AsQ0xPkg8MwT3Q==
X-Received: by 2002:a05:690c:6a89:b0:64b:6559:5d71 with SMTP id 00721157ae682-67a09d5fabemr10184417b3.32.1722022621870;
        Fri, 26 Jul 2024 12:37:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44db44sm9849157b3.144.2024.07.26.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 23/46] btrfs: convert extent_write_locked_range to take a folio
Date: Fri, 26 Jul 2024 15:36:10 -0400
Message-ID: <440fde6ddd6623c84c938bb41ae9e2c3a0f9ed97.1722022376.git.josef@toxicpanda.com>
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

This mostly uses folios, convert it to take a folio instead and update
the callers to pass in the folio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6036fd6b9b79..1faadf903e00 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2275,7 +2275,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-void extent_write_locked_range(struct inode *inode, const struct page *locked_page,
+void extent_write_locked_range(struct inode *inode, const struct folio *locked_folio,
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty)
 {
@@ -2317,7 +2317,7 @@ void extent_write_locked_range(struct inode *inode, const struct page *locked_pa
 		}
 
 		ASSERT(folio_test_locked(folio));
-		if (pages_dirty && &folio->page != locked_page)
+		if (pages_dirty && folio != locked_folio)
 			ASSERT(folio_test_dirty(folio));
 
 		ret = __extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5d36031578ff..b38460279b99 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -240,7 +240,7 @@ bool try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-void extent_write_locked_range(struct inode *inode, const struct page *locked_page,
+void extent_write_locked_range(struct inode *inode, const struct folio *locked_folio,
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty);
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 199f783680e2..0b44a250e5b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1758,7 +1758,8 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     true, false);
 		if (ret)
 			return ret;
-		extent_write_locked_range(&inode->vfs_inode, locked_page, start,
+		extent_write_locked_range(&inode->vfs_inode,
+					  page_folio(locked_page), start,
 					  done_offset, wbc, pages_dirty);
 		start = done_offset + 1;
 	}
-- 
2.43.0


