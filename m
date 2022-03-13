Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8944D7445
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Mar 2022 11:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiCMKlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Mar 2022 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiCMKle (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Mar 2022 06:41:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEE322B11
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 03:40:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CFAF1F394
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647168023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XK+4aaatqVlFs2I1AnRHEioLnxIjt5Nti3ehbNSofkg=;
        b=bybiIIgCFVq+orRcAOws1WEUT0u9YLVTa/5OdZU52KNOIKFnF9TbRsqmLuPqc9aDIrSX/j
        k/Wa/xSJNcK0YA6VyGdcOC7T/Tkqu6A0VGI3iFt6okjh/L3BmCIUqLwGqYeQcyFHmb0UJz
        nTDboakRYfSsdcSTwhisn3926z5IpCY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F80713AF7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YFbFBhbKLWLUFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 10:40:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: scrub: rename scrub_page to scrub_sector
Date:   Sun, 13 Mar 2022 18:40:01 +0800
Message-Id: <09b66a70a0aac8564c7da52ca086c446b56444ab.1647161284.git.wqu@suse.com>
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

Since the subpage support of scrub, scrub_sector is in fact just
representing one sector.

Thus the name scrub_page is no longer correct, rename it to
scrub_sector.

This also involves the following renames:

- spage -> sector
  Normally we would just replace "page" with "sector" and result
  something like "ssector".
  But the repeating 's' is not really eye friendly.

  So here we just simple use "sector", as there is nothing from MM layer
  called "sector" to cause any confusion.

- scrub_parity::spages -> sectors_list
  Normally we use plural to indicate an array, not a list.
  Rename it to @sectors_list to be more explicit on the list part.

- Also update involved comments to follow the latest comment style
  Mainly use upper charactor for the first word.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 464 +++++++++++++++++++++++------------------------
 1 file changed, 232 insertions(+), 232 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 49581a2d0831..eb143ff7f8d8 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -60,7 +60,7 @@ struct scrub_recover {
 	u64			map_length;
 };
 
-struct scrub_page {
+struct scrub_sector {
 	struct scrub_block	*sblock;
 	struct page		*page;
 	struct btrfs_device	*dev;
@@ -87,16 +87,16 @@ struct scrub_bio {
 	blk_status_t		status;
 	u64			logical;
 	u64			physical;
-	struct scrub_page	*pagev[SCRUB_PAGES_PER_BIO];
+	struct scrub_sector	*pagev[SCRUB_PAGES_PER_BIO];
 	int			page_count;
 	int			next_free;
 	struct btrfs_work	work;
 };
 
 struct scrub_block {
-	struct scrub_page	*sectors[SCRUB_MAX_SECTORS_PER_BLOCK];
+	struct scrub_sector	*sectors[SCRUB_MAX_SECTORS_PER_BLOCK];
 	int			sector_count;
-	atomic_t		outstanding_pages;
+	atomic_t		outstanding_sectors;
 	refcount_t		refs; /* free mem on transition to zero */
 	struct scrub_ctx	*sctx;
 	struct scrub_parity	*sparity;
@@ -129,7 +129,7 @@ struct scrub_parity {
 
 	refcount_t		refs;
 
-	struct list_head	spages;
+	struct list_head	sectors_list;
 
 	/* Work of parity check and repair */
 	struct btrfs_work	work;
@@ -212,24 +212,24 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 static void scrub_recheck_block_checksum(struct scrub_block *sblock);
 static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
 					     struct scrub_block *sblock_good);
-static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
+static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 					    struct scrub_block *sblock_good,
-					    int page_num, int force_write);
+					    int sector_num, int force_write);
 static void scrub_write_block_to_dev_replace(struct scrub_block *sblock);
-static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
-					   int page_num);
+static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
+					     int sector_num);
 static int scrub_checksum_data(struct scrub_block *sblock);
 static int scrub_checksum_tree_block(struct scrub_block *sblock);
 static int scrub_checksum_super(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
-static void scrub_page_get(struct scrub_page *spage);
-static void scrub_page_put(struct scrub_page *spage);
+static void scrub_sector_get(struct scrub_sector *sector);
+static void scrub_sector_put(struct scrub_sector *sector);
 static void scrub_parity_get(struct scrub_parity *sparity);
 static void scrub_parity_put(struct scrub_parity *sparity);
-static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
-		       u64 physical, struct btrfs_device *dev, u64 flags,
-		       u64 gen, int mirror_num, u8 *csum,
-		       u64 physical_for_dev_replace);
+static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
+			 u64 physical, struct btrfs_device *dev, u64 flags,
+			 u64 gen, int mirror_num, u8 *csum,
+			 u64 physical_for_dev_replace);
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct btrfs_work *work);
 static void scrub_block_complete(struct scrub_block *sblock);
@@ -238,17 +238,17 @@ static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
 			       u64 *extent_physical,
 			       struct btrfs_device **extent_dev,
 			       int *extent_mirror_num);
-static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
-				    struct scrub_page *spage);
+static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
+				      struct scrub_sector *sector);
 static void scrub_wr_submit(struct scrub_ctx *sctx);
 static void scrub_wr_bio_end_io(struct bio *bio);
 static void scrub_wr_bio_end_io_worker(struct btrfs_work *work);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
-static inline int scrub_is_page_on_raid56(struct scrub_page *spage)
+static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
 {
-	return spage->recover &&
-	       (spage->recover->bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+	return sector->recover &&
+	       (sector->recover->bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 }
 
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
@@ -798,8 +798,8 @@ static inline void scrub_put_recover(struct btrfs_fs_info *fs_info,
 
 /*
  * scrub_handle_errored_block gets called when either verification of the
- * pages failed or the bio failed to read, e.g. with EIO. In the latter
- * case, this function handles all pages in the bio, even though only one
+ * sectors failed or the bio failed to read, e.g. with EIO. In the latter
+ * case, this function handles all sectors in the bio, even though only one
  * may be bad.
  * The goal of this function is to repair the errored block by using the
  * contents of one of the mirrors.
@@ -854,7 +854,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	 * might be waiting the scrub task to pause (which needs to wait for all
 	 * the worker tasks to complete before pausing).
 	 * We do allocations in the workers through insert_full_stripe_lock()
-	 * and scrub_add_page_to_wr_bio(), which happens down the call chain of
+	 * and scrub_add_sector_to_wr_bio(), which happens down the call chain of
 	 * this function.
 	 */
 	nofs_flag = memalloc_nofs_save();
@@ -918,7 +918,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		goto out;
 	}
 
-	/* setup the context, map the logical blocks and alloc the pages */
+	/* Setup the context, map the logical blocks and alloc the sectors */
 	ret = scrub_setup_recheck_block(sblock_to_check, sblocks_for_recheck);
 	if (ret) {
 		spin_lock(&sctx->stat_lock);
@@ -937,7 +937,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	if (!sblock_bad->header_error && !sblock_bad->checksum_error &&
 	    sblock_bad->no_io_error_seen) {
 		/*
-		 * the error disappeared after reading page by page, or
+		 * The error disappeared after reading sector by sector, or
 		 * the area was part of a huge bio and other parts of the
 		 * bio caused I/O errors, or the block layer merged several
 		 * read requests into one and the error is caused by a
@@ -998,10 +998,10 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	 * that is known to contain an error is rewritten. Afterwards
 	 * the block is known to be corrected.
 	 * If a mirror is found which is completely correct, and no
-	 * checksum is present, only those pages are rewritten that had
+	 * checksum is present, only those sectors are rewritten that had
 	 * an I/O error in the block to be repaired, since it cannot be
-	 * determined, which copy of the other pages is better (and it
-	 * could happen otherwise that a correct page would be
+	 * determined, which copy of the other sectors is better (and it
+	 * could happen otherwise that a correct sector would be
 	 * overwritten by a bad one).
 	 */
 	for (mirror_index = 0; ;mirror_index++) {
@@ -1080,11 +1080,11 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	success = 1;
 	for (sector_num = 0; sector_num < sblock_bad->sector_count;
 	     sector_num++) {
-		struct scrub_page *spage_bad = sblock_bad->sectors[sector_num];
+		struct scrub_sector *sector_bad = sblock_bad->sectors[sector_num];
 		struct scrub_block *sblock_other = NULL;
 
-		/* skip no-io-error page in scrub */
-		if (!spage_bad->io_error && !sctx->is_dev_replace)
+		/* Skip no-io-error sectors in scrub */
+		if (!sector_bad->io_error && !sctx->is_dev_replace)
 			continue;
 
 		if (scrub_is_page_on_raid56(sblock_bad->sectors[0])) {
@@ -1096,8 +1096,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			 * sblock_for_recheck array to target device.
 			 */
 			sblock_other = NULL;
-		} else if (spage_bad->io_error) {
-			/* try to find no-io-error page in mirrors */
+		} else if (sector_bad->io_error) {
+			/* Try to find no-io-error sector in mirrors */
 			for (mirror_index = 0;
 			     mirror_index < BTRFS_MAX_MIRRORS &&
 			     sblocks_for_recheck[mirror_index].sector_count > 0;
@@ -1115,27 +1115,27 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 
 		if (sctx->is_dev_replace) {
 			/*
-			 * did not find a mirror to fetch the page
-			 * from. scrub_write_page_to_dev_replace()
-			 * handles this case (page->io_error), by
+			 * Did not find a mirror to fetch the sector
+			 * from. scrub_write_sector_to_dev_replace()
+			 * handles this case (sector->io_error), by
 			 * filling the block with zeros before
 			 * submitting the write request
 			 */
 			if (!sblock_other)
 				sblock_other = sblock_bad;
 
-			if (scrub_write_page_to_dev_replace(sblock_other,
-							    sector_num) != 0) {
+			if (scrub_write_sector_to_dev_replace(sblock_other,
+							      sector_num) != 0) {
 				atomic64_inc(
 					&fs_info->dev_replace.num_write_errors);
 				success = 0;
 			}
 		} else if (sblock_other) {
-			ret = scrub_repair_page_from_good_copy(sblock_bad,
-							       sblock_other,
-							       sector_num, 0);
+			ret = scrub_repair_sector_from_good_copy(sblock_bad,
+								 sblock_other,
+								 sector_num, 0);
 			if (0 == ret)
-				spage_bad->io_error = 0;
+				sector_bad->io_error = 0;
 			else
 				success = 0;
 		}
@@ -1197,7 +1197,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 					sblock->sectors[sector_index]->recover =
 									NULL;
 				}
-				scrub_page_put(sblock->sectors[sector_index]);
+				scrub_sector_put(sblock->sectors[sector_index]);
 			}
 		}
 		kfree(sblocks_for_recheck);
@@ -1272,7 +1272,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 	int ret;
 
 	/*
-	 * note: the two members refs and outstanding_pages
+	 * note: the two members refs and outstanding_sectors
 	 * are not used (and not set) in the blocks that are used for
 	 * the recheck procedure
 	 */
@@ -1313,13 +1313,13 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 		for (mirror_index = 0; mirror_index < nmirrors;
 		     mirror_index++) {
 			struct scrub_block *sblock;
-			struct scrub_page *spage;
+			struct scrub_sector *sector;
 
 			sblock = sblocks_for_recheck + mirror_index;
 			sblock->sctx = sctx;
 
-			spage = kzalloc(sizeof(*spage), GFP_NOFS);
-			if (!spage) {
+			sector = kzalloc(sizeof(*sector), GFP_NOFS);
+			if (!sector) {
 leave_nomem:
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
@@ -1327,15 +1327,15 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				scrub_put_recover(fs_info, recover);
 				return -ENOMEM;
 			}
-			scrub_page_get(spage);
-			sblock->sectors[sector_index] = spage;
-			spage->sblock = sblock;
-			spage->flags = flags;
-			spage->generation = generation;
-			spage->logical = logical;
-			spage->have_csum = have_csum;
+			scrub_sector_get(sector);
+			sblock->sectors[sector_index] = sector;
+			sector->sblock = sblock;
+			sector->flags = flags;
+			sector->generation = generation;
+			sector->logical = logical;
+			sector->have_csum = have_csum;
 			if (have_csum)
-				memcpy(spage->csum,
+				memcpy(sector->csum,
 				       original_sblock->sectors[0]->csum,
 				       sctx->fs_info->csum_size);
 
@@ -1348,23 +1348,23 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 						      mirror_index,
 						      &stripe_index,
 						      &stripe_offset);
-			spage->physical = bioc->stripes[stripe_index].physical +
+			sector->physical = bioc->stripes[stripe_index].physical +
 					 stripe_offset;
-			spage->dev = bioc->stripes[stripe_index].dev;
+			sector->dev = bioc->stripes[stripe_index].dev;
 
 			BUG_ON(sector_index >= original_sblock->sector_count);
-			spage->physical_for_dev_replace =
+			sector->physical_for_dev_replace =
 				original_sblock->sectors[sector_index]->
 				physical_for_dev_replace;
-			/* for missing devices, dev->bdev is NULL */
-			spage->mirror_num = mirror_index + 1;
+			/* For missing devices, dev->bdev is NULL */
+			sector->mirror_num = mirror_index + 1;
 			sblock->sector_count++;
-			spage->page = alloc_page(GFP_NOFS);
-			if (!spage->page)
+			sector->page = alloc_page(GFP_NOFS);
+			if (!sector->page)
 				goto leave_nomem;
 
 			scrub_get_recover(recover);
-			spage->recover = recover;
+			sector->recover = recover;
 		}
 		scrub_put_recover(fs_info, recover);
 		length -= sublen;
@@ -1382,19 +1382,19 @@ static void scrub_bio_wait_endio(struct bio *bio)
 
 static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 					struct bio *bio,
-					struct scrub_page *spage)
+					struct scrub_sector *sector)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	int ret;
 	int mirror_num;
 
-	bio->bi_iter.bi_sector = spage->logical >> 9;
+	bio->bi_iter.bi_sector = sector->logical >> 9;
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
 
-	mirror_num = spage->sblock->sectors[0]->mirror_num;
-	ret = raid56_parity_recover(bio, spage->recover->bioc,
-				    spage->recover->map_length,
+	mirror_num = sector->sblock->sectors[0]->mirror_num;
+	ret = raid56_parity_recover(bio, sector->recover->bioc,
+				    sector->recover->map_length,
 				    mirror_num, 0);
 	if (ret)
 		return ret;
@@ -1406,26 +1406,26 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 					  struct scrub_block *sblock)
 {
-	struct scrub_page *first_page = sblock->sectors[0];
+	struct scrub_sector *first_sector = sblock->sectors[0];
 	struct bio *bio;
 	int i;
 
-	/* All pages in sblock belong to the same stripe on the same device. */
-	ASSERT(first_page->dev);
-	if (!first_page->dev->bdev)
+	/* All sectors in sblock belong to the same stripe on the same device. */
+	ASSERT(first_sector->dev);
+	if (!first_sector->dev->bdev)
 		goto out;
 
 	bio = btrfs_bio_alloc(BIO_MAX_VECS);
-	bio_set_dev(bio, first_page->dev->bdev);
+	bio_set_dev(bio, first_sector->dev->bdev);
 
 	for (i = 0; i < sblock->sector_count; i++) {
-		struct scrub_page *spage = sblock->sectors[i];
+		struct scrub_sector *sector = sblock->sectors[i];
 
-		WARN_ON(!spage->page);
-		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
+		WARN_ON(!sector->page);
+		bio_add_page(bio, sector->page, PAGE_SIZE, 0);
 	}
 
-	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_page)) {
+	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_sector)) {
 		bio_put(bio);
 		goto out;
 	}
@@ -1443,11 +1443,11 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * this function will check the on disk data for checksum errors, header
- * errors and read I/O errors. If any I/O errors happen, the exact pages
+ * This function will check the on disk data for checksum errors, header
+ * errors and read I/O errors. If any I/O errors happen, the exact sectors
  * which are errored are marked as being bad. The goal is to enable scrub
- * to take those pages that are not errored from all the mirrors so that
- * the pages that are errored in the just handled mirror can be repaired.
+ * to take those sectors that are not errored from all the mirrors so that
+ * the sectors that are errored in the just handled mirror can be repaired.
  */
 static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 				struct scrub_block *sblock,
@@ -1463,24 +1463,24 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct bio *bio;
-		struct scrub_page *spage = sblock->sectors[i];
+		struct scrub_sector *sector = sblock->sectors[i];
 
-		if (spage->dev->bdev == NULL) {
-			spage->io_error = 1;
+		if (sector->dev->bdev == NULL) {
+			sector->io_error = 1;
 			sblock->no_io_error_seen = 0;
 			continue;
 		}
 
-		WARN_ON(!spage->page);
+		WARN_ON(!sector->page);
 		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, spage->dev->bdev);
+		bio_set_dev(bio, sector->dev->bdev);
 
-		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
-		bio->bi_iter.bi_sector = spage->physical >> 9;
+		bio_add_page(bio, sector->page, fs_info->sectorsize, 0);
+		bio->bi_iter.bi_sector = sector->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 
 		if (btrfsic_submit_bio_wait(bio)) {
-			spage->io_error = 1;
+			sector->io_error = 1;
 			sblock->no_io_error_seen = 0;
 		}
 
@@ -1492,9 +1492,9 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 }
 
 static inline int scrub_check_fsid(u8 fsid[],
-				   struct scrub_page *spage)
+				   struct scrub_sector *sector)
 {
-	struct btrfs_fs_devices *fs_devices = spage->dev->fs_devices;
+	struct btrfs_fs_devices *fs_devices = sector->dev->fs_devices;
 	int ret;
 
 	ret = memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
@@ -1522,8 +1522,8 @@ static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
 	for (i = 0; i < sblock_bad->sector_count; i++) {
 		int ret_sub;
 
-		ret_sub = scrub_repair_page_from_good_copy(sblock_bad,
-							   sblock_good, i, 1);
+		ret_sub = scrub_repair_sector_from_good_copy(sblock_bad,
+							     sblock_good, i, 1);
 		if (ret_sub)
 			ret = ret_sub;
 	}
@@ -1531,41 +1531,41 @@ static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
 	return ret;
 }
 
-static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
-					    struct scrub_block *sblock_good,
-					    int sector_num, int force_write)
+static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
+					      struct scrub_block *sblock_good,
+					      int sector_num, int force_write)
 {
-	struct scrub_page *spage_bad = sblock_bad->sectors[sector_num];
-	struct scrub_page *spage_good = sblock_good->sectors[sector_num];
+	struct scrub_sector *sector_bad = sblock_bad->sectors[sector_num];
+	struct scrub_sector *sector_good = sblock_good->sectors[sector_num];
 	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 
-	BUG_ON(spage_bad->page == NULL);
-	BUG_ON(spage_good->page == NULL);
+	BUG_ON(sector_bad->page == NULL);
+	BUG_ON(sector_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
-	    sblock_bad->checksum_error || spage_bad->io_error) {
+	    sblock_bad->checksum_error || sector_bad->io_error) {
 		struct bio *bio;
 		int ret;
 
-		if (!spage_bad->dev->bdev) {
+		if (!sector_bad->dev->bdev) {
 			btrfs_warn_rl(fs_info,
 				"scrub_repair_page_from_good_copy(bdev == NULL) is unexpected");
 			return -EIO;
 		}
 
 		bio = btrfs_bio_alloc(1);
-		bio_set_dev(bio, spage_bad->dev->bdev);
-		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
+		bio_set_dev(bio, sector_bad->dev->bdev);
+		bio->bi_iter.bi_sector = sector_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 
-		ret = bio_add_page(bio, spage_good->page, sectorsize, 0);
+		ret = bio_add_page(bio, sector_good->page, sectorsize, 0);
 		if (ret != sectorsize) {
 			bio_put(bio);
 			return -EIO;
 		}
 
 		if (btrfsic_submit_bio_wait(bio)) {
-			btrfs_dev_stat_inc_and_print(spage_bad->dev,
+			btrfs_dev_stat_inc_and_print(sector_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
 			bio_put(bio);
@@ -1592,22 +1592,22 @@ static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
 	for (i = 0; i < sblock->sector_count; i++) {
 		int ret;
 
-		ret = scrub_write_page_to_dev_replace(sblock, i);
+		ret = scrub_write_sector_to_dev_replace(sblock, i);
 		if (ret)
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
 	}
 }
 
-static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
-					   int sector_num)
+static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
+					     int sector_num)
 {
-	struct scrub_page *spage = sblock->sectors[sector_num];
+	struct scrub_sector *sector = sblock->sectors[sector_num];
 
-	BUG_ON(spage->page == NULL);
-	if (spage->io_error)
-		clear_page(page_address(spage->page));
+	BUG_ON(sector->page == NULL);
+	if (sector->io_error)
+		clear_page(page_address(sector->page));
 
-	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
+	return scrub_add_sector_to_wr_bio(sblock->sctx, sector);
 }
 
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
@@ -1632,8 +1632,8 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	return ret;
 }
 
-static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
-				    struct scrub_page *spage)
+static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
+				    struct scrub_sector *sector)
 {
 	struct scrub_bio *sbio;
 	int ret;
@@ -1656,14 +1656,14 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		struct bio *bio;
 
 		ret = fill_writer_pointer_gap(sctx,
-					      spage->physical_for_dev_replace);
+					      sector->physical_for_dev_replace);
 		if (ret) {
 			mutex_unlock(&sctx->wr_lock);
 			return ret;
 		}
 
-		sbio->physical = spage->physical_for_dev_replace;
-		sbio->logical = spage->logical;
+		sbio->physical = sector->physical_for_dev_replace;
+		sbio->logical = sector->logical;
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
@@ -1678,14 +1678,14 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		bio->bi_opf = REQ_OP_WRITE;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->page_count * sectorsize !=
-		   spage->physical_for_dev_replace ||
+		   sector->physical_for_dev_replace ||
 		   sbio->logical + sbio->page_count * sectorsize !=
-		   spage->logical) {
+		   sector->logical) {
 		scrub_wr_submit(sctx);
 		goto again;
 	}
 
-	ret = bio_add_page(sbio->bio, spage->page, sectorsize, 0);
+	ret = bio_add_page(sbio->bio, sector->page, sectorsize, 0);
 	if (ret != sectorsize) {
 		if (sbio->page_count < 1) {
 			bio_put(sbio->bio);
@@ -1697,8 +1697,8 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		goto again;
 	}
 
-	sbio->pagev[sbio->page_count] = spage;
-	scrub_page_get(spage);
+	sbio->pagev[sbio->page_count] = sector;
+	scrub_sector_get(sector);
 	sbio->page_count++;
 	if (sbio->page_count == sctx->pages_per_bio)
 		scrub_wr_submit(sctx);
@@ -1753,15 +1753,15 @@ static void scrub_wr_bio_end_io_worker(struct btrfs_work *work)
 			&sbio->sctx->fs_info->dev_replace;
 
 		for (i = 0; i < sbio->page_count; i++) {
-			struct scrub_page *spage = sbio->pagev[i];
+			struct scrub_sector *sector = sbio->pagev[i];
 
-			spage->io_error = 1;
+			sector->io_error = 1;
 			atomic64_inc(&dev_replace->num_write_errors);
 		}
 	}
 
 	for (i = 0; i < sbio->page_count; i++)
-		scrub_page_put(sbio->pagev[i]);
+		scrub_sector_put(sbio->pagev[i]);
 
 	bio_put(sbio->bio);
 	kfree(sbio);
@@ -1808,26 +1808,26 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 csum[BTRFS_CSUM_SIZE];
-	struct scrub_page *spage;
+	struct scrub_sector *sector;
 	char *kaddr;
 
 	BUG_ON(sblock->sector_count < 1);
-	spage = sblock->sectors[0];
-	if (!spage->have_csum)
+	sector = sblock->sectors[0];
+	if (!sector->have_csum)
 		return 0;
 
-	kaddr = page_address(spage->page);
+	kaddr = page_address(sector->page);
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 
 	/*
-	 * In scrub_pages() and scrub_pages_for_parity() we ensure each spage
+	 * In scrub_sectors() and scrub_sectors_for_parity() we ensure each sector
 	 * only contains one sector of data.
 	 */
 	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
 
-	if (memcmp(csum, spage->csum, fs_info->csum_size))
+	if (memcmp(csum, sector->csum, fs_info->csum_size))
 		sblock->checksum_error = 1;
 	return sblock->checksum_error;
 }
@@ -1848,16 +1848,16 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	const int num_sectors = fs_info->nodesize >> fs_info->sectorsize_bits;
 	int i;
-	struct scrub_page *spage;
+	struct scrub_sector *sector;
 	char *kaddr;
 
 	BUG_ON(sblock->sector_count < 1);
 
-	/* Each member in pagev is just one sector , not a full page */
+	/* Each member in sectorv is just one sector */
 	ASSERT(sblock->sector_count == num_sectors);
 
-	spage = sblock->sectors[0];
-	kaddr = page_address(spage->page);
+	sector = sblock->sectors[0];
+	kaddr = page_address(sector->page);
 	h = (struct btrfs_header *)kaddr;
 	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
 
@@ -1866,15 +1866,15 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	 * a) don't have an extent buffer and
 	 * b) the page is already kmapped
 	 */
-	if (spage->logical != btrfs_stack_header_bytenr(h))
+	if (sector->logical != btrfs_stack_header_bytenr(h))
 		sblock->header_error = 1;
 
-	if (spage->generation != btrfs_stack_header_generation(h)) {
+	if (sector->generation != btrfs_stack_header_generation(h)) {
 		sblock->header_error = 1;
 		sblock->generation_error = 1;
 	}
 
-	if (!scrub_check_fsid(h->fsid, spage))
+	if (!scrub_check_fsid(h->fsid, sector))
 		sblock->header_error = 1;
 
 	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
@@ -1905,23 +1905,23 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
-	struct scrub_page *spage;
+	struct scrub_sector *sector;
 	char *kaddr;
 	int fail_gen = 0;
 	int fail_cor = 0;
 
 	BUG_ON(sblock->sector_count < 1);
-	spage = sblock->sectors[0];
-	kaddr = page_address(spage->page);
+	sector = sblock->sectors[0];
+	kaddr = page_address(sector->page);
 	s = (struct btrfs_super_block *)kaddr;
 
-	if (spage->logical != btrfs_super_bytenr(s))
+	if (sector->logical != btrfs_super_bytenr(s))
 		++fail_cor;
 
-	if (spage->generation != btrfs_super_generation(s))
+	if (sector->generation != btrfs_super_generation(s))
 		++fail_gen;
 
-	if (!scrub_check_fsid(s->fsid, spage))
+	if (!scrub_check_fsid(s->fsid, sector))
 		++fail_cor;
 
 	shash->tfm = fs_info->csum_shash;
@@ -1942,10 +1942,10 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		++sctx->stat.super_errors;
 		spin_unlock(&sctx->stat_lock);
 		if (fail_cor)
-			btrfs_dev_stat_inc_and_print(spage->dev,
+			btrfs_dev_stat_inc_and_print(sector->dev,
 				BTRFS_DEV_STAT_CORRUPTION_ERRS);
 		else
-			btrfs_dev_stat_inc_and_print(spage->dev,
+			btrfs_dev_stat_inc_and_print(sector->dev,
 				BTRFS_DEV_STAT_GENERATION_ERRS);
 	}
 
@@ -1966,22 +1966,22 @@ static void scrub_block_put(struct scrub_block *sblock)
 			scrub_parity_put(sblock->sparity);
 
 		for (i = 0; i < sblock->sector_count; i++)
-			scrub_page_put(sblock->sectors[i]);
+			scrub_sector_put(sblock->sectors[i]);
 		kfree(sblock);
 	}
 }
 
-static void scrub_page_get(struct scrub_page *spage)
+static void scrub_sector_get(struct scrub_sector *sector)
 {
-	atomic_inc(&spage->refs);
+	atomic_inc(&sector->refs);
 }
 
-static void scrub_page_put(struct scrub_page *spage)
+static void scrub_sector_put(struct scrub_sector *sector)
 {
-	if (atomic_dec_and_test(&spage->refs)) {
-		if (spage->page)
-			__free_page(spage->page);
-		kfree(spage);
+	if (atomic_dec_and_test(&sector->refs)) {
+		if (sector->page)
+			__free_page(sector->page);
+		kfree(sector);
 	}
 }
 
@@ -2059,10 +2059,10 @@ static void scrub_submit(struct scrub_ctx *sctx)
 	btrfsic_submit_bio(sbio->bio);
 }
 
-static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
-				    struct scrub_page *spage)
+static int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
+				      struct scrub_sector *sector)
 {
-	struct scrub_block *sblock = spage->sblock;
+	struct scrub_block *sblock = sector->sblock;
 	struct scrub_bio *sbio;
 	const u32 sectorsize = sctx->fs_info->sectorsize;
 	int ret;
@@ -2088,9 +2088,9 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	if (sbio->page_count == 0) {
 		struct bio *bio;
 
-		sbio->physical = spage->physical;
-		sbio->logical = spage->logical;
-		sbio->dev = spage->dev;
+		sbio->physical = sector->physical;
+		sbio->logical = sector->logical;
+		sbio->dev = sector->dev;
 		bio = sbio->bio;
 		if (!bio) {
 			bio = btrfs_bio_alloc(sctx->pages_per_bio);
@@ -2104,16 +2104,16 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		bio->bi_opf = REQ_OP_READ;
 		sbio->status = 0;
 	} else if (sbio->physical + sbio->page_count * sectorsize !=
-		   spage->physical ||
+		   sector->physical ||
 		   sbio->logical + sbio->page_count * sectorsize !=
-		   spage->logical ||
-		   sbio->dev != spage->dev) {
+		   sector->logical ||
+		   sbio->dev != sector->dev) {
 		scrub_submit(sctx);
 		goto again;
 	}
 
-	sbio->pagev[sbio->page_count] = spage;
-	ret = bio_add_page(sbio->bio, spage->page, sectorsize, 0);
+	sbio->pagev[sbio->page_count] = sector;
+	ret = bio_add_page(sbio->bio, sector->page, sectorsize, 0);
 	if (ret != sectorsize) {
 		if (sbio->page_count < 1) {
 			bio_put(sbio->bio);
@@ -2125,7 +2125,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 	}
 
 	scrub_block_get(sblock); /* one for the page added to the bio */
-	atomic_inc(&sblock->outstanding_pages);
+	atomic_inc(&sblock->outstanding_sectors);
 	sbio->page_count++;
 	if (sbio->page_count == sctx->pages_per_bio)
 		scrub_submit(sctx);
@@ -2227,9 +2227,9 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto rbio_out;
 
 	for (i = 0; i < sblock->sector_count; i++) {
-		struct scrub_page *spage = sblock->sectors[i];
+		struct scrub_sector *sector = sblock->sectors[i];
 
-		raid56_add_scrub_pages(rbio, spage->page, spage->logical);
+		raid56_add_scrub_pages(rbio, sector->page, sector->logical);
 	}
 
 	btrfs_init_work(&sblock->work, scrub_missing_raid56_worker, NULL, NULL);
@@ -2248,7 +2248,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	spin_unlock(&sctx->stat_lock);
 }
 
-static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
+static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
 		       u64 gen, int mirror_num, u8 *csum,
 		       u64 physical_for_dev_replace)
@@ -2272,7 +2272,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 	sblock->no_io_error_seen = 1;
 
 	for (index = 0; len > 0; index++) {
-		struct scrub_page *spage;
+		struct scrub_sector *sector;
 		/*
 		 * Here we will allocate one page for one sector to scrub.
 		 * This is fine if PAGE_SIZE == sectorsize, but will cost
@@ -2280,8 +2280,8 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
-		if (!spage) {
+		sector = kzalloc(sizeof(*sector), GFP_KERNEL);
+		if (!sector) {
 leave_nomem:
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2290,25 +2290,25 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 			return -ENOMEM;
 		}
 		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
-		scrub_page_get(spage);
-		sblock->sectors[index] = spage;
-		spage->sblock = sblock;
-		spage->dev = dev;
-		spage->flags = flags;
-		spage->generation = gen;
-		spage->logical = logical;
-		spage->physical = physical;
-		spage->physical_for_dev_replace = physical_for_dev_replace;
-		spage->mirror_num = mirror_num;
+		scrub_sector_get(sector);
+		sblock->sectors[index] = sector;
+		sector->sblock = sblock;
+		sector->dev = dev;
+		sector->flags = flags;
+		sector->generation = gen;
+		sector->logical = logical;
+		sector->physical = physical;
+		sector->physical_for_dev_replace = physical_for_dev_replace;
+		sector->mirror_num = mirror_num;
 		if (csum) {
-			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->fs_info->csum_size);
+			sector->have_csum = 1;
+			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
 		} else {
-			spage->have_csum = 0;
+			sector->have_csum = 0;
 		}
 		sblock->sector_count++;
-		spage->page = alloc_page(GFP_KERNEL);
-		if (!spage->page)
+		sector->page = alloc_page(GFP_KERNEL);
+		if (!sector->page)
 			goto leave_nomem;
 		len -= l;
 		logical += l;
@@ -2325,10 +2325,10 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 		scrub_missing_raid56_pages(sblock);
 	} else {
 		for (index = 0; index < sblock->sector_count; index++) {
-			struct scrub_page *spage = sblock->sectors[index];
+			struct scrub_sector *sector = sblock->sectors[index];
 			int ret;
 
-			ret = scrub_add_page_to_rd_bio(sctx, spage);
+			ret = scrub_add_sector_to_rd_bio(sctx, sector);
 			if (ret) {
 				scrub_block_put(sblock);
 				return ret;
@@ -2364,19 +2364,19 @@ static void scrub_bio_end_io_worker(struct btrfs_work *work)
 	ASSERT(sbio->page_count <= SCRUB_PAGES_PER_BIO);
 	if (sbio->status) {
 		for (i = 0; i < sbio->page_count; i++) {
-			struct scrub_page *spage = sbio->pagev[i];
+			struct scrub_sector *sector = sbio->pagev[i];
 
-			spage->io_error = 1;
-			spage->sblock->no_io_error_seen = 0;
+			sector->io_error = 1;
+			sector->sblock->no_io_error_seen = 0;
 		}
 	}
 
-	/* now complete the scrub_block items that have all pages completed */
+	/* Now complete the scrub_block items that have all pages completed */
 	for (i = 0; i < sbio->page_count; i++) {
-		struct scrub_page *spage = sbio->pagev[i];
-		struct scrub_block *sblock = spage->sblock;
+		struct scrub_sector *sector = sbio->pagev[i];
+		struct scrub_block *sblock = sector->sblock;
 
-		if (atomic_dec_and_test(&sblock->outstanding_pages))
+		if (atomic_dec_and_test(&sblock->outstanding_sectors))
 			scrub_block_complete(sblock);
 		scrub_block_put(sblock);
 	}
@@ -2570,7 +2570,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 			if (have_csum == 0)
 				++sctx->stat.no_csum;
 		}
-		ret = scrub_pages(sctx, logical, l, physical, dev, flags, gen,
+		ret = scrub_sectors(sctx, logical, l, physical, dev, flags, gen,
 				  mirror_num, have_csum ? csum : NULL,
 				  physical_for_dev_replace);
 		if (ret)
@@ -2583,7 +2583,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 	return 0;
 }
 
-static int scrub_pages_for_parity(struct scrub_parity *sparity,
+static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 				  u64 logical, u32 len,
 				  u64 physical, struct btrfs_device *dev,
 				  u64 flags, u64 gen, int mirror_num, u8 *csum)
@@ -2612,10 +2612,10 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 	scrub_parity_get(sparity);
 
 	for (index = 0; len > 0; index++) {
-		struct scrub_page *spage;
+		struct scrub_sector *sector;
 
-		spage = kzalloc(sizeof(*spage), GFP_KERNEL);
-		if (!spage) {
+		sector = kzalloc(sizeof(*sector), GFP_KERNEL);
+		if (!sector) {
 leave_nomem:
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2625,27 +2625,27 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		}
 		ASSERT(index < SCRUB_MAX_SECTORS_PER_BLOCK);
 		/* For scrub block */
-		scrub_page_get(spage);
-		sblock->sectors[index] = spage;
+		scrub_sector_get(sector);
+		sblock->sectors[index] = sector;
 		/* For scrub parity */
-		scrub_page_get(spage);
-		list_add_tail(&spage->list, &sparity->spages);
-		spage->sblock = sblock;
-		spage->dev = dev;
-		spage->flags = flags;
-		spage->generation = gen;
-		spage->logical = logical;
-		spage->physical = physical;
-		spage->mirror_num = mirror_num;
+		scrub_sector_get(sector);
+		list_add_tail(&sector->list, &sparity->sectors_list);
+		sector->sblock = sblock;
+		sector->dev = dev;
+		sector->flags = flags;
+		sector->generation = gen;
+		sector->logical = logical;
+		sector->physical = physical;
+		sector->mirror_num = mirror_num;
 		if (csum) {
-			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->fs_info->csum_size);
+			sector->have_csum = 1;
+			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
 		} else {
-			spage->have_csum = 0;
+			sector->have_csum = 0;
 		}
 		sblock->sector_count++;
-		spage->page = alloc_page(GFP_KERNEL);
-		if (!spage->page)
+		sector->page = alloc_page(GFP_KERNEL);
+		if (!sector->page)
 			goto leave_nomem;
 
 
@@ -2657,17 +2657,17 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 
 	WARN_ON(sblock->sector_count == 0);
 	for (index = 0; index < sblock->sector_count; index++) {
-		struct scrub_page *spage = sblock->sectors[index];
+		struct scrub_sector *sector = sblock->sectors[index];
 		int ret;
 
-		ret = scrub_add_page_to_rd_bio(sctx, spage);
+		ret = scrub_add_sector_to_rd_bio(sctx, sector);
 		if (ret) {
 			scrub_block_put(sblock);
 			return ret;
 		}
 	}
 
-	/* last one frees, either here or in bio completion for last page */
+	/* Last one frees, either here or in bio completion for last sector */
 	scrub_block_put(sblock);
 	return 0;
 }
@@ -2706,7 +2706,7 @@ static int scrub_extent_for_parity(struct scrub_parity *sparity,
 			if (have_csum == 0)
 				goto skip;
 		}
-		ret = scrub_pages_for_parity(sparity, logical, l, physical, dev,
+		ret = scrub_sectors_for_parity(sparity, logical, l, physical, dev,
 					     flags, gen, mirror_num,
 					     have_csum ? csum : NULL);
 		if (ret)
@@ -2766,7 +2766,7 @@ static int get_raid56_logic_offset(u64 physical, int num,
 static void scrub_free_parity(struct scrub_parity *sparity)
 {
 	struct scrub_ctx *sctx = sparity->sctx;
-	struct scrub_page *curr, *next;
+	struct scrub_sector *curr, *next;
 	int nbits;
 
 	nbits = bitmap_weight(sparity->ebitmap, sparity->nsectors);
@@ -2777,9 +2777,9 @@ static void scrub_free_parity(struct scrub_parity *sparity)
 		spin_unlock(&sctx->stat_lock);
 	}
 
-	list_for_each_entry_safe(curr, next, &sparity->spages, list) {
+	list_for_each_entry_safe(curr, next, &sparity->sectors_list, list) {
 		list_del_init(&curr->list);
-		scrub_page_put(curr);
+		scrub_sector_put(curr);
 	}
 
 	kfree(sparity);
@@ -2942,7 +2942,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	sparity->logic_start = logic_start;
 	sparity->logic_end = logic_end;
 	refcount_set(&sparity->refs, 1);
-	INIT_LIST_HEAD(&sparity->spages);
+	INIT_LIST_HEAD(&sparity->sectors_list);
 	sparity->dbitmap = sparity->bitmap;
 	sparity->ebitmap = (void *)sparity->bitmap + bitmap_len;
 
@@ -3939,9 +3939,9 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (!btrfs_check_super_location(scrub_dev, bytenr))
 			continue;
 
-		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
-				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-				  NULL, bytenr);
+		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
+				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
+				    NULL, bytenr);
 		if (ret)
 			return ret;
 	}
@@ -4060,7 +4060,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	    SCRUB_MAX_SECTORS_PER_BLOCK * fs_info->sectorsize ||
 	    fs_info->sectorsize > PAGE_SIZE * SCRUB_MAX_SECTORS_PER_BLOCK) {
 		/*
-		 * would exhaust the array bounds of pagev member in
+		 * Would exhaust the array bounds of sectorv member in
 		 * struct scrub_block
 		 */
 		btrfs_err(fs_info,
@@ -4136,7 +4136,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	/*
 	 * In order to avoid deadlock with reclaim when there is a transaction
 	 * trying to pause scrub, make sure we use GFP_NOFS for all the
-	 * allocations done at btrfs_scrub_pages() and scrub_pages_for_parity()
+	 * allocations done at btrfs_scrub_sectors() and scrub_sectors_for_parity()
 	 * invoked by our callees. The pausing request is done when the
 	 * transaction commit starts, and it blocks the transaction until scrub
 	 * is paused (done at specific points at scrub_stripe() or right above
-- 
2.35.1

