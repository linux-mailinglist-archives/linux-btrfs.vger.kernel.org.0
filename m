Return-Path: <linux-btrfs+bounces-10532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51B9F61F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F215B167F45
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4315B13D;
	Wed, 18 Dec 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CCCZJkme";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CCCZJkme"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC74198A1A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514924; cv=none; b=agDQ0hJ8wbDmr7WhxNifUxJy73j85btYpvtcrq+845Xv6LMgu6273VULJtkHyNogWosEx1d8e8kURUqGer4BnIZWQYojyR0kFB9nXDODXpnJl5+rJW65t4ij2lyCWZTd9/mAuHgm8M2VmTYpNkJoOLaMiRDAfLff7PGF2HlDuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514924; c=relaxed/simple;
	bh=EezIwDv3OdlzXR9LEPCSp8YNz63o2mwvdyq+N+719WA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1YioW5f/HVYkqLkThdUCxOcYRBmwQ8waLND+1AHuRJOhew7onoqrNyS2ozmkcYFswesKoveUVgkEgZ+x5Hg6py/FL7z7Dv11M3gc6DKO/lPzUiuaTgxBr85t3kyFLaLKtjqiEo/2M4O95f9qYeKu3VcB5Y08OnTRVGgpFnWAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CCCZJkme; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CCCZJkme; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 227BC2116B
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGP0ZiJzZJ86Fh8DCVZxVGmgc9zH4PLwu2Uq3CUc+qk=;
	b=CCCZJkmeExgXrNYMRfTJ00/UEJDdBdVbEJsJotFSEZuWOrfn/g8ejaA8qp3SaIHPtpm0op
	Fn9XomN1gE6K5n5plt0eAVIMzfcGVWyuqxQOCv0+ceEbtnAAzp2r0AavQZup/NSV5KWVlW
	ow7Ql7koNEcSO6E92JWUEAUD6ZOrzJ4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CCCZJkme
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGP0ZiJzZJ86Fh8DCVZxVGmgc9zH4PLwu2Uq3CUc+qk=;
	b=CCCZJkmeExgXrNYMRfTJ00/UEJDdBdVbEJsJotFSEZuWOrfn/g8ejaA8qp3SaIHPtpm0op
	Fn9XomN1gE6K5n5plt0eAVIMzfcGVWyuqxQOCv0+ceEbtnAAzp2r0AavQZup/NSV5KWVlW
	ow7Ql7koNEcSO6E92JWUEAUD6ZOrzJ4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D59E132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aFIVA+eYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/18] btrfs: migrate extent_io.[ch] to use block size terminology
Date: Wed, 18 Dec 2024 20:11:21 +1030
Message-ID: <eaa1da7b8ce3872268c97b092f5c51b516941e51.1734514696.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 227BC2116B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Straightforward rename from "sector" to "block", except the bio
interface.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 124 +++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h |  16 +++---
 2 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9725ff7f274d..26e53c6c077c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -103,7 +103,7 @@ struct btrfs_bio_ctrl {
 	struct writeback_control *wbc;
 
 	/*
-	 * The sectors of the page which are going to be submitted by
+	 * The blocks of the page which are going to be submitted by
 	 * extent_writepage_io().
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
@@ -457,7 +457,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, bio) {
@@ -468,12 +468,12 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		/* Only order 0 (single page) folios are allowed for data. */
 		ASSERT(folio_order(folio) == 0);
 
-		/* Our read/write should always be sector aligned. */
-		if (!IS_ALIGNED(fi.offset, sectorsize))
+		/* Our read/write should always be block aligned. */
+		if (!IS_ALIGNED(fi.offset, blocksize))
 			btrfs_err(fs_info,
 		"partial page write in btrfs with offset %zu and length %zu",
 				  fi.offset, fi.length);
-		else if (!IS_ALIGNED(fi.length, sectorsize))
+		else if (!IS_ALIGNED(fi.length, blocksize))
 			btrfs_info(fs_info,
 		"incomplete page write with offset %zu and length %zu",
 				   fi.offset, fi.length);
@@ -515,7 +515,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct bio *bio = &bbio->bio;
 	struct folio_iter fi;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, &bbio->bio) {
@@ -534,17 +534,17 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 			bbio->mirror_num);
 
 		/*
-		 * We always issue full-sector reads, but if some block in a
+		 * We always issue full-block reads, but if some block in a
 		 * folio fails to read, blk_update_request() will advance
 		 * bv_offset and adjust bv_len to compensate.  Print a warning
 		 * for unaligned offsets, and an error if they don't add up to
-		 * a full sector.
+		 * a full block.
 		 */
-		if (!IS_ALIGNED(fi.offset, sectorsize))
+		if (!IS_ALIGNED(fi.offset, blocksize))
 			btrfs_err(fs_info,
 		"partial page read in btrfs with offset %zu and length %zu",
 				  fi.offset, fi.length);
-		else if (!IS_ALIGNED(fi.offset + fi.length, sectorsize))
+		else if (!IS_ALIGNED(fi.offset + fi.length, blocksize))
 			btrfs_info(fs_info,
 		"incomplete page read with offset %zu and length %zu",
 				   fi.offset, fi.length);
@@ -795,7 +795,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 
 		/*
 		 * len_to_oe_boundary defaults to U32_MAX, which isn't folio or
-		 * sector aligned.  alloc_new_bio() then sets it to the end of
+		 * block aligned.  alloc_new_bio() then sets it to the end of
 		 * our ordered extent for writes into zoned devices.
 		 *
 		 * When len_to_oe_boundary is tracking an ordered extent, we
@@ -955,7 +955,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	int ret = 0;
 	size_t pg_offset = 0;
 	size_t iosize;
-	size_t blocksize = fs_info->sectorsize;
+	size_t blocksize = fs_info->blocksize;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
@@ -978,7 +978,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
 
-		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
+		ASSERT(IS_ALIGNED(cur, fs_info->blocksize));
 		if (cur >= last_byte) {
 			iosize = folio_size(folio) - pg_offset;
 			folio_zero_range(folio, pg_offset, iosize);
@@ -1111,8 +1111,8 @@ static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bit
 	unsigned int nbits;
 
 	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
-	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
-	nbits = len >> fs_info->sectorsize_bits;
+	start_bit = (start - folio_start) >> fs_info->blocksize_bits;
+	nbits = len >> fs_info->blocksize_bits;
 	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
 	bitmap_set(delalloc_bitmap, start_bit, nbits);
 }
@@ -1123,21 +1123,21 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	const u64 folio_start = folio_pos(folio);
-	const unsigned int bitmap_size = fs_info->sectors_per_page;
+	const unsigned int bitmap_size = fs_info->blocks_per_page;
 	unsigned int start_bit;
 	unsigned int first_zero;
 	unsigned int first_set;
 
 	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
 
-	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	start_bit = (start - folio_start) >> fs_info->blocksize_bits;
 	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
 	if (first_set >= bitmap_size)
 		return false;
 
-	*found_start = folio_start + (first_set << fs_info->sectorsize_bits);
+	*found_start = folio_start + (first_set << fs_info->blocksize_bits);
 	first_zero = find_next_zero_bit(delalloc_bitmap, bitmap_size, first_set);
-	*found_len = (first_zero - first_set) << fs_info->sectorsize_bits;
+	*found_len = (first_zero - first_set) << fs_info->blocksize_bits;
 	return true;
 }
 
@@ -1175,16 +1175,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
-		ASSERT(fs_info->sectors_per_page > 1);
+		ASSERT(fs_info->blocks_per_page > 1);
 		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &bio_ctrl->submit_bitmap);
 	} else {
 		bio_ctrl->submit_bitmap = 1;
 	}
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
-		u64 start = page_start + (bit << fs_info->sectorsize_bits);
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->blocks_per_page) {
+		u64 start = page_start + (bit << fs_info->blocksize_bits);
 
-		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
+		btrfs_folio_set_lock(fs_info, folio, start, fs_info->blocksize);
 	}
 
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
@@ -1227,7 +1227,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		if (!found)
 			break;
 		/*
-		 * The subpage range covers the last sector, the delalloc range may
+		 * The subpage range covers the last block, the delalloc range may
 		 * end beyond the folio boundary, use the saved delalloc_end
 		 * instead.
 		 */
@@ -1260,9 +1260,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		 */
 		if (ret > 0) {
 			unsigned int start_bit = (found_start - page_start) >>
-						 fs_info->sectorsize_bits;
+						 fs_info->blocksize_bits;
 			unsigned int end_bit = (min(page_end + 1, found_start + found_len) -
-						page_start) >> fs_info->sectorsize_bits;
+						page_start) >> fs_info->blocksize_bits;
 			bitmap_clear(&bio_ctrl->submit_bitmap, start_bit, end_bit - start_bit);
 		}
 		/*
@@ -1292,7 +1292,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	 * If all ranges are submitted asynchronously, we just need to account
 	 * for them here.
 	 */
-	if (bitmap_empty(&bio_ctrl->submit_bitmap, fs_info->sectors_per_page)) {
+	if (bitmap_empty(&bio_ctrl->submit_bitmap, fs_info->blocks_per_page)) {
 		wbc->nr_to_write -= delalloc_to_write;
 		return 1;
 	}
@@ -1310,12 +1310,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 }
 
 /*
- * Return 0 if we have submitted or queued the sector for submission.
+ * Return 0 if we have submitted or queued the block for submission.
  * Return <0 for critical errors.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
-static int submit_one_sector(struct btrfs_inode *inode,
+static int submit_one_block(struct btrfs_inode *inode,
 			     struct folio *folio,
 			     u64 filepos, struct btrfs_bio_ctrl *bio_ctrl,
 			     loff_t i_size)
@@ -1326,22 +1326,22 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	u64 disk_bytenr;
 	u64 extent_offset;
 	u64 em_end;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 
-	ASSERT(IS_ALIGNED(filepos, sectorsize));
+	ASSERT(IS_ALIGNED(filepos, blocksize));
 
 	/* @filepos >= i_size case should be handled by the caller. */
 	ASSERT(filepos < i_size);
 
-	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
+	em = btrfs_get_extent(inode, NULL, filepos, blocksize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
 	extent_offset = filepos - em->start;
 	em_end = extent_map_end(em);
 	ASSERT(filepos <= em_end);
-	ASSERT(IS_ALIGNED(em->start, sectorsize));
-	ASSERT(IS_ALIGNED(em->len, sectorsize));
+	ASSERT(IS_ALIGNED(em->start, blocksize));
+	ASSERT(IS_ALIGNED(em->len, blocksize));
 
 	block_start = extent_map_block_start(em);
 	disk_bytenr = extent_map_block_start(em) + extent_offset;
@@ -1359,18 +1359,18 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	 * So clear subpage dirty bit here so next time we won't submit
 	 * a folio for a range already written to disk.
 	 */
-	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
-	btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
+	btrfs_folio_clear_dirty(fs_info, folio, filepos, blocksize);
+	btrfs_folio_set_writeback(fs_info, folio, filepos, blocksize);
 	/*
 	 * Above call should set the whole folio with writeback flag, even
-	 * just for a single subpage sector.
+	 * just for a single subpage block.
 	 * As long as the folio is properly locked and the range is correct,
 	 * we should always get the folio with writeback flag.
 	 */
 	ASSERT(folio_test_writeback(folio));
 
 	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
-			    sectorsize, filepos - folio_pos(folio));
+			    blocksize, filepos - folio_pos(folio));
 	return 0;
 }
 
@@ -1407,15 +1407,15 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
-	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
-		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
+	for (cur = start; cur < start + len; cur += fs_info->blocksize)
+		set_bit((cur - folio_start) >> fs_info->blocksize_bits, &range_bitmap);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
-		   fs_info->sectors_per_page);
+		   fs_info->blocks_per_page);
 
 	bio_ctrl->end_io_func = end_bbio_data_write;
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
-		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->blocks_per_page) {
+		cur = folio_pos(folio) + (bit << fs_info->blocksize_bits);
 
 		if (cur >= i_size) {
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
@@ -1425,21 +1425,21 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * bother writing back.
 			 * But we still need to clear the dirty subpage bit, or
 			 * the next time the folio gets dirtied, we will try to
-			 * writeback the sectors with subpage dirty bits,
+			 * writeback the blocks with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
 			btrfs_folio_clear_dirty(fs_info, folio, cur,
 						start + len - cur);
 			break;
 		}
-		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
+		ret = submit_one_block(inode, folio, cur, bio_ctrl, i_size);
 		if (ret < 0)
 			goto out;
 		submitted_io = true;
 	}
 out:
 	/*
-	 * If we didn't submitted any sector (>= i_size), folio dirty get
+	 * If we didn't submitted any block (>= i_size), folio dirty get
 	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
 	 * by folio_start_writeback() if the folio is not dirty).
 	 *
@@ -1658,7 +1658,7 @@ static struct extent_buffer *find_extent_buffer_nolock(
 
 	rcu_read_lock();
 	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> fs_info->sectorsize_bits);
+			       start >> fs_info->blocksize_bits);
 	if (eb && atomic_inc_not_zero(&eb->refs)) {
 		rcu_read_unlock();
 		return eb;
@@ -1794,10 +1794,10 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 	int submitted = 0;
 	u64 folio_start = folio_pos(folio);
 	int bit_start = 0;
-	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
+	int blocks_per_node = fs_info->nodesize >> fs_info->blocksize_bits;
 
 	/* Lock and write each dirty extent buffers in the range */
-	while (bit_start < fs_info->sectors_per_page) {
+	while (bit_start < fs_info->blocks_per_page) {
 		struct btrfs_subpage *subpage = folio_get_private(folio);
 		struct extent_buffer *eb;
 		unsigned long flags;
@@ -1813,7 +1813,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 			break;
 		}
 		spin_lock_irqsave(&subpage->lock, flags);
-		if (!test_bit(bit_start + btrfs_bitmap_nr_dirty * fs_info->sectors_per_page,
+		if (!test_bit(bit_start + btrfs_bitmap_nr_dirty * fs_info->blocks_per_page,
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&folio->mapping->i_private_lock);
@@ -1821,8 +1821,8 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 			continue;
 		}
 
-		start = folio_start + bit_start * fs_info->sectorsize;
-		bit_start += sectors_per_node;
+		start = folio_start + bit_start * fs_info->blocksize;
+		bit_start += blocks_per_node;
 
 		/*
 		 * Here we just want to grab the eb without touching extra
@@ -2246,7 +2246,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	loff_t i_size = i_size_read(inode);
 	u64 cur = start;
 	struct btrfs_bio_ctrl bio_ctrl = {
@@ -2257,7 +2257,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 	if (wbc->no_cgroup_owner)
 		bio_ctrl.opf |= REQ_BTRFS_CGROUP_PUNT;
 
-	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
+	ASSERT(IS_ALIGNED(start, blocksize) && IS_ALIGNED(end + 1, blocksize));
 
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
@@ -2283,7 +2283,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			ASSERT(folio_test_dirty(folio));
 
 		/*
-		 * Set the submission bitmap to submit all sectors.
+		 * Set the submission bitmap to submit all blocks.
 		 * extent_writepage_io() will do the truncation correctly.
 		 */
 		bio_ctrl.submit_bitmap = (unsigned long)-1;
@@ -2354,7 +2354,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	struct extent_state *cached_state = NULL;
 	u64 start = folio_pos(folio);
 	u64 end = start + folio_size(folio) - 1;
-	size_t blocksize = folio_to_fs_info(folio)->sectorsize;
+	size_t blocksize = folio_to_fs_info(folio)->blocksize;
 
 	/* This function is only called for the btree inode */
 	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
@@ -2810,7 +2810,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> fs_info->sectorsize_bits, eb);
+				start >> fs_info->blocksize_bits, eb);
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
@@ -2867,7 +2867,7 @@ static struct extent_buffer *grab_extent_buffer(
 
 static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 {
-	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
+	if (!IS_ALIGNED(start, fs_info->blocksize)) {
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return -EINVAL;
 	}
@@ -3128,7 +3128,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> fs_info->sectorsize_bits, eb);
+				start >> fs_info->blocksize_bits, eb);
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
@@ -3212,7 +3212,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 			spin_lock(&fs_info->buffer_lock);
 			radix_tree_delete(&fs_info->buffer_radix,
-					  eb->start >> fs_info->sectorsize_bits);
+					  eb->start >> fs_info->blocksize_bits);
 			spin_unlock(&fs_info->buffer_lock);
 		} else {
 			spin_unlock(&eb->refs_lock);
@@ -3714,7 +3714,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 /*
  * Check that the extent buffer is uptodate.
  *
- * For regular sector size == PAGE_SIZE case, check if @page is uptodate.
+ * For regular block size == PAGE_SIZE case, check if @page is uptodate.
  * For subpage case, check if the range covered by the eb has EXTENT_UPTODATE.
  */
 static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
@@ -4126,7 +4126,7 @@ static struct extent_buffer *get_next_extent_buffer(
 		int i;
 
 		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
-				(void **)gang, cur >> fs_info->sectorsize_bits,
+				(void **)gang, cur >> fs_info->blocksize_bits,
 				min_t(unsigned int, GANG_LOOKUP_SIZE,
 				      PAGE_SIZE / fs_info->nodesize));
 		if (ret == 0)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8a36117ed453..c0e70412851f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -145,13 +145,13 @@ static inline unsigned long offset_in_eb_folio(const struct extent_buffer *eb,
  * @eb:		target extent buffer
  * @start:	offset inside the extent buffer
  *
- * Will handle both sectorsize == PAGE_SIZE and sectorsize < PAGE_SIZE cases.
+ * Will handle both blocksize == PAGE_SIZE and blocksize < PAGE_SIZE cases.
  */
 static inline size_t get_eb_offset_in_folio(const struct extent_buffer *eb,
 					    unsigned long offset)
 {
 	/*
-	 * 1) sectorsize == PAGE_SIZE and nodesize >= PAGE_SIZE case
+	 * 1) blocksize == PAGE_SIZE and nodesize >= PAGE_SIZE case
 	 *    1.1) One large folio covering the whole eb
 	 *	   The eb->start is aligned to folio size, thus adding it
 	 *	   won't cause any difference.
@@ -159,7 +159,7 @@ static inline size_t get_eb_offset_in_folio(const struct extent_buffer *eb,
 	 *	   The eb->start is aligned to folio (page) size, thus
 	 *	   adding it won't cause any difference.
 	 *
-	 * 2) sectorsize < PAGE_SIZE and nodesize < PAGE_SIZE case
+	 * 2) blocksize < PAGE_SIZE and nodesize < PAGE_SIZE case
 	 *    In this case there would only be one page sized folio, and there
 	 *    may be several different extent buffers in the page/folio.
 	 *    We need to add eb->start to properly access the offset inside
@@ -172,7 +172,7 @@ static inline unsigned long get_eb_folio_index(const struct extent_buffer *eb,
 					       unsigned long offset)
 {
 	/*
-	 * 1) sectorsize == PAGE_SIZE and nodesize >= PAGE_SIZE case
+	 * 1) blocksize == PAGE_SIZE and nodesize >= PAGE_SIZE case
 	 *    1.1) One large folio covering the whole eb.
 	 *	   the folio_shift would be large enough to always make us
 	 *	   return 0 as index.
@@ -180,7 +180,7 @@ static inline unsigned long get_eb_folio_index(const struct extent_buffer *eb,
 	 *         The folio_shift would be PAGE_SHIFT, giving us the correct
 	 *         index.
 	 *
-	 * 2) sectorsize < PAGE_SIZE and nodesize < PAGE_SIZE case
+	 * 2) blocksize < PAGE_SIZE and nodesize < PAGE_SIZE case
 	 *    The folio would only be page sized, and always give us 0 as index.
 	 */
 	return offset >> eb->folio_shift;
@@ -275,10 +275,10 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 static inline int num_extent_pages(const struct extent_buffer *eb)
 {
 	/*
-	 * For sectorsize == PAGE_SIZE case, since nodesize is always aligned to
-	 * sectorsize, it's just eb->len >> PAGE_SHIFT.
+	 * For blocksize == PAGE_SIZE case, since nodesize is always aligned to
+	 * blocksize, it's just eb->len >> PAGE_SHIFT.
 	 *
-	 * For sectorsize < PAGE_SIZE case, we could have nodesize < PAGE_SIZE,
+	 * For blocksize < PAGE_SIZE case, we could have nodesize < PAGE_SIZE,
 	 * thus have to ensure we get at least one page.
 	 */
 	return (eb->len >> PAGE_SHIFT) ?: 1;
-- 
2.47.1


