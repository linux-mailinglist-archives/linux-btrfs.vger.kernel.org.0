Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7AA327AB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhCAJ1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 04:27:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhCAJ12 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 04:27:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1095164E3F
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Mar 2021 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614590807;
        bh=Z8R492mCd1t5P6nD2pDOek2h+CM0gEbBIkOWkuGSlCk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bCdw0Y4GSfVK2+XRo8VAP/8o367O1wdHPDMPXVBTzJd5IbX5KjKwSDwDYoww06/3V
         LK/ojjyLBeOV1/7jgpVyIIAvzYzbl/JvNfcxjJ2RRyHlC0obO48R4MM5mFN71OfBTv
         Y7aEMZcmguosLW21iM9nKNWh4ZJIG/OKVMvH96s1pk2xE9xc+P7Dk81NhhcguSICur
         4Zq8I68XeTrBkdD95F1dh3hzORPnPKscX0QLF0VY7NgVIucf3UptcpdP62VOQk8wOi
         AYocaN7PA50lQB2E30j5o54azh+rZENzQvbU/+kKGQ0QnZHGiqvcH3pcK5NQA0fBFi
         XBTZCuBY5tX9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: add btree read ahead for incremental send operations
Date:   Mon,  1 Mar 2021 09:26:43 +0000
Message-Id: <25eec324e30a71cbcc991cb74317df93209cee99.1614590582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1614590582.git.fdmanana@suse.com>
References: <cover.1614590582.git.fdmanana@suse.com>
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
and triggering read ahead for its nodes/leaves seemed to have not made
significant difference.

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

  umount $MNT

  echo 3 > /proc/sys/vm/drop_caches
  blockdev --flushbufs $DEV &> /dev/null
  hdparm -F $DEV &> /dev/null

  mount $MOUNT_OPTIONS $DEV $MNT

  echo
  echo "Testing incremental send..."
  start=$(date +%s)
  btrfs send -p $MNT/snap1 $MNT/snap2 > /dev/null
  end=$(date +%s)
  echo
  echo "Incremental send took $((end - start)) seconds"

  umount $MNT

Before this change, incremental send duration:

with $initial_file_count == 200000: 51 seconds
with $initial_file_count == 500000: 168 seconds

After this change, incremental send duration:

with $initial_file_count == 200000:  39 seconds (-26.7%)
with $initial_file_count == 500000:  125 seconds (-29.4%)

For $initial_file_count == 200000 there are 62600 nodes and leaves in the
btree of the first snapshot, and 77759 nodes and leaves in the btree of
the second snapshot. The root nodes were at level 2.

While for $initial_file_count == 500000 there are 152476 nodes and leaves
in the btree of the first snapshot, and 190511 nodes and leaves in the
btree of the second snapshot. The root nodes were at level 2 as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7ff81da30af4..3bfd5609fbac 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6692,15 +6692,35 @@ static int full_send_tree(struct send_ctx *sctx)
 	return ret;
 }
 
-static int tree_move_down(struct btrfs_path *path, int *level)
+static int tree_move_down(struct btrfs_path *path, int *level, u64 reada_min_gen)
 {
 	struct extent_buffer *eb;
+	struct extent_buffer *parent = path->nodes[*level];
+	int slot = path->slots[*level];
+	const int nritems = btrfs_header_nritems(parent);
+	u64 reada_max;
+	u64 reada_done = 0;
 
 	BUG_ON(*level == 0);
-	eb = btrfs_read_node_slot(path->nodes[*level], path->slots[*level]);
+	eb = btrfs_read_node_slot(parent, slot);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
 
+	/*
+	 * Trigger readahead for the next leaves we will process, so that it is
+	 * very likely that when we need them they are already in memory and we
+	 * will not block on disk IO. For nodes we only do readahead for one,
+	 * since the time window between processing nodes is typically larger.
+	 */
+	reada_max = *level == 1 ? SZ_128K : eb->fs_info->nodesize;
+
+	for (slot++; slot < nritems && reada_done < reada_max; slot++) {
+		if (btrfs_node_ptr_generation(parent, slot) > reada_min_gen) {
+			btrfs_readahead_node_child(parent, slot);
+			reada_done += eb->fs_info->nodesize;
+		}
+	}
+
 	path->nodes[*level - 1] = eb;
 	path->slots[*level - 1] = 0;
 	(*level)--;
@@ -6740,14 +6760,15 @@ static int tree_move_next_or_upnext(struct btrfs_path *path,
 static int tree_advance(struct btrfs_path *path,
 			int *level, int root_level,
 			int allow_down,
-			struct btrfs_key *key)
+			struct btrfs_key *key,
+			u64 reada_min_gen)
 {
 	int ret;
 
 	if (*level == 0 || !allow_down) {
 		ret = tree_move_next_or_upnext(path, level, root_level);
 	} else {
-		ret = tree_move_down(path, level);
+		ret = tree_move_down(path, level, reada_min_gen);
 	}
 	if (ret >= 0) {
 		if (*level == 0)
@@ -6821,6 +6842,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	u64 right_blockptr;
 	u64 left_gen;
 	u64 right_gen;
+	u64 reada_min_gen;
 
 	left_path = btrfs_alloc_path();
 	if (!left_path) {
@@ -6900,6 +6922,14 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		ret = -ENOMEM;
 		goto out;
 	}
+	/*
+	 * Our right root is the parent root, while the left root is the "send"
+	 * root. We know that all new nodes/leaves in the left root must have
+	 * a generation greater than the right root's generation, so we trigger
+	 * readahead for those nodes and leaves of the left root, as we know we
+	 * will need to read them at some point.
+	 */
+	reada_min_gen = btrfs_header_generation(right_root->commit_root);
 	up_read(&fs_info->commit_root_sem);
 
 	if (left_level == 0)
@@ -6924,7 +6954,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			ret = tree_advance(left_path, &left_level,
 					left_root_level,
 					advance_left != ADVANCE_ONLY_NEXT,
-					&left_key);
+					&left_key, reada_min_gen);
 			if (ret == -1)
 				left_end_reached = ADVANCE;
 			else if (ret < 0)
@@ -6935,7 +6965,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			ret = tree_advance(right_path, &right_level,
 					right_root_level,
 					advance_right != ADVANCE_ONLY_NEXT,
-					&right_key);
+					&right_key, reada_min_gen);
 			if (ret == -1)
 				right_end_reached = ADVANCE;
 			else if (ret < 0)
-- 
2.28.0

