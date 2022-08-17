Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F26596D77
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiHQLXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHQLXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4626315
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41D6614A3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E51C433D7
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735389;
        bh=jpH9AnhE1WbyjTZWf0Net8UEp1kmq4oL5S95sB+O/rs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r9Z5rDfiiG/C/WEhdmpbDC3SmsKtDn9C0opGnQ3K4/tgllxDDjREgce48/qBWFp8j
         GbzBDUM071ywb7v6uLiGm+pAT/IlfApvMfG9zKbs0JCqYxq/07B59kRcNIcNAzFH4i
         wLwjvVoR/Oc3EWPnEFBgEh/PFAzaouyu/pK49BX/qvjW+2+uYOmPbd94qkQg8Z95bW
         CmBAWDmeuqILxPwZ02zlu8hKcOv4u0w+wMqqyY+9HzX3IbIA9dco2U3sjaOtVaU6dP
         j0l1TfMxdxzNxzcfcKjqUoQXedFswd3p1vgiBHPrm9dumLVtJWXLW21l1l4xd5LoRs
         XNgl3hj/eZ/uw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/15] btrfs: use delayed items when logging a directory
Date:   Wed, 17 Aug 2022 12:22:48 +0100
Message-Id: <85edb6cc38e26f257b321d566f8502e570b98261.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a directory we start by flushing all its delayed items.
That results in adding dir index items to the subvolume btree, for new
dentries, and removing dir index items from the subvolume btree for any
dentries that were deleted.

This makes it straightforward to log a directory simply by iterating over
all the modified subvolume btree leaves, especially when we used to log
both dir index keys and dir item keys (before commit 339d035424849c
("btrfs: only copy dir index keys when logging a directory") and when we
used to copy old dir index entries for leaves modified in the current
transaction (before commit 732d591a5d6c12 ("btrfs: stop copying old dir
items when logging a directory")).

From an efficiency point of view this has a couple of drawbacks:

1) Adds extra latency, due to copying delayed items to the subvolume btree
   and deleting dir index items from the btree.

   Further if there are other tasks accessing the btree, which is common
   (syscalls like creat, mkdir, rename, link, unlink, truncate, reflinks,
   etc, finishing an ordered extent, etc), lock contention can cause
   further delays, both to the task logging a directory and to the other
   tasks accessing the btree;

2) More time spent overall flushing delayed items, if after logging the
   directory further changes are done to the directory in the same
   transaction.

   For example, if we add 10 dentries to a directory, fsync it, add more
   10 dentries, fsync it again, then add more 10 dentries and fsync it
   again, then we end up inserting 3 batches of 10 items to the subvolume
   btree. With the changes from this patch, we flush all the delayed items
   to the btree only once - a single batch of 30 items, and outside the
   logging code (transaction commit or when delayed items are flushed
   asynchronously).

This change simply skips the flushing of delayed items everytime we log a
directory. Instead we copy the delayed insertion items directly to the log
tree and delete delayed deletion items directly from the log tree.
Therefore avoiding changing first the subvolume btree and then scanning it
for new items to copy from it to the log tree and detecting deletions
by observing gaps in consecutive dir index keys in subvolume btree leaves.

Running the following tests on a non-debug kernel (Debian's default kernel
config), on a box with a nvme device, a 12 cores Intel cpu and 64G of ram,
produced the results below.

The results compare a branch without this patch and all the other patches
it depends on versus the same branch with the patchset applied.

The patchset is comprised of the following patches:

  btrfs: don't drop dir index range items when logging a directory
  btrfs: remove the root argument from log_new_dir_dentries()
  btrfs: update stale comment for log_new_dir_dentries()
  btrfs: free list element sooner at log_new_dir_dentries()
  btrfs: avoid memory allocation at log_new_dir_dentries() for common case
  btrfs: remove root argument from btrfs_delayed_item_reserve_metadata()
  btrfs: store index number instead of key in struct btrfs_delayed_item
  btrfs: remove unused logic when looking up delayed items
  btrfs: shrink the size of struct btrfs_delayed_item
  btrfs: search for last logged dir index if it's not cached in the inode
  btrfs: move need_log_inode() to above log_conflicting_inodes()
  btrfs: move log_new_dir_dentries() above btrfs_log_inode()
  btrfs: log conflicting inodes without holding log mutex of the initial inode
  btrfs: skip logging parent dir when conflicting inode is not a dir
  btrfs: use delayed items when logging a directory

Custom test script for testing time spent at btrfs_log_inode():

   #!/bin/bash

   DEV=/dev/nvme0n1
   MNT=/mnt/nvme0n1

   # Total number of files to create in the test directory.
   NUM_FILES=10000
   # Fsync after creating or renaming N files.
   FSYNC_AFTER=100

   umount $DEV &> /dev/null
   mkfs.btrfs -f $DEV
   mount -o ssd $DEV $MNT

   TEST_DIR=$MNT/testdir
   mkdir $TEST_DIR

   echo "Creating files..."
   for ((i = 1; i <= $NUM_FILES; i++)); do
           echo -n > $TEST_DIR/file_$i
           if (( ($i % $FSYNC_AFTER) == 0 )); then
                   xfs_io -c "fsync" $TEST_DIR
           fi
   done

   sync

   echo "Renaming files..."
   for ((i = 1; i <= $NUM_FILES; i++)); do
           mv $TEST_DIR/file_$i $TEST_DIR/file_$i.renamed
           if (( ($i % $FSYNC_AFTER) == 0 )); then
                   xfs_io -c "fsync" $TEST_DIR
           fi
   done

   umount $MNT

And using the following bpftrace script to capture the total time that is
spent at btrfs_log_inode():

   #!/usr/bin/bpftrace

   k:btrfs_log_inode
   {
           @start_log_inode[tid] = nsecs;
   }

   kr:btrfs_log_inode
   /@start_log_inode[tid]/
   {
           $dur = (nsecs - @start_log_inode[tid]) / 1000;
           @btrfs_log_inode_total_time = sum($dur);
           delete(@start_log_inode[tid]);
   }

   END
   {
           clear(@start_log_inode);
   }

Result before applying patchset:

   @btrfs_log_inode_total_time: 622642

Result after applying patchset:

   @btrfs_log_inode_total_time: 354134    (-43.1% time spent)

The following dbench script was also used for testing:

   #!/bin/bash

   NUM_JOBS=$(nproc --all)

   DEV=/dev/nvme0n1
   MNT=/mnt/nvme0n1
   MOUNT_OPTIONS="-o ssd"
   MKFS_OPTIONS="-O no-holes -R free-space-tree"

   echo "performance" | \
       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

   umount $DEV &> /dev/null
   mkfs.btrfs -f $MKFS_OPTIONS $DEV
   mount $MOUNT_OPTIONS $DEV $MNT

   dbench -D $MNT --skip-cleanup -t 120 -S $NUM_JOBS

   umount $MNT

Before patchset:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    3322265     0.034    21.032
 Close        2440562     0.002     0.994
 Rename        140664     1.150   269.633
 Unlink        670796     1.093   269.678
 Deltree           96     5.481    15.510
 Mkdir             48     0.004     0.052
 Qpathinfo    3010924     0.014     8.127
 Qfileinfo     528055     0.001     0.518
 Qfsinfo       552113     0.003     0.372
 Sfileinfo     270575     0.005     0.688
 Find         1164176     0.052    13.931
 WriteX       1658537     0.019     5.918
 ReadX        5207412     0.003     1.034
 LockX          10818     0.003     0.079
 UnlockX        10818     0.002     0.313
 Flush         232811     1.027   269.735

Throughput 869.867 MB/sec (sync dirs)  12 clients  12 procs  max_latency=269.741 ms

After patchset:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    4152738     0.029    20.863
 Close        3050770     0.002     1.119
 Rename        175829     0.871   211.741
 Unlink        838447     0.845   211.724
 Deltree          120     4.798    14.162
 Mkdir             60     0.003     0.005
 Qpathinfo    3763807     0.011     4.673
 Qfileinfo     660111     0.001     0.400
 Qfsinfo       690141     0.003     0.429
 Sfileinfo     338260     0.005     0.725
 Find         1455273     0.046     6.787
 WriteX       2073307     0.017     5.690
 ReadX        6509193     0.003     1.171
 LockX          13522     0.003     0.077
 UnlockX        13522     0.002     0.125
 Flush         291044     0.811   211.631

Throughput 1089.27 MB/sec (sync dirs)  12 clients  12 procs  max_latency=211.750 ms

(+25.2% throughput, -21.5% max latency)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 149 +++++++++++----
 fs/btrfs/delayed-inode.h |  21 +-
 fs/btrfs/tree-log.c      | 403 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 522 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index b35eddcac846..2837b2dbd611 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -315,6 +315,8 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
 		item->bytes_reserved = 0;
 		item->delayed_node = node;
 		RB_CLEAR_NODE(&item->rb_node);
+		INIT_LIST_HEAD(&item->log_list);
+		item->logged = false;
 		refcount_set(&item->refs, 1);
 	}
 	return item;
@@ -1175,43 +1177,6 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_handle *trans, int nr)
 	return __btrfs_run_delayed_items(trans, nr);
 }
 
-int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
-				     struct btrfs_inode *inode)
-{
-	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
-	struct btrfs_path *path;
-	struct btrfs_block_rsv *block_rsv;
-	int ret;
-
-	if (!delayed_node)
-		return 0;
-
-	mutex_lock(&delayed_node->mutex);
-	if (!delayed_node->count) {
-		mutex_unlock(&delayed_node->mutex);
-		btrfs_release_delayed_node(delayed_node);
-		return 0;
-	}
-	mutex_unlock(&delayed_node->mutex);
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		btrfs_release_delayed_node(delayed_node);
-		return -ENOMEM;
-	}
-
-	block_rsv = trans->block_rsv;
-	trans->block_rsv = &delayed_node->root->fs_info->delayed_block_rsv;
-
-	ret = __btrfs_commit_inode_delayed_items(trans, path, delayed_node);
-
-	btrfs_release_delayed_node(delayed_node);
-	btrfs_free_path(path);
-	trans->block_rsv = block_rsv;
-
-	return ret;
-}
-
 int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -2045,3 +2010,113 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
 	}
 }
 
+void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
+				 struct list_head *ins_list,
+				 struct list_head *del_list)
+{
+	struct btrfs_delayed_node *node;
+	struct btrfs_delayed_item *item;
+
+	node = btrfs_get_delayed_node(inode);
+	if (!node)
+		return;
+
+	mutex_lock(&node->mutex);
+	item = __btrfs_first_delayed_insertion_item(node);
+	while (item) {
+		/*
+		 * It's possible that the item is already in a log list. This
+		 * can happen in case two tasks are trying to log the same
+		 * directory. For example if we have tasks A and task B:
+		 *
+		 * Task A collected the delayed items into a log list while
+		 * under the inode's log_mutex (at btrfs_log_inode()), but it
+		 * only releases the items after logging the inodes they point
+		 * to (if they are new inodes), which happens after unlocking
+		 * the log mutex;
+		 *
+		 * Task B enters btrfs_log_inode() and acquires the log_mutex
+		 * of the same directory inode, before task B releases the
+		 * delayed items. This can happen for example when logging some
+		 * inode we need to trigger logging of its parent directory, so
+		 * logging two files that have the same parent directory can
+		 * lead to this.
+		 *
+		 * If this happens, just ignore delayed items already in a log
+		 * list. All the tasks logging the directory are under a log
+		 * transaction and whichever finishes first can not sync the log
+		 * before the other completes and leaves the log transaction.
+		 */
+		if (!item->logged && list_empty(&item->log_list)) {
+			refcount_inc(&item->refs);
+			list_add_tail(&item->log_list, ins_list);
+		}
+		item = __btrfs_next_delayed_item(item);
+	}
+
+	item = __btrfs_first_delayed_deletion_item(node);
+	while (item) {
+		/* It may be non-empty, for the same reason mentioned above. */
+		if (!item->logged && list_empty(&item->log_list)) {
+			refcount_inc(&item->refs);
+			list_add_tail(&item->log_list, del_list);
+		}
+		item = __btrfs_next_delayed_item(item);
+	}
+	mutex_unlock(&node->mutex);
+
+	/*
+	 * We are called during inode logging, which means the inode is in use
+	 * and can not be evicted before we finish logging the inode. So we never
+	 * have the last reference on the delayed inode.
+	 * Also, we don't use btrfs_release_delayed_node() because that would
+	 * requeue the delayed inode (change its order in the list of prepared
+	 * nodes) and we don't want to do such change because we don't create or
+	 * delete delayed items.
+	 */
+	ASSERT(refcount_read(&node->refs) > 1);
+	refcount_dec(&node->refs);
+}
+
+void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
+				 struct list_head *ins_list,
+				 struct list_head *del_list)
+{
+	struct btrfs_delayed_node *node;
+	struct btrfs_delayed_item *item;
+	struct btrfs_delayed_item *next;
+
+	node = btrfs_get_delayed_node(inode);
+	if (!node)
+		return;
+
+	mutex_lock(&node->mutex);
+
+	list_for_each_entry_safe(item, next, ins_list, log_list) {
+		item->logged = true;
+		list_del_init(&item->log_list);
+		if (refcount_dec_and_test(&item->refs))
+			kfree(item);
+	}
+
+	list_for_each_entry_safe(item, next, del_list, log_list) {
+		item->logged = true;
+		list_del_init(&item->log_list);
+		if (refcount_dec_and_test(&item->refs))
+			kfree(item);
+	}
+
+	mutex_unlock(&node->mutex);
+
+	/*
+	 * We are called during inode logging, which means the inode is in use
+	 * and can not be evicted before we finish logging the inode. So we never
+	 * have the last reference on the delayed inode.
+	 * Also, we don't use btrfs_release_delayed_node() because that would
+	 * requeue the delayed inode (change its order in the list of prepared
+	 * nodes) and we don't want to do such change because we don't create or
+	 * delete delayed items.
+	 */
+	ASSERT(refcount_read(&node->refs) > 1);
+	refcount_dec(&node->refs);
+}
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 729d352ca8a1..95898ddc35e1 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -78,10 +78,21 @@ struct btrfs_delayed_item {
 	u64 index;
 	struct list_head tree_list;	/* used for batch insert/delete items */
 	struct list_head readdir_list;	/* used for readdir items */
+	/*
+	 * Used when logging a directory.
+	 * Insertions and deletions to this list are protected by the parent
+	 * delayed node's mutex.
+	 */
+	struct list_head log_list;
 	u64 bytes_reserved;
 	struct btrfs_delayed_node *delayed_node;
 	refcount_t refs;
 	enum btrfs_delayed_item_type type:1;
+	/*
+	 * Track if this delayed item was already logged.
+	 * Protected by the mutex of the parent delayed inode.
+	 */
+	bool logged;
 	/* The maximum leaf size is 64K, so u16 is more than enough. */
 	u16 data_len;
 	char data[];
@@ -115,8 +126,6 @@ int btrfs_run_delayed_items_nr(struct btrfs_trans_handle *trans, int nr);
 
 void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info);
 
-int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
-				     struct btrfs_inode *inode);
 /* Used for evicting the inode. */
 void btrfs_remove_delayed_node(struct btrfs_inode *inode);
 void btrfs_kill_delayed_inode_items(struct btrfs_inode *inode);
@@ -147,6 +156,14 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
 int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 				    struct list_head *ins_list);
 
+/* Used during directory logging. */
+void btrfs_log_get_delayed_items(struct btrfs_inode *inode,
+				 struct list_head *ins_list,
+				 struct list_head *del_list);
+void btrfs_log_put_delayed_items(struct btrfs_inode *inode,
+				 struct list_head *ins_list,
+				 struct list_head *del_list);
+
 /* for init */
 int __init btrfs_delayed_inode_init(void);
 void __cold btrfs_delayed_inode_exit(void);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 626c17392626..2b357b9549b3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5943,6 +5943,367 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int insert_delayed_items_batch(struct btrfs_trans_handle *trans,
+				      struct btrfs_root *log,
+				      struct btrfs_path *path,
+				      const struct btrfs_item_batch *batch,
+				      const struct btrfs_delayed_item *first_item)
+{
+	const struct btrfs_delayed_item *curr = first_item;
+	int ret;
+
+	ret = btrfs_insert_empty_items(trans, log, path, batch);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < batch->nr; i++) {
+		char *data_ptr;
+
+		data_ptr = btrfs_item_ptr(path->nodes[0], path->slots[0], char);
+		write_extent_buffer(path->nodes[0], &curr->data,
+				    (unsigned long)data_ptr, curr->data_len);
+		curr = list_next_entry(curr, log_list);
+		path->slots[0]++;
+	}
+
+	btrfs_release_path(path);
+
+	return 0;
+}
+
+static int log_delayed_insertion_items(struct btrfs_trans_handle *trans,
+				       struct btrfs_inode *inode,
+				       struct btrfs_path *path,
+				       const struct list_head *delayed_ins_list,
+				       struct btrfs_log_ctx *ctx)
+{
+	/* 195 (4095 bytes of keys and sizes) fits in a single 4K page. */
+	const int max_batch_size = 195;
+	const int leaf_data_size = BTRFS_LEAF_DATA_SIZE(trans->fs_info);
+	const u64 ino = btrfs_ino(inode);
+	struct btrfs_root *log = inode->root->log_root;
+	struct btrfs_item_batch batch = {
+		.nr = 0,
+		.total_data_size = 0,
+	};
+	const struct btrfs_delayed_item *first = NULL;
+	const struct btrfs_delayed_item *curr;
+	char *ins_data;
+	struct btrfs_key *ins_keys;
+	u32 *ins_sizes;
+	u64 curr_batch_size = 0;
+	int batch_idx = 0;
+	int ret;
+
+	/* We are adding dir index items to the log tree. */
+	lockdep_assert_held(&inode->log_mutex);
+
+	/*
+	 * We collect delayed items before copying index keys from the subvolume
+	 * to the log tree. However just after we collected them, they may have
+	 * been flushed (all of them or just some of them), and therefore we
+	 * could have copied them from the subvolume tree to the log tree.
+	 * So find the first delayed item that was not yet logged (they are
+	 * sorted by index number).
+	 */
+	list_for_each_entry(curr, delayed_ins_list, log_list) {
+		if (curr->index > inode->last_dir_index_offset) {
+			first = curr;
+			break;
+		}
+	}
+
+	/* Empty list or all delayed items were already logged. */
+	if (!first)
+		return 0;
+
+	ins_data = kmalloc(max_batch_size * sizeof(u32) +
+			   max_batch_size * sizeof(struct btrfs_key), GFP_NOFS);
+	if (!ins_data)
+		return -ENOMEM;
+	ins_sizes = (u32 *)ins_data;
+	batch.data_sizes = ins_sizes;
+	ins_keys = (struct btrfs_key *)(ins_data + max_batch_size * sizeof(u32));
+	batch.keys = ins_keys;
+
+	curr = first;
+	while (!list_entry_is_head(curr, delayed_ins_list, log_list)) {
+		const u32 curr_size = curr->data_len + sizeof(struct btrfs_item);
+
+		if (curr_batch_size + curr_size > leaf_data_size ||
+		    batch.nr == max_batch_size) {
+			ret = insert_delayed_items_batch(trans, log, path,
+							 &batch, first);
+			if (ret)
+				goto out;
+			batch_idx = 0;
+			batch.nr = 0;
+			batch.total_data_size = 0;
+			curr_batch_size = 0;
+			first = curr;
+		}
+
+		ins_sizes[batch_idx] = curr->data_len;
+		ins_keys[batch_idx].objectid = ino;
+		ins_keys[batch_idx].type = BTRFS_DIR_INDEX_KEY;
+		ins_keys[batch_idx].offset = curr->index;
+		curr_batch_size += curr_size;
+		batch.total_data_size += curr->data_len;
+		batch.nr++;
+		batch_idx++;
+		curr = list_next_entry(curr, log_list);
+	}
+
+	ASSERT(batch.nr >= 1);
+	ret = insert_delayed_items_batch(trans, log, path, &batch, first);
+
+	curr = list_last_entry(delayed_ins_list, struct btrfs_delayed_item,
+			       log_list);
+	inode->last_dir_index_offset = curr->index;
+out:
+	kfree(ins_data);
+
+	return ret;
+}
+
+static int log_delayed_deletions_full(struct btrfs_trans_handle *trans,
+				      struct btrfs_inode *inode,
+				      struct btrfs_path *path,
+				      const struct list_head *delayed_del_list,
+				      struct btrfs_log_ctx *ctx)
+{
+	const u64 ino = btrfs_ino(inode);
+	const struct btrfs_delayed_item *curr;
+
+	curr = list_first_entry(delayed_del_list, struct btrfs_delayed_item,
+				log_list);
+
+	while (!list_entry_is_head(curr, delayed_del_list, log_list)) {
+		u64 first_dir_index = curr->index;
+		u64 last_dir_index;
+		const struct btrfs_delayed_item *next;
+		int ret;
+
+		/*
+		 * Find a range of consecutive dir index items to delete. Like
+		 * this we log a single dir range item spanning several contiguous
+		 * dir items instead of logging one range item per dir index item.
+		 */
+		next = list_next_entry(curr, log_list);
+		while (!list_entry_is_head(next, delayed_del_list, log_list)) {
+			if (next->index != curr->index + 1)
+				break;
+			curr = next;
+			next = list_next_entry(next, log_list);
+		}
+
+		last_dir_index = curr->index;
+		ASSERT(last_dir_index >= first_dir_index);
+
+		ret = insert_dir_log_key(trans, inode->root->log_root, path,
+					 ino, first_dir_index, last_dir_index);
+		if (ret)
+			return ret;
+		curr = list_next_entry(curr, log_list);
+	}
+
+	return 0;
+}
+
+static int batch_delete_dir_index_items(struct btrfs_trans_handle *trans,
+					struct btrfs_inode *inode,
+					struct btrfs_path *path,
+					struct btrfs_log_ctx *ctx,
+					const struct list_head *delayed_del_list,
+					const struct btrfs_delayed_item *first,
+					const struct btrfs_delayed_item **last_ret)
+{
+	const struct btrfs_delayed_item *next;
+	struct extent_buffer *leaf = path->nodes[0];
+	const int last_slot = btrfs_header_nritems(leaf) - 1;
+	int slot = path->slots[0] + 1;
+	const u64 ino = btrfs_ino(inode);
+
+	next = list_next_entry(first, log_list);
+
+	while (slot < last_slot &&
+	       !list_entry_is_head(next, delayed_del_list, log_list)) {
+		struct btrfs_key key;
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		if (key.objectid != ino ||
+		    key.type != BTRFS_DIR_INDEX_KEY ||
+		    key.offset != next->index)
+			break;
+
+		slot++;
+		*last_ret = next;
+		next = list_next_entry(next, log_list);
+	}
+
+	return btrfs_del_items(trans, inode->root->log_root, path,
+			       path->slots[0], slot - path->slots[0]);
+}
+
+static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
+					     struct btrfs_inode *inode,
+					     struct btrfs_path *path,
+					     const struct list_head *delayed_del_list,
+					     struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_root *log = inode->root->log_root;
+	const struct btrfs_delayed_item *curr;
+	u64 last_range_start;
+	u64 last_range_end = 0;
+	struct btrfs_key key;
+
+	key.objectid = btrfs_ino(inode);
+	key.type = BTRFS_DIR_INDEX_KEY;
+	curr = list_first_entry(delayed_del_list, struct btrfs_delayed_item,
+				log_list);
+
+	while (!list_entry_is_head(curr, delayed_del_list, log_list)) {
+		const struct btrfs_delayed_item *last = curr;
+		u64 first_dir_index = curr->index;
+		u64 last_dir_index;
+		bool deleted_items = false;
+		int ret;
+
+		key.offset = curr->index;
+		ret = btrfs_search_slot(trans, log, &key, path, -1, 1);
+		if (ret < 0) {
+			return ret;
+		} else if (ret == 0) {
+			ret = batch_delete_dir_index_items(trans, inode, path, ctx,
+							   delayed_del_list, curr,
+							   &last);
+			if (ret)
+				return ret;
+			deleted_items = true;
+		}
+
+		btrfs_release_path(path);
+
+		/*
+		 * If we deleted items from the leaf, it means we have a range
+		 * item logging their range, so no need to add one or update an
+		 * existing one. Otherwise we have to log a dir range item.
+		 */
+		if (deleted_items)
+			goto next_batch;
+
+		last_dir_index = last->index;
+		ASSERT(last_dir_index >= first_dir_index);
+		/*
+		 * If this range starts right after where the previous one ends,
+		 * then we want to reuse the previous range item and change its
+		 * end offset to the end of this range. This is just to minimize
+		 * leaf space usage, by avoiding adding a new range item.
+		 */
+		if (last_range_end != 0 && first_dir_index == last_range_end + 1)
+			first_dir_index = last_range_start;
+
+		ret = insert_dir_log_key(trans, log, path, key.objectid,
+					 first_dir_index, last_dir_index);
+		if (ret)
+			return ret;
+
+		last_range_start = first_dir_index;
+		last_range_end = last_dir_index;
+next_batch:
+		curr = list_next_entry(last, log_list);
+	}
+
+	return 0;
+}
+
+static int log_delayed_deletion_items(struct btrfs_trans_handle *trans,
+				      struct btrfs_inode *inode,
+				      struct btrfs_path *path,
+				      const struct list_head *delayed_del_list,
+				      struct btrfs_log_ctx *ctx)
+{
+	/*
+	 * We are deleting dir index items from the log tree or adding range
+	 * items to it.
+	 */
+	lockdep_assert_held(&inode->log_mutex);
+
+	if (list_empty(delayed_del_list))
+		return 0;
+
+	if (ctx->logged_before)
+		return log_delayed_deletions_incremental(trans, inode, path,
+							 delayed_del_list, ctx);
+
+	return log_delayed_deletions_full(trans, inode, path, delayed_del_list,
+					  ctx);
+}
+
+/*
+ * Similar logic as for log_new_dir_dentries(), but it iterates over the delayed
+ * items instead of the subvolume tree.
+ */
+static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
+				    struct btrfs_inode *inode,
+				    const struct list_head *delayed_ins_list,
+				    struct btrfs_log_ctx *ctx)
+{
+	const bool orig_log_new_dentries = ctx->log_new_dentries;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_delayed_item *item;
+	int ret = 0;
+
+	/*
+	 * No need for the log mutex, plus to avoid potential deadlocks or
+	 * lockdep annotations due to nesting of delayed inode mutexes and log
+	 * mutexes.
+	 */
+	lockdep_assert_not_held(&inode->log_mutex);
+
+	list_for_each_entry(item, delayed_ins_list, log_list) {
+		struct btrfs_dir_item *dir_item;
+		struct inode *di_inode;
+		struct btrfs_key key;
+		int log_mode = LOG_INODE_EXISTS;
+
+		dir_item = (struct btrfs_dir_item *)item->data;
+		btrfs_disk_key_to_cpu(&key, &dir_item->location);
+
+		if (key.type == BTRFS_ROOT_ITEM_KEY)
+			continue;
+
+		di_inode = btrfs_iget(fs_info->sb, key.objectid, inode->root);
+		if (IS_ERR(di_inode)) {
+			ret = PTR_ERR(di_inode);
+			break;
+		}
+
+		if (!need_log_inode(trans, BTRFS_I(di_inode))) {
+			btrfs_add_delayed_iput(di_inode);
+			continue;
+		}
+
+		if (btrfs_stack_dir_type(dir_item) == BTRFS_FT_DIR)
+			log_mode = LOG_INODE_ALL;
+
+		ctx->log_new_dentries = false;
+		ret = btrfs_log_inode(trans, BTRFS_I(di_inode), log_mode, ctx);
+
+		if (!ret && ctx->log_new_dentries)
+			ret = log_new_dir_dentries(trans, BTRFS_I(di_inode), ctx);
+
+		btrfs_add_delayed_iput(di_inode);
+
+		if (ret)
+			break;
+	}
+
+	ctx->log_new_dentries = orig_log_new_dentries;
+
+	return ret;
+}
+
 /* log a single inode in the tree log.
  * At least one parent directory for this inode must exist in the tree
  * or be logged already.
@@ -5975,6 +6336,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	bool need_log_inode_item = true;
 	bool xattrs_logged = false;
 	bool inode_item_dropped = true;
+	LIST_HEAD(delayed_ins_list);
+	LIST_HEAD(delayed_del_list);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -6002,17 +6365,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		max_key.type = (u8)-1;
 	max_key.offset = (u64)-1;
 
-	/*
-	 * Only run delayed items if we are a directory. We want to make sure
-	 * all directory indexes hit the fs/subvolume tree so we can find them
-	 * and figure out which index ranges have to be logged.
-	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode)) {
-		ret = btrfs_commit_inode_delayed_items(trans, inode);
-		if (ret)
-			goto out;
-	}
-
 	mutex_lock(&inode->log_mutex);
 
 	/*
@@ -6117,6 +6469,16 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * If we are logging a directory in full mode, collect the delayed items
+	 * before iterating the subvolume tree, so that we don't miss any new
+	 * dir index items in case they get flushed while or right after we are
+	 * iterating the subvolume tree.
+	 */
+	if (S_ISDIR(inode->vfs_inode.i_mode) && inode_only == LOG_INODE_ALL)
+		btrfs_log_get_delayed_items(inode, &delayed_ins_list,
+					    &delayed_del_list);
+
 	ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
 				      path, dst_path, logged_isize,
 				      inode_only, ctx,
@@ -6176,6 +6538,14 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		ret = log_directory_changes(trans, inode, path, dst_path, ctx);
 		if (ret)
 			goto out_unlock;
+		ret = log_delayed_insertion_items(trans, inode, path,
+						  &delayed_ins_list, ctx);
+		if (ret)
+			goto out_unlock;
+		ret = log_delayed_deletion_items(trans, inode, path,
+						 &delayed_del_list, ctx);
+		if (ret)
+			goto out_unlock;
 	}
 
 	spin_lock(&inode->lock);
@@ -6224,7 +6594,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
-out:
+
 	btrfs_free_path(path);
 	btrfs_free_path(dst_path);
 
@@ -6233,6 +6603,15 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	else
 		ret = log_conflicting_inodes(trans, inode->root, ctx);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode) && inode_only == LOG_INODE_ALL) {
+		if (!ret)
+			ret = log_new_delayed_dentries(trans, inode,
+						       &delayed_ins_list, ctx);
+
+		btrfs_log_put_delayed_items(inode, &delayed_ins_list,
+					    &delayed_del_list);
+	}
+
 	return ret;
 }
 
-- 
2.35.1

