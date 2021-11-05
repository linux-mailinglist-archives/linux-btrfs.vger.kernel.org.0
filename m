Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3936446A0B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhKEUtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbhKEUtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B31C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h17so6000312qtx.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qYJ7yyPyl8XAKXikqQkBbgcBgxjvYHqTcLvaieX/Mno=;
        b=YJ2ib8xL1GaYReWbl2D9w3K7MA/eBa5N66r4ifKPklaimGU/trWu+1vpigZSVv1a8l
         5IhYwsmBWet0x78WkYFN4x9Z+iqps4ZtOn+GRi2ZbG30sYR6ByX1C7302oNAqD6Mx54i
         AzvmgGc3dZ+tpjx+Ir9bTptc75E2JvXPmxLymSucY1k2/2NX+cLNw4r1jofKuljlKk8I
         LivQpF0Dyd+hr82fHDXAXCtNukXIU6Ns9xeImY1kdQ1VxCbUKFzpltIJe9xCbwi68LeW
         V93oVDi3k2QlGVFZnfdrxLfOok1AgDnLJ2FNlbrzR+o0yUz3xnLBtfZSXDjfgkZElsen
         2P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYJ7yyPyl8XAKXikqQkBbgcBgxjvYHqTcLvaieX/Mno=;
        b=3e2zuRHb/m1K/KosezXyDccBPe8zRfF5LJtTesXX7DAkFETpsIBNz926L1IT6ynIsO
         BFA6nfQjW2Tqp8AWvp3B/aghw1ijX/0qdSl3uDG5vySLyiDEklzSJ1Bdr3TfIkpucvy0
         sEkq7tHV1aoYzCb3h6UKrnTDWFnfEwtOyqNhspm5V3cJhnSu9MXKSNcdA40cZeJ8HYS/
         8d8p4plVUlT2I1ucyRAr7mInTACzm9Q7iogZWVj+rWE89zDvvOqoY+FGRino3sBtsTmL
         h3aHR8JBZ3AeVxp9J8TCCjxbHe+G+ap7iHdwtc+KkCDU4GHKWxxh8km/Vv/6lr0ZBurq
         OSYA==
X-Gm-Message-State: AOAM531aa1crRT31hDKrMr4BJKo+PCFHKE2wQ84niqwgjDJcfDHH7iZ/
        LQ9hIKXChgQn7vLKjMCNskvbJpSAUmx4Gw==
X-Google-Smtp-Source: ABdhPJwoML+4xuMnf3g88pM/RHB7KW92YmaDjXWjiA1/+EW8KDdWKz+zOOmIuls56cB1fVcWUaht4A==
X-Received: by 2002:ac8:1e0b:: with SMTP id n11mr62837762qtl.274.1636145184956;
        Fri, 05 Nov 2021 13:46:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d129sm5770034qkf.136.2021.11.05.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/25] btrfs: stop accessing ->free_space_root directly
Date:   Fri,  5 Nov 2021 16:45:49 -0400
Message-Id: <ec1e0d8d0a25780c50da8b99d1eb7e9baac0bebd.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to have multiple free space roots in the future, so adjust
all the users of the free space root to use a helper to access the root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                       |  2 +-
 fs/btrfs/disk-io.c                     | 10 ++++----
 fs/btrfs/free-space-tree.c             | 32 +++++++++++++++-----------
 fs/btrfs/tests/free-space-tree-tests.c |  2 +-
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c8bd1abc7b89..773a45470610 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -631,7 +631,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *_csum_root;
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
-	struct btrfs_root *free_space_root;
+	struct btrfs_root *_free_space_root;
 	struct btrfs_root *data_reloc_root;
 
 	/* the log root tree is a directory of all the other log roots */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b8a92bb6081d..b0efc9ca9eaa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1571,8 +1571,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 		return btrfs_grab_root(fs_info->uuid_root) ?
 			fs_info->uuid_root : ERR_PTR(-ENOENT);
 	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->free_space_root) ?
-			fs_info->free_space_root : ERR_PTR(-ENOENT);
+		return btrfs_grab_root(fs_info->_free_space_root) ?
+			fs_info->_free_space_root : ERR_PTR(-ENOENT);
 	return NULL;
 }
 
@@ -1637,7 +1637,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->_csum_root);
 	btrfs_put_root(fs_info->quota_root);
 	btrfs_put_root(fs_info->uuid_root);
-	btrfs_put_root(fs_info->free_space_root);
+	btrfs_put_root(fs_info->_free_space_root);
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_check_leaked_roots(fs_info);
@@ -2168,7 +2168,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->data_reloc_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
-	free_root_extent_buffers(info->free_space_root);
+	free_root_extent_buffers(info->_free_space_root);
 }
 
 void btrfs_put_root(struct btrfs_root *root)
@@ -2535,7 +2535,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 			}
 		}  else {
 			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-			fs_info->free_space_root = root;
+			fs_info->_free_space_root = root;
 		}
 	}
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 968c79d86d72..c0f0ba66b5ae 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -16,6 +16,12 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
 					struct btrfs_path *path);
 
+static struct btrfs_root *btrfs_free_space_root(
+				struct btrfs_block_group *block_group)
+{
+	return block_group->fs_info->_free_space_root;
+}
+
 void set_free_space_tree_thresholds(struct btrfs_block_group *cache)
 {
 	u32 bitmap_range;
@@ -51,7 +57,7 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *block_group,
 				   struct btrfs_path *path)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_free_space_info *info;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
@@ -85,7 +91,7 @@ struct btrfs_free_space_info *search_free_space_info(
 		struct btrfs_path *path, int cow)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_key key;
 	int ret;
 
@@ -188,7 +194,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 				  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_free_space_info *info;
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
@@ -326,7 +332,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_free_space_info *info;
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
@@ -586,7 +592,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 				    struct btrfs_path *path,
 				    u64 start, u64 size, int remove)
 {
-	struct btrfs_root *root = block_group->fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_key key;
 	u64 end = start + size;
 	u64 cur_start, cur_size;
@@ -699,7 +705,7 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 				    struct btrfs_path *path,
 				    u64 start, u64 size)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_key key;
 	u64 found_start, found_end;
 	u64 end = start + size;
@@ -851,7 +857,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 u64 start, u64 size)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_key key, new_key;
 	u64 found_start, found_end;
 	u64 end = start + size;
@@ -1158,7 +1164,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		ret = PTR_ERR(free_space_root);
 		goto abort;
 	}
-	fs_info->free_space_root = free_space_root;
+	fs_info->_free_space_root = free_space_root;
 
 	node = rb_first(&fs_info->block_group_cache_tree);
 	while (node) {
@@ -1233,7 +1239,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_root *free_space_root = fs_info->free_space_root;
+	struct btrfs_root *free_space_root = fs_info->_free_space_root;
 	int ret;
 
 	trans = btrfs_start_transaction(tree_root, 0);
@@ -1242,7 +1248,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 
 	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE);
 	btrfs_clear_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
-	fs_info->free_space_root = NULL;
+	fs_info->_free_space_root = NULL;
 
 	ret = clear_free_space_tree(trans, free_space_root);
 	if (ret)
@@ -1320,7 +1326,7 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 				  struct btrfs_block_group *block_group)
 {
-	struct btrfs_root *root = trans->fs_info->free_space_root;
+	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_path *path;
 	struct btrfs_key key, found_key;
 	struct extent_buffer *leaf;
@@ -1411,7 +1417,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 
 	block_group = caching_ctl->block_group;
 	fs_info = block_group->fs_info;
-	root = fs_info->free_space_root;
+	root = btrfs_free_space_root(block_group);
 
 	end = block_group->start + block_group->length;
 
@@ -1489,7 +1495,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 
 	block_group = caching_ctl->block_group;
 	fs_info = block_group->fs_info;
-	root = fs_info->free_space_root;
+	root = btrfs_free_space_root(block_group);
 
 	end = block_group->start + block_group->length;
 
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 2c783d2f5228..7d6de8b53038 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -446,7 +446,7 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 
 	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
 					BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
-	root->fs_info->free_space_root = root;
+	root->fs_info->_free_space_root = root;
 	root->fs_info->tree_root = root;
 
 	root->node = alloc_test_extent_buffer(root->fs_info, nodesize);
-- 
2.26.3

