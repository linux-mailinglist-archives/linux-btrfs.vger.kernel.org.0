Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA054C9FAE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 09:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiCBIp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 03:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiCBIpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 03:45:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D442ECE
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 00:44:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5481021991
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646210674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icOiRxnwbHFU58iu6IRRZYdGB4as515MfOTc8YwgYxI=;
        b=HcjVnDb/ellkc/2ujbKCSr2lpouJKF6lLgVUlBNJ5WxVlmjdJ74gjcLl4HGRSBvadW3OTc
        4o/rbsLmyXkD1+HlKuHpmYq1zUx2vWxyXAmr0r5UkocUYpSyFpAL2oBBsdCMsrD4QFIN/A
        ifCatKvo1OK55VGkyt0+Ba10fZUmICY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F2CA13345
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yFk9FHEuH2JHTAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 08:44:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: scrub: remove scrub_sector::page and use scrub_block::pages instead
Date:   Wed,  2 Mar 2022 16:44:08 +0800
Message-Id: <90f1356db345a2b16230b338c8ccfad2865a4263.1646210538.git.wqu@suse.com>
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

Although scrub currently works for subpage (PAGE_SIZE > sectorsize) cases,
it will allocate one page for each scrub_sector, which can cause extra
unnecessary memory usage.

This patch will utilize scrub_block::pages[] instead of allocating page
for each scrub_sector, this allows us to integrate larger extents while
use less memory.

For example, if our page size is 64K, sectorsize is 4K, and we got an
32K sized extent.
We will only allocated one page for scrub_block, and all 8 scrub sectors
will point to that page.

To do that properly, here we introduce several small helpers:

- scrub_page_get_logical()
  Get the logical bytenr of a page.
  We store the logical bytenr of the page range into page::private.
  But for 32bit systems, their (void *) is not large enough to contain
  a u64, so in that case we will need to allocate extra memory for it.

  For 64bit systems, we can use page::private directly.

- scrub_block_get_logical()
  Just get the logical bytenr of the first page.

- scrub_sector_get_page()
  Return the page which the scrub_sector points to.

- scrub_sector_get_page_offset()
  Return the offset inside the page which the scrub_sector points to.

- scrub_sector_get_kaddr()
  Return the address which the scrub_sector points to.
  Just a wrapper using scrub_sector_get_page() and
  scrub_sector_get_page_offset()

- bio_add_scrub_sector()

Please note that, even with this patch, we're still allocating one page
for one sector for data extents.

This is because in scrub_extent() we split the data extent using
sectorsize.

The memory usage reduce will need extra work to make scrub to work like
data read to only use the correct sector(s).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 100 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7edf063baee6..02efb0ce7d43 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -64,7 +64,6 @@ struct scrub_recover {
 
 struct scrub_sector {
 	struct scrub_block	*sblock;
-	struct page		*page;
 	struct btrfs_device	*dev;
 	struct list_head	list;
 	u64			flags;  /* extent flags */
@@ -311,15 +310,65 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 
 	/* The slot to be added should not be used */
 	ASSERT(sblock->sectorv[sblock->sector_count] == NULL);
+
 	/* And the sector count should be smaller than the limit */
 	ASSERT(sblock->sector_count < SCRUB_MAX_SECTORS_PER_BLOCK);
 
 	sblock->sectorv[sblock->sector_count] = ssector;
 	sblock->sector_count++;
+	sblock->len += sblock->sctx->fs_info->sectorsize;
 
 	return ssector;
 }
 
+static struct page *scrub_sector_get_page(struct scrub_sector *ssector)
+{
+	struct scrub_block *sblock = ssector->sblock;
+	int index;
+	/*
+	 * When calling this function, ssector should have been attached to
+	 * the parent sblock.
+	 */
+	ASSERT(sblock);
+
+	/* The range should be inside the sblock range */
+	ASSERT(ssector->logical - sblock->logical < sblock->len);
+
+	index = (ssector->logical - sblock->logical) >> PAGE_SHIFT;
+	ASSERT(index < SCRUB_MAX_PAGES);
+	ASSERT(sblock->pages[index]);
+	ASSERT(PagePrivate(sblock->pages[index]));
+	return sblock->pages[index];
+}
+
+static unsigned int scrub_sector_get_page_offset(struct scrub_sector *ssector)
+{
+	struct scrub_block *sblock = ssector->sblock;
+	/*
+	 * When calling this function, ssector should have been attached to
+	 * the parent sblock.
+	 */
+	ASSERT(sblock);
+
+	/* The range should be inside the sblock range */
+	ASSERT(ssector->logical - sblock->logical < sblock->len);
+
+	return offset_in_page(ssector->logical - sblock->logical);
+}
+
+static char *scrub_sector_get_kaddr(struct scrub_sector *ssector)
+{
+	return page_address(scrub_sector_get_page(ssector)) +
+	       scrub_sector_get_page_offset(ssector);
+}
+
+static int bio_add_scrub_sector(struct bio *bio, struct scrub_sector *ssector,
+				 unsigned int len)
+{
+	return bio_add_page(bio, scrub_sector_get_page(ssector), len,
+			   scrub_sector_get_page_offset(ssector));
+}
+
 static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				     struct scrub_block *sblocks_for_recheck[]);
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
@@ -652,7 +701,6 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 		struct scrub_bio *sbio = sctx->bios[sctx->curr];
 
 		for (i = 0; i < sbio->sector_count; i++) {
-			WARN_ON(!sbio->sectorv[i]->page);
 			scrub_block_put(sbio->sectorv[i]->sblock);
 		}
 		bio_put(sbio->bio);
@@ -1533,8 +1581,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	for (sector_num = 0; sector_num < sblock->sector_count; sector_num++) {
 		struct scrub_sector *ssector = sblock->sectorv[sector_num];
 
-		WARN_ON(!ssector->page);
-		bio_add_page(bio, ssector->page, PAGE_SIZE, 0);
+		bio_add_scrub_sector(bio, ssector, fs_info->sectorsize);
 	}
 
 	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_sector)) {
@@ -1583,11 +1630,10 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
-		WARN_ON(!ssector->page);
 		bio = btrfs_bio_alloc(1);
 		bio_set_dev(bio, ssector->dev->bdev);
 
-		bio_add_page(bio, ssector->page, fs_info->sectorsize, 0);
+		bio_add_scrub_sector(bio, ssector, fs_info->sectorsize);
 		bio->bi_iter.bi_sector = ssector->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 
@@ -1653,8 +1699,6 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 
-	BUG_ON(ssector_bad->page == NULL);
-	BUG_ON(ssector_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
 	    sblock_bad->checksum_error || ssector_bad->io_error) {
 		struct bio *bio;
@@ -1671,7 +1715,7 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 		bio->bi_iter.bi_sector = ssector_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 
-		ret = bio_add_page(bio, ssector_good->page, sectorsize, 0);
+		ret = bio_add_scrub_sector(bio, ssector_good, sectorsize);
 		if (ret != sectorsize) {
 			bio_put(bio);
 			return -EIO;
@@ -1714,11 +1758,16 @@ static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
 static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
 					     int sector_num)
 {
+	const u32 sectorsize = sblock->sctx->fs_info->sectorsize;
 	struct scrub_sector *ssector = sblock->sectorv[sector_num];
 
-	BUG_ON(ssector->page == NULL);
-	if (ssector->io_error)
-		clear_page(page_address(ssector->page));
+	if (ssector->io_error) {
+		/* We can only clear the full page if one sector is one page */
+		if (sectorsize == PAGE_SIZE)
+			clear_page(page_address(scrub_sector_get_page(ssector)));
+		else
+			memset(scrub_sector_get_kaddr(ssector), 0, sectorsize);
+	}
 
 	return scrub_add_sector_to_wr_bio(sblock->sctx, ssector);
 }
@@ -1803,7 +1852,7 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		goto again;
 	}
 
-	ret = bio_add_page(sbio->bio, ssector->page, sectorsize, 0);
+	ret = bio_add_scrub_sector(sbio->bio, ssector, sectorsize);
 	if (ret != sectorsize) {
 		if (sbio->sector_count < 1) {
 			bio_put(sbio->bio);
@@ -1943,15 +1992,11 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	if (!ssector->have_csum)
 		return 0;
 
-	kaddr = page_address(ssector->page);
+	kaddr = scrub_sector_get_kaddr(ssector);
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 
-	/*
-	 * In scrub_sectors() and scrub_sectors_for_parity() we ensure each ssector
-	 * only contains one sector of data.
-	 */
 	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
 
 	if (memcmp(csum, ssector->csum, fs_info->csum_size))
@@ -1984,7 +2029,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	ASSERT(sblock->sector_count == num_sectors);
 
 	ssector = sblock->sectorv[0];
-	kaddr = page_address(ssector->page);
+	kaddr = scrub_sector_get_kaddr(ssector);
 	h = (struct btrfs_header *)kaddr;
 	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
 
@@ -2014,7 +2059,8 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 			    sectorsize - BTRFS_CSUM_SIZE);
 
 	for (i = 1; i < num_sectors; i++) {
-		kaddr = page_address(sblock->sectorv[i]->page);
+		ssector = sblock->sectorv[i];
+		kaddr = scrub_sector_get_kaddr(ssector);
 		crypto_shash_update(shash, kaddr, sectorsize);
 	}
 
@@ -2039,7 +2085,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 
 	BUG_ON(sblock->sector_count < 1);
 	ssector = sblock->sectorv[0];
-	kaddr = page_address(ssector->page);
+	kaddr = scrub_sector_get_kaddr(ssector);
 	s = (struct btrfs_super_block *)kaddr;
 
 	if (ssector->logical != btrfs_super_bytenr(s))
@@ -2106,11 +2152,8 @@ static void scrub_sector_get(struct scrub_sector *ssector)
 
 static void scrub_sector_put(struct scrub_sector *ssector)
 {
-	if (atomic_dec_and_test(&ssector->refs)) {
-		if (ssector->page)
-			__free_page(ssector->page);
+	if (atomic_dec_and_test(&ssector->refs))
 		kfree(ssector);
-	}
 }
 
 /*
@@ -2241,7 +2284,7 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 	}
 
 	sbio->sectorv[sbio->sector_count] = ssector;
-	ret = bio_add_page(sbio->bio, ssector->page, sectorsize, 0);
+	ret = bio_add_scrub_sector(sbio->bio, ssector, sectorsize);
 	if (ret != sectorsize) {
 		if (sbio->sector_count < 1) {
 			bio_put(sbio->bio);
@@ -2357,7 +2400,10 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct scrub_sector *ssector = sblock->sectorv[i];
 
-		raid56_add_scrub_pages(rbio, ssector->page, ssector->logical);
+		/* Subpage doesn't support RAID56 yet */
+		ASSERT(fs_info->sectorsize == PAGE_SIZE);
+		raid56_add_scrub_pages(rbio, scrub_sector_get_page(ssector),
+				       ssector->logical);
 	}
 
 	btrfs_init_work(&sblock->work, scrub_missing_raid56_worker, NULL, NULL);
-- 
2.35.1

