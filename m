Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408F4CC9F8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiCCXUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiCCXUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367F14FFDD
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb21so5916597pjb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13QpFG7i2coJtFsQrtcKk29inMBAj/dznjcFwI7nKZY=;
        b=yHXKRda8cisw7I/nnzcpXmlqNCOlxEMuTcbwl7It7bXupo7qdsgsJXXMUjrFhJmfx3
         swRsRfjiL+X9r4cQH+uOYDMi0GK78tS/DNlIzgE9JU3cIMSjavIIecE0akpXmX3wENpp
         kstjZ2FJ9o4uuJUFNeZpS5wIAZrTvusrL3aS9Qgu4hRr6IuPHxR9QH1+3VSxu5Im1USB
         fjXd5+fb8gvYeidWAhoEz7wu5SqOGscyKSFFf0If0wubANXcGCyCgj1S4e/36qaD3Ba5
         0JNoB5XmbxZHetYV31Rjqxsdtwhf+f7Aa0cypW7/gLi9+Q6hdxnn0itkQvg2yh5gGBud
         NY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13QpFG7i2coJtFsQrtcKk29inMBAj/dznjcFwI7nKZY=;
        b=2whaTIBVfmQzBJM3ReT5/x6DFe2WzMrAl1JVbzyy2OcKWJpyIh/azXztyITHjSaF7e
         ZvABnxJoCybMW+OL4GViQ0f+5xVdSDm5VRRguIUThsuesvMqCpuk7MQQJIJFLBX9lSBq
         +/WIHR73AcyWQGSyRRfJY8kYsQfsMZQOOYbRl52pzm5Z9b8ovWSfGELO+bX2x3Pzs6KZ
         k2ACRjYEmNR/a2+eYj0ZKJkpFytGdiA38pUjK9ibOZQuq+RpIu0bPZXj2WZXf/+bUyEg
         R1nlcYZq8q1UESzVyYUoGC//9eusHYfH6QwxVx8IwA8P/LYye2NJszJqvhqO89ukOrHp
         rAWw==
X-Gm-Message-State: AOAM533BY9crMg+sgjQCn0FXlg5wglMeJoOS8JrpMPEAt40rHiRXB88j
        IGVNKmaN0NxrMKTNBubOWRV38YZRvS0clw==
X-Google-Smtp-Source: ABdhPJxvpxbMMRD9GajNQhVvJ9UH+PStpvxTPEt9DJFLSdZBLPcNoJya50TGe0uOFEtkJ/4ijZLdQQ==
X-Received: by 2002:a17:902:860a:b0:14b:341e:5ffb with SMTP id f10-20020a170902860a00b0014b341e5ffbmr38131239plo.6.1646349569515;
        Thu, 03 Mar 2022 15:19:29 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:29 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 09/12] btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
Date:   Thu,  3 Mar 2022 15:18:59 -0800
Message-Id: <c712bef899b8bbd162a5c856093f2845b42a147c.1646348486.git.osandov@fb.com>
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

For everything other than a subvolume root inode, we get the parent
objectid from the parent directory. For the subvolume root inode, the
parent objectid is the same as the inode's objectid. We can find this
within btrfs_new_inode() instead of passing it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a9dabe9e5500..9c845c67421a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6095,8 +6095,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 				     struct user_namespace *mnt_userns,
 				     struct inode *dir,
 				     const char *name, int name_len,
-				     u64 ref_objectid, u64 objectid,
-				     umode_t mode, u64 *index)
+				     u64 objectid, umode_t mode, u64 *index)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode *inode;
@@ -6182,7 +6181,10 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 		 */
 		key[1].objectid = objectid;
 		key[1].type = BTRFS_INODE_REF_KEY;
-		key[1].offset = ref_objectid;
+		if (dir)
+			key[1].offset = btrfs_ino(BTRFS_I(dir));
+		else
+			key[1].offset = objectid;
 
 		sizes[1] = name_len + sizeof(*ref);
 	}
@@ -6380,7 +6382,7 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
-			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
+			objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6444,7 +6446,7 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
-			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
+			objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6589,7 +6591,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
-			btrfs_ino(BTRFS_I(dir)), objectid,
+			objectid,
 			S_IFDIR | mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -8776,7 +8778,7 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 		return err;
 
 	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
-				ino, ino,
+				ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
 	if (IS_ERR(inode))
@@ -9289,7 +9291,6 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name,
 				dentry->d_name.len,
-				btrfs_ino(BTRFS_I(dir)),
 				objectid,
 				S_IFCHR | WHITEOUT_MODE,
 				&index);
@@ -9783,7 +9784,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name, dentry->d_name.len,
-				btrfs_ino(BTRFS_I(dir)), objectid,
+				objectid,
 				S_IFLNK | S_IRWXUGO, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -10134,7 +10135,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out;
 
 	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
-			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
+			objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		inode = NULL;
-- 
2.35.1

