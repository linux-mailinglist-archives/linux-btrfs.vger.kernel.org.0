Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F1C4EC9DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiC3QqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348921AbiC3QqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:09 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29C1D7609;
        Wed, 30 Mar 2022 09:44:17 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 58ED4804E2;
        Wed, 30 Mar 2022 12:44:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648658657; bh=blxcaGyrDyunfWeVCn6ZDWJ8bJyfFIf/SH2MIaoOHDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isny/yxf3Ep7AzKinxOXXNZFD8R7yMUjn6RPH/dPQYfU/poKrNQNHh7kS9uRoHhNX
         aGeElqc+99PLN3KzXCko4d87eMiUJnBAobZm/w7rzRt1lzw566Kf0bln91UFXtolU7
         9TO1HRV3oxrajgQAhU3zkgchPUaaFUZdjQ1qVrkJjG+FFe9NAk7vi2gE1ST3VXkqK8
         GrdgKduYRsryFdFg9zm2hxBPYFYyKMx5ShwbwUdkZRWEhe6D//QbgvCm8L0ivSuc9H
         6q24i4YqCD11aW/lzidopVtyVz9xphauoURNhrlToRb5J3uJyx5+pF0u766+N8LLij
         zPoFO8QjAsUjA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/2] btrfs: factor out allocating an array of pages
Date:   Wed, 30 Mar 2022 12:44:06 -0400
Message-Id: <0444e2ee3ebefbd9eac357dedf63a6a1214dbff0.1648658235.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1648658235.git.sweettea-kernel@dorminy.me>
References: <cover.1648658235.git.sweettea-kernel@dorminy.me>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
Changes in v2: 
 - moved the new btrfs_alloc_page_array() function to extent_io.[ch]
---
 fs/btrfs/check-integrity.c |  8 ++---
 fs/btrfs/compression.c     | 37 ++++++++++------------
 fs/btrfs/extent_io.c       | 65 ++++++++++++++++++++++++++++----------
 fs/btrfs/extent_io.h       |  2 ++
 fs/btrfs/inode.c           | 10 +++---
 fs/btrfs/raid56.c          | 30 +++---------------
 6 files changed, 78 insertions(+), 74 deletions(-)

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
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 53b59944013f..5700fcc23271 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3132,6 +3132,31 @@ static void end_bio_extent_readpage(struct bio *bio)
 	bio_put(bio);
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
  * Initialize the members up to but not including 'bio'. Use after allocating a
  * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
@@ -5898,9 +5923,9 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	int i;
-	struct page *p;
 	struct extent_buffer *new;
 	int num_pages = num_extent_pages(src);
+	int r;
 
 	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
 	if (new == NULL)
@@ -5913,22 +5938,23 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
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
@@ -5942,31 +5968,38 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
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
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 151e9da5da2d..464269e28941 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -277,6 +277,8 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
+
+int btrfs_alloc_page_array(unsigned long nr_pages, struct page **page_array);
 struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
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

