Return-Path: <linux-btrfs+bounces-12920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4151A82330
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5464A6951
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA425DCE3;
	Wed,  9 Apr 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4pQHxQb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBB25DB1A
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197077; cv=none; b=gcmg2vlKZrY/M0uT2KsW2y1BmDN36Qk0o/luwmi5BG6vWlqhb2g2PDT7Tyy9mKHbuWwJaAQTGsFLA/3PPOZdmh9Ak7dDO9AFuogiuk07B+lBTTSSHbhqhahURb4vNN+y36Le530mof2erSkbpb1qYgu5juYYwhVhy5awiB8jeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197077; c=relaxed/simple;
	bh=4ccoFaquUw/OgqRrJzBkANbgZQQJzP9i9jL6t6eWGq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gr2o0pV6QeGCkJ1fCCIckHwCcb97mmJS2zg1UJy7Q3k0pIYx30s+BSW+14F1qwkgQ1eLW2lMw+WSQCEnbMZ9t0eKfpptGTGbqYKMpCR1r6/V39QY43OBqv81KxhKz8WIc7V4rTilc2QvxPpBWDcXTTBjaKL5M/mZt2h+KBKehJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k4pQHxQb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dzq0mSFwsqXmbtLmVennOOCIUdmX8lsYsXUJfNPRpB4=; b=k4pQHxQbIRujd/Lk5Dce6cGM39
	bY55Ob+8DCmFpVSvt3R1sCGQxKOEdA3AHKlxkrsi4PZ660IpX+qAhc2rQclrSsfH7VaRFlqVykeWu
	k3ZxvQFoUm1igToQmdY+Fy1DguvL56qc+jY/d14BqFd76oC2HTt9JBpudp7oIn/tcS+deBvYBIrZw
	mZiHVjO2lfia6wS4W7VawI0+uuQmdFEAXjZnLYK2THmgkoazvxh/roaooRr279q7pdVKkiBCU82jA
	Uu5SBCz/omx67SgTuqj85qidm/pzzKZw8mwC6O8qLzjisl2VTimSc7aC0vGw81jt0AvFtTAZe5Trl
	95SZGr9A==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKt-00000006x4e-1F4U;
	Wed, 09 Apr 2025 11:11:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: refactor getting the address of a stripe sector
Date: Wed,  9 Apr 2025 13:10:41 +0200
Message-ID: <20250409111055.3640328-8-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409111055.3640328-1-hch@lst.de>
References: <20250409111055.3640328-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to get the actual kernel address of a stripe instead of
just the page and offset into it to simplify the code, and add another
helper to add the memory backing a sector to a bio using the above
helper.

This nicely abstracts away the page + offset representation from almost
all of the scrub code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/scrub.c | 81 +++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 49021765c17b..d014b728eb0d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -579,20 +579,13 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
-static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe, int sector_nr)
+static void *scrub_stripe_get_kaddr(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	int page_index = (sector_nr << fs_info->sectorsize_bits) >> PAGE_SHIFT;
+	u32 offset = sector_nr << fs_info->sectorsize_bits;
 
-	return stripe->pages[page_index];
-}
-
-static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
-						 int sector_nr)
-{
-	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-
-	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
+	return page_address(stripe->pages[offset >> PAGE_SHIFT]) +
+			offset_in_page(offset);
 }
 
 static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
@@ -600,19 +593,17 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
 	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
-	const struct page *first_page = scrub_stripe_get_page(stripe, sector_nr);
-	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, sector_nr);
+	void *first_kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
-	struct btrfs_header *header;
+	struct btrfs_header *header = first_kaddr;
 
 	/*
 	 * Here we don't have a good way to attach the pages (and subpages)
 	 * to a dummy extent buffer, thus we have to directly grab the members
 	 * from pages.
 	 */
-	header = (struct btrfs_header *)(page_address(first_page) + first_off);
 	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
 
 	if (logical != btrfs_stack_header_bytenr(header)) {
@@ -648,14 +639,11 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	/* Now check tree block csum. */
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
-	crypto_shash_update(shash, page_address(first_page) + first_off +
-			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
+	crypto_shash_update(shash, first_kaddr + BTRFS_CSUM_SIZE,
+			fs_info->sectorsize - BTRFS_CSUM_SIZE);
 
 	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
-		struct page *page = scrub_stripe_get_page(stripe, i);
-		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
-
-		crypto_shash_update(shash, page_address(page) + page_off,
+		crypto_shash_update(shash, scrub_stripe_get_kaddr(stripe, i),
 				    fs_info->sectorsize);
 	}
 
@@ -691,10 +679,8 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct scrub_sector_verification *sector = &stripe->sectors[sector_nr];
 	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
-	struct page *page = scrub_stripe_get_page(stripe, sector_nr);
-	unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
+	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
 	u8 csum_buf[BTRFS_CSUM_SIZE];
-	void *kaddr;
 	int ret;
 
 	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
@@ -738,9 +724,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		return;
 	}
 
-	kaddr = kmap_local_page(page) + pgoff;
 	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum);
-	kunmap_local(kaddr);
 	if (ret < 0) {
 		set_bit(sector_nr, &stripe->csum_error_bitmap);
 		set_bit(sector_nr, &stripe->error_bitmap);
@@ -769,8 +753,7 @@ static int calc_sector_number(struct scrub_stripe *stripe, struct bio_vec *first
 	int i;
 
 	for (i = 0; i < stripe->nr_sectors; i++) {
-		if (scrub_stripe_get_page(stripe, i) == first_bvec->bv_page &&
-		    scrub_stripe_get_page_offset(stripe, i) == first_bvec->bv_offset)
+		if (scrub_stripe_get_kaddr(stripe, i) == bvec_virt(first_bvec))
 			break;
 	}
 	ASSERT(i < stripe->nr_sectors);
@@ -817,6 +800,15 @@ static int calc_next_mirror(int mirror, int num_copies)
 	return (mirror + 1 > num_copies) ? 1 : mirror + 1;
 }
 
+static void scrub_bio_add_sector(struct btrfs_bio *bbio,
+		struct scrub_stripe *stripe, int sector_nr)
+{
+	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
+
+	__bio_add_page(&bbio->bio, virt_to_page(kaddr),
+			bbio->fs_info->sectorsize, offset_in_page(kaddr));
+}
+
 static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 					    int mirror, int blocksize, bool wait)
 {
@@ -829,13 +821,6 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 	ASSERT(atomic_read(&stripe->pending_io) == 0);
 
 	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
-		struct page *page;
-		int pgoff;
-		int ret;
-
-		page = scrub_stripe_get_page(stripe, i);
-		pgoff = scrub_stripe_get_page_offset(stripe, i);
-
 		/* The current sector cannot be merged, submit the bio. */
 		if (bbio && ((i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) ||
 			     bbio->bio.bi_iter.bi_size >= blocksize)) {
@@ -854,8 +839,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
 		}
 
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
+		scrub_bio_add_sector(bbio, stripe, i);
 	}
 	if (bbio) {
 		ASSERT(bbio->bio.bi_iter.bi_size);
@@ -1202,10 +1186,6 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 	int sector_nr;
 
 	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
-		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
-		int ret;
-
 		/* We should only writeback sectors covered by an extent. */
 		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
 
@@ -1221,8 +1201,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 				(sector_nr << fs_info->sectorsize_bits)) >>
 				SECTOR_SHIFT;
 		}
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
+		scrub_bio_add_sector(bbio, stripe, sector_nr);
 	}
 	if (bbio)
 		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
@@ -1675,9 +1654,6 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 	atomic_inc(&stripe->pending_io);
 
 	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
-		struct page *page = scrub_stripe_get_page(stripe, i);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
-
 		/* We're beyond the chunk boundary, no need to read anymore. */
 		if (i >= nr_sectors)
 			break;
@@ -1730,7 +1706,7 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
 		}
 
-		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		scrub_bio_add_sector(bbio, stripe, i);
 	}
 
 	if (bbio) {
@@ -1768,15 +1744,8 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 
 	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
 	/* Read the whole range inside the chunk boundary. */
-	for (unsigned int cur = 0; cur < nr_sectors; cur++) {
-		struct page *page = scrub_stripe_get_page(stripe, cur);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, cur);
-		int ret;
-
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		/* We should have allocated enough bio vectors. */
-		ASSERT(ret == fs_info->sectorsize);
-	}
+	for (unsigned int cur = 0; cur < nr_sectors; cur++)
+		scrub_bio_add_sector(bbio, stripe, cur);
 	atomic_inc(&stripe->pending_io);
 
 	/*
-- 
2.47.2


