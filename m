Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48011476279
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhLOUA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhLOUAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48CC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:20 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a1so2184676qtx.11
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=twh96mWAB+UJ70Mw9hmxyNXcK3rV2c2vsfNMBJ2GGZM=;
        b=YmdeIyG/4DBkKFGlo4h0C4BTMNJU2uhBvhufAt+HTiDhv7Xeln3lO3ntyB4+hUZRq4
         vsoqljxq8JHyT17jF0Hw9Kd+bca9eJG1CqhNGAacPgiVy5h4rrdSjih3vbPnnd2BBWUm
         IrzH7+iegwMJqw/IZvqMrdHK5L9WWoMLe6kpzjWITpantFx9FHwwGLKli7BoKO855I3J
         IFBZeFe2ZhMcExM+dB/2+gx+j3OD7C28fqqxgXn2zvixbnMxXOsGNFfDf6JKC0bjJUET
         EVvIfPZ29DE+Wky0D3QngmhKYCgirm6mPYlpm13XH8F+N59yWI+L19yM8I2BjAGUrnRR
         OMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twh96mWAB+UJ70Mw9hmxyNXcK3rV2c2vsfNMBJ2GGZM=;
        b=5jZghTtZDd3QTLJRuTTD6OgnbsMeiu02a1I/rKNwnGUpcSXFOQ4jf/Acfo3KSD0A8M
         +g5RxtARJR9CJ8220bVDLDvW1/L6tE1oE6cIJCNaPqAN6T+kz6HrSZcqwzoc3cyug4db
         7BLn31IfjkZLveCM14/vCbAXTdxuxzjRYD2yPuxpVR3yqkABICTibzX9qTFZ5rq5udg5
         oFJFvOBUWfRsCLiPTkT9JkKTiutKuF00vjfAU4m1jYiyjeX1fcWdpUkDzRRxyHxodLav
         Zyalpe39Dh/Vl6TkYoxpZHNobdzfuQrmfa8e96z5znWqRMM0T51g/yp5ZKHdtuaQqicb
         iH6g==
X-Gm-Message-State: AOAM533WbD4ZMMyut0/+4XqY/H4wk7uU6dByPNJ8vo72BPcKVny8c0gx
        RQEwxP2W+RdKXMxFwppuVsyOXSrqT5s+QA==
X-Google-Smtp-Source: ABdhPJzIigrLLJoaPSSqzxI/oSiL8o6I/fjxbr9xHU7jxSYTxIniWw915KGvVwnXSIgpy3XvTxCH+w==
X-Received: by 2002:ac8:5485:: with SMTP id h5mr13633103qtq.672.1639598419172;
        Wed, 15 Dec 2021 12:00:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o1sm2362844qtw.24.2021.12.15.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 19/22] btrfs-progs: make btrfs_create_tree take a key for the root key
Date:   Wed, 15 Dec 2021 14:59:45 -0500
Message-Id: <feb41cbb147792d0ae67279c902ca34bdef256ff.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
index 83977cec..40097930 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2395,25 +2395,22 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 
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
@@ -2424,7 +2421,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_header_bytenr(leaf, leaf->start);
 	btrfs_set_header_generation(leaf, trans->transid);
 	btrfs_set_header_backref_rev(leaf, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(leaf, objectid);
+	btrfs_set_header_owner(leaf, root->root_key.objectid);
 	root->node = leaf;
 	write_extent_buffer(leaf, fs_info->fs_devices->metadata_uuid,
 			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
@@ -2449,10 +2446,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
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
index 6a64b620..4007abd1 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -213,7 +213,7 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb);
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

