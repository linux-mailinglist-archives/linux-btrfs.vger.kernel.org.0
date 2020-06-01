Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A731EA705
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgFAPhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgFAPhx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1BA0FB20D;
        Mon,  1 Jun 2020 15:37:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 21/46] btrfs: Make run_delalloc_nocow take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:19 +0300
Message-Id: <20200601153744.31891-22-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It only really uses btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27051e8a7013..2798154f2c48 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1419,28 +1419,27 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
  * If no cow copies or snapshots exist, we write directly to the existing
  * blocks on disk
  */
-static noinline int run_delalloc_nocow(struct inode *inode,
+static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				       struct page *locked_page,
 				       const u64 start, const u64 end,
 				       int *page_started, int force,
 				       unsigned long *nr_written)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_path *path;
 	u64 cow_start = (u64)-1;
 	u64 cur_offset = start;
 	int ret;
 	bool check_prev = true;
-	const bool freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	const bool freespace_inode = btrfs_is_free_space_inode(inode);
+	u64 ino = btrfs_ino(inode);
 	bool nocow = false;
 	u64 disk_bytenr = 0;

 	path = btrfs_alloc_path();
 	if (!path) {
-		extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
-					     locked_page,
+		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DO_ACCOUNTING |
 					     EXTENT_DEFRAG, PAGE_UNLOCK |
@@ -1660,7 +1659,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		 * NOCOW, following one which needs to be COW'ed
 		 */
 		if (cow_start != (u64)-1) {
-			ret = fallback_to_cow(BTRFS_I(inode), locked_page,
+			ret = fallback_to_cow(inode, locked_page,
 					      cow_start, found_key.offset - 1,
 					      page_started, nr_written);
 			if (ret) {
@@ -1676,7 +1675,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			u64 orig_start = found_key.offset - extent_offset;
 			struct extent_map *em;

-			em = create_io_em(BTRFS_I(inode), cur_offset, num_bytes,
+			em = create_io_em(inode, cur_offset, num_bytes,
 					  orig_start,
 					  disk_bytenr, /* block_start */
 					  num_bytes, /* block_len */
@@ -1691,19 +1690,18 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				goto error;
 			}
 			free_extent_map(em);
-			ret = btrfs_add_ordered_extent(BTRFS_I(inode), cur_offset,
+			ret = btrfs_add_ordered_extent(inode, cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_PREALLOC);
 			if (ret) {
-				btrfs_drop_extent_cache(BTRFS_I(inode),
-							cur_offset,
+				btrfs_drop_extent_cache(inode, cur_offset,
 							cur_offset + num_bytes - 1,
 							0);
 				goto error;
 			}
 		} else {
-			ret = btrfs_add_ordered_extent(BTRFS_I(inode), cur_offset,
+			ret = btrfs_add_ordered_extent(inode, cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_NOCOW);
@@ -1722,10 +1720,10 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			 * extent_clear_unlock_delalloc() in error handler
 			 * from freeing metadata of created ordered extent.
 			 */
-			ret = btrfs_reloc_clone_csums(BTRFS_I(inode), cur_offset,
+			ret = btrfs_reloc_clone_csums(inode, cur_offset,
 						      num_bytes);

-		extent_clear_unlock_delalloc(BTRFS_I(inode), cur_offset,
+		extent_clear_unlock_delalloc(inode, cur_offset,
 					     cur_offset + num_bytes - 1,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC |
@@ -1751,8 +1749,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,

 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = fallback_to_cow(BTRFS_I(inode), locked_page, cow_start,
-				      end, page_started, nr_written);
+		ret = fallback_to_cow(inode, locked_page, cow_start, end,
+				      page_started, nr_written);
 		if (ret)
 			goto error;
 	}
@@ -1762,7 +1760,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		btrfs_dec_nocow_writers(fs_info, disk_bytenr);

 	if (ret && cur_offset < end)
-		extent_clear_unlock_delalloc(BTRFS_I(inode), cur_offset, end,
+		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -1805,10 +1803,10 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 	int force_cow = need_force_cow(inode, start, end);

 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW && !force_cow) {
-		ret = run_delalloc_nocow(inode, locked_page, start, end,
+		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC && !force_cow) {
-		ret = run_delalloc_nocow(inode, locked_page, start, end,
+		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
 					 page_started, 0, nr_written);
 	} else if (!inode_can_compress(inode) ||
 		   !inode_need_compress(inode, start, end)) {
--
2.17.1

