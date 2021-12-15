Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B243A4758B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 13:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbhLOMUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 07:20:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55426 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbhLOMUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 07:20:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28677618B3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1837CC34603
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639570808;
        bh=V11LP571KXvhlNEFqV2n1N/82jWI07pAVmHFMnkd5Rk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M3HxarJFS6TjNQJKZQHoLhVXHp5AsSp0G/4w+epMu2GhWCoTRbBBiC7JTwEuCm69X
         cw7geznxnWNBfhchZLmnsCEy33tV02h9wMeM7p0VdbpR4fV2J/eKlM1fM1MEVk1HcG
         jgLI8odXtxo9QFhl0R0xuWFhLIJe/7GZunr/U4Fd0GZtoJ65BgWQQWZAziMJH3cnQx
         uEnBZ11OqFwPGnZaK9JFvrhzHSq/uwe7oJ+CewVAZIw4cJgKd9rCT2uPLveJOQMWrD
         SNfRMCqjtR9skRRFb9brfGPIhngwHCOLBsZRkAs3WWn+mLdNkKg05GH6iMKvoYnPY2
         WaOd1yocwxQ4A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: stop copying old dir items when logging a directory
Date:   Wed, 15 Dec 2021 12:20:00 +0000
Message-Id: <1f35adc1f4e0725c33e293b5f5490be8e6d7f2c0.1639568906.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639568905.git.fdmanana@suse.com>
References: <cover.1639568905.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a directory, we go over every leaf of the subvolume tree that
was changed in the current transaction and copy all its dir index keys to
the log tree.

That includes copying dir index keys created in past transactions. This is
done mostly for simplicity, as after logging the keys we log an item that
specifies the start and end ranges of the keys we logged. That item is
then used during log replay to figure out which keys need to be deleted -
every key in that range that we find in the subvolume tree and is not in
the log tree, needs to be deleted.

Now that we log only dir index keys, and not dir item keys anymore, when
we remove dentries from a directory (due to unlink and rename operations),
we can get entire leaves that we changed only for deleting old dir index
keys, or that have few dir index keys that are new - this is due to the
fact that the offset for new index keys comes from a monotonically
increasing counter.

We can avoid logging dir index keys from past transactions, and in order
to track the deletions, only log range items (BTRFS_DIR_LOG_INDEX_KEY key
type) when we find gaps between consecutive index keys. This massively
reduces the amount of logged metadata when we have deleted directory
entries, even if it's a small percentage of the total number of entries.
The reduction comes from both less items that are logged and instead of
logging many dir index items (struct btrfs_dir_item), which have a size
of 30 bytes plus a file name, we typically log just a few range items
(struct btrfs_dir_log_item), which take only 8 bytes each.

Even if no entries were deleted from a directory and only new entries
were added, we typically still get a reduction on the amount of logged
metadata, because it's very likely the first leaf that got the new
dir index entries also has several old dir index entries.

So change the logging logic to not log dir index keys created in past
transactions and log a range item for every gap it finds between each
pair of consecutive index keys, to ensure deletions are tracked and
replayed on log replay.

This patch is part of a patchset comprised of the following patches:

 1/4 btrfs: don't log unnecessary boundary keys when logging directory
 2/4 btrfs: put initial index value of a directory in a constant
 3/4 btrfs: stop copying old dir items when logging a directory
 4/4 btrfs: stop trying to log subdirectories created in past transactions

The following test was run on a branch without this patchset and on a
branch with the first three patches applied:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1

  NUM_FILES=1000000
  NUM_FILE_DELETES=10000

  MKFS_OPTIONS="-O no-holes -R free-space-tree"
  MOUNT_OPTIONS="-o ssd"

  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  mkdir $MNT/testdir
  for ((i = 1; i <= $NUM_FILES; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  sync

  del_inc=$(( $NUM_FILES / $NUM_FILE_DELETES ))
  for ((i = 1; i <= $NUM_FILES; i += $del_inc)); do
      rm -f $MNT/testdir/file_$i
  done

  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/testdir
  end=$(date +%s%N)

  dur=$(( (end - start) / 1000000 ))
  echo "dir fsync took $dur ms after deleting $NUM_FILE_DELETES files"
  echo

  umount $MNT

The test was run on a non-debug kernel (Debian's default kernel config),
and the results were the following for various values of NUM_FILES and
NUM_FILE_DELETES:

** before, NUM_FILES = 1 000 000, NUM_FILE_DELETES = 10 000 **

dir fsync took 585 ms after deleting 10000 files

** after, NUM_FILES = 1 000 000, NUM_FILE_DELETES = 10 000 **

dir fsync took 34 ms after deleting 10000 files   (-94.2%)

** before, NUM_FILES = 100 000, NUM_FILE_DELETES = 1 000 **

dir fsync took 50 ms after deleting 1000 files

** after, NUM_FILES = 100 000, NUM_FILE_DELETES = 1 000 **

dir fsync took 7 ms after deleting 1000 files    (-86.0%)

** before, NUM_FILES = 10 000, NUM_FILE_DELETES = 100 **

dir fsync took 9 ms after deleting 100 files

** after, NUM_FILES = 10 000, NUM_FILE_DELETES = 100 **

dir fsync took 5 ms after deleting 100 files     (-44.4%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 83 +++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a80f14df5b81..7c239fedf192 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3702,7 +3702,8 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode *inode,
 				  struct btrfs_path *path,
 				  struct btrfs_path *dst_path,
-				  struct btrfs_log_ctx *ctx)
+				  struct btrfs_log_ctx *ctx,
+				  u64 *last_old_dentry_offset)
 {
 	struct btrfs_root *log = inode->root->log_root;
 	struct extent_buffer *src = path->nodes[0];
@@ -3715,6 +3716,7 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 	int i;
 
 	for (i = path->slots[0]; i < nritems; i++) {
+		struct btrfs_dir_item *di;
 		struct btrfs_key key;
 		int ret;
 
@@ -3725,7 +3727,34 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 			break;
 		}
 
+		di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
 		ctx->last_dir_item_offset = key.offset;
+
+		/*
+		 * Skip ranges of items that consist only of dir item keys created
+		 * in past transactions. However if we find a gap, we must log a
+		 * dir index range item for that gap, so that index keys in that
+		 * gap are deleted during log replay.
+		 */
+		if (btrfs_dir_transid(src, di) < trans->transid) {
+			if (key.offset > *last_old_dentry_offset + 1) {
+				ret = insert_dir_log_key(trans, log, dst_path,
+						 ino, *last_old_dentry_offset + 1,
+						 key.offset - 1);
+				/*
+				 * -EEXIST should never happen because when we
+				 * log a directory in full mode (LOG_INODE_ALL)
+				 * we drop all BTRFS_DIR_LOG_INDEX_KEY keys from
+				 * the log tree.
+				 */
+				ASSERT(ret != -EEXIST);
+				if (ret < 0)
+					return ret;
+			}
+
+			*last_old_dentry_offset = key.offset;
+			continue;
+		}
 		/*
 		 * We must make sure that when we log a directory entry, the
 		 * corresponding inode, after log replay, has a matching link
@@ -3749,14 +3778,10 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 		 * resulting in -ENOTEMPTY errors.
 		 */
 		if (!ctx->log_new_dentries) {
-			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
 
-			di = btrfs_item_ptr(src, i, struct btrfs_dir_item);
 			btrfs_dir_item_key_to_cpu(src, di, &di_key);
-			if ((btrfs_dir_transid(src, di) == trans->transid ||
-			     btrfs_dir_type(src, di) == BTRFS_FT_DIR) &&
-			    di_key.type != BTRFS_ROOT_ITEM_KEY)
+			if (di_key.type != BTRFS_ROOT_ITEM_KEY)
 				ctx->log_new_dentries = true;
 		}
 
@@ -3837,7 +3862,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	struct btrfs_root *log = root->log_root;
 	int err = 0;
 	int ret;
-	u64 first_offset = min_offset;
+	u64 last_old_dentry_offset = min_offset - 1;
 	u64 last_offset = (u64)-1;
 	u64 ino = btrfs_ino(inode);
 
@@ -3871,10 +3896,11 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		 */
 		if (ret == 0) {
 			struct btrfs_key tmp;
+
 			btrfs_item_key_to_cpu(path->nodes[0], &tmp,
 					      path->slots[0]);
 			if (tmp.type == BTRFS_DIR_INDEX_KEY)
-				first_offset = max(min_offset, tmp.offset) + 1;
+				last_old_dentry_offset = tmp.offset;
 		}
 		goto done;
 	}
@@ -3894,7 +3920,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		 * previous key's offset plus 1, so that those deletes are replayed.
 		 */
 		if (tmp.type == BTRFS_DIR_INDEX_KEY)
-			first_offset = tmp.offset + 1;
+			last_old_dentry_offset = tmp.offset;
 	}
 	btrfs_release_path(path);
 
@@ -3916,7 +3942,8 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	 * from our directory
 	 */
 	while (1) {
-		ret = process_dir_items_leaf(trans, inode, path, dst_path, ctx);
+		ret = process_dir_items_leaf(trans, inode, path, dst_path, ctx,
+					     &last_old_dentry_offset);
 		if (ret != 0) {
 			if (ret < 0)
 				err = ret;
@@ -3967,13 +3994,21 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	if (err == 0) {
 		*last_offset_ret = last_offset;
 		/*
-		 * insert the log range keys to indicate where the log
-		 * is valid
+		 * In case the leaf was changed in the current transaction but
+		 * all its dir items are from a past transaction, the last item
+		 * in the leaf is a dir item and there's no gap between that last
+		 * dir item and the first one on the next leaf (which did not
+		 * change in the current transaction), then we don't need to log
+		 * a range, last_old_dentry_offset is == to last_offset.
 		 */
-		ret = insert_dir_log_key(trans, log, path, ino, first_offset,
-					 last_offset);
-		if (ret)
-			err = ret;
+		ASSERT(last_old_dentry_offset <= last_offset);
+		if (last_old_dentry_offset < last_offset) {
+			ret = insert_dir_log_key(trans, log, path, ino,
+						 last_old_dentry_offset + 1,
+						 last_offset);
+			if (ret)
+				err = ret;
+		}
 	}
 	return err;
 }
@@ -4015,7 +4050,7 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 	if (inode->logged_trans != trans->transid)
 		inode->last_dir_index_offset = (u64)-1;
 
-	min_key = 0;
+	min_key = BTRFS_DIR_START_INDEX;
 	max_key = 0;
 	ctx->last_dir_item_offset = inode->last_dir_index_offset;
 
@@ -5869,7 +5904,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_root *log = root->log_root;
 	struct btrfs_path *path;
 	LIST_HEAD(dir_list);
 	struct btrfs_dir_list *dir_elem;
@@ -5911,7 +5945,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 		min_key.offset = 0;
 again:
 		btrfs_release_path(path);
-		ret = btrfs_search_forward(log, &min_key, path, trans->transid);
+		ret = btrfs_search_forward(root, &min_key, path, trans->transid);
 		if (ret < 0) {
 			goto next_dir_inode;
 		} else if (ret > 0) {
@@ -5919,7 +5953,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			goto next_dir_inode;
 		}
 
-process_leaf:
 		leaf = path->nodes[0];
 		nritems = btrfs_header_nritems(leaf);
 		for (i = path->slots[0]; i < nritems; i++) {
@@ -5976,16 +6009,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			}
 			break;
 		}
-		if (i == nritems) {
-			ret = btrfs_next_leaf(log, path);
-			if (ret < 0) {
-				goto next_dir_inode;
-			} else if (ret > 0) {
-				ret = 0;
-				goto next_dir_inode;
-			}
-			goto process_leaf;
-		}
 		if (min_key.offset < (u64)-1) {
 			min_key.offset++;
 			goto again;
-- 
2.33.0

