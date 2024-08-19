Return-Path: <linux-btrfs+bounces-7325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CC95752B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 22:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592121F2590D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 20:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4281DD39E;
	Mon, 19 Aug 2024 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yaLx4o6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Ix45UUB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yaLx4o6l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Ix45UUB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE641DD395
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097698; cv=none; b=mQSqyJ3YcYUroU0wq7vdiceY5ior265c7uHLLowcS6BCem0CmhMf7Baxhuq6+zUXi4Rtg53XhnIU6WSN38QNh9UZUyYBsca53coe9wKJIzUAtiW5BlaVX/GEzUXIwxxtO+OgP6X41XhsxBRfK6mQ/t+xQkNFJBqyu27MtgRqzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097698; c=relaxed/simple;
	bh=e/mbZLoSsGKeffUuyRKJSxorVBNCmYfeYymUqBKR0nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA8cxbFej1vAWiSBQPCSQIs9g7sddlMwO1ZHgaUm08pNSb3d7oFp0nm53K/iLC4vz+eKSRAP8lY4JB0duNnyTiX6cs6nJnMIHAi7JyzZtUw2p9QBqxDn6zd/LAiRTqoe36h9c8qbVcCbalkfjN01m3ssgkfr2P7k5oo5/1pCjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yaLx4o6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Ix45UUB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yaLx4o6l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Ix45UUB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2791221EF5;
	Mon, 19 Aug 2024 20:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724097694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrLvOcC/6OUzzxBrm7ipl8BijqhjVAkid35YUQBxoYQ=;
	b=yaLx4o6lMWRRecoKIb77RrYyMxe6eKjaIK/PfFUNS+9hN5pgbp8V1cFZMpoy7e+/EaHzJO
	MfCeKqOrjLcD2U8mda4UZnyu3Hm+uNGyw0wCBpzKaCGUeJvIvDJatcTW1UyD6TTTn2H5xh
	nnzluzTQajnLKvv4Ge8/wydAYZD1ip4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724097694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrLvOcC/6OUzzxBrm7ipl8BijqhjVAkid35YUQBxoYQ=;
	b=0Ix45UUBFsjCTfgvVMWDDt+0CBHbTRuTD0/uwt8zTu2MLQkgoZHjemcf+viW5mvU4fffsp
	6MKz4NcFqhpgzTBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yaLx4o6l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0Ix45UUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724097694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrLvOcC/6OUzzxBrm7ipl8BijqhjVAkid35YUQBxoYQ=;
	b=yaLx4o6lMWRRecoKIb77RrYyMxe6eKjaIK/PfFUNS+9hN5pgbp8V1cFZMpoy7e+/EaHzJO
	MfCeKqOrjLcD2U8mda4UZnyu3Hm+uNGyw0wCBpzKaCGUeJvIvDJatcTW1UyD6TTTn2H5xh
	nnzluzTQajnLKvv4Ge8/wydAYZD1ip4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724097694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrLvOcC/6OUzzxBrm7ipl8BijqhjVAkid35YUQBxoYQ=;
	b=0Ix45UUBFsjCTfgvVMWDDt+0CBHbTRuTD0/uwt8zTu2MLQkgoZHjemcf+viW5mvU4fffsp
	6MKz4NcFqhpgzTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5EEB137C3;
	Mon, 19 Aug 2024 20:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RApFMp2kw2bBZgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 19 Aug 2024 20:01:33 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/2] btrfs: take extent lock only while reading extent map
Date: Mon, 19 Aug 2024 16:00:53 -0400
Message-ID: <1dd23111344b032993047de374de151cef3d4548.1724095925.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724095925.git.rgoldwyn@suse.com>
References: <cover.1724095925.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2791221EF5
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Limit the scope of the extent lock only while reading extent map.
The extent_map is refcounted so we don't need to worry about holding the
lock for it's lifecycle (in em_cached).

This removes all the processed extent structures and functions for
unlocking the extent as a whole on finishing reads.

This also removes all unlock extents for page boundaries in case of a
failure while performing reads.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c |  5 ---
 fs/btrfs/extent_io.c   | 95 +++---------------------------------------
 2 files changed, 5 insertions(+), 95 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 832ab8984c41..094d46cdfd1b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -424,11 +424,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
-	struct extent_io_tree *tree;
 	int sectors_missed = 0;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
-	tree = &BTRFS_I(inode)->io_tree;
 
 	if (isize == 0)
 		return 0;
@@ -499,7 +497,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		page_end = (pg_index << PAGE_SHIFT) + folio_size(folio) - 1;
-		lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
@@ -514,7 +511,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (extent_map_block_start(em) >> SECTOR_SHIFT) !=
 		    orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
-			unlock_extent(tree, cur, page_end, NULL);
 			folio_unlock(folio);
 			folio_put(folio);
 			break;
@@ -534,7 +530,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 		if (!bio_add_folio(orig_bio, folio, add_size,
 				   offset_in_folio(folio, cur))) {
-			unlock_extent(tree, cur, page_end, NULL);
 			folio_unlock(folio);
 			folio_put(folio);
 			break;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 695589f02263..b16b80895dc7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -480,75 +480,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	bio_put(bio);
 }
 
-/*
- * Record previously processed extent range
- *
- * For endio_readpage_release_extent() to handle a full extent range, reducing
- * the extent io operations.
- */
-struct processed_extent {
-	struct btrfs_inode *inode;
-	/* Start of the range in @inode */
-	u64 start;
-	/* End of the range in @inode */
-	u64 end;
-	bool uptodate;
-};
-
-/*
- * Try to release processed extent range
- *
- * May not release the extent range right now if the current range is
- * contiguous to processed extent.
- *
- * Will release processed extent when any of @inode, @uptodate, the range is
- * no longer contiguous to the processed range.
- *
- * Passing @inode == NULL will force processed extent to be released.
- */
-static void endio_readpage_release_extent(struct processed_extent *processed,
-			      struct btrfs_inode *inode, u64 start, u64 end,
-			      bool uptodate)
-{
-	struct extent_state *cached = NULL;
-	struct extent_io_tree *tree;
-
-	/* The first extent, initialize @processed */
-	if (!processed->inode)
-		goto update;
-
-	/*
-	 * Contiguous to processed extent, just uptodate the end.
-	 *
-	 * Several things to notice:
-	 *
-	 * - bio can be merged as long as on-disk bytenr is contiguous
-	 *   This means we can have page belonging to other inodes, thus need to
-	 *   check if the inode still matches.
-	 * - bvec can contain range beyond current page for multi-page bvec
-	 *   Thus we need to do processed->end + 1 >= start check
-	 */
-	if (processed->inode == inode && processed->uptodate == uptodate &&
-	    processed->end + 1 >= start && end >= processed->end) {
-		processed->end = end;
-		return;
-	}
-
-	tree = &processed->inode->io_tree;
-	/*
-	 * Now we don't have range contiguous to the processed range, release
-	 * the processed range now.
-	 */
-	unlock_extent(tree, processed->start, processed->end, &cached);
-
-update:
-	/* Update processed to current range */
-	processed->inode = inode;
-	processed->start = start;
-	processed->end = end;
-	processed->uptodate = uptodate;
-}
-
 static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
 	ASSERT(folio_test_locked(folio));
@@ -575,7 +506,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 	struct bio *bio = &bbio->bio;
-	struct processed_extent processed = { 0 };
 	struct folio_iter fi;
 	const u32 sectorsize = fs_info->sectorsize;
 
@@ -640,11 +570,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 
 		/* Update page status and unlock. */
 		end_folio_read(folio, uptodate, start, len);
-		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, uptodate);
 	}
-	/* Release the last extent */
-	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
 	bio_put(bio);
 }
 
@@ -973,6 +899,7 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 					   u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
+	struct extent_state *cached_state = NULL;
 
 	ASSERT(em_cached);
 
@@ -988,12 +915,16 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 		*em_cached = NULL;
 	}
 
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start + len - 1, &cached_state);
+
 	em = btrfs_get_extent(BTRFS_I(inode), folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
 	}
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, start + len - 1, &cached_state);
+
 	return em;
 }
 /*
@@ -1019,11 +950,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	size_t pg_offset = 0;
 	size_t iosize;
 	size_t blocksize = fs_info->sectorsize;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
-		unlock_extent(tree, start, end, NULL);
 		folio_unlock(folio);
 		return ret;
 	}
@@ -1047,14 +976,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (cur >= last_byte) {
 			iosize = folio_size(folio) - pg_offset;
 			folio_zero_range(folio, pg_offset, iosize);
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_folio_read(folio, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, folio, cur, end - cur + 1,
 				      em_cached);
 		if (IS_ERR(em)) {
-			unlock_extent(tree, cur, end, NULL);
 			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
 		}
@@ -1123,7 +1050,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		if (block_start == EXTENT_MAP_HOLE) {
 			folio_zero_range(folio, pg_offset, iosize);
 
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_folio_read(folio, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1131,7 +1057,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		}
 		/* the get_extent function already copied into the folio */
 		if (block_start == EXTENT_MAP_INLINE) {
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_folio_read(folio, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1156,15 +1081,10 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct btrfs_inode *inode = folio_to_inode(folio);
-	u64 start = folio_pos(folio);
-	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	struct extent_map *em_cached = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
 	free_extent_map(em_cached);
 
@@ -2345,15 +2265,10 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
-	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
 	struct folio *folio;
-	u64 start = readahead_pos(rac);
-	u64 end = start + readahead_length(rac) - 1;
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
-- 
2.46.0


