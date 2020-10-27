Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEFB29CAF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832090AbgJ0VJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:09:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60325 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411855AbgJ0VJJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:09:09 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id AF40D5C00ED;
        Tue, 27 Oct 2020 17:09:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fD/ynqnWQddNK
        rGuAAeWQqjuEl7+7yLEXTQ46LFt+Jc=; b=OyPY9nHiSu5r9J1+ujFNQ+uGFaPu1
        +geDn9LhVWdHjNr6dY+qVhsEfjPndcCASsAyGWMcQOM6iA/N/nuJgYLyBeJCr8dl
        uIPwsg/o4KZB/OWcWX5y16LfeHR90X9T5gRLSaq6z+NvkBn+47DBYSO6h/r2X9JQ
        Ke4A42OCmP7sH47dcaDGa0pb1DKeitCnod9gTJ/kWNDJXnl07BJdcV1v5ZhxKDpc
        G/3OL15B0OwHYUkFrC7OjisAEVUOE5SABLJtl54BQbW5664yVj7ld/WK+sRkRVx8
        MFGJRbkZENZzVkaju+LUjay6PJjH1FCaxnPTZgbI/xwVAEBO3/0aC1AsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fD/ynqnWQddNKrGuAAeWQqjuEl7+7yLEXTQ46LFt+Jc=; b=em1dO2dF
        fYktdGL7Cg8rYLE9jgYwQgsch5X4ZoOEJ/01EfZQE+R6BKEJ/p/T9g8Ll7Pvu1uP
        MNeWFNVlcwWJL2cz7hU9ajmzY46odyS02FmcGRZ2iXt1zNdHoA29IlV8WxXjfOrg
        tMWJ2Wyu6Kgsi70FuidC2q0bflgp+Kw6c/spRnNvylJkE0QNVrctIL6mCuSkGGoL
        R0q3Xr/f6Om7HFDg5RvtEBIQX8pgyshIucMGp6udzAJ65SGI7LheFcWA/5WBzoEo
        WzYov63Kw9LS/PmZcy8+PiRTU/n3C6nSTjiHLJdF8vLiIa2WHj6Pi6xz/JC4ZGfp
        61HWyNs4D9WefQ==
X-ME-Sender: <xms:c4yYXzNycH2NJLbetMK9LEoh2Zamk0NfgHDf3HX6-viBtgr6wLHHEw>
    <xme:c4yYX9-NdDhd-joEsDmMnvIXbWTJiFvtdP0ePIiVCKWt0E0sxi6dStwcl3c9NQy1T
    5bMifMwdTObKwBGCGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeetheehudfgleelhfehffettedtfeelvdfghfelke
    efgefgvdevgefffedvtdefgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:c4yYXyQaC-TR7Dkwt0sG2wILEFiawCgr-bLcz9vgDWyPppWZ-A15-w>
    <xmx:c4yYX3vlSagoiLgIZcuI5NHNOlHoqGKLNK4f0k2uZzywcR4wzMBYWQ>
    <xmx:c4yYX7f7Sn-2JCJL2lbjWFD8k-xdqKSlPysIcnjWzTet_9TISsJQQg>
    <xmx:c4yYX7nXK5aXDUMtDNKDYmvnVNxYaLGW2PYDiQnf899zrbb8we32CA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8BF89328005D;
        Tue, 27 Oct 2020 17:09:06 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 09/10] btrfs: remove free space items when disabling space cache v1
Date:   Tue, 27 Oct 2020 14:08:03 -0700
Message-Id: <750174b66139e105150b988b35705a1a708b2eb5.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
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
index c0f1d6818df7..8938b11a3339 100644
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
index 3acf935536ea..5d357786c9da 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -207,6 +207,65 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
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
@@ -3997,6 +4056,28 @@ bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info)
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
@@ -4004,18 +4085,30 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
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
index 5c546898ded9..8df4b2925eca 100644
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

