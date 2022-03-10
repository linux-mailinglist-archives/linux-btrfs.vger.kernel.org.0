Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382A34D3ECC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiCJBdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbiCJBdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA79127562
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v4so3901509pjh.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLmdJeAiVlAz4pYyD2llESv4vFvWdhISmtxWV+FvwLE=;
        b=Wp7Yscxgt9LNdgDP+coOBpG3s2firaow5YckDm4lYy7110F1CMHAwwEl+zpW9pCuE6
         zFLJD/TQN0F0JTRzACWKP6s0+RJHPSr7A7OR7E+npQygO7Kjgi4lB5EaaIonl7blkni9
         Y6wiuQwxKo+fOl3xuVdoJvu+bDEwYnD4gbs4gpAwDAQMxJ1W3agt1mO5dTgxYWInDR87
         hhlh5xsQ8INXpc/G5As71WuUwNslM9bGZbFC3KoNVzO31L+Mzq2phc90Z+1EiMaWIh6l
         8LKoOs/Sa5oz+8Tto+DI01MFQ4Qe8NnmUZxJkE4eaNTELKCNvgnu4tofv0hK/w0YUPAa
         5JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLmdJeAiVlAz4pYyD2llESv4vFvWdhISmtxWV+FvwLE=;
        b=K97K9EvQnrP4WJzx/o4AuFqcamJvCFQZnIuYD6xBbQV4QAhMg4BQfZYBCPxrK8pPAo
         l1nQfyT92FTjBOkdk5E/VF3bRptXuRqQoV0v+sGajrj7/wyxQuqjVKLNJWXUbqUAzpxG
         4HNEToZZmU8fhBOyMIHwZvXw8qdgiMb5mCYK1K2h1gEz6/820ulNNmw72jT6Xgl86ZNu
         /mGrIDI5ZlyO3l0VqOsdk8qiiX49ki6sDueuHVQ3ykjWLyBB6f8ZJq0u9qwIzMezqOn/
         aJEsxWJEGHjDjwFtePugjeOwH/kYjsBXeH6MXirJJ/MNSozQ4JGHqb33lJQJDD1UODTT
         B9Lw==
X-Gm-Message-State: AOAM532EvKwuX3EPSpLu8J7Wtx4maAI3zFsD6HcDYNYvk2NSYzaCA1CY
        HAC3TLiWRRkxIcBacTb7eer+82CJtY6+8A==
X-Google-Smtp-Source: ABdhPJzxy4Zu2KGRFX6AznuHqV++DhbXQuvV5d1rtXtTgRrYOBPswkb2eP8MGFp5ayWJ5ljIHvzGLg==
X-Received: by 2002:a17:902:b094:b0:151:be02:8e27 with SMTP id p20-20020a170902b09400b00151be028e27mr2476329plr.50.1646875928397;
        Wed, 09 Mar 2022 17:32:08 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:07 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 13/16] btrfs: allocate inode outside of btrfs_new_inode()
Date:   Wed,  9 Mar 2022 17:31:43 -0800
Message-Id: <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Instead of calling new_inode() and inode_init_owner() inside of
btrfs_new_inode(), do it in the callers. This allows us to pass in just
the inode instead of the mnt_userns and mode and removes the need for
memalloc_nofs_{save,restores}() since we do it before starting a
transaction. This also paves the way for some more cleanups in later
patches.

This also removes the comments about Smack checking i_op, which are no
longer true since commit 5d6c31910bc0 ("xattr: Add
__vfs_{get,set,remove}xattr helpers"). Now it checks inode->i_opflags &
IOP_XATTR, which is set based on sb->s_xattr.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   5 +-
 fs/btrfs/inode.c | 284 +++++++++++++++++++++++++----------------------
 fs/btrfs/ioctl.c |  22 ++--
 3 files changed, 167 insertions(+), 144 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db17bd05a21..f39730420e8a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3254,10 +3254,11 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
+struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+				     struct inode *dir);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *new_root,
 			     struct btrfs_root *parent_root,
-			     struct user_namespace *mnt_userns);
+			     struct inode *inode);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c47bdada2440..ff780256c936 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6090,15 +6090,12 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 	btrfs_sync_inode_flags_to_i_flags(inode);
 }
 
-static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
-				     struct btrfs_root *root,
-				     struct user_namespace *mnt_userns,
-				     struct inode *dir,
-				     const char *name, int name_len,
-				     umode_t mode, u64 *index)
+static int btrfs_new_inode(struct btrfs_trans_handle *trans,
+			   struct btrfs_root *root, struct inode *inode,
+			   struct inode *dir, const char *name, int name_len,
+			   u64 *index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode *inode;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_key *location;
 	struct btrfs_path *path;
@@ -6108,20 +6105,11 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	u32 sizes[2];
 	struct btrfs_item_batch batch;
 	unsigned long ptr;
-	unsigned int nofs_flag;
 	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
-		return ERR_PTR(-ENOMEM);
-
-	nofs_flag = memalloc_nofs_save();
-	inode = new_inode(fs_info->sb);
-	memalloc_nofs_restore(nofs_flag);
-	if (!inode) {
-		btrfs_free_path(path);
-		return ERR_PTR(-ENOMEM);
-	}
+		return -ENOMEM;
 
 	/*
 	 * O_TMPFILE, set link count to 0, so that after this point,
@@ -6133,8 +6121,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	ret = btrfs_get_free_objectid(root, &objectid);
 	if (ret) {
 		btrfs_free_path(path);
-		iput(inode);
-		return ERR_PTR(ret);
+		return ret;
 	}
 	inode->i_ino = objectid;
 
@@ -6144,8 +6131,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 		ret = btrfs_set_inode_index(BTRFS_I(dir), index);
 		if (ret) {
 			btrfs_free_path(path);
-			iput(inode);
-			return ERR_PTR(ret);
+			return ret;
 		}
 	} else if (dir) {
 		*index = 0;
@@ -6163,7 +6149,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_inherit_iflags(inode, dir);
 
-	if (S_ISREG(mode)) {
+	if (S_ISREG(inode->i_mode)) {
 		if (btrfs_test_opt(fs_info, NODATASUM))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
 		if (btrfs_test_opt(fs_info, NODATACOW))
@@ -6208,10 +6194,8 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	location->type = BTRFS_INODE_ITEM_KEY;
 
 	ret = btrfs_insert_inode_locked(inode);
-	if (ret < 0) {
-		iput(inode);
+	if (ret < 0)
 		goto fail;
-	}
 
 	batch.keys = &key[0];
 	batch.data_sizes = &sizes[0];
@@ -6221,8 +6205,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	if (ret != 0)
 		goto fail_unlock;
 
-	inode_init_owner(mnt_userns, inode, dir, mode);
-
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
@@ -6259,15 +6241,20 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 			  "error inheriting props for ino %llu (root %llu): %d",
 			btrfs_ino(BTRFS_I(inode)), root->root_key.objectid, ret);
 
-	return inode;
+	return 0;
 
 fail_unlock:
+	/*
+	 * discard_new_inode() calls iput(), but the caller owns the reference
+	 * to the inode.
+	 */
+	ihold(inode);
 	discard_new_inode(inode);
 fail:
 	if (dir && name)
 		BTRFS_I(dir)->index_cnt--;
 	btrfs_free_path(path);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /*
@@ -6365,37 +6352,36 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	int err;
 	u64 index = 0;
 
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode->i_op = &btrfs_special_inode_operations;
+	init_special_inode(inode, inode->i_mode, rdev);
+
 	/*
 	 * 2 for inode item and ref
 	 * 2 for dir items
 	 * 1 for xattr if selinux is on
 	 */
 	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		iput(inode);
 		return PTR_ERR(trans);
+	}
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-			dentry->d_name.name, dentry->d_name.len,
-			mode, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
+			      dentry->d_name.len, &index);
+	if (err) {
+		iput(inode);
 		inode = NULL;
 		goto out_unlock;
 	}
 
-	/*
-	* If the active LSM wants to access the inode during
-	* d_instantiate it needs these. Smack checks to see
-	* if the filesystem supports xattrs by looking at the
-	* ops vector.
-	*/
-	inode->i_op = &btrfs_special_inode_operations;
-	init_special_inode(inode, inode->i_mode, rdev);
-
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
 		goto out_unlock;
@@ -6424,36 +6410,36 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	int err;
 	u64 index = 0;
 
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode->i_fop = &btrfs_file_operations;
+	inode->i_op = &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops = &btrfs_aops;
+
 	/*
 	 * 2 for inode item and ref
 	 * 2 for dir items
 	 * 1 for xattr if selinux is on
 	 */
 	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		iput(inode);
 		return PTR_ERR(trans);
+	}
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-			dentry->d_name.name, dentry->d_name.len,
-			mode, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
+			      dentry->d_name.len, &index);
+	if (err) {
+		iput(inode);
 		inode = NULL;
 		goto out_unlock;
 	}
-	/*
-	* If the active LSM wants to access the inode during
-	* d_instantiate it needs these. Smack checks to see
-	* if the filesystem supports xattrs by looking at the
-	* ops vector.
-	*/
-	inode->i_fop = &btrfs_file_operations;
-	inode->i_op = &btrfs_file_inode_operations;
-	inode->i_mapping->a_ops = &btrfs_aops;
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
@@ -6562,34 +6548,38 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	int err = 0;
+	int err;
 	u64 index = 0;
 
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
+	inode->i_op = &btrfs_dir_inode_operations;
+	inode->i_fop = &btrfs_dir_file_operations;
+
 	/*
 	 * 2 items for inode and ref
 	 * 2 items for dir items
 	 * 1 for xattr if selinux is on
 	 */
 	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		iput(inode);
 		return PTR_ERR(trans);
+	}
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-			dentry->d_name.name, dentry->d_name.len,
-			S_IFDIR | mode, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
+			      dentry->d_name.len, &index);
+	if (err) {
+		iput(inode);
 		inode = NULL;
 		goto out_fail;
 	}
 
-	/* these must be set before we unlock the inode */
-	inode->i_op = &btrfs_dir_inode_operations;
-	inode->i_fop = &btrfs_dir_file_operations;
-
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
 		goto out_fail;
@@ -8747,25 +8737,39 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	return ret;
 }
 
+struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+				     struct inode *dir)
+{
+	struct inode *inode;
+
+	inode = new_inode(dir->i_sb);
+	if (inode) {
+		/*
+		 * Subvolumes don't inherit the sgid bit or the parent's gid if
+		 * the parent's sgid bit is set. This is probably a bug.
+		 */
+		inode_init_owner(mnt_userns, inode, NULL,
+				 S_IFDIR | (~current_umask() & S_IRWXUGO));
+		inode->i_op = &btrfs_dir_inode_operations;
+		inode->i_fop = &btrfs_dir_file_operations;
+	}
+	return inode;
+}
+
 /*
  * create a new subvolume directory/inode (helper for the ioctl).
  */
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *new_root,
 			     struct btrfs_root *parent_root,
-			     struct user_namespace *mnt_userns)
+			     struct inode *inode)
 {
-	struct inode *inode;
+	struct btrfs_root *new_root = BTRFS_I(inode)->root;
 	int err;
 	u64 index = 0;
 
-	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
-				S_IFDIR | (~current_umask() & S_IRWXUGO),
-				&index);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-	inode->i_op = &btrfs_dir_inode_operations;
-	inode->i_fop = &btrfs_dir_file_operations;
+	err = btrfs_new_inode(trans, new_root, inode, NULL, "..", 2, &index);
+	if (err)
+		return err;
 
 	unlock_new_inode(inode);
 
@@ -8776,8 +8780,6 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			  new_root->root_key.objectid, err);
 
 	err = btrfs_update_inode(trans, new_root, BTRFS_I(inode));
-
-	iput(inode);
 	return err;
 }
 
@@ -9254,31 +9256,36 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	return ret;
 }
 
+static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
+					struct inode *dir)
+{
+	struct inode *inode;
+
+	inode = new_inode(dir->i_sb);
+	if (inode) {
+		inode_init_owner(mnt_userns, inode, dir,
+				 S_IFCHR | WHITEOUT_MODE);
+		inode->i_op = &btrfs_special_inode_operations;
+		init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
+	}
+	return inode;
+}
+
 static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
-				     struct user_namespace *mnt_userns,
-				     struct inode *dir,
+				     struct inode *inode, struct inode *dir,
 				     struct dentry *dentry)
 {
 	int ret;
-	struct inode *inode;
 	u64 index;
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-				dentry->d_name.name,
-				dentry->d_name.len,
-				S_IFCHR | WHITEOUT_MODE,
-				&index);
-
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
+	ret = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
+			      dentry->d_name.len, &index);
+	if (ret) {
+		iput(inode);
 		return ret;
 	}
 
-	inode->i_op = &btrfs_special_inode_operations;
-	init_special_inode(inode, inode->i_mode,
-		WHITEOUT_DEV);
-
 	ret = btrfs_init_inode_security(trans, inode, dir,
 				&dentry->d_name);
 	if (ret)
@@ -9305,6 +9312,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 			unsigned int flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
+	struct inode *whiteout_inode;
 	struct btrfs_trans_handle *trans;
 	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
@@ -9359,6 +9367,12 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (new_inode && S_ISREG(old_inode->i_mode) && new_inode->i_size)
 		filemap_flush(old_inode->i_mapping);
 
+	if (flags & RENAME_WHITEOUT) {
+		whiteout_inode = new_whiteout_inode(mnt_userns, old_dir);
+		if (!whiteout_inode)
+			return -ENOMEM;
+	}
+
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		/* close the racy window with snapshot create/destroy ioctl */
 		down_read(&fs_info->subvol_sem);
@@ -9495,9 +9509,9 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 				   rename_ctx.index, new_dentry->d_parent);
 
 	if (flags & RENAME_WHITEOUT) {
-		ret = btrfs_whiteout_for_rename(trans, root, mnt_userns,
+		ret = btrfs_whiteout_for_rename(trans, root, whiteout_inode,
 						old_dir, old_dentry);
-
+		whiteout_inode = NULL;
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_fail;
@@ -9509,7 +9523,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 out_notrans:
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
 		up_read(&fs_info->subvol_sem);
-
+	if (flags & RENAME_WHITEOUT)
+		iput(whiteout_inode);
 	return ret;
 }
 
@@ -9728,7 +9743,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	int err;
 	u64 index = 0;
 	int name_len;
@@ -9741,6 +9756,14 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
 		return -ENAMETOOLONG;
 
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, S_IFLNK | S_IRWXUGO);
+	inode->i_op = &btrfs_symlink_inode_operations;
+	inode_nohighmem(inode);
+	inode->i_mapping->a_ops = &btrfs_aops;
+
 	/*
 	 * 2 items for inode item and ref
 	 * 2 items for dir items
@@ -9749,28 +9772,19 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	 * 1 item for xattr if selinux is on
 	 */
 	trans = btrfs_start_transaction(root, 7);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		iput(inode);
 		return PTR_ERR(trans);
+	}
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-				dentry->d_name.name, dentry->d_name.len,
-				S_IFLNK | S_IRWXUGO, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
+			      dentry->d_name.len, &index);
+	if (err) {
+		iput(inode);
 		inode = NULL;
 		goto out_unlock;
 	}
 
-	/*
-	* If the active LSM wants to access the inode during
-	* d_instantiate it needs these. Smack checks to see
-	* if the filesystem supports xattrs by looking at the
-	* ops vector.
-	*/
-	inode->i_fop = &btrfs_file_operations;
-	inode->i_op = &btrfs_file_inode_operations;
-	inode->i_mapping->a_ops = &btrfs_aops;
-
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
 		goto out_unlock;
@@ -9806,8 +9820,6 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	inode->i_op = &btrfs_symlink_inode_operations;
-	inode_nohighmem(inode);
 	inode_set_bytes(inode, name_len);
 	btrfs_i_size_write(BTRFS_I(inode), name_len);
 	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
@@ -10087,30 +10099,34 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	u64 index;
-	int ret = 0;
+	int ret;
+
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode->i_fop = &btrfs_file_operations;
+	inode->i_op = &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops = &btrfs_aops;
 
 	/*
 	 * 5 units required for adding orphan entry
 	 */
 	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		iput(inode);
 		return PTR_ERR(trans);
+	}
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
-			mode, &index);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
+	ret = btrfs_new_inode(trans, root, inode, dir, NULL, 0, &index);
+	if (ret) {
+		iput(inode);
 		inode = NULL;
 		goto out;
 	}
 
-	inode->i_fop = &btrfs_file_operations;
-	inode->i_op = &btrfs_file_inode_operations;
-
-	inode->i_mapping->a_ops = &btrfs_aops;
-
 	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 891352fd6d0f..60c907b14547 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -587,6 +587,12 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	if (ret < 0)
 		goto out_root_item;
 
+	inode = btrfs_new_subvol_inode(mnt_userns, dir);
+	if (!inode) {
+		ret = -ENOMEM;
+		goto out_anon_dev;
+	}
+
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
 	 * The same as the snapshot creation, please see the comment
@@ -594,13 +600,13 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	 */
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 8, false);
 	if (ret)
-		goto out_anon_dev;
+		goto out_inode;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_subvolume_release_metadata(root, &block_rsv);
-		goto out_anon_dev;
+		goto out_inode;
 	}
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
@@ -683,16 +689,16 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	}
 	/* anon_dev is owned by new_root now. */
 	anon_dev = 0;
+	BTRFS_I(inode)->root = new_root;
+	/* ... and new_root is owned by inode now. */
 
 	ret = btrfs_record_root_in_trans(trans, new_root);
 	if (ret) {
-		btrfs_put_root(new_root);
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	ret = btrfs_create_subvol_root(trans, new_root, root, mnt_userns);
-	btrfs_put_root(new_root);
+	ret = btrfs_create_subvol_root(trans, root, inode);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
@@ -745,11 +751,11 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		ret = btrfs_commit_transaction(trans);
 
 	if (!ret) {
-		inode = btrfs_lookup_dentry(dir, dentry);
-		if (IS_ERR(inode))
-			return PTR_ERR(inode);
 		d_instantiate(dentry, inode);
+		inode = NULL;
 	}
+out_inode:
+	iput(inode);
 out_anon_dev:
 	if (anon_dev)
 		free_anon_bdev(anon_dev);
-- 
2.35.1

