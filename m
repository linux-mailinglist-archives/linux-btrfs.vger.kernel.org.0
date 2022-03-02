Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE54C9FA3
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 09:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiCBIpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 03:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiCBIpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 03:45:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC0BAB9C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 00:44:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B630219A2
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646210673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYXhOPOr3U1aD9r0cEkliJR5YlOsIJx9Lpqz4lAG38k=;
        b=ZD+bMlIoqNuX1778Je+ZotFfxW43dds3lmceFt0xDGx98Ia5rHvS3rIOEc8ncOrS9WEe6k
        7azdagfsNwdeserGWbXBIQXClk+E/S9PAAN/PRtLV/1bzyMcPoDBy+y4USoMLEAZx9Sl1j
        NDdJiT029tuhsjDt4v36YZcpGjMWnWk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 570EC13345
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yDWXBnAuH2JHTAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 08:44:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: scrub: introduce scrub_block::pages for more efficient memory usage for subpage
Date:   Wed,  2 Mar 2022 16:44:07 +0800
Message-Id: <126d66711c933ca79b19352b79c5bdbea44dd08f.1646210538.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646210538.git.wqu@suse.com>
References: <cover.1646210538.git.wqu@suse.com>
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
 fs/btrfs/scrub.c | 135 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bab717e80918..7edf063baee6 100644
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
 	struct scrub_sector	*sectorv[SCRUB_MAX_SECTORS_PER_BLOCK];
+	u64			logical; /* Logical bytenr of the sblock */
+	u32			len; /* The length of sblock in bytes */
 	int			sector_count;
+
 	atomic_t		outstanding_sectors;
 	refcount_t		refs; /* free mem on transition to zero */
 	struct scrub_ctx	*sctx;
@@ -204,7 +214,46 @@ struct full_stripe_lock {
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
 
@@ -213,27 +262,54 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx)
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
-	/* This sector to be added should not be used */
+	ssector->logical = logical;
+
+	/* The slot to be added should not be used */
 	ASSERT(sblock->sectorv[sblock->sector_count] == NULL);
 	/* And the sector count should be smaller than the limit */
 	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
@@ -955,7 +1031,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		 * But alloc_scrub_block() will initialize sblock::ref anyway,
 		 * so we can use scrub_block_put() to clean them up.
 		 */
-		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx);
+		sblocks_for_recheck[mirror_index] = alloc_scrub_block(sctx,
+								      logical);
 		if (!sblocks_for_recheck[mirror_index]) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -1363,7 +1440,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			ssector = alloc_scrub_sector(sblock, GFP_NOFS);
+			ssector = alloc_scrub_sector(sblock, logical, GFP_NOFS);
 			if (!ssector) {
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
@@ -1373,7 +1450,6 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			}
 			ssector->flags = flags;
 			ssector->generation = generation;
-			ssector->logical = logical;
 			ssector->have_csum = have_csum;
 			if (have_csum)
 				memcpy(ssector->csum,
@@ -1669,6 +1745,11 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
+static void scrub_block_get(struct scrub_block *sblock)
+{
+	refcount_inc(&sblock->refs);
+}
+
 static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_sector *ssector)
 {
@@ -1736,6 +1817,13 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 
 	sbio->sectorv[sbio->sector_count] = ssector;
 	scrub_sector_get(ssector);
+	/*
+	 * Since ssector no longer holds a page, but uses sblock::pages, we
+	 * have to ensure the sblock didn't get freed before our write bio
+	 * finished.
+	 */
+	scrub_block_get(ssector->sblock);
+
 	sbio->sector_count++;
 	if (sbio->sector_count == sctx->sectors_per_bio)
 		scrub_wr_submit(sctx);
@@ -1797,8 +1885,10 @@ static void scrub_wr_bio_end_io_worker(struct btrfs_work *work)
 		}
 	}
 
-	for (i = 0; i < sbio->sector_count; i++)
+	for (i = 0; i < sbio->sector_count; i++) {
+		scrub_block_put(sbio->sectorv[i]->sblock);
 		scrub_sector_put(sbio->sectorv[i]);
+	}
 
 	bio_put(sbio->bio);
 	kfree(sbio);
@@ -1989,11 +2079,6 @@ static int scrub_checksum_super(struct scrub_block *sblock)
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
@@ -2004,6 +2089,12 @@ static void scrub_block_put(struct scrub_block *sblock)
 
 		for (i = 0; i < sblock->sector_count; i++)
 			scrub_sector_put(sblock->sectorv[i]);
+		for (i = 0; i < DIV_ROUND_UP(sblock->len, PAGE_SIZE); i++) {
+			if (sblock->pages[i]) {
+				detach_scrub_page_private(sblock->pages[i]);
+				__free_page(sblock->pages[i]);
+			}
+		}
 		kfree(sblock);
 	}
 }
@@ -2294,7 +2385,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int index;
 
-	sblock = alloc_scrub_block(sctx);
+	sblock = alloc_scrub_block(sctx, logical);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2311,7 +2402,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		ssector = alloc_scrub_sector(sblock, GFP_KERNEL);
+		ssector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 		if (!ssector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2322,7 +2413,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		ssector->dev = dev;
 		ssector->flags = flags;
 		ssector->generation = gen;
-		ssector->logical = logical;
 		ssector->physical = physical;
 		ssector->physical_for_dev_replace = physical_for_dev_replace;
 		ssector->mirror_num = mirror_num;
@@ -2632,7 +2722,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 
 	ASSERT(IS_ALIGNED(len, sectorsize));
 
-	sblock = alloc_scrub_block(sctx);
+	sblock = alloc_scrub_block(sctx, logical);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
@@ -2646,7 +2736,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *ssector;
 
-		ssector = alloc_scrub_sector(sblock, GFP_KERNEL);
+		ssector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 		if (!ssector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2661,7 +2751,6 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 		ssector->dev = dev;
 		ssector->flags = flags;
 		ssector->generation = gen;
-		ssector->logical = logical;
 		ssector->physical = physical;
 		ssector->mirror_num = mirror_num;
 		if (csum) {
-- 
2.35.1

