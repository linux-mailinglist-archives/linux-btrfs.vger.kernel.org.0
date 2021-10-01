Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78F41EDD9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhJAMyV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 08:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhJAMyU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 08:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CE0461A83
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092756;
        bh=igtCDDlqPbMyHa0SG4+G3xKDOfX85St3eb+Gbnjd5Hs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zh9b5o5wNI7u6QH5qwltpMdT9PJYbsML1Ibyd18kiOVIHQE2lcs7NHyf0ew87JZaF
         xYlbpAQA8EVvnFJETsBaSIb6xavWLQ97lxALlw8+eGuyXQwUt0FW8qvTXq9eZtEjP0
         z5u2aQB+q8F4R3wFy1Bvkpj+8eImZnlFKGztmkMU2W9hxCyK6DmzGhReN2R5nyR0T9
         UrRL/jqXZD79FLR+YfIZQhCxdplNfJ/zHlJvIZc/jeS1coqv84yJlMR5x9kIurP/Mz
         N8y9XJSd13JQNsoRZ7FmeO3ej6QnHsEKu1Xj7++GHWwdCK1TGymabBgcA1ApaLlKpH
         JP8oungy+PpTQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: deal with errors when checking if a dir entry exists during log replay
Date:   Fri,  1 Oct 2021 13:52:30 +0100
Message-Id: <2c11d304684692a7f41d34c149099580f1bce9e8.1633082623.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633082623.git.fdmanana@suse.com>
References: <cover.1633082623.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently inode_in_dir() ignores errors returned from
btrfs_lookup_dir_index_item() and from btrfs_lookup_dir_item(), treating
any errors as if the directory entry does not exists in the fs/subvolume
tree, which is obviously not correct, as we can get errors such as -EIO
when reading extent buffers while searching the fs/subvolume's tree.

Fix that by making inode_in_dir() return the errors and making its only
caller, add_inode_ref(), deal with returned errors as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b765ca7536fe..79d7cca704fb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -967,9 +967,11 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 }
 
 /*
- * helper function to see if a given name and sequence number found
- * in an inode back reference are already in a directory and correctly
- * point to this inode
+ * Helper function to see if a given name and sequence number found in an inode
+ * back reference are already in a directory and correctly point to this inode.
+ *
+ * Returns: < 0 on error, 0 if the directory entry does not exists and 1 if it
+ * exists.
  */
 static noinline int inode_in_dir(struct btrfs_root *root,
 				 struct btrfs_path *path,
@@ -978,29 +980,35 @@ static noinline int inode_in_dir(struct btrfs_root *root,
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
@@ -1545,10 +1553,12 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1608,6 +1618,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			if (ret)
 				goto out;
 		}
+		/* Else, ret == 1, we already have a perfect match, we're done. */
 
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
 		kfree(name);
-- 
2.33.0

