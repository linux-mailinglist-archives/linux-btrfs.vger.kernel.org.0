Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D24D3EC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiCJBdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbiCJBdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C377EF7B7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cx5so3904081pjb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OB5DZbURwz6ypU/sksudgg6eWva0UysnW2Ct2q+6eCU=;
        b=hfYZhibMMLpkU4rxk9gIVnxS0rQ7P+0A1Q6pe9LAdJ1MIDa3Ebbg3Hzwfs1ED5gFKY
         baFkDk800LYTeRPuBXntZBtYAb4l2uvbAVf1VfJ6lvs6O7HGASSM7PSp8KBAAmmCCe4Y
         YREetFB/V4ef2Ybjzrox+ysPvwJsWFRzz7yW+a6Bgprn3oE8lhwD3Y7y60ppH+GZdGVx
         W8FuQ4ysrb6HNNaaC1pXd+W9IAm1UhCZQwaNjyz+dF6NVRJQG2wNJQ1LMet7oHQbNYrN
         v0GYUXxUGA1Ri9potbhmj16IGaN8QX+uybSApHo8sqduJPfqtukc51sJjx+DH/QpVoGa
         xQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OB5DZbURwz6ypU/sksudgg6eWva0UysnW2Ct2q+6eCU=;
        b=xSGcQK9VSDr2RaepUD36M8bnGyCq+H/mxsrEqizJ4XWGLsFKFcIJBg48A87QcXCUw8
         7QvuDivePuGrublxiPEVoLJ3WO1mQiluO5bBbOI6Dw4nhLx6mrkbHNgvoxr2hu1Qhr7F
         qEfYVmC6c/w6DvVtGToIaNjfUs/Pl2t6YGIY46ychr6Fr9w7EzROacAOiXVAifRFf++9
         6hRwrIoW3//8ergaAA8szc9bJANwgUym53/w2xamYsbEjBUkQU+IpTblMbmnyDfvzPDu
         yR5iNHcj+77sJW5NHrKpB+sqtB1/25gyqXXGkiW/dATZitKD8Prhfh+3Zosx1Iu2GoI3
         VlFQ==
X-Gm-Message-State: AOAM533M7F/zRTLIOdA8CLSVW4XDB5BVIIJZjlbKzliHR5RKRAR2VJOY
        TZ9FYS/hiOA0m/kMXGNjSKpR5iKVHkeTfg==
X-Google-Smtp-Source: ABdhPJybb+xvTrZJecjHoG/e3+FZXnp+8AVR8AVZ1Ccjm/y3I8edG0ULpoVD63+u9fKooXLkzXQ7pw==
X-Received: by 2002:a17:90a:160f:b0:1b8:ab45:d287 with SMTP id n15-20020a17090a160f00b001b8ab45d287mr2365255pja.91.1646875926259;
        Wed, 09 Mar 2022 17:32:06 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:05 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 11/16] btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
Date:   Wed,  9 Mar 2022 17:31:41 -0800
Message-Id: <7a6aecc1bbe98f2fb0bcdfe3fe655d98e3aa042b.1646875648.git.osandov@fb.com>
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

Every call of btrfs_new_inode() is immediately preceded by a call to
btrfs_get_free_objectid(). Since getting an inode number is part of
creating a new inode, this is better off being moved into
btrfs_new_inode(). While we're here, get rid of the comment about
reclaiming inode numbers, since we only did that when using the ino
cache, which was removed by commit 5297199a8bca ("btrfs: remove inode
number cache feature").

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

