Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E483D577D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhGZJs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232453AbhGZJs2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D0960F58;
        Mon, 26 Jul 2021 10:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295337;
        bh=jQFnDuoM/BnuEq8Rz4s4nc57hocd81q6QDseKfOaPjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaJLEvIsIiLjwYnmm/ySha+/6+SNR2Ohv/XrA7IEvSTEImmwP5K0LqbBJHjSfMUP+
         D9ImdwrUg8VYrJVj13cFJgkC8BziZJoKl+r5WXEHGpQncucc8jRI4XOQYF73+72m0b
         oSU1yLfWA9qcRGrlSLdPN1s444lYUn1nkitUhdNvxifBAQnWg4Qmv61EdUzEXHLZAH
         YLSNO0Q/b3FaToTQpaZ/JhP9FC2oc1pTKMdyXSXtfZre426hN7IMvy4sfr9xE7Xg0Y
         IL3rWOIGwNw6fXoA1EILp7gbHBlz5UedQ6X2/pBjxGP91VbJvqj2h3NUeaRJIsrGnD
         CNVyiCyNVS8CQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 03/21] btrfs/inode: allow idmapped rename iop
Date:   Mon, 26 Jul 2021 12:27:58 +0200
Message-Id: <20210726102816.612434-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; h=from:subject; bh=ekR9Pl2USGKPFCFCMIDZ7co7GAwCT5FLMDb2Um5phBw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zNc8OGwqK9r4P73krKBHO99WPuTuItsXSVM2kRZfC8e EuLvKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIhDEiPD9Yve17vXnI36/tLs2XJxm1 sHnf5ce+1bv+eE399oLrWb/Qz/4242/Vn/n/dYQNsC52Pvj8v9ZZlx7vuBw9lp7K/uNyzr4AcA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_rename() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

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
 fs/btrfs/inode.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ae4fe9377e6f..ddb60462f5f0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9433,6 +9433,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
+				     struct user_namespace *mnt_userns,
 				     struct inode *dir,
 				     struct dentry *dentry)
 {
@@ -9445,7 +9446,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 				dentry->d_name.name,
 				dentry->d_name.len,
 				btrfs_ino(BTRFS_I(dir)),
@@ -9482,9 +9483,10 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-			   struct inode *new_dir, struct dentry *new_dentry,
-			   unsigned int flags)
+static int btrfs_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
 	struct btrfs_trans_handle *trans;
@@ -9657,8 +9659,8 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	if (flags & RENAME_WHITEOUT) {
-		ret = btrfs_whiteout_for_rename(trans, root, old_dir,
-						old_dentry);
+		ret = btrfs_whiteout_for_rename(trans, root, mnt_userns,
+						old_dir, old_dentry);
 
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -9708,7 +9710,8 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
 		return btrfs_rename_exchange(old_dir, old_dentry, new_dir,
 					  new_dentry);
 
-	return btrfs_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
+	return btrfs_rename(mnt_userns, old_dir, old_dentry, new_dir,
+			    new_dentry, flags);
 }
 
 struct btrfs_delalloc_work {
-- 
2.30.2

