Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378FB1EC905
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgFCFz7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFCFz4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5812BB012;
        Wed,  3 Jun 2020 05:55:57 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/46] btrfs: Make cow_file_range_inline take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:12 +0300
Message-Id: <20200603055546.3889-13-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It has only 2 uses for the vfs_inode - insert_inline_extent and i_size_read.
On the flipside it will allow converting its callers to btrfs_inode,
so convert it to taking btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 70ed320cd1fa..a05ffc129967 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -273,15 +273,15 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
  */
-static noinline int cow_file_range_inline(struct inode *inode, u64 start,
+static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 					  u64 end, size_t compressed_size,
 					  int compress_type,
 					  struct page **compressed_pages)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	u64 isize = i_size_read(inode);
+	u64 isize = i_size_read(&inode->vfs_inode);
 	u64 actual_end = min(end + 1, isize);
 	u64 inline_len = actual_end - start;
 	u64 aligned_end = ALIGN(end, fs_info->sectorsize);
@@ -313,7 +313,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
 	}
-	trans->block_rsv = &BTRFS_I(inode)->block_rsv;
+	trans->block_rsv = &inode->block_rsv;

 	if (compressed_size && compressed_pages)
 		extent_item_size = btrfs_file_extent_calc_inline_size(
@@ -322,9 +322,9 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 		extent_item_size = btrfs_file_extent_calc_inline_size(
 		    inline_len);

-	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path,
-				   start, aligned_end, NULL,
-				   1, 1, extent_item_size, &extent_inserted);
+	ret = __btrfs_drop_extents(trans, root, inode, path, start, aligned_end,
+				   NULL, 1, 1, extent_item_size,
+				   &extent_inserted);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -333,7 +333,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 	if (isize > actual_end)
 		inline_len = min_t(u64, isize, actual_end);
 	ret = insert_inline_extent(trans, path, extent_inserted,
-				   root, inode, start,
+				   root, &inode->vfs_inode, start,
 				   inline_len, compressed_size,
 				   compress_type, compressed_pages);
 	if (ret && ret != -ENOSPC) {
@@ -344,8 +344,8 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 		goto out;
 	}

-	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
-	btrfs_drop_extent_cache(BTRFS_I(inode), start, aligned_end - 1, 0);
+	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
+	btrfs_drop_extent_cache(inode, start, aligned_end - 1, 0);
 out:
 	/*
 	 * Don't forget to free the reserved space, as for inlined extent
@@ -353,7 +353,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(BTRFS_I(inode), NULL, 0, PAGE_SIZE);
+	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
@@ -615,11 +615,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/* we didn't compress the entire range, try
 			 * to make an uncompressed inline extent.
 			 */
-			ret = cow_file_range_inline(inode, start, end, 0,
-						    BTRFS_COMPRESS_NONE, NULL);
+			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
+						    0, BTRFS_COMPRESS_NONE,
+						    NULL);
 		} else {
 			/* try making a compressed inline extent */
-			ret = cow_file_range_inline(inode, start, end,
+			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
 						    total_compressed,
 						    compress_type, pages);
 		}
@@ -1007,7 +1008,7 @@ static noinline int cow_file_range(struct inode *inode,

 	if (start == 0) {
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, start, end, 0,
+		ret = cow_file_range_inline(BTRFS_I(inode), start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL);
 		if (ret == 0) {
 			/*
--
2.17.1

