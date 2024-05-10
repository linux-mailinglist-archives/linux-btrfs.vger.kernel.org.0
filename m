Return-Path: <linux-btrfs+bounces-4901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD558C2957
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30715287B15
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F843D97D;
	Fri, 10 May 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loJnCzLs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BF3A29A
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362389; cv=none; b=I73T/NmvLvPf6psjtlxlWn1SCo/qsqZsGUMHBVDMX21oJXAxr2qw/g9GJqTKfxf0kE6XN+T9WU7ZMhIHqXcO+1etqyH4O3zNZk9+1LWzJaGMoPv6SaSuijo0TB7o/oAHe2wHUUXmy8nniZ3UY9hwDFbo27XPt7FkAokxUvTa4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362389; c=relaxed/simple;
	bh=6zLSV9xXL29aVT+UvddcLeK3WVRFJD64tesDN8nR7AA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTHig6BTOnmBEFvg1eJ8t2CIyJD85XnKr4Mip6F6NR0h+EF016QexopvUUOsgiCAxKAkR5I+rWcJvMPPHd0EW+R0JIMZD3wcEakFM5UvUi7e2u9SAlqODjJegpVXA/N2YbxogG5DhQnT+TM7blNebtYQ+QarLp8A/TtQw/LegJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loJnCzLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD2C113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362388;
	bh=6zLSV9xXL29aVT+UvddcLeK3WVRFJD64tesDN8nR7AA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=loJnCzLsiz+410sQP05uzmRnbFMB7qo48MxCU4PyDNIXf9RTCIy/+CJYwunJYg0cO
	 M5ArKXrnDWQ04aNzuDG/wSvfc9k0EvYXsCVoHZAyjP1gtQh2tNKQormN7jQfKASkad
	 dmRM9JfJm4mJwMNNPeUO9UxS6kgImD7y+lX50FzpsaTwrcErywiUHRViFdmf/Mti60
	 gpKR6bUNnzRSJEGB0OYqr3pzGs5qiswdIavZ0Y3UYgfQBQBakhP6EsWsAYZg0a3uCV
	 gPgna+a9xzZmOJmo7/CqVdnJ1VU5hjqUI+0iGhiNCw5iinVYEW6ihI+4iNKPt1pWIr
	 kLMylPgSTUswg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/10] btrfs: remove location key from struct btrfs_inode
Date: Fri, 10 May 2024 18:32:55 +0100
Message-Id: <856d3b985011d3dc5dfe9045fb687e995b596e81.1715362104.git.fdmanana@suse.com>
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

Currently struct btrfs_inode has a key member, named "location", that is
either:

1) The key of the inode's item. In this case the objectid is the number
   of the inode;

2) A key stored in a dir entry with a type of BTRFS_ROOT_ITEM_KEY, for
   the case where we have a root that is a snapshot of a subvolume that
   points to other subvolumes. In this case the objectid is the ID of
   a subvolume inside the snapshotted parent subvolume.

The key is only used to lookup the inode item for the first case, while
for the second it's never used since it corresponds to directory stubs
created with new_simple_dir() and which are marked as dummy, so there's
no actual inode item to ever update. In the second case we only check
the key type at btrfs_ino() for 32 bits platforms and its objectid is
only needed for unlink.

Instead of using a key we can do fine with just the objectid, since we
can generate the key whenever we need it having only the objectid, as
in all use cases the type is always BTRFS_INODE_ITEM_KEY and the offset
is always 0.

So use only an objectid instead of a full key. This reduces the size of
struct btrfs_inode from 1048 bytes down to 1040 bytes on a release kernel.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h       | 47 +++++++++++++++++++++++++++++++-----
 fs/btrfs/disk-io.c           |  4 +--
 fs/btrfs/export.c            |  2 +-
 fs/btrfs/inode.c             | 25 +++++++++----------
 fs/btrfs/ioctl.c             |  8 +++---
 fs/btrfs/tests/btrfs-tests.c |  4 +--
 fs/btrfs/tree-log.c          |  6 +++--
 7 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 19bb3d057414..fa2f91396ae0 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -89,6 +89,29 @@ enum {
 	BTRFS_INODE_FREE_SPACE_INODE,
 	/* Set when there are no capabilities in XATTs for the inode. */
 	BTRFS_INODE_NO_CAP_XATTR,
+	/*
+	 * Indicate this is a directory that points to a subvolume for which
+	 * there is no root reference item. That's a case like the following:
+	 *
+	 *   $ btrfs subvolume create /mnt/parent
+	 *   $ btrfs subvolume create /mnt/parent/child
+	 *   $ btrfs subvolume snapshot /mnt/parent /mnt/snap
+	 *
+	 * If subvolume "parent" is root 256, subvolume "child" is root 257 and
+	 * snapshot "snap" is root 258, then there's no root reference item (key
+	 * BTRFS_ROOT_REF_KEY in the root tree) for the subvolume "child"
+	 * associated to root 258 (the snapshot) - there's only for the root
+	 * of the "parent" subvolume (root 256). In the chunk root we have a
+	 * (256 BTRFS_ROOT_REF_KEY 257) key but we don't have a
+	 * (258 BTRFS_ROOT_REF_KEY 257) key - the sames goes for backrefs, we
+	 * have a (257 BTRFS_ROOT_BACKREF_KEY 256) but we don't have a
+	 * (257 BTRFS_ROOT_BACKREF_KEY 258) key.
+	 *
+	 * So when opening the "child" dentry from the snapshot's directory,
+	 * we don't find a root ref item and we create a stub inode. This is
+	 * done at new_simple_dir(), called from btrfs_lookup_dentry().
+	 */
+	BTRFS_INODE_ROOT_STUB,
 };
 
 /* in memory btrfs inode */
@@ -96,10 +119,15 @@ struct btrfs_inode {
 	/* which subvolume this inode belongs to */
 	struct btrfs_root *root;
 
-	/* key used to find this inode on disk.  This is used by the code
-	 * to read in roots of subvolumes
+	/*
+	 * This is either:
+	 *
+	 * 1) The objectid of the corresponding BTRFS_INODE_ITEM_KEY;
+	 *
+	 * 2) In case this a root stub inode (BTRFS_INODE_ROOT_STUB flag set),
+	 *    the ID of that root.
 	 */
-	struct btrfs_key location;
+	u64 objectid;
 
 	/* Cached value of inode property 'compression'. */
 	u8 prop_compress;
@@ -330,10 +358,9 @@ static inline unsigned long btrfs_inode_hash(u64 objectid,
  */
 static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 {
-	u64 ino = inode->location.objectid;
+	u64 ino = inode->objectid;
 
-	/* type == BTRFS_ROOT_ITEM_KEY: subvol dir */
-	if (inode->location.type == BTRFS_ROOT_ITEM_KEY)
+	if (test_bit(BTRFS_INODE_ROOT_STUB, &inode->runtime_flags))
 		ino = inode->vfs_inode.i_ino;
 	return ino;
 }
@@ -347,6 +374,14 @@ static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 
 #endif
 
+static inline void btrfs_get_inode_key(const struct btrfs_inode *inode,
+				       struct btrfs_key *key)
+{
+	key->objectid = inode->objectid;
+	key->type = BTRFS_INODE_ITEM_KEY;
+	key->offset = 0;
+}
+
 static inline void btrfs_i_size_write(struct btrfs_inode *inode, u64 size)
 {
 	i_size_write(&inode->vfs_inode, size);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d20e400a9ce3..e3edaf510108 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1944,9 +1944,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
-	BTRFS_I(inode)->location.objectid = BTRFS_BTREE_INODE_OBJECTID;
-	BTRFS_I(inode)->location.type = 0;
-	BTRFS_I(inode)->location.offset = 0;
+	BTRFS_I(inode)->objectid = BTRFS_BTREE_INODE_OBJECTID;
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	__insert_inode_hash(inode, hash);
 	fs_info->btree_inode = inode;
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 9e81f89e76d8..5526e25ebb3f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -40,7 +40,7 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	if (parent) {
 		u64 parent_root_id;
 
-		fid->parent_objectid = BTRFS_I(parent)->location.objectid;
+		fid->parent_objectid = BTRFS_I(parent)->objectid;
 		fid->parent_gen = parent->i_generation;
 		parent_root_id = btrfs_root_id(BTRFS_I(parent)->root);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 175fd007f0ef..44dc82ff96db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3838,7 +3838,7 @@ static int btrfs_read_locked_inode(struct inode *inode,
 			return -ENOMEM;
 	}
 
-	memcpy(&location, &BTRFS_I(inode)->location, sizeof(location));
+	btrfs_get_inode_key(BTRFS_I(inode), &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
 	if (ret) {
@@ -4068,13 +4068,15 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
+	struct btrfs_key key;
 	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_lookup_inode(trans, inode->root, path, &inode->location, 1);
+	btrfs_get_inode_key(inode, &key);
+	ret = btrfs_lookup_inode(trans, inode->root, path, &key, 1);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
@@ -4338,7 +4340,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		objectid = btrfs_root_id(inode->root);
 	} else if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
-		objectid = inode->location.objectid;
+		objectid = inode->objectid;
 	} else {
 		WARN_ON(1);
 		fscrypt_free_filename(&fname);
@@ -5580,9 +5582,7 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	struct btrfs_iget_args *args = p;
 
 	inode->i_ino = args->ino;
-	BTRFS_I(inode)->location.objectid = args->ino;
-	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
-	BTRFS_I(inode)->location.offset = 0;
+	BTRFS_I(inode)->objectid = args->ino;
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
 
 	if (args->root && args->root == args->root->fs_info->tree_root &&
@@ -5596,7 +5596,7 @@ static int btrfs_find_actor(struct inode *inode, void *opaque)
 {
 	struct btrfs_iget_args *args = opaque;
 
-	return args->ino == BTRFS_I(inode)->location.objectid &&
+	return args->ino == BTRFS_I(inode)->objectid &&
 		args->root == BTRFS_I(inode)->root;
 }
 
@@ -5673,7 +5673,8 @@ static struct inode *new_simple_dir(struct inode *dir,
 		return ERR_PTR(-ENOMEM);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(root);
-	memcpy(&BTRFS_I(inode)->location, key, sizeof(*key));
+	BTRFS_I(inode)->objectid = key->objectid;
+	set_bit(BTRFS_INODE_ROOT_STUB, &BTRFS_I(inode)->runtime_flags);
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
 	inode->i_ino = BTRFS_EMPTY_SUBVOL_DIR_OBJECTID;
@@ -6149,7 +6150,7 @@ static int btrfs_insert_inode_locked(struct inode *inode)
 {
 	struct btrfs_iget_args args;
 
-	args.ino = BTRFS_I(inode)->location.objectid;
+	args.ino = BTRFS_I(inode)->objectid;
 	args.root = BTRFS_I(inode)->root;
 
 	return insert_inode_locked4(inode,
@@ -6256,7 +6257,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct btrfs_root *root;
 	struct btrfs_inode_item *inode_item;
-	struct btrfs_key *location;
 	struct btrfs_path *path;
 	u64 objectid;
 	struct btrfs_inode_ref *ref;
@@ -6332,10 +6332,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 				BTRFS_INODE_NODATASUM;
 	}
 
-	location = &BTRFS_I(inode)->location;
-	location->objectid = objectid;
-	location->offset = 0;
-	location->type = BTRFS_INODE_ITEM_KEY;
+	BTRFS_I(inode)->objectid = objectid;
 
 	ret = btrfs_insert_inode_locked(inode);
 	if (ret < 0) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 28df28e50ad9..79a5ccb27b92 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1918,7 +1918,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct super_block *sb = inode->i_sb;
-	struct btrfs_key upper_limit = BTRFS_I(inode)->location;
+	u64 upper_limit = BTRFS_I(inode)->objectid;
 	u64 treeid = btrfs_root_id(BTRFS_I(inode)->root);
 	u64 dirid = args->dirid;
 	unsigned long item_off;
@@ -1944,7 +1944,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	 * If the bottom subvolume does not exist directly under upper_limit,
 	 * construct the path in from the bottom up.
 	 */
-	if (dirid != upper_limit.objectid) {
+	if (dirid != upper_limit) {
 		ptr = &args->path[BTRFS_INO_LOOKUP_USER_PATH_MAX - 1];
 
 		root = btrfs_get_fs_root(fs_info, treeid, true);
@@ -2019,7 +2019,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 				goto out_put;
 			}
 
-			if (key.offset == upper_limit.objectid)
+			if (key.offset == upper_limit)
 				break;
 			if (key.objectid == BTRFS_FIRST_FREE_OBJECTID) {
 				ret = -EACCES;
@@ -2140,7 +2140,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 	inode = file_inode(file);
 
 	if (args->dirid == BTRFS_FIRST_FREE_OBJECTID &&
-	    BTRFS_I(inode)->location.objectid != BTRFS_FIRST_FREE_OBJECTID) {
+	    BTRFS_I(inode)->objectid != BTRFS_FIRST_FREE_OBJECTID) {
 		/*
 		 * The subvolume does not exist under fd with which this is
 		 * called
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index dce0387ef155..b28a79935d8e 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -62,9 +62,7 @@ struct inode *btrfs_new_test_inode(void)
 
 	inode->i_mode = S_IFREG;
 	inode->i_ino = BTRFS_FIRST_FREE_OBJECTID;
-	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
-	BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
-	BTRFS_I(inode)->location.offset = 0;
+	BTRFS_I(inode)->objectid = BTRFS_FIRST_FREE_OBJECTID;
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, S_IFREG);
 
 	return inode;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0aee43466c52..2e762b89d4a2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4235,8 +4235,10 @@ static int log_inode_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_inode *inode, bool inode_item_dropped)
 {
 	struct btrfs_inode_item *inode_item;
+	struct btrfs_key key;
 	int ret;
 
+	btrfs_get_inode_key(inode, &key);
 	/*
 	 * If we are doing a fast fsync and the inode was logged before in the
 	 * current transaction, then we know the inode was previously logged and
@@ -4248,7 +4250,7 @@ static int log_inode_item(struct btrfs_trans_handle *trans,
 	 * already exists can also result in unnecessarily splitting a leaf.
 	 */
 	if (!inode_item_dropped && inode->logged_trans == trans->transid) {
-		ret = btrfs_search_slot(trans, log, &inode->location, path, 0, 1);
+		ret = btrfs_search_slot(trans, log, &key, path, 0, 1);
 		ASSERT(ret <= 0);
 		if (ret > 0)
 			ret = -ENOENT;
@@ -4262,7 +4264,7 @@ static int log_inode_item(struct btrfs_trans_handle *trans,
 		 * the inode, we set BTRFS_INODE_NEEDS_FULL_SYNC on its runtime
 		 * flags and set ->logged_trans to 0.
 		 */
-		ret = btrfs_insert_empty_item(trans, log, path, &inode->location,
+		ret = btrfs_insert_empty_item(trans, log, path, &key,
 					      sizeof(*inode_item));
 		ASSERT(ret != -EEXIST);
 	}
-- 
2.43.0


