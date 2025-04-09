Return-Path: <linux-btrfs+bounces-12919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D514A82329
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E1B3ABD4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9025DB19;
	Wed,  9 Apr 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3v6DIRig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81125DCF3
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197075; cv=none; b=tvCKjwgmTpOJ8Jb6d9zPnzUxy+ZoIS2zHvK6RD310w1OFJF8NcQdK8YbMLyfIt0Ob254U+ZttnrjhR/1L4A4WDjdKJLiunYPOGv9ckGiaiPoR+R1X/eGqmCFvE7+nB5Sn/p/jBbnH8fJRjdUQhERvZ0lW3DmhMJs++HH5YuMc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197075; c=relaxed/simple;
	bh=d4zP1hpkDhN2aa8jJlvvvJGJBLj26xg3UFxvzIVPwGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAOU4UJqliTLzTQiT/zm5uBVh5WT75liq+XwMhO56voWBI2wEhHgEBzyoNttWKW2zke6DY1+c4c9nlEoid6ar8A1GCAW/MDAwIM65meuKVfEGZk9jRODj8hQ8cDYFrx/jtWA6vyKxA4b/f1hInr5QerFpCV0x3eYaofAwNQaads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3v6DIRig; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p8lwzqntgwLB4W+7DEBNqg7M09hFfV+7sNtEWAGUnD8=; b=3v6DIRigR0EzGslM70I/3zGmZ6
	+h7JOvFH33cJtVIY+45mwA/sYwhaacholW1558TqIe2+Euy9hLiRas9DBDuUJ7AAsoUkeR6FTiSv/
	E+aLZISgdGM+sVDWsURsVRBVytp0fC7sMcQiOUhnc8BHKsQHu4qZEtmEL4ZJcjbDYN45esHKXpE3i
	VV9EidK9D3/yRJ1pvhTd84sOdNStPoyjjIlmrGOaTyuvQZRcD71MRq6X8fg6dXuPG22xdNOO1RNip
	OnpMhJhMEAcQFqSV6cYVJn6WrG07Y3lSrw0IK3VDoBGWUV7IQL/9rziqk4En89TUsfUbb1qWS3ymO
	0Za6/YRw==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKq-00000006x47-3yT6;
	Wed, 09 Apr 2025 11:11:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: store a kernel virtual address in struct sector_ptr
Date: Wed,  9 Apr 2025 13:10:40 +0200
Message-ID: <20250409111055.3640328-7-hch@lst.de>
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

All data pointed to by struct sector_ptr is non-highmem kernel memory.
Simplify the code by using a void pointer instead of a page + offset
pair and dropping all the kmap calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 167 +++++++++++++++++-----------------------------
 1 file changed, 62 insertions(+), 105 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 703e713bac03..3ccbf133b455 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -134,14 +134,12 @@ struct btrfs_stripe_hash_table {
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
+	void *kaddr;
+	u8 uptodate;
 };
 
 static void rmw_rbio_work(struct work_struct *work);
@@ -253,7 +251,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (!rbio->bio_sectors[i].page) {
+		if (!rbio->bio_sectors[i].kaddr) {
 			/*
 			 * Even if the sector is not covered by bio, if it is
 			 * a data sector it should still be uptodate as it is
@@ -264,11 +262,9 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 
-		ASSERT(rbio->stripe_sectors[i].page);
-		memcpy_page(rbio->stripe_sectors[i].page,
-			    rbio->stripe_sectors[i].pgoff,
-			    rbio->bio_sectors[i].page,
-			    rbio->bio_sectors[i].pgoff,
+		ASSERT(rbio->stripe_sectors[i].kaddr);
+		memcpy(rbio->stripe_sectors[i].kaddr,
+			    rbio->bio_sectors[i].kaddr,
 			    rbio->bioc->fs_info->sectorsize);
 		rbio->stripe_sectors[i].uptodate = 1;
 	}
@@ -326,8 +322,9 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 		int page_index = offset >> PAGE_SHIFT;
 
 		ASSERT(page_index < rbio->nr_pages);
-		rbio->stripe_sectors[i].page = rbio->stripe_pages[page_index];
-		rbio->stripe_sectors[i].pgoff = offset_in_page(offset);
+		rbio->stripe_sectors[i].kaddr =
+			page_address(rbio->stripe_pages[page_index]) +
+					offset_in_page(offset);
 	}
 }
 
@@ -962,9 +959,9 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 
 	spin_lock(&rbio->bio_list_lock);
 	sector = &rbio->bio_sectors[index];
-	if (sector->page || bio_list_only) {
+	if (sector->kaddr || bio_list_only) {
 		/* Don't return sector without a valid page pointer */
-		if (!sector->page)
+		if (!sector->kaddr)
 			sector = NULL;
 		spin_unlock(&rbio->bio_list_lock);
 		return sector;
@@ -1142,7 +1139,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 			   rbio, stripe_nr);
 	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
 			   rbio, sector_nr);
-	ASSERT(sector->page);
+	ASSERT(sector->kaddr);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
@@ -1173,8 +1170,9 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 		 */
 		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_bdev == stripe->dev->bdev) {
-			ret = bio_add_page(last, sector->page, sectorsize,
-					   sector->pgoff);
+			ret = bio_add_page(last, virt_to_page(sector->kaddr),
+					sectorsize,
+					offset_in_page(sector->kaddr));
 			if (ret == sectorsize)
 				return 0;
 		}
@@ -1187,7 +1185,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 	bio->bi_private = rbio;
 
-	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
+	__bio_add_page(bio, virt_to_page(sector->kaddr), sectorsize,
+			offset_in_page(sector->kaddr));
 	bio_list_add(bio_list, bio);
 	return 0;
 }
@@ -1204,10 +1203,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 		struct sector_ptr *sector = &rbio->bio_sectors[index];
 		struct bio_vec bv = bio_iter_iovec(bio, iter);
 
-		sector->page = bv.bv_page;
-		sector->pgoff = bv.bv_offset;
-		ASSERT(sector->pgoff < PAGE_SIZE);
-
+		sector->kaddr = bvec_virt(&bv);
 		bio_advance_iter_single(bio, &iter, sectorsize);
 	}
 }
@@ -1298,14 +1294,13 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 	/* First collect one sector from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
 		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-		pointers[stripe] = kmap_local_page(sector->page) +
-				   sector->pgoff;
+		pointers[stripe] = sector->kaddr;
 	}
 
 	/* Then add the parity stripe */
 	sector = rbio_pstripe_sector(rbio, sectornr);
 	sector->uptodate = 1;
-	pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
+	pointers[stripe++] = sector->kaddr;
 
 	if (has_qstripe) {
 		/*
@@ -1314,8 +1309,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		 */
 		sector = rbio_qstripe_sector(rbio, sectornr);
 		sector->uptodate = 1;
-		pointers[stripe++] = kmap_local_page(sector->page) +
-				     sector->pgoff;
+		pointers[stripe++] = sector->kaddr;
 
 		assert_rbio(rbio);
 		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
@@ -1325,8 +1319,6 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		memcpy(pointers[rbio->nr_data], pointers[0], sectorsize);
 		run_xor(pointers + 1, rbio->nr_data - 1, sectorsize);
 	}
-	for (stripe = stripe - 1; stripe >= 0; stripe--)
-		kunmap_local(pointers[stripe]);
 }
 
 static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
@@ -1474,15 +1466,14 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
  * stripe_pages[], thus we need to locate the sector.
  */
 static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
-					     struct page *page,
-					     unsigned int pgoff)
+					     void *kaddr)
 {
 	int i;
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		struct sector_ptr *sector = &rbio->stripe_sectors[i];
 
-		if (sector->page == page && sector->pgoff == pgoff)
+		if (sector->kaddr == kaddr)
 			return sector;
 	}
 	return NULL;
@@ -1502,11 +1493,11 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct sector_ptr *sector;
-		int pgoff;
+		void *kaddr = bvec_virt(bvec);
+		int off;
 
-		for (pgoff = bvec->bv_offset; pgoff - bvec->bv_offset < bvec->bv_len;
-		     pgoff += sectorsize) {
-			sector = find_stripe_sector(rbio, bvec->bv_page, pgoff);
+		for (off = 0; off < bvec->bv_len; off += sectorsize) {
+			sector = find_stripe_sector(rbio, kaddr + off);
 			ASSERT(sector);
 			if (sector)
 				sector->uptodate = 1;
@@ -1516,17 +1507,13 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	struct bio_vec *bv = bio_first_bvec_all(bio);
+	void *bvec_kaddr = bvec_virt(bio_first_bvec_all(bio));
 	int i;
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
-		struct sector_ptr *sector;
-
-		sector = &rbio->stripe_sectors[i];
-		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
+		if (rbio->stripe_sectors[i].kaddr == bvec_kaddr)
 			break;
-		sector = &rbio->bio_sectors[i];
-		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
+		if (rbio->bio_sectors[i].kaddr == bvec_kaddr)
 			break;
 	}
 	ASSERT(i < rbio->nr_sectors);
@@ -1789,8 +1776,6 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	struct sector_ptr *sector;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
-	void *kaddr;
-	int ret;
 
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
 		return 0;
@@ -1808,15 +1793,13 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
 	}
 
-	ASSERT(sector->page);
+	ASSERT(sector->kaddr);
 
-	kaddr = kmap_local_page(sector->page) + sector->pgoff;
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, csum_expected);
-	kunmap_local(kaddr);
-	return ret;
+	return btrfs_check_sector_csum(fs_info, sector->kaddr, csum_buf,
+			csum_expected);
 }
 
 /*
@@ -1825,7 +1808,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
  * need to allocate/free the pointers again and again.
  */
 static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
-			    void **pointers, void **unmap_array)
+			    void **pointers)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct sector_ptr *sector;
@@ -1872,10 +1855,8 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		} else {
 			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
 		}
-		ASSERT(sector->page);
-		pointers[stripe_nr] = kmap_local_page(sector->page) +
-				   sector->pgoff;
-		unmap_array[stripe_nr] = pointers[stripe_nr];
+		ASSERT(sector->kaddr);
+		pointers[stripe_nr] = sector->kaddr;
 	}
 
 	/* All raid6 handling here */
@@ -1889,7 +1870,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 				 * We have nothing to do, just skip the
 				 * recovery for this stripe.
 				 */
-				goto cleanup;
+				return ret;
 			/*
 			 * a single failure in raid6 is rebuilt
 			 * in the pstripe code below
@@ -1911,7 +1892,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 				 * We only care about data stripes recovery,
 				 * can skip this vertical stripe.
 				 */
-				goto cleanup;
+				return ret;
 			/*
 			 * Otherwise we have one bad data stripe and
 			 * a good P stripe.  raid5!
@@ -1960,7 +1941,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	if (faila >= 0) {
 		ret = verify_one_sector(rbio, faila, sector_nr);
 		if (ret < 0)
-			goto cleanup;
+			return ret;
 
 		sector = rbio_stripe_sector(rbio, faila, sector_nr);
 		sector->uptodate = 1;
@@ -1968,34 +1949,26 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	if (failb >= 0) {
 		ret = verify_one_sector(rbio, failb, sector_nr);
 		if (ret < 0)
-			goto cleanup;
+			return ret;
 
 		sector = rbio_stripe_sector(rbio, failb, sector_nr);
 		sector->uptodate = 1;
 	}
 
-cleanup:
-	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
-		kunmap_local(unmap_array[stripe_nr]);
 	return ret;
 }
 
 static int recover_sectors(struct btrfs_raid_bio *rbio)
 {
 	void **pointers = NULL;
-	void **unmap_array = NULL;
 	int sectornr;
 	int ret = 0;
 
 	/*
 	 * @pointers array stores the pointer for each sector.
-	 *
-	 * @unmap_array stores copy of pointers that does not get reordered
-	 * during reconstruction so that kunmap_local works.
 	 */
 	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	if (!pointers || !unmap_array) {
+	if (!pointers) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2009,14 +1982,13 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 	index_rbio_pages(rbio);
 
 	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-		ret = recover_vertical(rbio, sectornr, pointers, unmap_array);
+		ret = recover_vertical(rbio, sectornr, pointers);
 		if (ret < 0)
 			break;
 	}
 
 out:
 	kfree(pointers);
-	kfree(unmap_array);
 	return ret;
 }
 
@@ -2326,7 +2298,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 		 * thus this rbio can not be cached one, as cached one must
 		 * have all its data sectors present and uptodate.
 		 */
-		if (!sector->page || !sector->uptodate)
+		if (!sector->kaddr || !sector->uptodate)
 			return true;
 	}
 	return false;
@@ -2547,29 +2519,27 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 */
 	clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	p_sector.page = alloc_page(GFP_NOFS);
-	if (!p_sector.page)
+	p_sector.kaddr = (void *)__get_free_page(GFP_NOFS);
+	if (!p_sector.kaddr)
 		return -ENOMEM;
-	p_sector.pgoff = 0;
 	p_sector.uptodate = 1;
 
 	if (has_qstripe) {
 		/* RAID6, allocate and map temp space for the Q stripe */
-		q_sector.page = alloc_page(GFP_NOFS);
-		if (!q_sector.page) {
-			__free_page(p_sector.page);
-			p_sector.page = NULL;
+		q_sector.kaddr = (void *)__get_free_page(GFP_NOFS);
+		if (!q_sector.kaddr) {
+			free_page((unsigned long)p_sector.kaddr);
+			p_sector.kaddr = NULL;
 			return -ENOMEM;
 		}
-		q_sector.pgoff = 0;
 		q_sector.uptodate = 1;
-		pointers[rbio->real_stripes - 1] = kmap_local_page(q_sector.page);
+		pointers[rbio->real_stripes - 1] = q_sector.kaddr;
 	}
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	/* Map the parity stripe just once */
-	pointers[nr_data] = kmap_local_page(p_sector.page);
+	pointers[nr_data] = p_sector.kaddr;
 
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
 		struct sector_ptr *sector;
@@ -2578,8 +2548,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
 			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_page(sector->page) +
-					   sector->pgoff;
+			pointers[stripe] = sector->kaddr;
 		}
 
 		if (has_qstripe) {
@@ -2595,25 +2564,19 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 
 		/* Check scrubbing parity and repair it */
 		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		parity = kmap_local_page(sector->page) + sector->pgoff;
+		parity = sector->kaddr;
 		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
 			memcpy(parity, pointers[rbio->scrubp], sectorsize);
 		else
 			/* Parity is right, needn't writeback */
 			bitmap_clear(&rbio->dbitmap, sectornr, 1);
-		kunmap_local(parity);
-
-		for (stripe = nr_data - 1; stripe >= 0; stripe--)
-			kunmap_local(pointers[stripe]);
 	}
 
-	kunmap_local(pointers[nr_data]);
-	__free_page(p_sector.page);
-	p_sector.page = NULL;
-	if (q_sector.page) {
-		kunmap_local(pointers[rbio->real_stripes - 1]);
-		__free_page(q_sector.page);
-		q_sector.page = NULL;
+	free_page((unsigned long)p_sector.kaddr);
+	p_sector.kaddr = NULL;
+	if (q_sector.kaddr) {
+		free_page((unsigned long)q_sector.kaddr);
+		q_sector.kaddr = NULL;
 	}
 
 	/*
@@ -2669,19 +2632,14 @@ static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
 static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	void **pointers = NULL;
-	void **unmap_array = NULL;
 	int sector_nr;
 	int ret = 0;
 
 	/*
 	 * @pointers array stores the pointer for each sector.
-	 *
-	 * @unmap_array stores copy of pointers that does not get reordered
-	 * during reconstruction so that kunmap_local works.
 	 */
 	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
-	if (!pointers || !unmap_array) {
+	if (!pointers) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2740,13 +2698,12 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 			goto out;
 		}
 
-		ret = recover_vertical(rbio, sector_nr, pointers, unmap_array);
+		ret = recover_vertical(rbio, sector_nr, pointers);
 		if (ret < 0)
 			goto out;
 	}
 out:
 	kfree(pointers);
-	kfree(unmap_array);
 	return ret;
 }
 
-- 
2.47.2


