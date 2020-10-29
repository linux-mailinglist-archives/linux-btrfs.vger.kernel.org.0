Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2037A29EE3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgJ2O32 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgJ2O31 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFSqd+9nSxIHeqEnyl2a0ttrM6vSw9oO/9lbs5ssEaU=;
        b=MY5oNMiJ46I+4RFoY21wsgtNVTirWVsxg64Mf5q18DlGlweropizjtFRM6/FuzBjGrGEv+
        gTuZ5qNHWEmUg4+uC31ip0dZhC+pKV4hgUZ6JPVVudtLWSBCMfOWjbHcBbIcY0RFrE+E6S
        nF1x6Pnq/8ZkgD7P+s04mqXEAGjbE9M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8C6FACA3;
        Thu, 29 Oct 2020 14:29:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EA15DA7CE; Thu, 29 Oct 2020 15:27:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/10] btrfs: use cached value of fs_info::csum_size everywhere
Date:   Thu, 29 Oct 2020 15:27:49 +0100
Message-Id: <cc7bf45e56b81cb2f947adfd83509c9f0a0f32f4.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_get_16 shows up in the system performance profiles (helper to read
16bit values from on-disk structures). This is partially because of the
checksum size that's frequently read along with data reads/writes, other
u16 uses are from item size or directory entries.

Replace all calls to btrfs_super_csum_size by the cached value from
fs_info.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h     |  3 +--
 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/compression.c     |  6 +++---
 fs/btrfs/disk-io.c         |  6 +++---
 fs/btrfs/extent_io.c       |  2 +-
 fs/btrfs/file-item.c       | 14 +++++++-------
 fs/btrfs/inode.c           |  6 +++---
 fs/btrfs/ordered-data.c    |  2 +-
 fs/btrfs/ordered-data.h    |  2 +-
 fs/btrfs/scrub.c           |  2 +-
 fs/btrfs/tree-checker.c    |  2 +-
 11 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 92dd86bceae3..f1c9cbd0d184 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -341,8 +341,7 @@ static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
 		u64 logical_start, u8 *csum, u8 *csum_expected, int mirror_num)
 {
 	struct btrfs_root *root = inode->root;
-	struct btrfs_super_block *sb = root->fs_info->super_copy;
-	const u16 csum_size = btrfs_super_csum_size(sb);
+	const u16 csum_size = root->fs_info->csum_size;
 
 	/* Output minus objectid, which is more meaningful */
 	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 81a8c87a5afb..2905fe5974e6 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -660,7 +660,7 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 		return -1;
 	}
 
-	state->csum_size = btrfs_super_csum_size(selected_super);
+	state->csum_size = state->fs_info->csum_size;
 
 	for (pass = 0; pass < 3; pass++) {
 		int num_copies;
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 972fb68a85ac..00bbd859f31b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -131,7 +131,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb);
 static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
 				      unsigned long disk_size)
 {
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 
 	return sizeof(struct compressed_bio) +
 		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * csum_size;
@@ -142,7 +142,7 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	struct page *page;
 	unsigned long i;
 	char *kaddr;
@@ -628,7 +628,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct extent_map *em;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int faili = 0;
-	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f870e252aa37..e22e8de31c07 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -319,7 +319,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
 			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
 
-	if (memcmp(disk_sb->csum, result, btrfs_super_csum_size(disk_sb)))
+	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
 		return 1;
 
 	return 0;
@@ -452,7 +452,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 	u64 start = page_offset(page);
 	u64 found_start;
 	u8 result[BTRFS_CSUM_SIZE];
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -541,7 +541,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
 
 	eb = (struct extent_buffer *)page->private;
 	fs_info = eb->fs_info;
-	csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	csum_size = fs_info->csum_size;
 
 	/* the pending IO might have been the only thing that kept this buffer
 	 * in memory.  Make sure we have a ref for all this other checks
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cd27a2a4f717..e943fff35608 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2685,7 +2685,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	repair_bio->bi_private = failed_bio->bi_private;
 
 	if (failed_io_bio->csum) {
-		const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+		const u16 csum_size = fs_info->csum_size;
 
 		repair_io_bio->csum = repair_io_bio->csum_inline;
 		memcpy(repair_io_bio->csum,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index ed750dd8a115..a4a68a224342 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -181,7 +181,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 	struct btrfs_csum_item *item;
 	struct extent_buffer *leaf;
 	u64 csum_offset = 0;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	int csums_in_item;
 
 	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
@@ -270,7 +270,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 	u32 diff;
 	int nblocks;
 	int count = 0;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 
 	if (!fs_info->csum_root || (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
 		return BLK_STS_OK;
@@ -409,7 +409,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 	int ret;
 	size_t size;
 	u64 csum_end;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(end + 1, fs_info->sectorsize));
@@ -541,7 +541,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	int i;
 	u64 offset;
 	unsigned nofs_flag;
-	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 
 	nofs_flag = memalloc_nofs_save();
 	sums = kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
@@ -639,7 +639,7 @@ static noinline void truncate_one_csum(struct btrfs_fs_info *fs_info,
 				       u64 bytenr, u64 len)
 {
 	struct extent_buffer *leaf;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
@@ -693,7 +693,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	u64 csum_end;
 	struct extent_buffer *leaf;
 	int ret;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
 
 	ASSERT(root == fs_info->csum_root ||
@@ -848,7 +848,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 	int index = 0;
 	int found_next;
 	int ret;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5582c1c9c007..549dca610f8c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2796,7 +2796,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
@@ -7738,7 +7738,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 
 		csum_offset = file_offset - dip->logical_offset;
 		csum_offset >>= fs_info->sectorsize_bits;
-		csum_offset *= btrfs_super_csum_size(fs_info->super_copy);
+		csum_offset *= fs_info->csum_size;
 		btrfs_io_bio(bio)->csum = dip->csums + csum_offset;
 	}
 map:
@@ -7763,7 +7763,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	dip_size = sizeof(*dip);
 	if (!write && csum) {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+		const u16 csum_size = fs_info->csum_size;
 		size_t nblocks;
 
 		nblocks = dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ecc731a6bbae..4d612105b991 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -868,7 +868,7 @@ int btrfs_find_ordered_sum(struct btrfs_inode *inode, u64 offset,
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	unsigned long num_sectors;
 	unsigned long i;
-	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 	int index = 0;
 
 	ordered = btrfs_lookup_ordered_extent(inode, offset);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c3a2325e64a4..4662fd8ca546 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -137,7 +137,7 @@ static inline int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info,
 					 unsigned long bytes)
 {
 	int num_sectors = (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
-	int csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csum_size = fs_info->csum_size;
 
 	return sizeof(struct btrfs_ordered_sum) + num_sectors * csum_size;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7babf670c8c2..d4f693a4ca38 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -610,7 +610,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	atomic_set(&sctx->bios_in_flight, 0);
 	atomic_set(&sctx->workers_pending, 0);
 	atomic_set(&sctx->cancel_req, 0);
-	sctx->csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	sctx->csum_size = fs_info->csum_size;
 
 	spin_lock_init(&sctx->list_lock);
 	spin_lock_init(&sctx->stat_lock);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c0e19917e59b..5efaf1f811e2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -336,7 +336,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	u32 sectorsize = fs_info->sectorsize;
-	u32 csumsize = btrfs_super_csum_size(fs_info->super_copy);
+	const u16 csumsize = fs_info->csum_size;
 
 	if (key->objectid != BTRFS_EXTENT_CSUM_OBJECTID) {
 		generic_err(leaf, slot,
-- 
2.25.0

