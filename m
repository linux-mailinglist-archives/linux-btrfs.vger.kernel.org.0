Return-Path: <linux-btrfs+bounces-12088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D081EA56939
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEB83A98A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F421ABAC;
	Fri,  7 Mar 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCHzpWcF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D321ABCA
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355071; cv=none; b=LG2Ae/+jJpmZXqx59UfY4i6NymJ1WOvvGBhdLujeKeGpcdb//6auTWfXu+S0Ke30+LSQmIZxNxRsiHh8ZWfGtTKo3IM+F2k7BLYi9koWghSGuY8s/jLRGuFlpL/uhJfOPRnHYB+mVjRKZ0nHEf3xUaft2IOpwYLZw+IeYyzBeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355071; c=relaxed/simple;
	bh=U2JgnJrRQYB9bBOiYKVBr5Y7dW6crVA0RPifdfgMCVA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8HCHxfuBeHfhXURy+bwODfOv4fvhvc4ut0mLxEykICKrb8WcmJuWTNOWArrYpWib77N9r+Uv44mBlTd+Q45rJeq+gb44cK+aw53ShW9Kl8304hBRIHQOXUtgOVhpU00mrx9FEcCz+INRR4zA2qfXf42Z0TW0oP/nTyyeCzBgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCHzpWcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56320C4CEE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355070;
	bh=U2JgnJrRQYB9bBOiYKVBr5Y7dW6crVA0RPifdfgMCVA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HCHzpWcFE4DLLxLldMucKW6lEQAAd8L2ZKIVOmY0IqMugaSbnAeipOEhKzdJPOOmA
	 gDN28sgkqzToD269vzjQiL6D3q4Aw+zEtmTyWUBm9QMOgh1Nom6xnfrJmw7/2kSYqx
	 MpPUmAF/e3xGfojJ/42PAPIXaLG7KrpybCGoz8+WR71ePTnccicMCrHlEnQdiB0QW1
	 VeF8FJ62QNvkQzeAVgdfwc9W/L0JcZFFbgug5FLrP8IabCTXu41PbSqYFd7Ux1LUyJ
	 mC6YiMoDnXFd1MKL576ohd1UBqISA+pZIVmecKQ9RAg0S9L9AN6O8eEybY70IADrL5
	 zH4snOh/dE+yQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: return a btrfs_inode from read_one_inode()
Date: Fri,  7 Mar 2025 13:44:19 +0000
Message-Id: <cdeee79d76d82241f8249f11c9c5d5ab53840492.1741354478.git.fdmanana@suse.com>
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

All callers of read_one_inode() are mostly interested in the btrfs_inode
structure rather than the VFS inode, so make read_one_inode() return
the btrfs_inode instead, avoiding lots of BTRFS_I() calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 152 +++++++++++++++++++++-----------------------
 1 file changed, 73 insertions(+), 79 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fc13dbfb96f8..0df356e23762 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -616,15 +616,15 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
  * simple helper to read an inode off the disk from a given root
  * This can only be called for subvolume roots and not for the log
  */
-static noinline struct inode *read_one_inode(struct btrfs_root *root,
-					     u64 objectid)
+static noinline struct btrfs_inode *read_one_inode(struct btrfs_root *root,
+						   u64 objectid)
 {
 	struct btrfs_inode *inode;
 
 	inode = btrfs_iget_logging(objectid, root);
 	if (IS_ERR(inode))
 		return NULL;
-	return &inode->vfs_inode;
+	return inode;
 }
 
 /* replays a single extent in 'eb' at 'slot' with 'key' into the
@@ -652,7 +652,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	u64 start = key->offset;
 	u64 nbytes = 0;
 	struct btrfs_file_extent_item *item;
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	unsigned long size;
 	int ret = 0;
 
@@ -691,8 +691,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	 * file.  This must be done before the btrfs_drop_extents run
 	 * so we don't try to drop this extent.
 	 */
-	ret = btrfs_lookup_file_extent(trans, root, path,
-			btrfs_ino(BTRFS_I(inode)), start, 0);
+	ret = btrfs_lookup_file_extent(trans, root, path, btrfs_ino(inode), start, 0);
 
 	if (ret == 0 &&
 	    (found_type == BTRFS_FILE_EXTENT_REG ||
@@ -726,7 +725,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	drop_args.start = start;
 	drop_args.end = extent_end;
 	drop_args.drop_cache = true;
-	ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), &drop_args);
+	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
 
@@ -904,16 +903,15 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start,
-						extent_end - start);
+	ret = btrfs_inode_set_file_extent_range(inode, start, extent_end - start);
 	if (ret)
 		goto out;
 
 update_inode:
-	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
-	ret = btrfs_update_inode(trans, BTRFS_I(inode));
+	btrfs_update_inode_bytes(inode, nbytes, drop_args.bytes_found);
+	ret = btrfs_update_inode(trans, inode);
 out:
-	iput(inode);
+	iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -950,7 +948,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 				      struct btrfs_dir_item *di)
 {
 	struct btrfs_root *root = dir->root;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct fscrypt_str name;
 	struct extent_buffer *leaf;
 	struct btrfs_key location;
@@ -975,10 +973,10 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), &name);
+	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 out:
 	kfree(name.name);
-	iput(inode);
+	iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -1151,7 +1149,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		u32 item_size;
 		u32 cur_offset = 0;
 		unsigned long base;
-		struct inode *victim_parent;
+		struct btrfs_inode *victim_parent;
 
 		leaf = path->nodes[0];
 
@@ -1191,10 +1189,10 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					btrfs_release_path(path);
 
 					ret = unlink_inode_for_log_replay(trans,
-							BTRFS_I(victim_parent),
+							victim_parent,
 							inode, &victim_name);
 				}
-				iput(victim_parent);
+				iput(&victim_parent->vfs_inode);
 				kfree(victim_name.name);
 				if (ret)
 					return ret;
@@ -1328,7 +1326,7 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 			ret = !!btrfs_find_name_in_backref(log_eb, log_slot, &name);
 
 		if (!ret) {
-			struct inode *dir;
+			struct btrfs_inode *dir;
 
 			btrfs_release_path(path);
 			dir = read_one_inode(root, parent_id);
@@ -1337,10 +1335,9 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 				kfree(name.name);
 				goto out;
 			}
-			ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
-						 inode, &name);
+			ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 			kfree(name.name);
-			iput(dir);
+			iput(&dir->vfs_inode);
 			if (ret)
 				goto out;
 			goto again;
@@ -1372,8 +1369,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				  struct extent_buffer *eb, int slot,
 				  struct btrfs_key *key)
 {
-	struct inode *dir = NULL;
-	struct inode *inode = NULL;
+	struct btrfs_inode *dir = NULL;
+	struct btrfs_inode *inode = NULL;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
 	struct fscrypt_str name = { 0 };
@@ -1438,8 +1435,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 
-		ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
-				   btrfs_ino(BTRFS_I(inode)), ref_index, &name);
+		ret = inode_in_dir(root, path, btrfs_ino(dir), btrfs_ino(inode),
+				   ref_index, &name);
 		if (ret < 0) {
 			goto out;
 		} else if (ret == 0) {
@@ -1450,8 +1447,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			 * overwrite any existing back reference, and we don't
 			 * want to create dangling pointers in the directory.
 			 */
-			ret = __add_inode_ref(trans, root, path, log,
-					      BTRFS_I(dir), BTRFS_I(inode),
+			ret = __add_inode_ref(trans, root, path, log, dir, inode,
 					      inode_objectid, parent_objectid,
 					      ref_index, &name);
 			if (ret) {
@@ -1461,12 +1457,11 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			}
 
 			/* insert our name */
-			ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-					     &name, 0, ref_index);
+			ret = btrfs_add_link(trans, dir, inode, &name, 0, ref_index);
 			if (ret)
 				goto out;
 
-			ret = btrfs_update_inode(trans, BTRFS_I(inode));
+			ret = btrfs_update_inode(trans, inode);
 			if (ret)
 				goto out;
 		}
@@ -1476,7 +1471,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		kfree(name.name);
 		name.name = NULL;
 		if (log_ref_ver) {
-			iput(dir);
+			iput(&dir->vfs_inode);
 			dir = NULL;
 		}
 	}
@@ -1489,8 +1484,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	 * dir index entries exist for a name but there is no inode reference
 	 * item with the same name.
 	 */
-	ret = unlink_old_inode_refs(trans, root, path, BTRFS_I(inode), eb, slot,
-				    key);
+	ret = unlink_old_inode_refs(trans, root, path, inode, eb, slot, key);
 	if (ret)
 		goto out;
 
@@ -1499,8 +1493,10 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 	kfree(name.name);
-	iput(dir);
-	iput(inode);
+	if (dir)
+		iput(&dir->vfs_inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -1672,12 +1668,13 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_key key;
-	struct inode *inode;
 
 	key.objectid = BTRFS_TREE_LOG_FIXUP_OBJECTID;
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = (u64)-1;
 	while (1) {
+		struct btrfs_inode *inode;
+
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret < 0)
 			break;
@@ -1705,8 +1702,8 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		ret = fixup_inode_link_count(trans, inode);
-		iput(inode);
+		ret = fixup_inode_link_count(trans, &inode->vfs_inode);
+		iput(&inode->vfs_inode);
 		if (ret)
 			break;
 
@@ -1734,12 +1731,14 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_key key;
 	int ret = 0;
-	struct inode *inode;
+	struct btrfs_inode *inode;
+	struct inode *vfs_inode;
 
 	inode = read_one_inode(root, objectid);
 	if (!inode)
 		return -EIO;
 
+	vfs_inode = &inode->vfs_inode;
 	key.objectid = BTRFS_TREE_LOG_FIXUP_OBJECTID;
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = objectid;
@@ -1748,15 +1747,15 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 	if (ret == 0) {
-		if (!inode->i_nlink)
-			set_nlink(inode, 1);
+		if (!vfs_inode->i_nlink)
+			set_nlink(vfs_inode, 1);
 		else
-			inc_nlink(inode);
-		ret = btrfs_update_inode(trans, BTRFS_I(inode));
+			inc_nlink(vfs_inode);
+		ret = btrfs_update_inode(trans, inode);
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	}
-	iput(inode);
+	iput(vfs_inode);
 
 	return ret;
 }
@@ -1772,8 +1771,8 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 				    const struct fscrypt_str *name,
 				    struct btrfs_key *location)
 {
-	struct inode *inode;
-	struct inode *dir;
+	struct btrfs_inode *inode;
+	struct btrfs_inode *dir;
 	int ret;
 
 	inode = read_one_inode(root, location->objectid);
@@ -1782,17 +1781,16 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 
 	dir = read_one_inode(root, dirid);
 	if (!dir) {
-		iput(inode);
+		iput(&inode->vfs_inode);
 		return -EIO;
 	}
 
-	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-			     1, index);
+	ret = btrfs_add_link(trans, dir, inode, name, 1, index);
 
 	/* FIXME, put inode into FIXUP list */
 
-	iput(inode);
-	iput(dir);
+	iput(&inode->vfs_inode);
+	iput(&dir->vfs_inode);
 	return ret;
 }
 
@@ -1854,7 +1852,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	bool index_dst_matches = false;
 	struct btrfs_key log_key;
 	struct btrfs_key search_key;
-	struct inode *dir;
+	struct btrfs_inode *dir;
 	u8 log_flags;
 	bool exists;
 	int ret;
@@ -1884,9 +1882,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(dir_dst_di);
 		goto out;
 	} else if (dir_dst_di) {
-		ret = delete_conflicting_dir_entry(trans, BTRFS_I(dir), path,
-						   dir_dst_di, &log_key,
-						   log_flags, exists);
+		ret = delete_conflicting_dir_entry(trans, dir, path, dir_dst_di,
+						   &log_key, log_flags, exists);
 		if (ret < 0)
 			goto out;
 		dir_dst_matches = (ret == 1);
@@ -1901,9 +1898,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(index_dst_di);
 		goto out;
 	} else if (index_dst_di) {
-		ret = delete_conflicting_dir_entry(trans, BTRFS_I(dir), path,
-						   index_dst_di, &log_key,
-						   log_flags, exists);
+		ret = delete_conflicting_dir_entry(trans, dir, path, index_dst_di,
+						   &log_key, log_flags, exists);
 		if (ret < 0)
 			goto out;
 		index_dst_matches = (ret == 1);
@@ -1958,11 +1954,11 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 out:
 	if (!ret && update_size) {
-		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name.len * 2);
-		ret = btrfs_update_inode(trans, BTRFS_I(dir));
+		btrfs_i_size_write(dir, dir->vfs_inode.i_size + name.len * 2);
+		ret = btrfs_update_inode(trans, dir);
 	}
 	kfree(name.name);
-	iput(dir);
+	iput(&dir->vfs_inode);
 	if (!ret && name_added)
 		ret = 1;
 	return ret;
@@ -2119,16 +2115,16 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *log,
 				      struct btrfs_path *path,
 				      struct btrfs_path *log_path,
-				      struct inode *dir,
+				      struct btrfs_inode *dir,
 				      struct btrfs_key *dir_key)
 {
-	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_root *root = dir->root;
 	int ret;
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_dir_item *di;
 	struct fscrypt_str name = { 0 };
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	struct btrfs_key location;
 
 	/*
@@ -2175,9 +2171,8 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	inc_nlink(inode);
-	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(inode),
-					  &name);
+	inc_nlink(&inode->vfs_inode);
+	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
@@ -2187,7 +2182,8 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 	btrfs_release_path(log_path);
 	kfree(name.name);
-	iput(inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -2311,7 +2307,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	struct btrfs_key dir_key;
 	struct btrfs_key found_key;
 	struct btrfs_path *log_path;
-	struct inode *dir;
+	struct btrfs_inode *dir;
 
 	dir_key.objectid = dirid;
 	dir_key.type = BTRFS_DIR_INDEX_KEY;
@@ -2388,7 +2384,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 	btrfs_free_path(log_path);
-	iput(dir);
+	iput(&dir->vfs_inode);
 	return ret;
 }
 
@@ -2482,7 +2478,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			 */
 			if (S_ISREG(mode)) {
 				struct btrfs_drop_extents_args drop_args = { 0 };
-				struct inode *inode;
+				struct btrfs_inode *inode;
 				u64 from;
 
 				inode = read_one_inode(root, key.objectid);
@@ -2490,22 +2486,20 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 					ret = -EIO;
 					break;
 				}
-				from = ALIGN(i_size_read(inode),
+				from = ALIGN(i_size_read(&inode->vfs_inode),
 					     root->fs_info->sectorsize);
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
-				ret = btrfs_drop_extents(wc->trans, root,
-							 BTRFS_I(inode),
+				ret = btrfs_drop_extents(wc->trans, root, inode,
 							 &drop_args);
 				if (!ret) {
-					inode_sub_bytes(inode,
+					inode_sub_bytes(&inode->vfs_inode,
 							drop_args.bytes_found);
 					/* Update the inode's nbytes. */
-					ret = btrfs_update_inode(wc->trans,
-								 BTRFS_I(inode));
+					ret = btrfs_update_inode(wc->trans, inode);
 				}
-				iput(inode);
+				iput(&inode->vfs_inode);
 				if (ret)
 					break;
 			}
-- 
2.45.2


