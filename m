Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57723115369
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLFOpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44285 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id g17so1374428qtp.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xl1J5b4iVgtui8x+f3BoLKOYLCMYZl0W57rvKAE6w2Y=;
        b=FHeufxeflOGqJvcPwzwflkzmul1rBc+cehSe24m0slRAulUK9fLrHH/y7JfAY6xEwL
         yHg3fpjHyhg1vF62uiOcz0JqVbSEYpJbEslqH8nw/mIuTwEjV+6E28DVhkAFJAJXRL/9
         aBm85mY6hdzjWbsM8SoWGUt+mz7AVXC9E3dAhUbh05UAhaCeAIQXAhfLjM0CYz+7wX1q
         mRmsm9MWbbER/2Pjp5lTUHNclrA7Xmw/i7OnXMtaD0ruapZCEGza17NeSPfp+mATwMST
         5omZye/AsnAhsVz42VgkExV5Rpy49uJXvKIsZuAO8OYTci1IV2+4+vQELYYfNueKJe3f
         H/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl1J5b4iVgtui8x+f3BoLKOYLCMYZl0W57rvKAE6w2Y=;
        b=DUyPGu1AVmWo0H9pNeqmbxemudg4SQMNxKcltzG5Tp5lD0tREo7gtMSmsZ28Knn8Wa
         ITj+UyPlnfbYVlwMDGNPi53UtV5lPHgwL6hndjBDxrLPwGWOv38bVxaAQIG1O0j2rIKP
         SV7gN9LUfxXmovbQWzDGltNDW7e2afEowHAVKii1TGa7crCYNJAuzOi/7MiViwgiJIbd
         rrZ3kvnK+ZjCgaSnnDK9vX6McnQdB1ecin7gVWvKyMeU7sL1DG4qzrQYjm4pTuJeWfU6
         4xCSzxBnabKDcVJIxqlBKmCMc+9bPFDOsMfav2IjpCFhbt8s78zO3e5lYwT9vk0oywXL
         wn1Q==
X-Gm-Message-State: APjAAAUsxvpTCLLxV6a1/o391qbb5AKYlsVFT/KFniWRSdpvzfJeT1oR
        pYK1cTPUM5E+0S8/4qzsTY7fxclaun2qjQ==
X-Google-Smtp-Source: APXvYqzU7t3s7jiiE0I+1GE4SHPIPVnmaFwzw3XL2rniOSc4IS7Vhq/aCy3CFTXVtZsv4GUhP1dK+A==
X-Received: by 2002:ac8:7615:: with SMTP id t21mr12107711qtq.95.1575643543461;
        Fri, 06 Dec 2019 06:45:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w76sm5982500qkb.8.2019.12.06.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/44] btrfs: push __setup_root into btrfs_alloc_root
Date:   Fri,  6 Dec 2019 09:44:55 -0500
Message-Id: <20191206144538.168112-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's no reason to not init the root at alloc time, and with later
patches it actually causes problems if we error out mounting the fs
before the tree_root is init'ed because we expect it to have a valid ref
count.  Fix this by pushing __setup_root into btrfs_alloc_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8783d86f487d..ee0ddd4f45f0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1132,6 +1132,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
 	bool dummy = test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+	root->fs_info = fs_info;
 	root->node = NULL;
 	root->commit_root = NULL;
 	root->state = 0;
@@ -1200,11 +1201,11 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 }
 
 static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
-		gfp_t flags)
+					   u64 objectid, gfp_t flags)
 {
 	struct btrfs_root *root = kzalloc(sizeof(*root), flags);
 	if (root)
-		root->fs_info = fs_info;
+		__setup_root(root, fs_info, objectid);
 	return root;
 }
 
@@ -1217,12 +1218,11 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info)
 	if (!fs_info)
 		return ERR_PTR(-EINVAL);
 
-	root = btrfs_alloc_root(fs_info, GFP_KERNEL);
+	root = btrfs_alloc_root(fs_info, BTRFS_ROOT_TREE_OBJECTID, GFP_KERNEL);
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 
 	/* We don't use the stripesize in selftest, set it as sectorsize */
-	__setup_root(root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
 	root->alloc_bytenr = 0;
 
 	return root;
@@ -1246,12 +1246,11 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	 * context to avoid deadlock if reclaim happens.
 	 */
 	nofs_flag = memalloc_nofs_save();
-	root = btrfs_alloc_root(fs_info, GFP_KERNEL);
+	root = btrfs_alloc_root(fs_info, objectid, GFP_KERNEL);
 	memalloc_nofs_restore(nofs_flag);
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 
-	__setup_root(root, fs_info, objectid);
 	root->root_key.objectid = objectid;
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = 0;
@@ -1311,12 +1310,10 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root;
 	struct extent_buffer *leaf;
 
-	root = btrfs_alloc_root(fs_info, GFP_NOFS);
+	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 
-	__setup_root(root, fs_info, BTRFS_TREE_LOG_OBJECTID);
-
 	root->root_key.objectid = BTRFS_TREE_LOG_OBJECTID;
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
@@ -1403,14 +1400,12 @@ static struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	root = btrfs_alloc_root(fs_info, GFP_NOFS);
+	root = btrfs_alloc_root(fs_info, key->objectid, GFP_NOFS);
 	if (!root) {
 		ret = -ENOMEM;
 		goto alloc_fail;
 	}
 
-	__setup_root(root, fs_info, key->objectid);
-
 	ret = btrfs_find_root(tree_root, key, path,
 			      &root->root_item, &root->root_key);
 	if (ret) {
@@ -2205,12 +2200,11 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		return -EIO;
 	}
 
-	log_tree_root = btrfs_alloc_root(fs_info, GFP_KERNEL);
+	log_tree_root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID,
+					 GFP_KERNEL);
 	if (!log_tree_root)
 		return -ENOMEM;
 
-	__setup_root(log_tree_root, fs_info, BTRFS_TREE_LOG_OBJECTID);
-
 	log_tree_root->node = read_tree_block(fs_info, bytenr,
 					      fs_info->generation + 1,
 					      level, NULL);
@@ -2642,8 +2636,10 @@ int __cold open_ctree(struct super_block *sb,
 	int clear_free_space_tree = 0;
 	int level;
 
-	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info, GFP_KERNEL);
-	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info, GFP_KERNEL);
+	tree_root = fs_info->tree_root = btrfs_alloc_root(fs_info,
+					BTRFS_ROOT_TREE_OBJECTID, GFP_KERNEL);
+	chunk_root = fs_info->chunk_root = btrfs_alloc_root(fs_info,
+					BTRFS_CHUNK_TREE_OBJECTID, GFP_KERNEL);
 	if (!tree_root || !chunk_root) {
 		err = -ENOMEM;
 		goto fail;
@@ -2821,8 +2817,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
-	__setup_root(tree_root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
-
 	invalidate_bdev(fs_devices->latest_bdev);
 
 	/*
@@ -3018,8 +3012,6 @@ int __cold open_ctree(struct super_block *sb,
 	generation = btrfs_super_chunk_root_generation(disk_super);
 	level = btrfs_super_chunk_root_level(disk_super);
 
-	__setup_root(chunk_root, fs_info, BTRFS_CHUNK_TREE_OBJECTID);
-
 	chunk_root->node = read_tree_block(fs_info,
 					   btrfs_super_chunk_root(disk_super),
 					   generation, level, NULL);
-- 
2.23.0

