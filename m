Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD32A62E5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 12:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgKDLHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 06:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgKDLHl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 06:07:41 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95656221F9
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604488059;
        bh=UTYTYooVSWzUSpz+vZuuJY7jxH6vFpRH7a/067S6AGM=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dThwpEI0k6UWQ9IdVSc5Kdfw4/9TZZce8XR0tqyPSov53zK2i+lGCwX22ElR1JX8R
         HAvKYyEyqwySVPO8utuHng9nDYPhGgNGHFp0y/NpYOCiCPKT9YDRqcEx5TNEWB9bVf
         JYE3335j78oRnQtT7IlYY4Xo6CnaBEa9rNvO+wfg=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: refactor btrfs_drop_extents() to make it easier to extend
Date:   Wed,  4 Nov 2020 11:07:32 +0000
Message-Id: <e18124431f5c0617dd0c2fcd16e2b439b32193cb.1604486892.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
References: <cover.1604486892.git.fdmanana@suse.com>
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
References: <cover.1604486892.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are many arguments for __btrfs_drop_extents() and its wrapper
btrfs_drop_extents(), which makes it hard to add more arguments to it and
requires changing every caller. I have added a couple myself back in 2014
commit 1acae57b161e ("Btrfs: faster file extent item replace operations")
and therefore know firsthand that it is a bit cumbersome to add additional
arguments to these functions.

Since I will need to add more arguments in a subsequent bug fix, this
change is preparatory work and adds a data structure that holds all the
arguments, for both input and output, that are passed to this function,
with some comments in the structure's definition mentioning what each
field is and how it relates to other fields.

Callers of this function need only to zero out the content of the
structure and setup only the fields they need. This also removes the
need to have both __btrfs_drop_extents() and btrfs_drop_extents(), so
now we have a single function named btrfs_drop_extents() that takes a
pointer to this new data structure (struct btrfs_drop_extents_args).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h    |  63 +++++++++++++++---
 fs/btrfs/file.c     | 155 +++++++++++++++++++++++---------------------
 fs/btrfs/inode.c    |  41 +++++++-----
 fs/btrfs/reflink.c  |   7 +-
 fs/btrfs/tree-log.c |  28 +++++---
 5 files changed, 187 insertions(+), 107 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b46eecf882a1..c3b2e7f2d772 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1229,6 +1229,58 @@ struct btrfs_replace_extent_info {
 	int insertions;
 };
 
+/* Arguments for btrfs_drop_extents(). */
+struct btrfs_drop_extents_args {
+	/* Input parameters */
+
+	/*
+	 * If NULL, btrfs_drop_extents() will allocate and free its own path.
+	 * If 'replace_extent' is true, this must not be NULL. Also the path
+	 * is always released except if 'replace_extent' is true and
+	 * btrfs_drop_extents() sets 'extent_inserted' to true, in which case
+	 * the path is kept locked.
+	 */
+	struct btrfs_path *path;
+	/* Start offset of the range to drop extents from. */
+	u64 start;
+	/* End (exclusive, last byte + 1) of the range to drop extents from. */
+	u64 end;
+	/* If true drop all the extent maps in the range. */
+	bool drop_cache;
+	/*
+	 * If true it means we want to insert a new extent after dropping all
+	 * the extents in the range. If this is true, the 'extent_item_size'
+	 * parameter must be set as well and the 'extent_inserted' field will
+	 * be set to true by btrfs_drop_extents() if it could insert the new
+	 * extent.
+	 * Note: when this is set to true the path must not be NULL.
+	 */
+	bool replace_extent;
+	/*
+	 * Used if 'replace_extent' is true. Size of the file extent item to
+	 * insert after dropping all existing extents in the range.
+	 */
+	u32 extent_item_size;
+
+	/* Output parameters */
+
+	/*
+	 * Set to the minimum between the input parameter 'end' and the end
+	 * (exclusive, last byte + 1) of the last dropped extent. This is always
+	 * set even if btrfs_drop_extents() returns an error.
+	 */
+	u64 drop_end;
+	/*
+	 * Only set if 'replace_extent' is true. Set to true if we were able
+	 * to insert a replacement extent after dropping all extents in the
+	 * range, otherwise set to false by btrfs_drop_extents().
+	 * Also, if btrfs_drop_extents() has set this to true it means it
+	 * returned with the path locked, otherwise if it has set this to
+	 * false it has returned with the path released.
+	 */
+	bool extent_inserted;
+};
+
 struct btrfs_file_private {
 	void *filldir_buf;
 };
@@ -3116,16 +3168,9 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			     int skip_pinned);
 extern const struct file_operations btrfs_file_operations;
-int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root, struct btrfs_inode *inode,
-			 struct btrfs_path *path, u64 start, u64 end,
-			 u64 *drop_end, int drop_cache,
-			 int replace_extent,
-			 u32 extent_item_size,
-			 int *key_inserted);
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct inode *inode, u64 start,
-		       u64 end, int drop_cache);
+		       struct btrfs_root *root, struct btrfs_inode *inode,
+		       struct btrfs_drop_extents_args *args);
 int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			   const u64 start, const u64 end,
 			   struct btrfs_replace_extent_info *extent_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 56c1fe3988bd..68b96c6c9c4b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -678,13 +678,9 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
  * it is either truncated or split.  Anything entirely inside the range
  * is deleted from the tree.
  */
-int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root, struct btrfs_inode *inode,
-			 struct btrfs_path *path, u64 start, u64 end,
-			 u64 *drop_end, int drop_cache,
-			 int replace_extent,
-			 u32 extent_item_size,
-			 int *key_inserted)
+int btrfs_drop_extents(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct btrfs_inode *inode,
+		       struct btrfs_drop_extents_args *args)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
@@ -694,12 +690,12 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_key new_key;
 	struct inode *vfs_inode = &inode->vfs_inode;
 	u64 ino = btrfs_ino(inode);
-	u64 search_start = start;
+	u64 search_start = args->start;
 	u64 disk_bytenr = 0;
 	u64 num_bytes = 0;
 	u64 extent_offset = 0;
 	u64 extent_end = 0;
-	u64 last_end = start;
+	u64 last_end = args->start;
 	int del_nr = 0;
 	int del_slot = 0;
 	int extent_type;
@@ -709,11 +705,25 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	int update_refs;
 	int found = 0;
 	int leafs_visited = 0;
+	struct btrfs_path *path = args->path;
+
+	args->extent_inserted = false;
+
+	/* Must always have a path if ->replace_extent is true. */
+	ASSERT(!(args->replace_extent && !args->path));
+
+	if (!path) {
+		path = btrfs_alloc_path();
+		if (!path) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
 
-	if (drop_cache)
-		btrfs_drop_extent_cache(inode, start, end - 1, 0);
+	if (args->drop_cache)
+		btrfs_drop_extent_cache(inode, args->start, args->end - 1, 0);
 
-	if (start >= inode->disk_i_size && !replace_extent)
+	if (args->start >= inode->disk_i_size && !args->replace_extent)
 		modify_tree = 0;
 
 	update_refs = (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
@@ -724,7 +734,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 					       search_start, modify_tree);
 		if (ret < 0)
 			break;
-		if (ret > 0 && path->slots[0] > 0 && search_start == start) {
+		if (ret > 0 && path->slots[0] > 0 && search_start == args->start) {
 			leaf = path->nodes[0];
 			btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
 			if (key.objectid == ino &&
@@ -759,7 +769,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			path->slots[0]++;
 			goto next_slot;
 		}
-		if (key.type > BTRFS_EXTENT_DATA_KEY || key.offset >= end)
+		if (key.type > BTRFS_EXTENT_DATA_KEY || key.offset >= args->end)
 			break;
 
 		fi = btrfs_item_ptr(leaf, path->slots[0],
@@ -801,7 +811,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		}
 
 		found = 1;
-		search_start = max(key.offset, start);
+		search_start = max(key.offset, args->start);
 		if (recow || !modify_tree) {
 			modify_tree = -1;
 			btrfs_release_path(path);
@@ -812,7 +822,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *     | - range to drop - |
 		 *  | -------- extent -------- |
 		 */
-		if (start > key.offset && end < extent_end) {
+		if (args->start > key.offset && args->end < extent_end) {
 			BUG_ON(del_nr > 0);
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
@@ -820,7 +830,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			}
 
 			memcpy(&new_key, &key, sizeof(new_key));
-			new_key.offset = start;
+			new_key.offset = args->start;
 			ret = btrfs_duplicate_item(trans, root, path,
 						   &new_key);
 			if (ret == -EAGAIN) {
@@ -834,15 +844,15 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			fi = btrfs_item_ptr(leaf, path->slots[0] - 1,
 					    struct btrfs_file_extent_item);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
-							start - key.offset);
+							args->start - key.offset);
 
 			fi = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_file_extent_item);
 
-			extent_offset += start - key.offset;
+			extent_offset += args->start - key.offset;
 			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
-							extent_end - start);
+							extent_end - args->start);
 			btrfs_mark_buffer_dirty(leaf);
 
 			if (update_refs && disk_bytenr > 0) {
@@ -852,11 +862,11 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				btrfs_init_data_ref(&ref,
 						root->root_key.objectid,
 						new_key.objectid,
-						start - extent_offset);
+						args->start - extent_offset);
 				ret = btrfs_inc_extent_ref(trans, &ref);
 				BUG_ON(ret); /* -ENOMEM */
 			}
-			key.offset = start;
+			key.offset = args->start;
 		}
 		/*
 		 * From here on out we will have actually dropped something, so
@@ -868,23 +878,24 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | ---- range to drop ----- |
 		 *      | -------- extent -------- |
 		 */
-		if (start <= key.offset && end < extent_end) {
+		if (args->start <= key.offset && args->end < extent_end) {
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
 
 			memcpy(&new_key, &key, sizeof(new_key));
-			new_key.offset = end;
+			new_key.offset = args->end;
 			btrfs_set_item_key_safe(fs_info, path, &new_key);
 
-			extent_offset += end - key.offset;
+			extent_offset += args->end - key.offset;
 			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
-							extent_end - end);
+							extent_end - args->end);
 			btrfs_mark_buffer_dirty(leaf);
 			if (update_refs && disk_bytenr > 0)
-				inode_sub_bytes(vfs_inode, end - key.offset);
+				inode_sub_bytes(vfs_inode,
+						args->end - key.offset);
 			break;
 		}
 
@@ -893,7 +904,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *       | ---- range to drop ----- |
 		 *  | -------- extent -------- |
 		 */
-		if (start > key.offset && end >= extent_end) {
+		if (args->start > key.offset && args->end >= extent_end) {
 			BUG_ON(del_nr > 0);
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
@@ -901,11 +912,12 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			}
 
 			btrfs_set_file_extent_num_bytes(leaf, fi,
-							start - key.offset);
+							args->start - key.offset);
 			btrfs_mark_buffer_dirty(leaf);
 			if (update_refs && disk_bytenr > 0)
-				inode_sub_bytes(vfs_inode, extent_end - start);
-			if (end == extent_end)
+				inode_sub_bytes(vfs_inode,
+						extent_end - args->start);
+			if (args->end == extent_end)
 				break;
 
 			path->slots[0]++;
@@ -916,7 +928,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | ---- range to drop ----- |
 		 *    | ------ extent ------ |
 		 */
-		if (start <= key.offset && end >= extent_end) {
+		if (args->start <= key.offset && args->end >= extent_end) {
 delete_extent_item:
 			if (del_nr == 0) {
 				del_slot = path->slots[0];
@@ -946,7 +958,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 						extent_end - key.offset);
 			}
 
-			if (end == extent_end)
+			if (args->end == extent_end)
 				break;
 
 			if (path->slots[0] + 1 < btrfs_header_nritems(leaf)) {
@@ -976,7 +988,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 * Set path->slots[0] to first slot, so that after the delete
 		 * if items are move off from our leaf to its immediate left or
 		 * right neighbor leafs, we end up with a correct and adjusted
-		 * path->slots[0] for our insertion (if replace_extent != 0).
+		 * path->slots[0] for our insertion (if args->replace_extent).
 		 */
 		path->slots[0] = del_slot;
 		ret = btrfs_del_items(trans, root, path, del_slot, del_nr);
@@ -990,15 +1002,15 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	 * which case it unlocked our path, so check path->locks[0] matches a
 	 * write lock.
 	 */
-	if (!ret && replace_extent && leafs_visited == 1 &&
+	if (!ret && args->replace_extent && leafs_visited == 1 &&
 	    (path->locks[0] == BTRFS_WRITE_LOCK_BLOCKING ||
 	     path->locks[0] == BTRFS_WRITE_LOCK) &&
 	    btrfs_leaf_free_space(leaf) >=
-	    sizeof(struct btrfs_item) + extent_item_size) {
+	    sizeof(struct btrfs_item) + args->extent_item_size) {
 
 		key.objectid = ino;
 		key.type = BTRFS_EXTENT_DATA_KEY;
-		key.offset = start;
+		key.offset = args->start;
 		if (!del_nr && path->slots[0] < btrfs_header_nritems(leaf)) {
 			struct btrfs_key slot_key;
 
@@ -1006,30 +1018,18 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			if (btrfs_comp_cpu_keys(&key, &slot_key) > 0)
 				path->slots[0]++;
 		}
-		setup_items_for_insert(root, path, &key, &extent_item_size, 1);
-		*key_inserted = 1;
+		setup_items_for_insert(root, path, &key,
+				       &args->extent_item_size, 1);
+		args->extent_inserted = true;
 	}
 
-	if (!replace_extent || !(*key_inserted))
+	if (!args->path)
+		btrfs_free_path(path);
+	else if (!args->extent_inserted)
 		btrfs_release_path(path);
-	if (drop_end)
-		*drop_end = found ? min(end, last_end) : end;
-	return ret;
-}
-
-int btrfs_drop_extents(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct inode *inode, u64 start,
-		       u64 end, int drop_cache)
-{
-	struct btrfs_path *path;
-	int ret;
+out:
+	args->drop_end = found ? min(args->end, last_end) : args->end;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path, start,
-				   end, NULL, drop_cache, 0, 0, NULL);
-	btrfs_free_path(path);
 	return ret;
 }
 
@@ -2602,6 +2602,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			   struct btrfs_replace_extent_info *extent_info,
 			   struct btrfs_trans_handle **trans_out)
 {
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
 	u64 ino_size = round_up(inode->i_size, fs_info->sectorsize);
@@ -2610,7 +2611,6 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 	struct btrfs_block_rsv *rsv;
 	unsigned int rsv_count;
 	u64 cur_offset;
-	u64 drop_end;
 	u64 len = end - start;
 	int ret = 0;
 
@@ -2649,10 +2649,12 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 	trans->block_rsv = rsv;
 
 	cur_offset = start;
+	drop_args.path = path;
+	drop_args.end = end + 1;
+	drop_args.drop_cache = true;
 	while (cur_offset < end) {
-		ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path,
-					   cur_offset, end + 1, &drop_end,
-					   1, 0, 0, NULL);
+		drop_args.start = cur_offset;
+		ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), &drop_args);
 		if (ret != -ENOSPC) {
 			/*
 			 * When cloning we want to avoid transaction aborts when
@@ -2669,10 +2671,10 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 
-		if (!extent_info && cur_offset < drop_end &&
+		if (!extent_info && cur_offset < drop_args.drop_end &&
 		    cur_offset < ino_size) {
 			ret = fill_holes(trans, BTRFS_I(inode), path,
-					cur_offset, drop_end);
+					 cur_offset, drop_args.drop_end);
 			if (ret) {
 				/*
 				 * If we failed then we didn't insert our hole
@@ -2683,7 +2685,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
-		} else if (!extent_info && cur_offset < drop_end) {
+		} else if (!extent_info && cur_offset < drop_args.drop_end) {
 			/*
 			 * We are past the i_size here, but since we didn't
 			 * insert holes we need to clear the mapped area so we
@@ -2691,7 +2693,8 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			 * file extent is inserted here.
 			 */
 			ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
-					cur_offset, drop_end - cur_offset);
+					cur_offset,
+					drop_args.drop_end - cur_offset);
 			if (ret) {
 				/*
 				 * We couldn't clear our area, so we could
@@ -2703,8 +2706,10 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			}
 		}
 
-		if (extent_info && drop_end > extent_info->file_offset) {
-			u64 replace_len = drop_end - extent_info->file_offset;
+		if (extent_info &&
+		    drop_args.drop_end > extent_info->file_offset) {
+			u64 replace_len = drop_args.drop_end -
+				extent_info->file_offset;
 
 			ret = btrfs_insert_replace_extent(trans, inode, path,
 							extent_info, replace_len);
@@ -2717,7 +2722,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			extent_info->file_offset += replace_len;
 		}
 
-		cur_offset = drop_end;
+		cur_offset = drop_args.drop_end;
 
 		ret = btrfs_update_inode(trans, root, inode);
 		if (ret)
@@ -2776,25 +2781,27 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 	 * will not record the existence of the hole region
 	 * [existing_hole_start, lockend].
 	 */
-	if (drop_end <= end)
-		drop_end = end + 1;
+	if (drop_args.drop_end <= end)
+		drop_args.drop_end = end + 1;
 	/*
 	 * Don't insert file hole extent item if it's for a range beyond eof
 	 * (because it's useless) or if it represents a 0 bytes range (when
 	 * cur_offset == drop_end).
 	 */
-	if (!extent_info && cur_offset < ino_size && cur_offset < drop_end) {
+	if (!extent_info && cur_offset < ino_size &&
+	    cur_offset < drop_args.drop_end) {
 		ret = fill_holes(trans, BTRFS_I(inode), path,
-				cur_offset, drop_end);
+				 cur_offset, drop_args.drop_end);
 		if (ret) {
 			/* Same comment as above. */
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
 		}
-	} else if (!extent_info && cur_offset < drop_end) {
+	} else if (!extent_info && cur_offset < drop_args.drop_end) {
 		/* See the comment in the loop above for the reasoning here. */
 		ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
-					cur_offset, drop_end - cur_offset);
+					cur_offset,
+					drop_args.drop_end - cur_offset);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2fb3d2ea75fd..58f667269e7e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -202,7 +202,7 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
  * no overlapping inline items exist in the btree
  */
 static int insert_inline_extent(struct btrfs_trans_handle *trans,
-				struct btrfs_path *path, int extent_inserted,
+				struct btrfs_path *path, bool extent_inserted,
 				struct btrfs_root *root, struct inode *inode,
 				u64 start, size_t size, size_t compressed_size,
 				int compress_type,
@@ -317,6 +317,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 					  int compress_type,
 					  struct page **compressed_pages)
 {
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
@@ -327,8 +328,6 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	u64 data_len = inline_len;
 	int ret;
 	struct btrfs_path *path;
-	int extent_inserted = 0;
-	u32 extent_item_size;
 
 	if (compressed_size)
 		data_len = compressed_size;
@@ -354,16 +353,20 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	}
 	trans->block_rsv = &inode->block_rsv;
 
+	drop_args.path = path;
+	drop_args.start = start;
+	drop_args.end = aligned_end;
+	drop_args.drop_cache = true;
+	drop_args.replace_extent = true;
+
 	if (compressed_size && compressed_pages)
-		extent_item_size = btrfs_file_extent_calc_inline_size(
+		drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(
 		   compressed_size);
 	else
-		extent_item_size = btrfs_file_extent_calc_inline_size(
+		drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(
 		    inline_len);
 
-	ret = __btrfs_drop_extents(trans, root, inode, path, start, aligned_end,
-				   NULL, 1, 1, extent_item_size,
-				   &extent_inserted);
+	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -371,7 +374,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 
 	if (isize > actual_end)
 		inline_len = min_t(u64, isize, actual_end);
-	ret = insert_inline_extent(trans, path, extent_inserted,
+	ret = insert_inline_extent(trans, path, drop_args.extent_inserted,
 				   root, &inode->vfs_inode, start,
 				   inline_len, compressed_size,
 				   compress_type, compressed_pages);
@@ -2568,7 +2571,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
-	int extent_inserted = 0;
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -2584,13 +2587,16 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * the caller is expected to unpin it and allow it to be merged
 	 * with the others.
 	 */
-	ret = __btrfs_drop_extents(trans, root, inode, path, file_pos,
-				   file_pos + num_bytes, NULL, 0,
-				   1, sizeof(*stack_fi), &extent_inserted);
+	drop_args.path = path;
+	drop_args.start = file_pos;
+	drop_args.end = file_pos + num_bytes;
+	drop_args.replace_extent = true;
+	drop_args.extent_item_size = sizeof(*stack_fi);
+	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
 
-	if (!extent_inserted) {
+	if (!drop_args.extent_inserted) {
 		ins.objectid = btrfs_ino(inode);
 		ins.offset = file_pos;
 		ins.type = BTRFS_EXTENT_DATA_KEY;
@@ -4752,6 +4758,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_trans_handle *trans;
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	int ret;
 
 	/*
@@ -4774,7 +4781,11 @@ static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_drop_extents(trans, root, inode, offset, offset + len, 1);
+	drop_args.start = offset;
+	drop_args.end = offset + len;
+	drop_args.drop_cache = true;
+
+	ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 99aa87c08912..e65f8c9f8abb 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -163,6 +163,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	const u64 aligned_end = ALIGN(new_key->offset + datal,
 				      fs_info->sectorsize);
 	struct btrfs_trans_handle *trans = NULL;
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	int ret;
 	struct btrfs_key key;
 
@@ -252,7 +253,11 @@ static int clone_copy_inline_extent(struct inode *dst,
 		trans = NULL;
 		goto out;
 	}
-	ret = btrfs_drop_extents(trans, root, dst, drop_start, aligned_end, 1);
+	drop_args.path = path;
+	drop_args.start = drop_start;
+	drop_args.end = aligned_end;
+	drop_args.drop_cache = true;
+	ret = btrfs_drop_extents(trans, root, BTRFS_I(dst), &drop_args);
 	if (ret)
 		goto out;
 	ret = btrfs_insert_empty_item(trans, root, path, new_key, size);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 135cb40295c1..3d142114aa15 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -576,6 +576,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				      struct extent_buffer *eb, int slot,
 				      struct btrfs_key *key)
 {
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int found_type;
 	u64 extent_end;
@@ -653,7 +654,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* drop any overlapping extents */
-	ret = btrfs_drop_extents(trans, root, inode, start, extent_end, 1);
+	drop_args.start = start;
+	drop_args.end = extent_end;
+	drop_args.drop_cache = true;
+	ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), &drop_args);
 	if (ret)
 		goto out;
 
@@ -2576,6 +2580,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			 * those prealloc extents just after replaying them.
 			 */
 			if (S_ISREG(mode)) {
+				struct btrfs_drop_extents_args drop_args = { 0 };
 				struct inode *inode;
 				u64 from;
 
@@ -2586,8 +2591,12 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				}
 				from = ALIGN(i_size_read(inode),
 					     root->fs_info->sectorsize);
-				ret = btrfs_drop_extents(wc->trans, root, inode,
-							 from, (u64)-1, 1);
+				drop_args.start = from;
+				drop_args.end = (u64)-1;
+				drop_args.drop_cache = true;
+				ret = btrfs_drop_extents(wc->trans, root,
+							 BTRFS_I(inode),
+							 &drop_args);
 				if (!ret) {
 					/* Update the inode's nbytes. */
 					ret = btrfs_update_inode(wc->trans,
@@ -4186,6 +4195,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 			  struct btrfs_path *path,
 			  struct btrfs_log_ctx *ctx)
 {
+	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *log = root->log_root;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *leaf;
@@ -4194,19 +4204,21 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
-	int extent_inserted = 0;
 
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
 		return ret;
 
-	ret = __btrfs_drop_extents(trans, log, inode, path, em->start,
-				   em->start + em->len, NULL, 0, 1,
-				   sizeof(*fi), &extent_inserted);
+	drop_args.path = path;
+	drop_args.start = em->start;
+	drop_args.end = em->start + em->len;
+	drop_args.replace_extent = true;
+	drop_args.extent_item_size = sizeof(*fi);
+	ret = btrfs_drop_extents(trans, log, inode, &drop_args);
 	if (ret)
 		return ret;
 
-	if (!extent_inserted) {
+	if (!drop_args.extent_inserted) {
 		key.objectid = btrfs_ino(inode);
 		key.type = BTRFS_EXTENT_DATA_KEY;
 		key.offset = em->start;
-- 
2.28.0

