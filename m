Return-Path: <linux-btrfs+bounces-1888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C68401FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA28BB21349
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107955E57;
	Mon, 29 Jan 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F2JJ+qwV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lvflaDxx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347255777
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521596; cv=none; b=hljsAgch7Z38UjgliYlx2QOnKrPItW4ocV3ovxPpgeaawfOR1RqtIiAzYTV+lGReC87wCFXs6HPPE2G0/GNnbLTiguBxzq0tjYcZxbkEeLrl5hf72bRN9YABGGrkVRE9MqgzPu9artGeIZqU82mUNhCDbYOi9lk2S4hBg+zGyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521596; c=relaxed/simple;
	bh=Woc5nAF6KlZ352i08jQTfp8Jl4JbwoA1NQh6vucpXCA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajc0SzSIGIXAcSSG7N0llrtnvMfRCk4VDWDw//7BGQ1ejWbTe+d/8lE+zqCzp1+NusB1Wd4AUvranWXkWIIL120NKD/nk3bWxc0XmdLZ/T5eW2C1uOpYn4f7MLoDIHxJGqXNvl+z51qECOSJpI0qMZB4xp3CEkMc331yKDIcawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F2JJ+qwV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lvflaDxx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C48FF1F7D9
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9LSqrHVvtZsWW/x2Ts9UVHabs7Y5TPavQEPYOZJe1U=;
	b=F2JJ+qwVaKfqdw5NhMRvit1DHGLwDGBIG5n00DLqy+Y6rvc9+zE/wTvum9V/gSWJH6A8EL
	H5D9i87dPBvSbG3Y8M8ZiuCSPP4+C3PbZ/S2OYrX44eqnxRQibB5RF25HhTaXWprMI+7bI
	YiWByIDosDhW5uA+DPKprO5WRC8FvD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9LSqrHVvtZsWW/x2Ts9UVHabs7Y5TPavQEPYOZJe1U=;
	b=lvflaDxxStg2YtkwGhPfkpCm1WwzgZzMkbPtfkKuXlFakdNU9BMpcBdgZefvxQymAGduS6
	gYpRvOgXSUMNaSHv3YmyWxQbcAqp1Xi0gMR4nHwAEL07KoWvD47RWYS5zZuM4Feq0/D4pl
	bsdHUBpMp+jU9cWkYelyJIaIKkQRHkU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0439213911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oK6HLvdzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: compression: convert page allocation to folio interfaces
Date: Mon, 29 Jan 2024 20:16:07 +1030
Message-ID: <764525d863b7701bc93f7939078ded3d9962dfe0.1706521511.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706521511.git.wqu@suse.com>
References: <cover.1706521511.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lvflaDxx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: C48FF1F7D9
X-Spam-Flag: NO

Currently we have two wrappers to allocate and free a page for
compression usage:

- btrfs_alloc_compr_page()
- btrfs_free_compr_page()

The allocator would try to grab a page from the pool, and only allocate
a new page if the pool is empty.

The reclaimer would check if the pool is full, and if not full it would
put the page into the pool.

This patch would convert both helpers to use folio interfaces, and
allowing further conversion of compression path to folios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 24 ++++++++++++------------
 fs/btrfs/compression.h |  4 ++--
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/lzo.c         |  4 ++--
 fs/btrfs/zlib.c        |  6 +++---
 fs/btrfs/zstd.c        |  6 +++---
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 165ed35b4f9f..9c2c86f69588 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -161,7 +161,7 @@ static int compression_decompress(int type, struct list_head *ws,
 static void btrfs_free_compressed_pages(struct compressed_bio *cb)
 {
 	for (unsigned int i = 0; i < cb->nr_pages; i++)
-		btrfs_free_compr_page(cb->compressed_pages[i]);
+		btrfs_free_compr_folio(page_folio(cb->compressed_pages[i]));
 	kfree(cb->compressed_pages);
 }
 
@@ -223,25 +223,25 @@ static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_co
 /*
  * Common wrappers for page allocation from compression wrappers
  */
-struct page *btrfs_alloc_compr_page(void)
+struct folio *btrfs_alloc_compr_folio(void)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 
 	spin_lock(&compr_pool.lock);
 	if (compr_pool.count > 0) {
-		page = list_first_entry(&compr_pool.list, struct page, lru);
-		list_del_init(&page->lru);
+		folio = list_first_entry(&compr_pool.list, struct folio, lru);
+		list_del_init(&folio->lru);
 		compr_pool.count--;
 	}
 	spin_unlock(&compr_pool.lock);
 
-	if (page)
-		return page;
+	if (folio)
+		return folio;
 
-	return alloc_page(GFP_NOFS);
+	return folio_alloc(GFP_NOFS, 0);
 }
 
-void btrfs_free_compr_page(struct page *page)
+void btrfs_free_compr_folio(struct folio *folio)
 {
 	bool do_free = false;
 
@@ -249,7 +249,7 @@ void btrfs_free_compr_page(struct page *page)
 	if (compr_pool.count > compr_pool.thresh) {
 		do_free = true;
 	} else {
-		list_add(&page->lru, &compr_pool.list);
+		list_add(&folio->lru, &compr_pool.list);
 		compr_pool.count++;
 	}
 	spin_unlock(&compr_pool.lock);
@@ -257,8 +257,8 @@ void btrfs_free_compr_page(struct page *page)
 	if (!do_free)
 		return;
 
-	ASSERT(page_ref_count(page) == 1);
-	put_page(page);
+	ASSERT(folio_ref_count(folio) == 1);
+	folio_put(folio);
 }
 
 static void end_bbio_comprssed_read(struct btrfs_bio *bbio)
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 427a0c2cd5cc..7fc3145bfbed 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -98,8 +98,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
-struct page *btrfs_alloc_compr_page(void);
-void btrfs_free_compr_page(struct page *page);
+struct folio *btrfs_alloc_compr_folio(void);
+void btrfs_free_compr_folio(struct folio *folio);
 
 enum btrfs_compression_type {
 	BTRFS_COMPRESS_NONE  = 0,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6734717350e3..f057a0a147ac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1044,7 +1044,7 @@ static void compress_file_range(struct btrfs_work *work)
 	if (pages) {
 		for (i = 0; i < nr_pages; i++) {
 			WARN_ON(pages[i]->mapping);
-			btrfs_free_compr_page(pages[i]);
+			btrfs_free_compr_folio(page_folio(pages[i]));
 		}
 		kfree(pages);
 	}
@@ -1059,7 +1059,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 
 	for (i = 0; i < async_extent->nr_pages; i++) {
 		WARN_ON(async_extent->pages[i]->mapping);
-		btrfs_free_compr_page(async_extent->pages[i]);
+		btrfs_free_compr_folio(page_folio(async_extent->pages[i]));
 	}
 	kfree(async_extent->pages);
 	async_extent->nr_pages = 0;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index fe7e08a4199c..262305025aa7 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -152,7 +152,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	cur_page = out_pages[*cur_out / PAGE_SIZE];
 	/* Allocate a new page */
 	if (!cur_page) {
-		cur_page = btrfs_alloc_compr_page();
+		cur_page = folio_page(btrfs_alloc_compr_folio(), 0);
 		if (!cur_page)
 			return -ENOMEM;
 		out_pages[*cur_out / PAGE_SIZE] = cur_page;
@@ -178,7 +178,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		cur_page = out_pages[*cur_out / PAGE_SIZE];
 		/* Allocate a new page */
 		if (!cur_page) {
-			cur_page = btrfs_alloc_compr_page();
+			cur_page = folio_page(btrfs_alloc_compr_folio(), 0);
 			if (!cur_page)
 				return -ENOMEM;
 			out_pages[*cur_out / PAGE_SIZE] = cur_page;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 171c40712516..306a3f0bee11 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -121,7 +121,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_page = btrfs_alloc_compr_page();
+	out_page = folio_page(btrfs_alloc_compr_folio(), 0);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -206,7 +206,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = btrfs_alloc_compr_page();
+			out_page = folio_page(btrfs_alloc_compr_folio(), 0);
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -242,7 +242,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = btrfs_alloc_compr_page();
+			out_page = folio_page(btrfs_alloc_compr_folio(), 0);
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 88674771b4e6..2cdedae39147 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -412,7 +412,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
 
 	/* Allocate and map in the output buffer */
-	out_page = btrfs_alloc_compr_page();
+	out_page = folio_page(btrfs_alloc_compr_folio(), 0);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -457,7 +457,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = btrfs_alloc_compr_page();
+			out_page = folio_page(btrfs_alloc_compr_folio(), 0);
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -517,7 +517,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			ret = -E2BIG;
 			goto out;
 		}
-		out_page = btrfs_alloc_compr_page();
+		out_page = folio_page(btrfs_alloc_compr_folio(), 0);
 		if (out_page == NULL) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.43.0


