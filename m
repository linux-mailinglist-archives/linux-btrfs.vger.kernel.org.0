Return-Path: <linux-btrfs+bounces-4838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802908BFCFB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3931F24764
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D484D2A;
	Wed,  8 May 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9zS86vH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FF83CDC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170660; cv=none; b=ao0UlfESD5SX9f1OWxP3oQS5jtYKGol3Dg2yPV6NceW17rVyM9ejL/e9VdD28NGmyoKtZJVTFaTbi0RQMCcFOF/+h1iz953Og/Rxco/JtJDBaAMIJZ8XtJShqGpsnK0OITOy7kCCuZ2IIrvVy0rDv23oNh/934eRD3zB2uPfVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170660; c=relaxed/simple;
	bh=0+zVYEueYtzfOA++IVEtDCN9bL3D46fHqucgtWxKz94=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kqz7UYLkClSH4ZXWGA/Apgj1jO46cW5v601NPQrC4sR/+PcvaD9gx+0+HVPiypigpp84W07jprNqGVIIqXDV55LAquxr/T/Sijrn3+LRmtWYF2n4SiPnKbFjRxLam5NkP9lQzOJ4XsvBcf0ge/YRbRYkhn2XFoyjgbH9/l+MB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9zS86vH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853E9C3277B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170660;
	bh=0+zVYEueYtzfOA++IVEtDCN9bL3D46fHqucgtWxKz94=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=T9zS86vH/0tBoHp6CGTF1uY/mDG8TP0QHxzxIaAHTzHc3mDJRpA38mnWdCOYuaxCM
	 sLTje+Y8bAn61zyCIJGH0Kdhq+1oW2+6VlsG9p3CXZlXV59Ql1WkAe5xXy8OSqYgix
	 ogzq+rpsLAbt4njyhLlCEywUM9vfOkUH2rAf6mRf5h02GFGei/2JVyVPPkOcWlarwM
	 2s6juxECsBPEe9dKnAo7+6K5C8/dx/zsxaIifmqxi2+VrXONOx0MylE9joYhTniIsz
	 Xif9tILXX6olkUnfCebtRgGmyodv9tQ6DQg1MBUv5iby9P8gYYZFUZp9nI99wg+9Uj
	 26n88RqHXU7oQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: don't allocate file extent tree for non regular files
Date: Wed,  8 May 2024 13:17:29 +0100
Message-Id: <13d914be0518dc3f4a8086f96275c3b8bf113d63.1715169723.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715169723.git.fdmanana@suse.com>
References: <cover.1715169723.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When not using the NO_HOLES feature we always allocate an io tree for an
inode's file_extent_tree. This is wasteful because that io tree is only
used for regular files, so we allocate more memory than needed for inodes
that represent directories or symlinks for example, or for inodes that
correspond to free space inodes.

So improve on this by allocating the io tree only for inodes of regular
files that are not free space inodes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 13 ++++++-----
 fs/btrfs/inode.c     | 53 +++++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index bce95f871750..f3ed78e21fa4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -45,13 +45,12 @@
  */
 void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 start, end, i_size;
 	int ret;
 
 	spin_lock(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
-	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
+	if (!inode->file_extent_tree) {
 		inode->disk_i_size = i_size;
 		goto out_unlock;
 	}
@@ -84,13 +83,14 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 				      u64 len)
 {
+	if (!inode->file_extent_tree)
+		return 0;
+
 	if (len == 0)
 		return 0;
 
 	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize));
 
-	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
-		return 0;
 	return set_extent_bit(inode->file_extent_tree, start, start + len - 1,
 			      EXTENT_DIRTY, NULL);
 }
@@ -112,14 +112,15 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len)
 {
+	if (!inode->file_extent_tree)
+		return 0;
+
 	if (len == 0)
 		return 0;
 
 	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) ||
 	       len == (u64)-1);
 
-	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
-		return 0;
 	return clear_extent_bit(inode->file_extent_tree, start,
 				start + len - 1, EXTENT_DIRTY, NULL);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9b98aa65cc63..175fd007f0ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3781,6 +3781,30 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 	return 1;
 }
 
+static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	if (WARN_ON_ONCE(inode->file_extent_tree))
+		return 0;
+	if (btrfs_fs_incompat(fs_info, NO_HOLES))
+		return 0;
+	if (!S_ISREG(inode->vfs_inode.i_mode))
+		return 0;
+	if (btrfs_is_free_space_inode(inode))
+		return 0;
+
+	inode->file_extent_tree = kmalloc(sizeof(struct extent_io_tree), GFP_KERNEL);
+	if (!inode->file_extent_tree)
+		return -ENOMEM;
+
+	extent_io_tree_init(fs_info, inode->file_extent_tree, IO_TREE_INODE_FILE_EXTENT);
+	/* Lockdep class is set only for the file extent tree. */
+	lockdep_set_class(&inode->file_extent_tree->lock, &file_extent_tree_class);
+
+	return 0;
+}
+
 /*
  * read an inode from the btree into the in-memory inode
  */
@@ -3800,6 +3824,10 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	bool filled = false;
 	int first_xattr_slot;
 
+	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
+	if (ret)
+		return ret;
+
 	ret = btrfs_fill_inode(inode, &rdev);
 	if (!ret)
 		filled = true;
@@ -6247,6 +6275,10 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		BTRFS_I(inode)->root = btrfs_grab_root(BTRFS_I(dir)->root);
 	root = BTRFS_I(inode)->root;
 
+	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
+	if (ret)
+		goto out;
+
 	ret = btrfs_get_free_objectid(root, &objectid);
 	if (ret)
 		goto out;
@@ -8413,20 +8445,10 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_inode *ei;
 	struct inode *inode;
-	struct extent_io_tree *file_extent_tree = NULL;
-
-	/* Self tests may pass a NULL fs_info. */
-	if (fs_info && !btrfs_fs_incompat(fs_info, NO_HOLES)) {
-		file_extent_tree = kmalloc(sizeof(struct extent_io_tree), GFP_KERNEL);
-		if (!file_extent_tree)
-			return NULL;
-	}
 
 	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
-	if (!ei) {
-		kfree(file_extent_tree);
+	if (!ei)
 		return NULL;
-	}
 
 	ei->root = NULL;
 	ei->generation = 0;
@@ -8471,13 +8493,8 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
 	ei->io_tree.inode = ei;
 
-	ei->file_extent_tree = file_extent_tree;
-	if (file_extent_tree) {
-		extent_io_tree_init(fs_info, ei->file_extent_tree,
-				    IO_TREE_INODE_FILE_EXTENT);
-		/* Lockdep class is set only for the file extent tree. */
-		lockdep_set_class(&ei->file_extent_tree->lock, &file_extent_tree_class);
-	}
+	ei->file_extent_tree = NULL;
+
 	mutex_init(&ei->log_mutex);
 	spin_lock_init(&ei->ordered_tree_lock);
 	ei->ordered_tree = RB_ROOT;
-- 
2.43.0


