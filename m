Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD73FC9C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhHaObv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237852AbhHaObq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42C5D60FD8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420251;
        bh=h6xJm3oU37Yle8UtKelIaJ0iwNOgxO3Ma5FOUrq4IBc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=K8Q8IcEAmxi3HINALt7iDeZHV6BtyKCtLtzLZH214Aa+0Vk/d8D/vMkCgCImt4+JO
         afQqn14rjVQoye8wOGF+PJcPt2/tZTb21YM6l/Ozy7VBCC5qwcOHagqakvfSQ3C7gG
         JHmHRMHFbl+a0bwEo4sQj/P7KeBibpbjS3+O27EXvAYlBmRzuWjbKg3tCI6DTkj6qJ
         5bCQoFHDm/15xJ3NMgGlkQorkBxUqDNQ6cdw7GioJ/OSjDaOEg9WOvPZOEV82IwonQ
         FQm2vGvE4ELS4/lKiTYYFPQkxky/Gn4I97F0TWKwFFnge9EqtWESdKtlZmicNyqINA
         87StwcQKThIvw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: do not commit delayed inode when logging a file in full sync mode
Date:   Tue, 31 Aug 2021 15:30:40 +0100
Message-Id: <e726fc80316f66392bdd8df046ff601a0514a4c2.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging a regular file in full sync mode, we are currently committing
its delayed inode item. This is to ensure that we never miss copying the
inode item, with its most up to date data, into the log tree.

However that is not necessary since commit e4545de5b035 ("Btrfs: fix fsync
data loss after append write"), because even if we don't find the leaf
with the inode item when looking for leaves that changed in the current
transaction, we end up logging the inode item later using the in-memory
content. In case we find the leaf containing the inode item, we already
end up using the in-memory inode for filling the inode item in the log
tree, and not the inode item that is in the fs/subvolume tree, as it
might be not up to date (copy_items() -> fill_inode_item()).

So don't commit the delayed inode item, which brings a couple of benefits:

1) Avoid writing the inode item to the fs/subvolume btree, saving time and
   reducing lock contention on the btree;

2) In case no other item for the inode was changed, added or deleted in
   the same leaf where the inode item is located, we ended up copying
   all the items in that leaf to the log tree - it's harmless from a
   functional point of view, but it wastes time and log tree space.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 10/10 and the following test results compare a branch with
the whole patch set applied versus a branch without any of the patches
applied.

The following script was used to test dbench with 8 and 16 jobs on a
machine with 12 cores, 64G of RAM, a NVME device and using a non-debug
kernel config (Debian's default):

  $ cat test.sh
  #!/bin/bash

  if [ $# -ne 1 ]; then
      echo "Use $0 NUM_JOBS"
      exit 1
  fi

  NUM_JOBS=$1

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1
  MOUNT_OPTIONS="-o ssd"
  MKFS_OPTIONS="-m single -d single"

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  dbench -D $MNT -t 120 $NUM_JOBS

  umount $MNT

The results were the following:

8 jobs, before patchset:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    4113896     0.009   238.665
 Close        3021699     0.001     0.590
 Rename        174215     0.082   238.733
 Unlink        830977     0.049   238.642
 Deltree           96     2.232     8.022
 Mkdir             48     0.003     0.005
 Qpathinfo    3729013     0.005     2.672
 Qfileinfo     653206     0.001     0.152
 Qfsinfo       683866     0.002     0.526
 Sfileinfo     335055     0.004     1.571
 Find         1441800     0.016     4.288
 WriteX       2049644     0.010     3.982
 ReadX        6449786     0.003     0.969
 LockX          13400     0.002     0.043
 UnlockX        13400     0.001     0.075
 Flush         288349     2.521   245.516

Throughput 1075.73 MB/sec  8 clients  8 procs  max_latency=245.520 ms

8 jobs, after patchset:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    4154282     0.009   156.675
 Close        3051450     0.001     0.843
 Rename        175912     0.072     4.444
 Unlink        839067     0.048    66.050
 Deltree           96     2.131     5.979
 Mkdir             48     0.002     0.004
 Qpathinfo    3765575     0.005     3.079
 Qfileinfo     659582     0.001     0.099
 Qfsinfo       690474     0.002     0.155
 Sfileinfo     338366     0.004     1.419
 Find         1455816     0.016     3.423
 WriteX       2069538     0.010     4.328
 ReadX        6512429     0.003     0.840
 LockX          13530     0.002     0.078
 UnlockX        13530     0.001     0.051
 Flush         291158     2.500   163.468

Throughput 1105.45 MB/sec  8 clients  8 procs  max_latency=163.474 ms

+2.7% throughput, -40.1% max latency

16 jobs, before patchset:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    5457602     0.033   337.098
 Close        4008979     0.002     2.018
 Rename        231051     0.323   254.054
 Unlink       1102209     0.202   337.243
 Deltree          160     6.521    31.720
 Mkdir             80     0.003     0.007
 Qpathinfo    4946147     0.014     6.988
 Qfileinfo     867440     0.001     1.642
 Qfsinfo       907081     0.003     1.821
 Sfileinfo     444433     0.005     2.053
 Find         1912506     0.067     7.854
 WriteX       2724852     0.018     7.428
 ReadX        8553883     0.003     2.059
 LockX          17770     0.003     0.350
 UnlockX        17770     0.002     0.627
 Flush         382533     2.810   353.691

Throughput 1413.09 MB/sec  16 clients  16 procs  max_latency=353.696 ms

16 jobs, after patchset:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    5393156     0.034   303.181
 Close        3961986     0.002     1.502
 Rename        228359     0.320   253.379
 Unlink       1088920     0.206   303.409
 Deltree          160     6.419    30.088
 Mkdir             80     0.003     0.004
 Qpathinfo    4887967     0.015     7.722
 Qfileinfo     857408     0.001     1.651
 Qfsinfo       896343     0.002     2.147
 Sfileinfo     439317     0.005     4.298
 Find         1890018     0.073     8.347
 WriteX       2693356     0.018     6.373
 ReadX        8453485     0.003     3.836
 LockX          17562     0.003     0.486
 UnlockX        17562     0.002     0.635
 Flush         378023     2.802   315.904

Throughput 1454.46 MB/sec  16 clients  16 procs  max_latency=315.910 ms

+2.9% throughput, -11.3% max latency

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 630660408c2e..6a90e1178236 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5397,22 +5397,11 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 * Only run delayed items if we are a directory. We want to make sure
 	 * all directory indexes hit the fs/subvolume tree so we can find them
 	 * and figure out which index ranges have to be logged.
-	 *
-	 * Otherwise commit the delayed inode only if the full sync flag is set,
-	 * as we want to make sure an up to date version is in the subvolume
-	 * tree so copy_inode_items_to_log() / copy_items() can find it and copy
-	 * it to the log tree. For a non full sync, we always log the inode item
-	 * based on the in-memory struct btrfs_inode which is always up to date.
 	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode))
-		ret = btrfs_commit_inode_delayed_items(trans, inode);
-	else if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags))
-		ret = btrfs_commit_inode_delayed_inode(inode);
-
-	if (ret) {
-		btrfs_free_path(path);
-		btrfs_free_path(dst_path);
-		return ret;
+	if (S_ISDIR(inode->vfs_inode.i_mode)) {
+		err = btrfs_commit_inode_delayed_items(trans, inode);
+		if (err)
+			goto out;
 	}
 
 	if (inode_only == LOG_OTHER_INODE || inode_only == LOG_OTHER_INODE_ALL) {
@@ -5613,7 +5602,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	spin_unlock(&inode->lock);
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
-
+out:
 	btrfs_free_path(path);
 	btrfs_free_path(dst_path);
 	return err;
-- 
2.28.0

