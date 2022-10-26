Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4960E8BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiJZTL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiJZTLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:35 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4571E0A5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h24so10692448qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlwehgK/I8T3kwdfHSDAbCouQVn0GccQsInuKqi2Eg0=;
        b=yPRAxEdUrjD/czhSbK8WunK7fPOBIPSZnNCVVL/kOtqKvJrbK7uUQ7kOZF7ss2NFqO
         X8vw+Hr7rjqs64w6nGKAFq9y6tvwEGhVJp0WYWk1sphztf7kf4AEZO+mPh4YeQV66FlT
         1j52DVGJ8FJIEVPzO7vJObxQiUeKt2kCc8Vd6YiMQVHw7EFWIb1j/r7Zp2PIwAcTowjo
         q1WjrO0ugAK47T71qcrf3vobw4CAlYNXcZJ3WMl0CfwkI4J+EbyOFb/Wjl+N7gwYYHO5
         /QY3gy55uMVOOhfuZOeouDk7yolD1Y4RMRkfXVfzx5B1KNur4wu/jyMJ+yPJnfJwU+yX
         gDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlwehgK/I8T3kwdfHSDAbCouQVn0GccQsInuKqi2Eg0=;
        b=RYp0W+6Wp6WFtMI4FmHQQr/HfXkO9L7H6xqUFjq0bunBl7ihaZ56TWEf68ofaX9SMR
         ZWmEJeYNkx3bih9uF/Ejl5TS1zny6RVy3JesZ3MtNtl9KMqi3cL1GERbuJFkPOl9BNzo
         BfQnNvflpWAyAk1ez4JkpMl5+21KXyLcsDgM7/u6arbALTqGnJgnXGVzq3gCN21GlWg+
         c7pKd/NE1qEJbVcidLj5hFMcsJZT9aeRbttyty2YCN5BdU+NnvgNZKsPYRUbtKxJ0gFC
         kZ5efl7tNEzIBHju16UCt0KablB426/xZhnbdVcDOQR6konfevYkj40Ykh6whGq/JjiZ
         j/qg==
X-Gm-Message-State: ACrzQf2VSpSzvZvKzmK3R2WihtSH0GAR4JEGyhYG8uOOOHEj76W3JVJB
        fKLbMbQlzcNJYiWai5iIRyImlNB6P2Up7A==
X-Google-Smtp-Source: AMsMyM6JTThmXFO/n9VhFVG3+YLg0BfiSwo3xHoXyjBjoMS8+dBScYNUr+6Soi0wmBo+HIsjGYtR6w==
X-Received: by 2002:a05:622a:11d0:b0:39d:322:7c38 with SMTP id n16-20020a05622a11d000b0039d03227c38mr31959074qtk.291.1666811344558;
        Wed, 26 Oct 2022 12:09:04 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a269b00b006ee7923c187sm4397144qkp.42.2022.10.26.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/26] btrfs: move file prototypes to file.h
Date:   Wed, 26 Oct 2022 15:08:30 -0400
Message-Id: <c8a2baee43e9dfeb85c5c028b1b1d7b6f369d5d7.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into file.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            | 26 --------------------------
 fs/btrfs/extent_io.c        |  1 +
 fs/btrfs/file.c             |  1 +
 fs/btrfs/file.h             | 31 +++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/inode.c            |  1 +
 fs/btrfs/ioctl.c            |  1 +
 fs/btrfs/ordered-data.c     |  1 +
 fs/btrfs/reflink.c          |  1 +
 fs/btrfs/tree-log.c         |  1 +
 10 files changed, 39 insertions(+), 26 deletions(-)
 create mode 100644 fs/btrfs/file.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 87930337b301..3a46b5b688e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -688,32 +688,6 @@ int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset);
 
-/* file.c */
-int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
-extern const struct file_operations btrfs_file_operations;
-int btrfs_drop_extents(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct btrfs_inode *inode,
-		       struct btrfs_drop_extents_args *args);
-int btrfs_replace_file_extents(struct btrfs_inode *inode,
-			   struct btrfs_path *path, const u64 start,
-			   const u64 end,
-			   struct btrfs_replace_extent_info *extent_info,
-			   struct btrfs_trans_handle **trans_out);
-int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
-			      struct btrfs_inode *inode, u64 start, u64 end);
-ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
-			    const struct btrfs_ioctl_encoded_io_args *encoded);
-int btrfs_release_file(struct inode *inode, struct file *file);
-int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
-		      size_t num_pages, loff_t pos, size_t write_bytes,
-		      struct extent_state **cached, bool noreserve);
-int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
-int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
-			   size_t *write_bytes, bool nowait);
-void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
-bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
-				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
-
 /* super.c */
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ec71de37c6dc..e5287c4cd97f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -33,6 +33,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "file.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7b361a3d7785..be9048dc4658 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -35,6 +35,7 @@
 #include "extent-tree.h"
 #include "file-item.h"
 #include "ioctl.h"
+#include "file.h"
 
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
new file mode 100644
index 000000000000..16e1b564c220
--- /dev/null
+++ b/fs/btrfs/file.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_FILE_H
+#define BTRFS_FILE_H
+
+int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
+extern const struct file_operations btrfs_file_operations;
+int btrfs_drop_extents(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct btrfs_inode *inode,
+		       struct btrfs_drop_extents_args *args);
+int btrfs_replace_file_extents(struct btrfs_inode *inode,
+			   struct btrfs_path *path, const u64 start,
+			   const u64 end,
+			   struct btrfs_replace_extent_info *extent_info,
+			   struct btrfs_trans_handle **trans_out);
+int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
+			      struct btrfs_inode *inode, u64 start, u64 end);
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    const struct btrfs_ioctl_encoded_io_args *encoded);
+int btrfs_release_file(struct inode *inode, struct file *file);
+int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
+		      size_t num_pages, loff_t pos, size_t write_bytes,
+		      struct extent_state **cached, bool noreserve);
+int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
+int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
+			   size_t *write_bytes, bool nowait);
+void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
+bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
+				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
+
+#endif /* BTRFS_FILE_H */
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 250eeaa0a0ea..776dfd8f79a2 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -29,6 +29,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "file.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d33b4f9f4aaa..19d4f1f16723 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -64,6 +64,7 @@
 #include "file-item.h"
 #include "uuid-tree.h"
 #include "ioctl.h"
+#include "file.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2d691d147876..dfbb0e328bb2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -58,6 +58,7 @@
 #include "dir-item.h"
 #include "uuid-tree.h"
 #include "ioctl.h"
+#include "file.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1cbaacdc50da..eec2a4fe2ef4 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -18,6 +18,7 @@
 #include "delalloc-space.h"
 #include "qgroup.h"
 #include "subpage.h"
+#include "file.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 2e7141d6942a..bebe552d83be 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -13,6 +13,7 @@
 #include "subpage.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "file.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f625819095f1..b014e6946534 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -27,6 +27,7 @@
 #include "root-tree.h"
 #include "dir-item.h"
 #include "file-item.h"
+#include "file.h"
 
 #define MAX_CONFLICT_INODES 10
 
-- 
2.26.3

