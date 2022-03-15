Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD34D9217
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiCOBN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbiCOBN4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 21:13:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785EFC5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:12:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g19so16998038pfc.9
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVSS8c5l1w6ZmOD4tzEgxN4KrPFORuhMdaGs8vT2z84=;
        b=dRqtuTh3uWKXerXxbK+89DnVZWE+efzhcbyr7QI6KbM/K49soYpJuESSvMPwBY7he1
         b6fulo7gwrlmDvLcTvoS57KRFtCGmTllZsxlxAfIREk4eMtSe9UeMuqKLdTn2FASYxfW
         Cn2DIcsVW/UOSqag2JPTHSDudDIlcQREaJMb9/bA+i0KrUCyBFaKgChrXZUJMaX6L8bD
         jgmd1QackKeix7jGmhzmJQwHJ7JAPwhDEPsnE/OVsMGXIBZ1PyE/trI+ynLoRe5fvD0e
         WMnr4dnBS8qRmNsuHzC20HHyWzSW98hKZDaKH1X3jw8QB6mvUESE8/y3Hcjg2cZAjg8n
         69QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVSS8c5l1w6ZmOD4tzEgxN4KrPFORuhMdaGs8vT2z84=;
        b=Ewq7PYb6t0jXhEI1itF1aJN0nXnAng5KAuMXt0BktIAl8fhrDtan5ceKG/gLGBJ8pH
         8B998ZG6BzOCneafq76q7z3ShS4eW7GEtEC+Nw2ayx5Hqz+7+8hat2kcjVRht9HzXaSX
         TVJvDdgAVzDCiFBAfIcSnukaT+sffhf+BIgq3PMk7JBtGnWZf9LOY0X7wGa/o4vfzCTB
         rhJe3QTPio868ovtP/KI2EsniwFdfA0N5a/qvjbo8eNdXXr+YlYRCt91SEK+8iHzh+La
         xqMAjoXGevNBfjRQ5i1mdrkopBz9UhKKAMzgYiilwLrC0jgDssOYkehyL+RYjAfKR6D2
         GEMw==
X-Gm-Message-State: AOAM532EZbcANUN/jE9OViM0JmK7x2i/R/tk5XUavItxr1Kc78AtI7zU
        jMWKx7IaHG4cYObveNgm3qk6ahbQAN0NmQ==
X-Google-Smtp-Source: ABdhPJzJcNB1Bbvrd+/guk5RVRx8BgzsrIifeSXFkiKfMb8aVCWhZlV8GtevJiV3tPmdp4s1VleA7g==
X-Received: by 2002:a63:af4b:0:b0:373:a2a1:bf9a with SMTP id s11-20020a63af4b000000b00373a2a1bf9amr22257178pgo.369.1647306765380;
        Mon, 14 Mar 2022 18:12:45 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm724609pjb.52.2022.03.14.18.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:12:44 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v4 2/4] btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
Date:   Mon, 14 Mar 2022 18:12:33 -0700
Message-Id: <2a3c1adc75ff5f72d4f503ab21bba5f660f74dd8.1647306546.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647306546.git.osandov@fb.com>
References: <cover.1647306546.git.osandov@fb.com>
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
index d616a3a35e83..4ed6157335c4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6347,82 +6347,15 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
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
@@ -6467,6 +6400,35 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
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
@@ -6548,12 +6510,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
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
@@ -6561,50 +6518,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
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

