Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2556CD2B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 09:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjC2HKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjC2HKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 03:10:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E7268B
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 00:10:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C76E219B3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680073814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQeat43fykj0L88YzNFyJmsSk1cYRdfMjY7IK1qUh30=;
        b=EqRlrrpaTvfGCNlMuhxW+b417vr02Pmj7xgjp022xggnghq6TV5XJRyE/VXWlhXQwgxQAg
        Tygx6QybG4SKIx3lnVy/L/a4OBlqpVVJs1aBpxX35gVdJ74aRvbMHSet1QIXmgps/2mlLB
        ODM7y96W5+LfIEe+6sndeNAv+HM0Nxs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B2D7138FF
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EGfnMlXkI2T4NQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 07:10:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: scrub: remove scrub_bio structure
Date:   Wed, 29 Mar 2023 15:09:50 +0800
Message-Id: <9fc275192811e1998f8b06764f89ab03d1ab5645.1680073696.git.wqu@suse.com>
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

Since scrub path has been fully moved to scrub_stripe based facilities,
no more scrub_bio would be submitted.
Thus we can remove it completely, this involves:

- SCRUB_SECTORS_PER_BIO macro
- SCRUB_BIOS_PER_SCTX macro
- SCRUB_MAX_PAGES macro
- BTRFS_MAX_MIRRORS macro
- scrub_bio structure
- scrub_ctx::bios member
- scrub_ctx::curr member
- scrub_ctx::bios_in_flight member
- scrub_ctx::workers_pending member
- scrub_ctx::list_lock member
- scrub_ctx::list_wait member

- function scrub_bio_end_io_worker()
- function scrub_pending_bio_inc()
- function scrub_pending_bio_dec()
- function scrub_throttle()
- function scrub_submit()

- function scrub_find_csum()
- function drop_csum_range()

- Some unnecessary flush and scrub pauses

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 245 ++---------------------------------------------
 fs/btrfs/scrub.h |   5 -
 2 files changed, 6 insertions(+), 244 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8c44a2fa0a19..ddd6c432f607 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -41,14 +41,10 @@
 struct scrub_ctx;
 
 /*
- * The following three values only influence the performance.
+ * The following value only influence the performance.
  *
- * The last one configures the number of parallel and outstanding I/O
- * operations. The first one configures an upper limit for the number
- * of (dynamically allocated) pages that are added to a bio.
+ * This determines the batch size for stripe submitted in one go.
  */
-#define SCRUB_SECTORS_PER_BIO	32	/* 128KiB per bio for 4KiB pages */
-#define SCRUB_BIOS_PER_SCTX	64	/* 8MiB per device in flight for 4KiB pages */
 #define SCRUB_STRIPES_PER_SCTX	8	/* That would be 8 64K stripe per-device. */
 
 /*
@@ -57,19 +53,6 @@ struct scrub_ctx;
  */
 #define SCRUB_MAX_SECTORS_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
 
-#define SCRUB_MAX_PAGES			(DIV_ROUND_UP(BTRFS_MAX_METADATA_BLOCKSIZE, PAGE_SIZE))
-
-/*
- * Maximum number of mirrors that can be available for all profiles counting
- * the target device of dev-replace as one. During an active device replace
- * procedure, the target device of the copy operation is a mirror for the
- * filesystem data as well that can be used to read data in order to repair
- * read errors on other disks.
- *
- * Current value is derived from RAID1C4 with 4 copies.
- */
-#define BTRFS_MAX_MIRRORS (4 + 1)
-
 /* Represent one sector and its needed info to verify the content. */
 struct scrub_sector_verification {
 	bool is_metadata;
@@ -182,31 +165,12 @@ struct scrub_stripe {
 	struct work_struct work;
 };
 
-struct scrub_bio {
-	int			index;
-	struct scrub_ctx	*sctx;
-	struct btrfs_device	*dev;
-	struct bio		*bio;
-	blk_status_t		status;
-	u64			logical;
-	u64			physical;
-	int			sector_count;
-	int			next_free;
-	struct work_struct	work;
-};
-
 struct scrub_ctx {
-	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
 	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
 	int			first_free;
-	int			curr;
 	int			cur_stripe;
-	atomic_t		bios_in_flight;
-	atomic_t		workers_pending;
-	spinlock_t		list_lock;
-	wait_queue_head_t	list_wait;
 	struct list_head	csum_list;
 	atomic_t		cancel_req;
 	int			readonly;
@@ -305,22 +269,8 @@ static void wait_scrub_stripe_io(struct scrub_stripe *stripe)
 	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
 }
 
-static void scrub_bio_end_io_worker(struct work_struct *work);
 static void scrub_put_ctx(struct scrub_ctx *sctx);
 
-static void scrub_pending_bio_inc(struct scrub_ctx *sctx)
-{
-	refcount_inc(&sctx->refs);
-	atomic_inc(&sctx->bios_in_flight);
-}
-
-static void scrub_pending_bio_dec(struct scrub_ctx *sctx)
-{
-	atomic_dec(&sctx->bios_in_flight);
-	wake_up(&sctx->list_wait);
-	scrub_put_ctx(sctx);
-}
-
 static void __scrub_blocked_if_needed(struct btrfs_fs_info *fs_info)
 {
 	while (atomic_read(&fs_info->scrub_pause_req)) {
@@ -371,21 +321,6 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	if (!sctx)
 		return;
 
-	/* this can happen when scrub is cancelled */
-	if (sctx->curr != -1) {
-		struct scrub_bio *sbio = sctx->bios[sctx->curr];
-
-		bio_put(sbio->bio);
-	}
-
-	for (i = 0; i < SCRUB_BIOS_PER_SCTX; ++i) {
-		struct scrub_bio *sbio = sctx->bios[i];
-
-		if (!sbio)
-			break;
-		kfree(sbio);
-	}
-
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
 		release_scrub_stripe(&sctx->stripes[i]);
 
@@ -410,28 +345,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		goto nomem;
 	refcount_set(&sctx->refs, 1);
 	sctx->is_dev_replace = is_dev_replace;
-	sctx->sectors_per_bio = SCRUB_SECTORS_PER_BIO;
-	sctx->curr = -1;
 	sctx->fs_info = fs_info;
 	INIT_LIST_HEAD(&sctx->csum_list);
-	for (i = 0; i < SCRUB_BIOS_PER_SCTX; ++i) {
-		struct scrub_bio *sbio;
-
-		sbio = kzalloc(sizeof(*sbio), GFP_KERNEL);
-		if (!sbio)
-			goto nomem;
-		sctx->bios[i] = sbio;
-
-		sbio->index = i;
-		sbio->sctx = sctx;
-		sbio->sector_count = 0;
-		INIT_WORK(&sbio->work, scrub_bio_end_io_worker);
-
-		if (i != SCRUB_BIOS_PER_SCTX - 1)
-			sctx->bios[i]->next_free = i + 1;
-		else
-			sctx->bios[i]->next_free = -1;
-	}
 	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
 		int ret;
 
@@ -441,13 +356,9 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		sctx->stripes[i].sctx = sctx;
 	}
 	sctx->first_free = 0;
-	atomic_set(&sctx->bios_in_flight, 0);
-	atomic_set(&sctx->workers_pending, 0);
 	atomic_set(&sctx->cancel_req, 0);
 
-	spin_lock_init(&sctx->list_lock);
 	spin_lock_init(&sctx->stat_lock);
-	init_waitqueue_head(&sctx->list_wait);
 	sctx->throttle_deadline = 0;
 
 	mutex_init(&sctx->wr_lock);
@@ -1309,6 +1220,10 @@ static void scrub_write_sectors(struct scrub_ctx *sctx,
 	}
 }
 
+/*
+ * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
+ * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
+ */
 static void scrub_throttle_dev_io(struct scrub_ctx *sctx,
 				  struct btrfs_device *device,
 				  unsigned int bio_size)
@@ -1362,112 +1277,6 @@ static void scrub_throttle_dev_io(struct scrub_ctx *sctx,
 	sctx->throttle_deadline = 0;
 }
 
-/*
- * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
- * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
- */
-static void scrub_throttle(struct scrub_ctx *sctx)
-{
-	struct scrub_bio *sbio = sctx->bios[sctx->curr];
-
-	scrub_throttle_dev_io(sctx, sbio->dev, sbio->bio->bi_iter.bi_size);
-}
-
-static void scrub_submit(struct scrub_ctx *sctx)
-{
-	struct scrub_bio *sbio;
-
-	if (sctx->curr == -1)
-		return;
-
-	scrub_throttle(sctx);
-
-	sbio = sctx->bios[sctx->curr];
-	sctx->curr = -1;
-	scrub_pending_bio_inc(sctx);
-	btrfsic_check_bio(sbio->bio);
-	submit_bio(sbio->bio);
-}
-
-static void scrub_bio_end_io_worker(struct work_struct *work)
-{
-	struct scrub_bio *sbio = container_of(work, struct scrub_bio, work);
-	struct scrub_ctx *sctx = sbio->sctx;
-
-	ASSERT(sbio->sector_count <= SCRUB_SECTORS_PER_BIO);
-
-	bio_put(sbio->bio);
-	sbio->bio = NULL;
-	spin_lock(&sctx->list_lock);
-	sbio->next_free = sctx->first_free;
-	sctx->first_free = sbio->index;
-	spin_unlock(&sctx->list_lock);
-
-	scrub_pending_bio_dec(sctx);
-}
-
-static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered_sum *sum)
-{
-	sctx->stat.csum_discards += sum->len >> sctx->fs_info->sectorsize_bits;
-	list_del(&sum->list);
-	kfree(sum);
-}
-
-/*
- * Find the desired csum for range [logical, logical + sectorsize), and store
- * the csum into @csum.
- *
- * The search source is sctx->csum_list, which is a pre-populated list
- * storing bytenr ordered csum ranges.  We're responsible to cleanup any range
- * that is before @logical.
- *
- * Return 0 if there is no csum for the range.
- * Return 1 if there is csum for the range and copied to @csum.
- */
-int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
-{
-	bool found = false;
-
-	while (!list_empty(&sctx->csum_list)) {
-		struct btrfs_ordered_sum *sum = NULL;
-		unsigned long index;
-		unsigned long num_sectors;
-
-		sum = list_first_entry(&sctx->csum_list,
-				       struct btrfs_ordered_sum, list);
-		/* The current csum range is beyond our range, no csum found */
-		if (sum->bytenr > logical)
-			break;
-
-		/*
-		 * The current sum is before our bytenr, since scrub is always
-		 * done in bytenr order, the csum will never be used anymore,
-		 * clean it up so that later calls won't bother with the range,
-		 * and continue search the next range.
-		 */
-		if (sum->bytenr + sum->len <= logical) {
-			drop_csum_range(sctx, sum);
-			continue;
-		}
-
-		/* Now the csum range covers our bytenr, copy the csum */
-		found = true;
-		index = (logical - sum->bytenr) >> sctx->fs_info->sectorsize_bits;
-		num_sectors = sum->len >> sctx->fs_info->sectorsize_bits;
-
-		memcpy(csum, sum->sums + index * sctx->fs_info->csum_size,
-		       sctx->fs_info->csum_size);
-
-		/* Cleanup the range if we're at the end of the csum range */
-		if (index == num_sectors - 1)
-			drop_csum_range(sctx, sum);
-		break;
-	}
-	if (!found)
-		return 0;
-	return 1;
-}
-
 /*
  * Given a physical address, this will calculate it's
  * logical offset. if this is a parity stripe, it will return
@@ -1648,8 +1457,6 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	if (!btrfs_is_zoned(fs_info))
 		return 0;
 
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
-
 	mutex_lock(&sctx->wr_lock);
 	if (sctx->write_pointer < physical_end) {
 		ret = btrfs_sync_zone_write_pointer(sctx->wr_tgtdev, logical,
@@ -2185,11 +1992,6 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		/* Paused? */
 		if (atomic_read(&fs_info->scrub_pause_req)) {
 			/* Push queued extents */
-			scrub_submit(sctx);
-			mutex_lock(&sctx->wr_lock);
-			mutex_unlock(&sctx->wr_lock);
-			wait_event(sctx->list_wait,
-				   atomic_read(&sctx->bios_in_flight) == 0);
 			scrub_blocked_if_needed(fs_info);
 		}
 		/* Block group removed? */
@@ -2317,8 +2119,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 stripe_logical;
 	int stop_loop = 0;
 
-	wait_event(sctx->list_wait,
-		   atomic_read(&sctx->bios_in_flight) == 0);
 	scrub_blocked_if_needed(fs_info);
 
 	if (sctx->is_dev_replace &&
@@ -2433,8 +2233,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			break;
 	}
 out:
-	/* push queued extents */
-	scrub_submit(sctx);
 	flush_scrub_stripes(sctx);
 	if (sctx->raid56_data_stripes) {
 		for (int i = 0; i < nr_data_stripes(map); i++)
@@ -2759,34 +2557,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
 				  dev_extent_len);
-
-		/*
-		 * flush, submit all pending read and write bios, afterwards
-		 * wait for them.
-		 * Note that in the dev replace case, a read request causes
-		 * write requests that are submitted in the read completion
-		 * worker. Therefore in the current situation, it is required
-		 * that all write requests are flushed, so that all read and
-		 * write requests are really completed when bios_in_flight
-		 * changes to 0.
-		 */
-		scrub_submit(sctx);
-
-		wait_event(sctx->list_wait,
-			   atomic_read(&sctx->bios_in_flight) == 0);
-
-		scrub_pause_on(fs_info);
-
-		/*
-		 * must be called before we decrease @scrub_paused.
-		 * make sure we don't block transaction commit while
-		 * we are waiting pending workers finished.
-		 */
-		wait_event(sctx->list_wait,
-			   atomic_read(&sctx->workers_pending) == 0);
-
-		scrub_pause_off(fs_info);
-
 		if (sctx->is_dev_replace &&
 		    !btrfs_finish_block_group_to_copy(dev_replace->srcdev,
 						      cache, found_key.offset))
@@ -3111,12 +2881,9 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		ret = scrub_enumerate_chunks(sctx, dev, start, end);
 	memalloc_nofs_restore(nofs_flag);
 
-	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
 	atomic_dec(&fs_info->scrubs_running);
 	wake_up(&fs_info->scrub_pause_wait);
 
-	wait_event(sctx->list_wait, atomic_read(&sctx->workers_pending) == 0);
-
 	if (progress)
 		memcpy(progress, &sctx->stat, sizeof(*progress));
 
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 1fa4d26e8122..7639103ebf9d 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -13,9 +13,4 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
 
-/* Temporary declaration, would be deleted later. */
-struct scrub_ctx;
-struct scrub_block;
-int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
-
 #endif
-- 
2.39.2

