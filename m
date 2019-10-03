Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF85CAA95
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392104AbfJCRJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 13:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391805AbfJCRJZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Oct 2019 13:09:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7A6DB201;
        Thu,  3 Oct 2019 17:09:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C61EDA890; Thu,  3 Oct 2019 19:09:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: drop unused parameter is_new from btrfs_iget
Date:   Thu,  3 Oct 2019 19:09:35 +0200
Message-Id: <20191003170935.31399-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parameter is now always set to NULL and could be dropped. The last
user was get_default_root but that got reworked in 05dbe6837b60 ("Btrfs:
unify subvol= and subvolid= mounting") and the parameter became unused.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h            |  5 ++---
 fs/btrfs/export.c           |  4 ++--
 fs/btrfs/file.c             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 24 ++++++++++++------------
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/props.c            |  4 ++--
 fs/btrfs/relocation.c       |  4 ++--
 fs/btrfs/send.c             |  2 +-
 fs/btrfs/super.c            |  2 +-
 fs/btrfs/tree-log.c         | 14 ++++++--------
 11 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 117cf26319fc..35dee08de1c5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2872,10 +2872,9 @@ int btrfs_drop_inode(struct inode *inode);
 int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
 struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
-			      struct btrfs_root *root, int *new,
-			      struct btrfs_path *path);
+			      struct btrfs_root *root, struct btrfs_path *path);
 struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
-			 struct btrfs_root *root, int *was_new);
+			 struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end, int create);
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index ddf28ecf17f9..72e312cae69d 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -87,7 +87,7 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	inode = btrfs_iget(sb, &key, root, NULL);
+	inode = btrfs_iget(sb, &key, root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail;
@@ -214,7 +214,7 @@ static struct dentry *btrfs_get_parent(struct dentry *child)
 
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	return d_obtain_alias(btrfs_iget(fs_info->sb, &key, root, NULL));
+	return d_obtain_alias(btrfs_iget(fs_info->sb, &key, root));
 fail:
 	btrfs_free_path(path);
 	return ERR_PTR(ret);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3d151f788177..b01e80eab133 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -296,7 +296,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	inode = btrfs_iget(fs_info->sb, &key, inode_root, NULL);
+	inode = btrfs_iget(fs_info->sb, &key, inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d54dcd0ab230..85cd874e7b48 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -78,7 +78,7 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	 * sure NOFS is set to keep us from deadlocking.
 	 */
 	nofs_flag = memalloc_nofs_save();
-	inode = btrfs_iget_path(fs_info->sb, &location, root, NULL, path);
+	inode = btrfs_iget_path(fs_info->sb, &location, root, path);
 	btrfs_release_path(path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(inode))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 067cbd6e3923..bceaebec9536 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2659,7 +2659,7 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
+	inode = btrfs_iget(fs_info->sb, &key, root);
 	if (IS_ERR(inode)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		return 0;
@@ -3510,7 +3510,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		found_key.objectid = found_key.offset;
 		found_key.type = BTRFS_INODE_ITEM_KEY;
 		found_key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, &found_key, root, NULL);
+		inode = btrfs_iget(fs_info->sb, &found_key, root);
 		ret = PTR_ERR_OR_ZERO(inode);
 		if (ret && ret != -ENOENT)
 			goto out;
@@ -5729,12 +5729,14 @@ static struct inode *btrfs_iget_locked(struct super_block *s,
 	return inode;
 }
 
-/* Get an inode object given its location and corresponding root.
- * Returns in *is_new if the inode was read from disk
+/*
+ * Get an inode object given its location and corresponding root.
+ * Path can be preallocated to prevent recursing back to iget through
+ * allocator. NULL is also valid but may require an additional allocation
+ * later.
  */
 struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
-			      struct btrfs_root *root, int *new,
-			      struct btrfs_path *path)
+			      struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct inode *inode;
 
@@ -5749,8 +5751,6 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 		if (!ret) {
 			inode_tree_add(inode);
 			unlock_new_inode(inode);
-			if (new)
-				*new = 1;
 		} else {
 			iget_failed(inode);
 			/*
@@ -5768,9 +5768,9 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 }
 
 struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
-			 struct btrfs_root *root, int *new)
+			 struct btrfs_root *root)
 {
-	return btrfs_iget_path(s, location, root, new, NULL);
+	return btrfs_iget_path(s, location, root, NULL);
 }
 
 static struct inode *new_simple_dir(struct super_block *s,
@@ -5836,7 +5836,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return ERR_PTR(ret);
 
 	if (location.type == BTRFS_INODE_ITEM_KEY) {
-		inode = btrfs_iget(dir->i_sb, &location, root, NULL);
+		inode = btrfs_iget(dir->i_sb, &location, root);
 		if (IS_ERR(inode))
 			return inode;
 
@@ -5861,7 +5861,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		else
 			inode = new_simple_dir(dir->i_sb, &location, sub_root);
 	} else {
-		inode = btrfs_iget(dir->i_sb, &location, sub_root, NULL);
+		inode = btrfs_iget(dir->i_sb, &location, sub_root);
 	}
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..f83c9de5dcf3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2464,7 +2464,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				goto out;
 			}
 
-			temp_inode = btrfs_iget(sb, &key2, root, NULL);
+			temp_inode = btrfs_iget(sb, &key2, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
 				goto out;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 1e664e0b59b8..aac596300c89 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -416,11 +416,11 @@ int btrfs_subvol_inherit_props(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	parent_inode = btrfs_iget(sb, &key, parent_root, NULL);
+	parent_inode = btrfs_iget(sb, &key, parent_root);
 	if (IS_ERR(parent_inode))
 		return PTR_ERR(parent_inode);
 
-	child_inode = btrfs_iget(sb, &key, root, NULL);
+	child_inode = btrfs_iget(sb, &key, root);
 	if (IS_ERR(child_inode)) {
 		iput(parent_inode);
 		return PTR_ERR(child_inode);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 077ad3d93639..99d26a765b05 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2548,7 +2548,7 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
+	inode = btrfs_iget(fs_info->sb, &key, root);
 	if (IS_ERR(inode))
 		return -ENOENT;
 
@@ -3234,7 +3234,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
+	inode = btrfs_iget(fs_info->sb, &key, root);
 	BUG_ON(IS_ERR(inode));
 	BTRFS_I(inode)->index_cnt = group->key.objectid;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f3215028235c..b8d770979489 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4779,7 +4779,7 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
-	inode = btrfs_iget(fs_info->sb, &key, root, NULL);
+	inode = btrfs_iget(fs_info->sb, &key, root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 843015b9a11e..c7d78ac64b83 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1219,7 +1219,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	inode = btrfs_iget(sb, &key, fs_info->fs_root, NULL);
+	inode = btrfs_iget(sb, &key, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail_close;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fa35fb890bf3..30a17143448d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -559,7 +559,7 @@ static noinline struct inode *read_one_inode(struct btrfs_root *root,
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	inode = btrfs_iget(root->fs_info->sb, &key, root, NULL);
+	inode = btrfs_iget(root->fs_info->sb, &key, root);
 	if (IS_ERR(inode))
 		inode = NULL;
 	return inode;
@@ -4965,7 +4965,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		key.objectid = ino;
 		key.type = BTRFS_INODE_ITEM_KEY;
 		key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, &key, root, NULL);
+		inode = btrfs_iget(fs_info->sb, &key, root);
 		/*
 		 * If the other inode that had a conflicting dir entry was
 		 * deleted in the current transaction, we need to log its parent
@@ -4975,8 +4975,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			ret = PTR_ERR(inode);
 			if (ret == -ENOENT) {
 				key.objectid = parent;
-				inode = btrfs_iget(fs_info->sb, &key, root,
-						   NULL);
+				inode = btrfs_iget(fs_info->sb, &key, root);
 				if (IS_ERR(inode)) {
 					ret = PTR_ERR(inode);
 				} else {
@@ -5681,7 +5680,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				continue;
 
 			btrfs_release_path(path);
-			di_inode = btrfs_iget(fs_info->sb, &di_key, root, NULL);
+			di_inode = btrfs_iget(fs_info->sb, &di_key, root);
 			if (IS_ERR(di_inode)) {
 				ret = PTR_ERR(di_inode);
 				goto next_dir_inode;
@@ -5807,8 +5806,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				cur_offset = item_size;
 			}
 
-			dir_inode = btrfs_iget(fs_info->sb, &inode_key,
-					       root, NULL);
+			dir_inode = btrfs_iget(fs_info->sb, &inode_key, root);
 			/*
 			 * If the parent inode was deleted, return an error to
 			 * fallback to a transaction commit. This is to prevent
@@ -5882,7 +5880,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		search_key.objectid = found_key.offset;
 		search_key.type = BTRFS_INODE_ITEM_KEY;
 		search_key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, &search_key, root, NULL);
+		inode = btrfs_iget(fs_info->sb, &search_key, root);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-- 
2.23.0

