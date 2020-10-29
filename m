Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B491829EE38
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgJ2O3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgJ2O3U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/YmTN7ZNpgI9Bky6jU+dQaxUMRIDlE1EmYSmeMixbk=;
        b=Yp4JQdohm1bTMn6saT/FyNNFCG5OkZHjtIpoXuQfswO6sLdYXys/8Pj1TUiBY3rCJwZZUA
        UQZSa+4MEs61fnxMN6oLgAMV5qdnqKrc0lOJRf+EWEb8WzGqQfqTA3r73JJYz/1TN/SUq4
        jp5ZZ+CmOa/47qIdn9eznhjnlXILouw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88D6EB03A;
        Thu, 29 Oct 2020 14:29:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 81B68DA7CE; Thu, 29 Oct 2020 15:27:42 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/10] btrfs: replace s_blocksize_bits with fs_info::sectorsize_bits
Date:   Thu, 29 Oct 2020 15:27:42 +0100
Message-Id: <1021ce9995a25cca9dbfeb49ba298aaff53f0986.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The value of super_block::s_blocksize_bits is the same as
fs_info::sectorsize_bits, but we don't need to do the extra dereferences
in many functions and storing the bits as u32 (in fs_info) generates
shorter assembly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h        |  2 +-
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/file-item.c    | 34 +++++++++++++++-------------------
 fs/btrfs/file.c         |  3 +--
 fs/btrfs/inode.c        |  6 +++---
 fs/btrfs/ordered-data.c |  6 +++---
 fs/btrfs/super.c        |  2 +-
 7 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 87c40cc5c42e..a1a0b99c3530 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1405,7 +1405,7 @@ struct btrfs_map_token {
 };
 
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
-				((bytes) >> (fs_info)->sb->s_blocksize_bits)
+				((bytes) >> (fs_info)->sectorsize_bits)
 
 static inline void btrfs_init_map_token(struct btrfs_map_token *token,
 					struct extent_buffer *eb)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 14d01b76f5c9..cd27a2a4f717 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2652,7 +2652,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
-	const int icsum = phy_offset >> inode->i_sb->s_blocksize_bits;
+	const int icsum = phy_offset >> fs_info->sectorsize_bits;
 	bool need_validation;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d8cd467b4e0c..ed750dd8a115 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -201,7 +201,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 			goto fail;
 
 		csum_offset = (bytenr - found_key.offset) >>
-				fs_info->sb->s_blocksize_bits;
+				fs_info->sectorsize_bits;
 		csums_in_item = btrfs_item_size_nr(leaf, path->slots[0]);
 		csums_in_item /= csum_size;
 
@@ -279,7 +279,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	if (!path)
 		return BLK_STS_RESOURCE;
 
-	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
+	nblocks = bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
 	if (!dst) {
 		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
 
@@ -372,7 +372,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		diff = diff >> fs_info->sectorsize_bits;
 		diff = diff * csum_size;
 		count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
-					    inode->i_sb->s_blocksize_bits);
+					    fs_info->sectorsize_bits);
 		read_extent_buffer(path->nodes[0], csum,
 				   ((unsigned long)item) + diff,
 				   csum_size * count);
@@ -436,8 +436,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0] - 1);
 		if (key.objectid == BTRFS_EXTENT_CSUM_OBJECTID &&
 		    key.type == BTRFS_EXTENT_CSUM_KEY) {
-			offset = (start - key.offset) >>
-				 fs_info->sb->s_blocksize_bits;
+			offset = (start - key.offset) >> fs_info->sectorsize_bits;
 			if (offset * csum_size <
 			    btrfs_item_size_nr(leaf, path->slots[0] - 1))
 				path->slots[0]--;
@@ -488,10 +487,9 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			sums->bytenr = start;
 			sums->len = (int)size;
 
-			offset = (start - key.offset) >>
-				fs_info->sb->s_blocksize_bits;
+			offset = (start - key.offset) >> fs_info->sectorsize_bits;
 			offset *= csum_size;
-			size >>= fs_info->sb->s_blocksize_bits;
+			size >>= fs_info->sectorsize_bits;
 
 			read_extent_buffer(path->nodes[0],
 					   sums->sums,
@@ -644,11 +642,11 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
-	u32 blocksize_bits = fs_info->sb->s_blocksize_bits;
+	u32 blocksize_bits = fs_info->sectorsize_bits;
 
 	leaf = path->nodes[0];
 	csum_end = btrfs_item_size_nr(leaf, path->slots[0]) / csum_size;
-	csum_end <<= fs_info->sb->s_blocksize_bits;
+	csum_end <<= blocksize_bits;
 	csum_end += key->offset;
 
 	if (key->offset < bytenr && csum_end <= end_byte) {
@@ -696,7 +694,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int ret;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
-	int blocksize_bits = fs_info->sb->s_blocksize_bits;
+	u32 blocksize_bits = fs_info->sectorsize_bits;
 
 	ASSERT(root == fs_info->csum_root ||
 	       root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
@@ -925,7 +923,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	if (btrfs_leaf_free_space(leaf) >= csum_size) {
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		csum_offset = (bytenr - found_key.offset) >>
-			fs_info->sb->s_blocksize_bits;
+			fs_info->sectorsize_bits;
 		goto extend_csum;
 	}
 
@@ -943,8 +941,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-	csum_offset = (bytenr - found_key.offset) >>
-			fs_info->sb->s_blocksize_bits;
+	csum_offset = (bytenr - found_key.offset) >> fs_info->sectorsize_bits;
 
 	if (found_key.type != BTRFS_EXTENT_CSUM_KEY ||
 	    found_key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
@@ -960,7 +957,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		u32 diff;
 
 		tmp = sums->len - total_bytes;
-		tmp >>= fs_info->sb->s_blocksize_bits;
+		tmp >>= fs_info->sectorsize_bits;
 		WARN_ON(tmp < 1);
 
 		extend_nr = max_t(int, 1, (int)tmp);
@@ -985,9 +982,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 		u64 tmp;
 
 		tmp = sums->len - total_bytes;
-		tmp >>= fs_info->sb->s_blocksize_bits;
+		tmp >>= fs_info->sectorsize_bits;
 		tmp = min(tmp, (next_offset - file_key.offset) >>
-					 fs_info->sb->s_blocksize_bits);
+					 fs_info->sectorsize_bits);
 
 		tmp = max_t(u64, 1, tmp);
 		tmp = min_t(u64, tmp, MAX_CSUM_ITEMS(fs_info, csum_size));
@@ -1011,8 +1008,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	ins_size = (u32)(sums->len - total_bytes) >>
-		   fs_info->sb->s_blocksize_bits;
+	ins_size = (u32)(sums->len - total_bytes) >> fs_info->sectorsize_bits;
 	ins_size *= csum_size;
 	ins_size = min_t(u32, (unsigned long)item_end - (unsigned long)item,
 			      ins_size);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1c97e559aefb..25dc5eb495d8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1763,8 +1763,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		if (num_sectors > dirty_sectors) {
 			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors <<
-						fs_info->sb->s_blocksize_bits;
+			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
 			if (only_release_metadata) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							release_bytes, true);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1dcccd212809..5582c1c9c007 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2854,7 +2854,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		return 0;
 	}
 
-	phy_offset >>= inode->i_sb->s_blocksize_bits;
+	phy_offset >>= root->fs_info->sectorsize_bits;
 	return check_data_csum(inode, io_bio, phy_offset, page, offset, start,
 			       (size_t)(end - start + 1));
 }
@@ -7737,7 +7737,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		u64 csum_offset;
 
 		csum_offset = file_offset - dip->logical_offset;
-		csum_offset >>= inode->i_sb->s_blocksize_bits;
+		csum_offset >>= fs_info->sectorsize_bits;
 		csum_offset *= btrfs_super_csum_size(fs_info->super_copy);
 		btrfs_io_bio(bio)->csum = dip->csums + csum_offset;
 	}
@@ -7766,7 +7766,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 		const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 		size_t nblocks;
 
-		nblocks = dio_bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
+		nblocks = dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
 		dip_size += csum_size * nblocks;
 	}
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 7b62dcc6cd98..ecc731a6bbae 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -868,7 +868,6 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
-	const u8 blocksize_bits = inode->vfs_inode.i_sb->s_blocksize_bits;
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int index = 0;
 
@@ -880,8 +879,9 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 	list_for_each_entry_reverse(ordered_sum, &ordered->list, list) {
 		if (disk_bytenr >= ordered_sum->bytenr &&
 		    disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
-			i = (disk_bytenr - ordered_sum->bytenr) >> blocksize_bits;
-			num_sectors = ordered_sum->len >> blocksize_bits;
+			i = (disk_bytenr - ordered_sum->bytenr) >>
+			    fs_info->sectorsize_bits;
+			num_sectors = ordered_sum->len >> fs_info->sectorsize_bits;
 			num_sectors = min_t(int, len - index, num_sectors - i);
 			memcpy(sum + index, ordered_sum->sums + i * csum_size,
 			       num_sectors * csum_size);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1ffa50bae1dd..87b390a5351f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2205,7 +2205,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 total_used = 0;
 	u64 total_free_data = 0;
 	u64 total_free_meta = 0;
-	int bits = dentry->d_sb->s_blocksize_bits;
+	u32 bits = fs_info->sectorsize_bits;
 	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
-- 
2.25.0

