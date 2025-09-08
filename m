Return-Path: <linux-btrfs+bounces-16718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A1B4892B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5363AB860
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B812FB988;
	Mon,  8 Sep 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6POuJYX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6A2FB0A6
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325232; cv=none; b=unLm5/c2KDlEUpU4VV1sn1EUBJyWYiIVc5MMu71CpXeSqdSbGwp+IXo0z36/rLSer6ox2KAxo2dTUjg6N5fZf6+Y1RN7jfdjvtfikKZvTUGnDemWeO3d5IJC3fMjOIPPPMqr0xANlFys5tlwZg94+x6ZttC11fRmicSef/g0K40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325232; c=relaxed/simple;
	bh=j4dHRcqcc15619otE4ZXuu+Hlc4J6HVTgaoU8VyWLpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo0l66qX+BwZkKH7E+oCwFzKLi+z3fV2J6KmgHP4eowzXaN2XRtkoJRyH95zT4a0rWMZnbwEEFvqWOw7rTsX5au9C2CEXEaKsRQIpWVdV10KGD9uy0Yqceia0XCqPuhNiKqRBi921cfCir2bbqJFh4d3WTjAQ1RtojKNshj0mac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6POuJYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C9AC4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325231;
	bh=j4dHRcqcc15619otE4ZXuu+Hlc4J6HVTgaoU8VyWLpg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b6POuJYXfSqskdkb7/S+zaGcum1JaUNInIScDoankekjBXjGbfcc75nmWVYkD2H3c
	 ppjWreBZnBITRZiw17//pfYeifN+32S633sgX40xDT3eM5FipoxV8G6jKBExNFLDeu
	 PbKlDFi6XBtovoxVDs/9gKTqUjbM2AeV1PeF4qZzBQIxbVMwAMOOpCCLAhyHwIuR7M
	 SLc6QEa69trAL3aCggArSIyyh09Lng3BLPMKFrNcc9wLT4XRGvgQQ39SxaHC/K+ToH
	 vPbuYkxrmpdUEtLxNC35r42fRkzObToPbIIBOWQf4dbzBbXyivHQSWEFnxLvnB2KF0
	 Qx/Ck8AP6HL8A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 22/33] btrfs: add current log leaf, key and slot to struct walk_control
Date: Mon,  8 Sep 2025 10:53:16 +0100
Message-ID: <247e1013735943cecfe4942a4a163376552cc562.1757271913.git.fdmanana@suse.com>
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

A lot of the log replay functions get passed the current log leaf being
processed as well as the current slot and the key at that slot. Instead
of passing them as parameters, add them to struct walk_control so that
we reduce the numbers of parameters. This is also going to be needed to
further changes that improve error reporting during log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 255 ++++++++++++++++++++++----------------------
 1 file changed, 126 insertions(+), 129 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d830c33be7c6..b4e901da9e8b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -150,6 +150,18 @@ struct walk_control {
 	 */
 	int (*process_func)(struct extent_buffer *eb,
 			    struct walk_control *wc, u64 gen, int level);
+
+	/*
+	 * The following are used only when stage is >= LOG_WALK_REPLAY_INODES
+	 * and by the replay_one_buffer() callback.
+	 */
+
+	/* The current log leaf being processed. */
+	struct extent_buffer *log_leaf;
+	/* The key being processed of the current log leaf. */
+	struct btrfs_key log_key;
+	/* The slot being processed of the current log leaf. */
+	int log_slot;
 };
 
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
@@ -396,8 +408,9 @@ static int process_one_buffer(struct extent_buffer *eb,
 }
 
 /*
- * Item overwrite used by log replay. The given eb, slot and key all refer to
- * the source data we are copying out.
+ * Item overwrite used by log replay. The given log tree leaf, slot and key
+ * from the walk_control structure all refer to the source data we are copying
+ * out.
  *
  * The given root is for the tree we are copying into, and path is a scratch
  * path for use in this function (it should be released on entry and will be
@@ -409,10 +422,7 @@ static int process_one_buffer(struct extent_buffer *eb,
  *
  * If the key isn't in the destination yet, a new item is inserted.
  */
-static int overwrite_item(struct walk_control *wc,
-			  struct btrfs_path *path,
-			  struct extent_buffer *eb, int slot,
-			  struct btrfs_key *key)
+static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -424,7 +434,7 @@ static int overwrite_item(struct walk_control *wc,
 	unsigned long dst_ptr;
 	struct extent_buffer *dst_eb;
 	int dst_slot;
-	const bool is_inode_item = (key->type == BTRFS_INODE_ITEM_KEY);
+	const bool is_inode_item = (wc->log_key.type == BTRFS_INODE_ITEM_KEY);
 
 	/*
 	 * This is only used during log replay, so the root is always from a
@@ -435,11 +445,11 @@ static int overwrite_item(struct walk_control *wc,
 	 */
 	ASSERT(btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID);
 
-	item_size = btrfs_item_size(eb, slot);
-	src_ptr = btrfs_item_ptr_offset(eb, slot);
+	item_size = btrfs_item_size(wc->log_leaf, wc->log_slot);
+	src_ptr = btrfs_item_ptr_offset(wc->log_leaf, wc->log_slot);
 
 	/* Look for the key in the destination tree. */
-	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &wc->log_key, path, 0, 0);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		return ret;
@@ -466,7 +476,7 @@ static int overwrite_item(struct walk_control *wc,
 			return -ENOMEM;
 		}
 
-		read_extent_buffer(eb, src_copy, src_ptr, item_size);
+		read_extent_buffer(wc->log_leaf, src_copy, src_ptr, item_size);
 		dst_ptr = btrfs_item_ptr_offset(dst_eb, dst_slot);
 		ret = memcmp_extent_buffer(dst_eb, src_copy, dst_ptr, item_size);
 
@@ -494,18 +504,18 @@ static int overwrite_item(struct walk_control *wc,
 			item = btrfs_item_ptr(dst_eb, dst_slot,
 					      struct btrfs_inode_item);
 			nbytes = btrfs_inode_nbytes(dst_eb, item);
-			item = btrfs_item_ptr(eb, slot,
+			item = btrfs_item_ptr(wc->log_leaf, wc->log_slot,
 					      struct btrfs_inode_item);
-			btrfs_set_inode_nbytes(eb, item, nbytes);
+			btrfs_set_inode_nbytes(wc->log_leaf, item, nbytes);
 
 			/*
 			 * If this is a directory we need to reset the i_size to
 			 * 0 so that we can set it up properly when replaying
 			 * the rest of the items in this log.
 			 */
-			mode = btrfs_inode_mode(eb, item);
+			mode = btrfs_inode_mode(wc->log_leaf, item);
 			if (S_ISDIR(mode))
-				btrfs_set_inode_size(eb, item, 0);
+				btrfs_set_inode_size(wc->log_leaf, item, 0);
 		}
 	} else if (is_inode_item) {
 		struct btrfs_inode_item *item;
@@ -515,24 +525,23 @@ static int overwrite_item(struct walk_control *wc,
 		 * New inode, set nbytes to 0 so that the nbytes comes out
 		 * properly when we replay the extents.
 		 */
-		item = btrfs_item_ptr(eb, slot, struct btrfs_inode_item);
-		btrfs_set_inode_nbytes(eb, item, 0);
+		item = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_inode_item);
+		btrfs_set_inode_nbytes(wc->log_leaf, item, 0);
 
 		/*
 		 * If this is a directory we need to reset the i_size to 0 so
 		 * that we can set it up properly when replaying the rest of
 		 * the items in this log.
 		 */
-		mode = btrfs_inode_mode(eb, item);
+		mode = btrfs_inode_mode(wc->log_leaf, item);
 		if (S_ISDIR(mode))
-			btrfs_set_inode_size(eb, item, 0);
+			btrfs_set_inode_size(wc->log_leaf, item, 0);
 	}
 insert:
 	btrfs_release_path(path);
 	/* try to insert the key into the destination tree */
 	path->skip_release_on_error = 1;
-	ret = btrfs_insert_empty_item(trans, root, path,
-				      key, item_size);
+	ret = btrfs_insert_empty_item(trans, root, path, &wc->log_key, item_size);
 	path->skip_release_on_error = 0;
 
 	dst_eb = path->nodes[0];
@@ -568,8 +577,8 @@ static int overwrite_item(struct walk_control *wc,
 		src_item = (struct btrfs_inode_item *)src_ptr;
 		dst_item = (struct btrfs_inode_item *)dst_ptr;
 
-		if (btrfs_inode_generation(eb, src_item) == 0) {
-			const u64 ino_size = btrfs_inode_size(eb, src_item);
+		if (btrfs_inode_generation(wc->log_leaf, src_item) == 0) {
+			const u64 ino_size = btrfs_inode_size(wc->log_leaf, src_item);
 
 			/*
 			 * For regular files an ino_size == 0 is used only when
@@ -578,21 +587,21 @@ static int overwrite_item(struct walk_control *wc,
 			 * case don't set the size of the inode in the fs/subvol
 			 * tree, otherwise we would be throwing valid data away.
 			 */
-			if (S_ISREG(btrfs_inode_mode(eb, src_item)) &&
+			if (S_ISREG(btrfs_inode_mode(wc->log_leaf, src_item)) &&
 			    S_ISREG(btrfs_inode_mode(dst_eb, dst_item)) &&
 			    ino_size != 0)
 				btrfs_set_inode_size(dst_eb, dst_item, ino_size);
 			goto no_copy;
 		}
 
-		if (S_ISDIR(btrfs_inode_mode(eb, src_item)) &&
+		if (S_ISDIR(btrfs_inode_mode(wc->log_leaf, src_item)) &&
 		    S_ISDIR(btrfs_inode_mode(dst_eb, dst_item))) {
 			save_old_i_size = 1;
 			saved_i_size = btrfs_inode_size(dst_eb, dst_item);
 		}
 	}
 
-	copy_extent_buffer(dst_eb, eb, dst_ptr, src_ptr, item_size);
+	copy_extent_buffer(dst_eb, wc->log_leaf, dst_ptr, src_ptr, item_size);
 
 	if (save_old_i_size) {
 		struct btrfs_inode_item *dst_item;
@@ -641,10 +650,7 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
  * The extent is inserted into the file, dropping any existing extents
  * from the file that overlap the new one.
  */
-static noinline int replay_one_extent(struct walk_control *wc,
-				      struct btrfs_path *path,
-				      struct extent_buffer *eb, int slot,
-				      struct btrfs_key *key)
+static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path *path)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -652,7 +658,7 @@ static noinline int replay_one_extent(struct walk_control *wc,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int found_type;
 	u64 extent_end;
-	u64 start = key->offset;
+	const u64 start = wc->log_key.offset;
 	u64 nbytes = 0;
 	u64 csum_start;
 	u64 csum_end;
@@ -665,34 +671,35 @@ static noinline int replay_one_extent(struct walk_control *wc,
 	unsigned long size;
 	int ret = 0;
 
-	item = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
-	found_type = btrfs_file_extent_type(eb, item);
+	item = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_file_extent_item);
+	found_type = btrfs_file_extent_type(wc->log_leaf, item);
 
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
-		nbytes = btrfs_file_extent_num_bytes(eb, item);
+		nbytes = btrfs_file_extent_num_bytes(wc->log_leaf, item);
 		extent_end = start + nbytes;
 
 		/*
 		 * We don't add to the inodes nbytes if we are prealloc or a
 		 * hole.
 		 */
-		if (btrfs_file_extent_disk_bytenr(eb, item) == 0)
+		if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0)
 			nbytes = 0;
 	} else if (found_type == BTRFS_FILE_EXTENT_INLINE) {
-		size = btrfs_file_extent_ram_bytes(eb, item);
-		nbytes = btrfs_file_extent_ram_bytes(eb, item);
+		size = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
+		nbytes = btrfs_file_extent_ram_bytes(wc->log_leaf, item);
 		extent_end = ALIGN(start + size,
 				   fs_info->sectorsize);
 	} else {
 		btrfs_abort_transaction(trans, -EUCLEAN);
 		btrfs_err(fs_info,
 		  "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
-			  found_type, btrfs_root_id(root), key->objectid, key->offset);
+			  found_type, btrfs_root_id(root), wc->log_key.objectid,
+			  wc->log_key.offset);
 		return -EUCLEAN;
 	}
 
-	inode = btrfs_iget_logging(key->objectid, root);
+	inode = btrfs_iget_logging(wc->log_key.objectid, root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		btrfs_abort_transaction(trans, ret);
@@ -719,7 +726,7 @@ static noinline int replay_one_extent(struct walk_control *wc,
 		 * we already have a pointer to this exact extent,
 		 * we don't have to do anything
 		 */
-		if (memcmp_extent_buffer(eb, &existing, (unsigned long)item,
+		if (memcmp_extent_buffer(wc->log_leaf, &existing, (unsigned long)item,
 					 sizeof(existing)) == 0) {
 			btrfs_release_path(path);
 			goto out;
@@ -739,7 +746,7 @@ static noinline int replay_one_extent(struct walk_control *wc,
 
 	if (found_type == BTRFS_FILE_EXTENT_INLINE) {
 		/* inline extents are easy, we just overwrite them */
-		ret = overwrite_item(wc, path, eb, slot, key);
+		ret = overwrite_item(wc, path);
 		if (ret)
 			goto out;
 		goto update_inode;
@@ -751,18 +758,18 @@ static noinline int replay_one_extent(struct walk_control *wc,
 	 */
 
 	/* A hole and NO_HOLES feature enabled, nothing else to do. */
-	if (btrfs_file_extent_disk_bytenr(eb, item) == 0 &&
+	if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0 &&
 	    btrfs_fs_incompat(fs_info, NO_HOLES))
 		goto update_inode;
 
-	ret = btrfs_insert_empty_item(trans, root, path, key, sizeof(*item));
+	ret = btrfs_insert_empty_item(trans, root, path, &wc->log_key, sizeof(*item));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	dest_offset = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-	copy_extent_buffer(path->nodes[0], eb, dest_offset, (unsigned long)item,
-			   sizeof(*item));
+	copy_extent_buffer(path->nodes[0], wc->log_leaf, dest_offset,
+			   (unsigned long)item, sizeof(*item));
 
 	/*
 	 * We have an explicit hole and NO_HOLES is not enabled. We have added
@@ -770,15 +777,15 @@ static noinline int replay_one_extent(struct walk_control *wc,
 	 * anything else to do other than update the file extent item range and
 	 * update the inode item.
 	 */
-	if (btrfs_file_extent_disk_bytenr(eb, item) == 0) {
+	if (btrfs_file_extent_disk_bytenr(wc->log_leaf, item) == 0) {
 		btrfs_release_path(path);
 		goto update_inode;
 	}
 
-	ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
+	ins.objectid = btrfs_file_extent_disk_bytenr(wc->log_leaf, item);
 	ins.type = BTRFS_EXTENT_ITEM_KEY;
-	ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
-	offset = key->offset - btrfs_file_extent_offset(eb, item);
+	ins.offset = btrfs_file_extent_disk_num_bytes(wc->log_leaf, item);
+	offset = wc->log_key.offset - btrfs_file_extent_offset(wc->log_leaf, item);
 
 	/*
 	 * Manually record dirty extent, as here we did a shallow file extent
@@ -810,7 +817,7 @@ static noinline int replay_one_extent(struct walk_control *wc,
 			.ref_root = btrfs_root_id(root),
 		};
 
-		btrfs_init_data_ref(&ref, key->objectid, offset, 0, false);
+		btrfs_init_data_ref(&ref, wc->log_key.objectid, offset, 0, false);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -819,7 +826,7 @@ static noinline int replay_one_extent(struct walk_control *wc,
 	} else {
 		/* Insert the extent pointer in the extent tree. */
 		ret = btrfs_alloc_logged_file_extent(trans, btrfs_root_id(root),
-						     key->objectid, offset, &ins);
+						     wc->log_key.objectid, offset, &ins);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -828,12 +835,12 @@ static noinline int replay_one_extent(struct walk_control *wc,
 
 	btrfs_release_path(path);
 
-	if (btrfs_file_extent_compression(eb, item)) {
+	if (btrfs_file_extent_compression(wc->log_leaf, item)) {
 		csum_start = ins.objectid;
 		csum_end = csum_start + ins.offset;
 	} else {
-		csum_start = ins.objectid + btrfs_file_extent_offset(eb, item);
-		csum_end = csum_start + btrfs_file_extent_num_bytes(eb, item);
+		csum_start = ins.objectid + btrfs_file_extent_offset(wc->log_leaf, item);
+		csum_end = csum_start + btrfs_file_extent_num_bytes(wc->log_leaf, item);
 	}
 
 	ret = btrfs_lookup_csums_list(root->log_root, csum_start, csum_end - 1,
@@ -1352,10 +1359,7 @@ static int ref_get_fields(struct extent_buffer *eb, unsigned long ref_ptr,
  */
 static int unlink_old_inode_refs(struct walk_control *wc,
 				 struct btrfs_path *path,
-				 struct btrfs_inode *inode,
-				 struct extent_buffer *log_eb,
-				 int log_slot,
-				 struct btrfs_key *key)
+				 struct btrfs_inode *inode)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1366,7 +1370,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 
 again:
 	btrfs_release_path(path);
-	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &wc->log_key, path, 0, 0);
 	if (ret > 0) {
 		ret = 0;
 		goto out;
@@ -1383,7 +1387,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 		struct fscrypt_str name;
 		u64 parent_id;
 
-		if (key->type == BTRFS_INODE_EXTREF_KEY) {
+		if (wc->log_key.type == BTRFS_INODE_EXTREF_KEY) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						NULL, &parent_id);
 			if (ret) {
@@ -1391,7 +1395,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 				goto out;
 			}
 		} else {
-			parent_id = key->offset;
+			parent_id = wc->log_key.offset;
 			ret = ref_get_fields(eb, ref_ptr, &name, NULL);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
@@ -1399,11 +1403,12 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 			}
 		}
 
-		if (key->type == BTRFS_INODE_EXTREF_KEY)
-			ret = !!btrfs_find_name_in_ext_backref(log_eb, log_slot,
+		if (wc->log_key.type == BTRFS_INODE_EXTREF_KEY)
+			ret = !!btrfs_find_name_in_ext_backref(wc->log_leaf, wc->log_slot,
 							       parent_id, &name);
 		else
-			ret = !!btrfs_find_name_in_backref(log_eb, log_slot, &name);
+			ret = !!btrfs_find_name_in_backref(wc->log_leaf, wc->log_slot,
+							   &name);
 
 		if (!ret) {
 			struct btrfs_inode *dir;
@@ -1426,7 +1431,7 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 
 		kfree(name.name);
 		ref_ptr += name.len;
-		if (key->type == BTRFS_INODE_EXTREF_KEY)
+		if (wc->log_key.type == BTRFS_INODE_EXTREF_KEY)
 			ref_ptr += sizeof(struct btrfs_inode_extref);
 		else
 			ref_ptr += sizeof(struct btrfs_inode_ref);
@@ -1438,15 +1443,10 @@ static int unlink_old_inode_refs(struct walk_control *wc,
 }
 
 /*
- * replay one inode back reference item found in the log tree.
- * eb, slot and key refer to the buffer and key found in the log tree.
- * root is the destination we are replaying into, and path is for temp
- * use by this function.  (it should be released on return).
+ * Replay one inode back reference item found in the log tree.
+ * Path is for temporary use by this function (it should be released on return).
  */
-static noinline int add_inode_ref(struct walk_control *wc,
-				  struct btrfs_path *path,
-				  struct extent_buffer *eb, int slot,
-				  struct btrfs_key *key)
+static noinline int add_inode_ref(struct walk_control *wc, struct btrfs_path *path)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1456,26 +1456,26 @@ static noinline int add_inode_ref(struct walk_control *wc,
 	unsigned long ref_end;
 	struct fscrypt_str name = { 0 };
 	int ret;
-	const bool is_extref_item = (key->type == BTRFS_INODE_EXTREF_KEY);
+	const bool is_extref_item = (wc->log_key.type == BTRFS_INODE_EXTREF_KEY);
 	u64 parent_objectid;
 	u64 inode_objectid;
 	u64 ref_index = 0;
 	int ref_struct_size;
 
-	ref_ptr = btrfs_item_ptr_offset(eb, slot);
-	ref_end = ref_ptr + btrfs_item_size(eb, slot);
+	ref_ptr = btrfs_item_ptr_offset(wc->log_leaf, wc->log_slot);
+	ref_end = ref_ptr + btrfs_item_size(wc->log_leaf, wc->log_slot);
 
 	if (is_extref_item) {
 		struct btrfs_inode_extref *r;
 
 		ref_struct_size = sizeof(struct btrfs_inode_extref);
 		r = (struct btrfs_inode_extref *)ref_ptr;
-		parent_objectid = btrfs_inode_extref_parent(eb, r);
+		parent_objectid = btrfs_inode_extref_parent(wc->log_leaf, r);
 	} else {
 		ref_struct_size = sizeof(struct btrfs_inode_ref);
-		parent_objectid = key->offset;
+		parent_objectid = wc->log_key.offset;
 	}
-	inode_objectid = key->objectid;
+	inode_objectid = wc->log_key.objectid;
 
 	/*
 	 * it is possible that we didn't log all the parent directories
@@ -1504,7 +1504,7 @@ static noinline int add_inode_ref(struct walk_control *wc,
 
 	while (ref_ptr < ref_end) {
 		if (is_extref_item) {
-			ret = extref_get_fields(eb, ref_ptr, &name,
+			ret = extref_get_fields(wc->log_leaf, ref_ptr, &name,
 						&ref_index, &parent_objectid);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
@@ -1541,7 +1541,7 @@ static noinline int add_inode_ref(struct walk_control *wc,
 				}
 			}
 		} else {
-			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
+			ret = ref_get_fields(wc->log_leaf, ref_ptr, &name, &ref_index);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto out;
@@ -1602,12 +1602,12 @@ static noinline int add_inode_ref(struct walk_control *wc,
 	 * dir index entries exist for a name but there is no inode reference
 	 * item with the same name.
 	 */
-	ret = unlink_old_inode_refs(wc, path, inode, eb, slot, key);
+	ret = unlink_old_inode_refs(wc, path, inode);
 	if (ret)
 		goto out;
 
 	/* finally write the back reference in the inode */
-	ret = overwrite_item(wc, path, eb, slot, key);
+	ret = overwrite_item(wc, path);
 out:
 	btrfs_release_path(path);
 	kfree(name.name);
@@ -1965,9 +1965,7 @@ static int delete_conflicting_dir_entry(struct walk_control *wc,
  */
 static noinline int replay_one_name(struct walk_control *wc,
 				    struct btrfs_path *path,
-				    struct extent_buffer *eb,
-				    struct btrfs_dir_item *di,
-				    struct btrfs_key *key)
+				    struct btrfs_dir_item *di)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
@@ -1985,21 +1983,22 @@ static noinline int replay_one_name(struct walk_control *wc,
 	bool update_size = true;
 	bool name_added = false;
 
-	dir = btrfs_iget_logging(key->objectid, root);
+	dir = btrfs_iget_logging(wc->log_key.objectid, root);
 	if (IS_ERR(dir)) {
 		ret = PTR_ERR(dir);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	ret = read_alloc_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
+	ret = read_alloc_one_name(wc->log_leaf, di + 1,
+				  btrfs_dir_name_len(wc->log_leaf, di), &name);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	log_flags = btrfs_dir_flags(eb, di);
-	btrfs_dir_item_key_to_cpu(eb, di, &log_key);
+	log_flags = btrfs_dir_flags(wc->log_leaf, di);
+	btrfs_dir_item_key_to_cpu(wc->log_leaf, di, &log_key);
 	ret = btrfs_lookup_inode(trans, root, path, &log_key, 0);
 	btrfs_release_path(path);
 	if (ret < 0) {
@@ -2009,7 +2008,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 	exists = (ret == 0);
 	ret = 0;
 
-	dir_dst_di = btrfs_lookup_dir_item(trans, root, path, key->objectid,
+	dir_dst_di = btrfs_lookup_dir_item(trans, root, path, wc->log_key.objectid,
 					   &name, 1);
 	if (IS_ERR(dir_dst_di)) {
 		ret = PTR_ERR(dir_dst_di);
@@ -2028,8 +2027,8 @@ static noinline int replay_one_name(struct walk_control *wc,
 	btrfs_release_path(path);
 
 	index_dst_di = btrfs_lookup_dir_index_item(trans, root, path,
-						   key->objectid, key->offset,
-						   &name, 1);
+						   wc->log_key.objectid,
+						   wc->log_key.offset, &name, 1);
 	if (IS_ERR(index_dst_di)) {
 		ret = PTR_ERR(index_dst_di);
 		btrfs_abort_transaction(trans, ret);
@@ -2058,7 +2057,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 	 */
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_REF_KEY;
-	search_key.offset = key->objectid;
+	search_key.offset = wc->log_key.objectid;
 	ret = backref_in_log(root->log_root, &search_key, 0, &name);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
@@ -2072,8 +2071,8 @@ static noinline int replay_one_name(struct walk_control *wc,
 
 	search_key.objectid = log_key.objectid;
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
-	search_key.offset = btrfs_extref_hash(key->objectid, name.name, name.len);
-	ret = backref_in_log(root->log_root, &search_key, key->objectid, &name);
+	search_key.offset = btrfs_extref_hash(wc->log_key.objectid, name.name, name.len);
+	ret = backref_in_log(root->log_root, &search_key, wc->log_key.objectid, &name);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -2084,7 +2083,7 @@ static noinline int replay_one_name(struct walk_control *wc,
 		goto out;
 	}
 	btrfs_release_path(path);
-	ret = insert_one_name(trans, root, key->objectid, key->offset,
+	ret = insert_one_name(trans, root, wc->log_key.objectid, wc->log_key.offset,
 			      &name, &log_key);
 	if (ret && ret != -ENOENT && ret != -EEXIST) {
 		btrfs_abort_transaction(trans, ret);
@@ -2111,18 +2110,16 @@ static noinline int replay_one_name(struct walk_control *wc,
 
 /* Replay one dir item from a BTRFS_DIR_INDEX_KEY key. */
 static noinline int replay_one_dir_item(struct walk_control *wc,
-					struct btrfs_path *path,
-					struct extent_buffer *eb, int slot,
-					struct btrfs_key *key)
+					struct btrfs_path *path)
 {
 	int ret;
 	struct btrfs_dir_item *di;
 
 	/* We only log dir index keys, which only contain a single dir item. */
-	ASSERT(key->type == BTRFS_DIR_INDEX_KEY);
+	ASSERT(wc->log_key.type == BTRFS_DIR_INDEX_KEY);
 
-	di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
-	ret = replay_one_name(wc, path, eb, di, key);
+	di = btrfs_item_ptr(wc->log_leaf, wc->log_slot, struct btrfs_dir_item);
+	ret = replay_one_name(wc, path, di);
 	if (ret < 0)
 		return ret;
 
@@ -2152,7 +2149,7 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 	 * to ever delete the parent directory has it would result in stale
 	 * dentries that can never be deleted.
 	 */
-	if (ret == 1 && btrfs_dir_ftype(eb, di) != BTRFS_FT_DIR) {
+	if (ret == 1 && btrfs_dir_ftype(wc->log_leaf, di) != BTRFS_FT_DIR) {
 		struct btrfs_path *fixup_path;
 		struct btrfs_key di_key;
 
@@ -2162,7 +2159,7 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 			return -ENOMEM;
 		}
 
-		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
+		btrfs_dir_item_key_to_cpu(wc->log_leaf, di, &di_key);
 		ret = link_to_fixup_dir(wc, fixup_path, di_key.objectid);
 		btrfs_free_path(fixup_path);
 	}
@@ -2339,15 +2336,14 @@ static noinline int check_item_in_log(struct walk_control *wc,
 	return ret;
 }
 
-static int replay_xattr_deletes(struct walk_control *wc,
-				struct btrfs_path *path,
-				const u64 ino)
+static int replay_xattr_deletes(struct walk_control *wc, struct btrfs_path *path)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = wc->root;
 	struct btrfs_root *log = wc->log;
 	struct btrfs_key search_key;
 	struct btrfs_path *log_path;
+	const u64 ino = wc->log_key.objectid;
 	int i;
 	int nritems;
 	int ret;
@@ -2587,8 +2583,6 @@ static int replay_one_buffer(struct extent_buffer *eb,
 	struct btrfs_path *path;
 	struct btrfs_root *root = wc->root;
 	struct btrfs_trans_handle *trans = wc->trans;
-	struct btrfs_key key;
-	int i;
 	int ret;
 
 	if (level != 0)
@@ -2606,14 +2600,17 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		return -ENOMEM;
 	}
 
+	wc->log_leaf = eb;
+
 	nritems = btrfs_header_nritems(eb);
-	for (i = 0; i < nritems; i++) {
+	for (wc->log_slot = 0; wc->log_slot < nritems; wc->log_slot++) {
 		struct btrfs_inode_item *inode_item;
 
-		btrfs_item_key_to_cpu(eb, &key, i);
+		btrfs_item_key_to_cpu(eb, &wc->log_key, wc->log_slot);
 
-		if (key.type == BTRFS_INODE_ITEM_KEY) {
-			inode_item = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
+		if (wc->log_key.type == BTRFS_INODE_ITEM_KEY) {
+			inode_item = btrfs_item_ptr(eb, wc->log_slot,
+						    struct btrfs_inode_item);
 			/*
 			 * An inode with no links is either:
 			 *
@@ -2642,20 +2639,20 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		}
 
 		/* Inode keys are done during the first stage. */
-		if (key.type == BTRFS_INODE_ITEM_KEY &&
+		if (wc->log_key.type == BTRFS_INODE_ITEM_KEY &&
 		    wc->stage == LOG_WALK_REPLAY_INODES) {
 			u32 mode;
 
-			ret = replay_xattr_deletes(wc, path, key.objectid);
+			ret = replay_xattr_deletes(wc, path);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
 			if (S_ISDIR(mode)) {
-				ret = replay_dir_deletes(wc, path, key.objectid, false);
+				ret = replay_dir_deletes(wc, path, wc->log_key.objectid, false);
 				if (ret)
 					break;
 			}
-			ret = overwrite_item(wc, path, eb, i, &key);
+			ret = overwrite_item(wc, path);
 			if (ret)
 				break;
 
@@ -2672,7 +2669,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				struct btrfs_inode *inode;
 				u64 from;
 
-				inode = btrfs_iget_logging(key.objectid, root);
+				inode = btrfs_iget_logging(wc->log_key.objectid, root);
 				if (IS_ERR(inode)) {
 					ret = PTR_ERR(inode);
 					btrfs_abort_transaction(trans, ret);
@@ -2699,7 +2696,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 					break;
 			}
 
-			ret = link_to_fixup_dir(wc, path, key.objectid);
+			ret = link_to_fixup_dir(wc, path, wc->log_key.objectid);
 			if (ret)
 				break;
 		}
@@ -2707,9 +2704,9 @@ static int replay_one_buffer(struct extent_buffer *eb,
 		if (wc->ignore_cur_inode)
 			continue;
 
-		if (key.type == BTRFS_DIR_INDEX_KEY &&
+		if (wc->log_key.type == BTRFS_DIR_INDEX_KEY &&
 		    wc->stage == LOG_WALK_REPLAY_DIR_INDEX) {
-			ret = replay_one_dir_item(wc, path, eb, i, &key);
+			ret = replay_one_dir_item(wc, path);
 			if (ret)
 				break;
 		}
@@ -2718,17 +2715,17 @@ static int replay_one_buffer(struct extent_buffer *eb,
 			continue;
 
 		/* these keys are simply copied */
-		if (key.type == BTRFS_XATTR_ITEM_KEY) {
-			ret = overwrite_item(wc, path, eb, i, &key);
+		if (wc->log_key.type == BTRFS_XATTR_ITEM_KEY) {
+			ret = overwrite_item(wc, path);
 			if (ret)
 				break;
-		} else if (key.type == BTRFS_INODE_REF_KEY ||
-			   key.type == BTRFS_INODE_EXTREF_KEY) {
-			ret = add_inode_ref(wc, path, eb, i, &key);
+		} else if (wc->log_key.type == BTRFS_INODE_REF_KEY ||
+			   wc->log_key.type == BTRFS_INODE_EXTREF_KEY) {
+			ret = add_inode_ref(wc, path);
 			if (ret)
 				break;
-		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
-			ret = replay_one_extent(wc, path, eb, i, &key);
+		} else if (wc->log_key.type == BTRFS_EXTENT_DATA_KEY) {
+			ret = replay_one_extent(wc, path);
 			if (ret)
 				break;
 		}
-- 
2.47.2


