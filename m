Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4113CFDB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhGTO6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239984AbhGTOWd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2765610F7
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793386;
        bh=Ucl24oHM5iW+cRQ6rEKKDwivQC2Y561F7tGhfogogHk=;
        h=From:To:Subject:Date:From;
        b=V/ArZUp83/qBCKcqDnexzvd4NS4z6znpdn4fv2Z8M5r4wcjFNazWu+Pwd3b8sr7RP
         7vTqypCuAqJplRN3ILfKPKia4Q7IfJ3kOZv3K8NXo66Es9s1t0ipBxhK398gsz/cqF
         +hgcVqn3pjCg21bx64TV40ZdFEvmHJYZyX3jlxZz6T82CkmAHHblWhJ/VMBLNkKZ9p
         lrjvuv4eJa6u4EhIQ40LFCU94/vNr+Uv0d6DXQLo8xu2HXkzvJF315voe3AsR8I0rG
         eQoGmJz/cdcsJQmXFPXcMvIFjjcY0omY0rvuUXYRFbxZiRfGpY28T/ldj83x6mDjFz
         HZYiXV8Je5/YA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: continue readahead of siblings even if target node is in memory
Date:   Tue, 20 Jul 2021 16:03:03 +0100
Message-Id: <1589fffc3a30631b2268b4f64e55fcf9ce664fb6.1626792325.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At reada_for_search(), when attempting to readahead a node or leaf's
siblings, we skip the readahead of the siblings if the node/leaf is
already in memory. That is probably fine for the READA_FORWARD and
READA_BACK readahead types, as they are used on contextes where we
end up reading some consecutive leaves, but usually not the whole btree.

However for a READA_FORWARD_ALWAYS mode, currently only used for full
send operations, it does not make sense to skip the readahead if the
target node or leaf is already loaded in memory, since we know the caller
is visiting every node and leaf of the btree in ascending order.

So change the behaviour to not skip the readahead when the target node is
already in memory and the readahead mode is READA_FORWARD_ALWAYS.

The following test script was used to measure the improvement on a box
using an average, consumer grade, spinning disk, with 32GiB of RAM and
using a non-debug kernel config (Debian's default config).

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

  file_count=2000000
  add_files $file_count 0 4

  echo
  echo "Creating snapshot..."
  btrfs subvolume snapshot -r $MNT $MNT/snap1

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

  umount $MNT

The duration of the full send operations, in seconds, were the following:

Before this change:  85 seconds
After this change:   76 seconds (-11.2%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c212f1218fdd..63c026495193 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1233,7 +1233,6 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	u64 target;
 	u64 nread = 0;
 	u64 nread_max;
-	struct extent_buffer *eb;
 	u32 nr;
 	u32 blocksize;
 	u32 nscan = 0;
@@ -1262,10 +1261,14 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 
 	search = btrfs_node_blockptr(node, slot);
 	blocksize = fs_info->nodesize;
-	eb = find_extent_buffer(fs_info, search);
-	if (eb) {
-		free_extent_buffer(eb);
-		return;
+	if (path->reada != READA_FORWARD_ALWAYS) {
+		struct extent_buffer *eb;
+
+		eb = find_extent_buffer(fs_info, search);
+		if (eb) {
+			free_extent_buffer(eb);
+			return;
+		}
 	}
 
 	target = search;
-- 
2.30.2

