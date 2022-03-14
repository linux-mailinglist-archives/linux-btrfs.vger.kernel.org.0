Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA104D8DC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiCNUGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbiCNUGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 16:06:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A773FDB4
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:05:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q11so14458262pln.11
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkzOfmpoJl+CP/oBPGBOAgEQgBJ+AIOUAh/a4xrxXg8=;
        b=uy8bfmcRvE4SRCfJ6hEfVB0Kc+2utQ/G1+2h42p/q05emFk2Gz3tDOBje3wTRwGnU3
         9ZdrW8Q83EOt0Anwq29GuCaBccRXykXNUXBwoB1Od6GJIJijGdoTZazT9cD2gHZ1oI4K
         tLypHzKfPGiL151PlGPWk30hIL/z7VBR7IxMvUsFUg4EGFHD6tF4rFz/yZIHQ/PkFytd
         74QGlI4Q5oMQqpmQh1LbgM2zaMbEKOWtryBgyocHBKfa53GOHeIrwCrMbliCjOvGfVP3
         Xoc/sVt0OUFXM0fgXu/AbbcntmE+u5UzOQeyZVEw7uK51E2hbl26YJvhwjtpmI5mKRWe
         gnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkzOfmpoJl+CP/oBPGBOAgEQgBJ+AIOUAh/a4xrxXg8=;
        b=DM6U1dphXINebel2PizaWNtg+rxkxqcCIGtMKrX7ksqDMOt/T/snyGA7YC1XkEFo0m
         cuK0MJI+WnEjpIJqcNUsmDoCfqNzjqqthR0mQAHBTrvnLCx+i6ZDVSWZBI4KI695+bu4
         IeojL1TL4bYqUVdBRojDlimTYAlJJ69carE6Ec8HdEiUMLxZ3QtgIwivpdKm1kYwMY2u
         0iD1wynI+6IAZfXOBRVzsJOLiDXxjfl4vitIQ00Hd6YFe7FSV3oz/Fzj8KKsGXKnftx9
         HgUud+NEhtTEYZQ1GsnrsCt7Oj85PsLxSb8SMWnQj4AgBNVUQp4KqyarQqQZuckjEViZ
         h/jQ==
X-Gm-Message-State: AOAM5333X6I75IXHFV6cH5biWR3CI+t8h6XontS7CdvCBcp+2DGmiISA
        Xvezdp02smxaRU5rHV8nx6ck+cfzIVTm1g==
X-Google-Smtp-Source: ABdhPJzXAW0z6UPn6s56/fdyOow7tPecyredUbDlQlkNwOGFvwbZe2w5WWVxtY7hhC9f9kC76/j/Pg==
X-Received: by 2002:a17:90b:17c5:b0:1c6:3639:7daf with SMTP id me5-20020a17090b17c500b001c636397dafmr43997pjb.105.1647288327198;
        Mon, 14 Mar 2022 13:05:27 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id mi13-20020a17090b4b4d00b001c6320d40c6sm187321pjb.45.2022.03.14.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:05:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v3 2/4] btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
Date:   Mon, 14 Mar 2022 13:05:17 -0700
Message-Id: <cc956ec7f6e643c717956d0ae60257645d95783f.1647288019.git.osandov@fb.com>
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

btrfs_{mknod,create,mkdir}() are now identical other than the inode
initialization and some inconsequential function call order differences.
Factor out the common code to reduce code duplication.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 152 ++++++++++-------------------------------------
 1 file changed, 33 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ff780256c936..bea2cb2d90a5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6346,82 +6346,15 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, dev_t rdev)
+static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
+			       struct inode *inode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode;
+	struct btrfs_trans_handle *trans;
 	int err;
 	u64 index = 0;
 
-	inode = new_inode(dir->i_sb);
-	if (!inode)
-		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, mode);
-	inode->i_op = &btrfs_special_inode_operations;
-	init_special_inode(inode, inode->i_mode, rdev);
-
-	/*
-	 * 2 for inode item and ref
-	 * 2 for dir items
-	 * 1 for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans)) {
-		iput(inode);
-		return PTR_ERR(trans);
-	}
-
-	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
-			      dentry->d_name.len, &index);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out_unlock;
-	}
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
-}
-
-static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct inode *inode;
-	int err;
-	u64 index = 0;
-
-	inode = new_inode(dir->i_sb);
-	if (!inode)
-		return -ENOMEM;
-	inode_init_owner(mnt_userns, inode, dir, mode);
-	inode->i_fop = &btrfs_file_operations;
-	inode->i_op = &btrfs_file_inode_operations;
-	inode->i_mapping->a_ops = &btrfs_aops;
-
 	/*
 	 * 2 for inode item and ref
 	 * 2 for dir items
@@ -6466,6 +6399,35 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
+static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t rdev)
+{
+	struct inode *inode;
+
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode->i_op = &btrfs_special_inode_operations;
+	init_special_inode(inode, inode->i_mode, rdev);
+	return btrfs_create_common(dir, dentry, inode);
+}
+
+static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
+{
+	struct inode *inode;
+
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return -ENOMEM;
+	inode_init_owner(mnt_userns, inode, dir, mode);
+	inode->i_fop = &btrfs_file_operations;
+	inode->i_op = &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops = &btrfs_aops;
+	return btrfs_create_common(dir, dentry, inode);
+}
+
 static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 		      struct dentry *dentry)
 {
@@ -6547,12 +6509,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct inode *inode;
-	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	int err;
-	u64 index = 0;
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
@@ -6560,50 +6517,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
-
-	/*
-	 * 2 items for inode and ref
-	 * 2 items for dir items
-	 * 1 for xattr if selinux is on
-	 */
-	trans = btrfs_start_transaction(root, 5);
-	if (IS_ERR(trans)) {
-		iput(inode);
-		return PTR_ERR(trans);
-	}
-
-	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
-			      dentry->d_name.len, &index);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out_fail;
-	}
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
-- 
2.35.1

