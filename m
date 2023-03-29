Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04B6CD2B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjC2HKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjC2HKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B33199
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6F981FE0F
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tmdsy6jZUtUjcUcDktd4m0tqGAUYmFWzmMLydyMY27k=;
        b=Koo2HUVUuno4V1lqL/rrkYTU4kmiVBVIPPgxZVta/A6qY/NvurBOgnzhpjf7ioniYStsyG
        R72Fz5orulrrnuw8irNoinKmHX5fNbXaEwjaYU302vJex7LMOa3rtQuI9T53EKGLvn9PWw
        +XyESeVfeTjWC6YKZovLr26tCFwzJkg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 136D2138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SH26NFTkI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: scrub: remove scrub_block and scrub_sector structures
Date:   Wed, 29 Mar 2023 15:09:49 +0800
Message-Id: <43abb4fe2a827c06b14d94d241cd05c094514c0f.1680073696.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680073696.git.wqu@suse.com>
References: <cover.1680073696.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those two structures are used to represent a bunch of sectors for scrub,
but now they are fully replaced by scrub_stripe in one go, so we can
remove them now. This involves:

- structure scrub_block
- structure scrub_sector

- structure scrub_page_private
- function attach_scrub_page_private()
- function detach_scrub_page_private()
  Now we no longer need to use page::private to handle subpage.

- function alloc_scrub_block()
- function alloc_scrub_sector()
- function scrub_sector_get_page()
- function scrub_sector_get_page_offset()
- function scrub_sector_get_kaddr()
- function bio_add_scrub_sector()

- function scrub_checksum_data()
- function scrub_checksum_tree_block()
- function scrub_checksum_super()
- function scrub_check_fsid()
- function scrub_block_get()
- function scrub_block_put()
- function scrub_sector_get()
- function scrub_sector_put()
- function scrub_bio_end_io()
- function scrub_block_complete()
- function scrub_add_sector_to_rd_bio()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 564 -----------------------------------------------
 fs/btrfs/scrub.h |  10 -
 2 files changed, 574 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 63182aed390f..8c44a2fa0a19 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -38,7 +38,6 @@
  *  - add a mode to also read unallocated space
  */
 
-struct scrub_block;
 struct scrub_ctx;
 
 /*
@@ -183,19 +182,6 @@ struct scrub_stripe {
 	struct work_struct work;
 };
 
-struct scrub_sector {
-	struct scrub_block	*sblock;
-	struct list_head	list;
-	u64			flags;  /* extent flags */
-	u64			generation;
-	/* Offset in bytes to @sblock. */
-	u32			offset;
-	atomic_t		refs;
-	unsigned int		have_csum:1;
-	unsigned int		io_error:1;
-	u8			csum[BTRFS_CSUM_SIZE];
-};
-
 struct scrub_bio {
 	int			index;
 	struct scrub_ctx	*sctx;
@@ -204,45 +190,11 @@ struct scrub_bio {
 	blk_status_t		status;
 	u64			logical;
 	u64			physical;
-	struct scrub_sector	*sectors[SCRUB_SECTORS_PER_BIO];
 	int			sector_count;
 	int			next_free;
 	struct work_struct	work;
 };
 
-struct scrub_block {
-	/*
-	 * Each page will have its page::private used to record the logical
-	 * bytenr.
-	 */
-	struct page		*pages[SCRUB_MAX_PAGES];
-	struct scrub_sector	*sectors[SCRUB_MAX_SECTORS_PER_BLOCK];
-	struct btrfs_device	*dev;
-	/* Logical bytenr of the sblock */
-	u64			logical;
-	u64			physical;
-	u64			physical_for_dev_replace;
-	/* Length of sblock in bytes */
-	u32			len;
-	int			sector_count;
-	int			mirror_num;
-
-	atomic_t		outstanding_sectors;
-	refcount_t		refs; /* free mem on transition to zero */
-	struct scrub_ctx	*sctx;
-	struct {
-		unsigned int	header_error:1;
-		unsigned int	checksum_error:1;
-		unsigned int	no_io_error_seen:1;
-		unsigned int	generation_error:1; /* also sets header_error */
-
-		/* The following is for the data used to check parity */
-		/* It is for the data with checksum */
-		unsigned int	data_corrected:1;
-	};
-	struct work_struct	work;
-};
-
 struct scrub_ctx {
 	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
 	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
@@ -295,44 +247,6 @@ struct scrub_warning {
 	struct btrfs_device	*dev;
 };
 
-#ifndef CONFIG_64BIT
-/* This structure is for architectures whose (void *) is smaller than u64 */
-struct scrub_page_private {
-	u64 logical;
-};
-#endif
-
-static int attach_scrub_page_private(struct page *page, u64 logical)
-{
-#ifdef CONFIG_64BIT
-	attach_page_private(page, (void *)logical);
-	return 0;
-#else
-	struct scrub_page_private *spp;
-
-	spp = kmalloc(sizeof(*spp), GFP_KERNEL);
-	if (!spp)
-		return -ENOMEM;
-	spp->logical = logical;
-	attach_page_private(page, (void *)spp);
-	return 0;
-#endif
-}
-
-static void detach_scrub_page_private(struct page *page)
-{
-#ifdef CONFIG_64BIT
-	detach_page_private(page);
-	return;
-#else
-	struct scrub_page_private *spp;
-
-	spp = detach_page_private(page);
-	kfree(spp);
-	return;
-#endif
-}
-
 static void release_scrub_stripe(struct scrub_stripe *stripe)
 {
 	if (!stripe)
@@ -391,141 +305,7 @@ static void wait_scrub_stripe_io(struct scrub_stripe *stripe)
 	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
 }
 
-struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
-				     struct btrfs_device *dev,
-				     u64 logical, u64 physical,
-				     u64 physical_for_dev_replace,
-				     int mirror_num)
-{
-	struct scrub_block *sblock;
-
-	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
-	if (!sblock)
-		return NULL;
-	refcount_set(&sblock->refs, 1);
-	sblock->sctx = sctx;
-	sblock->logical = logical;
-	sblock->physical = physical;
-	sblock->physical_for_dev_replace = physical_for_dev_replace;
-	sblock->dev = dev;
-	sblock->mirror_num = mirror_num;
-	sblock->no_io_error_seen = 1;
-	/*
-	 * Scrub_block::pages will be allocated at alloc_scrub_sector() when
-	 * the corresponding page is not allocated.
-	 */
-	return sblock;
-}
-
-/*
- * Allocate a new scrub sector and attach it to @sblock.
- *
- * Will also allocate new pages for @sblock if needed.
- */
-struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock, u64 logical)
-{
-	const pgoff_t page_index = (logical - sblock->logical) >> PAGE_SHIFT;
-	struct scrub_sector *ssector;
-
-	/* We must never have scrub_block exceed U32_MAX in size. */
-	ASSERT(logical - sblock->logical < U32_MAX);
-
-	ssector = kzalloc(sizeof(*ssector), GFP_KERNEL);
-	if (!ssector)
-		return NULL;
-
-	/* Allocate a new page if the slot is not allocated */
-	if (!sblock->pages[page_index]) {
-		int ret;
-
-		sblock->pages[page_index] = alloc_page(GFP_KERNEL);
-		if (!sblock->pages[page_index]) {
-			kfree(ssector);
-			return NULL;
-		}
-		ret = attach_scrub_page_private(sblock->pages[page_index],
-				sblock->logical + (page_index << PAGE_SHIFT));
-		if (ret < 0) {
-			kfree(ssector);
-			__free_page(sblock->pages[page_index]);
-			sblock->pages[page_index] = NULL;
-			return NULL;
-		}
-	}
-
-	atomic_set(&ssector->refs, 1);
-	ssector->sblock = sblock;
-	/* The sector to be added should not be used */
-	ASSERT(sblock->sectors[sblock->sector_count] == NULL);
-	ssector->offset = logical - sblock->logical;
-
-	/* The sector count must be smaller than the limit */
-	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
-
-	sblock->sectors[sblock->sector_count] = ssector;
-	sblock->sector_count++;
-	sblock->len += sblock->sctx->fs_info->sectorsize;
-
-	return ssector;
-}
-
-static struct page *scrub_sector_get_page(struct scrub_sector *ssector)
-{
-	struct scrub_block *sblock = ssector->sblock;
-	pgoff_t index;
-	/*
-	 * When calling this function, ssector must be alreaday attached to the
-	 * parent sblock.
-	 */
-	ASSERT(sblock);
-
-	/* The range should be inside the sblock range */
-	ASSERT(ssector->offset < sblock->len);
-
-	index = ssector->offset >> PAGE_SHIFT;
-	ASSERT(index < SCRUB_MAX_PAGES);
-	ASSERT(sblock->pages[index]);
-	ASSERT(PagePrivate(sblock->pages[index]));
-	return sblock->pages[index];
-}
-
-static unsigned int scrub_sector_get_page_offset(struct scrub_sector *ssector)
-{
-	struct scrub_block *sblock = ssector->sblock;
-
-	/*
-	 * When calling this function, ssector must be already attached to the
-	 * parent sblock.
-	 */
-	ASSERT(sblock);
-
-	/* The range should be inside the sblock range */
-	ASSERT(ssector->offset < sblock->len);
-
-	return offset_in_page(ssector->offset);
-}
-
-static char *scrub_sector_get_kaddr(struct scrub_sector *ssector)
-{
-	return page_address(scrub_sector_get_page(ssector)) +
-	       scrub_sector_get_page_offset(ssector);
-}
-
-static int bio_add_scrub_sector(struct bio *bio, struct scrub_sector *ssector,
-				unsigned int len)
-{
-	return bio_add_page(bio, scrub_sector_get_page(ssector), len,
-			    scrub_sector_get_page_offset(ssector));
-}
-
-static int scrub_checksum_data(struct scrub_block *sblock);
-static int scrub_checksum_tree_block(struct scrub_block *sblock);
-static int scrub_checksum_super(struct scrub_block *sblock);
-static void scrub_block_put(struct scrub_block *sblock);
-static void scrub_sector_put(struct scrub_sector *sector);
-static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct work_struct *work);
-static void scrub_block_complete(struct scrub_block *sblock);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
@@ -595,8 +375,6 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	if (sctx->curr != -1) {
 		struct scrub_bio *sbio = sctx->bios[sctx->curr];
 
-		for (i = 0; i < sbio->sector_count; i++)
-			scrub_block_put(sbio->sectors[i]->sblock);
 		bio_put(sbio->bio);
 	}
 
@@ -895,15 +673,6 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 	}
 }
 
-static inline int scrub_check_fsid(u8 fsid[], struct scrub_sector *sector)
-{
-	struct btrfs_fs_devices *fs_devices = sector->sblock->dev->fs_devices;
-	int ret;
-
-	ret = memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	return !ret;
-}
-
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 {
 	int ret = 0;
@@ -926,68 +695,6 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
-static void scrub_block_get(struct scrub_block *sblock)
-{
-	refcount_inc(&sblock->refs);
-}
-
-static int scrub_checksum(struct scrub_block *sblock)
-{
-	u64 flags;
-	int ret;
-
-	/*
-	 * No need to initialize these stats currently,
-	 * because this function only use return value
-	 * instead of these stats value.
-	 *
-	 * Todo:
-	 * always use stats
-	 */
-	sblock->header_error = 0;
-	sblock->generation_error = 0;
-	sblock->checksum_error = 0;
-
-	WARN_ON(sblock->sector_count < 1);
-	flags = sblock->sectors[0]->flags;
-	ret = 0;
-	if (flags & BTRFS_EXTENT_FLAG_DATA)
-		ret = scrub_checksum_data(sblock);
-	else if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
-		ret = scrub_checksum_tree_block(sblock);
-	else if (flags & BTRFS_EXTENT_FLAG_SUPER)
-		ret = scrub_checksum_super(sblock);
-	else
-		WARN_ON(1);
-	return ret;
-}
-
-static int scrub_checksum_data(struct scrub_block *sblock)
-{
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u8 csum[BTRFS_CSUM_SIZE];
-	struct scrub_sector *sector;
-	char *kaddr;
-
-	BUG_ON(sblock->sector_count < 1);
-	sector = sblock->sectors[0];
-	if (!sector->have_csum)
-		return 0;
-
-	kaddr = scrub_sector_get_kaddr(sector);
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-
-	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
-
-	if (memcmp(csum, sector->csum, fs_info->csum_size))
-		sblock->checksum_error = 1;
-	return sblock->checksum_error;
-}
-
 static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe,
 					  int sector_nr)
 {
@@ -1602,168 +1309,6 @@ static void scrub_write_sectors(struct scrub_ctx *sctx,
 	}
 }
 
-static int scrub_checksum_tree_block(struct scrub_block *sblock)
-{
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_header *h;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u8 calculated_csum[BTRFS_CSUM_SIZE];
-	u8 on_disk_csum[BTRFS_CSUM_SIZE];
-	/*
-	 * This is done in sectorsize steps even for metadata as there's a
-	 * constraint for nodesize to be aligned to sectorsize. This will need
-	 * to change so we don't misuse data and metadata units like that.
-	 */
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-	const int num_sectors = fs_info->nodesize >> fs_info->sectorsize_bits;
-	int i;
-	struct scrub_sector *sector;
-	char *kaddr;
-
-	BUG_ON(sblock->sector_count < 1);
-
-	/* Each member in sectors is just one sector */
-	ASSERT(sblock->sector_count == num_sectors);
-
-	sector = sblock->sectors[0];
-	kaddr = scrub_sector_get_kaddr(sector);
-	h = (struct btrfs_header *)kaddr;
-	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
-
-	/*
-	 * we don't use the getter functions here, as we
-	 * a) don't have an extent buffer and
-	 * b) the page is already kmapped
-	 */
-	if (sblock->logical != btrfs_stack_header_bytenr(h)) {
-		sblock->header_error = 1;
-		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
-			      sblock->logical, sblock->mirror_num,
-			      btrfs_stack_header_bytenr(h),
-			      sblock->logical);
-		goto out;
-	}
-
-	if (!scrub_check_fsid(h->fsid, sector)) {
-		sblock->header_error = 1;
-		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
-			      sblock->logical, sblock->mirror_num,
-			      h->fsid, sblock->dev->fs_devices->fsid);
-		goto out;
-	}
-
-	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid, BTRFS_UUID_SIZE)) {
-		sblock->header_error = 1;
-		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
-			      sblock->logical, sblock->mirror_num,
-			      h->chunk_tree_uuid, fs_info->chunk_tree_uuid);
-		goto out;
-	}
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    sectorsize - BTRFS_CSUM_SIZE);
-
-	for (i = 1; i < num_sectors; i++) {
-		kaddr = scrub_sector_get_kaddr(sblock->sectors[i]);
-		crypto_shash_update(shash, kaddr, sectorsize);
-	}
-
-	crypto_shash_final(shash, calculated_csum);
-	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size)) {
-		sblock->checksum_error = 1;
-		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
-			      sblock->logical, sblock->mirror_num,
-			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
-			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
-		goto out;
-	}
-
-	if (sector->generation != btrfs_stack_header_generation(h)) {
-		sblock->header_error = 1;
-		sblock->generation_error = 1;
-		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad generation, has %llu want %llu",
-			      sblock->logical, sblock->mirror_num,
-			      btrfs_stack_header_generation(h),
-			      sector->generation);
-	}
-
-out:
-	return sblock->header_error || sblock->checksum_error;
-}
-
-static int scrub_checksum_super(struct scrub_block *sblock)
-{
-	struct btrfs_super_block *s;
-	struct scrub_ctx *sctx = sblock->sctx;
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u8 calculated_csum[BTRFS_CSUM_SIZE];
-	struct scrub_sector *sector;
-	char *kaddr;
-	int fail_gen = 0;
-	int fail_cor = 0;
-
-	BUG_ON(sblock->sector_count < 1);
-	sector = sblock->sectors[0];
-	kaddr = scrub_sector_get_kaddr(sector);
-	s = (struct btrfs_super_block *)kaddr;
-
-	if (sblock->logical != btrfs_super_bytenr(s))
-		++fail_cor;
-
-	if (sector->generation != btrfs_super_generation(s))
-		++fail_gen;
-
-	if (!scrub_check_fsid(s->fsid, sector))
-		++fail_cor;
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
-			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
-
-	if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
-		++fail_cor;
-
-	return fail_cor + fail_gen;
-}
-
-static void scrub_block_put(struct scrub_block *sblock)
-{
-	if (refcount_dec_and_test(&sblock->refs)) {
-		int i;
-
-		for (i = 0; i < sblock->sector_count; i++)
-			scrub_sector_put(sblock->sectors[i]);
-		for (i = 0; i < DIV_ROUND_UP(sblock->len, PAGE_SIZE); i++) {
-			if (sblock->pages[i]) {
-				detach_scrub_page_private(sblock->pages[i]);
-				__free_page(sblock->pages[i]);
-			}
-		}
-		kfree(sblock);
-	}
-}
-
-void scrub_sector_get(struct scrub_sector *sector)
-{
-	atomic_inc(&sector->refs);
-}
-
-static void scrub_sector_put(struct scrub_sector *sector)
-{
-	if (atomic_dec_and_test(&sector->refs))
-		kfree(sector);
-}
-
 static void scrub_throttle_dev_io(struct scrub_ctx *sctx,
 				  struct btrfs_device *device,
 				  unsigned int bio_size)
@@ -1844,110 +1389,12 @@ static void scrub_submit(struct scrub_ctx *sctx)
 	submit_bio(sbio->bio);
 }
 
-int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
-			       struct scrub_sector *sector)
-{
-	struct scrub_block *sblock = sector->sblock;
-	struct scrub_bio *sbio;
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-	int ret;
-
-again:
-	/*
-	 * grab a fresh bio or wait for one to become available
-	 */
-	while (sctx->curr == -1) {
-		spin_lock(&sctx->list_lock);
-		sctx->curr = sctx->first_free;
-		if (sctx->curr != -1) {
-			sctx->first_free = sctx->bios[sctx->curr]->next_free;
-			sctx->bios[sctx->curr]->next_free = -1;
-			sctx->bios[sctx->curr]->sector_count = 0;
-			spin_unlock(&sctx->list_lock);
-		} else {
-			spin_unlock(&sctx->list_lock);
-			wait_event(sctx->list_wait, sctx->first_free != -1);
-		}
-	}
-	sbio = sctx->bios[sctx->curr];
-	if (sbio->sector_count == 0) {
-		sbio->physical = sblock->physical + sector->offset;
-		sbio->logical = sblock->logical + sector->offset;
-		sbio->dev = sblock->dev;
-		if (!sbio->bio) {
-			sbio->bio = bio_alloc(sbio->dev->bdev, sctx->sectors_per_bio,
-					      REQ_OP_READ, GFP_NOFS);
-		}
-		sbio->bio->bi_private = sbio;
-		sbio->bio->bi_end_io = scrub_bio_end_io;
-		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
-		sbio->status = 0;
-	} else if (sbio->physical + sbio->sector_count * sectorsize !=
-		   sblock->physical + sector->offset ||
-		   sbio->logical + sbio->sector_count * sectorsize !=
-		   sblock->logical + sector->offset ||
-		   sbio->dev != sblock->dev) {
-		scrub_submit(sctx);
-		goto again;
-	}
-
-	sbio->sectors[sbio->sector_count] = sector;
-	ret = bio_add_scrub_sector(sbio->bio, sector, sectorsize);
-	if (ret != sectorsize) {
-		if (sbio->sector_count < 1) {
-			bio_put(sbio->bio);
-			sbio->bio = NULL;
-			return -EIO;
-		}
-		scrub_submit(sctx);
-		goto again;
-	}
-
-	scrub_block_get(sblock); /* one for the page added to the bio */
-	atomic_inc(&sblock->outstanding_sectors);
-	sbio->sector_count++;
-	if (sbio->sector_count == sctx->sectors_per_bio)
-		scrub_submit(sctx);
-
-	return 0;
-}
-
-static void scrub_bio_end_io(struct bio *bio)
-{
-	struct scrub_bio *sbio = bio->bi_private;
-	struct btrfs_fs_info *fs_info = sbio->dev->fs_info;
-
-	sbio->status = bio->bi_status;
-	sbio->bio = bio;
-
-	queue_work(fs_info->scrub_workers, &sbio->work);
-}
-
 static void scrub_bio_end_io_worker(struct work_struct *work)
 {
 	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
 	struct scrub_ctx *sctx = sbio->sctx;
-	int i;
 
 	ASSERT(sbio->sector_count <= SCRUB_SECTORS_PER_BIO);
-	if (sbio->status) {
-		for (i = 0; i < sbio->sector_count; i++) {
-			struct scrub_sector *sector = sbio->sectors[i];
-
-			sector->io_error = 1;
-			sector->sblock->no_io_error_seen = 0;
-		}
-	}
-
-	/* Now complete the scrub_block items that have all pages completed */
-	for (i = 0; i < sbio->sector_count; i++) {
-		struct scrub_sector *sector = sbio->sectors[i];
-		struct scrub_block *sblock = sector->sblock;
-
-		if (atomic_dec_and_test(&sblock->outstanding_sectors))
-			scrub_block_complete(sblock);
-		scrub_block_put(sblock);
-	}
 
 	bio_put(sbio->bio);
 	sbio->bio = NULL;
@@ -1959,17 +1406,6 @@ static void scrub_bio_end_io_worker(struct work_struct *work)
 	scrub_pending_bio_dec(sctx);
 }
 
-static void scrub_block_complete(struct scrub_block *sblock)
-{
-	if (sblock->no_io_error_seen)
-		/*
-		 * if has checksum error, write via repair mechanism in
-		 * dev replace case, otherwise write here in dev replace
-		 * case.
-		 */
-		scrub_checksum(sblock);
-}
-
 static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *sum)
 {
 	sctx->stat.csum_discards += sum->len >> sctx->fs_info->sectorsize_bits;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7d1982893363..1fa4d26e8122 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -15,17 +15,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 
 /* Temporary declaration, would be deleted later. */
 struct scrub_ctx;
-struct scrub_sector;
 struct scrub_block;
 int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
-int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
-			       struct scrub_sector *sector);
-void scrub_sector_get(struct scrub_sector *sector);
-struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock, u64 logical);
-struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
-				     struct btrfs_device *dev,
-				     u64 logical, u64 physical,
-				     u64 physical_for_dev_replace,
-				     int mirror_num);
 
 #endif
-- 
2.39.2

