Return-Path: <linux-btrfs+bounces-10232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1509ECF10
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB24283A6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E01D0F50;
	Wed, 11 Dec 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns6+8EQ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BC19F12A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928817; cv=none; b=KXaaTZZ0Hvko9XjQ0GrD0vg+e2o+4Pu4DqswktHITbN/BnoVePBJUjbYF7joAl+QjHshXaCOjwQ2uh9Uea5vZqvWgAzLSxHL4mCp7Jla+zbu3fcP6ObWjDVYoqMoOP1W5e3+ZsbNNW83OMg+AI80wuWn4tpZLcxlP6NBoZpE8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928817; c=relaxed/simple;
	bh=6VwCPiBsWimEYCZeJJjWMXSayHBnPW9jPdrAz7rOh6c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUX95gao9EkTxfyTmigCI0jxMn5E+syWw+W/uGp3lB3aj6aYQDzesgyhzBv/ApHAToMXCyY7r+wG6lvP92TbU9uc6JkpDG3KK7hZJST/U5+UsQ94o520UB4YHf442yakV9KHct4AFSakH7aVnkcbW9ceEsC1SPijHcxEjgk2eDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns6+8EQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FEFC4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928816;
	bh=6VwCPiBsWimEYCZeJJjWMXSayHBnPW9jPdrAz7rOh6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ns6+8EQ5VZeaSXtMcYqN5qcrCmJ7u0orDa+dhimtJO2/X215c+rUs2HoAMq+UR6PT
	 iPZd/8SYJgOjiwBS+5DZkaBpI/8u47Yz5fItC9J8RrpiwFEioC5EwI1XlqO9JSvrTP
	 vSIXTgBx+8jGx9uyB8Jubo6wdOjdPuS0u5bYr8vmCMQdXhNvQOCFuhr2OHQ7JZddlb
	 vmW+J1Wr2yicxe8d3mv0QekCy4+IFuli3QXD2+TXf0PRDAmippeyzsenTj+aO6LmW2
	 iMecbN2yYYKO2Otrmv5vZ2dGltevVcJSizgzy1cZG3IjIB+zXnd0xJdA7iXYtYXJ5z
	 U6v+O9oFXSF0g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: remove no longer needed strict argument from can_nocow_extent()
Date: Wed, 11 Dec 2024 14:53:22 +0000
Message-Id: <2aa371a0b76fa92f94b7ec408788381530a3bf8e.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
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


