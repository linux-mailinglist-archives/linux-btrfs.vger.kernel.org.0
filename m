Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D67785AAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjHWOdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbjHWOdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA63E54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d40c2debeso62279687b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801214; x=1693406014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9LNgjQ9gxDam5zBCWotVFHgLh6mbx0viiWOaWN1WYE=;
        b=EGzJEO3ibxXt+OFP9ZtF6BaD0WMVl7sBQIiAVElF3oSmLPE24cr6CQq5oUYAmVImme
         cXH0f4UM3hiVKm9IYnszFe7hhO7tkRhEinXR9EL0J0yWFUq/9u2frcAqnR13CpWvY4Ut
         Dgr0VQtpG5NkqF0edrUiF7/j5T1uD4ZOHMiwqIAvoysI87L0hVGnyFxLUGGkcsmfwPMb
         7A4vaa6W/lS/njffBx6Bq65hFhMoK+aoXJgbNXNy51pyEVaYedZi4zUr214bbiojTOP7
         prVTgaQg9W9hMLtHG5oBXHdjb4iZrQnNYCY0j4ChM451fIJKid3tLDdcKtSUISKr7P0C
         N07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801214; x=1693406014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9LNgjQ9gxDam5zBCWotVFHgLh6mbx0viiWOaWN1WYE=;
        b=XwxzBo08RCPQE26WfbI2hTnjz9KmylBkE2G+1U4kvWam1IfpV4rHNVkR5f5PHPe9te
         K7pUKyzuhQhRp8Ptj+ytDsMA9RSzswMkBuQ4S3e8puJHxtpJBWAiaAHlCfKMGPzY/Al4
         lZP/pyPPOSTn9RBKWU46/rI/5qVFYgRpKLlTmIgPqCOcgTcSFFEQR8cKJ7b8bdfv/HJd
         AlbbqQLZora4jyJ211k/jeoeZ0+9GCCQUwn9PKYQvZ2ssLkN58RiG1E4N94d+yzleENI
         YXcVg3rsO92hPScw3oBwYE6X15UIrj1zd4YfE1Xe9/CZQB3X8hnjL5zu53Eo7fTgqztM
         uVZQ==
X-Gm-Message-State: AOJu0YwIm0Spg7Lt1LBwOLALLu52onHaqHTIJYS/lDRkaQEARNJPYu8D
        peN0qWuy4QBumrqxF1hHOAPMGZh29v15bMO+qus=
X-Google-Smtp-Source: AGHT+IEHDDLyJCUkOQ+XB6DM43f5zL6CdbqN9+ySL/9HdUcrF+U69QpSU0toZ5p2Nlj46qPzEm6T+w==
X-Received: by 2002:a0d:d80f:0:b0:589:e7ab:d4e5 with SMTP id a15-20020a0dd80f000000b00589e7abd4e5mr12758714ywe.0.1692801213763;
        Wed, 23 Aug 2023 07:33:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i194-20020a816dcb000000b0057042405e2csm3368883ywc.71.2023.08.23.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/38] btrfs-progs: replace blocksize with parent argument for btrfs_alloc_tree_block
Date:   Wed, 23 Aug 2023 10:32:47 -0400
Message-ID: <621e47bfa5cbdd21ee2c6639602c028585aacc79.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel we pass in the parent to btrfs_alloc_tree_block instead of
the blocksize and simply derive the blocksize from the fs_info.  Update
the function to match the kernel's convention and update all of the
callers so we can sync ctree.c easily.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                |  3 +--
 cmds/rescue-chunk-recover.c |  3 +--
 kernel-shared/ctree.c       | 29 ++++++++++++-----------------
 kernel-shared/ctree.h       |  2 +-
 kernel-shared/disk-io.c     |  5 ++---
 kernel-shared/extent-tree.c |  9 +++++----
 6 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/check/main.c b/check/main.c
index a33a300a..08c49f7a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9067,8 +9067,7 @@ static struct extent_buffer *btrfs_fsck_clear_root(
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	c = btrfs_alloc_tree_block(trans, gfs_info->tree_root,
-				   gfs_info->nodesize, key->objectid,
+	c = btrfs_alloc_tree_block(trans, gfs_info->tree_root, 0, key->objectid,
 				   &disk_key, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(c)) {
 		btrfs_free_path(path);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index e12dc61c..89b778d5 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1143,8 +1143,7 @@ static int __rebuild_chunk_root(struct btrfs_trans_handle *trans,
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_ITEM_KEY);
 	btrfs_set_disk_key_offset(&disk_key, min_devid);
 
-	cow = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
-				     BTRFS_CHUNK_TREE_OBJECTID,
+	cow = btrfs_alloc_tree_block(trans, root, 0, BTRFS_CHUNK_TREE_OBJECTID,
 				     &disk_key, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	btrfs_set_header_bytenr(cow, cow->start);
 	btrfs_set_header_generation(cow, trans->transid);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 91127933..e3b29a3a 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -307,9 +307,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	cow = btrfs_alloc_tree_block(trans, new_root, buf->len,
-				     new_root_objectid, &disk_key,
-				     level, buf->start, 0,
+	cow = btrfs_alloc_tree_block(trans, new_root, 0, new_root_objectid,
+				     &disk_key, level, buf->start, 0,
 				     BTRFS_NESTING_NORMAL);
 	if (IS_ERR(cow)) {
 		kfree(new_root);
@@ -489,9 +488,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	cow = btrfs_alloc_tree_block(trans, root, buf->len,
-				     root->root_key.objectid, &disk_key,
-				     level, search_start, empty_size,
+	cow = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				     &disk_key, level, search_start, empty_size,
 				     BTRFS_NESTING_NORMAL);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
@@ -1566,9 +1564,8 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(lower, &lower_key, 0);
 
-	c = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
-				   root->root_key.objectid, &lower_key,
-				   level, root->node->start, 0,
+	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				   &lower_key, level, root->node->start, 0,
 				   BTRFS_NESTING_NORMAL);
 
 	if (IS_ERR(c))
@@ -1688,10 +1685,9 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 	mid = (c_nritems + 1) / 2;
 	btrfs_node_key(c, &disk_key, mid);
 
-	split = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
-					root->root_key.objectid,
-					&disk_key, level, c->start, 0,
-					BTRFS_NESTING_NORMAL);
+	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				       &disk_key, level, c->start, 0,
+				       BTRFS_NESTING_NORMAL);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -2251,10 +2247,9 @@ again:
 	else
 		btrfs_item_key(l, &disk_key, mid);
 
-	right = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
-					root->root_key.objectid,
-					&disk_key, 0, l->start, 0,
-					BTRFS_NESTING_NORMAL);
+	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				       &disk_key, 0, l->start, 0,
+				       BTRFS_NESTING_NORMAL);
 	if (IS_ERR(right)) {
 		BUG_ON(1);
 		return PTR_ERR(right);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a1c09d97..0b440b1a 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -886,7 +886,7 @@ struct btrfs_block_group *btrfs_lookup_first_block_group(struct
 						       u64 bytenr);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
-					u32 blocksize, u64 root_objectid,
+					u64 parent, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
 					u64 hint, u64 empty_size,
 					enum btrfs_lock_nesting nest);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index c98addd2..286eb9cb 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2319,9 +2319,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_setup_root(root, fs_info, key->objectid);
 	memcpy(&root->root_key, key, sizeof(struct btrfs_key));
 
-	leaf = btrfs_alloc_tree_block(trans, root, fs_info->nodesize,
-				      root->root_key.objectid, NULL, 0, 0, 0,
-				      BTRFS_NESTING_NORMAL);
+	leaf = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				      NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 433cf4fc..439ac530 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2479,7 +2479,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 }
 
 static int alloc_tree_block(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root, u64 num_bytes,
+			    struct btrfs_root *root, u64 parent,
 			    u64 root_objectid, u64 generation,
 			    u64 flags, struct btrfs_disk_key *key,
 			    int level, u64 empty_size, u64 hint_byte,
@@ -2490,6 +2490,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_extent_op *extent_op;
 	struct btrfs_space_info *sinfo;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	u64 num_bytes = fs_info->nodesize;
 	bool skinny_metadata = btrfs_fs_incompat(root->fs_info,
 						 SKINNY_METADATA);
 
@@ -2536,7 +2537,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 
 	sinfo->bytes_reserved += extent_size;
 	ret = btrfs_add_delayed_tree_ref(root->fs_info, trans, ins->objectid,
-					 extent_size, 0, root_objectid,
+					 extent_size, parent, root_objectid,
 					 level, BTRFS_ADD_DELAYED_EXTENT,
 					 extent_op, NULL, NULL);
 	return ret;
@@ -2548,7 +2549,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
  */
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
-					u32 blocksize, u64 root_objectid,
+					u64 parent, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
 					u64 hint, u64 empty_size,
 					enum btrfs_lock_nesting nest)
@@ -2557,7 +2558,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 	struct extent_buffer *buf;
 
-	ret = alloc_tree_block(trans, root, blocksize, root_objectid,
+	ret = alloc_tree_block(trans, root, parent, root_objectid,
 			       trans->transid, 0, key, level,
 			       empty_size, hint, (u64)-1, &ins);
 	if (ret) {
-- 
2.41.0

