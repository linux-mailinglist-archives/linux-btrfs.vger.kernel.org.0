Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F745240AAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHJPnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgHJPnU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A7C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so8729582qkk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k08b7xrwKN7zptrsA0Iv3Wn1ke/0OAqcbzz2WIOT8UQ=;
        b=Zdo679EKnSjMHrfSfkpYm/aOHv9pWYH60yxKWCmc7A6kQu+2f+NJtma/VJ2226AW70
         3Clyc7DVKnH3d9VVuwkKtDZJPgg+XcW6axH48Z3bHzr4nWEVP0yBNc0lpxmAAyQ4fCqj
         2+Y3gQNuvMDa3eRG3bSe6e/vEQdzyN1yDdh8+KeWnb1BpVvjeJAyqBvmLBXFKbahY/vo
         8dvLf3AkQm2LY39yvIqSx5g1VeMIF4Ho72ZIRJtP9fWdGIM+AWCiEq2J91SmaZsp7KSk
         KAA8j1tI0WwDwlDkdtmLkGvTFURV9EHK0iV0Uyc54ZJ+ew2iM8G4w6F3Uj9X14Etk27Z
         AIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k08b7xrwKN7zptrsA0Iv3Wn1ke/0OAqcbzz2WIOT8UQ=;
        b=Sults4qmVg3YWwrZsFD9FiXLrkCXYISdh0FbdP4yqtNXdWY2/Y9AMYnq2UWjKqrpkr
         3gku3tpkcux4abujODx/1vVPmVPgL+OVYYkVChey/JunRsz1T4arrF1AGEekucVdmEfi
         IiiXDiAzNM5UCnzsCuSMqIhs6OzW1x8EZrrYZioGJSd1icrQ7FtkUE3F50ZFiFga6oHc
         6iPbh8f8weJv9iYK6oLrjn+p76/4JwoNMAYg5haCHg44blSkrz/6oiDaNSMnx8609z/L
         ZSvxrt+KqSL33LNc5dFsca9jm/L6a7bQX7yI1TV2jkPArZDWOoONf52FdYLlFhLLYLKY
         GSUA==
X-Gm-Message-State: AOAM5335JL6WDPQnmfb7H168PnPmX5ASqXN1q82VPtiIGlKMFEgfLBQm
        4f3Q+OHRRHlTpqNGOUSdz1fLz2YXuaE6OQ==
X-Google-Smtp-Source: ABdhPJxWkIvbptKkFTqBVIjSSItv7lMtTR5RH59K014d8/kAbJX4Y7uxZ953MjKG65FzIL9EUDDwUA==
X-Received: by 2002:a37:a6c6:: with SMTP id p189mr25850352qke.386.1597074199144;
        Mon, 10 Aug 2020 08:43:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o13sm14876938qko.48.2020.08.10.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/17] btrfs: rip out path->leave_spinning
Date:   Mon, 10 Aug 2020 11:42:42 -0400
Message-Id: <20200810154242.782802-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
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
index 5b994d4377d6..9635c9368b39 100644
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
index 45215eaee492..3481de544d29 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5227,7 +5227,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	struct btrfs_key key;
 	u32 nritems;
 	int ret;
-	int old_spinning = path->leave_spinning;
 	int next_rw_lock = 0;
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
@@ -5242,7 +5241,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_release_path(path);
 
 	path->keep_locks = 1;
-	path->leave_spinning = 1;
 
 	if (time_seq)
 		ret = btrfs_search_old_slot(root, &key, path, time_seq);
@@ -5377,7 +5375,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	ret = 0;
 done:
 	unlock_up(path, 0, 1, 0, NULL);
-	path->leave_spinning = old_spinning;
 
 	return ret;
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ceecccce6133..0e797ac2e2d6 100644
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
index 548ee1742987..c95799af95f1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1447,7 +1447,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	/* this will setup the path even if it fails to insert the back ref */
 	ret = insert_inline_extent_backref(trans, path, bytenr, num_bytes,
 					   parent, root_objectid, owner,
@@ -1471,7 +1470,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	path->leave_spinning = 1;
 	/* now insert the actual backref */
 	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
 		BUG_ON(refs_to_add != 1);
@@ -1587,7 +1585,6 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
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
index ab44e696c249..9a2dbae195cd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4725,7 +4725,6 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
index ca242de7cb69..c51c3faaf962 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -196,7 +196,6 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
-		path->leave_spinning = 1;
 		ret = btrfs_insert_empty_item(trans, root, path, &key,
 					      datasize);
 		if (ret)
@@ -2498,7 +2497,6 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 		ins.offset = file_pos;
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
-		path->leave_spinning = 1;
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
 					      sizeof(*stack_fi));
 		if (ret)
@@ -3480,7 +3478,6 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	path->leave_spinning = 1;
 	ret = btrfs_lookup_inode(trans, root, path, &BTRFS_I(inode)->location,
 				 1);
 	if (ret) {
@@ -3569,7 +3566,6 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	path->leave_spinning = 1;
 	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
 				    name, name_len, -1);
 	if (IS_ERR_OR_NULL(di)) {
@@ -6025,7 +6021,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_items(trans, root, path, key, sizes, nitems);
 	if (ret != 0)
 		goto fail_unlock;
@@ -6584,13 +6579,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
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
index c0d4ab44361d..d2a8326fb096 100644
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
index 0c19d12fb20d..0e24990b6140 100644
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
index 53639de3a064..99fbc25f667b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1126,7 +1126,6 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto err;
 	}
-	path->leave_spinning = 1;
 
 	name = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!name) {
@@ -1255,7 +1254,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
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

