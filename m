Return-Path: <linux-btrfs+bounces-6779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1D93D927
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CDDB247C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4C0154444;
	Fri, 26 Jul 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VOIvjoW8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD0153804
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022639; cv=none; b=mbmuDx/rl6l3aTBnCyJb973zTYWMxeqels++OfmsvfZ3LN7usThf6Kivk9TOeIjeElZUAIC+6aIsyu4cZTDxYJgnByCDxYAB9ZopIlg5BTMJGQZNBcoP9KNOJvKy2XrHYr5oCw1KQ5Esdlbp8fUdJFfPvrSO81k7yLDQzKmW3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022639; c=relaxed/simple;
	bh=GucPEWsDIecsbuQ7OcD/S7ZoXmhr9y2dSl4EPPECVR8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RobRGmWq9kXQwYQkraLECVJIPyRZS5op/jNu1zg+ZtPs9yzI9jwgiNTpwygjQXDIaIyG96lrZErSR59anOgnGvoWHUyIvUb8QQQYaYwphovDQY8Y92QmzZmpljdNYQg3HAdETK3MX+64HR82y4euqcr7c6efPL9e5wxXjZsQJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VOIvjoW8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso46822276.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022637; x=1722627437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKd/OOuZGEJ2gmxvwAHNhhH1eEtc+48z6k83BbKebcQ=;
        b=VOIvjoW8jrd4otnzuo1a38Juq6FjTzbTacpJc8JkgILfSXWCgAapHM1BqcGJ6rycLe
         KsL4pCADeNJTj6e8niRkaOgNjYuAgT6J4ooR7+WB4SUSMHQQ1uayzt1F55D9ZhrzEvFv
         gNfltTdySMPUeB4LkyXdEU31jr3xUjErZWU7rCli/gaWMTrtaXrrlB0J5AoS2XJqc8e6
         NTsQxMgKyGbk+rpOAM8JFeTOyW46XfNHtgYxDVik+udwBLvQrZgC1yeaynrPBJUgjEwj
         76hNplxNUHhWWKzer2G7fnuE6IUnLjsFNuwR+uKwwP9Q/rAt7OX9AVdVLBnj5vVWuP0p
         WTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022637; x=1722627437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKd/OOuZGEJ2gmxvwAHNhhH1eEtc+48z6k83BbKebcQ=;
        b=jU5KhjLIzE1LWxBmUDy59zJtxhM3f6JZdjRIay9zh0xI+0PDq5YaUIpQLR/P8XVQhK
         yd4BQoGt6kKhDzWTD7J7tfvMZZxbXvZNQHzQCFdwpyuU9f+H2ZVez2+Bg5BikfWvZAfI
         zp68Bzb5PUETeWxlXTB/qArNl/JtVTzaveHzvrKfIlbLmdzbf/N4pwLlq0cy+I6ER72n
         SHG8aB/AJ/R/3yyKDHc/yDnrmRPStZSAHRBan7zMgJy175e1pfjWKb89CjA7hxopJV9E
         GgguLJWaORwsscuXSOYOYA46h44zWhEWuQGE7rcJ/N2GjvE5LGWCrDFwlYDWf+3SlAnk
         yC3g==
X-Gm-Message-State: AOJu0YzIUjNzhYevoaN/YrUzF4tooJXdIn2zpRQ77LHBW5t/j+VHonkH
	NDTjFhN+SLTE/ZQAHnQHn3DJ9wWBBTe/Uc7twm9UCuVy4q0p2zJa3ay33D6PkblKiuqhlzlhQgc
	k
X-Google-Smtp-Source: AGHT+IGw9Z74f6+ywSDbO68enL1poiiVZME87EFyzneqAVkrcrlnbWye5215dpuFO2ylzh6RLgMbZA==
X-Received: by 2002:a05:6902:188f:b0:e08:7600:4697 with SMTP id 3f1490d57ef6-e0b545c0434mr1076289276.46.1722022637380;
        Fri, 26 Jul 2024 12:37:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f7ad81sm882558276.24.2024.07.26.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 38/46] btrfs: convert uncompress_inline to take a folio
Date: Fri, 26 Jul 2024 15:36:25 -0400
Message-ID: <c0e3c05e1af0b08fefebd847af888b55a96d0bbf.1722022377.git.josef@toxicpanda.com>
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

Update uncompress_inline to take a folio and update it's usage
accordingly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0667da7b1895..560575a5de03 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6706,7 +6706,7 @@ static int btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static noinline int uncompress_inline(struct btrfs_path *path,
-				      struct page *page,
+				      struct folio *folio,
 				      struct btrfs_file_extent_item *item)
 {
 	int ret;
@@ -6728,7 +6728,8 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	read_extent_buffer(leaf, tmp, ptr, inline_size);
 
 	max_size = min_t(unsigned long, PAGE_SIZE, max_size);
-	ret = btrfs_decompress(compress_type, tmp, page, 0, inline_size, max_size);
+	ret = btrfs_decompress(compress_type, tmp, &folio->page, 0, inline_size,
+			       max_size);
 
 	/*
 	 * decompression code contains a memset to fill in any space between the end
@@ -6739,7 +6740,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 */
 
 	if (max_size < PAGE_SIZE)
-		memzero_page(page, max_size, PAGE_SIZE - max_size);
+		folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
 	kfree(tmp);
 	return ret;
 }
@@ -6759,7 +6760,7 @@ static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path
 	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_file_extent_item);
 	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
-		return uncompress_inline(path, page, fi);
+		return uncompress_inline(path, page_folio(page), fi);
 
 	copy_size = min_t(u64, PAGE_SIZE,
 			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
-- 
2.43.0


