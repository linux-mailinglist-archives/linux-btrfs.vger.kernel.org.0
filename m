Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC6A241A89
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgHKLnk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 07:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgHKLnk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 07:43:40 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D7720578
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597146219;
        bh=0KTs081TAgP+0iBrIMTPbYN40uGeigtGYN1Iw8JWqZg=;
        h=From:To:Subject:Date:From;
        b=PPu+yCyDku+bDFZ/BVyLvpKnx8o4VdT2WC67nojNywNnjF46yR7qBrQjpcQmBdc6d
         TuYl0ZVDkSoHBCZ5JDei6vPf5MjRyfrfHI+ZbqHwNwop0yZnMcEJ9gbLgFQadapo0v
         Rck7//w4ikVlg0vAlLcZBgeeCprrwqNpS5FHJN+U=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: do not take the log_mutex of the subvolume when pinning the log
Date:   Tue, 11 Aug 2020 12:43:37 +0100
Message-Id: <20200811114337.689881-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a rename we pin the log to make sure no one commits a log that
reflects an ongoing rename operation, as it might result in a committed
log where it recorded the unlink of the old name without having recorded
the new name. However we are taking the subvolume's log_mutex before
incrementing the log_writers counter, which is not necessary since that
counter is atomic and we only remove the old name from the log and add
the new name to the log after we have incremented log_writers, ensuring
that no one can commit the log after we have removed the old name from
the log and before we added the new name to the log.

By taking the log_mutex lock we are just adding unnecessary contention on
the lock, which can become visible for workloads that mix renames with
fsyncs, writes for files opened with O_SYNC and unlink operations (if the
inode or its parent were fsynced before in the current transaction).

So just remove the lock and unlock of the subvolume's log_mutex at
btrfs_pin_log_trans().

Using dbench, which mixes different types of operations that end up taking
that mutex (fsyncs, renames, unlinks and writes into files opened with
O_SYNC) revealed some small gains. The following script that calls dbench
was used:

  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/btrfs
  MOUNT_OPTIONS="-o ssd -o space_cache=v2"
  MKFS_OPTIONS="-m single -d single"
  THREADS=32

  echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  dbench -s -t 600 -D $MNT $THREADS

  umount $MNT

The test was run on bare metal, no virtualization, on a box with 12 cores
(Intel i7-8700), 64Gb of RAM and using a NVMe device, with a kernel
configuration that is the default of typical distributions (debian in this
case), without debug options enabled (kasan, kmemleak, slub debug, debug
of page allocations, lock debugging, etc).

Results before this patch:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    4410848     0.017   738.640
 Close        3240222     0.001     0.834
 Rename        186850     7.478  1272.476
 Unlink        890875     0.128   785.018
 Deltree          128     2.846    12.081
 Mkdir             64     0.002     0.003
 Qpathinfo    3997659     0.009    11.171
 Qfileinfo     701307     0.001     0.478
 Qfsinfo       733494     0.002     1.103
 Sfileinfo     359362     0.004     3.266
 Find         1546226     0.041     4.128
 WriteX       2202803     7.905  1376.989
 ReadX        6917775     0.003     3.887
 LockX          14392     0.002     0.043
 UnlockX        14392     0.001     0.085
 Flush         309225     0.128  1033.936

Throughput 231.555 MB/sec (sync open)  32 clients  32 procs  max_latency=1376.993 ms

Results after this patch:

Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    4603244     0.017   232.776
 Close        3381299     0.001     1.041
 Rename        194871     7.251  1073.165
 Unlink        929730     0.133   119.233
 Deltree          128     2.871    10.199
 Mkdir             64     0.002     0.004
 Qpathinfo    4171343     0.009    11.317
 Qfileinfo     731227     0.001     1.635
 Qfsinfo       765079     0.002     3.568
 Sfileinfo     374881     0.004     1.220
 Find         1612964     0.041     4.675
 WriteX       2296720     7.569  1178.204
 ReadX        7213633     0.003     3.075
 LockX          14976     0.002     0.076
 UnlockX        14976     0.001     0.061
 Flush         322635     0.102   579.505

Throughput 241.4 MB/sec (sync open)  32 clients  32 procs  max_latency=1178.207 ms
(+4.3% throughput, -14.4% max latency)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 696dd861cc3c..4e7ef3fd5288 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -215,9 +215,7 @@ static int join_running_log_trans(struct btrfs_root *root)
  */
 void btrfs_pin_log_trans(struct btrfs_root *root)
 {
-	mutex_lock(&root->log_mutex);
 	atomic_inc(&root->log_writers);
-	mutex_unlock(&root->log_mutex);
 }
 
 /*
-- 
2.26.2

