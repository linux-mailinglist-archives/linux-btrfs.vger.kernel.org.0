Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262D24170DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 13:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245760AbhIXLaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 07:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244860AbhIXL3x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 07:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D34B61241
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632482901;
        bh=kzX9LPLnHXMY/rzzhvGhnYsBJ5gH9culLjo5xMMGfKU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h6qrfAY4/QsnyanuLkw2YXRBwWZLyy+NRDjBdpE0PMO7nK7Mou25JT2Sev4bQml16
         /bha1VrXrwYNop/pAiEkRoqISrO6SIohwUR0SGM+/epR2PZzP7YBdwhYiRoSH3Cd6w
         ks/KfVroL5hEkTkpGuX/DNxd0Lk1duYlOgzOzanrVhSw5nHCwoeTUEZxNulIg2R/xf
         cA6i1xvPJeQEEtGH3U/iSMH5kRteR9xZGGeOU2u5nITmqxT06KGCPKLnpwUaKWvmTS
         ovkfCic2nxkvDhQ+BXtD/Wg5Ca41EOYXPbjQz6+HtAfSL+Kd9fzyiJqb114lCHjKcM
         Y+ISE6E+wjmUg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use single bulk copy operations when logging directories
Date:   Fri, 24 Sep 2021 12:28:15 +0100
Message-Id: <5d51d982dc9f83ef12fbff91c098044e8032c134.1632482680.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632482680.git.fdmanana@suse.com>
References: <cover.1632482680.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a directory and inserting a batch of directory items, we are
copying the data of each item from a leaf in the fs/subvolume tree to a
leaf in a log tree, separately. This is not really needed, since we are
copying from a contiguous memory area into another one, so we can use a
single copy operation to copy all items at once.

This patch is part of a small patchset that is comprised of the following
patches:

  btrfs: loop only once over data sizes array when inserting an item batch
  btrfs: unexport setup_items_for_insert()
  btrfs: use single bulk copy operations when logging directories

This is patch 3/3.

The following test was used to compare performance of a branch without the
patchset versus one branch that has the whole patchset applied:

  $ cat dir-fsync-test.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1

  NUM_NEW_FILES=1000000
  NUM_FILE_DELETES=1000
  LEAF_SIZE=16K

  mkfs.btrfs -f -n $LEAF_SIZE $DEV
  mount -o ssd $DEV $MNT

  mkdir $MNT/testdir

  for ((i = 1; i <= $NUM_NEW_FILES; i++)); do
      echo -n > $MNT/testdir/file_$i
  done

  # Fsync the directory, this will log the new dir items and the inodes
  # they point to, because these are new inodes.
  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/testdir
  end=$(date +%s%N)

  dur=$(( (end - start) / 1000000 ))
  echo "dir fsync took $dur ms after adding $NUM_NEW_FILES files"

  # sync to force transaction commit and wipeout the log.
  sync

  del_inc=$(( $NUM_NEW_FILES / $NUM_FILE_DELETES ))
  for ((i = 1; i <= $NUM_NEW_FILES; i += $del_inc)); do
      rm -f $MNT/testdir/file_$i
  done

  # Fsync the directory, this will only log dir items, there are no
  # dentries pointing to new inodes.
  start=$(date +%s%N)
  xfs_io -c "fsync" $MNT/testdir
  end=$(date +%s%N)

  dur=$(( (end - start) / 1000000 ))
  echo "dir fsync took $dur ms after deleting $NUM_FILE_DELETES files"

  umount $MNT

The tests were run on a non-debug kernel (Debian's default kernel config)
and were the following:

*** with a leaf size of 16K, before patchset ***

dir fsync took 8482 ms after adding 1000000 files
dir fsync took 166 ms after deleting 1000 files

*** with a leaf size of 16K, after patchset ***

dir fsync took 8196 ms after adding 1000000 files  (-3.4%)
dir fsync took 143 ms after deleting 1000 files    (-14.9%)

*** with a leaf size of 64K, before patchset ***

dir fsync took 12851 ms after adding 1000000 files
dir fsync took 466 ms after deleting 1000 files

*** with a leaf size of 64K, after  patchset ***

dir fsync took 12287 ms after adding 1000000 files (-4.5%)
dir fsync took 414 ms after deleting 1000 files    (-11.8%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index de725a806a7b..b765ca7536fe 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3653,6 +3653,8 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 	char *ins_data = NULL;
 	struct btrfs_item_batch batch;
 	struct extent_buffer *dst;
+	unsigned long src_offset;
+	unsigned long dst_offset;
 	struct btrfs_key key;
 	u32 item_size;
 	int ret;
@@ -3696,16 +3698,19 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 		goto out;
 
 	dst = dst_path->nodes[0];
-	for (i = 0; i < count; i++) {
-		unsigned long src_offset;
-		unsigned long dst_offset;
-
-		dst_offset = btrfs_item_ptr_offset(dst, dst_path->slots[0]);
-		src_offset = btrfs_item_ptr_offset(src, start_slot + i);
-		copy_extent_buffer(dst, src, dst_offset, src_offset,
-				   batch.data_sizes[i]);
-		dst_path->slots[0]++;
-	}
+	/*
+	 * Copy all the items in bulk, in a single copy operation. Item data is
+	 * organized such that it's placed at the end of a leaf and from right
+	 * to left. For example, the data for the second item ends at an offset
+	 * that matches the offset where the data for the first item starts, the
+	 * data for the third item ends at an offset that matches the offset
+	 * where the data of the second items starts, and so on.
+	 * Therefore our source and destination start offsets for copy match the
+	 * offsets of the last items (highest slots).
+	 */
+	dst_offset = btrfs_item_ptr_offset(dst, dst_path->slots[0] + count - 1);
+	src_offset = btrfs_item_ptr_offset(src, start_slot + count - 1);
+	copy_extent_buffer(dst, src, dst_offset, src_offset, batch.total_data_size);
 	btrfs_release_path(dst_path);
 out:
 	kfree(ins_data);
-- 
2.33.0

