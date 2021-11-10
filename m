Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B744CA69
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhKJUSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhKJUSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:18 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775EC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:30 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id r8so3693548qkp.4
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TjOid4Bvsqc58RjLt+F3EaWa1C5KV09HVSsJcS/ZFk4=;
        b=wqc/yw1DsCqompVm/mHHo6xkmEkrJ3NLQj2BVRjyZNDf+xnPq1aE+GOjkKZgLZFFkX
         nPWFbR2Qb2q+/AoykvywUvGwdIPtjKFBbTGwGUbBKF3nUnOs/TeycqXgMhvv0JZDAiWg
         +PKHi+Ic/5sX5QylDrp7b4eCogxSz/AIgoOsf/Bn7FDA+MVcwi5+gfnB9oYBxTwr6pso
         Y0aZ6MSAYKtXOHYJRB8c3fHN8mF6Fwk7+LvhMTYICHdhx4PDqcO5W5AFOQXuJJdwIpjA
         cqvWpppy6Hu/m5jaPxm0TEyqC/bOQWzDGnEqRVUP68QjOgBFNEqbgag/PvqDsj/7g32k
         DGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjOid4Bvsqc58RjLt+F3EaWa1C5KV09HVSsJcS/ZFk4=;
        b=od46IVAdYDkR5MTnQkF1A3x1l9Xxxh7VEkUB8cYywniGJ1b35+5fj3OM7MVjYLEf/X
         PFP12fos/4ZeBvvwz9PLK2ch2B6c9U/yNJRf487pYDyI3TaPeyEs3HuGpRe5pFlNUwOA
         lw3TvpJFK1/k6ersea2wI2BNXTeQGBYujQeFj3p6LwAa7EbspVzUDD2p75rP3hrwrQN6
         tEIKld2SmUiVDyfRnIwdPmgzQ6k3UZK3ManOL0Kw1kO8eIUYJS2tWZrevWQEcAw8Gb7h
         EUunDNAsR1r1w8MzU+6fH/MePIzI21LKujzEecvHYu0VSq2yqLlRETHMehIFNqj3PWqe
         KwMg==
X-Gm-Message-State: AOAM533nu37ZTgza4aIdz3XhWrfGAA/Ba1Qrd/lC+RhNZYe+dMi5UoYl
        +YdxTtlvjG2hp5JqKprlkjBsKUAPPmgXEQ==
X-Google-Smtp-Source: ABdhPJxC5eiL/6fQS1oEeJAqVB9Lxcm8rcxyIgMO4Uk7rk1aZNpK/1vdrWfSZ0YYXuv14np40zYtDQ==
X-Received: by 2002:a05:620a:458c:: with SMTP id bp12mr1759553qkb.409.1636575329433;
        Wed, 10 Nov 2021 12:15:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o18sm494689qta.34.2021.11.10.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 27/30] btrfs-progs: make btrfs_create_tree take a key for the root key
Date:   Wed, 10 Nov 2021 15:14:39 -0500
Message-Id: <c6c8710c4c74f778789d080e7e26b2d95cb9b454.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to start create global roots from mkfs, and we need to have
a offset set for the root key.  Make the btrfs_create_tree() take a key
for the root_key instead of just the objectid so we can setup these new
style roots properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c         | 21 ++++++++-------------
 kernel-shared/disk-io.h         |  2 +-
 kernel-shared/free-space-tree.c |  7 +++++--
 mkfs/main.c                     | 13 ++++++++++---
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 13234605..0e200714 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2394,25 +2394,22 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
-				     u64 objectid)
+				     struct btrfs_key *key)
 {
 	struct extent_buffer *leaf;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *root;
-	struct btrfs_key key;
 	int ret = 0;
 
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 
-	btrfs_setup_root(root, fs_info, objectid);
-	root->root_key.objectid = objectid;
-	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root->root_key.offset = 0;
+	btrfs_setup_root(root, fs_info, key->objectid);
+	memcpy(&root->root_key, key, sizeof(struct btrfs_key));
 
-	leaf = btrfs_alloc_free_block(trans, root, fs_info->nodesize, objectid,
-			NULL, 0, 0, 0);
+	leaf = btrfs_alloc_free_block(trans, root, fs_info->nodesize,
+				      root->root_key.objectid, NULL, 0, 0, 0);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
@@ -2423,7 +2420,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_header_bytenr(leaf, leaf->start);
 	btrfs_set_header_generation(leaf, trans->transid);
 	btrfs_set_header_backref_rev(leaf, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(leaf, objectid);
+	btrfs_set_header_owner(leaf, root->root_key.objectid);
 	root->node = leaf;
 	write_extent_buffer(leaf, fs_info->fs_devices->metadata_uuid,
 			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
@@ -2448,10 +2445,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	memset(root->root_item.uuid, 0, BTRFS_UUID_SIZE);
 	root->root_item.drop_level = 0;
 
-	key.objectid = objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = 0;
-	ret = btrfs_insert_root(trans, tree_root, &key, &root->root_item);
+	ret = btrfs_insert_root(trans, tree_root, &root->root_key,
+				&root->root_item);
 	if (ret)
 		goto fail;
 
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index fa4d41f3..9214b56f 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -216,7 +216,7 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb);
 int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
-				     u64 objectid);
+				     struct btrfs_key *key);
 int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 70306175..23fb67bf 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1475,14 +1475,17 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	struct btrfs_root *free_space_root;
 	struct btrfs_block_group *block_group;
 	u64 start = BTRFS_SUPER_INFO_OFFSET + BTRFS_SUPER_INFO_SIZE;
+	struct btrfs_key root_key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
 	int ret;
 
 	trans = btrfs_start_transaction(tree_root, 0);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	free_space_root = btrfs_create_tree(trans, fs_info,
-					    BTRFS_FREE_SPACE_TREE_OBJECTID);
+	free_space_root = btrfs_create_tree(trans, fs_info, &root_key);
 	if (IS_ERR(free_space_root)) {
 		ret = PTR_ERR(free_space_root);
 		goto abort;
diff --git a/mkfs/main.c b/mkfs/main.c
index 1653ab32..fd40c70e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -717,12 +717,15 @@ static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
 	struct btrfs_inode_item *inode;
 	struct btrfs_root *root;
 	struct btrfs_path path;
-	struct btrfs_key key;
+	struct btrfs_key key = {
+		.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
 	u64 ino = BTRFS_FIRST_FREE_OBJECTID;
 	char *name = "..";
 	int ret;
 
-	root = btrfs_create_tree(trans, fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	root = btrfs_create_tree(trans, fs_info, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
@@ -782,10 +785,14 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root;
+	struct btrfs_key key = {
+		.objectid = BTRFS_UUID_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
 	int ret = 0;
 
 	ASSERT(fs_info->uuid_root == NULL);
-	root = btrfs_create_tree(trans, fs_info, BTRFS_UUID_TREE_OBJECTID);
+	root = btrfs_create_tree(trans, fs_info, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
-- 
2.26.3

