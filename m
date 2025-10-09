Return-Path: <linux-btrfs+bounces-17559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D6BC761E
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 06:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A65114EDF23
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 04:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435225A2C7;
	Thu,  9 Oct 2025 04:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OYjGxOrd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OYjGxOrd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FB154BE2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984843; cv=none; b=bEoGKYwni/E72CmgjYYX4ad4djesBlTarpTN/83SuYlo+Zzx9cPbnxJ9MaxSoMEYZlqDtFkDeVlNQA00H8HHgdS00TUW+XtixhBariyZB7ATCCXVkDM/ew8vN77yP3fshi47/6ATY6wAMDuP9omWcliXHWnKAeAA02BCQXjZFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984843; c=relaxed/simple;
	bh=o7Ltqe/b/wGF3kLl3YnVmvKz6HpWCdbX9RKhM2QSY30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNlNYH6c+TiQKhJYmdegd6ryS+JhuZLv9klS5eyQbG93jWWAJQN82Qnp5oXZwAMHH7yJ3BKhdiWyHzS4XrEiUroz7mYjkVipInnEX3qwxORfCZcNSEQEDj10o0X2h8APF2iHvB6w9AsT5EDWKsc4OrnGlvFvp3woD4E/0+FvctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OYjGxOrd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OYjGxOrd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EB181F793
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCAq7cq+eGHckn7vvm2ED3YcZw/MLsMiByMX34ISdU8=;
	b=OYjGxOrdBjKV/h4hFgaPfJ8rCScS3Z51IQHl7yT8xBVDl0Sh54QOzJbvkHycs1+FLziqwp
	qaXGo7HdQrr3cEOTtpwbfwud6ULL4YvonpPmCiES2Grv01L/9T8K5y1zECUqXjbUFk0V7U
	RPNqeIZJxXUg6oDO+Ptb96nbne3h+8g=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OYjGxOrd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759984827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCAq7cq+eGHckn7vvm2ED3YcZw/MLsMiByMX34ISdU8=;
	b=OYjGxOrdBjKV/h4hFgaPfJ8rCScS3Z51IQHl7yT8xBVDl0Sh54QOzJbvkHycs1+FLziqwp
	qaXGo7HdQrr3cEOTtpwbfwud6ULL4YvonpPmCiES2Grv01L/9T8K5y1zECUqXjbUFk0V7U
	RPNqeIZJxXUg6oDO+Ptb96nbne3h+8g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78F44139D2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 04:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPX+Dro852geVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 04:40:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: raid56: remove sector_ptr structure
Date: Thu,  9 Oct 2025 15:10:01 +1030
Message-ID: <994b548f707bbd5e2c1271f01e168366acba46c5.1759984060.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3EB181F793
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Since sector_ptr structure is now only containing a single paddr, there
is no need to use that structure.

Instead use phys_addr_t array for bio and stripe pointers.

This means several helpers are also needed to accept a paddr instead of
a sector_ptr pointer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 276 +++++++++++++++++++++-------------------------
 fs/btrfs/raid56.h |  14 +--
 2 files changed, 127 insertions(+), 163 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 77ff1ac29886..75a24fbfbe38 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -139,20 +139,6 @@ struct btrfs_stripe_hash_table {
  */
 #define INVALID_PADDR	(~(phys_addr_t)0)
 
-/*
- * A structure to present a sector inside a page, the length is fixed to
- * sectorsize;
- */
-struct sector_ptr {
-	/*
-	 * Blocks from the bio list can still be highmem.
-	 * So here we use physical address to present a page and the offset inside it.
-	 *
-	 * If it's INVALID_PADDR then it's not set.
-	 */
-	phys_addr_t paddr;
-};
-
 static void rmw_rbio_work(struct work_struct *work);
 static void rmw_rbio_work_locked(struct work_struct *work);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
@@ -165,8 +151,8 @@ static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
 	bitmap_free(rbio->error_bitmap);
 	kfree(rbio->stripe_pages);
-	kfree(rbio->bio_sectors);
-	kfree(rbio->stripe_sectors);
+	kfree(rbio->bio_paddrs);
+	kfree(rbio->stripe_paddrs);
 	kfree(rbio->finish_pointers);
 }
 
@@ -241,12 +227,17 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 	return 0;
 }
 
-static void memcpy_sectors(const struct sector_ptr *dst,
-			   const struct sector_ptr *src, u32 blocksize)
+static void memcpy_from_bio_to_stripe(struct btrfs_raid_bio *rbio, unsigned int sector_nr)
 {
-	memcpy_page(phys_to_page(dst->paddr), offset_in_page(dst->paddr),
-		    phys_to_page(src->paddr), offset_in_page(src->paddr),
-		    blocksize);
+	phys_addr_t dst = rbio->stripe_paddrs[sector_nr];
+	phys_addr_t src = rbio->bio_paddrs[sector_nr];
+
+	ASSERT(dst != INVALID_PADDR);
+	ASSERT(src != INVALID_PADDR);
+
+	memcpy_page(phys_to_page(dst), offset_in_page(dst),
+		    phys_to_page(src), offset_in_page(src),
+		    rbio->bioc->fs_info->sectorsize);
 }
 
 /*
@@ -269,7 +260,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (rbio->bio_sectors[i].paddr == INVALID_PADDR) {
+		if (rbio->bio_paddrs[i] == INVALID_PADDR) {
 			/*
 			 * Even if the sector is not covered by bio, if it is
 			 * a data sector it should still be uptodate as it is
@@ -280,8 +271,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 
-		memcpy_sectors(&rbio->stripe_sectors[i], &rbio->bio_sectors[i],
-				rbio->bioc->fs_info->sectorsize);
+		memcpy_from_bio_to_stripe(rbio, i);
 		set_bit(i, rbio->stripe_uptodate_bitmap);
 	}
 	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
@@ -341,9 +331,8 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 		if (!rbio->stripe_pages[page_index])
 			continue;
 
-		rbio->stripe_sectors[i].paddr =
-			page_to_phys(rbio->stripe_pages[page_index]) +
-			offset_in_page(offset);
+		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index] +
+						      offset_in_page(offset));
 	}
 }
 
@@ -689,29 +678,28 @@ static unsigned int rbio_stripe_sector_index(const struct btrfs_raid_bio *rbio,
 	return stripe_nr * rbio->stripe_nsectors + sector_nr;
 }
 
-/* Return a sector from rbio->stripe_sectors, not from the bio list */
-static struct sector_ptr *rbio_stripe_sector(const struct btrfs_raid_bio *rbio,
-					     unsigned int stripe_nr,
-					     unsigned int sector_nr)
+/* Return a paddr from rbio->stripe_sectors, not from the bio list */
+static phys_addr_t rbio_stripe_paddr(const struct btrfs_raid_bio *rbio,
+					    unsigned int stripe_nr,
+					    unsigned int sector_nr)
 {
-	return &rbio->stripe_sectors[rbio_stripe_sector_index(rbio, stripe_nr,
-							      sector_nr)];
+	return rbio->stripe_paddrs[rbio_stripe_sector_index(rbio, stripe_nr, sector_nr)];
 }
 
-/* Grab a sector inside P stripe */
-static struct sector_ptr *rbio_pstripe_sector(const struct btrfs_raid_bio *rbio,
-					      unsigned int sector_nr)
+/* Grab a paddr inside P stripe */
+static phys_addr_t rbio_pstripe_paddr(const struct btrfs_raid_bio *rbio,
+				      unsigned int sector_nr)
 {
-	return rbio_stripe_sector(rbio, rbio->nr_data, sector_nr);
+	return rbio_stripe_paddr(rbio, rbio->nr_data, sector_nr);
 }
 
-/* Grab a sector inside Q stripe, return NULL if not RAID6 */
-static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
-					      unsigned int sector_nr)
+/* Grab a paddr inside Q stripe, return INVALID_PADDR if not RAID6 */
+static phys_addr_t rbio_qstripe_paddr(const struct btrfs_raid_bio *rbio,
+				      unsigned int sector_nr)
 {
 	if (rbio->nr_data + 1 == rbio->real_stripes)
-		return NULL;
-	return rbio_stripe_sector(rbio, rbio->nr_data + 1, sector_nr);
+		return INVALID_PADDR;
+	return rbio_stripe_paddr(rbio, rbio->nr_data + 1, sector_nr);
 }
 
 /*
@@ -946,7 +934,7 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t status)
 }
 
 /*
- * Get a sector pointer specified by its @stripe_nr and @sector_nr.
+ * Get the paddr specified by its @stripe_nr and @sector_nr.
  *
  * @rbio:               The raid bio
  * @stripe_nr:          Stripe number, valid range [0, real_stripe)
@@ -957,11 +945,11 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t status)
  * The read/modify/write code wants to reuse the original bio page as much
  * as possible, and only use stripe_sectors as fallback.
  */
-static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
-					 int stripe_nr, int sector_nr,
-					 bool bio_list_only)
+static phys_addr_t sector_paddr_in_rbio(struct btrfs_raid_bio *rbio,
+					int stripe_nr, int sector_nr,
+					bool bio_list_only)
 {
-	struct sector_ptr *sector;
+	phys_addr_t ret = INVALID_PADDR;
 	int index;
 
 	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->real_stripes,
@@ -973,17 +961,16 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 	ASSERT(index >= 0 && index < rbio->nr_sectors);
 
 	spin_lock(&rbio->bio_list_lock);
-	sector = &rbio->bio_sectors[index];
-	if (sector->paddr != INVALID_PADDR || bio_list_only) {
+	if (rbio->bio_paddrs[index] != INVALID_PADDR || bio_list_only) {
 		/* Don't return sector without a valid page pointer */
-		if (sector->paddr == INVALID_PADDR)
-			sector = NULL;
+		if (rbio->bio_paddrs[index] != INVALID_PADDR)
+			ret = rbio->bio_paddrs[index];
 		spin_unlock(&rbio->bio_list_lock);
-		return sector;
+		return ret;
 	}
 	spin_unlock(&rbio->bio_list_lock);
 
-	return &rbio->stripe_sectors[index];
+	return rbio->stripe_paddrs[index];
 }
 
 /*
@@ -1021,23 +1008,21 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 	rbio->stripe_pages = kcalloc(num_pages, sizeof(struct page *),
 				     GFP_NOFS);
-	rbio->bio_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
-				    GFP_NOFS);
-	rbio->stripe_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
-				       GFP_NOFS);
+	rbio->bio_paddrs = kcalloc(num_sectors, sizeof(phys_addr_t), GFP_NOFS);
+	rbio->stripe_paddrs = kcalloc(num_sectors, sizeof(phys_addr_t), GFP_NOFS);
 	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
 	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 	rbio->stripe_uptodate_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 
-	if (!rbio->stripe_pages || !rbio->bio_sectors || !rbio->stripe_sectors ||
+	if (!rbio->stripe_pages || !rbio->bio_paddrs || !rbio->stripe_paddrs ||
 	    !rbio->finish_pointers || !rbio->error_bitmap || !rbio->stripe_uptodate_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
 		return ERR_PTR(-ENOMEM);
 	}
 	for (int i = 0; i < num_sectors; i++) {
-		rbio->stripe_sectors[i].paddr = INVALID_PADDR;
-		rbio->bio_sectors[i].paddr = INVALID_PADDR;
+		rbio->stripe_paddrs[i] = INVALID_PADDR;
+		rbio->bio_paddrs[i] = INVALID_PADDR;
 	}
 
 	bio_list_init(&rbio->bio_list);
@@ -1136,12 +1121,12 @@ static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
  * Return 0 if everything went well.
  * Return <0 for error.
  */
-static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
-			      struct bio_list *bio_list,
-			      struct sector_ptr *sector,
-			      unsigned int stripe_nr,
-			      unsigned int sector_nr,
-			      enum req_op op)
+static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio,
+			     struct bio_list *bio_list,
+			     phys_addr_t paddr,
+			     unsigned int stripe_nr,
+			     unsigned int sector_nr,
+			     enum req_op op)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	struct bio *last = bio_list->tail;
@@ -1159,7 +1144,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 			   rbio, stripe_nr);
 	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
 			   rbio, sector_nr);
-	ASSERT(sector->paddr != INVALID_PADDR);
+	ASSERT(paddr != INVALID_PADDR);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
 	disk_start = stripe->physical + sector_nr * sectorsize;
@@ -1190,8 +1175,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 		 */
 		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_bdev == stripe->dev->bdev) {
-			ret = bio_add_page(last, phys_to_page(sector->paddr),
-					   sectorsize, offset_in_page(sector->paddr));
+			ret = bio_add_page(last, phys_to_page(paddr), sectorsize,
+					   offset_in_page(paddr));
 			if (ret == sectorsize)
 				return 0;
 		}
@@ -1204,8 +1189,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 	bio->bi_private = rbio;
 
-	__bio_add_page(bio, phys_to_page(sector->paddr), sectorsize,
-		       offset_in_page(sector->paddr));
+	__bio_add_page(bio, phys_to_page(paddr), sectorsize, offset_in_page(paddr));
 	bio_list_add(bio_list, bio);
 	return 0;
 }
@@ -1221,9 +1205,8 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 	btrfs_bio_for_each_block(paddr, bio, &iter, sectorsize) {
 		unsigned int index = (offset >> sectorsize_bits);
-		struct sector_ptr *sector = &rbio->bio_sectors[index];
 
-		sector->paddr = paddr;
+		rbio->bio_paddrs[index] = paddr;
 		offset += sectorsize;
 	}
 }
@@ -1302,13 +1285,12 @@ static void assert_rbio(struct btrfs_raid_bio *rbio)
 	ASSERT_RBIO(rbio->nr_data < rbio->real_stripes, rbio);
 }
 
-static inline void *kmap_local_sector(const struct sector_ptr *sector)
+static inline void *kmap_local_paddr(phys_addr_t paddr)
 {
 	/* The sector pointer must have a page mapped to it. */
-	ASSERT(sector->paddr != INVALID_PADDR);
+	ASSERT(paddr != INVALID_PADDR);
 
-	return kmap_local_page(phys_to_page(sector->paddr)) +
-	       offset_in_page(sector->paddr);
+	return kmap_local_page(phys_to_page(paddr)) + offset_in_page(paddr);
 }
 
 /* Generate PQ for one vertical stripe. */
@@ -1316,31 +1298,27 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 {
 	void **pointers = rbio->finish_pointers;
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	struct sector_ptr *sector;
 	int stripe;
 	const bool has_qstripe = rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6;
 
 	/* First collect one sector from each data stripe */
-	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
-		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-		pointers[stripe] = kmap_local_sector(sector);
-	}
+	for (stripe = 0; stripe < rbio->nr_data; stripe++)
+		pointers[stripe] = kmap_local_paddr(
+				sector_paddr_in_rbio(rbio, stripe, sectornr, 0));
 
 	/* Then add the parity stripe */
-	sector = rbio_pstripe_sector(rbio, sectornr);
 	set_bit(rbio_stripe_sector_index(rbio, rbio->nr_data, sectornr),
 		rbio->stripe_uptodate_bitmap);
-	pointers[stripe++] = kmap_local_sector(sector);
+	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_paddr(rbio, sectornr));
 
 	if (has_qstripe) {
 		/*
 		 * RAID6, add the qstripe and call the library function
 		 * to fill in our p/q
 		 */
-		sector = rbio_qstripe_sector(rbio, sectornr);
 		set_bit(rbio_stripe_sector_index(rbio, rbio->nr_data + 1, sectornr),
 			rbio->stripe_uptodate_bitmap);
-		pointers[stripe++] = kmap_local_sector(sector);
+		pointers[stripe++] = kmap_local_paddr(rbio_qstripe_paddr(rbio, sectornr));
 
 		assert_rbio(rbio);
 		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
@@ -1380,7 +1358,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	 */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		struct sector_ptr *sector;
+		phys_addr_t paddr;
 
 		stripe = total_sector_nr / rbio->stripe_nsectors;
 		sectornr = total_sector_nr % rbio->stripe_nsectors;
@@ -1390,15 +1368,15 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 			continue;
 
 		if (stripe < rbio->nr_data) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (!sector)
+			paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
+			if (paddr == INVALID_PADDR)
 				continue;
 		} else {
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+			paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
 		}
 
-		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
-					 sectornr, REQ_OP_WRITE);
+		ret = rbio_add_io_paddr(rbio, bio_list, paddr, stripe,
+					sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto error;
 	}
@@ -1415,7 +1393,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		struct sector_ptr *sector;
+		phys_addr_t paddr;
 
 		stripe = total_sector_nr / rbio->stripe_nsectors;
 		sectornr = total_sector_nr % rbio->stripe_nsectors;
@@ -1440,14 +1418,14 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 			continue;
 
 		if (stripe < rbio->nr_data) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (!sector)
+			paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
+			if (paddr == INVALID_PADDR)
 				continue;
 		} else {
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+			paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
 		}
 
-		ret = rbio_add_io_sector(rbio, bio_list, sector,
+		ret = rbio_add_io_paddr(rbio, bio_list, paddr,
 					 rbio->real_stripes,
 					 sectornr, REQ_OP_WRITE);
 		if (ret)
@@ -1503,9 +1481,7 @@ static int find_stripe_sector_nr(struct btrfs_raid_bio *rbio,
 				 phys_addr_t paddr)
 {
 	for (int i = 0; i < rbio->nr_sectors; i++) {
-		struct sector_ptr *sector = &rbio->stripe_sectors[i];
-
-		if (sector->paddr == paddr)
+		if (rbio->stripe_paddrs[i] == paddr)
 			return i;
 	}
 	return -1;
@@ -1537,9 +1513,9 @@ static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 	int i;
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
-		if (rbio->stripe_sectors[i].paddr == bvec_paddr)
+		if (rbio->stripe_paddrs[i] == bvec_paddr)
 			break;
-		if (rbio->bio_sectors[i].paddr == bvec_paddr)
+		if (rbio->bio_paddrs[i] == bvec_paddr)
 			break;
 	}
 	ASSERT(i < rbio->nr_sectors);
@@ -1791,7 +1767,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 			     int stripe_nr, int sector_nr)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	struct sector_ptr *sector;
+	phys_addr_t paddr;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
 	int ret;
@@ -1807,15 +1783,15 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	 * bio list if possible.
 	 */
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-		sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
+		paddr = sector_paddr_in_rbio(rbio, stripe_nr, sector_nr, 0);
 	} else {
-		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
+		paddr = rbio_stripe_paddr(rbio, stripe_nr, sector_nr);
 	}
 
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	ret = btrfs_check_block_csum(fs_info, sector->paddr, csum_buf, csum_expected);
+	ret = btrfs_check_block_csum(fs_info, paddr, csum_buf, csum_expected);
 	return ret;
 }
 
@@ -1828,7 +1804,6 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 			    void **pointers, void **unmap_array)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	struct sector_ptr *sector;
 	const u32 sectorsize = fs_info->sectorsize;
 	int found_errors;
 	int faila;
@@ -1863,16 +1838,18 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	 * pointer order.
 	 */
 	for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
+		phys_addr_t paddr;
+
 		/*
 		 * If we're rebuilding a read, we have to use pages from the
 		 * bio list if possible.
 		 */
 		if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-			sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
+			paddr = sector_paddr_in_rbio(rbio, stripe_nr, sector_nr, 0);
 		} else {
-			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
+			paddr = rbio_stripe_paddr(rbio, stripe_nr, sector_nr);
 		}
-		pointers[stripe_nr] = kmap_local_sector(sector);
+		pointers[stripe_nr] = kmap_local_paddr(paddr);
 		unmap_array[stripe_nr] = pointers[stripe_nr];
 	}
 
@@ -1960,7 +1937,6 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		if (ret < 0)
 			goto cleanup;
 
-		sector = rbio_stripe_sector(rbio, faila, sector_nr);
 		set_bit(rbio_stripe_sector_index(rbio, faila, sector_nr),
 			rbio->stripe_uptodate_bitmap);
 	}
@@ -1969,7 +1945,6 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		if (ret < 0)
 			goto cleanup;
 
-		sector = rbio_stripe_sector(rbio, failb, sector_nr);
 		set_bit(rbio_stripe_sector_index(rbio, failb, sector_nr),
 			rbio->stripe_uptodate_bitmap);
 	}
@@ -2051,7 +2026,7 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 	     total_sector_nr++) {
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		struct sector_ptr *sector;
+		phys_addr_t paddr;
 
 		/*
 		 * Skip the range which has error.  It can be a range which is
@@ -2068,8 +2043,8 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 			continue;
 		}
 
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+		paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
+		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, stripe,
 					 sectornr, REQ_OP_READ);
 		if (ret < 0) {
 			bio_list_put(&bio_list);
@@ -2258,12 +2233,12 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	 */
 	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
 	     total_sector_nr++) {
-		struct sector_ptr *sector;
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+		phys_addr_t paddr;
 
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+		paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
+		ret = rbio_add_io_paddr(rbio, &bio_list, paddr,
 			       stripe, sectornr, REQ_OP_READ);
 		if (ret) {
 			bio_list_put(&bio_list);
@@ -2318,14 +2293,14 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 	int i;
 
 	for (i = 0; i < rbio->nr_data * rbio->stripe_nsectors; i++) {
-		struct sector_ptr *sector = &rbio->stripe_sectors[i];
+		phys_addr_t paddr = rbio->stripe_paddrs[i];
 
 		/*
 		 * We have a sector which doesn't have page nor uptodate,
 		 * thus this rbio can not be cached one, as cached one must
 		 * have all its data sectors present and uptodate.
 		 */
-		if (sector->paddr == INVALID_PADDR ||
+		if (paddr == INVALID_PADDR ||
 		    !test_bit(i, rbio->stripe_uptodate_bitmap))
 			return true;
 	}
@@ -2517,8 +2492,8 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	int sectornr;
 	bool has_qstripe;
 	struct page *page;
-	struct sector_ptr p_sector = { .paddr = INVALID_PADDR };
-	struct sector_ptr q_sector = { .paddr = INVALID_PADDR };
+	phys_addr_t p_paddr = INVALID_PADDR;
+	phys_addr_t q_paddr = INVALID_PADDR;
 	struct bio_list bio_list;
 	int is_replace = 0;
 	int ret;
@@ -2551,36 +2526,34 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	page = alloc_page(GFP_NOFS);
 	if (!page)
 		return -ENOMEM;
-	p_sector.paddr = page_to_phys(page);
+	p_paddr = page_to_phys(page);
 	page = NULL;
+	pointers[nr_data] = kmap_local_paddr(p_paddr);
 
 	if (has_qstripe) {
 		/* RAID6, allocate and map temp space for the Q stripe */
 		page = alloc_page(GFP_NOFS);
 		if (!page) {
-			__free_page(phys_to_page(p_sector.paddr));
-			p_sector.paddr = INVALID_PADDR;
+			__free_page(phys_to_page(p_paddr));
+			p_paddr = INVALID_PADDR;
 			return -ENOMEM;
 		}
-		q_sector.paddr = page_to_phys(page);
+		q_paddr = page_to_phys(page);
 		page = NULL;
-		pointers[rbio->real_stripes - 1] = kmap_local_sector(&q_sector);
+		pointers[rbio->real_stripes - 1] = kmap_local_paddr(q_paddr);
 	}
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
 	/* Map the parity stripe just once */
-	pointers[nr_data] = kmap_local_sector(&p_sector);
 
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		struct sector_ptr *sector;
 		void *parity;
 
 		/* first collect one page from each data stripe */
-		for (stripe = 0; stripe < nr_data; stripe++) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_sector(sector);
-		}
+		for (stripe = 0; stripe < nr_data; stripe++)
+			pointers[stripe] = kmap_local_paddr(
+					sector_paddr_in_rbio(rbio, stripe, sectornr, 0));
 
 		if (has_qstripe) {
 			assert_rbio(rbio);
@@ -2594,8 +2567,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 		}
 
 		/* Check scrubbing parity and repair it */
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		parity = kmap_local_sector(sector);
+		parity = kmap_local_paddr(rbio_stripe_paddr(rbio, rbio->scrubp, sectornr));
 		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
 			memcpy(parity, pointers[rbio->scrubp], sectorsize);
 		else
@@ -2608,11 +2580,11 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	}
 
 	kunmap_local(pointers[nr_data]);
-	__free_page(phys_to_page(p_sector.paddr));
-	p_sector.paddr = INVALID_PADDR;
-	if (q_sector.paddr != INVALID_PADDR) {
-		__free_page(phys_to_page(q_sector.paddr));
-		q_sector.paddr = INVALID_PADDR;
+	__free_page(phys_to_page(p_paddr));
+	p_paddr = INVALID_PADDR;
+	if (q_paddr != INVALID_PADDR) {
+		__free_page(phys_to_page(q_paddr));
+		q_paddr = INVALID_PADDR;
 	}
 
 	/*
@@ -2621,10 +2593,10 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * everything else.
 	 */
 	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		struct sector_ptr *sector;
+		phys_addr_t paddr;
 
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
+		paddr = rbio_stripe_paddr(rbio, rbio->scrubp, sectornr);
+		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, rbio->scrubp,
 					 sectornr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
@@ -2639,10 +2611,10 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 */
 	ASSERT_RBIO(rbio->bioc->replace_stripe_src >= 0, rbio);
 	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
-		struct sector_ptr *sector;
+		phys_addr_t paddr;
 
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+		paddr = rbio_stripe_paddr(rbio, rbio->scrubp, sectornr);
+		ret = rbio_add_io_paddr(rbio, &bio_list, paddr,
 					 rbio->real_stripes,
 					 sectornr, REQ_OP_WRITE);
 		if (ret)
@@ -2760,7 +2732,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 	     total_sector_nr++) {
 		int sectornr = total_sector_nr % rbio->stripe_nsectors;
 		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		struct sector_ptr *sector;
+		phys_addr_t paddr;
 
 		/* No data in the vertical stripe, no need to read. */
 		if (!test_bit(sectornr, &rbio->dbitmap))
@@ -2768,14 +2740,14 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 
 		/*
 		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk. If sector_in_rbio() finds a sector
+		 * read them from the disk. If sector_paddr_in_rbio() finds a sector
 		 * in the bio list we don't need to read it off the stripe.
 		 */
-		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-		if (sector)
+		paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
+		if (paddr == INVALID_PADDR)
 			continue;
 
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		paddr = rbio_stripe_paddr(rbio, stripe, sectornr);
 		/*
 		 * The bio cache may have handed us an uptodate sector.  If so,
 		 * use it.
@@ -2784,7 +2756,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 			     rbio->stripe_uptodate_bitmap))
 			continue;
 
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+		ret = rbio_add_io_paddr(rbio, &bio_list, paddr, stripe,
 					 sectornr, REQ_OP_READ);
 		if (ret) {
 			bio_list_put(&bio_list);
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index b636de4af7ac..42a45716fb03 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -16,7 +16,6 @@
 #include "volumes.h"
 
 struct page;
-struct sector_ptr;
 struct btrfs_fs_info;
 
 enum btrfs_rbio_ops {
@@ -116,13 +115,10 @@ struct btrfs_raid_bio {
 	struct page **stripe_pages;
 
 	/* Pointers to the sectors in the bio_list, for faster lookup */
-	struct sector_ptr *bio_sectors;
+	phys_addr_t *bio_paddrs;
 
-	/*
-	 * For subpage support, we need to map each sector to above
-	 * stripe_pages.
-	 */
-	struct sector_ptr *stripe_sectors;
+	/* Pointers to the sectors in the stripe_pages[]. */
+	phys_addr_t *stripe_paddrs;
 
 	/* Each set bit means the corresponding sector in stripe_sectors[] is uptodate. */
 	unsigned long *stripe_uptodate_bitmap;
@@ -134,10 +130,6 @@ struct btrfs_raid_bio {
 	 * The bitmap recording where IO errors happened.
 	 * Each bit is corresponding to one sector in either bio_sectors[] or
 	 * stripe_sectors[] array.
-	 *
-	 * The reason we don't use another bit in sector_ptr is, we have two
-	 * arrays of sectors, and a lot of IO can use sectors in both arrays.
-	 * Thus making it much harder to iterate.
 	 */
 	unsigned long *error_bitmap;
 
-- 
2.50.1


