Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD526E39E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIQSbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 14:31:14 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35359 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgIQSbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 14:31:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1EA223CC;
        Thu, 17 Sep 2020 14:14:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Sep 2020 14:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=c4o5GPfZS6ZG2
        4fW4YueA0GGS4pFbyZh70UDaE1HvWM=; b=W7x0amnZRQhxe7uDIAgoyXLOo4ocS
        B5hYKLltvkd02ce8/lDydzteR18TKmZAQH1tjf345DDc1vdwkoeP0c44XmyJhRKW
        4AzNds3IhDYbYtmggFNb9twMBn0xo88iVlr1etpxQsQqswjeeReH7yPNt9rRR0QX
        +K5lXrR9wfpENFaTCGDmGwadDV0Tznhip0TcaUEjRsvwPTfiM4grKLEAPzfgdm3D
        W53ECAev9sVR68WGLQRMEceqaynQ/ubZsqjOpwv0susyof3XNBfr4tVN4dbI7vFV
        Y8qkKQqLC+jGTVIMFo4+V+Lc9M4bhKx+mqLyqHZc1H3zTegbeAdUD9/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=c4o5GPfZS6ZG24fW4YueA0GGS4pFbyZh70UDaE1HvWM=; b=NPgYkHAC
        /GMgdk80Gkk7BpsvCMbcgzk1HfnaUmbktKNrW0v82q18SkJYFJhRzHysJBs5yJpM
        m2hwA1RE1KUXFEcUZIINS3+21bD6F9kk/ZWJhbjDWPkMUcWvxYyskqEogcky9m6V
        IHov9hw/PSAwUPcIW60a4XUGtcLxtct9xLGJmZOHMuocEHYqteOhkbFGM805u+fh
        tcVSkrvGJXo0Hl2nbNFt43IZkhj6iBqPWNGSIEBIFMJZr0JYD9A8q+BWxuAxuW6i
        E8JLxIJMl/cpfBlaN6xhAZpxmVanytNrFmn/t1qv5IucNYgnujOSWWGLWPdsndOE
        Y9BqmYAEiWq0lw==
X-ME-Sender: <xms:c6djX_Sk0FbsymrYgztH_wF6PIqFmj7Kx0xlm4wDFumwOMQsS8_-ig>
    <xme:c6djXwyQ71uDGZsklUIi5YPMJkMzW0tGh1UbYuFoV1sgdV71YKhVJVWWCzN2tmkVv
    z7MYav2To6TtbLcNgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeetheehudfgleelhfehffettedtfeelvdfghfelke
    efgefgvdevgefffedvtdefgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:c6djX01124px8tNCE2yUPaApteDVVXoVp-Y1yql1vLKieXzSBxDbPw>
    <xmx:c6djX_CLs3iUE3ck7RUS_sksD_NHcLbjoGwVaBxLoD8iDPmbgJ4r-g>
    <xmx:c6djX4j5rxFLeBt26g08Blf6AuUr3CzjAx1xc3PRqL8-I7sqHY1sBQ>
    <xmx:c6djXwIPkyOtHrr5-9ymRCVyKnh3S_ZAXJDT_J5r2gkN57HibpF1oQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 157123064686;
        Thu, 17 Sep 2020 14:14:11 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 3/4] btrfs: remove free space items when creating free space tree
Date:   Thu, 17 Sep 2020 11:13:40 -0700
Message-Id: <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1600282812.git.boris@bur.io>
References: <cover.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v3:
- pass in optional inode to btrfs_remove_free_space_inode, which fixes
  the bug of not issuing an iput for it in the bg delete case.
- fix bug where the orphan generated by fst creation could not be
  cleaned up, because delayed_iput had an outstanding reference
v2:
- remove_free_space_inode -> btrfs_remove_free_space_inode
- undo sinful whitespace change

 fs/btrfs/block-group.c      | 39 ++-----------------------
 fs/btrfs/disk-io.c          |  9 ++++++
 fs/btrfs/free-space-cache.c | 58 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  3 ++
 fs/btrfs/free-space-tree.c  |  3 ++
 5 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 01e8ba1da1d3..717b3435c88e 100644
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
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ade92e93e63f..775d29565665 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3333,6 +3333,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			close_ctree(fs_info);
 			return ret;
 		}
+		/*
+		 * Creating the free space tree creates inode orphan items and
+		 * delayed iputs when it deletes the free space inodes. Later in
+		 * open_ctree, we run btrfs_orphan_cleanup which tries to clean
+		 * up the orphan items. However, the outstanding references on
+		 * the inodes from the delayed iputs causes the cleanup to fail.
+		 * To fix it, force going through the delayed iputs here.
+		 */
+		btrfs_run_delayed_iputs(fs_info);
 	}
 
 	if ((bool)btrfs_test_opt(fs_info, SPACE_CACHE) !=
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 25420d51039c..6e1bbe87d734 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -207,6 +207,64 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
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
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	if (!inode) {
+		inode = lookup_free_space_inode(block_group, path);
+	}
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
+	ret = btrfs_search_slot(trans, trans->fs_info->tree_root, &key, path, -1, 1);
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
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 5fbdbd2fe740..0c01c53fce82 100644
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
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6b9faf3b0e96..d5926d36bf73 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1165,6 +1165,9 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
 		ret = populate_free_space_tree(trans, block_group);
+		if (ret)
+			goto abort;
+		ret = btrfs_remove_free_space_inode(trans, NULL, block_group);
 		if (ret)
 			goto abort;
 		node = rb_next(node);
-- 
2.24.1

