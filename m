Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8A76E049
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjHCGeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjHCGd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 02:33:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A879EE7D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 23:33:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6BEB3219B2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691044436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSNTvkBQ/DtiQ5Xg/L4+Qhhx3yBWPyvZufn5zJUjEhA=;
        b=HAl/Zfe+S6kO9mjumVMSxN19B0VPNrdK2MBqn3SriVdFef11Pmyn1CxX8aRtycj9I2QbsA
        TlpoTKyzmxM+kLNCutWyu+LJ0BKJMqTQAOU57pmySLUNSew8F+6nR2vHIi5B/83xgaEHs1
        cWJEfXAWn11EjeqAPQH2QdesQzXb5eg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5649C134B0
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 06:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sExzCFNKy2SjGAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 06:33:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs: scrub: fix grouping of read IO
Date:   Thu,  3 Aug 2023 14:33:31 +0800
Message-ID: <796b9068a2ad3c62c9374ac6ca67a2054b85354f.1691044274.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691044274.git.wqu@suse.com>
References: <cover.1691044274.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[REGRESSION]
There are several regression reports about the scrub performance with
v6.4 kernel.

On a PCIe 3.0 device, the old v6.3 kernel can go 3GB/s scrub speed, but
v6.4 can only go 1GB/s, an obvious 66% performance drop.

[CAUSE]
Iostat shows a very different behavior between v6.3 and v6.4 kernel:

 Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
 nvme0n1p3  9731.00 3425544.00 17237.00  63.92    2.18   352.02  21.18 100.00
 nvme0n1p3 15578.00  993616.00     5.00   0.03    0.09    63.78   1.32 100.00

The upper one is v6.3 while the lower one is v6.4.

There are several obvious differences:

- Very few read merges
  This turns out to be a behavior change that we no longer go bio
  plug/unplug.

- Very low aqu-sz
  This is due to the submit-and-wait behavior of flush_scrub_stripes(),
  and extra extent/csum tree search.

Both behavior is not that obvious on SATA SSDs, as SATA SSDs has NCQ to
merge the reads, while SATA SSDs can not handle high queue depth well
either.

[FIX]
For now this patch focuses on the read speed fix. Dev-replace replace
speed needs more work.

For the read part, we go two directions to fix the problems:

- Re-introduce blk plug/unplug to merge read requests
  This is pretty simple, and the behavior is pretty easy to observe.

  This would enlarge the average read request size to 512K.

- Introduce multi-group reads and no longer waits for each group
  Instead of the old behavior, which submits 8 stripes and waits for
  them, here we would enlarge the total number of stripes to 16 * 8.
  Which is 8M per device, the same limit as the old scrub in-flight
  bios size limit.

  Now every time we fill a group (8 stripes), we submit them and
  continue to next stripes.

  Only when the full 16 * 8 stripes are all filled, we submit the
  remaining ones (the last group), and wait for all groups to finish.
  Then submit the repair writes and dev-replace writes.

  This should enlarge the queue depth.

This would greatly improve the merge rate (thus read block size) and
queue depth:

Before (with regression, and cached extent/csum path):

 Device         r/s      rkB/s   rrqm/s  %rrqm r_await rareq-sz aqu-sz  %util
 nvme0n1p3 20666.00 1318240.00    10.00   0.05    0.08    63.79   1.63 100.00

After (with all patches applied):

 nvme0n1p3  5165.00 2278304.00 30557.00  85.54    0.55   441.10   2.81 100.00
---
 fs/btrfs/scrub.c | 95 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 1748735f72c6..bfa8feee257f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -43,9 +43,21 @@ struct scrub_ctx;
 /*
  * The following value only influences the performance.
  *
- * This determines the batch size for stripe submitted in one go.
+ * This detemines how many stripes would be submitted in one go,
+ * this would 512KiB (BTRFS_STRIPE_LEN * SCRUB_STRIPES_PER_GROUP).
  */
-#define SCRUB_STRIPES_PER_SCTX	8	/* That would be 8 64K stripe per-device. */
+#define SCRUB_STRIPES_PER_GROUP		8
+
+/*
+ * How many groups we have for each sctx.
+ *
+ * This would be 8M per device, the same value as the old scrub in-flight bios
+ * size limit.
+ */
+#define SCRUB_GROUPS_PER_SCTX		16
+
+#define SCRUB_TOTAL_STRIPES		(SCRUB_GROUPS_PER_SCTX * \
+					 SCRUB_STRIPES_PER_GROUP)
 
 /*
  * The following value times PAGE_SIZE needs to be large enough to match the
@@ -172,7 +184,7 @@ struct scrub_stripe {
 };
 
 struct scrub_ctx {
-	struct scrub_stripe	stripes[SCRUB_STRIPES_PER_SCTX];
+	struct scrub_stripe	stripes[SCRUB_TOTAL_STRIPES];
 	struct scrub_stripe	*raid56_data_stripes;
 	struct btrfs_fs_info	*fs_info;
 	struct btrfs_path	extent_path;
@@ -317,7 +329,7 @@ static noinline_for_stack void scrub_free_ctx(struct scrub_ctx *sctx)
 	if (!sctx)
 		return;
 
-	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++)
+	for (i = 0; i < SCRUB_TOTAL_STRIPES; i++)
 		release_scrub_stripe(&sctx->stripes[i]);
 
 	kfree(sctx);
@@ -345,7 +357,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	sctx->extent_path.skip_locking = 1;
 	sctx->csum_path.search_commit_root = 1;
 	sctx->csum_path.skip_locking = 1;
-	for (i = 0; i < SCRUB_STRIPES_PER_SCTX; i++) {
+	for (i = 0; i < SCRUB_TOTAL_STRIPES; i++) {
 		int ret;
 
 		ret = init_scrub_stripe(fs_info, &sctx->stripes[i]);
@@ -1657,6 +1669,29 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 	return false;
 }
 
+static void submit_initial_group_read(struct scrub_ctx *sctx,
+				      unsigned int first_slot,
+				      unsigned int nr_stripes)
+{
+	struct blk_plug plug;
+
+	ASSERT(first_slot < SCRUB_TOTAL_STRIPES);
+	ASSERT(first_slot + nr_stripes <= SCRUB_TOTAL_STRIPES);
+
+	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
+			      btrfs_stripe_nr_to_offset(nr_stripes));
+	blk_start_plug(&plug);
+	for (int i = 0; i < nr_stripes; i++) {
+		struct scrub_stripe *stripe = &sctx->stripes[first_slot + i];
+
+		/* Those stripes should be initialized. */
+		ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
+
+		scrub_submit_initial_read(sctx, stripe);
+	}
+	blk_finish_plug(&plug);
+}
+
 static int flush_scrub_stripes(struct scrub_ctx *sctx)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
@@ -1669,11 +1704,13 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
 
-	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
-			      btrfs_stripe_nr_to_offset(nr_stripes));
-	for (int i = 0; i < nr_stripes; i++) {
-		stripe = &sctx->stripes[i];
-		scrub_submit_initial_read(sctx, stripe);
+	/* Submit the stripes which are populated but not submitted. */
+	if (nr_stripes % SCRUB_STRIPES_PER_GROUP) {
+		const int first_slot = round_down(nr_stripes,
+						  SCRUB_STRIPES_PER_GROUP);
+
+		submit_initial_group_read(sctx, first_slot,
+					  nr_stripes - first_slot);
 	}
 
 	for (int i = 0; i < nr_stripes; i++) {
@@ -1753,21 +1790,19 @@ static void raid56_scrub_wait_endio(struct bio *bio)
 
 static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *bg,
 			      struct btrfs_device *dev, int mirror_num,
-			      u64 logical, u32 length, u64 physical)
+			      u64 logical, u32 length, u64 physical,
+			      u64 *found_logical_ret)
 {
 	struct scrub_stripe *stripe;
 	int ret;
 
-	/* No available slot, submit all stripes and wait for them. */
-	if (sctx->cur_stripe >= SCRUB_STRIPES_PER_SCTX) {
-		ret = flush_scrub_stripes(sctx);
-		if (ret < 0)
-			return ret;
-	}
+	/*
+	 * There should always be one slot left, as caller filling the last
+	 * slot should flush them all.
+	 */
+	ASSERT(sctx->cur_stripe < SCRUB_TOTAL_STRIPES);
 
 	stripe = &sctx->stripes[sctx->cur_stripe];
-
-	/* We can queue one stripe using the remaining slot. */
 	scrub_reset_stripe(stripe);
 	ret = scrub_find_fill_first_stripe(bg, &sctx->extent_path,
 			&sctx->csum_path, dev, physical, mirror_num, logical,
@@ -1775,7 +1810,22 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	/* Either >0 as no more extents or <0 for error. */
 	if (ret)
 		return ret;
+	if (found_logical_ret)
+		*found_logical_ret = stripe->logical;
 	sctx->cur_stripe++;
+
+	/* We filled one group, submit them. */
+	if (sctx->cur_stripe % SCRUB_STRIPES_PER_GROUP == 0) {
+		const int first_slot = sctx->cur_stripe -
+				       SCRUB_STRIPES_PER_GROUP;
+
+		submit_initial_group_read(sctx, first_slot,
+					  SCRUB_STRIPES_PER_GROUP);
+	}
+
+	/* Last slot used, flush them all. */
+	if (sctx->cur_stripe == SCRUB_TOTAL_STRIPES)
+		return flush_scrub_stripes(sctx);
 	return 0;
 }
 
@@ -1984,6 +2034,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 	/* Go through each extent items inside the logical range */
 	while (cur_logical < logical_end) {
+		u64 found_logical;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
 		/* Canceled? */
@@ -2008,7 +2059,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 		ret = queue_scrub_stripe(sctx, bg, device, mirror_num,
 					 cur_logical, logical_end - cur_logical,
-					 cur_physical);
+					 cur_physical, &found_logical);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
 			sctx->stat.last_physical = physical + logical_length;
@@ -2018,9 +2069,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
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

