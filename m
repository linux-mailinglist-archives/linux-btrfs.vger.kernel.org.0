Return-Path: <linux-btrfs+bounces-3751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFE891A5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B7BB22148
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A82C1586FD;
	Fri, 29 Mar 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7PIKq1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8A1586E9;
	Fri, 29 Mar 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715495; cv=none; b=jSWMilphJWCWQvzo6ifKdLrBAnVJmcQlX80QHM9UB4RLNWqIGoovjXTDiYA9y48/iPQljEQGCN+rgUvF2vfC8sxtfaiUOz0qCaIXVfRNv8AY3sMflJbvyX2ZpLbg5axDx0y/QS6g8WpkQ66iHMa2CiYPFU8pD1lTCxiOwMN4/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715495; c=relaxed/simple;
	bh=2OXrj8pdjP/cFaSKQFC10cyVukXIyvqpoBsTMboDDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVckDrmTOpgKtk7yO6lr4IuvQI6Uk/ZzbYX06XP3cj4fY82ptcmxgdJB3/U89jByma4ruHwmAkFCMYYNo8uGlpAtMHZVInrZ1LKjOYTivXCEUp9igno0k6Pqzd/ugR2jcXfL41bm3J6CDkoS6wBhXSlbIlEffVihEiDmUZu9QsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7PIKq1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613DEC433F1;
	Fri, 29 Mar 2024 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715495;
	bh=2OXrj8pdjP/cFaSKQFC10cyVukXIyvqpoBsTMboDDm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7PIKq1mg5jlBtySSPSpO3565+TVhoZYSccQhdClfzIN04fCA1pD0cRWvaU/SV9ti
	 Njc07T2br5qkAeaWpU0H3UEhI67u4At6qGe0nRHPrlZKSbvS+VDc/hLNt6raLae+hO
	 RpKj0NvTZp+N5EHPZdA/omKho6yC+h7vuKsUziPS4MA7FRNKldI0UUYFeyWPPFVdcg
	 wGBXJXP+vHnBPnWB/9e5Wai2ixBeOR2IOX3NHPniLV5QeZrfzUGkTg+EMQHrwc2w2H
	 K3tNkw9KuAVExtYGqgq93j+jJ0kkbPHNRq2A5l9HiCSke/BUqucB4Hp4GTRoiajlBe
	 Ac5HTJPyoN/Wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 44/52] btrfs: preallocate temporary extent buffer for inode logging when needed
Date: Fri, 29 Mar 2024 08:29:14 -0400
Message-ID: <20240329122956.3083859-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit e383e158ed1b6abc2d2d3e6736d77a46393f80fa ]

When logging an inode and we require to copy items from subvolume leaves
to the log tree, we clone each subvolume leaf and than use that clone to
copy items to the log tree. This is required to avoid possible deadlocks
as stated in commit 796787c978ef ("btrfs: do not modify log tree while
holding a leaf from fs tree locked").

The cloning requires allocating an extent buffer (struct extent_buffer)
and then allocating pages (folios) to attach to the extent buffer. This
may be slow in case we are under memory pressure, and since we are doing
the cloning while holding a read lock on a subvolume leaf, it means we
can be blocking other operations on that leaf for significant periods of
time, which can increase latency on operations like creating other files,
renaming files, etc. Similarly because we're under a log transaction, we
may also cause extra delay on other tasks doing an fsync, because syncing
the log requires waiting for tasks that joined a log transaction to exit
the transaction.

So to improve this, for any inode logging operation that needs to copy
items from a subvolume leaf ("full sync" or "copy everything" bit set
in the inode), preallocate a dummy extent buffer before locking any
extent buffer from the subvolume tree, and even before joining a log
transaction, add it to the log context and then use it when we need to
copy items from a subvolume leaf to the log tree. This avoids making
other operations get extra latency when waiting to lock a subvolume
leaf that is used during inode logging and we are under heavy memory
pressure.

The following test script with bonnie++ was used to test this:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdh
  MNT=/mnt/sdh
  MOUNT_OPTIONS="-o ssd"

  MEMTOTAL_BYTES=`free -b | grep Mem: | awk '{ print $2 }'`
  NR_DIRECTORIES=20
  NR_FILES=20480
  DATASET_SIZE=$((MEMTOTAL_BYTES * 2 / 1048576))
  DIRECTORY_SIZE=$((MEMTOTAL_BYTES * 2 / NR_FILES))
  NR_FILES=$((NR_FILES / 1024))

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  umount $DEV &> /dev/null
  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  bonnie++ -u root -d $MNT \
      -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
      -r 0 -s $DATASET_SIZE -b

  umount $MNT

The results of this test on a 8G VM running a non-debug kernel (Debian's
default kernel config), were the following.

Before this change:

  Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
  Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
  debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95 +++++ +++
  Latency             35068us   24976us    2944ms   30725us   71770us   26152us
  Version 2.00a       ------Sequential Create------ --------Random Create--------
  debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
  files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
  20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56 20480  61
  Latency               411ms   11914us     119ms     617ms   10296us     110ms

After this change:

  Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
  Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
  debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98 +++++ +++
  Latency             35975us  20945us    2144ms   10297us    2217us    6004us
  Version 2.00a       ------Sequential Create------ --------Random Create--------
  debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
  files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
  20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57 20480  59
  Latency               320ms   11237us   77779us     518ms    6470us   86389us

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c     | 12 ++++++
 fs/btrfs/tree-log.c | 93 +++++++++++++++++++++++++++------------------
 fs/btrfs/tree-log.h | 25 ++++++++++++
 3 files changed, 94 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c997b790568fa..ac697568887e8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1906,6 +1906,8 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out_release_extents;
 	}
 
+	btrfs_init_log_ctx_scratch_eb(&ctx);
+
 	/*
 	 * We use start here because we will need to wait on the IO to complete
 	 * in btrfs_sync_log, which could require joining a transaction (for
@@ -1925,6 +1927,15 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	trans->in_fsync = true;
 
 	ret = btrfs_log_dentry_safe(trans, dentry, &ctx);
+	/*
+	 * Scratch eb no longer needed, release before syncing log or commit
+	 * transaction, to avoid holding unnecessary memory during such long
+	 * operations.
+	 */
+	if (ctx.scratch_eb) {
+		free_extent_buffer(ctx.scratch_eb);
+		ctx.scratch_eb = NULL;
+	}
 	btrfs_release_log_ctx_extents(&ctx);
 	if (ret < 0) {
 		/* Fallthrough and commit/free transaction. */
@@ -2000,6 +2011,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	ret = btrfs_commit_transaction(trans);
 out:
+	free_extent_buffer(ctx.scratch_eb);
 	ASSERT(list_empty(&ctx.list));
 	ASSERT(list_empty(&ctx.conflict_inodes));
 	err = file_check_and_advance_wb_err(file);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9fb64af608d12..8eb5c725052b4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3627,6 +3627,30 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int clone_leaf(struct btrfs_path *path, struct btrfs_log_ctx *ctx)
+{
+	const int slot = path->slots[0];
+
+	if (ctx->scratch_eb) {
+		copy_extent_buffer_full(ctx->scratch_eb, path->nodes[0]);
+	} else {
+		ctx->scratch_eb = btrfs_clone_extent_buffer(path->nodes[0]);
+		if (!ctx->scratch_eb)
+			return -ENOMEM;
+	}
+
+	btrfs_release_path(path);
+	path->nodes[0] = ctx->scratch_eb;
+	path->slots[0] = slot;
+	/*
+	 * Add extra ref to scratch eb so that it is not freed when callers
+	 * release the path, so we can reuse it later if needed.
+	 */
+	atomic_inc(&ctx->scratch_eb->refs);
+
+	return 0;
+}
+
 static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode *inode,
 				  struct btrfs_path *path,
@@ -3641,23 +3665,20 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 	bool last_found = false;
 	int batch_start = 0;
 	int batch_size = 0;
-	int i;
+	int ret;
 
 	/*
 	 * We need to clone the leaf, release the read lock on it, and use the
 	 * clone before modifying the log tree. See the comment at copy_items()
 	 * about why we need to do this.
 	 */
-	src = btrfs_clone_extent_buffer(path->nodes[0]);
-	if (!src)
-		return -ENOMEM;
+	ret = clone_leaf(path, ctx);
+	if (ret < 0)
+		return ret;
 
-	i = path->slots[0];
-	btrfs_release_path(path);
-	path->nodes[0] = src;
-	path->slots[0] = i;
+	src = path->nodes[0];
 
-	for (; i < nritems; i++) {
+	for (int i = path->slots[0]; i < nritems; i++) {
 		struct btrfs_dir_item *di;
 		struct btrfs_key key;
 		int ret;
@@ -4267,17 +4288,16 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_path *dst_path,
 			       struct btrfs_path *src_path,
 			       int start_slot, int nr, int inode_only,
-			       u64 logged_isize)
+			       u64 logged_isize, struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *log = inode->root->log_root;
 	struct btrfs_file_extent_item *extent;
 	struct extent_buffer *src;
-	int ret = 0;
+	int ret;
 	struct btrfs_key *ins_keys;
 	u32 *ins_sizes;
 	struct btrfs_item_batch batch;
 	char *ins_data;
-	int i;
 	int dst_index;
 	const bool skip_csum = (inode->flags & BTRFS_INODE_NODATASUM);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
@@ -4310,14 +4330,11 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	 * while the other is holding the delayed node's mutex and wants to
 	 * write lock the same subvolume leaf for flushing delayed items.
 	 */
-	src = btrfs_clone_extent_buffer(src_path->nodes[0]);
-	if (!src)
-		return -ENOMEM;
+	ret = clone_leaf(src_path, ctx);
+	if (ret < 0)
+		return ret;
 
-	i = src_path->slots[0];
-	btrfs_release_path(src_path);
-	src_path->nodes[0] = src;
-	src_path->slots[0] = i;
+	src = src_path->nodes[0];
 
 	ins_data = kmalloc(nr * sizeof(struct btrfs_key) +
 			   nr * sizeof(u32), GFP_NOFS);
@@ -4332,7 +4349,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	batch.nr = 0;
 
 	dst_index = 0;
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		const int src_slot = start_slot + i;
 		struct btrfs_root *csum_root;
 		struct btrfs_ordered_sum *sums;
@@ -4439,7 +4456,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		goto out;
 
 	dst_index = 0;
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		const int src_slot = start_slot + i;
 		const int dst_slot = dst_path->slots[0] + dst_index;
 		struct btrfs_key key;
@@ -4710,7 +4727,8 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
  */
 static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 				      struct btrfs_inode *inode,
-				      struct btrfs_path *path)
+				      struct btrfs_path *path,
+				      struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_key key;
@@ -4776,7 +4794,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			if (ins_nr > 0) {
 				ret = copy_items(trans, inode, dst_path, path,
-						 start_slot, ins_nr, 1, 0);
+						 start_slot, ins_nr, 1, 0, ctx);
 				if (ret < 0)
 					goto out;
 				ins_nr = 0;
@@ -4826,7 +4844,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	}
 	if (ins_nr > 0)
 		ret = copy_items(trans, inode, dst_path, path,
-				 start_slot, ins_nr, 1, 0);
+				 start_slot, ins_nr, 1, 0, ctx);
 out:
 	btrfs_release_path(path);
 	btrfs_free_path(dst_path);
@@ -4905,7 +4923,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	write_unlock(&tree->lock);
 
 	if (!ret)
-		ret = btrfs_log_prealloc_extents(trans, inode, path);
+		ret = btrfs_log_prealloc_extents(trans, inode, path, ctx);
 	if (ret)
 		return ret;
 
@@ -4986,7 +5004,8 @@ static int logged_inode_size(struct btrfs_root *log, struct btrfs_inode *inode,
 static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode,
 				struct btrfs_path *path,
-				struct btrfs_path *dst_path)
+				struct btrfs_path *dst_path,
+				struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
 	int ret;
@@ -5015,7 +5034,7 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 		if (slot >= nritems) {
 			if (ins_nr > 0) {
 				ret = copy_items(trans, inode, dst_path, path,
-						 start_slot, ins_nr, 1, 0);
+						 start_slot, ins_nr, 1, 0, ctx);
 				if (ret < 0)
 					return ret;
 				ins_nr = 0;
@@ -5041,7 +5060,7 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 	}
 	if (ins_nr > 0) {
 		ret = copy_items(trans, inode, dst_path, path,
-				 start_slot, ins_nr, 1, 0);
+				 start_slot, ins_nr, 1, 0, ctx);
 		if (ret < 0)
 			return ret;
 	}
@@ -5853,7 +5872,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				}
 				ret = copy_items(trans, inode, dst_path, path,
 						 ins_start_slot, ins_nr,
-						 inode_only, logged_isize);
+						 inode_only, logged_isize, ctx);
 				if (ret < 0)
 					return ret;
 				ins_nr = 0;
@@ -5872,7 +5891,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				goto next_slot;
 			ret = copy_items(trans, inode, dst_path, path,
 					 ins_start_slot,
-					 ins_nr, inode_only, logged_isize);
+					 ins_nr, inode_only, logged_isize, ctx);
 			if (ret < 0)
 				return ret;
 			ins_nr = 0;
@@ -5889,7 +5908,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		}
 
 		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
-				 ins_nr, inode_only, logged_isize);
+				 ins_nr, inode_only, logged_isize, ctx);
 		if (ret < 0)
 			return ret;
 		ins_nr = 1;
@@ -5904,7 +5923,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		if (ins_nr) {
 			ret = copy_items(trans, inode, dst_path, path,
 					 ins_start_slot, ins_nr, inode_only,
-					 logged_isize);
+					 logged_isize, ctx);
 			if (ret < 0)
 				return ret;
 			ins_nr = 0;
@@ -5929,7 +5948,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 	}
 	if (ins_nr) {
 		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
-				 ins_nr, inode_only, logged_isize);
+				 ins_nr, inode_only, logged_isize, ctx);
 		if (ret)
 			return ret;
 	}
@@ -5940,7 +5959,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		 * lock the same leaf with btrfs_log_prealloc_extents() below.
 		 */
 		btrfs_release_path(path);
-		ret = btrfs_log_prealloc_extents(trans, inode, dst_path);
+		ret = btrfs_log_prealloc_extents(trans, inode, dst_path, ctx);
 	}
 
 	return ret;
@@ -6532,7 +6551,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
-	ret = btrfs_log_all_xattrs(trans, inode, path, dst_path);
+	ret = btrfs_log_all_xattrs(trans, inode, path, dst_path, ctx);
 	if (ret)
 		goto out_unlock;
 	xattrs_logged = true;
@@ -6559,7 +6578,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		 * BTRFS_INODE_COPY_EVERYTHING set.
 		 */
 		if (!xattrs_logged && inode->logged_trans < trans->transid) {
-			ret = btrfs_log_all_xattrs(trans, inode, path, dst_path);
+			ret = btrfs_log_all_xattrs(trans, inode, path, dst_path, ctx);
 			if (ret)
 				goto out_unlock;
 			btrfs_release_path(path);
@@ -7510,6 +7529,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 
 	btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
 	ctx.logging_new_name = true;
+	btrfs_init_log_ctx_scratch_eb(&ctx);
 	/*
 	 * We don't care about the return value. If we fail to log the new name
 	 * then we know the next attempt to sync the log will fallback to a full
@@ -7518,6 +7538,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * inconsistent state after a rename operation.
 	 */
 	btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
+	free_extent_buffer(ctx.scratch_eb);
 	ASSERT(list_empty(&ctx.conflict_inodes));
 out:
 	/*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index a550a8a375cd1..af219e8840d28 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -36,6 +36,15 @@ struct btrfs_log_ctx {
 	struct list_head conflict_inodes;
 	int num_conflict_inodes;
 	bool logging_conflict_inodes;
+	/*
+	 * Used for fsyncs that need to copy items from the subvolume tree to
+	 * the log tree (full sync flag set or copy everything flag set) to
+	 * avoid allocating a temporary extent buffer while holding a lock on
+	 * an extent buffer of the subvolume tree and under the log transaction.
+	 * Also helps to avoid allocating and freeing a temporary extent buffer
+	 * in case we need to process multiple leaves from the subvolume tree.
+	 */
+	struct extent_buffer *scratch_eb;
 };
 
 static inline void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,
@@ -53,6 +62,22 @@ static inline void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,
 	INIT_LIST_HEAD(&ctx->conflict_inodes);
 	ctx->num_conflict_inodes = 0;
 	ctx->logging_conflict_inodes = false;
+	ctx->scratch_eb = NULL;
+}
+
+static inline void btrfs_init_log_ctx_scratch_eb(struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
+
+	if (!test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
+	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
+		return;
+
+	/*
+	 * Don't care about allocation failure. This is just for optimization,
+	 * if we fail to allocate here, we will try again later if needed.
+	 */
+	ctx->scratch_eb = alloc_dummy_extent_buffer(inode->root->fs_info, 0);
 }
 
 static inline void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx)
-- 
2.43.0


