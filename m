Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6493BF950
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGHLua (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:50:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56168 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHLu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:50:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 57B8E201B9;
        Thu,  8 Jul 2021 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625744867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YuhhVxDjjliTmSxp5/ZG7xIdavTEwN9lz5taKG/X/s=;
        b=pGSAuy30q1mu8WUDlqZCUyq5KsPZzPw609slARjxC0khKvccFABsvqs/TZmAZuQvLbgLyp
        eWPhscYVZ/R3LxuNbeS45INPHXOWl/Y/YTbJWkOPfmp34AwhtlDzSPX7DH3fO1EgBLEZVG
        C/f3bCHuwfSWKxpdhOzRZpUuCcTeivU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 516C82C1FE;
        Thu,  8 Jul 2021 11:47:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3D0C6DAF79; Thu,  8 Jul 2021 13:45:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: compression: drop kmap/kunmap from zlib
Date:   Thu,  8 Jul 2021 13:45:13 +0200
Message-Id: <ffd2c6236a5c3f0792b1711792efe01365a7ce0c.1625043706.git.dsterba@suse.com>
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
 fs/btrfs/zlib.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 2c792bc5a987..5e18d7ad75a4 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = kmap(out_page);
+	cpage_out = page_address(out_page);
 	pages[0] = out_page;
 	nr_pages = 1;
 
@@ -148,26 +148,22 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				int i;
 
 				for (i = 0; i < in_buf_pages; i++) {
-					if (in_page) {
-						kunmap(in_page);
+					if (in_page)
 						put_page(in_page);
-					}
 					in_page = find_get_page(mapping,
 								start >> PAGE_SHIFT);
-					data_in = kmap(in_page);
+					data_in = page_address(in_page);
 					memcpy(workspace->buf + i * PAGE_SIZE,
 					       data_in, PAGE_SIZE);
 					start += PAGE_SIZE;
 				}
 				workspace->strm.next_in = workspace->buf;
 			} else {
-				if (in_page) {
-					kunmap(in_page);
+				if (in_page)
 					put_page(in_page);
-				}
 				in_page = find_get_page(mapping,
 							start >> PAGE_SHIFT);
-				data_in = kmap(in_page);
+				data_in = page_address(in_page);
 				start += PAGE_SIZE;
 				workspace->strm.next_in = data_in;
 			}
@@ -196,7 +192,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -207,7 +202,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = page_address(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -234,7 +229,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* get another page for the stream end */
-			kunmap(out_page);
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -245,7 +239,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = page_address(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -264,13 +258,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
-
-	if (in_page) {
-		kunmap(in_page);
+	if (in_page)
 		put_page(in_page);
-	}
 	return ret;
 }
 
@@ -289,7 +278,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	u64 disk_start = cb->start;
 	struct bio *orig_bio = cb->orig_bio;
 
-	data_in = kmap(pages_in[page_in_index]);
+	data_in = page_address(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
 	workspace->strm.total_in = 0;
@@ -311,7 +300,6 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
 		pr_warn("BTRFS: inflateInit failed\n");
-		kunmap(pages_in[page_in_index]);
 		return -EIO;
 	}
 	while (workspace->strm.total_in < srclen) {
@@ -339,13 +327,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
-			kunmap(pages_in[page_in_index]);
+
 			page_in_index++;
 			if (page_in_index >= total_pages_in) {
 				data_in = NULL;
 				break;
 			}
-			data_in = kmap(pages_in[page_in_index]);
+			data_in = page_address(pages_in[page_in_index]);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
 			workspace->strm.avail_in = min(tmp,
@@ -358,8 +346,6 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		ret = 0;
 done:
 	zlib_inflateEnd(&workspace->strm);
-	if (data_in)
-		kunmap(pages_in[page_in_index]);
 	if (!ret)
 		zero_fill_bio(orig_bio);
 	return ret;
-- 
2.31.1

