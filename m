Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69BA1F4A97
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFJBEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 21:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgFJBEx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 21:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A1F1ADA8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jun 2020 01:04:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/5] btrfs: inode: refactor the parameters of insert_reserved_file_extent()
Date:   Wed, 10 Jun 2020 09:04:40 +0800
Message-Id: <20200610010444.13583-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610010444.13583-1-wqu@suse.com>
References: <20200610010444.13583-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function insert_reserved_file_extent() takes a long list of parameters,
which are all for btrfs_file_extent_item, even including two reserved
members, encryption and other_encoding.

This makes the parameter list unnecessary long for a function which only
get called twice.

This patch will refactor the parameter list, by using
btrfs_file_extent_item as parameter directly to hugely reduce the number
of parameters.

Also, since there are only two callers, one in btrfs_finish_ordered_io()
which inserts file extent for ordered extent, and one
__btrfs_prealloc_file_range().

These two call sites have completely different context, where ordered
extent can be compressed, but will always be regular extent, while the
preallocated one is never going to be compressed and always has PREALLOC
type.

So use two small wrapper for these two different call sites to improve
readability.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  6 +++-
 fs/btrfs/inode.c | 94 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 161533040978..23f7e9d67bdb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2231,7 +2231,8 @@ static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
 }
 
 /* struct btrfs_file_extent_item */
-BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
+			 type, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_bytenr,
 			 struct btrfs_file_extent_item, disk_bytenr, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_offset,
@@ -2240,6 +2241,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_file_extent_generation,
 			 struct btrfs_file_extent_item, generation, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_num_bytes,
 			 struct btrfs_file_extent_item, num_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_file_extent_ram_bytes,
+			 struct btrfs_file_extent_item, ram_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_disk_num_bytes,
 			 struct btrfs_file_extent_item, disk_num_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_compression,
@@ -2256,6 +2259,7 @@ static inline u32 btrfs_file_extent_calc_inline_size(u32 datasize)
 	return BTRFS_FILE_EXTENT_INLINE_DATA_START + datasize;
 }
 
+BTRFS_SETGET_FUNCS(file_extent_type, struct btrfs_file_extent_item, type, 8);
 BTRFS_SETGET_FUNCS(file_extent_disk_bytenr, struct btrfs_file_extent_item,
 		   disk_bytenr, 64);
 BTRFS_SETGET_FUNCS(file_extent_generation, struct btrfs_file_extent_item,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1242d0aa108d..c076cbe9f492 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2449,16 +2449,16 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct inode *inode, u64 file_pos,
-				       u64 disk_bytenr, u64 disk_num_bytes,
-				       u64 num_bytes, u64 ram_bytes,
-				       u8 compression, u8 encryption,
-				       u16 other_encoding, int extent_type)
+				       struct btrfs_file_extent_item *stack_fi)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_file_extent_item *fi;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_key ins;
+	u64 disk_num_bytes = btrfs_stack_file_extent_disk_num_bytes(stack_fi);
+	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
+	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
+	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
 	u64 qg_released;
 	int extent_inserted = 0;
 	int ret;
@@ -2478,7 +2478,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 */
 	ret = __btrfs_drop_extents(trans, root, inode, path, file_pos,
 				   file_pos + num_bytes, NULL, 0,
-				   1, sizeof(*fi), &extent_inserted);
+				   1, sizeof(*stack_fi), &extent_inserted);
 	if (ret)
 		goto out;
 
@@ -2489,23 +2489,15 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 
 		path->leave_spinning = 1;
 		ret = btrfs_insert_empty_item(trans, root, path, &ins,
-					      sizeof(*fi));
+					      sizeof(*stack_fi));
 		if (ret)
 			goto out;
 	}
 	leaf = path->nodes[0];
-	fi = btrfs_item_ptr(leaf, path->slots[0],
-			    struct btrfs_file_extent_item);
-	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-	btrfs_set_file_extent_type(leaf, fi, extent_type);
-	btrfs_set_file_extent_disk_bytenr(leaf, fi, disk_bytenr);
-	btrfs_set_file_extent_disk_num_bytes(leaf, fi, disk_num_bytes);
-	btrfs_set_file_extent_offset(leaf, fi, 0);
-	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
-	btrfs_set_file_extent_ram_bytes(leaf, fi, ram_bytes);
-	btrfs_set_file_extent_compression(leaf, fi, compression);
-	btrfs_set_file_extent_encryption(leaf, fi, encryption);
-	btrfs_set_file_extent_other_encoding(leaf, fi, other_encoding);
+	btrfs_set_stack_file_extent_generation(stack_fi, trans->transid);
+	write_extent_buffer(leaf, stack_fi,
+			btrfs_item_ptr_offset(leaf, path->slots[0]),
+			sizeof(struct btrfs_file_extent_item));
 
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
@@ -2553,7 +2545,33 @@ static void btrfs_release_delalloc_bytes(struct btrfs_fs_info *fs_info,
 	btrfs_put_block_group(cache);
 }
 
-/* as ordered data IO finishes, this gets called so we can finish
+static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
+					     struct inode *inode,
+					     struct btrfs_ordered_extent *oe)
+{
+	struct btrfs_file_extent_item stack_fi;
+	u64 logical_len;
+
+	memset(&stack_fi, 0, sizeof(stack_fi));
+	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
+	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->disk_bytenr);
+	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
+						   oe->disk_num_bytes);
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
+		logical_len = oe->truncated_len;
+	else
+		logical_len = oe->num_bytes;
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, logical_len);
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, logical_len);
+	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
+	/* Encryption and other encoding is reserved and all 0 */
+
+	return insert_reserved_file_extent(trans, inode, oe->file_offset,
+					   &stack_fi);
+}
+
+/*
+ * As ordered data IO finishes, this gets called so we can finish
  * an ordered extent if the range of bytes in the file it covers are
  * fully written.
  */
@@ -2655,12 +2673,8 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						logical_len);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
-		ret = insert_reserved_file_extent(trans, inode, start,
-						ordered_extent->disk_bytenr,
-						ordered_extent->disk_num_bytes,
-						logical_len, logical_len,
-						compress_type, 0, 0,
-						BTRFS_FILE_EXTENT_REG);
+		ret = insert_ordered_extent_file_extent(trans, inode,
+							ordered_extent);
 		if (!ret) {
 			clear_reserved_extent = false;
 			btrfs_release_delalloc_bytes(fs_info,
@@ -9487,6 +9501,27 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
+static int insert_prealloc_file_extent(struct btrfs_trans_handle *trans,
+				       struct inode *inode, struct btrfs_key *ins,
+				       u64 file_offset)
+{
+	struct btrfs_file_extent_item stack_fi;
+	u64 start = ins->objectid;
+	u64 len = ins->offset;
+
+	memset(&stack_fi, 0, sizeof(stack_fi));
+
+	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_PREALLOC);
+	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, start);
+	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi, len);
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, len);
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
+	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
+	/* Encryption and other encoding is reserved and all 0 */
+
+	return insert_reserved_file_extent(trans, inode, file_offset,
+					   &stack_fi);
+}
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				       u64 start, u64 num_bytes, u64 min_size,
 				       loff_t actual_len, u64 *alloc_hint,
@@ -9545,11 +9580,8 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
 		last_alloc = ins.offset;
-		ret = insert_reserved_file_extent(trans, inode,
-						  cur_offset, ins.objectid,
-						  ins.offset, ins.offset,
-						  ins.offset, 0, 0, 0,
-						  BTRFS_FILE_EXTENT_PREALLOC);
+		ret = insert_prealloc_file_extent(trans, inode, &ins,
+						  cur_offset);
 		if (ret) {
 			btrfs_free_reserved_extent(fs_info, ins.objectid,
 						   ins.offset, 0);
-- 
2.26.2

