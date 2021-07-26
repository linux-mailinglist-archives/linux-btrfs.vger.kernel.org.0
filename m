Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A53D577C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhGZJs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232373AbhGZJs0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E1360F57;
        Mon, 26 Jul 2021 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295335;
        bh=cQ5K86trKiIycXN6esOezpVjNe0HcWEebhQT8/Nd24I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFU5z8U0W4BKr/h5Ltx+AtGl1t+In9PLpixhGJ9rEI3x0stRj88SFofo4vsyqsIxJ
         Jy7JIV3YFc/IaROby+8TKVPa5vgU+zQZGf9krIU1qh2ios+JOGo03Lmrlfzfd17Nfz
         /KFe29rjjwixmrxpfdUtfdq92FUkPAbNlDES4XZWADpcJE+bVOGkbfNyjjI2oHgDyX
         J9jhHFjRZMWryXzcZmJUHlvHthqUpYu7AnGd/t2+Ji48D05FNpXLvFwJIqEgORLPuJ
         kStQGZVP/2mJcPppMeNNLfiXMsPGYnl0wLnb20WbssZiu4+cAwR6JazqUVjkV8retU
         L8hIIFWlYsnWQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 02/21] btrfs/inode: handle idmaps in btrfs_new_inode()
Date:   Mon, 26 Jul 2021 12:27:57 +0200
Message-Id: <20210726102816.612434-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4707; h=from:subject; bh=rq58S+phGawkvkIF+U33h3z9o90mx2uQ5xoIw5t9uRA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zO8pu9SoHPiQ0Rd3v8lZdI/J/5d1d67ocVm4qaJsZeN shgndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEeQojw5zp/0rd5h6x2FnvN7P9sP MG+Wuc/l9f679XY7T/6fkwcT7Df5+mde/NObPz8ib3ab5f8FwxMEL2A/MTgzfvowV+BLMdYwYA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Extend btrfs_new_inode() to take the idmapped mount into account when
initializing a new inode. This is just a matter of passing down the mount's
userns. The rest is taken care of in inode_init_owner(). This is a preliminary
patch to make the individual btrfs inode operations idmapped mount aware.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0117d867ecf8..ae4fe9377e6f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6370,6 +6370,7 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
 
 static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
+				     struct user_namespace *mnt_userns,
 				     struct inode *dir,
 				     const char *name, int name_len,
 				     u64 ref_objectid, u64 objectid,
@@ -6479,7 +6480,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	if (ret != 0)
 		goto fail_unlock;
 
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(mnt_userns, inode, dir, mode);
 	inode_set_bytes(inode, 0);
 
 	inode->i_mtime = current_time(inode);
@@ -6664,9 +6665,9 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-			dentry->d_name.len, btrfs_ino(BTRFS_I(dir)), objectid,
-			mode, &index);
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+			dentry->d_name.name, dentry->d_name.len,
+			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6728,9 +6729,9 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-			dentry->d_name.len, btrfs_ino(BTRFS_I(dir)), objectid,
-			mode, &index);
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+			dentry->d_name.name, dentry->d_name.len,
+			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -6873,8 +6874,9 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-			dentry->d_name.len, btrfs_ino(BTRFS_I(dir)), objectid,
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+			dentry->d_name.name, dentry->d_name.len,
+			btrfs_ino(BTRFS_I(dir)), objectid,
 			S_IFDIR | mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -8949,7 +8951,8 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	if (err < 0)
 		return err;
 
-	inode = btrfs_new_inode(trans, new_root, NULL, "..", 2, ino, ino,
+	inode = btrfs_new_inode(trans, new_root, &init_user_ns, NULL, "..", 2,
+				ino, ino,
 				S_IFDIR | (~current_umask() & S_IRWXUGO),
 				&index);
 	if (IS_ERR(inode))
@@ -9442,7 +9445,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	inode = btrfs_new_inode(trans, root, dir,
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
 				dentry->d_name.name,
 				dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)),
@@ -9941,9 +9944,10 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	inode = btrfs_new_inode(trans, root, dir, dentry->d_name.name,
-				dentry->d_name.len, btrfs_ino(BTRFS_I(dir)),
-				objectid, S_IFLNK|S_IRWXUGO, &index);
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+				dentry->d_name.name, dentry->d_name.len,
+				btrfs_ino(BTRFS_I(dir)), objectid,
+				S_IFLNK | S_IRWXUGO, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		inode = NULL;
@@ -10292,7 +10296,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ret)
 		goto out;
 
-	inode = btrfs_new_inode(trans, root, dir, NULL, 0,
+	inode = btrfs_new_inode(trans, root, &init_user_ns, dir, NULL, 0,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-- 
2.30.2

