Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C184A3CD382
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhGSKaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKaZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94C9B6113C;
        Mon, 19 Jul 2021 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693065;
        bh=5GH3IZAKq/cw7ybT8neP42F5HkBTerTYEqa8fFU09eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZN1XSTCR0nSzXLR3HVT84tiMBJSQgYPwMv3o0rFLtWg2mFBKCRoMo1hXvH4Aqoo4
         GmxUciXB2VVUr2loaKgwJeLF22xwfhEl8tk5t/EzgSF5e7kcxghmL5wd/SkB4oL6sJ
         spLVbGPfH/FwCk6ruvO96zcBOo5zK7lgnpDxa/nRRBdXDdB570iNLZkenzNh7tn0z3
         SJJJ1oQayehNMdEswSnKpZ3N6npA1+F7taPaRS79FPfbAheUdkwoNKBtBFHKls5Nms
         azouKwRTfncsktdQ+N6mc3NnYURm26wvxB6hMp+g2EY0Q/sh1LLCIO6VwBepHEEnbh
         fE5OtNELBropw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 02/21] btrfs/inode: handle idmaps in btrfs_new_inode()
Date:   Mon, 19 Jul 2021 13:10:33 +0200
Message-Id: <20210719111052.1626299-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4635; h=from:subject; bh=T6CniUBhfqWP/zsl4QdNeVmJV9K4pg35sN/QaYOiakU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd1cf/N+q+qPaoZHprHzTNdPFLM08bxt8m37stLTn9QL 5jO87yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIHA/Df6/0idoHDunLP/teMfXp+x qHhOM8B6/5bXi94OHfB0Wl2/IZGVZcivJ22BWa9ky5ceGRev6fp81WXP/zgfdv3JTyhw1Mt1gA
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/inode.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c5..19e83afc7d45 100644
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

