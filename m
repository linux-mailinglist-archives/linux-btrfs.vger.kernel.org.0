Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61EE6C08DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCTCNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCTCNj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA0F1968C
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E7111F45E
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zCZO2RF+qsb2ZYABXgJxAwJJ5LVPMjvHXzowg44Stc=;
        b=TxuZQDym+018T5qel3qztRoA7vndHG1Y4vk11fdjq3BjUnylQOXf43K3gE0l5QYcZx4TDj
        7zT8Nq5X1CcmEFd1Hr0amIUgZod+dlvgHyWHhgt092w35gs2hKzigP0cgmXUra1gxM37Lh
        tLWLpUl35dCRgP9Iy0RK75Az6qBZ7MU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0539813416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KEK6ME7BF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/12] btrfs: scrub: introduce the helper to queue a stripe for scrub
Date:   Mon, 20 Mar 2023 10:12:57 +0800
Message-Id: <d626e41703ae041c3a6f17b16aad33fcc3207834.1679278088.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679278088.git.wqu@suse.com>
References: <cover.1679278088.git.wqu@suse.com>
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

The new helper, queue_scrub_stripe(), would try to queue a stripe for
scrub.
If all stripes are already in use, we will submit all the existing
stripes and wait them to finish.

Currently we would queue up to 8 stripes, to enlarge the blocksize to
512KiB to improve the performance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 181 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/scrub.h |  13 ++--
 2 files changed, 176 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e31cf73597fc..44f34883adc7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -50,6 +50,7 @@ struct scrub_ctx;
  */
 #define SCRUB_SECTORS_PER_BIO	32	/* 128KiB per bio for 4KiB pages */
 #define SCRUB_BIOS_PER_SCTX	64	/* 8MiB per device in flight for 4KiB pages */
+#define SCRUB_STRIPES_PER_SCTX	8	/* That would be 8 64K stripe per-device. */
 
 /*
  * The following value times PAGE_SIZE needs to be large enough to match the
@@ -271,9 +272,11 @@ struct scrub_parity {
 
 struct scrub_ctx {
 	struct scrub_bio	*bios[SCRUB_BIOS_PER_SCTX];
+	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
 	struct btrfs_fs_info	*fs_info;
 	int			first_free;
 	int			curr;
+	int			cur_stripe;
 	atomic_t		bios_in_flight;
 	atomic_t		workers_pending;
 	spinlock_t		list_lock;
@@ -385,7 +388,8 @@ static void release_scrub_stripe(struct scrub_stripe *stripe)
 	stripe->state = 0;
 }
 
-int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe)
+static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
+			     struct scrub_stripe *stripe)
 {
 	int ret;
 
@@ -892,6 +896,9 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 		kfree(sbio);
 	}
 
+	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
+		release_scrub_stripe(&sctx->stripes[i]);
+
 	kfree(sctx->wr_curr_bio);
 	scrub_free_csums(sctx);
 	kfree(sctx);
@@ -936,6 +943,14 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		else
 			sctx->bios[i]->next_free = -1;
 	}
+	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
+		int ret;
+
+		ret = init_scrub_stripe(fs_info, &sctx->stripes[i]);
+		if (ret < 0)
+			goto nomem;
+		sctx->stripes[i].sctx = sctx;
+	}
 	sctx->first_free = 0;
 	atomic_set(&sctx->bios_in_flight, 0);
 	atomic_set(&sctx->workers_pending, 0);
@@ -2688,7 +2703,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	wake_up(&stripe->repair_wait);
 }
 
-void scrub_read_endio(struct btrfs_bio *bbio)
+static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
 
@@ -2744,9 +2759,9 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
  *
  * - Handle dev-replace and read-repair writeback differently
  */
-void scrub_write_sectors(struct scrub_ctx *sctx,
-			struct scrub_stripe *stripe,
-			unsigned long write_bitmap, bool dev_replace)
+static void scrub_write_sectors(struct scrub_ctx *sctx,
+				struct scrub_stripe *stripe,
+				unsigned long write_bitmap, bool dev_replace)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
@@ -4321,10 +4336,11 @@ static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
  * Return >0 if there is no such stripe in the specified range.
  * Return <0 for error.
  */
-int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
-				 struct btrfs_device *dev, u64 physical,
-				 int mirror_num, u64 logical_start,
-				 u32 logical_len, struct scrub_stripe *stripe)
+static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
+					struct btrfs_device *dev, u64 physical,
+					int mirror_num, u64 logical_start,
+					u32 logical_len,
+					struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
@@ -4436,6 +4452,153 @@ int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	return ret;
 }
 
+static void scrub_reset_stripe(struct scrub_stripe *stripe)
+{
+	int i;
+
+	scrub_stripe_reset_bitmaps(stripe);
+
+	stripe->nr_meta_extents = 0;
+	stripe->nr_data_extents = 0;
+	stripe->state = 0;
+
+	for (i = 0; i < stripe->nr_sectors; i++) {
+		stripe->sectors[i].is_metadata = false;
+		stripe->sectors[i].csum = NULL;
+		stripe->sectors[i].generation = 0;
+	}
+}
+
+static void scrub_submit_initial_read(struct scrub_ctx *sctx,
+				      struct scrub_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_bio *bbio;
+	int mirror = stripe->mirror_num;
+	int i;
+
+	ASSERT(stripe->bg);
+	ASSERT(stripe->mirror_num > 0);
+	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
+
+	bbio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> PAGE_SHIFT, REQ_OP_READ, NULL,
+			       scrub_read_endio, stripe);
+	/* Backed by mempool. */
+	ASSERT(bbio);
+
+	/* Read the whole stripe. */
+	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
+	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+		int ret;
+
+		ret = bio_add_page(&bbio->bio, stripe->pages[i], PAGE_SIZE, 0);
+		/* We should have allocated enough bio vectors. */
+		ASSERT(ret == PAGE_SIZE);
+	}
+	atomic_inc(&stripe->pending_io);
+	if (sctx->is_dev_replace &&
+	    (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
+	     BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID ||
+	     !stripe->dev->bdev)) {
+		int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
+						  stripe->bg->length);
+		mirror = calc_next_mirror(mirror, num_copies);
+	}
+	btrfs_submit_scrub_read(fs_info, bbio, mirror);
+}
+
+static void flush_scrub_stripes(struct scrub_ctx *sctx)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct scrub_stripe *stripe;
+	const int nr_stripes = sctx->cur_stripe;
+	int i;
+
+	if (!nr_stripes)
+		return;
+
+	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
+	for (i = 0; i < nr_stripes; i++) {
+		stripe = &sctx->stripes[i];
+		scrub_submit_initial_read(sctx, stripe);
+	}
+
+	for (i = 0; i < nr_stripes; i++) {
+		stripe = &sctx->stripes[i];
+
+		wait_event(stripe->repair_wait,
+			   test_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE,
+				    &stripe->state));
+	}
+
+	/*
+	 * Submit the repaired sectors.
+	 * For zoned case, we can not do repair in-place, but
+	 * queue the bg to be relocated.
+	 */
+	if (btrfs_is_zoned(fs_info)) {
+		btrfs_repair_one_zone(fs_info, sctx->stripes[0].bg->start);
+	} else {
+		for (i = 0; i < nr_stripes; i++) {
+			unsigned long repaired;
+
+			stripe = &sctx->stripes[i];
+
+			bitmap_andnot(&repaired, &stripe->init_error_bitmap,
+				      &stripe->error_bitmap, stripe->nr_sectors);
+			scrub_write_sectors(sctx, stripe, repaired, false);
+		}
+	}
+
+	/* Submit for dev-replace. */
+	if (sctx->is_dev_replace) {
+		for (i = 0; i < nr_stripes; i++) {
+			unsigned long good;
+
+			stripe = &sctx->stripes[i];
+
+			ASSERT(stripe->dev == fs_info->dev_replace.srcdev);
+
+			bitmap_andnot(&good, &stripe->extent_sector_bitmap,
+				      &stripe->error_bitmap, stripe->nr_sectors);
+			scrub_write_sectors(sctx, stripe, good, true);
+		}
+	}
+
+	/* Wait for above writebacks to finish. */
+	for (i = 0; i < nr_stripes; i++) {
+		stripe = &sctx->stripes[i];
+
+		wait_scrub_stripe_io(stripe);
+		scrub_reset_stripe(stripe);
+	}
+	sctx->cur_stripe = 0;
+}
+
+int queue_scrub_stripe(struct scrub_ctx *sctx,
+		       struct btrfs_block_group *bg,
+		       struct btrfs_device *dev, int mirror_num,
+		       u64 logical, u32 length, u64 physical)
+{
+	struct scrub_stripe *stripe;
+	int ret;
+
+	/* No available slot, submit all stripes and wait for them. */
+	if (sctx->cur_stripe >= SCRUB_STRIPES_PER_SCTX)
+		flush_scrub_stripes(sctx);
+
+	stripe = &sctx->stripes[sctx->cur_stripe];
+
+	/* We can queue one stripe using the remaining slot. */
+	scrub_reset_stripe(stripe);
+	ret = scrub_find_fill_first_stripe(bg, dev, physical, mirror_num,
+					   logical, length, stripe);
+	/* Either >0 as no more extent or <0 for error. */
+	if (ret)
+		return ret;
+	sctx->cur_stripe++;
+	return 0;
+}
 
 /*
  * Scrub one range which can only has simple mirror based profile.
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 3027d4c23ee8..fb9d906f5a17 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -18,14 +18,9 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
  * static functions.
  */
 struct scrub_stripe;
-int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe);
-int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
-				 struct btrfs_device *dev, u64 physical,
-				 int mirror_num, u64 logical_start,
-				 u32 logical_len, struct scrub_stripe *stripe);
-void scrub_read_endio(struct btrfs_bio *bbio);
-void scrub_write_sectors(struct scrub_ctx *sctx,
-			struct scrub_stripe *stripe,
-			unsigned long write_bitmap, bool dev_replace);
+int queue_scrub_stripe(struct scrub_ctx *sctx,
+		       struct btrfs_block_group *bg,
+		       struct btrfs_device *dev, int mirror_num,
+		       u64 logical, u32 length, u64 physical);
 
 #endif
-- 
2.39.2

