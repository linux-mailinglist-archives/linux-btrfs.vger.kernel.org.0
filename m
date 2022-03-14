Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1574D8DC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 21:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiCNUGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244898AbiCNUGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 16:06:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1822403DB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:05:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u17so13702585pfk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFY7awzZDMFRhq2WEt8dK+ED9W2HyDdJ74UCKuKZeD0=;
        b=UsIjAzPlEOx2QP958JVt2mBNeDIjqxMLh+55dPwQK1Kz5kwiQFC+B5laV452i+LK94
         72r2WOa3xDk31mAbojBh7DUlRRYGtVxTDwSMTErZp2sMCkzd/1xiKMJtnI7DKai33wyd
         WkHk1MSsihCkNUTEQ2uQgZiDCBA9/yKv4XnYbmCjNzi/L1HaQrPfENBP1K3TGPawoYbC
         zy0mx4Gun4/diQYCizxo1jHRyUT6+mSJcw7tWb0dZ0KdyYaWdxeQhlF3EqXGaunCFeQ0
         e73EZtSs+XlGJWR/ryql0hzzoIp4iNpNXBAX7M8IzeA0wY8MeXpNSbLVygszhX+MrBAz
         xnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFY7awzZDMFRhq2WEt8dK+ED9W2HyDdJ74UCKuKZeD0=;
        b=x2/Uy4K5HIvSZSysetCRd+xnx6l8zcwUH2iHrzzIaEuDUIWuVeOu3J/TJ77qwcpAGp
         Ch9Q7sdiLcXyIDlgQTiGAlNVKQTzULI+eOhgNMrXjYFtYNbqnVIqmfWTqAehzatu1G8S
         AB1jc9W+sT2oVkWofnGQfU7nbDQP/t9RG6H3bk3QZA1iI9RW4nlrKtTgSYSgreEkCBQb
         RBQRte45rO1Pfhv4r0U7Jh6VpXjl0kdsMIIu8nGjhcHugD7hPMscMtxBInJDV6eplIc4
         t6V8YtwSaJV+gjfjgb+hnNMVs1PByzxtJx3za3zOnOFAjuDJa7uHmYQhU0YY7dnA/TO3
         mpWQ==
X-Gm-Message-State: AOAM530t/xavsp40mjVC7aYH2qlWQuiqMXzmdDNV48C7rFzutqEiVvr7
        ZELkuPXk+MRPG5IvUfbBvFjNEm8wgdRwAA==
X-Google-Smtp-Source: ABdhPJxOeQ1L+49sXIOe9XqwiFQc+cjPRngiI6Psv83OcHSKF9jVsuTgjTpgLZ4BYqUwHUgw6Fg36w==
X-Received: by 2002:a63:544c:0:b0:378:907d:1e37 with SMTP id e12-20020a63544c000000b00378907d1e37mr21541323pgm.394.1647288328209;
        Mon, 14 Mar 2022 13:05:28 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id mi13-20020a17090b4b4d00b001c6320d40c6sm187321pjb.45.2022.03.14.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:05:27 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v3 3/4] btrfs: reserve correct number of items for inode creation
Date:   Mon, 14 Mar 2022 13:05:18 -0700
Message-Id: <0f6214a621170a4398f30afcd6c6ae61f635cdef.1647288019.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647288019.git.osandov@fb.com>
References: <cover.1647288019.git.osandov@fb.com>
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

The various inode creation code paths do not account for the compression
property, POSIX ACLs, or the parent inode item when starting a
transaction. Fix it by refactoring all of these code paths to use a new
function, btrfs_new_inode_prepare(), which computes the correct number
of items. To do so, it needs to know whether POSIX ACLs will be created,
so move the ACL creation into that function. To reduce the number of
arguments that need to be passed around for inode creation, define
struct btrfs_new_inode_args containing all of the relevant information.

btrfs_new_inode_prepare() will also be a good place to set up the
fscrypt context and encrypted filename in the future.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/acl.c   |  36 +------
 fs/btrfs/ctree.h |  34 +++++--
 fs/btrfs/inode.c | 250 ++++++++++++++++++++++++++++++++++-------------
 fs/btrfs/ioctl.c |  83 +++++++++++-----
 4 files changed, 270 insertions(+), 133 deletions(-)

diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index a6909ec9bc38..548d6a5477b4 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -55,8 +55,8 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 
-static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
-			   struct inode *inode, struct posix_acl *acl, int type)
+int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
+		    struct posix_acl *acl, int type)
 {
 	int ret, size = 0;
 	const char *name;
@@ -127,35 +127,3 @@ int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		inode->i_mode = old_mode;
 	return ret;
 }
-
-int btrfs_init_acl(struct btrfs_trans_handle *trans,
-		   struct inode *inode, struct inode *dir)
-{
-	struct posix_acl *default_acl, *acl;
-	int ret = 0;
-
-	/* this happens with subvols */
-	if (!dir)
-		return 0;
-
-	ret = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
-	if (ret)
-		return ret;
-
-	if (default_acl) {
-		ret = __btrfs_set_acl(trans, inode, default_acl,
-				      ACL_TYPE_DEFAULT);
-		posix_acl_release(default_acl);
-	}
-
-	if (acl) {
-		if (!ret)
-			ret = __btrfs_set_acl(trans, inode, acl,
-					      ACL_TYPE_ACCESS);
-		posix_acl_release(acl);
-	}
-
-	if (!default_acl && !acl)
-		cache_no_acl(inode);
-	return ret;
-}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f39730420e8a..322c02610e9e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3254,11 +3254,32 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
+struct btrfs_new_inode_args {
+	/* Input */
+	struct inode *dir;
+	struct dentry *dentry;
+	struct inode *inode;
+	bool orphan;
+	bool subvol;
+
+	/*
+	 * Output from btrfs_new_inode_prepare(), input to
+	 * btrfs_create_new_inode().
+	 */
+	struct posix_acl *default_acl;
+	struct posix_acl *acl;
+};
+int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
+			    unsigned int *trans_num_items);
+int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
+			   struct btrfs_new_inode_args *args,
+			   u64 *index);
+void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
 struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
 				     struct inode *dir);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *parent_root,
-			     struct inode *inode);
+			     struct btrfs_new_inode_args *args);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
@@ -3816,15 +3837,16 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
 int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		  struct posix_acl *acl, int type);
-int btrfs_init_acl(struct btrfs_trans_handle *trans,
-		   struct inode *inode, struct inode *dir);
+int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
+		    struct posix_acl *acl, int type);
 #else
 #define btrfs_get_acl NULL
 #define btrfs_set_acl NULL
-static inline int btrfs_init_acl(struct btrfs_trans_handle *trans,
-				 struct inode *inode, struct inode *dir)
+static inline int __btrfs_set_acl(struct btrfs_trans_handle *trans,
+				  struct inode *inode, struct posix_acl *acl,
+				  int type)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 #endif
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bea2cb2d90a5..3ce02378480f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -222,15 +222,26 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 static int btrfs_dirty_inode(struct inode *inode);
 
 static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
-				     struct inode *inode,  struct inode *dir,
-				     const struct qstr *qstr)
+				     struct btrfs_new_inode_args *args)
 {
 	int err;
 
-	err = btrfs_init_acl(trans, inode, dir);
-	if (!err)
-		err = btrfs_xattr_security_init(trans, inode, dir, qstr);
-	return err;
+	if (args->default_acl) {
+		err = __btrfs_set_acl(trans, args->inode, args->default_acl,
+				      ACL_TYPE_DEFAULT);
+		if (err)
+			return err;
+	}
+	if (args->acl) {
+		err = __btrfs_set_acl(trans, args->inode, args->acl,
+				      ACL_TYPE_ACCESS);
+		if (err)
+			return err;
+	}
+	if (!args->default_acl && !args->acl)
+		cache_no_acl(args->inode);
+	return btrfs_xattr_security_init(trans, args->inode, args->dir,
+					 &args->dentry->d_name);
 }
 
 /*
@@ -6059,6 +6070,49 @@ static int btrfs_insert_inode_locked(struct inode *inode)
 		   btrfs_find_actor, &args);
 }
 
+int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
+			    unsigned int *trans_num_items)
+{
+	struct inode *dir = args->dir;
+	struct inode *inode = args->inode;
+	int ret;
+
+	ret = posix_acl_create(dir, &inode->i_mode, &args->default_acl,
+			       &args->acl);
+	if (ret)
+		return ret;
+
+	*trans_num_items = 1; /* 1 to add inode item */
+	if (BTRFS_I(dir)->prop_compress)
+		(*trans_num_items)++; /* 1 to add compression property */
+	if (args->default_acl)
+		(*trans_num_items)++; /* 1 to add default ACL xattr */
+	if (args->acl)
+		(*trans_num_items)++; /* 1 to add access ACL xattr */
+#ifdef CONFIG_SECURITY
+	if (dir->i_security)
+		(*trans_num_items)++; /* 1 to add LSM xattr */
+#endif
+	if (args->orphan) {
+		(*trans_num_items)++; /* 1 to add orphan item */
+	} else {
+		/*
+		 * 1 to add inode ref
+		 * 1 to add dir item
+		 * 1 to add dir index
+		 * 1 to update parent inode item
+		 */
+		*trans_num_items += 4;
+	}
+	return 0;
+}
+
+void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args)
+{
+	posix_acl_release(args->acl);
+	posix_acl_release(args->default_acl);
+}
+
 /*
  * Inherit flags from the parent inode.
  *
@@ -6090,12 +6144,16 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 	btrfs_sync_inode_flags_to_i_flags(inode);
 }
 
-static int btrfs_new_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root, struct inode *inode,
-			   struct inode *dir, const char *name, int name_len,
+int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
+			   struct btrfs_new_inode_args *args,
 			   u64 *index)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *dir = args->subvol ? NULL : args->dir;
+	struct inode *inode = args->inode;
+	const char *name;
+	int name_len;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_key *location;
 	struct btrfs_path *path;
@@ -6107,6 +6165,17 @@ static int btrfs_new_inode(struct btrfs_trans_handle *trans,
 	unsigned long ptr;
 	int ret;
 
+	if (args->subvol) {
+		name = "..";
+		name_len = 2;
+	} else if (args->orphan) {
+		name = NULL;
+		name_len = 0;
+	} else {
+		name = args->dentry->d_name.name;
+		name_len = args->dentry->d_name.len;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -6118,6 +6187,10 @@ static int btrfs_new_inode(struct btrfs_trans_handle *trans,
 	if (!name)
 		set_nlink(inode, 0);
 
+	if (!args->subvol)
+		BTRFS_I(inode)->root = btrfs_grab_root(BTRFS_I(dir)->root);
+	root = BTRFS_I(inode)->root;
+
 	ret = btrfs_get_free_objectid(root, &objectid);
 	if (ret) {
 		btrfs_free_path(path);
@@ -6143,7 +6216,6 @@ static int btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
 	BTRFS_I(inode)->dir_index = *index;
-	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
@@ -6351,30 +6423,37 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+		.inode = inode,
+	};
+	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
 	int err;
 	u64 index = 0;
 
-	/*
-	 * 2 for inode item and ref
-	 * 2 for dir items
-	 * 1 for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans)) {
+	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (err) {
 		iput(inode);
-		return PTR_ERR(trans);
+		return err;
 	}
 
-	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
-			      dentry->d_name.len, &index);
+	trans = btrfs_start_transaction(root, trans_num_items);
+	if (IS_ERR(trans)) {
+		iput(inode);
+		err = PTR_ERR(trans);
+		goto out_new_inode_args;
+	}
+
+	err = btrfs_create_new_inode(trans, &new_inode_args, &index);
 	if (err) {
 		iput(inode);
 		inode = NULL;
 		goto out_unlock;
 	}
 
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
+	err = btrfs_init_inode_security(trans, &new_inode_args);
 	if (err)
 		goto out_unlock;
 
@@ -6396,6 +6475,8 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 		discard_new_inode(inode);
 	}
 	btrfs_btree_balance_dirty(fs_info);
+out_new_inode_args:
+	btrfs_new_inode_args_destroy(&new_inode_args);
 	return err;
 }
 
@@ -8675,13 +8756,14 @@ struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
  */
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *parent_root,
-			     struct inode *inode)
+			     struct btrfs_new_inode_args *args)
 {
+	struct inode *inode = args->inode;
 	struct btrfs_root *new_root = BTRFS_I(inode)->root;
 	int err;
 	u64 index = 0;
 
-	err = btrfs_new_inode(trans, new_root, inode, NULL, "..", 2, &index);
+	err = btrfs_create_new_inode(trans, args, &index);
 	if (err)
 		return err;
 
@@ -9186,22 +9268,22 @@ static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
 }
 
 static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
-				     struct btrfs_root *root,
-				     struct inode *inode, struct inode *dir,
-				     struct dentry *dentry)
+				     struct btrfs_new_inode_args *args)
 {
+	struct inode *inode = args->inode;
+	struct inode *dir = args->dir;
+	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct dentry *dentry = args->dentry;
 	int ret;
 	u64 index;
 
-	ret = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
-			      dentry->d_name.len, &index);
+	ret = btrfs_create_new_inode(trans, args, &index);
 	if (ret) {
 		iput(inode);
 		return ret;
 	}
 
-	ret = btrfs_init_inode_security(trans, inode, dir,
-				&dentry->d_name);
+	ret = btrfs_init_inode_security(trans, args);
 	if (ret)
 		goto out;
 
@@ -9226,7 +9308,10 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 			unsigned int flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
-	struct inode *whiteout_inode;
+	struct btrfs_new_inode_args whiteout_args = {
+		.dir = old_dir,
+		.dentry = old_dentry,
+	};
 	struct btrfs_trans_handle *trans;
 	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
@@ -9282,9 +9367,15 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		filemap_flush(old_inode->i_mapping);
 
 	if (flags & RENAME_WHITEOUT) {
-		whiteout_inode = new_whiteout_inode(mnt_userns, old_dir);
-		if (!whiteout_inode)
+		whiteout_args.inode = new_whiteout_inode(mnt_userns, old_dir);
+		if (!whiteout_args.inode)
 			return -ENOMEM;
+		ret = btrfs_new_inode_prepare(&whiteout_args, &trans_num_items);
+		if (ret)
+			goto out_whiteout_inode;
+	} else {
+		/* 1 to update the old parent inode. */
+		trans_num_items = 1;
 	}
 
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
@@ -9296,24 +9387,25 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		 * 1 to add new root ref
 		 * 1 to add new root backref
 		 */
-		trans_num_items = 4;
+		trans_num_items += 4;
 	} else {
 		/*
 		 * 1 to update inode
 		 * 1 to remove old inode ref
 		 * 1 to add new inode ref
 		 */
-		trans_num_items = 3;
+		trans_num_items += 3;
 	}
 	/*
 	 * 1 to remove old dir item
 	 * 1 to remove old dir index
-	 * 1 to update old parent inode
 	 * 1 to add new dir item
 	 * 1 to add new dir index
-	 * 1 to update new parent inode (if it's not the same as the old parent)
 	 */
-	trans_num_items += 6;
+	trans_num_items += 4;
+	/*
+	 * 1 to update new parent inode if it's not the same as the old parent
+	 */
 	if (new_dir != old_dir)
 		trans_num_items++;
 	if (new_inode) {
@@ -9326,8 +9418,6 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		 */
 		trans_num_items += 5;
 	}
-	if (flags & RENAME_WHITEOUT)
-		trans_num_items += 5;
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -9423,9 +9513,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 				   rename_ctx.index, new_dentry->d_parent);
 
 	if (flags & RENAME_WHITEOUT) {
-		ret = btrfs_whiteout_for_rename(trans, root, whiteout_inode,
-						old_dir, old_dentry);
-		whiteout_inode = NULL;
+		ret = btrfs_whiteout_for_rename(trans, &whiteout_args);
+		whiteout_args.inode = NULL;
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_fail;
@@ -9438,7 +9527,10 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
 		up_read(&fs_info->subvol_sem);
 	if (flags & RENAME_WHITEOUT)
-		iput(whiteout_inode);
+		btrfs_new_inode_args_destroy(&whiteout_args);
+out_whiteout_inode:
+	if (flags & RENAME_WHITEOUT)
+		iput(whiteout_args.inode);
 	return ret;
 }
 
@@ -9658,6 +9750,11 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct inode *inode;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+	};
+	unsigned int trans_num_items;
 	int err;
 	u64 index = 0;
 	int name_len;
@@ -9678,28 +9775,30 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	inode_nohighmem(inode);
 	inode->i_mapping->a_ops = &btrfs_aops;
 
-	/*
-	 * 2 items for inode item and ref
-	 * 2 items for dir items
-	 * 1 item for updating parent inode item
-	 * 1 item for the inline extent item
-	 * 1 item for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 7);
+	new_inode_args.inode = inode;
+	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (err) {
+		iput(inode);
+		return err;
+	}
+	/* 1 additional item for the inline extent */
+	trans_num_items++;
+
+	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
 		iput(inode);
-		return PTR_ERR(trans);
+		err = PTR_ERR(trans);
+		goto out_new_inode_args;
 	}
 
-	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
-			      dentry->d_name.len, &index);
+	err = btrfs_create_new_inode(trans, &new_inode_args, &index);
 	if (err) {
 		iput(inode);
 		inode = NULL;
 		goto out_unlock;
 	}
 
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
+	err = btrfs_init_inode_security(trans, &new_inode_args);
 	if (err)
 		goto out_unlock;
 
@@ -9758,6 +9857,8 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		discard_new_inode(inode);
 	}
 	btrfs_btree_balance_dirty(fs_info);
+out_new_inode_args:
+	btrfs_new_inode_args_destroy(&new_inode_args);
 	return err;
 }
 
@@ -10014,6 +10115,12 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+		.orphan = true,
+	};
+	unsigned int trans_num_items;
 	u64 index;
 	int ret;
 
@@ -10025,23 +10132,28 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
 
-	/*
-	 * 5 units required for adding orphan entry
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans)) {
+	new_inode_args.inode = inode;
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (ret) {
 		iput(inode);
-		return PTR_ERR(trans);
+		return ret;
 	}
 
-	ret = btrfs_new_inode(trans, root, inode, dir, NULL, 0, &index);
+	trans = btrfs_start_transaction(root, trans_num_items);
+	if (IS_ERR(trans)) {
+		iput(inode);
+		ret = PTR_ERR(trans);
+		goto out_new_inode_args;
+	}
+
+	ret = btrfs_create_new_inode(trans, &new_inode_args, &index);
 	if (ret) {
 		iput(inode);
 		inode = NULL;
 		goto out;
 	}
 
-	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
+	ret = btrfs_init_inode_security(trans, &new_inode_args);
 	if (ret)
 		goto out;
 
@@ -10053,9 +10165,9 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 
 	/*
-	 * We set number of links to 0 in btrfs_new_inode(), and here we set
-	 * it to 1 because d_tmpfile() will issue a warning if the count is 0,
-	 * through:
+	 * We set number of links to 0 in btrfs_create_new_inode(), and here we
+	 * set it to 1 because d_tmpfile() will issue a warning if the count is
+	 * 0, through:
 	 *
 	 *    d_tmpfile() -> inode_dec_link_count() -> drop_nlink()
 	 */
@@ -10068,6 +10180,8 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ret && inode)
 		discard_new_inode(inode);
 	btrfs_btree_balance_dirty(fs_info);
+out_new_inode_args:
+	btrfs_new_inode_args_destroy(&new_inode_args);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 60c907b14547..07a74bbe3d84 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -544,6 +544,32 @@ int __pure btrfs_is_empty_uuid(u8 *uuid)
 	return 1;
 }
 
+/*
+ * Calculate the number of transaction items to reserve for creating a subvolume
+ * or snapshot, not including the inode, directory entries, or parent directory.
+ */
+static unsigned int create_subvol_num_items(struct btrfs_qgroup_inherit *inherit)
+{
+	/*
+	 * 1 to add root block
+	 * 1 to add root item
+	 * 1 to add root ref
+	 * 1 to add root backref
+	 * 1 to add UUID item
+	 * 1 to add qgroup info
+	 * 1 to add qgroup limit
+	 * (Ideally the last two would only be accounted if qgroups are enabled,
+	 * but that can change between now and the time we would insert them)
+	 */
+	unsigned int num_items = 7;
+
+	if (inherit) {
+		/* 2 to add qgroup relations for each inherited qgroup */
+		num_items += 2 * inherit->num_qgroups;
+	}
+	return num_items;
+}
+
 static noinline int create_subvol(struct user_namespace *mnt_userns,
 				  struct inode *dir, struct dentry *dentry,
 				  struct btrfs_qgroup_inherit *inherit)
@@ -560,7 +586,12 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	struct btrfs_root *new_root;
 	struct btrfs_block_rsv block_rsv;
 	struct timespec64 cur_time = current_time(dir);
-	struct inode *inode;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+		.subvol = true,
+	};
+	unsigned int trans_num_items;
 	int ret;
 	dev_t anon_dev;
 	u64 objectid;
@@ -587,26 +618,27 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	if (ret < 0)
 		goto out_root_item;
 
-	inode = btrfs_new_subvol_inode(mnt_userns, dir);
-	if (!inode) {
+	new_inode_args.inode = btrfs_new_subvol_inode(mnt_userns, dir);
+	if (!new_inode_args.inode) {
 		ret = -ENOMEM;
 		goto out_anon_dev;
 	}
-
-	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
-	/*
-	 * The same as the snapshot creation, please see the comment
-	 * of create_snapshot().
-	 */
-	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 8, false);
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
 	if (ret)
 		goto out_inode;
+	trans_num_items += create_subvol_num_items(inherit);
+
+	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
+	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv,
+					       trans_num_items, false);
+	if (ret)
+		goto out_new_inode_args;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_subvolume_release_metadata(root, &block_rsv);
-		goto out_inode;
+		goto out_new_inode_args;
 	}
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
@@ -689,8 +721,8 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	}
 	/* anon_dev is owned by new_root now. */
 	anon_dev = 0;
-	BTRFS_I(inode)->root = new_root;
-	/* ... and new_root is owned by inode now. */
+	BTRFS_I(new_inode_args.inode)->root = new_root;
+	/* ... and new_root is owned by new_inode_args.inode now. */
 
 	ret = btrfs_record_root_in_trans(trans, new_root);
 	if (ret) {
@@ -698,7 +730,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		goto out;
 	}
 
-	ret = btrfs_create_subvol_root(trans, root, inode);
+	ret = btrfs_create_subvol_root(trans, root, &new_inode_args);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
@@ -751,11 +783,13 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		ret = btrfs_commit_transaction(trans);
 
 	if (!ret) {
-		d_instantiate(dentry, inode);
-		inode = NULL;
+		d_instantiate(dentry, new_inode_args.inode);
+		new_inode_args.inode = NULL;
 	}
+out_new_inode_args:
+	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
-	iput(inode);
+	iput(new_inode_args.inode);
 out_anon_dev:
 	if (anon_dev)
 		free_anon_bdev(anon_dev);
@@ -771,6 +805,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct inode *inode;
 	struct btrfs_pending_snapshot *pending_snapshot;
+	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
 	int ret;
 
@@ -808,16 +843,14 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
 			     BTRFS_BLOCK_RSV_TEMP);
 	/*
-	 * 1 - parent dir inode
-	 * 2 - dir entries
-	 * 1 - root item
-	 * 2 - root ref/backref
-	 * 1 - root of snapshot
-	 * 1 - UUID item
+	 * 1 to add dir item
+	 * 1 to add dir index
+	 * 1 to update parent inode item
 	 */
+	trans_num_items = create_subvol_num_items(inherit) + 3;
 	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root,
-					&pending_snapshot->block_rsv, 8,
-					false);
+					       &pending_snapshot->block_rsv,
+					       trans_num_items, false);
 	if (ret)
 		goto free_pending;
 
-- 
2.35.1

