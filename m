Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E03326495
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBZPRt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 10:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhBZPRr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 10:17:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B92CB64EED
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614352626;
        bh=JMfpDW8Q/eoZUjISB6lXtkH3nG7jA5nrsESdpnZ4Yjc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fo3m4AHbbKyYyzRjkF87HWXIpieBr3Ejle3aEsLly5c0iriU0yi+ZY+gVDyG88v7f
         Qqq9d+BS60yCmG2yBvO63+wg3kEIzuW8ce37jrEQX1FGim3zUyS2Hr0ZPfRSDbyLS/
         S480Qatw7Y9rZaxAbV2l+aFn9UmQvVh/GE6QIikaMLK6Ah011dwEpGdui9YukADC2L
         uTe5Df2jThR8nZtlnnicID9uPWPHS6dFoNTU1c0nL/KSLphCxy6qTbYCG6Uncwk+fb
         7kD7Ik87TzUwPl7yX8gK5e5CxF2pvO06TbsEgB1J2Ma9OB6HR7C/aY/AAlYxPjXqFB
         72BYR5dsgEGvg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add btree read ahead for full send operations
Date:   Fri, 26 Feb 2021 15:17:01 +0000
Message-Id: <797bc702f6ba466153eb8448aa54c3c41e764620.1614351671.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614351671.git.fdmanana@suse.com>
References: <cover.1614351671.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a full send we know that we are going to be reading every node
and leaf of the send root, so we benefit from enabling read ahead for the
btree.

This change enables read ahead for full send operations only, incremental
sends will have read ahead enabled in a different way by a separate patch.

The following test script was used to measure the improvement on a box
using an average, consumer grade, spinning disk and with 16Gb of ram:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj
  MKFS_OPTIONS="--nodesize 16384"     # default, just to be explicit
  MOUNT_OPTIONS="-o max_inline=2048"  # default, just to be explicit

  mkfs.btrfs -f $MKFS_OPTIONS $DEV > /dev/null
  mount $MOUNT_OPTIONS $DEV $MNT

  # Create files with inline data to make it easier and faster to create
  # large btrees.
  add_files()
  {
      local total=$1
      local start_offset=$2
      local number_jobs=$3
      local total_per_job=$(($total / $number_jobs))

      echo "Creating $total new files using $number_jobs jobs"
      for ((n = 0; n < $number_jobs; n++)); do
          (
              local start_num=$(($start_offset + $n * $total_per_job))
              for ((i = 1; i <= $total_per_job; i++)); do
                  local file_num=$((start_num + $i))
                  local file_path="$MNT/file_${file_num}"
                  xfs_io -f -c "pwrite -S 0xab 0 2000" $file_path > /dev/null
                  if [ $? -ne 0 ]; then
                      echo "Failed creating file $file_path"
                      break
                  fi
              done
          ) &
          worker_pids[$n]=$!
      done

      wait ${worker_pids[@]}

      sync
      echo
      echo "btree node/leaf count: $(btrfs inspect-internal dump-tree -t 5 $DEV | egrep '^(node|leaf) ' | wc -l)"
  }

  initial_file_count=500000
  add_files $initial_file_count 0 4

  echo
  echo "Creating first snapshot..."
  btrfs subvolume snapshot -r $MNT $MNT/snap1

  echo
  echo "Adding more files..."
  add_files $((initial_file_count / 4)) $initial_file_count 4

  echo
  echo "Updating 1/50th of the initial files..."
  for ((i = 1; i < $initial_file_count; i += 50)); do
      xfs_io -c "pwrite -S 0xcd 0 20" $MNT/file_$i > /dev/null
  done

  echo
  echo "Creating second snapshot..."
  btrfs subvolume snapshot -r $MNT $MNT/snap2

  umount $MNT

  echo 3 > /proc/sys/vm/drop_caches
  blockdev --flushbufs $DEV &> /dev/null
  hdparm -F $DEV &> /dev/null

  mount $MOUNT_OPTIONS $DEV $MNT

  echo
  echo "Testing full send..."
  start=$(date +%s)
  btrfs send $MNT/snap1 > /dev/null
  end=$(date +%s)
  echo
  echo "Full send took $((end - start)) seconds"

  echo
  echo "Testing incremental send..."
  start=$(date +%s)
  btrfs send -p $MNT/snap1 $MNT/snap2 > /dev/null
  end=$(date +%s)
  echo
  echo "Incremental send took $((end - start)) seconds"

  umount $MNT

Before this change, full send duration:

with $initial_file_count == 200000:  165 seconds
with $initial_file_count == 500000:  407 seconds

After this change, full send duration:

with $initial_file_count == 200000:  149 seconds (-10.2%)
with $initial_file_count == 500000:  353 seconds (-14.2%)

For $initial_file_count == 200000 there are 62600 nodes and leaves in the
btree of the first snapshot, while for $initial_file_count == 500000 there
are 152476 nodes and leaves.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f87878274e9f..7ff81da30af4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6653,6 +6653,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
+	path->reada = READA_FORWARD;
 
 	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
 	key.type = BTRFS_INODE_ITEM_KEY;
-- 
2.28.0

