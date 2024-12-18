Return-Path: <linux-btrfs+bounces-10540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E449F61FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420CD1896477
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1719B5BE;
	Wed, 18 Dec 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uuDAnc8k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uuDAnc8k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE629194AFB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514934; cv=none; b=Lb2fk6EPv50wlYWxz1+zxv2IB/lfGh2Fe10Rpqs1x8BAaFB/0Yw09KvyhuSS+6nMdO7qq+b0DRPtgsIMe3KyKXVbEVqzP/9NIadFOYv6Uzoyr7m7vfhRYt76sapUF35yIn8+LDvGLkd3qVqvXMqVubPGCZ8uY9YAGUCTDpxusZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514934; c=relaxed/simple;
	bh=xmO1UBcbrdLCKSaefHfwkd4tWZtmMsIQ4xC7T9BzSCQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjKnjZSYuLsUYdBWGZs47ua8NvBbV+ulQ9XilUDeTffgZGIH1bethKa5XuA0bhvl9drHc2CeLwr2WNkZ3VqkCd3TBYRMPNFgc5kvmitFlJJoHGA30uzqd/ps+C6LsJAfUIIsk+ijz2I4MHEKRFGK4dUGC2FlMsHeBgCztFTLBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uuDAnc8k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uuDAnc8k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DDAB2115F
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTAt9017a09iJgDHkVJb4jaU/hz7G+YJd/9n2CpHXAQ=;
	b=uuDAnc8kO3zOdIw/UeZ4k6Bh1rq4UfWtd43sj2G2r5l5HXDYx8sH3xJPEgTO7jEZ3xjJdx
	+rpX+gMg4e22t16oEFZaBLYofxtQp+tW4QXrZ2y0ICviQxsxWMEhsJyo5eP0O7MJ1KmFEc
	9mu7c2zr6+ndS8KYnOiQHuzjN7q2YgA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTAt9017a09iJgDHkVJb4jaU/hz7G+YJd/9n2CpHXAQ=;
	b=uuDAnc8kO3zOdIw/UeZ4k6Bh1rq4UfWtd43sj2G2r5l5HXDYx8sH3xJPEgTO7jEZ3xjJdx
	+rpX+gMg4e22t16oEFZaBLYofxtQp+tW4QXrZ2y0ICviQxsxWMEhsJyo5eP0O7MJ1KmFEc
	9mu7c2zr6+ndS8KYnOiQHuzjN7q2YgA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A96C132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJNqAu+YYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/18] btrfs: migrate raid56.[ch] to use block size terminology
Date: Wed, 18 Dec 2024 20:11:27 +1030
Message-ID: <750e822aa037c4910bf71cedaa592d94370f9172.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Raid56 is a heavy user of the sector terminology, including a lot of
raid56 internal structure names and comments, thus this involves quite
a lot of renames.

And since we're here, also fix the "vertical" typo too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 806 +++++++++++++++++++++++-----------------------
 fs/btrfs/raid56.h |  36 +--
 2 files changed, 421 insertions(+), 421 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0c5b19c2d0db..c4ca2453c414 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -66,9 +66,9 @@ static void btrfs_dump_rbio(const struct btrfs_fs_info *fs_info,
 
 	dump_bioc(fs_info, rbio->bioc);
 	btrfs_crit(fs_info,
-"rbio flags=0x%lx nr_sectors=%u nr_data=%u real_stripes=%u stripe_nsectors=%u scrubp=%u dbitmap=0x%lx",
-		rbio->flags, rbio->nr_sectors, rbio->nr_data,
-		rbio->real_stripes, rbio->stripe_nsectors,
+"rbio flags=0x%lx nr_blocks=%u nr_data=%u real_stripes=%u stripe_nblocks=%u scrubp=%u dbitmap=0x%lx",
+		rbio->flags, rbio->nr_blocks, rbio->nr_data,
+		rbio->real_stripes, rbio->stripe_nblocks,
 		rbio->scrubp, rbio->dbitmap);
 }
 
@@ -95,14 +95,14 @@ static void btrfs_dump_rbio(const struct btrfs_fs_info *fs_info,
 	ASSERT((expr));							\
 })
 
-#define ASSERT_RBIO_SECTOR(expr, rbio, sector_nr)			\
+#define ASSERT_RBIO_BLOCK(expr, rbio, block_nr)				\
 ({									\
 	if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {	\
 		const struct btrfs_fs_info *__fs_info = (rbio)->bioc ?	\
 					(rbio)->bioc->fs_info : NULL;	\
 									\
 		btrfs_dump_rbio(__fs_info, (rbio));			\
-		btrfs_crit(__fs_info, "sector_nr=%d", (sector_nr));	\
+		btrfs_crit(__fs_info, "block_nr=%d", (block_nr));	\
 	}								\
 	ASSERT((expr));							\
 })
@@ -134,11 +134,11 @@ struct btrfs_stripe_hash_table {
 };
 
 /*
- * A bvec like structure to present a sector inside a page.
+ * A bvec like structure to present a block inside a page.
  *
- * Unlike bvec we don't need bvlen, as it's fixed to sectorsize.
+ * Unlike bvec we don't need bvlen, as it's fixed to blocksize.
  */
-struct sector_ptr {
+struct block_ptr {
 	struct page *page;
 	unsigned int pgoff:24;
 	unsigned int uptodate:8;
@@ -156,8 +156,8 @@ static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
 	bitmap_free(rbio->error_bitmap);
 	kfree(rbio->stripe_pages);
-	kfree(rbio->bio_sectors);
-	kfree(rbio->stripe_sectors);
+	kfree(rbio->bio_blocks);
+	kfree(rbio->stripe_blocks);
 	kfree(rbio->finish_pointers);
 }
 
@@ -235,7 +235,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 
 /*
  * caching an rbio means to copy anything from the
- * bio_sectors array into the stripe_pages array.  We
+ * bio_blocks array into the stripe_pages array.  We
  * use the page uptodate bit in the stripe cache array
  * to indicate if it has valid data
  *
@@ -251,26 +251,26 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 	if (ret)
 		return;
 
-	for (i = 0; i < rbio->nr_sectors; i++) {
+	for (i = 0; i < rbio->nr_blocks; i++) {
 		/* Some range not covered by bio (partial write), skip it */
-		if (!rbio->bio_sectors[i].page) {
+		if (!rbio->bio_blocks[i].page) {
 			/*
-			 * Even if the sector is not covered by bio, if it is
-			 * a data sector it should still be uptodate as it is
+			 * Even if the block is not covered by bio, if it is
+			 * a data block it should still be uptodate as it is
 			 * read from disk.
 			 */
-			if (i < rbio->nr_data * rbio->stripe_nsectors)
-				ASSERT(rbio->stripe_sectors[i].uptodate);
+			if (i < rbio->nr_data * rbio->stripe_nblocks)
+				ASSERT(rbio->stripe_blocks[i].uptodate);
 			continue;
 		}
 
-		ASSERT(rbio->stripe_sectors[i].page);
-		memcpy_page(rbio->stripe_sectors[i].page,
-			    rbio->stripe_sectors[i].pgoff,
-			    rbio->bio_sectors[i].page,
-			    rbio->bio_sectors[i].pgoff,
-			    rbio->bioc->fs_info->sectorsize);
-		rbio->stripe_sectors[i].uptodate = 1;
+		ASSERT(rbio->stripe_blocks[i].page);
+		memcpy_page(rbio->stripe_blocks[i].page,
+			    rbio->stripe_blocks[i].pgoff,
+			    rbio->bio_blocks[i].page,
+			    rbio->bio_blocks[i].pgoff,
+			    rbio->bioc->fs_info->blocksize);
+		rbio->stripe_blocks[i].uptodate = 1;
 	}
 	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 }
@@ -293,49 +293,49 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
 	return hash_64(num >> 16, BTRFS_STRIPE_HASH_TABLE_BITS);
 }
 
-static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
+static bool full_page_blocks_uptodate(struct btrfs_raid_bio *rbio,
 				       unsigned int page_nr)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
+	const u32 blocks_per_page = PAGE_SIZE / blocksize;
 	int i;
 
 	ASSERT(page_nr < rbio->nr_pages);
 
-	for (i = sectors_per_page * page_nr;
-	     i < sectors_per_page * page_nr + sectors_per_page;
+	for (i = blocks_per_page * page_nr;
+	     i < blocks_per_page * page_nr + blocks_per_page;
 	     i++) {
-		if (!rbio->stripe_sectors[i].uptodate)
+		if (!rbio->stripe_blocks[i].uptodate)
 			return false;
 	}
 	return true;
 }
 
 /*
- * Update the stripe_sectors[] array to use correct page and pgoff
+ * Update the stripe_blocks[] array to use correct page and pgoff
  *
  * Should be called every time any page pointer in stripes_pages[] got modified.
  */
-static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
+static void index_stripe_blocks(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
 	u32 offset;
 	int i;
 
-	for (i = 0, offset = 0; i < rbio->nr_sectors; i++, offset += sectorsize) {
+	for (i = 0, offset = 0; i < rbio->nr_blocks; i++, offset += blocksize) {
 		int page_index = offset >> PAGE_SHIFT;
 
 		ASSERT(page_index < rbio->nr_pages);
-		rbio->stripe_sectors[i].page = rbio->stripe_pages[page_index];
-		rbio->stripe_sectors[i].pgoff = offset_in_page(offset);
+		rbio->stripe_blocks[i].page = rbio->stripe_pages[page_index];
+		rbio->stripe_blocks[i].pgoff = offset_in_page(offset);
 	}
 }
 
 static void steal_rbio_page(struct btrfs_raid_bio *src,
 			    struct btrfs_raid_bio *dest, int page_nr)
 {
-	const u32 sectorsize = src->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	const u32 blocksize = src->bioc->fs_info->blocksize;
+	const u32 blocks_per_page = PAGE_SIZE / blocksize;
 	int i;
 
 	if (dest->stripe_pages[page_nr])
@@ -343,32 +343,32 @@ static void steal_rbio_page(struct btrfs_raid_bio *src,
 	dest->stripe_pages[page_nr] = src->stripe_pages[page_nr];
 	src->stripe_pages[page_nr] = NULL;
 
-	/* Also update the sector->uptodate bits. */
-	for (i = sectors_per_page * page_nr;
-	     i < sectors_per_page * page_nr + sectors_per_page; i++)
-		dest->stripe_sectors[i].uptodate = true;
+	/* Also update the block->uptodate bits. */
+	for (i = blocks_per_page * page_nr;
+	     i < blocks_per_page * page_nr + blocks_per_page; i++)
+		dest->stripe_blocks[i].uptodate = true;
 }
 
 static bool is_data_stripe_page(struct btrfs_raid_bio *rbio, int page_nr)
 {
-	const int sector_nr = (page_nr << PAGE_SHIFT) >>
-			      rbio->bioc->fs_info->sectorsize_bits;
+	const int block_nr = (page_nr << PAGE_SHIFT) >>
+			      rbio->bioc->fs_info->blocksize_bits;
 
 	/*
-	 * We have ensured PAGE_SIZE is aligned with sectorsize, thus
+	 * We have ensured PAGE_SIZE is aligned with blocksize, thus
 	 * we won't have a page which is half data half parity.
 	 *
-	 * Thus if the first sector of the page belongs to data stripes, then
+	 * Thus if the first block of the page belongs to data stripes, then
 	 * the full page belongs to data stripes.
 	 */
-	return (sector_nr < rbio->nr_data * rbio->stripe_nsectors);
+	return (block_nr < rbio->nr_data * rbio->stripe_nblocks);
 }
 
 /*
  * Stealing an rbio means taking all the uptodate pages from the stripe array
  * in the source rbio and putting them into the destination rbio.
  *
- * This will also update the involved stripe_sectors[] which are referring to
+ * This will also update the involved stripe_blocks[] which are referring to
  * the old pages.
  */
 static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
@@ -393,11 +393,11 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 		 * all data stripe pages present and uptodate.
 		 */
 		ASSERT(p);
-		ASSERT(full_page_sectors_uptodate(src, i));
+		ASSERT(full_page_blocks_uptodate(src, i));
 		steal_rbio_page(src, dest, i);
 	}
-	index_stripe_sectors(dest);
-	index_stripe_sectors(src);
+	index_stripe_blocks(dest);
+	index_stripe_blocks(src);
 }
 
 /*
@@ -414,7 +414,7 @@ static void merge_rbio(struct btrfs_raid_bio *dest,
 	dest->bio_list_bytes += victim->bio_list_bytes;
 	/* Also inherit the bitmaps from @victim. */
 	bitmap_or(&dest->dbitmap, &victim->dbitmap, &dest->dbitmap,
-		  dest->stripe_nsectors);
+		  dest->stripe_nblocks);
 }
 
 /*
@@ -667,39 +667,39 @@ static int rbio_can_merge(struct btrfs_raid_bio *last,
 	return 1;
 }
 
-static unsigned int rbio_stripe_sector_index(const struct btrfs_raid_bio *rbio,
+static unsigned int rbio_stripe_block_index(const struct btrfs_raid_bio *rbio,
 					     unsigned int stripe_nr,
-					     unsigned int sector_nr)
+					     unsigned int block_nr)
 {
 	ASSERT_RBIO_STRIPE(stripe_nr < rbio->real_stripes, rbio, stripe_nr);
-	ASSERT_RBIO_SECTOR(sector_nr < rbio->stripe_nsectors, rbio, sector_nr);
+	ASSERT_RBIO_BLOCK(block_nr < rbio->stripe_nblocks, rbio, block_nr);
 
-	return stripe_nr * rbio->stripe_nsectors + sector_nr;
+	return stripe_nr * rbio->stripe_nblocks + block_nr;
 }
 
-/* Return a sector from rbio->stripe_sectors, not from the bio list */
-static struct sector_ptr *rbio_stripe_sector(const struct btrfs_raid_bio *rbio,
+/* Return a block from rbio->stripe_blocks, not from the bio list */
+static struct block_ptr *rbio_stripe_block(const struct btrfs_raid_bio *rbio,
 					     unsigned int stripe_nr,
-					     unsigned int sector_nr)
+					     unsigned int block_nr)
 {
-	return &rbio->stripe_sectors[rbio_stripe_sector_index(rbio, stripe_nr,
-							      sector_nr)];
+	return &rbio->stripe_blocks[rbio_stripe_block_index(rbio, stripe_nr,
+							      block_nr)];
 }
 
-/* Grab a sector inside P stripe */
-static struct sector_ptr *rbio_pstripe_sector(const struct btrfs_raid_bio *rbio,
-					      unsigned int sector_nr)
+/* Grab a block inside P stripe */
+static struct block_ptr *rbio_pstripe_block(const struct btrfs_raid_bio *rbio,
+					      unsigned int block_nr)
 {
-	return rbio_stripe_sector(rbio, rbio->nr_data, sector_nr);
+	return rbio_stripe_block(rbio, rbio->nr_data, block_nr);
 }
 
-/* Grab a sector inside Q stripe, return NULL if not RAID6 */
-static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
-					      unsigned int sector_nr)
+/* Grab a block inside Q stripe, return NULL if not RAID6 */
+static struct block_ptr *rbio_qstripe_block(const struct btrfs_raid_bio *rbio,
+					      unsigned int block_nr)
 {
 	if (rbio->nr_data + 1 == rbio->real_stripes)
 		return NULL;
-	return rbio_stripe_sector(rbio, rbio->nr_data + 1, sector_nr);
+	return rbio_stripe_block(rbio, rbio->nr_data + 1, block_nr);
 }
 
 /*
@@ -914,7 +914,7 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	 * do this before before unlock_stripe() so there will be no new bio
 	 * for this bio.
 	 */
-	bitmap_clear(&rbio->dbitmap, 0, rbio->stripe_nsectors);
+	bitmap_clear(&rbio->dbitmap, 0, rbio->stripe_nblocks);
 
 	/*
 	 * At this moment, rbio->bio_list is empty, however since rbio does not
@@ -934,44 +934,44 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 }
 
 /*
- * Get a sector pointer specified by its @stripe_nr and @sector_nr.
+ * Get a block pointer specified by its @stripe_nr and @block_nr.
  *
  * @rbio:               The raid bio
  * @stripe_nr:          Stripe number, valid range [0, real_stripe)
- * @sector_nr:		Sector number inside the stripe,
- *			valid range [0, stripe_nsectors)
- * @bio_list_only:      Whether to use sectors inside the bio list only.
+ * @block_nr:		Sector number inside the stripe,
+ *			valid range [0, stripe_nblocks)
+ * @bio_list_only:      Whether to use blocks inside the bio list only.
  *
  * The read/modify/write code wants to reuse the original bio page as much
- * as possible, and only use stripe_sectors as fallback.
+ * as possible, and only use stripe_blocks as fallback.
  */
-static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
-					 int stripe_nr, int sector_nr,
+static struct block_ptr *block_in_rbio(struct btrfs_raid_bio *rbio,
+					 int stripe_nr, int block_nr,
 					 bool bio_list_only)
 {
-	struct sector_ptr *sector;
+	struct block_ptr *block;
 	int index;
 
 	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->real_stripes,
 			   rbio, stripe_nr);
-	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
-			   rbio, sector_nr);
+	ASSERT_RBIO_BLOCK(block_nr >= 0 && block_nr < rbio->stripe_nblocks,
+			  rbio, block_nr);
 
-	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
-	ASSERT(index >= 0 && index < rbio->nr_sectors);
+	index = stripe_nr * rbio->stripe_nblocks + block_nr;
+	ASSERT(index >= 0 && index < rbio->nr_blocks);
 
 	spin_lock(&rbio->bio_list_lock);
-	sector = &rbio->bio_sectors[index];
-	if (sector->page || bio_list_only) {
-		/* Don't return sector without a valid page pointer */
-		if (!sector->page)
-			sector = NULL;
+	block = &rbio->bio_blocks[index];
+	if (block->page || bio_list_only) {
+		/* Don't return block without a valid page pointer */
+		if (!block->page)
+			block = NULL;
 		spin_unlock(&rbio->bio_list_lock);
-		return sector;
+		return block;
 	}
 	spin_unlock(&rbio->bio_list_lock);
 
-	return &rbio->stripe_sectors[index];
+	return &rbio->stripe_blocks[index];
 }
 
 /*
@@ -984,18 +984,18 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	const unsigned int real_stripes = bioc->num_stripes - bioc->replace_nr_stripes;
 	const unsigned int stripe_npages = BTRFS_STRIPE_LEN >> PAGE_SHIFT;
 	const unsigned int num_pages = stripe_npages * real_stripes;
-	const unsigned int stripe_nsectors =
-		BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
-	const unsigned int num_sectors = stripe_nsectors * real_stripes;
+	const unsigned int stripe_nblocks =
+		BTRFS_STRIPE_LEN >> fs_info->blocksize_bits;
+	const unsigned int num_blocks = stripe_nblocks * real_stripes;
 	struct btrfs_raid_bio *rbio;
 
-	/* PAGE_SIZE must also be aligned to sectorsize for subpage support */
-	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
+	/* PAGE_SIZE must also be aligned to blocksize for subpage support */
+	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->blocksize));
 	/*
-	 * Our current stripe len should be fixed to 64k thus stripe_nsectors
+	 * Our current stripe len should be fixed to 64k thus stripe_nblocks
 	 * (at most 16) should be no larger than BITS_PER_LONG.
 	 */
-	ASSERT(stripe_nsectors <= BITS_PER_LONG);
+	ASSERT(stripe_nblocks <= BITS_PER_LONG);
 
 	/*
 	 * Real stripes must be between 2 (2 disks RAID5, aka RAID1) and 256
@@ -1009,14 +1009,14 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 	rbio->stripe_pages = kcalloc(num_pages, sizeof(struct page *),
 				     GFP_NOFS);
-	rbio->bio_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
+	rbio->bio_blocks = kcalloc(num_blocks, sizeof(struct block_ptr),
 				    GFP_NOFS);
-	rbio->stripe_sectors = kcalloc(num_sectors, sizeof(struct sector_ptr),
+	rbio->stripe_blocks = kcalloc(num_blocks, sizeof(struct block_ptr),
 				       GFP_NOFS);
 	rbio->finish_pointers = kcalloc(real_stripes, sizeof(void *), GFP_NOFS);
-	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
+	rbio->error_bitmap = bitmap_zalloc(num_blocks, GFP_NOFS);
 
-	if (!rbio->stripe_pages || !rbio->bio_sectors || !rbio->stripe_sectors ||
+	if (!rbio->stripe_pages || !rbio->bio_blocks || !rbio->stripe_blocks ||
 	    !rbio->finish_pointers || !rbio->error_bitmap) {
 		free_raid_bio_pointers(rbio);
 		kfree(rbio);
@@ -1032,10 +1032,10 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	btrfs_get_bioc(bioc);
 	rbio->bioc = bioc;
 	rbio->nr_pages = num_pages;
-	rbio->nr_sectors = num_sectors;
+	rbio->nr_blocks = num_blocks;
 	rbio->real_stripes = real_stripes;
 	rbio->stripe_npages = stripe_npages;
-	rbio->stripe_nsectors = stripe_nsectors;
+	rbio->stripe_nblocks = stripe_nblocks;
 	refcount_set(&rbio->refs, 1);
 	atomic_set(&rbio->stripes_pending, 0);
 
@@ -1054,8 +1054,8 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 	ret = btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages, false);
 	if (ret < 0)
 		return ret;
-	/* Mapping all sectors */
-	index_stripe_sectors(rbio);
+	/* Mapping all blocks */
+	index_stripe_blocks(rbio);
 	return 0;
 }
 
@@ -1070,17 +1070,17 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		return ret;
 
-	index_stripe_sectors(rbio);
+	index_stripe_blocks(rbio);
 	return 0;
 }
 
 /*
- * Return the total number of errors found in the vertical stripe of @sector_nr.
+ * Return the total number of errors found in the vertical stripe of @block_nr.
  *
  * @faila and @failb will also be updated to the first and second stripe
  * number of the errors.
  */
-static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
+static int get_rbio_vertical_errors(struct btrfs_raid_bio *rbio, int block_nr,
 				     int *faila, int *failb)
 {
 	int stripe_nr;
@@ -1097,9 +1097,9 @@ static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
 	}
 
 	for (stripe_nr = 0; stripe_nr < rbio->real_stripes; stripe_nr++) {
-		int total_sector_nr = stripe_nr * rbio->stripe_nsectors + sector_nr;
+		int total_block_nr = stripe_nr * rbio->stripe_nblocks + block_nr;
 
-		if (test_bit(total_sector_nr, rbio->error_bitmap)) {
+		if (test_bit(total_block_nr, rbio->error_bitmap)) {
 			found_errors++;
 			if (faila) {
 				/* Update faila and failb. */
@@ -1114,19 +1114,19 @@ static int get_rbio_veritical_errors(struct btrfs_raid_bio *rbio, int sector_nr,
 }
 
 /*
- * Add a single sector @sector into our list of bios for IO.
+ * Add a single block @block into our list of bios for IO.
  *
  * Return 0 if everything went well.
  * Return <0 for error.
  */
-static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
+static int rbio_add_io_block(struct btrfs_raid_bio *rbio,
 			      struct bio_list *bio_list,
-			      struct sector_ptr *sector,
+			      struct block_ptr *block,
 			      unsigned int stripe_nr,
-			      unsigned int sector_nr,
+			      unsigned int block_nr,
 			      enum req_op op)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
 	struct bio *last = bio_list->tail;
 	int ret;
 	struct bio *bio;
@@ -1140,22 +1140,22 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	 */
 	ASSERT_RBIO_STRIPE(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes,
 			   rbio, stripe_nr);
-	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
-			   rbio, sector_nr);
-	ASSERT(sector->page);
+	ASSERT_RBIO_BLOCK(block_nr >= 0 && block_nr < rbio->stripe_nblocks,
+			  rbio, block_nr);
+	ASSERT(block->page);
 
 	stripe = &rbio->bioc->stripes[stripe_nr];
-	disk_start = stripe->physical + sector_nr * sectorsize;
+	disk_start = stripe->physical + block_nr * blocksize;
 
 	/* if the device is missing, just fail this stripe */
 	if (!stripe->dev->bdev) {
 		int found_errors;
 
-		set_bit(stripe_nr * rbio->stripe_nsectors + sector_nr,
+		set_bit(stripe_nr * rbio->stripe_nblocks + block_nr,
 			rbio->error_bitmap);
 
 		/* Check if we have reached tolerance early. */
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+		found_errors = get_rbio_vertical_errors(rbio, block_nr,
 							 NULL, NULL);
 		if (found_errors > rbio->bioc->max_errors)
 			return -EIO;
@@ -1173,9 +1173,9 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 		 */
 		if (last_end == disk_start && !last->bi_status &&
 		    last->bi_bdev == stripe->dev->bdev) {
-			ret = bio_add_page(last, sector->page, sectorsize,
-					   sector->pgoff);
-			if (ret == sectorsize)
+			ret = bio_add_page(last, block->page, blocksize,
+					   block->pgoff);
+			if (ret == blocksize)
 				return 0;
 		}
 	}
@@ -1187,14 +1187,14 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 	bio->bi_private = rbio;
 
-	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
+	__bio_add_page(bio, block->page, blocksize, block->pgoff);
 	bio_list_add(bio_list, bio);
 	return 0;
 }
 
 static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
@@ -1204,13 +1204,13 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 		u32 bvec_offset;
 
 		for (bvec_offset = 0; bvec_offset < bvec.bv_len;
-		     bvec_offset += sectorsize, offset += sectorsize) {
-			int index = offset / sectorsize;
-			struct sector_ptr *sector = &rbio->bio_sectors[index];
+		     bvec_offset += blocksize, offset += blocksize) {
+			int index = offset / blocksize;
+			struct block_ptr *block = &rbio->bio_blocks[index];
 
-			sector->page = bvec.bv_page;
-			sector->pgoff = bvec.bv_offset + bvec_offset;
-			ASSERT(sector->pgoff < PAGE_SIZE);
+			block->page = bvec.bv_page;
+			block->pgoff = bvec.bv_offset + bvec_offset;
+			ASSERT(block->pgoff < PAGE_SIZE);
 		}
 	}
 }
@@ -1290,43 +1290,43 @@ static void assert_rbio(struct btrfs_raid_bio *rbio)
 }
 
 /* Generate PQ for one vertical stripe. */
-static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
+static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int blocknr)
 {
 	void **pointers = rbio->finish_pointers;
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	struct sector_ptr *sector;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
+	struct block_ptr *block;
 	int stripe;
 	const bool has_qstripe = rbio->bioc->map_type & BTRFS_BLOCK_GROUP_RAID6;
 
-	/* First collect one sector from each data stripe */
+	/* First collect one block from each data stripe */
 	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
-		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-		pointers[stripe] = kmap_local_page(sector->page) +
-				   sector->pgoff;
+		block = block_in_rbio(rbio, stripe, blocknr, 0);
+		pointers[stripe] = kmap_local_page(block->page) +
+				   block->pgoff;
 	}
 
 	/* Then add the parity stripe */
-	sector = rbio_pstripe_sector(rbio, sectornr);
-	sector->uptodate = 1;
-	pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
+	block = rbio_pstripe_block(rbio, blocknr);
+	block->uptodate = 1;
+	pointers[stripe++] = kmap_local_page(block->page) + block->pgoff;
 
 	if (has_qstripe) {
 		/*
 		 * RAID6, add the qstripe and call the library function
 		 * to fill in our p/q
 		 */
-		sector = rbio_qstripe_sector(rbio, sectornr);
-		sector->uptodate = 1;
-		pointers[stripe++] = kmap_local_page(sector->page) +
-				     sector->pgoff;
+		block = rbio_qstripe_block(rbio, blocknr);
+		block->uptodate = 1;
+		pointers[stripe++] = kmap_local_page(block->page) +
+				     block->pgoff;
 
 		assert_rbio(rbio);
-		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
+		raid6_call.gen_syndrome(rbio->real_stripes, blocksize,
 					pointers);
 	} else {
 		/* raid5 */
-		memcpy(pointers[rbio->nr_data], pointers[0], sectorsize);
-		run_xor(pointers + 1, rbio->nr_data - 1, sectorsize);
+		memcpy(pointers[rbio->nr_data], pointers[0], blocksize);
+		run_xor(pointers + 1, rbio->nr_data - 1, blocksize);
 	}
 	for (stripe = stripe - 1; stripe >= 0; stripe--)
 		kunmap_local(pointers[stripe]);
@@ -1335,48 +1335,48 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 				   struct bio_list *bio_list)
 {
-	/* The total sector number inside the full stripe. */
-	int total_sector_nr;
-	int sectornr;
+	/* The total block number inside the full stripe. */
+	int total_block_nr;
+	int blocknr;
 	int stripe;
 	int ret;
 
 	ASSERT(bio_list_size(bio_list) == 0);
 
-	/* We should have at least one data sector. */
-	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
+	/* We should have at least one data block. */
+	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nblocks));
 
 	/*
 	 * Reset errors, as we may have errors inherited from from degraded
 	 * write.
 	 */
-	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_blocks);
 
 	/*
 	 * Start assembly.  Make bios for everything from the higher layers (the
 	 * bio_list in our rbio) and our P/Q.  Ignore everything else.
 	 */
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
+	for (total_block_nr = 0; total_block_nr < rbio->nr_blocks;
+	     total_block_nr++) {
+		struct block_ptr *block;
 
-		stripe = total_sector_nr / rbio->stripe_nsectors;
-		sectornr = total_sector_nr % rbio->stripe_nsectors;
+		stripe = total_block_nr / rbio->stripe_nblocks;
+		blocknr = total_block_nr % rbio->stripe_nblocks;
 
 		/* This vertical stripe has no data, skip it. */
-		if (!test_bit(sectornr, &rbio->dbitmap))
+		if (!test_bit(blocknr, &rbio->dbitmap))
 			continue;
 
 		if (stripe < rbio->nr_data) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (!sector)
+			block = block_in_rbio(rbio, stripe, blocknr, 1);
+			if (!block)
 				continue;
 		} else {
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+			block = rbio_stripe_block(rbio, stripe, blocknr);
 		}
 
-		ret = rbio_add_io_sector(rbio, bio_list, sector, stripe,
-					 sectornr, REQ_OP_WRITE);
+		ret = rbio_add_io_block(rbio, bio_list, block, stripe,
+					 blocknr, REQ_OP_WRITE);
 		if (ret)
 			goto error;
 	}
@@ -1391,12 +1391,12 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	 */
 	ASSERT(rbio->bioc->replace_stripe_src >= 0);
 
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
+	for (total_block_nr = 0; total_block_nr < rbio->nr_blocks;
+	     total_block_nr++) {
+		struct block_ptr *block;
 
-		stripe = total_sector_nr / rbio->stripe_nsectors;
-		sectornr = total_sector_nr % rbio->stripe_nsectors;
+		stripe = total_block_nr / rbio->stripe_nblocks;
+		blocknr = total_block_nr % rbio->stripe_nblocks;
 
 		/*
 		 * For RAID56, there is only one device that can be replaced,
@@ -1406,28 +1406,28 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 		if (stripe != rbio->bioc->replace_stripe_src) {
 			/*
 			 * We can skip the whole stripe completely, note
-			 * total_sector_nr will be increased by one anyway.
+			 * total_block_nr will be increased by one anyway.
 			 */
-			ASSERT(sectornr == 0);
-			total_sector_nr += rbio->stripe_nsectors - 1;
+			ASSERT(blocknr == 0);
+			total_block_nr += rbio->stripe_nblocks - 1;
 			continue;
 		}
 
 		/* This vertical stripe has no data, skip it. */
-		if (!test_bit(sectornr, &rbio->dbitmap))
+		if (!test_bit(blocknr, &rbio->dbitmap))
 			continue;
 
 		if (stripe < rbio->nr_data) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-			if (!sector)
+			block = block_in_rbio(rbio, stripe, blocknr, 1);
+			if (!block)
 				continue;
 		} else {
-			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+			block = rbio_stripe_block(rbio, stripe, blocknr);
 		}
 
-		ret = rbio_add_io_sector(rbio, bio_list, sector,
+		ret = rbio_add_io_block(rbio, bio_list, block,
 					 rbio->real_stripes,
-					 sectornr, REQ_OP_WRITE);
+					 blocknr, REQ_OP_WRITE);
 		if (ret)
 			goto error;
 	}
@@ -1443,12 +1443,12 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
 		     rbio->bioc->full_stripe_logical;
-	int total_nr_sector = offset >> fs_info->sectorsize_bits;
+	int total_nr_block = offset >> fs_info->blocksize_bits;
 
-	ASSERT(total_nr_sector < rbio->nr_data * rbio->stripe_nsectors);
+	ASSERT(total_nr_block < rbio->nr_data * rbio->stripe_nblocks);
 
-	bitmap_set(rbio->error_bitmap, total_nr_sector,
-		   bio->bi_iter.bi_size >> fs_info->sectorsize_bits);
+	bitmap_set(rbio->error_bitmap, total_nr_block,
+		   bio->bi_iter.bi_size >> fs_info->blocksize_bits);
 
 	/*
 	 * Special handling for raid56_alloc_missing_rbio() used by
@@ -1464,8 +1464,8 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 			if (!rbio->bioc->stripes[stripe_nr].dev->bdev) {
 				found_missing = true;
 				bitmap_set(rbio->error_bitmap,
-					   stripe_nr * rbio->stripe_nsectors,
-					   rbio->stripe_nsectors);
+					   stripe_nr * rbio->stripe_nblocks,
+					   rbio->stripe_nblocks);
 			}
 		}
 		ASSERT(found_missing);
@@ -1474,19 +1474,19 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
 
 /*
  * For subpage case, we can no longer set page Up-to-date directly for
- * stripe_pages[], thus we need to locate the sector.
+ * stripe_pages[], thus we need to locate the block.
  */
-static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
+static struct block_ptr *find_stripe_block(struct btrfs_raid_bio *rbio,
 					     struct page *page,
 					     unsigned int pgoff)
 {
 	int i;
 
-	for (i = 0; i < rbio->nr_sectors; i++) {
-		struct sector_ptr *sector = &rbio->stripe_sectors[i];
+	for (i = 0; i < rbio->nr_blocks; i++) {
+		struct block_ptr *block = &rbio->stripe_blocks[i];
 
-		if (sector->page == page && sector->pgoff == pgoff)
-			return sector;
+		if (block->page == page && block->pgoff == pgoff)
+			return block;
 	}
 	return NULL;
 }
@@ -1497,48 +1497,48 @@ static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
  */
 static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct sector_ptr *sector;
+		struct block_ptr *block;
 		int pgoff;
 
 		for (pgoff = bvec->bv_offset; pgoff - bvec->bv_offset < bvec->bv_len;
-		     pgoff += sectorsize) {
-			sector = find_stripe_sector(rbio, bvec->bv_page, pgoff);
-			ASSERT(sector);
-			if (sector)
-				sector->uptodate = 1;
+		     pgoff += blocksize) {
+			block = find_stripe_block(rbio, bvec->bv_page, pgoff);
+			ASSERT(block);
+			if (block)
+				block->uptodate = 1;
 		}
 	}
 }
 
-static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
+static int get_bio_block_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	struct bio_vec *bv = bio_first_bvec_all(bio);
 	int i;
 
-	for (i = 0; i < rbio->nr_sectors; i++) {
-		struct sector_ptr *sector;
+	for (i = 0; i < rbio->nr_blocks; i++) {
+		struct block_ptr *block;
 
-		sector = &rbio->stripe_sectors[i];
-		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
+		block = &rbio->stripe_blocks[i];
+		if (block->page == bv->bv_page && block->pgoff == bv->bv_offset)
 			break;
-		sector = &rbio->bio_sectors[i];
-		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
+		block = &rbio->bio_blocks[i];
+		if (block->page == bv->bv_page && block->pgoff == bv->bv_offset)
 			break;
 	}
-	ASSERT(i < rbio->nr_sectors);
+	ASSERT(i < rbio->nr_blocks);
 	return i;
 }
 
 static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
-	int total_sector_nr = get_bio_sector_nr(rbio, bio);
+	int total_block_nr = get_bio_block_nr(rbio, bio);
 	u32 bio_size = 0;
 	struct bio_vec *bvec;
 	int i;
@@ -1552,17 +1552,17 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 	 *
 	 * Instead use set_bit() for each bit, as set_bit() itself is atomic.
 	 */
-	for (i = total_sector_nr; i < total_sector_nr +
-	     (bio_size >> rbio->bioc->fs_info->sectorsize_bits); i++)
+	for (i = total_block_nr; i < total_block_nr +
+	     (bio_size >> rbio->bioc->fs_info->blocksize_bits); i++)
 		set_bit(i, rbio->error_bitmap);
 }
 
-/* Verify the data sectors at read time. */
-static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
+/* Verify the data blocks at read time. */
+static void verify_bio_data_blocks(struct btrfs_raid_bio *rbio,
 				    struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	int total_sector_nr = get_bio_sector_nr(rbio, bio);
+	int total_block_nr = get_bio_block_nr(rbio, bio);
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
@@ -1571,7 +1571,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 		return;
 
 	/* P/Q stripes, they have no data csum to verify against. */
-	if (total_sector_nr >= rbio->nr_data * rbio->stripe_nsectors)
+	if (total_block_nr >= rbio->nr_data * rbio->stripe_nblocks)
 		return;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -1579,20 +1579,20 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 
 		for (bv_offset = bvec->bv_offset;
 		     bv_offset < bvec->bv_offset + bvec->bv_len;
-		     bv_offset += fs_info->sectorsize, total_sector_nr++) {
+		     bv_offset += fs_info->blocksize, total_block_nr++) {
 			u8 csum_buf[BTRFS_CSUM_SIZE];
 			u8 *expected_csum = rbio->csum_buf +
-					    total_sector_nr * fs_info->csum_size;
+					    total_block_nr * fs_info->csum_size;
 			int ret;
 
-			/* No csum for this sector, skip to the next sector. */
-			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
+			/* No csum for this block, skip to the next block. */
+			if (!test_bit(total_block_nr, rbio->csum_bitmap))
 				continue;
 
 			ret = btrfs_check_block_csum(fs_info, bvec->bv_page,
 				bv_offset, csum_buf, expected_csum);
 			if (ret < 0)
-				set_bit(total_sector_nr, rbio->error_bitmap);
+				set_bit(total_block_nr, rbio->error_bitmap);
 		}
 	}
 }
@@ -1605,7 +1605,7 @@ static void raid_wait_read_end_io(struct bio *bio)
 		rbio_update_error_bitmap(rbio, bio);
 	} else {
 		set_bio_pages_uptodate(rbio, bio);
-		verify_bio_data_sectors(rbio, bio);
+		verify_bio_data_blocks(rbio, bio);
 	}
 
 	bio_put(bio);
@@ -1643,7 +1643,7 @@ static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		return ret;
 
-	index_stripe_sectors(rbio);
+	index_stripe_blocks(rbio);
 	return 0;
 }
 
@@ -1720,7 +1720,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 	const u64 orig_logical = orig_bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	const u64 full_stripe_start = rbio->bioc->full_stripe_logical;
 	const u32 orig_len = orig_bio->bi_iter.bi_size;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	u64 cur_logical;
 
 	ASSERT_RBIO_LOGICAL(orig_logical >= full_stripe_start &&
@@ -1733,9 +1733,9 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 
 	/* Update the dbitmap. */
 	for (cur_logical = orig_logical; cur_logical < orig_logical + orig_len;
-	     cur_logical += sectorsize) {
+	     cur_logical += blocksize) {
 		int bit = ((u32)(cur_logical - full_stripe_start) >>
-			   fs_info->sectorsize_bits) % rbio->stripe_nsectors;
+			   fs_info->blocksize_bits) % rbio->stripe_nblocks;
 
 		set_bit(bit, &rbio->dbitmap);
 	}
@@ -1784,11 +1784,11 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	start_async_work(rbio, rmw_rbio_work);
 }
 
-static int verify_one_sector(struct btrfs_raid_bio *rbio,
-			     int stripe_nr, int sector_nr)
+static int verify_one_block(struct btrfs_raid_bio *rbio,
+			     int stripe_nr, int block_nr)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	struct sector_ptr *sector;
+	struct block_ptr *block;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
 	int ret;
@@ -1804,32 +1804,32 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	 * bio list if possible.
 	 */
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-		sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
+		block = block_in_rbio(rbio, stripe_nr, block_nr, 0);
 	} else {
-		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
+		block = rbio_stripe_block(rbio, stripe_nr, block_nr);
 	}
 
-	ASSERT(sector->page);
+	ASSERT(block->page);
 
 	csum_expected = rbio->csum_buf +
-			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
+			(stripe_nr * rbio->stripe_nblocks + block_nr) *
 			fs_info->csum_size;
-	ret = btrfs_check_block_csum(fs_info, sector->page, sector->pgoff,
+	ret = btrfs_check_block_csum(fs_info, block->page, block->pgoff,
 				     csum_buf, csum_expected);
 	return ret;
 }
 
 /*
- * Recover a vertical stripe specified by @sector_nr.
+ * Recover a vertical stripe specified by @block_nr.
  * @*pointers are the pre-allocated pointers by the caller, so we don't
  * need to allocate/free the pointers again and again.
  */
-static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
+static int recover_vertical(struct btrfs_raid_bio *rbio, int block_nr,
 			    void **pointers, void **unmap_array)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	struct sector_ptr *sector;
-	const u32 sectorsize = fs_info->sectorsize;
+	struct block_ptr *block;
+	const u32 blocksize = fs_info->blocksize;
 	int found_errors;
 	int faila;
 	int failb;
@@ -1841,10 +1841,10 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	 * which we have data when doing parity scrub.
 	 */
 	if (rbio->operation == BTRFS_RBIO_PARITY_SCRUB &&
-	    !test_bit(sector_nr, &rbio->dbitmap))
+	    !test_bit(block_nr, &rbio->dbitmap))
 		return 0;
 
-	found_errors = get_rbio_veritical_errors(rbio, sector_nr, &faila,
+	found_errors = get_rbio_vertical_errors(rbio, block_nr, &faila,
 						 &failb);
 	/*
 	 * No errors in the vertical stripe, skip it.  Can happen for recovery
@@ -1857,7 +1857,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		return -EIO;
 
 	/*
-	 * Setup our array of pointers with sectors from each stripe
+	 * Setup our array of pointers with blocks from each stripe
 	 *
 	 * NOTE: store a duplicate array of pointers to preserve the
 	 * pointer order.
@@ -1868,13 +1868,13 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		 * bio list if possible.
 		 */
 		if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
-			sector = sector_in_rbio(rbio, stripe_nr, sector_nr, 0);
+			block = block_in_rbio(rbio, stripe_nr, block_nr, 0);
 		} else {
-			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
+			block = rbio_stripe_block(rbio, stripe_nr, block_nr);
 		}
-		ASSERT(sector->page);
-		pointers[stripe_nr] = kmap_local_page(sector->page) +
-				   sector->pgoff;
+		ASSERT(block->page);
+		pointers[stripe_nr] = kmap_local_page(block->page) +
+				   block->pgoff;
 		unmap_array[stripe_nr] = pointers[stripe_nr];
 	}
 
@@ -1920,10 +1920,10 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		}
 
 		if (failb == rbio->real_stripes - 2) {
-			raid6_datap_recov(rbio->real_stripes, sectorsize,
+			raid6_datap_recov(rbio->real_stripes, blocksize,
 					  faila, pointers);
 		} else {
-			raid6_2data_recov(rbio->real_stripes, sectorsize,
+			raid6_2data_recov(rbio->real_stripes, blocksize,
 					  faila, failb, pointers);
 		}
 	} else {
@@ -1933,7 +1933,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		ASSERT(failb == -1);
 pstripe:
 		/* Copy parity block into failed block to start with */
-		memcpy(pointers[faila], pointers[rbio->nr_data], sectorsize);
+		memcpy(pointers[faila], pointers[rbio->nr_data], blocksize);
 
 		/* Rearrange the pointer array */
 		p = pointers[faila];
@@ -1943,35 +1943,35 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 		pointers[rbio->nr_data - 1] = p;
 
 		/* Xor in the rest */
-		run_xor(pointers, rbio->nr_data - 1, sectorsize);
+		run_xor(pointers, rbio->nr_data - 1, blocksize);
 
 	}
 
 	/*
 	 * No matter if this is a RMW or recovery, we should have all
-	 * failed sectors repaired in the vertical stripe, thus they are now
+	 * failed blocks repaired in the vertical stripe, thus they are now
 	 * uptodate.
 	 * Especially if we determine to cache the rbio, we need to
-	 * have at least all data sectors uptodate.
+	 * have at least all data blocks uptodate.
 	 *
-	 * If possible, also check if the repaired sector matches its data
+	 * If possible, also check if the repaired block matches its data
 	 * checksum.
 	 */
 	if (faila >= 0) {
-		ret = verify_one_sector(rbio, faila, sector_nr);
+		ret = verify_one_block(rbio, faila, block_nr);
 		if (ret < 0)
 			goto cleanup;
 
-		sector = rbio_stripe_sector(rbio, faila, sector_nr);
-		sector->uptodate = 1;
+		block = rbio_stripe_block(rbio, faila, block_nr);
+		block->uptodate = 1;
 	}
 	if (failb >= 0) {
-		ret = verify_one_sector(rbio, failb, sector_nr);
+		ret = verify_one_block(rbio, failb, block_nr);
 		if (ret < 0)
 			goto cleanup;
 
-		sector = rbio_stripe_sector(rbio, failb, sector_nr);
-		sector->uptodate = 1;
+		block = rbio_stripe_block(rbio, failb, block_nr);
+		block->uptodate = 1;
 	}
 
 cleanup:
@@ -1980,15 +1980,15 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 	return ret;
 }
 
-static int recover_sectors(struct btrfs_raid_bio *rbio)
+static int recover_blocks(struct btrfs_raid_bio *rbio)
 {
 	void **pointers = NULL;
 	void **unmap_array = NULL;
-	int sectornr;
+	int blocknr;
 	int ret = 0;
 
 	/*
-	 * @pointers array stores the pointer for each sector.
+	 * @pointers array stores the pointer for each block.
 	 *
 	 * @unmap_array stores copy of pointers that does not get reordered
 	 * during reconstruction so that kunmap_local works.
@@ -2008,8 +2008,8 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 
 	index_rbio_pages(rbio);
 
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
-		ret = recover_vertical(rbio, sectornr, pointers, unmap_array);
+	for (blocknr = 0; blocknr < rbio->stripe_nblocks; blocknr++) {
+		ret = recover_vertical(rbio, blocknr, pointers, unmap_array);
 		if (ret < 0)
 			break;
 	}
@@ -2023,16 +2023,16 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 static void recover_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list = BIO_EMPTY_LIST;
-	int total_sector_nr;
+	int total_block_nr;
 	int ret = 0;
 
 	/*
 	 * Either we're doing recover for a read failure or degraded write,
 	 * caller should have set error bitmap correctly.
 	 */
-	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
+	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_blocks));
 
-	/* For recovery, we need to read all sectors including P/Q. */
+	/* For recovery, we need to read all blocks including P/Q. */
 	ret = alloc_rbio_pages(rbio);
 	if (ret < 0)
 		goto out;
@@ -2041,17 +2041,17 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 
 	/*
 	 * Read everything that hasn't failed. However this time we will
-	 * not trust any cached sector.
+	 * not trust any cached block.
 	 * As we may read out some stale data but higher layer is not reading
 	 * that stale part.
 	 *
 	 * So here we always re-read everything in recovery path.
 	 */
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		struct sector_ptr *sector;
+	for (total_block_nr = 0; total_block_nr < rbio->nr_blocks;
+	     total_block_nr++) {
+		int stripe = total_block_nr / rbio->stripe_nblocks;
+		int blocknr = total_block_nr % rbio->stripe_nblocks;
+		struct block_ptr *block;
 
 		/*
 		 * Skip the range which has error.  It can be a range which is
@@ -2059,18 +2059,18 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 		 * device.
 		 */
 		if (!rbio->bioc->stripes[stripe].dev->bdev ||
-		    test_bit(total_sector_nr, rbio->error_bitmap)) {
+		    test_bit(total_block_nr, rbio->error_bitmap)) {
 			/*
 			 * Also set the error bit for missing device, which
 			 * may not yet have its error bit set.
 			 */
-			set_bit(total_sector_nr, rbio->error_bitmap);
+			set_bit(total_block_nr, rbio->error_bitmap);
 			continue;
 		}
 
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-					 sectornr, REQ_OP_READ);
+		block = rbio_stripe_block(rbio, stripe, blocknr);
+		ret = rbio_add_io_block(rbio, &bio_list, block, stripe,
+					 blocknr, REQ_OP_READ);
 		if (ret < 0) {
 			bio_list_put(&bio_list);
 			goto out;
@@ -2078,7 +2078,7 @@ static void recover_rbio(struct btrfs_raid_bio *rbio)
 	}
 
 	submit_read_wait_bio_list(rbio, &bio_list);
-	ret = recover_sectors(rbio);
+	ret = recover_blocks(rbio);
 out:
 	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
@@ -2100,7 +2100,7 @@ static void recover_rbio_work_locked(struct work_struct *work)
 static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_num)
 {
 	bool found = false;
-	int sector_nr;
+	int block_nr;
 
 	/*
 	 * This is for RAID6 extra recovery tries, thus mirror number should
@@ -2109,12 +2109,12 @@ static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_n
 	 * RAID5 methods.
 	 */
 	ASSERT(mirror_num > 2);
-	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+	for (block_nr = 0; block_nr < rbio->stripe_nblocks; block_nr++) {
 		int found_errors;
 		int faila;
 		int failb;
 
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+		found_errors = get_rbio_vertical_errors(rbio, block_nr,
 							 &faila, &failb);
 		/* This vertical stripe doesn't have errors. */
 		if (!found_errors)
@@ -2134,7 +2134,7 @@ static void set_rbio_raid6_extra_error(struct btrfs_raid_bio *rbio, int mirror_n
 
 		/* Set the extra bit in error bitmap. */
 		if (failb >= 0)
-			set_bit(failb * rbio->stripe_nsectors + sector_nr,
+			set_bit(failb * rbio->stripe_nblocks + block_nr,
 				rbio->error_bitmap);
 	}
 
@@ -2183,8 +2183,8 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
 						       rbio->bioc->full_stripe_logical);
 	const u64 start = rbio->bioc->full_stripe_logical;
-	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
-			fs_info->sectorsize_bits;
+	const u32 len = (rbio->nr_data * rbio->stripe_nblocks) <<
+			fs_info->blocksize_bits;
 	int ret;
 
 	/* The rbio should not have its csum buffer initialized. */
@@ -2205,9 +2205,9 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 	    rbio->bioc->map_type & BTRFS_BLOCK_GROUP_METADATA)
 		return;
 
-	rbio->csum_buf = kzalloc(rbio->nr_data * rbio->stripe_nsectors *
+	rbio->csum_buf = kzalloc(rbio->nr_data * rbio->stripe_nblocks *
 				 fs_info->csum_size, GFP_NOFS);
-	rbio->csum_bitmap = bitmap_zalloc(rbio->nr_data * rbio->stripe_nsectors,
+	rbio->csum_bitmap = bitmap_zalloc(rbio->nr_data * rbio->stripe_nblocks,
 					  GFP_NOFS);
 	if (!rbio->csum_buf || !rbio->csum_bitmap) {
 		ret = -ENOMEM;
@@ -2218,7 +2218,7 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 					rbio->csum_buf, rbio->csum_bitmap);
 	if (ret < 0)
 		goto error;
-	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->sectorsize_bits))
+	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->blocksize_bits))
 		goto no_csum;
 	return;
 
@@ -2241,30 +2241,30 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list = BIO_EMPTY_LIST;
-	int total_sector_nr;
+	int total_block_nr;
 	int ret = 0;
 
 	/*
 	 * Fill the data csums we need for data verification.  We need to fill
 	 * the csum_bitmap/csum_buf first, as our endio function will try to
-	 * verify the data sectors.
+	 * verify the data blocks.
 	 */
 	fill_data_csums(rbio);
 
 	/*
-	 * Build a list of bios to read all sectors (including data and P/Q).
+	 * Build a list of bios to read all blocks (including data and P/Q).
 	 *
 	 * This behavior is to compensate the later csum verification and recovery.
 	 */
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
-		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+	for (total_block_nr = 0; total_block_nr < rbio->nr_blocks;
+	     total_block_nr++) {
+		struct block_ptr *block;
+		int stripe = total_block_nr / rbio->stripe_nblocks;
+		int blocknr = total_block_nr % rbio->stripe_nblocks;
 
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
-			       stripe, sectornr, REQ_OP_READ);
+		block = rbio_stripe_block(rbio, stripe, blocknr);
+		ret = rbio_add_io_block(rbio, &bio_list, block,
+			       stripe, blocknr, REQ_OP_READ);
 		if (ret) {
 			bio_list_put(&bio_list);
 			return ret;
@@ -2272,11 +2272,11 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
 	}
 
 	/*
-	 * We may or may not have any corrupted sectors (including missing dev
-	 * and csum mismatch), just let recover_sectors() to handle them all.
+	 * We may or may not have any corrupted blocks (including missing dev
+	 * and csum mismatch), just let recover_blocks() to handle them all.
 	 */
 	submit_read_wait_bio_list(rbio, &bio_list);
-	return recover_sectors(rbio);
+	return recover_blocks(rbio);
 }
 
 static void raid_wait_write_end_io(struct bio *bio)
@@ -2311,22 +2311,22 @@ static void submit_write_bios(struct btrfs_raid_bio *rbio,
 }
 
 /*
- * To determine if we need to read any sector from the disk.
+ * To determine if we need to read any block from the disk.
  * Should only be utilized in RMW path, to skip cached rbio.
  */
-static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
+static bool need_read_stripe_blocks(struct btrfs_raid_bio *rbio)
 {
 	int i;
 
-	for (i = 0; i < rbio->nr_data * rbio->stripe_nsectors; i++) {
-		struct sector_ptr *sector = &rbio->stripe_sectors[i];
+	for (i = 0; i < rbio->nr_data * rbio->stripe_nblocks; i++) {
+		struct block_ptr *block = &rbio->stripe_blocks[i];
 
 		/*
-		 * We have a sector which doesn't have page nor uptodate,
+		 * We have a block which doesn't have page nor uptodate,
 		 * thus this rbio can not be cached one, as cached one must
-		 * have all its data sectors present and uptodate.
+		 * have all its data blocks present and uptodate.
 		 */
-		if (!sector->page || !sector->uptodate)
+		if (!block->page || !block->uptodate)
 			return true;
 	}
 	return false;
@@ -2335,7 +2335,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
 static void rmw_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
-	int sectornr;
+	int blocknr;
 	int ret = 0;
 
 	/*
@@ -2347,10 +2347,10 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 		goto out;
 
 	/*
-	 * Either full stripe write, or we have every data sector already
+	 * Either full stripe write, or we have every data block already
 	 * cached, can go to write path immediately.
 	 */
-	if (!rbio_is_full(rbio) && need_read_stripe_sectors(rbio)) {
+	if (!rbio_is_full(rbio) && need_read_stripe_blocks(rbio)) {
 		/*
 		 * Now we're doing sub-stripe write, also need all data stripes
 		 * to do the full RMW.
@@ -2375,7 +2375,7 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
 	spin_unlock(&rbio->bio_list_lock);
 
-	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_blocks);
 
 	index_rbio_pages(rbio);
 
@@ -2390,8 +2390,8 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 	else
 		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
-		generate_pq_vertical(rbio, sectornr);
+	for (blocknr = 0; blocknr < rbio->stripe_nblocks; blocknr++)
+		generate_pq_vertical(rbio, blocknr);
 
 	bio_list_init(&bio_list);
 	ret = rmw_assemble_write_bios(rbio, &bio_list);
@@ -2404,10 +2404,10 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
 	/* We may have more errors than our tolerance during the read. */
-	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
+	for (blocknr = 0; blocknr < rbio->stripe_nblocks; blocknr++) {
 		int found_errors;
 
-		found_errors = get_rbio_veritical_errors(rbio, sectornr, NULL, NULL);
+		found_errors = get_rbio_vertical_errors(rbio, blocknr, NULL, NULL);
 		if (found_errors > rbio->bioc->max_errors) {
 			ret = -EIO;
 			break;
@@ -2444,7 +2444,7 @@ static void rmw_rbio_work_locked(struct work_struct *work)
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
-				unsigned long *dbitmap, int stripe_nsectors)
+				unsigned long *dbitmap, int stripe_nblocks)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -2474,7 +2474,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	}
 	ASSERT_RBIO_STRIPE(i < rbio->real_stripes, rbio, i);
 
-	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
+	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nblocks);
 	return rbio;
 }
 
@@ -2484,16 +2484,16 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
  */
 static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 {
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	int total_sector_nr;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
+	int total_block_nr;
 
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
+	for (total_block_nr = 0; total_block_nr < rbio->nr_blocks;
+	     total_block_nr++) {
 		struct page *page;
-		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		int index = (total_sector_nr * sectorsize) >> PAGE_SHIFT;
+		int blocknr = total_block_nr % rbio->stripe_nblocks;
+		int index = (total_block_nr * blocksize) >> PAGE_SHIFT;
 
-		if (!test_bit(sectornr, &rbio->dbitmap))
+		if (!test_bit(blocknr, &rbio->dbitmap))
 			continue;
 		if (rbio->stripe_pages[index])
 			continue;
@@ -2502,22 +2502,22 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 			return -ENOMEM;
 		rbio->stripe_pages[index] = page;
 	}
-	index_stripe_sectors(rbio);
+	index_stripe_blocks(rbio);
 	return 0;
 }
 
 static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_io_context *bioc = rbio->bioc;
-	const u32 sectorsize = bioc->fs_info->sectorsize;
+	const u32 blocksize = bioc->fs_info->blocksize;
 	void **pointers = rbio->finish_pointers;
 	unsigned long *pbitmap = &rbio->finish_pbitmap;
 	int nr_data = rbio->nr_data;
 	int stripe;
-	int sectornr;
+	int blocknr;
 	bool has_qstripe;
-	struct sector_ptr p_sector = { 0 };
-	struct sector_ptr q_sector = { 0 };
+	struct block_ptr p_block = { 0 };
+	struct block_ptr q_block = { 0 };
 	struct bio_list bio_list;
 	int is_replace = 0;
 	int ret;
@@ -2537,7 +2537,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 */
 	if (bioc->replace_nr_stripes && bioc->replace_stripe_src == rbio->scrubp) {
 		is_replace = 1;
-		bitmap_copy(pbitmap, &rbio->dbitmap, rbio->stripe_nsectors);
+		bitmap_copy(pbitmap, &rbio->dbitmap, rbio->stripe_nblocks);
 	}
 
 	/*
@@ -2547,60 +2547,60 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 */
 	clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
 
-	p_sector.page = alloc_page(GFP_NOFS);
-	if (!p_sector.page)
+	p_block.page = alloc_page(GFP_NOFS);
+	if (!p_block.page)
 		return -ENOMEM;
-	p_sector.pgoff = 0;
-	p_sector.uptodate = 1;
+	p_block.pgoff = 0;
+	p_block.uptodate = 1;
 
 	if (has_qstripe) {
 		/* RAID6, allocate and map temp space for the Q stripe */
-		q_sector.page = alloc_page(GFP_NOFS);
-		if (!q_sector.page) {
-			__free_page(p_sector.page);
-			p_sector.page = NULL;
+		q_block.page = alloc_page(GFP_NOFS);
+		if (!q_block.page) {
+			__free_page(p_block.page);
+			p_block.page = NULL;
 			return -ENOMEM;
 		}
-		q_sector.pgoff = 0;
-		q_sector.uptodate = 1;
-		pointers[rbio->real_stripes - 1] = kmap_local_page(q_sector.page);
+		q_block.pgoff = 0;
+		q_block.uptodate = 1;
+		pointers[rbio->real_stripes - 1] = kmap_local_page(q_block.page);
 	}
 
-	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_blocks);
 
 	/* Map the parity stripe just once */
-	pointers[nr_data] = kmap_local_page(p_sector.page);
+	pointers[nr_data] = kmap_local_page(p_block.page);
 
-	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		struct sector_ptr *sector;
+	for_each_set_bit(blocknr, &rbio->dbitmap, rbio->stripe_nblocks) {
+		struct block_ptr *block;
 		void *parity;
 
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
-			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
-			pointers[stripe] = kmap_local_page(sector->page) +
-					   sector->pgoff;
+			block = block_in_rbio(rbio, stripe, blocknr, 0);
+			pointers[stripe] = kmap_local_page(block->page) +
+					   block->pgoff;
 		}
 
 		if (has_qstripe) {
 			assert_rbio(rbio);
 			/* RAID6, call the library function to fill in our P/Q */
-			raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
+			raid6_call.gen_syndrome(rbio->real_stripes, blocksize,
 						pointers);
 		} else {
 			/* raid5 */
-			memcpy(pointers[nr_data], pointers[0], sectorsize);
-			run_xor(pointers + 1, nr_data - 1, sectorsize);
+			memcpy(pointers[nr_data], pointers[0], blocksize);
+			run_xor(pointers + 1, nr_data - 1, blocksize);
 		}
 
 		/* Check scrubbing parity and repair it */
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		parity = kmap_local_page(sector->page) + sector->pgoff;
-		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
-			memcpy(parity, pointers[rbio->scrubp], sectorsize);
+		block = rbio_stripe_block(rbio, rbio->scrubp, blocknr);
+		parity = kmap_local_page(block->page) + block->pgoff;
+		if (memcmp(parity, pointers[rbio->scrubp], blocksize) != 0)
+			memcpy(parity, pointers[rbio->scrubp], blocksize);
 		else
 			/* Parity is right, needn't writeback */
-			bitmap_clear(&rbio->dbitmap, sectornr, 1);
+			bitmap_clear(&rbio->dbitmap, blocknr, 1);
 		kunmap_local(parity);
 
 		for (stripe = nr_data - 1; stripe >= 0; stripe--)
@@ -2608,12 +2608,12 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	}
 
 	kunmap_local(pointers[nr_data]);
-	__free_page(p_sector.page);
-	p_sector.page = NULL;
-	if (q_sector.page) {
+	__free_page(p_block.page);
+	p_block.page = NULL;
+	if (q_block.page) {
 		kunmap_local(pointers[rbio->real_stripes - 1]);
-		__free_page(q_sector.page);
-		q_sector.page = NULL;
+		__free_page(q_block.page);
+		q_block.page = NULL;
 	}
 
 	/*
@@ -2621,12 +2621,12 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
 	 * everything else.
 	 */
-	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
-		struct sector_ptr *sector;
+	for_each_set_bit(blocknr, &rbio->dbitmap, rbio->stripe_nblocks) {
+		struct block_ptr *block;
 
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
-					 sectornr, REQ_OP_WRITE);
+		block = rbio_stripe_block(rbio, rbio->scrubp, blocknr);
+		ret = rbio_add_io_block(rbio, &bio_list, block, rbio->scrubp,
+					 blocknr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2639,13 +2639,13 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 	 * the target device.  Check we have a valid source stripe number.
 	 */
 	ASSERT_RBIO(rbio->bioc->replace_stripe_src >= 0, rbio);
-	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
-		struct sector_ptr *sector;
+	for_each_set_bit(blocknr, pbitmap, rbio->stripe_nblocks) {
+		struct block_ptr *block;
 
-		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+		block = rbio_stripe_block(rbio, rbio->scrubp, blocknr);
+		ret = rbio_add_io_block(rbio, &bio_list, block,
 					 rbio->real_stripes,
-					 sectornr, REQ_OP_WRITE);
+					 blocknr, REQ_OP_WRITE);
 		if (ret)
 			goto cleanup;
 	}
@@ -2670,11 +2670,11 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 {
 	void **pointers = NULL;
 	void **unmap_array = NULL;
-	int sector_nr;
+	int block_nr;
 	int ret = 0;
 
 	/*
-	 * @pointers array stores the pointer for each sector.
+	 * @pointers array stores the pointer for each block.
 	 *
 	 * @unmap_array stores copy of pointers that does not get reordered
 	 * during reconstruction so that kunmap_local works.
@@ -2686,13 +2686,13 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 		goto out;
 	}
 
-	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+	for (block_nr = 0; block_nr < rbio->stripe_nblocks; block_nr++) {
 		int dfail = 0, failp = -1;
 		int faila;
 		int failb;
 		int found_errors;
 
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr,
+		found_errors = get_rbio_vertical_errors(rbio, block_nr,
 							 &faila, &failb);
 		if (found_errors > rbio->bioc->max_errors) {
 			ret = -EIO;
@@ -2740,7 +2740,7 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 			goto out;
 		}
 
-		ret = recover_vertical(rbio, sector_nr, pointers, unmap_array);
+		ret = recover_vertical(rbio, block_nr, pointers, unmap_array);
 		if (ret < 0)
 			goto out;
 	}
@@ -2753,39 +2753,39 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list = BIO_EMPTY_LIST;
-	int total_sector_nr;
+	int total_block_nr;
 	int ret = 0;
 
 	/* Build a list of bios to read all the missing parts. */
-	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
-	     total_sector_nr++) {
-		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		struct sector_ptr *sector;
+	for (total_block_nr = 0; total_block_nr < rbio->nr_blocks;
+	     total_block_nr++) {
+		int blocknr = total_block_nr % rbio->stripe_nblocks;
+		int stripe = total_block_nr / rbio->stripe_nblocks;
+		struct block_ptr *block;
 
 		/* No data in the vertical stripe, no need to read. */
-		if (!test_bit(sectornr, &rbio->dbitmap))
+		if (!test_bit(blocknr, &rbio->dbitmap))
 			continue;
 
 		/*
-		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk. If sector_in_rbio() finds a sector
+		 * We want to find all the blocks missing from the rbio and
+		 * read them from the disk. If block_in_rbio() finds a block
 		 * in the bio list we don't need to read it off the stripe.
 		 */
-		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-		if (sector)
+		block = block_in_rbio(rbio, stripe, blocknr, 1);
+		if (block)
 			continue;
 
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		block = rbio_stripe_block(rbio, stripe, blocknr);
 		/*
-		 * The bio cache may have handed us an uptodate sector.  If so,
+		 * The bio cache may have handed us an uptodate block.  If so,
 		 * use it.
 		 */
-		if (sector->uptodate)
+		if (block->uptodate)
 			continue;
 
-		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
-					 sectornr, REQ_OP_READ);
+		ret = rbio_add_io_block(rbio, &bio_list, block, stripe,
+					 blocknr, REQ_OP_READ);
 		if (ret) {
 			bio_list_put(&bio_list);
 			return ret;
@@ -2798,34 +2798,34 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 
 static void scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	int sector_nr;
+	int block_nr;
 	int ret;
 
 	ret = alloc_rbio_essential_pages(rbio);
 	if (ret)
 		goto out;
 
-	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
+	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_blocks);
 
 	ret = scrub_assemble_read_bios(rbio);
 	if (ret < 0)
 		goto out;
 
-	/* We may have some failures, recover the failed sectors first. */
+	/* We may have some failures, recover the failed blocks first. */
 	ret = recover_scrub_rbio(rbio);
 	if (ret < 0)
 		goto out;
 
 	/*
-	 * We have every sector properly prepared. Can finish the scrub
+	 * We have every block properly prepared. Can finish the scrub
 	 * and writeback the good content.
 	 */
 	ret = finish_parity_scrub(rbio);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
-	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
+	for (block_nr = 0; block_nr < rbio->stripe_nblocks; block_nr++) {
 		int found_errors;
 
-		found_errors = get_rbio_veritical_errors(rbio, sector_nr, NULL, NULL);
+		found_errors = get_rbio_vertical_errors(rbio, block_nr, NULL, NULL);
 		if (found_errors > rbio->bioc->max_errors) {
 			ret = -EIO;
 			break;
@@ -2859,8 +2859,8 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 	const u64 offset_in_full_stripe = data_logical -
 					  rbio->bioc->full_stripe_logical;
 	const int page_index = offset_in_full_stripe >> PAGE_SHIFT;
-	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
+	const u32 blocksize = rbio->bioc->fs_info->blocksize;
+	const u32 blocks_per_page = PAGE_SIZE / blocksize;
 	int ret;
 
 	/*
@@ -2884,9 +2884,9 @@ void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
 		struct page *src = data_pages[page_nr];
 
 		memcpy_page(dst, 0, src, 0, PAGE_SIZE);
-		for (int sector_nr = sectors_per_page * page_index;
-		     sector_nr < sectors_per_page * (page_index + 1);
-		     sector_nr++)
-			rbio->stripe_sectors[sector_nr].uptodate = true;
+		for (int block_nr = blocks_per_page * page_index;
+		     block_nr < blocks_per_page * (page_index + 1);
+		     block_nr++)
+			rbio->stripe_blocks[block_nr].uptodate = true;
 	}
 }
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 0d7b4c2fb6ae..353db840ad17 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -16,7 +16,7 @@
 #include "volumes.h"
 
 struct page;
-struct sector_ptr;
+struct block_ptr;
 struct btrfs_fs_info;
 
 enum btrfs_rbio_ops {
@@ -67,8 +67,8 @@ struct btrfs_raid_bio {
 	/* How many pages there are for the full stripe including P/Q */
 	u16 nr_pages;
 
-	/* How many sectors there are for the full stripe including P/Q */
-	u16 nr_sectors;
+	/* How many blocks there are for the full stripe including P/Q */
+	u16 nr_blocks;
 
 	/* Number of data stripes (no p/q) */
 	u8 nr_data;
@@ -79,8 +79,8 @@ struct btrfs_raid_bio {
 	/* How many pages there are for each stripe */
 	u8 stripe_npages;
 
-	/* How many sectors there are for each stripe */
-	u8 stripe_nsectors;
+	/* How many blocks there are for each stripe */
+	u8 stripe_nblocks;
 
 	/* Stripe number that we're scrubbing  */
 	u8 scrubp;
@@ -100,7 +100,7 @@ struct btrfs_raid_bio {
 	/* Bitmap to record which horizontal stripe has data */
 	unsigned long dbitmap;
 
-	/* Allocated with stripe_nsectors-many bits for finish_*() calls */
+	/* Allocated with stripe_nblocks-many bits for finish_*() calls */
 	unsigned long finish_pbitmap;
 
 	/*
@@ -115,38 +115,38 @@ struct btrfs_raid_bio {
 	 */
 	struct page **stripe_pages;
 
-	/* Pointers to the sectors in the bio_list, for faster lookup */
-	struct sector_ptr *bio_sectors;
+	/* Pointers to the blocks in the bio_list, for faster lookup */
+	struct block_ptr *bio_blocks;
 
 	/*
-	 * For subpage support, we need to map each sector to above
+	 * For subpage support, we need to map each block to above
 	 * stripe_pages.
 	 */
-	struct sector_ptr *stripe_sectors;
+	struct block_ptr *stripe_blocks;
 
 	/* Allocated with real_stripes-many pointers for finish_*() calls */
 	void **finish_pointers;
 
 	/*
 	 * The bitmap recording where IO errors happened.
-	 * Each bit is corresponding to one sector in either bio_sectors[] or
-	 * stripe_sectors[] array.
+	 * Each bit is corresponding to one block in either bio_blocks[] or
+	 * stripe_blocks[] array.
 	 *
-	 * The reason we don't use another bit in sector_ptr is, we have two
-	 * arrays of sectors, and a lot of IO can use sectors in both arrays.
+	 * The reason we don't use another bit in block_ptr is, we have two
+	 * arrays of blocks, and a lot of IO can use blocks in both arrays.
 	 * Thus making it much harder to iterate.
 	 */
 	unsigned long *error_bitmap;
 
 	/*
 	 * Checksum buffer if the rbio is for data.  The buffer should cover
-	 * all data sectors (excluding P/Q sectors).
+	 * all data blocks (excluding P/Q blocks).
 	 */
 	u8 *csum_buf;
 
 	/*
-	 * Each bit represents if the corresponding sector has data csum found.
-	 * Should only cover data sectors (excluding P/Q sectors).
+	 * Each bit represents if the corresponding block has data csum found.
+	 * Should only cover data blocks (excluding P/Q blocks).
 	 */
 	unsigned long *csum_bitmap;
 };
@@ -198,7 +198,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
 				struct btrfs_device *scrub_dev,
-				unsigned long *dbitmap, int stripe_nsectors);
+				unsigned long *dbitmap, int stripe_nblocks);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
 void raid56_parity_cache_data_pages(struct btrfs_raid_bio *rbio,
-- 
2.47.1


