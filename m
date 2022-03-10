Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19474D3ECB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiCJBdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiCJBdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:10 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C12127575
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 6so3473925pgg.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9JsZBsOgr9txHF6TgJVbRAb34Tjzpm5bdm/B44AYWg=;
        b=BoCJQuaJBZCHdHidgjan3W+dNaaOOrTlV7Du0e1B3QH3bpjHt90eow6xh58awjucIU
         d6oqQtsyWkuPJrfQFoZHYk3Y4kZFI+T3+RWqq09wcHvUgES4mzEv2UO+HrDu46yLtFcE
         JRsQxxL2BK/GGMV7tkenoI6VE1v5gIfo+q/EKbwotToLWeAy0xteiawsmBjnSOVlkild
         oo2xTH8EuDRZq8v3Vh7gB6TH461ShMjZQcsWLNeEzDyjsAwOJqtSjBuo3ewSR03SWvH7
         ngfP8ECWTDegorO9CP1b4tB57SOGaRq/z398JQnLtYa9i67HmbAgoWZjE1PBTEd4r5sZ
         8+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9JsZBsOgr9txHF6TgJVbRAb34Tjzpm5bdm/B44AYWg=;
        b=VIvQhTjPckTbXh+sZ6bcq2zxV25hOJ5RCYH1gtnsgr3GHs7VOs5o6R5C6NAHHnB4SI
         AKZKsLQlfY2v06MP727JaW0X8rtw5Gm9ISY1SZn5clS7dUz+4ChY/QIj4OM2o/qfYWGI
         UXvH9NjJENnqVFnXVGRLc+5z+NCjTKB4HNFX4wzZtcmbGD1Cwyn/TRFXrCX/Uk8ltppk
         dM9HILPIr/ZdOjLqD0/cHRc8YhA/3xmyGsJuqL9WjzHTXWMw4rGesUaSM0652mlMIYdP
         /x4Htsu/SY9OU+vPD+1m+cgxTgHkRP0y0iHrU0+u4BAdPKuNpWTRPiDTujCV3nMifhi2
         JJzw==
X-Gm-Message-State: AOAM533w/eXkgXf6oue989VwdZGQZmeJA44OzdTkquIrv15LVFuZASV5
        xUX7Qc5iQT1s2g8RAwtpOM2eA8qw6x8d/w==
X-Google-Smtp-Source: ABdhPJxStntAZJsNGsA1i8jDzMhDXsrSw2DC93T88u1QfUIRXPIV/hMMS93jTO5VGo0Huln/SL6n1A==
X-Received: by 2002:a63:1554:0:b0:363:794c:9e31 with SMTP id 20-20020a631554000000b00363794c9e31mr2057202pgv.66.1646875929580;
        Wed, 09 Mar 2022 17:32:09 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:09 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 14/16] btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
Date:   Wed,  9 Mar 2022 17:31:44 -0800
Message-Id: <2258575acbbf50aae5436b01e8d4400ecb905570.1646875648.git.osandov@fb.com>
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

btrfs_{mknod,create,mkdir}() are now identical other than the inode
initialization and some inconsequential function call order differences.
Factor out the common code to reduce code duplication.

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

