Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944AC48FBCD
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiAPIvM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPIvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:51:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC08FC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:51:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so26516196pjj.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Aj8k9+/OKTeZFkRxHYPidLp3FJBXLDv6NXCNj/xJqMw=;
        b=c1B7NegVS6xaFrxmZ07aCC/AzCZunkf/NG2gi+ngiciFV/U53SK4W1GJmsIJcx369e
         MWRJPRHZcx+ukAjWtfO9uVgsFCBwf2pmbjhTeVg1CjBWJ0+ybA/aY4Va4Dxq7eCe8uG1
         OfWdAssZ0dHzkTwgVcMmQHlmRMSr0sJf0hNWzOOC2WXgoaN3pD5qmjoTMQNM46qW5Kqg
         7lqkKv+NIvcXUjAt0aU5U94Sh+RXBSk42vG8Rtk1bERLPtEn2/UXMke2N+zqkCAhuepB
         5SQbLwUeQjOIQ7tTZDsNRVL+gAiw//5iOW/GY/uFGyPjfAXGpXx1/shQP56rzdADxv+t
         wDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aj8k9+/OKTeZFkRxHYPidLp3FJBXLDv6NXCNj/xJqMw=;
        b=Qu2pnmrAQPfQ+XYHLEuPmAUQ5hy7wER5lYtAZj2wd+DSLcfp1N9KQ/zXD2Ue0N8k4m
         yATWjD67b8Re2awg/0kF0RPDHeBmtbU4Ymdu46icBQC9TxC/zJvaeF5H4b1MffnDc2/o
         OHIXEV7uZL7nA14xY7DEbHtHkohE8ElBpsET1FTL7IPIcOcJ6gohrFEUYCHNHfaMbKcc
         GQ2jil+wHg5vODXDOAotpmAAVxlVwdmnTvLs0WURn4abNyuoj9rh1ieg52LwzCskHurL
         Czsgtl6SBsK28+uD0pr19HsIaxxIfkODzR4VKxeWxwmzz6gHOkhy+8bDHljkHlx7rDOB
         W4hg==
X-Gm-Message-State: AOAM5327M6Lb4SGZdBbQkN1kJ8wIw/dAovMFPclrPxrypUQVHBiUBM5v
        g5VJ4mVw8Tik/WhK+MC4XCjnq8zUhMTEc4yf
X-Google-Smtp-Source: ABdhPJwCascWQNh94M4afHF++/YsWkA/FAQh75rbtCC/Ld8c3wfRoHU93uhQVMZ0cs3QgImju1cvhQ==
X-Received: by 2002:a17:903:191:b0:14a:5a6d:e86e with SMTP id z17-20020a170903019100b0014a5a6de86emr16876847plg.111.1642323071018;
        Sun, 16 Jan 2022 00:51:11 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id c21sm667787pgw.41.2022.01.16.00.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:51:10 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH 4/5] btrfs: Synchronize compression flag BTRFS_INODE_NOCOMPRESS with xattr.
Date:   Sun, 16 Jan 2022 16:50:57 +0800
Message-Id: <1642323057-2044-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

1. If the btrfs_inode flag is set to BTRFS_INODE_NOCOMPRESS,
insert axttr btrfs.compression=none.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/ioctl.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a5bd692..7036463 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -223,7 +223,8 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	struct btrfs_trans_handle *trans;
 	unsigned int fsflags, old_fsflags;
 	int ret;
-	const char *comp = NULL;
+	const char *comp;
+    char comp_xattr_str[512];
 	u32 binode_flags;
 
 	if (btrfs_root_readonly(root))
@@ -304,13 +305,19 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	}
 
 	/*
-	 * The COMPRESS flag can only be changed by users, while the NOCOMPRESS
-	 * flag may be changed automatically if compression code won't make
-	 * things smaller.
+	 * The COMPRESS and NOCOMPRESS flag can only be changed by users, while the 
+     * BTRFS_INODE_HEURISTIC_NOCOMPRESS flag may be changed automatically if 
+     * compression code won't make things smaller.
 	 */
+    memset(comp_xattr_str, 0, sizeof(comp_xattr_str));
 	if (fsflags & FS_NOCOMP_FL) {
 		binode_flags &= ~BTRFS_INODE_COMPRESS;
 		binode_flags |= BTRFS_INODE_NOCOMPRESS;
+        /*
+         * set xattr btrfs.compression to none if user set the NOCOMPRESS flag
+         */
+        strncpy(comp_xattr_str, "none", 5);
+        comp = comp_xattr_str;
 	} else if (fsflags & FS_COMPR_FL) {
 
 		if (IS_SWAPFILE(inode))
@@ -318,10 +325,19 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 
 		binode_flags |= BTRFS_INODE_COMPRESS;
 		binode_flags &= ~BTRFS_INODE_NOCOMPRESS;
-
-		comp = btrfs_compress_type2str(fs_info->compress_type);
-		if (!comp || comp[0] == 0)
-			comp = btrfs_compress_type2str(BTRFS_COMPRESS_ZLIB);
+        /*
+         * set xattr btrfs.compression to filesystem specify compression type:level
+         */
+        comp = btrfs_compress_type_level2str(fs_info->compress_type, 
+            fs_info->compress_level, comp_xattr_str, sizeof(comp_xattr_str));
+        /*
+         * filesystem doesn't specify compression method, use default compression type
+         */
+        if(!comp || comp[0] == ':') {
+            btrfs_compress_type_level2str(BTRFS_COMPRESS_ZLIB,
+                BTRFS_ZLIB_DEFAULT_LEVEL, comp_xattr_str,
+                sizeof(comp_xattr_str));
+        }
 	} else {
 		binode_flags &= ~(BTRFS_INODE_COMPRESS | BTRFS_INODE_NOCOMPRESS);
 	}
@@ -335,8 +351,8 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 		return PTR_ERR(trans);
 
 	if (comp) {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
-				     strlen(comp), 0);
+		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp_xattr_str,
+				     strlen(comp_xattr_str), 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
-- 
1.8.3.1

