Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E846497184
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jan 2022 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiAWMnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 07:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiAWMnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 07:43:10 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3EC06173B
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 04:43:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h5so4880988pfv.13
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 04:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=KvtTkS0ogvjdHS6XVi8yLd8qZHw/Y/rOtu35m3c5jn8=;
        b=Asj7bb+s9UMmcpdvAQ3b1GGP6DkbqFEDnhNW7X6VBtqVfw0ek6VEpsCmGQYsZ/seCh
         ZWEJfpZMsnwzYevtlli7+x0QaNLjxbB3eGiXC5Qg+udGoVNYpkMLtY3Icw5PGZ4syy1B
         ZVIgNJ52e/ku4j2tPwNYGHwdC2E/I0fcqkmncQQXOSGf95JngVRjgk/hivCEoDC+A0QI
         KcJQCej23ewBpTExKXKx8LGjk4z+5ZovG5CbCtZO7siGs1DwvOMgMZt8Rfa/fDoUY1Ig
         q1ST7TLDYauDSOE0/EICUR13KtCY/op3S1zSVB89w5jl+d8dTV6ud1gq28nizwWxK2w0
         zxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KvtTkS0ogvjdHS6XVi8yLd8qZHw/Y/rOtu35m3c5jn8=;
        b=lrVsfUafCxY4kM9DTYXCXo/MwImlu6kJqKIJKmdoXkeOKSTv+yE3G3hk47psPhGBkd
         ap0ZsTYfvXyFAdel8qBIJPN+ZZIRLmCMoOgHVI1eBb0s0He0l8B6j3E0Kpwv7hajbqVR
         EbgbYvAlm0zq7U524dHegFyJsaPjoc8SshG7KL9PXDyF+6Pkhpjn8UJRgt1KdGWjHvdt
         FV2wz1T7ug9BIWmtR7tWJilIsaTJkB9khoXCmsdwb8E6zCpQECWvNK0CXEekw8hub9o3
         hDn2vDj0cjBbiEUZhMPqgfqpJs4c4SFR45xdLTB5dKd2Z/NPhGDIoK890M6ga9ht5qjq
         w5Iw==
X-Gm-Message-State: AOAM531xksxeP90t+mHlijJ1gt0H09dhobYMS1cX3CGROY0k1xmgOtv1
        tJs4OtaKCfScOMQxbSffeqkjcKkfMhhsQxlW
X-Google-Smtp-Source: ABdhPJyBzzN3jeI1hfWh9kVI4+Sg+QdAXW28uR6g77AvojxCnhQE2zZLjskBdd8H55NjoFpX/maLDQ==
X-Received: by 2002:a63:6c89:: with SMTP id h131mr8730649pgc.106.1642941788784;
        Sun, 23 Jan 2022 04:43:08 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.39])
        by smtp.gmail.com with ESMTPSA id u4sm13282906pfk.51.2022.01.23.04.43.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jan 2022 04:43:08 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH] btrfs: Change how child btrfs_inode inherits xattr compression from parent after expanding btrfs_info member prop_compress
Date:   Sun, 23 Jan 2022 20:43:00 +0800
Message-Id: <1642941780-17773-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, the patch I submitted fails xfstest/btrfs/048.

[patch link]
https://lore.kernel.org/linux-btrfs/1642323009-1953-1-git-send-email-zhanglikernel@gmail.com/

This is due to the following reasons.

[Problem Description]
1. Expanded struct btrfs_info member prop_compress to record
compression type and level, but did not change prop_compress allocation and initialization.
2. Inheriting inode still considers the parent inode member prop_compress just
records the compression type, it is wrong to parse prop_compress to compressed xattr.

[Repair method]
1. If the struct btrfs_inode member prop_compress is assigned or initialized to
BTRFS_COMPRESS_NONE , it will combine the compression type and compression level 0.
2. If a btrfs_inode inherits properties from parent, resolve prop_compress
to xattr compression <compression_type>:<compression_type>

But this changes the way the child btrfs_inode inherits properties from the
parent node, because parsing prop_compress as xattr compression <compression_type>:<compression_type>
formats xattr compression and therefore changes the behavior of btrfs.

Specifically:

Old behavior:
$ mkdir <parent directory>
$ btrfs attribute set <parent_dir> compressed zstd
$ btrfs attribute gets <parent_dir>
compressed=zstd
$ mkdir <parent directory>/1
$ touch <parent directory>/2
$ btrfs property gets <parent_dir>/1
compressed=zstd
$ btrfs attribute gets <parent_dir>/2
compressed=zstd

New behavior:
$ mkdir <parent directory>
$ btrfs attribute set <parent_dir> compressed zstd
$ btrfs attribute gets <parent_dir>
compressed=zstd
$ mkdir <parent directory>/1
$ touch <parent directory>/2
$ btrfs property gets <parent_dir>/1
compressed=zstd:3
$ btrfs attribute gets <parent_dir>/2
compressed=zstd:3

[Puzzled]
1. Because it will format the child's btrfs_inode xattr compression,
it still fails the fstest/btrfs/048 test, what can I do to fix it completely?
2. The original way of parsing the struct btrfs_inode member prop_compress was
to get only the compression, so it could return a global compression description,
but now it will combine the compression type and compression level, so this patch returns a
dynamic memory buf and is used by the callee, which Is there a better way to return the compressed
description xattr string?

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/inode.c |  2 +-
 fs/btrfs/props.c | 39 ++++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fb44899..16d40bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8796,7 +8796,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 		btrfs_init_metadata_block_rsv(fs_info, &ei->block_rsv,
 					      BTRFS_BLOCK_RSV_DELALLOC);
 	ei->runtime_flags = 0;
-	ei->prop_compress = BTRFS_COMPRESS_NONE;
+	ei->prop_compress = btrfs_compress_combine_type_level(BTRFS_COMPRESS_NONE, 0);
 	ei->defrag_compress = BTRFS_COMPRESS_NONE;
 
 	ei->delayed_node = NULL;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f07be37..b6d8e6a 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -279,7 +279,7 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 	if (len == 0) {
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
-		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
+		BTRFS_I(inode)->prop_compress = btrfs_compress_combine_type_level(BTRFS_COMPRESS_NONE, 0);
 		ret = 0;
         goto out;
 	}
@@ -289,7 +289,7 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 	    (len == 4 && strncmp("none", value, 4) == 0)) {
 		BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
 		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
-		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
+		BTRFS_I(inode)->prop_compress = btrfs_compress_combine_type_level(BTRFS_COMPRESS_NONE, 0);
         ret = 0;
         goto out;
 	}
@@ -332,15 +332,24 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 
 static const char *prop_compression_extract(struct inode *inode)
 {
-	switch (BTRFS_I(inode)->prop_compress) {
+    char *type_level = NULL;
+    int type_level_buf_len = 50;
+    
+    type_level = (char *)kmalloc(type_level_buf_len, GFP_NOFS);
+    if (!type_level) {
+        return NULL;
+    }
+	switch (btrfs_compress_type(BTRFS_I(inode)->prop_compress)) {
 	case BTRFS_COMPRESS_ZLIB:
 	case BTRFS_COMPRESS_LZO:
 	case BTRFS_COMPRESS_ZSTD:
-		return btrfs_compress_type2str(BTRFS_I(inode)->prop_compress);
+		return btrfs_compress_type_level2str(btrfs_compress_type(BTRFS_I(inode)->prop_compress), btrfs_compress_level(BTRFS_I(inode)->prop_compress), type_level, type_level_buf_len);
 	default:
 		break;
 	}
-
+    if (type_level) {
+        kfree(type_level);
+    }
 	return NULL;
 }
 
@@ -371,22 +380,26 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 	for (i = 0; i < ARRAY_SIZE(prop_handlers); i++) {
 		const struct prop_handler *h = &prop_handlers[i];
 		const char *value;
+        int is_compression_xattr = !strncmp(h->xattr_name, XATTR_BTRFS_PREFIX "compression", strlen(XATTR_BTRFS_PREFIX "compression"));
 		u64 num_bytes = 0;
 
 		if (!h->inheritable)
 			continue;
 
 		value = h->extract(parent);
+        btrfs_info(fs_info, "inherit_props values:%s", value);
 		if (!value)
 			continue;
-
 		/*
 		 * This is not strictly necessary as the property should be
 		 * valid, but in case it isn't, don't propagate it further.
 		 */
 		ret = h->validate(value, strlen(value));
-		if (ret)
+		if (ret) {
+            if (is_compression_xattr)
+                kfree(value);
 			continue;
+        }
 
 		/*
 		 * Currently callers should be reserving 1 item for properties,
@@ -400,8 +413,11 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 			ret = btrfs_block_rsv_add(fs_info, trans->block_rsv,
 						  num_bytes,
 						  BTRFS_RESERVE_NO_FLUSH);
-			if (ret)
+			if (ret) {
+                if (is_compression_xattr)
+                    kfree(value);
 				return ret;
+            }
 		}
 
 		ret = btrfs_setxattr(trans, inode, h->xattr_name, value,
@@ -419,10 +435,15 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 		if (need_reserve) {
 			btrfs_block_rsv_release(fs_info, trans->block_rsv,
 					num_bytes, NULL);
-			if (ret)
+			if (ret) {
+                if (is_compression_xattr)
+                    kfree(value);
 				return ret;
+            }
 		}
 		need_reserve = true;
+        if (is_compression_xattr)
+            kfree(value);
 	}
 
 	return 0;
-- 
1.8.3.1

