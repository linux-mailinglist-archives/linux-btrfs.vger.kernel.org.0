Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77584785AA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjHWOdf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjHWOdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:33 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042DE67
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:31 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d743a5fe05aso5049606276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801210; x=1693406010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofgEyvBe3ui82lRdlcvI6rHrBc3Ju6bigS+xexWEBGk=;
        b=BzXzsHM0l1Mf01mtOeJk4Vgdl4N/oWI0lYcfO0n0VB363NtduL64w2wqf27nmY2QST
         PX6KLFQwqVATneU5tWZ07ASqUNjAm43kaOsNLymp1FbnpIDzK5iDgYtC6qYNjIhfk/Y9
         2axzDzRn03vZ3FYFl8l9B/PyfgRU6g5H5Cmr/DJxdHTtCSOeF4L0o1D/OePgEJED+rEW
         8qaIb/ze/Cr4siaRn8bVshInpYcisBOISsWusq7d6Uz3xG3VMSyhoqxsua8MCh6v3j5I
         +k7V3x+iPcJtsNwyFTHVr28aAe/irdi21yTPHBODZA+xsTQ14zQkqRwPWnmuJ9N5eYK6
         yPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801210; x=1693406010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofgEyvBe3ui82lRdlcvI6rHrBc3Ju6bigS+xexWEBGk=;
        b=A+LnVSJBOftrl6VwVtWtNB5mBB9X0V5/m9aNr4N0j90nQjWsJPmcczaGnjJLzizGrh
         lCnV10SFwrPnFcC2MCAh79OPDUpVXhwDT7AlADn6jSemZDgRJ/cQI/JNn7z8CkqTRkSM
         l0m5wPnH2oN9BB4SvjPtx+O1gz/FxQxl+HLw+pRlDi/Mx91Mj3iz7QFUnBWH8AwiQfzm
         x97r/LwxQS66xg9rBj5ApaEFxewDbJmtRS5QjBK/e0z8MipgtOqQqKCMKE4F2WYeIDRA
         eCc7Ai8XLEQKmiWMZm8UPAODe8lGfFF/B/K6X8e9b2nUnsLapl0BwN+dfkdBSkLc25Lf
         hcKQ==
X-Gm-Message-State: AOJu0YzNvorND7tAXDxnCNERXehFJil5ff0+U5Yui3Wq/o+vRFkq/BWg
        pzV7WrbSYjINBkZvnMtqubYpHCECVve3XnDo9M0=
X-Google-Smtp-Source: AGHT+IFn7RqHWk4fR2enYicb3DeaBAZb5j8Nac8s4m9ycwlRdvworOLUt6JfOptkz+H8U+p57uzdIA==
X-Received: by 2002:a25:ac19:0:b0:d6b:7df8:a9ec with SMTP id w25-20020a25ac19000000b00d6b7df8a9ecmr11479608ybi.50.1692801210241;
        Wed, 23 Aug 2023 07:33:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m6-20020a056902004600b00c62e0df7ca8sm2734899ybh.24.2023.08.23.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/38] btrfs-progs: remove btrfs_create_root
Date:   Wed, 23 Aug 2023 10:32:44 -0400
Message-ID: <4dfa8b042cca9eb749050df7638e20891c2afe36.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
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

We have btrfs_create_root and btrfs_create_tree that do essentially the
same thing.  However btrfs_create_root isn't in the kernel, and
btrfs_create_tree is.  Update all of the callers of btrfs_create_root to
use btrfs_create_tree instead and then remove btrfs_create_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 117 ------------------------------------------
 kernel-shared/ctree.h |   2 -
 mkfs/main.c           |  14 +++--
 tune/convert-bgt.c    |  13 +++--
 4 files changed, 20 insertions(+), 126 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index eae233b9..1e45f756 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -341,123 +341,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
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
-	write_extent_buffer_fsid(node, fs_info->fs_devices->metadata_uuid);
-	write_extent_buffer_chunk_tree_uuid(node, fs_info->chunk_tree_uuid);
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
index c7d5167d..26cdae92 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -959,8 +959,6 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_create_root(struct btrfs_trans_handle *trans,
-		      struct btrfs_fs_info *fs_info, u64 objectid);
 void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
diff --git a/mkfs/main.c b/mkfs/main.c
index 4de57c8a..5d98ab69 100644
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
diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
index a2915376..15ec1042 100644
--- a/tune/convert-bgt.c
+++ b/tune/convert-bgt.c
@@ -31,7 +31,12 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
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
 
@@ -51,12 +56,14 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
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
2.41.0

