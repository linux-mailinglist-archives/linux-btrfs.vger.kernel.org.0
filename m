Return-Path: <linux-btrfs+bounces-140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9C7EC957
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C4A1C20481
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3D41AAC;
	Wed, 15 Nov 2023 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPgmvFpa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7632E64F
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 17:06:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6FF18E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 09:06:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id A026722921;
	Wed, 15 Nov 2023 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700068004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zApb398IszGJ1OCoNZ3vwvyD5mZ2Oz73uAqDtSXi6kk=;
	b=ZPgmvFpaOfTWSiPIC8GrtSmWBTk+XNzfKPT/oYPAdw3Ghzyt9mvT9kSPvLhadeD4ZZGiza
	f8ILA/3sCSLKkqFngffsvsdpV/DDN5ToyFgYxz6JYiZ5Rid/zy+gS4rhqZIbe+TUyngYkB
	p81iRPkDi7HhHB7x+pLlZyamdEl6Uzk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 839112C2D3;
	Wed, 15 Nov 2023 17:06:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id C3223DA86C; Wed, 15 Nov 2023 17:59:39 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: use page alloc/free wrapeprs for compression pages
Date: Wed, 15 Nov 2023 17:59:39 +0100
Message-ID: <9f861f8b25f74779dacf17c862b947efd59634a9.1700067287.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700067287.git.dsterba@suse.com>
References: <cover.1700067287.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.50 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 MIME_TRACE(0.00)[0:+];
	 R_DKIM_NA(2.20)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.50
X-Rspamd-Queue-Id: A026722921
X-Spam: Yes

This is a preparation for managing compression pages in a cache-like
manner, instead of asking the allocator each time. The common allocation
and free wrappers are introduced and are functionally equivalent to the
current code.

The freeing helpers need to be carefully placed where the last reference
is dropped.  This is either after directly allocating (error handling)
or when there are no other users of the pages (after copying the contents).

It's safe to not use the helper and use put_page() that will handle the
reference count. Not using the helper means there's lower number of
pages that could be reused without passing them back to allocator.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 16 +++++++++++++++-
 fs/btrfs/compression.h |  5 +++++
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/lzo.c         |  4 ++--
 fs/btrfs/zlib.c        |  6 +++---
 fs/btrfs/zstd.c        |  7 +++----
 6 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 19b22b4653c8..1cd15d6a9c49 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -163,12 +163,26 @@ static int compression_decompress(int type, struct list_head *ws,
 static void btrfs_free_compressed_pages(struct compressed_bio *cb)
 {
 	for (unsigned int i = 0; i < cb->nr_pages; i++)
-		put_page(cb->compressed_pages[i]);
+		btrfs_free_compr_page(cb->compressed_pages[i]);
 	kfree(cb->compressed_pages);
 }
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
+/*
+ * Common wrappers for page allocation from compression wrappers
+ */
+struct page *btrfs_alloc_compr_page(void)
+{
+	return alloc_page(GFP_NOFS);
+}
+
+void btrfs_free_compr_page(struct page *page)
+{
+	ASSERT(page_ref_count(page) == 1);
+	put_page(page);
+}
+
 static void end_compressed_bio_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 03bb9d143fa7..93cc92974dee 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -32,6 +32,8 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 
 #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
 
+struct page;
+
 struct compressed_bio {
 	/* Number of compressed pages in the array */
 	unsigned int nr_pages;
@@ -96,6 +98,9 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
+struct page *btrfs_alloc_compr_page(void);
+void btrfs_free_compr_page(struct page *page);
+
 enum btrfs_compression_type {
 	BTRFS_COMPRESS_NONE  = 0,
 	BTRFS_COMPRESS_ZLIB  = 1,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9f5a9894f88f..82cb811a597f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1037,7 +1037,7 @@ static void compress_file_range(struct btrfs_work *work)
 	if (pages) {
 		for (i = 0; i < nr_pages; i++) {
 			WARN_ON(pages[i]->mapping);
-			put_page(pages[i]);
+			btrfs_free_compr_page(pages[i]);
 		}
 		kfree(pages);
 	}
@@ -1052,7 +1052,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 
 	for (i = 0; i < async_extent->nr_pages; i++) {
 		WARN_ON(async_extent->pages[i]->mapping);
-		put_page(async_extent->pages[i]);
+		btrfs_free_compr_page(async_extent->pages[i]);
 	}
 	kfree(async_extent->pages);
 	async_extent->nr_pages = 0;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index d3fcfc628a4f..1131d5a29d61 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -152,7 +152,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	cur_page = out_pages[*cur_out / PAGE_SIZE];
 	/* Allocate a new page */
 	if (!cur_page) {
-		cur_page = alloc_page(GFP_NOFS);
+		cur_page = btrfs_alloc_compr_page();
 		if (!cur_page)
 			return -ENOMEM;
 		out_pages[*cur_out / PAGE_SIZE] = cur_page;
@@ -178,7 +178,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		cur_page = out_pages[*cur_out / PAGE_SIZE];
 		/* Allocate a new page */
 		if (!cur_page) {
-			cur_page = alloc_page(GFP_NOFS);
+			cur_page = btrfs_alloc_compr_page();
 			if (!cur_page)
 				return -ENOMEM;
 			out_pages[*cur_out / PAGE_SIZE] = cur_page;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 6c231a116a29..36cf1f0e338e 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -121,7 +121,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_page = alloc_page(GFP_NOFS);
+	out_page = btrfs_alloc_compr_page();
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -200,7 +200,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = alloc_page(GFP_NOFS);
+			out_page = btrfs_alloc_compr_page();
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -236,7 +236,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = alloc_page(GFP_NOFS);
+			out_page = btrfs_alloc_compr_page();
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 5511766485cd..0d66db8bc1d4 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -410,9 +410,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
-
 	/* Allocate and map in the output buffer */
-	out_page = alloc_page(GFP_NOFS);
+	out_page = btrfs_alloc_compr_page();
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -457,7 +456,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = alloc_page(GFP_NOFS);
+			out_page = btrfs_alloc_compr_page();
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -514,7 +513,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			ret = -E2BIG;
 			goto out;
 		}
-		out_page = alloc_page(GFP_NOFS);
+		out_page = btrfs_alloc_compr_page();
 		if (out_page == NULL) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.42.1


