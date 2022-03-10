Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E74D3ECE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiCJBdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbiCJBdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0EEEF7B7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s11so3754838pfu.13
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKrdC5EREXqWdy56T723d+3Ts7HGE9szNbmLFDfYZJA=;
        b=Rp0xGQ2Vz7ALRzRSztRSMpvPQfzr/TMOdTJjvGSGY6T5fIJWsD8V9m/FbseEqTMWyt
         ypywfTAE30BBzpOZr6Bxk16g13Vm0cLZOcXa42vZ6fxV3W4VWWlCmEQOhffHR46/cVhU
         J45qIIrLZWi9QH++1TwuSa22Q9ur2cg0FRH8+PjM2UxYU8QIewcLz8uCxm1t9l7koHHw
         U/8D8t1KqysKT/y3Vo5qMqlgV7gU6bZGIqYn6b6uFzBoVnfCQvo9ZdK/yZdx84XaGqYP
         N4YiXQAgdp2GiszgOlKqXtrjrw7eOgqnhKYftuoVscDIbh+ERuWKivYEs+nt3WJ9eZxn
         ZIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKrdC5EREXqWdy56T723d+3Ts7HGE9szNbmLFDfYZJA=;
        b=OMET7fMuZBp1iI0gBoomJK3swmXFn4/4E0yZQ0FeescKM8vqiydWNwLCwtTv8Bb2/n
         9wmsMXroz3X+xbtAC8CvvwJvXQ9cRn9krIYOU2kZMrMXn0j9WzNLU9pgMZGsLkdIcWOU
         ie/4ItUGOGz5Ro5vE9Xk5cMOLmW7TeKm6s9j7cjADple+fwRdhJlj4j+hWll24eFaoTT
         YILrMnJ6UxSfhj3Gd3oO7JdhYK6oJ6r5Y1qrUX53GmNqdRn5Vm5gDbjBAxaR9y7gAgCc
         vrK0Paq07PzdcDo7OpoGWkVIgoDCxqMxKqptoh7eggc42olLkKxEyzMV4D2LPNlQP6ij
         iSZA==
X-Gm-Message-State: AOAM533m4F33OfwUfi+nt+cfU7LXQ1be2GEceDoQTfA62tK6KJA0Iamn
        eiGuKpnjbpnVu2UVr0h+NwhgQUe0u2lp7A==
X-Google-Smtp-Source: ABdhPJxOhqaAeHwAT6mjCMeSHq1huKsD/dtQCoYZpxlkw3ae+mdl8kN+KCe3sx4li5PXupeTlVKHDg==
X-Received: by 2002:a63:5051:0:b0:374:5fd0:f131 with SMTP id q17-20020a635051000000b003745fd0f131mr2061291pgl.431.1646875931971;
        Wed, 09 Mar 2022 17:32:11 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:11 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 16/16] btrfs: move common inode creation code into btrfs_create_new_inode()
Date:   Wed,  9 Mar 2022 17:31:46 -0800
Message-Id: <6218b380a71e669de4489fdb32d3ac4b05a61e18.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

All of our inode creation code paths duplicate the calls to
btrfs_init_inode_security() and btrfs_add_link(). Subvolume creation
additionally duplicates property inheritance and the call to
btrfs_set_inode_index(). Fix this by moving the common code into
btrfs_create_new_inode(). This accomplishes a few things at once:

1. It reduces code duplication.
2. It allows us to set up the inode completely before inserting the
   inode item, removing calls to btrfs_update_inode().
3. It fixes a leak of an inode on disk in some error cases. For example,
   in btrfs_create(), if btrfs_new_inode() succeeds, then we have
   inserted an inode item and its inode ref. However, if something after
   that fails (e.g., btrfs_init_inode_security()), then we end the
   transaction and then decrement the link count on the inode. If the
   transaction is committed and the system crashes before the failed
   inode is deleted, then we leak that inode on disk. Instead, this
   refactoring aborts the transaction when we can't recover more
   gracefully.
4. It exposes various ways that subvolume creation diverges from mkdir
   in terms of inheriting flags, properties, permissions, and POSIX
   ACLs, a lot of which appears to be accidental. This patch explicitly
   does _not_ change the existing non-standard behavior, but it makes
   those differences more clear in the code and documents them so that
   we can discuss whether they should be changed.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   6 +-
 fs/btrfs/inode.c | 413 +++++++++++++++++++----------------------------
 fs/btrfs/ioctl.c |  59 ++-----
 fs/btrfs/props.c |  40 +----
 fs/btrfs/props.h |   4 -
 5 files changed, 182 insertions(+), 340 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 322c02610e9e..3a348b26df57 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3272,14 +3272,10 @@ struct btrfs_new_inode_args {
 int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 			    unsigned int *trans_num_items);
 int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_new_inode_args *args,
-			   u64 *index);
+			   struct btrfs_new_inode_args *args);
 void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
 struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 				     struct inode *dir);
-int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *parent_root,
-			     struct btrfs_new_inode_args *args);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e2b1b1969d0b..ff2a7404ba86 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6123,9 +6123,6 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 {
 	unsigned int flags;
 
-	if (!dir)
-		return;
-
 	flags = BTRFS_I(dir)->flags;
 
 	if (flags & BTRFS_INODE_NOCOMPRESS) {
@@ -6146,14 +6143,13 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 }
 
 int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_new_inode_args *args,
-			   u64 *index)
+			   struct btrfs_new_inode_args *args)
 {
-	struct inode *dir = args->subvol ? NULL : args->dir;
+	struct inode *dir = args->dir;
 	struct inode *inode = args->inode;
-	const char *name;
-	int name_len;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	const char *name = args->orphan ? NULL : args->dentry->d_name.name;
+	int name_len = args->orphan ? 0 : args->dentry->d_name.len;
+	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_key *location;
@@ -6166,49 +6162,32 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	unsigned long ptr;
 	int ret;
 
-	if (args->subvol) {
-		name = "..";
-		name_len = 2;
-	} else if (args->orphan) {
-		name = NULL;
-		name_len = 0;
-	} else {
-		name = args->dentry->d_name.name;
-		name_len = args->dentry->d_name.len;
-	}
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	/*
-	 * O_TMPFILE, set link count to 0, so that after this point,
-	 * we fill in an inode item with the correct link count.
-	 */
-	if (!name)
-		set_nlink(inode, 0);
-
 	if (!args->subvol)
 		BTRFS_I(inode)->root = btrfs_grab_root(BTRFS_I(dir)->root);
 	root = BTRFS_I(inode)->root;
 
 	ret = btrfs_get_free_objectid(root, &objectid);
-	if (ret) {
-		btrfs_free_path(path);
-		return ret;
-	}
+	if (ret)
+		goto out;
 	inode->i_ino = objectid;
 
-	if (dir && name) {
+	if (args->orphan) {
+		/*
+		 * O_TMPFILE, set link count to 0, so that after this point, we
+		 * fill in an inode item with the correct link count.
+		 */
+		set_nlink(inode, 0);
+	} else {
 		trace_btrfs_inode_request(dir);
 
-		ret = btrfs_set_inode_index(BTRFS_I(dir), index);
-		if (ret) {
-			btrfs_free_path(path);
-			return ret;
-		}
-	} else if (dir) {
-		*index = 0;
+		ret = btrfs_set_inode_index(BTRFS_I(dir),
+					    &BTRFS_I(inode)->dir_index);
+		if (ret)
+			goto out;
 	}
 	/*
 	 * index_cnt is ignored for everything but a dir,
@@ -6216,11 +6195,16 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	 * number
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
-	BTRFS_I(inode)->dir_index = *index;
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
-	btrfs_inherit_iflags(inode, dir);
+	/*
+	 * Subvolumes don't inherit flags from their parent directory.
+	 * Originally this was probably by accident, but we probably can't
+	 * change it now.
+	 */
+	if (!args->subvol)
+		btrfs_inherit_iflags(inode, dir);
 
 	if (S_ISREG(inode->i_mode)) {
 		if (btrfs_test_opt(fs_info, NODATASUM))
@@ -6230,6 +6214,57 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 				BTRFS_INODE_NODATASUM;
 	}
 
+	location = &BTRFS_I(inode)->location;
+	location->objectid = objectid;
+	location->offset = 0;
+	location->type = BTRFS_INODE_ITEM_KEY;
+
+	ret = btrfs_insert_inode_locked(inode);
+	if (ret < 0) {
+		if (!args->orphan)
+			BTRFS_I(dir)->index_cnt--;
+		goto out;
+	}
+
+	if (args->subvol) {
+		struct inode *parent;
+
+		/*
+		 * Subvolumes inherit properties from their parent subvolume,
+		 * not the directory they were created in.
+		 */
+		parent = btrfs_iget(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
+				    BTRFS_I(dir)->root);
+		if (IS_ERR(parent)) {
+			ret = PTR_ERR(parent);
+		} else {
+			ret = btrfs_inode_inherit_props(trans, inode, parent);
+			iput(parent);
+		}
+	} else {
+		ret = btrfs_inode_inherit_props(trans, inode, dir);
+	}
+	if (ret) {
+		btrfs_err(fs_info,
+			  "error inheriting props for ino %llu (root %llu): %d",
+			  btrfs_ino(BTRFS_I(inode)), root->root_key.objectid,
+			  ret);
+	}
+
+	/*
+	 * Subvolumes don't inherit ACLs or get passed to the LSM. This is
+	 * probably a bug.
+	 */
+	if (!args->subvol) {
+		ret = btrfs_init_inode_security(trans, inode, dir,
+						&args->dentry->d_name,
+						args->default_acl, args->acl);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto discard;
+		}
+	}
+
 	/*
 	 * We could have gotten an inode number from somebody who was fsynced
 	 * and then removed in this same transaction, so let's just set full
@@ -6244,7 +6279,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 
 	sizes[0] = sizeof(struct btrfs_inode_item);
 
-	if (name) {
+	if (!args->orphan) {
 		/*
 		 * Start new inodes with an inode_ref. This is slightly more
 		 * efficient for small numbers of hard links since they will
@@ -6253,53 +6288,61 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		 */
 		key[1].objectid = objectid;
 		key[1].type = BTRFS_INODE_REF_KEY;
-		if (dir)
-			key[1].offset = btrfs_ino(BTRFS_I(dir));
-		else
+		if (args->subvol) {
 			key[1].offset = objectid;
-
-		sizes[1] = name_len + sizeof(*ref);
+			sizes[1] = 2 + sizeof(*ref);
+		} else {
+			key[1].offset = btrfs_ino(BTRFS_I(dir));
+			sizes[1] = name_len + sizeof(*ref);
+		}
 	}
 
-	location = &BTRFS_I(inode)->location;
-	location->objectid = objectid;
-	location->offset = 0;
-	location->type = BTRFS_INODE_ITEM_KEY;
-
-	ret = btrfs_insert_inode_locked(inode);
-	if (ret < 0)
-		goto fail;
-
 	batch.keys = &key[0];
 	batch.data_sizes = &sizes[0];
-	batch.total_data_size = sizes[0] + (name ? sizes[1] : 0);
-	batch.nr = name ? 2 : 1;
+	batch.total_data_size = sizes[0] + (args->orphan ? 0 : sizes[1]);
+	batch.nr = args->orphan ? 1 : 2;
 	ret = btrfs_insert_empty_items(trans, root, path, &batch);
-	if (ret != 0)
-		goto fail_unlock;
+	if (ret != 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto discard;
+	}
 
 	inode->i_mtime = current_time(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
 	BTRFS_I(inode)->i_otime = inode->i_mtime;
 
+	/*
+	 * We're going to fill the inode item now, so at this point the inode
+	 * must be fully initialized.
+	 */
+
 	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				  struct btrfs_inode_item);
 	memzero_extent_buffer(path->nodes[0], (unsigned long)inode_item,
 			     sizeof(*inode_item));
 	fill_inode_item(trans, path->nodes[0], inode_item, inode);
 
-	if (name) {
+	if (!args->orphan) {
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0] + 1,
 				     struct btrfs_inode_ref);
-		btrfs_set_inode_ref_name_len(path->nodes[0], ref, name_len);
-		btrfs_set_inode_ref_index(path->nodes[0], ref, *index);
 		ptr = (unsigned long)(ref + 1);
-		write_extent_buffer(path->nodes[0], name, ptr, name_len);
+		if (args->subvol) {
+			btrfs_set_inode_ref_name_len(path->nodes[0], ref, 2);
+			btrfs_set_inode_ref_index(path->nodes[0], ref, 0);
+			write_extent_buffer(path->nodes[0], "..", ptr, 2);
+		} else {
+			btrfs_set_inode_ref_name_len(path->nodes[0], ref,
+						     name_len);
+			btrfs_set_inode_ref_index(path->nodes[0], ref,
+						  BTRFS_I(inode)->dir_index);
+			write_extent_buffer(path->nodes[0], name, ptr,
+					    name_len);
+		}
 	}
 
 	btrfs_mark_buffer_dirty(path->nodes[0]);
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 
 	inode_tree_add(inode);
 
@@ -6308,24 +6351,28 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_update_root_times(trans, root);
 
-	ret = btrfs_inode_inherit_props(trans, inode, dir);
-	if (ret)
-		btrfs_err(fs_info,
-			  "error inheriting props for ino %llu (root %llu): %d",
-			btrfs_ino(BTRFS_I(inode)), root->root_key.objectid, ret);
+	if (args->orphan) {
+		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+	} else {
+		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
+				     name_len, 0, BTRFS_I(inode)->dir_index);
+	}
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto discard;
+	}
 
-	return 0;
+	ret = 0;
+	goto out;
 
-fail_unlock:
+discard:
 	/*
 	 * discard_new_inode() calls iput(), but the caller owns the reference
 	 * to the inode.
 	 */
 	ihold(inode);
 	discard_new_inode(inode);
-fail:
-	if (dir && name)
-		BTRFS_I(dir)->index_cnt--;
+out:
 	btrfs_free_path(path);
 	return ret;
 }
@@ -6432,54 +6479,28 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
 	int err;
-	u64 index = 0;
 
 	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
-	if (err) {
-		iput(inode);
-		return err;
-	}
+	if (err)
+		goto out_inode;
 
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
-		iput(inode);
 		err = PTR_ERR(trans);
 		goto out_new_inode_args;
 	}
 
-	err = btrfs_create_new_inode(trans, &new_inode_args, &index);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out_unlock;
-	}
+	err = btrfs_create_new_inode(trans, &new_inode_args);
+	if (!err)
+		d_instantiate_new(dentry, inode);
 
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name,
-					new_inode_args.default_acl,
-					new_inode_args.acl);
-	if (err)
-		goto out_unlock;
-
-	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (err)
-		goto out_unlock;
-
-	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     dentry->d_name.name, dentry->d_name.len, 0, index);
-	if (err)
-		goto out_unlock;
-
-	d_instantiate_new(dentry, inode);
-
-out_unlock:
 	btrfs_end_transaction(trans);
-	if (err && inode) {
-		inode_dec_link_count(inode);
-		discard_new_inode(inode);
-	}
 	btrfs_btree_balance_dirty(fs_info);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
+out_inode:
+	if (err)
+		iput(inode);
 	return err;
 }
 
@@ -8754,34 +8775,6 @@ struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 	return inode;
 }
 
-/*
- * create a new subvolume directory/inode (helper for the ioctl).
- */
-int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *parent_root,
-			     struct btrfs_new_inode_args *args)
-{
-	struct inode *inode = args->inode;
-	struct btrfs_root *new_root = BTRFS_I(inode)->root;
-	int err;
-	u64 index = 0;
-
-	err = btrfs_create_new_inode(trans, args, &index);
-	if (err)
-		return err;
-
-	unlock_new_inode(inode);
-
-	err = btrfs_subvol_inherit_props(trans, new_root, parent_root);
-	if (err)
-		btrfs_err(new_root->fs_info,
-			  "error inheriting subvolume %llu properties: %d",
-			  new_root->root_key.objectid, err);
-
-	err = btrfs_update_inode(trans, new_root, BTRFS_I(inode));
-	return err;
-}
-
 struct inode *btrfs_alloc_inode(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -9270,42 +9263,6 @@ static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
 	return inode;
 }
 
-static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
-				     struct btrfs_new_inode_args *args)
-{
-	struct inode *inode = args->inode;
-	struct inode *dir = args->dir;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct dentry *dentry = args->dentry;
-	int ret;
-	u64 index;
-
-	ret = btrfs_create_new_inode(trans, args, &index);
-	if (ret) {
-		iput(inode);
-		return ret;
-	}
-
-	ret = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name,
-					args->default_acl, args->acl);
-	if (ret)
-		goto out;
-
-	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     dentry->d_name.name, dentry->d_name.len, 0, index);
-	if (ret)
-		goto out;
-
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-out:
-	unlock_new_inode(inode);
-	if (ret)
-		inode_dec_link_count(inode);
-	iput(inode);
-
-	return ret;
-}
-
 static int btrfs_rename(struct user_namespace *mnt_userns,
 			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
@@ -9517,11 +9474,14 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 				   rename_ctx.index, new_dentry->d_parent);
 
 	if (flags & RENAME_WHITEOUT) {
-		ret = btrfs_whiteout_for_rename(trans, &whiteout_args);
-		whiteout_args.inode = NULL;
+		ret = btrfs_create_new_inode(trans, &whiteout_args);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_fail;
+		} else {
+			unlock_new_inode(whiteout_args.inode);
+			iput(whiteout_args.inode);
+			whiteout_args.inode = NULL;
 		}
 	}
 out_fail:
@@ -9760,7 +9720,6 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	};
 	unsigned int trans_num_items;
 	int err;
-	u64 index = 0;
 	int name_len;
 	int datasize;
 	unsigned long ptr;
@@ -9778,40 +9737,33 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_op = &btrfs_symlink_inode_operations;
 	inode_nohighmem(inode);
 	inode->i_mapping->a_ops = &btrfs_aops;
+	btrfs_i_size_write(BTRFS_I(inode), name_len);
+	inode_set_bytes(inode, name_len);
 
 	new_inode_args.inode = inode;
 	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
-	if (err) {
-		iput(inode);
-		return err;
-	}
+	if (err)
+		goto out_inode;
 	/* 1 additional item for the inline extent */
 	trans_num_items++;
 
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
-		iput(inode);
 		err = PTR_ERR(trans);
 		goto out_new_inode_args;
 	}
 
-	err = btrfs_create_new_inode(trans, &new_inode_args, &index);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out_unlock;
-	}
-
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name,
-					new_inode_args.default_acl,
-					new_inode_args.acl);
+	err = btrfs_create_new_inode(trans, &new_inode_args);
 	if (err)
-		goto out_unlock;
+		goto out;
 
 	path = btrfs_alloc_path();
 	if (!path) {
 		err = -ENOMEM;
-		goto out_unlock;
+		btrfs_abort_transaction(trans, err);
+		discard_new_inode(inode);
+		inode = NULL;
+		goto out;
 	}
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 	key.offset = 0;
@@ -9820,8 +9772,11 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	err = btrfs_insert_empty_item(trans, root, path, &key,
 				      datasize);
 	if (err) {
+		btrfs_abort_transaction(trans, err);
 		btrfs_free_path(path);
-		goto out_unlock;
+		discard_new_inode(inode);
+		inode = NULL;
+		goto out;
 	}
 	leaf = path->nodes[0];
 	ei = btrfs_item_ptr(leaf, path->slots[0],
@@ -9839,32 +9794,16 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	inode_set_bytes(inode, name_len);
-	btrfs_i_size_write(BTRFS_I(inode), name_len);
-	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	/*
-	 * Last step, add directory indexes for our symlink inode. This is the
-	 * last step to avoid extra cleanup of these indexes if an error happens
-	 * elsewhere above.
-	 */
-	if (!err)
-		err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-				     dentry->d_name.name, dentry->d_name.len, 0,
-				     index);
-	if (err)
-		goto out_unlock;
-
 	d_instantiate_new(dentry, inode);
-
-out_unlock:
+	err = 0;
+out:
 	btrfs_end_transaction(trans);
-	if (err && inode) {
-		inode_dec_link_count(inode);
-		discard_new_inode(inode);
-	}
 	btrfs_btree_balance_dirty(fs_info);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
+out_inode:
+	if (err)
+		iput(inode);
 	return err;
 }
 
@@ -10127,7 +10066,6 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		.orphan = true,
 	};
 	unsigned int trans_num_items;
-	u64 index;
 	int ret;
 
 	inode = new_inode(dir->i_sb);
@@ -10140,37 +10078,16 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 
 	new_inode_args.inode = inode;
 	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
-	if (ret) {
-		iput(inode);
-		return ret;
-	}
+	if (ret)
+		goto out_inode;
 
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
-		iput(inode);
 		ret = PTR_ERR(trans);
 		goto out_new_inode_args;
 	}
 
-	ret = btrfs_create_new_inode(trans, &new_inode_args, &index);
-	if (ret) {
-		iput(inode);
-		inode = NULL;
-		goto out;
-	}
-
-	ret = btrfs_init_inode_security(trans, inode, dir, NULL,
-					new_inode_args.default_acl,
-					new_inode_args.acl);
-	if (ret)
-		goto out;
-
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (ret)
-		goto out;
-	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
-	if (ret)
-		goto out;
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
 
 	/*
 	 * We set number of links to 0 in btrfs_create_new_inode(), and here we
@@ -10180,16 +10097,20 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	 *    d_tmpfile() -> inode_dec_link_count() -> drop_nlink()
 	 */
 	set_nlink(inode, 1);
-	d_tmpfile(dentry, inode);
-	unlock_new_inode(inode);
-	mark_inode_dirty(inode);
-out:
+
+	if (!ret) {
+		d_tmpfile(dentry, inode);
+		unlock_new_inode(inode);
+		mark_inode_dirty(inode);
+	}
+
 	btrfs_end_transaction(trans);
-	if (ret && inode)
-		discard_new_inode(inode);
 	btrfs_btree_balance_dirty(fs_info);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
+out_inode:
+	if (ret)
+		iput(inode);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 07a74bbe3d84..24b3e384aa8f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -574,8 +574,6 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 				  struct inode *dir, struct dentry *dentry,
 				  struct btrfs_qgroup_inherit *inherit)
 {
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
@@ -595,7 +593,6 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	int ret;
 	dev_t anon_dev;
 	u64 objectid;
-	u64 index = 0;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -712,7 +709,6 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	free_extent_buffer(leaf);
 	leaf = NULL;
 
-	key.offset = (u64)-1;
 	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
@@ -730,47 +726,21 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		goto out;
 	}
 
-	ret = btrfs_create_subvol_root(trans, root, &new_inode_args);
-	if (ret) {
-		/* We potentially lose an unused inode item here */
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-
-	/*
-	 * insert the directory item
-	 */
-	ret = btrfs_set_inode_index(BTRFS_I(dir), &index);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-
-	ret = btrfs_insert_dir_item(trans, name, namelen, BTRFS_I(dir), &key,
-				    BTRFS_FT_DIR, index);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-
-	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-
-	ret = btrfs_add_root_ref(trans, objectid, root->root_key.objectid,
-				 btrfs_ino(BTRFS_I(dir)), index, name, namelen);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-
 	ret = btrfs_uuid_tree_add(trans, root_item->uuid,
 				  BTRFS_UUID_KEY_SUBVOL, objectid);
-	if (ret)
+	if (ret) {
 		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
+	d_instantiate_new(dentry, new_inode_args.inode);
+	new_inode_args.inode = NULL;
 
 out:
 	trans->block_rsv = NULL;
@@ -781,11 +751,6 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		btrfs_end_transaction(trans);
 	else
 		ret = btrfs_commit_transaction(trans);
-
-	if (!ret) {
-		d_instantiate(dentry, new_inode_args.inode);
-		new_inode_args.inode = NULL;
-	}
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 1a6d2d5b4b33..f5565c296898 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -334,9 +334,8 @@ static struct prop_handler prop_handlers[] = {
 	},
 };
 
-static int inherit_props(struct btrfs_trans_handle *trans,
-			 struct inode *inode,
-			 struct inode *parent)
+int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
+			      struct inode *inode, struct inode *parent)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -408,41 +407,6 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
-			      struct inode *inode,
-			      struct inode *dir)
-{
-	if (!dir)
-		return 0;
-
-	return inherit_props(trans, inode, dir);
-}
-
-int btrfs_subvol_inherit_props(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct btrfs_root *parent_root)
-{
-	struct super_block *sb = root->fs_info->sb;
-	struct inode *parent_inode, *child_inode;
-	int ret;
-
-	parent_inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, parent_root);
-	if (IS_ERR(parent_inode))
-		return PTR_ERR(parent_inode);
-
-	child_inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, root);
-	if (IS_ERR(child_inode)) {
-		iput(parent_inode);
-		return PTR_ERR(child_inode);
-	}
-
-	ret = inherit_props(trans, child_inode, parent_inode);
-	iput(child_inode);
-	iput(parent_inode);
-
-	return ret;
-}
-
 void __init btrfs_props_init(void)
 {
 	int i;
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 40b2c65b518c..1dcd5daa3b22 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -21,8 +21,4 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 			      struct inode *inode,
 			      struct inode *dir);
 
-int btrfs_subvol_inherit_props(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       struct btrfs_root *parent_root);
-
 #endif
-- 
2.35.1

