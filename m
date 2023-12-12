Return-Path: <linux-btrfs+bounces-833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E319480E1E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 03:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EE51C21765
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3289B673;
	Tue, 12 Dec 2023 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GUGyMw2J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GUGyMw2J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512E112B
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 18:29:04 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D07552231A
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dbWv0LuFjy4M760xu57BhG8za5Z1V/nblWyzAeKblw=;
	b=GUGyMw2JtXiHYGbWvPltA6CzsWH72hX05st6Ac/350ksbUa3rbo8wKgspgrI2P2NO6YPOj
	iVWH+WcGln9z3nVTkA4AaGba98HK8kbcePG6t5QdpU2J4qykUZS4m/ApwLIDoJhV8nYnoT
	XDdXz9KNSjcmuN2pGAf12vK7nWY+tdQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dbWv0LuFjy4M760xu57BhG8za5Z1V/nblWyzAeKblw=;
	b=GUGyMw2JtXiHYGbWvPltA6CzsWH72hX05st6Ac/350ksbUa3rbo8wKgspgrI2P2NO6YPOj
	iVWH+WcGln9z3nVTkA4AaGba98HK8kbcePG6t5QdpU2J4qykUZS4m/ApwLIDoJhV8nYnoT
	XDdXz9KNSjcmuN2pGAf12vK7nWY+tdQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA49913463
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sCL8HG3Fd2WtHQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:29:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: migrate various btrfs end io functions to folios
Date: Tue, 12 Dec 2023 12:58:38 +1030
Message-ID: <b56f99d1a1512cd5599c1f29607111dcc5c221b1.1702347666.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702347666.git.wqu@suse.com>
References: <cover.1702347666.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***************
X-Spam-Score: 15.00
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GUGyMw2J;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=fail (smtp-out1.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_SPF_FAIL(0.00)[-all];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAM_FLAG(5.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 WHITELIST_DMARC(-7.00)[suse.com:D:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: D07552231A
X-Spam-Flag: NO

If we still go the old page based iterator functions, like
bio_for_each_segment_all(), we can hit middle pages of a folio (compound
page).

In that case if we set any page flag on those middle pages, we can
easily trigger VM_BUG_ON(), as for compound page flags, they should
follow their flag policies (normally only set on leading or tail pages).

To avoid such problem in the future full folio migration, here we do:

- Change from bio_for_each_segment_all() to bio_for_each_folio_all()
  This completely removes the ability to access the middle page.

- Add extra ASSERT()s for data read/write paths
  To ensure we only get single paged folio for data now.

- Rename those end io functions to follow a certain schema
  * end_bbio_compressed_read()
  * end_bbio_compressed_write()

    These two endio function doesn't set any page flags, as they use pages
    not mapped to any address space.
    They can be very good candidates for higher order folio testing.

    And they are shared between compression and encoded IO.

  * end_bbio_data_read()
  * end_bbio_data_write()
  * end_bbio_meta_read()
  * end_bbio_meta_write()

  The old function names are a disaster:
    - end_bio_extent_writepage()
    - end_bio_extent_readpage()
    - extent_buffer_write_end_io()
    - extent_buffer_read_end_io()

  They share no schema on where the "end_*io" string should be, nor can
  be confusing just using "extent_buffer" and "extent" to distinguish
  data and metadata paths.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |   8 +--
 fs/btrfs/extent_io.c   | 150 +++++++++++++++++++++--------------------
 2 files changed, 81 insertions(+), 77 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ba661bc9ee99..c43572af5e68 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -264,7 +264,7 @@ void btrfs_free_compr_page(struct page *page)
 	put_page(page);
 }
 
-static void end_compressed_bio_read(struct btrfs_bio *bbio)
+static void end_bbio_comprssed_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	blk_status_t status = bbio->bio.bi_status;
@@ -337,7 +337,7 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
  * This also calls the writeback end hooks for the file pages so that metadata
  * and checksums can be updated in the file.
  */
-static void end_compressed_bio_write(struct btrfs_bio *bbio)
+static void end_bbio_comprssed_write(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
@@ -384,7 +384,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 
 	cb = alloc_compressed_bio(inode, ordered->file_offset,
 				  REQ_OP_WRITE | write_flags,
-				  end_compressed_bio_write);
+				  end_bbio_comprssed_write);
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
 	cb->compressed_pages = compressed_pages;
@@ -589,7 +589,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	compressed_len = em->block_len;
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
-				  end_compressed_bio_read);
+				  end_bbio_comprssed_read);
 
 	cb->start = em->orig_start;
 	em_len = em->len;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ec1b809a06fc..614d10655991 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -451,44 +451,48 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 }
 
 /*
- * after a writepage IO is done, we need to:
- * clear the uptodate bits on error
- * clear the writeback bits in the extent tree for this IO
- * end_page_writeback if the page has no more pending IO
+ * After a write IO is done, we need to:
+ *
+ * - clear the uptodate bits on error
+ * - clear the writeback bits in the extent tree for the range
+ * - filio_end_writeback()  if there is no more pending io for the folio
  *
  * Scheduling is not allowed, so the extent state tree is expected
  * to have one and only one object corresponding to this IO.
  */
-static void end_bio_extent_writepage(struct btrfs_bio *bbio)
+static void end_bbio_data_write(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
+		struct inode *inode = folio->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
-		u64 start = page_offset(page) + bvec->bv_offset;
-		u32 len = bvec->bv_len;
+		u64 start = folio_pos(folio) + fi.offset;
+		u32 len = fi.length;
+
+		/* Only order 0 (single page) folios are allowed for data. */
+		ASSERT(folio_order(folio) == 0);
 
 		/* Our read/write should always be sector aligned. */
-		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+		if (!IS_ALIGNED(fi.offset, sectorsize))
 			btrfs_err(fs_info,
-		"partial page write in btrfs with offset %u and length %u",
-				  bvec->bv_offset, bvec->bv_len);
-		else if (!IS_ALIGNED(bvec->bv_len, sectorsize))
+		"partial page write in btrfs with offset %zu and length %zu",
+				  fi.offset, fi.length);
+		else if (!IS_ALIGNED(fi.length, sectorsize))
 			btrfs_info(fs_info,
-		"incomplete page write with offset %u and length %u",
-				   bvec->bv_offset, bvec->bv_len);
+		"incomplete page write with offset %zu and length %zu",
+				   fi.offset, fi.length);
 
-		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error);
+		btrfs_finish_ordered_extent(bbio->ordered,
+				folio_page(folio, 0), start, len, !error);
 		if (error)
-			mapping_set_error(page->mapping, error);
-		btrfs_folio_clear_writeback(fs_info, page_folio(page), start, len);
+			mapping_set_error(folio->mapping, error);
+		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
 
 	bio_put(bio);
@@ -576,89 +580,91 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 }
 
 /*
- * after a readpage IO is done, we need to:
- * clear the uptodate bits on error
- * set the uptodate bits if things worked
- * set the page up to date if all extents in the tree are uptodate
- * clear the lock bit in the extent tree
- * unlock the page if there are no other extents locked for it
+ * After a data read IO is done, we need to:
+ *
+ * - clear the uptodate bits on error
+ * - set the uptodate bits if things worked
+ * - set the folio up to date if all extents in the tree are uptodate
+ * - clear the lock bit in the extent tree
+ * - unlock the folio if there are no other extents locked for it
  *
  * Scheduling is not allowed, so the extent state tree is expected
  * to have one and only one object corresponding to this IO.
  */
-static void end_bio_extent_readpage(struct btrfs_bio *bbio)
+static void end_bbio_data_read(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
-	struct bio_vec *bvec;
 	struct processed_extent processed = { 0 };
+	struct folio_iter fi;
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
 	 * larger than UINT_MAX, u32 here is enough.
 	 */
 	u32 bio_offset = 0;
-	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_folio_all(fi, &bbio->bio) {
 		bool uptodate = !bio->bi_status;
-		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
+		struct folio *folio = fi.folio;
+		struct inode *inode = folio->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
 		u64 start;
 		u64 end;
 		u32 len;
 
+		/* For now only order 0 folios are supported for data. */
+		ASSERT(folio_order(folio) == 0);
 		btrfs_debug(fs_info,
-			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
-			bio->bi_iter.bi_sector, bio->bi_status,
+			"%s: bi_sector=%llu, err=%d, mirror=%u",
+			__func__, bio->bi_iter.bi_sector, bio->bi_status,
 			bbio->mirror_num);
 
 		/*
 		 * We always issue full-sector reads, but if some block in a
-		 * page fails to read, blk_update_request() will advance
+		 * folio fails to read, blk_update_request() will advance
 		 * bv_offset and adjust bv_len to compensate.  Print a warning
 		 * for unaligned offsets, and an error if they don't add up to
 		 * a full sector.
 		 */
-		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+		if (!IS_ALIGNED(fi.offset, sectorsize))
 			btrfs_err(fs_info,
-		"partial page read in btrfs with offset %u and length %u",
-				  bvec->bv_offset, bvec->bv_len);
-		else if (!IS_ALIGNED(bvec->bv_offset + bvec->bv_len,
-				     sectorsize))
+		"partial page read in btrfs with offset %zu and length %zu",
+				  fi.offset, fi.length);
+		else if (!IS_ALIGNED(fi.offset + fi.length, sectorsize))
 			btrfs_info(fs_info,
-		"incomplete page read with offset %u and length %u",
-				   bvec->bv_offset, bvec->bv_len);
+		"incomplete page read with offset %zu and length %zu",
+				   fi.offset, fi.length);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
-		len = bvec->bv_len;
+		start = folio_pos(folio) + fi.offset;
+		end = start + fi.length - 1;
+		len = fi.length;
 
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
-			pgoff_t end_index = i_size >> PAGE_SHIFT;
+			pgoff_t end_index = i_size >> folio_shift(folio);
 
 			/*
 			 * Zero out the remaining part if this range straddles
 			 * i_size.
 			 *
-			 * Here we should only zero the range inside the bvec,
+			 * Here we should only zero the range inside the folio,
 			 * not touch anything else.
 			 *
 			 * NOTE: i_size is exclusive while end is inclusive.
 			 */
-			if (page->index == end_index && i_size <= end) {
-				u32 zero_start = max(offset_in_page(i_size),
-						     offset_in_page(start));
+			if (folio_index(folio) == end_index && i_size <= end) {
+				u32 zero_start = max(offset_in_folio(folio, i_size),
+						     offset_in_folio(folio, start));
+				u32 zero_len = offset_in_folio(folio, end) + 1 -
+					       zero_start;
 
-				zero_user_segment(page, zero_start,
-						  offset_in_page(end) + 1);
+				folio_zero_range(folio, zero_start, zero_len);
 			}
 		}
 
 		/* Update page status and unlock. */
-		end_page_read(page, uptodate, start, len);
+		end_page_read(folio_page(folio, 0), uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 
@@ -1031,7 +1037,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			memzero_page(page, zero_offset, iosize);
 		}
 	}
-	bio_ctrl->end_io_func = end_bio_extent_readpage;
+	bio_ctrl->end_io_func = end_bbio_data_read;
 	begin_page_read(fs_info, page);
 	while (cur <= end) {
 		enum btrfs_compression_type compress_type = BTRFS_COMPRESS_NONE;
@@ -1336,7 +1342,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
-	bio_ctrl->end_io_func = end_bio_extent_writepage;
+	bio_ctrl->end_io_func = end_bbio_data_write;
 	while (cur <= end) {
 		u32 len = end - cur + 1;
 		u64 disk_bytenr;
@@ -1638,24 +1644,23 @@ static struct extent_buffer *find_extent_buffer_nolock(
 	return NULL;
 }
 
-static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
+static void end_bbio_meta_write(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool uptodate = !bbio->bio.bi_status;
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
+	struct folio_iter fi;
 	u32 bio_offset = 0;
 
 	if (!uptodate)
 		set_btree_ioerr(eb);
 
-	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
+	bio_for_each_folio_all(fi, &bbio->bio) {
 		u64 start = eb->start + bio_offset;
-		struct page *page = bvec->bv_page;
-		u32 len = bvec->bv_len;
+		struct folio *folio = fi.folio;
+		u32 len = fi.length;
 
-		btrfs_folio_clear_writeback(fs_info, page_folio(page), start, len);
+		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 		bio_offset += len;
 	}
 
@@ -1704,7 +1709,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
-			       eb->fs_info, extent_buffer_write_end_io, eb);
+			       eb->fs_info, end_bbio_meta_write, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
 	wbc_init_bio(wbc, &bbio->bio);
@@ -4041,13 +4046,12 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
-static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
+static void end_bbio_meta_read(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool uptodate = !bbio->bio.bi_status;
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
+	struct folio_iter fi;
 	u32 bio_offset = 0;
 
 	eb->read_mirror = bbio->mirror_num;
@@ -4063,15 +4067,15 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 		set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	}
 
-	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
+	bio_for_each_folio_all(fi, &bbio->bio) {
+		struct folio *folio = fi.folio;
 		u64 start = eb->start + bio_offset;
-		struct page *page = bvec->bv_page;
-		u32 len = bvec->bv_len;
+		u32 len = fi.length;
 
 		if (uptodate)
-			btrfs_folio_set_uptodate(fs_info, page_folio(page), start, len);
+			btrfs_folio_set_uptodate(fs_info, folio, start, len);
 		else
-			btrfs_folio_clear_uptodate(fs_info, page_folio(page), start, len);
+			btrfs_folio_clear_uptodate(fs_info, folio, start, len);
 
 		bio_offset += len;
 	}
@@ -4112,7 +4116,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_READ | REQ_META, eb->fs_info,
-			       extent_buffer_read_end_io, eb);
+			       end_bbio_meta_read, eb);
 	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
-- 
2.43.0


