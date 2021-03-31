Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85D34FE5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhCaK4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 06:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234995AbhCaK4Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 06:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C0F61952
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617188184;
        bh=3mZ5kaYgygjNfuv3Z/Aix/PueH394XwLJMCFeLzRtQc=;
        h=From:To:Subject:Date:From;
        b=kC5gygak65OgdzIU7M5NXyELmlJSRfCJEtEndYYyW2fWhNCsTVPWJcX48SURs+AXA
         xrUVnUUtbol0mPnDzZnpCo06N1+T/7k+rN7d6LcADrsA7SIqZsU4KFg3T0Uw66nPHZ
         Tt4cmdN+1nyswdS+rOQ8I+v3SlwH1Vh5hMl8j911TGAPhxl1Fo97WFgIBnZBoKqP9f
         RmUzPD5dYA70xoyEAZJiYrikoNkw0hd+GyGw6mXksMyinHD9ND+eyTuAilStE/5S7I
         bBuL7sxEVh+IAMFy1xum+0DpjVLNl+n/p2rCshXrpjLaKKRg8PrPsqoN7SGTw4uc1g
         cvsJESAJhMF3w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: improve btree readahead for full send operations
Date:   Wed, 31 Mar 2021 11:56:21 +0100
Message-Id: <ec7b0d5e27fc3f54c888fb7b71510f3a6d793cd7.1617188079.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently a full send operation uses the standard btree readahead when
iterating over the subvolume/snapshot btree, which despite bringing good
performance benefits, it could be improved in a few aspects for use cases
such as full send operations, which are guaranteed to visit every node
and leaf of a btree, in ascending and sequential order. The limitations
of that standard btree readahead implementation are the following:

1) It only triggers readahead for for leaves that are physically close
   to the leaf being read, within a 64K range;

2) It only triggers readahead for the next or previous leaves if the
   leaf being read is not currently in memory;

3) It never triggers readahead for nodes.

So add a new readahead mode that addresses all these points and use it
for full send operations.

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

The durations of the full send operation in seconds were the following:

Before this change:  217 seconds
After this change:   205 seconds (-5.7%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 28 ++++++++++++++++++++++++----
 fs/btrfs/ctree.h | 22 +++++++++++++++++++++-
 fs/btrfs/send.c  |  2 +-
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 26c2d50ea2db..a484fb72a01f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1279,12 +1279,13 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 	u64 search;
 	u64 target;
 	u64 nread = 0;
+	u64 nread_max;
 	struct extent_buffer *eb;
 	u32 nr;
 	u32 blocksize;
 	u32 nscan = 0;
 
-	if (level != 1)
+	if (level != 1 && path->reada != READA_FORWARD_ALWAYS)
 		return;
 
 	if (!path->nodes[level])
@@ -1292,6 +1293,20 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 
 	node = path->nodes[level];
 
+	/*
+	 * Since the time between visiting leaves is much shorter than the time
+	 * between visiting nodes, limit read ahead of nodes to 1, to avoid too
+	 * much IO at once (possibly random).
+	 */
+	if (path->reada == READA_FORWARD_ALWAYS) {
+		if (level > 1)
+			nread_max = node->fs_info->nodesize;
+		else
+			nread_max = SZ_128K;
+	} else {
+		nread_max = SZ_64K;
+	}
+
 	search = btrfs_node_blockptr(node, slot);
 	blocksize = fs_info->nodesize;
 	eb = find_extent_buffer(fs_info, search);
@@ -1310,7 +1325,8 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 			if (nr == 0)
 				break;
 			nr--;
-		} else if (path->reada == READA_FORWARD) {
+		} else if (path->reada == READA_FORWARD ||
+			   path->reada == READA_FORWARD_ALWAYS) {
 			nr++;
 			if (nr >= nritems)
 				break;
@@ -1321,13 +1337,14 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
 				break;
 		}
 		search = btrfs_node_blockptr(node, nr);
-		if ((search <= target && target - search <= 65536) ||
+		if (path->reada == READA_FORWARD_ALWAYS ||
+		    (search <= target && target - search <= 65536) ||
 		    (search > target && search - target <= 65536)) {
 			btrfs_readahead_node_child(node, nr);
 			nread += blocksize;
 		}
 		nscan++;
-		if ((nread > 65536 || nscan > 32))
+		if (nread > nread_max || nscan > 32)
 			break;
 	}
 }
@@ -1436,6 +1453,9 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 
 	tmp = find_extent_buffer(fs_info, blocknr);
 	if (tmp) {
+		if (p->reada == READA_FORWARD_ALWAYS)
+			reada_for_search(fs_info, p, level, slot, key->objectid);
+
 		/* first we do an atomic uptodate check */
 		if (btrfs_buffer_uptodate(tmp, gen, 1) > 0) {
 			/*
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f2fd73e58ee6..2c858d5349c8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -342,6 +342,27 @@ struct btrfs_node {
 	struct btrfs_key_ptr ptrs[];
 } __attribute__ ((__packed__));
 
+/* Read ahead values for struct btrfs_path.reada */
+enum {
+	READA_NONE,
+	READA_BACK,
+	READA_FORWARD,
+	/*
+	 * Similar to READA_FORWARD but unlike it:
+	 *
+	 * 1) It will trigger readahead even for leaves that are not close to
+	 *    each other on disk;
+	 * 2) It also triggers readahead for nodes;
+	 * 3) During a search, even when a node or leaf is already in memory, it
+	 *    will still trigger readahead for other nodes and leaves that follow
+	 *    it.
+	 *
+	 * This is meant to be used only when we know we are iterating over the
+	 * entire tree or a very large part of it.
+	 */
+	READA_FORWARD_ALWAYS,
+};
+
 /*
  * btrfs_paths remember the path taken from the root down to the leaf.
  * level 0 is always the leaf, and nodes[1...BTRFS_MAX_LEVEL] will point
@@ -350,7 +371,6 @@ struct btrfs_node {
  * The slots array records the index of the item or block pointer
  * used while walking the tree.
  */
-enum { READA_NONE, READA_BACK, READA_FORWARD };
 struct btrfs_path {
 	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
 	int slots[BTRFS_MAX_LEVEL];
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3cc306397261..55741adf9071 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6650,7 +6650,7 @@ static int full_send_tree(struct send_ctx *sctx)
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
-	path->reada = READA_FORWARD;
+	path->reada = READA_FORWARD_ALWAYS;
 
 	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
 	key.type = BTRFS_INODE_ITEM_KEY;
-- 
2.28.0

