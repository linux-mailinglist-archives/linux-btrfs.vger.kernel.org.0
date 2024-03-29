Return-Path: <linux-btrfs+bounces-3755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65AB891ABB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339501F2760D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEDB15E5D3;
	Fri, 29 Mar 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiJWdvh0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7215E5BF;
	Fri, 29 Mar 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715575; cv=none; b=d1YJcKOhL71gCmyTYtjc2urd0rxsh3GwRMODroBMlbT9WtLxCvagBMSRB5+RN7bHrYTStVNbz2S7xoiyMIikdlSuabfzPg8k3S7tUmOLOfpNCNUHLtRrJ9wjhikCn3mpbM78VS5hHcew8hRzibvc6bg8FKEdytgR2m+mt+hG5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715575; c=relaxed/simple;
	bh=PdZs25lxo3wWdfgZHeq4wLEib33kOBCXI220fQlWIUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRxYml0N2JDXr+U7gJf2TpWYN4PARB3Q/TGYiELapUbzLgrPgtEcuHhWNOpyIR3KHGaDrSR5Byt7JQhAcRVzvj2ph0I+55XSZQbOtz7Q74A+++56/IojXeB54hvHEvCFsICwCSXYwxaQT+iJzJfFSpgUASsWdYkh8viHe0X8oKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiJWdvh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6676C43394;
	Fri, 29 Mar 2024 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715575;
	bh=PdZs25lxo3wWdfgZHeq4wLEib33kOBCXI220fQlWIUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AiJWdvh05TaR36LjF8v+sulx0+eqqqaZwLC5Sq6kXBjA18mI3nre9r1nvJs3Pi04y
	 OI+3yK9/khWZU/FyJINi22dxtUQJ0dpOFF6fMcv9X1PpdgLM/8CkpzpVW89aHtiH7x
	 LiK57hb8Hm4CJ0G/+ntH4SDlZI65EqvP5xOtM8RFsu8IR4t0S+L79QAy+f041EQI4K
	 942TNVwtqrsFS9FqoCvMgc73BBtQYQXAUCpuVmk1Kz+BqFrPqXYXXcv6Tnii3Q1bsB
	 Vst6Nz1opE5YR2g5KDHm0EZVPXqJUv428645jYormLBwGrDSCZc8hUwq8BOKIxC2+d
	 nCh2yQDZN45MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/31] btrfs: preallocate temporary extent buffer for inode logging when needed
Date: Fri, 29 Mar 2024 08:31:43 -0400
Message-ID: <20240329123207.3085013-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 1783a0fbf1665..cc0067d00be62 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1905,6 +1905,8 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out_release_extents;
 	}
 
+	btrfs_init_log_ctx_scratch_eb(&ctx);
+
 	/*
 	 * We use start here because we will need to wait on the IO to complete
 	 * in btrfs_sync_log, which could require joining a transaction (for
@@ -1924,6 +1926,15 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
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
@@ -1999,6 +2010,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	ret = btrfs_commit_transaction(trans);
 out:
+	free_extent_buffer(ctx.scratch_eb);
 	ASSERT(list_empty(&ctx.list));
 	ASSERT(list_empty(&ctx.conflict_inodes));
 	err = file_check_and_advance_wb_err(file);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7c33b28c02aeb..b6af4922ad334 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3670,6 +3670,30 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
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
@@ -3684,23 +3708,20 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
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
@@ -4311,17 +4332,16 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
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
@@ -4354,14 +4374,11 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
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
@@ -4376,7 +4393,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	batch.nr = 0;
 
 	dst_index = 0;
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		const int src_slot = start_slot + i;
 		struct btrfs_root *csum_root;
 		struct btrfs_ordered_sum *sums;
@@ -4483,7 +4500,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		goto out;
 
 	dst_index = 0;
-	for (i = 0; i < nr; i++) {
+	for (int i = 0; i < nr; i++) {
 		const int src_slot = start_slot + i;
 		const int dst_slot = dst_path->slots[0] + dst_index;
 		struct btrfs_key key;
@@ -4755,7 +4772,8 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
  */
 static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 				      struct btrfs_inode *inode,
-				      struct btrfs_path *path)
+				      struct btrfs_path *path,
+				      struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_key key;
@@ -4821,7 +4839,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 		if (slot >= btrfs_header_nritems(leaf)) {
 			if (ins_nr > 0) {
 				ret = copy_items(trans, inode, dst_path, path,
-						 start_slot, ins_nr, 1, 0);
+						 start_slot, ins_nr, 1, 0, ctx);
 				if (ret < 0)
 					goto out;
 				ins_nr = 0;
@@ -4871,7 +4889,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	}
 	if (ins_nr > 0)
 		ret = copy_items(trans, inode, dst_path, path,
-				 start_slot, ins_nr, 1, 0);
+				 start_slot, ins_nr, 1, 0, ctx);
 out:
 	btrfs_release_path(path);
 	btrfs_free_path(dst_path);
@@ -4952,7 +4970,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	write_unlock(&tree->lock);
 
 	if (!ret)
-		ret = btrfs_log_prealloc_extents(trans, inode, path);
+		ret = btrfs_log_prealloc_extents(trans, inode, path, ctx);
 	if (ret)
 		return ret;
 
@@ -5033,7 +5051,8 @@ static int logged_inode_size(struct btrfs_root *log, struct btrfs_inode *inode,
 static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode,
 				struct btrfs_path *path,
-				struct btrfs_path *dst_path)
+				struct btrfs_path *dst_path,
+				struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_root *root = inode->root;
 	int ret;
@@ -5062,7 +5081,7 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 		if (slot >= nritems) {
 			if (ins_nr > 0) {
 				ret = copy_items(trans, inode, dst_path, path,
-						 start_slot, ins_nr, 1, 0);
+						 start_slot, ins_nr, 1, 0, ctx);
 				if (ret < 0)
 					return ret;
 				ins_nr = 0;
@@ -5088,7 +5107,7 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 	}
 	if (ins_nr > 0) {
 		ret = copy_items(trans, inode, dst_path, path,
-				 start_slot, ins_nr, 1, 0);
+				 start_slot, ins_nr, 1, 0, ctx);
 		if (ret < 0)
 			return ret;
 	}
@@ -5880,7 +5899,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				}
 				ret = copy_items(trans, inode, dst_path, path,
 						 ins_start_slot, ins_nr,
-						 inode_only, logged_isize);
+						 inode_only, logged_isize, ctx);
 				if (ret < 0)
 					return ret;
 				ins_nr = 0;
@@ -5899,7 +5918,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 				goto next_slot;
 			ret = copy_items(trans, inode, dst_path, path,
 					 ins_start_slot,
-					 ins_nr, inode_only, logged_isize);
+					 ins_nr, inode_only, logged_isize, ctx);
 			if (ret < 0)
 				return ret;
 			ins_nr = 0;
@@ -5916,7 +5935,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		}
 
 		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
-				 ins_nr, inode_only, logged_isize);
+				 ins_nr, inode_only, logged_isize, ctx);
 		if (ret < 0)
 			return ret;
 		ins_nr = 1;
@@ -5931,7 +5950,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		if (ins_nr) {
 			ret = copy_items(trans, inode, dst_path, path,
 					 ins_start_slot, ins_nr, inode_only,
-					 logged_isize);
+					 logged_isize, ctx);
 			if (ret < 0)
 				return ret;
 			ins_nr = 0;
@@ -5956,7 +5975,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 	}
 	if (ins_nr) {
 		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
-				 ins_nr, inode_only, logged_isize);
+				 ins_nr, inode_only, logged_isize, ctx);
 		if (ret)
 			return ret;
 	}
@@ -5967,7 +5986,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 		 * lock the same leaf with btrfs_log_prealloc_extents() below.
 		 */
 		btrfs_release_path(path);
-		ret = btrfs_log_prealloc_extents(trans, inode, dst_path);
+		ret = btrfs_log_prealloc_extents(trans, inode, dst_path, ctx);
 	}
 
 	return ret;
@@ -6560,7 +6579,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
-	ret = btrfs_log_all_xattrs(trans, inode, path, dst_path);
+	ret = btrfs_log_all_xattrs(trans, inode, path, dst_path, ctx);
 	if (ret)
 		goto out_unlock;
 	xattrs_logged = true;
@@ -6587,7 +6606,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		 * BTRFS_INODE_COPY_EVERYTHING set.
 		 */
 		if (!xattrs_logged && inode->logged_trans < trans->transid) {
-			ret = btrfs_log_all_xattrs(trans, inode, path, dst_path);
+			ret = btrfs_log_all_xattrs(trans, inode, path, dst_path, ctx);
 			if (ret)
 				goto out_unlock;
 			btrfs_release_path(path);
@@ -7538,6 +7557,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 
 	btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
 	ctx.logging_new_name = true;
+	btrfs_init_log_ctx_scratch_eb(&ctx);
 	/*
 	 * We don't care about the return value. If we fail to log the new name
 	 * then we know the next attempt to sync the log will fallback to a full
@@ -7546,6 +7566,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * inconsistent state after a rename operation.
 	 */
 	btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
+	free_extent_buffer(ctx.scratch_eb);
 	ASSERT(list_empty(&ctx.conflict_inodes));
 out:
 	/*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 8adebf4c9adaf..fbcf8cd7aa22d 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -30,6 +30,15 @@ struct btrfs_log_ctx {
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
@@ -47,6 +56,22 @@ static inline void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,
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


