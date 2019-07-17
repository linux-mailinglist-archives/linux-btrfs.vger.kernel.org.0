Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F36BC38
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfGQMXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 08:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQMXo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 08:23:44 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AF820880
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563366223;
        bh=5owU9x4U8Ic7nQs68YcqZ8nDyAKd2ei3gy8fobUtf8Q=;
        h=From:To:Subject:Date:From;
        b=BJ84ebxzGIMom7gIokoCMwSX7cqAjX0Io6iD5sy/81YzXydivSqzvwejzfbtC1XTQ
         TBNtHSqwJ/kHkggzHWQ/IVyxVsyyQ3rYzzuDTtStTyVnbqKpDXRrDxwKuqqXl+oyDk
         hRMoAQHAfVoKtnB+qknPOp8edWtG/ZubgUabkcwE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix incremental send failure after deduplication
Date:   Wed, 17 Jul 2019 13:23:39 +0100
Message-Id: <20190717122339.4926-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an incremental send operation we can fail if we previously did
deduplication operations against a file that exists in both snapshots. In
that case we will fail the send operation with -EIO and print a message
to dmesg/syslog like the following:

  BTRFS error (device sdc): Send: inconsistent snapshot, found updated \
  extent for inode 257 without updated inode item, send root is 258, \
  parent root is 257

This requires that we deduplicate to the same file in both snapshots for
the same amount of times on each snapshot. The issue happens because a
deduplication only updates the iversion of an inode and does not update
any other field of the inode, therefore if we deduplicate the file on
each snapshot for the same amount of time, the inode will have the same
iversion value (stored as the "sequence" field on the inode item) on both
snapshots, therefore it will be seen as unchanged between in the send
snapshot while there are new/updated/deleted extent items when comparing
to the parent snapshot. This makes the send operation return -EIO and
print an error message.

Example reproducer:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  # Create our first file. The first half of the file has several 64Kb
  # extents while the second half as a single 512Kb extent.
  $ xfs_io -f -s -c "pwrite -S 0xb8 -b 64K 0 512K" /mnt/foo
  $ xfs_io -c "pwrite -S 0xb8 512K 512K" /mnt/foo

  # Create the base snapshot and the parent send stream from it.
  $ btrfs subvolume snapshot -r /mnt /mnt/mysnap1
  $ btrfs send -f /tmp/1.snap /mnt/mysnap1

  # Create our second file, that has exactly the same data as the first
  # file.
  $ xfs_io -f -c "pwrite -S 0xb8 0 1M" /mnt/bar

  # Create the second snapshot, used for the incremental send, before
  # doing the file deduplication.
  $ btrfs subvolume snapshot -r /mnt /mnt/mysnap2

  # Now before creating the incremental send stream:
  #
  # 1) Deduplicate into a subrange of file foo in snapshot mysnap1. This
  #    will drop several extent items and add a new one, also updating
  #    the inode's iversion (sequence field in inode item) by 1, but not
  #    any other field of the inode;
  #
  # 2) Deduplicate into a different subrange of file foo in snapshot
  #    mysnap2. This will replace an extent item with a new one, also
  #    updating the inode's iversion by 1 but not any other field of the
  #    inode.
  #
  # After these two deduplication operations, the inode items, for file
  # foo, are identical in both snapshots, but we have different extent
  # items for this inode in both snapshots. We want to check this doesn't
  # cause send to fail with an error or produce an incorrect stream.

  $ xfs_io -r -c "dedupe /mnt/bar 0 0 512K" /mnt/mysnap1/foo
  $ xfs_io -r -c "dedupe /mnt/bar 512K 512K 512K" /mnt/mysnap2/foo

  # Create the incremental send stream.
  $ btrfs send -p /mnt/mysnap1 -f /tmp/2.snap /mnt/mysnap2
  ERROR: send ioctl failed with -5: Input/output error

This issue started happening back in 2015 when deduplication was updated
to not update the inode's ctime and mtime and update only the iversion.
Back then we would hit a BUG_ON() in send, but later in 2016 send was
updated to return -EIO and print the error message instead of doing the
BUG_ON().

A test case for fstests follows soon.

Fixes: 1c919a5e13702c ("btrfs: don't update mtime/ctime on deduped inodes")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203933
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 77 +++++++++++----------------------------------------------
 1 file changed, 15 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d18f21061f26..e38287b855a8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6322,68 +6322,21 @@ static int changed_extent(struct send_ctx *sctx,
 {
 	int ret = 0;
 
-	if (sctx->cur_ino != sctx->cmp_key->objectid) {
-
-		if (result == BTRFS_COMPARE_TREE_CHANGED) {
-			struct extent_buffer *leaf_l;
-			struct extent_buffer *leaf_r;
-			struct btrfs_file_extent_item *ei_l;
-			struct btrfs_file_extent_item *ei_r;
-
-			leaf_l = sctx->left_path->nodes[0];
-			leaf_r = sctx->right_path->nodes[0];
-			ei_l = btrfs_item_ptr(leaf_l,
-					      sctx->left_path->slots[0],
-					      struct btrfs_file_extent_item);
-			ei_r = btrfs_item_ptr(leaf_r,
-					      sctx->right_path->slots[0],
-					      struct btrfs_file_extent_item);
-
-			/*
-			 * We may have found an extent item that has changed
-			 * only its disk_bytenr field and the corresponding
-			 * inode item was not updated. This case happens due to
-			 * very specific timings during relocation when a leaf
-			 * that contains file extent items is COWed while
-			 * relocation is ongoing and its in the stage where it
-			 * updates data pointers. So when this happens we can
-			 * safely ignore it since we know it's the same extent,
-			 * but just at different logical and physical locations
-			 * (when an extent is fully replaced with a new one, we
-			 * know the generation number must have changed too,
-			 * since snapshot creation implies committing the current
-			 * transaction, and the inode item must have been updated
-			 * as well).
-			 * This replacement of the disk_bytenr happens at
-			 * relocation.c:replace_file_extents() through
-			 * relocation.c:btrfs_reloc_cow_block().
-			 */
-			if (btrfs_file_extent_generation(leaf_l, ei_l) ==
-			    btrfs_file_extent_generation(leaf_r, ei_r) &&
-			    btrfs_file_extent_ram_bytes(leaf_l, ei_l) ==
-			    btrfs_file_extent_ram_bytes(leaf_r, ei_r) &&
-			    btrfs_file_extent_compression(leaf_l, ei_l) ==
-			    btrfs_file_extent_compression(leaf_r, ei_r) &&
-			    btrfs_file_extent_encryption(leaf_l, ei_l) ==
-			    btrfs_file_extent_encryption(leaf_r, ei_r) &&
-			    btrfs_file_extent_other_encoding(leaf_l, ei_l) ==
-			    btrfs_file_extent_other_encoding(leaf_r, ei_r) &&
-			    btrfs_file_extent_type(leaf_l, ei_l) ==
-			    btrfs_file_extent_type(leaf_r, ei_r) &&
-			    btrfs_file_extent_disk_bytenr(leaf_l, ei_l) !=
-			    btrfs_file_extent_disk_bytenr(leaf_r, ei_r) &&
-			    btrfs_file_extent_disk_num_bytes(leaf_l, ei_l) ==
-			    btrfs_file_extent_disk_num_bytes(leaf_r, ei_r) &&
-			    btrfs_file_extent_offset(leaf_l, ei_l) ==
-			    btrfs_file_extent_offset(leaf_r, ei_r) &&
-			    btrfs_file_extent_num_bytes(leaf_l, ei_l) ==
-			    btrfs_file_extent_num_bytes(leaf_r, ei_r))
-				return 0;
-		}
-
-		inconsistent_snapshot_error(sctx, result, "extent");
-		return -EIO;
-	}
+	/*
+	 * We have found an extent item that changed without the inode item
+	 * having changed. This can happen either after relocation (where the
+	 * disk_bytenr of an extent item is replaced at
+	 * relocation.c:replace_file_extents()) or after deduplication into a
+	 * file in both the parent and send snapshots (where an extent item can
+	 * get modified or replaced with a new one). Note that deduplication
+	 * updates the inode item, but it only changes the iversion (sequence
+	 * field in the inode item) of the inode, so if a file is deduplicated
+	 * the same amount of times in both the parent and send snapshots, its
+	 * iversion becames the same in both snapshots, whence the inode item is
+	 * the same on both snapshots.
+	 */
+	if (sctx->cur_ino != sctx->cmp_key->objectid)
+		return 0;
 
 	if (!sctx->cur_inode_new_gen && !sctx->cur_inode_deleted) {
 		if (result != BTRFS_COMPARE_TREE_DELETED)
-- 
2.11.0

