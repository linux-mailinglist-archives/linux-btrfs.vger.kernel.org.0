Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04DE579419
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 09:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiGSHYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiGSHYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 03:24:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6132DAF
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 00:24:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D79733B1D
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658215474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YopVIcdYFhYpafhetheJbEgDDMM7EqwyNTgfcHVdubE=;
        b=vRCBQ0nvSUb8XfWWAUaDmCSizPZXIQ2ml5LZSMSlW+uKs/J7nWcmCLySFseRyANYE4Ejve
        BuTm+CJNIfpD7s0Tyl9x0fwqQajlqR6NJR04nMOS7IytYYiVtD+pBHm6GgTbmx60RhAwnL
        WSoX5ynoi9hHrnWPVKcausiUD5NuNC4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A70E213488
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OJqYHDFc1mKvLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: scrub: introduce scrub_block::pages for more efficient memory usage for subpage
Date:   Tue, 19 Jul 2022 15:24:11 +0800
Message-Id: <14ea03b93f2708cce7ccbdc1321df51938c468e9.1658215183.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658215183.git.wqu@suse.com>
References: <cover.1658215183.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
Currently for scrub, we allocate one page for one sector, this is fine
for PAGE_SIZE == sectorsize support, but can waste extra memory for
subpage support.

[CODE CHANGE]
So this patch will make scrub_block to contain all the pages, so if
we're scrubing an extent sized 64K, and our page size is also 64K, we
only need to allocate one page.

[LIFESPAN CHANGE]
Since now scrub_sector no longer holds a page, but using
scrub_block::pages[] instead, we have to ensure scrub_block has a longer
lifespan for write bio.

(The lifespan for read bio is already large enough)

Now scrub_block will only be released after the write bio finished.

[COMING NEXT]
Currently we only added scrub_block::pages[] for this purpose, but
scrub_sector is still utilizing the old scrub_sector::page.

The switch will happen in the next patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 137 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b9acc1e30514..57edf4234fc3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -54,6 +54,8 @@ struct scrub_ctx;
  */
 #define SCRUB_MAX_SECTORS_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
 
+#define SCRUB_MAX_PAGES			(DIV_ROUND_UP(BTRFS_MAX_METADATA_BLOCKSIZE, PAGE_SIZE))
+
 struct scrub_recover {
 	refcount_t		refs;
 	struct btrfs_io_context	*bioc;
@@ -94,8 +96,16 @@ struct scrub_bio {
 };
 
 struct scrub_block {
+	/*
+	 * Each page will has its page::private used to record the logical
+	 * bytenr.
+	 */
+	struct page		*pages[SCRUB_MAX_PAGES];
 	struct scrub_sector	*sectors[SCRUB_MAX_SECTORS_PER_BLOCK];
+	u64			logical; /* Logical bytenr of the sblock */
+	u32			len; /* The length of sblock in bytes */
 	int			sector_count;
+
 	atomic_t		outstanding_sectors;
 	refcount_t		refs; /* free mem on transition to zero */
 	struct scrub_ctx	*sctx;
@@ -202,7 +212,46 @@ struct full_stripe_lock {
 	struct mutex mutex;
 };
 
-static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
+#ifndef CONFIG_64BIT
+/* This structure is for archtectures whose (void *) is smaller than u64 */
+struct scrub_page_private {
+	u64 logical;
+};
+#endif
+
+static int attach_scrub_page_private(struct page *page, u64 logical)
+{
+#ifdef CONFIG_64BIT
+	attach_page_private(page, (void *)logical);
+	return 0;
+#else
+	struct scrub_page_private *spp;
+
+	spp = kmalloc(sizeof(*spp), GFP_KERNEL);
+	if (!spp)
+		return -ENOMEM;
+	spp->logical = logical;
+	attach_page_private(page, (void *)spp);
+	return 0;
+#endif
+}
+
+static void detach_scrub_page_private(struct page *page)
+{
+#ifdef CONFIG_64BIT
+	detach_page_private(page);
+	return;
+#else
+	struct scrub_page_private *spp;
+
+	spp = detach_page_private(page);
+	kfree(spp);
+	return;
+#endif
+}
+
+static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
+					     u64 logical)
 {
 	struct scrub_block *sblock;
 
@@ -211,28 +260,55 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
 		return NULL;
 	refcount_set(&sblock->refs, 1);
 	sblock->sctx = sctx;
+	sblock->logical = logical;
 	sblock->no_io_error_seen = 1;
+	/*
+	 * Scrub_block::pages will be allocated at alloc_scrub_sector() when
+	 * the corresponding page is not allocated.
+	 */
 	return sblock;
 }
 
-/* Allocate a new scrub sector and attach it to @sblock */
+/*
+ * Allocate a new scrub sector and attach it to @sblock.
+ *
+ * Will also allocate new pages for @sblock if needed.
+ */
 static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
-					       gfp_t gfp)
+					       u64 logical, gfp_t gfp)
 {
+	const int page_index = (logical - sblock->logical) >> PAGE_SHIFT;
 	struct scrub_sector *ssector;
 
 	ssector = kzalloc(sizeof(*ssector), gfp);
 	if (!ssector)
 		return NULL;
-	ssector->page = alloc_page(gfp);
-	if (!ssector->page) {
-		kfree(ssector);
-		return NULL;
+
+	/* Allocate a new page if the slot is not allocated*/
+	if (!sblock->pages[page_index]) {
+		int ret;
+
+		sblock->pages[page_index] = alloc_page(gfp);
+		if (!sblock->pages[page_index]) {
+			kfree(ssector);
+			return NULL;
+		}
+		ret = attach_scrub_page_private(sblock->pages[page_index],
+				sblock->logical + (page_index << PAGE_SHIFT));
+		if (ret < 0) {
+			kfree(ssector);
+			__free_page(sblock->pages[page_index]);
+			sblock->pages[page_index] = NULL;
+			return NULL;
+		}
 	}
+
 	atomic_set(&ssector->refs, 1);
 	ssector->sblock = sblock;
 	/* This sector to be added should not be used */
 	ASSERT(sblock->sectors[sblock->sector_count] == NULL);
+	ssector->logical = logical;
+
 	/* And the sector count should be smaller than the limit */
 	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
 
@@ -952,7 +1028,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		 * But alloc_scrub_block() will initialize sblock::ref anyway,
 		 * so we can use scrub_block_put() to clean them up.
 		 */
-		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx);
+		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx,
+								      logical);
 		if (!sblocks_for_recheck[mirror_index]) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -1357,7 +1434,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			sector = alloc_scrub_sector(sblock, GFP_NOFS);
+			sector = alloc_scrub_sector(sblock, logical, GFP_NOFS);
 			if (!sector) {
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
@@ -1367,7 +1444,6 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			}
 			sector->flags = flags;
 			sector->generation = generation;
-			sector->logical = logical;
 			sector->have_csum = have_csum;
 			if (have_csum)
 				memcpy(sector->csum,
@@ -1646,6 +1722,11 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
+static void scrub_block_get(struct scrub_block *sblock)
+{
+	refcount_inc(&sblock->refs);
+}
+
 static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 				      struct scrub_sector *sector)
 {
@@ -1706,6 +1787,13 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 
 	sbio->sectors[sbio->sector_count] = sector;
 	scrub_sector_get(sector);
+	/*
+	 * Since ssector no longer holds a page, but uses sblock::pages, we
+	 * have to ensure the sblock didn't get freed before our write bio
+	 * finished.
+	 */
+	scrub_block_get(sector->sblock);
+
 	sbio->sector_count++;
 	if (sbio->sector_count == sctx->sectors_per_bio)
 		scrub_wr_submit(sctx);
@@ -1767,8 +1855,14 @@ static void scrub_wr_bio_end_io_worker(struct work_struct *work)
 		}
 	}
 
-	for (i = 0; i < sbio->sector_count; i++)
+	/*
+	 * In scrub_add_sector_to_wr_bio() we grab extra ref for sblock,
+	 * now in endio we should put the sblock.
+	 */
+	for (i = 0; i < sbio->sector_count; i++) {
+		scrub_block_put(sbio->sectors[i]->sblock);
 		scrub_sector_put(sbio->sectors[i]);
+	}
 
 	bio_put(sbio->bio);
 	kfree(sbio);
@@ -1959,11 +2053,6 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	return fail_cor + fail_gen;
 }
 
-static void scrub_block_get(struct scrub_block *sblock)
-{
-	refcount_inc(&sblock->refs);
-}
-
 static void scrub_block_put(struct scrub_block *sblock)
 {
 	if (refcount_dec_and_test(&sblock->refs)) {
@@ -1974,6 +2063,12 @@ static void scrub_block_put(struct scrub_block *sblock)
 
 		for (i = 0; i < sblock->sector_count; i++)
 			scrub_sector_put(sblock->sectors[i]);
+		for (i = 0; i < DIV_ROUND_UP(sblock->len, PAGE_SIZE); i++) {
+			if (sblock->pages[i]) {
+				detach_scrub_page_private(sblock->pages[i]);
+				__free_page(sblock->pages[i]);
+			}
+		}
 		kfree(sblock);
 	}
 }
@@ -2263,7 +2358,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
-	sblock = alloc_scrub_block(sctx);
+	sblock = alloc_scrub_block(sctx, logical);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2280,7 +2375,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		sector = alloc_scrub_sector(sblock, GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2291,7 +2386,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		sector->dev = dev;
 		sector->flags = flags;
 		sector->generation = gen;
-		sector->logical = logical;
 		sector->physical = physical;
 		sector->physical_for_dev_replace = physical_for_dev_replace;
 		sector->mirror_num = mirror_num;
@@ -2601,7 +2695,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 
 	ASSERT(IS_ALIGNED(len, sectorsize));
 
-	sblock = alloc_scrub_block(sctx);
+	sblock = alloc_scrub_block(sctx, logical);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2615,7 +2709,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *sector;
 
-		sector = alloc_scrub_sector(sblock, GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2630,7 +2724,6 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 		sector->dev = dev;
 		sector->flags = flags;
 		sector->generation = gen;
-		sector->logical = logical;
 		sector->physical = physical;
 		sector->mirror_num = mirror_num;
 		if (csum) {
-- 
2.37.0

