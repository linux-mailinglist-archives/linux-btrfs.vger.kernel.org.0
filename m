Return-Path: <linux-btrfs+bounces-1692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10283AF89
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D0B1F26F16
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4FB82D94;
	Wed, 24 Jan 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Q8RxY0Ht"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59F82D71
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116774; cv=none; b=iFyCAaXkDs0NdKaZPK5x3VFMeeaSUVvm+Ff5WR9UYvdU3Ka1wXjp7hbtYlHF1JPgrXHX1bo1ANHWD5bNyt+WsT2Rm5nbORndFJsrkIZRv5/nCTKkd2QHrnW9R/eaS2HgJGiYcPUlnXjMhIuM+/60JTlvCSIXfW0WcB5lNvY9+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116774; c=relaxed/simple;
	bh=Cl0q0mHy+OuiyGgyIEFPo6cO6ZyClhg2rMG5vgFqyBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYvxYoMPyPnO5ttXeC6FMn5HdxM9yhkBfZV/lpetl+DuH79lF8u3J3vBW8d90Us2KR3rEct+aaW1js4nbR4Ax72hnU6J4u1cOyRwFA8lvPcMNCc5bi5PUSC8X6f0bL2C39Xj3KXTUGZp3gAAZSyWeATOyybdDcLC9nawoEY2970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Q8RxY0Ht; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5fc2e997804so52224097b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116771; x=1706721571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH2EKMKBSNEeu4gP5LCCBuqQDLw8uHSTnP4/ZUu0wsk=;
        b=Q8RxY0Hthrh3+r23ei+HgXXzPAdQ6BI3koQS2LINUDkwgf5Q4acPH0Ph3fNO6DwdNZ
         YjcToauxEDm3XIoGBAHhazT8NoH9JWVria1tw88wootRYwIcfNX5ySZow2AjWUZk/1eG
         x9ERp0PlabWy/n/UufQaK9h9IRiF95Jxgobbr2C5N3F3U58mhgRIgqt6jxA+DFyikJC6
         DLHucZVnhuAZYAp5dsDYb+4uORs2HGf9cF1SRzK8gt0OF38wOg3Lv52sBGhE4X4SxE1+
         MAtwKH1rCoCH2a3544+VId4SJU94QgROPtWaTbew2dVuskUgY14iyMRDGZY39ghh9sFc
         Iulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116771; x=1706721571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH2EKMKBSNEeu4gP5LCCBuqQDLw8uHSTnP4/ZUu0wsk=;
        b=Q2e3dqWuzBQrPBU+o7atuC04GHdn49ixrp2ibixkI5iRnEFX5FoJqZ5IfrithPoseS
         JPDdr6Ac9EhZ1RPpm6eer42lPT9OUpC47TPm6sLxbUF2aeHgZRJ0TrfmGKmPKgOIIzpw
         xpLBMneTn3u6UTldkzkWezO+g1WZPvapY+uTM8JOHI+fUvwC/4et1xeNvJJVp9vZovLJ
         IFLcXk29woL9w6mRwrRD66yM5Sil2YBrSdog5lp9I8bmETsS0UtRjLcUkO6t0EKytvQM
         R6gDO69taZJVCDfx2Z0cJPPmT/pKHG49/WdGI0cnigkyWUHut3SL32+Ux/fVGhN2dQOC
         LolQ==
X-Gm-Message-State: AOJu0YxfPvmmm4rDcX1nIrcDV/wrfSeJcyIoDpmJ8RgDhYANdwktwG9p
	KSxD3jj2XTteERaVR4rSeMXLbKlFhTh+Mj//bDZRG3i0MF2NULYrAH7txWa9788RrMr8HswA34V
	y
X-Google-Smtp-Source: AGHT+IG5HHlloxTpZ1etIlGxjZuYbCsD+AZNFsXVdVAzAdqg6uRVsN8gycDkkoltiwNZOIYNoNrkaw==
X-Received: by 2002:a81:4808:0:b0:5f4:fd2b:89b with SMTP id v8-20020a814808000000b005f4fd2b089bmr1179641ywa.16.1706116771473;
        Wed, 24 Jan 2024 09:19:31 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fl15-20020a05690c338f00b005ff9d3ca38fsm67272ywb.1.2024.01.24.09.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:31 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 10/52] btrfs: disable various operations on encrypted inodes
Date: Wed, 24 Jan 2024 12:18:32 -0500
Message-ID: <0d1c1c34c9a9e2999a1cb5c76ed72ddcb866595e.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@osandov.com>

Initially, only normal data extents will be encrypted. This change
forbids various other bits:
- allows reflinking only if both inodes have the same encryption status
- disable inline data on encrypted inodes

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   | 3 ++-
 fs/btrfs/reflink.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bedd8703bfa6..c6122c20ad3a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -639,7 +639,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * compressed) data fits in a leaf and the configured maximum inline
 	 * size.
 	 */
-	if (size < i_size_read(&inode->vfs_inode) ||
+	if (IS_ENCRYPTED(&inode->vfs_inode) ||
+	    size < i_size_read(&inode->vfs_inode) ||
 	    size > fs_info->sectorsize ||
 	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
 	    data_len > fs_info->max_inline)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index e38cb40e150c..c61e54983faf 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/blkdev.h>
+#include <linux/fscrypt.h>
 #include <linux/iversion.h>
 #include "ctree.h"
 #include "fs.h"
@@ -809,6 +810,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		ASSERT(inode_in->i_sb == inode_out->i_sb);
 	}
 
+	/*
+	 * Can only reflink encrypted files if both files are encrypted.
+	 */
+	if (IS_ENCRYPTED(inode_in) != IS_ENCRYPTED(inode_out))
+		return -EINVAL;
+
 	/* Don't make the dst file partly checksummed */
 	if ((BTRFS_I(inode_in)->flags & BTRFS_INODE_NODATASUM) !=
 	    (BTRFS_I(inode_out)->flags & BTRFS_INODE_NODATASUM)) {
-- 
2.43.0


