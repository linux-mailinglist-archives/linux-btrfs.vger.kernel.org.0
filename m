Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CECB3D73A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhG0Kuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236387AbhG0Kue (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74EF611C5;
        Tue, 27 Jul 2021 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383034;
        bh=11ihsyzvFfW71UEouNoTSFiSLps04UkgtrM3/mDponQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM+22EJkqKilYZxcIPgF0xXvHrAw8wSJNGkDLLgQDREy8iuKUunhdWDdpI6HWzg4V
         Ri7He06M7XJKUl5Gonniuv/QjvvPC0t1VIJ/3ZRIoMT4huSHRQWzuN3IiM6kYizc5q
         JfbP70S/5AAo0u6rQSVAj5+VhaIalXxuH8JvF2s5jp+GG4rB1VXL8L/VwPLT2tfiOd
         EqeJaE2tQhDKfg0cT9J/HLYER5qW0vPO3vWBPB6M2sTPkzLh8BSCjpTxIp2I5YOMhD
         TI3DbBNyek6YsVcu2+wVwSxFQPEhC9qUHaLd3IbGma6MS4Ry53oSMAGrZBLP7uBToK
         260LZHOFqbQoQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 03/21] btrfs/inode: allow idmapped rename iop
Date:   Tue, 27 Jul 2021 12:48:42 +0200
Message-Id: <20210727104900.829215-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; h=from:subject; bh=emgPe/VOONUQcqGmZ3IuRcQkaxIqFeFuCR0vAIc/cgA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzLp6eppFipfc89KpzkuOzg3fcmFU2b3eFce7ujfvm26 +9HjNzpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmkrOO4X+I3ye/IOOV37ZOmTRr15 53NnfMVLet+THnxaIT0U8LpCXNGBl6d7ewzS7j35ul0Tf1S7fJ7HsVQQdWep3aLffgQQu31F1WAA==
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

/* v4 */
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

