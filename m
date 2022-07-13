Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B236573441
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiGMKa4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbiGMKax (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:53 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CBBFC989
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:51 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 8F1D28111E;
        Wed, 13 Jul 2022 06:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708251; bh=4uqpGo8qy3Bvwxt2inUNeCmG/GdZeE2uhg525J81V0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYOpfLxBLOLSR9zAoT2dhOO8YO85yDvHPb05f+XrSvHNhJ6ZU3/Uo9im0lNPYtLz0
         9uWYr4LACkxgxVYSH8lGQ4XDXcXE6ybp6P4OdLmrZd4TM0g9VeMGUup1usWwwmGGOs
         +cDAe0CeGKO0yBdviM1A8jO7l2EhECPI4Ut2hFAa3aXeBjDUzO3DK8Ve00jXO0lKlk
         wWYaOqA5h/agdQfzAdANCvnYOfGw7X5RHMjpP70bQQaO51U4+oATSWLGqUvjzy1u8g
         7MfxZr6hhz/50wHh/E7IG0adwtjz7Oh9AktZsapMGB8SO6Szv+vzwaGLTB8O5CSi8n
         TBwTEGCQBt7Dg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 07/23] btrfs: setup fscrypt_names from dentrys using helper
Date:   Wed, 13 Jul 2022 06:29:40 -0400
Message-Id: <8386fc3358d47243a7fbbf7cb957bc7ed8f342b5.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 fs/btrfs/inode.c       | 151 ++++++++++++++++++++++++++---------------
 fs/btrfs/transaction.c |  26 +++++--
 fs/btrfs/tree-log.c    |  12 ++--
 3 files changed, 123 insertions(+), 66 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27742237ac7d..ad556e8d5dac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4411,14 +4411,17 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
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
@@ -4435,6 +4438,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 out:
+	fscrypt_free_filename(&fname);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(BTRFS_I(dir)->root->fs_info);
 	return ret;
@@ -4453,9 +4457,11 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	int ret;
 	u64 objectid;
 	u64 dir_ino = btrfs_ino(BTRFS_I(dir));
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT(dentry->d_name.name, dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
+
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	if (ret)
+		return ret;
 
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		objectid = inode->root->root_key.objectid;
@@ -4463,12 +4469,15 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		objectid = inode->location.objectid;
 	} else {
 		WARN_ON(1);
+		fscrypt_free_fname(&fname);
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
@@ -4535,6 +4544,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 out:
 	btrfs_free_path(path);
+	fscrypt_free_filename(&fname);
 	return ret;
 }
 
@@ -4801,9 +4811,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	int err = 0;
 	struct btrfs_trans_handle *trans;
 	u64 last_unlink_trans;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT((unsigned char *)dentry->d_name.name, dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
 		return -ENOTEMPTY;
@@ -4816,9 +4824,15 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -4852,7 +4866,9 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 out:
 	btrfs_end_transaction(trans);
+out_notrans:
 	btrfs_btree_balance_dirty(fs_info);
+	fscrypt_free_filename(&fname);
 
 	return err;
 }
@@ -5547,7 +5563,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 /*
  * Return the key found in the dir entry in the location pointer, fill @type
- * with BTRFS_FT_*, and return 0.
+ * with BTRFS_FT_*, and return 0. Used only for lookups, not removals.
  *
  * If no dir entries were found, returns -ENOENT.
  * If found a corrupted location in dir entry, returns -EUCLEAN.
@@ -5559,14 +5575,16 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	int ret = 0;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT(dentry->d_name.name, dentry->d_name.len)
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
@@ -5586,6 +5604,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 	if (!ret)
 		*type = btrfs_dir_ftype(path->nodes[0], di);
 out:
+	fscrypt_free_filename(&fname);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -5606,9 +5625,15 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
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
@@ -5654,6 +5679,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 	err = 0;
 out:
 	btrfs_free_path(path);
+	fscrypt_free_filename(&fname);
 	return err;
 }
 
@@ -6260,16 +6286,17 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
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
+		fscrypt_free_fname(&args->fname);
 		return ret;
-
-	if (!args->orphan) {
-		const char *name = args->dentry->d_name.name;
-		int name_len = args->dentry->d_name.len;
-		args->fname = (struct fscrypt_name) {
-			.disk_name = FSTR_INIT(name, name_len),
-		};
 	}
 
 	/* 1 to add inode item */
@@ -6310,6 +6337,7 @@ void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args)
 {
 	posix_acl_release(args->acl);
 	posix_acl_release(args->default_acl);
+	fscrypt_free_filename(&args->fname);
 }
 
 /*
@@ -6737,10 +6765,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT(dentry->d_name.name,
-				       dentry->d_name.len)
-	};
+	struct fscrypt_name fname;
 	u64 index;
 	int err;
 	int drop_inode = 0;
@@ -6752,6 +6777,10 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
 		return -EMLINK;
 
+	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
+	if (err)
+		goto fail;
+
 	err = btrfs_set_inode_index(BTRFS_I(dir), &index);
 	if (err)
 		goto fail;
@@ -6802,6 +6831,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	}
 
 fail:
+	fscrypt_free_filename(&fname);
 	if (trans)
 		btrfs_end_transaction(trans);
 	if (drop_inode) {
@@ -9169,14 +9199,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	int ret;
 	int ret2;
 	bool need_abort = false;
-	struct fscrypt_name old_name = {
-		.disk_name = FSTR_INIT(old_dentry->d_name.name,
-				       old_dentry->d_name.len)
-	};
-	struct fscrypt_name new_name = {
-		.disk_name = FSTR_INIT(new_dentry->d_name.name,
-				       new_dentry->d_name.len)
-	};
+	struct fscrypt_name old_fname, new_fname;
 
 	/*
 	 * For non-subvolumes allow exchange only within one subvolume, in the
@@ -9188,6 +9211,16 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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
@@ -9255,7 +9288,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, dest, &new_name, old_ino,
+		ret = btrfs_insert_inode_ref(trans, dest, &new_fname, old_ino,
 					     btrfs_ino(BTRFS_I(new_dir)),
 					     old_idx);
 		if (ret)
@@ -9268,7 +9301,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		/* force full log commit if subvolume involved. */
 		btrfs_set_log_full_commit(trans);
 	} else {
-		ret = btrfs_insert_inode_ref(trans, root, &old_name, new_ino,
+		ret = btrfs_insert_inode_ref(trans, root, &old_fname, new_ino,
 					     btrfs_ino(BTRFS_I(old_dir)),
 					     new_idx);
 		if (ret) {
@@ -9302,7 +9335,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
-					   BTRFS_I(old_dentry->d_inode), &old_name,
+					   BTRFS_I(old_dentry->d_inode), &old_fname,
 					   &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, root, BTRFS_I(old_inode));
@@ -9317,7 +9350,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
-					   BTRFS_I(new_dentry->d_inode), &new_name,
+					   BTRFS_I(new_dentry->d_inode), &new_fname,
 					   &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, dest, BTRFS_I(new_inode));
@@ -9328,14 +9361,14 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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
@@ -9378,6 +9411,8 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	    old_ino == BTRFS_FIRST_FREE_OBJECTID)
 		up_read(&fs_info->subvol_sem);
 
+	fscrypt_free_filename(&new_fname);
+	fscrypt_free_filename(&old_fname);
 	return ret;
 }
 
@@ -9417,14 +9452,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	int ret;
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
-	struct fscrypt_name old_fname = {
-		.disk_name = FSTR_INIT(old_dentry->d_name.name,
-				       old_dentry->d_name.len)
-	};
-	struct fscrypt_name new_fname = {
-		.disk_name = FSTR_INIT(new_dentry->d_name.name,
-				       new_dentry->d_name.len)
-	};
+	struct fscrypt_name old_fname, new_fname;
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -9441,6 +9469,16 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
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
 
@@ -9449,11 +9487,11 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
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
@@ -9627,6 +9665,9 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 out_whiteout_inode:
 	if (flags & RENAME_WHITEOUT)
 		iput(whiteout_args.inode);
+out_fscrypt_names:
+	fscrypt_free_filename(&old_fname);
+	fscrypt_free_filename(&new_fname);
 	return ret;
 }
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4ef6299af949..ac3121068461 100644
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
@@ -1624,10 +1625,8 @@ create_pending_snapshot(struct btrfs_trans_handle *trans,
 	u64 index = 0;
 	u64 objectid;
 	u64 root_flags;
-	struct fscrypt_name fname = {
-		.disk_name = FSTR_INIT(pending->dentry->d_name.name,
-				       pending->dentry->d_name.len)
-	};
+	unsigned int mem_flags;
+	struct fscrypt_name fname;
 
 	ASSERT(pending->path);
 	path = pending->path;
@@ -1635,9 +1634,22 @@ create_pending_snapshot(struct btrfs_trans_handle *trans,
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
@@ -1852,7 +1864,9 @@ create_pending_snapshot(struct btrfs_trans_handle *trans,
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
index 118ab4f5bb11..4959e8ecc99a 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7033,13 +7033,13 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	if (old_dir && old_dir->logged_trans == trans->transid) {
 		struct btrfs_root *log = old_dir->root->log_root;
 		struct btrfs_path *path;
-		struct fscrypt_name fname = {
-			.disk_name = FSTR_INIT(old_dentry->d_name.name,
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
@@ -7052,6 +7052,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		path = btrfs_alloc_path();
 		if (!path) {
 			ret = -ENOMEM;
+			fscrypt_free_filename(&fname);
 			goto out;
 		}
 
@@ -7081,6 +7082,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		mutex_unlock(&old_dir->log_mutex);
 
 		btrfs_free_path(path);
+		fscrypt_free_filename(&fname);
 		if (ret < 0)
 			goto out;
 	}
-- 
2.35.1

