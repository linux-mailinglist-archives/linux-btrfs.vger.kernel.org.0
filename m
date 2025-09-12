Return-Path: <linux-btrfs+bounces-16799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992FB54158
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 06:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCA165832
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0E7DA66;
	Fri, 12 Sep 2025 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YBwhVB71";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YBwhVB71"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC92DC77F
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649620; cv=none; b=nn8Mpxf0+C/v+Ox1EiLNdpdYcB+kI6kbbHqbsHMhyhh8SKtzcAglbqzpDtIO77ooSi1VGEIySlOFc2lCGCTfnwhQs5sawvOTIsbvFyVXa5lD1L+xfLdQT/FbpcXJ+TwTTm7w94rz6z9hct5M7S5GYUtfOFHzzyBZXvs/40zmeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649620; c=relaxed/simple;
	bh=Roq7PECsSmnA6tLS6jQSp80a0iEQpoIEowrMjnv0JBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcGM0SsO6zkfHQR1TXGeH9e9bI1StAsPpM/NTxEg+OdKKlkFIJvqN44l7GozBRBXkhuJcgRd9YjLgZhvtTKWwd6KQgRLVCPdlYHximCNwayggCMplxgxphztn9fn/B6l/kc+XWTidnZ2FaU21vuvshonWUzvgXZZTHNkeHA0Ogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YBwhVB71; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YBwhVB71; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BAB03FC91
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757649604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJKx+bwAOxA6fm6mbFISDpTImEEeiszFjMUteO8cNW0=;
	b=YBwhVB71ifSOMA5aBBKKQNaQ1d97GizLZyQCGNF8yZNJLwTgw+Lpk5k6inIRxwqIgDCbFd
	7Snn4l9ZHNnI/V5svtlAdHigkmplH3NwZZL6jkImTZHnNLZ8UIPLoUWdY4ntlJUsWweDMU
	fLfFN7J/Pl1CSQQld8PWPanNxe0Dejw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757649604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJKx+bwAOxA6fm6mbFISDpTImEEeiszFjMUteO8cNW0=;
	b=YBwhVB71ifSOMA5aBBKKQNaQ1d97GizLZyQCGNF8yZNJLwTgw+Lpk5k6inIRxwqIgDCbFd
	7Snn4l9ZHNnI/V5svtlAdHigkmplH3NwZZL6jkImTZHnNLZ8UIPLoUWdY4ntlJUsWweDMU
	fLfFN7J/Pl1CSQQld8PWPanNxe0Dejw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D6E513647
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFFQNMKaw2hWXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: prepare raid56 to support bs > ps cases
Date: Fri, 12 Sep 2025 13:29:39 +0930
Message-ID: <cd0c5635403bc01d55ebdca88d740dd01b821076.1757649253.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757649253.git.wqu@suse.com>
References: <cover.1757649253.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

This involves the following conversion:

- btrfs_raid_bio::nr_pages -> nr_folios
- btrfs_raid_bio::stripe_npages -> stripe_nfolios
- btrfs_raid_bio::stripe_pages[] -> stripe_folios[]
- Involved comments using "page"
- Remove the PAGE_SIZE alignment check against sectorsize

There is one exception, function raid56_parity_cache_data_pages() is
utilized by scrub, and it doesn't support bs > ps yet.

So add an ASSERT() inside that function to make sure it's only called
when bs <= ps.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/misc.h   |   5 ++
 fs/btrfs/raid56.c | 181 ++++++++++++++++++++++++----------------------
 fs/btrfs/raid56.h |  22 ++++--
 3 files changed, 115 insertions(+), 93 deletions(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 60f9b000d644..3bedffbd51ba 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -214,4 +214,9 @@ static inline u64 folio_end(struct folio *folio)
 	return folio_pos(folio) + folio_size(folio);
 }
 
+static inline phys_addr_t folio_to_phys(const struct folio *folio)
+{
+	return page_to_phys(folio_page(folio, 0));
+}
+
 #endif
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2b4f577dcf39..ac94335dd262 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -158,7 +158,7 @@ static void scrub_rbio_work_locked(struct work_struct *work);
 static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
 	bitmap_free(rbio->error_bitmap);
-	kfree(rbio->stripe_pages);
+	kfree(rbio->stripe_folios);
 	kfree(rbio->bio_sectors);
 	kfree(rbio->stripe_sectors);
 	kfree(rbio->finish_pointers);
@@ -166,8 +166,6 @@ static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 
 static void free_raid_bio(struct btrfs_raid_bio *rbio)
 {
-	int i;
-
 	if (!refcount_dec_and_test(&rbio->refs))
 		return;
 
@@ -175,10 +173,10 @@ static void free_raid_bio(struct btrfs_raid_bio *rbio)
 	WARN_ON(!list_empty(&rbio->hash_list));
 	WARN_ON(!bio_list_empty(&rbio->bio_list));
 
-	for (i = 0; i < rbio->nr_pages; i++) {
-		if (rbio->stripe_pages[i]) {
-			__free_page(rbio->stripe_pages[i]);
-			rbio->stripe_pages[i] = NULL;
+	for (int i = 0; i < rbio->nr_folios; i++) {
+		if (rbio->stripe_folios[i]) {
+			folio_put(rbio->stripe_folios[i]);
+			rbio->stripe_folios[i] = NULL;
 		}
 	}
 
@@ -299,17 +297,16 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
 	return hash_64(num >> 16, BTRFS_STRIPE_HASH_TABLE_BITS);
 }
 
-static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
-				       unsigned int page_nr)
+static bool full_folio_sectors_uptodate(struct btrfs_raid_bio *rbio,
+					unsigned int folio_nr)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	const u32 sectors_per_folio = btrfs_min_folio_size(fs_info) >> fs_info->sectorsize_bits;
 	int i;
 
-	ASSERT(page_nr < rbio->nr_pages);
+	ASSERT(folio_nr < rbio->nr_folios);
 
-	for (i = sectors_per_page * page_nr;
-	     i < sectors_per_page * page_nr + sectors_per_page;
+	for (i = sectors_per_folio * folio_nr; i < sectors_per_folio * (folio_nr + 1);
 	     i++) {
 		if (!rbio->stripe_sectors[i].uptodate)
 			return false;
@@ -324,53 +321,54 @@ static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
  */
 static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	u32 offset;
-	int i;
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	const u32 blocksize = fs_info->sectorsize;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 
-	for (i = 0, offset = 0; i < rbio->nr_sectors; i++, offset += sectorsize) {
-		int page_index = offset >> PAGE_SHIFT;
+	for (u32 offset = 0; offset < rbio->nr_folios << min_folio_shift; offset += blocksize) {
+		const unsigned int findex = offset >> min_folio_shift;
+		const unsigned int sindex = offset >> fs_info->sectorsize_bits;
+		struct folio *folio = rbio->stripe_folios[findex];
 
-		ASSERT(page_index < rbio->nr_pages);
-		if (!rbio->stripe_pages[page_index])
+		ASSERT(findex < rbio->nr_folios);
+		if (!folio)
 			continue;
-
-		rbio->stripe_sectors[i].has_paddr = true;
-		rbio->stripe_sectors[i].paddr =
-			page_to_phys(rbio->stripe_pages[page_index]) +
-			offset_in_page(offset);
+		rbio->stripe_sectors[sindex].has_paddr = true;
+		rbio->stripe_sectors[sindex].paddr = folio_to_phys(folio) +
+			offset_in_folio(folio, offset);
 	}
 }
 
-static void steal_rbio_page(struct btrfs_raid_bio *src,
-			    struct btrfs_raid_bio *dest, int page_nr)
+static void steal_rbio_folio(struct btrfs_raid_bio *src,
+			     struct btrfs_raid_bio *dest, int folio_nr)
 {
-	const u32 sectorsize = src->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
-	int i;
+	struct btrfs_fs_info *fs_info = src->bioc->fs_info;
+	const u32 sectors_per_folio = btrfs_min_folio_size(fs_info) >> fs_info->sectorsize_bits;
 
-	if (dest->stripe_pages[page_nr])
-		__free_page(dest->stripe_pages[page_nr]);
-	dest->stripe_pages[page_nr] = src->stripe_pages[page_nr];
-	src->stripe_pages[page_nr] = NULL;
+	if (dest->stripe_folios[folio_nr])
+		folio_put(dest->stripe_folios[folio_nr]);
+	dest->stripe_folios[folio_nr] = src->stripe_folios[folio_nr];
+	src->stripe_folios[folio_nr] = NULL;
 
 	/* Also update the sector->uptodate bits. */
-	for (i = sectors_per_page * page_nr;
-	     i < sectors_per_page * page_nr + sectors_per_page; i++)
+	for (int i = sectors_per_folio * folio_nr;
+	     i < sectors_per_folio * (folio_nr + 1); i++)
 		dest->stripe_sectors[i].uptodate = true;
 }
 
-static bool is_data_stripe_page(struct btrfs_raid_bio *rbio, int page_nr)
+static bool is_data_stripe_folio(struct btrfs_raid_bio *rbio, int folio_nr)
 {
-	const int sector_nr = (page_nr << PAGE_SHIFT) >>
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	const unsigned int min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
+	const int sector_nr = (folio_nr << min_folio_shift) >>
 			      rbio->bioc->fs_info->sectorsize_bits;
 
 	/*
-	 * We have ensured PAGE_SIZE is aligned with sectorsize, thus
-	 * we won't have a page which is half data half parity.
+	 * We have ensured folio size is aligned with sectorsize, thus
+	 * we won't have a folio which is half data half parity.
 	 *
-	 * Thus if the first sector of the page belongs to data stripes, then
-	 * the full page belongs to data stripes.
+	 * Thus if the first sector of the folio belongs to data stripes, then
+	 * the full folio belongs to data stripes.
 	 */
 	return (sector_nr < rbio->nr_data * rbio->stripe_nsectors);
 }
@@ -384,28 +382,26 @@ static bool is_data_stripe_page(struct btrfs_raid_bio *rbio, int page_nr)
  */
 static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 {
-	int i;
-
 	if (!test_bit(RBIO_CACHE_READY_BIT, &src->flags))
 		return;
 
-	for (i = 0; i < dest->nr_pages; i++) {
-		struct page *p = src->stripe_pages[i];
+	for (int i = 0; i < dest->nr_folios; i++) {
+		struct folio *folio = src->stripe_folios[i];
 
 		/*
-		 * We don't need to steal P/Q pages as they will always be
+		 * We don't need to steal P/Q folio as they will always be
 		 * regenerated for RMW or full write anyway.
 		 */
-		if (!is_data_stripe_page(src, i))
+		if (!is_data_stripe_folio(src, i))
 			continue;
 
 		/*
 		 * If @src already has RBIO_CACHE_READY_BIT, it should have
 		 * all data stripe pages present and uptodate.
 		 */
-		ASSERT(p);
-		ASSERT(full_page_sectors_uptodate(src, i));
-		steal_rbio_page(src, dest, i);
+		ASSERT(folio);
+		ASSERT(full_folio_sectors_uptodate(src, i));
+		steal_rbio_folio(src, dest, i);
 	}
 	index_stripe_sectors(dest);
 	index_stripe_sectors(src);
@@ -991,16 +987,15 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_io_context *bioc)
 {
+	const unsigned int min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	const unsigned int real_stripes = bioc->num_stripes - bioc->replace_nr_stripes;
-	const unsigned int stripe_npages = BTRFS_STRIPE_LEN >> PAGE_SHIFT;
-	const unsigned int num_pages = stripe_npages * real_stripes;
+	const unsigned int stripe_nfolios = BTRFS_STRIPE_LEN >> min_folio_shift;
+	const unsigned int num_folios = stripe_nfolios * real_stripes;
 	const unsigned int stripe_nsectors =
 		BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
 	const unsigned int num_sectors = stripe_nsectors * real_stripes;
 	struct btrfs_raid_bio *rbio;
 
-	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
-	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
 	/*
 	 * Our current stripe len should be fixed to 64k thus stripe_nsectors
 	 * (at most 16) should be no larger than BITS_PER_LONG.
@@ -1017,8 +1012,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio = kzalloc(sizeof(*rbio), GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
-	rbio->stripe_pages = kcalloc(num_pages, sizeof(struct page *),
-				     GFP_NOFS);
+	rbio->stripe_folios = kcalloc(num_folios, sizeof(struct folio *), GFP_NOFS);
 	rbio->bio_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
 				    GFP_NOFS);
 	rbio->stripe_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
@@ -1026,7 +1020,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
 	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 
-	if (!rbio->stripe_pages || !rbio->bio_sectors || !rbio->stripe_sectors ||
+	if (!rbio->stripe_folios || !rbio->bio_sectors || !rbio->stripe_sectors ||
 	    !rbio->finish_pointers || !rbio->error_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
@@ -1041,10 +1035,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&rbio->hash_list);
 	btrfs_get_bioc(bioc);
 	rbio->bioc = bioc;
-	rbio->nr_pages = num_pages;
+	rbio->nr_folios = num_folios;
 	rbio->nr_sectors = num_sectors;
 	rbio->real_stripes = real_stripes;
-	rbio->stripe_npages = stripe_npages;
+	rbio->stripe_nfolios = stripe_nfolios;
 	rbio->stripe_nsectors = stripe_nsectors;
 	refcount_set(&rbio->refs, 1);
 	atomic_set(&rbio->stripes_pending, 0);
@@ -1061,7 +1055,8 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	int ret;
 
-	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages, false);
+	ret = btrfs_alloc_folio_array(rbio->nr_folios, rbio->bioc->fs_info->block_min_order,
+				      rbio->stripe_folios);
 	if (ret < 0)
 		return ret;
 	/* Mapping all sectors */
@@ -1072,14 +1067,14 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 /* only allocate pages for p/q stripes */
 static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 {
-	const int data_pages = rbio->nr_data * rbio->stripe_npages;
+	const unsigned int data_folios = rbio->nr_data * rbio->stripe_nfolios;
 	int ret;
 
-	ret = btrfs_alloc_page_array(rbio->nr_pages - data_pages,
-				     rbio->stripe_pages + data_pages, false);
+	ret = btrfs_alloc_folio_array(rbio->nr_folios - data_folios,
+				      rbio->bioc->fs_info->block_min_order,
+				      rbio->stripe_folios + data_folios);
 	if (ret < 0)
 		return ret;
-
 	index_stripe_sectors(rbio);
 	return 0;
 }
@@ -1488,7 +1483,7 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 /*
  * For subpage case, we can no longer set page Up-to-date directly for
- * stripe_pages[], thus we need to locate the sector.
+ * stripe_folios[], thus we need to locate the sector.
  */
 static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
 					     phys_addr_t paddr)
@@ -1633,10 +1628,11 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
 
 static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
 {
-	const int data_pages = rbio->nr_data * rbio->stripe_npages;
+	const unsigned int data_folios = rbio->nr_data * rbio->stripe_nfolios;
 	int ret;
 
-	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages, false);
+	ret = btrfs_alloc_folio_array(data_folios, rbio->bioc->fs_info->block_min_order,
+				      rbio->stripe_folios);
 	if (ret < 0)
 		return ret;
 
@@ -2475,23 +2471,25 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
  */
 static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	int total_sector_nr;
 
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		struct page *page;
+		struct folio *folio;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		int index = (total_sector_nr * sectorsize) >> PAGE_SHIFT;
+		unsigned int findex = (total_sector_nr * sectorsize) >> min_folio_shift;
 
 		if (!test_bit(sectornr, &rbio->dbitmap))
 			continue;
-		if (rbio->stripe_pages[index])
+		if (rbio->stripe_folios[findex])
 			continue;
-		page = alloc_page(GFP_NOFS);
-		if (!page)
+		folio = folio_alloc(GFP_NOFS, fs_info->block_min_order);
+		if (!folio)
 			return -ENOMEM;
-		rbio->stripe_pages[index] = page;
+		rbio->stripe_folios[findex] = folio;
 	}
 	index_stripe_sectors(rbio);
 	return 0;
@@ -2850,13 +2848,19 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 				    struct page **data_pages, u64 data_logical)
 {
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	const u64 offset_in_full_stripe = data_logical -
 					  rbio->bioc->full_stripe_logical;
-	const int page_index = offset_in_full_stripe >> PAGE_SHIFT;
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	int ret;
 
+	/*
+	 * The caller is not yet converted to follow min_folio_shift. So our
+	 * minimal folio order must be 0 for now.
+	 */
+	ASSERT(fs_info->block_min_order == 0);
+
 	/*
 	 * If we hit ENOMEM temporarily, but later at
 	 * raid56_parity_submit_scrub_rbio() time it succeeded, we just do
@@ -2873,13 +2877,20 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 	ASSERT(IS_ALIGNED(offset_in_full_stripe, BTRFS_STRIPE_LEN));
 	ASSERT(offset_in_full_stripe < (rbio->nr_data << BTRFS_STRIPE_LEN_SHIFT));
 
-	for (int page_nr = 0; page_nr < (BTRFS_STRIPE_LEN >> PAGE_SHIFT); page_nr++) {
-		struct page *dst = rbio->stripe_pages[page_nr + page_index];
-		struct page *src = data_pages[page_nr];
+	for (int cur = offset_in_full_stripe; cur < offset_in_full_stripe + BTRFS_STRIPE_LEN;
+	     cur += min_folio_size) {
+		struct folio *dest = rbio->stripe_folios[cur >> min_folio_shift];
+		struct folio *src = page_folio(data_pages[(cur - offset_in_full_stripe) >>
+							  min_folio_shift]);
 
-		memcpy_page(dst, 0, src, 0, PAGE_SIZE);
-		for (int sector_nr = sectors_per_page * page_index;
-		     sector_nr < sectors_per_page * (page_index + 1);
+		ASSERT(dest);
+		ASSERT(src);
+		/* Folios from source and destination should have the same order. */
+		ASSERT(folio_order(dest) == folio_order(src));
+		folio_copy(dest, src);
+
+		for (int sector_nr = cur >> fs_info->sectorsize_bits;
+		     sector_nr < (cur + BTRFS_STRIPE_LEN) >> fs_info->sectorsize_bits;
 		     sector_nr++)
 			rbio->stripe_sectors[sector_nr].uptodate = true;
 	}
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 0d7b4c2fb6ae..ddf6a7687eb6 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -64,8 +64,11 @@ struct btrfs_raid_bio {
 	 */
 	enum btrfs_rbio_ops operation;
 
-	/* How many pages there are for the full stripe including P/Q */
-	u16 nr_pages;
+	/*
+	 * How many folios there are for the full stripe including P/Q.
+	 * The folio size should be based on the fs_info::block_min_order.
+	 */
+	u16 nr_folios;
 
 	/* How many sectors there are for the full stripe including P/Q */
 	u16 nr_sectors;
@@ -76,8 +79,8 @@ struct btrfs_raid_bio {
 	/* Number of all stripes (including P/Q) */
 	u8 real_stripes;
 
-	/* How many pages there are for each stripe */
-	u8 stripe_npages;
+	/* How many folios there are for each stripe. */
+	u8 stripe_nfolios;
 
 	/* How many sectors there are for each stripe */
 	u8 stripe_nsectors;
@@ -110,17 +113,20 @@ struct btrfs_raid_bio {
 	 */
 
 	/*
-	 * Pointers to pages that we allocated for reading/writing stripes
+	 * Pointers to folios that we allocated for reading/writing stripes
 	 * directly from the disk (including P/Q).
+	 *
+	 * All folios are following fs_info::block_min_order, so that no block
+	 * will cross folio boundary.
 	 */
-	struct page **stripe_pages;
+	struct folio **stripe_folios;
 
 	/* Pointers to the sectors in the bio_list, for faster lookup */
 	struct sector_ptr *bio_sectors;
 
 	/*
-	 * For subpage support, we need to map each sector to above
-	 * stripe_pages.
+	 * For bs < ps support, we need to map each sector to above
+	 * stripe_folios.
 	 */
 	struct sector_ptr *stripe_sectors;
 
-- 
2.50.1


