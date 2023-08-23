Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F784785ABB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbjHWOd4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjHWOdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:55 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FEE54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:51 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5922b96c5fcso30193987b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801230; x=1693406030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biDBJWvlDH7z5+kIEbB0Hyvz0Y8yo6n5Hv8DM+HIiHw=;
        b=RN6FNNjE3bdyE5J0DRPmSuBumI8tdxJmE1qJeGZLzTGa71AWLf84KV2IlZJO+mbB0A
         Rvhiu8Cc/dsYxoDfrte7l+radzoJurVJ9Fiko4FYdwlNzTWxDap3EmZYcz7DgaIHx1Lg
         wxOaY0MC9zrDkg1shTWO6hNiZyXnLGQLiUiOlCIEGfDLrUxhl1vNkF10WPabsku2h3t1
         4e5P/OiRHCzIkvhxgbmKy5Fjq1qPhtYMf4Zq2dk7x5dFXgDHst638y2rb8wugKV6ag5T
         q53BRn6lbCsqPUptOtd3mdjymYRAGHIjx7DsejC7O51DlVCiu/eSGLqwxibAksWceNX4
         4MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801230; x=1693406030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biDBJWvlDH7z5+kIEbB0Hyvz0Y8yo6n5Hv8DM+HIiHw=;
        b=P8GmPh3T2JX+vlGNtlvh1bEektGqsK1oHAHETa3q5lGYwK2WqfI3JtB7z11p8e5EAW
         VwoKviGw25UcV7zgT/pX/9s4ZdZWhI4GJRabVNfnw4WpyufNJZmcvhrByThE/EAOvftx
         Y6tjTSPIyqkT2VPB8RAMdlXlViwAUErXHdXOQCr5uRPpD8IFVv+NvcCSDvYK/0HgHBtw
         v9GIvkkMukhrYV8TloJXSnqwsIaqhEjSlVPtl1Mwqi4Al+pL3/7mFVjOQCZRMzUDYKAT
         B/mneMcAgBVKuOyRI0jlvLlQHEt51vViOLGC+5uzFD2bNFnGbxBfHSHQNWK3lfB1Lcxt
         CJUA==
X-Gm-Message-State: AOJu0Yy962hmNwro+2iN+hmBWCQaaVNZ1oOQbyBV3dQTXe5y2od5ASPv
        1ZTlhhGARVNw5+BHVorZrf246lSFlXhgAlAQzs0=
X-Google-Smtp-Source: AGHT+IEURou8Lhvkjq+NoLRNbcpStG7eRcP878Xa+rOb+2HWUFrzSr05UvfLoEQC+L/WFcfhZp0Hdg==
X-Received: by 2002:a0d:d585:0:b0:577:1be8:c1ae with SMTP id x127-20020a0dd585000000b005771be8c1aemr14646686ywd.24.1692801230190;
        Wed, 23 Aug 2023 07:33:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a4-20020a0dd804000000b005832fe29034sm3341717ywe.89.2023.08.23.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 35/38] btrfs-progs: update read_tree_block to take a btrfs_parent_tree_check
Date:   Wed, 23 Aug 2023 10:33:01 -0400
Message-ID: <7dd4ba1382211701b1b3658b414cce3693103453.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel we've added a control struct to handle the different
checks we want to do on extent buffers when we read them.  Update our
copy of read_tree_block to take this as an argument, then update all of
the callers to use the new structure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-corrupt-block.c      | 16 +++++++++++-----
 btrfs-find-root.c          |  5 ++++-
 check/main.c               | 21 +++++++++++++++------
 check/mode-common.c        |  7 +++++--
 check/mode-lowmem.c        | 25 ++++++++++++++++++-------
 check/qgroup-verify.c      |  7 +++++--
 check/repair.c             | 16 ++++++++++------
 cmds/inspect-dump-tree.c   | 20 ++++++++++++++------
 cmds/inspect-tree-stats.c  | 11 +++++++----
 cmds/restore.c             | 13 ++++++++-----
 image/image-create.c       | 10 ++++++----
 image/image-restore.c      |  6 ++++--
 image/main.c               |  1 +
 kernel-shared/backref.c    | 17 +++++++++++++----
 kernel-shared/ctree.c      |  9 ++++++---
 kernel-shared/disk-io.c    | 26 ++++++++++----------------
 kernel-shared/disk-io.h    |  3 +--
 kernel-shared/print-tree.c | 10 +++++++---
 tune/change-uuid.c         |  4 +++-
 19 files changed, 148 insertions(+), 79 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 3e741c08..432dc859 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/extent-cache.h"
@@ -172,8 +173,9 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
 static int corrupt_keys_in_block(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = { 0 };
 
-	eb = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+	eb = read_tree_block(fs_info, bytenr, &check);
 	if (!extent_buffer_uptodate(eb))
 		return -EIO;;
 
@@ -301,11 +303,14 @@ static void btrfs_corrupt_extent_tree(struct btrfs_trans_handle *trans,
 
 	for (i = 0; i < btrfs_header_nritems(eb); i++) {
 		struct extent_buffer *next;
+		struct btrfs_tree_parent_check check = {
+			.owner_root = btrfs_header_owner(eb),
+			.transid = btrfs_node_ptr_generation(eb, i),
+			.level = btrfs_header_level(eb) - 1,
+		};
 
 		next = read_tree_block(fs_info, btrfs_node_blockptr(eb, i),
-				       btrfs_header_owner(eb),
-				       btrfs_node_ptr_generation(eb, i),
-				       btrfs_header_level(eb) - 1, NULL);
+				       &check);
 		if (!extent_buffer_uptodate(next))
 			continue;
 		btrfs_corrupt_extent_tree(trans, root, next);
@@ -860,6 +865,7 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 				  char *field)
 {
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = { 0 };
 	enum btrfs_metadata_block_field corrupt_field;
 	int ret;
 
@@ -869,7 +875,7 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 		return -EINVAL;
 	}
 
-	eb = read_tree_block(fs_info, block, 0, 0, 0, NULL);
+	eb = read_tree_block(fs_info, block, &check);
 	if (!extent_buffer_uptodate(eb)) {
 		error("couldn't read in tree block %s", field);
 		return -EINVAL;
diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index 6e32859f..32d32429 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -25,6 +25,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/box.h"
 #include "common/utils.h"
 #include "common/extent-cache.h"
@@ -200,7 +201,9 @@ int btrfs_find_root_search(struct btrfs_fs_info *fs_info,
 		for (offset = chunk_offset;
 		     offset < chunk_offset + chunk_size;
 		     offset += nodesize) {
-			eb = read_tree_block(fs_info, offset, 0, 0, 0, NULL);
+			struct btrfs_tree_parent_check check = { 0 };
+
+			eb = read_tree_block(fs_info, offset, &check);
 			if (!eb || IS_ERR(eb))
 				continue;
 			ret = add_eb_to_result(eb, result, nodesize, filter,
diff --git a/check/main.c b/check/main.c
index 04c965ab..08e6a94b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1894,11 +1894,15 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 
 		next = btrfs_find_tree_block(gfs_info, bytenr, gfs_info->nodesize);
 		if (!next || !btrfs_buffer_uptodate(next, ptr_gen, 0)) {
+			struct btrfs_tree_parent_check check = {
+				.owner_root = btrfs_header_owner(cur),
+				.transid = ptr_gen,
+				.level = *level - 1,
+			};
+
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
-			next = read_tree_block(gfs_info, bytenr,
-					       btrfs_header_owner(cur), ptr_gen,
-					       *level - 1, NULL);
+			next = read_tree_block(gfs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(next)) {
 				struct btrfs_key node_key;
 
@@ -6196,6 +6200,7 @@ static int run_next_block(struct btrfs_root *root,
 {
 	struct extent_buffer *buf;
 	struct extent_record *rec = NULL;
+	struct btrfs_tree_parent_check check = { 0 };
 	u64 bytenr;
 	u32 size;
 	u64 parent;
@@ -6252,7 +6257,8 @@ static int run_next_block(struct btrfs_root *root,
 	}
 
 	/* fixme, get the real parent transid */
-	buf = read_tree_block(gfs_info, bytenr, 0, gen, 0, NULL);
+	check.transid = gen;
+	buf = read_tree_block(gfs_info, bytenr, &check);
 	if (!extent_buffer_uptodate(buf)) {
 		record_bad_block_io(extent_cache, bytenr, size);
 		goto out;
@@ -8586,12 +8592,15 @@ static int deal_root_from_list(struct list_head *list,
 	while (!list_empty(list)) {
 		struct root_item_record *rec;
 		struct extent_buffer *buf;
+		struct btrfs_tree_parent_check check = { 0 };
 
 		rec = list_entry(list->next,
 				 struct root_item_record, list);
 		last = 0;
-		buf = read_tree_block(gfs_info, rec->bytenr, rec->objectid, 0,
-				      rec->level, NULL);
+
+		check.owner_root = rec->objectid;
+		check.level = rec->level;
+		buf = read_tree_block(gfs_info, rec->bytenr, &check);
 		if (!extent_buffer_uptodate(buf)) {
 			free_extent_buffer(buf);
 			ret = -EIO;
diff --git a/check/mode-common.c b/check/mode-common.c
index 71e735c4..f6cdcee3 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/backref.h"
 #include "kernel-shared/compression.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
@@ -127,11 +128,12 @@ next:
 static int check_prealloc_shared_data_ref(u64 parent, u64 disk_bytenr)
 {
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = { 0 };
 	u32 nr;
 	int i;
 	int ret = 0;
 
-	eb = read_tree_block(gfs_info, parent, 0, 0, 0, NULL);
+	eb = read_tree_block(gfs_info, parent, &check);
 	if (!extent_buffer_uptodate(eb)) {
 		ret = -EIO;
 		goto out;
@@ -1116,8 +1118,9 @@ int get_extent_item_generation(u64 bytenr, u64 *gen_ret)
 	if (btrfs_extent_flags(path.nodes[0], ei) &
 	    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 		struct extent_buffer *eb;
+		struct btrfs_tree_parent_check check = { 0 };
 
-		eb = read_tree_block(gfs_info, bytenr, 0, 0, 0, NULL);
+		eb = read_tree_block(gfs_info, bytenr, &check);
 		if (extent_buffer_uptodate(eb)) {
 			*gen_ret = btrfs_header_generation(eb);
 			ret = 0;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 35bca857..0189a656 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -3684,6 +3684,7 @@ static int query_tree_block_level(u64 bytenr)
 	struct btrfs_path path = {};
 	struct btrfs_key key;
 	struct btrfs_extent_item *ei;
+	struct btrfs_tree_parent_check check = { 0 };
 	u64 flags;
 	u64 transid;
 	u8 backref_level;
@@ -3731,7 +3732,8 @@ static int query_tree_block_level(u64 bytenr)
 	btrfs_release_path(&path);
 
 	/* Get level from tree block as an alternative source */
-	eb = read_tree_block(gfs_info, bytenr, 0, transid, 0, NULL);
+	check.transid = transid;
+	eb = read_tree_block(gfs_info, bytenr, &check);
 	if (!extent_buffer_uptodate(eb)) {
 		free_extent_buffer(eb);
 		return -EIO;
@@ -3760,6 +3762,9 @@ static int check_tree_block_backref(u64 root_id, u64 bytenr, int level)
 	struct btrfs_path path = {};
 	struct extent_buffer *eb;
 	struct extent_buffer *node;
+	struct btrfs_tree_parent_check check = {
+		.owner_root = root_id,
+	};
 	u32 nodesize = btrfs_super_nodesize(gfs_info->super_copy);
 	int err = 0;
 	int ret;
@@ -3783,7 +3788,7 @@ static int check_tree_block_backref(u64 root_id, u64 bytenr, int level)
 	}
 
 	/* Read out the tree block to get item/node key */
-	eb = read_tree_block(gfs_info, bytenr, root_id, 0, 0, NULL);
+	eb = read_tree_block(gfs_info, bytenr, &check);
 	if (!extent_buffer_uptodate(eb)) {
 		err |= REFERENCER_MISSING;
 		free_extent_buffer(eb);
@@ -3877,11 +3882,12 @@ static int is_tree_reloc_root(struct extent_buffer *eb)
 static int check_shared_block_backref(u64 parent, u64 bytenr, int level)
 {
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = { 0 };
 	u32 nr;
 	int found_parent = 0;
 	int i;
 
-	eb = read_tree_block(gfs_info, parent, 0, 0, 0, NULL);
+	eb = read_tree_block(gfs_info, parent, &check);
 	if (!extent_buffer_uptodate(eb))
 		goto out;
 
@@ -4048,11 +4054,12 @@ static int check_shared_data_backref(u64 parent, u64 bytenr)
 	struct extent_buffer *eb;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *fi;
+	struct btrfs_tree_parent_check check = { 0 };
 	u32 nr;
 	int found_parent = 0;
 	int i;
 
-	eb = read_tree_block(gfs_info, parent, 0, 0, 0, NULL);
+	eb = read_tree_block(gfs_info, parent, &check);
 	if (!extent_buffer_uptodate(eb))
 		goto out;
 
@@ -5018,11 +5025,15 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 
 		next = btrfs_find_tree_block(gfs_info, bytenr, gfs_info->nodesize);
 		if (!next || !btrfs_buffer_uptodate(next, ptr_gen, 0)) {
+			struct btrfs_tree_parent_check check = {
+				.owner_root = btrfs_header_owner(cur),
+				.transid = ptr_gen,
+				.level = *level - 1,
+			};
+
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
-			next = read_tree_block(gfs_info, bytenr,
-					       btrfs_header_owner(cur),
-					       ptr_gen, *level - 1, NULL);
+			next = read_tree_block(gfs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(next)) {
 				struct btrfs_key node_key;
 
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0c08eae8..0491d6a3 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -30,6 +30,7 @@
 #include "kernel-shared/ulist.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/messages.h"
 #include "common/rbtree-utils.h"
 #include "check/repair.h"
@@ -714,14 +715,16 @@ static int travel_tree(struct btrfs_fs_info *info, struct btrfs_root *root,
 {
 	int ret, nr, i;
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = {
+		.owner_root = btrfs_root_id(root),
+	};
 	u64 new_bytenr;
 	u64 new_num_bytes;
 
 //	printf("travel_tree: bytenr: %llu\tnum_bytes: %llu\tref_parent: %llu\n",
 //	       bytenr, num_bytes, ref_parent);
 
-	eb = read_tree_block(info, bytenr, btrfs_root_id(root), 0,
-			     0, NULL);
+	eb = read_tree_block(info, bytenr, &check);
 	if (!extent_buffer_uptodate(eb))
 		return -EIO;
 
diff --git a/check/repair.c b/check/repair.c
index d8900c41..240ac7fb 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -137,6 +137,8 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
+		struct btrfs_tree_parent_check check = { 0 };
+
 		if (level == 0) {
 			bool is_extent_root;
 			btrfs_item_key_to_cpu(eb, &key, i);
@@ -150,15 +152,16 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
 			bytenr = btrfs_disk_root_bytenr(eb, ri);
 
+			check.owner_root = key.objectid;
+			check.level = btrfs_disk_root_level(eb, ri);
+
 			/*
 			 * If at any point we start needing the real root we
 			 * will have to build a stump root for the root we are
 			 * in, but for now this doesn't actually use the root so
 			 * just pass in extent_root.
 			 */
-			tmp = read_tree_block(fs_info, bytenr, key.objectid, 0,
-					      btrfs_disk_root_level(eb, ri),
-					      NULL);
+			tmp = read_tree_block(fs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				fprintf(stderr, "Error reading root block\n");
 				return -EIO;
@@ -183,9 +186,10 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 				continue;
 			}
 
-			tmp = read_tree_block(fs_info, bytenr,
-					      btrfs_header_owner(eb), 0,
-					      level - 1, NULL);
+			check.owner_root = btrfs_header_owner(eb);
+			check.level = level - 1;
+
+			tmp = read_tree_block(fs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				fprintf(stderr, "Error reading tree block\n");
 				return -EIO;
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 9c3de7aa..c16d3aa2 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -32,6 +32,7 @@
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
 #include "common/messages.h"
@@ -58,10 +59,14 @@ static void print_extents(struct extent_buffer *eb)
 
 	nr = btrfs_header_nritems(eb);
 	for (i = 0; i < nr; i++) {
+		struct btrfs_tree_parent_check check = {
+			.owner_root = btrfs_header_owner(eb),
+			.transid = btrfs_node_ptr_generation(eb, i),
+			.level = btrfs_header_level(eb) - 1,
+		};
+
 		next = read_tree_block(fs_info, btrfs_node_blockptr(eb, i),
-				       btrfs_header_owner(eb),
-				       btrfs_node_ptr_generation(eb, i),
-				       btrfs_header_level(eb) - 1, NULL);
+				       &check);
 		if (!extent_buffer_uptodate(next))
 			continue;
 		if (btrfs_is_leaf(next) && btrfs_header_level(eb) != 1) {
@@ -269,6 +274,7 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
 {
 	struct cache_extent *ce;
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = { 0 };
 	u64 bytenr;
 	int ret = 0;
 
@@ -289,7 +295,7 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
 			goto next;
 		}
 
-		eb = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+		eb = read_tree_block(fs_info, bytenr, &check);
 		if (!extent_buffer_uptodate(eb)) {
 			error("failed to read tree block %llu", bytenr);
 			ret = -EIO;
@@ -592,12 +598,14 @@ again:
 		if (found_key.type == BTRFS_ROOT_ITEM_KEY) {
 			unsigned long offset;
 			struct extent_buffer *buf;
+			struct btrfs_tree_parent_check check = {
+				.owner_root = key.objectid,
+			};
 			bool skip = (extent_only || device_only || uuid_tree_only);
 
 			offset = btrfs_item_ptr_offset(leaf, slot);
 			read_extent_buffer(leaf, &ri, offset, sizeof(ri));
-			buf = read_tree_block(info, btrfs_root_bytenr(&ri),
-					      key.objectid, 0, 0, NULL);
+			buf = read_tree_block(info, btrfs_root_bytenr(&ri), &check);
 			if (!extent_buffer_uptodate(buf))
 				goto next;
 			if (tree_id && found_key.objectid != tree_id) {
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index e1808ec5..0d6db150 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/messages.h"
@@ -152,10 +153,12 @@ static int walk_nodes(struct btrfs_root *root, struct btrfs_path *path,
 
 		path->slots[level] = i;
 		if ((level - 1) > 0 || find_inline) {
-			tmp = read_tree_block(root->fs_info, cur_blocknr,
-					      btrfs_header_owner(b),
-					      btrfs_node_ptr_generation(b, i),
-					      level - 1, NULL);
+			struct btrfs_tree_parent_check check = {
+				.owner_root = btrfs_header_owner(b),
+				.transid = btrfs_node_ptr_generation(b, i),
+				.level = level - 1,
+			};
+			tmp = read_tree_block(root->fs_info, cur_blocknr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("failed to read blocknr %llu",
 					btrfs_node_blockptr(b, i));
diff --git a/cmds/restore.c b/cmds/restore.c
index b0e04a7e..74462bca 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -45,6 +45,7 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/compression.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/open-utils.h"
@@ -1241,15 +1242,17 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 	 * the fs_root.
 	 */
 	if (!extent_buffer_uptodate(fs_info->tree_root->node)) {
+		struct btrfs_tree_parent_check check = { 0 };
 		u64 generation;
 
 		root = fs_info->tree_root;
 		if (!root_location)
 			root_location = btrfs_super_root(fs_info->super_copy);
 		generation = btrfs_super_generation(fs_info->super_copy);
-		root->node = read_tree_block(fs_info, root_location,
-					     btrfs_root_id(root), generation,
-					     0, NULL);
+
+		check.owner_root = btrfs_root_id(root);
+		check.transid = generation;
+		root->node = read_tree_block(fs_info, root_location, &check);
 		if (!extent_buffer_uptodate(root->node)) {
 			error("opening tree root failed");
 			close_ctree(root);
@@ -1514,9 +1517,9 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 		goto out;
 
 	if (fs_location != 0) {
+		struct btrfs_tree_parent_check check = { 0 };
 		free_extent_buffer(root->node);
-		root->node = read_tree_block(root->fs_info, fs_location, 0, 0,
-					     0, NULL);
+		root->node = read_tree_block(root->fs_info, fs_location, &check);
 		if (!extent_buffer_uptodate(root->node)) {
 			error("failed to read fs location");
 			ret = 1;
diff --git a/image/image-create.c b/image/image-create.c
index 894969ed..c802ba14 100644
--- a/image/image-create.c
+++ b/image/image-create.c
@@ -21,6 +21,7 @@
 #include "kernel-shared/file-item.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/tree-checker.h"
 #include "crypto/crc32c.h"
 #include "common/internal.h"
 #include "common/messages.h"
@@ -437,11 +438,11 @@ static int flush_pending(struct metadump_struct *md, int done)
 		}
 
 		while (!md->data && size > 0) {
+			struct btrfs_tree_parent_check check = { 0 };
 			u64 this_read = min((u64)md->root->fs_info->nodesize,
 					size);
 
-			eb = read_tree_block(md->root->fs_info, start, 0, 0, 0,
-					     NULL);
+			eb = read_tree_block(md->root->fs_info, start, &check);
 			if (!extent_buffer_uptodate(eb)) {
 				free(async->buffer);
 				free(async);
@@ -510,6 +511,7 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 	struct btrfs_root_item *ri;
 	struct btrfs_key key;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_tree_parent_check check = { 0 };
 	u64 bytenr;
 	int level;
 	int nritems = 0;
@@ -545,7 +547,7 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 				continue;
 			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
 			bytenr = btrfs_disk_root_bytenr(eb, ri);
-			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+			tmp = read_tree_block(fs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
@@ -556,7 +558,7 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 				return ret;
 		} else {
 			bytenr = btrfs_node_blockptr(eb, i);
-			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+			tmp = read_tree_block(fs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
diff --git a/image/image-restore.c b/image/image-restore.c
index 36cdc554..5ac254cf 100644
--- a/image/image-restore.c
+++ b/image/image-restore.c
@@ -20,6 +20,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/open-utils.h"
@@ -1366,6 +1367,7 @@ static int iter_tree_blocks(struct btrfs_fs_info *fs_info,
 			    struct extent_buffer *eb, bool pin)
 {
 	void (*func)(struct btrfs_fs_info *fs_info, u64 bytenr, u64 num_bytes);
+	struct btrfs_tree_parent_check check = { 0 };
 	int nritems;
 	int level;
 	int i;
@@ -1396,7 +1398,7 @@ static int iter_tree_blocks(struct btrfs_fs_info *fs_info,
 				continue;
 			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
 			bytenr = btrfs_disk_root_bytenr(eb, ri);
-			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+			tmp = read_tree_block(fs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
@@ -1407,7 +1409,7 @@ static int iter_tree_blocks(struct btrfs_fs_info *fs_info,
 				return ret;
 		} else {
 			bytenr = btrfs_node_blockptr(eb, i);
-			tmp = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+			tmp = read_tree_block(fs_info, bytenr, &check);
 			if (!extent_buffer_uptodate(tmp)) {
 				error("unable to read log root block");
 				return -EIO;
diff --git a/image/main.c b/image/main.c
index fcec725d..52b46588 100644
--- a/image/main.c
+++ b/image/main.c
@@ -41,6 +41,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/tree-checker.h"
 #include "crypto/crc32c.h"
 #include "crypto/hash.h"
 #include "common/internal.h"
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index c4e76823..14f045d7 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -23,6 +23,7 @@
 #include "kernel-shared/ulist.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/messages.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/internal.h"
 
 #define pr_debug(...) do { } while (0)
@@ -454,6 +455,7 @@ static int __add_missing_keys(struct btrfs_fs_info *fs_info,
 
 	while (!list_empty(&prefstate->pending_missing_keys)) {
 		struct __prelim_ref *ref;
+		struct btrfs_tree_parent_check check;
 
 		ref = list_first_pref(&prefstate->pending_missing_keys);
 
@@ -461,8 +463,13 @@ static int __add_missing_keys(struct btrfs_fs_info *fs_info,
 		ASSERT(!ref->parent);
 		ASSERT(!ref->key_for_search.type);
 		BUG_ON(!ref->wanted_disk_byte);
-		eb = read_tree_block(fs_info, ref->wanted_disk_byte,
-				     ref->root_id, 0, ref->level - 1, NULL);
+
+		check.owner_root = ref->root_id;
+		check.transid = 0;
+		check.has_first_key = false;
+		check.level = ref->level - 1;
+
+		eb = read_tree_block(fs_info, ref->wanted_disk_byte, &check);
 		if (!extent_buffer_uptodate(eb)) {
 			free_extent_buffer(eb);
 			return -EIO;
@@ -823,9 +830,11 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 			if (extent_item_pos && !ref->inode_list &&
 			    ref->level == 0) {
 				struct extent_buffer *eb;
+				struct btrfs_tree_parent_check check = {
+					.level = ref->level,
+				};
 
-				eb = read_tree_block(fs_info, ref->parent, 0,
-						     0, ref->level, NULL);
+				eb = read_tree_block(fs_info, ref->parent, &check);
 				if (!extent_buffer_uptodate(eb)) {
 					free_extent_buffer(eb);
 					ret = -EIO;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index e95839bd..fb3b9899 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -715,6 +715,7 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 {
 	struct btrfs_fs_info *fs_info = parent->fs_info;
 	struct extent_buffer *ret;
+	struct btrfs_tree_parent_check check = { 0 };
 	int level = btrfs_header_level(parent);
 
 	if (slot < 0)
@@ -725,10 +726,12 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 	if (level == 0)
 		return NULL;
 
+	check.owner_root = btrfs_header_owner(parent);
+	check.transid = btrfs_node_ptr_generation(parent, slot);
+	check.level = level - 1;
+
 	ret = read_tree_block(fs_info, btrfs_node_blockptr(parent, slot),
-			      btrfs_header_owner(parent),
-			      btrfs_node_ptr_generation(parent, slot),
-			      level - 1, NULL);
+			      &check);
 	if (!extent_buffer_uptodate(ret))
 		return ERR_PTR(-EIO);
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index ef5ea391..b2fdc48d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -417,23 +417,12 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 }
 
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 owner_root, u64 parent_transid,
-				      int level, struct btrfs_key *first_key)
+				      struct btrfs_tree_parent_check *check)
 {
-	struct btrfs_tree_parent_check check = {
-		.owner_root = owner_root,
-		.transid = parent_transid,
-		.level = level,
-	};
 	int ret;
 	struct extent_buffer *eb;
 	u32 sectorsize = fs_info->sectorsize;
 
-	if (first_key) {
-		check.has_first_key = true;
-		memcpy(&check.first_key, first_key, sizeof(*first_key));
-	}
-
 	/*
 	 * Don't even try to create tree block for unaligned tree block
 	 * bytenr.
@@ -450,10 +439,10 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
 
-	if (btrfs_buffer_uptodate(eb, parent_transid, 0))
+	if (btrfs_buffer_uptodate(eb, check->transid, 0))
 		return eb;
 
-	ret = btrfs_read_extent_buffer(eb, &check);
+	ret = btrfs_read_extent_buffer(eb, check);
 	if (ret) {
 		/*
 		 * We failed to read this tree block, it be should deleted right
@@ -508,8 +497,13 @@ static int read_root_node(struct btrfs_fs_info *fs_info,
 			  struct btrfs_root *root, u64 bytenr, u64 gen,
 			  int level)
 {
-	root->node = read_tree_block(fs_info, bytenr, btrfs_root_id(root),
-				     gen, level, NULL);
+	struct btrfs_tree_parent_check check = {
+		.owner_root = btrfs_root_id(root),
+		.transid = gen,
+		.level = level,
+	};
+
+	root->node = read_tree_block(fs_info, bytenr, &check);
 	if (!extent_buffer_uptodate(root->node))
 		goto err;
 	if (btrfs_header_level(root->node) != level) {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 78c6e8c7..20dfb01c 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -147,8 +147,7 @@ struct btrfs_device;
 
 int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
-				      u64 owner_root, u64 parent_transid,
-				      int level, struct btrfs_key *first_key);
+				      struct btrfs_tree_parent_check *check);
 
 void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 			  u64 parent_transid);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9796085d..a5ca51e3 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -28,6 +28,7 @@
 #include "kernel-shared/compression.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/utils.h"
 
 static void print_dir_item_type(struct extent_buffer *eb,
@@ -1613,10 +1614,13 @@ static void dfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 	mode &= ~(BTRFS_PRINT_TREE_BFS);
 
 	for (i = 0; i < nr; i++) {
+		struct btrfs_tree_parent_check check = {
+			.owner_root = btrfs_header_owner(root_eb),
+			.transid = btrfs_node_ptr_generation(root_eb, i),
+			.level = root_eb_level,
+		};
 		next = read_tree_block(fs_info, btrfs_node_blockptr(root_eb, i),
-				       btrfs_header_owner(root_eb),
-				       btrfs_node_ptr_generation(root_eb, i),
-				       root_eb_level, NULL);
+				       &check);
 		if (!extent_buffer_uptodate(next)) {
 			fprintf(stderr, "failed to read %llu in tree %llu\n",
 				btrfs_node_blockptr(root_eb, i),
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index 54184811..a9e5385e 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -24,6 +24,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/defs.h"
 #include "common/messages.h"
 #include "tune/tune.h"
@@ -97,6 +98,7 @@ static int change_extent_tree_uuid(struct btrfs_fs_info *fs_info, uuid_t new_fsi
 	while (1) {
 		struct btrfs_extent_item *ei;
 		struct extent_buffer *eb;
+		struct btrfs_tree_parent_check check = { 0 };
 		u64 flags;
 		u64 bytenr;
 
@@ -111,7 +113,7 @@ static int change_extent_tree_uuid(struct btrfs_fs_info *fs_info, uuid_t new_fsi
 			goto next;
 
 		bytenr = key.objectid;
-		eb = read_tree_block(fs_info, bytenr, 0, 0, 0, NULL);
+		eb = read_tree_block(fs_info, bytenr, &check);
 		if (IS_ERR(eb)) {
 			error("failed to read tree block: %llu", bytenr);
 			ret = PTR_ERR(eb);
-- 
2.41.0

