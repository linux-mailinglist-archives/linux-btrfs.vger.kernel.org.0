Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225E6CD2AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjC2HKR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjC2HKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A9B212F
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B72E721A28
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6oWIsek5+ngKgbXbfYwWYOMQBk1Jc2/kfLjuI95BPZM=;
        b=nodLSkK52edXW1olUdHycV6I79cyBBhRC++ue7LPgRrwH/ARjUgQzzre2rCTmHdGjtqjjf
        beh8Y45YXla3iyxZ0AvFO5ll8h75u+odlCRWcuR5ZmzyBB+iREQ4QyoctzJkkTrGNUtc9C
        2swy9SEXPd6M8rLOFe1RXroJHciOgr4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25083138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iG0SOVLkI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: scrub: remove the old writeback infrastructure
Date:   Wed, 29 Mar 2023 15:09:47 +0800
Message-Id: <d25a628d0c9ed1289f39a82b8d31695569a76e13.1680073696.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680073696.git.wqu@suse.com>
References: <cover.1680073696.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the whole scrub path is switched to scrub_stripe based solution,
the old writeback path can be removed completely, which involves:

- scrub_ctx::wr_curr_bio member
- scrub_ctx::flush_all_writes member
- function scrub_write_block_to_dev_replace()
- function scrub_write_sector_to_dev_replace()
- function scrub_add_sector_to_wr_bio()
- function scrub_wr_submit()
- function scrub_wr_bio_end_io()
- function scrub_wr_bio_end_io_worker()

And one more function needs to be exported temporarily:

- scrub_sector_get()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 221 +----------------------------------------------
 fs/btrfs/scrub.h |   1 +
 2 files changed, 3 insertions(+), 219 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8e9f47859d3d..6e981b77c73f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -275,10 +275,8 @@ struct scrub_ctx {
 	int			is_dev_replace;
 	u64			write_pointer;
 
-	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
 	struct btrfs_device     *wr_tgtdev;
-	bool                    flush_all_writes;
 
 	/*
 	 * statistics
@@ -547,23 +545,14 @@ static int scrub_repair_block_from_good_copy(struct scrub_block *sblock_bad,
 static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 					    struct scrub_block *sblock_good,
 					    int sector_num, int force_write);
-static void scrub_write_block_to_dev_replace(struct scrub_block *sblock);
-static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
-					     int sector_num);
 static int scrub_checksum_data(struct scrub_block *sblock);
 static int scrub_checksum_tree_block(struct scrub_block *sblock);
 static int scrub_checksum_super(struct scrub_block *sblock);
 static void scrub_block_put(struct scrub_block *sblock);
-static void scrub_sector_get(struct scrub_sector *sector);
 static void scrub_sector_put(struct scrub_sector *sector);
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_block_complete(struct scrub_block *sblock);
-static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
-				      struct scrub_sector *sector);
-static void scrub_wr_submit(struct scrub_ctx *sctx);
-static void scrub_wr_bio_end_io(struct bio *bio);
-static void scrub_wr_bio_end_io_worker(struct work_struct *work);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
 static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
@@ -872,7 +861,6 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
 		release_scrub_stripe(&sctx->stripes[i]);
 
-	kfree(sctx->wr_curr_bio);
 	scrub_free_csums(sctx);
 	kfree(sctx);
 }
@@ -934,13 +922,10 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	init_waitqueue_head(&sctx->list_wait);
 	sctx->throttle_deadline = 0;
 
-	WARN_ON(sctx->wr_curr_bio != NULL);
 	mutex_init(&sctx->wr_lock);
-	sctx->wr_curr_bio = NULL;
 	if (is_dev_replace) {
 		WARN_ON(!fs_info->dev_replace.tgtdev);
 		sctx->wr_tgtdev = fs_info->dev_replace.tgtdev;
-		sctx->flush_all_writes = false;
 	}
 
 	return sctx;
@@ -1306,8 +1291,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		sblock_to_check->data_corrected = 1;
 		spin_unlock(&sctx->stat_lock);
 
-		if (sctx->is_dev_replace)
-			scrub_write_block_to_dev_replace(sblock_bad);
 		goto out;
 	}
 
@@ -1396,7 +1379,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 		    !sblock_other->checksum_error &&
 		    sblock_other->no_io_error_seen) {
 			if (sctx->is_dev_replace) {
-				scrub_write_block_to_dev_replace(sblock_other);
 				goto corrected_error;
 			} else {
 				ret = scrub_repair_block_from_good_copy(
@@ -1478,13 +1460,6 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 			 */
 			if (!sblock_other)
 				sblock_other = sblock_bad;
-
-			if (scrub_write_sector_to_dev_replace(sblock_other,
-							      sector_num) != 0) {
-				atomic64_inc(
-					&fs_info->dev_replace.num_write_errors);
-				success = 0;
-			}
 		} else if (sblock_other) {
 			ret = scrub_repair_sector_from_good_copy(sblock_bad,
 								 sblock_other,
@@ -1906,31 +1881,6 @@ static int scrub_repair_sector_from_good_copy(struct scrub_block *sblock_bad,
 	return 0;
 }
 
-static void scrub_write_block_to_dev_replace(struct scrub_block *sblock)
-{
-	struct btrfs_fs_info *fs_info = sblock->sctx->fs_info;
-	int i;
-
-	for (i = 0; i < sblock->sector_count; i++) {
-		int ret;
-
-		ret = scrub_write_sector_to_dev_replace(sblock, i);
-		if (ret)
-			atomic64_inc(&fs_info->dev_replace.num_write_errors);
-	}
-}
-
-static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock, int sector_num)
-{
-	const u32 sectorsize = sblock->sctx->fs_info->sectorsize;
-	struct scrub_sector *sector = sblock->sectors[sector_num];
-
-	if (sector->io_error)
-		memset(scrub_sector_get_kaddr(sector), 0, sectorsize);
-
-	return scrub_add_sector_to_wr_bio(sblock->sctx, sector);
-}
-
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 {
 	int ret = 0;
@@ -1958,150 +1908,6 @@ static void scrub_block_get(struct scrub_block *sblock)
 	refcount_inc(&sblock->refs);
 }
 
-static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
-				      struct scrub_sector *sector)
-{
-	struct scrub_block *sblock = sector->sblock;
-	struct scrub_bio *sbio;
-	int ret;
-	const u32 sectorsize = sctx->fs_info->sectorsize;
-
-	mutex_lock(&sctx->wr_lock);
-again:
-	if (!sctx->wr_curr_bio) {
-		sctx->wr_curr_bio = kzalloc(sizeof(*sctx->wr_curr_bio),
-					      GFP_KERNEL);
-		if (!sctx->wr_curr_bio) {
-			mutex_unlock(&sctx->wr_lock);
-			return -ENOMEM;
-		}
-		sctx->wr_curr_bio->sctx = sctx;
-		sctx->wr_curr_bio->sector_count = 0;
-	}
-	sbio = sctx->wr_curr_bio;
-	if (sbio->sector_count == 0) {
-		ret = fill_writer_pointer_gap(sctx, sector->offset +
-					      sblock->physical_for_dev_replace);
-		if (ret) {
-			mutex_unlock(&sctx->wr_lock);
-			return ret;
-		}
-
-		sbio->physical = sblock->physical_for_dev_replace + sector->offset;
-		sbio->logical = sblock->logical + sector->offset;
-		sbio->dev = sctx->wr_tgtdev;
-		if (!sbio->bio) {
-			sbio->bio = bio_alloc(sbio->dev->bdev, sctx->sectors_per_bio,
-					      REQ_OP_WRITE, GFP_NOFS);
-		}
-		sbio->bio->bi_private = sbio;
-		sbio->bio->bi_end_io = scrub_wr_bio_end_io;
-		sbio->bio->bi_iter.bi_sector = sbio->physical >> 9;
-		sbio->status = 0;
-	} else if (sbio->physical + sbio->sector_count * sectorsize !=
-		   sblock->physical_for_dev_replace + sector->offset ||
-		   sbio->logical + sbio->sector_count * sectorsize !=
-		   sblock->logical + sector->offset) {
-		scrub_wr_submit(sctx);
-		goto again;
-	}
-
-	ret = bio_add_scrub_sector(sbio->bio, sector, sectorsize);
-	if (ret != sectorsize) {
-		if (sbio->sector_count < 1) {
-			bio_put(sbio->bio);
-			sbio->bio = NULL;
-			mutex_unlock(&sctx->wr_lock);
-			return -EIO;
-		}
-		scrub_wr_submit(sctx);
-		goto again;
-	}
-
-	sbio->sectors[sbio->sector_count] = sector;
-	scrub_sector_get(sector);
-	/*
-	 * Since ssector no longer holds a page, but uses sblock::pages, we
-	 * have to ensure the sblock had not been freed before our write bio
-	 * finished.
-	 */
-	scrub_block_get(sector->sblock);
-
-	sbio->sector_count++;
-	if (sbio->sector_count == sctx->sectors_per_bio)
-		scrub_wr_submit(sctx);
-	mutex_unlock(&sctx->wr_lock);
-
-	return 0;
-}
-
-static void scrub_wr_submit(struct scrub_ctx *sctx)
-{
-	struct scrub_bio *sbio;
-
-	if (!sctx->wr_curr_bio)
-		return;
-
-	sbio = sctx->wr_curr_bio;
-	sctx->wr_curr_bio = NULL;
-	scrub_pending_bio_inc(sctx);
-	/* process all writes in a single worker thread. Then the block layer
-	 * orders the requests before sending them to the driver which
-	 * doubled the write performance on spinning disks when measured
-	 * with Linux 3.5 */
-	btrfsic_check_bio(sbio->bio);
-	submit_bio(sbio->bio);
-
-	if (btrfs_is_zoned(sctx->fs_info))
-		sctx->write_pointer = sbio->physical + sbio->sector_count *
-			sctx->fs_info->sectorsize;
-}
-
-static void scrub_wr_bio_end_io(struct bio *bio)
-{
-	struct scrub_bio *sbio = bio->bi_private;
-	struct btrfs_fs_info *fs_info = sbio->dev->fs_info;
-
-	sbio->status = bio->bi_status;
-	sbio->bio = bio;
-
-	INIT_WORK(&sbio->work, scrub_wr_bio_end_io_worker);
-	queue_work(fs_info->scrub_wr_completion_workers, &sbio->work);
-}
-
-static void scrub_wr_bio_end_io_worker(struct work_struct *work)
-{
-	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
-	struct scrub_ctx *sctx = sbio->sctx;
-	int i;
-
-	ASSERT(sbio->sector_count <= SCRUB_SECTORS_PER_BIO);
-	if (sbio->status) {
-		struct btrfs_dev_replace *dev_replace =
-			&sbio->sctx->fs_info->dev_replace;
-
-		for (i = 0; i < sbio->sector_count; i++) {
-			struct scrub_sector *sector = sbio->sectors[i];
-
-			sector->io_error = 1;
-			atomic64_inc(&dev_replace->num_write_errors);
-		}
-	}
-
-	/*
-	 * In scrub_add_sector_to_wr_bio() we grab extra ref for sblock, now in
-	 * endio we should put the sblock.
-	 */
-	for (i = 0; i < sbio->sector_count; i++) {
-		scrub_block_put(sbio->sectors[i]->sblock);
-		scrub_sector_put(sbio->sectors[i]);
-	}
-
-	bio_put(sbio->bio);
-	kfree(sbio);
-	scrub_pending_bio_dec(sctx);
-}
-
 static int scrub_checksum(struct scrub_block *sblock)
 {
 	u64 flags;
@@ -2927,7 +2733,7 @@ static void scrub_block_put(struct scrub_block *sblock)
 	}
 }
 
-static void scrub_sector_get(struct scrub_sector *sector)
+void scrub_sector_get(struct scrub_sector *sector)
 {
 	atomic_inc(&sector->refs);
 }
@@ -3130,21 +2936,12 @@ static void scrub_bio_end_io_worker(struct work_struct *work)
 	sctx->first_free = sbio->index;
 	spin_unlock(&sctx->list_lock);
 
-	if (sctx->is_dev_replace && sctx->flush_all_writes) {
-		mutex_lock(&sctx->wr_lock);
-		scrub_wr_submit(sctx);
-		mutex_unlock(&sctx->wr_lock);
-	}
-
 	scrub_pending_bio_dec(sctx);
 }
 
 static void scrub_block_complete(struct scrub_block *sblock)
 {
-	int corrupted = 0;
-
 	if (!sblock->no_io_error_seen) {
-		corrupted = 1;
 		scrub_handle_errored_block(sblock);
 	} else {
 		/*
@@ -3152,9 +2949,7 @@ static void scrub_block_complete(struct scrub_block *sblock)
 		 * dev replace case, otherwise write here in dev replace
 		 * case.
 		 */
-		corrupted = scrub_checksum(sblock);
-		if (!corrupted && sblock->sctx->is_dev_replace)
-			scrub_write_block_to_dev_replace(sblock);
+		scrub_checksum(sblock);
 	}
 }
 
@@ -3937,14 +3732,11 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		/* Paused? */
 		if (atomic_read(&fs_info->scrub_pause_req)) {
 			/* Push queued extents */
-			sctx->flush_all_writes = true;
 			scrub_submit(sctx);
 			mutex_lock(&sctx->wr_lock);
-			scrub_wr_submit(sctx);
 			mutex_unlock(&sctx->wr_lock);
 			wait_event(sctx->list_wait,
 				   atomic_read(&sctx->bios_in_flight) == 0);
-			sctx->flush_all_writes = false;
 			scrub_blocked_if_needed(fs_info);
 		}
 		/* Block group removed? */
@@ -4081,7 +3873,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		mutex_lock(&sctx->wr_lock);
 		sctx->write_pointer = physical;
 		mutex_unlock(&sctx->wr_lock);
-		sctx->flush_all_writes = true;
 	}
 
 	/* Prepare the extra data stripes used by RAID56. */
@@ -4191,9 +3982,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 out:
 	/* push queued extents */
 	scrub_submit(sctx);
-	mutex_lock(&sctx->wr_lock);
-	scrub_wr_submit(sctx);
-	mutex_unlock(&sctx->wr_lock);
 	flush_scrub_stripes(sctx);
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
@@ -4529,11 +4317,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * write requests are really completed when bios_in_flight
 		 * changes to 0.
 		 */
-		sctx->flush_all_writes = true;
 		scrub_submit(sctx);
-		mutex_lock(&sctx->wr_lock);
-		scrub_wr_submit(sctx);
-		mutex_unlock(&sctx->wr_lock);
 
 		wait_event(sctx->list_wait,
 			   atomic_read(&sctx->bios_in_flight) == 0);
@@ -4547,7 +4331,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 */
 		wait_event(sctx->list_wait,
 			   atomic_read(&sctx->workers_pending) == 0);
-		sctx->flush_all_writes = false;
 
 		scrub_pause_off(fs_info);
 
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index d23068e741fb..f47492e78e1c 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -19,5 +19,6 @@ struct scrub_sector;
 int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
 int scrub_add_sector_to_rd_bio(struct scrub_ctx *sctx,
 			       struct scrub_sector *sector);
+void scrub_sector_get(struct scrub_sector *sector);
 
 #endif
-- 
2.39.2

