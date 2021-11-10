Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C8344CA50
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhKJURi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhKJURi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC4C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:50 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m17so2627825qvx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8Log85UcwvuZtzc96yzzk5mucDO778TsPIHh/KLvfeM=;
        b=fDmjJ5vrQmnEPwanYMr+xvfRnbCAbvADXzWZ8/h8oC28buQA4v1KHjcvNzvQsQL29R
         xcnWRQIgVbh2dxNvSeVio4V1hmFn0kOHLe45Z2Bs95/zu7+pzOVW8GcAB2o/MVJTtkFh
         JP0iBvMWqyZF+FJbOaYH/TZrA2iCaHWZqYxPUfgfO5hq8TLCiMbIjbUquAViucYB87b7
         FE4Eg8IP0XC3TowuzdVjwEe8sPOL/p6/gSD9Xc+znPq03APoCNIhJh2SHSS+hHco1F7c
         r+ehFSDhtBWLvvMxV6VQHan19nOUKONUAfy5Ehj+7aR+8+1BRqJ+5C5GJF2CHOmmz2hp
         O8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Log85UcwvuZtzc96yzzk5mucDO778TsPIHh/KLvfeM=;
        b=f7mkUwfz6wPOeRuUVlXcGHSRaGzBPgqMk9GOhSPXOfCbmN8GcBE+6RBkVf8eegQJTy
         8uT7zEFSYNGr1ONBF+E93qBFHYfRDTHuHCLIqhnwJWP1WKIRtmsnBo9YcRG3wOd/3CMq
         slyd5dlz4vWZxVgZajxPX28RMp3N3YFSzI8zOHcMDJDzB02DGsVI+EnzUep5NrOc7OxZ
         nMBQ4f+hM1IvUOk4dRmuGz73qYPVCHNQSKQg7wI8+QhZ0IL1oZmFY7yavxToaA+vqLMo
         PJeCmrOIcQDJhRV4avb1p7i3WMoC8hVP+9ouAqb1NRe+c7x8B/0fehkrMDALz2jvbtcT
         Vong==
X-Gm-Message-State: AOAM533FmacsCl1GN8hJAbK5gsLNo9AO6L6VrAyrVO5xrhvSP/TPxAkm
        YDoNELZg1VpMn2u5C55MKKC4KnRucUdsWQ==
X-Google-Smtp-Source: ABdhPJxZNMzSWO+qUvEc/EEvi/pvl6/iwjz4WRGrklLACWXNQQEdyM8XCn+XYNgD39jyD2d29DHleg==
X-Received: by 2002:a05:6214:c8a:: with SMTP id r10mr1577840qvr.38.1636575288911;
        Wed, 10 Nov 2021 12:14:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f1sm376542qkj.84.2021.11.10.12.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:14:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/30] btrfs-progs: stop accessing ->free_space_root directly
Date:   Wed, 10 Nov 2021 15:14:14 -0500
Message-Id: <c03b48d0184936184009c4f90f0816e5f0a35827.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to have multiple free space roots in the future, so access
it via a helper in most cases.  We will address the remaining direct
accesses in future patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h           |  2 +-
 kernel-shared/disk-io.c         | 24 ++++++++++-----------
 kernel-shared/free-space-tree.c | 37 +++++++++++++++++++++------------
 mkfs/main.c                     |  4 ++--
 4 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 23750156..c263a3bb 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1163,7 +1163,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *dev_root;
 	struct btrfs_root *_csum_root;
 	struct btrfs_root *quota_root;
-	struct btrfs_root *free_space_root;
+	struct btrfs_root *_free_space_root;
 	struct btrfs_root *uuid_root;
 
 	struct rb_root fs_root_tree;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 76cf7567..4a43e102 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -791,7 +791,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		return fs_info->quota_enabled ? fs_info->quota_root :
 				ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return fs_info->free_space_root ? fs_info->free_space_root :
+		return fs_info->_free_space_root ? fs_info->_free_space_root :
 						ERR_PTR(-ENOENT);
 
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
@@ -821,7 +821,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	free(fs_info->chunk_root);
 	free(fs_info->dev_root);
 	free(fs_info->_csum_root);
-	free(fs_info->free_space_root);
+	free(fs_info->_free_space_root);
 	free(fs_info->uuid_root);
 	free(fs_info->super_copy);
 	free(fs_info->log_root_tree);
@@ -842,14 +842,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->_csum_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
-	fs_info->free_space_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->_free_space_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->_extent_root ||
 	    !fs_info->chunk_root || !fs_info->dev_root ||
 	    !fs_info->_csum_root || !fs_info->quota_root ||
-	    !fs_info->free_space_root || !fs_info->uuid_root ||
+	    !fs_info->_free_space_root || !fs_info->uuid_root ||
 	    !fs_info->super_copy)
 		goto free_all;
 
@@ -1046,17 +1046,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
 		ret = find_and_setup_root(root, fs_info, BTRFS_FREE_SPACE_TREE_OBJECTID,
-					  fs_info->free_space_root);
+					  fs_info->_free_space_root);
 		if (ret) {
-			free(fs_info->free_space_root);
-			fs_info->free_space_root = NULL;
+			free(fs_info->_free_space_root);
+			fs_info->_free_space_root = NULL;
 			printk("Couldn't read free space tree\n");
 			return -EIO;
 		}
-		fs_info->free_space_root->track_dirty = 1;
+		fs_info->_free_space_root->track_dirty = 1;
 	} else {
-		free(fs_info->free_space_root);
-		fs_info->free_space_root = NULL;
+		free(fs_info->_free_space_root);
+		fs_info->_free_space_root = NULL;
 	}
 
 	ret = find_and_setup_log_root(root, fs_info, sb);
@@ -1095,8 +1095,8 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 
 void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->free_space_root)
-		free_extent_buffer(fs_info->free_space_root->node);
+	if (fs_info->_free_space_root)
+		free_extent_buffer(fs_info->_free_space_root->node);
 	if (fs_info->quota_root)
 		free_extent_buffer(fs_info->quota_root->node);
 	if (fs_info->_csum_root)
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 0434733d..70b3d62a 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -25,13 +25,19 @@
 #include "kernel-lib/bitops.h"
 #include "common/internal.h"
 
+static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
+						struct btrfs_block_group *block_group)
+{
+	return fs_info->_free_space_root;
+}
+
 static struct btrfs_free_space_info *
 search_free_space_info(struct btrfs_trans_handle *trans,
 		       struct btrfs_fs_info *fs_info,
 		       struct btrfs_block_group *block_group,
 		       struct btrfs_path *path, int cow)
 {
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_key key;
 	int ret;
 
@@ -103,7 +109,8 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_free_space_info *info;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
@@ -179,7 +186,7 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 				  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_free_space_info *info;
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
@@ -318,7 +325,7 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_free_space_info *info;
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
@@ -558,7 +565,8 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 				    struct btrfs_path *path,
 				    u64 start, u64 size, int remove)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_key key;
 	u64 end = start + size;
 	u64 cur_start, cur_size;
@@ -671,7 +679,8 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 				    struct btrfs_path *path,
 				    u64 start, u64 size)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_key key;
 	u64 found_start, found_end;
 	u64 end = start + size;
@@ -811,7 +820,8 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 u64 start, u64 size)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_key key, new_key;
 	u64 found_start, found_end;
 	u64 end = start + size;
@@ -1107,7 +1117,8 @@ out:
 int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 				  struct btrfs_block_group *block_group)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_path *path;
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
@@ -1215,7 +1226,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_root *free_space_root = fs_info->free_space_root;
+	struct btrfs_root *free_space_root = btrfs_free_space_root(fs_info, NULL);
 	int ret;
 	u64 features;
 
@@ -1227,7 +1238,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	features &= ~(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
 		      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
 	btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
-	fs_info->free_space_root = NULL;
+	fs_info->_free_space_root = NULL;
 
 	ret = clear_free_space_tree(trans, free_space_root);
 	if (ret)
@@ -1263,7 +1274,7 @@ static int load_free_space_bitmaps(struct btrfs_fs_info *fs_info,
 				   u32 expected_extent_count,
 				   int *errors)
 {
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_key key;
 	int prev_bit = 0, bit;
 	u64 extent_start = 0;
@@ -1343,7 +1354,7 @@ static int load_free_space_extents(struct btrfs_fs_info *fs_info,
 				   u32 expected_extent_count,
 				   int *errors)
 {
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(fs_info, block_group);
 	struct btrfs_key key, prev_key;
 	int have_prev = 0;
 	u64 start, end;
@@ -1463,7 +1474,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		ret = PTR_ERR(free_space_root);
 		goto abort;
 	}
-	fs_info->free_space_root = free_space_root;
+	fs_info->_free_space_root = free_space_root;
 	add_root_to_dirty_list(free_space_root);
 
 	do {
diff --git a/mkfs/main.c b/mkfs/main.c
index 9647f12a..16f9ba19 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -289,8 +289,8 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, csum_root);
 	if (ret)
 		return ret;
-	if (info->free_space_root) {
-		ret = __recow_root(trans, info->free_space_root);
+	if (info->_free_space_root) {
+		ret = __recow_root(trans, info->_free_space_root);
 		if (ret)
 			return ret;
 	}
-- 
2.26.3

