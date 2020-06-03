Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDBD1EC95E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 08:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgFCGVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 02:21:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFCGVW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 02:21:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3232AD0D;
        Wed,  3 Jun 2020 06:21:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Martin Doucha <martin.doucha@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: Allow btrfs_truncate_block() to fallback to nocow for data space reservation
Date:   Wed,  3 Jun 2020 14:21:15 +0800
Message-Id: <20200603062115.16227-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
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

Since now check_can_nocow() is needed outside of inode.c, also export it
and rename it to btrfs_check_can_nocow().

Reported-by: Martin Doucha <martin.doucha@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
Changelog:
v2:
- Rebased to misc-next
  Only one minor conflict in ctree.h
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/file.c  | 10 +++++-----
 fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 161533040978..40e8c8170d39 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2984,6 +2984,8 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached);
 int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
+int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+			  size_t *write_bytes);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fde125616687..a298803e2b08 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1532,8 +1532,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	return ret;
 }
 
-static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-				    size_t *write_bytes)
+int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
+			  size_t *write_bytes)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1632,8 +1632,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (ret < 0) {
 			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 						      BTRFS_INODE_PREALLOC)) &&
-			    check_can_nocow(BTRFS_I(inode), pos,
-					&write_bytes) > 0) {
+			    btrfs_check_can_nocow(BTRFS_I(inode), pos,
+						  &write_bytes) > 0) {
 				/*
 				 * For nodata cow case, no need to reserve
 				 * data space.
@@ -1950,7 +1950,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		 */
 		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 					      BTRFS_INODE_PREALLOC)) ||
-		    check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
+		    btrfs_check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
 			inode_unlock(inode);
 			return -EAGAIN;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1242d0aa108d..6b94ec7369c6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4493,11 +4493,13 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
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
@@ -4509,11 +4511,26 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	block_start = round_down(from, blocksize);
 	block_end = block_start + blocksize - 1;
 
-	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
-					   block_start, blocksize);
-	if (ret)
+	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
+					  blocksize);
+	if (ret < 0) {
+		if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
+					      BTRFS_INODE_PREALLOC)) &&
+		    btrfs_check_can_nocow(BTRFS_I(inode), block_start,
+					  &write_bytes) > 0) {
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
 		goto out;
-
+	}
 again:
 	page = find_or_create_page(mapping, index, mask);
 	if (!page) {
@@ -4582,10 +4599,20 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
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
-- 
2.26.2

