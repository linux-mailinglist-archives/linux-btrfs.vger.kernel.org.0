Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198ED4A8714
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiBCO4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:56:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48826 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351566AbiBCO4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:56:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9042B8347A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F98C340EF
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900159;
        bh=pQmnkNa+58TzC4oBl991ULR/e3Fdh4/tHEp6AZGfcZ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gUHuwukez7eaK2wVYa3rBMyAOVG9vCbkuC8J69vPODluATdHHLjSLPki9UkI0ymsR
         KfRSCmQlgRTLJYQWtS4j1ieCqPKoMQ/tVaaEVdXf9XfjNURjO3utcncVwrDlFcQlNq
         cVN/XsmfQEJKJ0FlukkKsIe3Mp0SiK2DLMZq/MtCMXUAzyzH1vqLPTw/1eCVmlPESS
         fxELp2pbuQE8RiS5c+rR0YHKtxmnNABCpx/sKBIhvPd9i4kJqUKRESAkbfg2T23HYe
         OYXDV8v2lqArghb1qPWczqRCCQNrF/okUXSRCZhTkrFAdPnEB/NCyyPyFk4+J+qV/J
         2AR156scX/CZQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: prepare extents to be logged before locking a log tree path
Date:   Thu,  3 Feb 2022 14:55:50 +0000
Message-Id: <755fb97d622e160a2088f0d73c2dbf460f62f30d.1643898314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we want to log an extent, in the fast fsync path, we obtain a path
to the leaf that will hold the file extent item either through a deletion
search, via btrfs_drop_extents(), or through an insertion search using
btrfs_insert_empty_item(). After that we fill the file extent item's
fields one by one directly on the leaf.

Instead of doing that, we could prepare the file extent item before
obtaining a btree path, and then copy the prepared extent item with a
single operation once we get the path. This helps avoid some contention
on the log tree, since we are holding write locks for longer than
necessary, especially in the case where the path is obtained via
btrfs_drop_extents() through a deletion search, which always keeps a
write lock on the nodes at levels 1 and 2 (besides the leaf).

This change does that, we prepare the file extent item that is going to
be inserted before acquiring a path, and then copy it into a leaf using
a single copy operation once we get a path.

This change if part of a patchset that is comprised of the following
patches:

  1/6 btrfs: remove unnecessary leaf free space checks when pushing items
  2/6 btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  3/6 btrfs: avoid unnecessary computation when deleting items from a leaf
  4/6 btrfs: remove constraint on number of visited leaves when replacing extents
  5/6 btrfs: remove useless path release in the fast fsync path
  6/6 btrfs: prepare extents to be logged before locking a log tree path

The following test was run to measure the impact of the whole patchset:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi
  MOUNT_OPTIONS="-o ssd"
  MKFS_OPTIONS="-R free-space-tree -O no-holes"

  NUM_JOBS=8
  FILE_SIZE=128M
  RUN_TIME=200

  cat <<EOF > /tmp/fio-job.ini
  [writers]
  rw=randwrite
  fsync=1
  fallocate=none
  group_reporting=1
  direct=0
  bssplit=4k/20:8k/20:16k/20:32k/10:64k/10:128k/5:256k/5:512k/5:1m/5
  ioengine=sync
  filesize=$FILE_SIZE
  runtime=$RUN_TIME
  time_based
  directory=$MNT
  numjobs=$NUM_JOBS
  thread
  EOF

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  echo
  echo "Using config:"
  echo
  cat /tmp/fio-job.ini
  echo

  umount $MNT &> /dev/null
  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  fio /tmp/fio-job.ini

  umount $MNT

The test ran inside a VM (8 cores, 32G of ram) with the target disk
mapping to a raw nvme device, and using a non-debug kernel config
(Debian's default config).

Before the patchset:

WRITE: bw=116MiB/s (122MB/s), 116MiB/s-116MiB/s (122MB/s-122MB/s), io=22.7GiB (24.4GB), run=200013-200013msec

After the patchset:

WRITE: bw=125MiB/s (131MB/s), 125MiB/s-125MiB/s (131MB/s-131MB/s), io=24.3GiB (26.1GB), run=200007-200007msec

A 7.8% gain on througput and +7.0% more IO done in the same period of
time (200 seconds).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 64 +++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 492dbc92d37e..e9b6eba7c42d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4657,14 +4657,34 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *log = inode->root->log_root;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_extent_item fi = { 0 };
 	struct extent_buffer *leaf;
-	struct btrfs_map_token token;
 	struct btrfs_key key;
 	u64 extent_offset = em->start - em->orig_start;
 	u64 block_len;
 	int ret;
 
+	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
+	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_PREALLOC);
+	else
+		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
+
+	block_len = max(em->block_len, em->orig_block_len);
+	if (em->compress_type != BTRFS_COMPRESS_NONE) {
+		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
+		btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len);
+	} else if (em->block_start < EXTENT_MAP_LAST_BYTE) {
+		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start -
+							extent_offset);
+		btrfs_set_stack_file_extent_disk_num_bytes(&fi, block_len);
+	}
+
+	btrfs_set_stack_file_extent_offset(&fi, extent_offset);
+	btrfs_set_stack_file_extent_num_bytes(&fi, em->len);
+	btrfs_set_stack_file_extent_ram_bytes(&fi, em->ram_bytes);
+	btrfs_set_stack_file_extent_compression(&fi, em->compress_type);
+
 	ret = log_extent_csums(trans, inode, log, em, ctx);
 	if (ret)
 		return ret;
@@ -4683,7 +4703,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		drop_args.start = em->start;
 		drop_args.end = em->start + em->len;
 		drop_args.replace_extent = true;
-		drop_args.extent_item_size = sizeof(*fi);
+		drop_args.extent_item_size = sizeof(fi);
 		ret = btrfs_drop_extents(trans, log, inode, &drop_args);
 		if (ret)
 			return ret;
@@ -4695,44 +4715,14 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 		key.offset = em->start;
 
 		ret = btrfs_insert_empty_item(trans, log, path, &key,
-					      sizeof(*fi));
+					      sizeof(fi));
 		if (ret)
 			return ret;
 	}
 	leaf = path->nodes[0];
-	btrfs_init_map_token(&token, leaf);
-	fi = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
-
-	btrfs_set_token_file_extent_generation(&token, fi, trans->transid);
-	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
-		btrfs_set_token_file_extent_type(&token, fi,
-						 BTRFS_FILE_EXTENT_PREALLOC);
-	else
-		btrfs_set_token_file_extent_type(&token, fi,
-						 BTRFS_FILE_EXTENT_REG);
-
-	block_len = max(em->block_len, em->orig_block_len);
-	if (em->compress_type != BTRFS_COMPRESS_NONE) {
-		btrfs_set_token_file_extent_disk_bytenr(&token, fi,
-							em->block_start);
-		btrfs_set_token_file_extent_disk_num_bytes(&token, fi, block_len);
-	} else if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-		btrfs_set_token_file_extent_disk_bytenr(&token, fi,
-							em->block_start -
-							extent_offset);
-		btrfs_set_token_file_extent_disk_num_bytes(&token, fi, block_len);
-	} else {
-		btrfs_set_token_file_extent_disk_bytenr(&token, fi, 0);
-		btrfs_set_token_file_extent_disk_num_bytes(&token, fi, 0);
-	}
-
-	btrfs_set_token_file_extent_offset(&token, fi, extent_offset);
-	btrfs_set_token_file_extent_num_bytes(&token, fi, em->len);
-	btrfs_set_token_file_extent_ram_bytes(&token, fi, em->ram_bytes);
-	btrfs_set_token_file_extent_compression(&token, fi, em->compress_type);
-	btrfs_set_token_file_extent_encryption(&token, fi, 0);
-	btrfs_set_token_file_extent_other_encoding(&token, fi, 0);
+	write_extent_buffer(leaf, &fi,
+			    btrfs_item_ptr_offset(leaf, path->slots[0]),
+			    sizeof(fi));
 	btrfs_mark_buffer_dirty(leaf);
 
 	btrfs_release_path(path);
-- 
2.33.0

