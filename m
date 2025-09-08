Return-Path: <linux-btrfs+bounces-16723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B428CB48931
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53E03B8154
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAD2FDC56;
	Mon,  8 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks/zSs/5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131442FDC22
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325237; cv=none; b=GayDxX76Y0h/jN99vgNCK+voLwE+J2CqByDUXiPo2MV8+3XhcaG47xmH5ex8Rx9iF97rWN93lSF8ilnap6WfU1OAdIhWHYfHH7W2dW1BYzzphPRKuz2HXAN95bTUPSl9K8KVzGvTTBhjRbYAYY2H2T2PjqhTzuSWne4gN9rnOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325237; c=relaxed/simple;
	bh=tHRyKHZ6DQGKqt8svKkJ2zBKe11r/TmdNS70UGP3PAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PybcWemiZIMWdbJXTsC7D9zkSuPFrAmkHKuqeC9w7wy0OKhkEFYmFBsYVQ/HpKh1aWNuSTGyZrOUZLhx7mFx5NDInYPmIeNvzIwD6qH9WF6s6EWQJrVhaSFTk/eVWUYzAA/J8eh/ZoueJXgbgIMMouUucxFGIfGqt8RME7Scc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks/zSs/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69709C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325236;
	bh=tHRyKHZ6DQGKqt8svKkJ2zBKe11r/TmdNS70UGP3PAc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ks/zSs/5gxMyVgP3F4c0w6VpJsF1GNBxU1gPnHj3QiFA+rX9ZRBLuD5ur+QleXg6U
	 /6k2RvqxDrgGrgCy0Eg5xrYhPsh7tKIjnZDyu3w3oZJQZy8X2GreQuDmo+DNPgQHxp
	 yO5A8tk5QLm4CjDJ9bY4Qo0TwMtGU4bB1xKuS2TJxguBOk6A9nQQkCgkhxhW7HhVSS
	 +ZtUSfXJU06q8wP7j5ibDp/wqpGXe1L50tz99lD0I+WEKX1oCjt/mXLQBzak8RfiZn
	 DmEBQ9NQqs30sxc6ZybX67Eb4F2cujCoRUSRKOf0HUYJ78GMd19wEsdGi9pTxpc8fE
	 rUqVVKQiSlRKw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 28/33] btrfs: add path for subvolume tree changes to struct walk_control
Date: Mon,  8 Sep 2025 10:53:22 +0100
Message-ID: <5c7e6aaf70ab6fdc860819c564400f6b012015c9.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

While replaying log trees we need to do searches and updates to subvolume
trees and for that we use a path that we allocate in replay_one_buffer()
and then pass it as a parameter to other functions deeper in the log
replay call chain. Instead of passing it as parameter, add it to struct
walk_control since we pass a pointer to that structure for every log
replay function.

This reduces the number of arguments passed to the functions and it will
be needed and important for an upcoming changes that improves error
reporting for log replay. Also name the new filed in struct walk_control
to 'subvol_path' - while that is longer to type, the naming makes it clear
it's used for subvolume tree operations since many of the log replay
functions operate both on subvolume and log trees, and for the log tree
searches we have struct walk_control::log_leaf to also make it obvious
it's an extent buffer for a log tree extent buffer.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 323 +++++++++++++++++++++-----------------------
 1 file changed, 156 insertions(+), 167 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 66500ebdd35c..747daaaaf332 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -162,16 +162,17 @@ struct walk_control {
 	struct btrfs_key log_key;
 	/* The slot being processed of the current log leaf. */
 	int log_slot;
+
+	/* A path used for searches and modifications to subvolume trees. */
+	struct btrfs_path *subvol_path;
 };
 
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode,
 			   int inode_only,
 			   struct btrfs_log_ctx *ctx);
-static int link_to_fixup_dir(struct walk_control *wc,
-			     struct btrfs_path *path, u64 objectid);
+static int link_to_fixup_dir(struct walk_control *wc, u64 objectid);
 static noinline int replay_dir_deletes(struct walk_control *wc,
-				       struct btrfs_path *path,
 				       u64 dirid, bool del_all);
 static void wait_log_commit(struct btrfs_root *root, int transid);
 
@@ -422,7 +423,7 @@ static int process_one_buffer(struct extent_buffer *eb,
  *
  * If the key isn't in the destination yet, a new item is inserted.
  */
-static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
+static int overwrite_item(struct walk_control *wc)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -449,14 +450,14 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 	src_ptr = btrfs_item_ptr_offset(wc->log_leaf, wc->log_slot);
 
 	/* Look for the key in the destination tree. */
-	ret = btrfs_search_slot(NULL, root, &wc->log_key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &wc->log_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	dst_eb = path->nodes[0];
-	dst_slot = path->slots[0];
+	dst_eb = wc->subvol_path->nodes[0];
+	dst_slot = wc->subvol_path->slots[0];
 
 	if (ret == 0) {
 		char *src_copy;
@@ -466,7 +467,7 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 			goto insert;
 
 		if (item_size == 0) {
-			btrfs_release_path(path);
+			btrfs_release_path(wc->subvol_path);
 			return 0;
 		}
 		src_copy = kmalloc(item_size, GFP_NOFS);
@@ -487,7 +488,7 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 		 * sync
 		 */
 		if (ret == 0) {
-			btrfs_release_path(path);
+			btrfs_release_path(wc->subvol_path);
 			return 0;
 		}
 
@@ -537,23 +538,23 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 			btrfs_set_inode_size(wc->log_leaf, item, 0);
 	}
 insert:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	/* try to insert the key into the destination tree */
-	path->skip_release_on_error = 1;
-	ret = btrfs_insert_empty_item(trans, root, path, &wc->log_key, item_size);
-	path->skip_release_on_error = 0;
+	wc->subvol_path->skip_release_on_error = 1;
+	ret = btrfs_insert_empty_item(trans, root, wc->subvol_path, &wc->log_key, item_size);
+	wc->subvol_path->skip_release_on_error = 0;
 
-	dst_eb = path->nodes[0];
-	dst_slot = path->slots[0];
+	dst_eb = wc->subvol_path->nodes[0];
+	dst_slot = wc->subvol_path->slots[0];
 
 	/* make sure any existing item is the correct size */
 	if (ret == -EEXIST || ret == -EOVERFLOW) {
 		const u32 found_size = btrfs_item_size(dst_eb, dst_slot);
 
 		if (found_size > item_size)
-			btrfs_truncate_item(trans, path, item_size, 1);
+			btrfs_truncate_item(trans, wc->subvol_path, item_size, 1);
 		else if (found_size < item_size)
-			btrfs_extend_item(trans, path, item_size - found_size);
+			btrfs_extend_item(trans, wc->subvol_path, item_size - found_size);
 	} else if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -618,7 +619,7 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 			btrfs_set_inode_generation(dst_eb, dst_item, trans->transid);
 	}
 no_copy:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	return 0;
 }
 
@@ -649,7 +650,7 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
  * The extent is inserted into the file, dropping any existing extents
  * from the file that overlap the new one.
  */
-static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path *path)
+static noinline int replay_one_extent(struct walk_control *wc)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -710,16 +711,18 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 	 * file.  This must be done before the btrfs_drop_extents run
 	 * so we don't try to drop this extent.
 	 */
-	ret = btrfs_lookup_file_extent(trans, root, path, btrfs_ino(inode), start, 0);
+	ret = btrfs_lookup_file_extent(trans, root, wc->subvol_path,
+				       btrfs_ino(inode), start, 0);
 
 	if (ret == 0 &&
 	    (found_type == BTRFS_FILE_EXTENT_REG ||
 	     found_type == BTRFS_FILE_EXTENT_PREALLOC)) {
+		struct extent_buffer *leaf = wc->subvol_path->nodes[0];
 		struct btrfs_file_extent_item existing;
 		unsigned long ptr;
 
-		ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-		read_extent_buffer(path->nodes[0], &existing, ptr, sizeof(existing));
+		ptr = btrfs_item_ptr_offset(leaf, wc->subvol_path->slots[0]);
+		read_extent_buffer(leaf, &existing, ptr, sizeof(existing));
 
 		/*
 		 * we already have a pointer to this exact extent,
@@ -727,17 +730,17 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 		 */
 		if (memcmp_extent_buffer(wc->log_leaf, &existing, (unsigned long)item,
 					 sizeof(existing)) == 0) {
-			btrfs_release_path(path);
+			btrfs_release_path(wc->subvol_path);
 			goto out;
 		}
 	}
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	/* drop any overlapping extents */
 	drop_args.start = start;
 	drop_args.end = extent_end;
 	drop_args.drop_cache = true;
-	drop_args.path = path;
+	drop_args.path = wc->subvol_path;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -746,7 +749,7 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 
 	if (found_type == BTRFS_FILE_EXTENT_INLINE) {
 		/* inline extents are easy, we just overwrite them */
-		ret = overwrite_item(wc, path);
+		ret = overwrite_item(wc);
 		if (ret)
 			goto out;
 		goto update_inode;
@@ -762,13 +765,15 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 	    btrfs_fs_incompat(fs_info, NO_HOLES))
 		goto update_inode;
 
-	ret = btrfs_insert_empty_item(trans, root, path, &wc->log_key, sizeof(*item));
+	ret = btrfs_insert_empty_item(trans, root, wc->subvol_path,
+				      &wc->log_key, sizeof(*item));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	dest_offset = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-	copy_extent_buffer(path->nodes[0], wc->log_leaf, dest_offset,
+	dest_offset = btrfs_item_ptr_offset(wc->subvol_path->nodes[0],
+					    wc->subvol_path->slots[0]);
+	copy_extent_buffer(wc->subvol_path->nodes[0], wc->log_leaf, dest_offset,
 			   (unsigned long)item, sizeof(*item));
 
 	/*
@@ -778,7 +783,7 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 	 * update the inode item.
 	 */
 	if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0) {
-		btrfs_release_path(path);
+		btrfs_release_path(wc->subvol_path);
 		goto update_inode;
 	}
 
@@ -833,7 +838,7 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 		}
 	}
 
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	if (btrfs_file_extent_compression(wc->log_leaf, item)) {
 		csum_start = ins.objectid;
@@ -967,7 +972,6 @@ static int unlink_inode_for_log_replay(struct walk_control *wc,
  * item
  */
 static noinline int drop_one_dir_item(struct walk_control *wc,
-				      struct btrfs_path *path,
 				      struct btrfs_inode *dir,
 				      struct btrfs_dir_item *di)
 {
@@ -975,12 +979,10 @@ static noinline int drop_one_dir_item(struct walk_control *wc,
 	struct btrfs_root *root = dir->root;
 	struct btrfs_inode *inode;
 	struct fscrypt_str name;
-	struct extent_buffer *leaf;
+	struct extent_buffer *leaf = wc->subvol_path->nodes[0];
 	struct btrfs_key location;
 	int ret;
 
-	leaf = path->nodes[0];
-
 	btrfs_dir_item_key_to_cpu(leaf, di, &location);
 	ret = read_alloc_one_name(leaf, di + 1, btrfs_dir_name_len(leaf, di), &name);
 	if (ret) {
@@ -988,7 +990,7 @@ static noinline int drop_one_dir_item(struct walk_control *wc,
 		return ret;
 	}
 
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	inode = btrfs_iget_logging(location.objectid, root);
 	if (IS_ERR(inode)) {
@@ -998,7 +1000,7 @@ static noinline int drop_one_dir_item(struct walk_control *wc,
 		goto out;
 	}
 
-	ret = link_to_fixup_dir(wc, path, location.objectid);
+	ret = link_to_fixup_dir(wc, location.objectid);
 	if (ret)
 		goto out;
 
@@ -1097,13 +1099,12 @@ static noinline int backref_in_log(struct btrfs_root *log,
 }
 
 static int unlink_refs_not_in_log(struct walk_control *wc,
-				  struct btrfs_path *path,
 				  struct btrfs_key *search_key,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
 				  u64 parent_objectid)
 {
-	struct extent_buffer *leaf = path->nodes[0];
+	struct extent_buffer *leaf = wc->subvol_path->nodes[0];
 	unsigned long ptr;
 	unsigned long ptr_end;
 
@@ -1112,8 +1113,8 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 	 * log. If so, we allow them to stay otherwise they must be unlinked as
 	 * a conflict.
 	 */
-	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	ptr_end = ptr + btrfs_item_size(leaf, path->slots[0]);
+	ptr = btrfs_item_ptr_offset(leaf, wc->subvol_path->slots[0]);
+	ptr_end = ptr + btrfs_item_size(leaf, wc->subvol_path->slots[0]);
 	while (ptr < ptr_end) {
 		struct btrfs_trans_handle *trans = wc->trans;
 		struct fscrypt_str victim_name;
@@ -1141,7 +1142,7 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 		}
 
 		inc_nlink(&inode->vfs_inode);
-		btrfs_release_path(path);
+		btrfs_release_path(wc->subvol_path);
 
 		ret = unlink_inode_for_log_replay(wc, dir, inode, &victim_name);
 		kfree(victim_name.name);
@@ -1154,15 +1155,14 @@ static int unlink_refs_not_in_log(struct walk_control *wc,
 }
 
 static int unlink_extrefs_not_in_log(struct walk_control *wc,
-				     struct btrfs_path *path,
 				     struct btrfs_key *search_key,
 				     struct btrfs_inode *inode,
 				     u64 inode_objectid,
 				     u64 parent_objectid)
 {
-	struct extent_buffer *leaf = path->nodes[0];
-	const unsigned long base = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	const u32 item_size = btrfs_item_size(leaf, path->slots[0]);
+	struct extent_buffer *leaf = wc->subvol_path->nodes[0];
+	const unsigned long base = btrfs_item_ptr_offset(leaf, wc->subvol_path->slots[0]);
+	const u32 item_size = btrfs_item_size(leaf, wc->subvol_path->slots[0]);
 	u32 cur_offset = 0;
 
 	while (cur_offset < item_size) {
@@ -1213,7 +1213,7 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 		}
 
 		inc_nlink(&inode->vfs_inode);
-		btrfs_release_path(path);
+		btrfs_release_path(wc->subvol_path);
 
 		ret = unlink_inode_for_log_replay(wc, victim_parent, inode,
 						  &victim_name);
@@ -1228,7 +1228,6 @@ static int unlink_extrefs_not_in_log(struct walk_control *wc,
 }
 
 static inline int __add_inode_ref(struct walk_control *wc,
-				  struct btrfs_path *path,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
 				  u64 inode_objectid, u64 parent_objectid,
@@ -1246,7 +1245,7 @@ static inline int __add_inode_ref(struct walk_control *wc,
 	search_key.objectid = inode_objectid;
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = parent_objectid;
-	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -1258,53 +1257,54 @@ static inline int __add_inode_ref(struct walk_control *wc,
 		if (search_key.objectid == search_key.offset)
 			return 1;
 
-		ret = unlink_refs_not_in_log(wc, path, &search_key, dir, inode,
+		ret = unlink_refs_not_in_log(wc, &search_key, dir, inode,
 					     parent_objectid);
 		if (ret == -EAGAIN)
 			goto again;
 		else if (ret)
 			return ret;
 	}
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	/* Same search but for extended refs */
-	extref = btrfs_lookup_inode_extref(root, path, name, inode_objectid, parent_objectid);
+	extref = btrfs_lookup_inode_extref(root, wc->subvol_path, name,
+					   inode_objectid, parent_objectid);
 	if (IS_ERR(extref)) {
 		return PTR_ERR(extref);
 	} else if (extref) {
-		ret = unlink_extrefs_not_in_log(wc, path, &search_key, inode,
+		ret = unlink_extrefs_not_in_log(wc, &search_key, inode,
 						inode_objectid, parent_objectid);
 		if (ret == -EAGAIN)
 			goto again;
 		else if (ret)
 			return ret;
 	}
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	/* look for a conflicting sequence number */
-	di = btrfs_lookup_dir_index_item(trans, root, path, btrfs_ino(dir),
+	di = btrfs_lookup_dir_index_item(trans, root, wc->subvol_path, btrfs_ino(dir),
 					 ref_index, name, 0);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	} else if (di) {
-		ret = drop_one_dir_item(wc, path, dir, di);
+		ret = drop_one_dir_item(wc, dir, di);
 		if (ret)
 			return ret;
 	}
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	/* look for a conflicting name */
-	di = btrfs_lookup_dir_item(trans, root, path, btrfs_ino(dir), name, 0);
+	di = btrfs_lookup_dir_item(trans, root, wc->subvol_path, btrfs_ino(dir), name, 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	} else if (di) {
-		ret = drop_one_dir_item(wc, path, dir, di);
+		ret = drop_one_dir_item(wc, dir, di);
 		if (ret)
 			return ret;
 	}
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	return 0;
 }
@@ -1357,9 +1357,7 @@ static int ref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
  * proper unlink of that name (that is, remove its entry from the inode
  * reference item and both dir index keys).
  */
-static int unlink_old_inode_refs(struct walk_control *wc,
-				 struct btrfs_path *path,
-				 struct btrfs_inode *inode)
+static int unlink_old_inode_refs(struct walk_control *wc, struct btrfs_inode *inode)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1369,8 +1367,8 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 	struct extent_buffer *eb;
 
 again:
-	btrfs_release_path(path);
-	ret = btrfs_search_slot(NULL, root, &wc->log_key, path, 0, 0);
+	btrfs_release_path(wc->subvol_path);
+	ret = btrfs_search_slot(NULL, root, &wc->log_key, wc->subvol_path, 0, 0);
 	if (ret > 0) {
 		ret = 0;
 		goto out;
@@ -1380,9 +1378,9 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 		goto out;
 	}
 
-	eb = path->nodes[0];
-	ref_ptr = btrfs_item_ptr_offset(eb, path->slots[0]);
-	ref_end = ref_ptr + btrfs_item_size(eb, path->slots[0]);
+	eb = wc->subvol_path->nodes[0];
+	ref_ptr = btrfs_item_ptr_offset(eb, wc->subvol_path->slots[0]);
+	ref_end = ref_ptr + btrfs_item_size(eb, wc->subvol_path->slots[0]);
 	while (ref_ptr < ref_end) {
 		struct fscrypt_str name;
 		u64 parent_id;
@@ -1413,7 +1411,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 		if (!ret) {
 			struct btrfs_inode *dir;
 
-			btrfs_release_path(path);
+			btrfs_release_path(wc->subvol_path);
 			dir = btrfs_iget_logging(parent_id, root);
 			if (IS_ERR(dir)) {
 				ret = PTR_ERR(dir);
@@ -1438,7 +1436,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 	}
 	ret = 0;
  out:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	return ret;
 }
 
@@ -1446,7 +1444,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
  * Replay one inode back reference item found in the log tree.
  * Path is for temporary use by this function (it should be released on return).
  */
-static noinline int add_inode_ref(struct walk_control *wc, struct btrfs_path *path)
+static noinline int add_inode_ref(struct walk_control *wc)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1548,8 +1546,8 @@ static noinline int add_inode_ref(struct walk_control *wc, struct btrfs_path *pa
 			}
 		}
 
-		ret = inode_in_dir(root, path, btrfs_ino(dir), btrfs_ino(inode),
-				   ref_index, &name);
+		ret = inode_in_dir(root, wc->subvol_path, btrfs_ino(dir),
+				   btrfs_ino(inode), ref_index, &name);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -1561,7 +1559,7 @@ static noinline int add_inode_ref(struct walk_control *wc, struct btrfs_path *pa
 			 * overwrite any existing back reference, and we don't
 			 * want to create dangling pointers in the directory.
 			 */
-			ret = __add_inode_ref(wc, path, dir, inode, inode_objectid,
+			ret = __add_inode_ref(wc, dir, inode, inode_objectid,
 					      parent_objectid, ref_index, &name);
 			if (ret) {
 				if (ret == 1)
@@ -1602,14 +1600,14 @@ static noinline int add_inode_ref(struct walk_control *wc, struct btrfs_path *pa
 	 * dir index entries exist for a name but there is no inode reference
 	 * item with the same name.
 	 */
-	ret = unlink_old_inode_refs(wc, path, inode);
+	ret = unlink_old_inode_refs(wc, inode);
 	if (ret)
 		goto out;
 
 	/* finally write the back reference in the inode */
-	ret = overwrite_item(wc, path);
+	ret = overwrite_item(wc);
 out:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	kfree(name.name);
 	if (dir)
 		iput(&dir->vfs_inode);
@@ -1728,7 +1726,6 @@ static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_path *path)
  * will free the inode.
  */
 static noinline int fixup_inode_link_count(struct walk_control *wc,
-					   struct btrfs_path *path,
 					   struct btrfs_inode *inode)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
@@ -1737,13 +1734,13 @@ static noinline int fixup_inode_link_count(struct walk_control *wc,
 	u64 nlink = 0;
 	const u64 ino = btrfs_ino(inode);
 
-	ret = count_inode_refs(inode, path);
+	ret = count_inode_refs(inode, wc->subvol_path);
 	if (ret < 0)
 		goto out;
 
 	nlink = ret;
 
-	ret = count_inode_extrefs(inode, path);
+	ret = count_inode_extrefs(inode, wc->subvol_path);
 	if (ret < 0)
 		goto out;
 
@@ -1762,7 +1759,7 @@ static noinline int fixup_inode_link_count(struct walk_control *wc,
 
 	if (inode->vfs_inode.i_nlink == 0) {
 		if (S_ISDIR(inode->vfs_inode.i_mode)) {
-			ret = replay_dir_deletes(wc, path, ino, true);
+			ret = replay_dir_deletes(wc, ino, true);
 			if (ret)
 				goto out;
 		}
@@ -1772,12 +1769,11 @@ static noinline int fixup_inode_link_count(struct walk_control *wc,
 	}
 
 out:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	return ret;
 }
 
-static noinline int fixup_inode_link_counts(struct walk_control *wc,
-					    struct btrfs_path *path)
+static noinline int fixup_inode_link_counts(struct walk_control *wc)
 {
 	int ret;
 	struct btrfs_key key;
@@ -1790,34 +1786,34 @@ static noinline int fixup_inode_link_counts(struct walk_control *wc,
 		struct btrfs_root *root = wc->root;
 		struct btrfs_inode *inode;
 
-		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		ret = btrfs_search_slot(trans, root, &key, wc->subvol_path, -1, 1);
 		if (ret < 0)
 			break;
 
 		if (ret == 1) {
 			ret = 0;
-			if (path->slots[0] == 0)
+			if (wc->subvol_path->slots[0] == 0)
 				break;
-			path->slots[0]--;
+			wc->subvol_path->slots[0]--;
 		}
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		btrfs_item_key_to_cpu(wc->subvol_path->nodes[0], &key, wc->subvol_path->slots[0]);
 		if (key.objectid != BTRFS_TREE_LOG_FIXUP_OBJECTID ||
 		    key.type != BTRFS_ORPHAN_ITEM_KEY)
 			break;
 
-		ret = btrfs_del_item(trans, root, path);
+		ret = btrfs_del_item(trans, root, wc->subvol_path);
 		if (ret)
 			break;
 
-		btrfs_release_path(path);
+		btrfs_release_path(wc->subvol_path);
 		inode = btrfs_iget_logging(key.offset, root);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			break;
 		}
 
-		ret = fixup_inode_link_count(wc, path, inode);
+		ret = fixup_inode_link_count(wc, inode);
 		iput(&inode->vfs_inode);
 		if (ret)
 			break;
@@ -1829,7 +1825,7 @@ static noinline int fixup_inode_link_counts(struct walk_control *wc,
 		 */
 		key.offset = (u64)-1;
 	}
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	return ret;
 }
 
@@ -1839,9 +1835,7 @@ static noinline int fixup_inode_link_counts(struct walk_control *wc,
  * count when replay is done.  The link count is incremented here
  * so the inode won't go away until we check it
  */
-static noinline int link_to_fixup_dir(struct walk_control *wc,
-				      struct btrfs_path *path,
-				      u64 objectid)
+static noinline int link_to_fixup_dir(struct walk_control *wc, u64 objectid)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1862,9 +1856,9 @@ static noinline int link_to_fixup_dir(struct walk_control *wc,
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = objectid;
 
-	ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
+	ret = btrfs_insert_empty_item(trans, root, wc->subvol_path, &key, 0);
 
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	if (ret == 0) {
 		if (!vfs_inode->i_nlink)
 			set_nlink(vfs_inode, 1);
@@ -1917,7 +1911,6 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 
 static int delete_conflicting_dir_entry(struct walk_control *wc,
 					struct btrfs_inode *dir,
-					struct btrfs_path *path,
 					struct btrfs_dir_item *dst_di,
 					const struct btrfs_key *log_key,
 					u8 log_flags,
@@ -1925,12 +1918,12 @@ static int delete_conflicting_dir_entry(struct walk_control *wc,
 {
 	struct btrfs_key found_key;
 
-	btrfs_dir_item_key_to_cpu(path->nodes[0], dst_di, &found_key);
+	btrfs_dir_item_key_to_cpu(wc->subvol_path->nodes[0], dst_di, &found_key);
 	/* The existing dentry points to the same inode, don't delete it. */
 	if (found_key.objectid == log_key->objectid &&
 	    found_key.type == log_key->type &&
 	    found_key.offset == log_key->offset &&
-	    btrfs_dir_flags(path->nodes[0], dst_di) == log_flags)
+	    btrfs_dir_flags(wc->subvol_path->nodes[0], dst_di) == log_flags)
 		return 1;
 
 	/*
@@ -1940,7 +1933,7 @@ static int delete_conflicting_dir_entry(struct walk_control *wc,
 	if (!exists)
 		return 0;
 
-	return drop_one_dir_item(wc, path, dir, dst_di);
+	return drop_one_dir_item(wc, dir, dst_di);
 }
 
 /*
@@ -1959,9 +1952,7 @@ static int delete_conflicting_dir_entry(struct walk_control *wc,
  * Returns < 0 on error, 0 if the name wasn't replayed (dentry points to a
  * non-existing inode) and 1 if the name was replayed.
  */
-static noinline int replay_one_name(struct walk_control *wc,
-				    struct btrfs_path *path,
-				    struct btrfs_dir_item *di)
+static noinline int replay_one_name(struct walk_control *wc, struct btrfs_dir_item *di)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1995,8 +1986,8 @@ static noinline int replay_one_name(struct walk_control *wc,
 
 	log_flags = btrfs_dir_flags(wc->log_leaf, di);
 	btrfs_dir_item_key_to_cpu(wc->log_leaf, di, &log_key);
-	ret = btrfs_lookup_inode(trans, root, path, &log_key, 0);
-	btrfs_release_path(path);
+	ret = btrfs_lookup_inode(trans, root, wc->subvol_path, &log_key, 0);
+	btrfs_release_path(wc->subvol_path);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -2004,14 +1995,14 @@ static noinline int replay_one_name(struct walk_control *wc,
 	exists = (ret == 0);
 	ret = 0;
 
-	dir_dst_di = btrfs_lookup_dir_item(trans, root, path, wc->log_key.objectid,
-					   &name, 1);
+	dir_dst_di = btrfs_lookup_dir_item(trans, root, wc->subvol_path,
+					   wc->log_key.objectid, &name, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (dir_dst_di) {
-		ret = delete_conflicting_dir_entry(wc, dir, path, dir_dst_di,
+		ret = delete_conflicting_dir_entry(wc, dir, dir_dst_di,
 						   &log_key, log_flags, exists);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
@@ -2020,9 +2011,9 @@ static noinline int replay_one_name(struct walk_control *wc,
 		dir_dst_matches = (ret == 1);
 	}
 
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
-	index_dst_di = btrfs_lookup_dir_index_item(trans, root, path,
+	index_dst_di = btrfs_lookup_dir_index_item(trans, root, wc->subvol_path,
 						   wc->log_key.objectid,
 						   wc->log_key.offset, &name, 1);
 	if (IS_ERR(index_dst_di)) {
@@ -2030,7 +2021,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	} else if (index_dst_di) {
-		ret = delete_conflicting_dir_entry(wc, dir, path, index_dst_di,
+		ret = delete_conflicting_dir_entry(wc, dir, index_dst_di,
 						   &log_key, log_flags, exists);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
@@ -2039,7 +2030,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 		index_dst_matches = (ret == 1);
 	}
 
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 
 	if (dir_dst_matches && index_dst_matches) {
 		ret = 0;
@@ -2104,8 +2095,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 }
 
 /* Replay one dir item from a BTRFS_DIR_INDEX_KEY key. */
-static noinline int replay_one_dir_item(struct walk_control *wc,
-					struct btrfs_path *path)
+static noinline int replay_one_dir_item(struct walk_control *wc)
 {
 	int ret;
 	struct btrfs_dir_item *di;
@@ -2114,7 +2104,7 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 	ASSERT(wc->log_key.type == BTRFS_DIR_INDEX_KEY);
 
 	di = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_dir_item);
-	ret = replay_one_name(wc, path, di);
+	ret = replay_one_name(wc, di);
 	if (ret < 0)
 		return ret;
 
@@ -2148,7 +2138,7 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 		struct btrfs_key di_key;
 
 		btrfs_dir_item_key_to_cpu(wc->log_leaf, di, &di_key);
-		ret = link_to_fixup_dir(wc, path, di_key.objectid);
+		ret = link_to_fixup_dir(wc, di_key.objectid);
 	}
 
 	return ret;
@@ -2242,7 +2232,6 @@ static noinline int find_dir_range(struct btrfs_root *root,
  * to is unlinked
  */
 static noinline int check_item_in_log(struct walk_control *wc,
-				      struct btrfs_path *path,
 				      struct btrfs_path *log_path,
 				      struct btrfs_inode *dir,
 				      struct btrfs_key *dir_key,
@@ -2266,8 +2255,8 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	 */
 	ASSERT(dir_key->type == BTRFS_DIR_INDEX_KEY);
 
-	eb = path->nodes[0];
-	slot = path->slots[0];
+	eb = wc->subvol_path->nodes[0];
+	slot = wc->subvol_path->slots[0];
 	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
 	ret = read_alloc_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
 	if (ret) {
@@ -2293,7 +2282,7 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	}
 
 	btrfs_dir_item_key_to_cpu(eb, di, &location);
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	btrfs_release_path(log_path);
 	inode = btrfs_iget_logging(location.objectid, root);
 	if (IS_ERR(inode)) {
@@ -2303,7 +2292,7 @@ static noinline int check_item_in_log(struct walk_control *wc,
 		goto out;
 	}
 
-	ret = link_to_fixup_dir(wc, path, location.objectid);
+	ret = link_to_fixup_dir(wc, location.objectid);
 	if (ret)
 		goto out;
 
@@ -2315,7 +2304,7 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	 * (an index number), so we're done.
 	 */
 out:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	btrfs_release_path(log_path);
 	kfree(name.name);
 	if (inode)
@@ -2323,7 +2312,7 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	return ret;
 }
 
-static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path)
+static int replay_xattr_deletes(struct walk_control *wc)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -2331,7 +2320,6 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 	struct btrfs_key search_key;
 	struct btrfs_path *log_path;
 	const u64 ino = wc->log_key.objectid;
-	int i;
 	int nritems;
 	int ret;
 
@@ -2345,32 +2333,32 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 	search_key.type = BTRFS_XATTR_ITEM_KEY;
 	search_key.offset = 0;
 again:
-	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &search_key, wc->subvol_path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 process_leaf:
-	nritems = btrfs_header_nritems(path->nodes[0]);
-	for (i = path->slots[0]; i < nritems; i++) {
+	nritems = btrfs_header_nritems(wc->subvol_path->nodes[0]);
+	for (int i = wc->subvol_path->slots[0]; i < nritems; i++) {
 		struct btrfs_key key;
 		struct btrfs_dir_item *di;
 		struct btrfs_dir_item *log_di;
 		u32 total_size;
 		u32 cur;
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, i);
+		btrfs_item_key_to_cpu(wc->subvol_path->nodes[0], &key, i);
 		if (key.objectid != ino || key.type != BTRFS_XATTR_ITEM_KEY) {
 			ret = 0;
 			goto out;
 		}
 
-		di = btrfs_item_ptr(path->nodes[0], i, struct btrfs_dir_item);
-		total_size = btrfs_item_size(path->nodes[0], i);
+		di = btrfs_item_ptr(wc->subvol_path->nodes[0], i, struct btrfs_dir_item);
+		total_size = btrfs_item_size(wc->subvol_path->nodes[0], i);
 		cur = 0;
 		while (cur < total_size) {
-			u16 name_len = btrfs_dir_name_len(path->nodes[0], di);
-			u16 data_len = btrfs_dir_data_len(path->nodes[0], di);
+			u16 name_len = btrfs_dir_name_len(wc->subvol_path->nodes[0], di);
+			u16 data_len = btrfs_dir_data_len(wc->subvol_path->nodes[0], di);
 			u32 this_len = sizeof(*di) + name_len + data_len;
 			char *name;
 
@@ -2380,7 +2368,7 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
-			read_extent_buffer(path->nodes[0], name,
+			read_extent_buffer(wc->subvol_path->nodes[0], name,
 					   (unsigned long)(di + 1), name_len);
 
 			log_di = btrfs_lookup_xattr(NULL, log, log_path, ino,
@@ -2388,8 +2376,8 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 			btrfs_release_path(log_path);
 			if (!log_di) {
 				/* Doesn't exist in log tree, so delete it. */
-				btrfs_release_path(path);
-				di = btrfs_lookup_xattr(trans, root, path, ino,
+				btrfs_release_path(wc->subvol_path);
+				di = btrfs_lookup_xattr(trans, root, wc->subvol_path, ino,
 							name, name_len, -1);
 				kfree(name);
 				if (IS_ERR(di)) {
@@ -2399,12 +2387,12 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 				}
 				ASSERT(di);
 				ret = btrfs_delete_one_dir_name(trans, root,
-								path, di);
+								wc->subvol_path, di);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
 					goto out;
 				}
-				btrfs_release_path(path);
+				btrfs_release_path(wc->subvol_path);
 				search_key = key;
 				goto again;
 			}
@@ -2418,7 +2406,7 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 			di = (struct btrfs_dir_item *)((char *)di + this_len);
 		}
 	}
-	ret = btrfs_next_leaf(root, path);
+	ret = btrfs_next_leaf(root, wc->subvol_path);
 	if (ret > 0)
 		ret = 0;
 	else if (ret == 0)
@@ -2427,7 +2415,7 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
 		btrfs_abort_transaction(trans, ret);
 out:
 	btrfs_free_path(log_path);
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	return ret;
 }
 
@@ -2443,7 +2431,6 @@ static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path
  * directory.
  */
 static noinline int replay_dir_deletes(struct walk_control *wc,
-				       struct btrfs_path *path,
 				       u64 dirid, bool del_all)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
@@ -2486,7 +2473,7 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 		if (del_all)
 			range_end = (u64)-1;
 		else {
-			ret = find_dir_range(log, path, dirid,
+			ret = find_dir_range(log, wc->subvol_path, dirid,
 					     &range_start, &range_end);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
@@ -2499,16 +2486,16 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 		dir_key.offset = range_start;
 		while (1) {
 			int nritems;
-			ret = btrfs_search_slot(NULL, root, &dir_key, path,
-						0, 0);
+			ret = btrfs_search_slot(NULL, root, &dir_key,
+						wc->subvol_path, 0, 0);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
 			}
 
-			nritems = btrfs_header_nritems(path->nodes[0]);
-			if (path->slots[0] >= nritems) {
-				ret = btrfs_next_leaf(root, path);
+			nritems = btrfs_header_nritems(wc->subvol_path->nodes[0]);
+			if (wc->subvol_path->slots[0] >= nritems) {
+				ret = btrfs_next_leaf(root, wc->subvol_path);
 				if (ret == 1) {
 					break;
 				} else if (ret < 0) {
@@ -2516,8 +2503,8 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 					goto out;
 				}
 			}
-			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
-					      path->slots[0]);
+			btrfs_item_key_to_cpu(wc->subvol_path->nodes[0], &found_key,
+					      wc->subvol_path->slots[0]);
 			if (found_key.objectid != dirid ||
 			    found_key.type != dir_key.type) {
 				ret = 0;
@@ -2527,22 +2514,21 @@ static noinline int replay_dir_deletes(struct walk_control *wc,
 			if (found_key.offset > range_end)
 				break;
 
-			ret = check_item_in_log(wc, path, log_path, dir,
-						&found_key, del_all);
+			ret = check_item_in_log(wc, log_path, dir, &found_key, del_all);
 			if (ret)
 				goto out;
 			if (found_key.offset == (u64)-1)
 				break;
 			dir_key.offset = found_key.offset + 1;
 		}
-		btrfs_release_path(path);
+		btrfs_release_path(wc->subvol_path);
 		if (range_end == (u64)-1)
 			break;
 		range_start = range_end + 1;
 	}
 	ret = 0;
 out:
-	btrfs_release_path(path);
+	btrfs_release_path(wc->subvol_path);
 	btrfs_free_path(log_path);
 	iput(&dir->vfs_inode);
 	return ret;
@@ -2567,7 +2553,6 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		.transid = gen,
 		.level = level
 	};
-	struct btrfs_path *path;
 	struct btrfs_root *root = wc->root;
 	struct btrfs_trans_handle *trans = wc->trans;
 	int ret;
@@ -2581,8 +2566,9 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		return ret;
 	}
 
-	path = btrfs_alloc_path();
-	if (!path) {
+	ASSERT(wc->subvol_path == NULL);
+	wc->subvol_path = btrfs_alloc_path();
+	if (!wc->subvol_path) {
 		btrfs_abort_transaction(trans, -ENOMEM);
 		return -ENOMEM;
 	}
@@ -2630,16 +2616,16 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		    wc->stage == LOG_WALK_REPLAY_INODES) {
 			u32 mode;
 
-			ret = replay_xattr_deletes(wc, path);
+			ret = replay_xattr_deletes(wc);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
 			if (S_ISDIR(mode)) {
-				ret = replay_dir_deletes(wc, path, wc->log_key.objectid, false);
+				ret = replay_dir_deletes(wc, wc->log_key.objectid, false);
 				if (ret)
 					break;
 			}
-			ret = overwrite_item(wc, path);
+			ret = overwrite_item(wc);
 			if (ret)
 				break;
 
@@ -2667,7 +2653,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
-				drop_args.path = path;
+				drop_args.path = wc->subvol_path;
 				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
@@ -2684,7 +2670,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 					break;
 			}
 
-			ret = link_to_fixup_dir(wc, path, wc->log_key.objectid);
+			ret = link_to_fixup_dir(wc, wc->log_key.objectid);
 			if (ret)
 				break;
 		}
@@ -2694,7 +2680,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 		if (wc->log_key.type == BTRFS_DIR_INDEX_KEY &&
 		    wc->stage == LOG_WALK_REPLAY_DIR_INDEX) {
-			ret = replay_one_dir_item(wc, path);
+			ret = replay_one_dir_item(wc);
 			if (ret)
 				break;
 		}
@@ -2704,16 +2690,16 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 		/* these keys are simply copied */
 		if (wc->log_key.type == BTRFS_XATTR_ITEM_KEY) {
-			ret = overwrite_item(wc, path);
+			ret = overwrite_item(wc);
 			if (ret)
 				break;
 		} else if (wc->log_key.type == BTRFS_INODE_REF_KEY ||
 			   wc->log_key.type == BTRFS_INODE_EXTREF_KEY) {
-			ret = add_inode_ref(wc, path);
+			ret = add_inode_ref(wc);
 			if (ret)
 				break;
 		} else if (wc->log_key.type == BTRFS_EXTENT_DATA_KEY) {
-			ret = replay_one_extent(wc, path);
+			ret = replay_one_extent(wc);
 			if (ret)
 				break;
 		}
@@ -2724,7 +2710,8 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		 * older kernel with such keys, ignore them.
 		 */
 	}
-	btrfs_free_path(path);
+	btrfs_free_path(wc->subvol_path);
+	wc->subvol_path = NULL;
 	return ret;
 }
 
@@ -7515,7 +7502,9 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (wc.stage == LOG_WALK_REPLAY_ALL) {
 			struct btrfs_root *root = wc.root;
 
-			ret = fixup_inode_link_counts(&wc, path);
+			wc.subvol_path = path;
+			ret = fixup_inode_link_counts(&wc);
+			wc.subvol_path = NULL;
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto next;
-- 
2.47.2


