Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16EE29873B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770920AbgJZHL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770501AbgJZHL1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZWvMiTH+7TwdhY3JrEyUMeX2QaSLWIkGdtD6U83ZW8=;
        b=BnAHVp7QG/XioTN1Rhm4x/20+4Hfdijs7N7knUzVjL52zANhKrav/XKHoGOeoe3103Hovv
        whVX1T4zGMT5gMIERza0gbdxk/Qi062yYrpNpA23Va3cUUZAxy/kdgb7yTaxvu9CYYZ0hN
        nB1Kxe7T0v5SJxzT6n5pl4IICzOjWUg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC528AD2F
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: scrub: distinguish scrub_page from regular page
Date:   Mon, 26 Oct 2020 15:11:08 +0800
Message-Id: <20201026071115.57225-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026071115.57225-1-wqu@suse.com>
References: <20201026071115.57225-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several call sites where we declare something like
"struct scrub_page *page".

This is just asking for troubles when read the code, as we also have
scrub_page::page member.

To avoid confusion, use "spage" for scrub_page strcture pointers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 102 +++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 806523515d2f..0e25f9391b93 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -256,10 +256,10 @@ static void __scrub_blocked_if_needed(struct btrfs_fs_info *fs_info);
 static void scrub_blocked_if_needed(struct btrfs_fs_info *fs_info);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
-static inline int scrub_is_page_on_raid56(struct scrub_page *page)
+static inline int scrub_is_page_on_raid56(struct scrub_page *spage)
 {
-	return page->recover &&
-	       (page->recover->bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+	return spage->recover &&
+	       (spage->recover->bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 }
 
 static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
@@ -1092,11 +1092,11 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	success = 1;
 	for (page_num = 0; page_num < sblock_bad->page_count;
 	     page_num++) {
-		struct scrub_page *page_bad = sblock_bad->pagev[page_num];
+		struct scrub_page *spage_bad = sblock_bad->pagev[page_num];
 		struct scrub_block *sblock_other = NULL;
 
 		/* skip no-io-error page in scrub */
-		if (!page_bad->io_error && !sctx->is_dev_replace)
+		if (!spage_bad->io_error && !sctx->is_dev_replace)
 			continue;
 
 		if (scrub_is_page_on_raid56(sblock_bad->pagev[0])) {
@@ -1108,7 +1108,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			 * sblock_for_recheck array to target device.
 			 */
 			sblock_other = NULL;
-		} else if (page_bad->io_error) {
+		} else if (spage_bad->io_error) {
 			/* try to find no-io-error page in mirrors */
 			for (mirror_index = 0;
 			     mirror_index < BTRFS_MAX_MIRRORS &&
@@ -1147,7 +1147,7 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 							       sblock_other,
 							       page_num, 0);
 			if (0 == ret)
-				page_bad->io_error = 0;
+				spage_bad->io_error = 0;
 			else
 				success = 0;
 		}
@@ -1325,13 +1325,13 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 		for (mirror_index = 0; mirror_index < nmirrors;
 		     mirror_index++) {
 			struct scrub_block *sblock;
-			struct scrub_page *page;
+			struct scrub_page *spage;
 
 			sblock = sblocks_for_recheck + mirror_index;
 			sblock->sctx = sctx;
 
-			page = kzalloc(sizeof(*page), GFP_NOFS);
-			if (!page) {
+			spage = kzalloc(sizeof(*spage), GFP_NOFS);
+			if (!spage) {
 leave_nomem:
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
@@ -1339,15 +1339,15 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 				scrub_put_recover(fs_info, recover);
 				return -ENOMEM;
 			}
-			scrub_page_get(page);
-			sblock->pagev[page_index] = page;
-			page->sblock = sblock;
-			page->flags = flags;
-			page->generation = generation;
-			page->logical = logical;
-			page->have_csum = have_csum;
+			scrub_page_get(spage);
+			sblock->pagev[page_index] = spage;
+			spage->sblock = sblock;
+			spage->flags = flags;
+			spage->generation = generation;
+			spage->logical = logical;
+			spage->have_csum = have_csum;
 			if (have_csum)
-				memcpy(page->csum,
+				memcpy(spage->csum,
 				       original_sblock->pagev[0]->csum,
 				       sctx->csum_size);
 
@@ -1360,23 +1360,23 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 						      mirror_index,
 						      &stripe_index,
 						      &stripe_offset);
-			page->physical = bbio->stripes[stripe_index].physical +
+			spage->physical = bbio->stripes[stripe_index].physical +
 					 stripe_offset;
-			page->dev = bbio->stripes[stripe_index].dev;
+			spage->dev = bbio->stripes[stripe_index].dev;
 
 			BUG_ON(page_index >= original_sblock->page_count);
-			page->physical_for_dev_replace =
+			spage->physical_for_dev_replace =
 				original_sblock->pagev[page_index]->
 				physical_for_dev_replace;
 			/* for missing devices, dev->bdev is NULL */
-			page->mirror_num = mirror_index + 1;
+			spage->mirror_num = mirror_index + 1;
 			sblock->page_count++;
-			page->page = alloc_page(GFP_NOFS);
-			if (!page->page)
+			spage->page = alloc_page(GFP_NOFS);
+			if (!spage->page)
 				goto leave_nomem;
 
 			scrub_get_recover(recover);
-			page->recover = recover;
+			spage->recover = recover;
 		}
 		scrub_put_recover(fs_info, recover);
 		length -= sublen;
@@ -1394,19 +1394,19 @@ static void scrub_bio_wait_endio(struct bio *bio)
 
 static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 					struct bio *bio,
-					struct scrub_page *page)
+					struct scrub_page *spage)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	int ret;
 	int mirror_num;
 
-	bio->bi_iter.bi_sector = page->logical >> 9;
+	bio->bi_iter.bi_sector = spage->logical >> 9;
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
 
-	mirror_num = page->sblock->pagev[0]->mirror_num;
-	ret = raid56_parity_recover(fs_info, bio, page->recover->bbio,
-				    page->recover->map_length,
+	mirror_num = spage->sblock->pagev[0]->mirror_num;
+	ret = raid56_parity_recover(fs_info, bio, spage->recover->bbio,
+				    spage->recover->map_length,
 				    mirror_num, 0);
 	if (ret)
 		return ret;
@@ -1431,10 +1431,10 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	bio_set_dev(bio, first_page->dev->bdev);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
-		struct scrub_page *page = sblock->pagev[page_num];
+		struct scrub_page *spage = sblock->pagev[page_num];
 
-		WARN_ON(!page->page);
-		bio_add_page(bio, page->page, PAGE_SIZE, 0);
+		WARN_ON(!spage->page);
+		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
 	}
 
 	if (scrub_submit_raid56_bio_wait(fs_info, bio, first_page)) {
@@ -1475,24 +1475,24 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
 		struct bio *bio;
-		struct scrub_page *page = sblock->pagev[page_num];
+		struct scrub_page *spage = sblock->pagev[page_num];
 
-		if (page->dev->bdev == NULL) {
-			page->io_error = 1;
+		if (spage->dev->bdev == NULL) {
+			spage->io_error = 1;
 			sblock->no_io_error_seen = 0;
 			continue;
 		}
 
-		WARN_ON(!page->page);
+		WARN_ON(!spage->page);
 		bio = btrfs_io_bio_alloc(1);
-		bio_set_dev(bio, page->dev->bdev);
+		bio_set_dev(bio, spage->dev->bdev);
 
-		bio_add_page(bio, page->page, PAGE_SIZE, 0);
-		bio->bi_iter.bi_sector = page->physical >> 9;
+		bio_add_page(bio, spage->page, PAGE_SIZE, 0);
+		bio->bi_iter.bi_sector = spage->physical >> 9;
 		bio->bi_opf = REQ_OP_READ;
 
 		if (btrfsic_submit_bio_wait(bio)) {
-			page->io_error = 1;
+			spage->io_error = 1;
 			sblock->no_io_error_seen = 0;
 		}
 
@@ -1548,36 +1548,36 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 					    struct scrub_block *sblock_good,
 					    int page_num, int force_write)
 {
-	struct scrub_page *page_bad = sblock_bad->pagev[page_num];
-	struct scrub_page *page_good = sblock_good->pagev[page_num];
+	struct scrub_page *spage_bad = sblock_bad->pagev[page_num];
+	struct scrub_page *spage_good = sblock_good->pagev[page_num];
 	struct btrfs_fs_info *fs_info = sblock_bad->sctx->fs_info;
 
-	BUG_ON(page_bad->page == NULL);
-	BUG_ON(page_good->page == NULL);
+	BUG_ON(spage_bad->page == NULL);
+	BUG_ON(spage_good->page == NULL);
 	if (force_write || sblock_bad->header_error ||
-	    sblock_bad->checksum_error || page_bad->io_error) {
+	    sblock_bad->checksum_error || spage_bad->io_error) {
 		struct bio *bio;
 		int ret;
 
-		if (!page_bad->dev->bdev) {
+		if (!spage_bad->dev->bdev) {
 			btrfs_warn_rl(fs_info,
 				"scrub_repair_page_from_good_copy(bdev == NULL) is unexpected");
 			return -EIO;
 		}
 
 		bio = btrfs_io_bio_alloc(1);
-		bio_set_dev(bio, page_bad->dev->bdev);
-		bio->bi_iter.bi_sector = page_bad->physical >> 9;
+		bio_set_dev(bio, spage_bad->dev->bdev);
+		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
 
-		ret = bio_add_page(bio, page_good->page, PAGE_SIZE, 0);
+		ret = bio_add_page(bio, spage_good->page, PAGE_SIZE, 0);
 		if (PAGE_SIZE != ret) {
 			bio_put(bio);
 			return -EIO;
 		}
 
 		if (btrfsic_submit_bio_wait(bio)) {
-			btrfs_dev_stat_inc_and_print(page_bad->dev,
+			btrfs_dev_stat_inc_and_print(spage_bad->dev,
 				BTRFS_DEV_STAT_WRITE_ERRS);
 			atomic64_inc(&fs_info->dev_replace.num_write_errors);
 			bio_put(bio);
-- 
2.29.0

