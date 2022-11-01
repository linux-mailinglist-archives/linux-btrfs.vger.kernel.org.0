Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC86152E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKAUNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKAUM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923FB1E3D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 51D6A1F8BA;
        Tue,  1 Nov 2022 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bv8ghryHFDoTCtNUGy/P0poJcuQWk/L+T7y9u44oaJ8=;
        b=gEDTi37usZ++1XGbj3lbVQ+eC78E6WYXW9xRZ1LjyzmwXiAmGche5ZpI6ZDWsKmkfhDsEl
        LfdudP+8+frbsu93qUqblmmLA/fEo6ECB8ap/MWF+66ZZ/wWS8Va1fO+y26gDFLwutL22F
        jD9t69ATQJSD4ZGdpsvXCzXfOTAgepw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4B0452C141;
        Tue,  1 Nov 2022 20:12:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B98BDA79D; Tue,  1 Nov 2022 21:12:36 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 26/40] btrfs: drop private_data parameter from extent_io_tree_init
Date:   Tue,  1 Nov 2022 21:12:36 +0100
Message-Id: <7ec314a9ea8230a64faf2f314423e1a8c7eac07f.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers except one pass NULL, so the parameter can be dropped and
the inode::io_tree initialization can be open coded.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c               | 8 ++++----
 fs/btrfs/extent-io-tree.c        | 5 ++---
 fs/btrfs/extent-io-tree.h        | 3 +--
 fs/btrfs/inode.c                 | 5 +++--
 fs/btrfs/relocation.c            | 3 +--
 fs/btrfs/tests/btrfs-tests.c     | 2 +-
 fs/btrfs/tests/extent-io-tests.c | 4 ++--
 fs/btrfs/transaction.c           | 4 ++--
 fs/btrfs/volumes.c               | 3 +--
 9 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c86513e70ff3..d93bb971cc73 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1044,9 +1044,9 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->anon_dev = 0;
 	if (!dummy) {
 		extent_io_tree_init(fs_info, &root->dirty_log_pages,
-				    IO_TREE_ROOT_DIRTY_LOG_PAGES, NULL);
+				    IO_TREE_ROOT_DIRTY_LOG_PAGES);
 		extent_io_tree_init(fs_info, &root->log_csum_range,
-				    IO_TREE_LOG_CSUM_RANGE, NULL);
+				    IO_TREE_LOG_CSUM_RANGE);
 	}
 
 	spin_lock_init(&root->root_item_lock);
@@ -2252,7 +2252,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
-			    IO_TREE_BTREE_INODE_IO, NULL);
+			    IO_TREE_BTREE_INODE_IO);
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
@@ -3076,7 +3076,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
 
 	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
-			    IO_TREE_FS_EXCLUDED_EXTENTS, NULL);
+			    IO_TREE_FS_EXCLUDED_EXTENTS);
 
 	mutex_init(&fs_info->ordered_operations_mutex);
 	mutex_init(&fs_info->tree_log_mutex);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 2cdff74ff033..81365870576f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -94,13 +94,12 @@ struct tree_entry {
 };
 
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
-			 struct extent_io_tree *tree, unsigned int owner,
-			 void *private_data)
+			 struct extent_io_tree *tree, unsigned int owner)
 {
 	tree->fs_info = fs_info;
 	tree->state = RB_ROOT;
 	spin_lock_init(&tree->lock);
-	tree->private_data = private_data;
+	tree->private_data = NULL;
 	tree->owner = owner;
 	if (owner == IO_TREE_INODE_FILE_EXTENT)
 		lockdep_set_class(&tree->lock, &file_extent_tree_class);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d73ef24bad2e..0e16642c28a3 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -104,8 +104,7 @@ struct extent_state {
 };
 
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
-			 struct extent_io_tree *tree, unsigned int owner,
-			 void *private_data);
+			 struct extent_io_tree *tree, unsigned int owner);
 void extent_io_tree_release(struct extent_io_tree *tree);
 
 int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 203298546c7e..35b8aae4de5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8870,9 +8870,10 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
-	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
+	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
+	ei->io_tree.private_data = inode;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
-			    IO_TREE_INODE_FILE_EXTENT, NULL);
+			    IO_TREE_INODE_FILE_EXTENT);
 	ei->io_failure_tree = RB_ROOT;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1a337602723c..bdf845077002 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3925,8 +3925,7 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
 	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
 	mapping_tree_init(&rc->reloc_root_tree);
-	extent_io_tree_init(fs_info, &rc->processed_blocks,
-			    IO_TREE_RELOC_BLOCKS, NULL);
+	extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLOCKS);
 	return rc;
 }
 
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 1538c65f2b17..9d5cb7fa51d0 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -102,7 +102,7 @@ struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	extent_io_tree_init(NULL, &dev->alloc_state, 0, NULL);
+	extent_io_tree_init(NULL, &dev->alloc_state, 0);
 	INIT_LIST_HEAD(&dev->dev_list);
 	list_add(&dev->dev_list, &fs_info->fs_devices->devices);
 
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 350da449db08..dfc5c7fa6038 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -132,7 +132,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 * Passing NULL as we don't have fs_info but tracepoints are not used
 	 * at this point
 	 */
-	extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST, NULL);
+	extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST);
 
 	/*
 	 * First go through and create and mark all of our pages dirty, we pin
@@ -489,7 +489,7 @@ static int test_find_first_clear_extent_bit(void)
 
 	test_msg("running find_first_clear_extent_bit test");
 
-	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST, NULL);
+	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST);
 
 	/* Test correct handling of empty tree */
 	find_first_clear_extent_bit(&tree, 0, &start, &end, CHUNK_TRIMMED);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2e2dd2ea109b..b8c52e89688c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -378,9 +378,9 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
-			IO_TREE_TRANS_DIRTY_PAGES, NULL);
+			IO_TREE_TRANS_DIRTY_PAGES);
 	extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
-			IO_TREE_FS_PINNED_EXTENTS, NULL);
+			IO_TREE_FS_PINNED_EXTENTS);
 	fs_info->generation++;
 	cur_trans->transid = fs_info->generation;
 	fs_info->running_transaction = cur_trans;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 27fa43f5c4f4..0e3c8860c0a4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7036,8 +7036,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 
 	atomic_set(&dev->dev_stats_ccnt, 0);
 	btrfs_device_data_ordered_init(dev);
-	extent_io_tree_init(fs_info, &dev->alloc_state,
-			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
+	extent_io_tree_init(fs_info, &dev->alloc_state, IO_TREE_DEVICE_ALLOC_STATE);
 
 	if (devid)
 		tmp = *devid;
-- 
2.37.3

