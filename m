Return-Path: <linux-btrfs+bounces-10531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556809F61F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB4E1622D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF11991A8;
	Wed, 18 Dec 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vc3mvNgk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vc3mvNgk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8991917D9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514924; cv=none; b=oySl5qNLD9AesAs2uKr0sUg9WzxI4FwtrJHZs76p3mEtpPl4dSVxvkaAYKf6Mo8vW8TCQ7MM+TMLL1V/KxZiiyG2SAP1XBzovM7wgOed3OY8Thcr1coOCj4OzbLcCIYpUg7kzUU4Tm2h1+g/IOahKEjfve4G0LARXQhyMD3Kylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514924; c=relaxed/simple;
	bh=cnWq3zO+4Smy12SKGE7gprfQZB+ueyCgBoYHYzTKxEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dy13IogHNGcQ9LDxyBGVmf2YTj+2hCVuvmQd76DjTy/W2ioZJ3FBA02DOuNRiSfh2qQzgAM+0EoAH/R2B2L0jDEwJqNZ/mCCSbB/+4tPTFP79AYVMFmPMhtInXc2CiwbMXcuJqsO2r0eXB38TLgfbiqxGufCjRZAeS8TgoCE2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vc3mvNgk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vc3mvNgk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C46AF1F449
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2DxJPQuK4eN7+6+2W0fRa3cJMm2L6smP9Xfrao1CCc=;
	b=Vc3mvNgknbDgUId/zJu+aYhexJx2Vf67cJvDE5vwEttfpRBmHATwTgT6G/x5DLsErEuPeT
	n5/13P4Qau4rYZUaUe5S0T+An/Z2dBZaI2CpCulkueTTa9Xe3kHb/lLKhihjC5IJBH15Ep
	GULR9a6LtW4oX/KfcfvhgMEZWlDMSzc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2DxJPQuK4eN7+6+2W0fRa3cJMm2L6smP9Xfrao1CCc=;
	b=Vc3mvNgknbDgUId/zJu+aYhexJx2Vf67cJvDE5vwEttfpRBmHATwTgT6G/x5DLsErEuPeT
	n5/13P4Qau4rYZUaUe5S0T+An/Z2dBZaI2CpCulkueTTa9Xe3kHb/lLKhihjC5IJBH15Ep
	GULR9a6LtW4oX/KfcfvhgMEZWlDMSzc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0AB8132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wL1IG+WYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/18] btrfs: migrate scrub.c to use block size terminology
Date: Wed, 18 Dec 2024 20:11:20 +1030
Message-ID: <101d3ec7127ae1c30ddc20b53d43d2a5c70a9abf.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Mostly straightforward rename from "sector" to "block", except bio
interfaces.

Also rename the macro SCRUB_MAX_SECTORS_PER_BLOCK to
SCRUB_MAX_BLOCKS_PER_TREE_BLOCK.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 442 +++++++++++++++++++++++------------------------
 1 file changed, 221 insertions(+), 221 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 204c928beaf9..5cec0875a707 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -60,25 +60,25 @@ struct scrub_ctx;
 
 /*
  * The following value times PAGE_SIZE needs to be large enough to match the
- * largest node/leaf/sector size that shall be supported.
+ * largest node/leaf/block size that shall be supported.
  */
-#define SCRUB_MAX_SECTORS_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
+#define SCRUB_MAX_BLOCKS_PER_TREE_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
 
-/* Represent one sector and its needed info to verify the content. */
-struct scrub_sector_verification {
+/* Represent one block and its needed info to verify the content. */
+struct scrub_block_verification {
 	bool is_metadata;
 
 	union {
 		/*
 		 * Csum pointer for data csum verification.  Should point to a
-		 * sector csum inside scrub_stripe::csums.
+		 * block csum inside scrub_stripe::csums.
 		 *
-		 * NULL if this data sector has no csum.
+		 * NULL if this data block has no csum.
 		 */
 		u8 *csum;
 
 		/*
-		 * Extra info for metadata verification.  All sectors inside a
+		 * Extra info for metadata verification.  All blocks inside a
 		 * tree block share the same generation.
 		 */
 		u64 generation;
@@ -110,7 +110,7 @@ struct scrub_stripe {
 	struct btrfs_block_group *bg;
 
 	struct page *pages[SCRUB_STRIPE_PAGES];
-	struct scrub_sector_verification *sectors;
+	struct scrub_block_verification *blocks;
 
 	struct btrfs_device *dev;
 	u64 logical;
@@ -118,8 +118,8 @@ struct scrub_stripe {
 
 	u16 mirror_num;
 
-	/* Should be BTRFS_STRIPE_LEN / sectorsize. */
-	u16 nr_sectors;
+	/* Should be BTRFS_STRIPE_LEN / blocksize. */
+	u16 nr_blocks;
 
 	/*
 	 * How many data/meta extents are in this stripe.  Only for scrub status
@@ -138,8 +138,8 @@ struct scrub_stripe {
 	 */
 	unsigned long state;
 
-	/* Indicate which sectors are covered by extent items. */
-	unsigned long extent_sector_bitmap;
+	/* Indicate which blocks are covered by extent items. */
+	unsigned long extent_block_bitmap;
 
 	/*
 	 * The errors hit during the initial read of the stripe.
@@ -238,9 +238,9 @@ static void release_scrub_stripe(struct scrub_stripe *stripe)
 			__free_page(stripe->pages[i]);
 		stripe->pages[i] = NULL;
 	}
-	kfree(stripe->sectors);
+	kfree(stripe->blocks);
 	kfree(stripe->csums);
-	stripe->sectors = NULL;
+	stripe->blocks = NULL;
 	stripe->csums = NULL;
 	stripe->sctx = NULL;
 	stripe->state = 0;
@@ -253,7 +253,7 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 
 	memset(stripe, 0, sizeof(*stripe));
 
-	stripe->nr_sectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
+	stripe->nr_blocks = BTRFS_STRIPE_LEN >> fs_info->blocksize_bits;
 	stripe->state = 0;
 
 	init_waitqueue_head(&stripe->io_wait);
@@ -265,13 +265,13 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 	if (ret < 0)
 		goto error;
 
-	stripe->sectors = kcalloc(stripe->nr_sectors,
-				  sizeof(struct scrub_sector_verification),
+	stripe->blocks = kcalloc(stripe->nr_blocks,
+				  sizeof(struct scrub_block_verification),
 				  GFP_KERNEL);
-	if (!stripe->sectors)
+	if (!stripe->blocks)
 		goto error;
 
-	stripe->csums = kcalloc(BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits,
+	stripe->csums = kcalloc(BTRFS_STRIPE_LEN >> fs_info->blocksize_bits,
 				fs_info->csum_size, GFP_KERNEL);
 	if (!stripe->csums)
 		goto error;
@@ -456,7 +456,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 				  btrfs_dev_name(swarn->dev),
 				  swarn->physical,
 				  root, inum, offset,
-				  fs_info->sectorsize, nlink,
+				  fs_info->blocksize, nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
 	btrfs_put_root(local_root);
@@ -579,29 +579,29 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
-static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe, int sector_nr)
+static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe, int block_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	int page_index = (sector_nr << fs_info->sectorsize_bits) >> PAGE_SHIFT;
+	int page_index = (block_nr << fs_info->blocksize_bits) >> PAGE_SHIFT;
 
 	return stripe->pages[page_index];
 }
 
 static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
-						 int sector_nr)
+						 int block_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 
-	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
+	return offset_in_page(block_nr << fs_info->blocksize_bits);
 }
 
-static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
+static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int block_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
-	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
-	const struct page *first_page = scrub_stripe_get_page(stripe, sector_nr);
-	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, sector_nr);
+	const u32 blocks_per_tree = fs_info->nodesize >> fs_info->blocksize_bits;
+	const u64 logical = stripe->logical + (block_nr << fs_info->blocksize_bits);
+	const struct page *first_page = scrub_stripe_get_page(stripe, block_nr);
+	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, block_nr);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
@@ -616,8 +616,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
 
 	if (logical != btrfs_stack_header_bytenr(header)) {
-		bitmap_set(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->csum_error_bitmap, block_nr, blocks_per_tree);
+		bitmap_set(&stripe->error_bitmap, block_nr, blocks_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
 			      logical, stripe->mirror_num,
@@ -626,8 +626,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (memcmp(header->fsid, fs_info->fs_devices->metadata_uuid,
 		   BTRFS_FSID_SIZE) != 0) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_error_bitmap, block_nr, blocks_per_tree);
+		bitmap_set(&stripe->error_bitmap, block_nr, blocks_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
 			      logical, stripe->mirror_num,
@@ -636,8 +636,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	}
 	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
 		   BTRFS_UUID_SIZE) != 0) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_error_bitmap, block_nr, blocks_per_tree);
+		bitmap_set(&stripe->error_bitmap, block_nr, blocks_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
 			      logical, stripe->mirror_num,
@@ -649,20 +649,20 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 	crypto_shash_update(shash, page_address(first_page) + first_off +
-			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
+			    BTRFS_CSUM_SIZE, fs_info->blocksize - BTRFS_CSUM_SIZE);
 
-	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
+	for (int i = block_nr + 1; i < block_nr + blocks_per_tree; i++) {
 		struct page *page = scrub_stripe_get_page(stripe, i);
 		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
 
 		crypto_shash_update(shash, page_address(page) + page_off,
-				    fs_info->sectorsize);
+				    fs_info->blocksize);
 	}
 
 	crypto_shash_final(shash, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size) != 0) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_error_bitmap, block_nr, blocks_per_tree);
+		bitmap_set(&stripe->error_bitmap, block_nr, blocks_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
 			      logical, stripe->mirror_num,
@@ -670,44 +670,44 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
 		return;
 	}
-	if (stripe->sectors[sector_nr].generation !=
+	if (stripe->blocks[block_nr].generation !=
 	    btrfs_stack_header_generation(header)) {
-		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
-		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_error_bitmap, block_nr, blocks_per_tree);
+		bitmap_set(&stripe->error_bitmap, block_nr, blocks_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad generation, has %llu want %llu",
 			      logical, stripe->mirror_num,
 			      btrfs_stack_header_generation(header),
-			      stripe->sectors[sector_nr].generation);
+			      stripe->blocks[block_nr].generation);
 		return;
 	}
-	bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
-	bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
-	bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
+	bitmap_clear(&stripe->error_bitmap, block_nr, blocks_per_tree);
+	bitmap_clear(&stripe->csum_error_bitmap, block_nr, blocks_per_tree);
+	bitmap_clear(&stripe->meta_error_bitmap, block_nr, blocks_per_tree);
 }
 
-static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
+static void scrub_verify_one_block(struct scrub_stripe *stripe, int block_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	struct scrub_sector_verification *sector = &stripe->sectors[sector_nr];
-	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
-	struct page *page = scrub_stripe_get_page(stripe, sector_nr);
-	unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
+	struct scrub_block_verification *block = &stripe->blocks[block_nr];
+	const u32 blocks_per_tree = fs_info->nodesize >> fs_info->blocksize_bits;
+	struct page *page = scrub_stripe_get_page(stripe, block_nr);
+	unsigned int pgoff = scrub_stripe_get_page_offset(stripe, block_nr);
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	int ret;
 
-	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
+	ASSERT(block_nr >= 0 && block_nr < stripe->nr_blocks);
 
-	/* Sector not utilized, skip it. */
-	if (!test_bit(sector_nr, &stripe->extent_sector_bitmap))
+	/* Block not utilized, skip it. */
+	if (!test_bit(block_nr, &stripe->extent_block_bitmap))
 		return;
 
 	/* IO error, no need to check. */
-	if (test_bit(sector_nr, &stripe->io_error_bitmap))
+	if (test_bit(block_nr, &stripe->io_error_bitmap))
 		return;
 
 	/* Metadata, verify the full tree block. */
-	if (sector->is_metadata) {
+	if (block->is_metadata) {
 		/*
 		 * Check if the tree block crosses the stripe boundary.  If
 		 * crossed the boundary, we cannot verify it but only give a
@@ -716,15 +716,15 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		 * This can only happen on a very old filesystem where chunks
 		 * are not ensured to be stripe aligned.
 		 */
-		if (unlikely(sector_nr + sectors_per_tree > stripe->nr_sectors)) {
+		if (unlikely(block_nr + blocks_per_tree > stripe->nr_blocks)) {
 			btrfs_warn_rl(fs_info,
 			"tree block at %llu crosses stripe boundary %llu",
 				      stripe->logical +
-				      (sector_nr << fs_info->sectorsize_bits),
+				      (block_nr << fs_info->blocksize_bits),
 				      stripe->logical);
 			return;
 		}
-		scrub_verify_one_metadata(stripe, sector_nr);
+		scrub_verify_one_metadata(stripe, block_nr);
 		return;
 	}
 
@@ -732,52 +732,52 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	 * Data is easier, we just verify the data csum (if we have it).  For
 	 * cases without csum, we have no other choice but to trust it.
 	 */
-	if (!sector->csum) {
-		clear_bit(sector_nr, &stripe->error_bitmap);
+	if (!block->csum) {
+		clear_bit(block_nr, &stripe->error_bitmap);
 		return;
 	}
 
-	ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, sector->csum);
+	ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, block->csum);
 	if (ret < 0) {
-		set_bit(sector_nr, &stripe->csum_error_bitmap);
-		set_bit(sector_nr, &stripe->error_bitmap);
+		set_bit(block_nr, &stripe->csum_error_bitmap);
+		set_bit(block_nr, &stripe->error_bitmap);
 	} else {
-		clear_bit(sector_nr, &stripe->csum_error_bitmap);
-		clear_bit(sector_nr, &stripe->error_bitmap);
+		clear_bit(block_nr, &stripe->csum_error_bitmap);
+		clear_bit(block_nr, &stripe->error_bitmap);
 	}
 }
 
-/* Verify specified sectors of a stripe. */
+/* Verify specified blocks of a stripe. */
 static void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long bitmap)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
-	int sector_nr;
+	const u32 blocks_per_tree = fs_info->nodesize >> fs_info->blocksize_bits;
+	int block_nr;
 
-	for_each_set_bit(sector_nr, &bitmap, stripe->nr_sectors) {
-		scrub_verify_one_sector(stripe, sector_nr);
-		if (stripe->sectors[sector_nr].is_metadata)
-			sector_nr += sectors_per_tree - 1;
+	for_each_set_bit(block_nr, &bitmap, stripe->nr_blocks) {
+		scrub_verify_one_block(stripe, block_nr);
+		if (stripe->blocks[block_nr].is_metadata)
+			block_nr += blocks_per_tree - 1;
 	}
 }
 
-static int calc_sector_number(struct scrub_stripe *stripe, struct bio_vec *first_bvec)
+static int calc_block_number(struct scrub_stripe *stripe, struct bio_vec *first_bvec)
 {
 	int i;
 
-	for (i = 0; i < stripe->nr_sectors; i++) {
+	for (i = 0; i < stripe->nr_blocks; i++) {
 		if (scrub_stripe_get_page(stripe, i) == first_bvec->bv_page &&
 		    scrub_stripe_get_page_offset(stripe, i) == first_bvec->bv_offset)
 			break;
 	}
-	ASSERT(i < stripe->nr_sectors);
+	ASSERT(i < stripe->nr_blocks);
 	return i;
 }
 
 /*
  * Repair read is different to the regular read:
  *
- * - Only reads the failed sectors
+ * - Only reads the failed blocks
  * - May have extra blocksize limits
  */
 static void scrub_repair_read_endio(struct btrfs_bio *bbio)
@@ -785,23 +785,23 @@ static void scrub_repair_read_endio(struct btrfs_bio *bbio)
 	struct scrub_stripe *stripe = bbio->private;
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct bio_vec *bvec;
-	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int block_nr = calc_block_number(stripe, bio_first_bvec_all(&bbio->bio));
 	u32 bio_size = 0;
 	int i;
 
-	ASSERT(sector_nr < stripe->nr_sectors);
+	ASSERT(block_nr < stripe->nr_blocks);
 
 	bio_for_each_bvec_all(bvec, &bbio->bio, i)
 		bio_size += bvec->bv_len;
 
 	if (bbio->bio.bi_status) {
-		bitmap_set(&stripe->io_error_bitmap, sector_nr,
-			   bio_size >> fs_info->sectorsize_bits);
-		bitmap_set(&stripe->error_bitmap, sector_nr,
-			   bio_size >> fs_info->sectorsize_bits);
+		bitmap_set(&stripe->io_error_bitmap, block_nr,
+			   bio_size >> fs_info->blocksize_bits);
+		bitmap_set(&stripe->error_bitmap, block_nr,
+			   bio_size >> fs_info->blocksize_bits);
 	} else {
-		bitmap_clear(&stripe->io_error_bitmap, sector_nr,
-			     bio_size >> fs_info->sectorsize_bits);
+		bitmap_clear(&stripe->io_error_bitmap, block_nr,
+			     bio_size >> fs_info->blocksize_bits);
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io))
@@ -825,7 +825,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 	ASSERT(stripe->mirror_num >= 1);
 	ASSERT(atomic_read(&stripe->pending_io) == 0);
 
-	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
+	for_each_set_bit(i, &old_error_bitmap, stripe->nr_blocks) {
 		struct page *page;
 		int pgoff;
 		int ret;
@@ -833,7 +833,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 		page = scrub_stripe_get_page(stripe, i);
 		pgoff = scrub_stripe_get_page_offset(stripe, i);
 
-		/* The current sector cannot be merged, submit the bio. */
+		/* The current block cannot be merged, submit the bio. */
 		if (bbio && ((i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) ||
 			     bbio->bio.bi_iter.bi_size >= blocksize)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
@@ -845,14 +845,14 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 		}
 
 		if (!bbio) {
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
+			bbio = btrfs_bio_alloc(stripe->nr_blocks, REQ_OP_READ,
 				fs_info, scrub_repair_read_endio, stripe);
 			bbio->bio.bi_iter.bi_sector = (stripe->logical +
-				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
+				(i << fs_info->blocksize_bits)) >> SECTOR_SHIFT;
 		}
 
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
+		ret = bio_add_page(&bbio->bio, page, fs_info->blocksize, pgoff);
+		ASSERT(ret == fs_info->blocksize);
 	}
 	if (bbio) {
 		ASSERT(bbio->bio.bi_iter.bi_size);
@@ -871,11 +871,11 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_device *dev = NULL;
 	u64 physical = 0;
-	int nr_data_sectors = 0;
-	int nr_meta_sectors = 0;
-	int nr_nodatacsum_sectors = 0;
-	int nr_repaired_sectors = 0;
-	int sector_nr;
+	int nr_data_blocks = 0;
+	int nr_meta_blocks = 0;
+	int nr_nodatacsum_blocks = 0;
+	int nr_repaired_blocks = 0;
+	int block_nr;
 
 	if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
 		return;
@@ -886,8 +886,8 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	 * Although our scrub_stripe infrastructure is mostly based on btrfs_submit_bio()
 	 * thus no need for dev/physical, error reporting still needs dev and physical.
 	 */
-	if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors)) {
-		u64 mapped_len = fs_info->sectorsize;
+	if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_blocks)) {
+		u64 mapped_len = fs_info->blocksize;
 		struct btrfs_io_context *bioc = NULL;
 		int stripe_index = stripe->mirror_num - 1;
 		int ret;
@@ -909,29 +909,29 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	}
 
 skip:
-	for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
+	for_each_set_bit(block_nr, &stripe->extent_block_bitmap, stripe->nr_blocks) {
 		bool repaired = false;
 
-		if (stripe->sectors[sector_nr].is_metadata) {
-			nr_meta_sectors++;
+		if (stripe->blocks[block_nr].is_metadata) {
+			nr_meta_blocks++;
 		} else {
-			nr_data_sectors++;
-			if (!stripe->sectors[sector_nr].csum)
-				nr_nodatacsum_sectors++;
+			nr_data_blocks++;
+			if (!stripe->blocks[block_nr].csum)
+				nr_nodatacsum_blocks++;
 		}
 
-		if (test_bit(sector_nr, &stripe->init_error_bitmap) &&
-		    !test_bit(sector_nr, &stripe->error_bitmap)) {
-			nr_repaired_sectors++;
+		if (test_bit(block_nr, &stripe->init_error_bitmap) &&
+		    !test_bit(block_nr, &stripe->error_bitmap)) {
+			nr_repaired_blocks++;
 			repaired = true;
 		}
 
-		/* Good sector from the beginning, nothing need to be done. */
-		if (!test_bit(sector_nr, &stripe->init_error_bitmap))
+		/* Good block from the beginning, nothing need to be done. */
+		if (!test_bit(block_nr, &stripe->init_error_bitmap))
 			continue;
 
 		/*
-		 * Report error for the corrupted sectors.  If repaired, just
+		 * Report error for the corrupted blocks.  If repaired, just
 		 * output the message of repaired message.
 		 */
 		if (repaired) {
@@ -960,15 +960,15 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 					    stripe->logical, stripe->mirror_num);
 		}
 
-		if (test_bit(sector_nr, &stripe->io_error_bitmap))
+		if (test_bit(block_nr, &stripe->io_error_bitmap))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("i/o error", dev, false,
 						     stripe->logical, physical);
-		if (test_bit(sector_nr, &stripe->csum_error_bitmap))
+		if (test_bit(block_nr, &stripe->csum_error_bitmap))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("checksum error", dev, false,
 						     stripe->logical, physical);
-		if (test_bit(sector_nr, &stripe->meta_error_bitmap))
+		if (test_bit(block_nr, &stripe->meta_error_bitmap))
 			if (__ratelimit(&rs) && dev)
 				scrub_print_common_warning("header error", dev, false,
 						     stripe->logical, physical);
@@ -977,30 +977,30 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	spin_lock(&sctx->stat_lock);
 	sctx->stat.data_extents_scrubbed += stripe->nr_data_extents;
 	sctx->stat.tree_extents_scrubbed += stripe->nr_meta_extents;
-	sctx->stat.data_bytes_scrubbed += nr_data_sectors << fs_info->sectorsize_bits;
-	sctx->stat.tree_bytes_scrubbed += nr_meta_sectors << fs_info->sectorsize_bits;
-	sctx->stat.no_csum += nr_nodatacsum_sectors;
+	sctx->stat.data_bytes_scrubbed += nr_data_blocks << fs_info->blocksize_bits;
+	sctx->stat.tree_bytes_scrubbed += nr_meta_blocks << fs_info->blocksize_bits;
+	sctx->stat.no_csum += nr_nodatacsum_blocks;
 	sctx->stat.read_errors += stripe->init_nr_io_errors;
 	sctx->stat.csum_errors += stripe->init_nr_csum_errors;
 	sctx->stat.verify_errors += stripe->init_nr_meta_errors;
 	sctx->stat.uncorrectable_errors +=
-		bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
-	sctx->stat.corrected_errors += nr_repaired_sectors;
+		bitmap_weight(&stripe->error_bitmap, stripe->nr_blocks);
+	sctx->stat.corrected_errors += nr_repaired_blocks;
 	spin_unlock(&sctx->stat_lock);
 }
 
-static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
-				unsigned long write_bitmap, bool dev_replace);
+static void scrub_write_blocks(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
+			       unsigned long write_bitmap, bool dev_replace);
 
 /*
  * The main entrance for all read related scrub work, including:
  *
  * - Wait for the initial read to finish
- * - Verify and locate any bad sectors
+ * - Verify and locate any bad blocks
  * - Go through the remaining mirrors and try to read as large blocksize as
  *   possible
- * - Go through all mirrors (including the failed mirror) sector-by-sector
- * - Submit writeback for repaired sectors
+ * - Go through all mirrors (including the failed mirror) block-by-block
+ * - Submit writeback for repaired blocks
  *
  * Writeback for dev-replace does not happen here, it needs extra
  * synchronization for zoned devices.
@@ -1019,17 +1019,17 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	ASSERT(stripe->mirror_num > 0);
 
 	wait_scrub_stripe_io(stripe);
-	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
+	scrub_verify_one_stripe(stripe, stripe->extent_block_bitmap);
 	/* Save the initial failed bitmap for later repair and report usage. */
 	stripe->init_error_bitmap = stripe->error_bitmap;
 	stripe->init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
-						  stripe->nr_sectors);
+						  stripe->nr_blocks);
 	stripe->init_nr_csum_errors = bitmap_weight(&stripe->csum_error_bitmap,
-						    stripe->nr_sectors);
+						    stripe->nr_blocks);
 	stripe->init_nr_meta_errors = bitmap_weight(&stripe->meta_error_bitmap,
-						    stripe->nr_sectors);
+						    stripe->nr_blocks);
 
-	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
+	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_blocks))
 		goto out;
 
 	/*
@@ -1047,17 +1047,17 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 						BTRFS_STRIPE_LEN, false);
 		wait_scrub_stripe_io(stripe);
 		scrub_verify_one_stripe(stripe, old_error_bitmap);
-		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_blocks))
 			goto out;
 	}
 
 	/*
 	 * Last safety net, try re-checking all mirrors, including the failed
-	 * one, sector-by-sector.
+	 * one, block-by-block.
 	 *
-	 * As if one sector failed the drive's internal csum, the whole read
-	 * containing the offending sector would be marked as error.
-	 * Thus here we do sector-by-sector read.
+	 * As if one block failed the drive's internal csum, the whole read
+	 * containing the offending block would be marked as error.
+	 * Thus here we do block-by-block read.
 	 *
 	 * This can be slow, thus we only try it as the last resort.
 	 */
@@ -1068,24 +1068,24 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 		const unsigned long old_error_bitmap = stripe->error_bitmap;
 
 		scrub_stripe_submit_repair_read(stripe, mirror,
-						fs_info->sectorsize, true);
+						fs_info->blocksize, true);
 		wait_scrub_stripe_io(stripe);
 		scrub_verify_one_stripe(stripe, old_error_bitmap);
-		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_blocks))
 			goto out;
 	}
 out:
 	/*
-	 * Submit the repaired sectors.  For zoned case, we cannot do repair
+	 * Submit the repaired blocks.  For zoned case, we cannot do repair
 	 * in-place, but queue the bg to be relocated.
 	 */
 	bitmap_andnot(&repaired, &stripe->init_error_bitmap, &stripe->error_bitmap,
-		      stripe->nr_sectors);
-	if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_sectors)) {
+		      stripe->nr_blocks);
+	if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_blocks)) {
 		if (btrfs_is_zoned(fs_info)) {
 			btrfs_repair_one_zone(fs_info, sctx->stripes[0].bg->start);
 		} else {
-			scrub_write_sectors(sctx, stripe, repaired, false);
+			scrub_write_blocks(sctx, stripe, repaired, false);
 			wait_scrub_stripe_io(stripe);
 		}
 	}
@@ -1099,21 +1099,21 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
 	struct bio_vec *bvec;
-	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
-	int num_sectors;
+	int block_nr = calc_block_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int num_blocks;
 	u32 bio_size = 0;
 	int i;
 
-	ASSERT(sector_nr < stripe->nr_sectors);
+	ASSERT(block_nr < stripe->nr_blocks);
 	bio_for_each_bvec_all(bvec, &bbio->bio, i)
 		bio_size += bvec->bv_len;
-	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
+	num_blocks = bio_size >> stripe->bg->fs_info->blocksize_bits;
 
 	if (bbio->bio.bi_status) {
-		bitmap_set(&stripe->io_error_bitmap, sector_nr, num_sectors);
-		bitmap_set(&stripe->error_bitmap, sector_nr, num_sectors);
+		bitmap_set(&stripe->io_error_bitmap, block_nr, num_blocks);
+		bitmap_set(&stripe->error_bitmap, block_nr, num_blocks);
 	} else {
-		bitmap_clear(&stripe->io_error_bitmap, sector_nr, num_sectors);
+		bitmap_clear(&stripe->io_error_bitmap, block_nr, num_blocks);
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io)) {
@@ -1128,7 +1128,7 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 	struct scrub_stripe *stripe = bbio->private;
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct bio_vec *bvec;
-	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int block_nr = calc_block_number(stripe, bio_first_bvec_all(&bbio->bio));
 	u32 bio_size = 0;
 	int i;
 
@@ -1139,8 +1139,8 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		unsigned long flags;
 
 		spin_lock_irqsave(&stripe->write_error_lock, flags);
-		bitmap_set(&stripe->write_error_bitmap, sector_nr,
-			   bio_size >> fs_info->sectorsize_bits);
+		bitmap_set(&stripe->write_error_bitmap, block_nr,
+			   bio_size >> fs_info->blocksize_bits);
 		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
 	}
 	bio_put(&bbio->bio);
@@ -1173,13 +1173,13 @@ static void scrub_submit_write_bio(struct scrub_ctx *sctx,
 	 * And also need to update the write pointer if write finished
 	 * successfully.
 	 */
-	if (!test_bit(bio_off >> fs_info->sectorsize_bits,
+	if (!test_bit(bio_off >> fs_info->blocksize_bits,
 		      &stripe->write_error_bitmap))
 		sctx->write_pointer += bio_len;
 }
 
 /*
- * Submit the write bio(s) for the sectors specified by @write_bitmap.
+ * Submit the write bio(s) for the blocks specified by @write_bitmap.
  *
  * Here we utilize btrfs_submit_repair_write(), which has some extra benefits:
  *
@@ -1191,35 +1191,35 @@ static void scrub_submit_write_bio(struct scrub_ctx *sctx,
  *
  * - Handle dev-replace and read-repair writeback differently
  */
-static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
+static void scrub_write_blocks(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
 				unsigned long write_bitmap, bool dev_replace)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	int sector_nr;
+	int block_nr;
 
-	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
-		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
+	for_each_set_bit(block_nr, &write_bitmap, stripe->nr_blocks) {
+		struct page *page = scrub_stripe_get_page(stripe, block_nr);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, block_nr);
 		int ret;
 
-		/* We should only writeback sectors covered by an extent. */
-		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
+		/* We should only writeback blocks covered by an extent. */
+		ASSERT(test_bit(block_nr, &stripe->extent_block_bitmap));
 
-		/* Cannot merge with previous sector, submit the current one. */
-		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
+		/* Cannot merge with previous block, submit the current one. */
+		if (bbio && block_nr && !test_bit(block_nr - 1, &write_bitmap)) {
 			scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
 			bbio = NULL;
 		}
 		if (!bbio) {
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_WRITE,
+			bbio = btrfs_bio_alloc(stripe->nr_blocks, REQ_OP_WRITE,
 					       fs_info, scrub_write_endio, stripe);
 			bbio->bio.bi_iter.bi_sector = (stripe->logical +
-				(sector_nr << fs_info->sectorsize_bits)) >>
+				(block_nr << fs_info->blocksize_bits)) >>
 				SECTOR_SHIFT;
 		}
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
+		ret = bio_add_page(&bbio->bio, page, fs_info->blocksize, pgoff);
+		ASSERT(ret == fs_info->blocksize);
 	}
 	if (bbio)
 		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
@@ -1487,23 +1487,23 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 	for (u64 cur_logical = max(stripe->logical, extent_start);
 	     cur_logical < min(stripe->logical + BTRFS_STRIPE_LEN,
 			       extent_start + extent_len);
-	     cur_logical += fs_info->sectorsize) {
-		const int nr_sector = (cur_logical - stripe->logical) >>
-				      fs_info->sectorsize_bits;
-		struct scrub_sector_verification *sector =
-						&stripe->sectors[nr_sector];
+	     cur_logical += fs_info->blocksize) {
+		const int nr_block = (cur_logical - stripe->logical) >>
+				      fs_info->blocksize_bits;
+		struct scrub_block_verification *block =
+						&stripe->blocks[nr_block];
 
-		set_bit(nr_sector, &stripe->extent_sector_bitmap);
+		set_bit(nr_block, &stripe->extent_block_bitmap);
 		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-			sector->is_metadata = true;
-			sector->generation = extent_gen;
+			block->is_metadata = true;
+			block->generation = extent_gen;
 		}
 	}
 }
 
 static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
 {
-	stripe->extent_sector_bitmap = 0;
+	stripe->extent_block_bitmap = 0;
 	stripe->init_error_bitmap = 0;
 	stripe->init_nr_io_errors = 0;
 	stripe->init_nr_csum_errors = 0;
@@ -1541,8 +1541,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	u64 extent_gen;
 	int ret;
 
-	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
-				   stripe->nr_sectors);
+	memset(stripe->blocks, 0, sizeof(struct scrub_block_verification) *
+				   stripe->nr_blocks);
 	scrub_stripe_reset_bitmaps(stripe);
 
 	/* The range must be inside the bg. */
@@ -1575,12 +1575,12 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	stripe->mirror_num = mirror_num;
 	stripe_end = stripe->logical + BTRFS_STRIPE_LEN - 1;
 
-	/* Fill the first extent info into stripe->sectors[] array. */
+	/* Fill the first extent info into stripe->blocks[] array. */
 	fill_one_extent_info(fs_info, stripe, extent_start, extent_len,
 			     extent_flags, extent_gen);
 	cur_logical = extent_start + extent_len;
 
-	/* Fill the extent info for the remaining sectors. */
+	/* Fill the extent info for the remaining blocks. */
 	while (cur_logical <= stripe_end) {
 		ret = find_first_extent_item(extent_root, extent_path, cur_logical,
 					     stripe_end - cur_logical + 1);
@@ -1603,7 +1603,7 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 
 	/* Now fill the data csum. */
 	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
-		int sector_nr;
+		int block_nr;
 		unsigned long csum_bitmap = 0;
 
 		/* Csum space should have already been allocated. */
@@ -1611,9 +1611,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 
 		/*
 		 * Our csum bitmap should be large enough, as BTRFS_STRIPE_LEN
-		 * should contain at most 16 sectors.
+		 * should contain at most 16 blocks.
 		 */
-		ASSERT(BITS_PER_LONG >= BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
+		ASSERT(BITS_PER_LONG >= (BTRFS_STRIPE_LEN >> fs_info->blocksize_bits));
 
 		ret = btrfs_lookup_csums_bitmap(csum_root, csum_path,
 						stripe->logical, stripe_end,
@@ -1623,9 +1623,9 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 		if (ret > 0)
 			ret = 0;
 
-		for_each_set_bit(sector_nr, &csum_bitmap, stripe->nr_sectors) {
-			stripe->sectors[sector_nr].csum = stripe->csums +
-				sector_nr * fs_info->csum_size;
+		for_each_set_bit(block_nr, &csum_bitmap, stripe->nr_blocks) {
+			stripe->blocks[block_nr].csum = stripe->csums +
+				block_nr * fs_info->csum_size;
 		}
 	}
 	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
@@ -1641,10 +1641,10 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	stripe->nr_data_extents = 0;
 	stripe->state = 0;
 
-	for (int i = 0; i < stripe->nr_sectors; i++) {
-		stripe->sectors[i].is_metadata = false;
-		stripe->sectors[i].csum = NULL;
-		stripe->sectors[i].generation = 0;
+	for (int i = 0; i < stripe->nr_blocks; i++) {
+		stripe->blocks[i].is_metadata = false;
+		stripe->blocks[i].csum = NULL;
+		stripe->blocks[i].generation = 0;
 	}
 }
 
@@ -1656,29 +1656,29 @@ static u32 stripe_length(const struct scrub_stripe *stripe)
 		   stripe->bg->start + stripe->bg->length - stripe->logical);
 }
 
-static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
+static void scrub_submit_extent_block_read(struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
-	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
+	unsigned int nr_blocks = stripe_length(stripe) >> fs_info->blocksize_bits;
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
 
 	atomic_inc(&stripe->pending_io);
 
-	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
+	for_each_set_bit(i, &stripe->extent_block_bitmap, stripe->nr_blocks) {
 		struct page *page = scrub_stripe_get_page(stripe, i);
 		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
 
 		/* We're beyond the chunk boundary, no need to read anymore. */
-		if (i >= nr_sectors)
+		if (i >= nr_blocks)
 			break;
 
-		/* The current sector cannot be merged, submit the bio. */
+		/* The current block cannot be merged, submit the bio. */
 		if (bbio &&
 		    ((i > 0 &&
-		      !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
+		      !test_bit(i - 1, &stripe->extent_block_bitmap)) ||
 		     bbio->bio.bi_iter.bi_size >= stripe_len)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
 			atomic_inc(&stripe->pending_io);
@@ -1690,11 +1690,11 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 			struct btrfs_io_stripe io_stripe = {};
 			struct btrfs_io_context *bioc = NULL;
 			const u64 logical = stripe->logical +
-					    (i << fs_info->sectorsize_bits);
+					    (i << fs_info->blocksize_bits);
 			int err;
 
 			io_stripe.rst_search_commit_root = true;
-			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
+			stripe_len = (nr_blocks - i) << fs_info->blocksize_bits;
 			/*
 			 * For RST cases, we need to manually split the bbio to
 			 * follow the RST boundary.
@@ -1718,12 +1718,12 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 				continue;
 			}
 
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
+			bbio = btrfs_bio_alloc(stripe->nr_blocks, REQ_OP_READ,
 					       fs_info, scrub_read_endio, stripe);
 			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
 		}
 
-		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		__bio_add_page(&bbio->bio, page, fs_info->blocksize, pgoff);
 	}
 
 	if (bbio) {
@@ -1744,7 +1744,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
-	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
+	unsigned int nr_blocks = stripe_length(stripe) >> fs_info->blocksize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
@@ -1752,7 +1752,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 
 	if (btrfs_need_stripe_tree_update(fs_info, stripe->bg->flags)) {
-		scrub_submit_extent_sector_read(stripe);
+		scrub_submit_extent_block_read(stripe);
 		return;
 	}
 
@@ -1761,14 +1761,14 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 
 	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
 	/* Read the whole range inside the chunk boundary. */
-	for (unsigned int cur = 0; cur < nr_sectors; cur++) {
+	for (unsigned int cur = 0; cur < nr_blocks; cur++) {
 		struct page *page = scrub_stripe_get_page(stripe, cur);
 		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, cur);
 		int ret;
 
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		ret = bio_add_page(&bbio->bio, page, fs_info->blocksize, pgoff);
 		/* We should have allocated enough bio vectors. */
-		ASSERT(ret == fs_info->sectorsize);
+		ASSERT(ret == fs_info->blocksize);
 	}
 	atomic_inc(&stripe->pending_io);
 
@@ -1792,14 +1792,14 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 {
 	int i;
 
-	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_sectors) {
-		if (stripe->sectors[i].is_metadata) {
+	for_each_set_bit(i, &stripe->error_bitmap, stripe->nr_blocks) {
+		if (stripe->blocks[i].is_metadata) {
 			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 
 			btrfs_err(fs_info,
-			"stripe %llu has unrepaired metadata sector at %llu",
+			"stripe %llu has unrepaired metadata block at %llu",
 				  stripe->logical,
-				  stripe->logical + (i << fs_info->sectorsize_bits));
+				  stripe->logical + (i << fs_info->blocksize_bits));
 			return true;
 		}
 	}
@@ -1873,9 +1873,9 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 
 			ASSERT(stripe->dev == fs_info->dev_replace.srcdev);
 
-			bitmap_andnot(&good, &stripe->extent_sector_bitmap,
-				      &stripe->error_bitmap, stripe->nr_sectors);
-			scrub_write_sectors(sctx, stripe, good, true);
+			bitmap_andnot(&good, &stripe->extent_block_bitmap,
+				      &stripe->error_bitmap, stripe->nr_blocks);
+			scrub_write_blocks(sctx, stripe, good, true);
 		}
 	}
 
@@ -2008,7 +2008,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	/* Check if all data stripes are empty. */
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
-		if (!bitmap_empty(&stripe->extent_sector_bitmap, stripe->nr_sectors)) {
+		if (!bitmap_empty(&stripe->extent_block_bitmap, stripe->nr_blocks)) {
 			all_empty = false;
 			break;
 		}
@@ -2048,17 +2048,17 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		 * As we may hit an empty data stripe while it's missing.
 		 */
 		bitmap_and(&error, &stripe->error_bitmap,
-			   &stripe->extent_sector_bitmap, stripe->nr_sectors);
-		if (!bitmap_empty(&error, stripe->nr_sectors)) {
+			   &stripe->extent_block_bitmap, stripe->nr_blocks);
+		if (!bitmap_empty(&error, stripe->nr_blocks)) {
 			btrfs_err(fs_info,
-"unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
-				  full_stripe_start, i, stripe->nr_sectors,
+"unrepaired blocks detected, full stripe %llu data stripe %u errors %*pbl",
+				  full_stripe_start, i, stripe->nr_blocks,
 				  &error);
 			ret = -EIO;
 			goto out;
 		}
 		bitmap_or(&extent_bitmap, &extent_bitmap,
-			  &stripe->extent_sector_bitmap, stripe->nr_sectors);
+			  &stripe->extent_block_bitmap, stripe->nr_blocks);
 	}
 
 	/* Now we can check and regenerate the P/Q stripe. */
@@ -2076,7 +2076,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		goto out;
 	}
 	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap,
-				BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
+				BTRFS_STRIPE_LEN >> fs_info->blocksize_bits);
 	btrfs_put_bioc(bioc);
 	if (!rbio) {
 		ret = -ENOMEM;
@@ -2920,12 +2920,12 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	ASSERT(fs_info->nodesize <= BTRFS_STRIPE_LEN);
 
 	/*
-	 * SCRUB_MAX_SECTORS_PER_BLOCK is calculated using the largest possible
-	 * value (max nodesize / min sectorsize), thus nodesize should always
+	 * SCRUB_MAX_BLOCKS_PER_TREE_BLOCK is calculated using the largest possible
+	 * value (max nodesize / min blocksize), thus nodesize should always
 	 * be fine.
 	 */
 	ASSERT(fs_info->nodesize <=
-	       SCRUB_MAX_SECTORS_PER_BLOCK << fs_info->sectorsize_bits);
+	       SCRUB_MAX_BLOCKS_PER_TREE_BLOCK << fs_info->blocksize_bits);
 
 	/* Allocate outside of device_list_mutex */
 	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
@@ -2991,7 +2991,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	/*
 	 * In order to avoid deadlock with reclaim when there is a transaction
 	 * trying to pause scrub, make sure we use GFP_NOFS for all the
-	 * allocations done at btrfs_scrub_sectors() and scrub_sectors_for_parity()
+	 * allocations done at btrfs_scrub_blocks() and scrub_blocks_for_parity()
 	 * invoked by our callees. The pausing request is done when the
 	 * transaction commit starts, and it blocks the transaction until scrub
 	 * is paused (done at specific points at scrub_stripe() or right above
-- 
2.47.1


