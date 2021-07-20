Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8263C3CFDBF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbhGTO7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238781AbhGTOXK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 704CE61249
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793428;
        bh=KZ7rGDYbwQDxjDm8Xos1dBb4Aj6w+dS3i/dRLt6AgZ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r7Wg+SDwNcFyagayOUDyi06DSBHcguMC4AWVLcpgNpmn6BXPh8GDHzzLqgLMNm1cb
         WNPfLA5Cpihloilvm+F3q/2kxGccBEPYN7lg1BFZMjqYH3DTnG9VLHrxtehn9sZXuT
         8YS2t2XfQPYYJb7TUJjq8qwHyQIXOse9tVYlBhq04+DQ9XZrKmGqXelZjtJjD4LeoD
         +Vtkiwc8EMfcbAVLRq30d0bwdh//BpbY5/TEO5XyLX9Dbw4oMTJjRAnnEYU90IrNIG
         s6qMhCXtUdd/vA08FLXArg+0ma3dDM3/O2OFFFTJaF0sgn1BFZQkoOTGPgpP1JufVZ
         CawBuP4qfacBA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: avoid unnecessary lock and leaf splits when updating inode in the log
Date:   Tue, 20 Jul 2021 16:03:43 +0100
Message-Id: <0f3b22c649c394c3f5be698248cf7fee4a920cbb.1626791500.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626791500.git.fdmanana@suse.com>
References: <cover.1626791500.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a fast fsync, if we have already fsynced the file before and in the
current transaction, we can make the inode item update more efficient and
avoid acquiring a write lock on the leaf's parent.

To update the inode item we are always using btrfs_insert_empty_item() to
get a path pointing to the inode item, which calls btrfs_search_slot()
with an "ins_len" argument of 'sizeof(struct btrfs_inode_item) +
sizeof(struct btrfs_item)', and that always results in the search taking
a write lock on the level 1 node that is the parent of the leaf that
contains the inode item. This adds unnecessary lock contention on log
trees when we have multiple fsyncs in parallel against inodes in the same
subvolume, which has a very significant impact due to the fact that log
trees are short lived and their height very rarely goes beyond level 2.

Also, by using btrfs_insert_empty_item() when we need to update the inode
item, we also end up splitting the leaf of the existing inode item when
the leaf has an amount of free space smaller than the size of an inode
item.

Improve this by using btrfs_seach_slot(), with a 0 "ins_len" argument,
when we know the inode item already exists in the log. This avoids these
two inefficiencies.

The following script, using fio, was used to perform the tests:

  $ cat fio-test.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1
  MOUNT_OPTIONS="-o ssd"
  MKFS_OPTIONS="-d single -m single"

  if [ $# -ne 4 ]; then
    echo "Use $0 NUM_JOBS FILE_SIZE FSYNC_FREQ BLOCK_SIZE"
    exit 1
  fi

  NUM_JOBS=$1
  FILE_SIZE=$2
  FSYNC_FREQ=$3
  BLOCK_SIZE=$4

  cat <<EOF > /tmp/fio-job.ini
  [writers]
  rw=randwrite
  fsync=$FSYNC_FREQ
  fallocate=none
  group_reporting=1
  direct=0
  bs=$BLOCK_SIZE
  ioengine=sync
  size=$FILE_SIZE
  directory=$MNT
  numjobs=$NUM_JOBS
  EOF

  echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  echo
  echo "Using config:"
  echo
  cat /tmp/fio-job.ini
  echo
  echo "mount options: $MOUNT_OPTIONS"
  echo

  umount $MNT &> /dev/null
  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  fio /tmp/fio-job.ini
  umount $MNT

The tests were done on a physical machine, with 12 cores, 64G of RAM,
using a NVMEe device and using a non-debug kernel config (the default one
from Debian). The summary line from fio is provided below for each test
run.

With 8 jobs, file size 256M, fsync frequency of 4 and a block size of 4K:

Before: WRITE: bw=28.3MiB/s (29.7MB/s), 28.3MiB/s-28.3MiB/s (29.7MB/s-29.7MB/s), io=2048MiB (2147MB), run=72297-72297msec
After:  WRITE: bw=28.7MiB/s (30.1MB/s), 28.7MiB/s-28.7MiB/s (30.1MB/s-30.1MB/s), io=2048MiB (2147MB), run=71411-71411msec

+1.4% throughput, -1.2% runtime

With 16 jobs, file size 256M, fsync frequency of 4 and a block size of 4K:

Before: WRITE: bw=40.0MiB/s (42.0MB/s), 40.0MiB/s-40.0MiB/s (42.0MB/s-42.0MB/s), io=4096MiB (4295MB), run=99980-99980msec
After:  WRITE: bw=40.9MiB/s (42.9MB/s), 40.9MiB/s-40.9MiB/s (42.9MB/s-42.9MB/s), io=4096MiB (4295MB), run=97933-97933msec

+2.2% throughput, -2.1% runtime

The changes are small but it's possible to be better on faster hardware as
in the test machine used disk utilization was pretty much 100% during the
whole time the tests were running (observed with 'iostat -xz 1').

The tests also included the previous patch with the subject of:
"btrfs: avoid unnecessary log mutex contention when syncing log".
So they compared a branch without that patch and without this patch versus
a branch with these two patches applied.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 63f48715135c..2fa8815f7b3b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3972,14 +3972,41 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 
 static int log_inode_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *log, struct btrfs_path *path,
-			  struct btrfs_inode *inode)
+			  struct btrfs_inode *inode, bool inode_item_dropped)
 {
 	struct btrfs_inode_item *inode_item;
 	int ret;
 
-	ret = btrfs_insert_empty_item(trans, log, path,
-				      &inode->location, sizeof(*inode_item));
-	if (ret && ret != -EEXIST)
+	/*
+	 * If we are doing a fast fsync and the inode was logged before in the
+	 * current transaction, then we know the inode was previously logged and
+	 * it exists in the log tree. For performance reasons, in this case use
+	 * btrfs_search_slot() directly with ins_len set to 0 so that we never
+	 * attempt a write lock on the leaf's parent, which adds unnecessary lock
+	 * contention in case there are concurrent fsyncs for other inodes of the
+	 * same subvolume. Using btrfs_insert_empty_item() when the inode item
+	 * already exists can also result in unnecessarily splitting a leaf.
+	 */
+	if (!inode_item_dropped && inode->logged_trans == trans->transid) {
+		ret = btrfs_search_slot(trans, log, &inode->location, path, 0, 1);
+		ASSERT(ret <= 0);
+		if (ret > 0)
+			ret = -ENOENT;
+	} else {
+		/*
+		 * This means it is the first fsync in the current transaction,
+		 * so the inode item is not in the log and we need to insert it.
+		 * We can never get -EEXIST because we are only called for a fast
+		 * fsync and in case an inode eviction happens after the inode was
+		 * logged before in the current transaction, when we load again
+		 * the inode, we set BTRFS_INODE_NEEDS_FULL_SYNC on its runtime
+		 * flags and set ->logged_trans to 0.
+		 */
+		ret = btrfs_insert_empty_item(trans, log, path, &inode->location,
+					      sizeof(*inode_item));
+		ASSERT(ret != -EEXIST);
+	}
+	if (ret)
 		return ret;
 	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_inode_item);
@@ -5303,6 +5330,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	bool need_log_inode_item = true;
 	bool xattrs_logged = false;
 	bool recursive_logging = false;
+	bool inode_item_dropped = true;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -5437,6 +5465,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		} else {
 			if (inode_only == LOG_INODE_ALL)
 				fast_search = true;
+			inode_item_dropped = false;
 			goto log_extents;
 		}
 
@@ -5470,7 +5499,8 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
 	if (need_log_inode_item) {
-		err = log_inode_item(trans, log, dst_path, inode);
+		err = log_inode_item(trans, log, dst_path, inode,
+				     inode_item_dropped);
 		if (err)
 			goto out_unlock;
 		/*
-- 
2.30.2

