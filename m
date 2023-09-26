Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB97AF22C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjIZSDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjIZSDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:31 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1913A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:23 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7741c5bac51so464075885a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751403; x=1696356203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvUgsr/82Ad7po+7Bh9YYtXxzP0gfJA3GRIgY9dfAeo=;
        b=iLsZMBwlqpUhxyoQdJYEUp9M+vlbmFa+IZ7mRNZyR4jxXgTnWe9VoOoT1sImyx0CGu
         1RYyWu/5GftaL9mISAEt9+O+jbG0td2PMGbLZCwZBs9sYYknK/1TOAXdIxnMmHmQ/laY
         3JzbbGldcd/dC6lVaf0vsHGCjYtKUY/LwuWqMbAb1ZYWFXiRUggNs1AHGOwSNR+Lk5Xa
         /J52zi+t0ZzxSRpirBS0YAy/IM9AxFxPj2HotIhbFvLxgThiKhG+YCsnRaEzviRd33x0
         E/YsJpelhIOK7CoHd0Uq8YvHPtUN179beNWYeh0aZ06XINMDb6CjaahCFXYpNWjrX0Xw
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751403; x=1696356203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvUgsr/82Ad7po+7Bh9YYtXxzP0gfJA3GRIgY9dfAeo=;
        b=d1FPMAT0JV5R7Nnux8ppDv+e/tSuj6w11Z8pJXT14hPyUIIMn63fcEZpFKatpoc8Ui
         foAy9DUE91mN+Dv5uoCdksvoEYUN+Kh2m37XVHg8HLfpC1YTuTEsbx8tnxYPPcBQTKJ6
         cEWYhbSqDYyevP1Prl56qU9Ifhjy9iSUkr+iIktoYAPK+vaOMQxGxJi6hh6YNf3AXc7L
         n60EIhtcptAj0GDWCMc6uXRN76uod6GVSSK/DggKQQWM9sYnPUPKL57ok0JadrHgO4If
         4bYUc5fPR5aA8fnm+IHx7xvzL52ICZ99K5NdNbk1m7CceC7RjqwV4JlZHbSImFxAFzxg
         jlvg==
X-Gm-Message-State: AOJu0YwSTcTbpqyVVqXTnqLN0AopGD+yN6lqLdmydb9RGT7da5N36q8U
        DQ3psHb3MPxwC3ax25vVC3vr30l7tkd1eDtKcqD48Q==
X-Google-Smtp-Source: AGHT+IEYeHPXf3QIxe/GVAvfnuEqDK1wXoiieUM37Xo4d063NQugH/UxgIQmqwE0WwURZVtFCGLlFQ==
X-Received: by 2002:a05:620a:288d:b0:76c:e7b7:1d9d with SMTP id j13-20020a05620a288d00b0076ce7b71d9dmr10200605qkp.27.1695751402655;
        Tue, 26 Sep 2023 11:03:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id oq36-20020a05620a612400b0076ef004f659sm4950020qkn.1.2023.09.26.11.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 08/35] btrfs: disable various operations on encrypted inodes
Date:   Tue, 26 Sep 2023 14:01:34 -0400
Message-ID: <18da950f00bca068377700367d6b0bc091f72fdf.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 52576deda654..6cba648d5656 100644
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

