Return-Path: <linux-btrfs+bounces-1707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092283AFE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB217B2C9F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26FC86AED;
	Wed, 24 Jan 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yPgmDd/b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E186AD9
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116789; cv=none; b=EZKlgsJCeU7SQ3ZwswzriBQhYY1zy+6lv6vk5AVULvVzhvLpPr9X9FWE7qyfIusia4xk1FEkrSoioS1frH1LqiHJIyu5fjoNJPoSDzYVz6nY68dXfLLzdekc6qOf8qm0XejZ+xGYG9XPa3j7tW+s40BU0P1rnW1DszeNquwhLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116789; c=relaxed/simple;
	bh=xtRcK6dBJ30zEI5sHqGvI8ghQ9gBYXldNuOQz/LkXDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkF6YbMEIUcgRHZAoiqcPWXAF5b2OaIgZ1uPvL+eNB9VJ7s05KOnzYSfhPMCwV8RplW8CLaxPv7Pk/HW7bKVBvrYSSkg8oKHmpFBAS9iGrp5SSHNNjWDTnsaxkDtuNZ9HtS5O2TvsVYFWG26gMsXo0rx0/dHagxO8ATvEqWV7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yPgmDd/b; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ffb07bdce2so44414537b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116786; x=1706721586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI2sbf+skviJ+MRQkNvfInK+KNm9MopeERBHzdCxnSI=;
        b=yPgmDd/bfrRvgZGrJ8kW2HOTqPA5mzgT5jNqgDuqSIWGmdwTXg7GvsmKE/VmyjiSIe
         q2Pt/cSZonFu1TPiR09kyK7TEu4UzvFzVGSHr5aVqvAqwQAgNa5fowlBaoPGLbe1wigv
         9i5Yincyb5V99WgDbkTQAU2+RI/HfP4dl58HZ+7JdiF8zkLbWaZiYOvB2nzmv+r5v9BR
         szy8tGZwmQB6OyjEQxu+wry3ckhXTHzWeSFNHv3U5wWskiw+56Eas/zwgCRjc4HIxKUD
         SloSLlTNiNoCS4cmO7DFmdSv3qq5hE/PiZoXofLOVMl0+7u4M6+xwVbzuopJCw9xU4/4
         tsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116786; x=1706721586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uI2sbf+skviJ+MRQkNvfInK+KNm9MopeERBHzdCxnSI=;
        b=Z8oEY5WlDvjKlsUoCUH+fSligU5Jl25WoLgpDkIqKo2C1hzy7GzNGq0wcT4YiZP2n2
         QH+f5hC8c9ii35xlN+A/M8C1Nov1Me1F7TGZQge+saV1GAF35mL5ek8BFXZLGyryvln5
         XL6U4bg3hBVOoZK9wisTv4xI9rQBO3rsEaicqibl1dUy2NJb1cFvuYdmeB+eTJwAr6/Y
         2X/756vXbqXOMRTf9xXHmQZPagNes3u5yoVkrSLgRpv9ot3lhOaC88nUxkGmzfvE/QtX
         RH2UjGAhyEnATYQGMJbBNvbLOBRBacb45mZx/4Aer6H6MGRi++c3JrevQClzTNvZeEIq
         hmjA==
X-Gm-Message-State: AOJu0YypAgG0/KNOheIoCuXuJ1nnBJ+hKV0AOUYGqvOJc0Xoae4M7pN1
	n+TZvClcGriSMCojqJolvXfD+WR3mAuvpMPzpBOuP/8UAkqj0rYNJvxS1HteZMN3UvcnybBy9Is
	K
X-Google-Smtp-Source: AGHT+IGqP7GJB6Xn3aj39qX4y3gCE5abUb2pmY2ZRXn9htEziGpXTCXYH7owzhSm9zTu7/T0JRbv7w==
X-Received: by 2002:a81:8314:0:b0:5ff:8dc8:2026 with SMTP id t20-20020a818314000000b005ff8dc82026mr1153924ywf.63.1706116786613;
        Wed, 24 Jan 2024 09:19:46 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id do1-20020a05690c23c100b005fc98de3763sm61505ywb.79.2024.01.24.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 25/52] btrfs: plumb the fscrypt extent context through create_io_em
Date: Wed, 24 Jan 2024 12:18:47 -0500
Message-ID: <f2b402eac1963296b6b8db3cb59cdf24a8121b97.1706116485.git.josef@toxicpanda.com>
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

For prealloc extents we create an em, since we already have the context
loaded from the original prealloc extent creation we need to
pre-populate the extent map fscrypt info so it can be read properly
later if the pages are evicted.  Add the argument for create_io_em and
set it to NULL until we're ready to populate it properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b14ba55e293..5d8cf2f83831 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -140,11 +140,12 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     struct page *locked_page, u64 start,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
-static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
-				       u64 ram_bytes, int compress_type,
-				       int type);
+static struct extent_map *create_io_em(struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 start, u64 len, u64 orig_start,
+				       u64 block_start, u64 block_len,
+				       u64 orig_block_len, u64 ram_bytes,
+				       int compress_type, int type);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 					  u64 root, void *warn_ctx)
@@ -1156,7 +1157,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	/* Here we're doing allocation and writeback of the compressed pages */
-	em = create_io_em(inode, start,
+	em = create_io_em(inode, NULL, start,
 			  async_extent->ram_size,	/* len */
 			  start,			/* orig_start */
 			  ins.objectid,			/* block_start */
@@ -1421,7 +1422,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		extent_reserved = true;
 
 		ram_size = ins.offset;
-		em = create_io_em(inode, start, ins.offset, /* len */
+		em = create_io_em(inode, NULL, start, ins.offset, /* len */
 				  start, /* orig_start */
 				  ins.objectid, /* block_start */
 				  ins.offset, /* block_len */
@@ -2154,7 +2155,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
+			em = create_io_em(inode, NULL, cur_offset,
+					  nocow_args.num_bytes,
 					  orig_start,
 					  nocow_args.disk_bytenr, /* block_start */
 					  nocow_args.num_bytes, /* block_len */
@@ -7055,8 +7057,9 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len, orig_start, block_start,
-				  block_len, orig_block_len, ram_bytes,
+		em = create_io_em(inode, NULL, start, len, orig_start,
+				  block_start, block_len, orig_block_len,
+				  ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  type);
 		if (IS_ERR(em))
@@ -7344,11 +7347,12 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 }
 
 /* The callers of this must take lock_extent() */
-static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
-				       u64 ram_bytes, int compress_type,
-				       int type)
+static struct extent_map *create_io_em(struct btrfs_inode *inode,
+				       struct fscrypt_extent_info *fscrypt_info,
+				       u64 start, u64 len, u64 orig_start,
+				       u64 block_start, u64 block_len,
+				       u64 orig_block_len, u64 ram_bytes,
+				       int compress_type, int type)
 {
 	struct extent_map *em;
 	int ret;
@@ -10555,7 +10559,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		goto out_delalloc_release;
 	extent_reserved = true;
 
-	em = create_io_em(inode, start, num_bytes,
+	em = create_io_em(inode, NULL, start, num_bytes,
 			  start - encoded->unencoded_offset, ins.objectid,
 			  ins.offset, ins.offset, ram_bytes, compression,
 			  BTRFS_ORDERED_COMPRESSED);
-- 
2.43.0


