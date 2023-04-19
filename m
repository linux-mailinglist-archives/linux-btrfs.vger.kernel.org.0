Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546456E838A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjDSVWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDSVWh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:22:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBC7D92
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id fg9so684417qtb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939260; x=1684531260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJL4BH5zfjlEK7ouLKrTVZCqb3jUq7HRx2RxvhPzGVE=;
        b=z4u88xZduHWoLJ5b8+7cAtW+tvGvHzYe//e+lFgt5GY5F9aDn0ShdwwrikbnCX1RpY
         fZcipgW+q3tSgTN6Iqce74zc61WbwtxfgDQFMDVjV1JBT6cN5bZ/w2IywcgUx/KKB5zC
         JLqs7+Hv6q75jSATpXD/nTLVLD77oY9TvSeMDWTb/pLPpKte3yYM4OGWjqovcO1gU7d7
         jr9ShXsiYHZpl9CUGmbNqakchB2iuaLbDdVgDktMHjJD4iKnPHFRAsyNcTyZeKo8fEXl
         0OnW8B8OdAPKZn3wzV/uZySDTcAw/by+Hhi9Tiy6yNe548LQ/3oY7w/Ix0a+FpH9YGz1
         j9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939260; x=1684531260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJL4BH5zfjlEK7ouLKrTVZCqb3jUq7HRx2RxvhPzGVE=;
        b=YE1YpqiOF34EeSXypakIAKMuyKv3kZS9VR3IGsPIeGaI3xvcbneJ79Cx8m1WuOGoCM
         6nLj7GpYYd+wXmVOucSEjsG4N9ZqI7kB9hboWCNyVPNbMqxNyqn4IyuHo+SH2i4uCvc0
         woOmzkzNoKVhQstA/wh7sRMIh50JUUnplhjXu7+VFW55mp0ieWSthFZGocDGZLW0EscU
         9fsohpxaeh272IAdzELRHmSJG52ifobzmQRgZJgwxTrnVb0W9oUeqmgpDw6lQdmAd5jm
         HGpscHn98rA2Bp2R+Spkf2vlZ8ELRTWYVifN+tTMB1ogHYVviomOnpKFoDPUdFQOQ7r3
         /1PA==
X-Gm-Message-State: AAQBX9f838o9bJ2xH/TBtNJnd8YxTACNvXuG7rL5umQwU6KGrF5BbTSo
        PAKPKScP1jy0AvQZiFkeQmAvpHgfbiv9VZTVdcHI6w==
X-Google-Smtp-Source: AKy350YsAJujj4dGNNM2q7kUEBukfDyhuL45Y7WH+KB99w1tnzhF55CijRm9KLRVaeOlRKsN/GoQyg==
X-Received: by 2002:a05:622a:1454:b0:3e8:69dd:c62d with SMTP id v20-20020a05622a145400b003e869ddc62dmr9669570qtx.57.1681939260307;
        Wed, 19 Apr 2023 14:21:00 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a404200b007468765b411sm4950333qko.45.2023.04.19.14.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:20:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/10] btrfs-progs: add btrfs_locking_nest to btrfs_alloc_tree_block
Date:   Wed, 19 Apr 2023 17:20:45 -0400
Message-Id: <f1ae58e279715442a595f71ead51f3b2beee0bde.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
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

This is how btrfs_alloc_tree_block is defined in the kernel, so when we
go to sync this code in it'll be easier if we're already setup to accept
this argument.  Since we're in progs we don't care about nesting so just
use BTRFS_NORMAL_NESTING everywhere, as we sync in the kernel code it'll
get updated to whatever is appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                |  2 +-
 cmds/rescue-chunk-recover.c |  2 +-
 kernel-shared/ctree.c       | 18 ++++++++++++------
 kernel-shared/ctree.h       |  4 +++-
 kernel-shared/disk-io.c     |  3 ++-
 kernel-shared/extent-tree.c |  3 ++-
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/check/main.c b/check/main.c
index c5131b7a..09805511 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9098,7 +9098,7 @@ static struct extent_buffer *btrfs_fsck_clear_root(
 
 	c = btrfs_alloc_tree_block(trans, gfs_info->tree_root,
 				   gfs_info->nodesize, key->objectid,
-				   &disk_key, 0, 0, 0);
+				   &disk_key, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	if (IS_ERR(c)) {
 		btrfs_free_path(path);
 		return c;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index b18d422e..52119d98 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1148,7 +1148,7 @@ static int __rebuild_chunk_root(struct btrfs_trans_handle *trans,
 
 	cow = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 				     BTRFS_CHUNK_TREE_OBJECTID,
-				     &disk_key, 0, 0, 0);
+				     &disk_key, 0, 0, 0, BTRFS_NESTING_NORMAL);
 	btrfs_set_header_bytenr(cow, cow->start);
 	btrfs_set_header_generation(cow, trans->transid);
 	btrfs_set_header_nritems(cow, 0);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 230dae1b..cad15093 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -169,7 +169,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		btrfs_node_key(buf, &disk_key, 0);
 	cow = btrfs_alloc_tree_block(trans, new_root, buf->len,
 				     new_root_objectid, &disk_key,
-				     level, buf->start, 0);
+				     level, buf->start, 0,
+				     BTRFS_NESTING_NORMAL);
 	if (IS_ERR(cow)) {
 		kfree(new_root);
 		return PTR_ERR(cow);
@@ -231,7 +232,8 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 	new_root->root_key.offset = 0;
 
 	node = btrfs_alloc_tree_block(trans, new_root, fs_info->nodesize,
-				      objectid, &disk_key, 0, 0, 0);
+				      objectid, &disk_key, 0, 0, 0,
+				      BTRFS_NESTING_NORMAL);
 	if (IS_ERR(node)) {
 		ret = PTR_ERR(node);
 		error("failed to create root node for tree %llu: %d (%m)",
@@ -463,7 +465,8 @@ int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	cow = btrfs_alloc_tree_block(trans, root, buf->len,
 				     root->root_key.objectid, &disk_key,
-				     level, search_start, empty_size);
+				     level, search_start, empty_size,
+				     BTRFS_NESTING_NORMAL);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -1734,7 +1737,8 @@ static int noinline insert_new_root(struct btrfs_trans_handle *trans,
 
 	c = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 				   root->root_key.objectid, &lower_key,
-				   level, root->node->start, 0);
+				   level, root->node->start, 0,
+				   BTRFS_NESTING_NORMAL);
 
 	if (IS_ERR(c))
 		return PTR_ERR(c);
@@ -1860,7 +1864,8 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	split = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 					root->root_key.objectid,
-					&disk_key, level, c->start, 0);
+					&disk_key, level, c->start, 0,
+					BTRFS_NESTING_NORMAL);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -2427,7 +2432,8 @@ again:
 
 	right = btrfs_alloc_tree_block(trans, root, root->fs_info->nodesize,
 					root->root_key.objectid,
-					&disk_key, 0, l->start, 0);
+					&disk_key, 0, l->start, 0,
+					BTRFS_NESTING_NORMAL);
 	if (IS_ERR(right)) {
 		BUG_ON(1);
 		return PTR_ERR(right);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index af60ba66..f416fc36 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -29,6 +29,7 @@
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "accessors.h"
 #include "extent-io-tree.h"
+#include "locking.h"
 
 struct btrfs_root;
 struct btrfs_trans_handle;
@@ -853,7 +854,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
 					u32 blocksize, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
-					u64 hint, u64 empty_size);
+					u64 hint, u64 empty_size,
+					enum btrfs_lock_nesting nest);
 int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6f9dc327..7ee45ad1 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2334,7 +2334,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	memcpy(&root->root_key, key, sizeof(struct btrfs_key));
 
 	leaf = btrfs_alloc_tree_block(trans, root, fs_info->nodesize,
-				      root->root_key.objectid, NULL, 0, 0, 0);
+				      root->root_key.objectid, NULL, 0, 0, 0,
+				      BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
 		leaf = NULL;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index d0b3aee3..916eb840 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2559,7 +2559,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
 					u32 blocksize, u64 root_objectid,
 					struct btrfs_disk_key *key, int level,
-					u64 hint, u64 empty_size)
+					u64 hint, u64 empty_size,
+					enum btrfs_lock_nesting nest)
 {
 	struct btrfs_key ins;
 	int ret;
-- 
2.40.0

