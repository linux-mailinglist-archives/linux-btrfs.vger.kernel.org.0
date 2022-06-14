Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780454AEB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbiFNKr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbiFNKr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 06:47:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D42AC3;
        Tue, 14 Jun 2022 03:47:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so3666893wml.2;
        Tue, 14 Jun 2022 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KSwZmhrKnCN2gxS26DQIFCRWDQgSCBeYWLBnRWBMuA=;
        b=VmMQ4rebTlUKE0iOVD/8tCV2vAPw7Lfo8dUzd1IX1ULoRWlCxN8hn1qyb3cufpC+Vk
         p7FfceW2OMz+ma3KCCOBIiYypOwS9GMBSMRwQ8TNHsTov3nXxwjCPnlmIGUZLCRY0Nqg
         nDjQMfRPP92TUUHjNrnXAxrRTOt64i8mso8S8i7ImnIXB+UWehUdQVxiNbU/LYGn6UZw
         liB+zKEZUNVOvEXxsbiIjy8Y2oV8K0VNfnnY5KT+nqGrMs/8bEBrQLuJW7mA27/Yv406
         63Owh/YxIHEsdYgwR0pUImg5zS15mB5gmL5Xo+aTvV5j8zrXbh7D7eAv3QvdLRUmKumo
         Lh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5KSwZmhrKnCN2gxS26DQIFCRWDQgSCBeYWLBnRWBMuA=;
        b=thlesfEq41xG0LzAWmzjfkxXO8K4jJJq1gQH5gkIkZlFy8w1zyji5sqkNSuB7CmU9T
         Yjll+trLeNI9KBANarwc7xC8P1ngN4twS7CUaMYwjLK6ZW8RrKWFnmc37lpKetm8To0U
         Fp7r+7HD6nZih9EHU3yH4YIHFTJgciztkBmv9TDSfjMphxhG5l1D3bsWdEjY36aYf6eR
         PNqUJ0BnkN5MegqUbY4etrKWvbeTWPpNwpbVSKIHaR8eqvfzmq8DckIjJe4tlokmmCr4
         z1McMtqPzoqdRqnUqvIH9wYP6UY4eUUFSIjBZFWN5kKOQWlaimUq2ExUSEmQdkEYcpa6
         hmNw==
X-Gm-Message-State: AOAM532rQ5pgSYDuwKQISwduTFh5JSSonMab69j5rfYgJ8dX7ti+K5Xd
        fgU5SQBB4Vc7E5TdXmKFrsI=
X-Google-Smtp-Source: ABdhPJybdc1qySzdk6r0mnyppE7NbmLUaqumTHNFK054vG9ukuCFPM7Y1/SDa/3fVGDojsADkvjhDw==
X-Received: by 2002:a1c:4682:0:b0:39c:4459:6a84 with SMTP id t124-20020a1c4682000000b0039c44596a84mr3391098wma.167.1655203643428;
        Tue, 14 Jun 2022 03:47:23 -0700 (PDT)
Received: from localhost.localdomain (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id j20-20020adfa554000000b002100316b126sm11666256wrb.6.2022.06.14.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:47:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH] btrfs: Replace kmap() with kmap_local_page() in zlib.c
Date:   Tue, 14 Jun 2022 12:47:18 +0200
Message-Id: <20220614104718.9193-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The use of kmap() is being deprecated in favor of kmap_local_page(). With
kmap_local_page(), the mapping is per thread, CPU local and not globally
visible.

Therefore, use kmap_local_page() / kunmap_local() in zlib.c because in
this file the mappings are per thread and are not visible in other
contexts; meanwhile refactor zlib_compress_pages() to comply with nested
local mapping / unmapping ordering rules.

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled.

This is an RFC PATCH because it passes all tests of the "compress"
group, with the only two exceptions of tests/btrfs/138 (it freezes the
VM) and tests/btrfs/251 (it runs forever but doesn't freeze the VM).

Can anyone please take a look and tell me what I'm still overlooking
after days of code inspections?

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 75 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 767a0c6c9694..18f111bb2deb 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -97,8 +97,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
-	char *data_in;
-	char *cpage_out;
+	char *data_in = NULL;
+	char *cpage_out = NULL;
 	int nr_pages = 0;
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
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
@@ -196,9 +196,14 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
+			kunmap_local(data_in);
+			data_in = NULL;
+			put_page(in_page);
+
+			kunmap_local(cpage_out);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
+				cpage_out = NULL;
+				put_page(out_page);
 				ret = -E2BIG;
 				goto out;
 			}
@@ -207,7 +212,14 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
+
+			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
+			data_in = kmap_local_page(in_page);
+			workspace->strm.next_in = data_in;
+			workspace->strm.avail_in = min(bytes_left,
+						       (unsigned long)workspace->buf_size);
+
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -233,10 +245,15 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			ret = -EIO;
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
+			kunmap_local(data_in);
+			data_in = NULL;
+			put_page(in_page);
+
 			/* get another page for the stream end */
-			kunmap(out_page);
+			kunmap_local(cpage_out);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
+				cpage_out = NULL;
+				put_page(out_page);
 				ret = -E2BIG;
 				goto out;
 			}
@@ -245,7 +262,14 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = kmap_local_page(out_page);
+
+			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
+			data_in = kmap_local_page(in_page);
+			workspace->strm.next_in = data_in;
+			workspace->strm.avail_in = min(bytes_left,
+						       (unsigned long)workspace->buf_size);
+
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -264,13 +288,13 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
-
-	if (in_page) {
-		kunmap(in_page);
+	if (data_in) {
+		kunmap_local(data_in);
 		put_page(in_page);
 	}
+	if (cpage_out)
+		kunmap_local(cpage_out);
+
 	return ret;
 }
 
@@ -287,7 +311,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	struct page **pages_in = cb->compressed_pages;
 
-	data_in = kmap(pages_in[page_in_index]);
+	data_in = kmap_local_page(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
 	workspace->strm.total_in = 0;
@@ -309,7 +333,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
 		pr_warn("BTRFS: inflateInit failed\n");
-		kunmap(pages_in[page_in_index]);
+		kunmap_local(data_in);
 		return -EIO;
 	}
 	while (workspace->strm.total_in < srclen) {
@@ -336,13 +360,14 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
-			kunmap(pages_in[page_in_index]);
+
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
@@ -355,7 +380,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
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

