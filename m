Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCF48FBCB
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiAPIt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPItY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:49:24 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D33C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:49:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s1so6860736pga.5
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kj2rL3+EXNXNSigOfpfTRHKmQGvuAazq1uuleqK9hc4=;
        b=nYSiOhwq60nZpL7ya6n4prIhAgKdcxyJF3106vvVpkiez3NfgUcUluKJtQ+f7ZInYh
         DdwPgTXO2DA1Ne5KbID11Hgl6UtMInzk7tXI35b0ybVlf3ESHZ+4A5hR1/J1HWVcV6O5
         KUey/5JjRvHK0OWfrzPUVowVucrP+MYqc2Y0pPV/ljCqrRBSBl16RqTjTf14TiMvbJoT
         cP6bEPJxM/gHYiGmpmwc7B8dNYzX0THUMTZ79IZ4afWGdr59F+hRus719Qq6HnGUg1K0
         5DQMSKyRXwelQrM70BXbeUUw7p572NtdQbVsMWk8ftOS6bRhjX/9qHx1ULohvG8H9oTb
         IMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kj2rL3+EXNXNSigOfpfTRHKmQGvuAazq1uuleqK9hc4=;
        b=K3NmQP0pe8E6kear4TJZxRQYIuxKZTj8mygyEGLJz049DeKE6BwH1iN1bWK2adZGQE
         NAGpF4j6v0t5j1NBMGVrz3NrMe6cbwJ/bbp8U5bomMxOXt2I1ZPPrDSerpb8FHWR3YH/
         zquOpln+yfT+zdeNe0XVEoSToVeT/g0UlP+zAmOMIjH5YxDdfcJvjNCtAmIj+m+IVfSR
         5w3cWRGrlJNrQD7A5n56dInVEw2vXJykwluBnvRrP8BJ//iE50eKiAsGFMwWKXaEE4R7
         tq4djwWdTHZeGkT9vutjYYq2mxsWTkZ62GxUfUGFN2mpp6BLINX3G+hWZNo7ZE5D2p2L
         fwPA==
X-Gm-Message-State: AOAM530xoFR3ySPooHG3M1uyHm3LOdiKL5Msta2aBqzcavk2yGsPx9gs
        21lIIS6hE5kqscR9jPCsVNjgXmLbDNIZr6Jc
X-Google-Smtp-Source: ABdhPJwG1nScW0U1poVvLdybTIHPHszntwGbsoU1qcmlEwcNALEKyX28YJcJ6kBi3kIwO1X5Z9z8bA==
X-Received: by 2002:a05:6a00:1905:b0:4a8:2f86:3f18 with SMTP id y5-20020a056a00190500b004a82f863f18mr16178208pfi.52.1642322963036;
        Sun, 16 Jan 2022 00:49:23 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id 10sm10549626pjc.6.2022.01.16.00.49.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:49:22 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH 2/5] btrfs: Introduce helper functions for compression.
Date:   Sun, 16 Jan 2022 16:49:13 +0800
Message-Id: <1642322953-1856-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

1. Introduce the compression type and compression level
combination function. Use the lowest 4 bits of unsigned
int to record the compression type and 5 - 8 bits to record
the compression level.

2. Introduce functions to parse compression description strings
into filesystem flags and vice versa.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/compression.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/compression.h | 14 ++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 71e5b2e..019ed2d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -49,6 +49,38 @@ const char* btrfs_compress_type2str(enum btrfs_compression_type type)
 	return NULL;
 }
 
+/*
+ * convert str to combination of compression type and level
+ * ret: combination of compression type and compress level
+ * return type and level separately if caller specify type and level pointer
+ */
+unsigned int btrfs_compress_str2type_level(const char *str, unsigned int *type, unsigned int *level){
+    int i;
+    unsigned int result_type, result_level;
+    size_t len = strlen(str);
+    result_type = BTRFS_COMPRESS_NONE;
+    result_level = 0;
+    for(i = 1; i < ARRAY_SIZE(btrfs_compress_types); i ++){
+        size_t comp_len = strlen(btrfs_compress_types[i]);
+        if(len < comp_len){
+            continue;
+        }
+        if(!strncmp(btrfs_compress_types[i], str, comp_len)){
+            result_type = BTRFS_COMPRESS_NONE + i;
+            result_level = btrfs_compress_str2level(result_type, str + comp_len);
+            break;
+        }
+    }
+    if(type != NULL){
+        *type = result_type;
+    }
+    if(level != NULL){
+        *level = result_level;
+    }
+    return btrfs_compress_combine_type_level(result_type, result_level);
+}
+
+
 bool btrfs_compress_is_valid_type(const char *str, size_t len)
 {
 	int i;
@@ -1888,3 +1920,22 @@ unsigned int btrfs_compress_str2level(unsigned int type, const char *str)
 
 	return level;
 }
+
+
+/*
+ * convert combination of compression type and level to meaningful string
+ * the caller should specify buffer and buffer size
+ */
+char *btrfs_compress_type_level2str(unsigned type, unsigned level, char *out, size_t out_len){
+	switch (type) {
+	case BTRFS_COMPRESS_ZLIB:
+	case BTRFS_COMPRESS_LZO:
+	case BTRFS_COMPRESS_ZSTD:
+	case BTRFS_COMPRESS_NONE:
+        snprintf(out, out_len, "%s:%d", btrfs_compress_types[type], btrfs_compress_set_level(type, level));
+        return out;
+	default:
+		break;
+	}
+    return NULL;
+}
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 56eef08..b76473c 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -76,6 +76,16 @@ static inline unsigned int btrfs_compress_level(unsigned int type_level)
 	return ((type_level & 0xF0) >> 4);
 }
 
+/*
+ * helper function combine compression type and level
+ * combine compression type and level in one byte
+ * the lower 4bit represent compression type
+ * the upper 4bit represent compression level 
+ */
+static inline unsigned int btrfs_compress_combine_type_level(unsigned int type, unsigned level){
+    return (level << 4) | type;
+}
+
 void __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
@@ -101,6 +111,10 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
+unsigned int btrfs_compress_str2type_level(const char *str, unsigned int * type, unsigned int *level);
+
+char *btrfs_compress_type_level2str(unsigned type, unsigned level, char *out, size_t out_len);
+
 enum btrfs_compression_type {
 	BTRFS_COMPRESS_NONE  = 0,
 	BTRFS_COMPRESS_ZLIB  = 1,
-- 
1.8.3.1

