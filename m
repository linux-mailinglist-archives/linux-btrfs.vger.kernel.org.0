Return-Path: <linux-btrfs+bounces-6782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED4493D92A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE4285CA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A9154C10;
	Fri, 26 Jul 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xTopWa+T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AE154BE0
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022643; cv=none; b=WGfjW8gqFEkKB03XwKaW67FR925s82xfwaZsnwDwn0iH8ou1F5OpPUIUX4fI186qtwFuBKEl21sffscgipR9Jx7XurOGllw84Uv9jWiT/HvHnuwB6UJ2msSW4XVxOQKtbPyyLUCcTOku5snqULgq5655pr52n2JSuzqpDC++KPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022643; c=relaxed/simple;
	bh=pBmXwUgUff5UyMdThOEHcy7C6G9PZ2f4xSaXGNvjykA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXGJHAXhF7ww+Oq07LkiPFghqj+Eg0nkyP3Fg1LHG74Le/7yf1ut+YeKB2oTokdoYZk8QCzWLAD7wzAvroM3cVPPMrpVouKvwqdR83TQ6bb9R98VI8GQgky2UxTtIIF5R0DZQRXTI12B7A37UrP3kCXYHDz28Su/zJaRg1JMXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xTopWa+T; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0875778facso30714276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022639; x=1722627439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d0/9lKjMdP113nceu4AM5nk6zUI0PzpLneOMwa1dqI=;
        b=xTopWa+TUa92TlIcyDrVFaWhZGxPqY7hS171xuG7+xmCWmeddA8s5v/bOj1HeVK6fz
         68u7K0L3En+xe1bjkVPkGeYPKsBCNl9yaAkWdIapqUXFmYTIhZVPoqQBo5qNEpzp/6XZ
         EPRPvcvL+lDBbdriZufnSkE7fhML+SM6NnvvLEWboLzoJr74S4xDCBKdtXjuymLQVDfa
         zYCC0o+X7Nd7KFq6jtHCs71g+WZtVnUpGXb0Jcw/AxyzdKI2PU+2GLwZVqYbwb/8hpWs
         FXYLatxIKTzgQ5GjDafWvdN5nh64MJbqphI4GXrC3Tyfgxf51ACjtVCYj581nWpIUMaw
         ntvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022639; x=1722627439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d0/9lKjMdP113nceu4AM5nk6zUI0PzpLneOMwa1dqI=;
        b=e2ThY3ucBBmhN60qA3iPGMUXbAEfDnaUCH7e/5Cu5RbTFCMxSYInjeTN5l9SDkE+fr
         AEHibWUdrNOtn6cbk2mpdVZo9bca1hJW+LfKe+bPoOdUum/v11QT7sARoAT1JltZv9y9
         KM2PKpcQ7dBVUbxxjOFbEd9qKLn8ClfAfv5gTdSr87V60w0lSgF1J0t69g53MfTt5aS1
         1RP7CbuSto+r+DSYWFohdhp/yD4x5htmupx9axXFVd3PXgbJYtjrxH1X0OynUrh4j6YG
         p2zw3ZggnuP5y+ukduDEFZzkuQ2jkj7bf5k1vNmIt7xS8yVH1u12/y1ROq9QCPacXYDP
         ZvYA==
X-Gm-Message-State: AOJu0YzoaeVuaqVpa5yIWJsB1MVOHn29+WSetAQ1YgVlgDKwgh2qWHsc
	VL0il6IMjEKWcpmsSTDMZHcI4r/hJP0tk8WMgSeVlqdv+K/Ube1Iqdgtuwxf+ZqjZe/8An2K/bn
	r
X-Google-Smtp-Source: AGHT+IGy5pa3wanHI3NwJW8Gj+9IDiHZlGK/ANeIL0pRpvPyfFDFW5qDKA5XW8XPEJNMDN1sAxKD3g==
X-Received: by 2002:a05:6902:2510:b0:e0b:2fd0:6d34 with SMTP id 3f1490d57ef6-e0b543f752amr938263276.6.1722022639529;
        Fri, 26 Jul 2024 12:37:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f7a6a2sm847034276.23.2024.07.26.12.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 40/46] btrfs: convert btrfs_get_extent to take a folio
Date: Fri, 26 Jul 2024 15:36:27 -0400
Message-ID: <1e43ac3826c7a24e8b73d7b33932e80f2fb878df.1722022377.git.josef@toxicpanda.com>
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

We only pass this into read_inline_extent, change it to take a folio and
update the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/inode.c       | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index fc60c0cde479..2d7f8da54d8a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -578,7 +578,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 			      struct btrfs_path *path);
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, u64 start, u64 len);
+				    struct folio *folio, u64 start, u64 len);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ab5715de5f40..2a80dfbc8248 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -987,7 +987,7 @@ static struct extent_map *__get_extent_map(struct inode *inode, struct page *pag
 		*em_cached = NULL;
 	}
 
-	em = btrfs_get_extent(BTRFS_I(inode), page, start, len);
+	em = btrfs_get_extent(BTRFS_I(inode), page_folio(page), start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45835074aa6f..0cdb0b86e670 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6791,7 +6791,7 @@ static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path
  * Return: ERR_PTR on error, non-NULL extent_map on success.
  */
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, u64 start, u64 len)
+				    struct folio *folio, u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
@@ -6814,7 +6814,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	if (em) {
 		if (em->start > start || em->start + em->len <= start)
 			free_extent_map(em);
-		else if (em->disk_bytenr == EXTENT_MAP_INLINE && page)
+		else if (em->disk_bytenr == EXTENT_MAP_INLINE && folio)
 			free_extent_map(em);
 		else
 			goto out;
@@ -6944,7 +6944,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
 		ASSERT(em->len == fs_info->sectorsize);
 
-		ret = read_inline_extent(inode, path, page_folio(page));
+		ret = read_inline_extent(inode, path, folio);
 		if (ret < 0)
 			goto out;
 		goto insert;
-- 
2.43.0


