Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7921EA702
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFAPhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgFAPhu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 423DFB214;
        Mon,  1 Jun 2020 15:37:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/46] btrfs: Make __btrfs_drop_extents take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:06 +0300
Message-Id: <20200601153744.31891-9-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It has only 4 uses of a vfs_inode for inode_sub_bytes but unifies the interface
with the non  __ prefixed version. Will also makes converting its callers
to btrfs_inode easier.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h    |  2 +-
 fs/btrfs/file.c     | 23 ++++++++++++-----------
 fs/btrfs/inode.c    |  4 ++--
 fs/btrfs/tree-log.c |  4 ++--
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 55add0881615..bd69e912e8d6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2964,7 +2964,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			     int skip_pinned);
 extern const struct file_operations btrfs_file_operations;
 int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root, struct inode *inode,
+			 struct btrfs_root *root, struct btrfs_inode *inode,
 			 struct btrfs_path *path, u64 start, u64 end,
 			 u64 *drop_end, int drop_cache,
 			 int replace_extent,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fde125616687..01745c0651cb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -731,7 +731,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
  * is deleted from the tree.
  */
 int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *root, struct inode *inode,
+			 struct btrfs_root *root, struct btrfs_inode *inode,
 			 struct btrfs_path *path, u64 start, u64 end,
 			 u64 *drop_end, int drop_cache,
 			 int replace_extent,
@@ -744,7 +744,8 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_ref ref = { 0 };
 	struct btrfs_key key;
 	struct btrfs_key new_key;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	struct inode *vfs_inode = &inode->vfs_inode;
+	u64 ino = btrfs_ino(inode);
 	u64 search_start = start;
 	u64 disk_bytenr = 0;
 	u64 num_bytes = 0;
@@ -762,9 +763,9 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	int leafs_visited = 0;

 	if (drop_cache)
-		btrfs_drop_extent_cache(BTRFS_I(inode), start, end - 1, 0);
+		btrfs_drop_extent_cache(inode, start, end - 1, 0);

-	if (start >= BTRFS_I(inode)->disk_i_size && !replace_extent)
+	if (start >= inode->disk_i_size && !replace_extent)
 		modify_tree = 0;

 	update_refs = (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
@@ -935,7 +936,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 							extent_end - end);
 			btrfs_mark_buffer_dirty(leaf);
 			if (update_refs && disk_bytenr > 0)
-				inode_sub_bytes(inode, end - key.offset);
+				inode_sub_bytes(vfs_inode, end - key.offset);
 			break;
 		}

@@ -955,7 +956,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 							start - key.offset);
 			btrfs_mark_buffer_dirty(leaf);
 			if (update_refs && disk_bytenr > 0)
-				inode_sub_bytes(inode, extent_end - start);
+				inode_sub_bytes(vfs_inode, extent_end - start);
 			if (end == extent_end)
 				break;

@@ -979,7 +980,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,

 			if (update_refs &&
 			    extent_type == BTRFS_FILE_EXTENT_INLINE) {
-				inode_sub_bytes(inode,
+				inode_sub_bytes(vfs_inode,
 						extent_end - key.offset);
 				extent_end = ALIGN(extent_end,
 						   fs_info->sectorsize);
@@ -993,7 +994,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 						key.offset - extent_offset);
 				ret = btrfs_free_extent(trans, &ref);
 				BUG_ON(ret); /* -ENOMEM */
-				inode_sub_bytes(inode,
+				inode_sub_bytes(vfs_inode,
 						extent_end - key.offset);
 			}

@@ -1082,8 +1083,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	ret = __btrfs_drop_extents(trans, root, inode, path, start, end, NULL,
-				   drop_cache, 0, 0, NULL);
+	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path, start,
+				   end, NULL, drop_cache, 0, 0, NULL);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -2610,7 +2611,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,

 	cur_offset = start;
 	while (cur_offset < end) {
-		ret = __btrfs_drop_extents(trans, root, inode, path,
+		ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path,
 					   cur_offset, end + 1, &drop_end,
 					   1, 0, 0, NULL);
 		if (ret != -ENOSPC) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d20afd95ab4d..810065cd38a2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -322,7 +322,7 @@ static noinline int cow_file_range_inline(struct inode *inode, u64 start,
 		extent_item_size = btrfs_file_extent_calc_inline_size(
 		    inline_len);

-	ret = __btrfs_drop_extents(trans, root, inode, path,
+	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path,
 				   start, aligned_end, NULL,
 				   1, 1, extent_item_size, &extent_inserted);
 	if (ret) {
@@ -2480,7 +2480,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * the caller is expected to unpin it and allow it to be merged
 	 * with the others.
 	 */
-	ret = __btrfs_drop_extents(trans, root, inode, path, file_pos,
+	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path, file_pos,
 				   file_pos + num_bytes, NULL, 0,
 				   1, sizeof(*fi), &extent_inserted);
 	if (ret)
@@ -4146,7 +4146,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;

-	ret = __btrfs_drop_extents(trans, log, &inode->vfs_inode, path, em->start,
+	ret = __btrfs_drop_extents(trans, log, inode, path, em->start,
 				   em->start + em->len, NULL, 0, 1,
 				   sizeof(*fi), &extent_inserted);
 	if (ret)
--
2.17.1

