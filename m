Return-Path: <linux-btrfs+bounces-16903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDDBB822FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B04E6275E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A163101C0;
	Wed, 17 Sep 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fpYc1CEk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fpYc1CEk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8A30FC28
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149222; cv=none; b=fzSqIMNVDgoVrN+TumKM4E87qPggeAdHw7qpJBsUIZsaWsOUR9GOjWmMiKwS9A9MGQ90mHDd+7Rkg6Pna0UKcR2UaS2h28AZURJsmoMfkkqT3XWbkRF1XRPWqEk/LIVOfd4OgyMvuVpBr4FDABVXb71vL33BsI2MgO84we0oG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149222; c=relaxed/simple;
	bh=1Cau5AQfBCz9ik1+ee81XpeI1iCa9vHsNvCg9pxscx8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+pguV7YVOzoB5Xyy8/5XZ0lAirG//OQ+pNzMI04MIRRtsMeFiEZ+rhzPsazw7jEss5nLG3cWdCEbAKp6zm8d9Xx8QhlF/KR34fhJVbsVOUw/TRq6h3F+xmDo974prWo/DP2JjbgUtdJChMnbQ7HrT6jDq7FSbNFJJRQDku1n5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fpYc1CEk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fpYc1CEk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37D1D5D1CD
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcRllXLpwbaZp4Ax0zRgnoMwSpaZZQ3M5/mnPxIaFcU=;
	b=fpYc1CEkriufW8d1RlCItlrUsK86J5MfN9LwqPNB7dgiYwRDXoycvA0lJC+37X45Tdxrm+
	fYkDgL21ZkgIQDXXmXckrG0y27NTT0rAg6WcbuaEHE0ZFta5r+CUBQ0qWx5uZMVPPqA8CA
	qc8cnYJWaNJVJUH6HePtRwYTbwXrGUk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcRllXLpwbaZp4Ax0zRgnoMwSpaZZQ3M5/mnPxIaFcU=;
	b=fpYc1CEkriufW8d1RlCItlrUsK86J5MfN9LwqPNB7dgiYwRDXoycvA0lJC+37X45Tdxrm+
	fYkDgL21ZkgIQDXXmXckrG0y27NTT0rAg6WcbuaEHE0ZFta5r+CUBQ0qWx5uZMVPPqA8CA
	qc8cnYJWaNJVJUH6HePtRwYTbwXrGUk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79B9D1368D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBOiD1E6y2j/HQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 5/8] btrfs: prepare scrub to support bs > ps cases
Date: Thu, 18 Sep 2025 08:16:10 +0930
Message-ID: <92de06f115e9907b3a9b3b191e2839d8f04b8d4e.1758147788.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758147788.git.wqu@suse.com>
References: <cover.1758147788.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

This involves:

- Migrate scrub_stripe::pages[] to folios[]

- Use btrfs_alloc_folio_array() and folio_put() to alloc above array.

- Migrate scrub_stripe_get_kaddr() and scrub_stripe_get_paddr() to use
  folio interfaces

- Migrate raid56_parity_cache_data_pages() to
  raid56_parity_cache_data_folios()
  Since scrub is the only caller still using pages.

  This helper will copy the folio array contents into rbio::stripe_pages,
  with sector uptodate flags updated.

  And a new ASSERT() to make sure bs > ps cases will not hit this path.

Since most scrub code is based on kaddr/paddr, the migration itself is
pretty straightforward.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 43 ++++++++++++++++++++++++++++-----------
 fs/btrfs/raid56.h |  4 ++--
 fs/btrfs/scrub.c  | 51 +++++++++++++++++++++++++++--------------------
 3 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2b4f577dcf39..c1aa4b3edcec 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2844,19 +2844,24 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
  * This is for scrub call sites where we already have correct data contents.
  * This allows us to avoid reading data stripes again.
  *
- * Unfortunately here we have to do page copy, other than reusing the pages.
+ * Unfortunately here we have to do folio copy, other than reusing the pages.
  * This is due to the fact rbio has its own page management for its cache.
  */
-void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
-				    struct page **data_pages, u64 data_logical)
+void raid56_parity_cache_data_folios(struct btrfs_raid_bio *rbio,
+				     struct folio **data_folios, u64 data_logical)
 {
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	const u64 offset_in_full_stripe = data_logical -
 					  rbio->bioc->full_stripe_logical;
-	const int page_index = offset_in_full_stripe >> PAGE_SHIFT;
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	const u32 sectors_per_page = PAGE_SIZE >> fs_info->sectorsize_bits;
+	u32 cur_off = offset_in_full_stripe;
+	unsigned int findex = 0;
+	unsigned int foffset = 0;
 	int ret;
 
+	/* We shouldn't hit RAID56 for bs > ps cases for now. */
+	ASSERT(sectors_per_page > 0);
+
 	/*
 	 * If we hit ENOMEM temporarily, but later at
 	 * raid56_parity_submit_scrub_rbio() time it succeeded, we just do
@@ -2873,14 +2878,28 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 	ASSERT(IS_ALIGNED(offset_in_full_stripe, BTRFS_STRIPE_LEN));
 	ASSERT(offset_in_full_stripe < (rbio->nr_data << BTRFS_STRIPE_LEN_SHIFT));
 
-	for (int page_nr = 0; page_nr < (BTRFS_STRIPE_LEN >> PAGE_SHIFT); page_nr++) {
-		struct page *dst = rbio->stripe_pages[page_nr + page_index];
-		struct page *src = data_pages[page_nr];
+	while (cur_off <= offset_in_full_stripe + BTRFS_STRIPE_LEN) {
+		const unsigned int pindex = cur_off >> PAGE_SHIFT;
+		unsigned int copy_len = min(PAGE_SIZE, folio_size(data_folios[findex]));
+		void *kaddr;
 
-		memcpy_page(dst, 0, src, 0, PAGE_SIZE);
-		for (int sector_nr = sectors_per_page * page_index;
-		     sector_nr < sectors_per_page * (page_index + 1);
+		ASSERT(IS_ALIGNED(cur_off, PAGE_SIZE));
+
+		kaddr = kmap_local_page(rbio->stripe_pages[pindex]);
+		memcpy_from_folio(kaddr, data_folios[findex], foffset, copy_len);
+		kunmap_local(kaddr);
+
+		for (int sector_nr = sectors_per_page * pindex;
+		     sector_nr < sectors_per_page * (pindex + 1);
 		     sector_nr++)
 			rbio->stripe_sectors[sector_nr].uptodate = true;
+
+		cur_off += copy_len;
+		foffset += copy_len;
+		ASSERT(foffset <= folio_size(data_folios[findex]));
+		if (foffset == folio_size(data_folios[findex])) {
+			findex++;
+			foffset = 0;
+		}
 	}
 }
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 0d7b4c2fb6ae..84c4d1d29c7a 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -201,8 +201,8 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
-void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
-				    struct page **data_pages, u64 data_logical);
+void raid56_parity_cache_data_folios(struct btrfs_raid_bio *rbio,
+				     struct folio **data_folios, u64 data_logical);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 979d33d8c193..bf50556f186e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -130,7 +130,7 @@ enum {
 	scrub_bitmap_nr_last,
 };
 
-#define SCRUB_STRIPE_PAGES		(BTRFS_STRIPE_LEN / PAGE_SIZE)
+#define SCRUB_STRIPE_MAX_FOLIOS		(BTRFS_STRIPE_LEN / PAGE_SIZE)
 
 /*
  * Represent one contiguous range with a length of BTRFS_STRIPE_LEN.
@@ -139,7 +139,7 @@ struct scrub_stripe {
 	struct scrub_ctx *sctx;
 	struct btrfs_block_group *bg;
 
-	struct page *pages[SCRUB_STRIPE_PAGES];
+	struct folio *folios[SCRUB_STRIPE_MAX_FOLIOS];
 	struct scrub_sector_verification *sectors;
 
 	struct btrfs_device *dev;
@@ -339,10 +339,10 @@ static void release_scrub_stripe(struct scrub_stripe *stripe)
 	if (!stripe)
 		return;
 
-	for (int i = 0; i < SCRUB_STRIPE_PAGES; i++) {
-		if (stripe->pages[i])
-			__free_page(stripe->pages[i]);
-		stripe->pages[i] = NULL;
+	for (int i = 0; i < SCRUB_STRIPE_MAX_FOLIOS; i++) {
+		if (stripe->folios[i])
+			folio_put(stripe->folios[i]);
+		stripe->folios[i] = NULL;
 	}
 	kfree(stripe->sectors);
 	kfree(stripe->csums);
@@ -355,6 +355,7 @@ static void release_scrub_stripe(struct scrub_stripe *stripe)
 static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 			     struct scrub_stripe *stripe)
 {
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	int ret;
 
 	memset(stripe, 0, sizeof(*stripe));
@@ -367,7 +368,9 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 	atomic_set(&stripe->pending_io, 0);
 	spin_lock_init(&stripe->write_error_lock);
 
-	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages, false);
+	ASSERT(BTRFS_STRIPE_LEN >> min_folio_shift <= SCRUB_STRIPE_MAX_FOLIOS);
+	ret = btrfs_alloc_folio_array(BTRFS_STRIPE_LEN >> min_folio_shift,
+				      fs_info->block_min_order, stripe->folios);
 	if (ret < 0)
 		goto error;
 
@@ -687,27 +690,30 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 
 static void *scrub_stripe_get_kaddr(struct scrub_stripe *stripe, int sector_nr)
 {
-	u32 offset = (sector_nr << stripe->bg->fs_info->sectorsize_bits);
-	const struct page *page = stripe->pages[offset >> PAGE_SHIFT];
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
+	u32 offset = (sector_nr << fs_info->sectorsize_bits);
+	const struct folio *folio = stripe->folios[offset >> min_folio_shift];
 
-	/* stripe->pages[] is allocated by us and no highmem is allowed. */
-	ASSERT(page);
-	ASSERT(!PageHighMem(page));
-	return page_address(page) + offset_in_page(offset);
+	/* stripe->folios[] is allocated by us and no highmem is allowed. */
+	ASSERT(folio);
+	ASSERT(!folio_test_partial_kmap(folio));
+	return folio_address(folio) + offset_in_folio(folio, offset);
 }
 
 static phys_addr_t scrub_stripe_get_paddr(struct scrub_stripe *stripe, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	u32 offset = (sector_nr << fs_info->sectorsize_bits);
-	const struct page *page = stripe->pages[offset >> PAGE_SHIFT];
+	const struct folio *folio = stripe->folios[offset >> min_folio_shift];
 
-	/* stripe->pages[] is allocated by us and no highmem is allowed. */
-	ASSERT(page);
-	ASSERT(!PageHighMem(page));
-	/* And the range must be contained inside the page. */
-	ASSERT(offset_in_page(offset) + fs_info->sectorsize <= PAGE_SIZE);
-	return page_to_phys(page) + offset_in_page(offset);
+	/* stripe->folios[] is allocated by us and no highmem is allowed. */
+	ASSERT(folio);
+	ASSERT(!folio_test_partial_kmap(folio));
+	/* And the range must be contained inside the folio. */
+	ASSERT(offset_in_folio(folio, offset) + fs_info->sectorsize <= folio_size(folio));
+	return page_to_phys(folio_page(folio, 0)) + offset_in_folio(folio, offset);
 }
 
 static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
@@ -1872,6 +1878,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
+	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	unsigned int nr_sectors = stripe_length(stripe) >> fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
@@ -1884,7 +1891,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 		return;
 	}
 
-	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
+	bbio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> min_folio_shift, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 
 	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
@@ -2215,7 +2222,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	for (int i = 0; i < data_stripes; i++) {
 		stripe = &sctx->raid56_data_stripes[i];
 
-		raid56_parity_cache_data_pages(rbio, stripe->pages,
+		raid56_parity_cache_data_folios(rbio, stripe->folios,
 				full_stripe_start + (i << BTRFS_STRIPE_LEN_SHIFT));
 	}
 	raid56_parity_submit_scrub_rbio(rbio);
-- 
2.50.1


