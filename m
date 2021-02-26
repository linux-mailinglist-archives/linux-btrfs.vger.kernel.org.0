Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF9326496
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBZPRt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 10:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhBZPRr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 10:17:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9712764EF0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614352627;
        bh=Tv98pzZ0Q1TZRWbYMd8qm2rEJ1SykiN/P4dCGqeOa5s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fadrPEDxhOKjJtI1VQYclnwDajVWYYwEf65EbvLTLpHqpWp1Ll29BijlvN0fnLqlS
         lpETTcaC5z2J3fJgusxw9dl7MDoWEkl8GMI2L4mu+JC3JqHFKdwIuYXlycXW1ic7eG
         RyRRbnUhybN8it5SoddzAfEbrrbjFkTnM49MXDkEkF/EeaUdLv2i9O+ung7x4/nk9f
         zi8YFClaXHR+NtVhuSoyhBW5BCpe6yz1D14i4kurUrRkkspTAlvoa3XBEJUbj8ZZL+
         ovFKQeV2IbltFnxqvjRn5HkuU8fWjuccPATrbQJtz3aIhNp1ujsoHB2P6wB44Eygwn
         o7FTJuaWFzPGQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add btree read ahead for incremental send operations
Date:   Fri, 26 Feb 2021 15:17:02 +0000
Message-Id: <c2ff5dd6cecbe00e7bf6ea957e5eea86d27b1e67.1614351671.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614351671.git.fdmanana@suse.com>
References: <cover.1614351671.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently we do not do btree read ahead when doing an incremental send,
however we know that we will read and process any node or leaf in the
send root that has a generation greater than the generation of the parent
root. So triggering read ahead for such nodes and leafs is beneficial
for an incremental send.

This change does that, triggers read ahead of any node or leaf in the
send root that has a generation greater then the generation of the
parent root. As for the parent root, no readahead is triggered because
knowing in advance which nodes/leaves are going to be read is not so
linear and there's often a large time window between visiting nodes or
leaves of the parent root. So I opted to leave out the parent root,
and triggering read ahead for every node/leaf of the parent root made
things slightly worse (as expected).

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

Before this change, incremental send duration:

with $initial_file_count == 200000: 64 seconds
with $initial_file_count == 500000: 179 seconds

After this change, incremental send duration:

with $initial_file_count == 200000:  52 seconds (-20.7%)
with $initial_file_count == 500000:  130 seconds (-31.7%)

For $initial_file_count == 200000 there are 62600 nodes and leaves in the
btree of the first snapshot, and 77759 nodes and leaves in the btree of
the second snapshot.

While for $initial_file_count == 500000 there are 152476 nodes and leaves
in the btree of the first snapshot, and 190511 nodes and leaves in the
btree of the second snapshot.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7ff81da30af4..b53d16721b2d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6692,15 +6692,22 @@ static int full_send_tree(struct send_ctx *sctx)
 	return ret;
 }
 
-static int tree_move_down(struct btrfs_path *path, int *level)
+static int tree_move_down(struct btrfs_path *path, int *level, u64 min_reada_gen)
 {
 	struct extent_buffer *eb;
+	struct extent_buffer *parent = path->nodes[*level];
+	const int nritems = btrfs_header_nritems(parent);
+	int slot = path->slots[*level];
 
 	BUG_ON(*level == 0);
-	eb = btrfs_read_node_slot(path->nodes[*level], path->slots[*level]);
+	eb = btrfs_read_node_slot(parent, slot);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
 
+	for (slot++; slot < nritems; slot++)
+		if (btrfs_node_ptr_generation(parent, slot) > min_reada_gen)
+			btrfs_readahead_node_child(parent, slot);
+
 	path->nodes[*level - 1] = eb;
 	path->slots[*level - 1] = 0;
 	(*level)--;
@@ -6740,14 +6747,15 @@ static int tree_move_next_or_upnext(struct btrfs_path *path,
 static int tree_advance(struct btrfs_path *path,
 			int *level, int root_level,
 			int allow_down,
-			struct btrfs_key *key)
+			struct btrfs_key *key,
+			u64 min_reada_gen)
 {
 	int ret;
 
 	if (*level == 0 || !allow_down) {
 		ret = tree_move_next_or_upnext(path, level, root_level);
 	} else {
-		ret = tree_move_down(path, level);
+		ret = tree_move_down(path, level, min_reada_gen);
 	}
 	if (ret >= 0) {
 		if (*level == 0)
@@ -6821,6 +6829,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	u64 right_blockptr;
 	u64 left_gen;
 	u64 right_gen;
+	u64 min_reada_gen;
 
 	left_path = btrfs_alloc_path();
 	if (!left_path) {
@@ -6900,6 +6909,14 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		ret = -ENOMEM;
 		goto out;
 	}
+	/*
+	 * Our right root is the parent root, while the left root is the "send"
+	 * root. We know that all new nodes/leaves in the left root must have
+	 * a generation greater than the right root's generation, so we trigger
+	 * readahead for those nodes and leaves of the left root, as we know we
+	 * will read them for sure.
+	 */
+	min_reada_gen = btrfs_header_generation(right_root->commit_root);
 	up_read(&fs_info->commit_root_sem);
 
 	if (left_level == 0)
@@ -6924,7 +6941,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			ret = tree_advance(left_path, &left_level,
 					left_root_level,
 					advance_left != ADVANCE_ONLY_NEXT,
-					&left_key);
+					&left_key, min_reada_gen);
 			if (ret == -1)
 				left_end_reached = ADVANCE;
 			else if (ret < 0)
@@ -6935,7 +6952,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			ret = tree_advance(right_path, &right_level,
 					right_root_level,
 					advance_right != ADVANCE_ONLY_NEXT,
-					&right_key);
+					&right_key, min_reada_gen);
 			if (ret == -1)
 				right_end_reached = ADVANCE;
 			else if (ret < 0)
-- 
2.28.0

