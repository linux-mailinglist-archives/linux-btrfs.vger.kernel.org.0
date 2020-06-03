Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED21EC92E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFCF4n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:42442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgFCFz4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7828AAF8D;
        Wed,  3 Jun 2020 05:55:58 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/46] btrfs: Make submit_compressed_extents take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:17 +0300
Message-Id: <20200603055546.3889-18-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All but 3 uses require vfs_inode so convert the logic to have btrfs_inode be
the main inode struct.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a527848c57d5..9794895d16fe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -763,14 +763,14 @@ static void free_async_extent_pages(struct async_extent *async_extent)
  */
 static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 {
-	struct inode *inode = async_chunk->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct async_extent *async_extent;
 	u64 alloc_hint = 0;
 	struct btrfs_key ins;
 	struct extent_map *em;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_root *root = inode->root;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	int ret = 0;

 again:
@@ -788,8 +788,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			unsigned long nr_written = 0;

 			/* allocate blocks */
-			ret = cow_file_range(BTRFS_I(inode),
-					     async_chunk->locked_page,
+			ret = cow_file_range(inode, async_chunk->locked_page,
 					     async_extent->start,
 					     async_extent->start +
 					     async_extent->ram_size - 1,
@@ -804,7 +803,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			 * all those pages down to the drive.
 			 */
 			if (!page_started && !ret)
-				extent_write_locked_range(inode,
+				extent_write_locked_range(&inode->vfs_inode,
 						  async_extent->start,
 						  async_extent->start +
 						  async_extent->ram_size - 1,
@@ -834,7 +833,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				 * will not submit these pages down to lower
 				 * layers.
 				 */
-				extent_range_redirty_for_io(inode,
+				extent_range_redirty_for_io(&inode->vfs_inode,
 						async_extent->start,
 						async_extent->start +
 						async_extent->ram_size - 1);
@@ -847,7 +846,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		 * here we're doing allocation and writeback of the
 		 * compressed pages
 		 */
-		em = create_io_em(BTRFS_I(inode), async_extent->start,
+		em = create_io_em(inode, async_extent->start,
 				  async_extent->ram_size, /* len */
 				  async_extent->start, /* orig_start */
 				  ins.objectid, /* block_start */
@@ -861,7 +860,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			goto out_free_reserve;
 		free_extent_map(em);

-		ret = btrfs_add_ordered_extent_compress(BTRFS_I(inode),
+		ret = btrfs_add_ordered_extent_compress(inode,
 						async_extent->start,
 						ins.objectid,
 						async_extent->ram_size,
@@ -869,8 +868,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 						BTRFS_ORDERED_COMPRESSED,
 						async_extent->compress_type);
 		if (ret) {
-			btrfs_drop_extent_cache(BTRFS_I(inode),
-						async_extent->start,
+			btrfs_drop_extent_cache(inode, async_extent->start,
 						async_extent->start +
 						async_extent->ram_size - 1, 0);
 			goto out_free_reserve;
@@ -880,14 +878,13 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		/*
 		 * clear dirty, set writeback and unlock the pages.
 		 */
-		extent_clear_unlock_delalloc(BTRFS_I(inode), async_extent->start,
+		extent_clear_unlock_delalloc(inode, async_extent->start,
 				async_extent->start +
 				async_extent->ram_size - 1,
 				NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 				PAGE_UNLOCK | PAGE_CLEAR_DIRTY |
 				PAGE_SET_WRITEBACK);
-		if (btrfs_submit_compressed_write(BTRFS_I(inode),
-				    async_extent->start,
+		if (btrfs_submit_compressed_write(inode, async_extent->start,
 				    async_extent->ram_size,
 				    ins.objectid,
 				    ins.offset, async_extent->pages,
@@ -898,12 +895,11 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;

-			p->mapping = inode->i_mapping;
+			p->mapping = inode->vfs_inode.i_mapping;
 			btrfs_writepage_endio_finish_ordered(p, start, end, 0);

 			p->mapping = NULL;
-			extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
-						     NULL, 0,
+			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
 						     PAGE_END_WRITEBACK |
 						     PAGE_SET_ERROR);
 			free_async_extent_pages(async_extent);
@@ -917,7 +913,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
-	extent_clear_unlock_delalloc(BTRFS_I(inode), async_extent->start,
+	extent_clear_unlock_delalloc(inode, async_extent->start,
 				     async_extent->start +
 				     async_extent->ram_size - 1,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
--
2.17.1

