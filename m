Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25CB75380E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjGNK12 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjGNK1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 06:27:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A030FC
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 03:27:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B46A61FDAD
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689330418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OcP86LI+7G6Rc6wHGxYirsm5KM/UshLlIuW0iGKaIjw=;
        b=tisQPg4k0FuG/wqUavTi+uZ79B5CNYufB337IgGhwd6kWKCE6rcHBA8o7K5VGqOZeZ07PV
        BW56EImHVGN0kyw/C97SzhFoLGeU3MZ85wD2b7PEmT6OqAULnz0f7/qORnn9WbXYeLb+vj
        hFQVT55ou3Whs7pFbLqzEN3CBvAxcmU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1450313A15
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 10:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6k4SNPEisWQWFAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 10:26:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: speed up on NVME devices
Date:   Fri, 14 Jul 2023 18:26:40 +0800
Message-ID: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[REGRESSION]
There are several regression reports about the scrub performance with
v6.4 kernel.

On a PCIE3.0 device, the old v6.3 kernel can go 3GB/s scrub speed, but
v6.4 can only go 1GB/s, an obvious 66% performance drop.

[CAUSE]
Iostat shows a very different behavior between v6.3 and v6.4 kernel:

Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
nvme0n1p3  9731.00 3425544.00 17237.00  63.92    2.18   352.02  21.18 100.00
nvme0n1p3 20853.00 1330288.00     0.00   0.00    0.08    63.79   1.60 100.00

The upper one is v6.3 while the lower one is v6.4.

There are several obvious differences:

- Very few read merges
  This turns out to be a behavior change that we no longer go bio
  plug/unplug.

- Very low aqu-sz
  This is due to the submit-and-wait behavior of flush_scrub_stripes().

Both behavior is not that obvious on SATA SSDs, as SATA SSDs has NCQ to
merge the reads, while SATA SSDs can not handle high queue depth well
either.

[FIX]
For now this patch focus on the read speed fix. Dev-replace replace
speed needs extra work.

For the read part, we go two directions to fix the problems:

- Re-introduce blk plug/unplug to merge read requests
  This is pretty simple, and the behavior is pretty easy to observe.

  This would enlarge the average read request size to 512K.

- Introduce multi-group reads and no longer waits for each group
  Instead of the old behavior, which submit 8 stripes and wait for
  them, here we would enlarge the total stripes to 16 * 8.
  Which is 8M per device, the same limits as the old scrub flying
  bios size limit.

  Now every time we fill a group (8 stripes), we submit them and
  continue to next stripes.

  Only when the full 16 * 8 stripes are all filled, we submit the
  remaining ones (the last group), and wait for all groups to finish.
  Then submit the repair writes and dev-replace writes.

  This should enlarge the queue depth.

Even with all these optimization, unfortunately we can only improve the
scrub performance to around 1.9GiB/s, as the queue depth is still very
low.

Now the new iostat results looks like this:

Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
nvme0n1p3  4030.00 1995904.00 27257.00  87.12    0.37   495.26   1.50 100.00

Which still have a very low queue depth.

The current bottleneck seems to be in flush_scrub_stripes(), which is
still doing submit-and-wait, for read-repair and dev-replace
synchronization.

To fully re-gain the performance, we need to get rid of the
submit-and-wait, and go workqueue solution to fully utilize the
high queue depth capability of NVME devices.

Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
For the proper fix, I'm afraid we have to utilize btrfs workqueue, let
the initial read and repair done in an async manner, and let the
writeback (repaired and dev-replace) happen in a synchronized manner.

This can allow us to have a very high queue depth, to claim the
remaining 1GiB/s performance.

But I'm also not sure if we should go that hard, as we may still have
SATA SSD/HDDs, which won't benefit at all from high queue depth.

The only good news is, this patch is small enough for backport, without
huge structure changes.
---
 fs/btrfs/scrub.c | 76 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 38c103f13fd5..adb7d8c921d4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -43,16 +43,28 @@ struct scrub_ctx;
 /*
  * The following value only influences the performance.
  *
- * This determines the batch size for stripe submitted in one go.
+ * This detemines how many stripes would be submitted in one go,
+ * this would 512KiB (BTRFS_STRIPE_LEN * SCRUB_STRIPES_PER_GROUP).
  */
-#define SCRUB_STRIPES_PER_SCTX	8	/* That would be 8 64K stripe per-device. */
+#define SCRUB_STRIPES_PER_GROUP		8
 
+/*
+ * How many groups we have for each sctx.
+ *
+ * This would be 8M per device, the same value as the old scrub
+ * flying bios size limit.
+ */
+#define SCRUB_STRIPE_GROUPS_PER_SCTX	16
+
+#define SCRUB_STRIPES_PER_SCTX		(SCRUB_STRIPES_PER_GROUP * \
+					 SCRUB_STRIPE_GROUPS_PER_SCTX)
 /*
  * The following value times PAGE_SIZE needs to be large enough to match the
  * largest node/leaf/sector size that shall be supported.
  */
 #define SCRUB_MAX_SECTORS_PER_BLOCK	(BTRFS_MAX_METADATA_BLOCKSIZE / SZ_4K)
 
+
 /* Represent one sector and its needed info to verify the content. */
 struct scrub_sector_verification {
 	bool is_metadata;
@@ -78,6 +90,9 @@ enum scrub_stripe_flags {
 	/* Set when @mirror_num, @dev, @physical and @logical are set. */
 	SCRUB_STRIPE_FLAG_INITIALIZED,
 
+	/* Set when the initial read has been submitted. */
+	SCRUB_STRIPE_FLAG_READ_SUBMITTED,
+
 	/* Set when the read-repair is finished. */
 	SCRUB_STRIPE_FLAG_REPAIR_DONE,
 
@@ -1604,6 +1619,9 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	ASSERT(stripe->mirror_num > 0);
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 
+	if (test_and_set_bit(SCRUB_STRIPE_FLAG_READ_SUBMITTED, &stripe->state))
+		return;
+
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 
@@ -1657,6 +1675,7 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct scrub_stripe *stripe;
 	const int nr_stripes = sctx->cur_stripe;
+	struct blk_plug plug;
 	int ret = 0;
 
 	if (!nr_stripes)
@@ -1664,12 +1683,17 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
 
+	/* We should only have at most one group to submit. */
 	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
-			      btrfs_stripe_nr_to_offset(nr_stripes));
+			      btrfs_stripe_nr_to_offset(
+				      nr_stripes % SCRUB_STRIPES_PER_GROUP ?:
+				      SCRUB_STRIPES_PER_GROUP));
+	blk_start_plug(&plug);
 	for (int i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
 		scrub_submit_initial_read(sctx, stripe);
 	}
+	blk_finish_plug(&plug);
 
 	for (int i = 0; i < nr_stripes; i++) {
 		stripe = &sctx->stripes[i];
@@ -1748,28 +1772,47 @@ static void raid56_scrub_wait_endio(struct bio *bio)
 
 static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *bg,
 			      struct btrfs_device *dev, int mirror_num,
-			      u64 logical, u32 length, u64 physical)
+			      u64 logical, u32 length, u64 physical,
+			      u64 *found_stripe_start_ret)
 {
 	struct scrub_stripe *stripe;
 	int ret;
 
-	/* No available slot, submit all stripes and wait for them. */
-	if (sctx->cur_stripe >= SCRUB_STRIPES_PER_SCTX) {
-		ret = flush_scrub_stripes(sctx);
-		if (ret < 0)
-			return ret;
-	}
-
+	/*
+	 * We should always have at least one slot, when full the last one
+	 * who queued a slot should handle the flush.
+	 */
+	ASSERT(sctx->cur_stripe < SCRUB_STRIPES_PER_SCTX);
 	stripe = &sctx->stripes[sctx->cur_stripe];
-
-	/* We can queue one stripe using the remaining slot. */
 	scrub_reset_stripe(stripe);
 	ret = scrub_find_fill_first_stripe(bg, dev, physical, mirror_num,
 					   logical, length, stripe);
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
+	*found_stripe_start_ret = stripe->logical;
+
 	sctx->cur_stripe++;
+
+	/* Last slot used, flush them all. */
+	if (sctx->cur_stripe == SCRUB_STRIPES_PER_SCTX)
+		return flush_scrub_stripes(sctx);
+
+	/* We have filled one group, submit them now. */
+	if (sctx->cur_stripe % SCRUB_STRIPES_PER_GROUP == 0) {
+		struct blk_plug plug;
+
+		scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
+			      btrfs_stripe_nr_to_offset(SCRUB_STRIPES_PER_GROUP));
+
+		blk_start_plug(&plug);
+		for (int i = sctx->cur_stripe - SCRUB_STRIPES_PER_GROUP;
+		     i < sctx->cur_stripe; i++) {
+			stripe = &sctx->stripes[i];
+			scrub_submit_initial_read(sctx, stripe);
+		}
+		blk_finish_plug(&plug);
+	}
 	return 0;
 }
 
@@ -1965,6 +2008,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
 		u64 cur_physical = physical + cur_logical - logical_start;
+		u64 found_logical;
 
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
@@ -1988,7 +2032,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 		ret = queue_scrub_stripe(sctx, bg, device, mirror_num,
 					 cur_logical, logical_end - cur_logical,
-					 cur_physical);
+					 cur_physical, &found_logical);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
 			sctx->stat.last_physical = physical + logical_length;
@@ -1998,9 +2042,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		if (ret < 0)
 			break;
 
-		ASSERT(sctx->cur_stripe > 0);
-		cur_logical = sctx->stripes[sctx->cur_stripe - 1].logical
-			      + BTRFS_STRIPE_LEN;
+		cur_logical = found_logical + BTRFS_STRIPE_LEN;
 
 		/* Don't hold CPU for too long time */
 		cond_resched();
-- 
2.41.0

