Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB696F264F
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjD2UUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjD2UUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:32 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5651FD5
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a00da4e53so5437227b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799630; x=1685391630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tVmDDHyTh9kII60ufgF1qZDrFipk8YiatOI1xQ1kqM=;
        b=aSyJ2HNos2yMf4QXgyycb9xK+nFLHR+TaiXOgMI0Fdad5s1hhq2QlEBG78JUr0o2b6
         lhxpxmo3xB7OEsgo194WaKpBi0zr4/I3Lrhnb+zeWklQR4qzPOkhwQGlTQZuPwssOzNi
         tK5Oq0yuiXajB7zTweC+vObTz9DDJoFRkcQ53rJ7LMTi8S06Cqxn4g3Q0df159a8bYi1
         w9zwDXCv8SMAuTJ5azW/I26UOai6+LebE9owEnbEG8MmNFQCSP4aZZ/U8p5BxkGYFc3T
         +HtdAvjWBPs0pcrQ08BDDslQmLMI4ex+vngoZJ2R0/qUGoKaxMbnanc1/0nGrKSUAflv
         +Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799630; x=1685391630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tVmDDHyTh9kII60ufgF1qZDrFipk8YiatOI1xQ1kqM=;
        b=ECi+EZD5zl8gPLoaVKiZVk5A26QpOO7XCDe+4UToFJgW/hycy/+cJ7/iGI3zC5iLyF
         YLFHAIDoY0wXDSxjxzmeZ2QjHjsI0QaYVt+7DaB2IGcmvZHX44WTD7wvUWeA9jP1VOaJ
         cFa/QU1CbRrysxp9rUdTIC4xlkd+Ju9VMmzOb901HWfP76/UOzdcS0BCtcq7K1hdpmMA
         DreXfLhijKaqz/gLRhwIDV/CcyM23Xz6+r/wQ+IQjcQHC515TEUzajUtfEX3owOb6R3h
         BhD35dwBACjg+gWoeZ4K1on1NqNXn0HnNNX49SiUScbI+4xd6hAPiqSdOLPTbKusYp8t
         vDPw==
X-Gm-Message-State: AC+VfDypMK5GcjN4VHhcsvHVJ+wrHo7L+eEzupTYJLLre7V0Tv2fD5KQ
        PmPoUFG2y5TadAkKFnlDbPFIs6vJgLp5AEOHjtogaA==
X-Google-Smtp-Source: ACHHUZ4jWDE9xvJDi8uhQh7c0P56h0nx22xhJIJPMbsfLR0iw3AyvTVT9i4d6AcH1F4/VoUD1sxt3w==
X-Received: by 2002:a0d:d74c:0:b0:54f:b26f:bc8 with SMTP id z73-20020a0dd74c000000b0054fb26f0bc8mr7062730ywd.26.1682799629657;
        Sat, 29 Apr 2023 13:20:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n187-20020a0de4c4000000b005463e45458bsm6288976ywe.123.2023.04.29.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/26] btrfs-progs: replace blocksize with parent argument for btrfs_alloc_tree_block
Date:   Sat, 29 Apr 2023 16:19:53 -0400
Message-Id: <e76134382c7c794392ecd68daafa416a45988cf8.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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
index 2643244f..ca49863b 100644
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
index f30612d1..660d17f7 100644
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
index f9cf78da..2728452f 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -158,9 +158,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		btrfs_item_key(buf, &disk_key, 0);
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
@@ -329,9 +328,8 @@ static int __btrfs_cow_block(struct btrfs_trans_handle *trans,
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
@@ -1395,9 +1393,8 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(lower, &lower_key, 0);
 
-	c = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
-				   root->root_key.objectid, &lower_key,
-				   level, root->node->start, 0,
+	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
+				   &lower_key, level, root->node->start, 0,
 				   BTRFS_NESTING_NORMAL);
 
 	if (IS_ERR(c))
@@ -1522,10 +1519,9 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
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
 
@@ -2088,10 +2084,9 @@ again:
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
index 88a105ab..b68a8080 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -885,7 +885,7 @@ struct btrfs_block_group *btrfs_lookup_first_block_group(struct
 						       u64 bytenr);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
-					u32 blocksize, u64 root_objectid,
+					u64 parent, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
 					u64 hint, u64 empty_size,
 					enum btrfs_lock_nesting nest);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index ec97ff08..bdf77d50 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2361,9 +2361,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
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
index 98c0b297..a9f3eba6 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2480,7 +2480,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 }
 
 static int alloc_tree_block(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root, u64 num_bytes,
+			    struct btrfs_root *root, u64 parent,
 			    u64 root_objectid, u64 generation,
 			    u64 flags, struct btrfs_disk_key *key,
 			    int level, u64 empty_size, u64 hint_byte,
@@ -2491,6 +2491,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_extent_op *extent_op;
 	struct btrfs_space_info *sinfo;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	u64 num_bytes = fs_info->nodesize;
 	bool skinny_metadata = btrfs_fs_incompat(root->fs_info,
 						 SKINNY_METADATA);
 
@@ -2537,7 +2538,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 
 	sinfo->bytes_reserved += extent_size;
 	ret = btrfs_add_delayed_tree_ref(root->fs_info, trans, ins->objectid,
-					 extent_size, 0, root_objectid,
+					 extent_size, parent, root_objectid,
 					 level, BTRFS_ADD_DELAYED_EXTENT,
 					 extent_op, NULL, NULL);
 	return ret;
@@ -2549,7 +2550,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
  */
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
-					u32 blocksize, u64 root_objectid,
+					u64 parent, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
 					u64 hint, u64 empty_size,
 					enum btrfs_lock_nesting nest)
@@ -2558,7 +2559,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	int ret;
 	struct extent_buffer *buf;
 
-	ret = alloc_tree_block(trans, root, blocksize, root_objectid,
+	ret = alloc_tree_block(trans, root, parent, root_objectid,
 			       trans->transid, 0, key, level,
 			       empty_size, hint, (u64)-1, &ins);
 	if (ret) {
-- 
2.40.0

