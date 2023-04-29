Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD76F2656
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjD2UUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjD2UU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F9198A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9daef8681fso380613276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799623; x=1685391623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFiLDffUY2P8Hj97VdNTG5/ErorwuoC6NIuWFWZyjMM=;
        b=xYXIFk2Vk953fRzzb5ae5VFb8se1dGYkS6f01MWUCo4vCXI+YVpWBDHs0U6YYJ4qFm
         Df3FG4XekP+2nXMwZjP6jP/j+1o8KrYyZYAEpWdjUiwJV+AAa6lCMfU4apD2wYuPZrY5
         EcOmOvuHuxhOVnp9mPO0PlO8xfwI44Cg6X2WsbkkgszO6JWS5UFoXCTyhJBxMAzPRgg5
         y35XScoP+4kmS4/e/DItJL9w/CbLJsWmjT8om270U++Xg6UZ44+7ebPN6dudjYuNq66/
         B8xb6Gc899AJenpx3Sqb8inG+2B6W52G3A5V4GwniugU96zAw7EAus5orb0+uEtRTorh
         5acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799623; x=1685391623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFiLDffUY2P8Hj97VdNTG5/ErorwuoC6NIuWFWZyjMM=;
        b=K/oMtcGNZqSQaJ916S540K8ZWdOnTEi/QDLMARFLiH1s1kJ45O9imREwkHH7D+JMhI
         elqZOGh0cCV3ujpOY8KTuQ6eSt/PIuPryqkHM/jOXMPISA7rtV1pnVYE6uQH6Z0UC3Pu
         JITq4jfs2t5DU2dDxBPcXYkeRT/ZNEVkH8e4sPlVg3k1rg1Q6+LRXURwVXSAPsTN0O13
         VGMAKZpR37Z5dQ5qk7eOhPThL10H4YzE0fsfRPBcZHtM3c83B3y60q9bKXWUY9hmYPl4
         NCh1RjGx5E7I8Ft6PW/UACdABKr/Spam6RPeWF2b4Sh6gxsXojCW8R+NuzWuraPxWmzI
         T41g==
X-Gm-Message-State: AC+VfDxyIA3t2/fWz3xvT1g91XFMYHwsrIVqgyCJmdzA8QdXFOpCgZ+G
        byg6o0yPjPhhU+M7b3F8DbAhlDUY/FH3MEvpHoQ5UA==
X-Google-Smtp-Source: ACHHUZ4xjk21j7B+DC5SVpfXf3GmdmdFNtDcZCaHRdEa6AG2ed++xVeLnWd6mWne7Er65sgdQKnmpg==
X-Received: by 2002:a81:7345:0:b0:545:637c:3ed7 with SMTP id o66-20020a817345000000b00545637c3ed7mr6427606ywc.1.1682799622898;
        Sat, 29 Apr 2023 13:20:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m11-20020a81710b000000b00555e1886350sm6281002ywc.78.2023.04.29.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/26] btrfs-progs: move btrfs_record_file_extent and code into a new file
Date:   Sat, 29 Apr 2023 16:19:47 -0400
Message-Id: <51bd817f87867d61a5b209ea6a8634e04cf1d20d.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

This function and it's related functions only exist for the utilities
that populate existing file systems, and do not exist in the upstream
kernel.  Move this function and the related function into it's own
common source file and out of the kernel-shared sources, and then update
all of the users to include the new location of this code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                    |   1 +
 btrfs-map-logical.c         |   1 +
 common/extent-tree-utils.c  | 282 ++++++++++++++++++++++++++++++++++++
 common/extent-tree-utils.h  |  28 ++++
 convert/main.c              |   1 +
 convert/source-fs.c         |   1 +
 kernel-shared/ctree.c       |  24 ---
 kernel-shared/ctree.h       |   7 -
 kernel-shared/extent-tree.c | 234 ------------------------------
 mkfs/rootdir.c              |   1 +
 10 files changed, 315 insertions(+), 265 deletions(-)
 create mode 100644 common/extent-tree-utils.c
 create mode 100644 common/extent-tree-utils.h

diff --git a/Makefile b/Makefile
index 6806d347..09e12d06 100644
--- a/Makefile
+++ b/Makefile
@@ -196,6 +196,7 @@ objects = \
 	common/device-scan.o	\
 	common/device-utils.o	\
 	common/extent-cache.o	\
+	common/extent-tree-utils.o	\
 	common/filesystem-utils.o	\
 	common/format-output.o	\
 	common/fsfeatures.o	\
diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 19514e40..8631774c 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -33,6 +33,7 @@
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/extent-cache.h"
+#include "common/extent-tree-utils.h"
 #include "common/string-utils.h"
 #include "cmds/commands.h"
 
diff --git a/common/extent-tree-utils.c b/common/extent-tree-utils.c
new file mode 100644
index 00000000..06d5436f
--- /dev/null
+++ b/common/extent-tree-utils.c
@@ -0,0 +1,282 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include "kerncompat.h"
+#include "kernel-shared/ctree.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/file-item.h"
+#include "kernel-shared/transaction.h"
+#include "kernel-shared/free-space-tree.h"
+#include "common/internal.h"
+#include "common/extent-tree-utils.h"
+#include "common/messages.h"
+
+/*
+ * Search in extent tree to found next meta/data extent
+ * Caller needs to check for no-hole or skinny metadata features.
+ */
+int btrfs_next_extent_item(struct btrfs_root *root, struct btrfs_path *path,
+			   u64 max_objectid)
+{
+	struct btrfs_key found_key;
+	int ret;
+
+	while (1) {
+		ret = btrfs_next_item(root, path);
+		if (ret)
+			return ret;
+		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
+				      path->slots[0]);
+		if (found_key.objectid > max_objectid)
+			return 1;
+		if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
+		    found_key.type == BTRFS_METADATA_ITEM_KEY)
+		return 0;
+	}
+}
+
+static void __get_extent_size(struct btrfs_root *root, struct btrfs_path *path,
+			      u64 *start, u64 *len)
+{
+	struct btrfs_key key;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	BUG_ON(!(key.type == BTRFS_EXTENT_ITEM_KEY ||
+		 key.type == BTRFS_METADATA_ITEM_KEY));
+	*start = key.objectid;
+	if (key.type == BTRFS_EXTENT_ITEM_KEY)
+		*len = key.offset;
+	else
+		*len = root->fs_info->nodesize;
+}
+
+/*
+ * Find first overlap extent for range [bytenr, bytenr + len)
+ * Return 0 for found and point path to it.
+ * Return >0 for not found.
+ * Return <0 for err
+ */
+static int btrfs_search_overlap_extent(struct btrfs_root *root,
+				struct btrfs_path *path, u64 bytenr, u64 len)
+{
+	struct btrfs_key key;
+	u64 cur_start;
+	u64 cur_len;
+	int ret;
+
+	key.objectid = bytenr;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	BUG_ON(ret == 0);
+
+	ret = btrfs_previous_extent_item(root, path, 0);
+	if (ret < 0)
+		return ret;
+	/* no previous, check next extent */
+	if (ret > 0)
+		goto next;
+	__get_extent_size(root, path, &cur_start, &cur_len);
+	/* Tail overlap */
+	if (cur_start + cur_len > bytenr)
+		return 1;
+
+next:
+	ret = btrfs_next_extent_item(root, path, bytenr + len);
+	if (ret < 0)
+		return ret;
+	/* No next, prev already checked, no overlap */
+	if (ret > 0)
+		return 0;
+	__get_extent_size(root, path, &cur_start, &cur_len);
+	/* head overlap*/
+	if (cur_start < bytenr + len)
+		return 1;
+	return 0;
+}
+
+static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
+				      struct btrfs_root *root, u64 objectid,
+				      struct btrfs_inode_item *inode,
+				      u64 file_pos, u64 disk_bytenr,
+				      u64 *ret_num_bytes)
+{
+	int ret;
+	struct btrfs_fs_info *info = root->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(info, disk_bytenr);
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_key ins_key;
+	struct btrfs_path *path;
+	struct btrfs_extent_item *ei;
+	u64 nbytes;
+	u64 extent_num_bytes;
+	u64 extent_bytenr;
+	u64 extent_offset;
+	u64 num_bytes = *ret_num_bytes;
+
+	/*
+	 * @objectid should be an inode number, thus it must not be smaller
+	 * than BTRFS_FIRST_FREE_OBJECTID.
+	 */
+	UASSERT(objectid >= BTRFS_FIRST_FREE_OBJECTID);
+
+	/*
+	 * All supported file system should not use its 0 extent.
+	 * As it's for hole
+	 *
+	 * And hole extent has no size limit, no need to loop.
+	 */
+	if (disk_bytenr == 0) {
+		ret = btrfs_insert_file_extent(trans, root, objectid,
+						file_pos, disk_bytenr,
+						num_bytes, num_bytes);
+		return ret;
+	}
+	num_bytes = min_t(u64, num_bytes, BTRFS_MAX_EXTENT_SIZE);
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	/* First to check extent overlap */
+	ret = btrfs_search_overlap_extent(extent_root, path, disk_bytenr,
+					  num_bytes);
+	if (ret < 0)
+		goto fail;
+	if (ret > 0) {
+		/* Found overlap */
+		u64 cur_start;
+		u64 cur_len;
+
+		__get_extent_size(extent_root, path, &cur_start, &cur_len);
+		/*
+		 * For convert case, this extent should be a subset of
+		 * existing one.
+		 */
+		BUG_ON(disk_bytenr < cur_start);
+
+		extent_bytenr = cur_start;
+		extent_num_bytes = cur_len;
+		extent_offset = disk_bytenr - extent_bytenr;
+	} else {
+		/* No overlap, create new extent */
+		btrfs_release_path(path);
+		ins_key.objectid = disk_bytenr;
+		ins_key.offset = num_bytes;
+		ins_key.type = BTRFS_EXTENT_ITEM_KEY;
+
+		ret = btrfs_insert_empty_item(trans, extent_root, path,
+					      &ins_key, sizeof(*ei));
+		if (ret == 0) {
+			leaf = path->nodes[0];
+			ei = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_extent_item);
+
+			btrfs_set_extent_refs(leaf, ei, 0);
+			btrfs_set_extent_generation(leaf, ei, trans->transid);
+			btrfs_set_extent_flags(leaf, ei,
+					       BTRFS_EXTENT_FLAG_DATA);
+			btrfs_mark_buffer_dirty(leaf);
+
+			ret = btrfs_update_block_group(trans, disk_bytenr,
+						       num_bytes, 1, 0);
+			if (ret)
+				goto fail;
+		} else if (ret != -EEXIST) {
+			goto fail;
+		}
+
+		ret = remove_from_free_space_tree(trans, disk_bytenr, num_bytes);
+		if (ret)
+			goto fail;
+
+		btrfs_run_delayed_refs(trans, -1);
+		extent_bytenr = disk_bytenr;
+		extent_num_bytes = num_bytes;
+		extent_offset = 0;
+	}
+	btrfs_release_path(path);
+	ins_key.objectid = objectid;
+	ins_key.offset = file_pos;
+	ins_key.type = BTRFS_EXTENT_DATA_KEY;
+	ret = btrfs_insert_empty_item(trans, root, path, &ins_key,
+				      sizeof(*fi));
+	if (ret)
+		goto fail;
+	leaf = path->nodes[0];
+	fi = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
+	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
+	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
+	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
+	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
+	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
+	btrfs_set_file_extent_ram_bytes(leaf, fi, extent_num_bytes);
+	btrfs_set_file_extent_compression(leaf, fi, 0);
+	btrfs_set_file_extent_encryption(leaf, fi, 0);
+	btrfs_set_file_extent_other_encoding(leaf, fi, 0);
+	btrfs_mark_buffer_dirty(leaf);
+
+	nbytes = btrfs_stack_inode_nbytes(inode) + num_bytes;
+	btrfs_set_stack_inode_nbytes(inode, nbytes);
+	btrfs_release_path(path);
+
+	ret = btrfs_inc_extent_ref(trans, extent_bytenr, extent_num_bytes,
+				   0, root->root_key.objectid, objectid,
+				   file_pos - extent_offset);
+	if (ret)
+		goto fail;
+	ret = 0;
+	*ret_num_bytes = min(extent_num_bytes - extent_offset, num_bytes);
+fail:
+	btrfs_free_path(path);
+	return ret;
+}
+
+/*
+ * Record a file extent. Do all the required works, such as inserting
+ * file extent item, inserting extent item and backref item into extent
+ * tree and updating block accounting.
+ */
+int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root, u64 objectid,
+			      struct btrfs_inode_item *inode,
+			      u64 file_pos, u64 disk_bytenr,
+			      u64 num_bytes)
+{
+	u64 cur_disk_bytenr = disk_bytenr;
+	u64 cur_file_pos = file_pos;
+	u64 cur_num_bytes = num_bytes;
+	int ret = 0;
+
+	while (num_bytes > 0) {
+		ret = __btrfs_record_file_extent(trans, root, objectid,
+						 inode, cur_file_pos,
+						 cur_disk_bytenr,
+						 &cur_num_bytes);
+		if (ret < 0)
+			break;
+		cur_disk_bytenr += cur_num_bytes;
+		cur_file_pos += cur_num_bytes;
+		num_bytes -= cur_num_bytes;
+	}
+	return ret;
+}
diff --git a/common/extent-tree-utils.h b/common/extent-tree-utils.h
new file mode 100644
index 00000000..4a774dc2
--- /dev/null
+++ b/common/extent-tree-utils.h
@@ -0,0 +1,28 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#ifndef _EXTENT_TREE_UTILS_H_
+#define _EXTENT_TREE_UTILS_H_
+
+int btrfs_next_extent_item(struct btrfs_root *root, struct btrfs_path *path,
+			   u64 max_objectid);
+int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root, u64 objectid,
+			      struct btrfs_inode_item *inode,
+			      u64 file_pos, u64 disk_bytenr,
+			      u64 num_bytes);
+
+#endif /* _EXTENT_TREE_UTILS_H_ */
diff --git a/convert/main.c b/convert/main.c
index 78c8d76e..a8b74dfa 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -114,6 +114,7 @@
 #include "common/device-scan.h"
 #include "common/box.h"
 #include "common/open-utils.h"
+#include "common/extent-tree-utils.h"
 #include "cmds/commands.h"
 #include "check/repair.h"
 #include "mkfs/common.h"
diff --git a/convert/source-fs.c b/convert/source-fs.c
index d206fab6..cc82fdb6 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -24,6 +24,7 @@
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/extent-cache.h"
+#include "common/extent-tree-utils.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
 
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 68c270ee..96d25953 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -3042,30 +3042,6 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 	return 1;
 }
 
-/*
- * Search in extent tree to found next meta/data extent
- * Caller needs to check for no-hole or skinny metadata features.
- */
-int btrfs_next_extent_item(struct btrfs_root *root,
-			struct btrfs_path *path, u64 max_objectid)
-{
-	struct btrfs_key found_key;
-	int ret;
-
-	while (1) {
-		ret = btrfs_next_item(root, path);
-		if (ret)
-			return ret;
-		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
-				      path->slots[0]);
-		if (found_key.objectid > max_objectid)
-			return 1;
-		if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
-		    found_key.type == BTRFS_METADATA_ITEM_KEY)
-		return 0;
-	}
-}
-
 /*
  * Search uuid tree - unmounted
  *
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d7b386db..cc71e2a5 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -928,11 +928,6 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 			    struct btrfs_fs_info *fs_info);
 int btrfs_update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 			     u64 num, int alloc, int mark_free);
-int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root, u64 objectid,
-			      struct btrfs_inode_item *inode,
-			      u64 file_pos, u64 disk_bytenr,
-			      u64 num_bytes);
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 len);
 void free_excluded_extents(struct btrfs_fs_info *fs_info,
@@ -955,8 +950,6 @@ int btrfs_previous_item(struct btrfs_root *root,
 			int type);
 int btrfs_previous_extent_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid);
-int btrfs_next_extent_item(struct btrfs_root *root,
-			struct btrfs_path *path, u64 max_objectid);
 int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index c2ff94f5..98c0b297 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3520,240 +3520,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static void __get_extent_size(struct btrfs_root *root, struct btrfs_path *path,
-			      u64 *start, u64 *len)
-{
-	struct btrfs_key key;
-
-	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	BUG_ON(!(key.type == BTRFS_EXTENT_ITEM_KEY ||
-		 key.type == BTRFS_METADATA_ITEM_KEY));
-	*start = key.objectid;
-	if (key.type == BTRFS_EXTENT_ITEM_KEY)
-		*len = key.offset;
-	else
-		*len = root->fs_info->nodesize;
-}
-
-/*
- * Find first overlap extent for range [bytenr, bytenr + len)
- * Return 0 for found and point path to it.
- * Return >0 for not found.
- * Return <0 for err
- */
-static int btrfs_search_overlap_extent(struct btrfs_root *root,
-				struct btrfs_path *path, u64 bytenr, u64 len)
-{
-	struct btrfs_key key;
-	u64 cur_start;
-	u64 cur_len;
-	int ret;
-
-	key.objectid = bytenr;
-	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = (u64)-1;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-	BUG_ON(ret == 0);
-
-	ret = btrfs_previous_extent_item(root, path, 0);
-	if (ret < 0)
-		return ret;
-	/* no previous, check next extent */
-	if (ret > 0)
-		goto next;
-	__get_extent_size(root, path, &cur_start, &cur_len);
-	/* Tail overlap */
-	if (cur_start + cur_len > bytenr)
-		return 1;
-
-next:
-	ret = btrfs_next_extent_item(root, path, bytenr + len);
-	if (ret < 0)
-		return ret;
-	/* No next, prev already checked, no overlap */
-	if (ret > 0)
-		return 0;
-	__get_extent_size(root, path, &cur_start, &cur_len);
-	/* head overlap*/
-	if (cur_start < bytenr + len)
-		return 1;
-	return 0;
-}
-
-static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root, u64 objectid,
-				      struct btrfs_inode_item *inode,
-				      u64 file_pos, u64 disk_bytenr,
-				      u64 *ret_num_bytes)
-{
-	int ret;
-	struct btrfs_fs_info *info = root->fs_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(info, disk_bytenr);
-	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
-	struct btrfs_key ins_key;
-	struct btrfs_path *path;
-	struct btrfs_extent_item *ei;
-	u64 nbytes;
-	u64 extent_num_bytes;
-	u64 extent_bytenr;
-	u64 extent_offset;
-	u64 num_bytes = *ret_num_bytes;
-
-	/*
-	 * @objectid should be an inode number, thus it must not be smaller
-	 * than BTRFS_FIRST_FREE_OBJECTID.
-	 */
-	ASSERT(objectid >= BTRFS_FIRST_FREE_OBJECTID);
-
-	/*
-	 * All supported file system should not use its 0 extent.
-	 * As it's for hole
-	 *
-	 * And hole extent has no size limit, no need to loop.
-	 */
-	if (disk_bytenr == 0) {
-		ret = btrfs_insert_file_extent(trans, root, objectid,
-						file_pos, disk_bytenr,
-						num_bytes, num_bytes);
-		return ret;
-	}
-	num_bytes = min_t(u64, num_bytes, BTRFS_MAX_EXTENT_SIZE);
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	/* First to check extent overlap */
-	ret = btrfs_search_overlap_extent(extent_root, path, disk_bytenr,
-					  num_bytes);
-	if (ret < 0)
-		goto fail;
-	if (ret > 0) {
-		/* Found overlap */
-		u64 cur_start;
-		u64 cur_len;
-
-		__get_extent_size(extent_root, path, &cur_start, &cur_len);
-		/*
-		 * For convert case, this extent should be a subset of
-		 * existing one.
-		 */
-		BUG_ON(disk_bytenr < cur_start);
-
-		extent_bytenr = cur_start;
-		extent_num_bytes = cur_len;
-		extent_offset = disk_bytenr - extent_bytenr;
-	} else {
-		/* No overlap, create new extent */
-		btrfs_release_path(path);
-		ins_key.objectid = disk_bytenr;
-		ins_key.offset = num_bytes;
-		ins_key.type = BTRFS_EXTENT_ITEM_KEY;
-
-		ret = btrfs_insert_empty_item(trans, extent_root, path,
-					      &ins_key, sizeof(*ei));
-		if (ret == 0) {
-			leaf = path->nodes[0];
-			ei = btrfs_item_ptr(leaf, path->slots[0],
-					    struct btrfs_extent_item);
-
-			btrfs_set_extent_refs(leaf, ei, 0);
-			btrfs_set_extent_generation(leaf, ei, trans->transid);
-			btrfs_set_extent_flags(leaf, ei,
-					       BTRFS_EXTENT_FLAG_DATA);
-			btrfs_mark_buffer_dirty(leaf);
-
-			ret = btrfs_update_block_group(trans, disk_bytenr,
-						       num_bytes, 1, 0);
-			if (ret)
-				goto fail;
-		} else if (ret != -EEXIST) {
-			goto fail;
-		}
-
-		ret = remove_from_free_space_tree(trans, disk_bytenr, num_bytes);
-		if (ret)
-			goto fail;
-
-		btrfs_run_delayed_refs(trans, -1);
-		extent_bytenr = disk_bytenr;
-		extent_num_bytes = num_bytes;
-		extent_offset = 0;
-	}
-	btrfs_release_path(path);
-	ins_key.objectid = objectid;
-	ins_key.offset = file_pos;
-	ins_key.type = BTRFS_EXTENT_DATA_KEY;
-	ret = btrfs_insert_empty_item(trans, root, path, &ins_key,
-				      sizeof(*fi));
-	if (ret)
-		goto fail;
-	leaf = path->nodes[0];
-	fi = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
-	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
-	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
-	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
-	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
-	btrfs_set_file_extent_ram_bytes(leaf, fi, extent_num_bytes);
-	btrfs_set_file_extent_compression(leaf, fi, 0);
-	btrfs_set_file_extent_encryption(leaf, fi, 0);
-	btrfs_set_file_extent_other_encoding(leaf, fi, 0);
-	btrfs_mark_buffer_dirty(leaf);
-
-	nbytes = btrfs_stack_inode_nbytes(inode) + num_bytes;
-	btrfs_set_stack_inode_nbytes(inode, nbytes);
-	btrfs_release_path(path);
-
-	ret = btrfs_inc_extent_ref(trans, extent_bytenr, extent_num_bytes,
-				   0, root->root_key.objectid, objectid,
-				   file_pos - extent_offset);
-	if (ret)
-		goto fail;
-	ret = 0;
-	*ret_num_bytes = min(extent_num_bytes - extent_offset, num_bytes);
-fail:
-	btrfs_free_path(path);
-	return ret;
-}
-
-/*
- * Record a file extent. Do all the required works, such as inserting
- * file extent item, inserting extent item and backref item into extent
- * tree and updating block accounting.
- */
-int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root, u64 objectid,
-			      struct btrfs_inode_item *inode,
-			      u64 file_pos, u64 disk_bytenr,
-			      u64 num_bytes)
-{
-	u64 cur_disk_bytenr = disk_bytenr;
-	u64 cur_file_pos = file_pos;
-	u64 cur_num_bytes = num_bytes;
-	int ret = 0;
-
-	while (num_bytes > 0) {
-		ret = __btrfs_record_file_extent(trans, root, objectid,
-						 inode, cur_file_pos,
-						 cur_disk_bytenr,
-						 &cur_num_bytes);
-		if (ret < 0)
-			break;
-		cur_disk_bytenr += cur_num_bytes;
-		cur_file_pos += cur_num_bytes;
-		num_bytes -= cur_num_bytes;
-	}
-	return ret;
-}
-
-
 static int add_excluded_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 num_bytes)
 {
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index d6de3eba..91f97ed6 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -39,6 +39,7 @@
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/path-utils.h"
+#include "common/extent-tree-utils.h"
 #include "mkfs/rootdir.h"
 
 static u32 fs_block_size;
-- 
2.40.0

