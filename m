Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E44EA132
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiC1UQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 16:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiC1UQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 16:16:18 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CED26AF0;
        Mon, 28 Mar 2022 13:14:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1B231806B3;
        Mon, 28 Mar 2022 16:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648498474; bh=CaAImrDKnYe5XRZkBXJUWlaus8Bo7Q88RwwpRumgDVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSaC4bk9juGoRWh+On89Wjj8d/QUnwrq9p9SdaRuZEBCEcm4auUhqT3Bq8Mh45oyq
         4jmxFZydHDiwhlxv3diM0nZFohVHfwvH8Ot9Z0G0Vth2YocXnyIQMMbqMoBixCcOYb
         17O39HwhH2a8QzJ/08upHBLYk1MTPJMVAgIXAOlZEWoB6vd6Cx4JkjeveMxGELTKLQ
         XaRYMewTlhaaePxpPuKwoXOU+fXrT7FAr9P2sYICV/WAFevwhbvPbpezipzbER7ZjQ
         +CqYAs7CVacW88RYq85XvhoqMJcHCpzp2J7ZkHFlIOeK9rOAXLtnEPfPvf24kyCoYH
         kfOQtAXoafflQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/2] btrfs: Factor out allocating an array of pages.
Date:   Mon, 28 Mar 2022 16:14:27 -0400
Message-Id: <8a8c3d39c858a1b8610ea967a50c2572c7604f5e.1648497027.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1648497027.git.sweettea-kernel@dorminy.me>
References: <cover.1648497027.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several functions currently populate an array of page pointers one
allocated page at a time; factor out the common code so as to allow
improvements to all of the sites at once.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/check-integrity.c |  8 +++-----
 fs/btrfs/compression.c     | 37 +++++++++++++++--------------------
 fs/btrfs/ctree.c           | 25 ++++++++++++++++++++++++
 fs/btrfs/ctree.h           |  2 ++
 fs/btrfs/extent_io.c       | 40 +++++++++++++++++++++++---------------
 fs/btrfs/inode.c           | 10 ++++------
 fs/btrfs/raid56.c          | 30 ++++------------------------
 7 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 7e9f90fa0388..366d5a80f3c5 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1553,11 +1553,9 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		return -ENOMEM;
 	block_ctx->datav = block_ctx->mem_to_free;
 	block_ctx->pagev = (struct page **)(block_ctx->datav + num_pages);
-	for (i = 0; i < num_pages; i++) {
-		block_ctx->pagev[i] = alloc_page(GFP_NOFS);
-		if (!block_ctx->pagev[i])
-			return -1;
-	}
+	ret = btrfs_alloc_page_array(num_pages, block_ctx->pagev);
+	if (ret)
+		return ret;
 
 	dev_bytenr = block_ctx->dev_bytenr;
 	for (i = 0; i < num_pages;) {
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index be476f094300..0fc663b757fb 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -801,8 +801,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct extent_map_tree *em_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
-	unsigned int nr_pages;
-	unsigned int pg_index;
 	struct bio *comp_bio = NULL;
 	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_byte = disk_bytenr;
@@ -812,7 +810,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_start;
 	struct extent_map *em;
 	blk_status_t ret;
-	int faili = 0;
+	int r;
+	int i;
 	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
@@ -855,25 +854,20 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	cb->compress_type = extent_compress_type(bio_flags);
 	cb->orig_bio = bio;
 
-	nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
-	cb->compressed_pages = kcalloc(nr_pages, sizeof(struct page *),
+	cb->nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
+	cb->compressed_pages = kcalloc(cb->nr_pages, sizeof(struct page *),
 				       GFP_NOFS);
 	if (!cb->compressed_pages) {
 		ret = BLK_STS_RESOURCE;
-		goto fail1;
+		goto fail;
 	}
 
-	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
-		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS);
-		if (!cb->compressed_pages[pg_index]) {
-			faili = pg_index - 1;
-			ret = BLK_STS_RESOURCE;
-			goto fail2;
-		}
+	r = btrfs_alloc_page_array(cb->nr_pages, cb->compressed_pages);
+	if (r) {
+		ret = BLK_STS_RESOURCE;
+		goto fail;
 	}
-	faili = nr_pages - 1;
-	cb->nr_pages = nr_pages;
-
+	
 	add_ra_bio_pages(inode, em_start + em_len, cb);
 
 	/* include any pages we added in add_ra-bio_pages */
@@ -949,14 +943,15 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	}
 	return BLK_STS_OK;
 
-fail2:
-	while (faili >= 0) {
-		__free_page(cb->compressed_pages[faili]);
-		faili--;
+fail:
+	if (cb->compressed_pages) {
+		for (i = 0; i < cb->nr_pages; i++) {
+			if (cb->compressed_pages[i])
+				__free_page(cb->compressed_pages[i]);
+		}
 	}
 
 	kfree(cb->compressed_pages);
-fail1:
 	kfree(cb);
 out:
 	free_extent_map(em);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1e24695ede0a..4e81e75c8e7c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -90,6 +90,31 @@ void btrfs_free_path(struct btrfs_path *p)
 	kmem_cache_free(btrfs_path_cachep, p);
 }
 
+/**
+ * btrfs_alloc_page_array() - allocate an array of pages.
+ *
+ * @nr_pages: the number of pages to request
+ * @page_array: the array to fill with pages. Any existing non-null entries in
+ * 	the array will be skipped.
+ *
+ * Return: 0 if all pages were able to be allocated; -ENOMEM otherwise, and the
+ * caller is responsible for freeing all non-null page pointers in the array.
+ */
+int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array)
+{
+	int i;
+	for (i = 0; i < nr_pages; i++) {
+		struct page *page;
+		if (page_array[i])
+			continue;
+		page = alloc_page(GFP_NOFS);
+		if (!page)
+			return -ENOMEM;
+		page_array[i] = page;
+	}
+	return 0;
+}
+
 /*
  * path release drops references on the extent buffers in the path
  * and it drops any locks held by this path
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7328fb17b7f5..e835a2bfb60a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2969,6 +2969,8 @@ void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
 
+int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array);
+
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
 static inline int btrfs_del_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 53b59944013f..c1c8d770f43a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5898,9 +5898,9 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	int i;
-	struct page *p;
 	struct extent_buffer *new;
 	int num_pages = num_extent_pages(src);
+	int r;
 
 	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
 	if (new == NULL)
@@ -5913,22 +5913,23 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
+	memset(new->pages, 0, sizeof(*new->pages) * num_pages);
+	r = btrfs_alloc_page_array(num_pages, new->pages);
+	if (r) {
+		btrfs_release_extent_buffer(new);
+		return NULL;
+	}
+
 	for (i = 0; i < num_pages; i++) {
 		int ret;
+		struct page *p = new->pages[i];
 
-		p = alloc_page(GFP_NOFS);
-		if (!p) {
-			btrfs_release_extent_buffer(new);
-			return NULL;
-		}
 		ret = attach_extent_buffer_page(new, p, NULL);
 		if (ret < 0) {
-			put_page(p);
 			btrfs_release_extent_buffer(new);
 			return NULL;
 		}
 		WARN_ON(PageDirty(p));
-		new->pages[i] = p;
 		copy_page(page_address(p), page_address(src->pages[i]));
 	}
 	set_extent_buffer_uptodate(new);
@@ -5942,31 +5943,38 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *eb;
 	int num_pages;
 	int i;
+	int r;
 
 	eb = __alloc_extent_buffer(fs_info, start, len);
 	if (!eb)
 		return NULL;
 
 	num_pages = num_extent_pages(eb);
+	r = btrfs_alloc_page_array(num_pages, eb->pages);
+	if (r)
+		goto err;
+
 	for (i = 0; i < num_pages; i++) {
 		int ret;
+		struct page *p = eb->pages[i];
 
-		eb->pages[i] = alloc_page(GFP_NOFS);
-		if (!eb->pages[i])
-			goto err;
-		ret = attach_extent_buffer_page(eb, eb->pages[i], NULL);
-		if (ret < 0)
+		ret = attach_extent_buffer_page(eb, p, NULL);
+		if (ret < 0) {
 			goto err;
+		}
 	}
+
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	return eb;
 err:
-	for (; i > 0; i--) {
-		detach_extent_buffer_page(eb, eb->pages[i - 1]);
-		__free_page(eb->pages[i - 1]);
+	for (i = 0; i < num_pages; i++) {
+		if (eb->pages[i]) {
+			detach_extent_buffer_page(eb, eb->pages[i]);
+			__free_page(eb->pages[i]);
+		}
 	}
 	__free_extent_buffer(eb);
 	return NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c7b15634fe70..121858652a09 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10427,13 +10427,11 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 	if (!pages)
 		return -ENOMEM;
-	for (i = 0; i < nr_pages; i++) {
-		pages[i] = alloc_page(GFP_NOFS);
-		if (!pages[i]) {
-			ret = -ENOMEM;
-			goto out;
+	ret = btrfs_alloc_page_array(nr_pages, pages);
+	if (ret) {
+		ret = -ENOMEM;
+		goto out;
 		}
-	}
 
 	ret = btrfs_encoded_read_regular_fill_pages(inode, start, disk_bytenr,
 						    disk_io_size, pages);
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b26..ea7a9152b1cc 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1026,37 +1026,15 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 /* allocate pages for all the stripes in the bio, including parity */
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 {
-	int i;
-	struct page *page;
-
-	for (i = 0; i < rbio->nr_pages; i++) {
-		if (rbio->stripe_pages[i])
-			continue;
-		page = alloc_page(GFP_NOFS);
-		if (!page)
-			return -ENOMEM;
-		rbio->stripe_pages[i] = page;
-	}
-	return 0;
+	return btrfs_alloc_page_array(rbio->nr_pages, rbio->stripe_pages);
 }
 
 /* only allocate pages for p/q stripes */
 static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 {
-	int i;
-	struct page *page;
-
-	i = rbio_stripe_page_index(rbio, rbio->nr_data, 0);
-
-	for (; i < rbio->nr_pages; i++) {
-		if (rbio->stripe_pages[i])
-			continue;
-		page = alloc_page(GFP_NOFS);
-		if (!page)
-			return -ENOMEM;
-		rbio->stripe_pages[i] = page;
-	}
-	return 0;
+	int data_pages = rbio_stripe_page_index(rbio, rbio->nr_data, 0);
+	return btrfs_alloc_page_array(rbio->nr_pages - data_pages,
+				      rbio->stripe_pages + data_pages);
 }
 
 /*
-- 
2.35.1

