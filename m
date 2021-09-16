Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4940D773
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhIPKdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 06:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236569AbhIPKdl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 06:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02DA36120E
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631788341;
        bh=xGfVYb3tTttFJoItX2xJJLGCARxkbI/KL+ZpsEh8N5w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IxOa2pg5POtKzCjnxuRhaDdCUWW/qCa3P6emmyv1rKx+qKIOSdJYlCPSGn3OudCYM
         J2uqAhYfLkk3Y/CZqhrs4WRRp0Dk4C0M1Mjcyii3wOmOQWtnHQT7vPoY3jdT53p4sS
         mg5JrRLis9fLNoniwx3bU2KK8AtemxIxntBZD83efIaxr+W0+BqtMbaMP2VrfqhW3P
         eKdeOyIHAndckL6Khu9T9V9rkpX7qwoA2KUFR/XPLOrsNjAK4a3QvcgIDDNe7fnT29
         N0vb8HR26KkwT8A25ODLu+MPvzU2iv3KHCJ+1E6TEjCa1sAVaa3Ba7OTMZ6odctMOn
         1JO/OfIUo8Mmw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: keep track of the last logged keys when logging a directory
Date:   Thu, 16 Sep 2021 11:32:14 +0100
Message-Id: <594ddba9ad74f43b02f2a58d37b3aac50a6b52b1.1631787796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631787796.git.fdmanana@suse.com>
References: <cover.1631787796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the first time we log a directory in the current transaction, for
each directory item in a changed leaf of the subvolume tree, we have to
check if we previously logged the item, in order to overwrite it in case
its data changed or skip it in case its data hasn't changed.

Checking if we have logged each item before not only wastes times, but it
also adds lock contention on the log tree. So in order to minimize the
number of times we do such checks, keep track of the offset of the last
key we logged for a directory and, on the next time we log the directory,
skip the checks for any new keys that have an offset greater than the
offset we have previously saved. This is specially effective for index
keys, because the offset for these keys comes from a monotonically
increasing counter.

This patch is part of a patchset comprised of the following 5 patches:

  btrfs: remove root argument from btrfs_log_inode() and its callees
  btrfs: remove redundant log root assignment from log_dir_items()
  btrfs: factor out the copying loop of dir items from log_dir_items()
  btrfs: insert items in batches when logging a directory when possible
  btrfs: keep track of the last logged keys when logging a directory

This is patch 5/5.

The following test was used on a non-debug kernel to measure the impact
it has on a directory fsync:

  $ cat test-dir-fsync.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1

  NUM_NEW_FILES=100000
  NUM_FILE_DELETES=1000

  mkfs.btrfs -f $DEV
  mount -o ssd $DEV $MNT

  mkdir $MNT/testdir

  for ((i = 1; i <= $NUM_NEW_FILES; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  # fsync the directory, this will log the new dir items and the inodes
  # they point to, because these are new inodes.
  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/testdir
  end=$(date +%s%N)

  dur=$(( (end - start) / 1000000 ))
  echo "dir fsync took $dur ms after adding $NUM_NEW_FILES files"

  # sync to force transaction commit and wipeout the log.
  sync

  del_inc=$(( $NUM_NEW_FILES / $NUM_FILE_DELETES ))
  for ((i = 1; i <= $NUM_NEW_FILES; i += $del_inc)); do
      rm -f $MNT/testdir/file_$i
  done

  # fsync the directory, this will only log dir items, there are no
  # dentries pointing to new inodes.
  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/testdir
  end=$(date +%s%N)

  dur=$(( (end - start) / 1000000 ))
  echo "dir fsync took $dur ms after deleting $NUM_FILE_DELETES files"

  umount $MNT

Test results with NUM_NEW_FILES set to 100 000 and 1 000 000:

**** before patchset, 100 000 files, 1000 deletes ****

dir fsync took 848 ms after adding 100000 files
dir fsync took 175 ms after deleting 1000 files

**** after patchset, 100 000 files, 1000 deletes ****

dir fsync took 758 ms after adding 100000 files  (-11.2%)
dir fsync took 63 ms after deleting 1000 files   (-94.1%)

**** before patchset, 1 000 000 files, 1000 deletes ****

dir fsync took 9945 ms after adding 1000000 files
dir fsync took 473 ms after deleting 1000 files

**** after patchset, 1 000 000 files, 1000 deletes ****

dir fsync took 8677 ms after adding 1000000 files (-13.6%)
dir fsync took 146 ms after deleting 1000 files   (-105.6%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 39 ++++++++++++++++++++++++++++-----------
 fs/btrfs/inode.c       |  6 ++++--
 fs/btrfs/tree-log.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-log.h    |  2 ++
 4 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 76ee1452c57b..602b426c286d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -138,17 +138,34 @@ struct btrfs_inode {
 	/* a local copy of root's last_log_commit */
 	int last_log_commit;
 
-	/* total number of bytes pending delalloc, used by stat to calc the
-	 * real block usage of the file
-	 */
-	u64 delalloc_bytes;
-
-	/*
-	 * Total number of bytes pending delalloc that fall within a file
-	 * range that is either a hole or beyond EOF (and no prealloc extent
-	 * exists in the range). This is always <= delalloc_bytes.
-	 */
-	u64 new_delalloc_bytes;
+	union {
+		/*
+		 * Total number of bytes pending delalloc, used by stat to
+		 * calculate the real block usage of the file. This is used
+		 * only for files.
+		 */
+		u64 delalloc_bytes;
+		/*
+		 * The offset of the last dir item key that was logged.
+		 * This is used only for directories.
+		 */
+		u64 last_dir_item_offset;
+	};
+
+	union {
+		/*
+		 * Total number of bytes pending delalloc that fall within a file
+		 * range that is either a hole or beyond EOF (and no prealloc extent
+		 * exists in the range). This is always <= delalloc_bytes and this
+		 * is used only for files.
+		 */
+		u64 new_delalloc_bytes;
+		/*
+		 * The offset of the last dir index key that was logged.
+		 * This is used only for directories.
+		 */
+		u64 last_dir_index_offset;
+	};
 
 	/*
 	 * total number of bytes pending defrag, used by stat to check whether
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a3ce50289888..a82c14d637f3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9155,8 +9155,10 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	WARN_ON(inode->block_rsv.reserved);
 	WARN_ON(inode->block_rsv.size);
 	WARN_ON(inode->outstanding_extents);
-	WARN_ON(inode->delalloc_bytes);
-	WARN_ON(inode->new_delalloc_bytes);
+	if (!S_ISDIR(vfs_inode->i_mode)) {
+		WARN_ON(inode->delalloc_bytes);
+		WARN_ON(inode->new_delalloc_bytes);
+	}
 	WARN_ON(inode->csum_bytes);
 	WARN_ON(inode->defrag_bytes);
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 66b1516a7a6a..30590ddd69ac 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3717,11 +3717,17 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 	const int nritems = btrfs_header_nritems(src);
 	const u64 ino = btrfs_ino(inode);
 	const bool inode_logged_before = inode_logged(trans, inode);
+	u64 last_logged_key_offset;
 	bool last_found = false;
 	int batch_start = 0;
 	int batch_size = 0;
 	int i;
 
+	if (key_type == BTRFS_DIR_ITEM_KEY)
+		last_logged_key_offset = inode->last_dir_item_offset;
+	else
+		last_logged_key_offset = inode->last_dir_index_offset;
+
 	for (i = path->slots[0]; i < nritems; i++) {
 		struct btrfs_key key;
 		int ret;
@@ -3733,6 +3739,7 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 			break;
 		}
 
+		ctx->last_dir_item_offset = key.offset;
 		/*
 		 * We must make sure that when we log a directory entry, the
 		 * corresponding inode, after log replay, has a matching link
@@ -3769,6 +3776,15 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 
 		if (!inode_logged_before)
 			goto add_to_batch;
+
+		/*
+		 * If we were logged before and have logged dir items, we can skip
+		 * checking if any item with a key offset larger than the last one
+		 * we logged is in the log tree, saving time and avoiding adding
+		 * contention on the log tree.
+		 */
+		if (key.offset > last_logged_key_offset)
+			goto add_to_batch;
 		/*
 		 * Check if the key was already logged before. If not we can add
 		 * it to a batch for bulk insertion.
@@ -3995,9 +4011,31 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 	int ret;
 	int key_type = BTRFS_DIR_ITEM_KEY;
 
+	/*
+	 * If this is the first time we are being logged in the current
+	 * transaction, or we were logged before but the inode was evicted and
+	 * reloaded later, in which case its logged_trans is 0, reset the values
+	 * of the last logged key offsets. Note that we don't use the helper
+	 * function inode_logged() here - that is because the function returns
+	 * true after an inode eviction, assuming the worst case as it can not
+	 * know for sure if the inode was logged before. So we can not skip key
+	 * searches in the case the inode was evicted, because it may not have
+	 * been logged in this transaction and may have been logged in a past
+	 * transaction, so we need to reset the last dir item and index offsets
+	 * to (u64)-1.
+	 */
+	if (inode->logged_trans != trans->transid) {
+		inode->last_dir_item_offset = (u64)-1;
+		inode->last_dir_index_offset = (u64)-1;
+	}
 again:
 	min_key = 0;
 	max_key = 0;
+	if (key_type == BTRFS_DIR_ITEM_KEY)
+		ctx->last_dir_item_offset = inode->last_dir_item_offset;
+	else
+		ctx->last_dir_item_offset = inode->last_dir_index_offset;
+
 	while (1) {
 		ret = log_dir_items(trans, inode, path, dst_path, key_type,
 				ctx, min_key, &max_key);
@@ -4009,8 +4047,11 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 	}
 
 	if (key_type == BTRFS_DIR_ITEM_KEY) {
+		inode->last_dir_item_offset = ctx->last_dir_item_offset;
 		key_type = BTRFS_DIR_INDEX_KEY;
 		goto again;
+	} else {
+		inode->last_dir_index_offset = ctx->last_dir_item_offset;
 	}
 	return 0;
 }
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 731bd9c029f5..3ce6bdb76009 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -17,6 +17,8 @@ struct btrfs_log_ctx {
 	int log_transid;
 	bool log_new_dentries;
 	bool logging_new_name;
+	/* Tracks the last logged dir item/index key offset. */
+	u64 last_dir_item_offset;
 	struct inode *inode;
 	struct list_head list;
 	/* Only used for fast fsyncs. */
-- 
2.33.0

