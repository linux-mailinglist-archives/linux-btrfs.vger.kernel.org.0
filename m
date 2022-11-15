Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740FD629D8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKOPc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbiKOPb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:31:59 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75095286C1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:54 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id i9so9672231qki.10
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRFzNaHpk1wImxA4PyozxXJYAchUAXSv/kQe4Yxet0k=;
        b=GA1SRXQDcvYZ1gNy0+fzSN1XYtmF23xNFxfvYtvo8sqJ4pyd8YdLPkOgNi8nWUX7SW
         UMkhQAs7x3+FAfaxeVvnQatG0eu5pEJ798s0u7H05S2CCqjQBlphd0U4GFZGQeFnGGw9
         NvLOWetdqcdxmW+P+H0ZuLleb2izaEsMzRJEGVWaTUN8Lz+RMEohLKn9Qyts++Ll7XaR
         J2NPV1/Ci9GCNFs4clte6nLRWQ1H0LEjJRBJrd7N723YNpUa4ZMASnhBbwewjbdu0tB/
         GpPE2QjkFzfxgs834D0Qt3+GeO1IXiocvQ0INFCPlxOnkdi5pgFmEDXj+HysXSKIRk+8
         j8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRFzNaHpk1wImxA4PyozxXJYAchUAXSv/kQe4Yxet0k=;
        b=Z9MOYW5ob7JwRdhZpiemFYX/SvcT9bCsrt36duSSFRym+36Hi5ueNwjKnl1wwQDnJo
         jWZcb0b6YdZhRJ237Qcq7GxwS4LxJpj1JIxUyzy0hrL3N+nMMBH/0QIZ4vZhaamps4MC
         WeCX5qu0UpnmVJFKc1/XruY4O+csEOBcj5yHwzKd+abp14k1zcCqSQ7QGG67T5t2IoJJ
         kfeS2ATJM8XHzQgc8KGGpkAnOFII8z0HGK3VTVJJpCQ6joP5D+htAzfWiJOeH7EQKunf
         d5Tl+HeUv0iJ66TdRQOtWBLGPmURlF0iuHAEs7hGO52YvatcYQTPVFIhwf8NOXhulDBE
         gVag==
X-Gm-Message-State: ANoB5pkp1vxCxGBY+ff2BHAVSKQyQMDMGZN7voAy4/0vqxoj7/oO9Tgz
        41HTrba1uTAh5rLGzbuYEk+OpHR3Dz76JQ==
X-Google-Smtp-Source: AA0mqf4PZQCx++hennFfEoSVyBE2DpbfxnlnQSB/IEI8oXx8lDoGigtjF3jH/4Pr4jdF/clMvwmwKg==
X-Received: by 2002:a37:5ce:0:b0:6fa:1d53:95b3 with SMTP id 197-20020a3705ce000000b006fa1d5395b3mr14922060qkf.765.1668526312796;
        Tue, 15 Nov 2022 07:31:52 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id f7-20020ac84707000000b003995f6513b9sm7265772qtp.95.2022.11.15.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/18] btrfs-progs: sync compression.h from the kernel
Date:   Tue, 15 Nov 2022 10:31:22 -0500
Message-Id: <a2c4845c3242646cef739b80338a82a13328e551.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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

This patch copies in compression.h from the kernel.  This is relatively
straightforward, we just have to drop the compression types definition
from ctree.h, and update the image to use BTRFS_NR_COMPRESS_TYPES
instead of BTRFS_COMPRESS_LAST, and add a few things to kerncompat.h to
make everything build smoothly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c         |   1 +
 check/mode-lowmem.c         |   1 +
 cmds/filesystem.c           |   1 +
 cmds/restore.c              |   3 +-
 common/parse-utils.c        |   1 +
 kerncompat.h                |  21 ++++
 kernel-shared/compression.h | 184 ++++++++++++++++++++++++++++++++++++
 kernel-shared/ctree.h       |   9 --
 kernel-shared/file.c        |   1 +
 kernel-shared/print-tree.c  |   1 +
 10 files changed, 213 insertions(+), 10 deletions(-)
 create mode 100644 kernel-shared/compression.h

diff --git a/check/mode-common.c b/check/mode-common.c
index 7a38eceb..c8ac235d 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -27,6 +27,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/backref.h"
+#include "kernel-shared/compression.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index c62d8326..8377f647 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/backref.h"
+#include "kernel-shared/compression.h"
 #include "kernel-shared/volumes.h"
 #include "common/messages.h"
 #include "common/internal.h"
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index a0906b13..5ecd7871 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -35,6 +35,7 @@
 #include "kernel-lib/list.h"
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/ctree.h"
+#include "kernel-shared/compression.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-lib/list_sort.h"
 #include "kernel-shared/disk-io.h"
diff --git a/cmds/restore.c b/cmds/restore.c
index e9d3bdb8..19df6be2 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -43,6 +43,7 @@
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/compression.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/open-utils.h"
@@ -718,7 +719,7 @@ static int copy_file(struct btrfs_root *root, int fd, struct btrfs_key *key,
 				    struct btrfs_file_extent_item);
 		extent_type = btrfs_file_extent_type(leaf, fi);
 		compression = btrfs_file_extent_compression(leaf, fi);
-		if (compression >= BTRFS_COMPRESS_LAST) {
+		if (compression >= BTRFS_NR_COMPRESS_TYPES) {
 			warning("compression type %d not supported",
 				compression);
 			ret = -1;
diff --git a/common/parse-utils.c b/common/parse-utils.c
index 11ef2309..f16b7aac 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -25,6 +25,7 @@
 #include <strings.h>
 #include "libbtrfsutil/btrfsutil.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/compression.h"
 #include "common/parse-utils.h"
 #include "common/messages.h"
 #include "common/utils.h"
diff --git a/kerncompat.h b/kerncompat.h
index 15595500..dedcf5f0 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -192,6 +192,10 @@ struct mutex {
 	unsigned long lock;
 };
 
+typedef struct spinlock_struct {
+	unsigned long lock;
+} spinlock_t;
+
 #define mutex_init(m)						\
 do {								\
 	(m)->lock = 1;						\
@@ -550,4 +554,21 @@ do {									\
 	(x) = (val);							\
 } while (0)
 
+typedef struct refcount_struct {
+	int refs;
+} refcount_t;
+
+typedef u32 blk_status_t;
+typedef u32 blk_opf_t;
+typedef int atomic_t;
+
+struct work_struct {
+};
+
+typedef struct wait_queue_head_s {
+} wait_queue_head_t;
+
+#define __init
+#define __cold
+
 #endif
diff --git a/kernel-shared/compression.h b/kernel-shared/compression.h
new file mode 100644
index 00000000..285f1a9d
--- /dev/null
+++ b/kernel-shared/compression.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2008 Oracle.  All rights reserved.
+ */
+
+#ifndef BTRFS_COMPRESSION_H
+#define BTRFS_COMPRESSION_H
+
+#include "kerncompat.h"
+
+struct btrfs_inode;
+struct address_space;
+struct cgroup_subsys_state;
+
+/*
+ * We want to make sure that amount of RAM required to uncompress an extent is
+ * reasonable, so we limit the total size in ram of a compressed extent to
+ * 128k.  This is a crucial number because it also controls how easily we can
+ * spread reads across cpus for decompression.
+ *
+ * We also want to make sure the amount of IO required to do a random read is
+ * reasonably small, so we limit the size of a compressed extent to 128k.
+ */
+
+/* Maximum length of compressed data stored on disk */
+#define BTRFS_MAX_COMPRESSED		(SZ_128K)
+
+/* Maximum size of data before compression */
+#define BTRFS_MAX_UNCOMPRESSED		(SZ_128K)
+
+#define	BTRFS_ZLIB_DEFAULT_LEVEL		3
+
+struct compressed_bio {
+	/* Number of outstanding bios */
+	refcount_t pending_ios;
+
+	/* Number of compressed pages in the array */
+	unsigned int nr_pages;
+
+	/* the pages with the compressed data on them */
+	struct page **compressed_pages;
+
+	/* inode that owns this data */
+	struct inode *inode;
+
+	/* starting offset in the inode for our pages */
+	u64 start;
+
+	/* Number of bytes in the inode we're working on */
+	unsigned int len;
+
+	/* Number of bytes on disk */
+	unsigned int compressed_len;
+
+	/* The compression algorithm for this bio */
+	u8 compress_type;
+
+	/* Whether this is a write for writeback. */
+	bool writeback;
+
+	/* IO errors */
+	blk_status_t status;
+
+	union {
+		/* For reads, this is the bio we are copying the data into */
+		struct bio *orig_bio;
+		struct work_struct write_end_work;
+	};
+};
+
+static inline unsigned int btrfs_compress_type(unsigned int type_level)
+{
+	return (type_level & 0xF);
+}
+
+static inline unsigned int btrfs_compress_level(unsigned int type_level)
+{
+	return ((type_level & 0xF0) >> 4);
+}
+
+int __init btrfs_init_compress(void);
+void __cold btrfs_exit_compress(void);
+
+int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
+			 u64 start, struct page **pages,
+			 unsigned long *out_pages,
+			 unsigned long *total_in,
+			 unsigned long *total_out);
+int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
+		     unsigned long start_byte, size_t srclen, size_t destlen);
+int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
+			      struct compressed_bio *cb, u32 decompressed);
+
+blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
+				  unsigned int len, u64 disk_start,
+				  unsigned int compressed_len,
+				  struct page **compressed_pages,
+				  unsigned int nr_pages,
+				  blk_opf_t write_flags,
+				  struct cgroup_subsys_state *blkcg_css,
+				  bool writeback);
+void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
+				  int mirror_num);
+
+unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
+
+enum btrfs_compression_type {
+	BTRFS_COMPRESS_NONE  = 0,
+	BTRFS_COMPRESS_ZLIB  = 1,
+	BTRFS_COMPRESS_LZO   = 2,
+	BTRFS_COMPRESS_ZSTD  = 3,
+	BTRFS_NR_COMPRESS_TYPES = 4,
+};
+
+struct workspace_manager {
+	struct list_head idle_ws;
+	spinlock_t ws_lock;
+	/* Number of free workspaces */
+	int free_ws;
+	/* Total number of allocated workspaces */
+	atomic_t total_ws;
+	/* Waiters for a free workspace */
+	wait_queue_head_t ws_wait;
+};
+
+struct list_head *btrfs_get_workspace(int type, unsigned int level);
+void btrfs_put_workspace(int type, struct list_head *ws);
+
+struct btrfs_compress_op {
+	struct workspace_manager *workspace_manager;
+	/* Maximum level supported by the compression algorithm */
+	unsigned int max_level;
+	unsigned int default_level;
+};
+
+/* The heuristic workspaces are managed via the 0th workspace manager */
+#define BTRFS_NR_WORKSPACE_MANAGERS	BTRFS_NR_COMPRESS_TYPES
+
+extern const struct btrfs_compress_op btrfs_heuristic_compress;
+extern const struct btrfs_compress_op btrfs_zlib_compress;
+extern const struct btrfs_compress_op btrfs_lzo_compress;
+extern const struct btrfs_compress_op btrfs_zstd_compress;
+
+const char* btrfs_compress_type2str(enum btrfs_compression_type type);
+bool btrfs_compress_is_valid_type(const char *str, size_t len);
+
+int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
+
+int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int zlib_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+struct list_head *zlib_alloc_workspace(unsigned int level);
+void zlib_free_workspace(struct list_head *ws);
+struct list_head *zlib_get_workspace(unsigned int level);
+
+int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int lzo_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+struct list_head *lzo_alloc_workspace(unsigned int level);
+void lzo_free_workspace(struct list_head *ws);
+
+int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct page **pages, unsigned long *out_pages,
+		unsigned long *total_in, unsigned long *total_out);
+int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
+int zstd_decompress(struct list_head *ws, unsigned char *data_in,
+		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		size_t destlen);
+void zstd_init_workspace_manager(void);
+void zstd_cleanup_workspace_manager(void);
+struct list_head *zstd_alloc_workspace(unsigned int level);
+void zstd_free_workspace(struct list_head *ws);
+struct list_head *zstd_get_workspace(unsigned int level);
+void zstd_put_workspace(struct list_head *ws);
+
+#endif
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index fe0d2c9b..d3fc0660 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -149,15 +149,6 @@ struct btrfs_path {
 					sizeof(struct btrfs_item))
 #define BTRFS_MAX_EXTENT_SIZE		128UL * 1024 * 1024
 
-typedef enum {
-	BTRFS_COMPRESS_NONE  = 0,
-	BTRFS_COMPRESS_ZLIB  = 1,
-	BTRFS_COMPRESS_LZO   = 2,
-	BTRFS_COMPRESS_ZSTD  = 3,
-	BTRFS_COMPRESS_TYPES = 3,
-	BTRFS_COMPRESS_LAST  = 4,
-} btrfs_compression_type;
-
 enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_CLEAN,
 	BTRFS_TREE_BLOCK_INVALID_NRITEMS,
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index 59d82a1d..807ba477 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -21,6 +21,7 @@
 #include "common/utils.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
+#include "compression.h"
 #include "kerncompat.h"
 
 /*
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index e08c72df..e2f9f760 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -25,6 +25,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/compression.h"
 #include "common/utils.h"
 
 static void print_dir_item_type(struct extent_buffer *eb,
-- 
2.26.3

