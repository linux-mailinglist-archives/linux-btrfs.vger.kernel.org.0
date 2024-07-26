Return-Path: <linux-btrfs+bounces-6783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5C93D92B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3817A1F21DD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31301552E1;
	Fri, 26 Jul 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OKAfW3gY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150A56B7C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022644; cv=none; b=HIFRmlQsnmtvfO1j/FcuUOA5vkC8a6MYMpHwEGe0meES1m0DTG7QsqAeoS8P+X9EV9g2gAhwrX0UxmLrxMkxEw8fqba1SozIXJGYRkuFjY7VNzuQigQVfW/1ZcmS4xQdP7zaz94TPJzR7PB7VQ2ttpgHIM0DAw16jNwn8PLtCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022644; c=relaxed/simple;
	bh=G4e4+w1d4Vq4YkL1BXTX3xBAwWPIZH0081iZauWDDzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KufVe2Lcroo0ilg24R/Q54NELVplUAcLpy5bC0DN8ABYpUjryNE2fjnsCPHprisWI7FfhGkVBfpBrSVg7c5jn9pzyOfII6q4Nv1z+YQepQuIgl5uk2zWH+U4mgI3qpdO0N3IYL3agf4iuR4v8vcQCkNVTiCDDehtbjlvp0N/9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OKAfW3gY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66526e430e0so378027b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022642; x=1722627442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWxUzphjlU3Edps+E87zIu344ovkxgwglVIJpfgxmYk=;
        b=OKAfW3gY112V9cfBkOINLnfYlFqERTeXeo3A7Fj05StzKjPT9YmIuykQFo2gaDXKhN
         /vJ2y+Q3fJRBfnW5dbCdTRRrOsbVMdoc20gtQPJMDVFnvNPH6sLGmljrYe3OcWygh+tE
         /LVwdme5fxh03ZQaAeyfuJqT6OJikLHLbSOokzQcosIxj1I+hNYQtsPTDhH7z32oma7w
         onmaux6VvJnQ8vEbo7fmTgDDdjVPHI9YrD335tghXMtCj8tZj4ikf3h31B5tYzaA82wL
         Dgb6Gwl+qCdOpcjpoTWvI0P/oz1f5EM8EZNK8ALdgIqZiPtUdK9Xu/4JEUdRnCVLFZVa
         knpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022642; x=1722627442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWxUzphjlU3Edps+E87zIu344ovkxgwglVIJpfgxmYk=;
        b=KyZjvnzN5dHfFBgYxSUeqcNd6IviJUNxsl2M8ISwKc+nJPDMVYjWwXIVYVaOxkcdyn
         bDTfws+Wt574Q3JoSMml+XPyuKvPUhsnC7p8b+OR1FUJpeQmTv103yy+hlekqVCOjJ8R
         g5Wt4a24ayleMjf4tWN8EJBGRFn3jG10hQHbvjj8dYVwZJ8iKIRHGw/ecKMoUC2jO9G5
         YB4Ik4mUCguk8anSlrIBnlPcTd3RXo3HqCT7f18eiunUmOd11nvYIaIAcTKGwCEfIvDx
         TKq0MT/JsWhFIeycRvH7mXAsxtsWbTjgbUXxysa3XTfzeS1pLb/k5jxj/sSciBBeYi19
         IggQ==
X-Gm-Message-State: AOJu0YyW3jcX3KJWzSZducX71v6peH3fNDw6TdqYJgn+6UcX3gtu+jP7
	Z8QrpiAu0SxPO1ZoE2SmN5by40k1jt4b32Rq6x3+E2mc9e60mhDpjc6PvBdIvfv7qGR/phy/ve1
	J
X-Google-Smtp-Source: AGHT+IFizDZEK9aeoHwfmLIheXo5zl3weiKF7wAt/rR+fHNB3jsyEfMbfBwJwngWGgsP5IB6RYHWxg==
X-Received: by 2002:a81:ab53:0:b0:648:2c60:fdee with SMTP id 00721157ae682-67a0a1376demr9257687b3.38.1722022641774;
        Fri, 26 Jul 2024 12:37:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67561916209sm10108187b3.0.2024.07.26.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 42/46] btrfs: convert find_next_dirty_byte to take a folio
Date: Fri, 26 Jul 2024 15:36:29 -0400
Message-ID: <68aebabe701ae3b96a2804104da6edb9817dce68.1722022377.git.josef@toxicpanda.com>
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

We already use a folio some in this function, replace all page usage
with the folio and update the function to take the folio as an argument.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e9f0baba2ca..040c92541bc9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1348,9 +1348,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
  * If no dirty range is found, @start will be page_offset(page) + PAGE_SIZE.
  */
 static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
-				 struct page *page, u64 *start, u64 *end)
+				 struct folio *folio, u64 *start, u64 *end)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	struct btrfs_subpage_info *spi = fs_info->subpage_info;
 	u64 orig_start = *start;
@@ -1363,14 +1362,15 @@ static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
 	 * For regular sector size == page size case, since one page only
 	 * contains one sector, we return the page offset directly.
 	 */
-	if (!btrfs_is_subpage(fs_info, page->mapping)) {
-		*start = page_offset(page);
-		*end = page_offset(page) + PAGE_SIZE;
+	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+		*start = folio_pos(folio);
+		*end = folio_pos(folio) + folio_size(folio);
 		return;
 	}
 
 	range_start_bit = spi->dirty_offset +
-			  (offset_in_page(orig_start) >> fs_info->sectorsize_bits);
+			  (offset_in_folio(folio, orig_start) >>
+			   fs_info->sectorsize_bits);
 
 	/* We should have the page locked, but just in case */
 	spin_lock_irqsave(&subpage->lock, flags);
@@ -1381,8 +1381,8 @@ static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
 	range_start_bit -= spi->dirty_offset;
 	range_end_bit -= spi->dirty_offset;
 
-	*start = page_offset(page) + range_start_bit * fs_info->sectorsize;
-	*end = page_offset(page) + range_end_bit * fs_info->sectorsize;
+	*start = folio_pos(folio) + range_start_bit * fs_info->sectorsize;
+	*end = folio_pos(folio) + range_end_bit * fs_info->sectorsize;
 }
 
 /*
@@ -1443,7 +1443,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			break;
 		}
 
-		find_next_dirty_byte(fs_info, &folio->page, &dirty_range_start,
+		find_next_dirty_byte(fs_info, folio, &dirty_range_start,
 				     &dirty_range_end);
 		if (cur < dirty_range_start) {
 			cur = dirty_range_start;
-- 
2.43.0


