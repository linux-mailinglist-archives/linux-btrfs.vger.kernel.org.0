Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D494CC9F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiCCXUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiCCXUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1512B2DD6D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:34 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso6414352pjo.5
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLINxLnfOwThGvK62EORK9JMWC7kPmp05dCmongQNoM=;
        b=Y3PzBz+0d/98ZXon/CjFF0fEP7ZbFK7M0zW1MqLx/TA1lqxlZCYXtOnq4doDt0mL3t
         5reMhQgkHVMIhZmNilAwF/KSGicHvweiKCw+bWM1Ry4eg+QE4/Ylg+32SmEWxXsobAcJ
         pCq/nSWvRCcGe9JIt5k1S+UywvaEXXKKqz+nJh9H1ljLGiGxGRpW0dDvpKwM4zUJ2Fke
         IXR1I97pQIYs/qJVBWPgA+xXHPmOIJAG10Vbv+Voq6WDVlnzBO/AQ9UdfigAdGE95uax
         +n58dxI4UDJ1dv+Ndco5BG0xTWgakyg0DQ1A30FTf4uNYgZsu+ZsXN2RzqMEdLMUsqom
         BH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLINxLnfOwThGvK62EORK9JMWC7kPmp05dCmongQNoM=;
        b=CGrub7jRssvpce1mcQ53X/77vmPiXogLbZzKalD8aPEP7kcwJmR9zHieIiI6t6mP0q
         4P7n/ZNlYVdRCT74X/2Aq7ZfKw694C40PFvvqWxhkbrqMoVzQVWgtt13krxrXRUJBeEw
         Qs5EjfV/CsBjVgz3V/x8bosJmT7J8VEcw9nFp+8nfNho6OsrDt9WYHZBuWCjWMewAcfv
         v2ZIsKbhMrSxkMhbMbD+EfR8v0tjO/iaDncmzpkAw1jBwX+CE8JvIzjog1nxyHDkUE5a
         jFXIdEKOGYGIbpup0GnR1GXq0eXwnkhQxszi1dWLCGyxtCEF0MpTztMXrIBjNupaslB0
         H6tQ==
X-Gm-Message-State: AOAM5324dtSCbHSuK32Lg20k84xuo3U5W3w3P3up0sigOEAQw071dJAD
        GoQVSQr6vqdjEdW+ULdlLkZKZsYQdXuByQ==
X-Google-Smtp-Source: ABdhPJybeenfpEmUQkhzl+nomAXtkUXZVuKCUii9ZBj7Sro7wFX6YKsJPuCVjdkexmbBIlf676LJ4Q==
X-Received: by 2002:a17:903:2c5:b0:14f:4a29:1f64 with SMTP id s5-20020a17090302c500b0014f4a291f64mr39228484plk.90.1646349572625;
        Thu, 03 Mar 2022 15:19:32 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:32 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 12/12] btrfs: rework inode creation to fix several issues
Date:   Thu,  3 Mar 2022 15:19:02 -0800
Message-Id: <c7edee49c1935f66c07c5c2c1aa98a599e4a11ad.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
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

Inode creation currently has several issues:

* Parts of the creation code path are duplicated between every operation
  that creates an inode: create, mknod, mkdir, RENAME_WHITEOUT, symlink,
  O_TMPFILE, and subvolume creation. This makes it hard to fix bugs or
  add features to inode creation (in particular, preparatory work for
  fscrypt).
* Subvolume creation in particular duplicates code in a way that
  diverges from the usual inode creation behavior when it comes to
  inherting flags, properties, permissions, and ACLs.
* We insert an inode item first and then modify the inode and update the
  item again. This is a silly inefficiency.
* Creation does not account for the compression property, ACLs, or the
  parent inode item when starting the transaction.
* We can leak an inode on disk in some error cases. For example, in
  btrfs_create(), if btrfs_new_inode() succeeds, then we have inserted
  an inode item and its inode ref. However, if something after that
  fails (e.g., btrfs_init_inode_security()), then we end the transaction
  and then decrement the link count on the inode. If the transaction is
  committed and the system crashes before the failed inode is deleted,
  then we leak that inode on disk.

I tried to fix these issues in their own separate patches, but they're
all interconnected and much easier to fix all in one go. The solution is
to unify all of the inode creation code paths into a single code path
with two steps:

1. btrfs_new_inode_prepare(), which does the correct accounting and
   security preparations (currently POSIX ACLs, but this is where
   fscrypt context setup will go).
2. btrfs_create_new_inode(), which does the actual B-tree modifications
   for the inode and its name.

This is a straightforward fix for the code duplication issue, the
unnecessary inode update issue, and the accounting issue. It explicitly
does _not_ change the existing non-standard subvolume behavior around
flags, permissions, ACLs, etc., but it makes those differences more
clear in the code and documents them so that we can discuss whether they
should be changed. Finally, it fixes the inode leak issue by aborting
the transaction when we can't recover more gracefully. This shouldn't be
an issue now that we're accounting space correctly.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/acl.c   |  36 +--
 fs/btrfs/ctree.h |  39 ++-
 fs/btrfs/inode.c | 801 +++++++++++++++++++++++------------------------
 fs/btrfs/ioctl.c | 174 +++++-----
 fs/btrfs/props.c |  40 +--
 fs/btrfs/props.h |   4 -
 6 files changed, 508 insertions(+), 586 deletions(-)

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
index 4db17bd05a21..6fa63dfac573 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3254,10 +3254,30 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state);
-int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root,
-			     struct user_namespace *mnt_userns);
+
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
+			   struct btrfs_new_inode_args *args);
+void btrfs_new_inode_args_free(struct btrfs_new_inode_args *args);
+struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+				     struct inode *dir);
+
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
@@ -3815,15 +3835,16 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
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
index c47bdada2440..2f17e0598664 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -223,14 +223,26 @@ static int btrfs_dirty_inode(struct inode *inode);
 
 static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
 				     struct inode *inode,  struct inode *dir,
-				     const struct qstr *qstr)
+				     const struct qstr *qstr,
+				     struct posix_acl *default_acl,
+				     struct posix_acl *acl)
 {
 	int err;
 
-	err = btrfs_init_acl(trans, inode, dir);
-	if (!err)
-		err = btrfs_xattr_security_init(trans, inode, dir, qstr);
-	return err;
+	if (default_acl) {
+		err = __btrfs_set_acl(trans, inode, default_acl,
+				      ACL_TYPE_DEFAULT);
+		if (err)
+			return err;
+	}
+	if (acl) {
+		err = __btrfs_set_acl(trans, inode, acl, ACL_TYPE_ACCESS);
+		if (err)
+			return err;
+	}
+	if (!default_acl && !acl)
+		cache_no_acl(inode);
+	return btrfs_xattr_security_init(trans, inode, dir, qstr);
 }
 
 /*
@@ -6059,6 +6071,49 @@ static int btrfs_insert_inode_locked(struct inode *inode)
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
+void btrfs_new_inode_args_free(struct btrfs_new_inode_args *args)
+{
+	posix_acl_release(args->acl);
+	posix_acl_release(args->default_acl);
+}
+
 /*
  * Inherit flags from the parent inode.
  *
@@ -6068,9 +6123,6 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 {
 	unsigned int flags;
 
-	if (!dir)
-		return;
-
 	flags = BTRFS_I(dir)->flags;
 
 	if (flags & BTRFS_INODE_NOCOMPRESS) {
@@ -6090,65 +6142,52 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 	btrfs_sync_inode_flags_to_i_flags(inode);
 }
 
-static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
-				     struct btrfs_root *root,
-				     struct user_namespace *mnt_userns,
-				     struct inode *dir,
-				     const char *name, int name_len,
-				     umode_t mode, u64 *index)
+int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
+			   struct btrfs_new_inode_args *args)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode *inode;
-	struct btrfs_inode_item *inode_item;
-	struct btrfs_key *location;
+	struct inode *dir = args->dir;
+	struct inode *inode = args->inode;
+	const char *name = args->orphan ? NULL : args->dentry->d_name.name;
+	int name_len = args->orphan ? 0 : args->dentry->d_name.len;
+	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_path *path;
 	u64 objectid;
-	struct btrfs_inode_ref *ref;
+	struct btrfs_key *location;
+	struct btrfs_root *root;
 	struct btrfs_key key[2];
 	u32 sizes[2];
 	struct btrfs_item_batch batch;
+	struct btrfs_inode_item *inode_item;
+	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
-	unsigned int nofs_flag;
 	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	nofs_flag = memalloc_nofs_save();
-	inode = new_inode(fs_info->sb);
-	memalloc_nofs_restore(nofs_flag);
-	if (!inode) {
-		btrfs_free_path(path);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	/*
-	 * O_TMPFILE, set link count to 0, so that after this point,
-	 * we fill in an inode item with the correct link count.
-	 */
-	if (!name)
-		set_nlink(inode, 0);
+	if (!args->subvol)
+		BTRFS_I(inode)->root = btrfs_grab_root(BTRFS_I(dir)->root);
+	root = BTRFS_I(inode)->root;
 
 	ret = btrfs_get_free_objectid(root, &objectid);
-	if (ret) {
-		btrfs_free_path(path);
-		iput(inode);
-		return ERR_PTR(ret);
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
-			iput(inode);
-			return ERR_PTR(ret);
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
@@ -6156,14 +6195,18 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 * number
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
-	BTRFS_I(inode)->dir_index = *index;
-	BTRFS_I(inode)->root = btrfs_grab_root(root);
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
 
-	if (S_ISREG(mode)) {
+	if (S_ISREG(inode->i_mode)) {
 		if (btrfs_test_opt(fs_info, NODATASUM))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
 		if (btrfs_test_opt(fs_info, NODATACOW))
@@ -6171,6 +6214,57 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
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
@@ -6185,7 +6279,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 
 	sizes[0] = sizeof(struct btrfs_inode_item);
 
-	if (name) {
+	if (!args->orphan) {
 		/*
 		 * Start new inodes with an inode_ref. This is slightly more
 		 * efficient for small numbers of hard links since they will
@@ -6194,57 +6288,61 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
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
-	}
-
-	location = &BTRFS_I(inode)->location;
-	location->objectid = objectid;
-	location->offset = 0;
-	location->type = BTRFS_INODE_ITEM_KEY;
-
-	ret = btrfs_insert_inode_locked(inode);
-	if (ret < 0) {
-		iput(inode);
-		goto fail;
+			sizes[1] = 2 + sizeof(*ref);
+		} else {
+			key[1].offset = btrfs_ino(BTRFS_I(dir));
+			sizes[1] = name_len + sizeof(*ref);
+		}
 	}
 
 	batch.keys = &key[0];
 	batch.data_sizes = &sizes[0];
-	batch.total_data_size = sizes[0] + (name ? sizes[1] : 0);
-	batch.nr = name ? 2 : 1;
+	batch.total_data_size = sizes[0] + (args->orphan ? 0 : sizes[1]);
+	batch.nr = args->orphan ? 1 : 2;
 	ret = btrfs_insert_empty_items(trans, root, path, &batch);
-	if (ret != 0)
-		goto fail_unlock;
-
-	inode_init_owner(mnt_userns, inode, dir, mode);
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
 
@@ -6253,21 +6351,26 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 
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
 
-	return inode;
+	ret = 0;
+	goto out;
 
-fail_unlock:
+discard:
+	ihold(inode);
 	discard_new_inode(inode);
-fail:
-	if (dir && name)
-		BTRFS_I(dir)->index_cnt--;
+out:
 	btrfs_free_path(path);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /*
@@ -6359,125 +6462,72 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
+			       struct inode *inode)
+{
+
+	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+		.inode = inode,
+	};
+	unsigned int trans_num_items;
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (ret)
+		goto out_inode;
+
+	trans = btrfs_start_transaction(root, trans_num_items);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto out_new_inode_args;
+	}
+
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
+	if (!ret)
+		d_instantiate_new(dentry, inode);
+
+	btrfs_end_transaction(trans);
+	btrfs_btree_balance_dirty(fs_info);
+out_new_inode_args:
+	btrfs_new_inode_args_free(&new_inode_args);
+out_inode:
+	if (ret)
+		iput(inode);
+	return ret;
+}
+
 static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode = NULL;
-	int err;
-	u64 index = 0;
+	struct inode *inode;
 
-	/*
-	 * 2 for inode item and ref
-	 * 2 for dir items
-	 * 1 for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-			dentry->d_name.name, dentry->d_name.len,
-			mode, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		inode = NULL;
-		goto out_unlock;
-	}
-
-	/*
-	* If the active LSM wants to access the inode during
-	* d_instantiate it needs these. Smack checks to see
-	* if the filesystem supports xattrs by looking at the
-	* ops vector.
-	*/
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
 	inode->i_op = &btrfs_special_inode_operations;
 	init_special_inode(inode, inode->i_mode, rdev);
-
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err)
-		goto out_unlock;
-
-	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     dentry->d_name.name, dentry->d_name.len, 0, index);
-	if (err)
-		goto out_unlock;
-
-	btrfs_update_inode(trans, root, BTRFS_I(inode));
-	d_instantiate_new(dentry, inode);
-
-out_unlock:
-	btrfs_end_transaction(trans);
-	btrfs_btree_balance_dirty(fs_info);
-	if (err && inode) {
-		inode_dec_link_count(inode);
-		discard_new_inode(inode);
-	}
-	return err;
+	return btrfs_create_common(dir, dentry, inode);
 }
 
 static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode = NULL;
-	int err;
-	u64 index = 0;
+	struct inode *inode;
 
-	/*
-	 * 2 for inode item and ref
-	 * 2 for dir items
-	 * 1 for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-			dentry->d_name.name, dentry->d_name.len,
-			mode, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		inode = NULL;
-		goto out_unlock;
-	}
-	/*
-	* If the active LSM wants to access the inode during
-	* d_instantiate it needs these. Smack checks to see
-	* if the filesystem supports xattrs by looking at the
-	* ops vector.
-	*/
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
-
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
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
-	btrfs_end_transaction(trans);
-	if (err && inode) {
-		inode_dec_link_count(inode);
-		discard_new_inode(inode);
-	}
-	btrfs_btree_balance_dirty(fs_info);
-	return err;
+	return btrfs_create_common(dir, dentry, inode);
 }
 
 static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
@@ -6561,59 +6611,15 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct inode *inode = NULL;
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	int err = 0;
-	u64 index = 0;
+	struct inode *inode;
 
-	/*
-	 * 2 items for inode and ref
-	 * 2 items for dir items
-	 * 1 for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-			dentry->d_name.name, dentry->d_name.len,
-			S_IFDIR | mode, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		inode = NULL;
-		goto out_fail;
-	}
-
-	/* these must be set before we unlock the inode */
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
-
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err)
-		goto out_fail;
-
-	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (err)
-		goto out_fail;
-
-	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			dentry->d_name.name,
-			dentry->d_name.len, 0, index);
-	if (err)
-		goto out_fail;
-
-	d_instantiate_new(dentry, inode);
-
-out_fail:
-	btrfs_end_transaction(trans);
-	if (err && inode) {
-		inode_dec_link_count(inode);
-		discard_new_inode(inode);
-	}
-	btrfs_btree_balance_dirty(fs_info);
-	return err;
+	return btrfs_create_common(dir, dentry, inode);
 }
 
 static noinline int uncompress_inline(struct btrfs_path *path,
@@ -8747,38 +8753,23 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	return ret;
 }
 
-/*
- * create a new subvolume directory/inode (helper for the ioctl).
- */
-int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root,
-			     struct user_namespace *mnt_userns)
+struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+				     struct inode *dir)
 {
 	struct inode *inode;
-	int err;
-	u64 index = 0;
 
-	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
-				S_IFDIR | (~current_umask() & S_IRWXUGO),
-				&index);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return NULL;
+	/*
+	 * Subvolumes don't inherit the sgid bit or the parent's gid if the
+	 * parent's sgid bit is set. This is probably a bug.
+	 */
+	inode_init_owner(mnt_userns, inode, NULL,
+			 S_IFDIR | (~current_umask() & S_IRWXUGO));
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
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
-
-	iput(inode);
-	return err;
+	return inode;
 }
 
 struct inode *btrfs_alloc_inode(struct super_block *sb)
@@ -9254,49 +9245,19 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	return ret;
 }
 
-static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
-				     struct btrfs_root *root,
-				     struct user_namespace *mnt_userns,
-				     struct inode *dir,
-				     struct dentry *dentry)
+static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
+					struct inode *dir)
 {
-	int ret;
 	struct inode *inode;
-	u64 index;
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-				dentry->d_name.name,
-				dentry->d_name.len,
-				S_IFCHR | WHITEOUT_MODE,
-				&index);
-
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		return ret;
+	inode = new_inode(dir->i_sb);
+	if (inode) {
+		inode_init_owner(mnt_userns, inode, dir,
+				 S_IFCHR | WHITEOUT_MODE);
+		inode->i_op = &btrfs_special_inode_operations;
+		init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
 	}
-
-	inode->i_op = &btrfs_special_inode_operations;
-	init_special_inode(inode, inode->i_mode,
-		WHITEOUT_DEV);
-
-	ret = btrfs_init_inode_security(trans, inode, dir,
-				&dentry->d_name);
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
+	return inode;
 }
 
 static int btrfs_rename(struct user_namespace *mnt_userns,
@@ -9305,6 +9266,10 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 			unsigned int flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
+	struct btrfs_new_inode_args whiteout_args = {
+		.dir = old_dir,
+		.dentry = old_dentry,
+	};
 	struct btrfs_trans_handle *trans;
 	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
@@ -9359,6 +9324,18 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (new_inode && S_ISREG(old_inode->i_mode) && new_inode->i_size)
 		filemap_flush(old_inode->i_mapping);
 
+	if (flags & RENAME_WHITEOUT) {
+		whiteout_args.inode = new_whiteout_inode(mnt_userns, old_dir);
+		if (!whiteout_args.inode)
+			return -ENOMEM;
+		ret = btrfs_new_inode_prepare(&whiteout_args, &trans_num_items);
+		if (ret)
+			goto out_whiteout_inode;
+	} else {
+		/* 1 to update the old parent inode. */
+		trans_num_items = 1;
+	}
+
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		/* close the racy window with snapshot create/destroy ioctl */
 		down_read(&fs_info->subvol_sem);
@@ -9368,24 +9345,25 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
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
@@ -9398,8 +9376,6 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 		 */
 		trans_num_items += 5;
 	}
-	if (flags & RENAME_WHITEOUT)
-		trans_num_items += 5;
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -9495,12 +9471,14 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 				   rename_ctx.index, new_dentry->d_parent);
 
 	if (flags & RENAME_WHITEOUT) {
-		ret = btrfs_whiteout_for_rename(trans, root, mnt_userns,
-						old_dir, old_dentry);
-
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
@@ -9509,7 +9487,11 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 out_notrans:
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
 		up_read(&fs_info->subvol_sem);
-
+	if (flags & RENAME_WHITEOUT)
+		btrfs_new_inode_args_free(&whiteout_args);
+out_whiteout_inode:
+	if (flags & RENAME_WHITEOUT)
+		iput(whiteout_args.inode);
 	return ret;
 }
 
@@ -9724,13 +9706,17 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 			 struct dentry *dentry, const char *symname)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct inode *inode;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+	};
+	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
-	struct inode *inode = NULL;
 	int err;
-	u64 index = 0;
 	int name_len;
 	int datasize;
 	unsigned long ptr;
@@ -9741,44 +9727,40 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
 		return -ENAMETOOLONG;
 
-	/*
-	 * 2 items for inode item and ref
-	 * 2 items for dir items
-	 * 1 item for updating parent inode item
-	 * 1 item for the inline extent item
-	 * 1 item for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 7);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, S_IFLNK | S_IRWXUGO);
+	inode->i_op = &btrfs_symlink_inode_operations;
+	inode_nohighmem(inode);
+	inode->i_mapping->a_ops = &btrfs_aops;
+	btrfs_i_size_write(BTRFS_I(inode), name_len);
+	inode_set_bytes(inode, name_len);
 
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
-				dentry->d_name.name, dentry->d_name.len,
-				S_IFLNK | S_IRWXUGO, &index);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		inode = NULL;
-		goto out_unlock;
+	new_inode_args.inode = inode;
+	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (err)
+		goto out_inode;
+	/* 1 additional item for the inline extent */
+	trans_num_items++;
+
+	trans = btrfs_start_transaction(root, trans_num_items);
+	if (IS_ERR(trans)) {
+		err = PTR_ERR(trans);
+		goto out_new_inode_args;
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
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
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
@@ -9787,8 +9769,11 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
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
@@ -9806,32 +9791,16 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	inode->i_op = &btrfs_symlink_inode_operations;
-	inode_nohighmem(inode);
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
+out_new_inode_args:
+	btrfs_new_inode_args_free(&new_inode_args);
+out_inode:
+	if (err)
+		iput(inode);
 	return err;
 }
 
@@ -10085,59 +10054,61 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode = NULL;
-	u64 index;
-	int ret = 0;
-
-	/*
-	 * 5 units required for adding orphan entry
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
-			mode, &index);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		inode = NULL;
-		goto out;
-	}
+	struct inode *inode;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+		.orphan = true,
+	};
+	unsigned int trans_num_items;
+	struct btrfs_trans_handle *trans;
+	int ret;
 
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 
 	inode->i_mapping->a_ops = &btrfs_aops;
 
-	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
+	new_inode_args.inode = inode;
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
 	if (ret)
-		goto out;
+		goto out_inode;
 
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (ret)
-		goto out;
-	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
-	if (ret)
-		goto out;
+	trans = btrfs_start_transaction(root, trans_num_items);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto out_new_inode_args;
+	}
+
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
 
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
+out_new_inode_args:
+	btrfs_new_inode_args_free(&new_inode_args);
+out_inode:
+	if (ret)
+		iput(inode);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3cea5530ad83..4d217cff7da5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -544,13 +544,38 @@ int __pure btrfs_is_empty_uuid(u8 *uuid)
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
 {
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_root_item *root_item;
@@ -560,11 +585,14 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	struct btrfs_root *new_root;
 	struct btrfs_block_rsv block_rsv;
 	struct timespec64 cur_time = current_time(dir);
-	struct inode *inode;
+	struct btrfs_new_inode_args new_inode_args = {
+		.dir = dir,
+		.dentry = dentry,
+		.subvol = true,
+	};
 	int ret;
-	dev_t anon_dev = 0;
+	dev_t anon_dev;
 	u64 objectid;
-	u64 index = 0;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -572,11 +600,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 
 	ret = btrfs_get_free_objectid(fs_info->tree_root, &objectid);
 	if (ret)
-		goto fail_free;
-
-	ret = get_anon_bdev(&anon_dev);
-	if (ret < 0)
-		goto fail_free;
+		goto out_root_item;
 
 	/*
 	 * Don't create subvolume whose level is not zero. Or qgroup will be
@@ -584,36 +608,47 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	 */
 	if (btrfs_qgroup_level(objectid)) {
 		ret = -ENOSPC;
-		goto fail_free;
+		goto out_root_item;
 	}
 
-	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
-	/*
-	 * The same as the snapshot creation, please see the comment
-	 * of create_snapshot().
-	 */
-	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 8, false);
+	ret = get_anon_bdev(&anon_dev);
+	if (ret < 0)
+		goto out_root_item;
+
+	new_inode_args.inode = btrfs_new_subvol_inode(mnt_userns, dir);
+	if (!new_inode_args.inode) {
+		ret = -ENOMEM;
+		goto out_anon_dev;
+	}
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
 	if (ret)
-		goto fail_free;
+		goto out_inode;
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
-		goto fail_free;
+		goto out_new_inode_args;
 	}
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
 	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
 	if (ret)
-		goto fail;
+		goto out;
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
 				      BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
-		goto fail;
+		goto out;
 	}
 
 	btrfs_mark_buffer_dirty(leaf);
@@ -668,75 +703,47 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		btrfs_tree_unlock(leaf);
 		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
 		free_extent_buffer(leaf);
-		goto fail;
+		goto out;
 	}
 
 	free_extent_buffer(leaf);
 	leaf = NULL;
 
-	key.offset = (u64)-1;
 	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
 	if (IS_ERR(new_root)) {
-		free_anon_bdev(anon_dev);
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
-	/* Freeing will be done in btrfs_put_root() of new_root */
+	/* anon_dev is owned by new_root now. */
 	anon_dev = 0;
+	BTRFS_I(new_inode_args.inode)->root = new_root;
+	/* ... and new_root is owned by new_inode.inode now. */
 
 	ret = btrfs_record_root_in_trans(trans, new_root);
 	if (ret) {
 		btrfs_put_root(new_root);
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
-	ret = btrfs_create_subvol_root(trans, new_root, root, mnt_userns);
-	btrfs_put_root(new_root);
-	if (ret) {
-		/* We potentially lose an unused inode item here */
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
-	/*
-	 * insert the directory item
-	 */
-	ret = btrfs_set_inode_index(BTRFS_I(dir), &index);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
-	ret = btrfs_insert_dir_item(trans, name, namelen, BTRFS_I(dir), &key,
-				    BTRFS_FT_DIR, index);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
-	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
-	ret = btrfs_add_root_ref(trans, objectid, root->root_key.objectid,
-				 btrfs_ino(BTRFS_I(dir)), index, name, namelen);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	ret = btrfs_uuid_tree_add(trans, root_item->uuid,
 				  BTRFS_UUID_KEY_SUBVOL, objectid);
-	if (ret)
+	if (ret) {
 		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
 
-fail:
-	kfree(root_item);
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+
+	d_instantiate_new(dentry, new_inode_args.inode);
+	new_inode_args.inode = NULL;
+
+out:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
 	btrfs_subvolume_release_metadata(root, &block_rsv);
@@ -745,18 +752,14 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		btrfs_end_transaction(trans);
 	else
 		ret = btrfs_commit_transaction(trans);
-
-	if (!ret) {
-		inode = btrfs_lookup_dentry(dir, dentry);
-		if (IS_ERR(inode))
-			return PTR_ERR(inode);
-		d_instantiate(dentry, inode);
-	}
-	return ret;
-
-fail_free:
+out_new_inode_args:
+	btrfs_new_inode_args_free(&new_inode_args);
+out_inode:
+	iput(new_inode_args.inode);
+out_anon_dev:
 	if (anon_dev)
 		free_anon_bdev(anon_dev);
+out_root_item:
 	kfree(root_item);
 	return ret;
 }
@@ -769,6 +772,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct inode *inode;
 	struct btrfs_pending_snapshot *pending_snapshot;
 	struct btrfs_trans_handle *trans;
+	int trans_num_items;
 	int ret;
 
 	/* We do not support snapshotting right now. */
@@ -805,16 +809,14 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
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

