Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09E4CC9F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiCCXUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiCCXUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB113A1AA
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:31 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id bd1so6128720plb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaXjNK4dXMkufXXJQqVaoztHpfljK682q4NK7Xbpr/o=;
        b=ns+IuSFah05ZCfPw4THwPgRCDqOWrPyN/hQR3ZcY8faNEG2cdjTHplghc3TyJFEy3Q
         zJ6bE3YkPAUzU+ByRUuMRXX08TZqnmbAdIEFjmRrf6YKWlTYsEOTACPrPBqJIF3sHIX9
         ZPwvYZBgu5kA+xRGs/K3wRyFOL0/imnpYbkv17zAEtbuKn5aOeQgnWHVOzPL7lNMjGqp
         omE5ZjnHXamVvCkDawz+/INsuDIWhKjiiPE57eMFijwhYATk6Th8kKOdYEK2P8CjW94G
         b1fe1gvUZSDMsX6TioYE3TVZJ6U/c4ruMu18so25+MaUZMhP4sIfzJT0eoiiuvhd6+Ct
         vtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KaXjNK4dXMkufXXJQqVaoztHpfljK682q4NK7Xbpr/o=;
        b=r2dB0wZ8YrQvM9jhnA9MvoXuw14SVbo6/WPIJRkW/RMYn5Jthi4RYrUzFap2jRCJM0
         WF+4Ohj9PEp8iHd9XG5P5mI29V4Cm+STSm4GCT6K+gfWCZ69m2q+HLs2rrlYqNzX9gVO
         ta3wo/T+Bk4zX+fZSfQwoGN+UpoM+ed9cZ8U149Pe/PNfflxNlc1p2tJBabUz5h0oSzZ
         ljrxLuA4eYN0dWSllLnhctAIt0CNMhZ8C6fg3d77mhK1OQ3TA8PCTG/56hgJZTdbAk29
         30oTd/DAgMIgN91cH20KrHrIAdssnDwEzIm/Ez1dNrRChogOw5wJoPuF3eyxLfYTCjWv
         3/Dg==
X-Gm-Message-State: AOAM531CkgHG/FiFLd+/8pJKqIYGmOlPC6I9/kV5IMHqfTvwgMpsCcas
        MzDjiNu9z14ffSmd3+MNUJn4GsEbtOu/Mg==
X-Google-Smtp-Source: ABdhPJziUi91l7a/FaIqtc6MIrIJ12gjzgzNQP/ye4ckToyWRFIxCDSkHnJb+ScwbGPnZKCxfp95Xg==
X-Received: by 2002:a17:90b:3503:b0:1bc:5d68:e7a2 with SMTP id ls3-20020a17090b350300b001bc5d68e7a2mr7824264pjb.29.1646349570317;
        Thu, 03 Mar 2022 15:19:30 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:30 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 10/12] btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
Date:   Thu,  3 Mar 2022 15:19:00 -0800
Message-Id: <445cc006b66e4c8be60c389284e2861c1b22c84a.1646348486.git.osandov@fb.com>
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

Every call of btrfs_new_inode() is immediately preceded by a call to
btrfs_get_free_objectid(). Since getting an inode number is part of
creating a new inode, this is better off being moved into
btrfs_new_inode(). While we're here, get rid of the comment about
reclaiming inode numbers, since we only did that when using the ino
cache, which was removed by commit 5297199a8bca ("btrfs: remove inode
number cache feature").

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 58 +++++++++---------------------------------------
 1 file changed, 11 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9c845c67421a..289bb5176e09 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6095,13 +6095,14 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 				     struct user_namespace *mnt_userns,
 				     struct inode *dir,
 				     const char *name, int name_len,
-				     u64 objectid, umode_t mode, u64 *index)
+				     umode_t mode, u64 *index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode *inode;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_key *location;
 	struct btrfs_path *path;
+	u64 objectid;
 	struct btrfs_inode_ref *ref;
 	struct btrfs_key key[2];
 	u32 sizes[2];
@@ -6129,10 +6130,12 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	if (!name)
 		set_nlink(inode, 0);
 
-	/*
-	 * we have to initialize this early, so we can reclaim the inode
-	 * number if we fail afterwards in this function.
-	 */
+	ret = btrfs_get_free_objectid(root, &objectid);
+	if (ret) {
+		btrfs_free_path(path);
+		iput(inode);
+		return ERR_PTR(ret);
+	}
 	inode->i_ino = objectid;
 
 	if (dir && name) {
@@ -6364,7 +6367,6 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
 	int err;
-	u64 objectid;
 	u64 index = 0;
 
 	/*
@@ -6376,13 +6378,9 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_get_free_objectid(root, &objectid);
-	if (err)
-		goto out_unlock;
-
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
-			objectid, mode, &index);
+			mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6428,7 +6426,6 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
 	int err;
-	u64 objectid;
 	u64 index = 0;
 
 	/*
@@ -6440,13 +6437,9 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_get_free_objectid(root, &objectid);
-	if (err)
-		goto out_unlock;
-
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
-			objectid, mode, &index);
+			mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6573,7 +6566,6 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	int err = 0;
-	u64 objectid = 0;
 	u64 index = 0;
 
 	/*
@@ -6585,13 +6577,8 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_get_free_objectid(root, &objectid);
-	if (err)
-		goto out_fail;
-
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
-			objectid,
 			S_IFDIR | mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -8771,14 +8758,8 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	struct inode *inode;
 	int err;
 	u64 index = 0;
-	u64 ino;
-
-	err = btrfs_get_free_objectid(new_root, &ino);
-	if (err < 0)
-		return err;
 
 	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
-				ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
 	if (IS_ERR(inode))
@@ -9281,17 +9262,11 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct inode *inode;
-	u64 objectid;
 	u64 index;
 
-	ret = btrfs_get_free_objectid(root, &objectid);
-	if (ret)
-		return ret;
-
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name,
 				dentry->d_name.len,
-				objectid,
 				S_IFCHR | WHITEOUT_MODE,
 				&index);
 
@@ -9755,7 +9730,6 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_key key;
 	struct inode *inode = NULL;
 	int err;
-	u64 objectid;
 	u64 index = 0;
 	int name_len;
 	int datasize;
@@ -9778,13 +9752,8 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_get_free_objectid(root, &objectid);
-	if (err)
-		goto out_unlock;
-
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name, dentry->d_name.len,
-				objectid,
 				S_IFLNK | S_IRWXUGO, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -10119,7 +10088,6 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
-	u64 objectid;
 	u64 index;
 	int ret = 0;
 
@@ -10130,12 +10098,8 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_get_free_objectid(root, &objectid);
-	if (ret)
-		goto out;
-
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
-			objectid, mode, &index);
+			mode, &index);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		inode = NULL;
-- 
2.35.1

