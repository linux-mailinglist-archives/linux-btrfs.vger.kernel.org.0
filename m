Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8752B7C05
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgKRLAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 06:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbgKRLAW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 06:00:22 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA39221FB
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605697220;
        bh=FMWmQdl0hb1inN90C6HBQfUl8LAQB20EXhEYIL3B2po=;
        h=From:To:Subject:Date:From;
        b=kCsjFiKoBs0FqbtmosMlapN4oC9Mxr4ux035apjRlBP3MJ7+yoOCdIw5d3s3zA+Ws
         juj4QycmLmxjc7x6876zpjMSnDqjCCT2qmC53q/PrZthZSofR2SY0fnIchZpl+7gK6
         73knOzwPxP1H3E38zRRnPhytim8f/kA4X5jqj/d0=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unlock path before checking if extent is shared during nocow writeback
Date:   Wed, 18 Nov 2020 11:00:17 +0000
Message-Id: <6fbdddf38bd353dba7eba2117573f3b74fb79e40.1605697030.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we are attempting to start writeback for an existing extent in NOCOW
mode, at run_delalloc_nocow(), we must check if the extent is shared, and
if it is, fallback to a COW write. However we do such check while still
holding a read lock on the leaf that contains the file extent item, and
that check, the call to btrfs_cross_ref_exist(), can take some time
because:

1) It needs to do a search on the extent tree, which obviously takes some
   time, specially if delayed references are being run at the moment, as
   we can block when trying to lock currently write locked btree nodes;

2) It needs to check the delayed references for any existing reference
   for our data extent, this requires acquiring the delayed references'
   spinlock and maybe block on the mutex of a delayed reference head in the
   case where there is a delayed reference for our data extent, in the
   worst case it makes us release the path on the extent tree and retry
   the whole process again (going back to step 1).

There are other operations we do while holding the leaf locked that can
take some significant time as well (specially all together):

* btrfs_extent_readonly() - to check if the block group containing the
  extent is currently in RO mode. This requires taking a spinlock and
  searching for the block group in a rbtree that can be big on large
  filesystems;

* csum_exist_in_range() - to search if there are any checksums in the
  csum tree for the extent. Like before, this can take some time if we are
  in a filesystem that has both COW and NOCOW files, in which case the
  csum tree is not empty;

* btrfs_inc_nocow_writers() - increment the number of nocow writers in the
  block group that contains the data extent. Needs to acquire a spinlock
  and search for the block group in a rbtree that can be big on large
  filesystems.

So just unlock the leaf (release the path) before doing all those checks,
since we do not need it anymore. In case we can not do a NOCOW write for
the extent, due to any of those checks failing, and the writeback range
goes beyond that extents' length, we will do another btree search for the
next file extent item.

The following script that calls dbench was used to measure the impact of
this change on a VM with 8 CPUs, 16Gb of ram, using a raw NVMe device
directly (no intermediary filesystem on the host) and using a non-debug
kernel (default configuration on Debian):

  $ cat test-dbench.sh
  #!/bin/bash

  DEV=/dev/sdk
  MNT=/mnt/sdk
  MOUNT_OPTIONS="-o ssd -o nodatacow"
  MKFS_OPTIONS="-m single -d single"

  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  dbench -D $MNT -t 300 64

  umount $MNT

Before this change:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    9326331     0.317   399.957
 Close        6851198     0.002     6.402
 Rename        394894     2.621   402.819
 Unlink       1883131     0.931   398.082
 Deltree          256    19.160   303.580
 Mkdir            128     0.003     0.016
 Qpathinfo    8452314     0.068   116.133
 Qfileinfo    1481921     0.001     5.081
 Qfsinfo      1549963     0.002     4.444
 Sfileinfo     759679     0.084    17.079
 Find         3268168     0.396   118.196
 WriteX       4653310     0.056   110.993
 ReadX        14618818     0.005    23.314
 LockX          30364     0.003     0.497
 UnlockX        30364     0.002     1.720
 Flush         653619    16.954   569.299

Throughput 966.651 MB/sec  64 clients  64 procs  max_latency=569.377 ms

After this change:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    9710433     0.302   232.449
 Close        7132948     0.002    11.496
 Rename        411144     2.452   131.805
 Unlink       1960961     0.893   230.383
 Deltree          256    14.858   198.646
 Mkdir            128     0.002     0.005
 Qpathinfo    8800890     0.066   111.588
 Qfileinfo    1542556     0.001     3.852
 Qfsinfo      1613835     0.002     5.483
 Sfileinfo     790871     0.081    19.492
 Find         3402743     0.386   120.185
 WriteX       4842918     0.054   179.312
 ReadX        15220407     0.005    32.435
 LockX          31612     0.003     1.533
 UnlockX        31612     0.002     1.047
 Flush         680567    16.320   463.323

Throughput 1016.59 MB/sec  64 clients  64 procs  max_latency=463.327 ms

+5.0% throughput, -20.5% max latency

Also, the following test using fio was run:

  $ cat test-fio.sh
  #!/bin/bash

  DEV=/dev/sdk
  MNT=/mnt/sdk
  MOUNT_OPTIONS="-o ssd -o nodatacow"
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

  echo
  echo "Using fio config:"
  echo
  cat /tmp/fio-job.ini
  echo
  echo "mount options: $MOUNT_OPTIONS"
  echo

  mkfs.btrfs -f $MKFS_OPTIONS $DEV > /dev/null
  mount $MOUNT_OPTIONS $DEV $MNT

  echo "Creating nodatacow files before fio runs..."
  for ((i = 0; i < $NUM_JOBS; i++)); do
      xfs_io -f -c "pwrite -b 128M 0 $FILE_SIZE" "$MNT/writers.$i.0"
  done
  sync

  fio /tmp/fio-job.ini
  umount $MNT

Before this change:

$ ./test-fio.sh 16 512M 2 4K
(...)
WRITE: bw=28.3MiB/s (29.6MB/s), 28.3MiB/s-28.3MiB/s (29.6MB/s-29.6MB/s), io=8192MiB (8590MB), run=289800-289800msec

After this change:

$ ./test-fio.sh 16 512M 2 4K
(...)
WRITE: bw=31.2MiB/s (32.7MB/s), 31.2MiB/s-31.2MiB/s (32.7MB/s-32.7MB/s), io=8192MiB (8590MB), run=262845-262845msec

+9.7% throughput, -9.8% runtime

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a2ee8983528..24c8ad7e0603 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1649,6 +1649,15 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				goto out_check;
 			if (extent_type == BTRFS_FILE_EXTENT_REG && !force)
 				goto out_check;
+
+			/*
+			 * The following checks can be expensive, as they need to
+			 * take other locks and do btree or rbtree searches, so
+			 * release the path to avoid blocking other tasks for too
+			 * long.
+			 */
+			btrfs_release_path(path);
+
 			/* If extent is RO, we must COW it */
 			if (btrfs_extent_readonly(fs_info, disk_bytenr))
 				goto out_check;
@@ -1724,12 +1733,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			cur_offset = extent_end;
 			if (cur_offset > end)
 				break;
+			if (!path->nodes[0])
+				continue;
 			path->slots[0]++;
 			goto next_slot;
 		}
 
-		btrfs_release_path(path);
-
 		/*
 		 * COW range from cow_start to found_key.offset - 1. As the key
 		 * will contain the beginning of the first extent that can be
-- 
2.28.0

