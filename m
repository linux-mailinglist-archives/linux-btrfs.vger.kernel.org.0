Return-Path: <linux-btrfs+bounces-19059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C73C62BC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36B564EC909
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E13191BF;
	Mon, 17 Nov 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sGTGDTts";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sGTGDTts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578572EA749
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364708; cv=none; b=hRvqZA7qWd4MX7JeFbuW0aNT/HiTtDNJRENEnj2fGQS7mVCSvHb38nPAvOzgFYQoimS6Gv8x+SKIflemxAeQWKfqHo0Gub//UNxTc/yXdCk0ybkBrG5qKe2VTQC04+1W5e3u2WPSO1eHGnOoMBJK/xXZHvtPF0g+5OBJK3tJx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364708; c=relaxed/simple;
	bh=GftiFXSNKEjvHyz0qmAS3TmMDqqJNDG2yzS5L8bXoxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUZdpScaI1WZ4EH5oxOtEyw+wJcX6t2YwoG5wimYDmovaXHrTiKztmpgJKitTij+oDXx6UrfLYl5YCs923JLDZeUEA5+/6z5dcg4lFW1hLFh/azwoHjrJhCwZFAakXfdoYj/g+0AR7gBDcdgtHreqNMnKxu4yxLzWUqxOID1i9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sGTGDTts; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sGTGDTts; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3FC921209
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xB6xk89V4V0hzt9DhhLl2ds3hiliIAW+NHkrO3l6OvE=;
	b=sGTGDTts1kR8LiS3p/2QWk8HmjhAHcSRN0+AI2jb/8mw3sxv1nbxNdLQcZU5i2h98WySL4
	CQNFsKsTPR68FdQOHyPIlUzeYXwZraFdgXJXQ7yiW6WkkPP+yw0kEgR3cBifv+MC+Sdu7P
	9Hj2yXDoFTMudXUEGrUV0+A9J3HuDlo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xB6xk89V4V0hzt9DhhLl2ds3hiliIAW+NHkrO3l6OvE=;
	b=sGTGDTts1kR8LiS3p/2QWk8HmjhAHcSRN0+AI2jb/8mw3sxv1nbxNdLQcZU5i2h98WySL4
	CQNFsKsTPR68FdQOHyPIlUzeYXwZraFdgXJXQ7yiW6WkkPP+yw0kEgR3cBifv+MC+Sdu7P
	9Hj2yXDoFTMudXUEGrUV0+A9J3HuDlo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39F9A3EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qCYKO0rPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: prepare finish_parity_scrub() to support bs > ps cases
Date: Mon, 17 Nov 2025 18:00:50 +1030
Message-ID: <25850cab671970eb8a09670511fc943fba47eeaa.1763361991.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763361991.git.wqu@suse.com>
References: <cover.1763361991.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
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
X-Spam-Level: 

The function finish_parity_scrub() assume each fs block can be mapped by
one page, blocking bs > ps support for raid56.

Prepare it for bs > ps cases by:

- Introduce a helper, verify_one_parity_step()
  Since the P/Q generation is always done in a vertical stripe, we have
  to handle the range step by step.

- Only clear the rbio->dbitmap if all steps of an fs block match

- Remove rbio_stripe_paddr() and sector_paddr_in_rbio() helpers
  Now we either use the paddrs version for checksum, or the step version
  for P/Q generation/recovery.

- Make alloc_rbio_essential_pages() to handle bs > ps cases
  Since for bs > ps cases, one fs block needs multiple pages, the
  existing simple check against rbio->stripe_pages[] is not enough.

  Extract a dedicated helper, alloc_rbio_sector_pages(), for the
  existing alloc_rbio_essential_pages(), which is still based on sector
  number.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 175 +++++++++++++++++++++++-----------------------
 1 file changed, 86 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 44eede8d9544..d8d3af2c4db5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -735,13 +735,6 @@ static unsigned int rbio_paddr_index(const struct btrfs_raid_bio *rbio,
 	return ret;
 }
 
-/* Return a paddr from rbio->stripe_sectors, not from the bio list */
-static phys_addr_t rbio_stripe_paddr(const struct btrfs_raid_bio *rbio,
-				     unsigned int stripe_nr, unsigned int sector_nr)
-{
-	return rbio->stripe_paddrs[rbio_paddr_index(rbio, stripe_nr, sector_nr, 0)];
-}
-
 static phys_addr_t rbio_stripe_step_paddr(const struct btrfs_raid_bio *rbio,
 					  unsigned int stripe_nr, unsigned int sector_nr,
 					  unsigned int step_nr)
@@ -1001,46 +994,6 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t status)
 		rbio_endio_bio_list(extra, status);
 }
 
-/*
- * Get the paddr specified by its @stripe_nr and @sector_nr.
- *
- * @rbio:               The raid bio
- * @stripe_nr:          Stripe number, valid range [0, real_stripe)
- * @sector_nr:		Sector number inside the stripe,
- *			valid range [0, stripe_nsectors)
- * @bio_list_only:      Whether to use sectors inside the bio list only.
- *
- * The read/modify/write code wants to reuse the original bio page as much
- * as possible, and only use stripe_sectors as fallback.
- */
-static phys_addr_t sector_paddr_in_rbio(struct btrfs_raid_bio *rbio,
-					int stripe_nr, int sector_nr,
-					bool bio_list_only)
-{
-	phys_addr_t ret = INVALID_PADDR;
-	int index;
-
-	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->real_stripes,
-			   rbio, stripe_nr);
-	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
-			   rbio, sector_nr);
-
-	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
-	ASSERT(index >= 0 && index < rbio->nr_sectors);
-
-	spin_lock(&rbio->bio_list_lock);
-	if (rbio->bio_paddrs[index] != INVALID_PADDR || bio_list_only) {
-		/* Don't return sector without a valid page pointer */
-		if (rbio->bio_paddrs[index] != INVALID_PADDR)
-			ret = rbio->bio_paddrs[index];
-		spin_unlock(&rbio->bio_list_lock);
-		return ret;
-	}
-	spin_unlock(&rbio->bio_list_lock);
-
-	return rbio->stripe_paddrs[index];
-}
-
 /*
  * Get paddr pointer for the sector specified by its @stripe_nr and @sector_nr.
  *
@@ -2635,42 +2588,115 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	return rbio;
 }
 
+static int alloc_rbio_sector_pages(struct btrfs_raid_bio *rbio,
+				  int sector_nr)
+{
+	const u32 step = min(PAGE_SIZE, rbio->bioc->fs_info->sectorsize);
+	const u32 base = sector_nr * rbio->sector_nsteps;
+
+	for (int i = base; i < base + rbio->sector_nsteps; i++) {
+		const unsigned int page_index = (i * step) >> PAGE_SHIFT;
+		struct page *page;
+
+		if (rbio->stripe_pages[page_index])
+			continue;
+		page = alloc_page(GFP_NOFS);
+		if (!page)
+			return -ENOMEM;
+		rbio->stripe_pages[page_index] = page;
+	}
+	return 0;
+}
+
 /*
  * We just scrub the parity that we have correct data on the same horizontal,
  * so we needn't allocate all pages for all the stripes.
  */
 static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	int total_sector_nr;
 
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		struct page *page;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		int index = (total_sector_nr * sectorsize) >> PAGE_SHIFT;
+		int ret;
 
 		if (!test_bit(sectornr, &rbio->dbitmap))
 			continue;
-		if (rbio->stripe_pages[index])
-			continue;
-		page = alloc_page(GFP_NOFS);
-		if (!page)
-			return -ENOMEM;
-		rbio->stripe_pages[index] = page;
+		ret = alloc_rbio_sector_pages(rbio, total_sector_nr);
+		if (ret < 0)
+			return ret;
 	}
 	index_stripe_sectors(rbio);
 	return 0;
 }
 
+/* Return true if the content of the step matches the caclulated one. */
+static bool verify_one_parity_step(struct btrfs_raid_bio *rbio,
+				   void *pointers[], unsigned int sector_nr,
+				   unsigned int step_nr)
+{
+	const unsigned int nr_data = rbio->nr_data;
+	const bool has_qstripe = (rbio->real_stripes - rbio->nr_data == 2);
+	const u32 step = min(rbio->bioc->fs_info->sectorsize, PAGE_SIZE);
+	void *parity;
+	bool ret = false;
+
+	ASSERT(step_nr < rbio->sector_nsteps);
+
+	/* first collect one page from each data stripe */
+	for (int stripe = 0; stripe < nr_data; stripe++)
+		pointers[stripe] = kmap_local_paddr(
+				sector_step_paddr_in_rbio(rbio, stripe, sector_nr, step_nr, 0));
+
+	if (has_qstripe) {
+		assert_rbio(rbio);
+		/* RAID6, call the library function to fill in our P/Q */
+		raid6_call.gen_syndrome(rbio->real_stripes, step, pointers);
+	} else {
+		/* raid5 */
+		memcpy(pointers[nr_data], pointers[0], step);
+		run_xor(pointers + 1, nr_data - 1, step);
+	}
+
+	/* Check scrubbing parity and repair it */
+	parity = kmap_local_paddr(rbio_stripe_step_paddr(rbio, rbio->scrubp, sector_nr, step_nr));
+	if (memcmp(parity, pointers[rbio->scrubp], step) != 0)
+		memcpy(parity, pointers[rbio->scrubp], step);
+	else
+		ret = true;
+	kunmap_local(parity);
+
+	for (int stripe = nr_data - 1; stripe >= 0; stripe--)
+		kunmap_local(pointers[stripe]);
+	return ret;
+}
+
+/*
+ * The @pointers array should have the P/Q parity already mapped.
+ */
+static void verify_one_parity_sector(struct btrfs_raid_bio *rbio,
+				    void *pointers[], unsigned int sector_nr)
+{
+	bool found_error = false;
+
+	for (int step_nr = 0; step_nr < rbio->sector_nsteps; step_nr++) {
+		bool match;
+
+		match = verify_one_parity_step(rbio, pointers, sector_nr, step_nr);
+		if (!match)
+			found_error = true;
+	}
+	if (!found_error)
+		bitmap_clear(&rbio->dbitmap, sector_nr, 1);
+}
+
 static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
-	const u32 sectorsize = bioc->fs_info->sectorsize;
 	void **pointers = rbio->finish_pointers;
 	unsigned long *pbitmap = &rbio->finish_pbitmap;
 	int nr_data = rbio->nr_data;
-	int stripe;
 	int sectornr;
 	bool has_qstripe;
 	struct page *page;
@@ -2729,37 +2755,8 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 
 	/* Map the parity stripe just once */
 
-	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		void *parity;
-
-		/* first collect one page from each data stripe */
-		for (stripe = 0; stripe < nr_data; stripe++)
-			pointers[stripe] = kmap_local_paddr(
-					sector_paddr_in_rbio(rbio, stripe, sectornr, 0));
-
-		if (has_qstripe) {
-			assert_rbio(rbio);
-			/* RAID6, call the library function to fill in our P/Q */
-			raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
-						pointers);
-		} else {
-			/* raid5 */
-			memcpy(pointers[nr_data], pointers[0], sectorsize);
-			run_xor(pointers + 1, nr_data - 1, sectorsize);
-		}
-
-		/* Check scrubbing parity and repair it */
-		parity = kmap_local_paddr(rbio_stripe_paddr(rbio, rbio->scrubp, sectornr));
-		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
-			memcpy(parity, pointers[rbio->scrubp], sectorsize);
-		else
-			/* Parity is right, needn't writeback */
-			bitmap_clear(&rbio->dbitmap, sectornr, 1);
-		kunmap_local(parity);
-
-		for (stripe = nr_data - 1; stripe >= 0; stripe--)
-			kunmap_local(pointers[stripe]);
-	}
+	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors)
+		verify_one_parity_sector(rbio, pointers, sectornr);
 
 	kunmap_local(pointers[nr_data]);
 	__free_page(phys_to_page(p_paddr));
-- 
2.51.2


