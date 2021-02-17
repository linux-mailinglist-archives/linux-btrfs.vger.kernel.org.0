Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20B831DA06
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhBQNNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 08:13:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:56716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhBQNNk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 08:13:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613567572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tM67/V63GvXcrCNCbsU7veTgRnOWvPko6shy5aGm2U8=;
        b=S9CcqNTjL+GNJtpP7ie+DOJtW++qG0sxpuX8yj8MchD9o84iyCmFa1mp1NFZhpNu0TOdGe
        1bmlfBjSDqozUnA6xuzW/46y3O7t1t2Q78UVBNUvsh7EscyHCFo76JaMGq/U1a4EbnZcP4
        0S8U1GQKWfO/N0KYTh2eSrw92tzRY2Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 973CEB8F1;
        Wed, 17 Feb 2021 13:12:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/4] btrfs: Make btrfs_replace_file_extents take btrfs_inode
Date:   Wed, 17 Feb 2021 15:12:47 +0200
Message-Id: <20210217131250.265859-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217131250.265859-1-nborisov@suse.com>
References: <20210217131250.265859-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h   |  5 +++--
 fs/btrfs/file.c    | 51 +++++++++++++++++++++++-----------------------
 fs/btrfs/inode.c   |  2 +-
 fs/btrfs/reflink.c | 10 ++++-----
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3bc00aed13b2..410202020d70 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3212,8 +3212,9 @@ extern const struct file_operations btrfs_file_operations;
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct btrfs_inode *inode,
 		       struct btrfs_drop_extents_args *args);
-int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
-			   const u64 start, const u64 end,
+int btrfs_replace_file_extents(struct btrfs_inode *inode,
+			   struct btrfs_path *path, const u64 start,
+			   const u64 end,
 			   struct btrfs_replace_extent_info *extent_info,
 			   struct btrfs_trans_handle **trans_out);
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 01a72f53fb5d..a4e6fb43e3a7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2605,16 +2605,17 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
  * extents without inserting a new one, so we must abort the transaction to avoid
  * a corruption.
  */
-int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
-			   const u64 start, const u64 end,
-			   struct btrfs_replace_extent_info *extent_info,
-			   struct btrfs_trans_handle **trans_out)
+int btrfs_replace_file_extents(struct btrfs_inode *inode,
+			       struct btrfs_path *path, const u64 start,
+			       const u64 end,
+			       struct btrfs_replace_extent_info *extent_info,
+			       struct btrfs_trans_handle **trans_out)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
-	u64 ino_size = round_up(inode->i_size, fs_info->sectorsize);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	u64 ino_size = round_up(inode->vfs_inode.i_size, fs_info->sectorsize);
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_block_rsv *rsv;
 	unsigned int rsv_count;
@@ -2662,10 +2663,10 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 	drop_args.drop_cache = true;
 	while (cur_offset < end) {
 		drop_args.start = cur_offset;
-		ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), &drop_args);
+		ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 		/* If we are punching a hole decrement the inode's byte count */
 		if (!extent_info)
-			btrfs_update_inode_bytes(BTRFS_I(inode), 0,
+			btrfs_update_inode_bytes(inode, 0,
 						 drop_args.bytes_found);
 		if (ret != -ENOSPC) {
 			/*
@@ -2685,8 +2686,8 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 
 		if (!extent_info && cur_offset < drop_args.drop_end &&
 		    cur_offset < ino_size) {
-			ret = fill_holes(trans, BTRFS_I(inode), path,
-					 cur_offset, drop_args.drop_end);
+			ret = fill_holes(trans, inode, path, cur_offset,
+					 drop_args.drop_end);
 			if (ret) {
 				/*
 				 * If we failed then we didn't insert our hole
@@ -2704,7 +2705,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			 * know to not set disk_i_size in this area until a new
 			 * file extent is inserted here.
 			 */
-			ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
+			ret = btrfs_inode_clear_file_extent_range(inode,
 					cur_offset,
 					drop_args.drop_end - cur_offset);
 			if (ret) {
@@ -2723,8 +2724,8 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			u64 replace_len = drop_args.drop_end -
 					  extent_info->file_offset;
 
-			ret = btrfs_insert_replace_extent(trans, BTRFS_I(inode),
-					path, extent_info, replace_len,
+			ret = btrfs_insert_replace_extent(trans, inode,	path,
+					extent_info, replace_len,
 					drop_args.bytes_found);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
@@ -2737,7 +2738,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 
 		cur_offset = drop_args.drop_end;
 
-		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, root, inode);
 		if (ret)
 			break;
 
@@ -2757,8 +2758,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 		trans->block_rsv = rsv;
 
 		if (!extent_info) {
-			ret = find_first_non_hole(BTRFS_I(inode), &cur_offset,
-						  &len);
+			ret = find_first_non_hole(inode, &cur_offset, &len);
 			if (unlikely(ret < 0))
 				break;
 			if (ret && !len) {
@@ -2777,8 +2777,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 	 * try_release_extent_mapping() is invoked during page cache truncation.
 	 */
 	if (extent_info && !extent_info->is_new_extent)
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			&BTRFS_I(inode)->runtime_flags);
+		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 
 	if (ret)
 		goto out_trans;
@@ -2804,8 +2803,8 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 	 */
 	if (!extent_info && cur_offset < ino_size &&
 	    cur_offset < drop_args.drop_end) {
-		ret = fill_holes(trans, BTRFS_I(inode), path,
-				 cur_offset, drop_args.drop_end);
+		ret = fill_holes(trans, inode, path, cur_offset,
+				 drop_args.drop_end);
 		if (ret) {
 			/* Same comment as above. */
 			btrfs_abort_transaction(trans, ret);
@@ -2813,8 +2812,8 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 		}
 	} else if (!extent_info && cur_offset < drop_args.drop_end) {
 		/* See the comment in the loop above for the reasoning here. */
-		ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
-				cur_offset, drop_args.drop_end - cur_offset);
+		ret = btrfs_inode_clear_file_extent_range(inode, cur_offset,
+					drop_args.drop_end - cur_offset);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_trans;
@@ -2822,7 +2821,7 @@ int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 
 	}
 	if (extent_info) {
-		ret = btrfs_insert_replace_extent(trans, BTRFS_I(inode), path,
+		ret = btrfs_insert_replace_extent(trans, inode, path,
 				extent_info, extent_info->data_len,
 				drop_args.bytes_found);
 		if (ret) {
@@ -2967,8 +2966,8 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out;
 	}
 
-	ret = btrfs_replace_file_extents(inode, path, lockstart, lockend, NULL,
-				     &trans);
+	ret = btrfs_replace_file_extents(BTRFS_I(inode), path, lockstart,
+					 lockend, NULL, &trans);
 	btrfs_free_path(path);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 79ed01de7a52..48e36c5af7c7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9915,7 +9915,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	ret = btrfs_replace_file_extents(&inode->vfs_inode, path, file_offset,
+	ret = btrfs_replace_file_extents(inode, path, file_offset,
 				     file_offset + len - 1, &extent_info,
 				     &trans);
 	btrfs_free_path(path);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b24396cf2f99..bcfa112af4a0 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -482,9 +482,9 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
 			clone_info.is_new_extent = false;
-			ret = btrfs_replace_file_extents(inode, path, drop_start,
-					new_key.offset + datal - 1, &clone_info,
-					&trans);
+			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
+					drop_start, new_key.offset + datal - 1,
+					&clone_info, &trans);
 			if (ret)
 				goto out;
 		} else if (type == BTRFS_FILE_EXTENT_INLINE) {
@@ -553,8 +553,8 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		 */
 		btrfs_release_path(path);
 
-		ret = btrfs_replace_file_extents(inode, path, last_dest_end,
-				destoff + len - 1, NULL, &trans);
+		ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
+				last_dest_end, destoff + len - 1, NULL, &trans);
 		if (ret)
 			goto out;
 
-- 
2.25.1

