Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F655D080
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiF0QdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiF0QdM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 12:33:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA27BE09;
        Mon, 27 Jun 2022 09:33:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o9so13822726edt.12;
        Mon, 27 Jun 2022 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2w65OSNApZQLQgLQpOrKB8s1c2eNL3BVShzExZfFDk=;
        b=jDzt2v8Xe2Q+rwWN+i4MH2e+Yjs/XfRKDCV7jskNFAn8kv6GqIpc20LEv9s67FkL0R
         v9H8OB7HBC3F/lwkOfoW8f4qDee902jJ5jfNE6iqB/RhLKClIjl3TvbWKI8+6IsHV6wN
         LEOd7cuPBUo0VLdSVtpL525pUYIjDUXAC9BN64h6nGmaxfD5VA/+AuT3QgUOYMAN80VC
         kQ8Tu/5YdB8qsB0wmXEqVfbfluwEeWI5ablwl5+BcbpOyZc0zG1L1G2hzyUQUWhRcB62
         BFyfUn4i6Fcn0UhnCp7grb9G/MQcUwkkhc8Zsm8Sha/lbVlaLo7O5fEm6B80BS0U8KHQ
         wKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2w65OSNApZQLQgLQpOrKB8s1c2eNL3BVShzExZfFDk=;
        b=s20IZoU3XsDWce2nBqMLDYxaW9dMCaOU4F3AdTnI7owgOPX4QEZMrKmg9FYYyuHSlI
         hbAo3ZNkB/ekaRuEdqP5fq8PfC2dYQOiB00pvSnKccbxkDr0ZAv8gu/GuBQgcmM8ZiKu
         p++fyC4PZe2R/jSVEhnTwoRBRHIHlz3QexJTqCSvMH1fK4BzGMMxgAP3120vJuankytL
         4h45epgYLDAO/yRrhoCpdvyqK8Ab7HyLIXkSJtErULZ9STO35qqarXeyRgqnVpB/Zm09
         hFmtImlPLrzkehAKiPc5IaY9v6aZH+trAqq/brItQJWy7niYwP+yjp1+Ut3jZbhs3HKa
         +0sg==
X-Gm-Message-State: AJIora/U4oKQn+FyEkpflTiG6ziJ1ypQan+DXdt/MYA+9L+rzbhzDM1j
        O2mBaWb9GThjoH5rtAE9G6I=
X-Google-Smtp-Source: AGRyM1unj/Yl6cIkPWeMZywWU56xRUVKZkMkuZZrtj9U7r7PvuRovFP/TsD/t/DqpDNc4aS9bId2Cg==
X-Received: by 2002:a05:6402:1f02:b0:435:4a90:ec8e with SMTP id b2-20020a0564021f0200b004354a90ec8emr17610506edb.131.1656347589932;
        Mon, 27 Jun 2022 09:33:09 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id s8-20020a508dc8000000b00435c10b5daesm7774364edh.34.2022.06.27.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:33:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] btrfs: Convert zlib_compress_pages() to use kmap_local_page()
Date:   Mon, 27 Jun 2022 18:33:05 +0200
Message-Id: <20220627163305.24116-1-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() / kunmap_local() in zlib_compress_pages()
because in this function the mappings are per thread and are not visible
in other contexts. Furthermore, drop the mappings of "out_page" which is
allocated within zlib_compress_pages() with alloc_page(GFP_NOFS) and use
page_address() (thanks to David Sterba).

Tested with xfstests on a QEMU + KVM 32-bits VM with 4GB of RAM booting
a kernel with HIGHMEM64G enabled. This patch passes 26/26 tests of group
"compress".

Cc: Qu Wenruo <wqu@suse.com>
Suggested-by: David Sterba <dsterba@suse.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 770c4c6bbaef..b4f44662cda7 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -97,7 +97,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
-	char *data_in;
+	char *data_in = NULL;
 	char *cpage_out;
 	int nr_pages = 0;
 	struct page *in_page = NULL;
@@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
-	cpage_out = kmap(out_page);
+	cpage_out = page_address(out_page);
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
@@ -196,9 +196,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -207,7 +205,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = page_address(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -234,9 +232,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* get another page for the stream end */
-			kunmap(out_page);
 			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
 				ret = -E2BIG;
 				goto out;
 			}
@@ -245,7 +241,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
-			cpage_out = kmap(out_page);
+			cpage_out = page_address(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
@@ -264,13 +260,11 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
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
+
 	return ret;
 }
 
-- 
2.36.1

