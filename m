Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7540D76F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhIPKdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 06:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235590AbhIPKdi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 06:33:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDE466120E
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631788338;
        bh=U4Ibp/PpytZcNDUnOPCzUk6DrZpb0xKO7i53lnhkKrg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kdSOcnfC0lixWtXljfU3Wzt3xN/D+znT2QfJs/TITsNQiqkRExKL3A3dr7ESCADm+
         JuhWDf9TxLUGcPRYy25C1s0fmLr2usjqS1a+0cbpmDAyBc0eOhu8E1F7POyJx+Kg8W
         teXCujwVXlqhOR5ws2bZ1Hy9TJSfzlxpzSejarhyzzARY7wi5351fEQ6dp5/hYZeaw
         zFAk9Horv2u2mp9BhaVATYb5g0vIoc4jQhHqaccggGwlqhWpG7cnCGM037aIXW5gUx
         8vJB6xoUeh+SqisUiEnhUP3cBm/WtUyiK6f1Bnq0a0dd4k9dp131RTSkUiDuzzoSpF
         UVLoFcAHGM/jQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: remove root argument from btrfs_log_inode() and its callees
Date:   Thu, 16 Sep 2021 11:32:10 +0100
Message-Id: <03c99e78af748d21af7ff0bb6e915230cf0e3310.1631787796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631787796.git.fdmanana@suse.com>
References: <cover.1631787796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument passed to btrfs_log_inode() is unncessary, as it is
always the root of the inode we are going to log. This root also gets
unnecessarily propagated to several functions called by btrfs_log_inode(),
and all of them take the inode as an argument as well. So just remove
the root argument from these functions and have them get the root from
the inode where needed.

This patch is part of a patchset comprised of the following 5 patches:

  btrfs: remove root argument from btrfs_log_inode() and its callees
  btrfs: remove redundant log root assignment from log_dir_items()
  btrfs: factor out the copying loop of dir items from log_dir_items()
  btrfs: insert items in batches when logging a directory when possible
  btrfs: keep track of the last logged keys when logging a directory

This is patch 1/5. The change log of the last patch (5/5) has performance
results.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 52 +++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6a90e1178236..be9fb98465f5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -94,7 +94,7 @@ enum {
 };
 
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root, struct btrfs_inode *inode,
+			   struct btrfs_inode *inode,
 			   int inode_only,
 			   struct btrfs_log_ctx *ctx);
 static int link_to_fixup_dir(struct btrfs_trans_handle *trans,
@@ -3621,13 +3621,14 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
  * to replay anything deleted before the fsync
  */
 static noinline int log_dir_items(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, struct btrfs_inode *inode,
+			  struct btrfs_inode *inode,
 			  struct btrfs_path *path,
 			  struct btrfs_path *dst_path, int key_type,
 			  struct btrfs_log_ctx *ctx,
 			  u64 min_offset, u64 *last_offset_ret)
 {
 	struct btrfs_key min_key;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_root *log = root->log_root;
 	struct extent_buffer *src;
 	int err = 0;
@@ -3828,7 +3829,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
  * key logged by this transaction.
  */
 static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, struct btrfs_inode *inode,
+			  struct btrfs_inode *inode,
 			  struct btrfs_path *path,
 			  struct btrfs_path *dst_path,
 			  struct btrfs_log_ctx *ctx)
@@ -3842,7 +3843,7 @@ static noinline int log_directory_changes(struct btrfs_trans_handle *trans,
 	min_key = 0;
 	max_key = 0;
 	while (1) {
-		ret = log_dir_items(trans, root, inode, path, dst_path, key_type,
+		ret = log_dir_items(trans, inode, path, dst_path, key_type,
 				ctx, min_key, &max_key);
 		if (ret)
 			return ret;
@@ -4339,13 +4340,13 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 }
 
 static int log_one_extent(struct btrfs_trans_handle *trans,
-			  struct btrfs_inode *inode, struct btrfs_root *root,
+			  struct btrfs_inode *inode,
 			  const struct extent_map *em,
 			  struct btrfs_path *path,
 			  struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
-	struct btrfs_root *log = root->log_root;
+	struct btrfs_root *log = inode->root->log_root;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *leaf;
 	struct btrfs_map_token token;
@@ -4563,7 +4564,6 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 }
 
 static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
-				     struct btrfs_root *root,
 				     struct btrfs_inode *inode,
 				     struct btrfs_path *path,
 				     struct btrfs_log_ctx *ctx)
@@ -4628,7 +4628,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 
 		write_unlock(&tree->lock);
 
-		ret = log_one_extent(trans, inode, root, em, path, ctx);
+		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
 		free_extent_map(em);
@@ -4717,11 +4717,11 @@ static int logged_inode_size(struct btrfs_root *log, struct btrfs_inode *inode,
  * with a journal, ext3/4, xfs, f2fs, etc).
  */
 static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
 				struct btrfs_inode *inode,
 				struct btrfs_path *path,
 				struct btrfs_path *dst_path)
 {
+	struct btrfs_root *root = inode->root;
 	int ret;
 	struct btrfs_key key;
 	const u64 ino = btrfs_ino(inode);
@@ -4795,10 +4795,10 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
  * truncate operation that changes the inode's size.
  */
 static int btrfs_log_holes(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
 			   struct btrfs_inode *inode,
 			   struct btrfs_path *path)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
 	const u64 ino = btrfs_ino(inode);
@@ -5075,7 +5075,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 				if (IS_ERR(inode)) {
 					ret = PTR_ERR(inode);
 				} else {
-					ret = btrfs_log_inode(trans, root,
+					ret = btrfs_log_inode(trans,
 						      BTRFS_I(inode),
 						      LOG_OTHER_INODE_ALL,
 						      ctx);
@@ -5135,8 +5135,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * well because during a rename we pin the log and update the
 		 * log with the new name before we unpin it.
 		 */
-		ret = btrfs_log_inode(trans, root, BTRFS_I(inode),
-				      LOG_OTHER_INODE, ctx);
+		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_OTHER_INODE, ctx);
 		if (ret) {
 			btrfs_add_delayed_iput(inode);
 			continue;
@@ -5347,7 +5346,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
  * This handles both files and directories.
  */
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root, struct btrfs_inode *inode,
+			   struct btrfs_inode *inode,
 			   int inode_only,
 			   struct btrfs_log_ctx *ctx)
 {
@@ -5355,7 +5354,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *dst_path;
 	struct btrfs_key min_key;
 	struct btrfs_key max_key;
-	struct btrfs_root *log = root->log_root;
+	struct btrfs_root *log = inode->root->log_root;
 	int err = 0;
 	int ret = 0;
 	bool fast_search = false;
@@ -5505,14 +5504,14 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
-	err = btrfs_log_all_xattrs(trans, root, inode, path, dst_path);
+	err = btrfs_log_all_xattrs(trans, inode, path, dst_path);
 	if (err)
 		goto out_unlock;
 	xattrs_logged = true;
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-		err = btrfs_log_holes(trans, root, inode, path);
+		err = btrfs_log_holes(trans, inode, path);
 		if (err)
 			goto out_unlock;
 	}
@@ -5532,16 +5531,14 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		 * BTRFS_INODE_COPY_EVERYTHING set.
 		 */
 		if (!xattrs_logged && inode->logged_trans < trans->transid) {
-			err = btrfs_log_all_xattrs(trans, root, inode, path,
-						   dst_path);
+			err = btrfs_log_all_xattrs(trans, inode, path, dst_path);
 			if (err)
 				goto out_unlock;
 			btrfs_release_path(path);
 		}
 	}
 	if (fast_search) {
-		ret = btrfs_log_changed_extents(trans, root, inode, dst_path,
-						ctx);
+		ret = btrfs_log_changed_extents(trans, inode, dst_path, ctx);
 		if (ret) {
 			err = ret;
 			goto out_unlock;
@@ -5556,8 +5553,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	}
 
 	if (inode_only == LOG_INODE_ALL && S_ISDIR(inode->vfs_inode.i_mode)) {
-		ret = log_directory_changes(trans, root, inode, path, dst_path,
-					ctx);
+		ret = log_directory_changes(trans, inode, path, dst_path, ctx);
 		if (ret) {
 			err = ret;
 			goto out_unlock;
@@ -5786,7 +5782,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			ctx->log_new_dentries = false;
 			if (type == BTRFS_FT_DIR || type == BTRFS_FT_SYMLINK)
 				log_mode = LOG_INODE_ALL;
-			ret = btrfs_log_inode(trans, root, BTRFS_I(di_inode),
+			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
 					      log_mode, ctx);
 			btrfs_add_delayed_iput(di_inode);
 			if (ret)
@@ -5931,7 +5927,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 			}
 
 			ctx->log_new_dentries = false;
-			ret = btrfs_log_inode(trans, root, BTRFS_I(dir_inode),
+			ret = btrfs_log_inode(trans, BTRFS_I(dir_inode),
 					      LOG_INODE_ALL, ctx);
 			if (!ret && ctx->log_new_dentries)
 				ret = log_new_dir_dentries(trans, root,
@@ -5979,7 +5975,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 
 		if (BTRFS_I(inode)->generation >= trans->transid &&
 		    need_log_inode(trans, BTRFS_I(inode)))
-			ret = btrfs_log_inode(trans, root, BTRFS_I(inode),
+			ret = btrfs_log_inode(trans, BTRFS_I(inode),
 					      LOG_INODE_EXISTS, ctx);
 		btrfs_add_delayed_iput(inode);
 		if (ret)
@@ -6034,7 +6030,7 @@ static int log_new_ancestors_fast(struct btrfs_trans_handle *trans,
 
 		if (inode->generation >= trans->transid &&
 		    need_log_inode(trans, inode)) {
-			ret = btrfs_log_inode(trans, root, inode,
+			ret = btrfs_log_inode(trans, inode,
 					      LOG_INODE_EXISTS, ctx);
 			if (ret)
 				break;
@@ -6177,7 +6173,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto end_no_trans;
 
-	ret = btrfs_log_inode(trans, root, inode, inode_only, ctx);
+	ret = btrfs_log_inode(trans, inode, inode_only, ctx);
 	if (ret)
 		goto end_trans;
 
-- 
2.33.0

