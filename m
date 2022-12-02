Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F34640A9E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiLBQZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiLBQZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 11:25:21 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AFF92FC5
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 08:23:45 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c15so5815561qtw.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFCICbLGVbaWLKBgzyZgulg9J/hKL0YErDkzf2UT238=;
        b=HHoO7w+S+WcKEeuRxasEXjGONR5DN6fp77Txq+Pf0lGMZtUbgt4u/xCEfLgJFFjIzA
         niAjmQs5xxRHnkmCCkauw0xCtUNsd4TPHmYRXjrq4OkieKe4XQ6icQP06ULZaH2MgHr7
         c7yaUNqZDaY8dV//vnCdtaHeymJerExETX6IBGShw8lVz+hdkHWRl5YR0xQSByM2J/8G
         IwzZyEPAATBIBpAMKrGWnO+H8xBACGzkDtxW387tba6tqks6AcvmgXS/JbJgyv8zNr3d
         AYZSUw5LoL5bEvLjqXtlwtka3JCchdvjsNgRN5tYiYIc5wU/wJww1Y90QolDm2kkvRSK
         DhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFCICbLGVbaWLKBgzyZgulg9J/hKL0YErDkzf2UT238=;
        b=G8AeYYMOeFvqYHenWNCCzr1vJz+o6v/lLcPC8eC0fheBHSjHdVPUn7yVgsXgGrdD3Q
         Q1y4TTd4cd43tXKzuWENAKaDSa2RcgcxjbUtIdCqtlKW9Myco7huk70C/j8Ce/gpVyIm
         aJO0ddtAfOdssPUwWZplYD3AKmPf5T375NRYzHGo4bErg81zxZoZFPMMRY49+2u9INsR
         UXAQlNLH39Iyv+0Kfl1L8826Dsg5Fq8pFKVHzX1JRFENe5dQsxMIahSUqIixHIVEv52V
         zTiJcRj6zO0ZjPsGnk8cVKePhvbrpLvsdBKNYmQDkiLEVVjU1kvaQom7I6gxZoapvxde
         48XQ==
X-Gm-Message-State: ANoB5pnD2hhv8hZ3psHtlQIp5N6SI/FABzy6v/EFxdXtYslZe0s8jEo3
        0XgqzmyRb2Aa8gdWTCLk8zgzdCWtY5+avHjx
X-Google-Smtp-Source: AA0mqf7viUqOyFQaLShIvmkyjCHNMt54g9nznMV7KJPu2J3AymO4Apdhuhpl2l6AUCVAWezYtjswLg==
X-Received: by 2002:a05:622a:6113:b0:3a6:6eb7:3348 with SMTP id hg19-20020a05622a611300b003a66eb73348mr30032437qtb.640.1669998224300;
        Fri, 02 Dec 2022 08:23:44 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s3-20020ac85283000000b003a4cda52c95sm4355732qtn.63.2022.12.02.08.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:23:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 08/10] btrfs-progs: sync file-item.h into progs
Date:   Fri,  2 Dec 2022 11:23:30 -0500
Message-Id: <a0a63b406c2e023c33f0f287d3cd57f2bbe71490.1669998153.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669998153.git.josef@toxicpanda.com>
References: <cover.1669998153.git.josef@toxicpanda.com>
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
 btrfstune.c                 |  1 +
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
 18 files changed, 125 insertions(+), 56 deletions(-)
 create mode 100644 kernel-shared/file-item.h

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 493cfc69..56603bc8 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/extent-cache.h"
@@ -1109,7 +1110,7 @@ static int delete_csum(struct btrfs_root *root, u64 bytenr, u64 bytes)
 		return ret;
 	}
 
-	ret = btrfs_del_csums(trans, bytenr, bytes);
+	ret = btrfs_del_csums(trans, root, bytenr, bytes);
 	if (ret)
 		error("error deleting csums %d", ret);
 	btrfs_commit_transaction(trans, root);
diff --git a/btrfstune.c b/btrfstune.c
index 0ad7275c..c41d3838 100644
--- a/btrfstune.c
+++ b/btrfstune.c
@@ -32,6 +32,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/defs.h"
 #include "common/utils.h"
 #include "common/extent-cache.h"
diff --git a/check/clear-cache.c b/check/clear-cache.c
index c4ee6b33..1ea937dc 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -22,6 +22,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "check/common.h"
@@ -463,6 +464,7 @@ int truncate_free_ino_items(struct btrfs_root *root)
 	while (1) {
 		struct extent_buffer *leaf;
 		struct btrfs_file_extent_item *fi;
+		struct btrfs_root *csum_root;
 		struct btrfs_key found_key;
 		u8 found_type;
 
@@ -521,7 +523,10 @@ int truncate_free_ino_items(struct btrfs_root *root)
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
index 5d83de64..96317c9c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -42,6 +42,7 @@
 #include "kernel-shared/backref.h"
 #include "kernel-shared/ulist.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
 #include "common/internal.h"
diff --git a/check/mode-common.c b/check/mode-common.c
index a1d095f9..96ee311a 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/backref.h"
 #include "kernel-shared/compression.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
@@ -1312,7 +1313,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 		if (type == BTRFS_FILE_EXTENT_PREALLOC) {
 			start += btrfs_file_extent_offset(node, fi);
 			len = btrfs_file_extent_num_bytes(node, fi);
-			ret = btrfs_del_csums(trans, start, len);
+			ret = btrfs_del_csums(trans, csum_root, start, len);
 			if (ret < 0)
 				goto out;
 		}
@@ -1474,7 +1475,8 @@ static int remove_csum_for_file_extent(u64 ino, u64 offset, u64 rootid, void *ct
 	btrfs_release_path(&path);
 
 	/* Now delete the csum for the preallocated or nodatasum range */
-	ret = btrfs_del_csums(trans, disk_bytenr, disk_len);
+	root = btrfs_csum_root(fs_info, disk_bytenr);
+	ret = btrfs_del_csums(trans, root, disk_bytenr, disk_len);
 out:
 	btrfs_release_path(&path);
 	return ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 4b0c8b27..78ef0385 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -31,6 +31,7 @@
 #include "kernel-shared/compression.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/messages.h"
 #include "common/internal.h"
 #include "common/utils.h"
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index 9ed3dabd..a6c0efbc 100644
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
index c328b075..8af26776 100644
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
index 80b36697..1beb0b8e 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -100,6 +100,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "crypto/crc32c.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index a8b33317..05805495 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -28,6 +28,7 @@
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "common/extent-cache.h"
 #include "common/messages.h"
 #include "convert/common.h"
diff --git a/image/main.c b/image/main.c
index 5afc4b7c..a329a087 100644
--- a/image/main.c
+++ b/image/main.c
@@ -40,6 +40,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/file-item.h"
 #include "crypto/crc32c.h"
 #include "common/internal.h"
 #include "common/messages.h"
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3d1b2ff4..d30597d2 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -426,14 +426,6 @@ static inline u32 BTRFS_NODEPTRS_PER_EXTENT_BUFFER(const struct extent_buffer *e
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
@@ -705,19 +697,6 @@ static inline u8 *btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
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
@@ -731,17 +710,6 @@ static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
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
@@ -1081,19 +1049,6 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
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
index 0b0c40af..fda87ee1 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -33,6 +33,7 @@
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/zoned.h"
 #include "common/utils.h"
+#include "file-item.h"
 
 #define PENDING_EXTENT_INSERT 0
 #define PENDING_EXTENT_DELETE 1
@@ -2109,7 +2110,11 @@ static int __free_extent(struct btrfs_trans_handle *trans,
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
index 807ba477..6324f555 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -23,6 +23,7 @@
 #include "kernel-shared/transaction.h"
 #include "compression.h"
 #include "kerncompat.h"
+#include "file-item.h"
 
 /*
  * Get the first file extent that covers (part of) the given range
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index e7767010..517c34ca 100644
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
index 2cf6eef9..7e5d41a5 100644
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
2.26.3

