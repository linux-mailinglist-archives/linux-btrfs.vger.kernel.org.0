Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5234D998D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347507AbiCOKuN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348502AbiCOKta (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 06:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F6527F4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 03:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA9C1612B7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5A8C340ED
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647341236;
        bh=rs0YPLnJ6POMmPg9JGTMlp/d6NvZWCs1XqvveH+kGqc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dwUuucvutOfAB4tubJ7aerweexFpwSXTabMS1cF3K8YcHac/jLYfnbtIKH2aw1o4a
         lpsaw7/kgwQgyvVrGTVHnhILFGBZvDSvL2tFnBWJyw9M/N6ugrTg2SHW7m3GoLhsEY
         fe6HE8GetyBqioJhprwlIRSjfaMJZBV1FSLGoK0eHifLo3VvZYGbl+3ScroevXhjp6
         SZ6eCucMltbsmucpgvCcKpJ0dDQOB3EPAWsLijp4xZoawxhywsNB0CrxBI+U93rZPb
         ilDnAUdARPUAKFRrxyEAsej95v4YRSp6mYX8T9RxeyzyIF9a6HTwQbUx69lPS+UTMx
         LcMRc5F3fbuyA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: only reserve the needed data space amount during fallocate
Date:   Tue, 15 Mar 2022 10:47:06 +0000
Message-Id: <9a69626ef93741583ab7f6386f2b450f5d064080.1647340917.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647340917.git.fdmanana@suse.com>
References: <cover.1647340917.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a plain fallocate, we always start by reserving an mount of data
space that matches the length of the range passed to fallocate. When we
already have extents allocated in that range, we may end up trying to
reserve a lot more data space then we need, which can result in two
undesired behaviours:

1) We fail with -ENOSPC. For example the passed range has a length
   of 1G, but there's only one hole with a size of 1M in that range;

2) We temporarily reserve excessive data space that could be used by
   other operations happening concurrently;

3) By reserving much more data space then we need, we can end up
   doing expensive things like triggering dellaloc for other inodes,
   waiting for the ordered extents to complete, trigger transaction
   commits, allocate new block groups, etc.

Example:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdj
  MNT=/mnt/sdj

  mkfs.btrfs -f -b 1g $DEV
  mount $DEV $MNT

  # Create a file with a size of 600M and two holes, one at [200M, 201M[
  # and another at [401M, 402M[
  xfs_io -f -c "pwrite -S 0xab 0 200M" \
            -c "pwrite -S 0xcd 201M 200M" \
            -c "pwrite -S 0xef 402M 198M" \
            $MNT/foobar

  # Now call fallocate against the whole file range, see if it fails
  # with -ENOSPC or not - it shouldn't since we only need to allocate
  # 2M of data space.
  xfs_io -c "falloc 0 600M" $MNT/foobar

  umount $MNT

  $ ./test.sh
  (...)
  wrote 209715200/209715200 bytes at offset 0
  200 MiB, 51200 ops; 0.8063 sec (248.026 MiB/sec and 63494.5831 ops/sec)
  wrote 209715200/209715200 bytes at offset 210763776
  200 MiB, 51200 ops; 0.8053 sec (248.329 MiB/sec and 63572.3172 ops/sec)
  wrote 207618048/207618048 bytes at offset 421527552
  198 MiB, 50688 ops; 0.7925 sec (249.830 MiB/sec and 63956.5548 ops/sec)
  fallocate: No space left on device
  $

So fix this by not allocating an amount of data space that matches the
length of the range passed to fallocate. Instead allocate an amount of
data space that corresponds to the sum of the sizes of each hole found
in the range. This reservation now happens after we have locked the file
range, which is safe since we know at this point there's no delalloc
in the range because we've taken the inode's VFS lock in exclusive mode,
we have taken the inode's i_mmap_lock in exclusive mode, we have flushed
delalloc and waited for all ordered extents in the range to complete.

This type of failure actually seems to happen in pratice with systemd,
and we had at least one report about this in a very long thread which
is referenced by the Link tag below.

Link: https://lore.kernel.org/linux-btrfs/bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 69 ++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 380054c94e4b..b7c0db1000cd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3417,6 +3417,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 	u64 alloc_hint = 0;
 	u64 locked_end;
 	u64 actual_end = 0;
+	u64 data_space_needed = 0;
+	u64 data_space_reserved = 0;
+	u64 qgroup_reserved = 0;
 	struct extent_map *em;
 	int blocksize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	int ret;
@@ -3437,18 +3440,6 @@ static long btrfs_fallocate(struct file *file, int mode,
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		return btrfs_punch_hole(file, offset, len);
 
-	/*
-	 * Only trigger disk allocation, don't trigger qgroup reserve
-	 *
-	 * For qgroup space, it will be checked later.
-	 */
-	if (!(mode & FALLOC_FL_ZERO_RANGE)) {
-		ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
-						      alloc_end - alloc_start);
-		if (ret < 0)
-			return ret;
-	}
-
 	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
@@ -3548,48 +3539,66 @@ static long btrfs_fallocate(struct file *file, int mode,
 		if (em->block_start == EXTENT_MAP_HOLE ||
 		    (cur_offset >= inode->i_size &&
 		     !test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
+			const u64 range_len = last_byte - cur_offset;
+
 			ret = add_falloc_range(&reserve_list, cur_offset,
-					       last_byte - cur_offset);
+					       range_len);
 			if (ret < 0) {
 				free_extent_map(em);
 				break;
 			}
 			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
 					&data_reserved, cur_offset,
-					last_byte - cur_offset);
+					range_len);
 			if (ret < 0) {
-				cur_offset = last_byte;
 				free_extent_map(em);
 				break;
 			}
-		} else {
-			/*
-			 * Do not need to reserve unwritten extent for this
-			 * range, free reserved data space first, otherwise
-			 * it'll result in false ENOSPC error.
-			 */
-			btrfs_free_reserved_data_space(BTRFS_I(inode),
-				data_reserved, cur_offset,
-				last_byte - cur_offset);
+			qgroup_reserved += range_len;
+			data_space_needed += range_len;
 		}
 		free_extent_map(em);
 		cur_offset = last_byte;
 	}
 
+	if (!ret && data_space_needed > 0) {
+		/*
+		 * We are safe to reserve space here as we can't have delalloc
+		 * in the range, see above.
+		 */
+		ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
+						      data_space_needed);
+		if (!ret)
+			data_space_reserved = data_space_needed;
+	}
+
 	/*
 	 * If ret is still 0, means we're OK to fallocate.
 	 * Or just cleanup the list and exit.
 	 */
 	list_for_each_entry_safe(range, tmp, &reserve_list, list) {
-		if (!ret)
+		if (!ret) {
 			ret = btrfs_prealloc_file_range(inode, mode,
 					range->start,
 					range->len, i_blocksize(inode),
 					offset + len, &alloc_hint);
-		else
+			/*
+			 * btrfs_prealloc_file_range() releases space even
+			 * if it returns an error.
+			 */
+			data_space_reserved -= range->len;
+			qgroup_reserved -= range->len;
+		} else if (data_space_reserved > 0) {
 			btrfs_free_reserved_data_space(BTRFS_I(inode),
-					data_reserved, range->start,
-					range->len);
+					       data_reserved, range->start,
+					       range->len);
+			data_space_reserved -= range->len;
+			qgroup_reserved -= range->len;
+		} else if (qgroup_reserved > 0) {
+			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
+					       range->start, range->len);
+			qgroup_reserved -= range->len;
+		}
 		list_del(&range->list);
 		kfree(range);
 	}
@@ -3606,10 +3615,6 @@ static long btrfs_fallocate(struct file *file, int mode,
 			     &cached_state);
 out:
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
-	/* Let go of our reservation. */
-	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
-		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
-				cur_offset, alloc_end - cur_offset);
 	extent_changeset_free(data_reserved);
 	return ret;
 }
-- 
2.33.0

