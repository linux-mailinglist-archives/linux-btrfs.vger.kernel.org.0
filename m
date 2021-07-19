Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA83CD383
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhGSKa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKa1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F344F6112D;
        Mon, 19 Jul 2021 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693067;
        bh=YEFooLh98vJPJNJ+f29kzJlURCakQOXb6R8rjNFwqoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYXrrYox4VgiNF99PV2963MVMRZsXDAYtsSEAMF1FacMc2J++2d/YxbVYKf17wIG4
         G7HgmtGaolxCKd0P0dmX9PHuon4qTDpbUJGtzPhDXMPNI4aiSbL7JAU1i5YCE3CgaA
         aDUYs0+QGc+fX5Dh+LRsjDuBjoKIcZI8EwvjnmHIflLX729EZJKSiojmVfczQzmE1Z
         3q0WzUe2CS7TdxhwON/exIIGAsjwas6ZTTPK20G/Snyl/y6zaqZqSfAzk7LYFzH3QT
         JVowXA8UFJdv5V19NOr8H5l7fVwMhzXmdeQ7QfwGgQkeXc0wkb6FlSEQPV7P6R77Rv
         116q2QqMFmxxA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 03/21] btrfs/inode: allow idmapped rename iop
Date:   Mon, 19 Jul 2021 13:10:34 +0200
Message-Id: <20210719111052.1626299-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; h=from:subject; bh=grrzOjavKLZWLLGezpK1WrwE3NMHr10v0YlE7JCxiQ8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd0y/3Dlj7gz9xeH7v7Ytr7LhUP2yeHohETfDgN1DtP3 15fydZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEVoXhJ+PvhVN+TfjwZWIoG6/HqQ ZH5gs3Ts/dKcfsGHa407KuUY/hr9D8dNcz9VOL+/TKagXvvgtf+iJs/3KXS7IaarwXzGXvcAAA
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/inode.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19e83afc7d45..6e4e9f4fbdf3 100644
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

