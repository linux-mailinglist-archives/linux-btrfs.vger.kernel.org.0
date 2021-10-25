Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E590C439318
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhJYJ7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232633AbhJYJ6w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A94460FDC
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635155790;
        bh=8GPhRe/aTcfkxKGPg2bWk6McCaRAJKJH/C9DknVO6O4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jS3dB6q69mNRe9AbjpPnnmGcEOfgD2qgXBysNYSVpt8upffObrhq20crSWuyjOuyk
         1C7aTE3k1K/SW89PKFx112CWCMErAtHrvdPjyegXYnIqi3iP1MZMmMJ02gxSvZHWxf
         ZT+Ddivk56ZFbJhD9wob/FAmIIfszlobC4McrtE12hcb7LPcHePQCbP7RyD3MCa8yg
         AB5ICoD71UJvx/DlGJBHF+KKtsEGvL/d9kv5uZTQseMfbT4hSS3RNispmRBDTGPIq7
         UdVAqOaHlN+OGE5g5VukjReNsdJi4194HwId2cFFAf/hvmnHe0tdxXMoD73aH27cLl
         Rcf+rmiNjZHcQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: remove root argument from btrfs_unlink_inode()
Date:   Mon, 25 Oct 2021 10:56:22 +0100
Message-Id: <408c8e30e55c27dfea77f2dfba54e863b82eb516.1635155473.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635155473.git.fdmanana@suse.com>
References: <cover.1635155473.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument passed to btrfs_unlink_inode() and its callee,
__btrfs_unlink_inode(), always matches the root of the given directory and
the given inode. So remove the argument and make __btrfs_unlink_inode()
use the root of the directory.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h    |  1 -
 fs/btrfs/inode.c    | 25 +++++++++++--------------
 fs/btrfs/tree-log.c | 14 +++++++-------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dc6a6173a2c0..7553e9dc5f93 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3195,7 +3195,6 @@ void __btrfs_del_delalloc_inode(struct btrfs_root *root,
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
 		       const char *name, int name_len);
 int btrfs_add_link(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3032893efee5..5fec009fbe63 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4056,11 +4056,11 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
  * also drops the back refs in the inode to the directory
  */
 static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
 				struct btrfs_inode *dir,
 				struct btrfs_inode *inode,
 				const char *name, int name_len)
 {
+	struct btrfs_root *root = dir->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
 	int ret = 0;
@@ -4150,15 +4150,14 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
 		       const char *name, int name_len)
 {
 	int ret;
-	ret = __btrfs_unlink_inode(trans, root, dir, inode, name, name_len);
+	ret = __btrfs_unlink_inode(trans, dir, inode, name, name_len);
 	if (!ret) {
 		drop_nlink(&inode->vfs_inode);
-		ret = btrfs_update_inode(trans, root, inode);
+		ret = btrfs_update_inode(trans, inode->root, inode);
 	}
 	return ret;
 }
@@ -4187,7 +4186,6 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
 
 static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_trans_handle *trans;
 	struct inode *inode = d_inode(dentry);
 	int ret;
@@ -4199,7 +4197,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 			0);
 
-	ret = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
 			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
 			dentry->d_name.len);
 	if (ret)
@@ -4213,7 +4211,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 
 out:
 	btrfs_end_transaction(trans);
-	btrfs_btree_balance_dirty(root->fs_info);
+	btrfs_btree_balance_dirty(BTRFS_I(dir)->root->fs_info);
 	return ret;
 }
 
@@ -4564,7 +4562,6 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	int err = 0;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_trans_handle *trans;
 	u64 last_unlink_trans;
 
@@ -4589,7 +4586,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
 
 	/* now the directory is empty */
-	err = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
+	err = btrfs_unlink_inode(trans, BTRFS_I(dir),
 			BTRFS_I(d_inode(dentry)), dentry->d_name.name,
 			dentry->d_name.len);
 	if (!err) {
@@ -4610,7 +4607,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 out:
 	btrfs_end_transaction(trans);
-	btrfs_btree_balance_dirty(root->fs_info);
+	btrfs_btree_balance_dirty(BTRFS_I(dir)->root->fs_info);
 
 	return err;
 }
@@ -9468,7 +9465,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else { /* src is an inode */
-		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
+		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
 					   old_dentry->d_name.name,
 					   old_dentry->d_name.len);
@@ -9484,7 +9481,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	if (new_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 	} else { /* dest is an inode */
-		ret = __btrfs_unlink_inode(trans, dest, BTRFS_I(new_dir),
+		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
 					   new_dentry->d_name.name,
 					   new_dentry->d_name.len);
@@ -9759,7 +9756,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		 */
 		btrfs_pin_log_trans(root);
 		log_pinned = true;
-		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
+		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
 					old_dentry->d_name.name,
 					old_dentry->d_name.len);
@@ -9779,7 +9776,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 			ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 			BUG_ON(new_inode->i_nlink == 0);
 		} else {
-			ret = btrfs_unlink_inode(trans, dest, BTRFS_I(new_dir),
+			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 						 BTRFS_I(d_inode(new_dentry)),
 						 new_dentry->d_name.name,
 						 new_dentry->d_name.len);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 23f1a35ea04f..568509371b68 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -954,7 +954,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = btrfs_unlink_inode(trans, root, dir, BTRFS_I(inode), name,
+	ret = btrfs_unlink_inode(trans, dir, BTRFS_I(inode), name,
 			name_len);
 	if (ret)
 		goto out;
@@ -1119,7 +1119,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				inc_nlink(&inode->vfs_inode);
 				btrfs_release_path(path);
 
-				ret = btrfs_unlink_inode(trans, root, dir, inode,
+				ret = btrfs_unlink_inode(trans, dir, inode,
 						victim_name, victim_name_len);
 				kfree(victim_name);
 				if (ret)
@@ -1190,7 +1190,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					inc_nlink(&inode->vfs_inode);
 					btrfs_release_path(path);
 
-					ret = btrfs_unlink_inode(trans, root,
+					ret = btrfs_unlink_inode(trans,
 							BTRFS_I(victim_parent),
 							inode,
 							victim_name,
@@ -1352,7 +1352,7 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 				kfree(name);
 				goto out;
 			}
-			ret = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
+			ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
 						 inode, name, namelen);
 			kfree(name);
 			iput(dir);
@@ -1450,7 +1450,7 @@ static int add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = btrfs_unlink_inode(trans, root, BTRFS_I(dir), BTRFS_I(other_inode),
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(other_inode),
 				 name, namelen);
 	if (ret)
 		goto out;
@@ -1596,7 +1596,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			ret = btrfs_inode_ref_exists(inode, dir, key->type,
 						     name, namelen);
 			if (ret > 0) {
-				ret = btrfs_unlink_inode(trans, root,
+				ret = btrfs_unlink_inode(trans,
 							 BTRFS_I(dir),
 							 BTRFS_I(inode),
 							 name, namelen);
@@ -2346,7 +2346,7 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 			}
 
 			inc_nlink(inode);
-			ret = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
+			ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
 					BTRFS_I(inode), name, name_len);
 			if (!ret)
 				ret = btrfs_run_delayed_items(trans);
-- 
2.33.0

