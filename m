Return-Path: <linux-btrfs+bounces-13177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14272A94214
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC419E2783
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB5199E89;
	Sat, 19 Apr 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nmwoylvL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fUAygM1f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E39142659
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047090; cv=none; b=cvCfnahyZho87k44rVLlvyjrok6qNB9EpFSdk7jY2ZThELMEL/PsQj/DhsC6/oDyanrTYq78XtoLMtcYltrBLBDCq9dy8jrlUS2CLhsV8xhJ88kjLlHb0zgGtTL/ueMjVx42Idm99kGC7t0ID2rRcRr0yWZDLsntETApstS/22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047090; c=relaxed/simple;
	bh=qlXX7ybIJ+rhackkXQM3M1JQPL9Y5osLIY7fJYdOjUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szYBYs6BHc/24LBy4gH/lbrwIhjW0WSWwGFOlAPPN4j4A/T69+4nBWNjCJ5D/XSoOoDJl47o56Y9jJDS4qbptxGnxGPqFkA0BdBN0t/FvjXbe97iTwI3MN+69z68USGbx3gbOzrMh1Ej1lKn45fseLBbtwA3NZcm+OlWoWDS72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nmwoylvL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fUAygM1f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 172C52120C;
	Sat, 19 Apr 2025 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9FCRTRnudGir1/vI4Pz9ow1MXCs1L0y78PId3OoMmM=;
	b=nmwoylvL3r6ZN4HtR0FYfNPDpPYaVy5p+crR1DlWkNHUGZuy4mD5WxGeDV8EqR8ggkf2fC
	Czzy5mtI06w4ObXQbCucBFAUzfEgdPBENR+EovNW970XKJoF/Xibtcdfj0o9QB3vp1j4Os
	gKMqzt3At2zW3y3Brv3Hz2lDwyEynl4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9FCRTRnudGir1/vI4Pz9ow1MXCs1L0y78PId3OoMmM=;
	b=fUAygM1fQbzf6bY1+3+GoNOIjnNmCi2SOs7qK65dc60gdNARb+8zIrASzs5cdIo8YWxu+0
	vJwAviH38fZyjGxAg8MLfejONNY5Tp+yLz5eMqUzMfVNebCXKi292otJrHpvHwprp1Cavb
	6ZJqJRVXgo7maeGy9lH18yx9Iaog1do=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D961813942;
	Sat, 19 Apr 2025 07:17:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UADyJhpOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 6/8] btrfs: raid56: store a physical address in structure sector_ptr
Date: Sat, 19 Apr 2025 16:47:13 +0930
Message-ID: <03dbeaa8ac424885402a6590e393a15d5ae67c82.1745024799.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,lst.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

From: Christoph Hellwig <hch@lst.de>

Instead of using a @page + @pg_offset pair inside sector_ptr structure,
use a single physical address instead.

This allows us to grab both the page and offset from a single u64 value.
Although we still need an extra bool value, @has_paddr, to distinguish
if the sector is properly mapped (as the 0 physical address is totally
valid).

This change doesn't change the size of structure sector_ptr, but reduces
the parameters of several functions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[ Use physical addresses instead to handle highmem. ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 158 +++++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index b0938eff908e..f196682e40f1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -134,14 +134,17 @@ struct btrfs_stripe_hash_table {
 };
 
 /*
- * A bvec like structure to present a sector inside a page.
- *
- * Unlike bvec we don't need bvlen, as it's fixed to sectorsize.
+ * A structure to present a sector inside a page, the length is fixed to
+ * sectorsize;
  */
 struct sector_ptr {
-	struct page *page;
-	unsigned int pgoff:24;
-	unsigned int uptodate:8;
+	/*
+	 * Blocks from the bio list can still be highmem.
+	 * So here we use physical address to present a page and the offset inside it.
+	 */
+	phys_addr_t paddr;
+	bool has_paddr;
+	bool uptodate;
 };
 
 static void rmw_rbio_work(struct work_struct *work);
@@ -233,6 +236,14 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 	return 0;
 }
 
+static void memcpy_sectors(const struct sector_ptr *dst,
+			   const struct sector_ptr *src, u32 blocksize)
+{
+	memcpy_page(phys_to_page(dst->paddr), offset_in_page(dst->paddr),
+		    phys_to_page(src->paddr), offset_in_page(src->paddr),
+		    blocksize);
+}
+
 /*
  * caching an rbio means to copy anything from the
  * bio_sectors array into the stripe_pages array.  We
@@ -253,7 +264,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (!rbio->bio_sectors[i].page) {
+		if (!rbio->bio_sectors[i].has_paddr) {
 			/*
 			 * Even if the sector is not covered by bio, if it is
 			 * a data sector it should still be uptodate as it is
@@ -264,12 +275,8 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 
-		ASSERT(rbio->stripe_sectors[i].page);
-		memcpy_page(rbio->stripe_sectors[i].page,
-			    rbio->stripe_sectors[i].pgoff,
-			    rbio->bio_sectors[i].page,
-			    rbio->bio_sectors[i].pgoff,
-			    rbio->bioc->fs_info->sectorsize);
+		memcpy_sectors(&rbio->stripe_sectors[i], &rbio->bio_sectors[i],
+				rbio->bioc->fs_info->sectorsize);
 		rbio->stripe_sectors[i].uptodate = 1;
 	}
 	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
@@ -326,8 +333,13 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 		int page_index = offset >> PAGE_SHIFT;
 
 		ASSERT(page_index < rbio->nr_pages);
-		rbio->stripe_sectors[i].page = rbio->stripe_pages[page_index];
-		rbio->stripe_sectors[i].pgoff = offset_in_page(offset);
+		if (!rbio->stripe_pages[page_index])
+			continue;
+
+		rbio->stripe_sectors[i].has_paddr = true;
+		rbio->stripe_sectors[i].paddr =
+			page_to_phys(rbio->stripe_pages[page_index]) +
+			offset_in_page(offset);
 	}
 }
 
@@ -962,9 +974,9 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 
 	spin_lock(&rbio->bio_list_lock);
 	sector = &rbio->bio_sectors[index];
-	if (sector->page || bio_list_only) {
+	if (sector->has_paddr || bio_list_only) {
 		/* Don't return sector without a valid page pointer */
-		if (!sector->page)
+		if (!sector->has_paddr)
 			sector = NULL;
 		spin_unlock(&rbio->bio_list_lock);
 		return sector;
@@ -1142,7 +1154,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 			   rbio, stripe_nr);
 	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
 			   rbio, sector_nr);
-	ASSERT(sector->page);
+	ASSERT(sector->has_paddr);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
@@ -1173,8 +1185,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 		 */
 		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_bdev == stripe->dev->bdev) {
-			ret = bio_add_page(last, sector->page, sectorsize,
-					   sector->pgoff);
+			ret = bio_add_page(last, phys_to_page(sector->paddr),
+					   sectorsize, offset_in_page(sector->paddr));
 			if (ret == sectorsize)
 				return 0;
 		}
@@ -1187,7 +1199,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 	bio->bi_private = rbio;
 
-	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
+	__bio_add_page(bio, phys_to_page(sector->paddr), sectorsize,
+		       offset_in_page(sector->paddr));
 	bio_list_add(bio_list, bio);
 	return 0;
 }
@@ -1204,10 +1217,8 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 		struct sector_ptr *sector = &rbio->bio_sectors[index];
 		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
-		sector->page = bv.bv_page;
-		sector->pgoff = bv.bv_offset;
-		ASSERT(sector->pgoff < PAGE_SIZE);
-
+		sector->has_paddr = true;
+		sector->paddr = bvec_phys(&bv);
 		bio_advance_iter_single(bio, &iter, sectorsize);
 		offset += sectorsize;
 	}
@@ -1287,6 +1298,15 @@ static void assert_rbio(struct btrfs_raid_bio *rbio)
 	ASSERT_RBIO(rbio->nr_data < rbio->real_stripes, rbio);
 }
 
+static inline void *kmap_local_sector(const struct sector_ptr *sector)
+{
+	/* The sector pointer must has a page mapped to it. */
+	ASSERT(sector->has_paddr);
+
+	return kmap_local_page(phys_to_page(sector->paddr)) +
+	       offset_in_page(sector->paddr);
+}
+
 /* Generate PQ for one vertical stripe. */
 static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 {
@@ -1299,14 +1319,13 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 	/* First collect one sector from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
 		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-		pointers[stripe] = kmap_local_page(sector->page) +
-				   sector->pgoff;
+		pointers[stripe] = kmap_local_sector(sector);
 	}
 
 	/* Then add the parity stripe */
 	sector = rbio_pstripe_sector(rbio, sectornr);
 	sector->uptodate = 1;
-	pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
+	pointers[stripe++] = kmap_local_sector(sector);
 
 	if (has_qstripe) {
 		/*
@@ -1315,8 +1334,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		 */
 		sector = rbio_qstripe_sector(rbio, sectornr);
 		sector->uptodate = 1;
-		pointers[stripe++] = kmap_local_page(sector->page) +
-				     sector->pgoff;
+		pointers[stripe++] = kmap_local_sector(sector);
 
 		assert_rbio(rbio);
 		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
@@ -1475,15 +1493,14 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
  * stripe_pages[], thus we need to locate the sector.
  */
 static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
-					     struct page *page,
-					     unsigned int pgoff)
+					     phys_addr_t paddr)
 {
 	int i;
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		struct sector_ptr *sector = &rbio->stripe_sectors[i];
 
-		if (sector->page == page && sector->pgoff == pgoff)
+		if (sector->has_paddr && sector->paddr == paddr)
 			return sector;
 	}
 	return NULL;
@@ -1503,11 +1520,11 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct sector_ptr *sector;
-		int pgoff;
+		phys_addr_t paddr = bvec_phys(bvec);
+		int off;
 
-		for (pgoff = bvec->bv_offset; pgoff - bvec->bv_offset < bvec->bv_len;
-		     pgoff += sectorsize) {
-			sector = find_stripe_sector(rbio, bvec->bv_page, pgoff);
+		for (off = 0; off < bvec->bv_len; off += sectorsize) {
+			sector = find_stripe_sector(rbio, paddr + off);
 			ASSERT(sector);
 			if (sector)
 				sector->uptodate = 1;
@@ -1517,17 +1534,14 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	struct bio_vec *bv = bio_first_bvec_all(bio);
+	phys_addr_t bvec_paddr = bvec_phys(bio_first_bvec_all(bio));
 	int i;
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
-		struct sector_ptr *sector;
-
-		sector = &rbio->stripe_sectors[i];
-		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
+		if (rbio->stripe_sectors[i].paddr == bvec_paddr)
 			break;
-		sector = &rbio->bio_sectors[i];
-		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
+		if (rbio->bio_sectors[i].has_paddr &&
+		    rbio->bio_sectors[i].paddr == bvec_paddr)
 			break;
 	}
 	ASSERT(i < rbio->nr_sectors);
@@ -1788,10 +1802,10 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct sector_ptr *sector;
-	u8 csum_buf[BTRFS_CSUM_SIZE];
-	u8 *csum_expected;
 	void *kaddr;
 	int ret;
+	u8 csum_buf[BTRFS_CSUM_SIZE];
+	u8 *csum_expected;
 
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
 		return 0;
@@ -1809,12 +1823,10 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
 	}
 
-	ASSERT(sector->page);
-
-	kaddr = kmap_local_page(sector->page) + sector->pgoff;
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
+	kaddr = kmap_local_sector(sector);
 	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, csum_expected);
 	kunmap_local(kaddr);
 	return ret;
@@ -1873,9 +1885,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		} else {
 			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
 		}
-		ASSERT(sector->page);
-		pointers[stripe_nr] = kmap_local_page(sector->page) +
-				   sector->pgoff;
+		pointers[stripe_nr] = kmap_local_sector(sector);
 		unmap_array[stripe_nr] = pointers[stripe_nr];
 	}
 
@@ -2327,7 +2337,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 		 * thus this rbio can not be cached one, as cached one must
 		 * have all its data sectors present and uptodate.
 		 */
-		if (!sector->page || !sector->uptodate)
+		if (!sector->has_paddr || !sector->uptodate)
 			return true;
 	}
 	return false;
@@ -2517,6 +2527,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	int stripe;
 	int sectornr;
 	bool has_qstripe;
+	struct page *page;
 	struct sector_ptr p_sector = { 0 };
 	struct sector_ptr q_sector = { 0 };
 	struct bio_list bio_list;
@@ -2548,29 +2559,34 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 */
 	clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	p_sector.page = alloc_page(GFP_NOFS);
-	if (!p_sector.page)
+	page = alloc_page(GFP_NOFS);
+	if (!page)
 		return -ENOMEM;
-	p_sector.pgoff = 0;
+	p_sector.has_paddr = true;
+	p_sector.paddr = page_to_phys(page);
 	p_sector.uptodate = 1;
+	page = NULL;
 
 	if (has_qstripe) {
 		/* RAID6, allocate and map temp space for the Q stripe */
-		q_sector.page = alloc_page(GFP_NOFS);
-		if (!q_sector.page) {
-			__free_page(p_sector.page);
-			p_sector.page = NULL;
+		page = alloc_page(GFP_NOFS);
+		if (!page) {
+			__free_page(phys_to_page(p_sector.paddr));
+			p_sector.has_paddr = false;
 			return -ENOMEM;
 		}
-		q_sector.pgoff = 0;
+		q_sector.has_paddr = true;
+		q_sector.paddr = page_to_phys(page);
 		q_sector.uptodate = 1;
-		pointers[rbio->real_stripes - 1] = kmap_local_page(q_sector.page);
+		page = NULL;
+		pointers[rbio->real_stripes - 1] =
+			kmap_local_sector(&q_sector);
 	}
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	/* Map the parity stripe just once */
-	pointers[nr_data] = kmap_local_page(p_sector.page);
+	pointers[nr_data] = kmap_local_sector(&p_sector);
 
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
@@ -2579,8 +2595,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
 			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_page(sector->page) +
-					   sector->pgoff;
+			pointers[stripe] = kmap_local_sector(sector);
 		}
 
 		if (has_qstripe) {
@@ -2596,7 +2611,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 
 		/* Check scrubbing parity and repair it */
 		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		parity = kmap_local_page(sector->page) + sector->pgoff;
+		parity = kmap_local_sector(sector);
 		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
 			memcpy(parity, pointers[rbio->scrubp], sectorsize);
 		else
@@ -2609,12 +2624,11 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	}
 
 	kunmap_local(pointers[nr_data]);
-	__free_page(p_sector.page);
-	p_sector.page = NULL;
-	if (q_sector.page) {
-		kunmap_local(pointers[rbio->real_stripes - 1]);
-		__free_page(q_sector.page);
-		q_sector.page = NULL;
+	__free_page(phys_to_page(p_sector.paddr));
+	p_sector.has_paddr = false;
+	if (q_sector.has_paddr) {
+		__free_page(phys_to_page(q_sector.paddr));
+		q_sector.has_paddr = false;
 	}
 
 	/*
-- 
2.49.0


