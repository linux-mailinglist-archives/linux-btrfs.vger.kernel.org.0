Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43C435751
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 02:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhJUAZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 20:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhJUAY5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 20:24:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 318BA6138F;
        Thu, 21 Oct 2021 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634775762;
        bh=ipCo6gkWFu/IUnXrN/G226HbXm6WVIoEISJOa6rcDh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MM1/sE6Pr7NizGk+jlpLgRqMOo0JN1t2QxDtMm39GR1AZATRIeRFGunwypNENGaX+
         7Go9q6fuL+GQwV3NQTdXEBYYnIByvFSmkv+HaMh5hbWpLHqc+ex+EXPggh+uB5likP
         AcBmkYJkv5HTWyqiUuDz5eCuopAYlITioO0HlPH8WU7NtKlK0d7hxB75Vwd9V5b51B
         DKlrjbLaWYVeDDS+DqTI0rpb5oTmhgNuOYcGC6Q0gZ41iqPxrm2Yw78V5F8j/96SPc
         PZ1Og0wAZ9zo6OoRer6QEpB7ON1LG4Y50ObA0/A5qE2JlNAyV6AETwod1c6tDqzvJF
         S8GRtDmAsQq1Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/11] btrfs: deal with errors when checking if a dir entry exists during log replay
Date:   Wed, 20 Oct 2021 20:22:28 -0400
Message-Id: <20211021002238.1129482-2-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021002238.1129482-1-sashal@kernel.org>
References: <20211021002238.1129482-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 77a5b9e3d14cbce49ceed2766b2003c034c066dc ]

Currently inode_in_dir() ignores errors returned from
btrfs_lookup_dir_index_item() and from btrfs_lookup_dir_item(), treating
any errors as if the directory entry does not exists in the fs/subvolume
tree, which is obviously not correct, as we can get errors such as -EIO
when reading extent buffers while searching the fs/subvolume's tree.

Fix that by making inode_in_dir() return the errors and making its only
caller, add_inode_ref(), deal with returned errors as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ea4b3da85d1..3da8badd4199 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -900,9 +900,11 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 }
 
 /*
- * helper function to see if a given name and sequence number found
- * in an inode back reference are already in a directory and correctly
- * point to this inode
+ * See if a given name and sequence number found in an inode back reference are
+ * already in a directory and correctly point to this inode.
+ *
+ * Returns: < 0 on error, 0 if the directory entry does not exists and 1 if it
+ * exists.
  */
 static noinline int inode_in_dir(struct btrfs_root *root,
 				 struct btrfs_path *path,
@@ -911,29 +913,35 @@ static noinline int inode_in_dir(struct btrfs_root *root,
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key location;
-	int match = 0;
+	int ret = 0;
 
 	di = btrfs_lookup_dir_index_item(NULL, root, path, dirid,
 					 index, name, name_len, 0);
-	if (di && !IS_ERR(di)) {
+	if (IS_ERR(di)) {
+		if (PTR_ERR(di) != -ENOENT)
+			ret = PTR_ERR(di);
+		goto out;
+	} else if (di) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
 		if (location.objectid != objectid)
 			goto out;
-	} else
+	} else {
 		goto out;
-	btrfs_release_path(path);
+	}
 
+	btrfs_release_path(path);
 	di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, name_len, 0);
-	if (di && !IS_ERR(di)) {
-		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
-		if (location.objectid != objectid)
-			goto out;
-	} else
+	if (IS_ERR(di)) {
+		ret = PTR_ERR(di);
 		goto out;
-	match = 1;
+	} else if (di) {
+		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
+		if (location.objectid == objectid)
+			ret = 1;
+	}
 out:
 	btrfs_release_path(path);
-	return match;
+	return ret;
 }
 
 /*
@@ -1495,10 +1503,12 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 
-		/* if we already have a perfect match, we're done */
-		if (!inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
-					btrfs_ino(BTRFS_I(inode)), ref_index,
-					name, namelen)) {
+		ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
+				   btrfs_ino(BTRFS_I(inode)), ref_index,
+				   name, namelen);
+		if (ret < 0) {
+			goto out;
+		} else if (ret == 0) {
 			/*
 			 * look for a conflicting back reference in the
 			 * metadata. if we find one we have to unlink that name
@@ -1556,6 +1566,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 
 			btrfs_update_inode(trans, root, inode);
 		}
+		/* Else, ret == 1, we already have a perfect match, we're done. */
 
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
 		kfree(name);
-- 
2.33.0

