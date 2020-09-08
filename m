Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563C260FC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgIHK2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 06:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbgIHK1g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 06:27:36 -0400
Received: from falcondesktop.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50CA21D7A;
        Tue,  8 Sep 2020 10:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560855;
        bh=dT8FqnQ5XpHHiHTNcRFRWbVDwcx4xnGpEJedpcVb2f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lDXmNcj29C5Id12A6uniAgBtSREcg2FH1bKbccWgtYYg9fTJW9n2fwZMjcNR0Fwq6
         qIGrQdBB+lIZ75GWkVoRkz2Ywfp6ReU79TMijPSCloK0HkOyBCGYpAXVMjGsZmSjK/
         OTaMOoR0Xa61LJiRrRCDLrvGnFmFtnTuL88im7HE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/5] btrfs: rename struct btrfs_clone_extent_info to a more generic name
Date:   Tue,  8 Sep 2020 11:27:22 +0100
Message-Id: <45f5d723d70e55ae720abb9422ac9c0905f35f4b.1599560101.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Now that we can use btrfs_clone_extent_info to convey information for a
new prealloc extent as well, and not just for existing extents that are
being cloned, rename it to btrfs_replace_extent_info, which reflects the
fact that this is now more generic and it is used to replace all existing
extents in a file range with the extent described by the structure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   |  8 +++-
 fs/btrfs/file.c    | 92 +++++++++++++++++++++++-----------------------
 fs/btrfs/inode.c   |  2 +-
 fs/btrfs/reflink.c |  2 +-
 4 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3e648b0d5d60..0b1dadd44e53 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1183,7 +1183,11 @@ struct btrfs_root {
 #endif
 };
 
-struct btrfs_clone_extent_info {
+/*
+ * Structure that conveys information about an extent that is going to replace
+ * all the extents in a file range.
+ */
+struct btrfs_replace_extent_info {
 	u64 disk_offset;
 	u64 disk_len;
 	u64 data_offset;
@@ -3072,7 +3076,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       u64 end, int drop_cache);
 int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			   const u64 start, const u64 end,
-			   struct btrfs_clone_extent_info *clone_info,
+			   struct btrfs_replace_extent_info *extent_info,
 			   struct btrfs_trans_handle **trans_out);
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 28794a98778a..7ac0a20119f3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2573,8 +2573,8 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 				     struct inode *inode,
 				     struct btrfs_path *path,
-				     struct btrfs_clone_extent_info *clone_info,
-				     const u64 clone_len)
+				     struct btrfs_replace_extent_info *extent_info,
+				     const u64 replace_len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -2585,67 +2585,67 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_ref ref = { 0 };
 	int ret;
 
-	if (clone_len == 0)
+	if (replace_len == 0)
 		return 0;
 
-	if (clone_info->disk_offset == 0 &&
+	if (extent_info->disk_offset == 0 &&
 	    btrfs_fs_incompat(fs_info, NO_HOLES))
 		return 0;
 
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = clone_info->file_offset;
+	key.offset = extent_info->file_offset;
 	ret = btrfs_insert_empty_item(trans, root, path, &key,
 				      sizeof(struct btrfs_file_extent_item));
 	if (ret)
 		return ret;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
-	write_extent_buffer(leaf, clone_info->extent_buf,
+	write_extent_buffer(leaf, extent_info->extent_buf,
 			    btrfs_item_ptr_offset(leaf, slot),
 			    sizeof(struct btrfs_file_extent_item));
 	extent = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 	ASSERT(btrfs_file_extent_type(leaf, extent) != BTRFS_FILE_EXTENT_INLINE);
-	btrfs_set_file_extent_offset(leaf, extent, clone_info->data_offset);
-	btrfs_set_file_extent_num_bytes(leaf, extent, clone_len);
-	if (clone_info->is_new_extent)
+	btrfs_set_file_extent_offset(leaf, extent, extent_info->data_offset);
+	btrfs_set_file_extent_num_bytes(leaf, extent, replace_len);
+	if (extent_info->is_new_extent)
 		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
 	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
-			clone_info->file_offset, clone_len);
+			extent_info->file_offset, replace_len);
 	if (ret)
 		return ret;
 
 	/* If it's a hole, nothing more needs to be done. */
-	if (clone_info->disk_offset == 0)
+	if (extent_info->disk_offset == 0)
 		return 0;
 
-	inode_add_bytes(inode, clone_len);
+	inode_add_bytes(inode, replace_len);
 
-	if (clone_info->is_new_extent && clone_info->insertions == 0) {
-		key.objectid = clone_info->disk_offset;
+	if (extent_info->is_new_extent && extent_info->insertions == 0) {
+		key.objectid = extent_info->disk_offset;
 		key.type = BTRFS_EXTENT_ITEM_KEY;
-		key.offset = clone_info->disk_len;
+		key.offset = extent_info->disk_len;
 		ret = btrfs_alloc_reserved_file_extent(trans, root,
 						       btrfs_ino(BTRFS_I(inode)),
-						       clone_info->file_offset,
-						       clone_info->qgroup_reserved,
+						       extent_info->file_offset,
+						       extent_info->qgroup_reserved,
 						       &key);
 	} else {
 		u64 ref_offset;
 
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
-				       clone_info->disk_offset,
-				       clone_info->disk_len, 0);
-		ref_offset = clone_info->file_offset - clone_info->data_offset;
+				       extent_info->disk_offset,
+				       extent_info->disk_len, 0);
+		ref_offset = extent_info->file_offset - extent_info->data_offset;
 		btrfs_init_data_ref(&ref, root->root_key.objectid,
 				    btrfs_ino(BTRFS_I(inode)), ref_offset);
 		ret = btrfs_inc_extent_ref(trans, &ref);
 	}
 
-	clone_info->insertions++;
+	extent_info->insertions++;
 
 	return ret;
 }
@@ -2653,15 +2653,15 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 /*
  * The respective range must have been previously locked, as well as the inode.
  * The end offset is inclusive (last byte of the range).
- * @clone_info is NULL for fallocate's hole punching and non-NULL for extent
- * cloning.
- * When cloning, we don't want to end up in a state where we dropped extents
- * without inserting a new one, so we must abort the transaction to avoid a
- * corruption.
+ * @extent_info is NULL for fallocate's hole punching and non-NULL when replacing
+ * the file range with an extent.
+ * When not punching a hole, we don't want to end up in a state where we dropped
+ * extents without inserting a new one, so we must abort the transaction to avoid
+ * a corruption.
  */
 int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			   const u64 start, const u64 end,
-			   struct btrfs_clone_extent_info *clone_info,
+			   struct btrfs_replace_extent_info *extent_info,
 			   struct btrfs_trans_handle **trans_out)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2690,10 +2690,10 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	/*
 	 * 1 - update the inode
 	 * 1 - removing the extents in the range
-	 * 1 - adding the hole extent if no_holes isn't set or if we are cloning
-	 *     an extent
+	 * 1 - adding the hole extent if no_holes isn't set or if we are
+	 *     replacing the range with a new extent
 	 */
-	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || clone_info)
+	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || extent_info)
 		rsv_count = 3;
 	else
 		rsv_count = 2;
@@ -2723,7 +2723,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			 * returned by __btrfs_drop_extents() without having
 			 * changed anything in the file.
 			 */
-			if (clone_info && !clone_info->is_new_extent &&
+			if (extent_info && !extent_info->is_new_extent &&
 			    ret && ret != -EOPNOTSUPP)
 				btrfs_abort_transaction(trans, ret);
 			break;
@@ -2731,7 +2731,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 
-		if (!clone_info && cur_offset < drop_end &&
+		if (!extent_info && cur_offset < drop_end &&
 		    cur_offset < ino_size) {
 			ret = fill_holes(trans, BTRFS_I(inode), path,
 					cur_offset, drop_end);
@@ -2745,7 +2745,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
-		} else if (!clone_info && cur_offset < drop_end) {
+		} else if (!extent_info && cur_offset < drop_end) {
 			/*
 			 * We are past the i_size here, but since we didn't
 			 * insert holes we need to clear the mapped area so we
@@ -2765,18 +2765,18 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			}
 		}
 
-		if (clone_info && drop_end > clone_info->file_offset) {
-			u64 clone_len = drop_end - clone_info->file_offset;
+		if (extent_info && drop_end > extent_info->file_offset) {
+			u64 replace_len = drop_end - extent_info->file_offset;
 
 			ret = btrfs_insert_clone_extent(trans, inode, path,
-							clone_info, clone_len);
+							extent_info, replace_len);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				break;
 			}
-			clone_info->data_len -= clone_len;
-			clone_info->data_offset += clone_len;
-			clone_info->file_offset += clone_len;
+			extent_info->data_len -= replace_len;
+			extent_info->data_offset += replace_len;
+			extent_info->file_offset += replace_len;
 		}
 
 		cur_offset = drop_end;
@@ -2800,7 +2800,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 		BUG_ON(ret);	/* shouldn't happen */
 		trans->block_rsv = rsv;
 
-		if (!clone_info) {
+		if (!extent_info) {
 			ret = find_first_non_hole(inode, &cur_offset, &len);
 			if (unlikely(ret < 0))
 				break;
@@ -2819,7 +2819,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	 * than 16Mb would force the full fsync any way (when
 	 * try_release_extent_mapping() is invoked during page cache truncation.
 	 */
-	if (clone_info && !clone_info->is_new_extent)
+	if (extent_info && !extent_info->is_new_extent)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			&BTRFS_I(inode)->runtime_flags);
 
@@ -2845,7 +2845,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	 * (because it's useless) or if it represents a 0 bytes range (when
 	 * cur_offset == drop_end).
 	 */
-	if (!clone_info && cur_offset < ino_size && cur_offset < drop_end) {
+	if (!extent_info && cur_offset < ino_size && cur_offset < drop_end) {
 		ret = fill_holes(trans, BTRFS_I(inode), path,
 				cur_offset, drop_end);
 		if (ret) {
@@ -2853,7 +2853,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
 		}
-	} else if (!clone_info && cur_offset < drop_end) {
+	} else if (!extent_info && cur_offset < drop_end) {
 		/* See the comment in the loop above for the reasoning here. */
 		ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
 					cur_offset, drop_end - cur_offset);
@@ -2863,9 +2863,9 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 		}
 
 	}
-	if (clone_info) {
-		ret = btrfs_insert_clone_extent(trans, inode, path, clone_info,
-						clone_info->data_len);
+	if (extent_info) {
+		ret = btrfs_insert_clone_extent(trans, inode, path, extent_info,
+						extent_info->data_len);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0281895268f7..a67b80979c48 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9581,7 +9581,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 				       u64 file_offset)
 {
 	struct btrfs_file_extent_item stack_fi;
-	struct btrfs_clone_extent_info extent_info;
+	struct btrfs_replace_extent_info extent_info;
 	struct btrfs_trans_handle *trans = trans_in;
 	struct btrfs_path *path;
 	u64 start = ins->objectid;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 020da4d65b64..dc8b5397e198 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -439,7 +439,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 		if (type == BTRFS_FILE_EXTENT_REG ||
 		    type == BTRFS_FILE_EXTENT_PREALLOC) {
-			struct btrfs_clone_extent_info clone_info;
+			struct btrfs_replace_extent_info clone_info;
 
 			/*
 			 *    a  | --- range to clone ---|  b
-- 
2.26.2

