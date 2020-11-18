Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115172B8824
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKRXG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:06:59 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52779 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbgKRXG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:06:57 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 4861DCCF;
        Wed, 18 Nov 2020 18:07:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Nov 2020 18:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=1o6QIIFowAbaK9KlSPMxqGQ6al
        F6w8UAzLsxKO7iqNE=; b=eTrimpn+bsKEsbCo7fpGqpUXUNjbcCWRdvLqMqrkAu
        eCi5zhNdQfj+2qFE/qQpSmFOEJ9tnJ1PO5Wm9CHVqthDejsWWHPCR2lst6SbJnUs
        Bbd47h6wIv2C15joqub29HM3RVNmMqqvJPf/lw6UcfB2CteBB9gNONpZisVv7nKZ
        wzkaOYhSxyZXiigtyzAK7wyXzpyReLUPCj5hxurlUZJN8wM+ODGUZ0JmA+BND8CT
        9l30pz0B/eqUZHm+ho0U8G84GEbtzEP7iFwj8tEGIOx+YOKcKxviN1JYmXdWZ2FC
        TPnNQi7UwYC2WcYS5lnPHJOyVHjgPjFnIQQlK77q827w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1o6QIIFowAbaK9KlSPMxqGQ6alF6w8UAzLsxKO7iqNE=; b=mNYHFZXZ
        JUduRE3uh8lcvvjIrU3QH8LyFNc5hDHV41W5hTPbdLYiPNqDcQUnQTUjxu9Akqln
        SPNokWu5wNAtSusH2KRXnpj+mFwwkCTX/E32mrtbt0DLND2U4tLwIifFMXO4lozI
        hCEGORPJNZsg89hyxiIuWy2XlfX74ZeUPLcufbd7nM9dXhz6whqNO/d/LQiyr3k8
        2c44nLC3Wb4m227aw2/TsWWCiffvE5o0OlMqOh5ipBw9UXi7uj3thZx5WgIzcY1W
        XBDgXk6gzeZ+GQAjDkzYRBIgK+5xezQoWr0CgU9F3t1/PoqVMB5Ui9NIbkziSZ+0
        HHrxrwN3mCKWAA==
X-ME-Sender: <xms:IKm1X5QBB3v9Yz_MmA39G3JZp1xjOc8uE1x60boTcgtnm1c_EDw4UQ>
    <xme:IKm1XyzAzMEXVm3XNYDLwdnaEWcWwx_kpJxtVno-XmM_rLXd-Uk_OI5FXegcdXhkd
    Jw2C6HdTf1bRkGjTRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeetheehudfgleelhfehffettedtfeelvdfghfelke
    efgefgvdevgefffedvtdefgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:IKm1X-2yxcAQ5q-q0c-iFPJtUSnb5dynZhDNNMjFy9iKljYBNFAi1g>
    <xmx:IKm1XxCJTXAsect1A7XYKsvU77aTTxAcynKrV0uVdk3swhB3_UbyNw>
    <xmx:IKm1XyiAK_GR3TfN6tJ4BrWZAqhSwY_9Vf3dse2APmrkAUUUEttoVQ>
    <xmx:IKm1X4dM4LD8QirxqJ-8SNg9WO7s95Xs0ZzR32joUuKRIFhvY7pnJg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3FE0E328005E;
        Wed, 18 Nov 2020 18:07:12 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 10/12] btrfs: remove free space items when disabling space cache v1
Date:   Wed, 18 Nov 2020 15:06:25 -0800
Message-Id: <09feedd57a06e703eee37d8f40c5e1829bfe36de.1605736355.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1605736355.git.boris@bur.io>
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the file system transitions from space cache v1 to v2 or to
nospace_cache, it removes the old cached data, but does not remove
the FREE_SPACE items nor the free space inodes they point to. This
doesn't cause any issues besides being a bit inefficient, since these
items no longer do anything useful.

To fix it, when we are mounting, and plan to disable the space cache,
destroy each block group's free space item and free space inode.
The code to remove the items is lifted from the existing use case of
removing the block group, with a light adaptation to handle whether or
not we have already looked up the free space inode.

References: https://github.com/btrfs/btrfs-todo/issues/5
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c      |  39 +-------------
 fs/btrfs/free-space-cache.c | 101 ++++++++++++++++++++++++++++++++++--
 fs/btrfs/free-space-cache.h |   3 ++
 3 files changed, 102 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 00e2fe1d0f32..d5104560dfc9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -848,8 +848,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_block_group *block_group;
 	struct btrfs_free_cluster *cluster;
-	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_key key;
 	struct inode *inode;
 	struct kobject *kobj = NULL;
 	int ret;
@@ -927,42 +925,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
+	ret = btrfs_remove_free_space_inode(trans, inode, block_group);
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
index 48f7bd050909..3c226a436c7a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -213,6 +213,65 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
 					 ino, block_group->start);
 }
 
+/*
+ * inode is an optional sink: if it is NULL, btrfs_remove_free_space_inode
+ * handles lookup, otherwise it takes ownership and iputs the inode.
+ * Don't reuse an inode pointer after passing it into this function.
+ */
+int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
+				  struct inode *inode,
+				  struct btrfs_block_group *block_group)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	if (!inode)
+		inode = lookup_free_space_inode(block_group, path);
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
+	/* One for the lookup ref */
+	btrfs_add_delayed_iput(inode);
+
+	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
+	key.type = 0;
+	key.offset = block_group->start;
+	ret = btrfs_search_slot(trans, trans->fs_info->tree_root, &key, path,
+				-1, 1);
+	if (ret) {
+		if (ret > 0)
+			ret = 0;
+		goto out;
+	}
+	ret = btrfs_del_item(trans, trans->fs_info->tree_root, path);
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv)
 {
@@ -3976,6 +4035,28 @@ bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info)
 	return btrfs_super_cache_generation(fs_info->super_copy);
 }
 
+static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
+				       struct btrfs_trans_handle *trans)
+{
+	struct btrfs_block_group *block_group;
+	struct rb_node *node;
+	int ret;
+
+	btrfs_info(fs_info, "cleaning free space cache v1");
+
+	node = rb_first(&fs_info->block_group_cache_tree);
+	while (node) {
+		block_group = rb_entry(node, struct btrfs_block_group,
+				       cache_node);
+		ret = btrfs_remove_free_space_inode(trans, NULL, block_group);
+		if (ret)
+			goto out;
+		node = rb_next(node);
+	}
+out:
+	return ret;
+}
+
 int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
 					 bool active)
 {
@@ -3983,18 +4064,30 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	/*
-	 * update_super_roots will appropriately set
-	 * fs_info->super_copy->cache_generation based on the SPACE_CACHE
-	 * option, so all we have to do is trigger a transaction commit.
+	 * update_super_roots will appropriately set or unset
+	 * fs_info->super_copy->cache_generation based on SPACE_CACHE and
+	 * BTRFS_FS_CLEANUP_SPACE_CACHE_V1. For this reason, we need a
+	 * transaction commit whether we are enabling space cache v1 and don't
+	 * have any other work to do, or are disabling it and removing free
+	 * space inodes.
 	 */
 	trans = btrfs_start_transaction(fs_info->tree_root, 0);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	if (!active)
+	if (!active) {
 		set_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
+		ret = cleanup_free_space_cache_v1(fs_info, trans);
+		if (ret)
+			goto abort;
+	}
 
 	ret = btrfs_commit_transaction(trans);
+	goto out;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	btrfs_end_transaction(trans);
+out:
 	clear_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
 	return ret;
 }
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 8f4bc5781cd3..93522d22c195 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -84,6 +84,9 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 int create_free_space_inode(struct btrfs_trans_handle *trans,
 			    struct btrfs_block_group *block_group,
 			    struct btrfs_path *path);
+int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
+				  struct inode *inode,
+				  struct btrfs_block_group *block_group);
 
 int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *rsv);
-- 
2.24.1

