Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637791023E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfKSMHj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKSMHj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:07:39 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410FB222DC;
        Tue, 19 Nov 2019 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574165258;
        bh=Lsqlk3kFOTQOA2uG94iUGffvLSfLxs0D1PvGpyY+Xq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDmiXzZBabz2jteBDO6HajI+ifZE3bFLuGAA1l6i8YLxMzTy+ERtF9R9dtWw7UAHE
         W9nnTxQdB6cDy/He6zg2jFWDaOeATgbOK8einbinlpj0M28KsnthGk2vrQ5L7xKJM7
         ruCDITCBtO7EaIUZIhJSvNwMjAqp3GEGZQfg53Jc=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2] Btrfs: fix missing hole after hole punching and fsync when using NO_HOLES
Date:   Tue, 19 Nov 2019 12:07:33 +0000
Message-Id: <20191119120733.25827-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191112151331.3641-1-fdmanana@kernel.org>
References: <20191112151331.3641-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the NO_HOLES feature, if we punch a hole into a file and then
fsync it, there are cases where a subsequent fsync will miss the fact that
a hole was punched, resulting in the holes not existing after replaying
the log tree.

Essentially these cases all imply that, tree-log.c:copy_items(), is not
invoked for the leafs that delimit holes, because nothing changed those
leafs in the current transaction. And it's precisely copy_items() where
we currenly detect and log holes, which works as long as the holes are
between file extent items in the input leaf or between the beginning of
input leaf and the previous leaf or between the last item in the leaf
and the next leaf.

First example where we miss a hole:

  *) The extent items of the inode span multiple leafs;

  *) The punched hole covers a range that affects only the extent items of
     the first leaf;

  *) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
     is set in the inode's runtime flags).

  That results in the hole not existing after replaying the log tree.

  For example, if the fs/subvolume tree has the following layout for a
  particular inode:

      Leaf N, generation 10:

      [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]

      Leaf N + 1, generation 10:

      [ EXTENT_ITEM (128K 64K) ... ]

  If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
  up dropping the two extent items from leaf N, but we don't touch the other
  leaf, so we end up in the following state:

      Leaf N, generation 11:

      [ ... INODE_ITEM INODE_REF ]

      Leaf N + 1, generation 10:

      [ EXTENT_ITEM (128K 64K) ... ]

  A full fsync after punching the hole will only process leaf N because it
  was modified in the current transaction, but not leaf N + 1, since it
  was not modified in the current transaction (generation 10 and not 11).
  As a result the fsync will not log any holes, because it didn't process
  any leaf with extent items.

Second example where we will miss a hole:

  *) An inode as its items spanning 5 (or more) leafs;

  *) A hole is punched and it covers only the extents items of the 3rd
     leaf. This resulsts in deleting the entire leaf and not touching any
     of the other leafs.

  So the only leaf that is modified in the current transaction, when
  punching the hole, is the first leaf, which contains the inode item.
  During the full fsync, the only leaf that is passed to copy_items()
  is that first leaf, and that's not enough for the hole detection
  code in copy_items() to determine there's a hole between the last
  file extent item in the 2nd leaf and the first file extent item in
  the 3rd leaf (which was the 4th leaf before punching the hole).

Fix this by scanning all leafs and punch holes as necessary when doing a
full fsync (less common than a non-full fsync) when the NO_HOLES feature
is enabled. The lack of explicit file extent items to mark holes makes it
necessary to scan existing extents to determine if holes exist.

A test case for fstests follows soon.

Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Deal with other cases too, which involve hole punching dropping entire leafs.

 fs/btrfs/tree-log.c | 388 ++++++++++++++--------------------------------------
 1 file changed, 100 insertions(+), 288 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8a6cc600bf18..9cadf58020a7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3930,7 +3930,7 @@ static int log_inode_item(struct btrfs_trans_handle *trans,
 static noinline int copy_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_inode *inode,
 			       struct btrfs_path *dst_path,
-			       struct btrfs_path *src_path, u64 *last_extent,
+			       struct btrfs_path *src_path,
 			       int start_slot, int nr, int inode_only,
 			       u64 logged_isize)
 {
@@ -3941,7 +3941,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *extent;
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *src = src_path->nodes[0];
-	struct btrfs_key first_key, last_key, key;
 	int ret;
 	struct btrfs_key *ins_keys;
 	u32 *ins_sizes;
@@ -3949,9 +3948,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	int i;
 	struct list_head ordered_sums;
 	int skip_csum = inode->flags & BTRFS_INODE_NODATASUM;
-	bool has_extents = false;
-	bool need_find_last_extent = true;
-	bool done = false;
 
 	INIT_LIST_HEAD(&ordered_sums);
 
@@ -3960,8 +3956,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	if (!ins_data)
 		return -ENOMEM;
 
-	first_key.objectid = (u64)-1;
-
 	ins_sizes = (u32 *)ins_data;
 	ins_keys = (struct btrfs_key *)(ins_data + nr * sizeof(u32));
 
@@ -3982,9 +3976,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 
 		src_offset = btrfs_item_ptr_offset(src, start_slot + i);
 
-		if (i == nr - 1)
-			last_key = ins_keys[i];
-
 		if (ins_keys[i].type == BTRFS_INODE_ITEM_KEY) {
 			inode_item = btrfs_item_ptr(dst_path->nodes[0],
 						    dst_path->slots[0],
@@ -3998,20 +3989,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 					   src_offset, ins_sizes[i]);
 		}
 
-		/*
-		 * We set need_find_last_extent here in case we know we were
-		 * processing other items and then walk into the first extent in
-		 * the inode.  If we don't hit an extent then nothing changes,
-		 * we'll do the last search the next time around.
-		 */
-		if (ins_keys[i].type == BTRFS_EXTENT_DATA_KEY) {
-			has_extents = true;
-			if (first_key.objectid == (u64)-1)
-				first_key = ins_keys[i];
-		} else {
-			need_find_last_extent = false;
-		}
-
 		/* take a reference on file data extents so that truncates
 		 * or deletes of this inode don't have to relog the inode
 		 * again
@@ -4077,167 +4054,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		kfree(sums);
 	}
 
-	if (!has_extents)
-		return ret;
-
-	if (need_find_last_extent && *last_extent == first_key.offset) {
-		/*
-		 * We don't have any leafs between our current one and the one
-		 * we processed before that can have file extent items for our
-		 * inode (and have a generation number smaller than our current
-		 * transaction id).
-		 */
-		need_find_last_extent = false;
-	}
-
-	/*
-	 * Because we use btrfs_search_forward we could skip leaves that were
-	 * not modified and then assume *last_extent is valid when it really
-	 * isn't.  So back up to the previous leaf and read the end of the last
-	 * extent before we go and fill in holes.
-	 */
-	if (need_find_last_extent) {
-		u64 len;
-
-		ret = btrfs_prev_leaf(inode->root, src_path);
-		if (ret < 0)
-			return ret;
-		if (ret)
-			goto fill_holes;
-		if (src_path->slots[0])
-			src_path->slots[0]--;
-		src = src_path->nodes[0];
-		btrfs_item_key_to_cpu(src, &key, src_path->slots[0]);
-		if (key.objectid != btrfs_ino(inode) ||
-		    key.type != BTRFS_EXTENT_DATA_KEY)
-			goto fill_holes;
-		extent = btrfs_item_ptr(src, src_path->slots[0],
-					struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(src, extent) ==
-		    BTRFS_FILE_EXTENT_INLINE) {
-			len = btrfs_file_extent_ram_bytes(src, extent);
-			*last_extent = ALIGN(key.offset + len,
-					     fs_info->sectorsize);
-		} else {
-			len = btrfs_file_extent_num_bytes(src, extent);
-			*last_extent = key.offset + len;
-		}
-	}
-fill_holes:
-	/* So we did prev_leaf, now we need to move to the next leaf, but a few
-	 * things could have happened
-	 *
-	 * 1) A merge could have happened, so we could currently be on a leaf
-	 * that holds what we were copying in the first place.
-	 * 2) A split could have happened, and now not all of the items we want
-	 * are on the same leaf.
-	 *
-	 * So we need to adjust how we search for holes, we need to drop the
-	 * path and re-search for the first extent key we found, and then walk
-	 * forward until we hit the last one we copied.
-	 */
-	if (need_find_last_extent) {
-		/* btrfs_prev_leaf could return 1 without releasing the path */
-		btrfs_release_path(src_path);
-		ret = btrfs_search_slot(NULL, inode->root, &first_key,
-				src_path, 0, 0);
-		if (ret < 0)
-			return ret;
-		ASSERT(ret == 0);
-		src = src_path->nodes[0];
-		i = src_path->slots[0];
-	} else {
-		i = start_slot;
-	}
-
-	/*
-	 * Ok so here we need to go through and fill in any holes we may have
-	 * to make sure that holes are punched for those areas in case they had
-	 * extents previously.
-	 */
-	while (!done) {
-		u64 offset, len;
-		u64 extent_end;
-
-		if (i >= btrfs_header_nritems(src_path->nodes[0])) {
-			ret = btrfs_next_leaf(inode->root, src_path);
-			if (ret < 0)
-				return ret;
-			ASSERT(ret == 0);
-			src = src_path->nodes[0];
-			i = 0;
-			need_find_last_extent = true;
-		}
-
-		btrfs_item_key_to_cpu(src, &key, i);
-		if (!btrfs_comp_cpu_keys(&key, &last_key))
-			done = true;
-		if (key.objectid != btrfs_ino(inode) ||
-		    key.type != BTRFS_EXTENT_DATA_KEY) {
-			i++;
-			continue;
-		}
-		extent = btrfs_item_ptr(src, i, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(src, extent) ==
-		    BTRFS_FILE_EXTENT_INLINE) {
-			len = btrfs_file_extent_ram_bytes(src, extent);
-			extent_end = ALIGN(key.offset + len,
-					   fs_info->sectorsize);
-		} else {
-			len = btrfs_file_extent_num_bytes(src, extent);
-			extent_end = key.offset + len;
-		}
-		i++;
-
-		if (*last_extent == key.offset) {
-			*last_extent = extent_end;
-			continue;
-		}
-		offset = *last_extent;
-		len = key.offset - *last_extent;
-		ret = btrfs_insert_file_extent(trans, log, btrfs_ino(inode),
-				offset, 0, 0, len, 0, len, 0, 0, 0);
-		if (ret)
-			break;
-		*last_extent = extent_end;
-	}
-
-	/*
-	 * Check if there is a hole between the last extent found in our leaf
-	 * and the first extent in the next leaf. If there is one, we need to
-	 * log an explicit hole so that at replay time we can punch the hole.
-	 */
-	if (ret == 0 &&
-	    key.objectid == btrfs_ino(inode) &&
-	    key.type == BTRFS_EXTENT_DATA_KEY &&
-	    i == btrfs_header_nritems(src_path->nodes[0])) {
-		ret = btrfs_next_leaf(inode->root, src_path);
-		need_find_last_extent = true;
-		if (ret > 0) {
-			ret = 0;
-		} else if (ret == 0) {
-			btrfs_item_key_to_cpu(src_path->nodes[0], &key,
-					      src_path->slots[0]);
-			if (key.objectid == btrfs_ino(inode) &&
-			    key.type == BTRFS_EXTENT_DATA_KEY &&
-			    *last_extent < key.offset) {
-				const u64 len = key.offset - *last_extent;
-
-				ret = btrfs_insert_file_extent(trans, log,
-							       btrfs_ino(inode),
-							       *last_extent, 0,
-							       0, len, 0, len,
-							       0, 0, 0);
-				*last_extent += len;
-			}
-		}
-	}
-	/*
-	 * Need to let the callers know we dropped the path so they should
-	 * re-search.
-	 */
-	if (!ret && need_find_last_extent)
-		ret = 1;
 	return ret;
 }
 
@@ -4402,7 +4218,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	const u64 i_size = i_size_read(&inode->vfs_inode);
 	const u64 ino = btrfs_ino(inode);
 	struct btrfs_path *dst_path = NULL;
-	u64 last_extent = (u64)-1;
+	bool dropped_extents = false;
 	int ins_nr = 0;
 	int start_slot;
 	int ret;
@@ -4424,8 +4240,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			if (ins_nr > 0) {
 				ret = copy_items(trans, inode, dst_path, path,
-						 &last_extent, start_slot,
-						 ins_nr, 1, 0);
+						 start_slot, ins_nr, 1, 0);
 				if (ret < 0)
 					goto out;
 				ins_nr = 0;
@@ -4449,8 +4264,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			path->slots[0]++;
 			continue;
 		}
-		if (last_extent == (u64)-1) {
-			last_extent = key.offset;
+		if (!dropped_extents) {
 			/*
 			 * Avoid logging extent items logged in past fsync calls
 			 * and leading to duplicate keys in the log tree.
@@ -4464,6 +4278,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			} while (ret == -EAGAIN);
 			if (ret)
 				goto out;
+			dropped_extents = true;
 		}
 		if (ins_nr == 0)
 			start_slot = slot;
@@ -4478,7 +4293,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 		}
 	}
 	if (ins_nr > 0) {
-		ret = copy_items(trans, inode, dst_path, path, &last_extent,
+		ret = copy_items(trans, inode, dst_path, path,
 				 start_slot, ins_nr, 1, 0);
 		if (ret > 0)
 			ret = 0;
@@ -4665,13 +4480,8 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 
 		if (slot >= nritems) {
 			if (ins_nr > 0) {
-				u64 last_extent = 0;
-
 				ret = copy_items(trans, inode, dst_path, path,
-						 &last_extent, start_slot,
-						 ins_nr, 1, 0);
-				/* can't be 1, extent items aren't processed */
-				ASSERT(ret <= 0);
+						 start_slot, ins_nr, 1, 0);
 				if (ret < 0)
 					return ret;
 				ins_nr = 0;
@@ -4695,13 +4505,8 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 		cond_resched();
 	}
 	if (ins_nr > 0) {
-		u64 last_extent = 0;
-
 		ret = copy_items(trans, inode, dst_path, path,
-				 &last_extent, start_slot,
-				 ins_nr, 1, 0);
-		/* can't be 1, extent items aren't processed */
-		ASSERT(ret <= 0);
+				 start_slot, ins_nr, 1, 0);
 		if (ret < 0)
 			return ret;
 	}
@@ -4710,100 +4515,119 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 }
 
 /*
- * If the no holes feature is enabled we need to make sure any hole between the
- * last extent and the i_size of our inode is explicitly marked in the log. This
- * is to make sure that doing something like:
- *
- *      1) create file with 128Kb of data
- *      2) truncate file to 64Kb
- *      3) truncate file to 256Kb
- *      4) fsync file
- *      5) <crash/power failure>
- *      6) mount fs and trigger log replay
- *
- * Will give us a file with a size of 256Kb, the first 64Kb of data match what
- * the file had in its first 64Kb of data at step 1 and the last 192Kb of the
- * file correspond to a hole. The presence of explicit holes in a log tree is
- * what guarantees that log replay will remove/adjust file extent items in the
- * fs/subvol tree.
- *
- * Here we do not need to care about holes between extents, that is already done
- * by copy_items(). We also only need to do this in the full sync path, where we
- * lookup for extents from the fs/subvol tree only. In the fast path case, we
- * lookup the list of modified extent maps and if any represents a hole, we
- * insert a corresponding extent representing a hole in the log tree.
+ * When using the NO_HOLES feature if we punched a hole that causes the
+ * deletion of entire leafs or all the extent items of the first leaf (the one
+ * that contains the inode item and references) we may end up not processing
+ * any extents, because there are no leafs with a generation matching the
+ * current transaction that have extent items for our inode. So we need to find
+ * if any holes exist and then log them. We also need to log holes after any
+ * truncate operation that changes the inode's size.
  */
-static int btrfs_log_trailing_hole(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *root,
-				   struct btrfs_inode *inode,
-				   struct btrfs_path *path)
+static int btrfs_log_holes(struct btrfs_trans_handle *trans,
+			   struct btrfs_root *root,
+			   struct btrfs_inode *inode,
+			   struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
 	struct btrfs_key key;
-	u64 hole_start;
-	u64 hole_size;
-	struct extent_buffer *leaf;
-	struct btrfs_root *log = root->log_root;
 	const u64 ino = btrfs_ino(inode);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
+	u64 prev_extent_end = 0;
+	int ret;
 
-	if (!btrfs_fs_incompat(fs_info, NO_HOLES))
+	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || i_size == 0)
 		return 0;
 
 	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = (u64)-1;
+	key.offset = 0;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	ASSERT(ret != 0);
 	if (ret < 0)
 		return ret;
 
-	ASSERT(path->slots[0] > 0);
-	path->slots[0]--;
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-
-	if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
-		/* inode does not have any extents */
-		hole_start = 0;
-		hole_size = i_size;
-	} else {
+	while (true) {
 		struct btrfs_file_extent_item *extent;
+		struct extent_buffer *leaf = path->nodes[0];
 		u64 len;
 
-		/*
-		 * If there's an extent beyond i_size, an explicit hole was
-		 * already inserted by copy_items().
-		 */
-		if (key.offset >= i_size)
-			return 0;
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+			ret = btrfs_next_leaf(root, path);
+			if (ret < 0)
+				return ret;
+			if (ret > 0) {
+				ret = 0;
+				break;
+			}
+			leaf = path->nodes[0];
+		}
+
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
+			break;
+
+		/* We have a hole, log it. */
+		if (prev_extent_end < key.offset) {
+			const u64 hole_len = key.offset - prev_extent_end;
+
+			/*
+			 * Release the path to avoid deadlocks with other code
+			 * paths that search the root while holding locks on
+			 * leafs from the log root.
+			 */
+			btrfs_release_path(path);
+			ret = btrfs_insert_file_extent(trans, root->log_root,
+						       ino, prev_extent_end, 0,
+						       0, hole_len, 0, hole_len,
+						       0, 0, 0);
+			if (ret < 0)
+				return ret;
+
+			/*
+			 * Search for the same key again in the root. Since it's
+			 * an extent item and we are holding the inode lock, the
+			 * key must still exist. If it doesn't just emit warning
+			 * and return an error to fall back to a transaction
+			 * commit.
+			 */
+			ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+			if (ret < 0)
+				return ret;
+			if (WARN_ON(ret > 0))
+				return -ENOENT;
+			leaf = path->nodes[0];
+		}
 
 		extent = btrfs_item_ptr(leaf, path->slots[0],
 					struct btrfs_file_extent_item);
-
 		if (btrfs_file_extent_type(leaf, extent) ==
-		    BTRFS_FILE_EXTENT_INLINE)
-			return 0;
+		    BTRFS_FILE_EXTENT_INLINE) {
+			len = btrfs_file_extent_ram_bytes(leaf, extent);
+			prev_extent_end = ALIGN(key.offset + len,
+						fs_info->sectorsize);
+		} else {
+			len = btrfs_file_extent_num_bytes(leaf, extent);
+			prev_extent_end = key.offset + len;
+		}
 
-		len = btrfs_file_extent_num_bytes(leaf, extent);
-		/* Last extent goes beyond i_size, no need to log a hole. */
-		if (key.offset + len > i_size)
-			return 0;
-		hole_start = key.offset + len;
-		hole_size = i_size - hole_start;
+		path->slots[0]++;
+		cond_resched();
 	}
-	btrfs_release_path(path);
 
-	/* Last extent ends at i_size. */
-	if (hole_size == 0)
-		return 0;
+	if (prev_extent_end < i_size) {
+		u64 hole_len;
 
-	hole_size = ALIGN(hole_size, fs_info->sectorsize);
-	ret = btrfs_insert_file_extent(trans, log, ino, hole_start, 0, 0,
-				       hole_size, 0, hole_size, 0, 0, 0);
-	return ret;
+		btrfs_release_path(path);
+		hole_len = ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
+		ret = btrfs_insert_file_extent(trans, root->log_root,
+					       ino, prev_extent_end, 0, 0,
+					       hole_len, 0, hole_len,
+					       0, 0, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -5106,7 +4930,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key min_key;
 	struct btrfs_key max_key;
 	struct btrfs_root *log = root->log_root;
-	u64 last_extent = 0;
 	int err = 0;
 	int ret;
 	int nritems;
@@ -5284,7 +5107,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 					ins_start_slot = path->slots[0];
 				}
 				ret = copy_items(trans, inode, dst_path, path,
-						 &last_extent, ins_start_slot,
+						 ins_start_slot,
 						 ins_nr, inode_only,
 						 logged_isize);
 				if (ret < 0) {
@@ -5307,17 +5130,13 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			if (ins_nr == 0)
 				goto next_slot;
 			ret = copy_items(trans, inode, dst_path, path,
-					 &last_extent, ins_start_slot,
+					 ins_start_slot,
 					 ins_nr, inode_only, logged_isize);
 			if (ret < 0) {
 				err = ret;
 				goto out_unlock;
 			}
 			ins_nr = 0;
-			if (ret) {
-				btrfs_release_path(path);
-				continue;
-			}
 			goto next_slot;
 		}
 
@@ -5330,18 +5149,13 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			goto next_slot;
 		}
 
-		ret = copy_items(trans, inode, dst_path, path, &last_extent,
+		ret = copy_items(trans, inode, dst_path, path,
 				 ins_start_slot, ins_nr, inode_only,
 				 logged_isize);
 		if (ret < 0) {
 			err = ret;
 			goto out_unlock;
 		}
-		if (ret) {
-			ins_nr = 0;
-			btrfs_release_path(path);
-			continue;
-		}
 		ins_nr = 1;
 		ins_start_slot = path->slots[0];
 next_slot:
@@ -5355,13 +5169,12 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		}
 		if (ins_nr) {
 			ret = copy_items(trans, inode, dst_path, path,
-					 &last_extent, ins_start_slot,
+					 ins_start_slot,
 					 ins_nr, inode_only, logged_isize);
 			if (ret < 0) {
 				err = ret;
 				goto out_unlock;
 			}
-			ret = 0;
 			ins_nr = 0;
 		}
 		btrfs_release_path(path);
@@ -5376,14 +5189,13 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 	if (ins_nr) {
-		ret = copy_items(trans, inode, dst_path, path, &last_extent,
+		ret = copy_items(trans, inode, dst_path, path,
 				 ins_start_slot, ins_nr, inode_only,
 				 logged_isize);
 		if (ret < 0) {
 			err = ret;
 			goto out_unlock;
 		}
-		ret = 0;
 		ins_nr = 0;
 	}
 
@@ -5396,7 +5208,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-		err = btrfs_log_trailing_hole(trans, root, inode, path);
+		err = btrfs_log_holes(trans, root, inode, path);
 		if (err)
 			goto out_unlock;
 	}
-- 
2.11.0

