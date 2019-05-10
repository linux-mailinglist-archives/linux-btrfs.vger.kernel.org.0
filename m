Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36DE19C4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfEJLP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727251AbfEJLPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3763BAF8F
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 05/17] btrfs: don't assume ordered sums to be 4 bytes
Date:   Fri, 10 May 2019 13:15:35 +0200
Message-Id: <20190510111547.15310-6-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS has the implicit assumption that a checksum in btrfs_orderd_sums is 4
bytes. While this is true for CRC32C, it is not for any other checksum.

Change the data type to be a byte array and adjust loop index calculation
accordingly.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/compression.c  |  4 ++--
 fs/btrfs/ctree.h        |  3 ++-
 fs/btrfs/file-item.c    | 28 +++++++++++++++-------------
 fs/btrfs/ordered-data.c | 10 ++++++----
 fs/btrfs/ordered-data.h |  4 ++--
 fs/btrfs/scrub.c        |  2 +-
 6 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4ec1df369e47..98d8c2ed367f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -632,7 +632,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 				ret = btrfs_lookup_bio_sums(inode, comp_bio,
-							    sums);
+							    (u8 *)sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
@@ -658,7 +658,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
+		ret = btrfs_lookup_bio_sums(inode, comp_bio, (u8 *) sums);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a2a377f1640..e62934fb8748 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3184,7 +3184,8 @@ int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
 struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u32 *dst);
+blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
+				   u8 *dst);
 blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
 			      u64 logical_offset);
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d431ea8198e4..210ff69917a0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -22,9 +22,9 @@
 #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
 				       PAGE_SIZE))
 
-#define MAX_ORDERED_SUM_BYTES(fs_info) ((PAGE_SIZE - \
+#define MAX_ORDERED_SUM_BYTES(fs_info, csum_size) ((PAGE_SIZE - \
 				   sizeof(struct btrfs_ordered_sum)) / \
-				   sizeof(u32) * (fs_info)->sectorsize)
+				   (csum_size) * (fs_info)->sectorsize)
 
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
@@ -144,7 +144,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 }
 
 static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 logical_offset, u32 *dst, int dio)
+				   u64 logical_offset, u8 *dst, int dio)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
@@ -211,7 +211,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 		if (!dio)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
-					       (u32 *)csum, nblocks);
+					       csum, nblocks);
 		if (count)
 			goto found;
 
@@ -283,7 +283,8 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	return 0;
 }
 
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u32 *dst)
+blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
+				   u8 *dst)
 {
 	return __btrfs_lookup_bio_sums(inode, bio, 0, dst, 0);
 }
@@ -374,7 +375,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 				      struct btrfs_csum_item);
 		while (start < csum_end) {
 			size = min_t(size_t, csum_end - start,
-				     MAX_ORDERED_SUM_BYTES(fs_info));
+				     MAX_ORDERED_SUM_BYTES(fs_info, csum_size));
 			sums = kzalloc(btrfs_ordered_sum_size(fs_info, size),
 				       GFP_NOFS);
 			if (!sums) {
@@ -439,6 +440,7 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 	int i;
 	u64 offset;
 	unsigned nofs_flag;
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
 	nofs_flag = memalloc_nofs_save();
 	sums = kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
@@ -473,6 +475,7 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 						 - 1);
 
 		for (i = 0; i < nr_sectors; i++) {
+			u32 tmp;
 			if (offset >= ordered->file_offset + ordered->len ||
 				offset < ordered->file_offset) {
 				unsigned long bytes_left;
@@ -498,17 +501,16 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 				index = 0;
 			}
 
-			sums->sums[index] = ~(u32)0;
+			memset(&sums->sums[index], 0xff, csum_size);
 			data = kmap_atomic(bvec.bv_page);
-			sums->sums[index]
-				= btrfs_csum_data(data + bvec.bv_offset
+			tmp = btrfs_csum_data(data + bvec.bv_offset
 						+ (i * fs_info->sectorsize),
-						sums->sums[index],
+						*(u32 *)&sums->sums[index],
 						fs_info->sectorsize);
 			kunmap_atomic(data);
-			btrfs_csum_final(sums->sums[index],
+			btrfs_csum_final(tmp,
 					(char *)(sums->sums + index));
-			index++;
+			index += csum_size;
 			offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
 			total_bytes += fs_info->sectorsize;
@@ -904,9 +906,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, sums->sums + index, (unsigned long)item,
 			    ins_size);
 
+	index += ins_size;
 	ins_size /= csum_size;
 	total_bytes += ins_size * fs_info->sectorsize;
-	index += ins_size;
 
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	if (total_bytes < sums->len) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 52889da69113..6f7a18148dcb 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -924,14 +924,16 @@ int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
  * be reclaimed before their checksum is actually put into the btree
  */
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u32 *sum, int len)
+			   u8 *sum, int len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ordered_sum *ordered_sum;
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
 	u32 sectorsize = btrfs_inode_sectorsize(inode);
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int index = 0;
 
 	ordered = btrfs_lookup_ordered_extent(inode, offset);
@@ -947,10 +949,10 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 			num_sectors = ordered_sum->len >>
 				      inode->i_sb->s_blocksize_bits;
 			num_sectors = min_t(int, len - index, num_sectors - i);
-			memcpy(sum + index, ordered_sum->sums + i,
-			       num_sectors);
+			memcpy(sum + index, ordered_sum->sums + i * csum_size,
+			       num_sectors * csum_size);
 
-			index += (int)num_sectors;
+			index += (int)num_sectors * csum_size;
 			if (index == len)
 				goto out;
 			disk_bytenr += num_sectors * sectorsize;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4c5991c3de14..9a9884966343 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -23,7 +23,7 @@ struct btrfs_ordered_sum {
 	int len;
 	struct list_head list;
 	/* last field is a variable length array of csums */
-	u32 sums[];
+	u8 sums[];
 };
 
 /*
@@ -183,7 +183,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
 				struct btrfs_ordered_extent *ordered);
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-			   u32 *sum, int len);
+			   u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 			       const u64 range_start, const u64 range_len);
 u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7b29f9db5e2..2cf3cf9e9c9b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2448,7 +2448,7 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	ASSERT(index < UINT_MAX);
 
 	num_sectors = sum->len / sctx->fs_info->sectorsize;
-	memcpy(csum, sum->sums + index, sctx->csum_size);
+	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
 	if (index == num_sectors - 1) {
 		list_del(&sum->list);
 		kfree(sum);
-- 
2.16.4

