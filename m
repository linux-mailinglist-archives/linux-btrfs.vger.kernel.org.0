Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB055020F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 04:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiFRCjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 22:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFRCjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 22:39:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED45716D
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 19:39:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EE7E21C3C;
        Sat, 18 Jun 2022 02:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655519987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n2yz58J6OeOWJgqZ3rHE6KkurdjZI9TJc9r3o8cuQ70=;
        b=ZVtu8I6jQpcL56kUdHFyRC0S6JOSCPuBU50U4UP9wfARz1HBXIstoR1TGgq1O6w5jc2Rk1
        Hg4Jg8Rtfw/wkhyao7VNQFH8IHNXfE9OKwI6mTHXk7FTdQbZBmwLBfVLwJVybwL1JS1qSF
        LC/tkNCYZbD7zrGQqK7QtSDVNG2LPJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A1C81342C;
        Sat, 18 Jun 2022 02:39:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tvvDAPI6rWIIHgAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 18 Jun 2022 02:39:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] btrfs: zlib: refactor how we prepare the input buffer
Date:   Sat, 18 Jun 2022 10:39:28 +0800
Message-Id: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inspired by recent kmap() change from Fabio M. De Francesco.

There are some weird behavior in zlib_compress_pages(), mostly around how
we prepare the input buffer.

[BEFORE]
- We hold a page mapped for a long time
  This is making it much harder to convert kmap() to kmap_local_page(),
  as such long mapped page can lead to nested mapped page.

- Different paths in the name of "optimization"
  When we ran out of input buffer, we will grab the new input with two
  different paths:

  * If there are more than one pages left, we copy the content into the
    input buffer.
    This behavior is introduced mostly for S390, as that arch needs
    multiple pages as input buffer for hardware decompression.

  * If there is only one page left, we use that page from page cache
    directly without copying the content.

  This is making page map/unmap much harder, especially due the latter
  case.

[AFTER]
This patch will change the behavior by introducing a new helper, to
fulfill the input buffer:

- Only map one page when we do the content copy

- Unified path, by always copying the page content into workspace
  input buffer
  Yes, we're doing extra page copying. But the original optimization
  only work for the last page of the input range.

  Thus I'd say the sacrifice is already not that big.

- Use kmap_local_page() and kunmap_local() instead
  Now the lifespan for the mapped page is only during memcpy() call,
  we're definitely fine to use kmap_local_page()/kunmap_local().

Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Only tested on x86_64 for the correctness of the new helper.

But considering how small the window we need the page to be mapped, I
think it should also work for x86 without any problem.
---
 fs/btrfs/zlib.c | 85 ++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 767a0c6c9694..2cd4f6fb1537 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -91,20 +91,54 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
+/*
+ * Copy the content from page cache into @workspace->buf.
+ *
+ * @total_in:		The original total input length.
+ * @fileoff_ret:	The file offset.
+ *			Will be increased by the number of bytes we read.
+ */
+static void fill_input_buffer(struct workspace *workspace,
+			      struct address_space *mapping,
+			      unsigned long total_in, u64 *fileoff_ret)
+{
+	unsigned long bytes_left = total_in - workspace->strm.total_in;
+	const int input_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
+				    workspace->buf_size / PAGE_SIZE);
+	u64 file_offset = *fileoff_ret;
+	int i;
+
+	/* Copy the content of each page into the input buffer. */
+	for (i = 0; i < input_pages; i++) {
+		struct page *in_page;
+		void *addr;
+
+		in_page = find_get_page(mapping, file_offset >> PAGE_SHIFT);
+
+		addr = kmap_local_page(in_page);
+		memcpy(workspace->buf + i * PAGE_SIZE, addr, PAGE_SIZE);
+		kunmap_local(addr);
+
+		put_page(in_page);
+		file_offset += PAGE_SIZE;
+	}
+	*fileoff_ret = file_offset;
+	workspace->strm.next_in = workspace->buf;
+	workspace->strm.avail_in = min_t(unsigned long, bytes_left,
+					 workspace->buf_size);
+}
+
 int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	/* Total input length. */
+	const unsigned long len = *total_out;
 	int ret;
-	char *data_in;
 	char *cpage_out;
 	int nr_pages = 0;
-	struct page *in_page = NULL;
 	struct page *out_page = NULL;
-	unsigned long bytes_left;
-	unsigned int in_buf_pages;
-	unsigned long len = *total_out;
 	unsigned long nr_dest_pages = *out_pages;
 	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
 
@@ -140,40 +174,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		 * Get next input pages and copy the contents to
 		 * the workspace buffer if required.
 		 */
-		if (workspace->strm.avail_in == 0) {
-			bytes_left = len - workspace->strm.total_in;
-			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
-					   workspace->buf_size / PAGE_SIZE);
-			if (in_buf_pages > 1) {
-				int i;
-
-				for (i = 0; i < in_buf_pages; i++) {
-					if (in_page) {
-						kunmap(in_page);
-						put_page(in_page);
-					}
-					in_page = find_get_page(mapping,
-								start >> PAGE_SHIFT);
-					data_in = kmap(in_page);
-					memcpy(workspace->buf + i * PAGE_SIZE,
-					       data_in, PAGE_SIZE);
-					start += PAGE_SIZE;
-				}
-				workspace->strm.next_in = workspace->buf;
-			} else {
-				if (in_page) {
-					kunmap(in_page);
-					put_page(in_page);
-				}
-				in_page = find_get_page(mapping,
-							start >> PAGE_SHIFT);
-				data_in = kmap(in_page);
-				start += PAGE_SIZE;
-				workspace->strm.next_in = data_in;
-			}
-			workspace->strm.avail_in = min(bytes_left,
-						       (unsigned long) workspace->buf_size);
-		}
+		if (workspace->strm.avail_in == 0)
+			fill_input_buffer(workspace, mapping, len, &start);
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (ret != Z_OK) {
@@ -266,11 +268,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*out_pages = nr_pages;
 	if (out_page)
 		kunmap(out_page);
-
-	if (in_page) {
-		kunmap(in_page);
-		put_page(in_page);
-	}
 	return ret;
 }
 
-- 
2.36.1

