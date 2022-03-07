Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59764D0AA8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343538AbiCGWM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiCGWMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:24 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCD8BE05
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:29 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id b12so13251136qvk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mp+Rn4vTbNKyLWswjnvdBPpa+Ycj0lR1m17cda13CwI=;
        b=eiPKJukBY1KK/2R7ABXVnCGu/h8Au5YNR7YRJzpHm7ja5FnRqe43ffPHRmV1l0r/Ty
         5CZ0aEnjSNER7Tiv7Yiec4SY/yVUhBFhBu6U8ZQrl2wttGrHWLkN9p2vZEgJnYLoY7gR
         lyvIUKWCeQAKFZi31rSb4U+nYUVYseVRc+D34vQQO3cERjwEvKPbzHDSYz+hoDBilqYv
         1ASLTdG2Er5eO0tBW/yqwhweOZb2EGZLrYGzEPrVzdPiQ2BSPAM/QC0buj+0aew0dzaj
         Gn4vKTCtS1cB5i8JYG1OJpY4nHqdsMHGgI7+pyi6of4GaNhzOcjh6ePS2VDyLytadJTj
         sV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mp+Rn4vTbNKyLWswjnvdBPpa+Ycj0lR1m17cda13CwI=;
        b=wIn0MPUZG7UTPOKdfxF3537c3NTyD89t5WzlMtVf67Pjp2TZrc4W1YYu3wXicN6rRv
         9azSvardQ/zx3Q56exqIze707M2uTK7CBsHpAzjpPGLUdtyBrnr8G+JlK92Iy7XCEOf/
         Q735TSuI6wViYmtorkFbAp69hPm2I5scwuH7dWRD28mxQJpg+5OC+wCMhh89Xvnrwm/O
         syNgagBsGa7n1SUn7z4l0unvzrC/NWQ6LJ2voqBAg9TQkDWod8HlaGY/n7ucdtpEgAlH
         10XHlJaylzwmGV0Yf7BFwXtMAbSfc/6V2dUxFAdcp5GVAsDUxPG8j0VazPNvF3ekCnEm
         S70w==
X-Gm-Message-State: AOAM532xL0yf9+MuKBc0P/if2GRZoxX2zpfe1UGQ4pk6v6LvaFkN2IBk
        calDT3GXUFgiQNqupekZJiVaoQwOybc1Ibm9
X-Google-Smtp-Source: ABdhPJwEb1+RyCnOV+Xq2mneY+LzHwnDNrr+rFuM8CpAETXJsulw0S7QxrOO2vIUhPYorbMwrThabQ==
X-Received: by 2002:a05:6214:2405:b0:432:6dd5:ba6c with SMTP id fv5-20020a056214240500b004326dd5ba6cmr10268607qvb.6.1646691088632;
        Mon, 07 Mar 2022 14:11:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o133-20020a37a58b000000b0067b36d0a5dfsm1250766qke.57.2022.03.07.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 16/19] btrfs-progs: make btrfs_create_tree take a key for the root key
Date:   Mon,  7 Mar 2022 17:11:01 -0500
Message-Id: <c85a826fff278a4129f69a2964dbdf5745f7384a.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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
index f3ddf9e3..4964cd38 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2426,25 +2426,22 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 
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
@@ -2455,7 +2452,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_header_bytenr(leaf, leaf->start);
 	btrfs_set_header_generation(leaf, trans->transid);
 	btrfs_set_header_backref_rev(leaf, BTRFS_MIXED_BACKREF_REV);
-	btrfs_set_header_owner(leaf, objectid);
+	btrfs_set_header_owner(leaf, root->root_key.objectid);
 	root->node = leaf;
 	write_extent_buffer(leaf, fs_info->fs_devices->metadata_uuid,
 			    btrfs_header_fsid(), BTRFS_FSID_SIZE);
@@ -2480,10 +2477,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
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
index 1e97b9ac..e07141a9 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -220,7 +220,7 @@ int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb);
 int btrfs_fs_roots_compare_roots(struct rb_node *node1, struct rb_node *node2);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
-				     u64 objectid);
+				     struct btrfs_key *key);
 int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 7ac75c20..03eb0ed2 100644
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
index 7f79ba1a..19535604 100644
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

