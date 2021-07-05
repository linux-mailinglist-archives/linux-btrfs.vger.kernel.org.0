Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE23BB502
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 04:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGECDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 22:03:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGECDy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Jul 2021 22:03:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62F2D2210E
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625450477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjK2pVU+MoQjJBkV18QBL2sYQ/fqbAPU/RRIhaTwsbU=;
        b=ahX44VzKI+wEkwOhfiOZKFLrZPOMDZoD6Bz1v+60nIeAqBbS20NO3lgPBVbgPv4tIgMunl
        JZEvW5ZJt2y0xmiB0xYQ63Q6T/zixRSEaK90L3dvLOmuFZK96292d5f+NptVJyYU1c32C6
        PsDq7cNm8LaNZSOl1eRIUSQMelOcahQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9426813522
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uDV1Fexn4mAVSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 02:01:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 03/15] btrfs: rework btrfs_decompress_buf2page()
Date:   Mon,  5 Jul 2021 10:00:58 +0800
Message-Id: <20210705020110.89358-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705020110.89358-1-wqu@suse.com>
References: <20210705020110.89358-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several bugs inside the function btrfs_decompress_buf2page()

- @start_byte doesn't take bvec.bv_offset into consideration
  Thus it can't handle case where the target range is not page aligned.

- Too many helper variables
  There are tons of helper variables, @buf_offset, @current_buf_start,
  @start_byte, @prev_start_byte, @working_bytes, @bytes.
  This hurts anyone who wants to read the function.

- No obvious main cursor for the iteartion
  A new problem caused by previous problem.

- Comments for parameter list makes no sense
  Like @buf_start is the offset to @buf, or offset inside the full
  decompressed extent? (Spoiler alert, the later case)
  And @total_out acts more like @buf_start + @size_of_buf.

  The worst is @disk_start.
  The real meaning of it is the file offset of the full decompressed
  extent.

This patch will rework the whole function by:

- Add a proper comment with ASCII art to explain the parameter list

- Rework parameter list
  The old @buf_start is renamed to @decompressed, to show how many bytes
  are already decompressed inside the full decompressed extent.
  The old @total_out is replaced by @buf_len, which is the decompressed
  data size.
  For old @disk_start and @bio, just pass @compressed_bio in.

- Use single main cursor
  The main cursor will be @cur_file_offset, to show what's the current
  file offset.
  Other helper variables will be declared inside the main loop, and only
  minimal amount of helper variables:
  * offset_inside_decompressed_buf:	The only real helper
  * copy_start_file_offset:		File offset we start memcpy
  * bvec_file_offset:			File offset of current bvec

Even with all these extensive comments, the final function is still
smaller than the original function, which is definitely a win.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 140 +++++++++++++++++++----------------------
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/lzo.c         |   8 +--
 fs/btrfs/zlib.c        |  12 ++--
 fs/btrfs/zstd.c        |   6 +-
 5 files changed, 74 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8318e56b5ab4..af1b0f722e14 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1263,96 +1263,82 @@ void __cold btrfs_exit_compress(void)
 }
 
 /*
- * Copy uncompressed data from working buffer to pages.
+ * Copy decompressed data from working buffer to pages.
  *
- * buf_start is the byte offset we're of the start of our workspace buffer.
+ * @buf:		The decompressed data buffer
+ * @buf_len:		The decompressed data length
+ * @decompressed:	Number of bytes that is already decompressed inside the
+ * 			compressed extent
+ * @cb:			The compressed extent descriptor
+ * @orig_bio:		The original bio that the caller wants to read for
  *
- * total_out is the last byte of the buffer
+ * An easier to understand graph is like below:
+ *
+ * 		|<- orig_bio ->|     |<- orig_bio->|
+ * 	|<-------      full decompressed extent      ----->|
+ * 	|<-----------    @cb range   ---->|
+ * 	|			|<-- @buf_len -->|
+ * 	|<--- @decompressed --->|
+ *
+ * Note that, @cb can be a subpage of the full decompressed extent, but
+ * @cb->start always has the same as the orig_file_offset value of the full
+ * decompressed extent.
+ *
+ * When reading compressed extent, we have to read the full compressed extent,
+ * while @orig_bio may only want part of the range.
+ * Thus this function will ensure only data covered by @orig_bio will be copied
+ * to.
+ *
+ * Return 0 if we have copied all needed contents for @orig_bio.
+ * Return >0 if we need continue decompress.
  */
-int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
-			      unsigned long total_out, u64 disk_start,
-			      struct bio *bio)
+int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
+			      struct compressed_bio *cb, u32 decompressed)
 {
-	unsigned long buf_offset;
-	unsigned long current_buf_start;
-	unsigned long start_byte;
-	unsigned long prev_start_byte;
-	unsigned long working_bytes = total_out - buf_start;
-	unsigned long bytes;
-	struct bio_vec bvec = bio_iter_iovec(bio, bio->bi_iter);
-
-	/*
-	 * start byte is the first byte of the page we're currently
-	 * copying into relative to the start of the compressed data.
-	 */
-	start_byte = page_offset(bvec.bv_page) - disk_start;
-
-	/* we haven't yet hit data corresponding to this page */
-	if (total_out <= start_byte)
-		return 1;
+	struct bio *orig_bio = cb->orig_bio;
+	u32 cur_offset;	/* Offset inside the full decompressed extent */
 
-	/*
-	 * the start of the data we care about is offset into
-	 * the middle of our working buffer
-	 */
-	if (total_out > start_byte && buf_start < start_byte) {
-		buf_offset = start_byte - buf_start;
-		working_bytes -= buf_offset;
-	} else {
-		buf_offset = 0;
-	}
-	current_buf_start = buf_start;
+	cur_offset = decompressed;
+	/* The main loop to do the copy */
+	while (cur_offset < decompressed + buf_len) {
+		struct bio_vec bvec = bio_iter_iovec(orig_bio,
+						     orig_bio->bi_iter);
+		size_t copy_len;
+		u32 copy_start;
+		u32 bvec_offset; /* Offset inside the full decompressed extent */
 
-	/* copy bytes from the working buffer into the pages */
-	while (working_bytes > 0) {
-		bytes = min_t(unsigned long, bvec.bv_len,
-				PAGE_SIZE - (buf_offset % PAGE_SIZE));
-		bytes = min(bytes, working_bytes);
+		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
 
-		memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
-			       bytes);
-		flush_dcache_page(bvec.bv_page);
+		/*
+		 * cb->start may underflow, but minusing that value can still
+		 * give us correct offset inside the full decompressed extent.
+		 */
+		bvec_offset = page_offset(bvec.bv_page) + bvec.bv_offset
+			      - cb->start;
 
-		buf_offset += bytes;
-		working_bytes -= bytes;
-		current_buf_start += bytes;
+		/* Haven't reached the bvec range, exit */
+		if (decompressed + buf_len <= bvec_offset)
+			return 1;
 
-		/* check if we need to pick another page */
-		bio_advance(bio, bytes);
-		if (!bio->bi_iter.bi_size)
-			return 0;
-		bvec = bio_iter_iovec(bio, bio->bi_iter);
-		prev_start_byte = start_byte;
-		start_byte = page_offset(bvec.bv_page) - disk_start;
+		copy_start = max(cur_offset, bvec_offset);
+		copy_len = min(bvec_offset + bvec.bv_len,
+			       decompressed + buf_len) - copy_start;
+		ASSERT(copy_len);
 
 		/*
-		 * We need to make sure we're only adjusting
-		 * our offset into compression working buffer when
-		 * we're switching pages.  Otherwise we can incorrectly
-		 * keep copying when we were actually done.
+		 * Extra range check to ensure we didn't go beyond
+		 * @buf + @buf_len.
 		 */
-		if (start_byte != prev_start_byte) {
-			/*
-			 * make sure our new page is covered by this
-			 * working buffer
-			 */
-			if (total_out <= start_byte)
-				return 1;
-
-			/*
-			 * the next page in the biovec might not be adjacent
-			 * to the last page, but it might still be found
-			 * inside this working buffer. bump our offset pointer
-			 */
-			if (total_out > start_byte &&
-			    current_buf_start < start_byte) {
-				buf_offset = start_byte - buf_start;
-				working_bytes = total_out - start_byte;
-				current_buf_start = buf_start + buf_offset;
-			}
-		}
+		ASSERT(copy_start - decompressed < buf_len);
+		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
+			       buf + copy_start - decompressed, copy_len);
+		cur_offset += copy_len;
+
+		bio_advance(orig_bio, copy_len);
+		/* Finished the bio */
+		if (!orig_bio->bi_iter.bi_size)
+			return 0;
 	}
-
 	return 1;
 }
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index c359f20920d0..399be0b435bf 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -86,9 +86,8 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 			 unsigned long *total_out);
 int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
 		     unsigned long start_byte, size_t srclen, size_t destlen);
-int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
-			      unsigned long total_out, u64 disk_start,
-			      struct bio *bio);
+int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
+			      struct compressed_bio *cb, u32 decompressed);
 
 blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  unsigned int len, u64 disk_start,
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 2bebb60c5830..2dbbfd33e5a5 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -301,8 +301,6 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	char *buf;
 	bool may_late_unmap, need_unmap;
 	struct page **pages_in = cb->compressed_pages;
-	u64 disk_start = cb->start;
-	struct bio *orig_bio = cb->orig_bio;
 
 	data_in = kmap(pages_in[0]);
 	tot_len = read_compress_length(data_in);
@@ -407,15 +405,15 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		buf_start = tot_out;
 		tot_out += out_len;
 
-		ret2 = btrfs_decompress_buf2page(workspace->buf, buf_start,
-						 tot_out, disk_start, orig_bio);
+		ret2 = btrfs_decompress_buf2page(workspace->buf, out_len,
+						 cb, buf_start);
 		if (ret2 == 0)
 			break;
 	}
 done:
 	kunmap(pages_in[page_in_index]);
 	if (!ret)
-		zero_fill_bio(orig_bio);
+		zero_fill_bio(cb->orig_bio);
 	return ret;
 }
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 2c792bc5a987..767a0c6c9694 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -286,8 +286,6 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long total_pages_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
 	unsigned long buf_start;
 	struct page **pages_in = cb->compressed_pages;
-	u64 disk_start = cb->start;
-	struct bio *orig_bio = cb->orig_bio;
 
 	data_in = kmap(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
@@ -326,9 +324,8 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		if (buf_start == total_out)
 			break;
 
-		ret2 = btrfs_decompress_buf2page(workspace->buf, buf_start,
-						 total_out, disk_start,
-						 orig_bio);
+		ret2 = btrfs_decompress_buf2page(workspace->buf,
+				total_out - buf_start, cb, buf_start);
 		if (ret2 == 0) {
 			ret = 0;
 			goto done;
@@ -348,8 +345,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			data_in = kmap(pages_in[page_in_index]);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
-			workspace->strm.avail_in = min(tmp,
-							   PAGE_SIZE);
+			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
 		}
 	}
 	if (ret != Z_STREAM_END)
@@ -361,7 +357,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	if (data_in)
 		kunmap(pages_in[page_in_index]);
 	if (!ret)
-		zero_fill_bio(orig_bio);
+		zero_fill_bio(cb->orig_bio);
 	return ret;
 }
 
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 9451d2bb984e..f06b68040352 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -547,8 +547,6 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct page **pages_in = cb->compressed_pages;
-	u64 disk_start = cb->start;
-	struct bio *orig_bio = cb->orig_bio;
 	size_t srclen = cb->compressed_len;
 	ZSTD_DStream *stream;
 	int ret = 0;
@@ -589,7 +587,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		workspace->out_buf.pos = 0;
 
 		ret = btrfs_decompress_buf2page(workspace->out_buf.dst,
-				buf_start, total_out, disk_start, orig_bio);
+				total_out - buf_start, cb, buf_start);
 		if (ret == 0)
 			break;
 
@@ -614,7 +612,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 	}
 	ret = 0;
-	zero_fill_bio(orig_bio);
+	zero_fill_bio(cb->orig_bio);
 done:
 	if (workspace->in_buf.src)
 		kunmap(pages_in[page_in_index]);
-- 
2.32.0

