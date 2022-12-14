Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8864C227
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiLNCLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 21:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiLNCLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 21:11:35 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C97621E34
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 18:11:34 -0800 (PST)
From:   robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670983892; bh=01R+R6z/j4ZRdQ3Pr8zxf077SScevdzaAkNBwRZ3xkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DRX/nMu7ztieRc5CZztqIBQgdxWXQc8AWdcVGd9z1R0vcsNd0t2ETMc9NUjVwE76B
         hcuxKgm+tBJ+hWLCPrx0Q7yCy3/0LyciIhhEQT/Z5Snd28Bj8FzS1cjX5FwrK0dMnZ
         uO/4PoAPDeNSq+5wKXOpKznXxkyKhuX704IkmlfQ=
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2 1/3] btrfs: refactor anon_dev with new_fs_root_args for create subvolume/snapshot
Date:   Wed, 14 Dec 2022 10:11:23 +0800
Message-Id: <20221214021125.28289-2-robbieko@synology.com>
In-Reply-To: <20221214021125.28289-1-robbieko@synology.com>
References: <20221214021125.28289-1-robbieko@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

Create a new structure called btrfs_new_fs_root_args that
refactor the type of anon_dev.
With the new structure, btrfs_get_new_fs_root can input
btrfs_new_fs_root_args into btrfs_init_fs_root by order.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/disk-io.c     | 61 +++++++++++++++++++++++++++++-------------
 fs/btrfs/disk-io.h     | 10 ++++++-
 fs/btrfs/ioctl.c       | 34 +++++++++++------------
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/transaction.h |  5 ++--
 5 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bd6cd8956ec8..e45fd1ef5d11 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1506,12 +1506,42 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	return root;
 }
 
+struct btrfs_new_fs_root_args *btrfs_alloc_new_fs_root_args(void)
+{
+	int err;
+	struct btrfs_new_fs_root_args *args;
+
+	args = kzalloc(sizeof(*args), GFP_KERNEL);
+	if (!args)
+		return ERR_PTR(-ENOMEM);
+
+	err = get_anon_bdev(&args->anon_dev);
+	if (err)
+		goto error;
+
+	return args;
+
+error:
+	btrfs_free_new_fs_root_args(args);
+	return ERR_PTR(err);
+}
+
+void btrfs_free_new_fs_root_args(struct btrfs_new_fs_root_args *args)
+{
+	if (!args)
+		return;
+	if (args->anon_dev)
+		free_anon_bdev(args->anon_dev);
+	kfree(args);
+}
+
 /*
  * Initialize subvolume root in-memory structure
  *
  * @anon_dev:	anonymous device to attach to the root, if zero, allocate new
  */
-static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
+static int btrfs_init_fs_root(struct btrfs_root *root,
+			      struct btrfs_new_fs_root_args *new_fs_root_args)
 {
 	int ret;
 	unsigned int nofs_flag;
@@ -1538,12 +1568,13 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	 */
 	if (is_fstree(root->root_key.objectid) &&
 	    btrfs_root_refs(&root->root_item) > 0) {
-		if (!anon_dev) {
+		if (!new_fs_root_args || !new_fs_root_args->anon_dev) {
 			ret = get_anon_bdev(&root->anon_dev);
 			if (ret)
 				goto fail;
 		} else {
-			root->anon_dev = anon_dev;
+			root->anon_dev = new_fs_root_args->anon_dev;
+			new_fs_root_args->anon_dev = 0;
 		}
 	}
 
@@ -1717,7 +1748,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
  *		for orphan roots
  */
 static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
-					     u64 objectid, dev_t anon_dev,
+					     u64 objectid,
+					     struct btrfs_new_fs_root_args *new_fs_root_args,
 					     bool check_ref)
 {
 	struct btrfs_root *root;
@@ -1731,8 +1763,8 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
-		/* Shouldn't get preallocated anon_dev for cached roots */
-		ASSERT(!anon_dev);
+		/* Shouldn't get new_fs_root_args for cached roots */
+		ASSERT(!new_fs_root_args);
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
 			btrfs_put_root(root);
 			return ERR_PTR(-ENOENT);
@@ -1752,7 +1784,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 		goto fail;
 	}
 
-	ret = btrfs_init_fs_root(root, anon_dev);
+	ret = btrfs_init_fs_root(root, new_fs_root_args);
 	if (ret)
 		goto fail;
 
@@ -1782,14 +1814,6 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	}
 	return root;
 fail:
-	/*
-	 * If our caller provided us an anonymous device, then it's his
-	 * responsibility to free it in case we fail. So we have to set our
-	 * root's anon_dev to 0 to avoid a double free, once by btrfs_put_root()
-	 * and once again by our caller.
-	 */
-	if (anon_dev)
-		root->anon_dev = 0;
 	btrfs_put_root(root);
 	return ERR_PTR(ret);
 }
@@ -1804,7 +1828,7 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref)
 {
-	return btrfs_get_root_ref(fs_info, objectid, 0, check_ref);
+	return btrfs_get_root_ref(fs_info, objectid, NULL, check_ref);
 }
 
 /*
@@ -1816,9 +1840,10 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
  *		parameter value
  */
 struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
-					 u64 objectid, dev_t anon_dev)
+					 u64 objectid,
+					 struct btrfs_new_fs_root_args *new_fs_root_args)
 {
-	return btrfs_get_root_ref(fs_info, objectid, anon_dev, true);
+	return btrfs_get_root_ref(fs_info, objectid, new_fs_root_args, true);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 363935cfc084..67c6625797ca 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -25,6 +25,11 @@ static inline u64 btrfs_sb_offset(int mirror)
 	return BTRFS_SUPER_INFO_OFFSET;
 }
 
+struct btrfs_new_fs_root_args {
+	/* Preallocated anonymous block device number */
+	dev_t anon_dev;
+};
+
 struct btrfs_device;
 struct btrfs_fs_devices;
 struct btrfs_tree_parent_check;
@@ -58,6 +63,8 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
+struct btrfs_new_fs_root_args *btrfs_alloc_new_fs_root_args(void);
+void btrfs_free_new_fs_root_args(struct btrfs_new_fs_root_args *args);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root);
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
@@ -65,7 +72,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref);
 struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
-					 u64 objectid, dev_t anon_dev);
+					 u64 objectid,
+					 struct btrfs_new_fs_root_args *new_fs_root_args);
 struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
 						 u64 objectid);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e348bd2ccde..de0cafe9b62b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -599,8 +599,8 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	};
 	unsigned int trans_num_items;
 	int ret;
-	dev_t anon_dev;
 	u64 objectid;
+	struct btrfs_new_fs_root_args *new_fs_root_args = NULL;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -619,14 +619,17 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		goto out_root_item;
 	}
 
-	ret = get_anon_bdev(&anon_dev);
-	if (ret < 0)
+	new_fs_root_args = btrfs_alloc_new_fs_root_args();
+	if (IS_ERR(new_fs_root_args)) {
+		ret = PTR_ERR(new_fs_root_args);
+		new_fs_root_args = NULL;
 		goto out_root_item;
+	}
 
 	new_inode_args.inode = btrfs_new_subvol_inode(mnt_userns, dir);
 	if (!new_inode_args.inode) {
 		ret = -ENOMEM;
-		goto out_anon_dev;
+		goto out_root_item;
 	}
 	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
 	if (ret)
@@ -717,14 +720,12 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	free_extent_buffer(leaf);
 	leaf = NULL;
 
-	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
+	new_root = btrfs_get_new_fs_root(fs_info, objectid, new_fs_root_args);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	/* anon_dev is owned by new_root now. */
-	anon_dev = 0;
 	BTRFS_I(new_inode_args.inode)->root = new_root;
 	/* ... and new_root is owned by new_inode_args.inode now. */
 
@@ -763,10 +764,8 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
 	iput(new_inode_args.inode);
-out_anon_dev:
-	if (anon_dev)
-		free_anon_bdev(anon_dev);
 out_root_item:
+	btrfs_free_new_fs_root_args(new_fs_root_args);
 	kfree(root_item);
 	return ret;
 }
@@ -802,9 +801,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (!pending_snapshot)
 		return -ENOMEM;
 
-	ret = get_anon_bdev(&pending_snapshot->anon_dev);
-	if (ret < 0)
+	pending_snapshot->new_fs_root_args = btrfs_alloc_new_fs_root_args();
+	if (IS_ERR(pending_snapshot->new_fs_root_args)) {
+		ret = PTR_ERR(pending_snapshot->new_fs_root_args);
+		pending_snapshot->new_fs_root_args = NULL;
 		goto free_pending;
+	}
+
 	pending_snapshot->root_item = kzalloc(sizeof(struct btrfs_root_item),
 			GFP_KERNEL);
 	pending_snapshot->path = btrfs_alloc_path();
@@ -861,16 +864,11 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 
 	d_instantiate(dentry, inode);
 	ret = 0;
-	pending_snapshot->anon_dev = 0;
 fail:
-	/* Prevent double freeing of anon_dev */
-	if (ret && pending_snapshot->snap)
-		pending_snapshot->snap->anon_dev = 0;
 	btrfs_put_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
 free_pending:
-	if (pending_snapshot->anon_dev)
-		free_anon_bdev(pending_snapshot->anon_dev);
+	btrfs_free_new_fs_root_args(pending_snapshot->new_fs_root_args);
 	kfree(pending_snapshot->root_item);
 	btrfs_free_path(pending_snapshot->path);
 	kfree(pending_snapshot);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b8c52e89688c..042626fbd3b8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1801,7 +1801,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.offset = (u64)-1;
-	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->anon_dev);
+	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->new_fs_root_args);
 	if (IS_ERR(pending->snap)) {
 		ret = PTR_ERR(pending->snap);
 		pending->snap = NULL;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 97f6c39f59c8..60022240c1ea 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -11,6 +11,7 @@
 #include "delayed-ref.h"
 #include "ctree.h"
 #include "misc.h"
+#include "disk-io.h"
 
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
@@ -163,8 +164,8 @@ struct btrfs_pending_snapshot {
 	struct btrfs_block_rsv block_rsv;
 	/* extra metadata reservation for relocation */
 	int error;
-	/* Preallocated anonymous block device number */
-	dev_t anon_dev;
+	/* Preallocated new_fs_root_args */
+	struct btrfs_new_fs_root_args *new_fs_root_args;
 	bool readonly;
 	struct list_head list;
 };
-- 
2.17.1

