Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40CD60E8C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiJZTMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiJZTLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:39 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD8F41B1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z30so11354413qkz.13
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYgz5+l5nL787/l3zfiYsO9Lt/bY9Y2x2TfntFPBpx4=;
        b=kmqOskFvkDsf4c0AnPUbyReRU3eTODowDoR1TGhnUiGUjrOUlL4byafxsPPxnCi2xb
         cTi2bZvhzrJgk8ercPoiY4DQY0Wemiak4WkB82ygl8P8+yCOMlmwNjXIJPgwbiEs+34Q
         mTAwqKSVX7m85Qwllg9jzDXyCF9upccsE4deQssOAATwiP/kZCCILyEIs+bxTFRSQJ3X
         nkwXtn5bEElZWtlnp9PbfDGsh74vnbPWmVt+P30n+cLrXQ/8vUqfY5gRLpeXZ4gtUJRv
         vplKMDYZmwiIhMJtdDXr05Be7PGIei3gJO4WADY5WsDy49DLw9c1tmbmJJF6GjB/VQb7
         Fvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYgz5+l5nL787/l3zfiYsO9Lt/bY9Y2x2TfntFPBpx4=;
        b=skqQfQpx+Nr40B1CteX+qvLJcXxdhoGqR1MKvYRWWJOnTcFZ1B7g+3CFkptUtjOU/W
         GT071bRpmyDYAo4Cw7GeybAThG7YmbgBpa1yCXJIVhh8JzccioWRWvKutGkVItpqxuZY
         hzj2l/lT24/sIePwJ+PZc9pDDTfeHWygt+5kBWcu4qaM9+cCB95PNyclbfJMeYjpettr
         kvOdb93CMVFwdTfl1py26NMaOqKCuNrfsniESDXcWYXy/M34DSm6Ql8I5wVsV0yIN8RP
         x9TBJqkozOGSY1qgVVmRxVLfGflDHyJ+stX7NUaUwZZOCMVlZvbgkG905Y7pzXSlUB0o
         gG3w==
X-Gm-Message-State: ACrzQf088qq918LewkDrs52x5sDJJstyW10sW3fiRk9NuDlCneVW7SGr
        SFNvuKJa615sqFLkJCpvez1zZ2Pt7Tesxw==
X-Google-Smtp-Source: AMsMyM62rUZqVG8POGe1GZh7zTrlPdgQLlFUHF88h/w0lgY7fwv2Kmu/Zg0dB//U71ysXsh/Mukmbg==
X-Received: by 2002:a05:620a:2891:b0:6bc:5c73:9728 with SMTP id j17-20020a05620a289100b006bc5c739728mr32041218qkp.178.1666811340241;
        Wed, 26 Oct 2022 12:09:00 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h2-20020ac81382000000b0038b684a1642sm3617809qtj.32.2022.10.26.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/26] btrfs: move file-item prototypes into their own header
Date:   Wed, 26 Oct 2022 15:08:27 -0400
Message-Id: <4555d2f953254bc66af9e1a10183384c4b48b30f.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

Move these prototypes out of ctree.h and into file-item.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c      |  1 +
 fs/btrfs/ctree.h            | 30 ------------------------------
 fs/btrfs/defrag.c           |  1 +
 fs/btrfs/delayed-inode.c    |  1 +
 fs/btrfs/extent-tree.c      |  1 +
 fs/btrfs/extent_io.c        |  1 +
 fs/btrfs/file-item.c        |  1 +
 fs/btrfs/file-item.h        | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/file.c             |  1 +
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/inode-item.c       |  1 +
 fs/btrfs/inode.c            |  1 +
 fs/btrfs/reflink.c          |  1 +
 fs/btrfs/relocation.c       |  1 +
 fs/btrfs/scrub.c            |  1 +
 fs/btrfs/send.c             |  1 +
 fs/btrfs/tree-log.c         |  1 +
 17 files changed, 50 insertions(+), 30 deletions(-)
 create mode 100644 fs/btrfs/file-item.h

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 432019c18124..4ac42df7d35a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -34,6 +34,7 @@
 #include "extent_map.h"
 #include "subpage.h"
 #include "zoned.h"
+#include "file-item.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a2ec5044a1c6..6bfea55c82a0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -695,36 +695,6 @@ int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset);
 
-/* file-item.c */
-int btrfs_del_csums(struct btrfs_trans_handle *trans,
-		    struct btrfs_root *root, u64 bytenr, u64 len);
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
-int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root, u64 objectid, u64 pos,
-			     u64 num_bytes);
-int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct btrfs_path *path, u64 objectid,
-			     u64 bytenr, int mod);
-int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 offset, bool one_ordered);
-int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
-			     struct list_head *list, int search_commit,
-			     bool nowait);
-void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
-				     const struct btrfs_path *path,
-				     struct btrfs_file_extent_item *fi,
-				     struct extent_map *em);
-int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
-					u64 len);
-int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
-				      u64 len);
-void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size);
-u64 btrfs_file_extent_end(const struct btrfs_path *path);
-
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 98234aa4ee33..e3cc41295a41 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -14,6 +14,7 @@
 #include "delalloc-space.h"
 #include "subpage.h"
 #include "defrag.h"
+#include "file-item.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index a935709f2a29..ea80e2ee1de6 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -19,6 +19,7 @@
 #include "space-info.h"
 #include "fs.h"
 #include "accessors.h"
+#include "file-item.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 510be00da406..940d4fe23cfb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -40,6 +40,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "file-item.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b47bb8c590f..ec71de37c6dc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -32,6 +32,7 @@
 #include "compression.h"
 #include "fs.h"
 #include "accessors.h"
+#include "file-item.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d2fc6347ec75..50cd501d4f79 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -19,6 +19,7 @@
 #include "compression.h"
 #include "fs.h"
 #include "accessors.h"
+#include "file-item.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
new file mode 100644
index 000000000000..5a20e36fb5ab
--- /dev/null
+++ b/fs/btrfs/file-item.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_FILE_ITEM_H
+#define BTRFS_FILE_ITEM_H
+
+int btrfs_del_csums(struct btrfs_trans_handle *trans,
+		    struct btrfs_root *root, u64 bytenr, u64 len);
+blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
+int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root, u64 objectid, u64 pos,
+			     u64 num_bytes);
+int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root,
+			     struct btrfs_path *path, u64 objectid,
+			     u64 bytenr, int mod);
+int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
+			   struct btrfs_root *root,
+			   struct btrfs_ordered_sum *sums);
+blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
+				u64 offset, bool one_ordered);
+int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
+			     struct list_head *list, int search_commit,
+			     bool nowait);
+void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
+				     const struct btrfs_path *path,
+				     struct btrfs_file_extent_item *fi,
+				     struct extent_map *em);
+int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
+					u64 len);
+int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
+				      u64 len);
+void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size);
+u64 btrfs_file_extent_end(const struct btrfs_path *path);
+
+#endif
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0b52f4aae966..65a98bd5e395 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -33,6 +33,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "file-item.h"
 
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7a182cc6dab7..250eeaa0a0ea 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -28,6 +28,7 @@
 #include "inode-item.h"
 #include "fs.h"
 #include "accessors.h"
+#include "file-item.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 724507ce7a7d..b65c45b5d681 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -13,6 +13,7 @@
 #include "space-info.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "file-item.h"
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 						   int slot,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d02b0d7179ab..237efcab7c34 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -61,6 +61,7 @@
 #include "root-tree.h"
 #include "defrag.h"
 #include "dir-item.h"
+#include "file-item.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f0243eb33df7..2e7141d6942a 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -12,6 +12,7 @@
 #include "transaction.h"
 #include "subpage.h"
 #include "accessors.h"
+#include "file-item.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e345cc71da15..e86364bdac8e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -32,6 +32,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "file-item.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f50979511794..e6f9916501f6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -23,6 +23,7 @@
 #include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
+#include "file-item.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 78de4bf661f4..07524d070c48 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -29,6 +29,7 @@
 #include "print-tree.h"
 #include "accessors.h"
 #include "dir-item.h"
+#include "file-item.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5b89a9b755d8..f625819095f1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -26,6 +26,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "dir-item.h"
+#include "file-item.h"
 
 #define MAX_CONFLICT_INODES 10
 
-- 
2.26.3

