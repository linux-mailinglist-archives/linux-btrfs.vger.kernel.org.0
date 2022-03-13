Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A454D7448
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Mar 2022 11:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiCMKle (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Mar 2022 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiCMKlc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Mar 2022 06:41:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7511A14004
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 03:40:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 369401F395
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647168024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JfkiMTDUgPGUA1Xn2iw2O2IdxauqKwbY2wvqkPZaoU=;
        b=C64Te5DgTtRXEcBZkT8IGBkc1dpmaII/uJ79L6HTHz0EZzmzwmYa5rXIYxCLymFJGuBYc2
        3Mf4ZG6Y3b985s5bocnJEA7PoIYRdjBvqDefrWMNXoiLNfkhwnXdc/37uTVAhQr75NqvPQ
        BERDTjgeV/z7ctLNefJJqQxXtMvXVN4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D0CB13AF7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iPX9FRfKLWLUFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: scrub: rename scrub_bio::pagev[] and related members
Date:   Sun, 13 Mar 2022 18:40:02 +0800
Message-Id: <f8a8ff4c025e24838da84119e5b43672dfe8b87a.1647161284.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647161284.git.wqu@suse.com>
References: <cover.1647161284.git.wqu@suse.com>
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

Since the subpage support for scrub, one page no longer always represents
one sector, thus scrub_bio::pagev[] and scrub_bio::sector_count are no
longer accurate.

Rename them to scrub_bio::sectors[] and scrub_bio::sector_count
respectively.

This also involves scrub_ctx::pages_per_bio and other macros involved.

Now the rename of pages involved in scrub should be finished.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 76 ++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index eb143ff7f8d8..a6783130cae9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -45,7 +45,7 @@ struct scrub_ctx;
  * operations. The first one configures an upper limit for the number
  * of (dynamically allocated) pages that are added to a bio.
  */
-#define SCRUB_PAGES_PER_BIO	32	/* 128KiB per bio for x86 */
+#define SCRUB_SECTORS_PER_BIO	32	/* 128KiB per bio for x86 */
 #define SCRUB_BIOS_PER_SCTX	64	/* 8MiB per device in flight for x86 */
 
 /*
@@ -87,8 +87,8 @@ struct scrub_bio {
 	blk_status_t		status;
 	u64			logical;
 	u64			physical;
-	struct scrub_sector	*pagev[SCRUB_PAGES_PER_BIO];
-	int			page_count;
+	struct scrub_sector	*sectors[SCRUB_SECTORS_PER_BIO];
+	int			sector_count;
 	int			next_free;
 	struct btrfs_work	work;
 };
@@ -158,7 +158,7 @@ struct scrub_ctx {
 	struct list_head	csum_list;
 	atomic_t		cancel_req;
 	int			readonly;
-	int			pages_per_bio;
+	int			sectors_per_bio;
 
 	/* State of IO submission throttling affecting the associated device */
 	ktime_t			throttle_deadline;
@@ -535,9 +535,9 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	if (sctx->curr != -1) {
 		struct scrub_bio *sbio = sctx->bios[sctx->curr];
 
-		for (i = 0; i < sbio->page_count; i++) {
-			WARN_ON(!sbio->pagev[i]->page);
-			scrub_block_put(sbio->pagev[i]->sblock);
+		for (i = 0; i < sbio->sector_count; i++) {
+			WARN_ON(!sbio->sectors[i]->page);
+			scrub_block_put(sbio->sectors[i]->sblock);
 		}
 		bio_put(sbio->bio);
 	}
@@ -572,7 +572,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		goto nomem;
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
-	sctx->pages_per_bio = SCRUB_PAGES_PER_BIO;
+	sctx->sectors_per_bio = SCRUB_SECTORS_PER_BIO;
 	sctx->curr = -1;
 	sctx->fs_info = fs_info;
 	INIT_LIST_HEAD(&sctx->csum_list);
@@ -586,7 +586,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 
 		sbio->index = i;
 		sbio->sctx = sctx;
-		sbio->page_count = 0;
+		sbio->sector_count = 0;
 		btrfs_init_work(&sbio->work, scrub_bio_end_io_worker, NULL,
 				NULL);
 
@@ -1649,10 +1649,10 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 			return -ENOMEM;
 		}
 		sctx->wr_curr_bio->sctx = sctx;
-		sctx->wr_curr_bio->page_count = 0;
+		sctx->wr_curr_bio->sector_count = 0;
 	}
 	sbio = sctx->wr_curr_bio;
-	if (sbio->page_count == 0) {
+	if (sbio->sector_count == 0) {
 		struct bio *bio;
 
 		ret = fill_writer_pointer_gap(sctx,
@@ -1667,7 +1667,7 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->pages_per_bio);
+			bio = btrfs_bio_alloc(sctx->sectors_per_bio);
 			sbio->bio = bio;
 		}
 
@@ -1677,9 +1677,9 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 		sbio->status = 0;
-	} else if (sbio->physical + sbio->page_count * sectorsize !=
+	} else if (sbio->physical + sbio->sector_count * sectorsize !=
 		   sector->physical_for_dev_replace ||
-		   sbio->logical + sbio->page_count * sectorsize !=
+		   sbio->logical + sbio->sector_count * sectorsize !=
 		   sector->logical) {
 		scrub_wr_submit(sctx);
 		goto again;
@@ -1687,7 +1687,7 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 
 	ret = bio_add_page(sbio->bio, sector->page, sectorsize, 0);
 	if (ret != sectorsize) {
-		if (sbio->page_count < 1) {
+		if (sbio->sector_count < 1) {
 			bio_put(sbio->bio);
 			sbio->bio = NULL;
 			mutex_unlock(&sctx->wr_lock);
@@ -1697,10 +1697,10 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
 		goto again;
 	}
 
-	sbio->pagev[sbio->page_count] = sector;
+	sbio->sectors[sbio->sector_count] = sector;
 	scrub_sector_get(sector);
-	sbio->page_count++;
-	if (sbio->page_count == sctx->pages_per_bio)
+	sbio->sector_count++;
+	if (sbio->sector_count == sctx->sectors_per_bio)
 		scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
@@ -1725,7 +1725,7 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	btrfsic_submit_bio(sbio->bio);
 
 	if (btrfs_is_zoned(sctx->fs_info))
-		sctx->write_pointer = sbio->physical + sbio->page_count *
+		sctx->write_pointer = sbio->physical + sbio->sector_count *
 			sctx->fs_info->sectorsize;
 }
 
@@ -1747,21 +1747,21 @@ static void scrub_wr_bio_end_io_worker(struct btrfs_work *work)
 	struct scrub_ctx *sctx = sbio->sctx;
 	int i;
 
-	ASSERT(sbio->page_count <= SCRUB_PAGES_PER_BIO);
+	ASSERT(sbio->sector_count <= SCRUB_SECTORS_PER_BIO);
 	if (sbio->status) {
 		struct btrfs_dev_replace *dev_replace =
 			&sbio->sctx->fs_info->dev_replace;
 
-		for (i = 0; i < sbio->page_count; i++) {
-			struct scrub_sector *sector = sbio->pagev[i];
+		for (i = 0; i < sbio->sector_count; i++) {
+			struct scrub_sector *sector = sbio->sectors[i];
 
 			sector->io_error = 1;
 			atomic64_inc(&dev_replace->num_write_errors);
 		}
 	}
 
-	for (i = 0; i < sbio->page_count; i++)
-		scrub_sector_put(sbio->pagev[i]);
+	for (i = 0; i < sbio->sector_count; i++)
+		scrub_sector_put(sbio->sectors[i]);
 
 	bio_put(sbio->bio);
 	kfree(sbio);
@@ -2077,7 +2077,7 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 		if (sctx->curr != -1) {
 			sctx->first_free = sctx->bios[sctx->curr]->next_free;
 			sctx->bios[sctx->curr]->next_free = -1;
-			sctx->bios[sctx->curr]->page_count = 0;
+			sctx->bios[sctx->curr]->sector_count = 0;
 			spin_unlock(&sctx->list_lock);
 		} else {
 			spin_unlock(&sctx->list_lock);
@@ -2085,7 +2085,7 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 		}
 	}
 	sbio = sctx->bios[sctx->curr];
-	if (sbio->page_count == 0) {
+	if (sbio->sector_count == 0) {
 		struct bio *bio;
 
 		sbio->physical = sector->physical;
@@ -2093,7 +2093,7 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->dev = sector->dev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_bio_alloc(sctx->pages_per_bio);
+			bio = btrfs_bio_alloc(sctx->sectors_per_bio);
 			sbio->bio = bio;
 		}
 
@@ -2103,19 +2103,19 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 		bio->bi_iter.bi_sector = sbio->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 		sbio->status = 0;
-	} else if (sbio->physical + sbio->page_count * sectorsize !=
+	} else if (sbio->physical + sbio->sector_count * sectorsize !=
 		   sector->physical ||
-		   sbio->logical + sbio->page_count * sectorsize !=
+		   sbio->logical + sbio->sector_count * sectorsize !=
 		   sector->logical ||
 		   sbio->dev != sector->dev) {
 		scrub_submit(sctx);
 		goto again;
 	}
 
-	sbio->pagev[sbio->page_count] = sector;
+	sbio->sectors[sbio->sector_count] = sector;
 	ret = bio_add_page(sbio->bio, sector->page, sectorsize, 0);
 	if (ret != sectorsize) {
-		if (sbio->page_count < 1) {
+		if (sbio->sector_count < 1) {
 			bio_put(sbio->bio);
 			sbio->bio = NULL;
 			return -EIO;
@@ -2126,8 +2126,8 @@ static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 
 	scrub_block_get(sblock); /* one for the page added to the bio */
 	atomic_inc(&sblock->outstanding_sectors);
-	sbio->page_count++;
-	if (sbio->page_count == sctx->pages_per_bio)
+	sbio->sector_count++;
+	if (sbio->sector_count == sctx->sectors_per_bio)
 		scrub_submit(sctx);
 
 	return 0;
@@ -2361,10 +2361,10 @@ static void scrub_bio_end_io_worker(struct btrfs_work *work)
 	struct scrub_ctx *sctx = sbio->sctx;
 	int i;
 
-	ASSERT(sbio->page_count <= SCRUB_PAGES_PER_BIO);
+	ASSERT(sbio->sector_count <= SCRUB_SECTORS_PER_BIO);
 	if (sbio->status) {
-		for (i = 0; i < sbio->page_count; i++) {
-			struct scrub_sector *sector = sbio->pagev[i];
+		for (i = 0; i < sbio->sector_count; i++) {
+			struct scrub_sector *sector = sbio->sectors[i];
 
 			sector->io_error = 1;
 			sector->sblock->no_io_error_seen = 0;
@@ -2372,8 +2372,8 @@ static void scrub_bio_end_io_worker(struct btrfs_work *work)
 	}
 
 	/* Now complete the scrub_block items that have all pages completed */
-	for (i = 0; i < sbio->page_count; i++) {
-		struct scrub_sector *sector = sbio->pagev[i];
+	for (i = 0; i < sbio->sector_count; i++) {
+		struct scrub_sector *sector = sbio->sectors[i];
 		struct scrub_block *sblock = sector->sblock;
 
 		if (atomic_dec_and_test(&sblock->outstanding_sectors))
-- 
2.35.1

