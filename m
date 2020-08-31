Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84F2578C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHaLyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgHaLxx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:53:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82202B8D7;
        Mon, 31 Aug 2020 11:53:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/12] btrfs: Make copy_inline_to_page take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:47 +0300
Message-Id: <20200831114249.8360-11-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/reflink.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 7126f94cf216..2461be6ccb6f 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -45,19 +45,20 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int copy_inline_to_page(struct inode *inode,
+static int copy_inline_to_page(struct btrfs_inode *inode,
 			       const u64 file_offset,
 			       char *inline_data,
 			       const u64 size,
 			       const u64 datal,
 			       const u8 comp_type)
 {
-	const u64 block_size = btrfs_inode_sectorsize(BTRFS_I(inode));
+	const u64 block_size = btrfs_inode_sectorsize(inode);
 	const u64 range_end = file_offset + block_size - 1;
 	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
 	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
 	struct extent_changeset *data_reserved = NULL;
 	struct page *page = NULL;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	int ret;
 
 	ASSERT(IS_ALIGNED(file_offset, block_size));
@@ -68,24 +69,23 @@ static int copy_inline_to_page(struct inode *inode,
 	 * reservation here. Also we must not do the reservation while holding
 	 * a transaction open, otherwise we would deadlock.
 	 */
-	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
-					   file_offset, block_size);
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, file_offset,
+					   block_size);
 	if (ret)
 		goto out;
 
-	page = find_or_create_page(inode->i_mapping, file_offset >> PAGE_SHIFT,
-				   btrfs_alloc_write_mask(inode->i_mapping));
+	page = find_or_create_page(mapping, file_offset >> PAGE_SHIFT,
+				   btrfs_alloc_write_mask(mapping));
 	if (!page) {
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
 
 	set_page_extent_mapped(page);
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, file_offset, range_end,
+	clear_extent_bit(&inode->io_tree, file_offset, range_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, NULL);
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), file_offset, range_end,
-					0, NULL);
+	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
 
@@ -134,9 +134,9 @@ static int copy_inline_to_page(struct inode *inode,
 		put_page(page);
 	}
 	if (ret)
-		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
-					     file_offset, block_size, true);
-	btrfs_delalloc_release_extents(BTRFS_I(inode), block_size);
+		btrfs_delalloc_release_space(inode, data_reserved, file_offset,
+					     block_size, true);
+	btrfs_delalloc_release_extents(inode, block_size);
 out:
 	extent_changeset_free(data_reserved);
 
@@ -167,8 +167,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 	struct btrfs_key key;
 
 	if (new_key->offset > 0) {
-		ret = copy_inline_to_page(dst, new_key->offset, inline_data,
-					  size, datal, comp_type);
+		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
+					  inline_data, size, datal, comp_type);
 		goto out;
 	}
 
@@ -194,7 +194,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 			 * inline extent's data to the page.
 			 */
 			ASSERT(key.offset > 0);
-			ret = copy_inline_to_page(dst, new_key->offset,
+			ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
 						  inline_data, size, datal,
 						  comp_type);
 			goto out;
@@ -213,8 +213,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 		    BTRFS_FILE_EXTENT_INLINE)
 			goto copy_inline_extent;
 
-		ret = copy_inline_to_page(dst, new_key->offset, inline_data,
-					  size, datal, comp_type);
+		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
+					  inline_data, size, datal, comp_type);
 		goto out;
 	}
 
@@ -231,8 +231,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 		 * clone. Deal with all these cases by copying the inline extent
 		 * data into the respective page at the destination inode.
 		 */
-		ret = copy_inline_to_page(dst, new_key->offset, inline_data,
-					   size, datal, comp_type);
+		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
+					  inline_data, size, datal, comp_type);
 		goto out;
 	}
 
-- 
2.17.1

