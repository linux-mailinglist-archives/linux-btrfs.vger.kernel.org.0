Return-Path: <linux-btrfs+bounces-5707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEAC906AB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 13:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCEF2862BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9A14373B;
	Thu, 13 Jun 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2yQbTDa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0E142E81
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276734; cv=none; b=gxSx4OTiHB+48EH8c2sc1vq0yCSFjQqe1IC0GbBUC7udYwBVbhRflpykEuuUL3bCqt7EnsNTpXXIOXBZ17henl9cXKJ5/CrPEVsn82IZKb7ZYODjqY3XuVqXO5Lb7SnC1EDyhirZHhdqebbZiSmbbPN14ZZwEGIr9FESQWChYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276734; c=relaxed/simple;
	bh=4EfHSOb/YN+dp64yPgLCTuXs/spFB+vKyYYZkpX1SZM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0WD95vy0m305NNCku0hjAmgjVw3lFR9UMVXq5O7jI5XWrXM0+uHwHrdqbTGvVIhATj5AfPNafOU8oJKlmnWZlOjfMM9WexzJkjlN+RoTXGBYpkebFPGp7Vh6vVutPJMITTjENvq00Qhp+SArWsWZhg1m3ZbbeXblp6JeWCsY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2yQbTDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F8BC32786
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718276733;
	bh=4EfHSOb/YN+dp64yPgLCTuXs/spFB+vKyYYZkpX1SZM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M2yQbTDak3+YRCcl/mMzf5bAixiTCHimLUF99YI9/HV11nE38o0FK8qD6IeAjhUjm
	 WjO73UDf+c86YIj3/FMMJN30C8ahlFh5qdYDyn0tQwBfLEOqQaK5+jVZ/FOjcRirhU
	 TqiwncHPsfyVobJa4181CUvF3t+SxreNFAqpreHhPXeg+FFZOKqvmEZZo+Kin1Lguf
	 l+xK1+7J1GFgLWnJq+uJvpWuB81CQwPG3dQAHMIe31V+D5jHzPdV6gryIBByjJBpT3
	 fh//7LnZPIXjTi4xZe4PJZ29SKfM7Y4z0hPv44izJFa5L61iqYcZ2w3L5baccfaa3/
	 zWAyn5l3w3NZA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: remove super block argument from btrfs_iget()
Date: Thu, 13 Jun 2024 12:05:26 +0100
Message-Id: <526b6e65f49a2d32372bcbb7d5cb14bf9550fa0b.1718276261.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>
References: <cover.1718276261.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless to pass a super block argument to btrfs_iget() because we
always pass a root and from it we can get the super block through:

   root->fs_info->sb

So remove the super block argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/defrag.c      |  2 +-
 fs/btrfs/export.c      |  4 ++--
 fs/btrfs/inode.c       | 13 ++++++-------
 fs/btrfs/ioctl.c       |  3 +--
 fs/btrfs/relocation.c  |  4 ++--
 fs/btrfs/send.c        |  9 ++++-----
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/tree-log.c    |  2 +-
 9 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 7a1858267506..4867b0d76199 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -576,7 +576,7 @@ int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
 struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 			      struct btrfs_root *root, struct btrfs_path *path);
-struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
+struct inode *btrfs_iget(u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, u64 start, u64 len);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 6fb94e897fc5..e7a24f096cb6 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -255,7 +255,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		goto cleanup;
 	}
 
-	inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
+	inode = btrfs_iget(defrag->ino, inode_root);
 	btrfs_put_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 5da56e21ff73..e2b22bea348a 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -84,7 +84,7 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	if (IS_ERR(root))
 		return ERR_CAST(root);
 
-	inode = btrfs_iget(sb, objectid, root);
+	inode = btrfs_iget(objectid, root);
 	btrfs_put_root(root);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
@@ -210,7 +210,7 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 					found_key.offset, 0);
 	}
 
-	return d_obtain_alias(btrfs_iget(fs_info->sb, key.objectid, root));
+	return d_obtain_alias(btrfs_iget(key.objectid, root));
 fail:
 	btrfs_free_path(path);
 	return ERR_PTR(ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ddf96c4cc858..6c2654c1e222 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3577,7 +3577,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		found_key.objectid = found_key.offset;
 		found_key.type = BTRFS_INODE_ITEM_KEY;
 		found_key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, last_objectid, root);
+		inode = btrfs_iget(last_objectid, root);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			inode = NULL;
@@ -5630,9 +5630,9 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 	return ERR_PTR(ret);
 }
 
-struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root)
+struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	return btrfs_iget_path(s, ino, root, NULL);
+	return btrfs_iget_path(root->fs_info->sb, ino, root, NULL);
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
@@ -5704,7 +5704,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return ERR_PTR(ret);
 
 	if (location.type == BTRFS_INODE_ITEM_KEY) {
-		inode = btrfs_iget(dir->i_sb, location.objectid, root);
+		inode = btrfs_iget(location.objectid, root);
 		if (IS_ERR(inode))
 			return inode;
 
@@ -5728,7 +5728,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		else
 			inode = new_simple_dir(dir, &location, root);
 	} else {
-		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
+		inode = btrfs_iget(location.objectid, sub_root);
 		btrfs_put_root(sub_root);
 
 		if (IS_ERR(inode))
@@ -6403,8 +6403,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		 * Subvolumes inherit properties from their parent subvolume,
 		 * not the directory they were created in.
 		 */
-		parent = btrfs_iget(fs_info->sb, BTRFS_FIRST_FREE_OBJECTID,
-				    BTRFS_I(dir)->root);
+		parent = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, BTRFS_I(dir)->root);
 		if (IS_ERR(parent)) {
 			ret = PTR_ERR(parent);
 		} else {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1dca986943f0..06447ee6d7ce 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1914,7 +1914,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				struct btrfs_ioctl_ino_lookup_user_args *args)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct super_block *sb = inode->i_sb;
 	u64 upper_limit = btrfs_ino(BTRFS_I(inode));
 	u64 treeid = btrfs_root_id(BTRFS_I(inode)->root);
 	u64 dirid = args->dirid;
@@ -2003,7 +2002,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			 * btree and lock the same leaf.
 			 */
 			btrfs_release_path(path);
-			temp_inode = btrfs_iget(sb, key2.objectid, root);
+			temp_inode = btrfs_iget(key2.objectid, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 320e4362d9cf..6ea407255a30 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3376,7 +3376,7 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 	if (inode)
 		goto truncate;
 
-	inode = btrfs_iget(fs_info->sb, ino, root);
+	inode = btrfs_iget(ino, root);
 	if (IS_ERR(inode))
 		return -ENOENT;
 
@@ -3913,7 +3913,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 	if (ret)
 		goto out;
 
-	inode = btrfs_iget(fs_info->sb, objectid, root);
+	inode = btrfs_iget(objectid, root);
 	if (IS_ERR(inode)) {
 		delete_orphan_inode(trans, root, objectid);
 		ret = PTR_ERR(inode);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8159695ef69c..bc2acda1d1bb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5188,11 +5188,10 @@ static int send_verity(struct send_ctx *sctx, struct fs_path *path,
 static int process_verity(struct send_ctx *sctx)
 {
 	int ret = 0;
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	struct inode *inode;
 	struct fs_path *p;
 
-	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, sctx->send_root);
+	inode = btrfs_iget(sctx->cur_ino, sctx->send_root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -5550,7 +5549,7 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	size_t inline_size;
 	int ret;
 
-	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
+	inode = btrfs_iget(sctx->cur_ino, root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -5617,7 +5616,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	u32 crc;
 	int ret;
 
-	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
+	inode = btrfs_iget(sctx->cur_ino, root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -5746,7 +5745,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 	if (sctx->cur_inode == NULL) {
 		struct btrfs_root *root = sctx->send_root;
 
-		sctx->cur_inode = btrfs_iget(root->fs_info->sb, sctx->cur_ino, root);
+		sctx->cur_inode = btrfs_iget(sctx->cur_ino, root);
 		if (IS_ERR(sctx->cur_inode)) {
 			int err = PTR_ERR(sctx->cur_inode);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 549ad700e49e..715686e8d4cb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -949,7 +949,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
-	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
+	inode = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		btrfs_handle_fs_error(fs_info, err, NULL);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4c9cc8eecb30..f0cf8ce26f01 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -151,7 +151,7 @@ static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 	 * attempt a transaction commit, resulting in a deadlock.
 	 */
 	nofs_flag = memalloc_nofs_save();
-	inode = btrfs_iget(root->fs_info->sb, objectid, root);
+	inode = btrfs_iget(objectid, root);
 	memalloc_nofs_restore(nofs_flag);
 
 	return inode;
-- 
2.43.0


