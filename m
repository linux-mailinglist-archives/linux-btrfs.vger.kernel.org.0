Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADB7C4180
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjJJUla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjJJUlR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A2B9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:15 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7db1f864bso2045347b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970474; x=1697575274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KUH5mNaG/0p3sTE3eYcJAqpZYp281vwXEU6Fc+b6FA=;
        b=MmEi2Bkd4s74MRjhtIe9mifO0KP1gY1hkG0hopRTxIdzxllbREKwWP2ADJyzrjuf3R
         +QNyD3SgoQfV5YaLX5Ctfqpo2Id4axgXXKvjV54yKYGnbnsXG791Tz0BWr5kP0W3v3qR
         2ZxzdPfy7Z/9cHotxJ02aSbtqIT75LsDEHXM384a5MVWc2SUikdnWjIPIQ/BxSsFmqd/
         BQxapjemMKR1RSDyPdJsUa9ozCFDK+fNf+qdLtz07uo1cvHKN2EzTVVpRK1a77EdO8RK
         WgQuDw02KptqUMuRnp5SdJ6pdMPGQD5qI1LA3sLIMZEvApvdwROFdEoNN6SB8jjgmE2K
         WJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970474; x=1697575274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KUH5mNaG/0p3sTE3eYcJAqpZYp281vwXEU6Fc+b6FA=;
        b=WuHvhT/06iky764rnAEN7lgGP/KWyRWDa2MfK4+S3/aj211X44//10cu9Cp/OTlKAz
         33ghoB06sxZ4FLdeoDTN5mfv47uo6Er9hYn8bwvUd/DIsO9UYRSzRLYRcPOngaLa4SBL
         fsqKj+s/3obmfJmoeDqdYUm7CO/2HqLiJWp4ahXyHXZGK6ppoErnWWfDSCSGooPoeipx
         U1jVxIWLBsgLjNctyrFtb21ms6VUfHB+yB1bKJf/lSLHolrdZtGBN17H8/DGGQUYt9R4
         pcSUYdSBPI1cPFm66SIxM6FlZ2EWQkcoZp/KZ/zST3SMP3Iln57j2B1PH6/zshnmQq+/
         5hWA==
X-Gm-Message-State: AOJu0YweCGyFp7x/mozQH0z6RsnmtearPb/lX1TVh+9z2BHM1KP592ou
        omPANiLFYrv3obiG9QElBtUaag==
X-Google-Smtp-Source: AGHT+IHC9JiRGUt26OePCahGfMDDSIiFv4sUcCxpJvzEUqoZ3GRPMxdbMObItrQ/CkLQU5uAfJFHGg==
X-Received: by 2002:a0d:f003:0:b0:59b:4f2d:231 with SMTP id z3-20020a0df003000000b0059b4f2d0231mr21085500ywe.45.1696970474597;
        Tue, 10 Oct 2023 13:41:14 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s67-20020a815e46000000b0059b50f126fbsm4676785ywb.114.2023.10.10.13.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 09/36] btrfs: disable various operations on encrypted inodes
Date:   Tue, 10 Oct 2023 16:40:24 -0400
Message-ID: <a7b9e13bca63d9c1c33f7107b23473c65c8e07a4.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
index c9317c047587..4806ff34224a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -630,7 +630,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
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
index fabd856e5079..3c66630d87ee 100644
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
2.41.0

