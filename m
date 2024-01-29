Return-Path: <linux-btrfs+bounces-1892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E380840202
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200E6B22305
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B85579D;
	Mon, 29 Jan 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fM5Q+y+u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fM5Q+y+u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1056448
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521602; cv=none; b=Xjr8igMX/MlYYdRoDVe6Cb0X1sV4w7lkqGPwJkYzlouiFVAg08LJDQQIXEZ6MFCY2KSuMk8W5uoQHi19blxC04I+uD0Eedsr1Pna8H0HdP8iBKZk7u8YSLUqUdoELVy6VeGNtJUPtJ9Dx0JsfGajKPpI8QyY30SGy0UqpyGOUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521602; c=relaxed/simple;
	bh=gQ1FJ3T9uFjVN5yUIytLLrX9RykwI7QU9FxPy+PgDQ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdvJdSj/9Odpc93akb1NBj1U+EG85gag+ROdhVgQcZbY875aqb4ZGHkXLbx+crMqv+RABwUyCcHOtYdCK6Y42hnT/O63cI5anp7ABbMFxf8EwAiWjxOLp+nbfTU5aUDGMsso9Nqwy3HF2184z3euBUQ/Epk9eWJnYo+eUUy5SqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fM5Q+y+u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fM5Q+y+u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C203121C3D
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCJu242dKaoAKIa8uFq9I7b1xHpHVXs3/nhoRrudS6U=;
	b=fM5Q+y+uSVVK7J3KkkUU6lAC3yMvs9XMtiRyWDYkRGB1w4PGfMmAXsdOadUX4x4rWpVcmE
	WmZd7Asz114vJsvLXJjm01jTUuh1uUIfplcb6Odw/X9v8VNWktsMkvPOOS3hsMm9kzOywX
	iXkhM2VtHEbj1qFrgW4t3IC9JcDf5es=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCJu242dKaoAKIa8uFq9I7b1xHpHVXs3/nhoRrudS6U=;
	b=fM5Q+y+uSVVK7J3KkkUU6lAC3yMvs9XMtiRyWDYkRGB1w4PGfMmAXsdOadUX4x4rWpVcmE
	WmZd7Asz114vJsvLXJjm01jTUuh1uUIfplcb6Odw/X9v8VNWktsMkvPOOS3hsMm9kzOywX
	iXkhM2VtHEbj1qFrgW4t3IC9JcDf5es=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C672713911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YEFfIvxzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: compression: migrate compression/decompression paths to folios
Date: Mon, 29 Jan 2024 20:16:11 +1030
Message-ID: <84fb0948a1128ccceed4dc679a412d6feba00392.1706521511.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706521511.git.wqu@suse.com>
References: <cover.1706521511.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

For both compression and decompression paths, btrfs always requires a
"struct page **pages" and "unsigned long nr_pages", this involves quite
some part of the btrfs compression paths:

- All the compression entrances

- compressed_bio structure
  This affects both compression and decompression.

- async_extent structure

Unfortunately with all those involved parts, there is no good way to
split the conversion into smaller patches while still passes compiling.

So this patch would go a large conversion just in one go.

Please note this is just pure page->folio conversion, no change on the
page sized folio requirement yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  89 ++++++++++++++++-----------------
 fs/btrfs/compression.h |  38 +++++++--------
 fs/btrfs/inode.c       | 108 ++++++++++++++++++++---------------------
 fs/btrfs/lzo.c         |  84 ++++++++++++++++----------------
 fs/btrfs/zlib.c        | 104 +++++++++++++++++++--------------------
 fs/btrfs/zstd.c        |  74 ++++++++++++++--------------
 6 files changed, 249 insertions(+), 248 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9c2c86f69588..ef257fe570fb 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -90,20 +90,20 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len)
 }
 
 static int compression_compress_pages(int type, struct list_head *ws,
-               struct address_space *mapping, u64 start, struct page **pages,
-               unsigned long *out_pages, unsigned long *total_in,
-               unsigned long *total_out)
+		struct address_space *mapping, u64 start, struct folio **folios,
+		unsigned long *out_folios, unsigned long *total_in,
+		unsigned long *total_out)
 {
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB:
-		return zlib_compress_pages(ws, mapping, start, pages,
-				out_pages, total_in, total_out);
+		return zlib_compress_folios(ws, mapping, start, folios,
+				out_folios, total_in, total_out);
 	case BTRFS_COMPRESS_LZO:
-		return lzo_compress_pages(ws, mapping, start, pages,
-				out_pages, total_in, total_out);
+		return lzo_compress_folios(ws, mapping, start, folios,
+				out_folios, total_in, total_out);
 	case BTRFS_COMPRESS_ZSTD:
-		return zstd_compress_pages(ws, mapping, start, pages,
-				out_pages, total_in, total_out);
+		return zstd_compress_folios(ws, mapping, start, folios,
+				out_folios, total_in, total_out);
 	case BTRFS_COMPRESS_NONE:
 	default:
 		/*
@@ -115,7 +115,7 @@ static int compression_compress_pages(int type, struct list_head *ws,
 		 * Not a big deal, just need to inform caller that we
 		 * haven't allocated any pages yet.
 		 */
-		*out_pages = 0;
+		*out_folios = 0;
 		return -E2BIG;
 	}
 }
@@ -158,11 +158,11 @@ static int compression_decompress(int type, struct list_head *ws,
 	}
 }
 
-static void btrfs_free_compressed_pages(struct compressed_bio *cb)
+static void btrfs_free_compressed_folios(struct compressed_bio *cb)
 {
-	for (unsigned int i = 0; i < cb->nr_pages; i++)
-		btrfs_free_compr_folio(page_folio(cb->compressed_pages[i]));
-	kfree(cb->compressed_pages);
+	for (unsigned int i = 0; i < cb->nr_folios; i++)
+		btrfs_free_compr_folio(cb->compressed_folios[i]);
+	kfree(cb->compressed_folios);
 }
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
@@ -269,7 +269,7 @@ static void end_bbio_comprssed_read(struct btrfs_bio *bbio)
 	if (!status)
 		status = errno_to_blk_status(btrfs_decompress_bio(cb));
 
-	btrfs_free_compressed_pages(cb);
+	btrfs_free_compressed_folios(cb);
 	btrfs_bio_end_io(cb->orig_bbio, status);
 	bio_put(&bbio->bio);
 }
@@ -323,7 +323,7 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 		end_compressed_writeback(cb);
 	/* Note, our inode could be gone now */
 
-	btrfs_free_compressed_pages(cb);
+	btrfs_free_compressed_folios(cb);
 	bio_put(&cb->bbio.bio);
 }
 
@@ -342,17 +342,18 @@ static void end_bbio_comprssed_write(struct btrfs_bio *bbio)
 	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 }
 
-static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb)
+static void btrfs_add_compressed_bio_folios(struct compressed_bio *cb)
 {
 	struct bio *bio = &cb->bbio.bio;
 	u32 offset = 0;
 
 	while (offset < cb->compressed_len) {
+		int ret;
 		u32 len = min_t(u32, cb->compressed_len - offset, PAGE_SIZE);
 
 		/* Maximum compressed extent is smaller than bio size limit. */
-		__bio_add_page(bio, cb->compressed_pages[offset >> PAGE_SHIFT],
-			       len, 0);
+		ret = bio_add_folio(bio, cb->compressed_folios[offset >> PAGE_SHIFT], len, 0);
+		ASSERT(ret);
 		offset += len;
 	}
 }
@@ -367,8 +368,8 @@ static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb)
  * the end io hooks.
  */
 void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
-				   struct page **compressed_pages,
-				   unsigned int nr_pages,
+				   struct folio **compressed_folios,
+				   unsigned int nr_folios,
 				   blk_opf_t write_flags,
 				   bool writeback)
 {
@@ -384,14 +385,14 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 				  end_bbio_comprssed_write);
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
-	cb->compressed_pages = compressed_pages;
+	cb->compressed_folios = compressed_folios;
 	cb->compressed_len = ordered->disk_num_bytes;
 	cb->writeback = writeback;
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
-	cb->nr_pages = nr_pages;
+	cb->nr_folios = nr_folios;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	cb->bbio.ordered = ordered;
-	btrfs_add_compressed_bio_pages(cb);
+	btrfs_add_compressed_bio_folios(cb);
 
 	btrfs_submit_bio(&cb->bbio, 0);
 }
@@ -599,14 +600,14 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 	free_extent_map(em);
 
-	cb->nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
-	cb->compressed_pages = kcalloc(cb->nr_pages, sizeof(struct page *), GFP_NOFS);
-	if (!cb->compressed_pages) {
+	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
+	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct page *), GFP_NOFS);
+	if (!cb->compressed_folios) {
 		ret = BLK_STS_RESOURCE;
 		goto out_free_bio;
 	}
 
-	ret2 = btrfs_alloc_page_array(cb->nr_pages, cb->compressed_pages, 0);
+	ret2 = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios, 0);
 	if (ret2) {
 		ret = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
@@ -618,7 +619,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->bbio.bio.bi_iter.bi_sector = bbio->bio.bi_iter.bi_sector;
-	btrfs_add_compressed_bio_pages(cb);
+	btrfs_add_compressed_bio_folios(cb);
 
 	if (memstall)
 		psi_memstall_leave(&pflags);
@@ -627,7 +628,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	return;
 
 out_free_compressed_pages:
-	kfree(cb->compressed_pages);
+	kfree(cb->compressed_folios);
 out_free_bio:
 	bio_put(&cb->bbio.bio);
 out:
@@ -974,18 +975,18 @@ static unsigned int btrfs_compress_set_level(int type, unsigned level)
 	return level;
 }
 
-/* A wrapper around find_get_page(), with extra error message. */
-int btrfs_compress_find_get_page(struct address_space *mapping, u64 start,
-				 struct page **in_page_ret)
+/* A wrapper around filemap_get_folio(), with extra error message. */
+int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
+				     struct folio **in_folio_ret)
 {
-	struct page *in_page;
+	struct folio *in_folio;
 
 	/*
-	 * The compressed write path should have the page locked already,
-	 * thus we only need to grab one reference of the page cache.
+	 * The compressed write path should have the folio locked already,
+	 * thus we only need to grab one reference.
 	 */
-	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	if (unlikely(!in_page)) {
+	in_folio = filemap_get_folio(mapping, start >> PAGE_SHIFT);
+	if (IS_ERR(in_folio)) {
 		struct btrfs_inode *binode = BTRFS_I(mapping->host);
 		struct btrfs_fs_info *fs_info = binode->root->fs_info;
 
@@ -996,7 +997,7 @@ int btrfs_compress_find_get_page(struct address_space *mapping, u64 start,
 		ASSERT(0);
 		return -ENOENT;
 	}
-	*in_page_ret = in_page;
+	*in_folio_ret = in_folio;
 	return 0;
 }
 
@@ -1020,9 +1021,9 @@ int btrfs_compress_find_get_page(struct address_space *mapping, u64 start,
  * @total_out is an in/out parameter, must be set to the input length and will
  * be also used to return the total number of compressed bytes
  */
-int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
-			 u64 start, struct page **pages,
-			 unsigned long *out_pages,
+int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping,
+			 u64 start, struct folio **folios,
+			 unsigned long *out_folios,
 			 unsigned long *total_in,
 			 unsigned long *total_out)
 {
@@ -1033,8 +1034,8 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 
 	level = btrfs_compress_set_level(type, level);
 	workspace = get_workspace(type, level);
-	ret = compression_compress_pages(type, workspace, mapping, start, pages,
-					 out_pages, total_in, total_out);
+	ret = compression_compress_pages(type, workspace, mapping, start, folios,
+					 out_folios, total_in, total_out);
 	put_workspace(type, workspace);
 	return ret;
 }
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 7fc3145bfbed..85b0e60e993c 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -35,11 +35,11 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 struct page;
 
 struct compressed_bio {
-	/* Number of compressed pages in the array */
-	unsigned int nr_pages;
+	/* Number of compressed folios in the array */
+	unsigned int nr_folios;
 
-	/* the pages with the compressed data on them */
-	struct page **compressed_pages;
+	/* the folios with the compressed data on them */
+	struct folio **compressed_folios;
 
 	/* starting offset in the inode for our pages */
 	u64 start;
@@ -79,9 +79,9 @@ static inline unsigned int btrfs_compress_level(unsigned int type_level)
 int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
-int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
-			 u64 start, struct page **pages,
-			 unsigned long *out_pages,
+int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping,
+			 u64 start, struct folio **folios,
+			 unsigned long *out_folios,
 			 unsigned long *total_in,
 			 unsigned long *total_out);
 int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
@@ -90,10 +90,10 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
 
 void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
-				  struct page **compressed_pages,
-				  unsigned int nr_pages,
-				  blk_opf_t write_flags,
-				  bool writeback);
+				   struct folio **compressed_folios,
+				   unsigned int nr_folios,
+				   blk_opf_t write_flags,
+				   bool writeback);
 void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
@@ -143,11 +143,11 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len);
 
 int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
 
-int btrfs_compress_find_get_page(struct address_space *mapping, u64 start,
-				 struct page **in_page_ret);
+int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
+				     struct folio **in_folio_ret);
 
-int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
+int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
@@ -157,8 +157,8 @@ struct list_head *zlib_alloc_workspace(unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
 struct list_head *zlib_get_workspace(unsigned int level);
 
-int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
+int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
@@ -167,8 +167,8 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 struct list_head *lzo_alloc_workspace(unsigned int level);
 void lzo_free_workspace(struct list_head *ws);
 
-int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
+int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index abeb78de8a15..e8c7ccd86ac5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -708,8 +708,8 @@ struct async_extent {
 	u64 start;
 	u64 ram_size;
 	u64 compressed_size;
-	struct page **pages;
-	unsigned long nr_pages;
+	struct folio **folios;
+	unsigned long nr_folios;
 	int compress_type;
 	struct list_head list;
 };
@@ -734,8 +734,8 @@ struct async_cow {
 static noinline int add_async_extent(struct async_chunk *cow,
 				     u64 start, u64 ram_size,
 				     u64 compressed_size,
-				     struct page **pages,
-				     unsigned long nr_pages,
+				     struct folio **folios,
+				     unsigned long nr_folios,
 				     int compress_type)
 {
 	struct async_extent *async_extent;
@@ -745,8 +745,8 @@ static noinline int add_async_extent(struct async_chunk *cow,
 	async_extent->start = start;
 	async_extent->ram_size = ram_size;
 	async_extent->compressed_size = compressed_size;
-	async_extent->pages = pages;
-	async_extent->nr_pages = nr_pages;
+	async_extent->folios = folios;
+	async_extent->nr_folios = nr_folios;
 	async_extent->compress_type = compress_type;
 	list_add_tail(&async_extent->list, &cow->extents);
 	return 0;
@@ -850,8 +850,8 @@ static void compress_file_range(struct btrfs_work *work)
 	u64 actual_end;
 	u64 i_size;
 	int ret = 0;
-	struct page **pages;
-	unsigned long nr_pages;
+	struct folio **folios;
+	unsigned long nr_folios;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
 	unsigned int poff;
@@ -881,9 +881,9 @@ static void compress_file_range(struct btrfs_work *work)
 	barrier();
 	actual_end = min_t(u64, i_size, end + 1);
 again:
-	pages = NULL;
-	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
-	nr_pages = min_t(unsigned long, nr_pages, BTRFS_MAX_COMPRESSED_PAGES);
+	folios = NULL;
+	nr_folios = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
+	nr_folios = min_t(unsigned long, nr_folios, BTRFS_MAX_COMPRESSED_PAGES);
 
 	/*
 	 * we don't want to send crud past the end of i_size through
@@ -932,8 +932,8 @@ static void compress_file_range(struct btrfs_work *work)
 	if (!inode_need_compress(inode, start, end))
 		goto cleanup_and_bail_uncompressed;
 
-	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-	if (!pages) {
+	folios = kcalloc(nr_folios, sizeof(struct folio *), GFP_NOFS);
+	if (!folios) {
 		/*
 		 * Memory allocation failure is not a fatal error, we can fall
 		 * back to uncompressed code.
@@ -947,8 +947,8 @@ static void compress_file_range(struct btrfs_work *work)
 		compress_type = inode->prop_compress;
 
 	/* Compression level is applied here. */
-	ret = btrfs_compress_pages(compress_type | (fs_info->compress_level << 4),
-				   mapping, start, pages, &nr_pages, &total_in,
+	ret = btrfs_compress_folios(compress_type | (fs_info->compress_level << 4),
+				   mapping, start, folios, &nr_folios, &total_in,
 				   &total_compressed);
 	if (ret)
 		goto mark_incompressible;
@@ -959,7 +959,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 */
 	poff = offset_in_page(total_compressed);
 	if (poff)
-		memzero_page(pages[nr_pages - 1], poff, PAGE_SIZE - poff);
+		folio_zero_range(folios[nr_folios - 1], poff, PAGE_SIZE - poff);
 
 	/*
 	 * Try to create an inline extent.
@@ -978,8 +978,7 @@ static void compress_file_range(struct btrfs_work *work)
 		} else {
 			ret = cow_file_range_inline(inode, actual_end,
 						    total_compressed,
-						    compress_type,
-						    page_folio(pages[0]),
+						    compress_type, folios[0],
 						    false);
 		}
 		if (ret <= 0) {
@@ -1029,8 +1028,8 @@ static void compress_file_range(struct btrfs_work *work)
 	 * The async work queues will take care of doing actual allocation on
 	 * disk for these compressed pages, and will submit the bios.
 	 */
-	add_async_extent(async_chunk, start, total_in, total_compressed, pages,
-			 nr_pages, compress_type);
+	add_async_extent(async_chunk, start, total_in, total_compressed, folios,
+			 nr_folios, compress_type);
 	if (start + total_in < end) {
 		start += total_in;
 		cond_resched();
@@ -1045,12 +1044,12 @@ static void compress_file_range(struct btrfs_work *work)
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
 			 BTRFS_COMPRESS_NONE);
 free_pages:
-	if (pages) {
-		for (i = 0; i < nr_pages; i++) {
-			WARN_ON(pages[i]->mapping);
-			btrfs_free_compr_folio(page_folio(pages[i]));
+	if (folios) {
+		for (i = 0; i < nr_folios; i++) {
+			WARN_ON(folios[i]->mapping);
+			btrfs_free_compr_folio(folios[i]);
 		}
-		kfree(pages);
+		kfree(folios);
 	}
 }
 
@@ -1058,16 +1057,16 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 {
 	int i;
 
-	if (!async_extent->pages)
+	if (!async_extent->folios)
 		return;
 
-	for (i = 0; i < async_extent->nr_pages; i++) {
-		WARN_ON(async_extent->pages[i]->mapping);
-		btrfs_free_compr_folio(page_folio(async_extent->pages[i]));
+	for (i = 0; i < async_extent->nr_folios; i++) {
+		WARN_ON(async_extent->folios[i]->mapping);
+		btrfs_free_compr_folio(async_extent->folios[i]);
 	}
-	kfree(async_extent->pages);
-	async_extent->nr_pages = 0;
-	async_extent->pages = NULL;
+	kfree(async_extent->folios);
+	async_extent->nr_folios = 0;
+	async_extent->folios = NULL;
 }
 
 static void submit_uncompressed_range(struct btrfs_inode *inode,
@@ -1191,8 +1190,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
 	btrfs_submit_compressed_write(ordered,
-			    async_extent->pages,	/* compressed_pages */
-			    async_extent->nr_pages,
+			    async_extent->folios,	/* compressed_folios */
+			    async_extent->nr_folios,
 			    async_chunk->write_flags, true);
 	*alloc_hint = ins.objectid + ins.offset;
 done:
@@ -10241,8 +10240,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	size_t orig_count;
 	u64 start, end;
 	u64 num_bytes, ram_bytes, disk_num_bytes;
-	unsigned long nr_pages, i;
-	struct page **pages;
+	unsigned long nr_folios, i;
+	struct folio **folios;
 	struct btrfs_key ins;
 	bool extent_reserved = false;
 	struct extent_map *em;
@@ -10324,24 +10323,24 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 * isn't.
 	 */
 	disk_num_bytes = ALIGN(orig_count, fs_info->sectorsize);
-	nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
-	pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
-	if (!pages)
+	nr_folios = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
+	folios = kvcalloc(nr_folios, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!folios)
 		return -ENOMEM;
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
 		char *kaddr;
 
-		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
-		if (!pages[i]) {
+		folios[i] = folio_alloc(GFP_KERNEL_ACCOUNT, 0);
+		if (!folios[i]) {
 			ret = -ENOMEM;
-			goto out_pages;
+			goto out_folios;
 		}
-		kaddr = kmap_local_page(pages[i]);
+		kaddr = kmap_local_folio(folios[i], 0);
 		if (copy_from_iter(kaddr, bytes, from) != bytes) {
 			kunmap_local(kaddr);
 			ret = -EFAULT;
-			goto out_pages;
+			goto out_folios;
 		}
 		if (bytes < PAGE_SIZE)
 			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
@@ -10353,12 +10352,12 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 		ret = btrfs_wait_ordered_range(&inode->vfs_inode, start, num_bytes);
 		if (ret)
-			goto out_pages;
+			goto out_folios;
 		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
 						    start >> PAGE_SHIFT,
 						    end >> PAGE_SHIFT);
 		if (ret)
-			goto out_pages;
+			goto out_folios;
 		lock_extent(io_tree, start, end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
 		if (!ordered &&
@@ -10389,8 +10388,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start == 0 && encoded->unencoded_len == encoded->len &&
 	    encoded->unencoded_offset == 0) {
 		ret = cow_file_range_inline(inode, encoded->len, orig_count,
-					    compression, page_folio(pages[0]),
-					    true);
+					    compression, folios[0], true);
 		if (ret <= 0) {
 			if (ret == 0)
 				ret = orig_count;
@@ -10434,7 +10432,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
-	btrfs_submit_compressed_write(ordered, pages, nr_pages, 0, false);
+	btrfs_submit_compressed_write(ordered, folios, nr_folios, 0, false);
 	ret = orig_count;
 	goto out;
 
@@ -10456,12 +10454,12 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
 out_unlock:
 	unlock_extent(io_tree, start, end, &cached_state);
-out_pages:
-	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
-			__free_page(pages[i]);
+out_folios:
+	for (i = 0; i < nr_folios; i++) {
+		if (folios[i])
+			__folio_put(folios[i]);
 	}
-	kvfree(pages);
+	kvfree(folios);
 out:
 	if (ret >= 0)
 		iocb->ki_pos += encoded->len;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 262305025aa7..0a90fe745c54 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -130,17 +130,17 @@ static inline size_t read_compress_length(const char *buf)
  */
 static int copy_compressed_data_to_page(char *compressed_data,
 					size_t compressed_size,
-					struct page **out_pages,
-					unsigned long max_nr_page,
+					struct folio **out_folios,
+					unsigned long max_nr_folio,
 					u32 *cur_out,
 					const u32 sectorsize)
 {
 	u32 sector_bytes_left;
 	u32 orig_out;
-	struct page *cur_page;
+	struct folio *cur_folio;
 	char *kaddr;
 
-	if ((*cur_out / PAGE_SIZE) >= max_nr_page)
+	if ((*cur_out / PAGE_SIZE) >= max_nr_folio)
 		return -E2BIG;
 
 	/*
@@ -149,16 +149,16 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	 */
 	ASSERT((*cur_out / sectorsize) == (*cur_out + LZO_LEN - 1) / sectorsize);
 
-	cur_page = out_pages[*cur_out / PAGE_SIZE];
+	cur_folio = out_folios[*cur_out / PAGE_SIZE];
 	/* Allocate a new page */
-	if (!cur_page) {
-		cur_page = folio_page(btrfs_alloc_compr_folio(), 0);
-		if (!cur_page)
+	if (!cur_folio) {
+		cur_folio = btrfs_alloc_compr_folio();
+		if (!cur_folio)
 			return -ENOMEM;
-		out_pages[*cur_out / PAGE_SIZE] = cur_page;
+		out_folios[*cur_out / PAGE_SIZE] = cur_folio;
 	}
 
-	kaddr = kmap_local_page(cur_page);
+	kaddr = kmap_local_folio(cur_folio, 0);
 	write_compress_length(kaddr + offset_in_page(*cur_out),
 			      compressed_size);
 	*cur_out += LZO_LEN;
@@ -172,18 +172,18 @@ static int copy_compressed_data_to_page(char *compressed_data,
 
 		kunmap_local(kaddr);
 
-		if ((*cur_out / PAGE_SIZE) >= max_nr_page)
+		if ((*cur_out / PAGE_SIZE) >= max_nr_folio)
 			return -E2BIG;
 
-		cur_page = out_pages[*cur_out / PAGE_SIZE];
+		cur_folio = out_folios[*cur_out / PAGE_SIZE];
 		/* Allocate a new page */
-		if (!cur_page) {
-			cur_page = folio_page(btrfs_alloc_compr_folio(), 0);
-			if (!cur_page)
+		if (!cur_folio) {
+			cur_folio = btrfs_alloc_compr_folio();
+			if (!cur_folio)
 				return -ENOMEM;
-			out_pages[*cur_out / PAGE_SIZE] = cur_page;
+			out_folios[*cur_out / PAGE_SIZE] = cur_folio;
 		}
-		kaddr = kmap_local_page(cur_page);
+		kaddr = kmap_local_folio(cur_folio, 0);
 
 		memcpy(kaddr + offset_in_page(*cur_out),
 		       compressed_data + *cur_out - orig_out, copy_len);
@@ -209,15 +209,15 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	return 0;
 }
 
-int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
+int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const u32 sectorsize = btrfs_sb(mapping->host->i_sb)->sectorsize;
-	struct page *page_in = NULL;
+	struct folio *folio_in = NULL;
 	char *sizes_ptr;
-	const unsigned long max_nr_page = *out_pages;
+	const unsigned long max_nr_folio = *out_folios;
 	int ret = 0;
 	/* Points to the file offset of input data */
 	u64 cur_in = start;
@@ -225,8 +225,8 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	u32 cur_out = 0;
 	u32 len = *total_out;
 
-	ASSERT(max_nr_page > 0);
-	*out_pages = 0;
+	ASSERT(max_nr_folio > 0);
+	*out_folios = 0;
 	*total_out = 0;
 	*total_in = 0;
 
@@ -243,8 +243,8 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		size_t out_len;
 
 		/* Get the input page first */
-		if (!page_in) {
-			ret =  btrfs_compress_find_get_page(mapping, cur_in, &page_in);
+		if (!folio_in) {
+			ret = btrfs_compress_filemap_get_folio(mapping, cur_in, &folio_in);
 			if (ret < 0)
 				goto out;
 		}
@@ -252,7 +252,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* Compress at most one sector of data each time */
 		in_len = min_t(u32, start + len - cur_in, sectorsize - sector_off);
 		ASSERT(in_len);
-		data_in = kmap_local_page(page_in);
+		data_in = kmap_local_folio(folio_in, 0);
 		ret = lzo1x_1_compress(data_in +
 				       offset_in_page(cur_in), in_len,
 				       workspace->cbuf, &out_len,
@@ -265,7 +265,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		}
 
 		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
-						   pages, max_nr_page,
+						   folios, max_nr_folio,
 						   &cur_out, sectorsize);
 		if (ret < 0)
 			goto out;
@@ -283,13 +283,13 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		/* Check if we have reached page boundary */
 		if (PAGE_ALIGNED(cur_in)) {
-			put_page(page_in);
-			page_in = NULL;
+			folio_put(folio_in);
+			folio_in = NULL;
 		}
 	}
 
 	/* Store the size of all chunks of compressed data */
-	sizes_ptr = kmap_local_page(pages[0]);
+	sizes_ptr = kmap_local_folio(folios[0], 0);
 	write_compress_length(sizes_ptr, cur_out);
 	kunmap_local(sizes_ptr);
 
@@ -297,9 +297,9 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_out = cur_out;
 	*total_in = cur_in - start;
 out:
-	if (page_in)
-		put_page(page_in);
-	*out_pages = DIV_ROUND_UP(cur_out, PAGE_SIZE);
+	if (folio_in)
+		folio_put(folio_in);
+	*out_folios = DIV_ROUND_UP(cur_out, PAGE_SIZE);
 	return ret;
 }
 
@@ -314,15 +314,15 @@ static void copy_compressed_segment(struct compressed_bio *cb,
 	u32 orig_in = *cur_in;
 
 	while (*cur_in < orig_in + len) {
-		struct page *cur_page;
+		struct folio *cur_folio;
 		u32 copy_len = min_t(u32, PAGE_SIZE - offset_in_page(*cur_in),
 					  orig_in + len - *cur_in);
 
 		ASSERT(copy_len);
-		cur_page = cb->compressed_pages[*cur_in / PAGE_SIZE];
+		cur_folio = cb->compressed_folios[*cur_in / PAGE_SIZE];
 
-		memcpy_from_page(dest + *cur_in - orig_in, cur_page,
-				 offset_in_page(*cur_in), copy_len);
+		memcpy_from_folio(dest + *cur_in - orig_in, cur_folio,
+				offset_in_folio(cur_folio, *cur_in), copy_len);
 
 		*cur_in += copy_len;
 	}
@@ -342,7 +342,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	/* Bytes decompressed so far */
 	u32 cur_out = 0;
 
-	kaddr = kmap_local_page(cb->compressed_pages[0]);
+	kaddr = kmap_local_folio(cb->compressed_folios[0], 0);
 	len_in = read_compress_length(kaddr);
 	kunmap_local(kaddr);
 	cur_in += LZO_LEN;
@@ -364,7 +364,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	/* Go through each lzo segment */
 	while (cur_in < len_in) {
-		struct page *cur_page;
+		struct folio *cur_folio;
 		/* Length of the compressed segment */
 		u32 seg_len;
 		u32 sector_bytes_left;
@@ -376,9 +376,9 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		 */
 		ASSERT(cur_in / sectorsize ==
 		       (cur_in + LZO_LEN - 1) / sectorsize);
-		cur_page = cb->compressed_pages[cur_in / PAGE_SIZE];
-		ASSERT(cur_page);
-		kaddr = kmap_local_page(cur_page);
+		cur_folio = cb->compressed_folios[cur_in / PAGE_SIZE];
+		ASSERT(cur_folio);
+		kaddr = kmap_local_folio(cur_folio, 0);
 		seg_len = read_compress_length(kaddr + offset_in_page(cur_in));
 		kunmap_local(kaddr);
 		cur_in += LZO_LEN;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 306a3f0bee11..ec78f0b764b3 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -91,24 +91,24 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
-int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
+int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
 	char *data_in = NULL;
-	char *cpage_out;
-	int nr_pages = 0;
-	struct page *in_page = NULL;
-	struct page *out_page = NULL;
+	char *cfolio_out;
+	int nr_folios = 0;
+	struct folio *in_folio = NULL;
+	struct folio *out_folio = NULL;
 	unsigned long bytes_left;
-	unsigned int in_buf_pages;
+	unsigned int in_buf_folios;
 	unsigned long len = *total_out;
-	unsigned long nr_dest_pages = *out_pages;
-	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
+	unsigned long nr_dest_folios = *out_folios;
+	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
 
-	*out_pages = 0;
+	*out_folios = 0;
 	*total_out = 0;
 	*total_in = 0;
 
@@ -121,18 +121,18 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_page = folio_page(btrfs_alloc_compr_folio(), 0);
-	if (out_page == NULL) {
+	out_folio = btrfs_alloc_compr_folio();
+	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = page_address(out_page);
-	pages[0] = out_page;
-	nr_pages = 1;
+	cfolio_out = folio_address(out_folio);
+	folios[0] = out_folio;
+	nr_folios = 1;
 
 	workspace->strm.next_in = workspace->buf;
 	workspace->strm.avail_in = 0;
-	workspace->strm.next_out = cpage_out;
+	workspace->strm.next_out = cfolio_out;
 	workspace->strm.avail_out = PAGE_SIZE;
 
 	while (workspace->strm.total_in < len) {
@@ -142,22 +142,22 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 */
 		if (workspace->strm.avail_in == 0) {
 			bytes_left = len - workspace->strm.total_in;
-			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
-					   workspace->buf_size / PAGE_SIZE);
-			if (in_buf_pages > 1) {
+			in_buf_folios = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
+					    workspace->buf_size / PAGE_SIZE);
+			if (in_buf_folios > 1) {
 				int i;
 
-				for (i = 0; i < in_buf_pages; i++) {
+				for (i = 0; i < in_buf_folios; i++) {
 					if (data_in) {
 						kunmap_local(data_in);
-						put_page(in_page);
+						folio_put(in_folio);
 						data_in = NULL;
 					}
-					ret = btrfs_compress_find_get_page(mapping,
-							start, &in_page);
+					ret = btrfs_compress_filemap_get_folio(mapping,
+							start, &in_folio);
 					if (ret < 0)
 						goto out;
-					data_in = kmap_local_page(in_page);
+					data_in = kmap_local_folio(in_folio, 0);
 					copy_page(workspace->buf + i * PAGE_SIZE,
 						  data_in);
 					start += PAGE_SIZE;
@@ -166,14 +166,14 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			} else {
 				if (data_in) {
 					kunmap_local(data_in);
-					put_page(in_page);
+					folio_put(in_folio);
 					data_in = NULL;
 				}
-				ret = btrfs_compress_find_get_page(mapping,
-						start, &in_page);
+				ret = btrfs_compress_filemap_get_folio(mapping,
+						start, &in_folio);
 				if (ret < 0)
 					goto out;
-				data_in = kmap_local_page(in_page);
+				data_in = kmap_local_folio(in_folio, 0);
 				start += PAGE_SIZE;
 				workspace->strm.next_in = data_in;
 			}
@@ -202,20 +202,20 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			if (nr_pages == nr_dest_pages) {
+			if (nr_folios == nr_dest_folios) {
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = folio_page(btrfs_alloc_compr_folio(), 0);
-			if (out_page == NULL) {
+			out_folio = btrfs_alloc_compr_folio();
+			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = page_address(out_page);
-			pages[nr_pages] = out_page;
-			nr_pages++;
+			cfolio_out = folio_address(out_folio);
+			folios[nr_folios] = out_folio;
+			nr_folios++;
 			workspace->strm.avail_out = PAGE_SIZE;
-			workspace->strm.next_out = cpage_out;
+			workspace->strm.next_out = cfolio_out;
 		}
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
@@ -237,21 +237,21 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			ret = -EIO;
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
-			/* get another page for the stream end */
-			if (nr_pages == nr_dest_pages) {
+			/* get another folio for the stream end */
+			if (nr_folios == nr_dest_folios) {
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = folio_page(btrfs_alloc_compr_folio(), 0);
-			if (out_page == NULL) {
+			out_folio = btrfs_alloc_compr_folio();
+			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = page_address(out_page);
-			pages[nr_pages] = out_page;
-			nr_pages++;
+			cfolio_out = folio_address(out_folio);
+			folios[nr_folios] = out_folio;
+			nr_folios++;
 			workspace->strm.avail_out = PAGE_SIZE;
-			workspace->strm.next_out = cpage_out;
+			workspace->strm.next_out = cfolio_out;
 		}
 	}
 	zlib_deflateEnd(&workspace->strm);
@@ -265,10 +265,10 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_out = workspace->strm.total_out;
 	*total_in = workspace->strm.total_in;
 out:
-	*out_pages = nr_pages;
+	*out_folios = nr_folios;
 	if (data_in) {
 		kunmap_local(data_in);
-		put_page(in_page);
+		folio_put(in_folio);
 	}
 
 	return ret;
@@ -281,13 +281,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	int wbits = MAX_WBITS;
 	char *data_in;
 	size_t total_out = 0;
-	unsigned long page_in_index = 0;
+	unsigned long folio_in_index = 0;
 	size_t srclen = cb->compressed_len;
-	unsigned long total_pages_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
+	unsigned long total_folios_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
 	unsigned long buf_start;
-	struct page **pages_in = cb->compressed_pages;
+	struct folio **folios_in = cb->compressed_folios;
 
-	data_in = kmap_local_page(pages_in[page_in_index]);
+	data_in = kmap_local_folio(folios_in[folio_in_index], 0);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
 	workspace->strm.total_in = 0;
@@ -337,12 +337,12 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
 			kunmap_local(data_in);
-			page_in_index++;
-			if (page_in_index >= total_pages_in) {
+			folio_in_index++;
+			if (folio_in_index >= total_folios_in) {
 				data_in = NULL;
 				break;
 			}
-			data_in = kmap_local_page(pages_in[page_in_index]);
+			data_in = kmap_local_folio(folios_in[folio_in_index], 0);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
 			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 2cdedae39147..c822432857ab 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -372,25 +372,25 @@ struct list_head *zstd_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
-int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
-		u64 start, struct page **pages, unsigned long *out_pages,
+int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
+		u64 start, struct folio **folios, unsigned long *out_folios,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	zstd_cstream *stream;
 	int ret = 0;
-	int nr_pages = 0;
-	struct page *in_page = NULL;  /* The current page to read */
-	struct page *out_page = NULL; /* The current page to write to */
+	int nr_folios = 0;
+	struct folio *in_folio = NULL;  /* The current page to read */
+	struct folio *out_folio = NULL; /* The current page to write to */
 	unsigned long tot_in = 0;
 	unsigned long tot_out = 0;
 	unsigned long len = *total_out;
-	const unsigned long nr_dest_pages = *out_pages;
-	unsigned long max_out = nr_dest_pages * PAGE_SIZE;
+	const unsigned long nr_dest_folios = *out_folios;
+	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
 	zstd_parameters params = zstd_get_btrfs_parameters(workspace->req_level,
 							   len);
 
-	*out_pages = 0;
+	*out_folios = 0;
 	*total_out = 0;
 	*total_in = 0;
 
@@ -404,21 +404,21 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	}
 
 	/* map in the first page of input data */
-	ret = btrfs_compress_find_get_page(mapping, start, &in_page);
+	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 	if (ret < 0)
 		goto out;
-	workspace->in_buf.src = kmap_local_page(in_page);
+	workspace->in_buf.src = kmap_local_folio(in_folio, 0);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
 	/* Allocate and map in the output buffer */
-	out_page = folio_page(btrfs_alloc_compr_folio(), 0);
-	if (out_page == NULL) {
+	out_folio = btrfs_alloc_compr_folio();
+	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	pages[nr_pages++] = out_page;
-	workspace->out_buf.dst = page_address(out_page);
+	folios[nr_folios++] = out_folio;
+	workspace->out_buf.dst = folio_address(out_folio);
 	workspace->out_buf.pos = 0;
 	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 
@@ -453,17 +453,17 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
 			tot_out += PAGE_SIZE;
 			max_out -= PAGE_SIZE;
-			if (nr_pages == nr_dest_pages) {
+			if (nr_folios == nr_dest_folios) {
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = folio_page(btrfs_alloc_compr_folio(), 0);
-			if (out_page == NULL) {
+			out_folio = btrfs_alloc_compr_folio();
+			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
 			}
-			pages[nr_pages++] = out_page;
-			workspace->out_buf.dst = page_address(out_page);
+			folios[nr_folios++] = out_folio;
+			workspace->out_buf.dst = folio_address(out_folio);
 			workspace->out_buf.pos = 0;
 			workspace->out_buf.size = min_t(size_t, max_out,
 							PAGE_SIZE);
@@ -480,13 +480,14 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			tot_in += PAGE_SIZE;
 			kunmap_local(workspace->in_buf.src);
 			workspace->in_buf.src = NULL;
-			put_page(in_page);
+			folio_put(in_folio);
 			start += PAGE_SIZE;
 			len -= PAGE_SIZE;
-			ret = btrfs_compress_find_get_page(mapping, start, &in_page);
+			ret = btrfs_compress_filemap_get_folio(mapping, start,
+							       &in_folio);
 			if (ret < 0)
 				goto out;
-			workspace->in_buf.src = kmap_local_page(in_page);
+			workspace->in_buf.src = kmap_local_folio(in_folio, 0);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 		}
@@ -513,17 +514,17 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		tot_out += PAGE_SIZE;
 		max_out -= PAGE_SIZE;
-		if (nr_pages == nr_dest_pages) {
+		if (nr_folios == nr_dest_folios) {
 			ret = -E2BIG;
 			goto out;
 		}
-		out_page = folio_page(btrfs_alloc_compr_folio(), 0);
-		if (out_page == NULL) {
+		out_folio = btrfs_alloc_compr_folio();
+		if (out_folio == NULL) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		pages[nr_pages++] = out_page;
-		workspace->out_buf.dst = page_address(out_page);
+		folios[nr_folios++] = out_folio;
+		workspace->out_buf.dst = folio_address(out_folio);
 		workspace->out_buf.pos = 0;
 		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 	}
@@ -537,10 +538,10 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = tot_in;
 	*total_out = tot_out;
 out:
-	*out_pages = nr_pages;
+	*out_folios = nr_folios;
 	if (workspace->in_buf.src) {
 		kunmap_local(workspace->in_buf.src);
-		put_page(in_page);
+		folio_put(in_folio);
 	}
 	return ret;
 }
@@ -548,12 +549,12 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct page **pages_in = cb->compressed_pages;
+	struct folio **folios_in = cb->compressed_folios;
 	size_t srclen = cb->compressed_len;
 	zstd_dstream *stream;
 	int ret = 0;
-	unsigned long page_in_index = 0;
-	unsigned long total_pages_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
+	unsigned long folio_in_index = 0;
+	unsigned long total_folios_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
 	unsigned long buf_start;
 	unsigned long total_out = 0;
 
@@ -565,7 +566,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
+	workspace->in_buf.src = kmap_local_folio(folios_in[folio_in_index], 0);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 
@@ -602,14 +603,15 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			kunmap_local(workspace->in_buf.src);
-			page_in_index++;
-			if (page_in_index >= total_pages_in) {
+			folio_in_index++;
+			if (folio_in_index >= total_folios_in) {
 				workspace->in_buf.src = NULL;
 				ret = -EIO;
 				goto done;
 			}
 			srclen -= PAGE_SIZE;
-			workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
+			workspace->in_buf.src =
+				kmap_local_folio(folios_in[folio_in_index], 0);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 		}
-- 
2.43.0


