Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF106259CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiKKLuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiKKLun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8C286DE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35CC0B825D2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67903C433D7
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167439;
        bh=M555hlG9Gd4CJ56gd/hrF61UhAMZr1TtqzmcIx+gReU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MFiVPTBhLLbi8ul8A+3olEaxtGm59X8DJff4aaYW83wacd7q1dX99mS/jWT62OBqy
         IpDA593Hes0h+eI+Iqydcqp4Z1jhZi9fVDK3FGM4OcskYMH5EL1ClUQZP7no7rmp4Y
         zsEwPc2HZVo1URaOuGWPLV7iFLCVqUaG/VbchNhWXTfsazDGg7ASwzBFzx5JTv+VfE
         uC6HbPXn77MoviF3C3BZyjjdWQe/hpa+djOkFV+Gwb4Hoai3J1lpkobTXlMPs98X7u
         XpDtZQxS6CIPMUuNhKk7AazLpz7CO8h0BHwRUUhYjBXc3fS78YPBxDxG78I1xhHiHA
         N1wSpwH5YK3lQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
Date:   Fri, 11 Nov 2022 11:50:27 +0000
Message-Id: <4579e6b56a708df83d409a5b2e38ff91299ddea5.1668166764.git.fdmanana@suse.com>
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

We don't need to set the EXTENT_UPDATE bit in an inode's io_tree to mark a
range as uptodate, we rely on the pages themselves being uptodate - page
reading is not triggered for already uptodate pages. Recently we removed
most use of the EXTENT_UPTODATE for buffered IO with commit 52b029f42751
("btrfs: remove unnecessary EXTENT_UPTODATE state in buffered I/O path"),
but there were a few leftovers, namely when reading from holes and
successfully finishing read repair.

These leftovers are unnecessarily making an inode's tree larger and deeper,
slowing down searches on it. So remove all the leftovers.

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
 fs/btrfs/extent-io-tree.h |  7 -------
 fs/btrfs/extent_io.c      | 19 +++----------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index cdee8c0854c8..18ab82f62611 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -216,13 +216,6 @@ static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
 }
 
-static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
-		u64 end, struct extent_state **cached_state, gfp_t mask)
-{
-	return set_extent_bit(tree, start, end, EXTENT_UPTODATE,
-			      cached_state, mask);
-}
-
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			  u64 *start_ret, u64 *end_ret, u32 bits,
 			  struct extent_state **cached_state);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 859a41624c31..bf19011037d1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -901,14 +901,9 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	const u32 sectorsize = inode->root->fs_info->sectorsize;
-	struct extent_state *cached = NULL;
 
 	end_page_read(page, uptodate, offset, sectorsize);
-	if (uptodate)
-		set_extent_uptodate(&inode->io_tree, offset,
-				    offset + sectorsize - 1, &cached, GFP_NOFS);
-	unlock_extent(&inode->io_tree, offset, offset + sectorsize - 1,
-		      &cached);
+	unlock_extent(&inode->io_tree, offset, offset + sectorsize - 1, NULL);
 }
 
 static void submit_data_read_repair(struct inode *inode,
@@ -1781,13 +1776,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
-			struct extent_state *cached = NULL;
-
 			iosize = PAGE_SIZE - pg_offset;
 			memzero_page(page, pg_offset, iosize);
-			set_extent_uptodate(tree, cur, cur + iosize - 1,
-					    &cached, GFP_NOFS);
-			unlock_extent(tree, cur, cur + iosize - 1, &cached);
+			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			break;
 		}
@@ -1863,13 +1854,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
-			struct extent_state *cached = NULL;
-
 			memzero_page(page, pg_offset, iosize);
 
-			set_extent_uptodate(tree, cur, cur + iosize - 1,
-					    &cached, GFP_NOFS);
-			unlock_extent(tree, cur, cur + iosize - 1, &cached);
+			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
-- 
2.35.1

