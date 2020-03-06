Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C255917C4E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCFRus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 12:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCFRus (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 12:50:48 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B30A20656;
        Fri,  6 Mar 2020 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583517047;
        bh=mLspBd+szpTocknckIm5hdqvMgHFpcQlxGiqInel8i0=;
        h=From:To:Cc:Subject:Date:From;
        b=o26QhxNJYS/v34CQUik0X09UKoZRhZlyI/HAkPzqOLD3LG3YINdvm9il2O+7WJxvW
         fS3aJA9WZNKzIbsdBDIWSwfKeGwqCzb8zRe2a7AkfmB9ebJ1/VHRuq8DSP/B8rYDe6
         JeEp9A81DQEfcXlHuhoGNW7QUW0cC6wbobLziBTE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH v2 4/4] Btrfs: make ranged full fsyncs more efficient
Date:   Fri,  6 Mar 2020 17:50:44 +0000
Message-Id: <20200306175044.25402-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Commit 0c713cbab6200b ("Btrfs: fix race between ranged fsync and writeback
of adjacent ranges") fixed a bug where we could end up with file extent
items in a log tree that represent file ranges that overlap due to a race
between the hole detection of a ranged full fsync and writeback for a
different file range.

The problem was solved by forcing any ranged full fsync to become a
non-ranged full fsync - setting the range start to 0 and the end offset to
LLONG_MAX. This was a simple solution because the code that detected and
marked holes was very complex, it used to be done at copy_items() and
implied several searches on the fs/subvolume tree. The drawback of that
solution was that we started to flush delalloc for the entire file and
wait for all the ordered extents to complete for ranged full fsyncs
(including ordered extents covering ranges completely outside the given
range). Fortunatelly ranged full fsyncs are not the most common case
(hopefully for most workloads).

However a later fix for detecting and marking holes was made by commit
0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync
when using NO_HOLES") and it simplified a lot the detection of holes,
and now copy_items() no longer does it and we do it in a much more simple
way at btrfs_log_holes().

This makes it now possible to simply make the code that detects holes to
operate only on the initial range and no longer need to operate on the
whole file, while also avoiding the need to flush delalloc for the entire
file and wait for ordered extents that cover ranges that don't overlap the
given range.

Another special care is that we must skip file extent items that fall
entirely outside the fsync range when copying inode items from the
fs/subvolume tree into the log tree - this is to avoid races with ordered
extent completion for extents falling outside the fsync range, which could
cause us to end up with file extent items in the log tree that have
overlapping ranges - for example if the fsync range is [1Mb, 2Mb], when
we copy inode items we could copy an extent item for the range [0, 512K],
then release the search path and before moving to the next leaf, an
ordered extent for a range of [256Kb, 512Kb] completes - this would
cause us to copy the new extent item for range [256Kb, 512Kb] into the
log tree after we have copied one for the range [0, 512Kb] - the extents
overlap, resulting in a corruption.

So this change just does these steps:

1) When the NO_HOLES feature is enabled it leaves the initial range
   intact - no longer sets it to [0, LLONG_MAX] when the full sync bit
   is set in the inode. If NO_HOLES is not enabled, always set the range
   to a full, just like before this change, to avoid missing file extent
   items representing holes after replaying the log;

2) Make the hole detection code to operate only on the fsync range;

3) Make the code that copies items from the fs/subvolume tree to skip
   copying file extent items that cover a range completely outside the
   range of the fsync.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c     | 12 ++-----
 fs/btrfs/tree-log.c | 93 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7b189b9eb228..d14c903cc1a7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2094,19 +2094,11 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	atomic_inc(&root->log_batch);
 
 	/*
-	 * If the inode needs a full sync, make sure we use a full range to
-	 * avoid log tree corruption, due to hole detection racing with ordered
-	 * extent completion for adjacent ranges, and assertion failures during
-	 * hole detection. Do this while holding the inode lock, to avoid races
-	 * with other tasks.
-	 *
-	 * Also set the range to full if the NO_HOLES feature is not enabled.
+	 * Set the range to full if the NO_HOLES feature is not enabled.
 	 * This is to avoid missing file extent items representing holes after
 	 * replaying the log.
 	 */
-	if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-		     &BTRFS_I(inode)->runtime_flags) ||
-	    !btrfs_fs_incompat(fs_info, NO_HOLES)) {
+	if (!btrfs_fs_incompat(fs_info, NO_HOLES)) {
 		start = 0;
 		end = LLONG_MAX;
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index bd4854ced55d..d8cc46517865 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -96,8 +96,8 @@ enum {
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root, struct btrfs_inode *inode,
 			   int inode_only,
-			   const loff_t start,
-			   const loff_t end,
+			   u64 start,
+			   u64 end,
 			   struct btrfs_log_ctx *ctx);
 static int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
@@ -4534,13 +4534,15 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_inode *inode,
-			   struct btrfs_path *path)
+			   struct btrfs_path *path,
+			   const u64 start,
+			   const u64 end)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
 	const u64 ino = btrfs_ino(inode);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
-	u64 prev_extent_end = 0;
+	u64 prev_extent_end = start;
 	int ret;
 
 	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || i_size == 0)
@@ -4548,14 +4550,21 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 
 	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
-	key.offset = 0;
+	key.offset = start;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 
+	if (ret > 0 && path->slots[0] > 0) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
+		if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
+			path->slots[0]--;
+	}
+
 	while (true) {
 		struct extent_buffer *leaf = path->nodes[0];
+		u64 extent_end;
 
 		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 			ret = btrfs_next_leaf(root, path);
@@ -4572,9 +4581,18 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 		if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
 			break;
 
+		extent_end = btrfs_file_extent_end(path);
+		if (extent_end <= start)
+			goto next_slot;
+
 		/* We have a hole, log it. */
 		if (prev_extent_end < key.offset) {
-			const u64 hole_len = key.offset - prev_extent_end;
+			u64 hole_len;
+
+			if (key.offset >= end)
+				hole_len = end - prev_extent_end;
+			else
+				hole_len = key.offset - prev_extent_end;
 
 			/*
 			 * Release the path to avoid deadlocks with other code
@@ -4604,16 +4622,20 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			leaf = path->nodes[0];
 		}
 
-		prev_extent_end = btrfs_file_extent_end(path);
+		prev_extent_end = min(extent_end, end);
+		if (extent_end >= end)
+			break;
+next_slot:
 		path->slots[0]++;
 		cond_resched();
 	}
 
-	if (prev_extent_end < i_size) {
+	if (prev_extent_end < end && prev_extent_end < i_size) {
 		u64 hole_len;
 
 		btrfs_release_path(path);
-		hole_len = ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
+		hole_len = min(ALIGN(i_size, fs_info->sectorsize), end);
+		hole_len -= prev_extent_end;
 		ret = btrfs_insert_file_extent(trans, root->log_root,
 					       ino, prev_extent_end, 0, 0,
 					       hole_len, 0, hole_len,
@@ -4950,6 +4972,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				   const u64 logged_isize,
 				   const bool recursive_logging,
 				   const int inode_only,
+				   const u64 start,
+				   const u64 end,
 				   struct btrfs_log_ctx *ctx,
 				   bool *need_log_inode_item)
 {
@@ -4958,6 +4982,21 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 	int ins_nr = 0;
 	int ret;
 
+	/*
+	 * We must make sure we don't copy extent items that are entirely out of
+	 * the range [start, end - 1]. This is not just an optimization to avoid
+	 * copying but also needed to avoid a corruption where we end up with
+	 * file extent items in the log tree that have overlapping ranges - this
+	 * can happen if we race with ordered extent completion for ranges that
+	 * are outside our target range. For example we copy an extent item and
+	 * when we move to the next leaf, that extent was trimmed and a new one
+	 * covering a subrange of it, but with a higher key, was inserted - we
+	 * would then copy this other extent too, resulting in a log tree with
+	 * 2 extent items that represent overlapping ranges.
+	 *
+	 * We can copy the entire extents at the range bondaries however, even
+	 * if they cover an area outside the target range. That's ok.
+	 */
 	while (1) {
 		ret = btrfs_search_forward(root, min_key, path, trans->transid);
 		if (ret < 0)
@@ -5026,6 +5065,29 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 			goto next_slot;
 		}
 
+		if (min_key->type == BTRFS_EXTENT_DATA_KEY) {
+			const u64 extent_end = btrfs_file_extent_end(path);
+
+			if (extent_end <= start) {
+				if (ins_nr > 0) {
+					ret = copy_items(trans, inode, dst_path,
+							 path, ins_start_slot,
+							 ins_nr, inode_only,
+							 logged_isize);
+					if (ret < 0)
+						return ret;
+					ins_nr = 0;
+				}
+				goto next_slot;
+			}
+			if (extent_end >= end) {
+				ins_nr++;
+				if (ins_nr == 1)
+					ins_start_slot = path->slots[0];
+				break;
+			}
+		}
+
 		if (ins_nr && ins_start_slot + ins_nr == path->slots[0]) {
 			ins_nr++;
 			goto next_slot;
@@ -5093,8 +5155,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root, struct btrfs_inode *inode,
 			   int inode_only,
-			   const loff_t start,
-			   const loff_t end,
+			   u64 start,
+			   u64 end,
 			   struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -5122,6 +5184,9 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	}
 
+	start = ALIGN_DOWN(start, fs_info->sectorsize);
+	end = ALIGN(end, fs_info->sectorsize);
+
 	min_key.objectid = ino;
 	min_key.type = BTRFS_INODE_ITEM_KEY;
 	min_key.offset = 0;
@@ -5237,8 +5302,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	err = copy_inode_items_to_log(trans, inode, &min_key, &max_key,
 				      path, dst_path, logged_isize,
-				      recursive_logging, inode_only, ctx,
-				      &need_log_inode_item);
+				      recursive_logging, inode_only,
+				      start, end, ctx, &need_log_inode_item);
 	if (err)
 		goto out_unlock;
 
@@ -5251,7 +5316,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
-		err = btrfs_log_holes(trans, root, inode, path);
+		err = btrfs_log_holes(trans, root, inode, path, start, end);
 		if (err)
 			goto out_unlock;
 	}
-- 
2.11.0

