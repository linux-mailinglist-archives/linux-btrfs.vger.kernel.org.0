Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A63B7203
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhF2M0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 08:26:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhF2M0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 08:26:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CE23203E0;
        Tue, 29 Jun 2021 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624969415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rd+Oh8vKedzrQPmZd2WPxMdcluUGGfm2QDkprjhSvog=;
        b=Dvz0JgSb6ICUdhQFRICdYaGfIyQCxOgUfsSLqhQVudjm7GUQ90L+/wFak3jAoejDvoc9FP
        BzrsLjbH2KauS2UfpVvbnWxbuVP5VJyTl6BZzSmgRlQgFCGMD64ILowb3IKYZdErd4sbbk
        gaFi4e0HlXTiXu3Hcza4vNL0SnBJ/7U=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6695811906;
        Tue, 29 Jun 2021 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624969415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rd+Oh8vKedzrQPmZd2WPxMdcluUGGfm2QDkprjhSvog=;
        b=Dvz0JgSb6ICUdhQFRICdYaGfIyQCxOgUfsSLqhQVudjm7GUQ90L+/wFak3jAoejDvoc9FP
        BzrsLjbH2KauS2UfpVvbnWxbuVP5VJyTl6BZzSmgRlQgFCGMD64ILowb3IKYZdErd4sbbk
        gaFi4e0HlXTiXu3Hcza4vNL0SnBJ/7U=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id JEJiCMYQ22D2RQAALh3uQQ
        (envelope-from <wqu@suse.com>); Tue, 29 Jun 2021 12:23:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH RFC] btrfs: rework lzo_compress_pages() to make it subpage compatible
Date:   Tue, 29 Jun 2021 20:23:29 +0800
Message-Id: <20210629122329.314947-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several problems in lzo_compress_pages() preventing it from
being subpage compatible:

- No page offset is calculated when reading from inode pages
  For subpage case, we could have @start which is not aligned to
  PAGE_SIZE.

  Thus the destination where we read data from must take offset in page
  into consideration.

- The padding for segment header is bound to PAGE_SIZE
  This means, for subpage case we can skip several corners where on x86
  machines we need to add padding zeros.

The rework will:

- Update the comment to replace "page" with "sector"

- Introduce a new helper, copy_compressed_data_to_page(), to do the copy
  So that we don't need to bother page switches for both input and
  output.

  Now in lzo_compress_pages() we only care about page switching for
  input, while in copy_compressed_data_to_page() we only care the page
  switching for output.

- Only one main cursor
  For lzo_compress_pages() we use @cur_in as main curor.
  It will be the file offset we are currently at.

  All other helper variables will be only declared inside the loop.

  For copy_compressed_data_to_page() it's similar, we will have
  @cur_out at the main cursor, which records how many bytes are in the
  output.

- Get rid of kmap()/kunmap()
  Instead of using __GFP_HIGHMEM and needs to do kmap()/kunmap(), just
  get rid of that GFP flag, so we can use page_address() and never
  bother the kmap()/kunmap() thing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

The patch itself seems not only easier to read, but already passes
fstests -g compress with "-o compress=lzo" tests.

Haven't yet run the full test suits with "-o compress=lzo", but so far
so good.

So the main reason for RFC is, if the style is OK.

There are at least 4 functions need similar rework, and one of them
is in high priority as it affects subpage read path for compressed
data. (namely lzo_decompress_bio()).

While the lzo|zlib/zstd_compress_pages() functions are in low priority, as for
subpage write support we will only support range which is PAGE_SIZE
aligned, thus the existing functions can work without big problems.

Personally speaking I'm pretty happy with the refactor.

Even with my excessive comments style, we still reach net 0 for changed
lines.

Thus any feedback on the style if appreciated.
---
 fs/btrfs/lzo.c | 284 ++++++++++++++++++++++++-------------------------
 1 file changed, 142 insertions(+), 142 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index cd042c7567a4..18681153fea6 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -14,6 +14,7 @@
 #include <linux/lzo.h>
 #include <linux/refcount.h>
 #include "compression.h"
+#include "ctree.h"
 
 #define LZO_LEN	4
 
@@ -31,19 +32,19 @@
  *     payload.
  *     One regular LZO compressed extent can have one or more segments.
  *     For inlined LZO compressed extent, only one segment is allowed.
- *     One segment represents at most one page of uncompressed data.
+ *     One segment represents at most one sector of uncompressed data.
  *
  * 2.1 Segment header
  *     Fixed size. LZO_LEN (4) bytes long, LE32.
  *     Records the total size of the segment (not including the header).
- *     Segment header never crosses page boundary, thus it's possible to
- *     have at most 3 padding zeros at the end of the page.
+ *     Segment header never crosses sector boundary, thus it's possible to
+ *     have at most 3 padding zeros at the end of the sector.
  *
  * 2.2 Data Payload
- *     Variable size. Size up limit should be lzo1x_worst_compress(PAGE_SIZE)
- *     which is 4419 for a 4KiB page.
+ *     Variable size. Size up limit should be lzo1x_worst_compress(sectorsize)
+ *     which is 4419 for a 4KiB sectorsize.
  *
- * Example:
+ * Example with 4K sectorsize:
  * Page 1:
  *          0     0x2   0x4   0x6   0x8   0xa   0xc   0xe     0x10
  * 0x0000   |  Header   | SegHdr 01 | Data payload 01 ...     |
@@ -111,170 +112,169 @@ static inline size_t read_compress_length(const char *buf)
 	return le32_to_cpu(dlen);
 }
 
+/*
+ * Will do:
+ *
+ * - Write a segment header into the destination
+ * - Copy the compressed buffer into the destination
+ * - Make sure we have enough space in the last sector to fit a segment header
+ *   If not, we will pad at most (LZO_LEN (4)) - 1 bytes of zeros.
+ *
+ * Will allocate new pages when needed.
+ */
+static int copy_compressed_data_to_page(char *compressed_data,
+					size_t compressed_size,
+					struct page **out_pages,
+					u32 *cur_out,
+					const u32 sectorsize)
+{
+	u32 sector_bytes_left;
+	u32 orig_out;
+	struct page *cur_page;
+
+	/*
+	 * We never allow a segment header crossing sector boundary, previous
+	 * run should ensure we have enough space left inside the sector.
+	 */
+	ASSERT((*cur_out / sectorsize) ==
+	       (*cur_out + LZO_LEN - 1) / sectorsize);
+
+	cur_page = out_pages[*cur_out / PAGE_SIZE];
+	/* Allocate a new page */
+	if (!cur_page) {
+		cur_page = alloc_page(GFP_NOFS);
+		if (!cur_page)
+			return -ENOMEM;
+		out_pages[*cur_out / PAGE_SIZE] = cur_page;
+	}
+
+	write_compress_length(page_address(cur_page) + offset_in_page(*cur_out),
+			      compressed_size);
+
+	*cur_out += LZO_LEN;
+	orig_out = *cur_out;
+	/* *cur_out is increased, let the main loop to grab a proper page */
+	cur_page = NULL;
+
+	/* Copy compressed data */
+	while (*cur_out - orig_out < compressed_size) {
+		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
+				     orig_out + compressed_size - *cur_out);
+
+		/* Grab a page or allocate a new one */
+		if (!cur_page) {
+			cur_page = out_pages[*cur_out / PAGE_SIZE];
+			if (!cur_page) {
+				cur_page = alloc_page(GFP_NOFS);
+				if (!cur_page)
+					return -ENOMEM;
+				out_pages[*cur_out / PAGE_SIZE] = cur_page;
+			}
+		}
+
+		memcpy(page_address(cur_page) + offset_in_page(*cur_out),
+		       compressed_data + *cur_out - orig_out, copy_len);
+
+		*cur_out += copy_len;
+
+		/* If we reached page boudnary, go to next page */
+		if (IS_ALIGNED(*cur_out, PAGE_SIZE)) {
+			/* Let next iteration to grab a page */
+			cur_page = NULL;
+		}
+	}
+
+	/*
+	 * Check if we can fit the next segment header into the remaining space
+	 * of the sector.
+	 */
+	sector_bytes_left = round_up(*cur_out, sectorsize) - *cur_out;
+	if (sector_bytes_left >= LZO_LEN)
+		return 0;
+
+	/* The remaining size is not enough, pad it with zeros */
+	memset(page_address(cur_page) + offset_in_page(*cur_out), 0,
+	       sector_bytes_left);
+	*cur_out += sector_bytes_left;
+	return 0;
+}
+
 int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	const u32 sectorsize = btrfs_sb(mapping->host->i_sb)->sectorsize;
+	struct page *page_in = NULL;
 	int ret = 0;
-	char *data_in;
-	char *cpage_out, *sizes_ptr;
-	int nr_pages = 0;
-	struct page *in_page = NULL;
-	struct page *out_page = NULL;
-	unsigned long bytes_left;
-	unsigned long len = *total_out;
-	unsigned long nr_dest_pages = *out_pages;
-	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
-	size_t in_len;
-	size_t out_len;
-	char *buf;
-	unsigned long tot_in = 0;
-	unsigned long tot_out = 0;
-	unsigned long pg_bytes_left;
-	unsigned long out_offset;
-	unsigned long bytes;
+	u64 cur_in = start;	/* Points to the file offset of input data */
+	u32 cur_out = 0;	/* Points to the current output byte */
+	u32 len = *total_out;
 
 	*out_pages = 0;
 	*total_out = 0;
 	*total_in = 0;
 
-	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	data_in = kmap(in_page);
-
 	/*
-	 * store the size of all chunks of compressed data in
-	 * the first 4 bytes
+	 * Skip the header for now, we will later come back and write the total
+	 * compressed size
 	 */
-	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (out_page == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	cpage_out = kmap(out_page);
-	out_offset = LZO_LEN;
-	tot_out = LZO_LEN;
-	pages[0] = out_page;
-	nr_pages = 1;
-	pg_bytes_left = PAGE_SIZE - LZO_LEN;
-
-	/* compress at most one page of data each time */
-	in_len = min(len, PAGE_SIZE);
-	while (tot_in < len) {
-		ret = lzo1x_1_compress(data_in, in_len, workspace->cbuf,
-				       &out_len, workspace->mem);
-		if (ret != LZO_E_OK) {
-			pr_debug("BTRFS: lzo in loop returned %d\n",
-			       ret);
+	cur_out += LZO_LEN;
+	while (cur_in < start + len) {
+		u32 sector_off = (cur_in - start) % sectorsize;
+		u32 in_len;
+		size_t out_len;
+
+		/* Get the input page first */
+		if (!page_in) {
+			page_in = find_get_page(mapping, cur_in >> PAGE_SHIFT);
+			ASSERT(page_in);
+		}
+
+		/* Compress at most one sector of data each time */
+		in_len = min_t(u32, start + len - cur_in,
+			       sectorsize - sector_off);
+		ASSERT(in_len);
+		ret = lzo1x_1_compress(page_address(page_in) +
+				       offset_in_page(cur_in), in_len,
+				       workspace->cbuf, &out_len,
+				       workspace->mem);
+		if (ret < 0) {
+			pr_debug("BTRFS: lzo in loop returned %d\n", ret);
 			ret = -EIO;
 			goto out;
 		}
 
-		/* store the size of this chunk of compressed data */
-		write_compress_length(cpage_out + out_offset, out_len);
-		tot_out += LZO_LEN;
-		out_offset += LZO_LEN;
-		pg_bytes_left -= LZO_LEN;
-
-		tot_in += in_len;
-		tot_out += out_len;
-
-		/* copy bytes from the working buffer into the pages */
-		buf = workspace->cbuf;
-		while (out_len) {
-			bytes = min_t(unsigned long, pg_bytes_left, out_len);
-
-			memcpy(cpage_out + out_offset, buf, bytes);
-
-			out_len -= bytes;
-			pg_bytes_left -= bytes;
-			buf += bytes;
-			out_offset += bytes;
-
-			/*
-			 * we need another page for writing out.
-			 *
-			 * Note if there's less than 4 bytes left, we just
-			 * skip to a new page.
-			 */
-			if ((out_len == 0 && pg_bytes_left < LZO_LEN) ||
-			    pg_bytes_left == 0) {
-				if (pg_bytes_left) {
-					memset(cpage_out + out_offset, 0,
-					       pg_bytes_left);
-					tot_out += pg_bytes_left;
-				}
-
-				/* we're done, don't allocate new page */
-				if (out_len == 0 && tot_in >= len)
-					break;
-
-				kunmap(out_page);
-				if (nr_pages == nr_dest_pages) {
-					out_page = NULL;
-					ret = -E2BIG;
-					goto out;
-				}
-
-				out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-				if (out_page == NULL) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				cpage_out = kmap(out_page);
-				pages[nr_pages++] = out_page;
+		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
+						   pages, &cur_out, sectorsize);
+		if (ret < 0)
+			goto out;
 
-				pg_bytes_left = PAGE_SIZE;
-				out_offset = 0;
-			}
-		}
+		cur_in += in_len;
 
-		/* we're making it bigger, give up */
-		if (tot_in > 8192 && tot_in < tot_out) {
+		/*
+		 * Check if we're making it bigger after two sectors.
+		 * And if we're making it bigger, give up.
+		 */
+		if (cur_in - start > sectorsize * 2 &&
+		    cur_in - start < cur_out) {
 			ret = -E2BIG;
 			goto out;
 		}
 
-		/* we're all done */
-		if (tot_in >= len)
-			break;
-
-		if (tot_out > max_out)
-			break;
-
-		bytes_left = len - tot_in;
-		kunmap(in_page);
-		put_page(in_page);
-
-		start += PAGE_SIZE;
-		in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-		data_in = kmap(in_page);
-		in_len = min(bytes_left, PAGE_SIZE);
-	}
-
-	if (tot_out >= tot_in) {
-		ret = -E2BIG;
-		goto out;
+		/* Check if we have reached page boundary */
+		if (IS_ALIGNED(cur_in, PAGE_SIZE))
+			page_in = NULL;
 	}
 
-	/* store the size of all chunks of compressed data */
-	sizes_ptr = kmap_local_page(pages[0]);
-	write_compress_length(sizes_ptr, tot_out);
-	kunmap_local(sizes_ptr);
+	/* Store the size of all chunks of compressed data */
+	write_compress_length(page_address(pages[0]), cur_out);
 
 	ret = 0;
-	*total_out = tot_out;
-	*total_in = tot_in;
+	*total_out = cur_out;
+	*total_in = cur_in - start;
 out:
-	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
-
-	if (in_page) {
-		kunmap(in_page);
-		put_page(in_page);
-	}
-
+	*out_pages = DIV_ROUND_UP(cur_out, PAGE_SIZE);
 	return ret;
 }
 
-- 
2.32.0

