Return-Path: <linux-btrfs+bounces-12090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EAA5693B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A544188D7AC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6421ABC4;
	Fri,  7 Mar 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAepOl+1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE4219EAB
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355073; cv=none; b=TYw1YoX5cZIrCL/xZA9BxcmcAKa4WqxMQHdob/uqQdWAw36Myf5AvOyCByWweRrJePFiLlBestsfYNqK22Xt9TrHAo/H1vmaXsNylob7+YAx+jlsxdod2Al/0YBloKIEOUud3vjiLF+9an5EA6PZX/M8Lpa5hn9PdQLOOBtOtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355073; c=relaxed/simple;
	bh=/mtJsJTh1f7XnnT03eaLEp5HMmWDbOsSjiaKE2gzdX8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p++rJDZpCZtdENQ2/GBkVaLe1mPXlQd3DDHh+0Nw2oGJ7P7qSv5VLqM5qTHrPPNYDyZiLQUg9SSA4qzwleYK9gM9O22hgxqpX1ftX0mSeq1OpzpPr41VXnfSUsgQ7dGEuhkmeJptxPmFo3K6X6ROIv7tMPnHnaNPLTmE+xPIyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAepOl+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A62C4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355072;
	bh=/mtJsJTh1f7XnnT03eaLEp5HMmWDbOsSjiaKE2gzdX8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OAepOl+1Funr4x9WXSOSceM+kQOLkw/oOqJgE1NZNnyGw9J8cdV8K6dwbgYPPfY1n
	 e1cYDrcl/anpGnSF6++NJqP1htr34RSrdZn6XPYoiUUVq99CDbowHUMYmszEXTYKIQ
	 IN6pAig2Vx4/wyivPGZgniS9jGwmjA7cSTVEmF5A4NwBsX6/W2Nf3E7AO9nyvPCZ7s
	 6MhCE3qbV7fI1g2mMWPn8TBytyGT8KCwcsmXpUFeFyHdDfAr13S0BjFe8c6nLA0Hvd
	 w5hTnb/aDz9a/XYPT7SVz+KblPg+cTX8EdJOyudXXijPuHoNbrkA8JZwzztthQRZyi
	 xnlVE8E9/jgfg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
Date: Fri,  7 Mar 2025 13:44:21 +0000
Message-Id: <f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's an internal function and most of the time the callers are doing a lot
of BTRFS_I() calls on the returned VFS inode to get the btrfs inode, so
change the return type to struct btrfs_inode instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/defrag.c      | 14 +++++------
 fs/btrfs/export.c      | 17 +++++++++----
 fs/btrfs/inode.c       | 56 +++++++++++++++++++++---------------------
 fs/btrfs/ioctl.c       |  7 +++---
 fs/btrfs/relocation.c  | 17 +++++++------
 fs/btrfs/send.c        | 25 +++++++++----------
 fs/btrfs/super.c       |  4 +--
 fs/btrfs/tree-log.c    |  7 ++----
 9 files changed, 78 insertions(+), 71 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ca1cd600f5d2..d81bfc760f9b 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -594,7 +594,7 @@ int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
 struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 			      struct btrfs_path *path);
-struct inode *btrfs_iget(u64 ino, struct btrfs_root *root);
+struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct folio *folio, u64 start, u64 len);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 18f0704263f3..6097c2e12b41 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -225,7 +225,7 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 				  struct file_ra_state *ra)
 {
 	struct btrfs_root *inode_root;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct btrfs_ioctl_defrag_range_args range;
 	int ret = 0;
 	u64 cur = 0;
@@ -250,24 +250,24 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		goto cleanup;
 	}
 
-	if (cur >= i_size_read(inode)) {
-		iput(inode);
+	if (cur >= i_size_read(&inode->vfs_inode)) {
+		iput(&inode->vfs_inode);
 		goto cleanup;
 	}
 
 	/* Do a chunk of defrag */
-	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
+	clear_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
 	memset(&range, 0, sizeof(range));
 	range.len = (u64)-1;
 	range.start = cur;
 	range.extent_thresh = defrag->extent_thresh;
-	file_ra_state_init(ra, inode->i_mapping);
+	file_ra_state_init(ra, inode->vfs_inode.i_mapping);
 
 	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(BTRFS_I(inode), ra, &range, defrag->transid,
+	ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
 				BTRFS_DEFRAG_BATCH);
 	sb_end_write(fs_info->sb);
-	iput(inode);
+	iput(&inode->vfs_inode);
 
 	if (ret < 0)
 		goto cleanup;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index a91eaf0ca34e..9fddbb4bb66c 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -75,7 +75,7 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	if (objectid < BTRFS_FIRST_FREE_OBJECTID)
 		return ERR_PTR(-ESTALE);
@@ -89,12 +89,12 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	if (generation != 0 && generation != inode->i_generation) {
-		iput(inode);
+	if (generation != 0 && generation != inode->vfs_inode.i_generation) {
+		iput(&inode->vfs_inode);
 		return ERR_PTR(-ESTALE);
 	}
 
-	return d_obtain_alias(inode);
+	return d_obtain_alias(&inode->vfs_inode);
 }
 
 static struct dentry *btrfs_fh_to_parent(struct super_block *sb, struct fid *fh,
@@ -146,6 +146,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 struct dentry *btrfs_get_parent(struct dentry *child)
 {
 	struct btrfs_inode *dir = BTRFS_I(d_inode(child));
+	struct btrfs_inode *inode;
 	struct btrfs_root *root = dir->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
@@ -210,7 +211,13 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 					found_key.offset, 0);
 	}
 
-	return d_obtain_alias(btrfs_iget(key.objectid, root));
+	inode = btrfs_iget(key.objectid, root);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		goto fail;
+	}
+
+	return d_obtain_alias(&inode->vfs_inode);
 fail:
 	btrfs_free_path(path);
 	return ERR_PTR(ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ac4858b70e7..072e7a47f162 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3555,7 +3555,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	struct extent_buffer *leaf;
 	struct btrfs_key key, found_key;
 	struct btrfs_trans_handle *trans;
-	struct inode *inode;
 	u64 last_objectid = 0;
 	int ret = 0, nr_unlink = 0;
 
@@ -3574,6 +3573,8 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	key.offset = (u64)-1;
 
 	while (1) {
+		struct btrfs_inode *inode;
+
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		if (ret < 0)
 			goto out;
@@ -3697,10 +3698,10 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		 * deleted but wasn't. The inode number may have been reused,
 		 * but either way, we can delete the orphan item.
 		 */
-		if (!inode || inode->i_nlink) {
+		if (!inode || inode->vfs_inode.i_nlink) {
 			if (inode) {
-				ret = btrfs_drop_verity_items(BTRFS_I(inode));
-				iput(inode);
+				ret = btrfs_drop_verity_items(inode);
+				iput(&inode->vfs_inode);
 				inode = NULL;
 				if (ret)
 					goto out;
@@ -3723,7 +3724,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		nr_unlink++;
 
 		/* this will do delete_inode and everything for us */
-		iput(inode);
+		iput(&inode->vfs_inode);
 	}
 	/* release the path since we're done with it */
 	btrfs_release_path(path);
@@ -5673,7 +5674,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 /*
  * Get an inode object given its inode number and corresponding root.
  */
-struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
+struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
 	struct btrfs_inode *inode;
 	struct btrfs_path *path;
@@ -5684,7 +5685,7 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 		return ERR_PTR(-ENOMEM);
 
 	if (!(inode->vfs_inode.i_state & I_NEW))
-		return &inode->vfs_inode;
+		return inode;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -5696,7 +5697,7 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 		return ERR_PTR(ret);
 
 	unlock_new_inode(&inode->vfs_inode);
-	return &inode->vfs_inode;
+	return inode;
 }
 
 static struct btrfs_inode *new_simple_dir(struct inode *dir,
@@ -5756,7 +5757,7 @@ static inline u8 btrfs_inode_type(const struct btrfs_inode *inode)
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
 	struct btrfs_key location = { 0 };
@@ -5773,49 +5774,48 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	if (location.type == BTRFS_INODE_ITEM_KEY) {
 		inode = btrfs_iget(location.objectid, root);
 		if (IS_ERR(inode))
-			return inode;
+			return ERR_CAST(inode);
 
 		/* Do extra check against inode mode with di_type */
-		if (btrfs_inode_type(BTRFS_I(inode)) != di_type) {
+		if (btrfs_inode_type(inode) != di_type) {
 			btrfs_crit(fs_info,
 "inode mode mismatch with dir: inode mode=0%o btrfs type=%u dir type=%u",
-				  inode->i_mode, btrfs_inode_type(BTRFS_I(inode)),
+				  inode->vfs_inode.i_mode, btrfs_inode_type(inode),
 				  di_type);
-			iput(inode);
+			iput(&inode->vfs_inode);
 			return ERR_PTR(-EUCLEAN);
 		}
-		return inode;
+		return &inode->vfs_inode;
 	}
 
 	ret = fixup_tree_root_location(fs_info, BTRFS_I(dir), dentry,
 				       &location, &sub_root);
 	if (ret < 0) {
-		if (ret != -ENOENT) {
+		if (ret != -ENOENT)
 			inode = ERR_PTR(ret);
-		} else {
-			struct btrfs_inode *b_inode;
-
-			b_inode = new_simple_dir(dir, &location, root);
-			inode = &b_inode->vfs_inode;
-		}
+		else
+			inode = new_simple_dir(dir, &location, root);
 	} else {
 		inode = btrfs_iget(location.objectid, sub_root);
 		btrfs_put_root(sub_root);
 
 		if (IS_ERR(inode))
-			return inode;
+			return ERR_CAST(inode);
 
 		down_read(&fs_info->cleanup_work_sem);
-		if (!sb_rdonly(inode->i_sb))
+		if (!sb_rdonly(inode->vfs_inode.i_sb))
 			ret = btrfs_orphan_cleanup(sub_root);
 		up_read(&fs_info->cleanup_work_sem);
 		if (ret) {
-			iput(inode);
+			iput(&inode->vfs_inode);
 			inode = ERR_PTR(ret);
 		}
 	}
 
-	return inode;
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	return &inode->vfs_inode;
 }
 
 static int btrfs_dentry_delete(const struct dentry *dentry)
@@ -6468,7 +6468,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	path = NULL;
 
 	if (args->subvol) {
-		struct inode *parent;
+		struct btrfs_inode *parent;
 
 		/*
 		 * Subvolumes inherit properties from their parent subvolume,
@@ -6479,8 +6479,8 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			ret = PTR_ERR(parent);
 		} else {
 			ret = btrfs_inode_inherit_props(trans, BTRFS_I(inode),
-							BTRFS_I(parent));
-			iput(parent);
+							parent);
+			iput(&parent->vfs_inode);
 		}
 	} else {
 		ret = btrfs_inode_inherit_props(trans, BTRFS_I(inode),
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fffa2868f329..c68e505710af 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1832,7 +1832,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	struct btrfs_path *path;
 	struct btrfs_key key, key2;
 	struct extent_buffer *leaf;
-	struct inode *temp_inode;
 	char *ptr;
 	int slot;
 	int len;
@@ -1860,6 +1859,8 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 		key.type = BTRFS_INODE_REF_KEY;
 		key.offset = (u64)-1;
 		while (1) {
+			struct btrfs_inode *temp_inode;
+
 			ret = btrfs_search_backwards(root, &key, path);
 			if (ret < 0)
 				goto out_put;
@@ -1914,9 +1915,9 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
-			ret = inode_permission(idmap, temp_inode,
+			ret = inode_permission(idmap, &temp_inode->vfs_inode,
 					       MAY_READ | MAY_EXEC);
-			iput(temp_inode);
+			iput(&temp_inode->vfs_inode);
 			if (ret) {
 				ret = -EACCES;
 				goto out_put;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index af0969b70b53..5359cf2b79b5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3246,14 +3246,16 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_inode *btrfs_inode;
 	int ret = 0;
 
 	if (inode)
 		goto truncate;
 
-	inode = btrfs_iget(ino, root);
-	if (IS_ERR(inode))
+	btrfs_inode = btrfs_iget(ino, root);
+	if (IS_ERR(btrfs_inode))
 		return -ENOENT;
+	inode = &btrfs_inode->vfs_inode;
 
 truncate:
 	ret = btrfs_check_trunc_cache_free_space(fs_info,
@@ -3764,7 +3766,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 					struct btrfs_fs_info *fs_info,
 					const struct btrfs_block_group *group)
 {
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root;
 	u64 objectid;
@@ -3792,18 +3794,19 @@ static noinline_for_stack struct inode *create_reloc_inode(
 		inode = NULL;
 		goto out;
 	}
-	BTRFS_I(inode)->reloc_block_group_start = group->start;
+	inode->reloc_block_group_start = group->start;
 
-	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+	ret = btrfs_orphan_add(trans, inode);
 out:
 	btrfs_put_root(root);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (ret) {
-		iput(inode);
+		if (inode)
+			iput(&inode->vfs_inode);
 		inode = ERR_PTR(ret);
 	}
-	return inode;
+	return &inode->vfs_inode;
 }
 
 /*
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 17a6ed3691e7..0c8c58c4f29b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5187,14 +5187,14 @@ static int send_verity(struct send_ctx *sctx, struct fs_path *path,
 static int process_verity(struct send_ctx *sctx)
 {
 	int ret = 0;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct fs_path *p;
 
 	inode = btrfs_iget(sctx->cur_ino, sctx->send_root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	ret = btrfs_get_verity_descriptor(inode, NULL, 0);
+	ret = btrfs_get_verity_descriptor(&inode->vfs_inode, NULL, 0);
 	if (ret < 0)
 		goto iput;
 
@@ -5211,7 +5211,7 @@ static int process_verity(struct send_ctx *sctx)
 		}
 	}
 
-	ret = btrfs_get_verity_descriptor(inode, sctx->verity_descriptor, ret);
+	ret = btrfs_get_verity_descriptor(&inode->vfs_inode, sctx->verity_descriptor, ret);
 	if (ret < 0)
 		goto iput;
 
@@ -5223,7 +5223,7 @@ static int process_verity(struct send_ctx *sctx)
 
 	ret = send_verity(sctx, p, sctx->verity_descriptor);
 iput:
-	iput(inode);
+	iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -5573,7 +5573,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct fs_path *fspath;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_key key;
@@ -5639,7 +5639,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	 * Note that send_buf is a mapping of send_buf_pages, so this is really
 	 * reading into send_buf.
 	 */
-	ret = btrfs_encoded_read_regular_fill_pages(BTRFS_I(inode),
+	ret = btrfs_encoded_read_regular_fill_pages(inode,
 						    disk_bytenr, disk_num_bytes,
 						    sctx->send_buf_pages +
 						    (data_offset >> PAGE_SHIFT),
@@ -5665,7 +5665,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 
 tlv_put_failure:
 out:
-	iput(inode);
+	iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -5707,15 +5707,14 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 	}
 
 	if (sctx->cur_inode == NULL) {
+		struct btrfs_inode *btrfs_inode;
 		struct btrfs_root *root = sctx->send_root;
 
-		sctx->cur_inode = btrfs_iget(sctx->cur_ino, root);
-		if (IS_ERR(sctx->cur_inode)) {
-			int err = PTR_ERR(sctx->cur_inode);
+		btrfs_inode = btrfs_iget(sctx->cur_ino, root);
+		if (IS_ERR(btrfs_inode))
+			return PTR_ERR(btrfs_inode);
 
-			sctx->cur_inode = NULL;
-			return err;
-		}
+		sctx->cur_inode = &btrfs_inode->vfs_inode;
 		memset(&sctx->ra, 0, sizeof(struct file_ra_state));
 		file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fdec546a87f3..40709e2a44fc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -947,7 +947,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 static int btrfs_fill_super(struct super_block *sb,
 			    struct btrfs_fs_devices *fs_devices)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	int err;
 
@@ -982,7 +982,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		goto fail_close;
 	}
 
-	sb->s_root = d_make_root(inode);
+	sb->s_root = d_make_root(&inode->vfs_inode);
 	if (!sb->s_root) {
 		err = -ENOMEM;
 		goto fail_close;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 349c9482e9b9..2d23223f476b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -141,7 +141,7 @@ static void wait_log_commit(struct btrfs_root *root, int transid);
 static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 {
 	unsigned int nofs_flag;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/*
 	 * We're holding a transaction handle whether we are logging or
@@ -154,10 +154,7 @@ static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *r
 	inode = btrfs_iget(objectid, root);
 	memalloc_nofs_restore(nofs_flag);
 
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
-
-	return BTRFS_I(inode);
+	return inode;
 }
 
 /*
-- 
2.45.2


