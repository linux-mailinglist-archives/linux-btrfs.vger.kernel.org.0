Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323CE60426
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfGEKJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 06:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfGEKJz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 06:09:55 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A982C2082F
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562321394;
        bh=P4cRpIJKcrfiNzVILEvcqW1wmVm3fF6D3yfMhbeskvQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZGIh40hPOM4sRKydcFqwf7kMAxzOGcAiyX7YraxHe5hCps25H47LXycs/DVTv2eeQ
         b8cVgSxML5/7awZMJMQWaZ3YNagDiXxFwbTq6Qc9wsC84+HfiUoDMabUcpQCMjPy1a
         2OGOIat/xVnfKhTxAkH3HrkCvHkD/y4JMo59phN0=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents
Date:   Fri,  5 Jul 2019 11:09:50 +0100
Message-Id: <20190705100950.14917-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190627170042.6241-1-fdmanana@kernel.org>
References: <20190627170042.6241-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When cloning extents (or deduplicating) we create a transaction with a
space reservation that considers we will drop or update a single file
extent item of the destination inode (that we modify a single leaf). That
is fine for the vast majority of scenarios, however it might happen that
we need to drop many file extent items, and adjust at most two file extent
items, in the destination root, which can span multiple leafs. This will
lead to either the call to btrfs_drop_extents() to fail with ENOSPC or
the subsequent calls to btrfs_insert_empty_item() or btrfs_update_inode()
(called through clone_finish_inode_update()) to fail with ENOSPC. Such
failure results in a transaction abort, leaving the filesystem in a
read-only mode.

In order to fix this we need to follow the same approach as the hole
punching code, where we create a local reservation with 1 unit and keep
ending and starting transactions, after balancing the btree inode,
when __btrfs_drop_extents() returns ENOSPC. So fix this by making the
extent cloning call calls the recently added btrfs_punch_hole_range()
helper, which is what does the mentioned work for hole punching, and
make sure whenever we drop extent items in a transaction, we also add a
replacing file extent item, to avoid corruption (a hole) if after ending
a transaction and before starting a new one, the old transaction gets
committed and a power failure happens before we finish cloning.

A test case for fstests follows soon.

Reported-by: David Goodwin <david@codepoets.co.uk>
Link: https://lore.kernel.org/linux-btrfs/a4a4cf31-9cf4-e52c-1f86-c62d336c9cd1@codepoets.co.uk/
Reported-by: Sam Tygier <sam@tygier.co.uk>
Link: https://lore.kernel.org/linux-btrfs/82aace9f-a1e3-1f0b-055f-3ea75f7a41a0@tygier.co.uk/
Fixes: b6f3409b2197e8f ("Btrfs: reserve sufficient space for ioctl clone")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Ensure we never end a transaction after dropping extents without adding
    a replacing file extent. Otherwise if after ending a transaction and before
    we started a new one, the transaction got committed and a power failure
    happened, we would end up with a hole in the file.

V3: Skip the hole skipping code in btrfs_punch_hole_range when we are called
    in the context of extent cloning. This was causing -EEXIST errors when
    the range has holes, and found through the updated version of the testcase.


 fs/btrfs/ctree.h |  14 ++++
 fs/btrfs/file.c  | 146 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/ioctl.c | 195 ++++++++++++-------------------------------------------
 3 files changed, 188 insertions(+), 167 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c1a166706a77..78b40b6d1b9d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1374,6 +1374,16 @@ struct btrfs_root {
 #endif
 };
 
+struct btrfs_clone_extent_info {
+	u64 disk_offset;
+	u64 disk_len;
+	u64 data_offset;
+	u64 data_len;
+	u64 file_offset;
+	char *extent_buf;
+	u32 item_size;
+};
+
 struct btrfs_file_private {
 	void *filldir_buf;
 };
@@ -3345,6 +3355,10 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct inode *inode, u64 start,
 		       u64 end, int drop_cache);
+int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+			   const u64 start, const u64 end,
+			   struct btrfs_clone_extent_info *clone_info,
+			   struct btrfs_trans_handle **trans_out);
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end);
 int btrfs_release_file(struct inode *inode, struct file *file);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 393a6d23b6b0..d62ccf5112fd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2448,13 +2448,76 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 	return 0;
 }
 
+static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
+				     struct inode *inode,
+				     struct btrfs_path *path,
+				     struct btrfs_clone_extent_info *clone_info,
+				     const u64 clone_len)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_file_extent_item *extent;
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+	int slot;
+	struct btrfs_ref ref = { 0 };
+	u64 ref_offset;
+	int ret;
+
+	if (clone_len == 0)
+		return 0;
+
+	if (clone_info->disk_offset == 0 &&
+	    btrfs_fs_incompat(fs_info, NO_HOLES))
+		return 0;
+
+	key.objectid = btrfs_ino(BTRFS_I(inode));
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = clone_info->file_offset;
+	ret = btrfs_insert_empty_item(trans, root, path, &key,
+				      clone_info->item_size);
+	if (ret)
+		return ret;
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	write_extent_buffer(leaf, clone_info->extent_buf,
+			    btrfs_item_ptr_offset(leaf, slot),
+			    clone_info->item_size);
+	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+	btrfs_set_file_extent_offset(leaf, extent, clone_info->data_offset);
+	btrfs_set_file_extent_num_bytes(leaf, extent, clone_len);
+	btrfs_mark_buffer_dirty(leaf);
+	btrfs_release_path(path);
+
+	/* If it's a hole, nothing more needs to be done. */
+	if (clone_info->disk_offset == 0)
+		return 0;
+
+	inode_add_bytes(inode, clone_len);
+	btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
+			       clone_info->disk_offset,
+			       clone_info->disk_len, 0);
+	ref_offset = clone_info->file_offset - clone_info->data_offset;
+	btrfs_init_data_ref(&ref, root->root_key.objectid,
+			    btrfs_ino(BTRFS_I(inode)), ref_offset);
+	ret = btrfs_inc_extent_ref(trans, &ref);
+
+	return ret;
+}
+
 /*
  * The respective range must have been previously locked, as well as the inode.
  * The end offset is inclusive (last byte of the range).
+ * @clone_info is NULL for fallocate's hole punching and non-NULL for extent
+ * cloning.
+ * When cloning, we don't want to end up in a state where we dropped extents
+ * without inserting a new one, so we must abort the transaction to avoid a
+ * corruption.
  */
-static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
-				  const u64 start, const u64 end,
-				  struct btrfs_trans_handle **trans_out)
+int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+			   const u64 start, const u64 end,
+			   struct btrfs_clone_extent_info *clone_info,
+			   struct btrfs_trans_handle **trans_out)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 min_size = btrfs_calc_trans_metadata_size(fs_info, 1);
@@ -2482,9 +2545,14 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	/*
 	 * 1 - update the inode
 	 * 1 - removing the extents in the range
-	 * 1 - adding the hole extent if no_holes isn't set
+	 * 1 - adding the hole extent if no_holes isn't set or if we are cloning
+	 *     an extent
 	 */
-	rsv_count = btrfs_fs_incompat(fs_info, NO_HOLES) ? 2 : 3;
+	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || clone_info)
+		rsv_count = 3;
+	else
+		rsv_count = 2;
+
 	trans = btrfs_start_transaction(root, rsv_count);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -2502,12 +2570,23 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 		ret = __btrfs_drop_extents(trans, root, inode, path,
 					   cur_offset, end + 1, &drop_end,
 					   1, 0, 0, NULL);
-		if (ret != -ENOSPC)
+		if (ret != -ENOSPC) {
+			/*
+			 * When cloning we want to avoid transaction aborts when
+			 * nothing was done and we are attempting to clone parts
+			 * of inline extents, in such cases -EOPNOTSUPP is
+			 * returned by __btrfs_drop_extents() without having
+			 * changed anything in the file.
+			 */
+			if (clone_info && ret && ret != -EOPNOTSUPP)
+				btrfs_abort_transaction(trans, ret);
 			break;
+		}
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 
-		if (cur_offset < drop_end && cur_offset < ino_size) {
+		if (!clone_info && cur_offset < drop_end &&
+		    cur_offset < ino_size) {
 			ret = fill_holes(trans, BTRFS_I(inode), path,
 					cur_offset, drop_end);
 			if (ret) {
@@ -2522,6 +2601,20 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			}
 		}
 
+		if (clone_info) {
+			u64 clone_len = drop_end - cur_offset;
+
+			ret = btrfs_insert_clone_extent(trans, inode, path,
+							clone_info, clone_len);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				break;
+			}
+			clone_info->data_len -= clone_len;
+			clone_info->data_offset += clone_len;
+			clone_info->file_offset += clone_len;
+		}
+
 		cur_offset = drop_end;
 
 		ret = btrfs_update_inode(trans, root, inode);
@@ -2543,15 +2636,29 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 		BUG_ON(ret);	/* shouldn't happen */
 		trans->block_rsv = rsv;
 
-		ret = find_first_non_hole(inode, &cur_offset, &len);
-		if (unlikely(ret < 0))
-			break;
-		if (ret && !len) {
-			ret = 0;
-			break;
+		if (!clone_info) {
+			ret = find_first_non_hole(inode, &cur_offset, &len);
+			if (unlikely(ret < 0))
+				break;
+			if (ret && !len) {
+				ret = 0;
+				break;
+			}
 		}
 	}
 
+	/*
+	 * If we were cloning, force the next fsync to be a full one since we
+	 * we replaced (or just dropped in the case of cloning holes when
+	 * NO_HOLES is enabled) extents and extent maps.
+	 * This is for the sake of simplicity, and cloning into files larger
+	 * than 16Mb would force the full fsync any way (when
+	 * try_release_extent_mapping() is invoked during page cache truncation.
+	 */
+	if (clone_info)
+		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
+			&BTRFS_I(inode)->runtime_flags);
+
 	if (ret)
 		goto out_trans;
 
@@ -2574,7 +2681,7 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	 * (because it's useless) or if it represents a 0 bytes range (when
 	 * cur_offset == drop_end).
 	 */
-	if (cur_offset < ino_size && cur_offset < drop_end) {
+	if (!clone_info && cur_offset < ino_size && cur_offset < drop_end) {
 		ret = fill_holes(trans, BTRFS_I(inode), path,
 				cur_offset, drop_end);
 		if (ret) {
@@ -2583,6 +2690,14 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			goto out_trans;
 		}
 	}
+	if (clone_info) {
+		ret = btrfs_insert_clone_extent(trans, inode, path, clone_info,
+						clone_info->data_len);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_trans;
+		}
+	}
 
 out_trans:
 	if (!trans)
@@ -2719,7 +2834,8 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out;
 	}
 
-	ret = btrfs_punch_hole_range(inode, path, lockstart, lockend, &trans);
+	ret = btrfs_punch_hole_range(inode, path, lockstart, lockend, NULL,
+				     &trans);
 	btrfs_free_path(path);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2a1be0d1a698..318dd64d9a4e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3328,61 +3328,6 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static void clone_update_extent_map(struct btrfs_inode *inode,
-				    const struct btrfs_trans_handle *trans,
-				    const struct btrfs_path *path,
-				    const u64 hole_offset,
-				    const u64 hole_len)
-{
-	struct extent_map_tree *em_tree = &inode->extent_tree;
-	struct extent_map *em;
-	int ret;
-
-	em = alloc_extent_map();
-	if (!em) {
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
-		return;
-	}
-
-	if (path) {
-		struct btrfs_file_extent_item *fi;
-
-		fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				    struct btrfs_file_extent_item);
-		btrfs_extent_item_to_extent_map(inode, path, fi, false, em);
-		em->generation = -1;
-		if (btrfs_file_extent_type(path->nodes[0], fi) ==
-		    BTRFS_FILE_EXTENT_INLINE)
-			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-					&inode->runtime_flags);
-	} else {
-		em->start = hole_offset;
-		em->len = hole_len;
-		em->ram_bytes = em->len;
-		em->orig_start = hole_offset;
-		em->block_start = EXTENT_MAP_HOLE;
-		em->block_len = 0;
-		em->orig_block_len = 0;
-		em->compress_type = BTRFS_COMPRESS_NONE;
-		em->generation = trans->transid;
-	}
-
-	while (1) {
-		write_lock(&em_tree->lock);
-		ret = add_extent_mapping(em_tree, em, 1);
-		write_unlock(&em_tree->lock);
-		if (ret != -EEXIST) {
-			free_extent_map(em);
-			break;
-		}
-		btrfs_drop_extent_cache(inode, em->start,
-					em->start + em->len - 1, 0);
-	}
-
-	if (ret)
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
-}
-
 /*
  * Make sure we do not end up inserting an inline extent into a file that has
  * already other (non-inline) extents. If a file has an inline extent it can
@@ -3523,6 +3468,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 						  path->slots[0]),
 			    size);
 	inode_add_bytes(dst, datal);
+	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(dst)->runtime_flags);
 
 	return 0;
 }
@@ -3682,19 +3628,10 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			else
 				drop_start = new_key.offset;
 
-			/*
-			 * 1 - adjusting old extent (we may have to split it)
-			 * 1 - add new extent
-			 * 1 - inode update
-			 */
-			trans = btrfs_start_transaction(root, 3);
-			if (IS_ERR(trans)) {
-				ret = PTR_ERR(trans);
-				goto out;
-			}
-
 			if (type == BTRFS_FILE_EXTENT_REG ||
 			    type == BTRFS_FILE_EXTENT_PREALLOC) {
+				struct btrfs_clone_extent_info clone_info;
+
 				/*
 				 *    a  | --- range to clone ---|  b
 				 * | ------------- extent ------------- |
@@ -3710,63 +3647,19 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 					datal -= off - key.offset;
 				}
 
-				ret = btrfs_drop_extents(trans, root, inode,
-							 drop_start,
-							 new_key.offset + datal,
-							 1);
-				if (ret) {
-					if (ret != -EOPNOTSUPP)
-						btrfs_abort_transaction(trans,
-									ret);
-					btrfs_end_transaction(trans);
+				clone_info.disk_offset = disko;
+				clone_info.disk_len = diskl;
+				clone_info.data_offset = datao;
+				clone_info.data_len = datal;
+				clone_info.file_offset = new_key.offset;
+				clone_info.extent_buf = buf;
+				clone_info.item_size = size;
+				ret = btrfs_punch_hole_range(inode, path,
+						     drop_start,
+						     new_key.offset + datal - 1,
+						     &clone_info, &trans);
+				if (ret)
 					goto out;
-				}
-
-				ret = btrfs_insert_empty_item(trans, root, path,
-							      &new_key, size);
-				if (ret) {
-					btrfs_abort_transaction(trans, ret);
-					btrfs_end_transaction(trans);
-					goto out;
-				}
-
-				leaf = path->nodes[0];
-				slot = path->slots[0];
-				write_extent_buffer(leaf, buf,
-					    btrfs_item_ptr_offset(leaf, slot),
-					    size);
-
-				extent = btrfs_item_ptr(leaf, slot,
-						struct btrfs_file_extent_item);
-
-				/* disko == 0 means it's a hole */
-				if (!disko)
-					datao = 0;
-
-				btrfs_set_file_extent_offset(leaf, extent,
-							     datao);
-				btrfs_set_file_extent_num_bytes(leaf, extent,
-								datal);
-
-				if (disko) {
-					struct btrfs_ref ref = { 0 };
-					inode_add_bytes(inode, datal);
-					btrfs_init_generic_ref(&ref,
-						BTRFS_ADD_DELAYED_REF, disko,
-						diskl, 0);
-					btrfs_init_data_ref(&ref,
-						root->root_key.objectid,
-						btrfs_ino(BTRFS_I(inode)),
-						new_key.offset - datao);
-					ret = btrfs_inc_extent_ref(trans, &ref);
-					if (ret) {
-						btrfs_abort_transaction(trans,
-									ret);
-						btrfs_end_transaction(trans);
-						goto out;
-
-					}
-				}
 			} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 				u64 skip = 0;
 				u64 trim = 0;
@@ -3781,12 +3674,27 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 				if (comp && (skip || trim)) {
 					ret = -EINVAL;
-					btrfs_end_transaction(trans);
 					goto out;
 				}
 				size -= skip + trim;
 				datal -= skip + trim;
 
+				/*
+				 * If our extent is inline, we know we will drop
+				 * or adjust at most 1 extent item in the
+				 * destination root.
+				 *
+				 * 1 - adjusting old extent (we may have to
+				 *     split it)
+				 * 1 - add new extent
+				 * 1 - inode update
+				 */
+				trans = btrfs_start_transaction(root, 3);
+				if (IS_ERR(trans)) {
+					ret = PTR_ERR(trans);
+					goto out;
+				}
+
 				ret = clone_copy_inline_extent(inode,
 							       trans, path,
 							       &new_key,
@@ -3800,20 +3708,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 					btrfs_end_transaction(trans);
 					goto out;
 				}
-				leaf = path->nodes[0];
-				slot = path->slots[0];
 			}
 
-			/* If we have an implicit hole (NO_HOLES feature). */
-			if (drop_start < new_key.offset)
-				clone_update_extent_map(BTRFS_I(inode), trans,
-						NULL, drop_start,
-						new_key.offset - drop_start);
-
-			clone_update_extent_map(BTRFS_I(inode), trans,
-					path, 0, 0);
-
-			btrfs_mark_buffer_dirty(leaf);
 			btrfs_release_path(path);
 
 			last_dest_end = ALIGN(new_key.offset + datal,
@@ -3838,32 +3734,27 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	ret = 0;
 
 	if (last_dest_end < destoff + len) {
+		struct btrfs_clone_extent_info clone_info = { 0 };
 		/*
 		 * We have an implicit hole (NO_HOLES feature is enabled) that
 		 * fully or partially overlaps our cloning range at its end.
 		 */
 		btrfs_release_path(path);
+		path->leave_spinning = 0;
 
 		/*
-		 * 1 - remove extent(s)
-		 * 1 - inode update
+		 * We are dealing with a hole and our clone_info already has a
+		 * disk_offset of 0, we only need to fill the data length and
+		 * file offset.
 		 */
-		trans = btrfs_start_transaction(root, 2);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			goto out;
-		}
-		ret = btrfs_drop_extents(trans, root, inode,
-					 last_dest_end, destoff + len, 1);
-		if (ret) {
-			if (ret != -EOPNOTSUPP)
-				btrfs_abort_transaction(trans, ret);
-			btrfs_end_transaction(trans);
+		clone_info.data_len = destoff + len - last_dest_end;
+		clone_info.file_offset = last_dest_end;
+		ret = btrfs_punch_hole_range(inode, path,
+					     last_dest_end, destoff + len - 1,
+					     &clone_info, &trans);
+		if (ret)
 			goto out;
-		}
-		clone_update_extent_map(BTRFS_I(inode), trans, NULL,
-				last_dest_end,
-				destoff + len - last_dest_end);
+
 		ret = clone_finish_inode_update(trans, inode, destoff + len,
 						destoff, olen, no_time_update);
 	}
-- 
2.11.0

