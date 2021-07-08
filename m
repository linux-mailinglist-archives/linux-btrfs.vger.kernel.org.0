Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA03BF94F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhGHLu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:50:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56154 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHLu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:50:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 07817201B9;
        Thu,  8 Jul 2021 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625744865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuZIpgcjeVdyAbYihWagPCKMFTwHdNfKCo25N63nV+Q=;
        b=BC99aEtPlufMEEojsD7se5TFXbxMOCGnok35OY0FsNt7ZhtsNpr79LVUYfDYmg283TU/pL
        gywiaZE9n3KIcID6EwcUYh7v/2C+pgc8pxkUjbWZPQhiFhfOHeiJmL/vT7Q3YUewlxDUdJ
        sGRLcFJ05SPOX4fsfr2ko3fA+nU8/PU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 01C0AA3B97;
        Thu,  8 Jul 2021 11:47:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E21FFDAF79; Thu,  8 Jul 2021 13:45:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] btrfs: compression: drop kmap/kunmap from lzo
Date:   Thu,  8 Jul 2021 13:45:10 +0200
Message-Id: <ca3a8e441f8438aed336917e74b871f021b760c7.1625043706.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625043706.git.dsterba@suse.com>
References: <cover.1625043706.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As we don't use highmem pages anymore, drop the kmap/kunmap. The kmap is
simply page_address and kunmap is a no-op.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/lzo.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 2bebb60c5830..576a0e6142ad 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -140,7 +140,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = 0;
 
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	data_in = kmap(in_page);
+	data_in = page_address(in_page);
 
 	/*
 	 * store the size of all chunks of compressed data in
@@ -151,7 +151,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = kmap(out_page);
+	cpage_out = page_address(out_page);
 	out_offset = LZO_LEN;
 	tot_out = LZO_LEN;
 	pages[0] = out_page;
@@ -209,7 +209,6 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 				if (out_len == 0 && tot_in >= len)
 					break;
 
-				kunmap(out_page);
 				if (nr_pages == nr_dest_pages) {
 					out_page = NULL;
 					ret = -E2BIG;
@@ -221,7 +220,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 					ret = -ENOMEM;
 					goto out;
 				}
-				cpage_out = kmap(out_page);
+				cpage_out = page_address(out_page);
 				pages[nr_pages++] = out_page;
 
 				pg_bytes_left = PAGE_SIZE;
@@ -243,12 +242,11 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 			break;
 
 		bytes_left = len - tot_in;
-		kunmap(in_page);
 		put_page(in_page);
 
 		start += PAGE_SIZE;
 		in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-		data_in = kmap(in_page);
+		data_in = page_address(in_page);
 		in_len = min(bytes_left, PAGE_SIZE);
 	}
 
@@ -258,22 +256,17 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	}
 
 	/* store the size of all chunks of compressed data */
-	sizes_ptr = kmap_local_page(pages[0]);
+	sizes_ptr = page_address(pages[0]);
 	write_compress_length(sizes_ptr, tot_out);
-	kunmap_local(sizes_ptr);
 
 	ret = 0;
 	*total_out = tot_out;
 	*total_in = tot_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
 
-	if (in_page) {
-		kunmap(in_page);
+	if (in_page)
 		put_page(in_page);
-	}
 
 	return ret;
 }
@@ -299,12 +292,11 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long tot_out;
 	unsigned long tot_len;
 	char *buf;
-	bool may_late_unmap, need_unmap;
 	struct page **pages_in = cb->compressed_pages;
 	u64 disk_start = cb->start;
 	struct bio *orig_bio = cb->orig_bio;
 
-	data_in = kmap(pages_in[0]);
+	data_in = page_address(pages_in[0]);
 	tot_len = read_compress_length(data_in);
 	/*
 	 * Compressed data header check.
@@ -345,13 +337,11 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		tot_in += in_len;
 		working_bytes = in_len;
-		may_late_unmap = need_unmap = false;
 
 		/* fast path: avoid using the working buffer */
 		if (in_page_bytes_left >= in_len) {
 			buf = data_in + in_offset;
 			bytes = in_len;
-			may_late_unmap = true;
 			goto cont;
 		}
 
@@ -381,12 +371,8 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 					goto done;
 				}
 
-				if (may_late_unmap)
-					need_unmap = true;
-				else
-					kunmap(pages_in[page_in_index]);
-
-				data_in = kmap(pages_in[++page_in_index]);
+				page_in_index++;
+				data_in = page_address(pages_in[page_in_index]);
 
 				in_page_bytes_left = PAGE_SIZE;
 				in_offset = 0;
@@ -396,8 +382,6 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		out_len = max_segment_len;
 		ret = lzo1x_decompress_safe(buf, in_len, workspace->buf,
 					    &out_len);
-		if (need_unmap)
-			kunmap(pages_in[page_in_index - 1]);
 		if (ret != LZO_E_OK) {
 			pr_warn("BTRFS: decompress failed\n");
 			ret = -EIO;
@@ -413,7 +397,6 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			break;
 	}
 done:
-	kunmap(pages_in[page_in_index]);
 	if (!ret)
 		zero_fill_bio(orig_bio);
 	return ret;
@@ -466,7 +449,7 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 	destlen = min_t(unsigned long, destlen, PAGE_SIZE);
 	bytes = min_t(unsigned long, destlen, out_len - start_byte);
 
-	kaddr = kmap_local_page(dest_page);
+	kaddr = page_address(dest_page);
 	memcpy(kaddr, workspace->buf + start_byte, bytes);
 
 	/*
@@ -476,7 +459,6 @@ int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 	 */
 	if (bytes < destlen)
 		memset(kaddr+bytes, 0, destlen-bytes);
-	kunmap_local(kaddr);
 out:
 	return ret;
 }
-- 
2.31.1

