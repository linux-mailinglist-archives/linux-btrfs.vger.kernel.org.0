Return-Path: <linux-btrfs+bounces-16798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3ACB54157
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 06:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEAA3AA987
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 04:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948502367A8;
	Fri, 12 Sep 2025 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vWMJaKnX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vWMJaKnX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0C214A9B
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649612; cv=none; b=g9xILZaNFQbxcPL5e83qFbSNPBZtoIa0QPWtf10pKI0BlI44fa4c/v0F+lAEA0JjdnI2jVr3Wd2nfyVAKr465Gan3ibG9icq3xBe8Lie0MOaurdcSWFyO+uLdjjujlkdMkkM2vSs1DhmUgkfISh4gyaM49YEC5Nr7vGcTc0ZJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649612; c=relaxed/simple;
	bh=lUEetefToDF/LAfZChWMOqYIxSoEK7hjzhiUh/bRxh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOhKAKpfHjEnSmgtVzX/dZIuoiB7t5PDIrtttgaDktWGjWrM8TA+fZyprTLT8pbsq3Hm49Wkd3aRyz9RYtnMP66BJP2pBUuCgotAWovsrIoEGPJKVBlqVc2mjoC5FKbIVSad0/wPaQqLrEN/1UG14/r+fx769/q//jn0pnsZfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vWMJaKnX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vWMJaKnX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16E5A3FC96
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757649605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0RSqwGZ/lWTT6ix8yGljs4c7rdZ0+7eHjU7qZrkSHk=;
	b=vWMJaKnX5+OozqFzgB0Rxyg+dVc5buVyyMXa+Ar6pWeX/DwqHUjtlVw+fwUVvpzg2u1J3T
	rxBtQuZYesoodXvOrwdfHXIKb0ZWIyFCZfR28iu3BI4QzTXXTKfa1yJHwv/HgeEjqXISho
	6+PMT9Hp8i8yZpDytrTqIXnKubADj3k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757649605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0RSqwGZ/lWTT6ix8yGljs4c7rdZ0+7eHjU7qZrkSHk=;
	b=vWMJaKnX5+OozqFzgB0Rxyg+dVc5buVyyMXa+Ar6pWeX/DwqHUjtlVw+fwUVvpzg2u1J3T
	rxBtQuZYesoodXvOrwdfHXIKb0ZWIyFCZfR28iu3BI4QzTXXTKfa1yJHwv/HgeEjqXISho
	6+PMT9Hp8i8yZpDytrTqIXnKubADj3k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B0A13647
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8PIqBsSaw2hWXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: prepare scrub to support bs > ps cases
Date: Fri, 12 Sep 2025 13:29:40 +0930
Message-ID: <a4ed5a16f78a8dd5ece75c91a6c1f6c9fb6df6dd.1757649253.git.wqu@suse.com>
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

Since most scrub code is based on kaddr/paddr, the migration itself is
pretty straightforward.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 15 ++++----------
 fs/btrfs/raid56.h |  4 ++--
 fs/btrfs/scrub.c  | 51 +++++++++++++++++++++++++++--------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ac94335dd262..4074ff4ddb1d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2842,11 +2842,11 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
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
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	const u64 offset_in_full_stripe = data_logical -
@@ -2855,12 +2855,6 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 	const u32 min_folio_shift = PAGE_SHIFT + fs_info->block_min_order;
 	int ret;
 
-	/*
-	 * The caller is not yet converted to follow min_folio_shift. So our
-	 * minimal folio order must be 0 for now.
-	 */
-	ASSERT(fs_info->block_min_order == 0);
-
 	/*
 	 * If we hit ENOMEM temporarily, but later at
 	 * raid56_parity_submit_scrub_rbio() time it succeeded, we just do
@@ -2880,8 +2874,7 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 	for (int cur = offset_in_full_stripe; cur < offset_in_full_stripe + BTRFS_STRIPE_LEN;
 	     cur += min_folio_size) {
 		struct folio *dest = rbio->stripe_folios[cur >> min_folio_shift];
-		struct folio *src = page_folio(data_pages[(cur - offset_in_full_stripe) >>
-							  min_folio_shift]);
+		struct folio *src = data_folios[(cur - offset_in_full_stripe) >> min_folio_shift];
 
 		ASSERT(dest);
 		ASSERT(src);
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index ddf6a7687eb6..5662a3a2f04b 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -207,8 +207,8 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
-void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
-				    struct page **data_pages, u64 data_logical);
+void raid56_parity_cache_data_folios(struct btrfs_raid_bio *rbio,
+				     struct folio **data_folios, u64 data_logical);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 979d33d8c193..cddf798c32e8 100644
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
+	return folio_to_phys(folio) + offset_in_folio(folio, offset);
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


