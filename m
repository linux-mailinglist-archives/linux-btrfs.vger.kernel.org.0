Return-Path: <linux-btrfs+bounces-2286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ED884FB6A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F381C26B72
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552084A33;
	Fri,  9 Feb 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsEW2Ejd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F20D83CB9
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501660; cv=none; b=kbbCsZq9bPVYyb80FY71FuKZ/Z4SqI2Z+BUn1OC8IMrtkZKcmwgCfT4v6Qyg3fFAXNLwLfDfB0OhszS2fnJL2kS3cigiNAP4MqLyyg4fgnZpzt1U0ez76rZyCiFS1t1LV8gxAjWC5lNqkbkqBhG+67lfIVMC3weVJKq7Pd41/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501660; c=relaxed/simple;
	bh=eeURNJFMTtSR5ctnyDW/TRS0BqdSFvnYy128iw8Vo0Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFH7Q64tjpKXtXKstQDVLFNssDOwSe7uQR7uka2R9X/hCdDUu9qjULXWGtCG95ZR0xq4KuftRwHpep5FsBWI+230KD9VyLK7vDwRJskWt3R09cODkCXY7m88S3Z0GLzG5pN5Dtgm1vwjpiN5w8ZIFhr1wI5RLolgFxKyw/CX/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsEW2Ejd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCD2C43394
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501659;
	bh=eeURNJFMTtSR5ctnyDW/TRS0BqdSFvnYy128iw8Vo0Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CsEW2Ejd+D6m994HOhYJfXH1WvqBVIIJ0pedTyq2ZVKzXaadLkGAkZrUNLicU/gJV
	 QK2xbDVqp2hNg4Hfud95I2o4tnRr4V1yOSM8iah50QTs/JX4Ik35Haku2/dl+flBI5
	 UlfUbIZ56UsT2kAIH0KWUZ5LjK7l86gZWTg9Q0gAYFIxwip3spnVk5Btmavc88eolE
	 WHTwoSC7wedxSgvEd97f+CqWiWz/TvMw0bMTD8B+O3xfZcLrB4sT1GMGztHMuV796B
	 1j73hBE/7Qw6QQ1CeKGJEG5RmxyH3fteavTC8ltrLzTp+RiGsHLec3jZmrpKaJpGF/
	 T2vT5YUKw86Tg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs: reduce inode lock critical section when setting and clearing delalloc
Date: Fri,  9 Feb 2024 18:00:47 +0000
Message-Id: <ddec77dee32394687dab1b94904951be7e903222.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When setting and clearing a delalloc range, at btrfs_set_delalloc_extent()
and btrfs_clear_delalloc_extent(), we are adding/removing the inode
to/from the root's list of delalloc inodes while under the protection of
the inode's lock. This however is not needed, we can add and remove the
inode to the root's list without holding the inode's lock because here
we are under the protection of the io tree's lock, reducing the size of
the critical section delimited by the inode's lock. The inode's lock is
used in many other places such as when finishing an ordered extent (when
calling btrfs_update_inode_bytes() or btrfs_delalloc_release_metadata(),
or decreasing the number of outstanding extents) or when reserving space
when doing a buffered or direct IO write (calls to functions from
delalloc-space.c).

So move the inode add/remove operations to the root's list of delalloc
inodes to outside the critical section delimited by the inode's lock.
This also allows us to get rid of the BTRFS_INODE_IN_DELALLOC_LIST flag
since we can rely on the inode's delalloc bytes counter to determine if
the inode is or is not in the list.

The following fio based test, that exercises IO to multiple files in the
same subvolume, was used to test:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/nullb0
   MNT=/mnt/nullb0
   MOUNT_OPTIONS="-o ssd"

   mkfs.btrfs -f $DEV &> /dev/null
   mount $MOUNT_OPTIONS $DEV $MNT

   fio --direct=0 --ioengine=sync --thread --directory=$MNT \
       --invalidate=1 --group_reporting=1 \
       --new_group --rw=randwrite --size=50m --numjobs=200 \
       --bs=4k --fsync_on_close=0 --fallocate=none --end_fsync=0 \
       --name=foo --filename_format=FioWorkloads.\$jobnum

   umount $MNT

The test was run on a non-debug kernel (Debian's default kernel config)
against a 16G null block device.

Result before this patch:

   WRITE: bw=81.9MiB/s (85.9MB/s), 81.9MiB/s-81.9MiB/s (85.9MB/s-85.9MB/s), io=9.77GiB (10.5GB), run=122136-122136msec

Result after this patch:

   WRITE: bw=86.8MiB/s (91.0MB/s), 86.8MiB/s-86.8MiB/s (91.0MB/s-91.0MB/s), io=9.77GiB (10.5GB), run=115180-115180msec

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  1 -
 fs/btrfs/inode.c       | 60 ++++++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 32c59c5bd94d..7799d00cc5d6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -41,7 +41,6 @@ enum {
 	  */
 	BTRFS_INODE_NEEDS_FULL_SYNC,
 	BTRFS_INODE_COPY_EVERYTHING,
-	BTRFS_INODE_IN_DELALLOC_LIST,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b273fdbd63cd..778bb6754e00 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2391,17 +2391,14 @@ static void btrfs_add_delalloc_inode(struct btrfs_inode *inode)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&root->delalloc_lock);
-	if (list_empty(&inode->delalloc_inodes)) {
-		list_add_tail(&inode->delalloc_inodes, &root->delalloc_inodes);
-		set_bit(BTRFS_INODE_IN_DELALLOC_LIST, &inode->runtime_flags);
-		root->nr_delalloc_inodes++;
-		if (root->nr_delalloc_inodes == 1) {
-			spin_lock(&fs_info->delalloc_root_lock);
-			BUG_ON(!list_empty(&root->delalloc_root));
-			list_add_tail(&root->delalloc_root,
-				      &fs_info->delalloc_roots);
-			spin_unlock(&fs_info->delalloc_root_lock);
-		}
+	ASSERT(list_empty(&inode->delalloc_inodes));
+	list_add_tail(&inode->delalloc_inodes, &root->delalloc_inodes);
+	root->nr_delalloc_inodes++;
+	if (root->nr_delalloc_inodes == 1) {
+		spin_lock(&fs_info->delalloc_root_lock);
+		BUG_ON(!list_empty(&root->delalloc_root));
+		list_add_tail(&root->delalloc_root, &fs_info->delalloc_roots);
+		spin_unlock(&fs_info->delalloc_root_lock);
 	}
 	spin_unlock(&root->delalloc_lock);
 }
@@ -2413,10 +2410,14 @@ void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 
 	lockdep_assert_held(&root->delalloc_lock);
 
+	/*
+	 * We may be called after the inode was already deleted from the list,
+	 * namely in the transaction abort path btrfs_destroy_delalloc_inodes(),
+	 * and then later through btrfs_clear_delalloc_extent() while the inode
+	 * still has ->delalloc_bytes > 0.
+	 */
 	if (!list_empty(&inode->delalloc_inodes)) {
 		list_del_init(&inode->delalloc_inodes);
-		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-			  &inode->runtime_flags);
 		root->nr_delalloc_inodes--;
 		if (!root->nr_delalloc_inodes) {
 			ASSERT(list_empty(&root->delalloc_inodes));
@@ -2444,6 +2445,8 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
+	lockdep_assert_held(&inode->io_tree.lock);
+
 	if ((bits & EXTENT_DEFRAG) && !(bits & EXTENT_DELALLOC))
 		WARN_ON(1);
 	/*
@@ -2453,6 +2456,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 	 */
 	if (!(state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
 		u64 len = state->end + 1 - state->start;
+		u64 prev_delalloc_bytes;
 		u32 num_extents = count_max_extents(fs_info, len);
 		bool do_list = !btrfs_is_free_space_inode(inode);
 
@@ -2467,13 +2471,20 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, len,
 					 fs_info->delalloc_batch);
 		spin_lock(&inode->lock);
+		prev_delalloc_bytes = inode->delalloc_bytes;
 		inode->delalloc_bytes += len;
 		if (bits & EXTENT_DEFRAG)
 			inode->defrag_bytes += len;
-		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-					 &inode->runtime_flags))
-			btrfs_add_delalloc_inode(inode);
 		spin_unlock(&inode->lock);
+
+		/*
+		 * We don't need to be under the protection of the inode's lock,
+		 * because we are called while holding the inode's io_tree lock
+		 * and are therefore protected against concurrent calls of this
+		 * function and btrfs_clear_delalloc_extent().
+		 */
+		if (do_list && prev_delalloc_bytes == 0)
+			btrfs_add_delalloc_inode(inode);
 	}
 
 	if (!(state->state & EXTENT_DELALLOC_NEW) &&
@@ -2495,6 +2506,8 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	u64 len = state->end + 1 - state->start;
 	u32 num_extents = count_max_extents(fs_info, len);
 
+	lockdep_assert_held(&inode->io_tree.lock);
+
 	if ((state->state & EXTENT_DEFRAG) && (bits & EXTENT_DEFRAG)) {
 		spin_lock(&inode->lock);
 		inode->defrag_bytes -= len;
@@ -2508,6 +2521,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	 */
 	if ((state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
 		struct btrfs_root *root = inode->root;
+		u64 new_delalloc_bytes;
 		bool do_list = !btrfs_is_free_space_inode(inode);
 
 		spin_lock(&inode->lock);
@@ -2536,11 +2550,17 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 					 fs_info->delalloc_batch);
 		spin_lock(&inode->lock);
 		inode->delalloc_bytes -= len;
-		if (do_list && inode->delalloc_bytes == 0 &&
-		    test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-					&inode->runtime_flags))
-			btrfs_del_delalloc_inode(inode);
+		new_delalloc_bytes = inode->delalloc_bytes;
 		spin_unlock(&inode->lock);
+
+		/*
+		 * We don't need to be under the protection of the inode's lock,
+		 * because we are called while holding the inode's io_tree lock
+		 * and are therefore protected against concurrent calls of this
+		 * function and btrfs_set_delalloc_extent().
+		 */
+		if (do_list && new_delalloc_bytes == 0)
+			btrfs_del_delalloc_inode(inode);
 	}
 
 	if ((state->state & EXTENT_DELALLOC_NEW) &&
-- 
2.40.1


