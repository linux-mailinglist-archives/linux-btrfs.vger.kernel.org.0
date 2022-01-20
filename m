Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF0494C62
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiATLA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiATLAV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38876C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD6A6B81D39
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFD8C340E5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676418;
        bh=JPP/o3oewcK0XsVLhEhLAxivRCqv/hX0fZFZCkFerNM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QhlgHUUdskhmaOQwL7rLiLKeUbtwywhJrlnpFiz1+UZ/xhc9HmU5l6xHglVNuII35
         KTI2BBh0+mhI0WEJzJs+vfLV0qjrv19tNkgCUQk5vBumpMEaezMpEym5b7YMQu95RW
         jt2huzAINYo+uR0PvC668YYzAmwFCgtQ3d9K7IoAEsV2UBJJlwvOHrST54yN2T44Ui
         jLoz5c26zLW6RGfRQblhy3g+lITZ5yfF8s45c0yNYCkWaAMCZRRMtMr5Hm4AGulFQi
         bmIWg+lGX3UWjghkdVaNmk4i1tXogLNxinJA40JjcopP8KKhUsi9DGXeyZ8N5nIuxm
         PamHIK0WRZQQg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: stop doing unnecessary log updates during a rename
Date:   Thu, 20 Jan 2022 11:00:09 +0000
Message-Id: <9da2666e21f4a55834c422c8d00f4592e9eed741.1642676248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642676248.git.fdmanana@suse.com>
References: <cover.1642676248.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a rename, we call __btrfs_unlink_inode(), which will call
btrfs_del_inode_ref_in_log() and btrfs_del_dir_entries_in_log(), in order
to remove an inode reference and a directory entry from the log. These
are necessary when __btrfs_unlink_inode() is called from the unlink path,
but not necessary when it's called from a rename context, because:

1) For the btrfs_del_inode_ref_in_log() call, it's pointless to delete the
   inode reference related to the old name, because later in the rename
   path we call btrfs_log_new_name(), which will drop all inode references
   from the log and copy all inode references from the subvolume tree to
   the log tree. So we are doing one unnecessary btree operation which
   adds additional latency and lock contention in case there are other
   tasks accessing the log tree;

2) For the btrfs_del_dir_entries_in_log() call, we are now doing the
   equivalent at btrfs_log_new_name() since the previous patch in the
   series, that has the subject "btrfs: avoid logging all directory
   changes during renames". In fact, having __btrfs_unlink_inode() call
   this function not only adds additional latency and lock contention due
   to the extra btree operation, but also can make btrfs_log_new_name()
   unnecessarily log a range item to track the deletion of the old name,
   since it has no way to known that the directory entry related to the
   old name was previously logged and already deleted by
   __btrfs_unlink_inode() through its call to
   btrfs_del_dir_entries_in_log().

So skip those calls at __btrfs_unlink_inode() when we are doing a rename.
Skipping them also allows us now to reduce the duration of time we are
pinning a log transaction during renames, which is always beneficial as
it's not delaying so much other tasks trying to sync the log tree, in
particular we end up not holding the log transaction pinned while adding
the new name (adding inode ref, directory entry, etc).

This change is part of a patchset comprised of the following patches:

  1/5 btrfs: add helper to delete a dir entry from a log tree
  2/5 btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
  3/5 btrfs: avoid logging all directory changes during renames
  4/5 btrfs: stop doing unnecessary log updates during a rename
  5/5 btrfs: avoid inode logging during rename and link when possible

Just like the previous patch in the series, "btrfs: avoid logging all
directory changes during renames", the following script mimics part of
what a package installation/upgrade with zypper does, which is basically
renaming a lot of files, in some directory under /usr, to a name with a
suffix of "-RPMDELETE":

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1

  NUM_FILES=10000

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  mkdir $MNT/testdir

  for ((i = 1; i <= $NUM_FILES; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  sync

  # Do some change to testdir and fsync it.
  echo -n > $MNT/testdir/file_$((NUM_FILES + 1))
  xfs_io -c "fsync" $MNT/testdir

  echo "Renaming $NUM_FILES files..."
  start=$(date +%s%N)
  for ((i = 1; i <= $NUM_FILES; i++)); do
      mv $MNT/testdir/file_$i $MNT/testdir/file_$i-RPMDELETE
  done
  end=$(date +%s%N)

  dur=$(( (end - start) / 1000000 ))
  echo "Renames took $dur milliseconds"

  umount $MNT

Testing this change on box a using a non-debug kernel (Debian's default
kernel config) gave the following results:

NUM_FILES=10000, before patchset:                   27399 ms
NUM_FILES=10000, after patches 1/5 to 3/5 applied:   9093 ms (-66.8%)
NUM_FILES=10000, after patches 1/5 to 4/5 applied:   9016 ms (-67.1%)

NUM_FILES=5000, before patchset:                     9241 ms
NUM_FILES=5000, after patches 1/5 to 3/5 applied:    4642 ms (-49.8%)
NUM_FILES=5000, after patches 1/5 to 4/5 applied:    4553 ms (-50.7%)

NUM_FILES=2000, before patchset:                     2550 ms
NUM_FILES=2000, after patches 1/5 to 3/5 applied:    1788 ms (-29.9%)
NUM_FILES=2000, after patches 1/5 to 4/5 applied:    1767 ms (-30.7%)

NUM_FILES=1000, before patchset:                     1088 ms
NUM_FILES=1000, after patches 1/5 to 3/5 applied:     905 ms (-16.9%)
NUM_FILES=1000, after patches 1/5 to 4/5 applied:     883 ms (-18.8%)

The next patch in the series (5/5), also contains dbench results after
applying to whole patchset.

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    | 140 ++++++++++----------------------------------
 fs/btrfs/tree-log.c |  34 ++++++++---
 2 files changed, 59 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d30b7b9a521..4f51ab6e7cc0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4133,9 +4133,18 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto err;
 	}
 
-	btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
-				   dir_ino);
-	btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir, index);
+	/*
+	 * If we are in a rename context, we don't need to update anything in the
+	 * log. That will be done later during the rename by btrfs_log_new_name().
+	 * Besides that, doing it here would only cause extra unncessary btree
+	 * operations on the log tree, increasing latency for applications.
+	 */
+	if (!rename_ctx) {
+		btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
+					   dir_ino);
+		btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir,
+					     index);
+	}
 
 	/*
 	 * If we have a pending delayed iput we could end up with the final iput
@@ -9013,8 +9022,6 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	u64 new_idx = 0;
 	int ret;
 	int ret2;
-	bool root_log_pinned = false;
-	bool dest_log_pinned = false;
 	bool need_abort = false;
 
 	/*
@@ -9117,29 +9124,6 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 				BTRFS_I(new_inode), 1);
 	}
 
-	/*
-	 * Now pin the logs of the roots. We do it to ensure that no other task
-	 * can sync the logs while we are in progress with the rename, because
-	 * that could result in an inconsistency in case any of the inodes that
-	 * are part of this rename operation were logged before.
-	 *
-	 * We pin the logs even if at this precise moment none of the inodes was
-	 * logged before. This is because right after we checked for that, some
-	 * other task fsyncing some other inode not involved with this rename
-	 * operation could log that one of our inodes exists.
-	 *
-	 * We don't need to pin the logs before the above calls to
-	 * btrfs_insert_inode_ref(), since those don't ever need to change a log.
-	 */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID) {
-		btrfs_pin_log_trans(root);
-		root_log_pinned = true;
-	}
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID) {
-		btrfs_pin_log_trans(dest);
-		dest_log_pinned = true;
-	}
-
 	/* src is a subvolume */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
@@ -9195,46 +9179,31 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	if (new_inode->i_nlink == 1)
 		BTRFS_I(new_inode)->dir_index = new_idx;
 
-	if (root_log_pinned) {
+	/*
+	 * Now pin the logs of the roots. We do it to ensure that no other task
+	 * can sync the logs while we are in progress with the rename, because
+	 * that could result in an inconsistency in case any of the inodes that
+	 * are part of this rename operation were logged before.
+	 */
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+		btrfs_pin_log_trans(root);
+	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
+		btrfs_pin_log_trans(dest);
+
+	/* Do the log updates for all inodes. */
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   old_rename_ctx.index, new_dentry->d_parent);
-		btrfs_end_log_trans(root);
-		root_log_pinned = false;
-	}
-	if (dest_log_pinned) {
+	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
 				   new_rename_ctx.index, old_dentry->d_parent);
+
+	/* Now unpin the logs. */
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+		btrfs_end_log_trans(root);
+	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_end_log_trans(dest);
-		dest_log_pinned = false;
-	}
 out_fail:
-	/*
-	 * If we have pinned a log and an error happened, we unpin tasks
-	 * trying to sync the log and force them to fallback to a transaction
-	 * commit if the log currently contains any of the inodes involved in
-	 * this rename operation (to ensure we do not persist a log with an
-	 * inconsistent state for any of these inodes or leading to any
-	 * inconsistencies when replayed). If the transaction was aborted, the
-	 * abortion reason is propagated to userspace when attempting to commit
-	 * the transaction. If the log does not contain any of these inodes, we
-	 * allow the tasks to sync it.
-	 */
-	if (ret && (root_log_pinned || dest_log_pinned)) {
-		if (btrfs_inode_in_log(BTRFS_I(old_dir), fs_info->generation) ||
-		    btrfs_inode_in_log(BTRFS_I(new_dir), fs_info->generation) ||
-		    btrfs_inode_in_log(BTRFS_I(old_inode), fs_info->generation) ||
-		    btrfs_inode_in_log(BTRFS_I(new_inode), fs_info->generation))
-			btrfs_set_log_full_commit(trans);
-
-		if (root_log_pinned) {
-			btrfs_end_log_trans(root);
-			root_log_pinned = false;
-		}
-		if (dest_log_pinned) {
-			btrfs_end_log_trans(dest);
-			dest_log_pinned = false;
-		}
-	}
 	ret2 = btrfs_end_transaction(trans);
 	ret = ret ? ret : ret2;
 out_notrans:
@@ -9314,7 +9283,6 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	int ret;
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
-	bool log_pinned = false;
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -9419,25 +9387,6 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else {
-		/*
-		 * Now pin the log. We do it to ensure that no other task can
-		 * sync the log while we are in progress with the rename, as
-		 * that could result in an inconsistency in case any of the
-		 * inodes that are part of this rename operation were logged
-		 * before.
-		 *
-		 * We pin the log even if at this precise moment none of the
-		 * inodes was logged before. This is because right after we
-		 * checked for that, some other task fsyncing some other inode
-		 * not involved with this rename operation could log that one of
-		 * our inodes exists.
-		 *
-		 * We don't need to pin the logs before the above call to
-		 * btrfs_insert_inode_ref(), since that does not need to change
-		 * a log.
-		 */
-		btrfs_pin_log_trans(root);
-		log_pinned = true;
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
 					old_dentry->d_name.name,
@@ -9484,12 +9433,9 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (old_inode->i_nlink == 1)
 		BTRFS_I(old_inode)->dir_index = index;
 
-	if (log_pinned) {
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   rename_ctx.index, new_dentry->d_parent);
-		btrfs_end_log_trans(root);
-		log_pinned = false;
-	}
 
 	if (flags & RENAME_WHITEOUT) {
 		ret = btrfs_whiteout_for_rename(trans, root, mnt_userns,
@@ -9501,28 +9447,6 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		}
 	}
 out_fail:
-	/*
-	 * If we have pinned the log and an error happened, we unpin tasks
-	 * trying to sync the log and force them to fallback to a transaction
-	 * commit if the log currently contains any of the inodes involved in
-	 * this rename operation (to ensure we do not persist a log with an
-	 * inconsistent state for any of these inodes or leading to any
-	 * inconsistencies when replayed). If the transaction was aborted, the
-	 * abortion reason is propagated to userspace when attempting to commit
-	 * the transaction. If the log does not contain any of these inodes, we
-	 * allow the tasks to sync it.
-	 */
-	if (ret && log_pinned) {
-		if (btrfs_inode_in_log(BTRFS_I(old_dir), fs_info->generation) ||
-		    btrfs_inode_in_log(BTRFS_I(new_dir), fs_info->generation) ||
-		    btrfs_inode_in_log(BTRFS_I(old_inode), fs_info->generation) ||
-		    (new_inode &&
-		     btrfs_inode_in_log(BTRFS_I(new_inode), fs_info->generation)))
-			btrfs_set_log_full_commit(trans);
-
-		btrfs_end_log_trans(root);
-		log_pinned = false;
-	}
 	ret2 = btrfs_end_transaction(trans);
 	ret = ret ? ret : ret2;
 out_notrans:
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9784a906f369..bf529c6cb3ff 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6771,7 +6771,10 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			u64 old_dir_index, struct dentry *parent)
 {
 	struct btrfs_inode *inode = BTRFS_I(d_inode(old_dentry));
+	struct btrfs_root *root = inode->root;
 	struct btrfs_log_ctx ctx;
+	bool log_pinned = false;
+	int ret = 0;
 
 	/*
 	 * this will force the logging code to walk the dentry chain
@@ -6798,14 +6801,22 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	if (old_dir && old_dir->logged_trans == trans->transid) {
 		struct btrfs_root *log = old_dir->root->log_root;
 		struct btrfs_path *path;
-		int ret;
 
 		ASSERT(old_dir_index >= BTRFS_DIR_START_INDEX);
 
+		/*
+		 * We have two inodes to update in the log, the old directory and
+		 * the inode that got renamed, so we must pin the log to prevent
+		 * anyone from syncing the log until we have updated both inodes
+		 * in the log.
+		 */
+		log_pinned = true;
+		btrfs_pin_log_trans(root);
+
 		path = btrfs_alloc_path();
 		if (!path) {
-			btrfs_set_log_full_commit(trans);
-			return;
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		ret = del_logged_dentry(trans, log, path, btrfs_ino(old_dir),
@@ -6823,10 +6834,8 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_free_path(path);
-		if (ret < 0) {
-			btrfs_set_log_full_commit(trans);
-			return;
-		}
+		if (ret < 0)
+			goto out;
 	}
 
 	btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
@@ -6839,5 +6848,16 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * inconsistent state after a rename operation.
 	 */
 	btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
+out:
+	if (log_pinned) {
+		/*
+		 * If an error happened mark the log for a full commit because
+		 * it's not consistent and up to date. Do it before unpinning the
+		 * log, to avoid any races with someone else trying to commit it.
+		 */
+		if (ret < 0)
+			btrfs_set_log_full_commit(trans);
+		btrfs_end_log_trans(root);
+	}
 }
 
-- 
2.33.0

