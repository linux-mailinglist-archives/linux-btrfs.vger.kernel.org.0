Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA31A25CA9B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 22:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgICUeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 16:34:12 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41951 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbgICUdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 941A5B7D;
        Thu,  3 Sep 2020 16:33:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 16:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=HagPjOACRN0ZR
        AjXKjqa97WiriWA6vKYdQzDQ3X7Xwo=; b=tJd9EOncj2NkZDUJAaT7/GbwHeuYm
        4g3sJgvU0isQ2PI54lbxyjRe/nCcW2cdYTuID5cY9kInSqoD/xdZB+zlZKNrzHqf
        WoGBfLImm1HZQUgE04jpWBCmta1LQA/iLKzJPLMf3J+Y96BMOcQYZTmggjn+Cjc6
        IMs4SNDCu2HBhAoEmA4S+ceGhaU/80tHoA6ho6bw5nUNPiPuMMGugNKSwiGkUubt
        HqMf8sb1LrMQg91kYdcdaZwCyAYwojMvy6AgXuJmnvaE2Pzr8AesM7jK2RBV9N66
        xZDXCgZKWZ4aHQtdWtb9yiFY06QUL8wTufsLwHZ/gCyul863evkyzOL7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HagPjOACRN0ZRAjXKjqa97WiriWA6vKYdQzDQ3X7Xwo=; b=Eq8JZrnC
        ExuYj0dQzaVUIo5sTL4tcUK9s+RmtmV2kTLwn8x9uu47gB69kjyPyrFWMdUpUa7m
        IlRTYrOsH6rbHs58iMr9WjN2HqnU7zQMGWXK9wWX695s/BXV5qqKcP9ldPJaDF+z
        KTuqCv9+C6GVrS9F3ZlxP966AUgfRnSq0Yj2qwyruFvMT9RvlEeCXf2yVFoUovPn
        7sECGix1D4n84dz7UJN+TPZeBOtq+HYIaOimnVXxIRiJrvs+xPQsFWyTLfmGej2u
        qaVGvVkXFS2Zwb/8U2khkPZZFRBSjdqbsYvGNNbwh4UUwryBNW+8rx78b+p6C24o
        tfhMdwSiGKE1ww==
X-ME-Sender: <xms:JFNRX7q1etzdOcbXUY9WaX5f6O0Yr_qhYROlU6jQcyCnp7GnPNHgcg>
    <xme:JFNRX1qY8jqn1xcSXQCzOqwGeEm6IbQ37sIc0AFlpP5KzpS6YhVZiqX0lkWOmTOWt
    b_dkKc54-oVkJz7d2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    etheehudfgleelhfehffettedtfeelvdfghfelkeefgefgvdevgefffedvtdefgeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduieefrdduudegrddufedvrdefne
    cuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhi
    shessghurhdrihho
X-ME-Proxy: <xmx:JVNRX4MShIQ-sfseTPCmQrghuskVm8rTiy3aerkH7AIoS9LcNKK5IA>
    <xmx:JVNRX-7_hATESWXfjFFOaUqIu_DsVpZ_nA5NkHNL2tOgpPFqI4ifEw>
    <xmx:JVNRX66QPPpPxZyJwz_R2yT89FE7LGGdpltQYpJWl8iOM0k-fYiCPg>
    <xmx:JVNRXwnVTF7JdwPfYKNngOeuhdgEdRjtrVI4xng5euAjWYddP-x1LQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8DBA5328005E;
        Thu,  3 Sep 2020 16:33:40 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: remove free space items when creating free space tree
Date:   Thu,  3 Sep 2020 13:33:09 -0700
Message-Id: <c52c3edb5927356a33a3aa7af2adea69f7361576.1599164377.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599164377.git.boris@bur.io>
References: <cover.1599164377.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the file system transitions from space cache v1 to v2 it removes
the old cached data, but does not remove the FREE_SPACE items nor the
free space inodes they point to. This doesn't cause any issues besides
being a bit inefficient, since these items no longer do anything useful.

To fix it, as part of populating the free space tree, destroy each block
group's free space item and free space inode. This code is lifted from
the existing code for removing them when removing the block group.

Furthermore, cache_save_setup is called unconditionally from transaction
commit on dirty block groups, so we must also stop creating these items
when we are not using SPACE_CACHE.

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c      | 42 ++++---------------------------
 fs/btrfs/free-space-cache.c | 49 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/free-space-tree.c  |  3 +++
 4 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 01e8ba1da1d3..d9cda5696649 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -892,8 +892,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_block_group *block_group;
 	struct btrfs_free_cluster *cluster;
-	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_key key;
 	struct inode *inode;
 	struct kobject *kobj = NULL;
 	int ret;
@@ -971,42 +969,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	spin_unlock(&trans->transaction->dirty_bgs_lock);
 	mutex_unlock(&trans->transaction->cache_write_mutex);
 
-	if (!IS_ERR(inode)) {
-		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
-		if (ret) {
-			btrfs_add_delayed_iput(inode);
-			goto out;
-		}
-		clear_nlink(inode);
-		/* One for the block groups ref */
-		spin_lock(&block_group->lock);
-		if (block_group->iref) {
-			block_group->iref = 0;
-			block_group->inode = NULL;
-			spin_unlock(&block_group->lock);
-			iput(inode);
-		} else {
-			spin_unlock(&block_group->lock);
-		}
-		/* One for our lookup ref */
-		btrfs_add_delayed_iput(inode);
-	}
-
-	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
-	key.type = 0;
-	key.offset = block_group->start;
-
-	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
-	if (ret < 0)
+	ret = remove_free_space_inode(trans, block_group);
+	if (ret)
 		goto out;
-	if (ret > 0)
-		btrfs_release_path(path);
-	if (ret == 0) {
-		ret = btrfs_del_item(trans, tree_root, path);
-		if (ret)
-			goto out;
-		btrfs_release_path(path);
-	}
 
 	spin_lock(&fs_info->block_group_cache_lock);
 	rb_erase(&block_group->cache_node,
@@ -2343,6 +2308,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	int retries = 0;
 	int ret = 0;
 
+	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
+		return 0;
+
 	/*
 	 * If this block group is smaller than 100 megs don't bother caching the
 	 * block group.
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8759f5a1d6a0..52612d99a842 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -207,6 +207,54 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
 					 ino, block_group->start);
 }
 
+int remove_free_space_inode(struct btrfs_trans_handle *trans,
+			    struct btrfs_block_group *block_group)
+{
+	struct btrfs_path *path;
+	struct inode *inode;
+	struct btrfs_key key;
+	int ret = 0;
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	inode = lookup_free_space_inode(block_group, path);
+	if (IS_ERR(inode)) {
+		if (PTR_ERR(inode) != -ENOENT)
+			ret = PTR_ERR(inode);
+		goto out;
+	}
+	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+	if (ret) {
+		btrfs_add_delayed_iput(inode);
+		goto out;
+	}
+	clear_nlink(inode);
+	/* One for the block groups ref */
+	spin_lock(&block_group->lock);
+	if (block_group->iref) {
+		block_group->iref = 0;
+		block_group->inode = NULL;
+		spin_unlock(&block_group->lock);
+		iput(inode);
+	} else {
+		spin_unlock(&block_group->lock);
+	}
+	/* One for our lookup ref */
+	btrfs_add_delayed_iput(inode);
+
+	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
+	key.type = 0;
+	key.offset = block_group->start;
+	ret = btrfs_search_slot(trans, trans->fs_info->tree_root, &key, path, -1, 1);
+	if (ret != 0)
+		goto out;
+	ret = btrfs_del_item(trans, trans->fs_info->tree_root, path);
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv)
 {
@@ -2806,7 +2854,6 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 	__btrfs_remove_free_space_cache_locked(ctl);
 	btrfs_discard_update_discardable(block_group, ctl);
 	spin_unlock(&ctl->tree_lock);
-
 }
 
 /**
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..f75302efc025 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -84,6 +84,8 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 int create_free_space_inode(struct btrfs_trans_handle *trans,
 			    struct btrfs_block_group *block_group,
 			    struct btrfs_path *path);
+int remove_free_space_inode(struct btrfs_trans_handle *trans,
+			    struct btrfs_block_group *block_group);
 
 int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6b9faf3b0e96..30943d585854 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1165,6 +1165,9 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
 		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		ret = remove_free_space_inode(trans, block_group);
 		if (ret)
 			goto abort;
 		node = rb_next(node);
-- 
2.24.1

