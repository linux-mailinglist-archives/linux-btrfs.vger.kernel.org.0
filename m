Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F266E8343
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjDSVRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDSVRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B6744BE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l17so994241qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939053; x=1684531053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+U+0WSawAMs1teeq4bz8GVRzzfl1AEW3Q7VonhcEO4=;
        b=Yc+g0HN/jl/924trUO0BovFZfjKIR9T4mLSjWgWPkgTTLSoWos1lRyH+zBgiC6tC6B
         bRa0ZHlNnOHWfFkI3/K3dZ8a+MEfEFAgZ+4T0PHOwZooUn9G6w7iAamAS/DRQ5s1/msl
         Sy01xDYivJuXBkc2sUGDBbZ8ToK+wblaUwoIZZ+Gix2J10Wr+oITE/SPJHd/7f+RYaHj
         5BWF6pbhGBg6eMKe/x1+vQkVXnkkPvEjwhOVVoE3fBnLIlArxhP9M8sw7heHFG2GJMzG
         Lax7dzw6H04nT8ssSmemRORanwBTeMREIMlbOkLuWVuTOtadxwNCCiU5tDPqz3CRJikx
         uKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939053; x=1684531053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+U+0WSawAMs1teeq4bz8GVRzzfl1AEW3Q7VonhcEO4=;
        b=UlO6tfHHS3hqxeaNGvuyDjIzTthmvQ00syB4SHTwpB8snx8nK7eg3ntg1LSqaWRS+z
         pnTrM0tdL/wx7OrFQPV/CjeLeZXk+soZCZuoxNQVJph++uBupr+71vDK6Lt6Ug36/S7T
         rIgycM6mEdjTOAjTOr02dbR/MetdHj59fZ/OOdsEz1l01dabUrOClpT51MSAhtEHWu/Q
         ddqzISXnOvoJd9c3AnwJAZkVPchtuHAXAXYzB5QbPADwlVAK9MU99fc5gYriFTaMcaKJ
         OSll4eNMOO1NM9FkgMniSHRmYtItumL4tUlOeEGWjTrboeddTCmivr/stUvsE7pOAd+0
         zEcA==
X-Gm-Message-State: AAQBX9etJ8yE1Fevskc8tZ+Wbz+ukX3gWYqlpDKyX6X+OUpis4cvaTw9
        KfCE2sRRnmYFzUURUf+81h/pAktjO+/K122BDpOkWA==
X-Google-Smtp-Source: AKy350ZpMVzjih+DivzqfDmPVesvqUXkdCpmjAgmTTGKyW5bFXUE3WSd0Rk9iXgywyUH+Lc8i9VZaQ==
X-Received: by 2002:a05:6214:21e7:b0:5ef:653e:16a5 with SMTP id p7-20020a05621421e700b005ef653e16a5mr21683033qvj.39.1681939052681;
        Wed, 19 Apr 2023 14:17:32 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dl15-20020ad44e0f000000b005ef72557902sm2528109qvb.58.2023.04.19.14.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs-progs: sync file-item.h into progs
Date:   Wed, 19 Apr 2023 17:17:17 -0400
Message-Id: <371fd51f9b97e565b4d25ae50897d05da740b52d.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
References: <cover.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch syncs file-item.h into btrfs-progs.  This carries with it an
API change for btrfs_del_csums, which takes a root argument in the
kernel, so all callsites have been updated accordingly.

I didn't sync file-item.c because it carries with it a bunch of bio
related helpers which are difficult to adapt to the kernel.
Additionally there's a few helpers in the local copy of file-item.c that
aren't in the kernel that are required for different tools.

This requires more cleanups in both the kernel and progs in order to
sync file-item.c, so for now just do file-item.h in order to pull things
out of ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c       |  3 +-
 check/clear-cache.c         |  7 ++-
 check/main.c                |  1 +
 check/mode-common.c         |  6 ++-
 check/mode-lowmem.c         |  1 +
 cmds/inspect-tree-stats.c   |  1 +
 cmds/restore.c              |  1 +
 convert/main.c              |  1 +
 convert/source-ext2.c       |  1 +
 image/main.c                |  1 +
 kernel-shared/ctree.h       | 45 -------------------
 kernel-shared/extent-tree.c |  7 ++-
 kernel-shared/file-item.c   | 13 +++---
 kernel-shared/file-item.h   | 89 +++++++++++++++++++++++++++++++++++++
 kernel-shared/file.c        |  1 +
 kernel-shared/print-tree.c  |  1 +
 mkfs/rootdir.c              |  1 +
 17 files changed, 124 insertions(+), 56 deletions(-)
 create mode 100644 kernel-shared/file-item.h

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 91e5c7dd..35933854 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/file-item.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/extent-cache.h"
@@ -1098,7 +1099,7 @@ static int delete_csum(struct btrfs_root *root, u64 bytenr, u64 bytes)
 		return ret;
 	}
 
-	ret = btrfs_del_csums(trans, bytenr, bytes);
+	ret = btrfs_del_csums(trans, root, bytenr, bytes);
 	if (ret)
 		error("error deleting csums %d", ret);
 	btrfs_commit_transaction(trans, root);
diff --git a/check/clear-cache.c b/check/clear-cache.c
index ecc95167..9074557e 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -21,6 +21,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/file-item.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "check/common.h"
@@ -462,6 +463,7 @@ int truncate_free_ino_items(struct btrfs_root *root)
 	while (1) {
 		struct extent_buffer *leaf;
 		struct btrfs_file_extent_item *fi;
+		struct btrfs_root *csum_root;
 		struct btrfs_key found_key;
 		u8 found_type;
 
@@ -520,7 +522,10 @@ int truncate_free_ino_items(struct btrfs_root *root)
 				goto out;
 			}
 
-			ret = btrfs_del_csums(trans, extent_disk_bytenr,
+			csum_root = btrfs_csum_root(trans->fs_info,
+						    extent_disk_bytenr);
+			ret = btrfs_del_csums(trans, csum_root,
+					      extent_disk_bytenr,
 					      extent_num_bytes);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
diff --git a/check/main.c b/check/main.c
index 5683fb1b..513fa553 100644
--- a/check/main.c
+++ b/check/main.c
@@ -41,6 +41,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/backref.h"
 #include "kernel-shared/ulist.h"
+#include "kernel-shared/file-item.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
 #include "common/internal.h"
diff --git a/check/mode-common.c b/check/mode-common.c
index 412a9fd5..120165aa 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/backref.h"
 #include "kernel-shared/compression.h"
+#include "kernel-shared/file-item.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
@@ -1311,7 +1312,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 		if (type == BTRFS_FILE_EXTENT_PREALLOC) {
 			start += btrfs_file_extent_offset(node, fi);
 			len = btrfs_file_extent_num_bytes(node, fi);
-			ret = btrfs_del_csums(trans, start, len);
+			ret = btrfs_del_csums(trans, csum_root, start, len);
 			if (ret < 0)
 				goto out;
 		}
@@ -1473,7 +1474,8 @@ static int remove_csum_for_file_extent(u64 ino, u64 offset, u64 rootid, void *ct
 	btrfs_release_path(&path);
 
 	/* Now delete the csum for the preallocated or nodatasum range */
-	ret = btrfs_del_csums(trans, disk_bytenr, disk_len);
+	root = btrfs_csum_root(fs_info, disk_bytenr);
+	ret = btrfs_del_csums(trans, root, disk_bytenr, disk_len);
 out:
 	btrfs_release_path(&path);
 	return ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 18eac047..237e0fdb 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -30,6 +30,7 @@
 #include "kernel-shared/backref.h"
 #include "kernel-shared/compression.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/file-item.h"
 #include "common/messages.h"
 #include "common/internal.h"
 #include "common/utils.h"
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index 4c6104c1..08be1686 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/file-item.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/messages.h"
diff --git a/cmds/restore.c b/cmds/restore.c
index da5bafd1..c38cb541 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -44,6 +44,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/compression.h"
+#include "kernel-shared/file-item.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/open-utils.h"
diff --git a/convert/main.c b/convert/main.c
index 16520914..941b5ce3 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -99,6 +99,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/file-item.h"
 #include "crypto/hash.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 02f1d68b..cfffc9e2 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -27,6 +27,7 @@
 #include <string.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/file-item.h"
 #include "common/extent-cache.h"
 #include "common/messages.h"
 #include "convert/common.h"
diff --git a/image/main.c b/image/main.c
index 9144cf50..a90e6ff0 100644
--- a/image/main.c
+++ b/image/main.c
@@ -39,6 +39,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/file-item.h"
 #include "crypto/crc32c.h"
 #include "crypto/hash.h"
 #include "common/internal.h"
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7a17dbe0..6365a1f6 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -431,14 +431,6 @@ static inline u32 BTRFS_NODEPTRS_PER_EXTENT_BUFFER(const struct extent_buffer *e
 	return BTRFS_LEAF_DATA_SIZE(eb->fs_info) / sizeof(struct btrfs_key_ptr);
 }
 
-#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
-	(offsetof(struct btrfs_file_extent_item, disk_bytenr))
-static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_MAX_ITEM_SIZE(info) -
-		BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
 static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 {
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
@@ -719,19 +711,6 @@ static inline u8 *btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
        return (u8 *)((unsigned long)dev + ptr);
 }
 
-static inline unsigned long btrfs_file_extent_inline_start(struct
-						   btrfs_file_extent_item *e)
-{
-	unsigned long offset = (unsigned long)e;
-	offset += offsetof(struct btrfs_file_extent_item, disk_bytenr);
-	return offset;
-}
-
-static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
-{
-	return offsetof(struct btrfs_file_extent_item, disk_bytenr) + datasize;
-}
-
 static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
 					const struct btrfs_dev_stats_item *ptr,
 					int index)
@@ -745,17 +724,6 @@ static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
 	return val;
 }
 
-/*
- * this returns the number of bytes used by the item on disk, minus the
- * size of any extent headers.  If a file is compressed on disk, this is
- * the compressed size
- */
-static inline u32 btrfs_file_extent_inline_item_len(struct extent_buffer *eb,
-						    int nr)
-{
-	return btrfs_item_size(eb, nr) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
 /* struct btrfs_ioctl_search_header */
 static inline u64 btrfs_search_header_transid(struct btrfs_ioctl_search_header *sh)
 {
@@ -1091,19 +1059,6 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, const char *name, int name_len,
 			u64 ino, u64 parent_ino, u64 *index);
 
-/* file-item.c */
-int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len);
-int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     u64 objectid, u64 pos, u64 offset,
-			     u64 disk_num_bytes,
-			     u64 num_bytes);
-int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, u64 objectid,
-				u64 offset, const char *buffer, size_t size);
-int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 alloc_end,
-			  u64 bytenr, char *data, size_t len);
-
 /* uuid-tree.c, interface for mounted mounted filesystem */
 int btrfs_lookup_uuid_subvol_item(int fd, const u8 *uuid, u64 *subvol_id);
 int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index c134ce59..5613012c 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -33,6 +33,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/zoned.h"
 #include "common/utils.h"
+#include "file-item.h"
 
 #define PENDING_EXTENT_INSERT 0
 #define PENDING_EXTENT_DELETE 1
@@ -2115,7 +2116,11 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 
 		if (is_data) {
-			ret = btrfs_del_csums(trans, bytenr, num_bytes);
+			struct btrfs_root *csum_root;
+
+			csum_root = btrfs_csum_root(trans->fs_info, bytenr);
+			ret = btrfs_del_csums(trans, csum_root, bytenr,
+					      num_bytes);
 			BUG_ON(ret);
 		}
 
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 0a870495..9f8a3296 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -25,6 +25,7 @@
 #include "kernel-shared/print-tree.h"
 #include "crypto/crc32c.h"
 #include "common/internal.h"
+#include "file-item.h"
 
 #define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
 			       sizeof(struct btrfs_item) * 2) / \
@@ -400,7 +401,8 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
  * deletes the csum items from the csum tree for a given
  * range of bytes.
  */
-int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
+int btrfs_del_csums(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		    u64 bytenr, u64 len)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -410,7 +412,6 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 	int ret;
 	u16 csum_size = trans->fs_info->csum_size;
 	int blocksize = trans->fs_info->sectorsize;
-	struct btrfs_root *csum_root = btrfs_csum_root(trans->fs_info, bytenr);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -421,7 +422,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 		key.offset = end_byte - 1;
 		key.type = BTRFS_EXTENT_CSUM_KEY;
 
-		ret = btrfs_search_slot(trans, csum_root, &key, path, -1, 1);
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret > 0) {
 			if (path->slots[0] == 0)
 				goto out;
@@ -448,7 +449,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 
 		/* delete the entire item, it is inside our range */
 		if (key.offset >= bytenr && csum_end <= end_byte) {
-			ret = btrfs_del_item(trans, csum_root, path);
+			ret = btrfs_del_item(trans, root, path);
 			BUG_ON(ret);
 		} else if (key.offset < bytenr && csum_end > end_byte) {
 			unsigned long offset;
@@ -488,13 +489,13 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 			 * btrfs_split_item returns -EAGAIN when the
 			 * item changed size or key
 			 */
-			ret = btrfs_split_item(trans, csum_root, path, &key,
+			ret = btrfs_split_item(trans, root, path, &key,
 					       offset);
 			BUG_ON(ret && ret != -EAGAIN);
 
 			key.offset = end_byte - 1;
 		} else {
-			ret = truncate_one_csum(csum_root, path, &key, bytenr,
+			ret = truncate_one_csum(root, path, &key, bytenr,
 						len);
 			BUG_ON(ret);
 		}
diff --git a/kernel-shared/file-item.h b/kernel-shared/file-item.h
new file mode 100644
index 00000000..048e0be7
--- /dev/null
+++ b/kernel-shared/file-item.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FILE_ITEM_H
+#define BTRFS_FILE_ITEM_H
+
+#include "kerncompat.h"
+#include "accessors.h"
+
+struct bio;
+struct inode;
+struct btrfs_ordered_sum;
+struct btrfs_inode;
+struct extent_map;
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
+int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start, u64 len);
+void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size);
+u64 btrfs_file_extent_end(const struct btrfs_path *path);
+
+/*
+ * MODIFIED:
+ *  - This function doesn't exist in the kernel.
+ */
+int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root,
+			     u64 objectid, u64 pos, u64 offset,
+			     u64 disk_num_bytes, u64 num_bytes);
+int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
+			  u64 alloc_end, u64 bytenr, char *data, size_t len);
+int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root, u64 objectid,
+			       u64 offset, const char *buffer, size_t size);
+
+#endif
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index 1e5a9e98..100ea31c 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -22,6 +22,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/compression.h"
+#include "kernel-shared/file-item.h"
 #include "common/utils.h"
 
 /*
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index b5343462..d536b2ff 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/compression.h"
 #include "common/utils.h"
 #include "accessors.h"
+#include "file-item.h"
 
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 1ddc1138..aa2577ad 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -35,6 +35,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/file-item.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/path-utils.h"
-- 
2.40.0

