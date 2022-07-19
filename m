Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340DB57941D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 09:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiGSHYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiGSHYh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 03:24:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED032BA1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 00:24:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 522D933B23
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658215475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsL3rS3xyQ6DirGVOlwBT3LocJIZKlretVM1ganh4D0=;
        b=MJe+t+HLv0Zqp10A5Kwwgx5l8zgXF/A99/tPQJwrCVc1jKH6iS9q6kzHNdQ1Sjw/35yz0i
        XvRzXJwb/JYi2j73PrI9VnRN6euEvQddH8dKJEX/4J5A2E6Idtqr2vuG+pC8p8ct359lJL
        qmywMHtncFtfEBAiexadKh1+BkizReo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC44413488
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8FTeHTJc1mKvLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 07:24:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: scrub: remove scrub_sector::page and use scrub_block::pages instead
Date:   Tue, 19 Jul 2022 15:24:12 +0800
Message-Id: <05d70275f802f3b8e3584fdb22347d9f701cf128.1658215183.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658215183.git.wqu@suse.com>
References: <cover.1658215183.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/scrub.c | 97 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 57edf4234fc3..a8145f7bdc9f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -64,7 +64,6 @@ struct scrub_recover {
 
 struct scrub_sector {
 	struct scrub_block	*sblock;
-	struct page		*page;
 	struct btrfs_device	*dev;
 	struct list_head	list;
 	u64			flags;  /* extent flags */
@@ -314,10 +313,59 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 
 	sblock->sectors[sblock->sector_count] = ssector;
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
@@ -649,10 +697,8 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	if (sctx->curr != -1) {
 		struct scrub_bio *sbio = sctx->bios[sctx->curr];
 
-		for (i = 0; i < sbio->sector_count; i++) {
-			WARN_ON(!sbio->sectors[i]->page);
+		for (i = 0; i < sbio->sector_count; i++)
 			scrub_block_put(sbio->sectors[i]->sblock);
-		}
 		bio_put(sbio->bio);
 	}
 
@@ -1518,8 +1564,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct scrub_sector *sector = sblock->sectors[i];
 
-		WARN_ON(!sector->page);
-		bio_add_page(bio, sector->page, PAGE_SIZE, 0);
+		bio_add_scrub_sector(bio, sector, fs_info->sectorsize);
 	}
 
 	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_sector)) {
@@ -1569,9 +1614,8 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
-		WARN_ON(!sector->page);
 		bio_init(&bio, sector->dev->bdev, &bvec, 1, REQ_OP_READ);
-		bio_add_page(&bio, sector->page, fs_info->sectorsize, 0);
+		bio_add_scrub_sector(&bio, sector, fs_info->sectorsize);
 		bio.bi_iter.bi_sector = sector->physical >> 9;
 
 		btrfsic_check_bio(&bio);
@@ -1635,8 +1679,6 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 
-	BUG_ON(sector_bad->page == NULL);
-	BUG_ON(sector_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
 	    sblock_bad->checksum_error || sector_bad->io_error) {
 		struct bio bio;
@@ -1651,7 +1693,7 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 
 		bio_init(&bio, sector_bad->dev->bdev, &bvec, 1, REQ_OP_WRITE);
 		bio.bi_iter.bi_sector = sector_bad->physical >> 9;
-		__bio_add_page(&bio, sector_good->page, sectorsize, 0);
+		ret = bio_add_scrub_sector(&bio, sector_good, sectorsize);
 
 		btrfsic_check_bio(&bio);
 		ret = submit_bio_wait(&bio);
@@ -1691,11 +1733,11 @@ static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
 
 static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock, int sector_num)
 {
+	const u32 sectorsize = sblock->sctx->fs_info->sectorsize;
 	struct scrub_sector *sector = sblock->sectors[sector_num];
 
-	BUG_ON(sector->page == NULL);
 	if (sector->io_error)
-		clear_page(page_address(sector->page));
+		memset(scrub_sector_get_kaddr(sector), 0, sectorsize);
 
 	return scrub_add_sector_to_wr_bio(sblock->sctx, sector);
 }
@@ -1773,7 +1815,7 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		goto again;
 	}
 
-	ret = bio_add_page(sbio->bio, sector->page, sectorsize, 0);
+	ret = bio_add_scrub_sector(sbio->bio, sector, sectorsize);
 	if (ret != sectorsize) {
 		if (sbio->sector_count < 1) {
 			bio_put(sbio->bio);
@@ -1917,15 +1959,11 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	if (!sector->have_csum)
 		return 0;
 
-	kaddr = page_address(sector->page);
+	kaddr = scrub_sector_get_kaddr(sector);
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 
-	/*
-	 * In scrub_sectors() and scrub_sectors_for_parity() we ensure each sector
-	 * only contains one sector of data.
-	 */
 	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
 
 	if (memcmp(csum, sector->csum, fs_info->csum_size))
@@ -1958,7 +1996,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	ASSERT(sblock->sector_count == num_sectors);
 
 	sector = sblock->sectors[0];
-	kaddr = page_address(sector->page);
+	kaddr = scrub_sector_get_kaddr(sector);
 	h = (struct btrfs_header *)kaddr;
 	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
 
@@ -1988,7 +2026,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 			    sectorsize - BTRFS_CSUM_SIZE);
 
 	for (i = 1; i < num_sectors; i++) {
-		kaddr = page_address(sblock->sectors[i]->page);
+		kaddr = scrub_sector_get_kaddr(sblock->sectors[i]);
 		crypto_shash_update(shash, kaddr, sectorsize);
 	}
 
@@ -2013,7 +2051,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 
 	BUG_ON(sblock->sector_count < 1);
 	sector = sblock->sectors[0];
-	kaddr = page_address(sector->page);
+	kaddr = scrub_sector_get_kaddr(sector);
 	s = (struct btrfs_super_block *)kaddr;
 
 	if (sector->logical != btrfs_super_bytenr(s))
@@ -2080,11 +2118,8 @@ static void scrub_sector_get(struct scrub_sector *sector)
 
 static void scrub_sector_put(struct scrub_sector *sector)
 {
-	if (atomic_dec_and_test(&sector->refs)) {
-		if (sector->page)
-			__free_page(sector->page);
+	if (atomic_dec_and_test(&sector->refs))
 		kfree(sector);
-	}
 }
 
 /*
@@ -2210,7 +2245,7 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 	}
 
 	sbio->sectors[sbio->sector_count] = sector;
-	ret = bio_add_page(sbio->bio, sector->page, sectorsize, 0);
+	ret = bio_add_scrub_sector(sbio->bio, sector, sectorsize);
 	if (ret != sectorsize) {
 		if (sbio->sector_count < 1) {
 			bio_put(sbio->bio);
@@ -2326,11 +2361,9 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct scrub_sector *sector = sblock->sectors[i];
 
-		/*
-		 * For now, our scrub is still one page per sector, so pgoff
-		 * is always 0.
-		 */
-		raid56_add_scrub_pages(rbio, sector->page, 0, sector->logical);
+		raid56_add_scrub_pages(rbio, scrub_sector_get_page(sector),
+				       scrub_sector_get_page_offset(sector),
+				       sector->logical);
 	}
 
 	INIT_WORK(&sblock->work, scrub_missing_raid56_worker);
-- 
2.37.0

