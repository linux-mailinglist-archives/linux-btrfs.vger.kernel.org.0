Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DA1EC904
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFCFz5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:42442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgFCFzz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0FA97AFF6;
        Wed,  3 Jun 2020 05:55:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/46] btrfs: Make extent_clear_unlock_delalloc take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:06 +0300
Message-Id: <20200603055546.3889-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It has 1 vfs and 1 btrfs inode usages but converting it to
btrfs_inode interface will allow seamless conversion of its callers.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c |  7 +++----
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 29 ++++++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c59e07360083..4d19cb930d57 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2017,15 +2017,14 @@ static int __process_pages_contig(struct address_space *mapping,
 	return err;
 }

-void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
+void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  unsigned clear_bits,
 				  unsigned long page_ops)
 {
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, start, end, clear_bits, 1, 0,
-			 NULL);
+	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);

-	__process_pages_contig(inode->i_mapping, locked_page,
+	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
 			       start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 			       page_ops, NULL);
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9a10681b12bf..8e693cf2f89c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -277,7 +277,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 int extent_buffer_under_io(const struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
-void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
+void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  unsigned bits_to_clear,
 				  unsigned long page_ops);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 00ad7bdb7d34..7615b73feb30 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -641,7 +641,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(inode, start, end, NULL,
+			extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
+						     NULL,
 						     clear_flags,
 						     PAGE_UNLOCK |
 						     PAGE_CLEAR_DIRTY |
@@ -877,7 +878,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		/*
 		 * clear dirty, set writeback and unlock the pages.
 		 */
-		extent_clear_unlock_delalloc(inode, async_extent->start,
+		extent_clear_unlock_delalloc(BTRFS_I(inode), async_extent->start,
 				async_extent->start +
 				async_extent->ram_size - 1,
 				NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
@@ -899,7 +900,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 			btrfs_writepage_endio_finish_ordered(p, start, end, 0);

 			p->mapping = NULL;
-			extent_clear_unlock_delalloc(inode, start, end,
+			extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
 						     NULL, 0,
 						     PAGE_END_WRITEBACK |
 						     PAGE_SET_ERROR);
@@ -914,7 +915,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
-	extent_clear_unlock_delalloc(inode, async_extent->start,
+	extent_clear_unlock_delalloc(BTRFS_I(inode), async_extent->start,
 				     async_extent->start +
 				     async_extent->ram_size - 1,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
@@ -1015,7 +1016,8 @@ static noinline int cow_file_range(struct inode *inode,
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(inode, start, end, NULL,
+			extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
+				     NULL,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -1097,7 +1099,7 @@ static noinline int cow_file_range(struct inode *inode,
 		page_ops = unlock ? PAGE_UNLOCK : 0;
 		page_ops |= PAGE_SET_PRIVATE2;

-		extent_clear_unlock_delalloc(inode, start,
+		extent_clear_unlock_delalloc(BTRFS_I(inode), start,
 					     start + ram_size - 1,
 					     locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
@@ -1142,7 +1144,7 @@ static noinline int cow_file_range(struct inode *inode,
 	 * it the flag EXTENT_CLEAR_DATA_RESV.
 	 */
 	if (extent_reserved) {
-		extent_clear_unlock_delalloc(inode, start,
+		extent_clear_unlock_delalloc(BTRFS_I(inode), start,
 					     start + cur_alloc_size - 1,
 					     locked_page,
 					     clear_bits,
@@ -1151,7 +1153,7 @@ static noinline int cow_file_range(struct inode *inode,
 		if (start >= end)
 			goto out;
 	}
-	extent_clear_unlock_delalloc(inode, start, end, locked_page,
+	extent_clear_unlock_delalloc(BTRFS_I(inode), start, end, locked_page,
 				     clear_bits | EXTENT_CLEAR_DATA_RESV,
 				     page_ops);
 	goto out;
@@ -1259,8 +1261,8 @@ static int cow_file_range_async(struct inode *inode,
 			PAGE_SET_WRITEBACK | PAGE_END_WRITEBACK |
 			PAGE_SET_ERROR;

-		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     clear_bits, page_ops);
+		extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
+					     locked_page, clear_bits, page_ops);
 		return -ENOMEM;
 	}

@@ -1443,7 +1445,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,

 	path = btrfs_alloc_path();
 	if (!path) {
-		extent_clear_unlock_delalloc(inode, start, end, locked_page,
+		extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
+					     locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DO_ACCOUNTING |
 					     EXTENT_DEFRAG, PAGE_UNLOCK |
@@ -1728,7 +1731,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			ret = btrfs_reloc_clone_csums(BTRFS_I(inode), cur_offset,
 						      num_bytes);

-		extent_clear_unlock_delalloc(inode, cur_offset,
+		extent_clear_unlock_delalloc(BTRFS_I(inode), cur_offset,
 					     cur_offset + num_bytes - 1,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC |
@@ -1765,7 +1768,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		btrfs_dec_nocow_writers(fs_info, disk_bytenr);

 	if (ret && cur_offset < end)
-		extent_clear_unlock_delalloc(inode, cur_offset, end,
+		extent_clear_unlock_delalloc(BTRFS_I(inode), cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
--
2.17.1

