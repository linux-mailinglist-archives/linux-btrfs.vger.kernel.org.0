Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68029EE3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgJ2O33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbgJ2O32 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cUDj6EMF4MFpmbkR6yO+rknzo+6fBLbG/JptFz21Bc=;
        b=L37q6pkBNmSpFBvhQIxfLF2QvNrbIIlJtgy5U7O3W010bxG3MEqCHjZRGkHEjueYIZg5yA
        DGisZcjnQVbWlWmeb05+p1STrd5jxtGRaywwXy3oPf63XjnBaCgqUAJ0GwnBCRJFwKUuGt
        LQt5xRI9p/OtdAlbdbE3JoYhCYioto8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B65C9AFB7;
        Thu, 29 Oct 2020 14:29:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C9C6CDA7CE; Thu, 29 Oct 2020 15:27:51 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/10] btrfs: switch cached fs_info::csum_size from u16 to u32
Date:   Thu, 29 Oct 2020 15:27:51 +0100
Message-Id: <f72d6975de2da6fa325c47567de2d3dadf382a45.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fs_info value is 32bit, switch also the local u16 variables. This
leads to a better assembly code generated due to movzwl.

This simple change will shave some bytes on x86_64 and release config:

   text    data     bss     dec     hex filename
1090000   17980   14912 1122892  11224c pre/btrfs.ko
1089794   17980   14912 1122686  11217e post/btrfs.ko

DELTA: -206

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h  |  2 +-
 fs/btrfs/compression.c  |  7 +++----
 fs/btrfs/disk-io.c      |  2 +-
 fs/btrfs/extent_io.c    |  2 +-
 fs/btrfs/file-item.c    | 14 +++++++-------
 fs/btrfs/inode.c        |  5 ++---
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/ordered-data.h |  2 +-
 fs/btrfs/tree-checker.c |  2 +-
 9 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index f1c9cbd0d184..7294fae801c9 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -341,7 +341,7 @@ static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
 		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
 {
 	struct btrfs_root *root = inode->root;
-	const u16 csum_size = root->fs_info->csum_size;
+	const u32 csum_size = root->fs_info->csum_size;
 
 	/* Output minus objectid, which is more meaningful */
 	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 00bbd859f31b..b2bb4681975e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -131,8 +131,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb);
 static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
 				      unsigned long disk_size)
 {
-	const u16 csum_size = fs_info->csum_size;
-
+	const u32 csum_size = fs_info->csum_size;
 	return sizeof(struct compressed_bio) +
 		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * csum_size;
 }
@@ -142,7 +141,7 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	struct page *page;
 	unsigned long i;
 	char *kaddr;
@@ -628,7 +627,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct extent_map *em;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int faili = 0;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e22e8de31c07..aa89d5c15f6e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -452,7 +452,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 	u64 start = page_offset(page);
 	u64 found_start;
 	u8 result[BTRFS_CSUM_SIZE];
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	struct extent_buffer *eb;
 	int ret;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e943fff35608..6ff67d57d088 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2685,7 +2685,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	repair_bio->bi_private = failed_bio->bi_private;
 
 	if (failed_io_bio->csum) {
-		const u16 csum_size = fs_info->csum_size;
+		const u32 csum_size = fs_info->csum_size;
 
 		repair_io_bio->csum = repair_io_bio->csum_inline;
 		memcpy(repair_io_bio->csum,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a4a68a224342..d7fdfd6ea6f4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -181,7 +181,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 	struct btrfs_csum_item *item;
 	struct extent_buffer *leaf;
 	u64 csum_offset = 0;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	int csums_in_item;
 
 	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
@@ -270,7 +270,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	u32 diff;
 	int nblocks;
 	int count = 0;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 
 	if (!fs_info->csum_root || (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
 		return BLK_STS_OK;
@@ -409,7 +409,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	int ret;
 	size_t size;
 	u64 csum_end;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(end + 1, fs_info->sectorsize));
@@ -541,7 +541,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	int i;
 	u64 offset;
 	unsigned nofs_flag;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 
 	nofs_flag = memalloc_nofs_save();
 	sums = kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
@@ -639,7 +639,7 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 				       u64 bytenr, u64 len)
 {
 	struct extent_buffer *leaf;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
@@ -693,7 +693,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	u64 csum_end;
 	struct extent_buffer *leaf;
 	int ret;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
 
 	ASSERT(root == fs_info->csum_root ||
@@ -848,7 +848,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	int index = 0;
 	int found_next;
 	int ret;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 549dca610f8c..6a3a0e1cbf1c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2796,7 +2796,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
@@ -7763,11 +7763,10 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	dip_size = sizeof(*dip);
 	if (!write && csum) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u16 csum_size = fs_info->csum_size;
 		size_t nblocks;
 
 		nblocks = dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
-		dip_size += csum_size * nblocks;
+		dip_size += fs_info->csum_size * nblocks;
 	}
 
 	dip = kzalloc(dip_size, GFP_NOFS);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4d612105b991..8bb97168afa0 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -868,7 +868,7 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 	int index = 0;
 
 	ordered = btrfs_lookup_ordered_extent(inode, offset);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4662fd8ca546..e48810104e4a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -137,7 +137,7 @@ static inline int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info,
 					 unsigned long bytes)
 {
 	int num_sectors = (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
-	const u16 csum_size = fs_info->csum_size;
+	const u32 csum_size = fs_info->csum_size;
 
 	return sizeof(struct btrfs_ordered_sum) + num_sectors * csum_size;
 }
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 5efaf1f811e2..f047640c1b42 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -336,7 +336,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	u32 sectorsize = fs_info->sectorsize;
-	const u16 csumsize = fs_info->csum_size;
+	const u32 csumsize = fs_info->csum_size;
 
 	if (key->objectid != BTRFS_EXTENT_CSUM_OBJECTID) {
 		generic_err(leaf, slot,
-- 
2.25.0

