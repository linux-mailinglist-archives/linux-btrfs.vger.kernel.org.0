Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA829F955
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJ2X6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39437 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CC0A75C00AC;
        Thu, 29 Oct 2020 19:58:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=VbhibWHPQDmPWxK+X2yNUiStnY
        V//NJ1/twaUpnzY5U=; b=RX9Cy9vgTfGRsTAmafoHgddfiwbD3Y0P+gGgT1rDDz
        hh/tFuTWqzHJA25T0rC+lIqsP4x8TmOdtr7TFOUOlD4Nz5KImKmff1PntxF1ucFD
        oTg7jDqN2gfO9nHZ4po5S08T1NxYbaUbD070EnCCwHFSVLBsSJsxHrtMCFa2ToGz
        tcH6xHPxycNOz9Kdtvl2F6TlIIhr1drxatYK2x4sF8IQwSlrVGrpLQWQ5XiCL6xl
        OEraYaH1l8FaTUTN0tAWMRKqiGun9MfsSb2tJ/XCBEEOQbUF4cCXyCErNHOUTCQ4
        QUfFWMXzjfmwdxXCY1pYiPL/WU8bvTASybAtNQZcFMRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=VbhibWHPQDmPWxK+X2yNUiStnYV//NJ1/twaUpnzY5U=; b=A3Jvui8R
        ThoVahhMqtpYtQLhEohceI4j3ZoMvhEnzNFuAU7yrfP8DKevnZ/7dcNzFrdzau1m
        Ya+10wRz0xE4EAYjLSFdmmq5m2ztcuLNnh09k80sAgjAdyIEYncAdtY3WLCJ+QK5
        HdbKvfy0ldHMDG+jraLaSr0EO2SlFk2jK4PdkrA5YK0IiTq/GkyUNNbLpaLyxfH+
        9aM/r8lY0ooREyqbwcEf1izVetMIb40iVvXTe8ztRiSGSMqQZa9pT8cUiwjF3gKh
        rxnybkETnvQVEed+b7HvodA8v78ET8bv98+Z55oqpg16LIj4qyAl4+G1vXzklQO8
        J6oWxvWSu1wsDg==
X-ME-Sender: <xms:JVebX8fndC7Lg0HWafELZguvKtQr_5iP20K6wtdaP6_ofcms6Ir7ww>
    <xme:JVebX-OVbVWO-FGH9gJtYKMN3QlCguRucgc6bZg3gaGZ0rQJ19ICNII7VZR0hW5jP
    LFrx38PK1fvbFqYI84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepteehhedugfellefhheffteettdefledvgffhleekfe
    eggfdvveegffefvddtfeegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:JVebX9gb99KEqXBck9jN4VDgBFzS6AvxYYxZURQ0ZdtWFIIkukOd_g>
    <xmx:JVebXx9XPhYhadUvqGfwYC1uiX0TGOd5zn5y6kqQHXK-2wuy23ixug>
    <xmx:JVebX4u2qOn2sYuZgAG4duZpidKS8C-8kyZzeMOkBRkihhEFtLYimg>
    <xmx:JVebXx6CyymmTUoe2UjYsixEEepWB-9P5Ja6HbkX7f9FdvgaMmgs3g>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 355DF3280063;
        Thu, 29 Oct 2020 19:58:29 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 09/10] btrfs: remove free space items when disabling space cache v1
Date:   Thu, 29 Oct 2020 16:57:56 -0700
Message-Id: <ed1ecf494dfe89575244df80317392623843101c.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
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
index bb6685711824..2dde5c6f1da8 100644
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
index 5185e798cc57..660cc722ef3f 100644
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

