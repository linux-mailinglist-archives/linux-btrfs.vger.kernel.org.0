Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C56259D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKKLur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiKKLuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91E27DFE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF238B82417
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDE4C433D7
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167442;
        bh=TzRogcr/lRlq1eE0k3bAqpoaNyrrTg2ZDpqZxQaZ6rE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k3Z9anoDA0KYelqLNCyRKiMYs8DyTYUFSvSKRXY0ok25Vf6QlUtrAWehPokqEPFlf
         Xm6FCcwZjGHgLN40T4ZK61t2vmP5N+laI4XXhL/qMiz9H700Ec6G07llYf+6pHtlWx
         f6w0GYqRAZnmx96Nj2GRoXTUZsU9PngIwvGM7o8kD5KDRpwnv2V6Q0pE94mHgDp16s
         DA/wbjFXsIiHMy/emva9WQ3r9iL63VkCClq2LUH4tGmkdvsaopFcDWjTFD6+VP/Otk
         zJiA7VfWPg6Ckd9mrEkwUAacIur1ymbkRadrhXr/xQmhAuShXflOGtvByEFncmXvyT
         PH4voDuICVJFQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: search for delalloc more efficiently during lseek/fiemap
Date:   Fri, 11 Nov 2022 11:50:30 +0000
Message-Id: <38661c07016eadee1bb25f4dbc1993cc45cf3ae4.1668166764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
References: <cover.1668166764.git.fdmanana@suse.com>
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

During lseek (SEEK_HOLE/DATA) and fiemap, when processing a file range
that corresponds to a hole or a prealloc extent, we have to check if
there's any delalloc in the range. We do it by searching for delalloc
ranges in the inode's io_tree (for unflushed delalloc) and in the inode's
extent map tree (for delalloc that is flushing).

We avoid searching the extent map tree if the number of outstanding
extents is 0, as in that case we can't have extent maps for our search
range in the tree that correspond to delalloc that is flushing. However
if we have any unflushed delalloc, due to buffered writes or mmap writes,
then the outstanding extents counter is not 0 and we'll search the extent
map tree. The tree may be large because it can have lots of extent maps
that were loaded by reads or created by previous writes, therefore taking
a significant time to search the tree, specially if have a file with a
lot of holes and/or prealloc extents.

We can improve on this by instead of searching the extent map tree,
searching the ordered extents tree of the inode, since when delalloc is
flushing we create an ordered extent along with the new extent map, while
holding the respective file range locked in the inode's io_tree. The
ordered extents tree is typically much smaller, since ordered extents have
a short life and get removed from the tree once they are completed, while
extent maps can stay for a very long time in the extent map tree, either
created by previous writes or loaded by read operations.

So use the ordered extents tree instead of the extent maps tree.

This change is part of a patchset that has the goal to make performance
better for applications that use lseek's SEEK_HOLE and SEEK_DATA modes to
iterate over the extents of a file. Two examples are the cp program from
coreutils 9.0+ and the tar program (when using its --sparse / -S option).
A sample test and results are listed in the changelog of the last patch
in the series:

  1/9 btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
  2/9 btrfs: add an early exit when searching for delalloc range for lseek/fiemap
  3/9 btrfs: skip unnecessary delalloc searches during lseek/fiemap
  4/9 btrfs: search for delalloc more efficiently during lseek/fiemap
  5/9 btrfs: remove no longer used btrfs_next_extent_map()
  6/9 btrfs: allow passing a cached state record to count_range_bits()
  7/9 btrfs: update stale comment for count_range_bits()
  8/9 btrfs: use cached state when looking for delalloc ranges with fiemap
  9/9 btrfs: use cached state when looking for delalloc ranges with lseek

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://lore.kernel.org/linux-btrfs/20221106073028.71F9.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 152 +++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 104 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 99cc95487d42..6bc2397e324c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3218,29 +3218,27 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
 {
 	u64 len = end + 1 - start;
-	struct extent_map_tree *em_tree = &inode->extent_tree;
-	struct extent_map *em;
-	u64 em_end;
-	u64 delalloc_len;
-	unsigned int outstanding_extents;
+	u64 delalloc_len = 0;
+	struct btrfs_ordered_extent *oe;
+	u64 oe_start;
+	u64 oe_end;
 
 	/*
 	 * Search the io tree first for EXTENT_DELALLOC. If we find any, it
 	 * means we have delalloc (dirty pages) for which writeback has not
 	 * started yet.
 	 */
-	spin_lock(&inode->lock);
-	outstanding_extents = inode->outstanding_extents;
-
-	if (*search_io_tree && inode->delalloc_bytes > 0) {
-		spin_unlock(&inode->lock);
-		*delalloc_start_ret = start;
-		delalloc_len = count_range_bits(&inode->io_tree,
-						delalloc_start_ret, end,
-						len, EXTENT_DELALLOC, 1);
-	} else {
-		spin_unlock(&inode->lock);
-		delalloc_len = 0;
+	if (*search_io_tree) {
+		spin_lock(&inode->lock);
+		if (inode->delalloc_bytes > 0) {
+			spin_unlock(&inode->lock);
+			*delalloc_start_ret = start;
+			delalloc_len = count_range_bits(&inode->io_tree,
+							delalloc_start_ret, end,
+							len, EXTENT_DELALLOC, 1);
+		} else {
+			spin_unlock(&inode->lock);
+		}
 	}
 
 	if (delalloc_len > 0) {
@@ -3254,7 +3252,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 			/* Delalloc for the whole range, nothing more to do. */
 			if (*delalloc_end_ret == end)
 				return true;
-			/* Else trim our search range for extent maps. */
+			/* Else trim our search range for ordered extents. */
 			start = *delalloc_end_ret + 1;
 			len = end + 1 - start;
 		}
@@ -3264,110 +3262,56 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	}
 
 	/*
-	 * No outstanding extents means we don't have any delalloc that is
-	 * flushing, so return the unflushed range found in the io tree (if any).
-	 */
-	if (outstanding_extents == 0)
-		return (delalloc_len > 0);
-
-	/*
-	 * Now also check if there's any extent map in the range that does not
-	 * map to a hole or prealloc extent. We do this because:
+	 * Now also check if there's any ordered extent in the range.
+	 * We do this because:
 	 *
 	 * 1) When delalloc is flushed, the file range is locked, we clear the
-	 *    EXTENT_DELALLOC bit from the io tree and create an extent map for
-	 *    an allocated extent. So we might just have been called after
-	 *    delalloc is flushed and before the ordered extent completes and
-	 *    inserts the new file extent item in the subvolume's btree;
+	 *    EXTENT_DELALLOC bit from the io tree and create an extent map and
+	 *    an ordered extent for the write. So we might just have been called
+	 *    after delalloc is flushed and before the ordered extent completes
+	 *    and inserts the new file extent item in the subvolume's btree;
 	 *
-	 * 2) We may have an extent map created by flushing delalloc for a
+	 * 2) We may have an ordered extent created by flushing delalloc for a
 	 *    subrange that starts before the subrange we found marked with
 	 *    EXTENT_DELALLOC in the io tree.
+	 *
+	 * We could also use the extent map tree to find such delalloc that is
+	 * being flushed, but using the ordered extents tree is more efficient
+	 * because it's usually much smaller as ordered extents are removed from
+	 * the tree once they complete. With the extent maps, we mau have them
+	 * in the extent map tree for a very long time, and they were either
+	 * created by previous writes or loaded by read operations.
 	 */
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
-	if (!em) {
-		read_unlock(&em_tree->lock);
+	oe = btrfs_lookup_first_ordered_range(inode, start, len);
+	if (!oe)
 		return (delalloc_len > 0);
-	}
-
-	/* extent_map_end() returns a non-inclusive end offset. */
-	em_end = extent_map_end(em);
-
-	/*
-	 * If we have a hole/prealloc extent map, check the next one if this one
-	 * ends before our range's end.
-	 */
-	if ((em->block_start == EXTENT_MAP_HOLE ||
-	     test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
-		struct extent_map *next_em;
-
-		next_em = btrfs_next_extent_map(em_tree, em);
-		free_extent_map(em);
-
-		/*
-		 * There's no next extent map or the next one starts beyond our
-		 * range, return the range found in the io tree (if any).
-		 */
-		if (!next_em || next_em->start > end) {
-			read_unlock(&em_tree->lock);
-			free_extent_map(next_em);
-			return (delalloc_len > 0);
-		}
 
-		em_end = extent_map_end(next_em);
-		em = next_em;
-	}
-
-	read_unlock(&em_tree->lock);
+	/* The ordered extent may span beyond our search range. */
+	oe_start = max(oe->file_offset, start);
+	oe_end = min(oe->file_offset + oe->num_bytes - 1, end);
 
-	/*
-	 * We have a hole or prealloc extent that ends at or beyond our range's
-	 * end, return the range found in the io tree (if any).
-	 */
-	if (em->block_start == EXTENT_MAP_HOLE ||
-	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
-		free_extent_map(em);
-		return (delalloc_len > 0);
-	}
+	btrfs_put_ordered_extent(oe);
 
-	/*
-	 * We don't have any range as EXTENT_DELALLOC in the io tree, so the
-	 * extent map is the only subrange representing delalloc.
-	 */
+	/* Don't have unflushed delalloc, return the ordered extent range. */
 	if (delalloc_len == 0) {
-		*delalloc_start_ret = em->start;
-		*delalloc_end_ret = min(end, em_end - 1);
-		free_extent_map(em);
+		*delalloc_start_ret = oe_start;
+		*delalloc_end_ret = oe_end;
 		return true;
 	}
 
 	/*
-	 * The extent map represents a delalloc range that starts before the
-	 * delalloc range we found in the io tree.
+	 * We have both unflushed delalloc (io_tree) and an ordered extent.
+	 * If the ranges are adjacent returned a combined range, otherwise
+	 * return the leftmost range.
 	 */
-	if (em->start < *delalloc_start_ret) {
-		*delalloc_start_ret = em->start;
-		/*
-		 * If the ranges are adjacent, return a combined range.
-		 * Otherwise return the extent map's range.
-		 */
-		if (em_end < *delalloc_start_ret)
-			*delalloc_end_ret = min(end, em_end - 1);
-
-		free_extent_map(em);
-		return true;
+	if (oe_start < *delalloc_start_ret) {
+		if (oe_end < *delalloc_start_ret)
+			*delalloc_end_ret = oe_end;
+		*delalloc_start_ret = oe_start;
+	} else if (*delalloc_end_ret + 1 == oe_start) {
+		*delalloc_end_ret = oe_end;
 	}
 
-	/*
-	 * The extent map starts after the delalloc range we found in the io
-	 * tree. If it's adjacent, return a combined range, otherwise return
-	 * the range found in the io tree.
-	 */
-	if (*delalloc_end_ret + 1 == em->start)
-		*delalloc_end_ret = min(end, em_end - 1);
-
-	free_extent_map(em);
 	return true;
 }
 
-- 
2.35.1

