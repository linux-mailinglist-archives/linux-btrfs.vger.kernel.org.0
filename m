Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B35BCDFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiISOHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiISOHA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:07:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66D31EDD
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D153EB81B6A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235E8C433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596415;
        bh=s4F+qhr25M0+PMed36nh/XucQhRyWeuSzLerapb28wM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=efxszar0GBf2vRA7mYZLeaC1iXBQBgwNqFyAzYEjIZ8Cw5gUdI9j2D/Nh/YLqHnEi
         rOZ5VHaC5s86eDlemn2xyi2/iAzrcgIBFDiQeTqQQ6isiNAkULxCXmDeo+rQmOX1NA
         IAoQHm4RJj4/GoceMtzzT4yvqVd2yhsIXgbhnQtJf2kEujT2ndFo/uQA/Q5kwrA0u+
         f2nfnaOZYj3e/LpgNilomj5WxKempk2NNqUrq0jwfQ4kwUzSY5lFZa9HwbdiptkNwd
         sRtpsJKttlBH6DLFGUi4mYPHpM74l0tb+PnfAYdohsUR3nE9Uq+UOo5CNZuoKrjb6r
         fURBitl9C7WkQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/13] btrfs: drop extent map range more efficiently
Date:   Mon, 19 Sep 2022 15:06:40 +0100
Message-Id: <8dc411b9c00b4f447c0a21984d8249e9f61a1e63.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently when dropping extent maps for a file range, through
btrfs_drop_extent_map_range(), we do the following non-optimal things:

1) We lookup for extent maps one by one, always starting the search from
   the root of the extent map tree. This is not efficient if we have
   multiple extent maps in the range;

2) We check on every iteration if we have the 'split' and 'split2' spare
   extent maps in case we need to split an extent map that intersects our
   range but also crosses its boundaries (to the left, to the right or
   both cases). If our target range is for example:

       [2M, 8M)

   And we have 3 extents maps in the range:

       [1M, 3M) [3M, 6M) [6M, 10M[

   The on the first iteration we allocate two extent maps for 'split' and
   'split2', and use the 'split' to split the first extent map, so after
   the split we set 'split' to 'split2' and then set 'split2' to NULL.

   On the second iteration, we don't need to split the second extent map,
   but because 'split2' is now NULL, we allocate a new extent map for
   'split2'.

   On the third iteration we need to split the third extent map, so we
   use the extent map pointed by 'split'.

   So we ended up allocating 3 extent maps for splitting, but all we
   needed was 2 extent maps. We never need to allocate more than 2,
   because extent maps that need to be split are always the first one
   and the last one in the target range.

Improve on this by:

1) Using rb_next() to move on to the next extent map. This results in
   iterating over less nodes of the tree and it does not require comparing
   the ranges of nodes to our start/end offset;

2) Allocate the 2 extent maps for splitting before entering the loop and
   never allocate more than 2. In practice it's very rare to have the
   combination of both extent map allocations fail, since we have a
   dedicated slab for extent maps, and also have the need to split two
   extent maps.

This patch is part of a patchset comprised of the following patches:

   btrfs: fix missed extent on fsync after dropping extent maps
   btrfs: move btrfs_drop_extent_cache() to extent_map.c
   btrfs: use extent_map_end() at btrfs_drop_extent_map_range()
   btrfs: use cond_resched_rwlock_write() during inode eviction
   btrfs: move open coded extent map tree deletion out of inode eviction
   btrfs: add helper to replace extent map range with a new extent map
   btrfs: remove the refcount warning/check at free_extent_map()
   btrfs: remove unnecessary extent map initializations
   btrfs: assert tree is locked when clearing extent map from logging
   btrfs: remove unnecessary NULL pointer checks when searching extent maps
   btrfs: remove unnecessary next extent map search
   btrfs: avoid pointless extent map tree search when flushing delalloc
   btrfs: drop extent map range more efficiently

And the following fio test was done before and after applying the whole
patchset, on a non-debug kernel (Debian's default kernel config) on a 12
cores Intel box with 64G of ram:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/nvme0n1
   MNT=/mnt/nvme0n1
   MOUNT_OPTIONS="-o ssd"
   MKFS_OPTIONS="-R free-space-tree -O no-holes"

   cat <<EOF > /tmp/fio-job.ini
   [writers]
   rw=randwrite
   fsync=8
   fallocate=none
   group_reporting=1
   direct=0
   bssplit=4k/20:8k/20:16k/20:32k/10:64k/10:128k/5:256k/5:512k/5:1m/5
   ioengine=psync
   filesize=2G
   runtime=300
   time_based
   directory=$MNT
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
   mkfs.btrfs -f $MKFS_OPTIONS $DEV
   mount $MOUNT_OPTIONS $DEV $MNT

   fio /tmp/fio-job.ini

   umount $MNT

Result before applying the patchset:

   WRITE: bw=197MiB/s (206MB/s), 197MiB/s-197MiB/s (206MB/s-206MB/s), io=57.7GiB (61.9GB), run=300188-300188msec

Result after applying the patchset:

   WRITE: bw=203MiB/s (213MB/s), 203MiB/s-203MiB/s (213MB/s-213MB/s), io=59.5GiB (63.9GB), run=300019-300019msec

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 119 ++++++++++++++++++++++++++----------------
 1 file changed, 74 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index a5b031524c32..a3ec464b22a4 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -700,11 +700,11 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				 bool skip_pinned)
 {
-	struct extent_map *split = NULL;
-	struct extent_map *split2 = NULL;
+	struct extent_map *split;
+	struct extent_map *split2;
+	struct extent_map *em;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	u64 len = end - start + 1;
-	bool testend = true;
 
 	WARN_ON(end < start);
 	if (end == (u64)-1) {
@@ -713,57 +713,73 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			return;
 		}
 		len = (u64)-1;
-		testend = false;
+	} else {
+		/* Make end offset exclusive for use in the loop below. */
+		end++;
 	}
-	while (1) {
-		struct extent_map *em;
-		u64 em_end;
+
+	/*
+	 * It's ok if we fail to allocate the extent maps, see the comment near
+	 * the bottom of the loop below. We only need two spare extent maps in
+	 * the worst case, where the first extent map that intersects our range
+	 * starts before the range and the last extent map that intersects our
+	 * range ends after our range (and they might be the same extent map),
+	 * because we need to split those two extent maps at the boundaries.
+	 */
+	split = alloc_extent_map();
+	split2 = alloc_extent_map();
+
+	write_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, start, len);
+
+	while (em) {
+		/* extent_map_end() returns exclusive value (last byte + 1). */
+		const u64 em_end = extent_map_end(em);
+		struct extent_map *next_em = NULL;
 		u64 gen;
 		unsigned long flags;
-		bool ends_after_range = false;
-		bool no_splits = false;
 		bool modified;
 		bool compressed;
 
-		if (!split)
-			split = alloc_extent_map();
-		if (!split2)
-			split2 = alloc_extent_map();
-		if (!split || !split2)
-			no_splits = true;
-
-		write_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, start, len);
-		if (!em) {
-			write_unlock(&em_tree->lock);
-			break;
+		if (em_end < end) {
+			next_em = next_extent_map(em);
+			if (next_em) {
+				if (next_em->start < end)
+					refcount_inc(&next_em->refs);
+				else
+					next_em = NULL;
+			}
 		}
-		em_end = extent_map_end(em);
-		if (testend && em_end > start + len)
-			ends_after_range = true;
+
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
-			if (ends_after_range) {
-				free_extent_map(em);
-				write_unlock(&em_tree->lock);
-				break;
-			}
 			start = em_end;
-			if (testend)
+			if (end != (u64)-1)
 				len = start + len - em_end;
-			free_extent_map(em);
-			write_unlock(&em_tree->lock);
-			continue;
+			goto next;
 		}
-		flags = em->flags;
-		gen = em->generation;
-		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		clear_bit(EXTENT_FLAG_LOGGING, &flags);
 		modified = !list_empty(&em->list);
-		if (no_splits)
-			goto next;
+
+		/*
+		 * The extent map does not cross our target range, so no need to
+		 * split it, we can remove it directly.
+		 */
+		if (em->start >= start && em_end <= end)
+			goto remove_em;
+
+		flags = em->flags;
+		gen = em->generation;
+		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 
 		if (em->start < start) {
+			if (!split) {
+				split = split2;
+				split2 = NULL;
+				if (!split)
+					goto remove_em;
+			}
 			split->start = em->start;
 			split->len = start - em->start;
 
@@ -794,7 +810,13 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split = split2;
 			split2 = NULL;
 		}
-		if (ends_after_range) {
+		if (em_end > end) {
+			if (!split) {
+				split = split2;
+				split2 = NULL;
+				if (!split)
+					goto remove_em;
+			}
 			split->start = start + len;
 			split->len = em_end - (start + len);
 			split->block_start = em->block_start;
@@ -840,7 +862,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			free_extent_map(split);
 			split = NULL;
 		}
-next:
+remove_em:
 		if (extent_map_in_tree(em)) {
 			/*
 			 * If the extent map is still in the tree it means that
@@ -862,20 +884,27 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			 * full fsync, otherwise a fast fsync will miss this
 			 * extent if it's new and needs to be logged.
 			 */
-			if ((em->start < start || ends_after_range) && modified) {
-				ASSERT(no_splits);
+			if ((em->start < start || em_end > end) && modified) {
+				ASSERT(!split);
 				btrfs_set_inode_full_sync(inode);
 			}
 			remove_extent_mapping(em_tree, em);
 		}
-		write_unlock(&em_tree->lock);
 
-		/* Once for us. */
+		/*
+		 * Once for the tree reference (we replaced or removed the
+		 * extent map from the tree).
+		 */
 		free_extent_map(em);
-		/* And once for the tree. */
+next:
+		/* Once for us (for our lookup reference). */
 		free_extent_map(em);
+
+		em = next_em;
 	}
 
+	write_unlock(&em_tree->lock);
+
 	free_extent_map(split);
 	free_extent_map(split2);
 }
-- 
2.35.1

