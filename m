Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50C24469E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhKEUoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhKEUn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:56 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5165C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:16 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u25so8068552qve.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=snlyzzHwKlhpr0FQR9GhCGgA3WjohVRVuCPwmLb6mTw=;
        b=7AjyZwDgBRbKVGHkIU2ZtEu3aS7P4SNCFaWgSxyO50Ux9nNAghyiUlHtWcY5DFpzNi
         pB70LVJM355chvOXXNFmO1pNwRHRL4pRF0anzz9Ey9p2So7vsrwvrEQw+U3JDrVbrPwx
         /RLplNtnF2Ln83oE67WT8V9cIsv6NrH8ZwOVXNWJS1KsXzFSHX0/VI0FdkgFWAyyEQEd
         yjGR9qS6UkdWHW3qAZaK2E7+lGqaaeph0WH99N2qARXYqv/cYKDN6ZbT0XF/d5aeGrcC
         cZQtJ3u6Fb2FUUqYVstaN4y3szE3cLW1+C6/c3wXgHlAWGsx1bj4eQ5XxVDHu9p0og50
         WGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snlyzzHwKlhpr0FQR9GhCGgA3WjohVRVuCPwmLb6mTw=;
        b=4Cfzo6c/IY1ut6/c3I83X1OCUy9eghRnpukioS/dqzX2YHEpK5VB4yOKTGM/e81JLM
         XjFhek4g7MojADP5maZyKkr1UdI9Ihs4hP00Htv66G8N2dtozaZdAbAtVDApRaENIjbZ
         T2UikQKCdmKQchNzKufhwplPy5FdHWmgvYGQAxcNanidEoCfq1bHenEORARbCX2V2kv2
         +q4xJchxNi75nubOHSyyntcJk7ma0x6rUzrBK+2rAXIzUL7UFcqJv8JstT1iXrMAE3EM
         M+8t1G36jykx3RDNhcAozRL6UYZ4nUWRWEoLEp0tF96lxuk9lIxVDEbNJr/MJE/88Zk4
         /GGw==
X-Gm-Message-State: AOAM530n2kaBF4k6BfEWRZq7Se0vcV/o6ArXFPW6DcJ8APxyu+vfgAIW
        ZpqZ4OpuTwI6chtwQ4K3Hkicn/4cw4OsaQ==
X-Google-Smtp-Source: ABdhPJzNq3Js9jqevijME91e6V2yHBsLRMEZwH9ZR2jyS/qtafjQAMxL3/Jip10XF1BDJH2DiuUoSw==
X-Received: by 2002:a05:6214:29ed:: with SMTP id jv13mr1552532qvb.8.1636144875456;
        Fri, 05 Nov 2021 13:41:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v38sm6948506qtc.63.2021.11.05.13.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/22] btrfs-progs: make btrfs_create_tree take a key for the root key
Date:   Fri,  5 Nov 2021 16:40:45 -0400
Message-Id: <51cefdd03afdcca168991826b26a22d038785a53.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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
index c35bdff4..b9ee2505 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2376,25 +2376,22 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 
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
@@ -2405,7 +2402,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_header_bytenr(leaf, leaf->start);
 	btrfs_set_header_generation(leaf, trans->transid);
 	btrfs_set_header_backref_rev(leaf, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(leaf, objectid);
+	btrfs_set_header_owner(leaf, root->root_key.objectid);
 	root->node = leaf;
 	write_extent_buffer(leaf, fs_info->fs_devices->metadata_uuid,
 			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
@@ -2430,10 +2427,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
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

