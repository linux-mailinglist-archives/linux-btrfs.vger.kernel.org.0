Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536373D5331
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhGZFyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 01:54:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35614 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhGZFyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 01:54:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2561FE46
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627281319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XLRLRizTDiTrRlwYHyyyQgoWQpLX5UJ4puUcuPGib4=;
        b=DQTBjBHZfIVZkILN844qjmdYzbUAkxSOUdOF85xtZOZ+qb6tx7FEYh2QDL+q5YIKjsLqeW
        uzM3onzTqYjd+ZMSAbTYXR6+4Sgzworv3R3r5wdcLBkDvo7VYprUm/YqzgXhvTy7o9dYE3
        +cf9nx9k3EuKKyK5biPPJ7aZR6JU11w=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B52F41365C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8IYvHaZX/mCXBQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jul 2021 06:35:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v8 06/18] btrfs: rework lzo_decompress_bio() to make it subpage compatible
Date:   Mon, 26 Jul 2021 14:34:55 +0800
Message-Id: <20210726063507.160396-7-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726063507.160396-1-wqu@suse.com>
References: <20210726063507.160396-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the initial subpage support, although we won't support compressed
write, we still need to support compressed read.

But for lzo_decompress_bio() it has several problems:

- The abuse of PAGE_SIZE for boundary detection
  For subpage case, we should follow sectorsize to detect the padding
  zeros.
  Using PAGE_SIZE will cause subpage compress read to skip certain
  bytes, and causing read error.

- Too many helper variables
  There are half a dozen helper variables, which is only making things
  harder to read

This patch will rework lzo_decompress_bio() to make it work for subpage:

- Use sectorsize to do boundary check, while still use PAGE_SIZE for
  page switching
  This allows us to have the same on-disk format for 4K sectorsize fs,
  while take advantage of larger page size.

- Use two main cursor
  Only @cur_in and @cur_out is utilized as the main cursor.
  The helper variables will only be declared inside the loop, and only 2
  helper variables needed.

- Introduce a helper function to copy compressed segment payload
  Introduce a new helper, copy_compressed_segment(), to copy a
  compressed segment to workspace buffer.
  This function will handle the page switching.

Now the net result is, with all the excessive comments and new helper
function, the refactored code is still smaller, and easier to read.

For other decompression code, they have no special padding rule, thus no
need to bother for initial subpage support, but will be refactored to
the same style later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/lzo.c | 192 ++++++++++++++++++++++---------------------------
 1 file changed, 86 insertions(+), 106 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 6cab15e52cec..3ad10bb41723 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -14,6 +14,7 @@
 #include <linux/lzo.h>
 #include <linux/refcount.h>
 #include "compression.h"
+#include "ctree.h"
 
 #define LZO_LEN	4
 
@@ -271,130 +272,109 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	return ret;
 }
 
+/*
+ * Copy the compressed segment payload into @dest.
+ *
+ * For the payload there will be no padding, just need to do page switching.
+ */
+static void copy_compressed_segment(struct compressed_bio *cb,
+				    char *dest, u32 len, u32 *cur_in)
+{
+	u32 orig_in = *cur_in;
+
+	while (*cur_in < orig_in + len) {
+		struct page *cur_page;
+		u32 copy_len = min_t(u32, PAGE_SIZE - offset_in_page(*cur_in),
+					  orig_in + len - *cur_in);
+
+		ASSERT(copy_len);
+		cur_page = cb->compressed_pages[*cur_in / PAGE_SIZE];
+
+		memcpy(dest + *cur_in - orig_in,
+			page_address(cur_page) + offset_in_page(*cur_in),
+			copy_len);
+
+		*cur_in += copy_len;
+	}
+}
+
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	int ret = 0, ret2;
-	char *data_in;
-	unsigned long page_in_index = 0;
-	size_t srclen = cb->compressed_len;
-	unsigned long total_pages_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
-	unsigned long buf_start;
-	unsigned long buf_offset = 0;
-	unsigned long bytes;
-	unsigned long working_bytes;
-	size_t in_len;
-	size_t out_len;
-	const size_t max_segment_len = lzo1x_worst_compress(PAGE_SIZE);
-	unsigned long in_offset;
-	unsigned long in_page_bytes_left;
-	unsigned long tot_in;
-	unsigned long tot_out;
-	unsigned long tot_len;
-	char *buf;
-	struct page **pages_in = cb->compressed_pages;
+	const struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
+	int ret;
+	u32 len_in;		/* Compressed data length, can be unaligned */
+	u32 cur_in = 0;         /* Offset inside the compressed data */
+	u32 cur_out = 0;        /* Bytes decompressed so far */
+
+	len_in = read_compress_length(page_address(cb->compressed_pages[0]));
+	cur_in += LZO_LEN;
 
-	data_in = page_address(pages_in[0]);
-	tot_len = read_compress_length(data_in);
 	/*
-	 * Compressed data header check.
+	 * LZO header length check
 	 *
-	 * The real compressed size can't exceed the maximum extent length, and
-	 * all pages should be used (whole unused page with just the segment
-	 * header is not possible).  If this happens it means the compressed
-	 * extent is corrupted.
+	 * The total length should not exceed the maximum extent lenght,
+	 * and all sectors should be used.
+	 * If this happens, it means the compressed extent is corrupted.
 	 */
-	if (tot_len > min_t(size_t, BTRFS_MAX_COMPRESSED, srclen) ||
-	    tot_len < srclen - PAGE_SIZE) {
-		ret = -EUCLEAN;
-		goto done;
+	if (len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
+	    round_up(len_in, sectorsize) < cb->compressed_len) {
+		btrfs_err(fs_info,
+			"invalid lzo header, lzo len %u compressed len %u",
+			  len_in, cb->compressed_len);
+		return -EUCLEAN;
 	}
 
-	tot_in = LZO_LEN;
-	in_offset = LZO_LEN;
-	in_page_bytes_left = PAGE_SIZE - LZO_LEN;
-
-	tot_out = 0;
-
-	while (tot_in < tot_len) {
-		in_len = read_compress_length(data_in + in_offset);
-		in_page_bytes_left -= LZO_LEN;
-		in_offset += LZO_LEN;
-		tot_in += LZO_LEN;
+	/* Go through each lzo segment */
+	while (cur_in < len_in) {
+		struct page *cur_page;
+		u32 seg_len;	/* Length of the compressed segment */
+		u32 sector_bytes_left;
+		size_t out_len = lzo1x_worst_compress(sectorsize);
 
 		/*
-		 * Segment header check.
-		 *
-		 * The segment length must not exceed the maximum LZO
-		 * compression size, nor the total compressed size.
+		 * We should always have enough space for one segment header
+		 * inside current sector.
 		 */
-		if (in_len > max_segment_len || tot_in + in_len > tot_len) {
-			ret = -EUCLEAN;
-			goto done;
-		}
-
-		tot_in += in_len;
-		working_bytes = in_len;
-
-		/* fast path: avoid using the working buffer */
-		if (in_page_bytes_left >= in_len) {
-			buf = data_in + in_offset;
-			bytes = in_len;
-			goto cont;
-		}
-
-		/* copy bytes from the pages into the working buffer */
-		buf = workspace->cbuf;
-		buf_offset = 0;
-		while (working_bytes) {
-			bytes = min(working_bytes, in_page_bytes_left);
-
-			memcpy(buf + buf_offset, data_in + in_offset, bytes);
-			buf_offset += bytes;
-cont:
-			working_bytes -= bytes;
-			in_page_bytes_left -= bytes;
-			in_offset += bytes;
-
-			/* check if we need to pick another page */
-			if ((working_bytes == 0 && in_page_bytes_left < LZO_LEN)
-			    || in_page_bytes_left == 0) {
-				tot_in += in_page_bytes_left;
-
-				if (working_bytes == 0 && tot_in >= tot_len)
-					break;
-
-				if (page_in_index + 1 >= total_pages_in) {
-					ret = -EIO;
-					goto done;
-				}
-
-				page_in_index++;
-				data_in = page_address(pages_in[page_in_index]);
-
-				in_page_bytes_left = PAGE_SIZE;
-				in_offset = 0;
-			}
-		}
-
-		out_len = max_segment_len;
-		ret = lzo1x_decompress_safe(buf, in_len, workspace->buf,
-					    &out_len);
+		ASSERT(cur_in / sectorsize ==
+		       (cur_in + LZO_LEN - 1) / sectorsize);
+		cur_page = cb->compressed_pages[cur_in / PAGE_SIZE];
+		ASSERT(cur_page);
+		seg_len = read_compress_length(page_address(cur_page) +
+					       offset_in_page(cur_in));
+		cur_in += LZO_LEN;
+
+		/* Copy the compressed segment payload into workspace */
+		copy_compressed_segment(cb, workspace->cbuf, seg_len, &cur_in);
+
+		/* Decompress the data */
+		ret = lzo1x_decompress_safe(workspace->cbuf, seg_len,
+					    workspace->buf, &out_len);
 		if (ret != LZO_E_OK) {
-			pr_warn("BTRFS: decompress failed\n");
+			btrfs_err(fs_info, "failed to decompress");
 			ret = -EIO;
-			break;
+			goto out;
 		}
 
-		buf_start = tot_out;
-		tot_out += out_len;
+		/* Copy the data into inode pages */
+		ret = btrfs_decompress_buf2page(workspace->buf, out_len, cb, cur_out);
+		cur_out += out_len;
 
-		ret2 = btrfs_decompress_buf2page(workspace->buf, out_len,
-						 cb, buf_start);
-		if (ret2 == 0)
-			break;
+		/* All data read, exit */
+		if (ret == 0)
+			goto out;
+		ret = 0;
+
+		/* Check if the sector has enough space for a segment header */
+		sector_bytes_left = sectorsize - cur_in % sectorsize;
+		if (sector_bytes_left >= LZO_LEN)
+			continue;
+
+		/* Skip the padding zeros */
+		cur_in += sector_bytes_left;
 	}
-done:
+out:
 	if (!ret)
 		zero_fill_bio(cb->orig_bio);
 	return ret;
-- 
2.32.0

