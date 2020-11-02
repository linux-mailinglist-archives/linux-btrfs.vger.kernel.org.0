Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15912A2D56
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKBOtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:39924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgKBOtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmWFXB1P5MKtn1kPEOBEFCfpgt93BsSw30HnkAnaAPg=;
        b=QoxJnraFs0litaxFcsrJkiGL/00FjZMtaxU/+MHtHTQ4hXjEd8JqOFfOoKaHHBabKjukdd
        HTd+9325wWJNKuh6wSgMxntuhe1d2+2r0Fkv+gVZQSlfycydwyX79HKVKZ6X5G2c0h1Yu8
        7PHg4ka1LaIgceijg/REd8WCf0f89VA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 115F1B902;
        Mon,  2 Nov 2020 14:49:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/14] btrfs: Make btrfs_truncate_block take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:03 +0200
Message-Id: <20201102144906.3767963-12-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h |  4 ++--
 fs/btrfs/file.c  | 17 +++++++++-------
 fs/btrfs/inode.c | 52 +++++++++++++++++++++++-------------------------
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a23a7de6a4f3..bfcd4748319f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2994,8 +2994,8 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const char *name, int name_len, int add_backref, u64 index);
 int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
-int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
-			int front);
+int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
+			 int front);
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct btrfs_inode *inode, u64 new_size,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0f3b9fb842e7..3731b3b3325d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2918,7 +2918,8 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (same_block && len < fs_info->sectorsize) {
 		if (offset < ino_size) {
 			truncated_block = true;
-			ret = btrfs_truncate_block(inode, offset, len, 0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
+						   0);
 		} else {
 			ret = 0;
 		}
@@ -2928,7 +2929,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	/* zero back part of the first block */
 	if (offset < ino_size) {
 		truncated_block = true;
-		ret = btrfs_truncate_block(inode, offset, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 		if (ret) {
 			inode_unlock(inode);
 			return ret;
@@ -2964,7 +2965,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			/* zero the front end of the last page */
 			if (tail_start + tail_len < ino_size) {
 				truncated_block = true;
-				ret = btrfs_truncate_block(inode,
+				ret = btrfs_truncate_block(BTRFS_I(inode),
 							tail_start + tail_len,
 							0, 1);
 				if (ret)
@@ -3206,7 +3207,8 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 		if (len < sectorsize && em->block_start != EXTENT_MAP_HOLE) {
 			free_extent_map(em);
-			ret = btrfs_truncate_block(inode, offset, len, 0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
+						   0);
 			if (!ret)
 				ret = btrfs_fallocate_update_isize(inode,
 								   offset + len,
@@ -3237,7 +3239,7 @@ static int btrfs_zero_range(struct inode *inode,
 			alloc_start = round_down(offset, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
-			ret = btrfs_truncate_block(inode, offset, 0, 0);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 			if (ret)
 				goto out;
 		} else {
@@ -3254,7 +3256,8 @@ static int btrfs_zero_range(struct inode *inode,
 			alloc_end = round_up(offset + len, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
-			ret = btrfs_truncate_block(inode, offset + len, 0, 1);
+			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
+						   0, 1);
 			if (ret)
 				goto out;
 		} else {
@@ -3374,7 +3377,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		 * need to zero out the end of the block if i_size lands in the
 		 * middle of a block.
 		 */
-		ret = btrfs_truncate_block(inode, inode->i_size, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
 		if (ret)
 			goto out;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6264777474ad..a7fdea00b824 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4486,12 +4486,12 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
  * This will find the block for the "from" offset and cow the block and zero the
  * part we want to zero.  This is used with truncate and hole punching.
  */
-int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
-			int front)
+int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
+			 int front)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct address_space *mapping = inode->i_mapping;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
@@ -4514,10 +4514,10 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	block_start = round_down(from, blocksize);
 	block_end = block_start + blocksize - 1;
 
-	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved,
-					  block_start, blocksize);
+	ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
+					  blocksize);
 	if (ret < 0) {
-		if (btrfs_check_nocow_lock(BTRFS_I(inode), block_start,
+		if (btrfs_check_nocow_lock(inode, block_start,
 					   &write_bytes) > 0) {
 			/* For nocow case, no need to reserve data space */
 			only_release_metadata = true;
@@ -4525,19 +4525,19 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
-			btrfs_free_reserved_data_space(BTRFS_I(inode),
-					data_reserved, block_start, blocksize);
+			btrfs_free_reserved_data_space(inode, data_reserved,
+						       block_start, blocksize);
 		goto out;
 	}
 again:
 	page = find_or_create_page(mapping, index, mask);
 	if (!page) {
-		btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
-					     block_start, blocksize, true);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
+		btrfs_delalloc_release_space(inode, data_reserved, block_start,
+					     blocksize, true);
+		btrfs_delalloc_release_extents(inode, blocksize);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -4560,7 +4560,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	lock_extent_bits(io_tree, block_start, block_end, &cached_state);
 	set_page_extent_mapped(page);
 
-	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), block_start);
+	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
 		unlock_extent_cached(io_tree, block_start, block_end,
 				     &cached_state);
@@ -4571,11 +4571,11 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 		goto again;
 	}
 
-	clear_extent_bit(&BTRFS_I(inode)->io_tree, block_start, block_end,
+	clear_extent_bit(&inode->io_tree, block_start, block_end,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, &cached_state);
 
-	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), block_start, block_end, 0,
+	ret = btrfs_set_extent_delalloc(inode, block_start, block_end, 0,
 					&cached_state);
 	if (ret) {
 		unlock_extent_cached(io_tree, block_start, block_end,
@@ -4601,25 +4601,23 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
-		set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
-				block_end, EXTENT_NORESERVE, NULL, NULL,
-				GFP_NOFS);
+		set_extent_bit(io_tree, block_start, block_end,
+			       EXTENT_NORESERVE, NULL, NULL, GFP_NOFS);
 
 out_unlock:
 	if (ret) {
 		if (only_release_metadata)
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					blocksize, true);
+			btrfs_delalloc_release_metadata(inode, blocksize, true);
 		else
-			btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved,
+			btrfs_delalloc_release_space(inode, data_reserved,
 					block_start, blocksize, true);
 	}
-	btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
+	btrfs_delalloc_release_extents(inode, blocksize);
 	unlock_page(page);
 	put_page(page);
 out:
 	if (only_release_metadata)
-		btrfs_check_nocow_unlock(BTRFS_I(inode));
+		btrfs_check_nocow_unlock(inode);
 	extent_changeset_free(data_reserved);
 	return ret;
 }
@@ -4695,7 +4693,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 	 * rest of the block before we expand the i_size, otherwise we could
 	 * expose stale data.
 	 */
-	err = btrfs_truncate_block(inode, oldsize, 0, 0);
+	err = btrfs_truncate_block(BTRFS_I(inode), oldsize, 0, 0);
 	if (err)
 		return err;
 
@@ -8498,7 +8496,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
 
-		ret = btrfs_truncate_block(inode, inode->i_size, 0, 0);
+		ret = btrfs_truncate_block(BTRFS_I(inode), inode->i_size, 0, 0);
 		if (ret)
 			goto out;
 		trans = btrfs_start_transaction(root, 1);
-- 
2.25.1

