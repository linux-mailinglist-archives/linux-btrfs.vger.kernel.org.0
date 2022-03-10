Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7B4D3EC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiCJBdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiCJBdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:05 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD94EF7B7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w4so3486212ply.13
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ESGp4URGhTLPRuTCKIKbSBZCIAh9+fgCJDf6PxoO4I=;
        b=6wNvqMBcsWAY6xyKOUyA1QBgsMa3J+IsDm3NTGxAPOjxs4qPrpjK/8Jt0rmV/ZN4Gf
         TKT5xEvGagWHWAbe3uK+1a90u11VBQ6o0wNYM8bUEbBfxu5K5gQPAq5UcS+YTZML1LZw
         925kDLKyg2vDud+48vTZ3Q1jbKykgI2XiBvV323kwil+Piysbt3KW/rM5JBdxnv0cb4m
         WYelz6J0u1Iph819AtpOuOpyBMDpDl+WebVhqnlgpUVl35ec3edFTu9JI5sz6mQqgTYX
         qBKm3HZhK0/2ohrc5wCAy3kEgpz27ma+aeXsOQKxcqWq3Dy4EKgSblWE3A5/MOButp/R
         uLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ESGp4URGhTLPRuTCKIKbSBZCIAh9+fgCJDf6PxoO4I=;
        b=WWcTVaskfBXA+FsmFhC/M7HmrKUn0AY1BSAP7ISkgTTGYEIbnOVDE7fzKO0gUW6EdG
         dzzQHmCvvYcBxjdgsoHivSVpFbgcd8zTfI6BcfEChiVxTgvwESg4xlbRiTJ4J7CcH3/6
         ZzDapDRJ7DkGknLxOgsHZo/Tftpn3ntYugY0ihxA7YDckVCWFzwpq338krnxz0nLMl/z
         BulPRCWhJ4jkAshtuwd/LV7k0KubDjD3s6eMYJCnNSBUvkRT382EboaRIaaz9GoUb/PW
         oMDDQr197S20Acvo0U+rKV84rQAxn5lvHQa1s74mW7pE/5g4Tr5UTlRO/4uNnVUMmwHy
         BkPw==
X-Gm-Message-State: AOAM530+1u0/OVioACo/w25GaEgzkTJvKaXMz7YkV3CMRQYkaYDp2FUj
        ek0Fydro8hcmOS3RZdhF1PQtP42Kb35FGA==
X-Google-Smtp-Source: ABdhPJyr9XbVeoJcwE/TkwVxPKyK6Xf1+Uqm0KoPe1Gc/OM0466kVRC93Fz/iyqzI0WJyFhewXGkcw==
X-Received: by 2002:a17:90a:4289:b0:1bc:275b:8986 with SMTP id p9-20020a17090a428900b001bc275b8986mr13233416pjg.153.1646875925084;
        Wed, 09 Mar 2022 17:32:05 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:04 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 10/16] btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
Date:   Wed,  9 Mar 2022 17:31:40 -0800
Message-Id: <75839bab668df56ad486a103403d47becc39dc1d.1646875648.git.osandov@fb.com>
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

For everything other than a subvolume root inode, we get the parent
objectid from the parent directory. For the subvolume root inode, the
parent objectid is the same as the inode's objectid. We can find this
within btrfs_new_inode() instead of passing it.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

