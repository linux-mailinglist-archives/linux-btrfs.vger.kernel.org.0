Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFB220BEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGOLas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 07:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgGOLar (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 07:30:47 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454542063A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jul 2020 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594812646;
        bh=pAKmuapZDqFNjvqHkbc5JfgcHHYIyruZnzCtfnmO1RE=;
        h=From:To:Subject:Date:From;
        b=qkSfIHxuNSKMmeHG4rhfrtmVafbfL3mHYF963b7N7YAClF/lek/Qvf4vu7TXlDFfM
         utv9tg/vwPQP9bjlP1LW6be/8soJqyD6DZlqMOnAL/q6/Bt1BRaE98VIWuRGnUBiwL
         OIjnmJt2EnLsqc5Srh0D1ivXKbc/DF1XMCA+B7w0=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reduce contention on log trees when logging checksums
Date:   Wed, 15 Jul 2020 12:30:43 +0100
Message-Id: <20200715113043.3192206-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The possibility of extents being shared (through clone and deduplication
operations) requires special care when logging data checksums, to avoid
having a log tree with different checksum items that cover ranges which
overlap (which resulted in missing checksums after replaying a log tree).
Such problems were fixed in the past by the following commits:

commit 40e046acbd2f ("Btrfs: fix missing data checksums after replaying a
                      log tree")

commit e289f03ea79b ("btrfs: fix corrupt log due to concurrent fsync of
                      inodes with shared extents")

Test case generic/588 exercises the scenario solved by the first commit
(purely sequential and deterministic) while test case generic/457 often
triggered the case fixed by the second commit (not deterministic, requires
specific timings under concurrency).

The problems were addressed by deleting, from the log tree, any existing
checksums before logging the new ones. And also by doing the deletion and
logging of the cheksums while locking the checksum range in an extent io
tree (root->log_csum_range), to deal with the case where we have concurrent
fsyncs against files with shared extents.

That however causes more contention on the leaves of a log tree where we
store checksums (and all the nodes in the paths leading to them), even
when we do not have shared extents, or all the shared extents were created
by past transactions. It also adds a bit of contention on the spin lock of
the log_csums_range extent io tree of the log root.

This change adds a 'last_reflink_trans' field to the inode to keep track
of the last transaction where a new extent was shared between inodes
(through clone and deduplication operations). It is updated for both the
source and destination inodes of reflink operations whenever a new extent
(created in the current transaction) becomes shared by the inodes. This
field is kept in memory only, not persisted in the inode item, similar
to other existing fields (last_unlink_trans, logged_trans).

When logging checksums for an extent, if the value of 'last_reflink_trans'
is smaller then the current transaction's generation/id, we skip locking
the extent range and deletion of checksums from the log tree, since we
know we do not have new shared extents. This reduces contention on the
log tree's leaves where checksums are stored.

The following script, which uses fio, was used to measure the impact of
this change:

  $ cat test-fsync.sh
  #!/bin/bash

  DEV=/dev/sdk
  MNT=/mnt/sdk
  MOUNT_OPTIONS="-o ssd"
  MKFS_OPTIONS="-d single -m single"

  if [ $# -ne 3 ]; then
      echo "Use $0 NUM_JOBS FILE_SIZE FSYNC_FREQ"
      exit 1
  fi

  NUM_JOBS=$1
  FILE_SIZE=$2
  FSYNC_FREQ=$3

  cat <<EOF > /tmp/fio-job.ini
  [writers]
  rw=write
  fsync=$FSYNC_FREQ
  fallocate=none
  group_reporting=1
  direct=0
  bs=64k
  ioengine=sync
  size=$FILE_SIZE
  directory=$MNT
  numjobs=$NUM_JOBS
  EOF

  echo "Using config:"
  echo
  cat /tmp/fio-job.ini
  echo

  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT
  fio /tmp/fio-job.ini
  umount $MNT

The tests were performed for different numbers of jobs, file sizes and
fsync frequency. A qemu VM using kvm was used, with 8 cores (the host has
12 cores, with cpu governance set to performance mode on all cores), 16Gb
of ram (the host has 64Gb) and using a NVMe device directly (without an
intermediary filesystem in the host). While running the tests, the host
was not used for anything else, to avoid disturbing the tests.

The obtained results were the following (the last line of fio's output was
pasted). Starting with 16 jobs is where a significant difference is
observable in this particular setup and hardware (differences highlighted
below). The very small differences for tests with less than 16 jobs are
possibly just noise and random.

    **** 1 job, file size 1G, fsync frequency 1 ****

before this change:

WRITE: bw=23.8MiB/s (24.9MB/s), 23.8MiB/s-23.8MiB/s (24.9MB/s-24.9MB/s), io=1024MiB (1074MB), run=43075-43075msec

after this change:

WRITE: bw=24.4MiB/s (25.6MB/s), 24.4MiB/s-24.4MiB/s (25.6MB/s-25.6MB/s), io=1024MiB (1074MB), run=41938-41938msec

    **** 2 jobs, file size 1G, fsync frequency 1 ****

before this change:

WRITE: bw=37.7MiB/s (39.5MB/s), 37.7MiB/s-37.7MiB/s (39.5MB/s-39.5MB/s), io=2048MiB (2147MB), run=54351-54351msec

after this change:

WRITE: bw=37.7MiB/s (39.5MB/s), 37.6MiB/s-37.6MiB/s (39.5MB/s-39.5MB/s), io=2048MiB (2147MB), run=54428-54428msec

    **** 4 jobs, file size 1G, fsync frequency 1 ****

before this change:

WRITE: bw=67.5MiB/s (70.8MB/s), 67.5MiB/s-67.5MiB/s (70.8MB/s-70.8MB/s), io=4096MiB (4295MB), run=60669-60669msec

after this change:

WRITE: bw=68.6MiB/s (71.0MB/s), 68.6MiB/s-68.6MiB/s (71.0MB/s-71.0MB/s), io=4096MiB (4295MB), run=59678-59678msec

    **** 8 jobs, file size 1G, fsync frequency 1 ****

before this change:

WRITE: bw=128MiB/s (134MB/s), 128MiB/s-128MiB/s (134MB/s-134MB/s), io=8192MiB (8590MB), run=64048-64048msec

after this change:

WRITE: bw=129MiB/s (135MB/s), 129MiB/s-129MiB/s (135MB/s-135MB/s), io=8192MiB (8590MB), run=63405-63405msec

    **** 16 jobs, file size 1G, fsync frequency 1 ****

before this change:

WRITE: bw=78.5MiB/s (82.3MB/s), 78.5MiB/s-78.5MiB/s (82.3MB/s-82.3MB/s), io=16.0GiB (17.2GB), run=208676-208676msec

after this change:

WRITE: bw=110MiB/s (115MB/s), 110MiB/s-110MiB/s (115MB/s-115MB/s), io=16.0GiB (17.2GB), run=149295-149295msec
(+40.1% throughput, -28.5% runtime)

    **** 32 jobs, file size 1G, fsync frequency 1 ****

before this change:

WRITE: bw=58.8MiB/s (61.7MB/s), 58.8MiB/s-58.8MiB/s (61.7MB/s-61.7MB/s), io=32.0GiB (34.4GB), run=557134-557134msec

after this change:

WRITE: bw=76.1MiB/s (79.8MB/s), 76.1MiB/s-76.1MiB/s (79.8MB/s-79.8MB/s), io=32.0GiB (34.4GB), run=430550-430550msec
(+29.4% throughput, -22.7% runtime)

    **** 64 jobs, file size 512M, fsync frequency 1 ****

before this change:

WRITE: bw=65.8MiB/s (68.0MB/s), 65.8MiB/s-65.8MiB/s (68.0MB/s-68.0MB/s), io=32.0GiB (34.4GB), run=498055-498055msec

after this change:

WRITE: bw=85.1MiB/s (89.2MB/s), 85.1MiB/s-85.1MiB/s (89.2MB/s-89.2MB/s), io=32.0GiB (34.4GB), run=385116-385116msec
(+29.3% throughput, -22.7% runtime)

    **** 128 jobs, file size 256M, fsync frequency 1 ****

before this change:

WRITE: bw=54.7MiB/s (57.3MB/s), 54.7MiB/s-54.7MiB/s (57.3MB/s-57.3MB/s), io=32.0GiB (34.4GB), run=599373-599373msec

after this change:

WRITE: bw=121MiB/s (126MB/s), 121MiB/s-121MiB/s (126MB/s-126MB/s), io=32.0GiB (34.4GB), run=271907-271907msec
(+121.2% throughput, -54.6% runtime)

    **** 256 jobs, file size 256M, fsync frequency 1 ****

before this change:

WRITE: bw=69.2MiB/s (72.5MB/s), 69.2MiB/s-69.2MiB/s (72.5MB/s-72.5MB/s), io=64.0GiB (68.7GB), run=947536-947536msec

after this change:

WRITE: bw=121MiB/s (127MB/s), 121MiB/s-121MiB/s (127MB/s-127MB/s), io=64.0GiB (68.7GB), run=541916-541916msec
(+74.9% throughput, -42.8% runtime)

    **** 512 jobs, file size 128M, fsync frequency 1 ****

before this change:

WRITE: bw=85.4MiB/s (89.5MB/s), 85.4MiB/s-85.4MiB/s (89.5MB/s-89.5MB/s), io=64.0GiB (68.7GB), run=767734-767734msec

after this change:

WRITE: bw=141MiB/s (147MB/s), 141MiB/s-141MiB/s (147MB/s-147MB/s), io=64.0GiB (68.7GB), run=466022-466022msec
(+65.1% throughput, -39.3% runtime)

    **** 1024 jobs, file size 128M, fsync frequency 1 ****

before this change:

WRITE: bw=115MiB/s (120MB/s), 115MiB/s-115MiB/s (120MB/s-120MB/s), io=128GiB (137GB), run=1143775-1143775msec

after this change:

WRITE: bw=171MiB/s (180MB/s), 171MiB/s-171MiB/s (180MB/s-180MB/s), io=128GiB (137GB), run=764843-764843msec
(+48.7% throughput, -33.1% runtime)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 11 +++++++++++
 fs/btrfs/inode.c       |  9 +++++++++
 fs/btrfs/reflink.c     | 15 +++++++++++++++
 fs/btrfs/tree-log.c    | 13 +++++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e7d709505cb1..c47b6c6fea9f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -151,6 +151,17 @@ struct btrfs_inode {
 	 */
 	u64 last_unlink_trans;
 
+	/*
+	 * The id/generation of the last transaction where this inode was
+	 * either the source or the destination of a clone/dedupe operation.
+	 * Used when logging an inode to know if there are shared extents that
+	 * need special care when logging checksum items, to avoid duplicate
+	 * checksum items in a log (which can lead to a corruption where we end
+	 * up with missing checksum ranges after log replay).
+	 * Protected by the vfs inode lock.
+	 */
+	u64 last_reflink_trans;
+
 	/*
 	 * Number of bytes outstanding that are going to need csums.  This is
 	 * used in ENOSPC accounting.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2115eda7feda..fe03d07f888c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3333,6 +3333,14 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	 */
 	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
 
+	/*
+	 * Same logic as for last_unlink_trans. We don't persist the generation
+	 * of the last transaction where this inode was used for a reflink
+	 * operation, so after eviction and reloading the inode we must be
+	 * pessimistic and assume the last transaction that modified the inode.
+	 */
+	BTRFS_I(inode)->last_reflink_trans = BTRFS_I(inode)->last_trans;
+
 	path->slots[0]++;
 	if (inode->i_nlink != 1 ||
 	    path->slots[0] >= btrfs_header_nritems(leaf))
@@ -8549,6 +8557,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->index_cnt = (u64)-1;
 	ei->dir_index = 0;
 	ei->last_unlink_trans = 0;
+	ei->last_reflink_trans = 0;
 	ei->last_log_commit = 0;
 
 	spin_lock_init(&ei->lock);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 834eb6d98caa..5cd02514cf4d 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -337,6 +337,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	while (1) {
 		u64 next_key_min_offset = key.offset + 1;
 		struct btrfs_file_extent_item *extent;
+		u64 extent_gen;
 		int type;
 		u32 size;
 		struct btrfs_key new_key;
@@ -385,6 +386,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 		extent = btrfs_item_ptr(leaf, slot,
 					struct btrfs_file_extent_item);
+		extent_gen = btrfs_file_extent_generation(leaf, extent);
 		comp = btrfs_file_extent_compression(leaf, extent);
 		type = btrfs_file_extent_type(leaf, extent);
 		if (type == BTRFS_FILE_EXTENT_REG ||
@@ -489,6 +491,19 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 		btrfs_release_path(path);
 
+		/*
+		 * If this is a new extent update the last_reflink_trans of both
+		 * inodes. This is used by fsync to make sure it does not log
+		 * multiple checksum items with overlapping ranges. For older
+		 * extents we don't need to do it since inode logging skips the
+		 * checksums for older extents. Also ignore holes and inline
+		 * extents because they don't have checksums in the csum tree.
+		 */
+		if (extent_gen == trans->transid && disko > 0) {
+			BTRFS_I(src)->last_reflink_trans = trans->transid;
+			BTRFS_I(inode)->last_reflink_trans = trans->transid;
+		}
+
 		last_dest_end = ALIGN(new_key.offset + datal,
 				      fs_info->sectorsize);
 		ret = clone_finish_inode_update(trans, inode, last_dest_end,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d1a542be4db5..20334bebcaf2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3891,6 +3891,7 @@ static int log_inode_item(struct btrfs_trans_handle *trans,
 }
 
 static int log_csums(struct btrfs_trans_handle *trans,
+		     struct btrfs_inode *inode,
 		     struct btrfs_root *log_root,
 		     struct btrfs_ordered_sum *sums)
 {
@@ -3898,6 +3899,14 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	struct extent_state *cached_state = NULL;
 	int ret;
 
+	/*
+	 * If this inode was not used for reflink operations in the current
+	 * transaction with new extents, then do the fast path, no need to
+	 * worry about logging checksum items with overlapping ranges.
+	 */
+	if (inode->last_reflink_trans < trans->transid)
+		return btrfs_csum_file_blocks(trans, log_root, sums);
+
 	/*
 	 * Serialize logging for checksums. This is to avoid racing with the
 	 * same checksum being logged by another task that is logging another
@@ -4049,7 +4058,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 						   struct btrfs_ordered_sum,
 						   list);
 		if (!ret)
-			ret = log_csums(trans, log, sums);
+			ret = log_csums(trans, inode, log, sums);
 		list_del(&sums->list);
 		kfree(sums);
 	}
@@ -4108,7 +4117,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 						   struct btrfs_ordered_sum,
 						   list);
 		if (!ret)
-			ret = log_csums(trans, log_root, sums);
+			ret = log_csums(trans, inode, log_root, sums);
 		list_del(&sums->list);
 		kfree(sums);
 	}
-- 
2.26.2

