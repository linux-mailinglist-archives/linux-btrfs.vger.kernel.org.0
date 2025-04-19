Return-Path: <linux-btrfs+bounces-13178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C105FA94215
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED087A4FFF
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37B19CC20;
	Sat, 19 Apr 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c1XcJOam";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c1XcJOam"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7935893
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047097; cv=none; b=hb+DEIUIpOZhI//EQm76PgFIwPqqaBmH+KQx8C4T7Qhf/f04Y12O+cBWmv84OdPRCBHLa+CzOLr6VIlINcZH8VUOZbsmZ5eEF46Xo9eoT85NpP8hv0ikz+K7dfchKMC+sOKL7JB5vD3eMlnd+enZDRENJXL1V3SUVYKrLQy9u3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047097; c=relaxed/simple;
	bh=/xTYWEDVtfGBdiDdQgFYTHcJQ82O5lgtM/UgSYPuLxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5DXwudeW7zgxHgBTvj6Eq8N14fCmWl+kq8X6PgcJiNlH2Rqy9q/W3+uHzTcBf36zFTs1eGHnrWykSA03W2yTYdpSEW3bCODrmlV+TmH5jdkmU5x174u1rSCe47/S5SOkZEJY16lu6cbl2gQ2UcmjLZL7FqSAeHlC0r1xZbZ9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c1XcJOam; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c1XcJOam; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCE9A2120F;
	Sat, 19 Apr 2025 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+GLoDA3BQ2J9VhwNTwRMKEdltKTFVOGahyh33vLDq8=;
	b=c1XcJOamMgA10EV66u/zlgf+NzRVL+xJkEKOWTEyWRSo7DlDxPaPbd/A6rryapPUydOkSf
	IB/UsKUfgh6T/E8+O+YJFCV3RnzQE6El9PJev3Q/E+SbNWbGbbFhDD9TYcUh72pe1/s5yk
	5OllQ+NFq9PsA/RvSYWz66KEIKjfKjE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c1XcJOam
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+GLoDA3BQ2J9VhwNTwRMKEdltKTFVOGahyh33vLDq8=;
	b=c1XcJOamMgA10EV66u/zlgf+NzRVL+xJkEKOWTEyWRSo7DlDxPaPbd/A6rryapPUydOkSf
	IB/UsKUfgh6T/E8+O+YJFCV3RnzQE6El9PJev3Q/E+SbNWbGbbFhDD9TYcUh72pe1/s5yk
	5OllQ+NFq9PsA/RvSYWz66KEIKjfKjE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8800713A79;
	Sat, 19 Apr 2025 07:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCcHExxOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 7/8] btrfs: scrub: use virtual addresses directly
Date: Sat, 19 Apr 2025 16:47:14 +0930
Message-ID: <e0050f1ffef5f17cde772f40f18056f5af90a60e.1745024799.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745024799.git.wqu@suse.com>
References: <cover.1745024799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCE9A2120F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

Instead of the old @page and @page_offset pair inside scrub, here we can
directly use the virtual address for a sector.

This has the following benefit:

- Simplified parameters
  A single @kaddr will repair @page and @page_offset.

- No more unnecessary kmap/kunmap calls
  Since all pages utilized by scrub is allocated by scrub, and no
  highmem is allowed, we do not need to do any kmap/kunmap.

  And add an ASSERT() inside the new scrub_stripe_get_kaddr() to
  catch any unexpected highmem page.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 94 ++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 49021765c17b..4ff3465c430c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -579,20 +579,16 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
-static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe, int sector_nr)
+static void *scrub_stripe_get_kaddr(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	int page_index = (sector_nr << fs_info->sectorsize_bits) >> PAGE_SHIFT;
+	u32 offset = sector_nr << fs_info->sectorsize_bits;
+	const struct page *page = stripe->pages[offset >> PAGE_SHIFT];
 
-	return stripe->pages[page_index];
-}
-
-static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
-						 int sector_nr)
-{
-	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-
-	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
+	/* stripe->pages[] is allocated by us and no highmem is allowed. */
+	ASSERT(!PageHighMem(page));
+	ASSERT(page);
+	return page_address(page) + offset_in_page(offset);
 }
 
 static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
@@ -600,19 +596,17 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
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
@@ -648,14 +642,11 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
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
 
@@ -691,10 +682,8 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
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
@@ -738,9 +727,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		return;
 	}
 
-	kaddr = kmap_local_page(page) + pgoff;
 	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum);
-	kunmap_local(kaddr);
 	if (ret < 0) {
 		set_bit(sector_nr, &stripe->csum_error_bitmap);
 		set_bit(sector_nr, &stripe->error_bitmap);
@@ -769,8 +756,7 @@ static int calc_sector_number(struct scrub_stripe *stripe, struct bio_vec *first
 	int i;
 
 	for (i = 0; i < stripe->nr_sectors; i++) {
-		if (scrub_stripe_get_page(stripe, i) == first_bvec->bv_page &&
-		    scrub_stripe_get_page_offset(stripe, i) == first_bvec->bv_offset)
+		if (scrub_stripe_get_kaddr(stripe, i) == bvec_virt(first_bvec))
 			break;
 	}
 	ASSERT(i < stripe->nr_sectors);
@@ -817,6 +803,25 @@ static int calc_next_mirror(int mirror, int num_copies)
 	return (mirror + 1 > num_copies) ? 1 : mirror + 1;
 }
 
+static void scrub_bio_add_sector(struct btrfs_bio *bbio,
+		struct scrub_stripe *stripe, int sector_nr)
+{
+	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
+	int ret;
+
+	ret = bio_add_page(&bbio->bio, virt_to_page(kaddr),
+			   bbio->fs_info->sectorsize, offset_in_page(kaddr));
+	/*
+	 * Caller should ensure the bbio has enough size.
+	 * And we can not use __bio_add_page(), which doesn't do any merge.
+	 *
+	 * Meanwhile for scrub_submit_initial_read() we fully rely on the merge
+	 * to create the minimal amount of bio vectors, for fs block size < page
+	 * size cases.
+	 */
+	ASSERT(ret == bbio->fs_info->sectorsize);
+}
+
 static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 					    int mirror, int blocksize, bool wait)
 {
@@ -829,13 +834,6 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
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
@@ -854,8 +852,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
 		}
 
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
+		scrub_bio_add_sector(bbio, stripe, i);
 	}
 	if (bbio) {
 		ASSERT(bbio->bio.bi_iter.bi_size);
@@ -1202,10 +1199,6 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 	int sector_nr;
 
 	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
-		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
-		int ret;
-
 		/* We should only writeback sectors covered by an extent. */
 		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
 
@@ -1221,8 +1214,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
 				(sector_nr << fs_info->sectorsize_bits)) >>
 				SECTOR_SHIFT;
 		}
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
+		scrub_bio_add_sector(bbio, stripe, sector_nr);
 	}
 	if (bbio)
 		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
@@ -1675,9 +1667,6 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 	atomic_inc(&stripe->pending_io);
 
 	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
-		struct page *page = scrub_stripe_get_page(stripe, i);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
-
 		/* We're beyond the chunk boundary, no need to read anymore. */
 		if (i >= nr_sectors)
 			break;
@@ -1730,7 +1719,7 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
 			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
 		}
 
-		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		scrub_bio_add_sector(bbio, stripe, i);
 	}
 
 	if (bbio) {
@@ -1768,15 +1757,8 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 
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
2.49.0


