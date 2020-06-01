Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074451EA725
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgFAPiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgFAPhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD4CDB21F;
        Mon,  1 Jun 2020 15:37:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 19/46] btrfs: Make insert_reserved_file_extent take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:17 +0300
Message-Id: <20200601153744.31891-20-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 28dfadb97a6a..2f6460241c61 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2446,13 +2446,13 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 }
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
-				       struct inode *inode, u64 file_pos,
+				       struct btrfs_inode *inode, u64 file_pos,
 				       u64 disk_bytenr, u64 disk_num_bytes,
 				       u64 num_bytes, u64 ram_bytes,
 				       u8 compression, u8 encryption,
 				       u16 other_encoding, int extent_type)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
@@ -2474,14 +2474,14 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * the caller is expected to unpin it and allow it to be merged
 	 * with the others.
 	 */
-	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path, file_pos,
+	ret = __btrfs_drop_extents(trans, root, inode, path, file_pos,
 				   file_pos + num_bytes, NULL, 0,
 				   1, sizeof(*fi), &extent_inserted);
 	if (ret)
 		goto out;
 
 	if (!extent_inserted) {
-		ins.objectid = btrfs_ino(BTRFS_I(inode));
+		ins.objectid = btrfs_ino(inode);
 		ins.offset = file_pos;
 		ins.type = BTRFS_EXTENT_DATA_KEY;
 
@@ -2508,14 +2508,13 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	inode_add_bytes(inode, num_bytes);
+	inode_add_bytes(&inode->vfs_inode, num_bytes);
 
 	ins.objectid = disk_bytenr;
 	ins.offset = disk_num_bytes;
 	ins.type = BTRFS_EXTENT_ITEM_KEY;
 
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), file_pos,
-						ram_bytes);
+	ret = btrfs_inode_set_file_extent_range(inode, file_pos, ram_bytes);
 	if (ret)
 		goto out;
 
@@ -2523,12 +2522,11 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * Release the reserved range from inode dirty range map, as it is
 	 * already moved into delayed_ref_head
 	 */
-	ret = btrfs_qgroup_release_data(BTRFS_I(inode), file_pos, ram_bytes);
+	ret = btrfs_qgroup_release_data(inode, file_pos, ram_bytes);
 	if (ret < 0)
 		goto out;
 	qg_released = ret;
-	ret = btrfs_alloc_reserved_file_extent(trans, root,
-					       btrfs_ino(BTRFS_I(inode)),
+	ret = btrfs_alloc_reserved_file_extent(trans, root, btrfs_ino(inode),
 					       file_pos, qg_released, &ins);
 out:
 	btrfs_free_path(path);
@@ -2653,7 +2651,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						logical_len);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
-		ret = insert_reserved_file_extent(trans, inode, start,
+		ret = insert_reserved_file_extent(trans, BTRFS_I(inode), start,
 						ordered_extent->disk_bytenr,
 						ordered_extent->disk_num_bytes,
 						logical_len, logical_len,
@@ -9545,7 +9543,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
 		last_alloc = ins.offset;
-		ret = insert_reserved_file_extent(trans, inode,
+		ret = insert_reserved_file_extent(trans, BTRFS_I(inode),
 						  cur_offset, ins.objectid,
 						  ins.offset, ins.offset,
 						  ins.offset, 0, 0, 0,
-- 
2.17.1

