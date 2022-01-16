Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD148FBCC
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiAPIuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPIuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:50:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F1C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:50:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a5so6920873pfo.5
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zN+XDftrgAUHFMiUX9svS8GFo19XMARuamUVJNyydnc=;
        b=WA40ANAqHR25SxTE3F5rnerQBxi3aHLvquzS3PswkUgH8Au991IJ0ANg5AOc0IWztZ
         kkIzYsrgRmisaY/Ne9Ud4ZOt8Zgj/yoATefxBlJnSahegswQkb6rPS4PIPnNhmfpBBHu
         kHo2btJRiXhcUmuRdmXBsbV5mtt9MtZEkV4Bm1kLxr5KawDwW92UHvewn2AHro1995U9
         NSkPb42Up1MvEd6GXNsRkkGywqpxh33XaFBSYK+3BGQyj9zD+8RP3+rd+y+jt+C6Y0WM
         NsYurx46O+DzY4+bLil+AcThUrl2YMRVAPMTvFpsrpsqBFiDmhjqYsveEU4z+y13w4pu
         PGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zN+XDftrgAUHFMiUX9svS8GFo19XMARuamUVJNyydnc=;
        b=05mxAoI8E7AJcPdbRqujiV52gwnmJA9Cd0BumiRhS9vTYgAYPUl6hIp9oWu+WKxe6G
         I7ZulYIya15fYDbJDP+WoC3SPtbBKHr2z7RI+JrStlUffuoXD2UH+drYgv3WzL6grUDL
         Tjfosqa9ZLoZkpgbGT0sg6icT8oedNDbfYHsb7I1t/eWIMXirmC7xwE2fUEtCoXEth6q
         dktaM05wk3X7skyUVEAzUb4lPGR6BY9SHedm5ozA0kdTtFC7Hq9782alXmdIPQDsZwrA
         R2ivjYNRY01fsC4a6w/48sQ68QnpTsFOJugKfhnLT9O/gZpfpXVv/kA2Z39txsn8PJBo
         5e6Q==
X-Gm-Message-State: AOAM530kuvO0iwoj3v/JwrMj0Fk1b9fYMU/zJfI1/SLYRJ9sl8WtfS7B
        P4pYghgkbaoDQmZb+WfvQ2hC9TWsFFZau6sX
X-Google-Smtp-Source: ABdhPJy0HdpZnuLJrmB2CiizMTqGNZxDKTTsOiUnQJazYf1PTTaF8FpKXB5FMmHfd9spXXT1saEZUw==
X-Received: by 2002:a05:6a00:1a94:b0:4c3:a8f8:1e46 with SMTP id e20-20020a056a001a9400b004c3a8f81e46mr3487020pfv.2.1642323016979;
        Sun, 16 Jan 2022 00:50:16 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id l2sm9849028pfe.189.2022.01.16.00.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:50:16 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH 3/5] btrfs: Convert compression description strings into system flags.
Date:   Sun, 16 Jan 2022 16:50:09 +0800
Message-Id: <1642323009-1953-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

1. Calls the function in compress.c to Clean
up the redundant code that parses the compression
description string into system flags.

2. Convert the compressed description string
to a combination of compression type and compression level.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/props.c | 52 +++++++++++++++++++++++----------
 fs/btrfs/super.c | 89 ++++++++++++++++++++++++--------------------------------
 2 files changed, 74 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 1a6d2d5..f07be37 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -272,13 +272,16 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int type;
+    char* clean_value;
+    int ret;
 
 	/* Reset to defaults */
 	if (len == 0) {
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
 		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
-		return 0;
+		ret = 0;
+        goto out;
 	}
 
 	/* Set NOCOMPRESS flag */
@@ -287,27 +290,44 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 		BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
 		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
-
-		return 0;
+        ret = 0;
+        goto out;
 	}
 
-	if (!strncmp("lzo", value, 3)) {
-		type = BTRFS_COMPRESS_LZO;
-		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
-	} else if (!strncmp("zlib", value, 4)) {
-		type = BTRFS_COMPRESS_ZLIB;
-	} else if (!strncmp("zstd", value, 4)) {
-		type = BTRFS_COMPRESS_ZSTD;
-		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
-	} else {
-		return -EINVAL;
-	}
+    /*
+     * The value contains gibberish at the end, we should clean it up.
+     */
+    clean_value = kzalloc(len + 1, GFP_NOFS);
+    if(!clean_value){
+        ret = -ENOMEM;
+        goto out;
+    }
+    strncpy(clean_value, value, len);
+
+    if(!btrfs_compress_is_valid_type(value, len)){
+        ret = -EINVAL;
+        goto free_clean_value;
+    }
+    type = btrfs_compress_str2type_level(clean_value, NULL, NULL);
+    switch(btrfs_compress_type(type)){
+        case BTRFS_COMPRESS_LZO:
+		    btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
+            break;
+        case BTRFS_COMPRESS_ZSTD:
+		    btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
+            break;
+        default:
+            break;
+    }
 
 	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
 	BTRFS_I(inode)->flags |= BTRFS_INODE_COMPRESS;
 	BTRFS_I(inode)->prop_compress = type;
-
-	return 0;
+    ret = 0;
+free_clean_value:
+    kfree(clean_value);
+out:
+	return ret;
 }
 
 static const char *prop_compression_extract(struct inode *inode)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0ec09fe..fea7e2d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -574,6 +574,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
+    unsigned compress_type_flag, compress_level_flag;
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -660,62 +661,48 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			saved_compress_force =
 				btrfs_test_opt(info, FORCE_COMPRESS);
 			saved_compress_level = info->compress_level;
-			if (token == Opt_compress ||
-			    token == Opt_compress_force ||
-			    strncmp(args[0].from, "zlib", 4) == 0) {
-				compress_type = "zlib";
-
-				info->compress_type = BTRFS_COMPRESS_ZLIB;
-				info->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
-				/*
-				 * args[0] contains uninitialized data since
-				 * for these tokens we don't expect any
-				 * parameter.
-				 */
-				if (token != Opt_compress &&
-				    token != Opt_compress_force)
-					info->compress_level =
-					  btrfs_compress_str2level(
-							BTRFS_COMPRESS_ZLIB,
-							args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "lzo", 3) == 0) {
-				compress_type = "lzo";
-				info->compress_type = BTRFS_COMPRESS_LZO;
+            if( token == Opt_compress || token == Opt_compress_force ){
+                /*
+                 * defaule compression type
+                 */
+                compress_type = "zlib";
+            } else {
+                compress_type = args[0].from;
+            }
+            if(!strncmp(compress_type, "no", 2)){
+                /*
+                 * Handle no compression specially
+                 */
+                btrfs_clear_opt(info->mount_opt, COMPRESS);
+                btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
+                compress_force = false;
+				info->compress_type = 0;
 				info->compress_level = 0;
+                no_compress++;
+            } else {
+                if(!btrfs_compress_is_valid_type(
+                    compress_type, strlen(compress_type))){
+                    ret = -EINVAL;
+                    goto out;
+                }
+                btrfs_compress_str2type_level(compress_type, 
+                    &compress_type_flag, &compress_level_flag);
+                switch(compress_type_flag){
+                    case BTRFS_COMPRESS_ZSTD:
+				        btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
+                        break;
+                    case BTRFS_COMPRESS_LZO:
+				        btrfs_set_fs_incompat(info, COMPRESS_LZO);
+                        break;
+                }
 				btrfs_set_opt(info->mount_opt, COMPRESS);
 				btrfs_clear_opt(info->mount_opt, NODATACOW);
 				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_LZO);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "zstd", 4) == 0) {
-				compress_type = "zstd";
-				info->compress_type = BTRFS_COMPRESS_ZSTD;
-				info->compress_level =
-					btrfs_compress_str2level(
-							 BTRFS_COMPRESS_ZSTD,
-							 args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
 				no_compress = 0;
-			} else if (strncmp(args[0].from, "no", 2) == 0) {
-				compress_type = "no";
-				info->compress_level = 0;
-				info->compress_type = 0;
-				btrfs_clear_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-				compress_force = false;
-				no_compress++;
-			} else {
-				ret = -EINVAL;
-				goto out;
-			}
-
+				info->compress_type = compress_type_flag;
+				info->compress_level = compress_level_flag;
+            }
+            
 			if (compress_force) {
 				btrfs_set_opt(info->mount_opt, FORCE_COMPRESS);
 			} else {
-- 
1.8.3.1

