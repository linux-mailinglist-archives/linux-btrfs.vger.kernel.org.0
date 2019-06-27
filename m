Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A69587DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0RAr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 13:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0RAq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 13:00:46 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C6E20659
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2019 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561654845;
        bh=f8IzSZdFuBU/AzY7rp2iXrVzqkmkP0hAAiSHy/dNrw8=;
        h=From:To:Subject:Date:From;
        b=HVF3Qy2ucr+ItgB/cCBfdC7gGtz5WaqmDjO23lyzsiv3BaRQzAGUNUfb5OInsd99l
         2bmnEoctLEkIAAWsloMvIexMrnMYUC439Pv2w8k8/Wewdcel4HNSHZgJU9BlPTJR9S
         UQSxPWMFNtCkwsBZ7DtGqsFokChlPXleT/9Sm5Oc=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents
Date:   Thu, 27 Jun 2019 18:00:42 +0100
Message-Id: <20190627170042.6241-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
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
helper, which is what does the mentioned work for hole punching.

A test case for fstests follows soon.

Reported-by: David Goodwin <david@codepoets.co.uk>
Link: https://lore.kernel.org/linux-btrfs/a4a4cf31-9cf4-e52c-1f86-c62d336c9cd1@codepoets.co.uk/
Reported-by: Sam Tygier <sam@tygier.co.uk>
Link: https://lore.kernel.org/linux-btrfs/82aace9f-a1e3-1f0b-055f-3ea75f7a41a0@tygier.co.uk/
Fixes: b6f3409b2197e8f ("Btrfs: reserve sufficient space for ioctl clone")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h |  4 ++++
 fs/btrfs/file.c  | 26 +++++++++++++--------
 fs/btrfs/ioctl.c | 69 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c1a166706a77..66bf08ec82ef 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3345,6 +3345,10 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct inode *inode, u64 start,
 		       u64 end, int drop_cache);
+int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+			   const u64 start, const u64 end,
+			   const bool insert_holes,
+			   struct btrfs_trans_handle **trans_out);
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end);
 int btrfs_release_file(struct inode *inode, struct file *file);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 393a6d23b6b0..df9edf0af76a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2452,9 +2452,10 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
  * The respective range must have been previously locked, as well as the inode.
  * The end offset is inclusive (last byte of the range).
  */
-static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
-				  const u64 start, const u64 end,
-				  struct btrfs_trans_handle **trans_out)
+int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+			   const u64 start, const u64 end,
+			   const bool insert_holes,
+			   struct btrfs_trans_handle **trans_out)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 min_size = btrfs_calc_trans_metadata_size(fs_info, 1);
@@ -2482,9 +2483,14 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	/*
 	 * 1 - update the inode
 	 * 1 - removing the extents in the range
-	 * 1 - adding the hole extent if no_holes isn't set
+	 * 1 - adding the hole extent if no_holes isn't set or !insert_holes
+	 *     (used for extent cloning)
 	 */
-	rsv_count = btrfs_fs_incompat(fs_info, NO_HOLES) ? 2 : 3;
+	if (!btrfs_fs_incompat(fs_info, NO_HOLES) || !insert_holes)
+		rsv_count = 3;
+	else
+		rsv_count = 2;
+
 	trans = btrfs_start_transaction(root, rsv_count);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -2507,7 +2513,8 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 
-		if (cur_offset < drop_end && cur_offset < ino_size) {
+		if (insert_holes && cur_offset < drop_end &&
+		    cur_offset < ino_size) {
 			ret = fill_holes(trans, BTRFS_I(inode), path,
 					cur_offset, drop_end);
 			if (ret) {
@@ -2574,7 +2581,7 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 	 * (because it's useless) or if it represents a 0 bytes range (when
 	 * cur_offset == drop_end).
 	 */
-	if (cur_offset < ino_size && cur_offset < drop_end) {
+	if (insert_holes && cur_offset < ino_size && cur_offset < drop_end) {
 		ret = fill_holes(trans, BTRFS_I(inode), path,
 				cur_offset, drop_end);
 		if (ret) {
@@ -2589,7 +2596,7 @@ static int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 		goto out_free;
 
 	trans->block_rsv = &fs_info->trans_block_rsv;
-	if (ret)
+	if (ret && insert_holes)
 		btrfs_end_transaction(trans);
 	else
 		*trans_out = trans;
@@ -2719,7 +2726,8 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out;
 	}
 
-	ret = btrfs_punch_hole_range(inode, path, lockstart, lockend, &trans);
+	ret = btrfs_punch_hole_range(inode, path, lockstart, lockend, true,
+				     &trans);
 	btrfs_free_path(path);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2a1be0d1a698..95d2d0d90d20 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3682,17 +3682,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
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
 				/*
@@ -3710,17 +3699,20 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 					datal -= off - key.offset;
 				}
 
-				ret = btrfs_drop_extents(trans, root, inode,
-							 drop_start,
-							 new_key.offset + datal,
-							 1);
+				trans = NULL;
+				ret = btrfs_punch_hole_range(inode, path,
+						     drop_start,
+						     new_key.offset + datal - 1,
+						     false, &trans);
 				if (ret) {
-					if (ret != -EOPNOTSUPP)
+					if (trans && ret != -EOPNOTSUPP)
 						btrfs_abort_transaction(trans,
 									ret);
-					btrfs_end_transaction(trans);
+					if (trans)
+						btrfs_end_transaction(trans);
 					goto out;
 				}
+				ASSERT(trans != NULL);
 
 				ret = btrfs_insert_empty_item(trans, root, path,
 							      &new_key, size);
@@ -3781,12 +3773,27 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
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
@@ -3843,24 +3850,22 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		 * fully or partially overlaps our cloning range at its end.
 		 */
 		btrfs_release_path(path);
+		path->leave_spinning = 0;
 
-		/*
-		 * 1 - remove extent(s)
-		 * 1 - inode update
-		 */
-		trans = btrfs_start_transaction(root, 2);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			goto out;
-		}
-		ret = btrfs_drop_extents(trans, root, inode,
-					 last_dest_end, destoff + len, 1);
+		trans = NULL;
+		ret = btrfs_punch_hole_range(inode, path,
+					     last_dest_end, destoff + len - 1,
+					     false, &trans);
 		if (ret) {
-			if (ret != -EOPNOTSUPP)
-				btrfs_abort_transaction(trans, ret);
-			btrfs_end_transaction(trans);
+			if (trans) {
+				if (ret != -EOPNOTSUPP)
+					btrfs_abort_transaction(trans, ret);
+				btrfs_end_transaction(trans);
+			}
 			goto out;
 		}
+		ASSERT(trans != NULL);
+
 		clone_update_extent_map(BTRFS_I(inode), trans, NULL,
 				last_dest_end,
 				destoff + len - last_dest_end);
-- 
2.11.0

