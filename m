Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BCC6E8390
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjDSVX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjDSVXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:23:19 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B185BB2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:57 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id fy11so594892qtb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939258; x=1684531258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1F3Va4ZvJHGkHs0CIEZEWjSXJYpO1ErBYNd34ZGR8s=;
        b=C973+sju0MjVp6PnRqJ6293n8VbJERRalLldIf2+p6ZlzPHE2VqpnEWFpFDmeu6/c1
         wXU2V+xVeTLKp3FRV0pEsyNiv7pRcQn4CJJZupAPiIeH52HjIQ1spUHGiqFOQCPtFcBA
         tDxg1NI19CN5rUKBMu4gCtPEVNfAjhiW1xzHCO5YF4sOxn8NsjF5jyCTkzolKi2bgd0k
         Zg5WCOgv07uXlhUfFtaH0zWwZZIdEHUZgWuJvuzcWAVyOjqy8WV8clHKiPpGMr/5e2uh
         wEyZxzRsQ4Z0OU0fkgenX1LDT6p8AbyQZJMuuepwkL7ccOEoWjUIXNqJBCzdexSc1dMR
         C1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939258; x=1684531258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1F3Va4ZvJHGkHs0CIEZEWjSXJYpO1ErBYNd34ZGR8s=;
        b=H8A+1iGLxUjrzAdgDJZLt6Ar0oJOYyAzpd+bxyY+TFVd2ANo0bZn52aES9V9DBuFD1
         xPghZ8gaOIpv2SnBpMLqmh7Zd7No9vHStFJO3NlVcSJ4rKaHh6DGOrLaAEGJ30d/JzEj
         uyv8cwuQC42VpNZmhBCUuJObMjrvBAihsRKPA86t97cMm/INxDRfT/qI2TLcM//NKWGQ
         2Yk2fs46zT96jKUWRDFaPvk86AzsZIKMgDKwrCB4I2mTeWL0VyaQn/gy7ncXy11UfYHt
         9Mch+s8f2FpKeI3toJ5SoEFWi75I0Ru9HrpYBoH8ri8Uq4SOdaxbRbwQIMul4WiEnqOF
         W5rA==
X-Gm-Message-State: AAQBX9f5yXGk3XqqwfjxmxadfB15jqMAfc8Gm2UvADI7hNSXtHHo4ubS
        SfqN4DOhXCByEcIWbJ3VBj9tBw8NQcfUr5VxettnCg==
X-Google-Smtp-Source: AKy350bkTz3QZadYCMqGvkkTy6A2+7CTZ+20Y0OndudOkyub1gKM38ash9X69Qf/Abi54h0cJAKrDQ==
X-Received: by 2002:ac8:7d54:0:b0:3e6:386b:2314 with SMTP id h20-20020ac87d54000000b003e6386b2314mr8487651qtb.62.1681939257683;
        Wed, 19 Apr 2023 14:20:57 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a0d8900b00706b09b16fasm4944669qkl.11.2023.04.19.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:20:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/10] btrfs-progs: rename btrfs_alloc_free_block to btrfs_alloc_tree_block
Date:   Wed, 19 Apr 2023 17:20:43 -0400
Message-Id: <b221a1bcbe28651c06929e40155994452a068716.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is in keeping with what the function actually does, and is named
this way in the kernel.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                |  2 +-
 cmds/rescue-chunk-recover.c |  2 +-
 kernel-shared/ctree.c       | 14 +++++++-------
 kernel-shared/ctree.h       |  2 +-
 kernel-shared/disk-io.c     |  2 +-
 kernel-shared/extent-tree.c |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/check/main.c b/check/main.c
index 45e3442d..c5131b7a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9096,7 +9096,7 @@ static struct extent_buffer *btrfs_fsck_clear_root(
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	c = btrfs_alloc_free_block(trans, gfs_info->tree_root,
+	c = btrfs_alloc_tree_block(trans, gfs_info->tree_root,
 				   gfs_info->nodesize, key->objectid,
 				   &disk_key, 0, 0, 0);
 	if (IS_ERR(c)) {
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index ce53da2e..b18d422e 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1146,7 +1146,7 @@ static int __rebuild_chunk_root(struct btrfs_trans_handle *trans,
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_ITEM_KEY);
 	btrfs_set_disk_key_offset(&disk_key, min_devid);
 
-	cow = btrfs_alloc_free_block(trans, root, root->fs_info->nodesize,
+	cow = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 				     BTRFS_CHUNK_TREE_OBJECTID,
 				     &disk_key, 0, 0, 0);
 	btrfs_set_header_bytenr(cow, cow->start);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index cfbcc689..230dae1b 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -167,7 +167,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		btrfs_item_key(buf, &disk_key, 0);
 	else
 		btrfs_node_key(buf, &disk_key, 0);
-	cow = btrfs_alloc_free_block(trans, new_root, buf->len,
+	cow = btrfs_alloc_tree_block(trans, new_root, buf->len,
 				     new_root_objectid, &disk_key,
 				     level, buf->start, 0);
 	if (IS_ERR(cow)) {
@@ -230,7 +230,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 	new_root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	new_root->root_key.offset = 0;
 
-	node = btrfs_alloc_free_block(trans, new_root, fs_info->nodesize,
+	node = btrfs_alloc_tree_block(trans, new_root, fs_info->nodesize,
 				      objectid, &disk_key, 0, 0, 0);
 	if (IS_ERR(node)) {
 		ret = PTR_ERR(node);
@@ -285,7 +285,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 	/*
 	 * Essential trees can't be created by this function, yet.
 	 * As we expect such skeleton exists, or a lot of functions like
-	 * btrfs_alloc_free_block() doesn't work at all
+	 * btrfs_alloc_tree_block() doesn't work at all
 	 */
 	case BTRFS_ROOT_TREE_OBJECTID:
 	case BTRFS_EXTENT_TREE_OBJECTID:
@@ -461,7 +461,7 @@ int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	cow = btrfs_alloc_free_block(trans, root, buf->len,
+	cow = btrfs_alloc_tree_block(trans, root, buf->len,
 				     root->root_key.objectid, &disk_key,
 				     level, search_start, empty_size);
 	if (IS_ERR(cow))
@@ -1732,7 +1732,7 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(lower, &lower_key, 0);
 
-	c = btrfs_alloc_free_block(trans, root, root->fs_info->nodesize,
+	c = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 				   root->root_key.objectid, &lower_key,
 				   level, root->node->start, 0);
 
@@ -1858,7 +1858,7 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 	mid = (c_nritems + 1) / 2;
 	btrfs_node_key(c, &disk_key, mid);
 
-	split = btrfs_alloc_free_block(trans, root, root->fs_info->nodesize,
+	split = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 					root->root_key.objectid,
 					&disk_key, level, c->start, 0);
 	if (IS_ERR(split))
@@ -2425,7 +2425,7 @@ again:
 	else
 		btrfs_item_key(l, &disk_key, mid);
 
-	right = btrfs_alloc_free_block(trans, root, root->fs_info->nodesize,
+	right = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 					root->root_key.objectid,
 					&disk_key, 0, l->start, 0);
 	if (IS_ERR(right)) {
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 84acefef..af60ba66 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -849,7 +849,7 @@ struct btrfs_block_group *btrfs_lookup_block_group(struct btrfs_fs_info *info,
 struct btrfs_block_group *btrfs_lookup_first_block_group(struct
 						       btrfs_fs_info *info,
 						       u64 bytenr);
-struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
+struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
 					u32 blocksize, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 44462d8f..6f9dc327 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2333,7 +2333,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_setup_root(root, fs_info, key->objectid);
 	memcpy(&root->root_key, key, sizeof(struct btrfs_key));
 
-	leaf = btrfs_alloc_free_block(trans, root, fs_info->nodesize,
+	leaf = btrfs_alloc_tree_block(trans, root, fs_info->nodesize,
 				      root->root_key.objectid, NULL, 0, 0, 0);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8f3477bf..d0b3aee3 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2555,7 +2555,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
  * helper function to allocate a block for a given tree
  * returns the tree buffer or NULL.
  */
-struct extent_buffer *btrfs_alloc_free_block(struct btrfs_trans_handle *trans,
+struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
 					u32 blocksize, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
-- 
2.40.0

