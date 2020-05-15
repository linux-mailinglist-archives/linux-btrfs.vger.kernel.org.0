Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D311D5816
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEORgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 13:36:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEORgy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 13:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C264AAA4F;
        Fri, 15 May 2020 17:36:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE3A9DA732; Fri, 15 May 2020 19:35:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: simplify iget helpers
Date:   Fri, 15 May 2020 19:35:59 +0200
Message-Id: <c275c2045999258072fe24cc5bfe3a3728278fbc.1589563951.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1589563951.git.dsterba@suse.com>
References: <cover.1589563951.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The inode lookup starting at btrfs_iget takes the full location key,
while only the objectid is used to match the inode, because the lookup
happens inside the given root thus the inode number is unique.
The entire location key is properly set up in btrfs_init_locked_inode.

Simplify the helpers and pass only inode number, renaming it to 'ino'
instead of 'objectid'. This allows to remove temporary variables key,
saving some stack space.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h            |  5 ++---
 fs/btrfs/export.c           | 11 ++--------
 fs/btrfs/file.c             |  6 +-----
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 40 +++++++++++++++++++------------------
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/props.c            |  9 ++-------
 fs/btrfs/relocation.c       | 13 ++----------
 fs/btrfs/send.c             |  7 +------
 fs/btrfs/super.c            |  6 +-----
 fs/btrfs/tree-log.c         | 24 ++++++++++------------
 11 files changed, 44 insertions(+), 81 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a1fa1526c43..c7fe03ed84ef 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2876,10 +2876,9 @@ void btrfs_free_inode(struct inode *inode);
 int btrfs_drop_inode(struct inode *inode);
 int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
-struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
+struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 			      struct btrfs_root *root, struct btrfs_path *path);
-struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
-			 struct btrfs_root *root);
+struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct page *page, size_t pg_offset,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index e7cc98b4d7dc..1a8d419d9e1f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -64,7 +64,6 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root;
 	struct inode *inode;
-	struct btrfs_key key;
 
 	if (objectid < BTRFS_FIRST_FREE_OBJECTID)
 		return ERR_PTR(-ESTALE);
@@ -73,11 +72,7 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	if (IS_ERR(root))
 		return ERR_CAST(root);
 
-	key.objectid = objectid;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	inode = btrfs_iget(sb, &key, root);
+	inode = btrfs_iget(sb, objectid, root);
 	btrfs_put_root(root);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
@@ -196,9 +191,7 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 					found_key.offset, 0, 0);
 	}
 
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-	return d_obtain_alias(btrfs_iget(fs_info->sb, &key, root));
+	return d_obtain_alias(btrfs_iget(fs_info->sb, key.objectid, root));
 fail:
 	btrfs_free_path(path);
 	return ERR_PTR(ret);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 283e36994112..ba217d89cbe8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -275,7 +275,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *inode_root;
 	struct inode *inode;
-	struct btrfs_key key;
 	struct btrfs_ioctl_defrag_range_args range;
 	int num_defrag;
 	int ret;
@@ -287,10 +286,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		goto cleanup;
 	}
 
-	key.objectid = defrag->ino;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-	inode = btrfs_iget(fs_info->sb, &key, inode_root);
+	inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
 	btrfs_put_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3c353a337b91..525bc5a250da 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -82,7 +82,7 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	 * sure NOFS is set to keep us from deadlocking.
 	 */
 	nofs_flag = memalloc_nofs_save();
-	inode = btrfs_iget_path(fs_info->sb, &location, root, path);
+	inode = btrfs_iget_path(fs_info->sb, location.objectid, root, path);
 	btrfs_release_path(path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(inode))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dc64aee95f9b..de231f7a75a6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -51,7 +51,7 @@
 #include "block-group.h"
 
 struct btrfs_iget_args {
-	struct btrfs_key *location;
+	u64 ino;
 	struct btrfs_root *root;
 };
 
@@ -2978,7 +2978,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 		found_key.objectid = found_key.offset;
 		found_key.type = BTRFS_INODE_ITEM_KEY;
 		found_key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, &found_key, root);
+		inode = btrfs_iget(fs_info->sb, last_objectid, root);
 		ret = PTR_ERR_OR_ZERO(inode);
 		if (ret && ret != -ENOENT)
 			goto out;
@@ -5224,9 +5224,11 @@ static void inode_tree_del(struct inode *inode)
 static int btrfs_init_locked_inode(struct inode *inode, void *p)
 {
 	struct btrfs_iget_args *args = p;
-	inode->i_ino = args->location->objectid;
-	memcpy(&BTRFS_I(inode)->location, args->location,
-	       sizeof(*args->location));
+
+	inode->i_ino = args->ino;
+	BTRFS_I(inode)->location.objectid = args->ino;
+	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
+	BTRFS_I(inode)->location.offset = 0;
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
 	BUG_ON(args->root && !BTRFS_I(inode)->root);
 	return 0;
@@ -5235,19 +5237,19 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 static int btrfs_find_actor(struct inode *inode, void *opaque)
 {
 	struct btrfs_iget_args *args = opaque;
-	return args->location->objectid == BTRFS_I(inode)->location.objectid &&
+
+	return args->ino == BTRFS_I(inode)->location.objectid &&
 		args->root == BTRFS_I(inode)->root;
 }
 
-static struct inode *btrfs_iget_locked(struct super_block *s,
-				       struct btrfs_key *location,
+static struct inode *btrfs_iget_locked(struct super_block *s, u64 ino,
 				       struct btrfs_root *root)
 {
 	struct inode *inode;
 	struct btrfs_iget_args args;
-	unsigned long hashval = btrfs_inode_hash(location->objectid, root);
+	unsigned long hashval = btrfs_inode_hash(ino, root);
 
-	args.location = location;
+	args.ino = ino;
 	args.root = root;
 
 	inode = iget5_locked(s, hashval, btrfs_find_actor,
@@ -5257,17 +5259,17 @@ static struct inode *btrfs_iget_locked(struct super_block *s,
 }
 
 /*
- * Get an inode object given its location and corresponding root.
+ * Get an inode object given its inode number and corresponding root.
  * Path can be preallocated to prevent recursing back to iget through
  * allocator. NULL is also valid but may require an additional allocation
  * later.
  */
-struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
+struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 			      struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct inode *inode;
 
-	inode = btrfs_iget_locked(s, location, root);
+	inode = btrfs_iget_locked(s, ino, root);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
@@ -5294,10 +5296,9 @@ struct inode *btrfs_iget_path(struct super_block *s, struct btrfs_key *location,
 	return inode;
 }
 
-struct inode *btrfs_iget(struct super_block *s, struct btrfs_key *location,
-			 struct btrfs_root *root)
+struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root)
 {
-	return btrfs_iget_path(s, location, root, NULL);
+	return btrfs_iget_path(s, ino, root, NULL);
 }
 
 static struct inode *new_simple_dir(struct super_block *s,
@@ -5366,7 +5367,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return ERR_PTR(ret);
 
 	if (location.type == BTRFS_INODE_ITEM_KEY) {
-		inode = btrfs_iget(dir->i_sb, &location, root);
+		inode = btrfs_iget(dir->i_sb, location.objectid, root);
 		if (IS_ERR(inode))
 			return inode;
 
@@ -5390,7 +5391,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		else
 			inode = new_simple_dir(dir->i_sb, &location, sub_root);
 	} else {
-		inode = btrfs_iget(dir->i_sb, &location, sub_root);
+		inode = btrfs_iget(dir->i_sb, location.objectid, sub_root);
 	}
 	if (root != sub_root)
 		btrfs_put_root(sub_root);
@@ -5771,7 +5772,8 @@ int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index)
 static int btrfs_insert_inode_locked(struct inode *inode)
 {
 	struct btrfs_iget_args args;
-	args.location = &BTRFS_I(inode)->location;
+
+	args.ino = BTRFS_I(inode)->location.objectid;
 	args.root = BTRFS_I(inode)->root;
 
 	return insert_inode_locked4(inode,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e8425801f2cb..cba7f414933d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2412,7 +2412,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				goto out_put;
 			}
 
-			temp_inode = btrfs_iget(sb, &key2, root);
+			temp_inode = btrfs_iget(sb, key2.objectid, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index ff1ff90e48b1..2dcb1cb21634 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -408,19 +408,14 @@ int btrfs_subvol_inherit_props(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *parent_root)
 {
 	struct super_block *sb = root->fs_info->sb;
-	struct btrfs_key key;
 	struct inode *parent_inode, *child_inode;
 	int ret;
 
-	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	parent_inode = btrfs_iget(sb, &key, parent_root);
+	parent_inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, parent_root);
 	if (IS_ERR(parent_inode))
 		return PTR_ERR(parent_inode);
 
-	child_inode = btrfs_iget(sb, &key, root);
+	child_inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, root);
 	if (IS_ERR(child_inode)) {
 		iput(parent_inode);
 		return PTR_ERR(child_inode);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 722f36343664..87b9d38ab29f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2958,7 +2958,6 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 				    struct inode *inode,
 				    u64 ino)
 {
-	struct btrfs_key key;
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_trans_handle *trans;
 	int ret = 0;
@@ -2966,11 +2965,7 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
 	if (inode)
 		goto truncate;
 
-	key.objectid = ino;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	inode = btrfs_iget(fs_info->sb, &key, root);
+	inode = btrfs_iget(fs_info->sb, ino, root);
 	if (IS_ERR(inode))
 		return -ENOENT;
 
@@ -3458,7 +3453,6 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	struct inode *inode = NULL;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root;
-	struct btrfs_key key;
 	u64 objectid;
 	int err = 0;
 
@@ -3479,10 +3473,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	err = __insert_orphan_inode(trans, root, objectid);
 	BUG_ON(err);
 
-	key.objectid = objectid;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-	inode = btrfs_iget(fs_info->sb, &key, root);
+	inode = btrfs_iget(fs_info->sb, objectid, root);
 	BUG_ON(IS_ERR(inode));
 	BTRFS_I(inode)->index_cnt = group->start;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3ddd3b9778c7..0f37660b14b2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4806,17 +4806,12 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 	struct inode *inode;
 	struct page *page;
 	char *addr;
-	struct btrfs_key key;
 	pgoff_t index = offset >> PAGE_SHIFT;
 	pgoff_t last_index;
 	unsigned pg_offset = offset_in_page(offset);
 	ssize_t ret = 0;
 
-	key.objectid = sctx->cur_ino;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-
-	inode = btrfs_iget(fs_info->sb, &key, root);
+	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6bbf84a26501..bc73fd670702 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1217,7 +1217,6 @@ static int btrfs_fill_super(struct super_block *sb,
 {
 	struct inode *inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	struct btrfs_key key;
 	int err;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -1245,10 +1244,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
-	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-	inode = btrfs_iget(sb, &key, fs_info->fs_root);
+	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail_close;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d3662e102b2e..67fa7087f707 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -550,13 +550,9 @@ static noinline int overwrite_item(struct btrfs_trans_handle *trans,
 static noinline struct inode *read_one_inode(struct btrfs_root *root,
 					     u64 objectid)
 {
-	struct btrfs_key key;
 	struct inode *inode;
 
-	key.objectid = objectid;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-	inode = btrfs_iget(root->fs_info->sb, &key, root);
+	inode = btrfs_iget(root->fs_info->sb, objectid, root);
 	if (IS_ERR(inode))
 		inode = NULL;
 	return inode;
@@ -4815,10 +4811,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 
 		btrfs_release_path(path);
 
-		key.objectid = ino;
-		key.type = BTRFS_INODE_ITEM_KEY;
-		key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, &key, root);
+		inode = btrfs_iget(fs_info->sb, ino, root);
 		/*
 		 * If the other inode that had a conflicting dir entry was
 		 * deleted in the current transaction, we need to log its parent
@@ -4827,8 +4820,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			if (ret == -ENOENT) {
-				key.objectid = parent;
-				inode = btrfs_iget(fs_info->sb, &key, root);
+				inode = btrfs_iget(fs_info->sb, parent, root);
 				if (IS_ERR(inode)) {
 					ret = PTR_ERR(inode);
 				} else {
@@ -5567,7 +5559,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				continue;
 
 			btrfs_release_path(path);
-			di_inode = btrfs_iget(fs_info->sb, &di_key, root);
+			di_inode = btrfs_iget(fs_info->sb, di_key.objectid, root);
 			if (IS_ERR(di_inode)) {
 				ret = PTR_ERR(di_inode);
 				goto next_dir_inode;
@@ -5693,7 +5685,8 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				cur_offset = item_size;
 			}
 
-			dir_inode = btrfs_iget(fs_info->sb, &inode_key, root);
+			dir_inode = btrfs_iget(fs_info->sb, inode_key.objectid,
+					       root);
 			/*
 			 * If the parent inode was deleted, return an error to
 			 * fallback to a transaction commit. This is to prevent
@@ -5760,14 +5753,17 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		int slot = path->slots[0];
 		struct btrfs_key search_key;
 		struct inode *inode;
+		u64 ino;
 		int ret = 0;
 
 		btrfs_release_path(path);
 
+		ino = found_key.offset;
+
 		search_key.objectid = found_key.offset;
 		search_key.type = BTRFS_INODE_ITEM_KEY;
 		search_key.offset = 0;
-		inode = btrfs_iget(fs_info->sb, &search_key, root);
+		inode = btrfs_iget(fs_info->sb, ino, root);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-- 
2.25.0

