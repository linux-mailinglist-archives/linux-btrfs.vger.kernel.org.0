Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFB552AAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbiFUGAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344211AbiFUGAJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:00:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C121E32
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:00:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 236421FA60;
        Tue, 21 Jun 2022 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655791206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ivjbXC2B0bYlZnsTv3zdMl2Io0UQD1FA5gRxMdqOBKs=;
        b=ezYtZ7hGmVRqQa5vwD/7yEoNRBqS46aXvFFNs58GI3gp4mUSik0qUsnKxf/ZF3D+ZELTxC
        Qh/7BhyFmPjuR+pWVKJe7EDoWNcYYQd9He8Sc3uG4yw8ifMMNYFWJdELhprtLGCouKc9WD
        jusc1aLcA0g7X9jmhRNzQmw7YyKt05A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0825A13A88;
        Tue, 21 Jun 2022 06:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZWHLMGResWK4PwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 21 Jun 2022 06:00:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] btrfs: zlib: refactor how we prepare the buffers
Date:   Tue, 21 Jun 2022 13:59:46 +0800
Message-Id: <aa6f4902ae200435d9da603dd092e91c4dfdf69e.1655791043.git.wqu@suse.com>
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
we prepare the input and output buffers.

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

- Input and output pages can be unmapped at different timing
  This make it almost impossible to convert the kmap() into
  kmap_local_page().

  As kmap_local_page() have strict requirement on the sequence of nested
  kmap:
                   OK              |            BAD
  ---------------------------------+---------------------------------
  in = kmap_local_page(in_page);   | in = kmap_local_page(in_page);
  out = kmap_local_page(out_page); | out = kmap_local_page(out_page);
  kunmap(out);                     | kunmap(in);
  kunmap(in);                      | kunmap(out);

[AFTER]
This patch will change the behavior by introducing 4 helpers (in two
pairs), to fulfill the requirement on the kmap_local_page():

- map_input_buffer() and unmap_input_buffer()

  For map_input_buffer(), there are 4 different combinations:

  * avail_in > 0 and use workspace->buf
    Do nothing, we can still use the existing @avail_in and @next_in.

  * avail_in > 0 and not use workspace->buf
    Use @total_in to grab the next page, and re-setup @avail_in and
    @next_in.
    (The common path)

  * avail_in == 0 and we have at most one page left
    Use @total_in to grab the next page, and re-setup @avail_in and
    @next_in.
    (The common path)

  * avail_in == 0 and we have multiple pages left (S390 optimization)
    Copy the pages into workspace->buf, and use workspace->buf.

  For unmap_input_buffer(), we just unset workspace->in_addr and
  workspace->in_page.

- map_output_buffer() and unmap_output_buffer()

  For output buffer, we always using single mapped page, so for
  map_output_buffer() it's just using @total_out to grab the page, and do
  page allocation if needed.

Then in zlib_compress_pages() we always map input buffer first, then map
output buffer, finally call zlib_deflate().

And after zlib_deflate() we immediately unmap output buffer, then unmap
input buffer.

By this, we at most nest once (both input and output are using mapped
page), and the nested order is always fixed.

Furthermore, we avoid extra memcpy() for non-S390 cases.

Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Still only tested on x86_64, although I'm already building a dedicated
VM for 32bit tests, it may take some time to build the environment.

This time, since S390 is having its own special handling, tests on
S390 would also be appreciated.

Changelog:
v2:
- To avoid unnecessary memcpy(), always map and unmap input/output
  buffer around zlib_deflate().

  This is to meet the requirement of kmap_local_page() and
  kunmap_local().
---
 fs/btrfs/zlib.c | 262 +++++++++++++++++++++++++++++-------------------
 1 file changed, 160 insertions(+), 102 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 767a0c6c9694..c42b5b5e7535 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -19,16 +19,25 @@
 #include <linux/bio.h>
 #include <linux/refcount.h>
 #include "compression.h"
+/* For ASSERT(). */
+#include "ctree.h"
 
 /* workspace buffer size for s390 zlib hardware support */
 #define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
 
 struct workspace {
 	z_stream strm;
+
+	struct page *in_page;
+	struct page *out_page;
+	void *in_addr;
+	void *out_addr;
+
 	char *buf;
 	unsigned int buf_size;
 	struct list_head list;
 	int level;
+	bool using_buf;
 };
 
 static struct workspace_manager wsm;
@@ -91,20 +100,140 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 	return ERR_PTR(-ENOMEM);
 }
 
+/* Either map a page (non-S390 path), or prepare workspace->buf (S390). */
+static void map_input_buffer(struct workspace *workspace,
+			     struct address_space *mapping,
+			     unsigned long total_in,
+			     u64 orig_file_offset)
+{
+	const unsigned long bytes_left = total_in - workspace->strm.total_in;
+	const unsigned int in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
+					      workspace->buf_size / PAGE_SIZE);
+	struct page *in_page;
+	u64 file_offset = orig_file_offset + workspace->strm.total_in;
+
+	/*
+	 * We still have some bytes left in the input, rebuild the original
+	 * input context.
+	 */
+	if (workspace->strm.avail_in > 0) {
+		/*
+		 * We're using the S390 specific input buffer space, just do
+		 * basic sanity check and exit.
+		 */
+		if (workspace->using_buf) {
+			ASSERT(workspace->strm.next_in -
+			       (unsigned char *)workspace->buf <
+			       workspace->buf_size);
+			return;
+		}
+
+		/*
+		 * Other wise, we need to map the page, and set @next_in
+		 * into the mapped page address.
+		 * The common path can handle such case without problem.
+		 */
+		goto common;
+	}
+
+	/* Re-fill the input buffer for S390 path. */
+	if (in_buf_pages > 1) {
+		int i;
+
+		workspace->using_buf = true;
+
+		for (i = 0; i < in_buf_pages; i++) {
+			in_page = find_get_page(mapping,
+					(file_offset >> PAGE_SHIFT) + i);
+			memcpy_from_page(workspace->buf, in_page, 0, PAGE_SIZE);
+			put_page(in_page);
+		}
+		workspace->strm.next_in = workspace->buf;
+		workspace->strm.avail_in = min_t(unsigned long, bytes_left,
+						 workspace->buf_size);
+		return;
+	}
+
+common:
+	/*
+	 * The common case for non-S390 cases to map and set @next_in
+	 * and @next_avail.
+	 */
+	workspace->using_buf = false;
+
+	in_page = find_get_page(mapping, file_offset >> PAGE_SHIFT);
+	ASSERT(in_page);
+
+	/* Page unmap and put will happen in unmap_input_buffer(). */
+	workspace->in_page = in_page;
+	workspace->in_addr = kmap_local_page(in_page);
+	workspace->strm.next_in = workspace->in_addr +
+				  offset_in_page(file_offset);
+	workspace->strm.avail_in = min_t(unsigned long, bytes_left,
+					 workspace->buf_size);
+}
+
+static void unmap_input_buffer(struct workspace *workspace)
+{
+	/* If we're using buffer, no need to do anything. */
+	if (workspace->using_buf) {
+		ASSERT(workspace->in_addr == NULL &&
+		       workspace->in_page == NULL);
+		return;
+	}
+	/* Otherwise, just unmap @in_addr and put @in_page. */
+	ASSERT(workspace->in_addr && workspace->in_page);
+	kunmap_local(workspace->in_addr);
+	put_page(workspace->in_page);
+	workspace->in_addr = NULL;
+	workspace->in_page = NULL;
+}
+
+static int map_output_buffer(struct workspace *workspace,
+			     struct page **out_pages, int *nr_pages,
+			     int max_nr_pages)
+{
+	/* Our total output is already reaching the max amount of pages. */
+	if (workspace->strm.total_out >> PAGE_SHIFT >= max_nr_pages)
+		return -E2BIG;
+
+	/* Allocate a new out page for the array. */
+	if (workspace->strm.total_out >> PAGE_SHIFT >= *nr_pages) {
+		ASSERT(workspace->strm.total_out >> PAGE_SHIFT == *nr_pages);
+		out_pages[*nr_pages] = alloc_page(GFP_NOFS);
+		if (out_pages[*nr_pages] == NULL)
+			return -ENOMEM;
+		(*nr_pages)++;
+	}
+
+	/* Setup @next_out and @avail_out using the page. */
+	workspace->out_page = out_pages[workspace->strm.total_out >> PAGE_SHIFT];
+	workspace->out_addr = kmap_local_page(workspace->out_page);
+	workspace->strm.next_out = workspace->out_addr +
+				   offset_in_page(workspace->strm.total_out);
+	workspace->strm.avail_out = PAGE_SIZE -
+				    offset_in_page(workspace->strm.total_out);
+	/* Page unmap will happen at unmap_output_buffer(). */
+	return 0;
+}
+
+static void unmap_output_buffer(struct workspace *workspace)
+{
+	if (workspace->out_addr)
+		kunmap_local(workspace->out_addr);
+	/* Unlike input buffer, we just unmap the page, without putting it. */
+	workspace->out_addr = NULL;
+	workspace->out_page = NULL;
+}
+
 int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
-	char *data_in;
-	char *cpage_out;
 	int nr_pages = 0;
-	struct page *in_page = NULL;
-	struct page *out_page = NULL;
-	unsigned long bytes_left;
-	unsigned int in_buf_pages;
-	unsigned long len = *total_out;
+	const unsigned long len = *total_out;
 	unsigned long nr_dest_pages = *out_pages;
 	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
 
@@ -121,59 +250,23 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_page = alloc_page(GFP_NOFS);
-	if (out_page == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	cpage_out = kmap(out_page);
-	pages[0] = out_page;
-	nr_pages = 1;
-
-	workspace->strm.next_in = workspace->buf;
+	workspace->strm.next_in = NULL;
 	workspace->strm.avail_in = 0;
-	workspace->strm.next_out = cpage_out;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.next_out = NULL;
+	workspace->strm.avail_out = 0;
+	workspace->using_buf = false;
 
 	while (workspace->strm.total_in < len) {
 		/*
-		 * Get next input pages and copy the contents to
-		 * the workspace buffer if required.
+		 * Always map the input before output, this is required by the
+		 * nested kmap_local_page().
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
+		map_input_buffer(workspace, mapping, len, start);
+
+		ret = map_output_buffer(workspace, pages, &nr_pages,
+					nr_dest_pages);
+		if (ret < 0)
+			goto out;
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (ret != Z_OK) {
@@ -184,6 +277,10 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 
+		/* Always unmap the output before input. */
+		unmap_output_buffer(workspace);
+		unmap_input_buffer(workspace);
+
 		/* we're making it bigger, give up */
 		if (workspace->strm.total_in > 8192 &&
 		    workspace->strm.total_in <
@@ -191,28 +288,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 			ret = -E2BIG;
 			goto out;
 		}
-		/* we need another page for writing out.  Test this
-		 * before the total_in so we will pull in a new page for
-		 * the stream end if required
-		 */
-		if (workspace->strm.avail_out == 0) {
-			kunmap(out_page);
-			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
-				ret = -E2BIG;
-				goto out;
-			}
-			out_page = alloc_page(GFP_NOFS);
-			if (out_page == NULL) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			cpage_out = kmap(out_page);
-			pages[nr_pages] = out_page;
-			nr_pages++;
-			workspace->strm.avail_out = PAGE_SIZE;
-			workspace->strm.next_out = cpage_out;
-		}
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
 			break;
@@ -225,31 +300,21 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	 * space but no more input data, until it returns with Z_STREAM_END.
 	 */
 	while (ret != Z_STREAM_END) {
+		ret = map_output_buffer(workspace, pages, &nr_pages,
+					nr_dest_pages);
+		if (ret < 0)
+			goto out;
+
 		ret = zlib_deflate(&workspace->strm, Z_FINISH);
+
+		unmap_output_buffer(workspace);
+
 		if (ret == Z_STREAM_END)
 			break;
 		if (ret != Z_OK && ret != Z_BUF_ERROR) {
 			zlib_deflateEnd(&workspace->strm);
 			ret = -EIO;
 			goto out;
-		} else if (workspace->strm.avail_out == 0) {
-			/* get another page for the stream end */
-			kunmap(out_page);
-			if (nr_pages == nr_dest_pages) {
-				out_page = NULL;
-				ret = -E2BIG;
-				goto out;
-			}
-			out_page = alloc_page(GFP_NOFS);
-			if (out_page == NULL) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			cpage_out = kmap(out_page);
-			pages[nr_pages] = out_page;
-			nr_pages++;
-			workspace->strm.avail_out = PAGE_SIZE;
-			workspace->strm.next_out = cpage_out;
 		}
 	}
 	zlib_deflateEnd(&workspace->strm);
@@ -264,13 +329,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	*total_in = workspace->strm.total_in;
 out:
 	*out_pages = nr_pages;
-	if (out_page)
-		kunmap(out_page);
-
-	if (in_page) {
-		kunmap(in_page);
-		put_page(in_page);
-	}
 	return ret;
 }
 
-- 
2.36.1

