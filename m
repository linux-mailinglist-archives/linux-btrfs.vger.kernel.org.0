Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10302638A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 23:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIVq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 17:46:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36821 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIVqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 17:46:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 83C075C00C3;
        Wed,  9 Sep 2020 17:46:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Sep 2020 17:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=cnlJ2VxE4B6YB
        WmbLpR870YtmpcEbP0BGQeWJakwIVs=; b=mSD18XV9Jtn2VBZsnrN6AzsARDRk/
        sMY4KAJ2NIa3POyn8ihjRu6J8htSs72V4+nD1aRbsjZ7gsckDAXTm/KcGL1l2XwX
        czCKQBAYwUJwVWKpuJpvuAMggG5Psf33yNT37ZUOBSpa4bVLEYCSrGsdYYuOVrQJ
        YPziZCg5gnZ+7DCarZ17RmHL9/2XA42bh5ZGarmBldE26KYZUBqF8RAEiumeOuA8
        M+BxMzA3faOAzzwiX86eq0I0uAOvXiElk1T4V0678PPXqBtxl10ykkuRb7mAP74l
        giFQmraZGDx0GAlC0nChxPqVRoAuBrk2sxM409vL2OQ2QaTcu1Ad3Un/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cnlJ2VxE4B6YBWmbLpR870YtmpcEbP0BGQeWJakwIVs=; b=T+Kxz//y
        NriALSEKc6JlI2/XstqeBbd1Y6HrXgKxlyxbzkEzK4W2HcyTGMe1gws/XkrRvoW4
        RndXWZ17/vJ8pPdDKnSVm6e7op4cUXlyS8X55jR7Ol3rYaAPCj9mCyPM0bxm/RTV
        HbW6TNFN/aZZTysaFIB60gi3xYVe29j7kFCVZSjtXKg1oONNtdMF8/081tyt42+a
        IZBcCz0jXoz5NUb2zMpDkc63Jp+J4MDHiBIDulM9jR72h0W3NB2bSgerrdVJprKt
        +/j9EHpbgp6PfbI4NIPoYxIN9Km1ZkZsdd935cA/txRUX3Nlg+aiD7zCnZ9zXycT
        qmwbujdCx+YamQ==
X-ME-Sender: <xms:TU1ZX2HIJEbnAMErQpWqPU37NRvk3OnBvtTWl8UtBzjMLlobgdFjHA>
    <xme:TU1ZX3WTEgkyy62W5UaL-Q_poBb-9AUzSkavDy4vkP07p8QvKpvHVL1ioKHPaU4f-
    jAXbeisACuINB41TMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepte
    ehhedugfellefhheffteettdefledvgffhleekfeeggfdvveegffefvddtfeegnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucfkphepudeifedruddugedrudefvddrfeenuc
    evlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhs
    segsuhhrrdhioh
X-ME-Proxy: <xmx:TU1ZXwI_oOpOybomt0o_dpf40Vl3--hQyWVB1rVcJEUw5Oy9Z9mMJw>
    <xmx:TU1ZXwEMkvU7XZ_TJMnMjOa8zNDpGZ669bxRpsQqAAYtlzYcF9rxkA>
    <xmx:TU1ZX8XGJ_EDwtmQAp4bUgFPJscxm6r9F3uH9Trro9j8Xg-ozuwViw>
    <xmx:TU1ZXzTVWaSXW6ekoIWCJTmI0AJUY3NDKazBi2qGxixexoyGe2sU-w>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE9093280060;
        Wed,  9 Sep 2020 17:46:52 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Dave Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: remove free space items when creating free space tree
Date:   Wed,  9 Sep 2020 14:45:17 -0700
Message-Id: <ca7009f0e52c804f85e96f75b54a408a2de8b260.1599686801.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599686801.git.boris@bur.io>
References: <cover.1599686801.git.boris@bur.io>
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

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
v2:
- remove_free_space_inode -> btrfs_remove_free_space_inode
- undo sinful whitespace change

 fs/btrfs/block-group.c      | 39 ++----------------------------
 fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/free-space-tree.c  |  3 +++
 4 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 01e8ba1da1d3..e5e5baad88d8 100644
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
+	ret = btrfs_remove_free_space_inode(trans, block_group);
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
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8759f5a1d6a0..da6d436c58fa 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -207,6 +207,54 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
 					 ino, block_group->start);
 }
 
+int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
+				  struct btrfs_block_group *block_group)
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
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..606eca93e43f 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -84,6 +84,8 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 int create_free_space_inode(struct btrfs_trans_handle *trans,
 			    struct btrfs_block_group *block_group,
 			    struct btrfs_path *path);
+int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
+				  struct btrfs_block_group *block_group);
 
 int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv);
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6b9faf3b0e96..7b6be89c1862 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1165,6 +1165,9 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
 		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		ret = btrfs_remove_free_space_inode(trans, block_group);
 		if (ret)
 			goto abort;
 		node = rb_next(node);
-- 
2.24.1

