Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F204494C60
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiATLAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:00:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46816 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiATLAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBB35B81D37
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1707AC340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642676417;
        bh=nR7USJ5VvOAS7fVqBNJWmPKvTaOWRJetLX1l5viCblM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F//j4wx/dU57QVbqmAs9bDKaKylF0STz0Aw1QQibWEzcGaVii+pmPDpJ7UTc76fph
         daL/sRn1C16Bm1CoJJaXa4uYKTZDJtu2V9idLAO0520pgiHEDgkr6D3i3tmtHCllfc
         1iFrKKMVeQKnVXbmtR2xdvcA9/FLoT42Ck9l+2KJ2hDPhVo2GjaSXwdP+CjX1/0VQB
         5CEGMv8l8XPQDEkamvx+LyduxQ4AbxGdA5m578faLS2qgJvdb8JiTUk5iHvax+tSiX
         LdtKUUCbZx1RrGKHI1xYRclwnDglSrBRpP/GH9EradZJGt8rpCLdkHRm+ZWwX36XH2
         D/u4IDznwN4uA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: avoid logging all directory changes during renames
Date:   Thu, 20 Jan 2022 11:00:08 +0000
Message-Id: <285785ef66283fb6b00fe69112dc1240a2aa1e19.1642676248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642676248.git.fdmanana@suse.com>
References: <cover.1642676248.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a rename of a file, if the file or its old parent directory
were logged before, we log the new name of the file and then make sure
we log the old parent directory, to ensure that after a log replay the
old name of the file is deleted and the new name added.

The logging of the old parent directory can take some time, because it
will scan all leaves modified in the current transaction, check which
directries entries were already logged, copy the ones that were not
logged before, etc. In this rename context all we need to do is make
sure that the old name of the file is deleted on log replay, so instead
of triggering a directory log operation, we can just delete the old
directory entry from the log if it's there, or in case it isn't there,
just log a range item to signal log replay that the old name must be
deleted. So change btrfs_log_new_name() to do that.

This scenario is actually not uncommon to trigger, and recently on a
5.15 kernel, an openSUSE Tumbleweed user reported package installations
and upgrades, with the zypper tool, were often taking a long time to
complete, much more than usual. With strace it could be observed that
zypper was spending over 99% of its time on rename operations, and then
with further analysis we checked that directory logging was happening
too frequently and causing high latencies for the rename operations.
Taking into account that installation/upgrade of some of these packages
needed about a few thousand file renames, the slowdown was very noticeable
for the user.

The issue was caused indirectly due to an excessive number of inode
evictions on a 5.15 kernel, about 100x more compared to a 5.13, 5.14
or a 5.16-rc8 kernel. After an inode eviction we can't tell for sure,
in an efficient way, if an inode was previously logged in the current
transaction, so we are pessimistic and assume it was, because in case
it was we need to update the logged inode. More details on that in one
of the patches in the same series (subject "btrfs: avoid inode logging
during rename and link when possible"). Either way, in case the parent
directory was logged before, we currently do more work then necessary
during a rename, and this change minimizes that amount of work.

The following script mimics part of what a package installation/upgrade
with zypper does, which is basically renaming a lot of files, in some
directory under /usr, to a name with a suffix of "-RPMDELETE":

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

Testing this change on box using a non-debug kernel (Debian's default
kernel config) gave the following results:

NUM_FILES=10000, before this patch: 27399 ms
NUM_FILES=10000, after this patch:   9093 ms (-66.8%)

NUM_FILES=5000, before this patch:   9241 ms
NUM_FILES=5000, after this patch:    4642 ms (-49.8%)

NUM_FILES=2000, before this patch:   2550 ms
NUM_FILES=2000, after this patch:    1788 ms (-29.9%)

NUM_FILES=1000, before this patch:   1088 ms
NUM_FILES=1000, after this patch:     905 ms (-16.9%)

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    | 33 +++++++++++++++++++--------
 fs/btrfs/tree-log.c | 55 +++++++++++++++++++++++++++++++++------------
 fs/btrfs/tree-log.h |  2 +-
 3 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 023041579a79..7d30b7b9a521 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -66,6 +66,11 @@ struct btrfs_dio_data {
 	struct extent_changeset *data_reserved;
 };
 
+struct btrfs_rename_ctx {
+	/* Output field. Stores the index number of the old directory entry. */
+	u64 index;
+};
+
 static const struct inode_operations btrfs_dir_inode_operations;
 static const struct inode_operations btrfs_symlink_inode_operations;
 static const struct inode_operations btrfs_special_inode_operations;
@@ -4062,7 +4067,8 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir,
 				struct btrfs_inode *inode,
-				const char *name, int name_len)
+				const char *name, int name_len,
+				struct btrfs_rename_ctx *rename_ctx)
 {
 	struct btrfs_root *root = dir->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4118,6 +4124,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto err;
 	}
 skip_backref:
+	if (rename_ctx)
+		rename_ctx->index = index;
+
 	ret = btrfs_delete_delayed_dir_index(trans, dir, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -4158,7 +4167,7 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       const char *name, int name_len)
 {
 	int ret;
-	ret = __btrfs_unlink_inode(trans, dir, inode, name, name_len);
+	ret = __btrfs_unlink_inode(trans, dir, inode, name, name_len, NULL);
 	if (!ret) {
 		drop_nlink(&inode->vfs_inode);
 		ret = btrfs_update_inode(trans, inode->root, inode);
@@ -6531,7 +6540,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 				goto fail;
 		}
 		d_instantiate(dentry, inode);
-		btrfs_log_new_name(trans, old_dentry, NULL, parent);
+		btrfs_log_new_name(trans, old_dentry, NULL, 0, parent);
 	}
 
 fail:
@@ -8996,6 +9005,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	struct inode *new_inode = new_dentry->d_inode;
 	struct inode *old_inode = old_dentry->d_inode;
 	struct timespec64 ctime = current_time(old_inode);
+	struct btrfs_rename_ctx old_rename_ctx;
+	struct btrfs_rename_ctx new_rename_ctx;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	u64 new_ino = btrfs_ino(BTRFS_I(new_inode));
 	u64 old_idx = 0;
@@ -9136,7 +9147,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
 					   old_dentry->d_name.name,
-					   old_dentry->d_name.len);
+					   old_dentry->d_name.len,
+					   &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
 	}
@@ -9152,7 +9164,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
 					   new_dentry->d_name.name,
-					   new_dentry->d_name.len);
+					   new_dentry->d_name.len,
+					   &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
 	}
@@ -9184,13 +9197,13 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 	if (root_log_pinned) {
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
-				   new_dentry->d_parent);
+				   old_rename_ctx.index, new_dentry->d_parent);
 		btrfs_end_log_trans(root);
 		root_log_pinned = false;
 	}
 	if (dest_log_pinned) {
 		btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
-				   old_dentry->d_parent);
+				   new_rename_ctx.index, old_dentry->d_parent);
 		btrfs_end_log_trans(dest);
 		dest_log_pinned = false;
 	}
@@ -9296,6 +9309,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	struct btrfs_root *dest = BTRFS_I(new_dir)->root;
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *old_inode = d_inode(old_dentry);
+	struct btrfs_rename_ctx rename_ctx;
 	u64 index = 0;
 	int ret;
 	int ret2;
@@ -9427,7 +9441,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
 					old_dentry->d_name.name,
-					old_dentry->d_name.len);
+					old_dentry->d_name.len,
+					&rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
 	}
@@ -9471,7 +9486,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 
 	if (log_pinned) {
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
-				   new_dentry->d_parent);
+				   rename_ctx.index, new_dentry->d_parent);
 		btrfs_end_log_trans(root);
 		log_pinned = false;
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e253fa22ddba..9784a906f369 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6757,6 +6757,9 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
  *                      parent directory.
  * @old_dir:            The inode of the previous parent directory for the case
  *                      of a rename. For a link operation, it must be NULL.
+ * @old_dir_index:      The index number associated with the old name, meaningful
+ *                      only for rename operations (when @old_dir is not NULL).
+ *                      Ignored for link operations.
  * @parent:             The dentry associated to the directory under which the
  *                      new name is located.
  *
@@ -6765,7 +6768,7 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
  */
 void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			struct dentry *old_dentry, struct btrfs_inode *old_dir,
-			struct dentry *parent)
+			u64 old_dir_index, struct dentry *parent)
 {
 	struct btrfs_inode *inode = BTRFS_I(d_inode(old_dentry));
 	struct btrfs_log_ctx ctx;
@@ -6787,20 +6790,44 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 
 	/*
 	 * If we are doing a rename (old_dir is not NULL) from a directory that
-	 * was previously logged, make sure the next log attempt on the directory
-	 * is not skipped and logs the inode again. This is because the log may
-	 * not currently be authoritative for a range including the old
-	 * BTRFS_DIR_INDEX_KEY key, so we want to make sure after a log replay we
-	 * do not end up with both the new and old dentries around (in case the
-	 * inode is a directory we would have a directory with two hard links and
-	 * 2 inode references for different parents). The next log attempt of
-	 * old_dir will happen at btrfs_log_all_parents(), called through
-	 * btrfs_log_inode_parent() below, because we have previously set
-	 * inode->last_unlink_trans to the current transaction ID, either here or
-	 * at btrfs_record_unlink_dir() in case the inode is a directory.
+	 * was previously logged, make sure that on log replay we get the old
+	 * dir entry deleted. This is needed because we will also log the new
+	 * name of the renamed inode, so we need to make sure that after log
+	 * replay we don't end up with both the new and old dir entries existing.
 	 */
-	if (old_dir)
-		old_dir->logged_trans = 0;
+	if (old_dir && old_dir->logged_trans == trans->transid) {
+		struct btrfs_root *log = old_dir->root->log_root;
+		struct btrfs_path *path;
+		int ret;
+
+		ASSERT(old_dir_index >= BTRFS_DIR_START_INDEX);
+
+		path = btrfs_alloc_path();
+		if (!path) {
+			btrfs_set_log_full_commit(trans);
+			return;
+		}
+
+		ret = del_logged_dentry(trans, log, path, btrfs_ino(old_dir),
+					old_dentry->d_name.name,
+					old_dentry->d_name.len, old_dir_index);
+		if (ret > 0) {
+			/*
+			 * The dentry does not exist in the log, so record its
+			 * deletion.
+			 */
+			btrfs_release_path(path);
+			ret = insert_dir_log_key(trans, log, path,
+						 btrfs_ino(old_dir),
+						 old_dir_index, old_dir_index);
+		}
+
+		btrfs_free_path(path);
+		if (ret < 0) {
+			btrfs_set_log_full_commit(trans);
+			return;
+		}
+	}
 
 	btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
 	ctx.logging_new_name = true;
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index e69411f308ed..f1acb7fa944c 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -87,6 +87,6 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir);
 void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			struct dentry *old_dentry, struct btrfs_inode *old_dir,
-			struct dentry *parent);
+			u64 old_dir_index, struct dentry *parent);
 
 #endif
-- 
2.33.0

