Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768AA4FF9EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiDMPXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiDMPXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61749E0D2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB9F0B824F8
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD66C385A3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863251;
        bh=G1gSMrBOI15TaoayQ4VU1mEvuLY4vdhwbmhgWduyi38=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ntq2ZtD67c/P5OEbQ8Zih8p9PfUVWLLaqkefBsg/E3vSb51f643fYKH79WKrFDQ/6
         FCfol23wSLrVnBvF6tE+II/jtCGDGbYGOfccceKMZUVe1geHaLmcZtOlINISzvb20f
         KnVyPhOKvkOgU026tIQyHYsyjXn4FR6c4MB2dFSwlIMI+BygFqtCYPHqyDqUSEcTG3
         dRA0MCBG8BmlV9Tw0u56Y69MD8Rz+Ksrn/+JqACSNzX4dG/POsMYshCerHvSXHSpSW
         WphdDYxU6AaO100EU4zvIJ5jSbCAIGTjqh/BKJI2G8MBWWxWPFnHbTffVv9Ndkwgq7
         lW4BZJ9SC2mQg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: avoid double search for block group during NOCOW writes
Date:   Wed, 13 Apr 2022 16:20:43 +0100
Message-Id: <c0770c4cbf2caaff500fd6cf705f2bd450f6eb01.1649862853.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649862853.git.fdmanana@suse.com>
References: <cover.1649862853.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a NOCOW write, either through direct IO or buffered IO, we do
two lookups for the block group that contains the target extent: once
when we call btrfs_inc_nocow_writers() and then later again when we call
btrfs_dec_nocow_writers() after creating the ordered extent.

The lookups require taking a lock and navigating the red black tree used
to track all block groups, which can take a non-negligible amount of time
for a large filesystem with thousands of block groups, as well as lock
contention and cache line bouncing.

Improve on this by having a single block group search: making
btrfs_inc_nocow_writers() return the block group to its caller and then
have the caller pass that block group to btrfs_dec_nocow_writers().

This is part of a patchset comprised of the following patches:

  btrfs: remove search start argument from first_logical_byte()
  btrfs: use rbtree with leftmost node cached for tracking lowest block group
  btrfs: use a read/write lock for protecting the block groups tree
  btrfs: return block group directly at btrfs_next_block_group()
  btrfs: avoid double search for block group during NOCOW writes

The following test was used to test these changes from a performance
perspective:

   $ cat test.sh
   #!/bin/bash

   modprobe null_blk nr_devices=0

   NULL_DEV_PATH=/sys/kernel/config/nullb/nullb0
   mkdir $NULL_DEV_PATH
   if [ $? -ne 0 ]; then
       echo "Failed to create nullb0 directory."
       exit 1
   fi
   echo 2 > $NULL_DEV_PATH/submit_queues
   echo 16384 > $NULL_DEV_PATH/size # 16G
   echo 1 > $NULL_DEV_PATH/memory_backed
   echo 1 > $NULL_DEV_PATH/power

   DEV=/dev/nullb0
   MNT=/mnt/nullb0
   LOOP_MNT="$MNT/loop"
   MOUNT_OPTIONS="-o ssd -o nodatacow"
   MKFS_OPTIONS="-R free-space-tree -O no-holes"

   cat <<EOF > /tmp/fio-job.ini
   [io_uring_writes]
   rw=randwrite
   fsync=0
   fallocate=posix
   group_reporting=1
   direct=1
   ioengine=io_uring
   iodepth=64
   bs=64k
   filesize=1g
   runtime=300
   time_based
   directory=$LOOP_MNT
   numjobs=8
   thread
   EOF

   echo performance | \
       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

   echo
   echo "Using config:"
   echo
   cat /tmp/fio-job.ini
   echo

   umount $MNT &> /dev/null
   mkfs.btrfs -f $MKFS_OPTIONS $DEV &> /dev/null
   mount $MOUNT_OPTIONS $DEV $MNT

   mkdir $LOOP_MNT

   truncate -s 4T $MNT/loopfile
   mkfs.btrfs -f $MKFS_OPTIONS $MNT/loopfile &> /dev/null
   mount $MOUNT_OPTIONS $MNT/loopfile $LOOP_MNT

   # Trigger the allocation of about 3500 data block groups, without
   # actually consuming space on underlying filesystem, just to make
   # the tree of block group large.
   fallocate -l 3500G $LOOP_MNT/filler

   fio /tmp/fio-job.ini

   umount $LOOP_MNT
   umount $MNT

   echo 0 > $NULL_DEV_PATH/power
   rmdir $NULL_DEV_PATH

The test was run on a non-debug kernel (Debian't default kernel config),
the result were the following.

Before patchset:

  WRITE: bw=1455MiB/s (1526MB/s), 1455MiB/s-1455MiB/s (1526MB/s-1526MB/s), io=426GiB (458GB), run=300006-300006msec

After patchset:

  WRITE: bw=1503MiB/s (1577MB/s), 1503MiB/s-1503MiB/s (1577MB/s-1577MB/s), io=440GiB (473GB), run=300006-300006msec

  +3.3% write throughput and +3.3% IO done in the same time period.

The test has somewhat limited coverage scope, as with only NOCOW writes
we get less contention on the red black tree of block groups, since we
don't have the extra contention caused by COW writes, namely when
allocating data extents, pinning and unpinning data extents, but on the
hand there's access to tree in the NOCOW path, when incrementing a block
group's number of NOCOW writers.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 58 +++++++++++++++++++++++++++++-------------
 fs/btrfs/block-group.h |  5 ++--
 fs/btrfs/inode.c       | 26 +++++++++++--------
 3 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index db112a01d711..571c30a7fe0f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -284,42 +284,66 @@ struct btrfs_block_group *btrfs_next_block_group(
 	return cache;
 }
 
-bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
+/*
+ * Check if we can do a NOCOW write for a given extent.
+ *
+ * @fs_info:       The filesystem information object.
+ * @bytenr:        Logical start address of the extent.
+ *
+ * Check if we can do a NOCOW write for the given extent, and increments the
+ * number of NOCOW writers in the block group that contains the extent, as long
+ * as the block group exists and it's currently not in read-only mode.
+ *
+ * Returns: A non-NULL block group pointer if we can do a NOCOW write, the caller
+ *          is responsible for calling btrfs_dec_nocow_writers() later.
+ *
+ *          Or NULL if we can not do a NOCOW write
+ */
+struct btrfs_block_group *btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info,
+						  u64 bytenr)
 {
 	struct btrfs_block_group *bg;
-	bool ret = true;
+	bool can_nocow = true;
 
 	bg = btrfs_lookup_block_group(fs_info, bytenr);
 	if (!bg)
-		return false;
+		return NULL;
 
 	spin_lock(&bg->lock);
 	if (bg->ro)
-		ret = false;
+		can_nocow = false;
 	else
 		atomic_inc(&bg->nocow_writers);
 	spin_unlock(&bg->lock);
 
-	/* No put on block group, done by btrfs_dec_nocow_writers */
-	if (!ret)
+	if (!can_nocow) {
 		btrfs_put_block_group(bg);
+		return NULL;
+	}
 
-	return ret;
+	/* No put on block group, done by btrfs_dec_nocow_writers(). */
+	return bg;
 }
 
-void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
+/*
+ * Decrement the number of NOCOW writers in a block group.
+ *
+ * @bg:       The block group.
+ *
+ * This is meant to be called after a previous call to btrfs_inc_nocow_writers(),
+ * and on the block group returned by that call. Typically this is called after
+ * creating an ordered extent for a NOCOW write, to prevent races with scrub and
+ * relocation.
+ *
+ * After this call, the caller should not use the block group anymore. It it wants
+ * to use it, then it should get a reference on it before calling this function.
+ */
+void btrfs_dec_nocow_writers(struct btrfs_block_group *bg)
 {
-	struct btrfs_block_group *bg;
-
-	bg = btrfs_lookup_block_group(fs_info, bytenr);
-	ASSERT(bg);
 	if (atomic_dec_and_test(&bg->nocow_writers))
 		wake_up_var(&bg->nocow_writers);
-	/*
-	 * Once for our lookup and once for the lookup done by a previous call
-	 * to btrfs_inc_nocow_writers()
-	 */
-	btrfs_put_block_group(bg);
+
+	/* For the lookup done by a previous call to btrfs_inc_nocow_writers(). */
 	btrfs_put_block_group(bg);
 }
 
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index e8308f2ad07d..c9bf01dd10e8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -254,8 +254,9 @@ void btrfs_put_block_group(struct btrfs_block_group *cache);
 void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
 					const u64 start);
 void btrfs_wait_block_group_reservations(struct btrfs_block_group *bg);
-bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
-void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
+struct btrfs_block_group *btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info,
+						  u64 bytenr);
+void btrfs_dec_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
 				           u64 num_bytes);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 620baf24c6bd..a350ca662d53 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1784,6 +1784,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	int ret;
 	bool check_prev = true;
 	u64 ino = btrfs_ino(inode);
+	struct btrfs_block_group *bg;
 	bool nocow = false;
 	struct can_nocow_file_extent_args nocow_args = { 0 };
 
@@ -1912,7 +1913,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		}
 
 		ret = 0;
-		if (btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr))
+		bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
+		if (bg)
 			nocow = true;
 out_check:
 		/*
@@ -1988,9 +1990,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				goto error;
 		}
 
-		if (nocow)
-			btrfs_dec_nocow_writers(fs_info, nocow_args.disk_bytenr);
-		nocow = false;
+		if (nocow) {
+			btrfs_dec_nocow_writers(bg);
+			nocow = false;
+		}
 
 		if (btrfs_is_data_reloc_root(root))
 			/*
@@ -2034,7 +2037,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 error:
 	if (nocow)
-		btrfs_dec_nocow_writers(fs_info, nocow_args.disk_bytenr);
+		btrfs_dec_nocow_writers(bg);
 
 	if (ret && cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
@@ -7428,6 +7431,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct extent_map *em = *map;
 	int type;
 	u64 block_start, orig_start, orig_block_len, ram_bytes;
+	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
 	u64 prev_len;
@@ -7453,9 +7457,11 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, false) == 1 &&
-		    btrfs_inc_nocow_writers(fs_info, block_start))
-			can_nocow = true;
+				     &orig_block_len, &ram_bytes, false) == 1) {
+			bg = btrfs_inc_nocow_writers(fs_info, block_start);
+			if (bg)
+				can_nocow = true;
+		}
 	}
 
 	prev_len = len;
@@ -7469,7 +7475,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			/* Our caller expects us to free the input extent map. */
 			free_extent_map(em);
 			*map = NULL;
-			btrfs_dec_nocow_writers(fs_info, block_start);
+			btrfs_dec_nocow_writers(bg);
 			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
 				ret = -EAGAIN;
 			goto out;
@@ -7480,7 +7486,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      orig_start, block_start,
 					      len, orig_block_len,
 					      ram_bytes, type);
-		btrfs_dec_nocow_writers(fs_info, block_start);
+		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
 			*map = em = em2;
-- 
2.35.1

