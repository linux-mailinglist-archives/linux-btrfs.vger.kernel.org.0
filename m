Return-Path: <linux-btrfs+bounces-17558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E0BC761B
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 06:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3E344E8B13
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 04:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2025A2C7;
	Thu,  9 Oct 2025 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bPo6DWrx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bPo6DWrx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B56154BE2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984835; cv=none; b=Z6PjSq99KQfXdHGBS7EkIYFo4KSAJo1rReZOkjSv94h+262xfxR5YRT0dyiOfhNZrc9134fugyLySgIjOBd8KfuIeeW56JFyXSiFOmOZHnlXvWQYM4RABsIFwaXlTGs4Vhsablr63q3ijn2BPGKGqP0enEYP8p2KdNSgH1VWcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984835; c=relaxed/simple;
	bh=MO5OKsD9EpPPPc7yz9J/T4oVOu4KLsTMoHALxgwsmuU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKRcBMoJhHgYY2gN1sZwdojM5ginJ0QuEv4PFoRCctOiAvA3M7aLDEX1PpEaE8DDE1GQqV/M/IAWXTAKud2sXEgAvWBZv07Hj09D//doKSLih1rb8xZ5d6ZqTpSUqxjWkMrsFhD2RkxgXzg+RgxdvmTUK95Ya1K+suJ9i61aZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bPo6DWrx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bPo6DWrx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05C951F792
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2shP4Z9m4qF0dUYX343UDJVGFjRmBDfMMo3BRSYPSM=;
	b=bPo6DWrx0CqXRmy3aR4Jy/roA8ZkAj9T+q+dAqSVgD6wTXDVFNNxpxr3ZpvgwobLJnOuNR
	9IBviO4QOwaeUSP6xft/4J87GX/CCTlGoyrQwuHw9YWIChkHbYriio/K02hrHfwQzJOh3M
	ddf7tVHcKL57P1m15k2u4gBx50z1FP4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2shP4Z9m4qF0dUYX343UDJVGFjRmBDfMMo3BRSYPSM=;
	b=bPo6DWrx0CqXRmy3aR4Jy/roA8ZkAj9T+q+dAqSVgD6wTXDVFNNxpxr3ZpvgwobLJnOuNR
	9IBviO4QOwaeUSP6xft/4J87GX/CCTlGoyrQwuHw9YWIChkHbYriio/K02hrHfwQzJOh3M
	ddf7tVHcKL57P1m15k2u4gBx50z1FP4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41B8C139D2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDFyAbk852geVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 04:40:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: raid56: move sector_ptr::uptodate into a dedicated bitmap
Date: Thu,  9 Oct 2025 15:10:00 +1030
Message-ID: <2d0d2dd141fc994ba99e8915365350d2a896a616.1759984060.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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

The uptodate boolean member can be extracted into a bitmap, which will
save us some space (1 bit in a byte vs 8 bits in a byte).

Furthermore we do not need to record the uptodate bitmap for bio
sectors, as if bio_sectors[].paddr is valid it means there is a bio and
will be uptodate.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 69 +++++++++++++++++++++++------------------------
 fs/btrfs/raid56.h |  3 +++
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 60e81b79f939..77ff1ac29886 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -151,7 +151,6 @@ struct sector_ptr {
 	 * If it's INVALID_PADDR then it's not set.
 	 */
 	phys_addr_t paddr;
-	bool uptodate;
 };
 
 static void rmw_rbio_work(struct work_struct *work);
@@ -277,13 +276,13 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 			 * read from disk.
 			 */
 			if (i < rbio->nr_data * rbio->stripe_nsectors)
-				ASSERT(rbio->stripe_sectors[i].uptodate);
+				ASSERT(test_bit(i, rbio->stripe_uptodate_bitmap));
 			continue;
 		}
 
 		memcpy_sectors(&rbio->stripe_sectors[i], &rbio->bio_sectors[i],
 				rbio->bioc->fs_info->sectorsize);
-		rbio->stripe_sectors[i].uptodate = 1;
+		set_bit(i, rbio->stripe_uptodate_bitmap);
 	}
 	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 }
@@ -318,7 +317,7 @@ static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
 	for (i = sectors_per_page * page_nr;
 	     i < sectors_per_page * page_nr + sectors_per_page;
 	     i++) {
-		if (!rbio->stripe_sectors[i].uptodate)
+		if (!test_bit(i, rbio->stripe_uptodate_bitmap))
 			return false;
 	}
 	return true;
@@ -353,17 +352,14 @@ static void steal_rbio_page(struct btrfs_raid_bio *src,
 {
 	const u32 sectorsize = src->bioc->fs_info->sectorsize;
 	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
-	int i;
 
 	if (dest->stripe_pages[page_nr])
 		__free_page(dest->stripe_pages[page_nr]);
 	dest->stripe_pages[page_nr] = src->stripe_pages[page_nr];
 	src->stripe_pages[page_nr] = NULL;
 
-	/* Also update the sector->uptodate bits. */
-	for (i = sectors_per_page * page_nr;
-	     i < sectors_per_page * page_nr + sectors_per_page; i++)
-		dest->stripe_sectors[i].uptodate = true;
+	/* Also update the stripe_uptodate_bitmap bits. */
+	bitmap_set(dest->stripe_uptodate_bitmap, sectors_per_page * page_nr, sectors_per_page);
 }
 
 static bool is_data_stripe_page(struct btrfs_raid_bio *rbio, int page_nr)
@@ -1031,9 +1027,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 				       GFP_NOFS);
 	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
 	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
+	rbio->stripe_uptodate_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 
 	if (!rbio->stripe_pages || !rbio->bio_sectors || !rbio->stripe_sectors ||
-	    !rbio->finish_pointers || !rbio->error_bitmap) {
+	    !rbio->finish_pointers || !rbio->error_bitmap || !rbio->stripe_uptodate_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
 		return ERR_PTR(-ENOMEM);
@@ -1331,7 +1328,8 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 
 	/* Then add the parity stripe */
 	sector = rbio_pstripe_sector(rbio, sectornr);
-	sector->uptodate = 1;
+	set_bit(rbio_stripe_sector_index(rbio, rbio->nr_data, sectornr),
+		rbio->stripe_uptodate_bitmap);
 	pointers[stripe++] = kmap_local_sector(sector);
 
 	if (has_qstripe) {
@@ -1340,7 +1338,8 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		 * to fill in our p/q
 		 */
 		sector = rbio_qstripe_sector(rbio, sectornr);
-		sector->uptodate = 1;
+		set_bit(rbio_stripe_sector_index(rbio, rbio->nr_data + 1, sectornr),
+			rbio->stripe_uptodate_bitmap);
 		pointers[stripe++] = kmap_local_sector(sector);
 
 		assert_rbio(rbio);
@@ -1496,21 +1495,20 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 }
 
 /*
- * For subpage case, we can no longer set page Up-to-date directly for
- * stripe_pages[], thus we need to locate the sector.
+ * Return the index inside the rbio->stripe_sectors[] array.
+ *
+ * Return -1 if not found.
  */
-static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
-					     phys_addr_t paddr)
+static int find_stripe_sector_nr(struct btrfs_raid_bio *rbio,
+				 phys_addr_t paddr)
 {
-	int i;
-
-	for (i = 0; i < rbio->nr_sectors; i++) {
+	for (int i = 0; i < rbio->nr_sectors; i++) {
 		struct sector_ptr *sector = &rbio->stripe_sectors[i];
 
 		if (sector->paddr == paddr)
-			return sector;
+			return i;
 	}
-	return NULL;
+	return -1;
 }
 
 /*
@@ -1525,11 +1523,11 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
 	btrfs_bio_for_each_block_all(paddr, bio, blocksize) {
-		struct sector_ptr *sector = find_stripe_sector(rbio, paddr);
+		int sector_nr = find_stripe_sector_nr(rbio, paddr);
 
-		ASSERT(sector);
-		if (sector)
-			sector->uptodate = 1;
+		ASSERT(sector_nr >= 0);
+		if (sector_nr >= 0)
+			set_bit(sector_nr, rbio->stripe_uptodate_bitmap);
 	}
 }
 
@@ -1963,7 +1961,8 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 			goto cleanup;
 
 		sector = rbio_stripe_sector(rbio, faila, sector_nr);
-		sector->uptodate = 1;
+		set_bit(rbio_stripe_sector_index(rbio, faila, sector_nr),
+			rbio->stripe_uptodate_bitmap);
 	}
 	if (failb >= 0) {
 		ret = verify_one_sector(rbio, failb, sector_nr);
@@ -1971,7 +1970,8 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 			goto cleanup;
 
 		sector = rbio_stripe_sector(rbio, failb, sector_nr);
-		sector->uptodate = 1;
+		set_bit(rbio_stripe_sector_index(rbio, failb, sector_nr),
+			rbio->stripe_uptodate_bitmap);
 	}
 
 cleanup:
@@ -2325,7 +2325,8 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 		 * thus this rbio can not be cached one, as cached one must
 		 * have all its data sectors present and uptodate.
 		 */
-		if (sector->paddr == INVALID_PADDR || !sector->uptodate)
+		if (sector->paddr == INVALID_PADDR ||
+		    !test_bit(i, rbio->stripe_uptodate_bitmap))
 			return true;
 	}
 	return false;
@@ -2551,7 +2552,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	if (!page)
 		return -ENOMEM;
 	p_sector.paddr = page_to_phys(page);
-	p_sector.uptodate = 1;
 	page = NULL;
 
 	if (has_qstripe) {
@@ -2563,7 +2563,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 			return -ENOMEM;
 		}
 		q_sector.paddr = page_to_phys(page);
-		q_sector.uptodate = 1;
 		page = NULL;
 		pointers[rbio->real_stripes - 1] = kmap_local_sector(&q_sector);
 	}
@@ -2781,7 +2780,8 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 		 * The bio cache may have handed us an uptodate sector.  If so,
 		 * use it.
 		 */
-		if (sector->uptodate)
+		if (test_bit(rbio_stripe_sector_index(rbio, stripe, sectornr),
+			     rbio->stripe_uptodate_bitmap))
 			continue;
 
 		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
@@ -2899,8 +2899,7 @@ void raid56_parity_cache_data_folios(struct btrfs_raid_bio *rbio,
 			foffset = 0;
 		}
 	}
-	for (unsigned int sector_nr = offset_in_full_stripe >> fs_info->sectorsize_bits;
-	     sector_nr < (offset_in_full_stripe + BTRFS_STRIPE_LEN) >> fs_info->sectorsize_bits;
-	     sector_nr++)
-		rbio->stripe_sectors[sector_nr].uptodate = true;
+	bitmap_set(rbio->stripe_uptodate_bitmap,
+		   offset_in_full_stripe >> fs_info->sectorsize_bits,
+		   BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
 }
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 84c4d1d29c7a..b636de4af7ac 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -124,6 +124,9 @@ struct btrfs_raid_bio {
 	 */
 	struct sector_ptr *stripe_sectors;
 
+	/* Each set bit means the corresponding sector in stripe_sectors[] is uptodate. */
+	unsigned long *stripe_uptodate_bitmap;
+
 	/* Allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
 
-- 
2.50.1


