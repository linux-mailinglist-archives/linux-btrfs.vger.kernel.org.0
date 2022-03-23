Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE74E563C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245453AbiCWQVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245450AbiCWQVS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602078FCA
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BA661849
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A69C36AE2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052387;
        bh=SvO6PaZBubVRlErBjjjSUtzgLcZJl7aHMcmZeCBtoM0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AVUk2+9LEfFXpI8NK/gHAh/ehban26O2l8YFA5gFHT6bpMf58Ie+YB6U3iSpVZ7dJ
         bVcflKslGviSeRQD6eZwgDT34b+yTJIcRIHvYAtq2goO3vC0BnTUZ+dQwAZT4iZSOX
         HvnD/EC9KOMZARilp99n/sA7nOjEnncm+ZAo55E4YCeVDKKXMkbTM/ZFY90Z6GFxtX
         mPi7u8g6VoR5tgHvxbnliVj4t1M2GkwJqFZzwwbL6rd7PVaf2639Z4mB25rX0AVP7Z
         j/km4RW+XTVpaM6Mykb6GcF4scPljtg6KxPrLs0fg86EaqG6tB0D+HJ0vRcxnNteKY
         34stM8PQjijOA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: avoid blocking on space revervation when doing nowait dio writes
Date:   Wed, 23 Mar 2022 16:19:30 +0000
Message-Id: <4033e935eec985fda8bca79a865e14e3c26ab328.1648051583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a NOWAIT direct IO write, if we can NOCOW then it means we can
proceed with the non-blocking, NOWAIT path. However reserving the metadata
space and qgroup meta space can often result in blocking - flushing
delalloc, wait for ordered extents to complete, trigger transaction
commits, etc, going against the semantics of a NOWAIT write.

So make the NOWAIT write path to try to reserve all the metadata it needs
without resulting in a blocking behaviour - if we get -ENOSPC or -EDQUOT
then return -EAGAIN to make the caller fallback to a blocking direct IO
write.

This is part of a patchset comprised of the following patches:

  btrfs: avoid blocking on page locks with nowait dio on compressed range
  btrfs: avoid blocking nowait dio when locking file range
  btrfs: avoid double nocow check when doing nowait dio writes
  btrfs: stop allocating a path when checking if cross reference exists
  btrfs: free path at can_nocow_extent() before checking for checksum items
  btrfs: release path earlier at can_nocow_extent()
  btrfs: avoid blocking when allocating context for nowait dio read/write
  btrfs: avoid blocking on space revervation when doing nowait dio writes

The following test was run before and after applying this patchset:

  $ cat io-uring-nodatacow-test.sh
  #!/bin/bash

  DEV=/dev/sdc
  MNT=/mnt/sdc

  MOUNT_OPTIONS="-o ssd -o nodatacow"
  MKFS_OPTIONS="-R free-space-tree -O no-holes"

  NUM_JOBS=4
  FILE_SIZE=8G
  RUN_TIME=300

  cat <<EOF > /tmp/fio-job.ini
  [io_uring_rw]
  rw=randrw
  fsync=0
  fallocate=posix
  group_reporting=1
  direct=1
  ioengine=io_uring
  iodepth=64
  bssplit=4k/20:8k/20:16k/20:32k/10:64k/10:128k/5:256k/5:512k/5:1m/5
  filesize=$FILE_SIZE
  runtime=$RUN_TIME
  time_based
  filename=foobar
  directory=$MNT
  numjobs=$NUM_JOBS
  thread
  EOF

  echo performance | \
     tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  umount $MNT &> /dev/null
  mkfs.btrfs -f $MKFS_OPTIONS $DEV &> /dev/null
  mount $MOUNT_OPTIONS $DEV $MNT

  fio /tmp/fio-job.ini

  umount $MNT

The test was run a 12 cores box with 64G of ram, using a non-debug kernel
config (Debian's default config) and a spinning disk.

Result before the patchset:

 READ: bw=407MiB/s (427MB/s), 407MiB/s-407MiB/s (427MB/s-427MB/s), io=119GiB (128GB), run=300175-300175msec
WRITE: bw=407MiB/s (427MB/s), 407MiB/s-407MiB/s (427MB/s-427MB/s), io=119GiB (128GB), run=300175-300175msec

Result after the patchset:

 READ: bw=436MiB/s (457MB/s), 436MiB/s-436MiB/s (457MB/s-457MB/s), io=128GiB (137GB), run=300044-300044msec
WRITE: bw=435MiB/s (456MB/s), 435MiB/s-435MiB/s (456MB/s-456MB/s), io=128GiB (137GB), run=300044-300044msec

That's about +7.2% throughput for reads and +6.9% for writes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h          |  2 +-
 fs/btrfs/delalloc-space.c |  9 +++++----
 fs/btrfs/file.c           |  2 +-
 fs/btrfs/inode.c          | 13 +++++++++----
 fs/btrfs/qgroup.c         |  5 +++--
 fs/btrfs/qgroup.h         | 12 ++++++++----
 fs/btrfs/relocation.c     |  3 ++-
 fs/btrfs/root-tree.c      |  3 ++-
 8 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 85216b9492d5..c24e54820463 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2892,7 +2892,7 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				    u64 disk_num_bytes);
+				    u64 disk_num_bytes, bool noflush);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bd8267c4687d..36ab0859a263 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -289,7 +289,7 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
-				    u64 disk_num_bytes)
+				    u64 disk_num_bytes, bool noflush)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -308,7 +308,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 * If we have a transaction open (can happen if we call truncate_block
 	 * from truncate), then we need FLUSH_LIMIT so we don't deadlock.
 	 */
-	if (btrfs_is_free_space_inode(inode)) {
+	if (noflush || btrfs_is_free_space_inode(inode)) {
 		flush = BTRFS_RESERVE_NO_FLUSH;
 	} else {
 		if (current->journal_info)
@@ -333,7 +333,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 */
 	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
 				&meta_reserve, &qgroup_reserve);
-	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
+	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true,
+						 noflush);
 	if (ret)
 		return ret;
 	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, meta_reserve, flush);
@@ -456,7 +457,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len, false);
 	if (ret < 0) {
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 		extent_changeset_free(*reserved);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ceac806155b8..b64fb93d9046 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1684,7 +1684,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
 						      reserve_bytes,
-						      reserve_bytes);
+						      reserve_bytes, false);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(BTRFS_I(inode),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ca1d03b5f510..faf76da2526f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4711,7 +4711,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize, false);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
@@ -7420,6 +7420,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					 u64 start, u64 len,
 					 unsigned int iomap_flags)
 {
+	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em = *map;
 	int type;
@@ -7457,12 +7458,15 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		struct extent_map *em2;
 
 		/* We can NOCOW, so only need to reserve metadata space. */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len);
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
+						      nowait);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
 			free_extent_map(em);
 			*map = NULL;
 			btrfs_dec_nocow_writers(fs_info, block_start);
+			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
+				ret = -EAGAIN;
 			goto out;
 		}
 		space_reserved = true;
@@ -7488,7 +7492,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		free_extent_map(em);
 		*map = NULL;
 
-		if (iomap_flags & IOMAP_NOWAIT)
+		if (nowait)
 			return -EAGAIN;
 
 		/* We have to COW, so need to reserve metadata and data space. */
@@ -10813,7 +10817,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	ret = btrfs_qgroup_reserve_data(inode, &data_reserved, start, num_bytes);
 	if (ret)
 		goto out_free_data_space;
-	ret = btrfs_delalloc_reserve_metadata(inode, num_bytes, disk_num_bytes);
+	ret = btrfs_delalloc_reserve_metadata(inode, num_bytes, disk_num_bytes,
+					      false);
 	if (ret)
 		goto out_qgroup_free_data;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a9fed8195483..db723c0026bd 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3939,12 +3939,13 @@ int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 }
 
 int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
-				enum btrfs_qgroup_rsv_type type, bool enforce)
+				enum btrfs_qgroup_rsv_type type, bool enforce,
+				bool noflush)
 {
 	int ret;
 
 	ret = btrfs_qgroup_reserve_meta(root, num_bytes, type, enforce);
-	if (ret <= 0 && ret != -EDQUOT)
+	if ((ret <= 0 && ret != -EDQUOT) || noflush)
 		return ret;
 
 	ret = try_flush_qgroup(root);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 880e9df0dac1..0c4dd2a9af96 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -364,19 +364,23 @@ int btrfs_qgroup_free_data(struct btrfs_inode *inode,
 int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 			      enum btrfs_qgroup_rsv_type type, bool enforce);
 int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
-				enum btrfs_qgroup_rsv_type type, bool enforce);
+				enum btrfs_qgroup_rsv_type type, bool enforce,
+				bool noflush);
 /* Reserve metadata space for pertrans and prealloc type */
 static inline int btrfs_qgroup_reserve_meta_pertrans(struct btrfs_root *root,
 				int num_bytes, bool enforce)
 {
 	return __btrfs_qgroup_reserve_meta(root, num_bytes,
-			BTRFS_QGROUP_RSV_META_PERTRANS, enforce);
+					   BTRFS_QGROUP_RSV_META_PERTRANS,
+					   enforce, false);
 }
 static inline int btrfs_qgroup_reserve_meta_prealloc(struct btrfs_root *root,
-				int num_bytes, bool enforce)
+						     int num_bytes, bool enforce,
+						     bool noflush)
 {
 	return __btrfs_qgroup_reserve_meta(root, num_bytes,
-			BTRFS_QGROUP_RSV_META_PREALLOC, enforce);
+					   BTRFS_QGROUP_RSV_META_PREALLOC,
+					   enforce, noflush);
 }
 
 void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fdc2c4b411f0..b1c36fc72ffa 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2997,7 +2997,8 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 		/* Reserve metadata for this range */
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len, clamped_len);
+						      clamped_len, clamped_len,
+						      false);
 		if (ret)
 			goto release_page;
 
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index ca7426ef61c8..a64b26b16904 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -509,7 +509,8 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 		/* One for parent inode, two for dir entries */
 		qgroup_num_bytes = 3 * fs_info->nodesize;
 		ret = btrfs_qgroup_reserve_meta_prealloc(root,
-				qgroup_num_bytes, true);
+							 qgroup_num_bytes, true,
+							 false);
 		if (ret)
 			return ret;
 	}
-- 
2.33.0

