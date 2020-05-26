Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF11A0C14
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 12:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgDGKht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 06:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGKhs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 06:37:48 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869BC20644
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Apr 2020 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255867;
        bh=KOw6Y9orFyE6FiTwY/Gv05/CtQh3JOXjymKT7w96oQ8=;
        h=From:To:Subject:Date:From;
        b=nz/d5b9cY9KcD1qNy5fSIZEgtS/UbPg5Hy96GyWxV/olH7Dw9XKjLQcxjtxayPK0e
         bDigY1PUztCXzi9q45kY0Jbms5l8E60MJqtQUs01JIDaeCVJmjMpmNu9IpuhbvWAZO
         6LIf1ozCU3uKwyRSg+G1vVrixQXBQumOMUORlqXY=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: make full fsyncs always operate on the entire file again
Date:   Tue,  7 Apr 2020 11:37:44 +0100
Message-Id: <20200407103744.5960-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit 0a8068a3dd4294 ("btrfs: make ranged full fsyncs more efficient")
made full fsyncs operate on the given range only as it assumed it was safe
when using the NO_HOLES feature, since the hole detection was simplified
some time ago and no longer was a source for races with ordered extent
completion of adjacent file ranges.

However it's still not safe to have a full fsync only operate on the given
range, because extent maps for new extents might not be present in memory
due to inode eviction or extent cloning. Consider the following example:

1) We are currently at transaction N;

2) We write to the file range [0, 1Mb[;

3) Writeback finishes for the whole range and ordered extents complete,
   while we are still at transaction N;

4) The inode is evicted;

5) We open the file for writing, causing the inode to be loaded to
   memory again, which sets the 'full sync' bit on its flags. At this
   point the inode's list of modified extent maps is empty (figuring
   out which extents were created in the current transaction and were
   not yet logged by an fsync is expensive, that's why we set the
   'full sync' bit when loading an inode);

6) We write to the file range [512Kb, 768Kb[;

7) We do a ranged fsync (such as msync()) for file range [512Kb, 768Kb[.
   This correctly flushes this range and logs its extent into the log
   tree. When the writeback started an extent map for range [512Kb, 768Kb[
   was added to the inode's list of modified extents, and when the fsync()
   finishes logging it removes that extent map from the list of modified
   extent maps. This fsync also clears the 'full sync' bit;

8) We do a regular fsync() (full ranged). This fsync() ends up doing
   nothing because the inode's list of modified extents is empty and
   no other changes happened since the previous ranged fsync(), so
   it just returns success (0) and we end up never logging extents for
   the file ranges [0, 512Kb[ and [768Kb, 1Mb[.

Another scenario where this can happen is if we replace steps 2 to 4 with
cloning from another file into our test file, as that sets the 'full sync'
bit in our inode's flags and does not populate its list of modified extent
maps.

This was causing test case generic/457 to fail sporadically when using the
NO_HOLES feature, as it exercised this later case where the inode has the
'full sync' bit set and has no extent maps in memory to represent the new
extents due to extent cloning.

Fix this by reverting commit 0a8068a3dd4294 ("btrfs: make ranged full fsyncs
more efficient") since there is no easy way to work around it.

Fixes: 0a8068a3dd4294 ("btrfs: make ranged full fsyncs more efficient")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c     | 14 +++++++++
 fs/btrfs/tree-log.c | 91 ++++++++---------------------------------------------
 2 files changed, 27 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8a144f9cb7ac..750965088c83 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2097,6 +2097,20 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	atomic_inc(&root->log_batch);
 
+        /*
+        * If the inode needs a full sync, make sure we use a full range to avoid
+        * log tree corruption, due to hole detection racing with ordered extent
+        * completion for adjacent ranges and races between logging and completion
+	* of ordered extents for adjance ranges - both races could lead to file
+	* extent items in the log with overlapping ranges.
+	* Do this while holding the inode lock, to avoid races with other tasks.
+        */
+	if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
+		     &BTRFS_I(inode)->runtime_flags)) {
+		start = 0;
+		end = LLONG_MAX;
+	}
+
 	/*
 	 * Before we acquired the inode's lock, someone may have dirtied more
 	 * pages in the target range. We need to make sure that writeback for
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 58c111474ba5..4272610d7472 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -96,8 +96,8 @@ enum {
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root, struct btrfs_inode *inode,
 			   int inode_only,
-			   u64 start,
-			   u64 end,
+			   const loff_t start,
+			   const loff_t end,
 			   struct btrfs_log_ctx *ctx);
 static int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
@@ -4533,15 +4533,13 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_inode *inode,
-			   struct btrfs_path *path,
-			   const u64 start,
-			   const u64 end)
+			   struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
 	const u64 ino = btrfs_ino(inode);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
-	u64 prev_extent_end = start;
+	u64 prev_extent_end = 0;
 	int ret;
 
 	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || i_size == 0)
@@ -4549,21 +4547,14 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 
 	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = start;
+	key.offset = 0;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 
-	if (ret > 0 && path->slots[0] > 0) {
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
-		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
-			path->slots[0]--;
-	}
-
 	while (true) {
 		struct extent_buffer *leaf = path->nodes[0];
-		u64 extent_end;
 
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 			ret = btrfs_next_leaf(root, path);
@@ -4580,18 +4571,9 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
-		extent_end = btrfs_file_extent_end(path);
-		if (extent_end <= start)
-			goto next_slot;
-
 		/* We have a hole, log it. */
 		if (prev_extent_end < key.offset) {
-			u64 hole_len;
-
-			if (key.offset >= end)
-				hole_len = end - prev_extent_end;
-			else
-				hole_len = key.offset - prev_extent_end;
+			const u64 hole_len = key.offset - prev_extent_end;
 
 			/*
 			 * Release the path to avoid deadlocks with other code
@@ -4621,20 +4603,16 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			leaf = path->nodes[0];
 		}
 
-		prev_extent_end = min(extent_end, end);
-		if (extent_end >= end)
-			break;
-next_slot:
+		prev_extent_end = btrfs_file_extent_end(path);
 		path->slots[0]++;
 		cond_resched();
 	}
 
-	if (prev_extent_end < end && prev_extent_end < i_size) {
+	if (prev_extent_end < i_size) {
 		u64 hole_len;
 
 		btrfs_release_path(path);
-		hole_len = min(ALIGN(i_size, fs_info->sectorsize), end);
-		hole_len -= prev_extent_end;
+		hole_len = ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
 		ret = btrfs_insert_file_extent(trans, root->log_root,
 					       ino, prev_extent_end, 0, 0,
 					       hole_len, 0, hole_len,
@@ -4971,8 +4949,6 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				   const u64 logged_isize,
 				   const bool recursive_logging,
 				   const int inode_only,
-				   const u64 start,
-				   const u64 end,
 				   struct btrfs_log_ctx *ctx,
 				   bool *need_log_inode_item)
 {
@@ -4981,21 +4957,6 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 	int ins_nr = 0;
 	int ret;
 
-	/*
-	 * We must make sure we don't copy extent items that are entirely out of
-	 * the range [start, end - 1]. This is not just an optimization to avoid
-	 * copying but also needed to avoid a corruption where we end up with
-	 * file extent items in the log tree that have overlapping ranges - this
-	 * can happen if we race with ordered extent completion for ranges that
-	 * are outside our target range. For example we copy an extent item and
-	 * when we move to the next leaf, that extent was trimmed and a new one
-	 * covering a subrange of it, but with a higher key, was inserted - we
-	 * would then copy this other extent too, resulting in a log tree with
-	 * 2 extent items that represent overlapping ranges.
-	 *
-	 * We can copy the entire extents at the range bondaries however, even
-	 * if they cover an area outside the target range. That's ok.
-	 */
 	while (1) {
 		ret = btrfs_search_forward(root, min_key, path, trans->transid);
 		if (ret < 0)
@@ -5063,29 +5024,6 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 			goto next_slot;
 		}
 
-		if (min_key->type == BTRFS_EXTENT_DATA_KEY) {
-			const u64 extent_end = btrfs_file_extent_end(path);
-
-			if (extent_end <= start) {
-				if (ins_nr > 0) {
-					ret = copy_items(trans, inode, dst_path,
-							 path, ins_start_slot,
-							 ins_nr, inode_only,
-							 logged_isize);
-					if (ret < 0)
-						return ret;
-					ins_nr = 0;
-				}
-				goto next_slot;
-			}
-			if (extent_end >= end) {
-				ins_nr++;
-				if (ins_nr == 1)
-					ins_start_slot = path->slots[0];
-				break;
-			}
-		}
-
 		if (ins_nr && ins_start_slot + ins_nr == path->slots[0]) {
 			ins_nr++;
 			goto next_slot;
@@ -5151,8 +5089,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root, struct btrfs_inode *inode,
 			   int inode_only,
-			   u64 start,
-			   u64 end,
+			   const loff_t start,
+			   const loff_t end,
 			   struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -5180,9 +5118,6 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
-	start = ALIGN_DOWN(start, fs_info->sectorsize);
-	end = ALIGN(end, fs_info->sectorsize);
-
 	min_key.objectid = ino;
 	min_key.type = BTRFS_INODE_ITEM_KEY;
 	min_key.offset = 0;
@@ -5299,7 +5234,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	err = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
 				      path, dst_path, logged_isize,
 				      recursive_logging, inode_only,
-				      start, end, ctx, &need_log_inode_item);
+				      ctx, &need_log_inode_item);
 	if (err)
 		goto out_unlock;
 
@@ -5312,7 +5247,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-		err = btrfs_log_holes(trans, root, inode, path, start, end);
+		err = btrfs_log_holes(trans, root, inode, path);
 		if (err)
 			goto out_unlock;
 	}
-- 
2.11.0

