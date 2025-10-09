Return-Path: <linux-btrfs+bounces-17556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F15BC7618
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 06:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6727D19E0F0D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 04:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7E25A350;
	Thu,  9 Oct 2025 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z0p0ud35";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z0p0ud35"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0855154BE2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984829; cv=none; b=lOU/8y5P8JgdPph0JMOicwxBZofdcznQPyOrvKcNEboS6gldcNyDpQ0FfBeZxXyLPzOrluR/1gvdKNvvFMlzwfJiBLY/Nx/ALD4TJjMOZUKXHE3aMkIpsJr9qBkTUHoJdrFHDfyZ5PRNcig4CzUAu+387eTHodVWv0hJAUa049A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984829; c=relaxed/simple;
	bh=kftGuJheY6qk37XagAVVj5Vk4MEn0LSJlL5pKO1EOKc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8Ahvyn8YanO8r0BLw4eCPlfRn22te2sOwfaXmUWbpVN9/AmN0luu0cIHrV6l4MfYTY9BPX3DB+1IQ8GyK93QfImt82GUGQsZ3Za1RMitkml2RRwmyayO3fYpF2/sFZs4ooZrrCtKgNHw2M9D1gKO/mH15kSFFmC6C7dccJ4XpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z0p0ud35; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z0p0ud35; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C68161F791
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q0EwRoeqBVkHR0PfjN5bOMsdoM3jVp0LH85IZkCaxw=;
	b=Z0p0ud35Fb98nwfm2glN4g5uBU63SpNRiugKjx5wDNdkPXkdhc22r2NLojTO/C2a637eES
	Xn6Beb4pk1luDUHnAlG2IKQTs7fDC9sCDLiC6364DnSxPB/5Zwpc/dOBHLipD65Ix7St2Z
	vMOdJesaey7tqAlzSPRaImxNNhyvRHc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q0EwRoeqBVkHR0PfjN5bOMsdoM3jVp0LH85IZkCaxw=;
	b=Z0p0ud35Fb98nwfm2glN4g5uBU63SpNRiugKjx5wDNdkPXkdhc22r2NLojTO/C2a637eES
	Xn6Beb4pk1luDUHnAlG2IKQTs7fDC9sCDLiC6364DnSxPB/5Zwpc/dOBHLipD65Ix7St2Z
	vMOdJesaey7tqAlzSPRaImxNNhyvRHc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA2413AAC
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wDGOL7c852geVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 04:40:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: raid56: remove sector_ptr::has_paddr member
Date: Thu,  9 Oct 2025 15:09:59 +1030
Message-ID: <a7a93c47958119a270bb929eadf2128568b47d06.1759984060.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1759984060.git.wqu@suse.com>
References: <cover.1759984060.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

We can use paddr -1 as an indicator for unset/uninitialized paddr.

We can not use 0 paddr, unlike virtual address 0 which is never mapped
thus will always trigger a page fault, physical address 0 may be a valid
page.

So here we follow swiotlb to use (paddr)-1 as a special indicator for
invalid/unset physical address.

Even if the PFN may still be valid, our usage of the physical address
should always be aligned to fs block size (or page size for bs > ps
cases), thus such -1 paddr should never be a valid one.

With this special -1 paddr, we can get rid of has_paddr member and save
1 byte for sector_ptr structure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0135dceb7baa..60e81b79f939 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -133,6 +133,12 @@ struct btrfs_stripe_hash_table {
 	struct btrfs_stripe_hash table[];
 };
 
+/*
+ * The PFN may still be valid, but our paddrs should always be block size
+ * aligned, thus such -1 paddr is definitely not a valid one.
+ */
+#define INVALID_PADDR	(~(phys_addr_t)0)
+
 /*
  * A structure to present a sector inside a page, the length is fixed to
  * sectorsize;
@@ -141,9 +147,10 @@ struct sector_ptr {
 	/*
 	 * Blocks from the bio list can still be highmem.
 	 * So here we use physical address to present a page and the offset inside it.
+	 *
+	 * If it's INVALID_PADDR then it's not set.
 	 */
 	phys_addr_t paddr;
-	bool has_paddr;
 	bool uptodate;
 };
 
@@ -263,7 +270,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (!rbio->bio_sectors[i].has_paddr) {
+		if (rbio->bio_sectors[i].paddr == INVALID_PADDR) {
 			/*
 			 * Even if the sector is not covered by bio, if it is
 			 * a data sector it should still be uptodate as it is
@@ -335,7 +342,6 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 		if (!rbio->stripe_pages[page_index])
 			continue;
 
-		rbio->stripe_sectors[i].has_paddr = true;
 		rbio->stripe_sectors[i].paddr =
 			page_to_phys(rbio->stripe_pages[page_index]) +
 			offset_in_page(offset);
@@ -972,9 +978,9 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 
 	spin_lock(&rbio->bio_list_lock);
 	sector = &rbio->bio_sectors[index];
-	if (sector->has_paddr || bio_list_only) {
+	if (sector->paddr != INVALID_PADDR || bio_list_only) {
 		/* Don't return sector without a valid page pointer */
-		if (!sector->has_paddr)
+		if (sector->paddr == INVALID_PADDR)
 			sector = NULL;
 		spin_unlock(&rbio->bio_list_lock);
 		return sector;
@@ -1032,6 +1038,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		kfree(rbio);
 		return ERR_PTR(-ENOMEM);
 	}
+	for (int i = 0; i < num_sectors; i++) {
+		rbio->stripe_sectors[i].paddr = INVALID_PADDR;
+		rbio->bio_sectors[i].paddr = INVALID_PADDR;
+	}
 
 	bio_list_init(&rbio->bio_list);
 	init_waitqueue_head(&rbio->io_wait);
@@ -1152,7 +1162,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 			   rbio, stripe_nr);
 	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
 			   rbio, sector_nr);
-	ASSERT(sector->has_paddr);
+	ASSERT(sector->paddr != INVALID_PADDR);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
@@ -1216,7 +1226,6 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 		unsigned int index = (offset >> sectorsize_bits);
 		struct sector_ptr *sector = &rbio->bio_sectors[index];
 
-		sector->has_paddr = true;
 		sector->paddr = paddr;
 		offset += sectorsize;
 	}
@@ -1299,7 +1308,7 @@ static void assert_rbio(struct btrfs_raid_bio *rbio)
 static inline void *kmap_local_sector(const struct sector_ptr *sector)
 {
 	/* The sector pointer must have a page mapped to it. */
-	ASSERT(sector->has_paddr);
+	ASSERT(sector->paddr != INVALID_PADDR);
 
 	return kmap_local_page(phys_to_page(sector->paddr)) +
 	       offset_in_page(sector->paddr);
@@ -1498,7 +1507,7 @@ static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		struct sector_ptr *sector = &rbio->stripe_sectors[i];
 
-		if (sector->has_paddr && sector->paddr == paddr)
+		if (sector->paddr == paddr)
 			return sector;
 	}
 	return NULL;
@@ -1532,8 +1541,7 @@ static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		if (rbio->stripe_sectors[i].paddr == bvec_paddr)
 			break;
-		if (rbio->bio_sectors[i].has_paddr &&
-		    rbio->bio_sectors[i].paddr == bvec_paddr)
+		if (rbio->bio_sectors[i].paddr == bvec_paddr)
 			break;
 	}
 	ASSERT(i < rbio->nr_sectors);
@@ -2317,7 +2325,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 		 * thus this rbio can not be cached one, as cached one must
 		 * have all its data sectors present and uptodate.
 		 */
-		if (!sector->has_paddr || !sector->uptodate)
+		if (sector->paddr == INVALID_PADDR || !sector->uptodate)
 			return true;
 	}
 	return false;
@@ -2508,8 +2516,8 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	int sectornr;
 	bool has_qstripe;
 	struct page *page;
-	struct sector_ptr p_sector = { 0 };
-	struct sector_ptr q_sector = { 0 };
+	struct sector_ptr p_sector = { .paddr = INVALID_PADDR };
+	struct sector_ptr q_sector = { .paddr = INVALID_PADDR };
 	struct bio_list bio_list;
 	int is_replace = 0;
 	int ret;
@@ -2542,7 +2550,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	page = alloc_page(GFP_NOFS);
 	if (!page)
 		return -ENOMEM;
-	p_sector.has_paddr = true;
 	p_sector.paddr = page_to_phys(page);
 	p_sector.uptodate = 1;
 	page = NULL;
@@ -2552,10 +2559,9 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 		page = alloc_page(GFP_NOFS);
 		if (!page) {
 			__free_page(phys_to_page(p_sector.paddr));
-			p_sector.has_paddr = false;
+			p_sector.paddr = INVALID_PADDR;
 			return -ENOMEM;
 		}
-		q_sector.has_paddr = true;
 		q_sector.paddr = page_to_phys(page);
 		q_sector.uptodate = 1;
 		page = NULL;
@@ -2604,10 +2610,10 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 
 	kunmap_local(pointers[nr_data]);
 	__free_page(phys_to_page(p_sector.paddr));
-	p_sector.has_paddr = false;
-	if (q_sector.has_paddr) {
+	p_sector.paddr = INVALID_PADDR;
+	if (q_sector.paddr != INVALID_PADDR) {
 		__free_page(phys_to_page(q_sector.paddr));
-		q_sector.has_paddr = false;
+		q_sector.paddr = INVALID_PADDR;
 	}
 
 	/*
-- 
2.50.1


