Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1626420C7B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgF1Ljo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 07:39:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgF1Ljo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 07:39:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4D8CAE4B;
        Sun, 28 Jun 2020 11:39:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Martin Doucha <martin.doucha@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v7 1/3] btrfs: allow btrfs_truncate_block() to fallback to nocow for data space reservation
Date:   Sun, 28 Jun 2020 19:39:29 +0800
Message-Id: <20200628113931.26576-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628113931.26576-1-wqu@suse.com>
References: <20200628113931.26576-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When the data space is exhausted, even the inode has NOCOW attribute,
btrfs will still refuse to truncate unaligned range due to ENOSPC.

The following script can reproduce it pretty easily:
  #!/bin/bash

  dev=/dev/test/test
  mnt=/mnt/btrfs

  umount $dev &> /dev/null
  umount $mnt&> /dev/null

  mkfs.btrfs -f $dev -b 1G
  mount -o nospace_cache $dev $mnt
  touch $mnt/foobar
  chattr +C $mnt/foobar

  xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
  xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
  sync

  xfs_io -c "fpunch 0 2k" $mnt/foobar
  umount $mnt

Current btrfs will fail at the fpunch part.

[CAUSE]
Because btrfs_truncate_block() always reserve space without checking the
NOCOW attribute.

Since the writeback path follows NOCOW bit, we only need to bother the
space reservation code in btrfs_truncate_block().

[FIX]
Make btrfs_truncate_block() to follow btrfs_buffered_write() to try to
reserve data space first, and falls back to NOCOW check only when we
don't have enough space.

Such always-try-reserve is an optimization introduced in
btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() call.

This patch will export check_can_nocow() as btrfs_check_can_nocow(), and
use it in btrfs_truncate_block() to fix the problem.

Reported-by: Martin Doucha <martin.doucha@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/file.c  | 12 ++++++------
 fs/btrfs/inode.c | 44 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d8301bf240e0..b7e14189da32 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3035,6 +3035,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached);
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
+int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+			  size_t *write_bytes, bool nowait);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fccf5862cd3e..0115ef7f7943 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1533,8 +1533,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
-static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-				    size_t *write_bytes, bool nowait)
+int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+			  size_t *write_bytes, bool nowait)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1649,8 +1649,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (ret < 0) {
 			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 						      BTRFS_INODE_PREALLOC)) &&
-			    check_can_nocow(BTRFS_I(inode), pos,
-					    &write_bytes, false) > 0) {
+			    btrfs_check_can_nocow(BTRFS_I(inode), pos,
+						  &write_bytes, false) > 0) {
 				/*
 				 * For nodata cow case, no need to reserve
 				 * data space.
@@ -1927,8 +1927,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		 */
 		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 					      BTRFS_INODE_PREALLOC)) ||
-		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
-				    true) <= 0) {
+		    btrfs_check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
+					  true) <= 0) {
 			inode_unlock(inode);
 			return -EAGAIN;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 86f7aa377da9..9d9ec7838f13 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4519,11 +4519,13 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	char *kaddr;
+	bool only_release_metadata = false;
 	u32 blocksize = fs_info->sectorsize;
 	pgoff_t index = from >> PAGE_SHIFT;
 	unsigned offset = from & (blocksize - 1);
 	struct page *page;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
+	size_t write_bytes = blocksize;
 	int ret = 0;
 	u64 block_start;
 	u64 block_end;
@@ -4535,11 +4537,27 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	block_start = round_down(from, blocksize);
 	block_end = block_start + blocksize - 1;
 
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
-					   block_start, blocksize);
-	if (ret)
-		goto out;
 
+	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
+					  blocksize);
+	if (ret < 0) {
+		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
+					      BTRFS_INODE_PREALLOC)) &&
+		    btrfs_check_can_nocow(BTRFS_I(inode), block_start,
+					  &write_bytes, false) > 0) {
+			/* For nocow case, no need to reserve data space. */
+			only_release_metadata = true;
+		} else {
+			goto out;
+		}
+	}
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), blocksize);
+	if (ret < 0) {
+		if (!only_release_metadata)
+			btrfs_free_reserved_data_space(inode, data_reserved,
+					block_start, blocksize);
+		goto out;
+	}
 again:
 	page = find_or_create_page(mapping, index, mask);
 	if (!page) {
@@ -4608,14 +4626,26 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	set_page_dirty(page);
 	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
 
+	if (only_release_metadata)
+		set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
+				block_end, EXTENT_NORESERVE, NULL, NULL,
+				GFP_NOFS);
+
 out_unlock:
-	if (ret)
-		btrfs_delalloc_release_space(inode, data_reserved, block_start,
-					     blocksize, true);
+	if (ret) {
+		if (!only_release_metadata)
+			btrfs_delalloc_release_space(inode, data_reserved,
+					block_start, blocksize, true);
+		else
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+					blocksize, true);
+	}
 	btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
 	unlock_page(page);
 	put_page(page);
 out:
+	if (only_release_metadata)
+		btrfs_drew_write_unlock(&BTRFS_I(inode)->root->snapshot_lock);
 	extent_changeset_free(data_reserved);
 	return ret;
 }
-- 
2.27.0

