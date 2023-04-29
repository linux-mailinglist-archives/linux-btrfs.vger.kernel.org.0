Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7E6F2664
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjD2UUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjD2UU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:28 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D342710
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so14247644276.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799626; x=1685391626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEoZc+nEXW3E34N4qvHm3Kt4zypq/oZE+Vhd2LMh5uY=;
        b=gsYURdd7Yq/1tcJjX8XiYv2qeEwCFSJ6gmaNXZYDF47bZu9aJLvv3rzV4YbF+dste9
         jogr35WGjn3OMZU6Pt0IueVJj40Zz1VfVxajSB4dDTrvOeNPCh53u/sKKcUMzrGvK3J8
         OPRByELxVES5pQjJhymjhHnlIDuCfsgChq9aqPCqKtc3IxKX3IkS2aRuDqP2KcDQnzaN
         3OTWGHEy8fbKOCf1nT1QwzlI9cjnWotLbFzoC6TvPx2Vw/qSOirwdMQoeJbPJb7wE7mW
         4DdMG3N7Ds12TunaGNhFLh00ESHJ9dmY0Whh9MqkFgu/7kK3cPKLPYz7uOCETwVFUczh
         /YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799626; x=1685391626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEoZc+nEXW3E34N4qvHm3Kt4zypq/oZE+Vhd2LMh5uY=;
        b=F8VcsmLZKADgdR4K/RJenPNrPXYC3TCvHl90S4yvUwISOEHkw6zQXfYPz0DHt35ZCG
         SXERxYgCWWYj7efJnovPsPbJVKl65T9zRQn/aEdzH75K4ImpjnTAJUCfapPklJZNvkiv
         thEvnHmnDG5f9fX05bV7nDNfnGks0Pozvf2udiai4DeXf1/DLYF2hUkGPyetaLhqs3PP
         cE06zTPSHwcrxVooYX4sRqA8/0cBB9QrnFHOsrgeDN4dzqAapTe0ua8er54yZrgNbTPO
         qpZzXykbkwLimEKfd6gz60dBWVzxG2ytRUWMvzJj0xCps/yIey7xWwRgqX3DSs108A1v
         xBtg==
X-Gm-Message-State: AC+VfDwqvtRhUeOaSJtTeu4MUW1gCWoPZh7aDMoHjxYV5wYQ5rZ6cevX
        n8FuRUixYfP9EXHZLVLCRQkYIXtHpvJHfQZ5Le8OiQ==
X-Google-Smtp-Source: ACHHUZ6H4+ogIkWkVCmDcle9bECW/VSE9a6rdOp+Yd79T2x5H0TuqkrxxDUDXHPedHDuKdcT+PYshQ==
X-Received: by 2002:a81:6d14:0:b0:54f:a8cf:6b48 with SMTP id i20-20020a816d14000000b0054fa8cf6b48mr8538385ywc.10.1682799626244;
        Sat, 29 Apr 2023 13:20:26 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i198-20020a816dcf000000b005463239c01esm6361622ywc.51.2023.04.29.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/26] btrfs-progs: remove btrfs_create_root
Date:   Sat, 29 Apr 2023 16:19:50 -0400
Message-Id: <69cbc6a5d3d222301046cbf91cf27ed26c61aef3.1682799405.git.josef@toxicpanda.com>
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

We have btrfs_create_root and btrfs_create_tree that do essentially the
same thing.  However btrfs_create_root isn't in the kernel, and
btrfs_create_tree is.  Update all of the callers of btrfs_create_root to
use btrfs_create_tree instead and then remove btrfs_create_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 123 ------------------------------------------
 kernel-shared/ctree.h |   2 -
 mkfs/main.c           |  14 +++--
 tune/change-csum.c    |  11 +++-
 tune/convert-bgt.c    |  13 +++--
 5 files changed, 29 insertions(+), 134 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 96d25953..327ff40c 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -193,129 +193,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * Create a new tree root, with root objectid set to @objectid.
- *
- * NOTE: Doesn't support tree with non-zero offset, like data reloc tree.
- */
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid)
-{
-	struct extent_buffer *node;
-	struct btrfs_root *new_root;
-	struct btrfs_disk_key disk_key;
-	struct btrfs_key location;
-	struct btrfs_root_item root_item = { 0 };
-	int ret;
-
-	new_root = malloc(sizeof(*new_root));
-	if (!new_root)
-		return -ENOMEM;
-
-	btrfs_setup_root(new_root, fs_info, objectid);
-	if (!is_fstree(objectid))
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &new_root->state);
-	add_root_to_dirty_list(new_root);
-
-	new_root->objectid = objectid;
-	new_root->root_key.objectid = objectid;
-	new_root->root_key.type = BTRFS_ROOT_ITEM_KEY;
-	new_root->root_key.offset = 0;
-
-	node = btrfs_alloc_tree_block(trans, new_root, fs_info->nodesize,
-				      objectid, &disk_key, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
-	if (IS_ERR(node)) {
-		ret = PTR_ERR(node);
-		error("failed to create root node for tree %llu: %d (%m)",
-		      objectid, ret);
-		return ret;
-	}
-	new_root->node = node;
-
-	memset_extent_buffer(node, 0, 0, sizeof(struct btrfs_header));
-	btrfs_set_header_bytenr(node, node->start);
-	btrfs_set_header_generation(node, trans->transid);
-	btrfs_set_header_backref_rev(node, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(node, objectid);
-	write_extent_buffer(node, fs_info->fs_devices->metadata_uuid,
-			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
-	write_extent_buffer(node, fs_info->chunk_tree_uuid,
-			    btrfs_header_chunk_tree_uuid(node),
-			    BTRFS_UUID_SIZE);
-	btrfs_set_header_nritems(node, 0);
-	btrfs_set_header_level(node, 0);
-	ret = btrfs_inc_ref(trans, new_root, node, 0);
-	if (ret < 0)
-		goto free;
-
-	/*
-	 * Special tree roots may need to modify pointers in @fs_info
-	 * Only quota is supported yet.
-	 */
-	switch (objectid) {
-	case BTRFS_QUOTA_TREE_OBJECTID:
-		if (fs_info->quota_root) {
-			error("quota root already exists");
-			ret = -EEXIST;
-			goto free;
-		}
-		fs_info->quota_root = new_root;
-		fs_info->quota_enabled = 1;
-		break;
-	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
-		if (fs_info->block_group_root) {
-			error("bg root already exists");
-			ret = -EEXIST;
-			goto free;
-		}
-		fs_info->block_group_root = new_root;
-		break;
-
-	case BTRFS_CSUM_TREE_TMP_OBJECTID:
-		fs_info->csum_tree_tmp = new_root;
-		break;
-	/*
-	 * Essential trees can't be created by this function, yet.
-	 * As we expect such skeleton exists, or a lot of functions like
-	 * btrfs_alloc_tree_block() doesn't work at all
-	 */
-	case BTRFS_ROOT_TREE_OBJECTID:
-	case BTRFS_EXTENT_TREE_OBJECTID:
-	case BTRFS_CHUNK_TREE_OBJECTID:
-	case BTRFS_FS_TREE_OBJECTID:
-		ret = -EEXIST;
-		goto free;
-	default:
-		/* Subvolume trees don't need special handling */
-		if (is_fstree(objectid))
-			break;
-		/* Other special trees are not supported yet */
-		ret = -ENOTTY;
-		goto free;
-	}
-	btrfs_mark_buffer_dirty(node);
-	btrfs_set_root_bytenr(&root_item, btrfs_header_bytenr(node));
-	btrfs_set_root_level(&root_item, 0);
-	btrfs_set_root_generation(&root_item, trans->transid);
-	btrfs_set_root_dirid(&root_item, 0);
-	btrfs_set_root_refs(&root_item, 1);
-	btrfs_set_root_used(&root_item, fs_info->nodesize);
-	location.objectid = objectid;
-	location.type = BTRFS_ROOT_ITEM_KEY;
-	location.offset = 0;
-
-	ret = btrfs_insert_root(trans, fs_info->tree_root, &location, &root_item);
-	if (ret < 0)
-		goto free;
-	return ret;
-
-free:
-	free_extent_buffer(node);
-	free(new_root);
-	return ret;
-}
-
 /*
  * check if the tree block can be shared by multiple trees
  */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index cc71e2a5..ce1c3d25 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -958,8 +958,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid);
 void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
diff --git a/mkfs/main.c b/mkfs/main.c
index e0b589cd..88fea33b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -883,7 +883,10 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 	struct btrfs_qgroup_status_item *qsi;
 	struct btrfs_root *quota_root;
 	struct btrfs_path path = {};
-	struct btrfs_key key;
+	struct btrfs_key key = {
+		.objectid = BTRFS_QUOTA_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
 	int qgroup_repaired = 0;
 	int ret;
 
@@ -895,12 +898,15 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 		error_msg(ERROR_MSG_START_TRANS, "%m");
 		return ret;
 	}
-	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
-	if (ret < 0) {
+
+	quota_root = btrfs_create_tree(trans, fs_info, &key);
+	if (IS_ERR(quota_root)) {
+		ret = PTR_ERR(quota_root);
 		error("failed to create quota root: %d (%m)", ret);
 		goto fail;
 	}
-	quota_root = fs_info->quota_root;
+	fs_info->quota_root = quota_root;
+	fs_info->quota_enabled = 1;
 
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_STATUS_KEY;
diff --git a/tune/change-csum.c b/tune/change-csum.c
index f7917f0b..e75d0d9f 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -410,6 +410,11 @@ int rewrite_checksums(struct btrfs_fs_info *fs_info, int csum_type)
 		return ret;
 
 	if (ret == 1) {
+		struct btrfs_root *tmp;
+		struct btrfs_key key = {
+			.objectid = BTRFS_CSUM_TREE_TMP_OBJECTID,
+			.type = BTRFS_ROOT_ITEM_KEY,
+		};
 		struct item {
 			u64 offset;
 			u64 generation;
@@ -421,10 +426,12 @@ int rewrite_checksums(struct btrfs_fs_info *fs_info, int csum_type)
 			 */
 		} item[1];
 
-		ret = btrfs_create_root(trans, fs_info, BTRFS_CSUM_TREE_TMP_OBJECTID);
-		if (ret < 0) {
+		tmp = btrfs_create_tree(trans, fs_info, &key);
+		if (IS_ERR(tmp)) {
+			ret = PTR_ERR(tmp);
 			return ret;
 		} else {
+			fs_info->csum_tree_tmp = tmp;
 			item->offset = btrfs_header_bytenr(fs_info->csum_tree_tmp->node);
 			item->generation = btrfs_super_generation(fs_info->super_copy);
 			item->csum_type = csum_type;
diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
index 79d9169e..cdd0a007 100644
--- a/tune/convert-bgt.c
+++ b/tune/convert-bgt.c
@@ -30,7 +30,12 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_super_block *sb = fs_info->super_copy;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_root *root;
 	struct cache_extent *ce;
+	struct btrfs_key key = {
+		.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
 	int converted_bgs = 0;
 	int ret;
 
@@ -50,12 +55,14 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
 	if (btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_CHANGING_BG_TREE)
 		goto iterate_bgs;
 
-	ret = btrfs_create_root(trans, fs_info,
-				BTRFS_BLOCK_GROUP_TREE_OBJECTID);
-	if (ret < 0) {
+	root = btrfs_create_tree(trans, fs_info, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
 		error("failed to create block group root: %d", ret);
 		goto error;
 	}
+	fs_info->block_group_root = root;
+
 	btrfs_set_super_flags(sb,
 			btrfs_super_flags(sb) |
 			BTRFS_SUPER_FLAG_CHANGING_BG_TREE);
-- 
2.40.0

