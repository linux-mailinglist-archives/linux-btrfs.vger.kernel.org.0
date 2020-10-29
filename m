Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBA29EE36
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgJ2O3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgJ2O3P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1EE8OLLbFwaL9a7B1doUvUxWFa15AtRUrNzut4G/u8=;
        b=GHATZ5jYNkSabx+jZL0Od4vNHK67MC/Kj4b1zdLcjwDBBi5D3dAfKeloZU3xrelqlWdjxu
        6mS4FxJ/1dCtCmccDxwrq0s2pFZmLe+SDPwBLw3ubrEgexdp0qxAAaFtSqpbUfOqU+9xNn
        SxjDAso8CGW9e2Ub+wZmeuEl2O54UTM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C693AB03D;
        Thu, 29 Oct 2020 14:29:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF10BDA7CE; Thu, 29 Oct 2020 15:27:37 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/10] btrfs: use precalculated sectorsize_bits from fs_info
Date:   Thu, 29 Oct 2020 15:27:37 +0100
Message-Id: <b38721840b8d703a29807b71460464134b9ca7e1.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do a lot of calculations where we divide or multiply by sectorsize.
We also know and make sure that sectorsize is a power of two, so this
means all divisions can be turned to shifts and avoid eg. expensive
u64/u32 divisions.

The type is u32 as it's more register friendly on x86_64 compared to u8
and the resulting assembly is smaller (movzbl vs movl).

There's also superblock s_blocksize_bits but it's usually one more
pointer dereference farther than fs_info.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h           |  1 +
 fs/btrfs/disk-io.c         |  2 ++
 fs/btrfs/extent-tree.c     |  2 +-
 fs/btrfs/file-item.c       | 11 ++++++-----
 fs/btrfs/free-space-tree.c | 12 +++++++-----
 fs/btrfs/ordered-data.c    |  3 +--
 fs/btrfs/scrub.c           | 12 ++++++------
 fs/btrfs/tree-checker.c    |  3 ++-
 8 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a83bce3225c..87c40cc5c42e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -931,6 +931,7 @@ struct btrfs_fs_info {
 	/* Cached block sizes */
 	u32 nodesize;
 	u32 sectorsize;
+	u32 sectorsize_bits;
 	u32 stripesize;
 
 	/* Block groups and devices containing active swapfiles. */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 601a7ab2adb4..4e67c122389c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2812,6 +2812,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	/* Usable values until the real ones are cached from the superblock */
 	fs_info->nodesize = 4096;
 	fs_info->sectorsize = 4096;
+	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
 	spin_lock_init(&fs_info->swapfile_pins_lock);
@@ -3076,6 +3077,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/* Cache block sizes */
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
+	fs_info->sectorsize_bits = ilog2(sectorsize);
 	fs_info->stripesize = stripesize;
 
 	/*
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5fd60b13f4f8..29ac97248942 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2145,7 +2145,7 @@ u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes)
 	csum_size = BTRFS_MAX_ITEM_SIZE(fs_info);
 	num_csums_per_leaf = div64_u64(csum_size,
 			(u64)btrfs_super_csum_size(fs_info->super_copy));
-	num_csums = div64_u64(csum_bytes, fs_info->sectorsize);
+	num_csums = csum_bytes >> fs_info->sectorsize_bits;
 	num_csums += num_csums_per_leaf - 1;
 	num_csums = div64_u64(num_csums, num_csums_per_leaf);
 	return num_csums;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 816f57d52fc9..d8cd467b4e0c 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -119,7 +119,7 @@ static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
 {
 	u32 ncsums = (PAGE_SIZE - sizeof(struct btrfs_ordered_sum)) / csum_size;
 
-	return ncsums * fs_info->sectorsize;
+	return ncsums << fs_info->sectorsize_bits;
 }
 
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
@@ -369,7 +369,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		 * a single leaf so it will also fit inside a u32
 		 */
 		diff = disk_bytenr - item_start_offset;
-		diff = diff / fs_info->sectorsize;
+		diff = diff >> fs_info->sectorsize_bits;
 		diff = diff * csum_size;
 		count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
 					    inode->i_sb->s_blocksize_bits);
@@ -465,7 +465,8 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			start = key.offset;
 
 		size = btrfs_item_size_nr(leaf, path->slots[0]);
-		csum_end = key.offset + (size / csum_size) * fs_info->sectorsize;
+		csum_end = key.offset +
+			   ((size / csum_size) >> fs_info->sectorsize_bits);
 		if (csum_end <= start) {
 			path->slots[0]++;
 			continue;
@@ -606,7 +607,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 
 			data = kmap_atomic(bvec.bv_page);
 			crypto_shash_digest(shash, data + bvec.bv_offset
-					    + (i * fs_info->sectorsize),
+					    + (i << fs_info->sectorsize_bits),
 					    fs_info->sectorsize,
 					    sums->sums + index);
 			kunmap_atomic(data);
@@ -1020,7 +1021,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 
 	index += ins_size;
 	ins_size /= csum_size;
-	total_bytes += ins_size * fs_info->sectorsize;
+	total_bytes += ins_size << fs_info->sectorsize_bits;
 
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	if (total_bytes < sums->len) {
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6b9faf3b0e96..f09f62e245a0 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -416,16 +416,18 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	nrbits = div_u64(block_group->length, block_group->fs_info->sectorsize);
+	nrbits = block_group->length >> block_group->fs_info->sectorsize_bits;
 	start_bit = find_next_bit_le(bitmap, nrbits, 0);
 
 	while (start_bit < nrbits) {
 		end_bit = find_next_zero_bit_le(bitmap, nrbits, start_bit);
 		ASSERT(start_bit < end_bit);
 
-		key.objectid = start + start_bit * block_group->fs_info->sectorsize;
+		key.objectid = start +
+			       (start_bit << block_group->fs_info->sectorsize_bits);
 		key.type = BTRFS_FREE_SPACE_EXTENT_KEY;
-		key.offset = (end_bit - start_bit) * block_group->fs_info->sectorsize;
+		key.offset = (end_bit - start_bit) <<
+					block_group->fs_info->sectorsize_bits;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 		if (ret)
@@ -540,8 +542,8 @@ static void free_space_set_bits(struct btrfs_block_group *block_group,
 		end = found_end;
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	first = div_u64(*start - found_start, fs_info->sectorsize);
-	last = div_u64(end - found_start, fs_info->sectorsize);
+	first = (*start - found_start) >> fs_info->sectorsize_bits;
+	last = (end - found_start) >> fs_info->sectorsize_bits;
 	if (bit)
 		extent_buffer_bitmap_set(leaf, ptr, first, last - first);
 	else
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 87bac9ecdf4c..7b62dcc6cd98 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -868,7 +868,6 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
-	u32 sectorsize = btrfs_inode_sectorsize(inode);
 	const u8 blocksize_bits = inode->vfs_inode.i_sb->s_blocksize_bits;
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int index = 0;
@@ -890,7 +889,7 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 			index += (int)num_sectors * csum_size;
 			if (index == len)
 				goto out;
-			disk_bytenr += num_sectors * sectorsize;
+			disk_bytenr += num_sectors << fs_info->sectorsize_bits;
 		}
 	}
 out:
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 54a4f34d4c1c..7babf670c8c2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2300,7 +2300,7 @@ static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
 	u64 offset;
 	u64 nsectors64;
 	u32 nsectors;
-	int sectorsize = sparity->sctx->fs_info->sectorsize;
+	u32 sectorsize_bits = sparity->sctx->fs_info->sectorsize_bits;
 
 	if (len >= sparity->stripe_len) {
 		bitmap_set(bitmap, 0, sparity->nsectors);
@@ -2309,8 +2309,8 @@ static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
 
 	start -= sparity->logic_start;
 	start = div64_u64_rem(start, sparity->stripe_len, &offset);
-	offset = div_u64(offset, sectorsize);
-	nsectors64 = div_u64(len, sectorsize);
+	offset = offset >> sectorsize_bits;
+	nsectors64 = len >> sectorsize_bits;
 
 	ASSERT(nsectors64 < UINT_MAX);
 	nsectors = (u32)nsectors64;
@@ -2386,10 +2386,10 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	if (!sum)
 		return 0;
 
-	index = div_u64(logical - sum->bytenr, sctx->fs_info->sectorsize);
+	index = (logical - sum->bytenr) >> sctx->fs_info->sectorsize_bits;
 	ASSERT(index < UINT_MAX);
 
-	num_sectors = sum->len / sctx->fs_info->sectorsize;
+	num_sectors = sum->len >> sctx->fs_info->sectorsize_bits;
 	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
 	if (index == num_sectors - 1) {
 		list_del(&sum->list);
@@ -2776,7 +2776,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	int extent_mirror_num;
 	int stop_loop = 0;
 
-	nsectors = div_u64(map->stripe_len, fs_info->sectorsize);
+	nsectors = map->stripe_len >> fs_info->sectorsize_bits;
 	bitmap_len = scrub_calc_parity_bitmap_len(nsectors);
 	sparity = kzalloc(sizeof(struct scrub_parity) + 2 * bitmap_len,
 			  GFP_NOFS);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8784b74f5232..c0e19917e59b 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -361,7 +361,8 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 		u32 prev_item_size;
 
 		prev_item_size = btrfs_item_size_nr(leaf, slot - 1);
-		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
+		prev_csum_end = (prev_item_size / csumsize);
+		prev_csum_end <<= fs_info->sectorsize_bits;
 		prev_csum_end += prev_key->offset;
 		if (prev_csum_end > key->offset) {
 			generic_err(leaf, slot - 1,
-- 
2.25.0

