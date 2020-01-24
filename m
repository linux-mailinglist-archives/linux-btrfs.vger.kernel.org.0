Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD6148922
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392748AbgAXOdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36698 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391885AbgAXOdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id w198so948504qkb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVpRvrdCkqENjZPXDiqlu/srGi8++ae1ZfXSXhzi+0A=;
        b=VaBYfposQdRAAsMehyXhUE5jLdJCSFCI34SK7pF4hiCSd9k4J/cqoB3t4jUDlkeM1i
         VW7LqG06G5T7Ik9RBgtnP9CY48jqN+zneSsi6a3AgwEmKV1UkbuWahoHv1ZU6SACmqzU
         qS70d15OKpOwrPiw+Whlkzgcq+pvPvm120B32u11xSnjNJvbilCrA84EluMMZ6sIfbj1
         h2ztGO6ouurTNmFbSmm3mJ7Wf4mJSl9OfluD+OwGFux9w4dKiw62vKN/0oDp4XaNbOMm
         JcJgM3lXj0h3pZxOfE5ZlHOxynhw1Ut7smIij1txK//5LlEWL1zIBYhxj3oskkro/DpE
         ardg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVpRvrdCkqENjZPXDiqlu/srGi8++ae1ZfXSXhzi+0A=;
        b=JMQxVjMm89/BRb4+Twdg9hJww8IIxnw6Z48oUomLCoU4vfz9uusXR0zhmSu90R7wly
         KVgjrRWOUA6eL2z2/pn19gbbR3ipkk+4DKMJS6sSYwOtSZrbhCLC9AAmfDPLjpF2x/CQ
         igUhZLlbhfPjZIx3Jei0i9deERUqZDXVsopHYd6ei7CQzO6lBmsL3pAmmYGwKkHdEf2i
         oHliOyaPLu76yiGkCUoW541osKwK/r4SRQMZoXuIwOnQBrTPbd8WpDqr9IA44P7boxSK
         hvFH0YjKNjHJEHOBGaH4tjs4CXvICZazDHYo+1omDjYFOtsE835jnpz6jDEM9JXGWsyb
         9+4Q==
X-Gm-Message-State: APjAAAXtVcyg7RExkJCCNIprgkCdhBLJz00YAjdy6Kj0QDOf68feF5HC
        FSQJSoBYZzDLWIQeKzjdsayz9w==
X-Google-Smtp-Source: APXvYqz7Dqr7L7uGUPti/FSeqvb4ID1sSfxzrbFaDhRx42oeAEwqVr1sNa50K4rphPNR7AqkxYIm+w==
X-Received: by 2002:a37:64d5:: with SMTP id y204mr2686721qkb.459.1579876385877;
        Fri, 24 Jan 2020 06:33:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a19sm3148956qka.75.2020.01.24.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/44] btrfs: push __setup_root into btrfs_alloc_root
Date:   Fri, 24 Jan 2020 09:32:18 -0500
Message-Id: <20200124143301.2186319-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

