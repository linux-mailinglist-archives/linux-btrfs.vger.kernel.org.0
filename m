Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3BA57F25A
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiGXAyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiGXAyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:31 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF015A31;
        Sat, 23 Jul 2022 17:54:27 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 3231380BB8;
        Sat, 23 Jul 2022 20:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624067; bh=KMwdQ6jAOvtGoMIPsbcGzqZbBHsSZvYnkfyOv2An2yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmDUj6qv6wKQsNL7DT3Gcnqv+XG4UD9MfaQDcSyDEoclpMYezUhjOmyj4YwYcoili
         ffdM2364z8PXr42UgtmTatL7h2vyC5vhaGkWtPhk1vNKHYw8rvHAudVGyqwVV+/fMM
         hUlfrvvknupOQQvo0btze4zkZJ4OcvydOTDNVH1D61XFk0jqqoWzUNOoUmE2uiD5hD
         56+PY8kjz7GfsPquCCkW+kN3gQ/zesxHhoM6ZusWKOSfSVUGVDTIjThNBLHNd+yJeX
         Qy50fJVbd1tjUJ/ziaAsBOg1tGbD+gGzunCfFlMZlhNbFUwJ8tqbS6XJscqJt9jEHM
         c97GpxqY5Sccw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 03/16] btrfs: setup fscrypt_names from dentrys using helper
Date:   Sat, 23 Jul 2022 20:53:48 -0400
Message-Id: <2ecf66c3f7e99bb6cfa0da31a29638efeb8233f4.1658623319.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1658623319.git.sweettea-kernel@dorminy.me>
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most places that we create fscrypt_names, we are doing so from a dentry.
Fscrypt provides a helper for this common pattern:
fscrypt_setup_filename() initializes a filename to search for from a
dentry, performing encryption of the plaintext if it can and should be
done. This converts each setup of a fscrypt_name from a dentry to use
this helper; at present, since there are no encrypted directories,
nothing goes down the filename encryption paths.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/inode.c       | 153 ++++++++++++++++++++++++++---------------
 fs/btrfs/transaction.c |  26 +++++--
 fs/btrfs/tree-log.c    |  12 ++--
 3 files changed, 123 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b3406f79db8..3d2e8d9e2fd2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4406,14 +4406,17 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct btrfs_trans_handle *trans;
 	struct inode *inode = d_inode(dentry);
 	int ret;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((unsigned char *)dentry->d_name.name, dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
 
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	if (ret)
+		return ret;
 
 	trans = __unlink_start_trans(dir);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto out;
+	}
 
 	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 			0);
@@ -4430,6 +4433,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 out:
+	fscrypt_free_filename(&fname);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(BTRFS_I(dir)->root->fs_info);
 	return ret;
@@ -4448,10 +4452,11 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	int ret;
 	u64 objectid;
 	u64 dir_ino = btrfs_ino(BTRFS_I(dir));
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((char *) dentry->d_name.name,
-				       dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
+
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	if (ret)
+		return ret;
 
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		objectid = inode->root->root_key.objectid;
@@ -4459,12 +4464,15 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		objectid = inode->location.objectid;
 	} else {
 		WARN_ON(1);
+		fscrypt_free_filename(&fname);
 		return -EINVAL;
 	}
 
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, &fname, -1);
 	if (IS_ERR_OR_NULL(di)) {
@@ -4531,6 +4539,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 out:
 	btrfs_free_path(path);
+	fscrypt_free_filename(&fname);
 	return ret;
 }
 
@@ -4797,9 +4806,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	int err = 0;
 	struct btrfs_trans_handle *trans;
 	u64 last_unlink_trans;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((unsigned char *)dentry->d_name.name, dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
@@ -4812,9 +4819,15 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		return btrfs_delete_subvolume(dir, dentry);
 	}
 
+	err = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	if (err)
+		return err;
+
 	trans = __unlink_start_trans(dir);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	if (IS_ERR(trans)) {
+		err = PTR_ERR(trans);
+		goto out_notrans;
+	}
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		err = btrfs_unlink_subvol(trans, dir, dentry);
@@ -4848,7 +4861,9 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 out:
 	btrfs_end_transaction(trans);
+out_notrans:
 	btrfs_btree_balance_dirty(fs_info);
+	fscrypt_free_filename(&fname);
 
 	return err;
 }
@@ -5543,7 +5558,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 /*
  * Return the key found in the dir entry in the location pointer, fill @type
- * with BTRFS_FT_*, and return 0.
+ * with BTRFS_FT_*, and return 0. Used only for lookups, not removals.
  *
  * If no dir entries were found, returns -ENOENT.
  * If found a corrupted location in dir entry, returns -EUCLEAN.
@@ -5555,15 +5570,16 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	int ret = 0;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((char *) dentry->d_name.name,
-				       dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	if (ret)
+		goto out;
+
 	di = btrfs_lookup_dir_item(NULL, root, path, btrfs_ino(BTRFS_I(dir)),
 				   &fname, 0);
 	if (IS_ERR_OR_NULL(di)) {
@@ -5583,6 +5599,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 	if (!ret)
 		*type = btrfs_dir_ftype(path->nodes[0], di);
 out:
+	fscrypt_free_filename(&fname);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -5603,9 +5620,15 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	struct btrfs_root_ref *ref;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
+	struct fscrypt_name fname;
 	int ret;
 	int err = 0;
 
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 0,
+				     &fname);
+	if (ret)
+		return ret;
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		err = -ENOMEM;
@@ -5651,6 +5674,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	err = 0;
 out:
 	btrfs_free_path(path);
+	fscrypt_free_filename(&fname);
 	return err;
 }
 
@@ -6257,16 +6281,17 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 	struct inode *inode = args->inode;
 	int ret;
 
+	if (!args->orphan) {
+		ret = fscrypt_setup_filename(dir, &args->dentry->d_name, 0,
+					     &args->fname);
+		if (ret)
+			return ret;
+	}
+
 	ret = posix_acl_create(dir, &inode->i_mode, &args->default_acl, &args->acl);
-	if (ret)
+	if (ret) {
+		fscrypt_free_filename(&args->fname);
 		return ret;
-
-	if (!args->orphan) {
-		char *name = (char *) args->dentry->d_name.name;
-		int name_len = args->dentry->d_name.len;
-		args->fname = (struct fscrypt_name) {
-			.disk_name = FSTR_INIT(name, name_len),
-		};
 	}
 
 	/* 1 to add inode item */
@@ -6307,6 +6332,7 @@ void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args)
 {
 	posix_acl_release(args->acl);
 	posix_acl_release(args->default_acl);
+	fscrypt_free_filename(&args->fname);
 }
 
 /*
@@ -6734,10 +6760,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((char *) dentry->d_name.name,
-				       dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
 	u64 index;
 	int err;
 	int drop_inode = 0;
@@ -6749,6 +6772,10 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
 		return -EMLINK;
 
+	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
+	if (err)
+		goto fail;
+
 	err = btrfs_set_inode_index(BTRFS_I(dir), &index);
 	if (err)
 		goto fail;
@@ -6799,6 +6826,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	}
 
 fail:
+	fscrypt_free_filename(&fname);
 	if (trans)
 		btrfs_end_transaction(trans);
 	if (drop_inode) {
@@ -9169,14 +9197,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	int ret;
 	int ret2;
 	bool need_abort = false;
-	struct fscrypt_name old_name = {
-		.disk_name = FSTR_INIT((char *) old_dentry->d_name.name,
-				       old_dentry->d_name.len)
-	};
-	struct fscrypt_name new_name = {
-		.disk_name = FSTR_INIT((char *) new_dentry->d_name.name,
-				       new_dentry->d_name.len)
-	};
+	struct fscrypt_name old_fname, new_fname;
 
 	/*
 	 * For non-subvolumes allow exchange only within one subvolume, in the
@@ -9188,6 +9209,16 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	     new_ino != BTRFS_FIRST_FREE_OBJECTID))
 		return -EXDEV;
 
+	ret = fscrypt_setup_filename(old_dir, &old_dentry->d_name, 0, &old_fname);
+	if (ret)
+		return ret;
+
+	ret = fscrypt_setup_filename(new_dir, &new_dentry->d_name, 0, &new_fname);
+	if (ret) {
+		fscrypt_free_filename(&old_fname);
+		return ret;
+	}
+
 	/* close the race window with snapshot create/destroy ioctl */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID ||
 	    new_ino == BTRFS_FIRST_FREE_OBJECTID)
@@ -9255,7 +9286,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, dest, &new_name, old_ino,
+		ret = btrfs_insert_inode_ref(trans, dest, &new_fname, old_ino,
 					     btrfs_ino(BTRFS_I(new_dir)),
 					     old_idx);
 		if (ret)
@@ -9268,7 +9299,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, root, &old_name, new_ino,
+		ret = btrfs_insert_inode_ref(trans, root, &old_fname, new_ino,
 					     btrfs_ino(BTRFS_I(old_dir)),
 					     new_idx);
 		if (ret) {
@@ -9302,7 +9333,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
-					   BTRFS_I(old_dentry->d_inode), &old_name,
+					   BTRFS_I(old_dentry->d_inode), &old_fname,
 					   &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
@@ -9317,7 +9348,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
-					   BTRFS_I(new_dentry->d_inode), &new_name,
+					   BTRFS_I(new_dentry->d_inode), &new_fname,
 					   &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
@@ -9328,14 +9359,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
-			     &new_name, 0, old_idx);
+			     &new_fname, 0, old_idx);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(old_dir), BTRFS_I(new_inode),
-			     &old_name, 0, new_idx);
+			     &old_fname, 0, new_idx);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out_fail;
@@ -9378,6 +9409,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	    old_ino == BTRFS_FIRST_FREE_OBJECTID)
 		up_read(&fs_info->subvol_sem);
 
+	fscrypt_free_filename(&new_fname);
+	fscrypt_free_filename(&old_fname);
 	return ret;
 }
 
@@ -9417,14 +9450,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	int ret;
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
-	struct fscrypt_name old_fname = {
-		.disk_name = FSTR_INIT((char *)old_dentry->d_name.name,
-				       old_dentry->d_name.len)
-	};
-	struct fscrypt_name new_fname = {
-		.disk_name = FSTR_INIT((char *)new_dentry->d_name.name,
-				       new_dentry->d_name.len)
-	};
+	struct fscrypt_name old_fname, new_fname;
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -9441,6 +9467,16 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	    new_inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
 
+	ret = fscrypt_setup_filename(old_dir, &old_dentry->d_name, 0, &old_fname);
+	if (ret)
+		return ret;
+
+	ret = fscrypt_setup_filename(new_dir, &new_dentry->d_name, 0, &new_fname);
+	if (ret) {
+		fscrypt_free_filename(&old_fname);
+		return ret;
+	}
+
 	/* check for collisions, even if the  name isn't there */
 	ret = btrfs_check_dir_item_collision(dest, new_dir->i_ino, &new_fname);
 
@@ -9449,11 +9485,11 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 			/* we shouldn't get
 			 * eexist without a new_inode */
 			if (WARN_ON(!new_inode)) {
-				return ret;
+				goto out_fscrypt_names;
 			}
 		} else {
 			/* maybe -EOVERFLOW */
-			return ret;
+			goto out_fscrypt_names;
 		}
 	}
 	ret = 0;
@@ -9627,6 +9663,9 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 out_whiteout_inode:
 	if (flags & RENAME_WHITEOUT)
 		iput(whiteout_args.inode);
+out_fscrypt_names:
+	fscrypt_free_filename(&old_fname);
+	fscrypt_free_filename(&new_fname);
 	return ret;
 }
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index fe705e3a615e..f6cceeee138f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -6,6 +6,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/writeback.h>
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
@@ -1637,10 +1638,8 @@ create_pending_snapshot(struct btrfs_trans_handle *trans,
 	u64 index = 0;
 	u64 objectid;
 	u64 root_flags;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((char *) pending->dentry->d_name.name,
-				       pending->dentry->d_name.len)
-	};
+	unsigned int mem_flags;
+	struct fscrypt_name fname;
 
 	ASSERT(pending->path);
 	path = pending->path;
@@ -1648,9 +1647,22 @@ create_pending_snapshot(struct btrfs_trans_handle *trans,
 	ASSERT(pending->root_item);
 	new_root_item = pending->root_item;
 
+	/*
+	 * Since this is during btrfs_commit_transaction() and more items
+	 * joining the transaction at this point would be bad, use NOFS
+	 * allocations so that no new writes are kicked off.
+	 */
+	mem_flags = memalloc_nofs_save();
+	pending->error = fscrypt_setup_filename(parent_inode,
+						&pending->dentry->d_name, 0,
+						&fname);
+	memalloc_nofs_restore(mem_flags);
+	if (pending->error)
+		goto free_pending;
+
 	pending->error = btrfs_get_free_objectid(tree_root, &objectid);
 	if (pending->error)
-		goto no_free_objectid;
+		goto free_fname;
 
 	/*
 	 * Make qgroup to skip current new snapshot's qgroupid, as it is
@@ -1864,7 +1876,9 @@ create_pending_snapshot(struct btrfs_trans_handle *trans,
 	trans->bytes_reserved = 0;
 clear_skip_qgroup:
 	btrfs_clear_skip_qgroup(trans);
-no_free_objectid:
+free_fname:
+	fscrypt_free_filename(&fname);
+free_pending:
 	kfree(new_root_item);
 	pending->root_item = NULL;
 	btrfs_free_path(path);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 51a706e84e00..d73238254274 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7042,13 +7042,13 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	if (old_dir && old_dir->logged_trans == trans->transid) {
 		struct btrfs_root *log = old_dir->root->log_root;
 		struct btrfs_path *path;
-		struct fscrypt_name fname = {
-			.disk_name = FSTR_INIT((char *) old_dentry->d_name.name,
-					       old_dentry->d_name.len)
-		};
-
+		struct fscrypt_name fname;
 		ASSERT(old_dir_index >= BTRFS_DIR_START_INDEX);
 
+		ret = fscrypt_setup_filename(&old_dir->vfs_inode,
+					     &old_dentry->d_name, 0, &fname);
+		if (ret)
+			goto out;
 		/*
 		 * We have two inodes to update in the log, the old directory and
 		 * the inode that got renamed, so we must pin the log to prevent
@@ -7068,6 +7068,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		path = btrfs_alloc_path();
 		if (!path) {
 			ret = -ENOMEM;
+			fscrypt_free_filename(&fname);
 			goto out;
 		}
 
@@ -7097,6 +7098,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		mutex_unlock(&old_dir->log_mutex);
 
 		btrfs_free_path(path);
+		fscrypt_free_filename(&fname);
 		if (ret < 0)
 			goto out;
 	}
-- 
2.35.1

