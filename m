Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E710526FE9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIRNeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgIRNep (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=d+B9zBaBwdSLqva/gR80cZ2zWHYMQo4Jg1pvQm1xdjo=;
        b=cz8uTQE+CGz0J8X2W6rwEy1dkVHyfXfPrcx9GKvj3ZytiwenUu0KwzKJ2HMkssKmP2zlbT
        BTeweRSRmXTBnC+rTPZBBQM6qomPWY8tbK0BAr+JnsqqZMFM9ux0rVukOq3FYkbN2/Rjtu
        yoBmaMi25iiK9zzp3/cJbJDZLn6PyNQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37EEAB25C;
        Fri, 18 Sep 2020 13:35:17 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 7/7] btrfs: Remove struct extent_io_ops
Date:   Fri, 18 Sep 2020 16:34:39 +0300
Message-Id: <20200918133439.23187-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h             |  2 --
 fs/btrfs/disk-io.c           |  7 -------
 fs/btrfs/extent-io-tree.h    |  1 -
 fs/btrfs/extent_io.c         |  2 --
 fs/btrfs/inode.c             | 16 ----------------
 fs/btrfs/tests/inode-tests.c |  1 -
 6 files changed, 29 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5fc18b7ab771..8e811debae57 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3576,9 +3576,7 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 
 /* Sanity test specific functions */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-void btrfs_test_inode_set_ops(struct inode *inode);
 void btrfs_test_destroy_inode(struct inode *inode);
-
 static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 {
 	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 54f2b95cc305..85b59797a4a4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -50,7 +50,6 @@
 				 BTRFS_SUPER_FLAG_METADUMP |\
 				 BTRFS_SUPER_FLAG_METADUMP_V2)
 
-static const struct extent_io_ops btree_extent_io_ops;
 static void end_workqueue_fn(struct btrfs_work *work);
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
 static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
@@ -2066,8 +2065,6 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	BTRFS_I(inode)->io_tree.track_uptodate = false;
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
-	BTRFS_I(inode)->io_tree.ops = &btree_extent_io_ops;
-
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	memset(&BTRFS_I(inode)->location, 0, sizeof(struct btrfs_key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
@@ -4634,7 +4631,3 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 
 	return 0;
 }
-
-static const struct extent_io_ops btree_extent_io_ops = {
-	.submit_bio_hook = NULL
-};
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 250b8cbaaf97..b1b737e7ef5b 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -62,7 +62,6 @@ struct extent_io_tree {
 	u8 owner;
 
 	spinlock_t lock;
-	const struct extent_io_ops *ops;
 };
 
 struct extent_state {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4a00cfd4082f..b5e00b62bcb1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -281,7 +281,6 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 {
 	tree->fs_info = fs_info;
 	tree->state = RB_ROOT;
-	tree->ops = NULL;
 	tree->dirty_bytes = 0;
 	spin_lock_init(&tree->lock);
 	tree->private_data = private_data;
@@ -3056,7 +3055,6 @@ static int submit_extent_page(unsigned int opf,
 		else
 			contig = bio_end_sector(bio) == sector;
 
-		ASSERT(tree->ops);
 		if (btrfs_bio_fits_in_stripe(page, page_size, bio, bio_flags))
 			can_merge = false;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 955a66207fec..befbe19996b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -71,7 +71,6 @@ static const struct inode_operations btrfs_special_inode_operations;
 static const struct inode_operations btrfs_file_inode_operations;
 static const struct address_space_operations btrfs_aops;
 static const struct file_operations btrfs_dir_file_operations;
-static const struct extent_io_ops btrfs_extent_io_ops;
 
 static struct kmem_cache *btrfs_inode_cachep;
 struct kmem_cache *btrfs_trans_handle_cachep;
@@ -141,13 +140,6 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 
 static int btrfs_dirty_inode(struct inode *inode);
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-void btrfs_test_inode_set_ops(struct inode *inode)
-{
-	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
-}
-#endif
-
 static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
 				     struct inode *inode,  struct inode *dir,
 				     const struct qstr *qstr)
@@ -3376,7 +3368,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_mapping->a_ops = &btrfs_aops;
-		BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 		inode->i_fop = &btrfs_file_operations;
 		inode->i_op = &btrfs_file_inode_operations;
 		break;
@@ -6292,7 +6283,6 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out_unlock;
 
-	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
@@ -9504,7 +9494,6 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
-	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
@@ -9826,7 +9815,6 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_op = &btrfs_file_inode_operations;
 
 	inode->i_mapping->a_ops = &btrfs_aops;
-	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 
 	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
 	if (ret)
@@ -10244,10 +10232,6 @@ static const struct file_operations btrfs_dir_file_operations = {
 	.fsync		= btrfs_sync_file,
 };
 
-static const struct extent_io_ops btrfs_extent_io_ops = {
-	.submit_bio_hook = NULL
-};
-
 /*
  * btrfs doesn't support the bmap operation because swapfiles
  * use bmap to make a mapping of extents in the file.  They assume
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index cc54d4973a74..e6719f7db386 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -949,7 +949,6 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	BTRFS_I(inode)->root = root;
-	btrfs_test_inode_set_ops(inode);
 
 	/* [BTRFS_MAX_EXTENT_SIZE] */
 	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), 0,
-- 
2.17.1

