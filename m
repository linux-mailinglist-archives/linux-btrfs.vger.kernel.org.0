Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61C6BCDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfGQNSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 09:18:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:57838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfGQNSU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 09:18:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC5C8B15D
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 13:18:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Remove delalloc_end argument from extent_clear_unlock_delalloc
Date:   Wed, 17 Jul 2019 16:18:16 +0300
Message-Id: <20190717131817.8567-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It was added in ba8b04c1d4ad ("btrfs: extend btrfs_set_extent_delalloc
and its friends to support in-band dedupe and subpage size patchset") as
a preparatory patch for in-band and subapge block size patchsets.
However neither of those are likely to be merged anytime soon and the
code has diverged significantly from the last public post of either
of those patchsets.

It's unlikely either of the patchests are going to use those preparatory
steps so just remove the variables. Since cow_file_range also took
delalloc_end to pass it to extent_clear_unlock_delalloc remove the
parameter from that function as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c |  6 +++---
 fs/btrfs/extent_io.h |  6 +++---
 fs/btrfs/inode.c     | 48 ++++++++++++++++++--------------------------
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 93bcae4a4f8d..ef0b26545759 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1938,9 +1938,9 @@ static int __process_pages_contig(struct address_space *mapping,
 }
 
 void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
-				 u64 delalloc_end, struct page *locked_page,
-				 unsigned clear_bits,
-				 unsigned long page_ops)
+				  struct page *locked_page,
+				  unsigned clear_bits,
+				  unsigned long page_ops)
 {
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, start, end, clear_bits, 1, 0,
 			 NULL);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 04e8ecc216f0..b666b854b6b0 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -495,9 +495,9 @@ int map_private_extent_buffer(const struct extent_buffer *eb,
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
-				 u64 delalloc_end, struct page *locked_page,
-				 unsigned bits_to_clear,
-				 unsigned long page_ops);
+				  struct page *locked_page,
+				  unsigned bits_to_clear,
+				  unsigned long page_ops);
 struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a84d73b670ff..6dc06fee3a46 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -80,9 +80,9 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback);
 static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 static noinline int cow_file_range(struct inode *inode,
 				   struct page *locked_page,
-				   u64 start, u64 end, u64 delalloc_end,
-				   int *page_started, unsigned long *nr_written,
-				   int unlock, struct btrfs_dedupe_hash *hash);
+				   u64 start, u64 end, int *page_started,
+				   unsigned long *nr_written, int unlock,
+				   struct btrfs_dedupe_hash *hash);
 static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 				       u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
@@ -594,8 +594,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(inode, start, end, end,
-						     NULL, clear_flags,
+			extent_clear_unlock_delalloc(inode, start, end, NULL,
+						     clear_flags,
 						     PAGE_UNLOCK |
 						     PAGE_CLEAR_DIRTY |
 						     PAGE_SET_WRITEBACK |
@@ -741,8 +741,6 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 					     async_extent->start,
 					     async_extent->start +
 					     async_extent->ram_size - 1,
-					     async_extent->start +
-					     async_extent->ram_size - 1,
 					     &page_started, &nr_written, 0,
 					     NULL);
 
@@ -832,8 +830,6 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		 * clear dirty, set writeback and unlock the pages.
 		 */
 		extent_clear_unlock_delalloc(inode, async_extent->start,
-				async_extent->start +
-				async_extent->ram_size - 1,
 				async_extent->start +
 				async_extent->ram_size - 1,
 				NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
@@ -854,7 +850,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			btrfs_writepage_endio_finish_ordered(p, start, end, 0);
 
 			p->mapping = NULL;
-			extent_clear_unlock_delalloc(inode, start, end, end,
+			extent_clear_unlock_delalloc(inode, start, end,
 						     NULL, 0,
 						     PAGE_END_WRITEBACK |
 						     PAGE_SET_ERROR);
@@ -870,8 +866,6 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
 	extent_clear_unlock_delalloc(inode, async_extent->start,
-				     async_extent->start +
-				     async_extent->ram_size - 1,
 				     async_extent->start +
 				     async_extent->ram_size - 1,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
@@ -932,9 +926,9 @@ static u64 get_extent_allocation_hint(struct inode *inode, u64 start,
  */
 static noinline int cow_file_range(struct inode *inode,
 				   struct page *locked_page,
-				   u64 start, u64 end, u64 delalloc_end,
-				   int *page_started, unsigned long *nr_written,
-				   int unlock, struct btrfs_dedupe_hash *hash)
+				   u64 start, u64 end, int *page_started,
+				   unsigned long *nr_written, int unlock,
+				   struct btrfs_dedupe_hash *hash)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -973,8 +967,7 @@ static noinline int cow_file_range(struct inode *inode,
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(inode, start, end,
-				     delalloc_end, NULL,
+			extent_clear_unlock_delalloc(inode, start, end, NULL,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -1057,7 +1050,7 @@ static noinline int cow_file_range(struct inode *inode,
 
 		extent_clear_unlock_delalloc(inode, start,
 					     start + ram_size - 1,
-					     delalloc_end, locked_page,
+					     locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
 		if (num_bytes < cur_alloc_size)
@@ -1101,7 +1094,6 @@ static noinline int cow_file_range(struct inode *inode,
 	 */
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
-					     start + cur_alloc_size,
 					     start + cur_alloc_size,
 					     locked_page,
 					     clear_bits,
@@ -1110,8 +1102,7 @@ static noinline int cow_file_range(struct inode *inode,
 		if (start >= end)
 			goto out;
 	}
-	extent_clear_unlock_delalloc(inode, start, end, delalloc_end,
-				     locked_page,
+	extent_clear_unlock_delalloc(inode, start, end, locked_page,
 				     clear_bits | EXTENT_CLEAR_DATA_RESV,
 				     page_ops);
 	goto out;
@@ -1214,7 +1205,7 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
 			PAGE_SET_WRITEBACK | PAGE_END_WRITEBACK |
 			PAGE_SET_ERROR;
 
-		extent_clear_unlock_delalloc(inode, start, end, 0, locked_page,
+		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     clear_bits, page_ops);
 		return -ENOMEM;
 	}
@@ -1317,8 +1308,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		extent_clear_unlock_delalloc(inode, start, end, end,
-					     locked_page,
+		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DO_ACCOUNTING |
 					     EXTENT_DEFRAG, PAGE_UNLOCK |
@@ -1495,7 +1485,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		if (cow_start != (u64)-1) {
 			ret = cow_file_range(inode, locked_page,
 					     cow_start, found_key.offset - 1,
-					     end, page_started, nr_written, 1,
+					     page_started, nr_written, 1,
 					     NULL);
 			if (ret) {
 				if (nocow)
@@ -1549,7 +1539,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 						      num_bytes);
 
 		extent_clear_unlock_delalloc(inode, cur_offset,
-					     cur_offset + num_bytes - 1, end,
+					     cur_offset + num_bytes - 1,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
@@ -1574,7 +1564,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = cow_file_range(inode, locked_page, cow_start, end, end,
+		ret = cow_file_range(inode, locked_page, cow_start, end,
 				     page_started, nr_written, 1, NULL);
 		if (ret)
 			goto error;
@@ -1582,7 +1572,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 
 error:
 	if (ret && cur_offset < end)
-		extent_clear_unlock_delalloc(inode, cur_offset, end, end,
+		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -1632,7 +1622,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
 	} else if (!inode_need_compress(inode, start, end)) {
-		ret = cow_file_range(inode, locked_page, start, end, end,
+		ret = cow_file_range(inode, locked_page, start, end,
 				      page_started, nr_written, 1, NULL);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-- 
2.17.1

