Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6458948FBCE
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiAPIve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPIvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:51:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FCCC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:51:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id f144so6163246pfa.6
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZA5kyCBNMxZ16dMYBW2Z9FsXO+BvPxsy2eLlwspomlw=;
        b=hVugHvCfyveGVHi8HOHOh+QvQtZY2TcKWc2shZCmdBpRh4pma9kArS2Xr6njNjfOpY
         nRBG8OEBYOVctol4vHx2lbDg83yyd5KBrBzEV3Rxsi1snt5DWuE2LkoRTXvBIY/rbgTy
         jdPdD2IJtw0rODYwyqMLP/6HRFNyItk6gu82kg/2LqzwWSfXNDbuU89FuYYblOMk8d21
         SwnXlQdszCB+5pF/r3RoK/ioCAcvxrf6TEiJUu/Q0wUoKFsugTFylHP+GMktuBOs6gP8
         TSXT7+5LaXQj798qA9vIsQX+iyTCx+aPNOdt/iUby8FEWuLg/f6724E821iJ4tTJWAVd
         Ml4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZA5kyCBNMxZ16dMYBW2Z9FsXO+BvPxsy2eLlwspomlw=;
        b=f7tlUBJ2ZrWW2e5PtkfgDvXTWNDEd7vqk7txMmLQkbh8Lo+bjrTHAa2bkovrL4i8zV
         SAYihdLRdMEZ9aL0iGAV5JU78YwXPMlhNR6mczmGlQ2wYhBa36VEzRRjxC4e8216CBEu
         1AejTl1f80Hdr31v9wlne8IF5vXysd3N8EA8AT6/opdLe8ta8AF0nEnu6IavPbF6S+xk
         M2i2IQHLC7b2iZSdZvGWKiS/z7ZLfRjxkNihbSUB9k82XeRqRJjrK3N6Bh8gi6NxkR3o
         XoQtHQYJxCKkNecGdNdbvku3xRLcvLwjmsSPbVaJbMF3lXuG27fc6mPch24nNlgEOzZE
         atUQ==
X-Gm-Message-State: AOAM532JR0P1HSJxht20v9AtOYlbhOQ5qC628lpla+CXHoPtmEMVO/M1
        DcN7hv1Bd7wBos9jaeitqetppcbS/00SKQCz
X-Google-Smtp-Source: ABdhPJxvYUw78fcUpJ7j7hX18s4xN27yJhd+MySr4AkjSbHSwVpM+qz6p6WbQh+et2t4xMve8dcIng==
X-Received: by 2002:a63:9e01:: with SMTP id s1mr14513392pgd.45.1642323093004;
        Sun, 16 Jan 2022 00:51:33 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id h3sm6484560pfg.18.2022.01.16.00.51.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:51:32 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH 5/5] btrfs: Compresses files using a combination of compression type and compression level.
Date:   Sun, 16 Jan 2022 16:51:23 +0800
Message-Id: <1642323083-2088-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

1. If the file is being defragmented, combine defrag_compress
and fs_info compression_level (defrag_compress will be
extended in the future).

2. Extract the compression type btrfs_inode using and write to extent,
because decompression does not need to know the compression level.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/inode.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3fe485b..fb44899 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -602,7 +602,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	unsigned long total_in = 0;
 	int i;
 	int will_compress;
-	int compress_type = fs_info->compress_type;
+	int compress_type = btrfs_compress_combine_type_level(
+        fs_info->compress_type, fs_info -> compress_level);
 	int compressed_extents = 0;
 	int redirty = 0;
 
@@ -683,7 +684,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		}
 
 		if (BTRFS_I(inode)->defrag_compress)
-			compress_type = BTRFS_I(inode)->defrag_compress;
+            compress_type = btrfs_compress_combine_type_level(
+                BTRFS_I(inode)->defrag_compress, fs_info->compress_level);
 		else if (BTRFS_I(inode)->prop_compress)
 			compress_type = BTRFS_I(inode)->prop_compress;
 
@@ -706,7 +708,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 
 		/* Compression level is applied here and only here */
 		ret = btrfs_compress_pages(
-			compress_type | (fs_info->compress_level << 4),
+			compress_type,
 					   inode->i_mapping, start,
 					   pages,
 					   &nr_pages,
@@ -743,7 +745,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/* try making a compressed inline extent */
 			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
 						    total_compressed,
-						    compress_type, pages);
+						    btrfs_compress_type(compress_type), pages);
 		}
 		if (ret <= 0) {
 			unsigned long clear_flags = EXTENT_DELALLOC |
@@ -808,10 +810,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			 * The async work queues will take care of doing actual
 			 * allocation on disk for these compressed pages, and
 			 * will submit them to the elevator.
+             * It only need to record compression type, because decompress don't need
+             * to know compression level
 			 */
 			add_async_extent(async_chunk, start, total_in,
 					total_compressed, pages, nr_pages,
-					compress_type);
+					btrfs_compress_type(compress_type));
 
 			if (start + total_in < end) {
 				start += total_in;
-- 
1.8.3.1

