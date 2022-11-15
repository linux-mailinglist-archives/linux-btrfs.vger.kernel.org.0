Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B4629EA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbiKOQQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiKOQQd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:33 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7272AE21
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:28 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 8so9807805qka.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNg5nl/IJ1SssLGIZrztxJXYNUwkzr1i/JYgOj0i/ew=;
        b=AVuSKgu8953LrTD89xMrPoEzDZAo2b7PtCqU9XpmX/nPuIwrrAVWhhI1i0OvooD7lg
         93iTMfHdIYC+kqckmN6EWhQe/xbRbxPRTchwEw5In0XZqGJV5ONTDxHu+liqv8D6WSL2
         Tg1yZMYZoCo3hCB8dYqQXDrJ8StLU5+nJm80OpBPxw+NTVw8ZTKD++LDRhfk4Z6Bkyw9
         neWbBiQTb6pbVnawPN5ss5mCNUfuFCb4QGXmj1qPJmJTVoFE1i0sbjgnkoHuuJg7tiRP
         i7eLMAIIFDNcJDRT/vP/Zc0QzmM26I6bAiQ1dRSYsB9ZmQXIscsscwFywL0o3xvUdgWO
         l3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNg5nl/IJ1SssLGIZrztxJXYNUwkzr1i/JYgOj0i/ew=;
        b=kJUtA8Frby0D+ODVZtGJ8ITvT2k1VDlCU6eV69N5Vqbm2pZ3mi3iQG244ADMwlA3oJ
         Gjz1eM4xTpwBDa7w8fDHcGBQyULtNG/JimedzVZJtj+uSe3GX9Bx8QixzK1fHUjV7SzW
         yFGuP8o1KglbvH/zl/Td+pyRRlP2VaST5DkNjF7mbubZxw1Gz5s/SHOogHMzkNayNj60
         /7dCEGIkZF7FeRqoUcHoefJvN7HnLW0HKCT2j4nOyLpZQZK80/V+jg4R8QcKDwe0ccvF
         nJ6vVKf02vJZKl7mm6I2//KUCCpwnS03wt/uwpt3fH1O6nl/7UbfyW4Z+tg099XW6xV2
         Oeuw==
X-Gm-Message-State: ANoB5pkIlbp2TCRTKBOyjzAnMuQWN0GhSDOMbB3w7A3KyQ9DLkzU0SSl
        edBnWFLeyigsLUk40V26p/ZwjSfZ3Omh/A==
X-Google-Smtp-Source: AA0mqf6cFul1v6nTVIgCxrOLIGbEMOZFtpiGwE+TnuPCmLBVldbThrgd8OZgOyIj0zINLd2cdwpJDg==
X-Received: by 2002:a05:620a:a84:b0:6fa:470:7ee4 with SMTP id v4-20020a05620a0a8400b006fa04707ee4mr15677742qkg.153.1668528987316;
        Tue, 15 Nov 2022 08:16:27 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a268300b006fa32a26433sm8594351qkp.38.2022.11.15.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/11] btrfs: move file_extent_item helpers into file-item.h
Date:   Tue, 15 Nov 2022 11:16:12 -0500
Message-Id: <5abe38f1371dde3e5953d65a82ac3ce17f3d2393.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
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

These helpers use functions that are in multiple places, which makes it
tricky to sync them into btrfs-progs.  Move them to file-item.h and then
include file-item.h in places that use these helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h    | 22 ----------------------
 fs/btrfs/ctree.c        |  1 +
 fs/btrfs/ctree.h        |  8 --------
 fs/btrfs/file-item.h    | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-checker.c |  1 +
 5 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index b9d9a69685df..f0d017f9407f 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -915,16 +915,6 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
 			 struct btrfs_file_extent_item, compression, 8);
 
-static inline unsigned long btrfs_file_extent_inline_start(
-				const struct btrfs_file_extent_item *e)
-{
-	return (unsigned long)e + BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
-static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
-{
-	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
-}
 
 BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
 BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
@@ -946,18 +936,6 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct btrfs_file_extent_item,
 BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_extent_item,
 		   other_encoding, 16);
 
-/*
- * Returns the number of bytes used by the item on disk, minus the size of any
- * extent headers.  If a file is compressed on disk, this is the compressed
- * size.
- */
-static inline u32 btrfs_file_extent_inline_item_len(
-						const struct extent_buffer *eb,
-						int nr)
-{
-	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
 		   generation, 64);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a70355d2edca..a5a2be4d7717 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -22,6 +22,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "relocation.h"
+#include "file-item.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1d045febe1cc..3870a556f421 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -460,14 +460,6 @@ static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
 	return BTRFS_LEAF_DATA_SIZE(info) / sizeof(struct btrfs_key_ptr);
 }
 
-#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
-		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
-static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_MAX_ITEM_SIZE(info) -
-	       BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
 static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 {
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index ba12711cf933..a827b08ba95b 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -3,6 +3,40 @@
 #ifndef BTRFS_FILE_ITEM_H
 #define BTRFS_FILE_ITEM_H
 
+#include "accessors.h"
+
+#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
+		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
+
+static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) -
+	       BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+/*
+ * Returns the number of bytes used by the item on disk, minus the size of any
+ * extent headers.  If a file is compressed on disk, this is the compressed
+ * size.
+ */
+static inline u32 btrfs_file_extent_inline_item_len(
+						const struct extent_buffer *eb,
+						int nr)
+{
+	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+static inline unsigned long btrfs_file_extent_inline_start(
+				const struct btrfs_file_extent_item *e)
+{
+	return (unsigned long)e + BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
+{
+	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
+}
+
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 1c2d418dda6a..32e051101a27 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -28,6 +28,7 @@
 #include "btrfs_inode.h"
 #include "fs.h"
 #include "accessors.h"
+#include "file-item.h"
 
 /*
  * Error message should follow the following format:
-- 
2.26.3

