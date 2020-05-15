Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D01D5814
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEORgv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 13:36:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORgv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 13:36:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E020AA4F;
        Fri, 15 May 2020 17:36:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BFF3DA732; Fri, 15 May 2020 19:35:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: simplify root lookup by id
Date:   Fri, 15 May 2020 19:35:55 +0200
Message-Id: <03fc9f9d334f539786d8bc155b0a8d12fcdaa277.1589563951.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1589563951.git.dsterba@suse.com>
References: <cover.1589563951.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The main function to lookup a root by its id btrfs_get_fs_root takes the
whole key, while only using the objectid. The value of offset is preset
to (u64)-1 but not actually used until btrfs_find_root that does the
actual search.

Switch btrfs_get_fs_root to use only objectid and remove all local
variables that existed just for the lookup. The actual key for search is
set up in btrfs_get_fs_root, reusing another key variable.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c     | 13 ++-----------
 fs/btrfs/disk-io.c     | 35 ++++++++++++++++-------------------
 fs/btrfs/disk-io.h     |  3 +--
 fs/btrfs/export.c      |  6 +-----
 fs/btrfs/file.c        |  6 +-----
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/ioctl.c       | 28 ++++++----------------------
 fs/btrfs/relocation.c  |  8 +-------
 fs/btrfs/root-tree.c   | 12 +++++-------
 fs/btrfs/scrub.c       |  6 +-----
 fs/btrfs/send.c        | 15 ++++-----------
 fs/btrfs/super.c       |  5 +----
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/tree-log.c    |  8 ++------
 fs/btrfs/uuid-tree.c   |  6 +-----
 15 files changed, 44 insertions(+), 111 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ac3c34f47b56..67651d1a7bd6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -538,18 +538,13 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 				const u64 *extent_item_pos, bool ignore_offset)
 {
 	struct btrfs_root *root;
-	struct btrfs_key root_key;
 	struct extent_buffer *eb;
 	int ret = 0;
 	int root_level;
 	int level = ref->level;
 	struct btrfs_key search_key = ref->key_for_search;
 
-	root_key.objectid = ref->root_id;
-	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
-
-	root = btrfs_get_fs_root(fs_info, &root_key, false);
+	root = btrfs_get_fs_root(fs_info, ref->root_id, false);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out_free;
@@ -2690,16 +2685,12 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 	struct btrfs_backref_edge *edge;
 	struct extent_buffer *eb;
 	struct btrfs_root *root;
-	struct btrfs_key root_key;
 	struct rb_node *rb_node;
 	int level;
 	bool need_check = true;
 	int ret;
 
-	root_key.objectid = ref_key->offset;
-	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
-	root = btrfs_get_fs_root(fs_info, &root_key, false);
+	root = btrfs_get_fs_root(fs_info, ref_key->offset, false);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 714b57553ed6..f36d5d8eb8da 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1531,35 +1531,34 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 
 
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
-				     struct btrfs_key *location,
-				     bool check_ref)
+				     u64 objectid, bool check_ref)
 {
 	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	int ret;
 
-	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
+	if (objectid == BTRFS_ROOT_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->tree_root);
-	if (location->objectid == BTRFS_EXTENT_TREE_OBJECTID)
+	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->extent_root);
-	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
+	if (objectid == BTRFS_CHUNK_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->chunk_root);
-	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
+	if (objectid == BTRFS_DEV_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->dev_root);
-	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
+	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->csum_root);
-	if (location->objectid == BTRFS_QUOTA_TREE_OBJECTID)
+	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->quota_root) ?
 			fs_info->quota_root : ERR_PTR(-ENOENT);
-	if (location->objectid == BTRFS_UUID_TREE_OBJECTID)
+	if (objectid == BTRFS_UUID_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->uuid_root) ?
 			fs_info->uuid_root : ERR_PTR(-ENOENT);
-	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
+	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
 		return btrfs_grab_root(fs_info->free_space_root) ?
 			fs_info->free_space_root : ERR_PTR(-ENOENT);
 again:
-	root = btrfs_lookup_fs_root(fs_info, location->objectid);
+	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
 			btrfs_put_root(root);
@@ -1568,7 +1567,10 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 		return root;
 	}
 
-	root = btrfs_read_tree_root(fs_info->tree_root, location);
+	key.objectid = objectid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	root = btrfs_read_tree_root(fs_info->tree_root, &key);
 	if (IS_ERR(root))
 		return root;
 
@@ -1588,7 +1590,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	}
 	key.objectid = BTRFS_ORPHAN_OBJECTID;
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
-	key.offset = location->objectid;
+	key.offset = objectid;
 
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
 	btrfs_free_path(path);
@@ -2821,7 +2823,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	u64 generation;
 	u64 features;
 	u16 csum_type;
-	struct btrfs_key location;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *tree_root;
@@ -3235,11 +3236,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	location.objectid = BTRFS_FS_TREE_OBJECTID;
-	location.type = BTRFS_ROOT_ITEM_KEY;
-	location.offset = 0;
-
-	fs_info->fs_root = btrfs_get_fs_root(fs_info, &location, true);
+	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
 		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 734bc5270b6a..bf43245406c4 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -66,8 +66,7 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
 
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
-				     struct btrfs_key *key,
-				     bool check_ref);
+				     u64 objectid, bool check_ref);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 2bb25d2dc44b..e7cc98b4d7dc 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -69,11 +69,7 @@ struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 	if (objectid < BTRFS_FIRST_FREE_OBJECTID)
 		return ERR_PTR(-ESTALE);
 
-	key.objectid = root_objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	root = btrfs_get_fs_root(fs_info, &key, true);
+	root = btrfs_get_fs_root(fs_info, root_objectid, true);
 	if (IS_ERR(root))
 		return ERR_CAST(root);
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..283e36994112 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -281,11 +281,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	/* get the inode */
-	key.objectid = defrag->root;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	inode_root = btrfs_get_fs_root(fs_info, &key, true);
+	inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
 	if (IS_ERR(inode_root)) {
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3ea694ee1c90..dc64aee95f9b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5146,7 +5146,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 
 	btrfs_release_path(path);
 
-	new_root = btrfs_get_fs_root(fs_info, location, true);
+	new_root = btrfs_get_fs_root(fs_info, location->objectid, true);
 	if (IS_ERR(new_root)) {
 		err = PTR_ERR(new_root);
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..e8425801f2cb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -660,7 +660,7 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 
 	key.offset = (u64)-1;
-	new_root = btrfs_get_fs_root(fs_info, &key, true);
+	new_root = btrfs_get_fs_root(fs_info, objectid, true);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
@@ -2127,10 +2127,7 @@ static noinline int search_ioctl(struct inode *inode,
 		/* search the root of the inode that was passed */
 		root = btrfs_grab_root(BTRFS_I(inode)->root);
 	} else {
-		key.objectid = sk->tree_id;
-		key.type = BTRFS_ROOT_ITEM_KEY;
-		key.offset = (u64)-1;
-		root = btrfs_get_fs_root(info, &key, true);
+		root = btrfs_get_fs_root(info, sk->tree_id, true);
 		if (IS_ERR(root)) {
 			btrfs_free_path(path);
 			return PTR_ERR(root);
@@ -2263,10 +2260,7 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 
 	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
-	key.objectid = tree_id;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-	root = btrfs_get_fs_root(info, &key, true);
+	root = btrfs_get_fs_root(info, tree_id, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		root = NULL;
@@ -2359,10 +2353,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 	if (dirid != upper_limit.objectid) {
 		ptr = &args->path[BTRFS_INO_LOOKUP_USER_PATH_MAX - 1];
 
-		key.objectid = treeid;
-		key.type = BTRFS_ROOT_ITEM_KEY;
-		key.offset = (u64)-1;
-		root = btrfs_get_fs_root(fs_info, &key, true);
+		root = btrfs_get_fs_root(fs_info, treeid, true);
 		if (IS_ERR(root)) {
 			ret = PTR_ERR(root);
 			goto out;
@@ -2608,9 +2599,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 
 	/* Get root_item of inode's subvolume */
 	key.objectid = BTRFS_I(inode)->root->root_key.objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-	root = btrfs_get_fs_root(fs_info, &key, true);
+	root = btrfs_get_fs_root(fs_info, key.objectid, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out_free;
@@ -3278,7 +3267,6 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	struct btrfs_dir_item *di;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path = NULL;
-	struct btrfs_key location;
 	struct btrfs_disk_key disk_key;
 	u64 objectid = 0;
 	u64 dir_id;
@@ -3299,11 +3287,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	if (!objectid)
 		objectid = BTRFS_FS_TREE_OBJECTID;
 
-	location.objectid = objectid;
-	location.type = BTRFS_ROOT_ITEM_KEY;
-	location.offset = (u64)-1;
-
-	new_root = btrfs_get_fs_root(fs_info, &location, true);
+	new_root = btrfs_get_fs_root(fs_info, objectid, true);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		goto out;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f25deca18a5d..72dc096410cd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -368,13 +368,7 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_objectid)
 {
-	struct btrfs_key key;
-
-	key.objectid = root_objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
-	return btrfs_get_fs_root(fs_info, &key, false);
+	return btrfs_get_fs_root(fs_info, root_objectid, false);
 }
 
 /*
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 668f22844017..c89697486366 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -210,7 +210,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct btrfs_path *path;
 	struct btrfs_key key;
-	struct btrfs_key root_key;
 	struct btrfs_root *root;
 	int err = 0;
 	int ret;
@@ -223,10 +222,9 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = 0;
 
-	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
-
 	while (1) {
+		u64 root_objectid;
+
 		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
 		if (ret < 0) {
 			err = ret;
@@ -250,10 +248,10 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		    key.type != BTRFS_ORPHAN_ITEM_KEY)
 			break;
 
-		root_key.objectid = key.offset;
+		root_objectid = key.offset;
 		key.offset++;
 
-		root = btrfs_get_fs_root(fs_info, &root_key, false);
+		root = btrfs_get_fs_root(fs_info, root_objectid, false);
 		err = PTR_ERR_OR_ZERO(root);
 		if (err && err != -ENOENT) {
 			break;
@@ -270,7 +268,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 				break;
 			}
 			err = btrfs_del_orphan_item(trans, tree_root,
-						    root_key.objectid);
+						    root_objectid);
 			btrfs_end_transaction(trans);
 			if (err) {
 				btrfs_handle_fs_error(fs_info, err,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0f7740970553..016a025e36c7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -647,13 +647,9 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
 	struct inode_fs_paths *ipath = NULL;
 	struct btrfs_root *local_root;
-	struct btrfs_key root_key;
 	struct btrfs_key key;
 
-	root_key.objectid = root;
-	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
-	local_root = btrfs_get_fs_root(fs_info, &root_key, true);
+	local_root = btrfs_get_fs_root(fs_info, root, true);
 	if (IS_ERR(local_root)) {
 		ret = PTR_ERR(local_root);
 		goto err;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4f3b8d2bb56b..3ddd3b9778c7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7088,7 +7088,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *send_root = BTRFS_I(file_inode(mnt_file))->root;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
 	struct btrfs_root *clone_root;
-	struct btrfs_key key;
 	struct send_ctx *sctx = NULL;
 	u32 i;
 	u64 *clone_sources_tmp = NULL;
@@ -7217,11 +7216,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		}
 
 		for (i = 0; i < arg->clone_sources_count; i++) {
-			key.objectid = clone_sources_tmp[i];
-			key.type = BTRFS_ROOT_ITEM_KEY;
-			key.offset = (u64)-1;
-
-			clone_root = btrfs_get_fs_root(fs_info, &key, true);
+			clone_root = btrfs_get_fs_root(fs_info,
+						clone_sources_tmp[i], true);
 			if (IS_ERR(clone_root)) {
 				ret = PTR_ERR(clone_root);
 				goto out;
@@ -7252,11 +7248,8 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	}
 
 	if (arg->parent_root) {
-		key.objectid = arg->parent_root;
-		key.type = BTRFS_ROOT_ITEM_KEY;
-		key.offset = (u64)-1;
-
-		sctx->parent_root = btrfs_get_fs_root(fs_info, &key, true);
+		sctx->parent_root = btrfs_get_fs_root(fs_info, arg->parent_root,
+						      true);
 		if (IS_ERR(sctx->parent_root)) {
 			ret = PTR_ERR(sctx->parent_root);
 			goto out;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 438ecba26557..6bbf84a26501 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1102,10 +1102,7 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		dirid = btrfs_root_ref_dirid(path->nodes[0], root_ref);
 		btrfs_release_path(path);
 
-		key.objectid = subvol_objectid;
-		key.type = BTRFS_ROOT_ITEM_KEY;
-		key.offset = (u64)-1;
-		fs_root = btrfs_get_fs_root(fs_info, &key, true);
+		fs_root = btrfs_get_fs_root(fs_info, subvol_objectid, true);
 		if (IS_ERR(fs_root)) {
 			ret = PTR_ERR(fs_root);
 			fs_root = NULL;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f58d0fdc5078..7a18dd5f7757 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1630,7 +1630,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.offset = (u64)-1;
-	pending->snap = btrfs_get_fs_root(fs_info, &key, true);
+	pending->snap = btrfs_get_fs_root(fs_info, objectid, true);
 	if (IS_ERR(pending->snap)) {
 		ret = PTR_ERR(pending->snap);
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 60febf2082ee..d3662e102b2e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6112,7 +6112,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct btrfs_key tmp_key;
 	struct btrfs_root *log;
 	struct btrfs_fs_info *fs_info = log_root_tree->fs_info;
 	struct walk_control wc = {
@@ -6174,11 +6173,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			goto error;
 		}
 
-		tmp_key.objectid = found_key.offset;
-		tmp_key.type = BTRFS_ROOT_ITEM_KEY;
-		tmp_key.offset = (u64)-1;
-
-		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
+		wc.replay_dest = btrfs_get_fs_root(fs_info, found_key.offset,
+						   true);
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 76671a6bcb61..28525ad7ff8c 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -257,7 +257,6 @@ static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 				       u8 *uuid, u8 type, u64 subvolid)
 {
-	struct btrfs_key key;
 	int ret = 0;
 	struct btrfs_root *subvol_root;
 
@@ -265,10 +264,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 	    type != BTRFS_UUID_KEY_RECEIVED_SUBVOL)
 		goto out;
 
-	key.objectid = subvolid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-	subvol_root = btrfs_get_fs_root(fs_info, &key, true);
+	subvol_root = btrfs_get_fs_root(fs_info, subvolid, true);
 	if (IS_ERR(subvol_root)) {
 		ret = PTR_ERR(subvol_root);
 		if (ret == -ENOENT)
-- 
2.25.0

