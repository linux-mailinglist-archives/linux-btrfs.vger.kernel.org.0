Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3B539369
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbiEaOx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbiEaOx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 10:53:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465D111C1F;
        Tue, 31 May 2022 07:53:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so17904494edc.2;
        Tue, 31 May 2022 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6u/QxJKnZwln1iYjcv77c4i6gpgKvaB0L7K36sjt+A=;
        b=mMcGj/AIwwkZJ7/nVvrbkwzeWCyJrkU1xtJ1sSHt9NaW3pDdB54bycfU/H27R49bmX
         ZuLqdy0pmU9JUf0nh5h7Py62Fr7y2Jqd4NFAgK/7+FyIRtgvw9aQccqlzX4EQM9UcrpU
         fiyg4XCnTokY6DWtvuT4MRps/a91kvbfxcxph96qPhOUcpVxUKagEpqoFuj86nJqNgXC
         iLxq6Gbq9u53us1iiEBx0b3rSBjN4wPold9sQmKfOBRImR39z4PF8TO9W9FuRpkCP4rE
         msCsNJ9zq3FOeYYOdu8U1gQEPrttuxz9l2vqQZFHZ252jjsFuSsoKGlH6m/tkLlRFd7z
         l5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6u/QxJKnZwln1iYjcv77c4i6gpgKvaB0L7K36sjt+A=;
        b=BDef35pBomQ6pSiNYZekUiMGqlGCeD5GQtjiCHXtajOE3oum8TByYO19cQF0KuhlwR
         SmusiT3NyvTDdQFmrGVSGnxfekkaP3KseJ/rK6QQ8QB8D5CRBXtjuudEl0jAPiDtRHBm
         SJiXl5fcRA1mS7onksWZ3w2SBxv9cWOSQUzXglhmSD6h/NUuppZq4otZpAbZRg5Ehk3s
         rJ6OOBZ7/jPvFn02ORKr7xAC9kATeb67erZ0pkjF+6gx7qVG2KRa5MjMLdC2V/PahLrz
         rQhNPg7aSHqI4NADOK8qNZJn5j8dtA4Dh3+5SAbr9P+w8ag++Pw6M2p+DELcm0OF0j/l
         TXAg==
X-Gm-Message-State: AOAM5330+8gIWpYyy8Td8PgQ/1vFzPLyOI15iWMciAOXjaozZXm1KdkL
        IUW9U9o32R2hzADIAjqvn+uOrS212jA=
X-Google-Smtp-Source: ABdhPJys/H55/zOpGzAjyyuqldSEQIowZHeS9IPSdsSVWMguLYQYJiYjZCXFdODP8JumzjP9U53t2Q==
X-Received: by 2002:a05:6402:3046:b0:42b:505a:4f26 with SMTP id bs6-20020a056402304600b0042b505a4f26mr50652108edb.183.1654008833809;
        Tue, 31 May 2022 07:53:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-55-12-155.retail.telecomitalia.it. [79.55.12.155])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090603c200b006fea59ef3a5sm5099779eja.32.2022.05.31.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 07:53:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 3/3] btrfs: Replace kmap() with kmap_local_page() in zlib.c
Date:   Tue, 31 May 2022 16:53:35 +0200
Message-Id: <20220531145335.13954-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531145335.13954-1-fmdefrancesco@gmail.com>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page() where
it is feasible. With kmap_local_page(), the mapping is per thread, CPU
local and not globally visible.

Therefore, use kmap_local_page() / kunmap_local() in zlib.c wherever the
mappings are per thread and not globally visible.

Tested on QEMU + KVM 32 bits VM with 4GB of RAM and HIGHMEM64G enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 767a0c6c9694..7c10e78bd3d4 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = kmap(out_page);
+	cpage_out = kmap_local_page(out_page);
 	pages[0] = out_page;
 	nr_pages = 1;
 
@@ -148,26 +148,26 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				int i;
 
 				for (i = 0; i < in_buf_pages; i++) {
-					if (in_page) {
-						kunmap(in_page);
+					if (data_in) {
+						kunmap_local(data_in);
 						put_page(in_page);
 					}
 					in_page = find_get_page(mapping,
 								start >> PAGE_SHIFT);
-					data_in = kmap(in_page);
+					data_in = kmap_local_page(in_page);
 					memcpy(workspace->buf + i * PAGE_SIZE,
 					       data_in, PAGE_SIZE);
 					start += PAGE_SIZE;
 				}
 				workspace->strm.next_in = workspace->buf;
 			} else {
-				if (in_page) {
-					kunmap(in_page);
+				if (data_in) {
+					kunmap_local(data_in);
 					put_page(in_page);
 				}
 				in_page = find_get_page(mapping,
 							start >> PAGE_SHIFT);
-				data_in = kmap(in_page);
+				data_in = kmap_local_page(in_page);
 				start += PAGE_SIZE;
 				workspace->strm.next_in = data_in;
 			}
@@ -196,7 +196,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
+			kunmap_local(cpage_out);
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -207,7 +207,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -234,7 +234,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* get another page for the stream end */
-			kunmap(out_page);
+			kunmap_local(cpage_out);
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
 				ret = -E2BIG;
@@ -245,7 +245,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -264,11 +264,11 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
+	if (cpage_out)
+		kunmap_local(cpage_out);
 
-	if (in_page) {
-		kunmap(in_page);
+	if (data_in) {
+		kunmap_local(data_in);
 		put_page(in_page);
 	}
 	return ret;
@@ -287,7 +287,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	struct page **pages_in = cb->compressed_pages;
 
-	data_in = kmap(pages_in[page_in_index]);
+	data_in = kmap_local_page(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
 	workspace->strm.total_in = 0;
@@ -309,7 +309,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
 		pr_warn("BTRFS: inflateInit failed\n");
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 		return -EIO;
 	}
 	while (workspace->strm.total_in < srclen) {
@@ -336,13 +336,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
-			kunmap(pages_in[page_in_index]);
+			kunmap_local(data_in);
 			page_in_index++;
 			if (page_in_index >= total_pages_in) {
 				data_in = NULL;
 				break;
 			}
-			data_in = kmap(pages_in[page_in_index]);
+			data_in = kmap_local_page(pages_in[page_in_index]);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
 			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
@@ -355,7 +355,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 done:
 	zlib_inflateEnd(&workspace->strm);
 	if (data_in)
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 	if (!ret)
 		zero_fill_bio(cb->orig_bio);
 	return ret;
-- 
2.36.1

