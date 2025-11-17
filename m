Return-Path: <linux-btrfs+bounces-19051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71EC62B9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 08:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F360A35AE52
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FE318143;
	Mon, 17 Nov 2025 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Cg3zq8K3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Cg3zq8K3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58E318141
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364682; cv=none; b=VBf5XXxOv0i4LX33KRw0MlB75uLuzRbzy9zAm2Z2G/828rSg84LnURphYynAVHxzdhoUZgDEoySPMx62hrLRXKvto9Y+4yu9iabYA6L1rII1+yT3VhI6rzb7rg/VFdnmmVpL31b3c96iPtXNHvKy+HZzhHO3qkt19Qgns6cSEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364682; c=relaxed/simple;
	bh=MsjHMQcvINg2zs4+o5rtd42C0QG8A4GDtQDrf/voJZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8ZVvnDmUE3SoXmG+mcSe/wgwChJO/HdEqdJDIE6ARwVU0C495j0Ze59Fy36EX6KIr6JIXM4/ugmzt9IaMdanxB9KjJoN+p3E35luTRoPxSy6DzQj8yy9jb06CCDs9ufDpqHc8JWgSCX1M9qeLGMbCLwwG6F38ezcaqqcFgaDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Cg3zq8K3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Cg3zq8K3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16AA3211FF
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95TUUEmyYsohn7JBZ6fnl62E3nEiA3kyuMRFEVpfUHc=;
	b=Cg3zq8K3jB9T8JL077Pio/JDgYBCYQavcDbof/RMsy9crMt3aLSJ2HhRe+t26kVWkO8nlb
	7+rulqqYDkmYT3nidB0k6xRsHlQB9GpBdcd+kOZ11NTX2r6wSmC+QXzJ5KhCNTlqo/02g2
	aqDrb8tKugzTItf0cIc2XkWqVu0Nyp0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Cg3zq8K3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763364674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95TUUEmyYsohn7JBZ6fnl62E3nEiA3kyuMRFEVpfUHc=;
	b=Cg3zq8K3jB9T8JL077Pio/JDgYBCYQavcDbof/RMsy9crMt3aLSJ2HhRe+t26kVWkO8nlb
	7+rulqqYDkmYT3nidB0k6xRsHlQB9GpBdcd+kOZ11NTX2r6wSmC+QXzJ5KhCNTlqo/02g2
	aqDrb8tKugzTItf0cIc2XkWqVu0Nyp0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4585E3EA62
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6E07AkHPGmkLIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 07:31:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] btrfs: introduce a new parameter to locate a sector
Date: Mon, 17 Nov 2025 18:00:42 +1030
Message-ID: <5b233479bfba2d1c03fd579d615907f6fd585f62.1763361991.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 16AA3211FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Since we can not ensure all bios from the higher layer is backed by
large folios (e.g. direct IO, encoded read/write/send), we need to the
ability to locate sub-block (aka, a page) inside a full stripe.

So the existing @stripe_nr + @sector_nr combination is not enough to
locate such page for bs > ps cases.

Introduce a new parameter, @step_nr, to locate the page of a larger fs
block.
The naming is following the conventions used inside btrfs elsewhere,
where one step is min(sectorsize, PAGE_SIZE).

It's still a preparation, only touching the following aspects:

- btrfs_dump_rbio()
  To show the new @sector_nsteps member.

- btrfs_raid_bio::sector_nsteps
  Recording how many steps there are inside a fs block.

- Enlarge btrfs_raid_bio::*_paddrs[] size
  To take @sector_nsteps into consideration.

- index_one_bio()
- index_stripe_sectors()
- memcpy_from_bio_to_stripe()
- cache_rbio_pages()
- need_read_stripe_sectors()
  Those functions are iterating *_paddrs[], which needs to take
  sector_nsteps into consideration.

- Rename rbio_stripe_sector_index() to rbio_sector_index()
  The "stripe" part is not that helpful.

  And an extra ASSERT() before returning the result.

- Add a new rbio_paddr_index() helper
  This will take the extra @step_nr into consideration.

- The comments of btrfs_raid_bio

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 92 +++++++++++++++++++++++++++++++----------------
 fs/btrfs/raid56.h | 22 ++++++++++--
 2 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 95cc243d9c8b..7f01178be7d8 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -66,10 +66,10 @@ static void btrfs_dump_rbio(const struct btrfs_fs_info *fs_info,
 
 	dump_bioc(fs_info, rbio->bioc);
 	btrfs_crit(fs_info,
-"rbio flags=0x%lx nr_sectors=%u nr_data=%u real_stripes=%u stripe_nsectors=%u scrubp=%u dbitmap=0x%lx",
+"rbio flags=0x%lx nr_sectors=%u nr_data=%u real_stripes=%u stripe_nsectors=%u sector_nsteps=%u scrubp=%u dbitmap=0x%lx",
 		rbio->flags, rbio->nr_sectors, rbio->nr_data,
 		rbio->real_stripes, rbio->stripe_nsectors,
-		rbio->scrubp, rbio->dbitmap);
+		rbio->sector_nsteps, rbio->scrubp, rbio->dbitmap);
 }
 
 #define ASSERT_RBIO(expr, rbio)						\
@@ -229,15 +229,20 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 
 static void memcpy_from_bio_to_stripe(struct btrfs_raid_bio *rbio, unsigned int sector_nr)
 {
-	phys_addr_t dst = rbio->stripe_paddrs[sector_nr];
-	phys_addr_t src = rbio->bio_paddrs[sector_nr];
+	const u32 step = min(rbio->bioc->fs_info->sectorsize, PAGE_SIZE);
 
-	ASSERT(dst != INVALID_PADDR);
-	ASSERT(src != INVALID_PADDR);
+	ASSERT(sector_nr < rbio->nr_sectors);
+	for (int i = 0; i < rbio->sector_nsteps; i++) {
+		unsigned int index = sector_nr * rbio->sector_nsteps + i;
+		phys_addr_t dst = rbio->stripe_paddrs[index];
+		phys_addr_t src = rbio->bio_paddrs[index];
 
-	memcpy_page(phys_to_page(dst), offset_in_page(dst),
-		    phys_to_page(src), offset_in_page(src),
-		    rbio->bioc->fs_info->sectorsize);
+		ASSERT(dst != INVALID_PADDR);
+		ASSERT(src != INVALID_PADDR);
+
+		memcpy_page(phys_to_page(dst), offset_in_page(dst),
+			    phys_to_page(src), offset_in_page(src), step);
+	}
 }
 
 /*
@@ -260,7 +265,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 
 	for (i = 0; i < rbio->nr_sectors; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (rbio->bio_paddrs[i] == INVALID_PADDR) {
+		if (rbio->bio_paddrs[i * rbio->sector_nsteps] == INVALID_PADDR) {
 			/*
 			 * Even if the sector is not covered by bio, if it is
 			 * a data sector it should still be uptodate as it is
@@ -320,11 +325,12 @@ static __maybe_unused bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbi
  */
 static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 step = min(rbio->bioc->fs_info->sectorsize, PAGE_SIZE);
 	u32 offset;
 	int i;
 
-	for (i = 0, offset = 0; i < rbio->nr_sectors; i++, offset += sectorsize) {
+	for (i = 0, offset = 0; i < rbio->nr_sectors * rbio->sector_nsteps;
+	     i++, offset += step) {
 		int page_index = offset >> PAGE_SHIFT;
 
 		ASSERT(page_index < rbio->nr_pages);
@@ -668,21 +674,41 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	return 1;
 }
 
-static unsigned int rbio_stripe_sector_index(const struct btrfs_raid_bio *rbio,
-					     unsigned int stripe_nr,
-					     unsigned int sector_nr)
+/* Return the sector index for @stripe_nr and @sector_nr. */
+static unsigned int rbio_sector_index(const struct btrfs_raid_bio *rbio,
+				      unsigned int stripe_nr,
+				      unsigned int sector_nr)
 {
+	unsigned int ret;
+
 	ASSERT_RBIO_STRIPE(stripe_nr < rbio->real_stripes, rbio, stripe_nr);
 	ASSERT_RBIO_SECTOR(sector_nr < rbio->stripe_nsectors, rbio, sector_nr);
 
-	return stripe_nr * rbio->stripe_nsectors + sector_nr;
+	ret = stripe_nr * rbio->stripe_nsectors + sector_nr;
+	ASSERT(ret < rbio->nr_sectors);
+	return ret;
+}
+
+/* Return the paddr array index for @stripe_nr, @sector_nr and @step_nr. */
+static unsigned int rbio_paddr_index(const struct btrfs_raid_bio *rbio,
+				     unsigned int stripe_nr,
+				     unsigned int sector_nr,
+				     unsigned int step_nr)
+{
+	unsigned int ret;
+
+	ASSERT_RBIO_SECTOR(step_nr < rbio->sector_nsteps, rbio, step_nr);
+
+	ret = rbio_sector_index(rbio, stripe_nr, sector_nr) * rbio->sector_nsteps + step_nr;
+	ASSERT(ret < rbio->nr_sectors * rbio->sector_nsteps);
+	return ret;
 }
 
 /* Return a paddr from rbio->stripe_sectors, not from the bio list */
 static phys_addr_t rbio_stripe_paddr(const struct btrfs_raid_bio *rbio,
 				     unsigned int stripe_nr, unsigned int sector_nr)
 {
-	return rbio->stripe_paddrs[rbio_stripe_sector_index(rbio, stripe_nr, sector_nr)];
+	return rbio->stripe_paddrs[rbio_paddr_index(rbio, stripe_nr, sector_nr, 0)];
 }
 
 /* Grab a paddr inside P stripe */
@@ -985,6 +1011,8 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	const unsigned int stripe_nsectors =
 		BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
 	const unsigned int num_sectors = stripe_nsectors * real_stripes;
+	const unsigned int step = min(fs_info->sectorsize, PAGE_SIZE);
+	const unsigned int sector_nsteps = fs_info->sectorsize / step;
 	struct btrfs_raid_bio *rbio;
 
 	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
@@ -1007,8 +1035,8 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 	rbio->stripe_pages = kcalloc(num_pages, sizeof(struct page *),
 				     GFP_NOFS);
-	rbio->bio_paddrs = kcalloc(num_sectors, sizeof(phys_addr_t), GFP_NOFS);
-	rbio->stripe_paddrs = kcalloc(num_sectors, sizeof(phys_addr_t), GFP_NOFS);
+	rbio->bio_paddrs = kcalloc(num_sectors * sector_nsteps, sizeof(phys_addr_t), GFP_NOFS);
+	rbio->stripe_paddrs = kcalloc(num_sectors * sector_nsteps, sizeof(phys_addr_t), GFP_NOFS);
 	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
 	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
 	rbio->stripe_uptodate_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
@@ -1019,7 +1047,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		kfree(rbio);
 		return ERR_PTR(-ENOMEM);
 	}
-	for (int i = 0; i < num_sectors; i++) {
+	for (int i = 0; i < num_sectors * sector_nsteps; i++) {
 		rbio->stripe_paddrs[i] = INVALID_PADDR;
 		rbio->bio_paddrs[i] = INVALID_PADDR;
 	}
@@ -1037,6 +1065,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	rbio->real_stripes = real_stripes;
 	rbio->stripe_npages = stripe_npages;
 	rbio->stripe_nsectors = stripe_nsectors;
+	rbio->sector_nsteps = sector_nsteps;
 	refcount_set(&rbio->refs, 1);
 	atomic_set(&rbio->stripes_pending, 0);
 
@@ -1192,18 +1221,19 @@ static int rbio_add_io_paddr(struct btrfs_raid_bio *rbio, struct bio_list *bio_l
 
 static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectorsize_bits = rbio->bioc->fs_info->sectorsize_bits;
+	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
+	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
+	const u32 step_bits = min(fs_info->sectorsize_bits, PAGE_SHIFT);
 	struct bvec_iter iter = bio->bi_iter;
 	phys_addr_t paddr;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->full_stripe_logical;
 
-	btrfs_bio_for_each_block(paddr, bio, &iter, sectorsize) {
-		unsigned int index = (offset >> sectorsize_bits);
+	btrfs_bio_for_each_block(paddr, bio, &iter, step) {
+		unsigned int index = (offset >> step_bits);
 
 		rbio->bio_paddrs[index] = paddr;
-		offset += sectorsize;
+		offset += step;
 	}
 }
 
@@ -1303,7 +1333,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 				sector_paddr_in_rbio(rbio, stripe, sectornr, 0));
 
 	/* Then add the parity stripe */
-	set_bit(rbio_stripe_sector_index(rbio, rbio->nr_data, sectornr),
+	set_bit(rbio_sector_index(rbio, rbio->nr_data, sectornr),
 		rbio->stripe_uptodate_bitmap);
 	pointers[stripe++] = kmap_local_paddr(rbio_pstripe_paddr(rbio, sectornr));
 
@@ -1312,7 +1342,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		 * RAID6, add the qstripe and call the library function
 		 * to fill in our p/q
 		 */
-		set_bit(rbio_stripe_sector_index(rbio, rbio->nr_data + 1, sectornr),
+		set_bit(rbio_sector_index(rbio, rbio->nr_data + 1, sectornr),
 			rbio->stripe_uptodate_bitmap);
 		pointers[stripe++] = kmap_local_paddr(rbio_qstripe_paddr(rbio, sectornr));
 
@@ -1932,7 +1962,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		if (ret < 0)
 			goto cleanup;
 
-		set_bit(rbio_stripe_sector_index(rbio, faila, sector_nr),
+		set_bit(rbio_sector_index(rbio, faila, sector_nr),
 			rbio->stripe_uptodate_bitmap);
 	}
 	if (failb >= 0) {
@@ -1940,7 +1970,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		if (ret < 0)
 			goto cleanup;
 
-		set_bit(rbio_stripe_sector_index(rbio, failb, sector_nr),
+		set_bit(rbio_sector_index(rbio, failb, sector_nr),
 			rbio->stripe_uptodate_bitmap);
 	}
 
@@ -2288,7 +2318,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 	int i;
 
 	for (i = 0; i < rbio->nr_data * rbio->stripe_nsectors; i++) {
-		phys_addr_t paddr = rbio->stripe_paddrs[i];
+		phys_addr_t paddr = rbio->stripe_paddrs[i * rbio->sector_nsteps];
 
 		/*
 		 * We have a sector which doesn't have page nor uptodate,
@@ -2746,7 +2776,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 		 * The bio cache may have handed us an uptodate sector.  If so,
 		 * use it.
 		 */
-		if (test_bit(rbio_stripe_sector_index(rbio, stripe, sectornr),
+		if (test_bit(rbio_sector_index(rbio, stripe, sectornr),
 			     rbio->stripe_uptodate_bitmap))
 			continue;
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 87b0c73ee05b..cafad2435ecf 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -50,7 +50,7 @@ enum btrfs_rbio_ops {
  * If there is no bio covering a sector, then btrfs_raid_bio::bio_paddrs[i] will
  * be INVALID_PADDR.
  *
- * The length of each entry in bio_paddrs[] is sectorsize.
+ * The length of each entry in bio_paddrs[] is a step (aka, min(sectorsize, PAGE_SIZE)).
  *
  * [PAGES FOR INTERNAL USAGES]
  * For pages not covered by any bio or belonging to P/Q stripes, they are stored
@@ -71,7 +71,7 @@ enum btrfs_rbio_ops {
  * If the corresponding page of stripe_paddrs[i] is not allocated, the value of
  * stripe_paddrs[i] will be INVALID_PADDR.
  *
- * The length of each entry in stripe_paddrs[] is sectorsize.
+ * The length of each entry in stripe_paddrs[] is a step.
  *
  * [LOCATING A SECTOR]
  * To locating a sector for IO, we need the following info:
@@ -84,7 +84,15 @@ enum btrfs_rbio_ops {
  *   Starts from 0 (representing the first sector of the stripe), ends
  *   at BTRFS_STRIPE_LEN / sectorsize - 1.
  *
- *   All existing bitmaps are based on sector numbers.
+ * - step_nr
+ *   A step is min(sector_size, PAGE_SIZE).
+ *
+ *   Starts from 0 (representing the first step of the sector), ends
+ *   at @sector_nsteps - 1.
+ *
+ *   For most call sites they do not need to bother this parameter.
+ *   It is for bs > ps support and only for vertical stripe related works.
+ *   (e.g. RMW/recover)
  *
  * - from which array
  *   Whether grabbing from stripe_paddrs[] (aka, internal pages) or from the
@@ -152,6 +160,14 @@ struct btrfs_raid_bio {
 	/* How many sectors there are for each stripe */
 	u8 stripe_nsectors;
 
+	/*
+	 * How many steps there are for one sector.
+	 *
+	 * For bs > ps cases, it's sectorsize / PAGE_SIZE.
+	 * For bs <= ps cases, it's always 1.
+	 */
+	u8 sector_nsteps;
+
 	/* Stripe number that we're scrubbing  */
 	u8 scrubp;
 
-- 
2.51.2


