Return-Path: <linux-btrfs+bounces-10245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B99ECF4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE101169786
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073DC17D358;
	Wed, 11 Dec 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMZq3td/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FC1C1F1D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929517; cv=none; b=G0yTQuVZbbd7Cm/eJfdgUfVJI4q8+lHuA3UCRTqrWFMLGrWHlE1G1lF0vmRmLfxLVmMFiGaTpFuJYqzI23xX5lkjYGlGGLy72/cZ/HodgBpHFbZH5YGbIAT2+XfhHWWEGOWsmXeiTlHhqtlrZRBoXhmPA1IdFuakt4MJ4fULmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929517; c=relaxed/simple;
	bh=6VwCPiBsWimEYCZeJJjWMXSayHBnPW9jPdrAz7rOh6c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAMFChlvjwDraJ7IK6QGYbq4XtQYOI33jyq+GkB9OvByeR/uw7kzbRFBPP7srRaJYMOUP5z528JIT0ExgD8POwN9RoAMaE5QvcAwa9Y5Cptc54rzS0S1cNJ8QoPaexUvOQdTCfpx9qfgunVteWUf9vtPwQBlfVsFWg+BpaVui3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMZq3td/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8050AC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929517;
	bh=6VwCPiBsWimEYCZeJJjWMXSayHBnPW9jPdrAz7rOh6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MMZq3td/T1OOSBFdGrk/Ls603dVPiD+Us7XT4w5+oZ9eVwKHJpyt1pDqo+akiHOUg
	 TBmF/TfjxERFwOlYLDGCu1M4wzo1mjPD85hU8rKCL1DvLNSc1xUf2SL9ReTfTA/Ioe
	 0/TvklAB3SUALNrqU7ZCQvhMMfmvgTDL4RSdLYqCjFkAhAO0SW907oYT8VD/EsVeer
	 lSleuNMMTpf2mifBS5qZSk8o9O8u7IfGmra8Iw2XVNU64uWj4ttYxh1x7QRRll6Dce
	 QcXrHVKwh228XytvBmyowRPhICrQX9x4ZxsscstJdDZwakMKem1CTr97eB2EOAQJhR
	 +Wd4fS6+AvGvQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/11] btrfs: remove no longer needed strict argument from can_nocow_extent()
Date: Wed, 11 Dec 2024 15:05:02 +0000
Message-Id: <2aa371a0b76fa92f94b7ec408788381530a3bf8e.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All callers of can_nocow_extent() now pass a value of false for its
'strict' argument, making it redundant. So remove the argument from
can_nocow_extent() as well as can_nocow_file_extent(),
btrfs_cross_ref_exist() and check_committed_ref(), because this
argument was used just to influence the behavior of check_committed_ref().
Also remove the 'strict' field from struct can_nocow_file_extent_args,
which is now always false as well, as its value is taken from the
argument to can_nocow_extent().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/direct-io.c   |  3 +--
 fs/btrfs/extent-tree.c | 15 ++++++---------
 fs/btrfs/extent-tree.h |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 11 +++--------
 6 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index aa1f55cd81b7..b2fa33911c28 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -526,7 +526,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
-			      bool nowait, bool strict);
+			      bool nowait);
 
 void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index a7c3e221378d..8567af46e16f 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -248,8 +248,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		len = min(len, em->len - (start - em->start));
 		block_start = extent_map_block_start(em) + (start - em->start);
 
-		if (can_nocow_extent(inode, start, &len,
-				     &file_extent, false, false) == 1) {
+		if (can_nocow_extent(inode, start, &len, &file_extent, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2f9126528a01..46a3a4a4536b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2296,8 +2296,7 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 
 static noinline int check_committed_ref(struct btrfs_root *root,
 					struct btrfs_path *path,
-					u64 objectid, u64 offset, u64 bytenr,
-					bool strict)
+					u64 objectid, u64 offset, u64 bytenr)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
@@ -2361,11 +2360,10 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 
 	/*
 	 * If extent created before last snapshot => it's shared unless the
-	 * snapshot has been deleted. Use the heuristic if strict is false.
+	 * snapshot has been deleted.
 	 */
-	if (!strict &&
-	    (btrfs_extent_generation(leaf, ei) <=
-	     btrfs_root_last_snapshot(&root->root_item)))
+	if (btrfs_extent_generation(leaf, ei) <=
+	    btrfs_root_last_snapshot(&root->root_item))
 		goto out;
 
 	/* If this extent has SHARED_DATA_REF then it's shared */
@@ -2387,13 +2385,12 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 }
 
 int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
-			  u64 bytenr, bool strict, struct btrfs_path *path)
+			  u64 bytenr, struct btrfs_path *path)
 {
 	int ret;
 
 	do {
-		ret = check_committed_ref(root, path, objectid,
-					  offset, bytenr, strict);
+		ret = check_committed_ref(root, path, objectid, offset, bytenr);
 		if (ret && ret != -ENOENT)
 			goto out;
 
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 2ad51130c037..ee62035c4a71 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -117,7 +117,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    const struct extent_buffer *eb);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
-			  u64 objectid, u64 offset, u64 bytenr, bool strict,
+			  u64 objectid, u64 offset, u64 bytenr,
 			  struct btrfs_path *path);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c61f210259d8..a2fb100fd017 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1069,7 +1069,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			       NULL, nowait, false);
+			       NULL, nowait);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 283199d11642..0965a29cf4f7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1837,7 +1837,6 @@ struct can_nocow_file_extent_args {
 	/* End file offset (inclusive) of the range we want to NOCOW. */
 	u64 end;
 	bool writeback_path;
-	bool strict;
 	/*
 	 * Free the path passed to can_nocow_file_extent() once it's not needed
 	 * anymore.
@@ -1892,8 +1891,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 * for its subvolume was created, then this implies the extent is shared,
 	 * hence we must COW.
 	 */
-	if (!args->strict &&
-	    btrfs_file_extent_generation(leaf, fi) <=
+	if (btrfs_file_extent_generation(leaf, fi) <=
 	    btrfs_root_last_snapshot(&root->root_item))
 		goto out;
 
@@ -1924,7 +1922,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
 				    key->offset - args->file_extent.offset,
-				    args->file_extent.disk_bytenr, args->strict, path);
+				    args->file_extent.disk_bytenr, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;
@@ -7011,8 +7009,6 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  * @orig_start:	(optional) Return the original file offset of the file extent
  * @orig_len:	(optional) Return the original on-disk length of the file extent
  * @ram_bytes:	(optional) Return the ram_bytes of the file extent
- * @strict:	if true, omit optimizations that might force us into unnecessary
- *		cow. e.g., don't trust generation number.
  *
  * Return:
  * >0	and update @len if we can do nocow write
@@ -7024,7 +7020,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
-			      bool nowait, bool strict)
+			      bool nowait)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
@@ -7077,7 +7073,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 
 	nocow_args.start = offset;
 	nocow_args.end = offset + *len - 1;
-	nocow_args.strict = strict;
 	nocow_args.free_path = true;
 
 	ret = can_nocow_file_extent(path, &key, BTRFS_I(inode), &nocow_args);
-- 
2.45.2


