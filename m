Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD88F54F732
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382265AbiFQMF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382214AbiFQMFz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:05:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678766B7CD;
        Fri, 17 Jun 2022 05:05:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id me5so8390094ejb.2;
        Fri, 17 Jun 2022 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=An4VqlbV85lFxIwTKixxFZWGiBTSsqtaMQNOxgii35g=;
        b=E8NhQjtf3V5xxVM/puZlkNVsq/WnHH46QoEAkyGYxPh9eRM+RpvMQgusQIS+tzBteG
         bQ+c3M0+UV0TAL/at3SeV5qcaezmv8wGdazzZ7cfd0G4ds+JZXhKMn3ay74Y1wcwZwyZ
         yruQrJAlgez1XgAbH9lCGzI9RkAG6xxKfBe4SPqRmllUbuAksKzw0JFzHmkGfVKkLhSB
         o2RXGs6Wd/+3ye+WVxQBhGtchWVzztMipZBQ8FE89s+tKzjW6s2dEJuOCloO71ce9wBp
         wbQqvzwNulaM5oiyV/yqzMoSoEzhtKx84UxfxVIqdxAyhltPydf9xDfUBJcQS5qeFFPe
         mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=An4VqlbV85lFxIwTKixxFZWGiBTSsqtaMQNOxgii35g=;
        b=KvV3SR6g5OdzT3DNLJN+Rjik9deL+eT0KixpFjGFknctQMAgfS2A08sXwWctxA3BA5
         wI6tHGs+Jnsot05eCWutO0iQteFryMQ9QKe/tHxtSoS9cRZAMyFG9ECkXUXpaSjiFY0P
         u2Zzf3RH6McI/jMZyX8YeURu4iUvalG+IlKvXIXtni6bJj8lpJukd5vPoRTkHqhq3Kof
         sv4Kyrt7vnDEwZlZ5fY7dEq0tCVjmaluIc4xlg7T5Wzhu6mYKxz9Dnw7WmG3wXhuzxjz
         Vm20ume+pWChDh/m2cx67tfUx1zzk/8TYK0b9FTkA6FqSRhgWV/zB8fYJkbdexBsl4o6
         yfPg==
X-Gm-Message-State: AJIora/1VHfxur/2VRhw74+DppHuzFnBu6dCMw3he6NDQ+uw79j0ddJB
        74nl3h328448iF05kMW6b9LU+DAxQHk=
X-Google-Smtp-Source: AGRyM1upGBjBu4f3AX1HjebEDy6OWQ9rPP1SDaYiCLaIq14AZU3ea98jPecg0S5wHVUeuxoQFeG8Rw==
X-Received: by 2002:a17:907:7245:b0:711:d1ff:2ca4 with SMTP id ds5-20020a170907724500b00711d1ff2ca4mr9092563ejc.753.1655467552905;
        Fri, 17 Jun 2022 05:05:52 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b007121361d54asm2135179ejc.25.2022.06.17.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:05:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in zlib_compress_pages()
Date:   Fri, 17 Jun 2022 14:05:38 +0200
Message-Id: <20220617120538.18091-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617120538.18091-1-fmdefrancesco@gmail.com>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com>
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

Therefore, use kmap_local_page() / kunmap_local() on "in_page" in
zlib_compress_pages() because in this function the mappings are per thread
and are not visible in other contexts.

Use an array based stack in order to take note of the order of mappings
and un-mappings to comply to the rules of nesting local mappings.

Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/zlib.c | 65 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index c7c69ce4a1a9..1f16014e8ff3 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -99,6 +99,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	int ret;
 	char *data_in = NULL;
 	char *cpage_out = NULL;
+	char mstack[2];
+	int sind = 0;
 	int nr_pages = 0;
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
@@ -126,6 +128,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		ret = -ENOMEM;
 		goto out;
 	}
+	mstack[sind] = 'A';
+	sind++;
 	cpage_out = kmap_local_page(out_page);
 	pages[0] = out_page;
 	nr_pages = 1;
@@ -148,26 +152,32 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				int i;
 
 				for (i = 0; i < in_buf_pages; i++) {
-					if (in_page) {
-						kunmap(in_page);
+					if (data_in) {
+						sind--;
+						kunmap_local(data_in);
 						put_page(in_page);
 					}
 					in_page = find_get_page(mapping,
 								start >> PAGE_SHIFT);
-					data_in = kmap(in_page);
+					mstack[sind] = 'B';
+					sind++;
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
+					sind--;
+					kunmap_local(data_in);
 					put_page(in_page);
 				}
 				in_page = find_get_page(mapping,
 							start >> PAGE_SHIFT);
-				data_in = kmap(in_page);
+				mstack[sind] = 'B';
+				sind++;
+				data_in = kmap_local_page(in_page);
 				start += PAGE_SIZE;
 				workspace->strm.next_in = data_in;
 			}
@@ -196,23 +206,39 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
+			sind--;
+			kunmap_local(data_in);
+			data_in = NULL;
+
+			sind--;
 			kunmap_local(cpage_out);
 			cpage_out = NULL;
+
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
+				put_page(in_page);
 				ret = -E2BIG;
 				goto out;
 			}
+
 			out_page = alloc_page(GFP_NOFS);
 			if (out_page == NULL) {
+				put_page(in_page);
 				ret = -ENOMEM;
 				goto out;
 			}
+
+			mstack[sind] = 'A';
+			sind++;
 			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
 			workspace->strm.next_out = cpage_out;
+
+			mstack[sind] = 'B';
+			sind++;
+			data_in = kmap_local_page(in_page);
 		}
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
@@ -235,10 +261,16 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* get another page for the stream end */
+			sind--;
+			kunmap_local(data_in);
+			data_in = NULL;
+
+			sind--;
 			kunmap_local(cpage_out);
 			cpage_out = NULL;
 			if (nr_pages == nr_dest_pages) {
 				out_page = NULL;
+				put_page(in_page);
 				ret = -E2BIG;
 				goto out;
 			}
@@ -247,11 +279,18 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -ENOMEM;
 				goto out;
 			}
+
+			mstack[sind] = 'A';
+			sind++;
 			cpage_out = kmap_local_page(out_page);
 			pages[nr_pages] = out_page;
 			nr_pages++;
 			workspace->strm.avail_out = PAGE_SIZE;
 			workspace->strm.next_out = cpage_out;
+
+			mstack[sind] = 'B';
+			sind++;
+			data_in = kmap_local_page(in_page);
 		}
 	}
 	zlib_deflateEnd(&workspace->strm);
@@ -266,13 +305,15 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (cpage_out)
-		kunmap_local(cpage_out);
-
-	if (in_page) {
-		kunmap(in_page);
-		put_page(in_page);
+	while (--sind >= 0) {
+		if (mstack[sind] == 'B') {
+			kunmap_local(data_in);
+			put_page(in_page);
+		} else {
+			kunmap_local(cpage_out);
+		}
 	}
+
 	return ret;
 }
 
-- 
2.36.1

