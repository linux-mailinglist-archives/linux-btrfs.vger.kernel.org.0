Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD11412C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAQV0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36084 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so22916266qtr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BorF5U4tL3GY/tAcA80FIONM5hSu12CbgEdXxE/Nqe4=;
        b=xD04ERtfGgBr53gN1MfQGFZK9NVSssn1KxXiy3RKlLHKI4olG4cfIU/T9KnOtYtMIl
         yO0z3SYLGauHXZ7mzGkNl9yz+RcnQwvz7xLt2IHu92oobBCaZJbX+O46xMyMa3v6TQvO
         kFlu7SHuzuGzDDStqIT4YNykAyPWQXrcUxSQ0jR9dlpWGeReziMA98wIHS9WRdx3bjzK
         Xrj9GGOwqVy9Y0XFpjU6AESV3aDwo4toGCF1oAun7r4p4yel4cw6Xfxh/+16qh9koy3I
         PwzMEr3ar3xzGoyBqEnbeTEZwupm+NniwxQ6xqYbxCGco+G5bzQ9FzQgJ+eWHkAOUY4g
         yQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BorF5U4tL3GY/tAcA80FIONM5hSu12CbgEdXxE/Nqe4=;
        b=dFsIM7ELLyBXQacNQdi05dWsDacL8gVdfheNkkUbb0DBRaDg5mbxiOBGGrJZqKX3tB
         pUWXGI2mj8hJzfxHRtoQFwIhe4WMGbwnGiGjVr/ghkHJQKmPZ85ijDX9pyXagFvN0qxb
         qj+CisYRpiP/xdQaAvoCNQXbx6pkY7M/OhmiCbFAdCCTK/ePgl7sjRMO8Hj7T0tILMIG
         p/3BgKO2zES72CTW5h3jXphskhnx+USBfdcWtZVWjuuoI7IuJaIRmF4A4TO+603FgYO9
         rtLrZBElau7jh8qr1Wqt0sAVwxgWkzeTEp2eWZ1gJgQh936kV7BlaMtea48fLUmKrzIL
         hb4g==
X-Gm-Message-State: APjAAAVSl009gHWieWnk8NrHU+ZT2dT26Hp6st05jhYy8Xn9oYhX+Lxw
        h3FqUVV4MRxIVS7ROWAHn9plQAAgdq828Q==
X-Google-Smtp-Source: APXvYqyzT7D9LFP7MjaHAmiLkwwGMCDIEWGcJ+MB1OZG5gDYTJ1CyHzJ6vYCfHCIADGC3X2lczTREw==
X-Received: by 2002:ac8:540d:: with SMTP id b13mr9512563qtq.244.1579296367400;
        Fri, 17 Jan 2020 13:26:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m23sm4830163qtp.6.2020.01.17.13.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/43] btrfs: push __setup_root into btrfs_alloc_root
Date:   Fri, 17 Jan 2020 16:25:20 -0500
Message-Id: <20200117212602.6737-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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
index 5ce2801f8388..1dc33e95052b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1130,6 +1130,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
 	bool dummy = test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+	root->fs_info = fs_info;
 	root->node = NULL;
 	root->commit_root = NULL;
 	root->state = 0;
@@ -1198,11 +1199,11 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
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
 
@@ -1215,12 +1216,11 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info)
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
@@ -1244,12 +1244,11 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
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
@@ -1309,12 +1308,10 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
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
@@ -1401,14 +1398,12 @@ static struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
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
@@ -2208,12 +2203,11 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
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
@@ -2645,8 +2639,10 @@ int __cold open_ctree(struct super_block *sb,
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
@@ -2825,8 +2821,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
-	__setup_root(tree_root, fs_info, BTRFS_ROOT_TREE_OBJECTID);
-
 	invalidate_bdev(fs_devices->latest_bdev);
 
 	/*
@@ -3022,8 +3016,6 @@ int __cold open_ctree(struct super_block *sb,
 	generation = btrfs_super_chunk_root_generation(disk_super);
 	level = btrfs_super_chunk_root_level(disk_super);
 
-	__setup_root(chunk_root, fs_info, BTRFS_CHUNK_TREE_OBJECTID);
-
 	chunk_root->node = read_tree_block(fs_info,
 					   btrfs_super_chunk_root(disk_super),
 					   generation, level, NULL);
-- 
2.24.1

