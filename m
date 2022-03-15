Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483E94D9985
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 11:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347589AbiCOKuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 06:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348617AbiCOKtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 06:49:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595552B37
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 03:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64583B8124F
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9072CC340EE
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647341240;
        bh=n6TiDAoyme3T0bZN9Bfc0CRhQ/l4aFiGgvU+JlRDq1I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fuJHoKrYnTfUiwVvn4eEpUQvGpSZp+mgW3wfUD5LTrLBvo2BOxzM+fDsbbnPnwkFi
         u2wkuXvmkMLGnu8HqbBQ/eW7eiXrOB24MV+jcirJRA8G8gO9+ZLCTz7qbQGYKdqEWw
         jY4wbqmXbU2Tj3OFf5vcdqf/nRIJb9RUZaZZLM5jYh0pCu4u0BLuj+/nQ+cdGGk7BH
         VU2EE21UHoQI/fVxXSAnKIPJXj6JpIKFYBNj1sIRsSWx40qz6BYh3ApytYXdihU43/
         x1sSwXOJKVlQ5KbTekpoUEXqITIalArohZNRHWowFm605/gSdHPvstNAL7pZ4h3LQt
         rEo5un2vJoeNg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: remove ordered extent check and wait during hole punching and zero range
Date:   Tue, 15 Mar 2022 10:47:10 +0000
Message-Id: <bc5144c1420e6d9d11163867e8ba5612ebb8eae5.1647340917.git.fdmanana@suse.com>
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

For hole punching and zero range we have this loop that checks if we have
ordered extents after locking the file range, and if so unlock the range,
wait for ordered extents, and retry until we don't find more ordered
extents.

This logic was needed in the past because:

1) Direct IO writes within the i_size boundary did not take the inode's
   VFS lock. This was because that lock used to be a mutex, then some
   years ago it was switched to a rw semaphore (commit 9902af79c01a8e
   ("parallel lookups: actual switch to rwsem")), and then btrfs was
   changed to take the VFS inode's lock in shared mode for writes that
   don't cross the i_size boundary (commit e9adabb9712ef9 ("btrfs: use
   shared lock for direct writes within EOF"));

2) We could race with memory mapped writes, because memory mapped writes
   don't acquire the inode's VFS lock. We don't have that race anymore,
   as we have a rw semaphore to synchronize memory mapped writes with
   fallocate (and reflinking too). That change happened with commit
   8d9b4a162a37ce ("btrfs: exclude mmap from happening during all
   fallocate operations").

So stop looking for ordered extents after locking the file range when
doing hole punching and zero range operations.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 54 +++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a7fd05c1d52f..9f8db8a12a2f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2570,10 +2570,10 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 	return ret;
 }
 
-static int btrfs_punch_hole_lock_range(struct inode *inode,
-				       const u64 lockstart,
-				       const u64 lockend,
-				       struct extent_state **cached_state)
+static void btrfs_punch_hole_lock_range(struct inode *inode,
+					const u64 lockstart,
+					const u64 lockend,
+					struct extent_state **cached_state)
 {
 	/*
 	 * For subpage case, if the range is not at page boundary, we could
@@ -2587,40 +2587,27 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
 
 	while (1) {
-		struct btrfs_ordered_extent *ordered;
-		int ret;
-
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent_bits(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 				 cached_state);
-		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
-							    lockend);
-
 		/*
-		 * We need to make sure we have no ordered extents in this range
-		 * and nobody raced in and read a page in this range, if we did
-		 * we need to try again.
+		 * We can't have ordered extents in the range, nor dirty/writeback
+		 * pages, because we have locked the inode's VFS lock in exclusive
+		 * mode, we have locked the inode's i_mmap_lock in exclusive mode,
+		 * we have flushed all delalloc in the range and we have waited
+		 * for any ordered extents in the range to complete.
+		 * We can race with anyone reading pages from this range, so after
+		 * locking the range check if we have pages in the range, and if
+		 * we do, unlock the range and retry.
 		 */
-		if ((!ordered ||
-		    (ordered->file_offset + ordered->num_bytes <= lockstart ||
-		     ordered->file_offset > lockend)) &&
-		     !filemap_range_has_page(inode->i_mapping,
-					     page_lockstart, page_lockend)) {
-			if (ordered)
-				btrfs_put_ordered_extent(ordered);
+		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
+					    page_lockend))
 			break;
-		}
-		if (ordered)
-			btrfs_put_ordered_extent(ordered);
+
 		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
 				     lockend, cached_state);
-		ret = btrfs_wait_ordered_range(inode, lockstart,
-					       lockend - lockstart + 1);
-		if (ret)
-			return ret;
 	}
-	return 0;
 }
 
 static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
@@ -3072,10 +3059,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 		goto out_only_mutex;
 	}
 
-	ret = btrfs_punch_hole_lock_range(inode, lockstart, lockend,
-					  &cached_state);
-	if (ret)
-		goto out_only_mutex;
+	btrfs_punch_hole_lock_range(inode, lockstart, lockend, &cached_state);
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -3366,10 +3350,8 @@ static int btrfs_zero_range(struct inode *inode,
 		if (ret < 0)
 			goto out;
 		space_reserved = true;
-		ret = btrfs_punch_hole_lock_range(inode, lockstart, lockend,
-						  &cached_state);
-		if (ret)
-			goto out;
+		btrfs_punch_hole_lock_range(inode, lockstart, lockend,
+					    &cached_state);
 		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
 		if (ret) {
-- 
2.33.0

