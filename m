Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479D324C277
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgHTPrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgHTPqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C77C061345
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so1899775qkd.6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e/Lrf1H9faNU/Js6INHvSe3DpHFjc2dqYfSi3HLD6pk=;
        b=vQ+aM5JOjgyFjgY5P94RlisrGmiaHwoTfydyJVeTX3sI/fj4tKSDfLGDtNulndMW9N
         TSMXeLJMsmIM+jU8/+3pUhjrSZOgQs6sC3Hygf25kgRl4xBerDJrjkiEx+B2Dadj5NvS
         DhMx8Dy0z13hc2ZfpdWclTwVA6HAXld4aiXIS2oZoD2nXALUUM68z8aKcyhkchnpsUIK
         lSVRuSPNpPDve3f1hibQPISrcyFB4MHTPMT9dCEajOs3aQPVslnkT5zUvmQT7NAo/ApJ
         KlqVDt/A6x74pXFjHxrbYr2BcX7WDOqnI7UZ2DhQG5DK4pPU6H6OhJkGtrjdwQra6HTq
         vXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/Lrf1H9faNU/Js6INHvSe3DpHFjc2dqYfSi3HLD6pk=;
        b=TWXmfxWMeCYZtbUL5I0a9WCJjzmeSzkgYhvvn0KFdAngk4pdmQNH/FOkLcsELW70WO
         VmmukZXugkf2jdWcs7l8/YyKV1Y5ENYezC8yGh+HIM0KqpICsmbRW2yDB+gih4UKgrnz
         FQ0HkkMI1aw/ZT/JOE1aRZzNMLbT16uzAN+d+DGO/oJkP8zDO5oRKd0x37SbF5KMSORd
         EqQ2Q/9Rwn7486ARdQYlSqIsAzAABa+NbNz+rdfr4rCqeQikupZXioECPuaO+UPWqcO2
         P/L1ldVgZQZ8tsJx4nSG++aRibHA09m0lUQtk38fxwhFWjD+F3terGUIrOiivfKk2X/l
         Bq5Q==
X-Gm-Message-State: AOAM5319mW963hHE410XF4E9N01gu6/0yvlaiwn/aLwNMkpGqNEwPC0e
        6Fah7+tvYgX3UhTfkr02KHAf835wP1xs0G/N
X-Google-Smtp-Source: ABdhPJzFc5lqlTgiQyHb8V5IDhNW76XUoxGSH43qipyZezBckBkSb+kohCpyb9Ece9QxVm37Rd8RQQ==
X-Received: by 2002:ae9:f504:: with SMTP id o4mr3249927qkg.40.1597938402087;
        Thu, 20 Aug 2020 08:46:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k55sm3513340qtf.17.2020.08.20.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/12] btrfs: rip out path->leave_spinning
Date:   Thu, 20 Aug 2020 11:46:11 -0400
Message-Id: <aebbeda31f3ecf2c3c3864df9ee880c7fc6dc6db.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We no longer distinguish between blocking and spinning, so rip out all
of this code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c            |  3 ---
 fs/btrfs/ctree.c              |  3 ---
 fs/btrfs/ctree.h              |  1 -
 fs/btrfs/delayed-inode.c      |  4 ----
 fs/btrfs/dir-item.c           |  1 -
 fs/btrfs/export.c             |  1 -
 fs/btrfs/extent-tree.c        |  8 --------
 fs/btrfs/extent_io.c          |  1 -
 fs/btrfs/file-item.c          |  4 ----
 fs/btrfs/free-space-tree.c    |  2 --
 fs/btrfs/inode-item.c         |  6 ------
 fs/btrfs/inode.c              | 12 ------------
 fs/btrfs/ioctl.c              |  1 -
 fs/btrfs/qgroup.c             |  2 --
 fs/btrfs/reflink.c            |  3 ---
 fs/btrfs/super.c              |  2 --
 fs/btrfs/tests/qgroup-tests.c |  4 ----
 17 files changed, 58 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 4410a6e2f8c6..79275e5e45d4 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1658,13 +1658,11 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 	s64 bytes_left = ((s64)size) - 1;
 	struct extent_buffer *eb = eb_in;
 	struct btrfs_key found_key;
-	int leave_spinning = path->leave_spinning;
 	struct btrfs_inode_ref *iref;
 
 	if (bytes_left >= 0)
 		dest[bytes_left] = '\0';
 
-	path->leave_spinning = 1;
 	while (1) {
 		bytes_left -= name_len;
 		if (bytes_left >= 0)
@@ -1708,7 +1706,6 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 	}
 
 	btrfs_release_path(path);
-	path->leave_spinning = leave_spinning;
 
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 08e6cc8bd4c1..62a252448f7d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5237,7 +5237,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	struct btrfs_key key;
 	u32 nritems;
 	int ret;
-	int old_spinning = path->leave_spinning;
 	int next_rw_lock = 0;
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
@@ -5252,7 +5251,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_release_path(path);
 
 	path->keep_locks = 1;
-	path->leave_spinning = 1;
 
 	if (time_seq)
 		ret = btrfs_search_old_slot(root, &key, path, time_seq);
@@ -5387,7 +5385,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	ret = 0;
 done:
 	unlock_up(path, 0, 1, 0, NULL);
-	path->leave_spinning = old_spinning;
 
 	return ret;
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 86a620d1c3f7..7300a72f64f8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -370,7 +370,6 @@ struct btrfs_path {
 	unsigned int search_for_split:1;
 	unsigned int keep_locks:1;
 	unsigned int skip_locking:1;
-	unsigned int leave_spinning:1;
 	unsigned int search_commit_root:1;
 	unsigned int need_commit_sem:1;
 	unsigned int skip_release_on_error:1;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index b00b7ed47fc0..1f00daa8671b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1149,7 +1149,6 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->leave_spinning = 1;
 
 	block_rsv = trans->block_rsv;
 	trans->block_rsv = &fs_info->delayed_block_rsv;
@@ -1214,7 +1213,6 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 		btrfs_release_delayed_node(delayed_node);
 		return -ENOMEM;
 	}
-	path->leave_spinning = 1;
 
 	block_rsv = trans->block_rsv;
 	trans->block_rsv = &delayed_node->root->fs_info->delayed_block_rsv;
@@ -1259,7 +1257,6 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 		ret = -ENOMEM;
 		goto trans_out;
 	}
-	path->leave_spinning = 1;
 
 	block_rsv = trans->block_rsv;
 	trans->block_rsv = &fs_info->delayed_block_rsv;
@@ -1328,7 +1325,6 @@ static void btrfs_async_run_delayed_root(struct btrfs_work *work)
 		if (!delayed_node)
 			break;
 
-		path->leave_spinning = 1;
 		root = delayed_node->root;
 
 		trans = btrfs_join_transaction(root);
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 863367c2c620..98b63ebed539 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -127,7 +127,6 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->leave_spinning = 1;
 
 	btrfs_cpu_key_to_disk(&disk_key, location);
 
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 1a8d419d9e1f..1d4c2397d0d6 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -222,7 +222,6 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->leave_spinning = 1;
 
 	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
 		key.objectid = BTRFS_I(inode)->root->root_key.objectid;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fed2369a583f..bc2895add001 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1448,7 +1448,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	/* this will setup the path even if it fails to insert the back ref */
 	ret = insert_inline_extent_backref(trans, path, bytenr, num_bytes,
 					   parent, root_objectid, owner,
@@ -1472,7 +1471,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	path->leave_spinning = 1;
 	/* now insert the actual backref */
 	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
 		BUG_ON(refs_to_add != 1);
@@ -1588,7 +1586,6 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	}
 
 again:
-	path->leave_spinning = 1;
 	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 1);
 	if (ret < 0) {
 		err = ret;
@@ -2959,8 +2956,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
-
 	is_data = owner_objectid >= BTRFS_FIRST_FREE_OBJECTID;
 	BUG_ON(!is_data && refs_to_drop != 1);
 
@@ -3002,7 +2997,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 			btrfs_release_path(path);
-			path->leave_spinning = 1;
 
 			key.objectid = bytenr;
 			key.type = BTRFS_EXTENT_ITEM_KEY;
@@ -4292,7 +4286,6 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(trans, fs_info->extent_root, path,
 				      ins, size);
 	if (ret) {
@@ -4377,7 +4370,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(trans, fs_info->extent_root, path,
 				      &extent_key, size);
 	if (ret) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bd0c7e728ca2..db0f1d73be56 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4727,7 +4727,6 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->leave_spinning = 1;
 
 	roots = ulist_alloc(GFP_KERNEL);
 	tmp_ulist = ulist_alloc(GFP_KERNEL);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7d5ec71615b8..e2eb1037220e 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -142,7 +142,6 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 	file_key.offset = pos;
 	file_key.type = BTRFS_EXTENT_DATA_KEY;
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(trans, root, path, &file_key,
 				      sizeof(*item));
 	if (ret < 0)
@@ -706,7 +705,6 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		key.offset = end_byte - 1;
 		key.type = BTRFS_EXTENT_CSUM_KEY;
 
-		path->leave_spinning = 1;
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret > 0) {
 			if (path->slots[0] == 0)
@@ -991,10 +989,8 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	} else {
 		ins_size = csum_size;
 	}
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(trans, root, path, &file_key,
 				      ins_size);
-	path->leave_spinning = 0;
 	if (ret < 0)
 		goto out;
 	if (WARN_ON(ret != 0))
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 8b1f5c8897b7..752891e0d1bb 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1191,8 +1191,6 @@ static int clear_free_space_tree(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
-
 	key.objectid = 0;
 	key.type = 0;
 	key.offset = 0;
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 668701832845..37f36ffdaf6b 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -119,8 +119,6 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
-
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0)
 		ret = -ENOENT;
@@ -193,8 +191,6 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
-
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0) {
 		ret = -ENOENT;
@@ -270,7 +266,6 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      ins_len);
 	if (ret == -EEXIST) {
@@ -327,7 +322,6 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	path->skip_release_on_error = 1;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      ins_len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 68548164dc34..8598c543cce0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -197,7 +197,6 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
-		path->leave_spinning = 1;
 		ret = btrfs_insert_empty_item(trans, root, path, &key,
 					      datasize);
 		if (ret)
@@ -2499,7 +2498,6 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ins.offset = file_pos;
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
-		path->leave_spinning = 1;
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
 					      sizeof(*stack_fi));
 		if (ret)
@@ -3481,7 +3479,6 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	ret = btrfs_lookup_inode(trans, root, path, &BTRFS_I(inode)->location,
 				 1);
 	if (ret) {
@@ -3570,7 +3567,6 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	path->leave_spinning = 1;
 	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
 				    name, name_len, -1);
 	if (IS_ERR_OR_NULL(di)) {
@@ -6026,7 +6022,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_items(trans, root, path, key, sizes, nitems);
 	if (ret != 0)
 		goto fail_unlock;
@@ -6585,13 +6580,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	/* Chances are we'll be called again, so go ahead and do readahead */
 	path->reada = READA_FORWARD;
-
-	/*
-	 * Unless we're going to uncompress the inline extent, no sleep would
-	 * happen.
-	 */
-	path->leave_spinning = 1;
-
 	path->recurse = btrfs_is_free_space_inode(inode);
 
 	ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f4d0d6c27f3c..80e155396328 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3382,7 +3382,6 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		ret = -ENOMEM;
 		goto out_free;
 	}
-	path->leave_spinning = 1;
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f8e83be739d0..a15a5932a8ac 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -893,8 +893,6 @@ static int btrfs_clean_quota_tree(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
-
 	key.objectid = 0;
 	key.offset = 0;
 	key.type = 0;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 5cd02514cf4d..fa640bb107f9 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -347,7 +347,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		u64 drop_start;
 
 		/* Note the key will change type as we walk through the tree */
-		path->leave_spinning = 1;
 		ret = btrfs_search_slot(NULL, BTRFS_I(src)->root, &key, path,
 				0, 0);
 		if (ret < 0)
@@ -417,7 +416,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 				   size);
 
 		btrfs_release_path(path);
-		path->leave_spinning = 0;
 
 		memcpy(&new_key, &key, sizeof(new_key));
 		new_key.objectid = btrfs_ino(BTRFS_I(inode));
@@ -531,7 +529,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		 * mixing buffered and direct IO writes against this file.
 		 */
 		btrfs_release_path(path);
-		path->leave_spinning = 0;
 
 		ret = btrfs_punch_hole_range(inode, path, last_dest_end,
 				destoff + len - 1, NULL, &trans);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3ebe7240c63d..0ff7072e5bd8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1127,7 +1127,6 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto err;
 	}
-	path->leave_spinning = 1;
 
 	name = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!name) {
@@ -1256,7 +1255,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	path->leave_spinning = 1;
 
 	/*
 	 * Find the "default" dir item which points to the root item that we
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index ce1ca8e73c2d..f3137285a9e2 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -36,7 +36,6 @@ static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
 		return -ENOMEM;
 	}
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_item(&trans, root, path, &ins, size);
 	if (ret) {
 		test_err("couldn't insert ref %d", ret);
@@ -86,7 +85,6 @@ static int add_tree_ref(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
 		return -ENOMEM;
 	}
 
-	path->leave_spinning = 1;
 	ret = btrfs_search_slot(&trans, root, &key, path, 0, 1);
 	if (ret) {
 		test_err("couldn't find extent ref");
@@ -135,7 +133,6 @@ static int remove_extent_item(struct btrfs_root *root, u64 bytenr,
 		test_std_err(TEST_ALLOC_ROOT);
 		return -ENOMEM;
 	}
-	path->leave_spinning = 1;
 
 	ret = btrfs_search_slot(&trans, root, &key, path, -1, 1);
 	if (ret) {
@@ -170,7 +167,6 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 		return -ENOMEM;
 	}
 
-	path->leave_spinning = 1;
 	ret = btrfs_search_slot(&trans, root, &key, path, 0, 1);
 	if (ret) {
 		test_err("couldn't find extent ref");
-- 
2.24.1

