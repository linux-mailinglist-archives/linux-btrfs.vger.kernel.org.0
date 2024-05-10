Return-Path: <linux-btrfs+bounces-4900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7DD8C2956
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A193AB2530A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCD7381D5;
	Fri, 10 May 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfkmneVv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4E28DCB
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362387; cv=none; b=eSlwhEsz4C8nc6PqVgsAArJkywDEtwIyMade8qSED6cFd/7UoDo5mBhZGilZEvaBd+I2z/Jhmo+GgSaOIOwH/GveRg6YxfXvtm5LrMnDEEnaEInX5IvtidemjkSEp0bce38wyf7Adil3uC0BfIKh7J2v7daaXB0mZe8oyGO49Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362387; c=relaxed/simple;
	bh=qeRI9ygVXjE/voqZyUI6g2DsF6u23+3L02mAh6CVDB0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TD5tvoqClAo9NMUrl0nutpMF+P6e63CC6tGsQf0v8cdh2A62/umqsQGDNjbSvD9SF/WesPmu1/O22ODX/bAAh0zFQ7tZfjfV2EGO8hH8at6pQQjwK9tUJTvTeyuB3Hx3dsak4N9Jkame8XONekSjEbDIcXUVcrPp9W/jssXfp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfkmneVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F3FC2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362387;
	bh=qeRI9ygVXjE/voqZyUI6g2DsF6u23+3L02mAh6CVDB0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tfkmneVvB9rnOzRf3OG79YxB1hk/iR4k7bx0IBvBWa7ruPH9man76MQJhk9HebkLH
	 AC5vZSMJ0zqGpqMdLfLfdFPKFHuAwmgagqU2H/saG3T639KBg3eQOpZFwu8gOAbHqE
	 YDk3YQORetNEN5XOtxiZuPwQXb5c1UDlCmFEsZD4Xznpfptwb9jA+FMTfAOUnG5Zs5
	 6BGOUNvS1+Jb6UUvpT3Rz2a1l0IJpcJrZLXiE7id6dStnh9YmSKMuZfq21cWDaNnFI
	 c3g/89k3gCl5CMG70FsU+FKgMdtBxvErTXgi6EOUUYJ94IZtoe3KCSjd77/TsnEC0b
	 XJi/b1LAGctqA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/10] btrfs: don't allocate file extent tree for non regular files
Date: Fri, 10 May 2024 18:32:54 +0100
Message-Id: <ae7290aaff13515131e2d05d13e6e8940dce50ae.1715362104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715362104.git.fdmanana@suse.com>
References: <cover.1715362104.git.fdmanana@suse.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
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


