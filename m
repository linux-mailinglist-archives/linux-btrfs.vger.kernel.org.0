Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B805B596D75
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbiHQLXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiHQLXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE793E038
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F003B81CC2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55338C433D6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735387;
        bh=SamOxjksVUv1wNv9V3KvF+4r+UkI8+Yce1ZTwjobYCE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O9xq4bQV91B7UsfeoGer9uPLCZhoup8y4/ctFWh0cY7UJT3N3W+f2zViDv/sKxGlj
         LOJVqZ1O4q7iheDRYJY8DbsR7gPL+r9DTzRn+i01jD57fdX7rcUEaa48KA2zNFzYk+
         /w5uUPq7mBfLdHvmAf2a/NoBzrfcxZ7tP6QzoyXvGt6hVEzWPv33yQnhmwhgCkHHcP
         LIjVJMX2jR+YDjBpQdOdCifNQTk8fDRySuSYiF00jZdyFAVWlcZY1aC32pyqf1wIqc
         SHRwFSu/LwdzO7GJIGLvqqK+IchRBU9dApYICdpewtYUJtyqHIkt737X2/9T2X4F1j
         0aS4d6Y5ZtmaQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/15] btrfs: log conflicting inodes without holding log mutex of the initial inode
Date:   Wed, 17 Aug 2022 12:22:46 +0100
Message-Id: <98f70b3a99b7a295fea706c001ce0e67d4874f48.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging an inode, if we detect the inode has a reference that
conflicts with some other inode that got renamed, we log that other inode
while holding the log mutex of the current inode. We then find out if
there are other inodes that conflict with the first conflicting inode,
and log them while under the log mutex of the original inode. This is
fine because the recursion can only happen once.

For the upcoming work where we directly log delayed items without flushing
them first to the subvolume tree, this recursion adds a lot of complexity
and it's hard to keep lockdep happy about it.

So collect a list of conflicting inodes and then log the inodes after
unlocking the log mutex of the inode we started with.

Also limit the maximum number of conflict inodes we log to 10, to avoid
spending too much time logging (and maybe allocating too many list
elements too), as typically we don't have more than 1 or 2 conflicting
inodes - if we go over the limit, simply fallback to a transaction commit.

It is possible to have a very long list of conflicting inodes to be
intentionally created by a user if he/she creates a very long succession
of renames like this:

  (...)
  rename E to F
  rename D to E
  rename C to D
  rename B to C
  rename A to B
  touch A (create a new file named A)
  fsync A

If that happened for a sequence of hundreds or thousands of renames, it
could massively slow down the logging and cause other secondary effects
like for example blocking other fsync operations and transaction commits
for a very long time (assuming it wouldn't run into -ENOSPC or -ENOMEM
first). However such cases are very uncommon to happen in practice,
nevertheless it's better to be prepared for them and avoid chaos.
Such long sequence of conflicting inodes could be created before this
change.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c     |   1 +
 fs/btrfs/tree-log.c | 341 ++++++++++++++++++++++++--------------------
 fs/btrfs/tree-log.h |   6 +
 3 files changed, 196 insertions(+), 152 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 14466b99863b..9b693d780431 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2397,6 +2397,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	ret = btrfs_commit_transaction(trans);
 out:
 	ASSERT(list_empty(&ctx.list));
+	ASSERT(list_empty(&ctx.conflict_inodes));
 	err = file_check_and_advance_wb_err(file);
 	if (!ret)
 		ret = err;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e92a0b3b8088..2b56057dd199 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -22,6 +22,8 @@
 #include "zoned.h"
 #include "inode-item.h"
 
+#define MAX_CONFLICT_INODES 10
+
 /* magic values for the inode_only field in btrfs_log_inode:
  *
  * LOG_INODE_ALL means to log everything
@@ -31,8 +33,6 @@
 enum {
 	LOG_INODE_ALL,
 	LOG_INODE_EXISTS,
-	LOG_OTHER_INODE,
-	LOG_OTHER_INODE_ALL,
 };
 
 /*
@@ -5518,105 +5518,201 @@ struct btrfs_ino_list {
 	struct list_head list;
 };
 
-static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *root,
-				  struct btrfs_path *path,
-				  struct btrfs_log_ctx *ctx,
-				  u64 ino, u64 parent)
+static void free_conflicting_inodes(struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_ino_list *curr;
+	struct btrfs_ino_list *next;
+
+	list_for_each_entry_safe(curr, next, &ctx->conflict_inodes, list) {
+		list_del(&curr->list);
+		kfree(curr);
+	}
+}
+
+static int add_conflicting_inode(struct btrfs_trans_handle *trans,
+				 struct btrfs_root *root,
+				 u64 ino, u64 parent,
+				 struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_ino_list *ino_elem;
-	LIST_HEAD(inode_list);
-	int ret = 0;
+	struct inode *inode;
+
+	/*
+	 * It's rare to have a lot of conflicting inodes, in practice it is not
+	 * common to have more than 1 or 2. We don't want to collect too many,
+	 * as we could end up logging too many inodes (even if only in
+	 * LOG_INODE_EXISTS mode) and slow down other fsyncs or transaction
+	 * commits.
+	 */
+	if (ctx->num_conflict_inodes >= MAX_CONFLICT_INODES)
+		return BTRFS_LOG_FORCE_COMMIT;
+
+	inode = btrfs_iget(root->fs_info->sb, ino, root);
+	/*
+	 * If the other inode that had a conflicting dir entry was deleted in
+	 * the current transaction, we need to log its parent directory.
+	 * We can't simply ignore it and let the current inode's reference cause
+	 * an unlink of the conflicting inode when replaying the log - because
+	 * the conflicting inode may be a deleted subvolume/snapshot or it may
+	 * be a directory that had subvolumes/snapshots inside it (or had one
+	 * or more subdirectories with subvolumes/snapshots, etc). If that's the
+	 * case, then when logging the parent directory we will fallback to a
+	 * transaction commit because the parent directory will have a
+	 * last_unlink_trans that matches the current transaction.
+	 */
+	if (IS_ERR(inode)) {
+		int ret = PTR_ERR(inode);
+
+		if (ret != -ENOENT)
+			return ret;
+
+		ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
+		if (!ino_elem)
+			return -ENOMEM;
+		ino_elem->ino = ino;
+		ino_elem->parent = parent;
+		list_add_tail(&ino_elem->list, &ctx->conflict_inodes);
+		ctx->num_conflict_inodes++;
+
+		return 0;
+	}
+
+	/*
+	 * If the inode was already logged skip it - otherwise we can hit an
+	 * infinite loop. Example:
+	 *
+	 * From the commit root (previous transaction) we have the following
+	 * inodes:
+	 *
+	 * inode 257 a directory
+	 * inode 258 with references "zz" and "zz_link" on inode 257
+	 * inode 259 with reference "a" on inode 257
+	 *
+	 * And in the current (uncommitted) transaction we have:
+	 *
+	 * inode 257 a directory, unchanged
+	 * inode 258 with references "a" and "a2" on inode 257
+	 * inode 259 with reference "zz_link" on inode 257
+	 * inode 261 with reference "zz" on inode 257
+	 *
+	 * When logging inode 261 the following infinite loop could
+	 * happen if we don't skip already logged inodes:
+	 *
+	 * - we detect inode 258 as a conflicting inode, with inode 261
+	 *   on reference "zz", and log it;
+	 *
+	 * - we detect inode 259 as a conflicting inode, with inode 258
+	 *   on reference "a", and log it;
+	 *
+	 * - we detect inode 258 as a conflicting inode, with inode 259
+	 *   on reference "zz_link", and log it - again! After this we
+	 *   repeat the above steps forever.
+	 *
+	 * Here we can use need_log_inode() because we only need to log the
+	 * inode in LOG_INODE_EXISTS mode and rename operations update the log,
+	 * so that the log ends up with the new name and without the old name.
+	 */
+	if (!need_log_inode(trans, BTRFS_I(inode))) {
+		btrfs_add_delayed_iput(inode);
+		return 0;
+	}
+
+	btrfs_add_delayed_iput(inode);
 
 	ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
 	if (!ino_elem)
 		return -ENOMEM;
 	ino_elem->ino = ino;
 	ino_elem->parent = parent;
-	list_add_tail(&ino_elem->list, &inode_list);
+	list_add_tail(&ino_elem->list, &ctx->conflict_inodes);
+	ctx->num_conflict_inodes++;
 
-	while (!list_empty(&inode_list)) {
-		struct btrfs_fs_info *fs_info = root->fs_info;
-		struct btrfs_key key;
-		struct inode *inode;
+	return 0;
+}
 
-		ino_elem = list_first_entry(&inode_list, struct btrfs_ino_list,
-					    list);
-		ino = ino_elem->ino;
-		parent = ino_elem->parent;
-		list_del(&ino_elem->list);
-		kfree(ino_elem);
-		if (ret)
-			continue;
+static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
+				  struct btrfs_root *root,
+				  struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
 
-		btrfs_release_path(path);
+	/*
+	 * Conflicting inodes are logged by the first call to btrfs_log_inode(),
+	 * otherwise we could have unbounded recursion of btrfs_log_inode()
+	 * calls. This check guarantees we can have only 1 level of recursion.
+	 */
+	if (ctx->logging_conflict_inodes)
+		return 0;
+
+	ctx->logging_conflict_inodes = true;
+
+	/*
+	 * New conflicting inodes may be found and added to the list while we
+	 * are logging a conflicting inode, so keep iterating while the list is
+	 * not empty.
+	 */
+	while (!list_empty(&ctx->conflict_inodes)) {
+		struct btrfs_ino_list *curr;
+		struct inode *inode;
+		u64 ino;
+		u64 parent;
+
+		curr = list_first_entry(&ctx->conflict_inodes,
+					struct btrfs_ino_list, list);
+		ino = curr->ino;
+		parent = curr->parent;
+		list_del(&curr->list);
+		kfree(curr);
 
 		inode = btrfs_iget(fs_info->sb, ino, root);
 		/*
 		 * If the other inode that had a conflicting dir entry was
 		 * deleted in the current transaction, we need to log its parent
-		 * directory.
+		 * directory. See the comment at add_conflicting_inode().
 		 */
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
-			if (ret == -ENOENT) {
-				inode = btrfs_iget(fs_info->sb, parent, root);
-				if (IS_ERR(inode)) {
-					ret = PTR_ERR(inode);
-				} else {
-					ret = btrfs_log_inode(trans,
-						      BTRFS_I(inode),
-						      LOG_OTHER_INODE_ALL,
-						      ctx);
-					btrfs_add_delayed_iput(inode);
-				}
+			if (ret != -ENOENT)
+				break;
+
+			inode = btrfs_iget(fs_info->sb, parent, root);
+			if (IS_ERR(inode)) {
+				ret = PTR_ERR(inode);
+				break;
 			}
+
+			/*
+			 * Always log the directory, we cannot make this
+			 * conditional on need_log_inode() because the directory
+			 * might have been logged in LOG_INODE_EXISTS mode or
+			 * the dir index of the conflicting inode is not in a
+			 * dir index key range logged for the directory. So we
+			 * must make sure the deletion is recorded.
+			 */
+			ret = btrfs_log_inode(trans, BTRFS_I(inode),
+					      LOG_INODE_ALL, ctx);
+			btrfs_add_delayed_iput(inode);
+			if (ret)
+				break;
 			continue;
 		}
+
 		/*
-		 * If the inode was already logged skip it - otherwise we can
-		 * hit an infinite loop. Example:
-		 *
-		 * From the commit root (previous transaction) we have the
-		 * following inodes:
-		 *
-		 * inode 257 a directory
-		 * inode 258 with references "zz" and "zz_link" on inode 257
-		 * inode 259 with reference "a" on inode 257
-		 *
-		 * And in the current (uncommitted) transaction we have:
-		 *
-		 * inode 257 a directory, unchanged
-		 * inode 258 with references "a" and "a2" on inode 257
-		 * inode 259 with reference "zz_link" on inode 257
-		 * inode 261 with reference "zz" on inode 257
-		 *
-		 * When logging inode 261 the following infinite loop could
-		 * happen if we don't skip already logged inodes:
-		 *
-		 * - we detect inode 258 as a conflicting inode, with inode 261
-		 *   on reference "zz", and log it;
-		 *
-		 * - we detect inode 259 as a conflicting inode, with inode 258
-		 *   on reference "a", and log it;
+		 * Here we can use need_log_inode() because we only need to log
+		 * the inode in LOG_INODE_EXISTS mode and rename operations
+		 * update the log, so that the log ends up with the new name and
+		 * without the old name.
 		 *
-		 * - we detect inode 258 as a conflicting inode, with inode 259
-		 *   on reference "zz_link", and log it - again! After this we
-		 *   repeat the above steps forever.
+		 * We did this check at add_conflicting_inode(), but here we do
+		 * it again because if some other task logged the inode after
+		 * that, we can avoid doing it again.
 		 */
-		spin_lock(&BTRFS_I(inode)->lock);
-		/*
-		 * Check the inode's logged_trans only instead of
-		 * btrfs_inode_in_log(). This is because the last_log_commit of
-		 * the inode is not updated when we only log that it exists (see
-		 * btrfs_log_inode()).
-		 */
-		if (BTRFS_I(inode)->logged_trans == trans->transid) {
-			spin_unlock(&BTRFS_I(inode)->lock);
+		if (!need_log_inode(trans, BTRFS_I(inode))) {
 			btrfs_add_delayed_iput(inode);
 			continue;
 		}
-		spin_unlock(&BTRFS_I(inode)->lock);
+
 		/*
 		 * We are safe logging the other inode without acquiring its
 		 * lock as long as we log with the LOG_INODE_EXISTS mode. We
@@ -5624,67 +5720,16 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * well because during a rename we pin the log and update the
 		 * log with the new name before we unpin it.
 		 */
-		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_OTHER_INODE, ctx);
-		if (ret) {
-			btrfs_add_delayed_iput(inode);
-			continue;
-		}
-
-		key.objectid = ino;
-		key.type = BTRFS_INODE_REF_KEY;
-		key.offset = 0;
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-		if (ret < 0) {
-			btrfs_add_delayed_iput(inode);
-			continue;
-		}
-
-		while (true) {
-			struct extent_buffer *leaf = path->nodes[0];
-			int slot = path->slots[0];
-			u64 other_ino = 0;
-			u64 other_parent = 0;
-
-			if (slot >= btrfs_header_nritems(leaf)) {
-				ret = btrfs_next_leaf(root, path);
-				if (ret < 0) {
-					break;
-				} else if (ret > 0) {
-					ret = 0;
-					break;
-				}
-				continue;
-			}
-
-			btrfs_item_key_to_cpu(leaf, &key, slot);
-			if (key.objectid != ino ||
-			    (key.type != BTRFS_INODE_REF_KEY &&
-			     key.type != BTRFS_INODE_EXTREF_KEY)) {
-				ret = 0;
-				break;
-			}
-
-			ret = btrfs_check_ref_name_override(leaf, slot, &key,
-					BTRFS_I(inode), &other_ino,
-					&other_parent);
-			if (ret < 0)
-				break;
-			if (ret > 0) {
-				ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
-				if (!ino_elem) {
-					ret = -ENOMEM;
-					break;
-				}
-				ino_elem->ino = other_ino;
-				ino_elem->parent = other_parent;
-				list_add_tail(&ino_elem->list, &inode_list);
-				ret = 0;
-			}
-			path->slots[0]++;
-		}
+		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_INODE_EXISTS, ctx);
 		btrfs_add_delayed_iput(inode);
+		if (ret)
+			break;
 	}
 
+	ctx->logging_conflict_inodes = false;
+	if (ret)
+		free_conflicting_inodes(ctx);
+
 	return ret;
 }
 
@@ -5695,7 +5740,6 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				   struct btrfs_path *path,
 				   struct btrfs_path *dst_path,
 				   const u64 logged_isize,
-				   const bool recursive_logging,
 				   const int inode_only,
 				   struct btrfs_log_ctx *ctx,
 				   bool *need_log_inode_item)
@@ -5734,8 +5778,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 			break;
 		} else if ((min_key->type == BTRFS_INODE_REF_KEY ||
 			    min_key->type == BTRFS_INODE_EXTREF_KEY) &&
-			   inode->generation == trans->transid &&
-			   !recursive_logging) {
+			   (inode->generation == trans->transid ||
+			    ctx->logging_conflict_inodes)) {
 			u64 other_ino = 0;
 			u64 other_parent = 0;
 
@@ -5759,11 +5803,12 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 					return ret;
 				ins_nr = 0;
 
-				ret = log_conflicting_inodes(trans, root, path,
-						ctx, other_ino, other_parent);
+				btrfs_release_path(path);
+				ret = add_conflicting_inode(trans, root,
+							    other_ino,
+							    other_parent, ctx);
 				if (ret)
 					return ret;
-				btrfs_release_path(path);
 				goto next_key;
 			}
 		} else if (min_key->type == BTRFS_XATTR_ITEM_KEY) {
@@ -5877,9 +5922,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	u64 logged_isize = 0;
 	bool need_log_inode_item = true;
 	bool xattrs_logged = false;
-	bool recursive_logging = false;
 	bool inode_item_dropped = true;
-	const bool orig_logged_before = ctx->logged_before;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -5918,16 +5961,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
-	if (inode_only == LOG_OTHER_INODE || inode_only == LOG_OTHER_INODE_ALL) {
-		recursive_logging = true;
-		if (inode_only == LOG_OTHER_INODE)
-			inode_only = LOG_INODE_EXISTS;
-		else
-			inode_only = LOG_INODE_ALL;
-		mutex_lock_nested(&inode->log_mutex, SINGLE_DEPTH_NESTING);
-	} else {
-		mutex_lock(&inode->log_mutex);
-	}
+	mutex_lock(&inode->log_mutex);
 
 	/*
 	 * For symlinks, we must always log their content, which is stored in an
@@ -6033,7 +6067,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	ret = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
 				      path, dst_path, logged_isize,
-				      recursive_logging, inode_only, ctx,
+				      inode_only, ctx,
 				      &need_log_inode_item);
 	if (ret)
 		goto out_unlock;
@@ -6142,8 +6176,10 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	btrfs_free_path(path);
 	btrfs_free_path(dst_path);
 
-	if (recursive_logging)
-		ctx->logged_before = orig_logged_before;
+	if (ret)
+		free_conflicting_inodes(ctx);
+	else
+		ret = log_conflicting_inodes(trans, inode->root, ctx);
 
 	return ret;
 }
@@ -6998,6 +7034,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * inconsistent state after a rename operation.
 	 */
 	btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
+	ASSERT(list_empty(&ctx.conflict_inodes));
 out:
 	/*
 	 * If an error happened mark the log for a full commit because it's not
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 57ab5f3b8dc7..4e34fe4b7762 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -28,6 +28,9 @@ struct btrfs_log_ctx {
 	struct list_head list;
 	/* Only used for fast fsyncs. */
 	struct list_head ordered_extents;
+	struct list_head conflict_inodes;
+	int num_conflict_inodes;
+	bool logging_conflict_inodes;
 };
 
 static inline void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,
@@ -41,6 +44,9 @@ static inline void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,
 	ctx->inode = inode;
 	INIT_LIST_HEAD(&ctx->list);
 	INIT_LIST_HEAD(&ctx->ordered_extents);
+	INIT_LIST_HEAD(&ctx->conflict_inodes);
+	ctx->num_conflict_inodes = 0;
+	ctx->logging_conflict_inodes = false;
 }
 
 static inline void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx)
-- 
2.35.1

