Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0F3BF951
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhGHLuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:50:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59864 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHLuc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:50:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A4D3D21FB4;
        Thu,  8 Jul 2021 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625744869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mn4GWWciyxCseMAmMeagQn6te3ZPcFQyNEJHCv9uSN4=;
        b=JQbdR7uy5PpxnE43v9R2RNuAf/qu9zkMKbxWt/SHInp4RzFOQ8TCI37d7d4x3XIjS7Fhwl
        rnbl/JvUpmRmSdr44zl03sWKWzdkNOE28CsgP6aEYUjFQEarLPjPBIjXgCuLZ3dybxvGo5
        mZ/TDfV2LZsbV1AdrGxlmX+/aNg9pfk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C169A3B99;
        Thu,  8 Jul 2021 11:47:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88241DAF79; Thu,  8 Jul 2021 13:45:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] btrfs: compression: drop kmap/kunmap from zstd
Date:   Thu,  8 Jul 2021 13:45:15 +0200
Message-Id: <03b968b75931278a69228bac139580c55dcbf387.1625043706.git.dsterba@suse.com>
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
 fs/btrfs/zstd.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 9451d2bb984e..200ba08bfae6 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -399,7 +399,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 	/* map in the first page of input data */
 	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	workspace->in_buf.src = kmap(in_page);
+	workspace->in_buf.src = page_address(in_page);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
@@ -411,7 +411,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		goto out;
 	}
 	pages[nr_pages++] = out_page;
-	workspace->out_buf.dst = kmap(out_page);
+	workspace->out_buf.dst = page_address(out_page);
 	workspace->out_buf.pos = 0;
 	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 
@@ -446,7 +446,6 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
 			tot_out += PAGE_SIZE;
 			max_out -= PAGE_SIZE;
-			kunmap(out_page);
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -458,7 +457,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				goto out;
 			}
 			pages[nr_pages++] = out_page;
-			workspace->out_buf.dst = kmap(out_page);
+			workspace->out_buf.dst = page_address(out_page);
 			workspace->out_buf.pos = 0;
 			workspace->out_buf.size = min_t(size_t, max_out,
 							PAGE_SIZE);
@@ -473,13 +472,12 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* Check if we need more input */
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			tot_in += PAGE_SIZE;
-			kunmap(in_page);
 			put_page(in_page);
 
 			start += PAGE_SIZE;
 			len -= PAGE_SIZE;
 			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-			workspace->in_buf.src = kmap(in_page);
+			workspace->in_buf.src = page_address(in_page);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 		}
@@ -506,7 +504,6 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		tot_out += PAGE_SIZE;
 		max_out -= PAGE_SIZE;
-		kunmap(out_page);
 		if (nr_pages == nr_dest_pages) {
 			out_page = NULL;
 			ret = -E2BIG;
@@ -518,7 +515,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 		pages[nr_pages++] = out_page;
-		workspace->out_buf.dst = kmap(out_page);
+		workspace->out_buf.dst = page_address(out_page);
 		workspace->out_buf.pos = 0;
 		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
 	}
@@ -534,12 +531,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 out:
 	*out_pages = nr_pages;
 	/* Cleanup */
-	if (in_page) {
-		kunmap(in_page);
+	if (in_page)
 		put_page(in_page);
-	}
-	if (out_page)
-		kunmap(out_page);
 	return ret;
 }
 
@@ -565,7 +558,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap(pages_in[page_in_index]);
+	workspace->in_buf.src = page_address(pages_in[page_in_index]);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 
@@ -601,14 +594,14 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			break;
 
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
-			kunmap(pages_in[page_in_index++]);
+			page_in_index++;
 			if (page_in_index >= total_pages_in) {
 				workspace->in_buf.src = NULL;
 				ret = -EIO;
 				goto done;
 			}
 			srclen -= PAGE_SIZE;
-			workspace->in_buf.src = kmap(pages_in[page_in_index]);
+			workspace->in_buf.src = page_address(pages_in[page_in_index]);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
 		}
@@ -616,8 +609,6 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	ret = 0;
 	zero_fill_bio(orig_bio);
 done:
-	if (workspace->in_buf.src)
-		kunmap(pages_in[page_in_index]);
 	return ret;
 }
 
-- 
2.31.1

