Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88DE745625
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGCHdW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGCHdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3ACE51
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CEBE21900
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFH1qbuWAjyc8HOMyITGcpkkMhDRlnZ+Ia5Lco34zkc=;
        b=lgPZ5DGU0MAy0mT0qkrf0A87YdIxxn0Hv75AwznQjvo54L7CT9clXnqqxTo0lv5g/PIa2d
        1zR57G/HH+SheJvIRwxm2hezjiOn9jQPElabDj4aAk+nDu0ieWKq5fUd73t7l+sQmCWqg/
        cTYTIZvs9QzPrYE4Dkw3JRHIkTkj52M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A22E113276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0C6QG7V5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/14] btrfs: scrub: implement the repair part of scrub logical
Date:   Mon,  3 Jul 2023 15:32:35 +0800
Message-ID: <d4fd978dfec712284094c4f424dcbabf4c8e58ec.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

The repair part of scrub logical is done differently compared to the
per-device counterpart:

- We read out all mirrors in one go
  Since it's no longer per-device, we just read out all mirrors.

- Find a good mirror for the same sectornr of all mirrors

- Copy the good content to any corrupted sector

This has several advantages:

- Less IO wait
  Since all IOs are submitted at the very beginning, we avoid the read
  then wait for per-device scrub.

  This applies to both read and write part.

This needs some changes to the per-device scrub code though:

- Call the scrub_verify_one_stripe() inside scrub_read_endio()
  This is to improve the performance, as we can have csum verification
  per-mirror.

- Do not queue scrub_stripe_read_repair_worker() workload for
  scrub_logical
  Since we don't need to go per-device repair path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 148 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 138 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 02b212fe4712..21b3fa55d0f0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -995,7 +995,6 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	ASSERT(stripe->mirror_num > 0);
 
 	wait_scrub_stripe_io(stripe);
-	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
 	/* Save the initial failed bitmap for later repair and report usage. */
 	stripe->init_error_bitmap = stripe->error_bitmap;
 	stripe->init_nr_io_errors = bitmap_weight(&stripe->io_error_bitmap,
@@ -1068,9 +1067,12 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io)) {
+		scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
 		wake_up(&stripe->io_wait);
-		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
-		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
+		if (!stripe->sctx->scrub_logical) {
+			INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
+			queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
+		}
 	}
 }
 
@@ -1655,7 +1657,131 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 	return false;
 }
 
-static int flush_scrub_stripes(struct scrub_ctx *sctx)
+/*
+ * Unlike the per-device repair, we have all mirrors read out already.
+ *
+ * Thus we only need to find out the good mirror, and copy the content to
+ * any bad sectors.
+ */
+static void repair_one_mirror_group(struct scrub_ctx *sctx, int start_stripe,
+				    int ncopies)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct scrub_stripe *first_stripe = &sctx->stripes[start_stripe];
+	struct scrub_stripe *cur_stripe;
+	const u32 sectorsize = fs_info->sectorsize;
+	int sectornr;
+
+	ASSERT(start_stripe + ncopies <= sctx->cur_stripe);
+
+	for_each_set_bit(sectornr, &first_stripe->extent_sector_bitmap,
+			 first_stripe->nr_sectors) {
+		struct scrub_stripe *good_stripe;
+		int good_mirror = -1;
+
+		for (int cur_mirror = start_stripe;
+		     cur_mirror < start_stripe + ncopies; cur_mirror++) {
+			cur_stripe = &sctx->stripes[cur_mirror];
+
+			if (!test_bit(sectornr, &cur_stripe->error_bitmap)) {
+				good_mirror = cur_mirror;
+				break;
+			}
+		}
+		/* No good mirror found, this vertical stripe can not be repaired. */
+		if (good_mirror < 0)
+			continue;
+
+		good_stripe = &sctx->stripes[good_mirror];
+
+		for (int cur_mirror = start_stripe;
+		     cur_mirror < start_stripe + ncopies; cur_mirror++) {
+			cur_stripe = &sctx->stripes[cur_mirror];
+
+			if (!test_bit(sectornr, &cur_stripe->error_bitmap))
+				continue;
+			/* Repair from the good mirror. */
+			memcpy_page(scrub_stripe_get_page(cur_stripe, sectornr),
+				    scrub_stripe_get_page_offset(cur_stripe, sectornr),
+				    scrub_stripe_get_page(good_stripe, sectornr),
+				    scrub_stripe_get_page_offset(good_stripe, sectornr),
+				    sectorsize);
+			clear_bit(sectornr, &cur_stripe->error_bitmap);
+			clear_bit(sectornr, &cur_stripe->io_error_bitmap);
+			if (cur_stripe->sectors[sectornr].is_metadata)
+				clear_bit(sectornr, &cur_stripe->meta_error_bitmap);
+			else
+				clear_bit(sectornr, &cur_stripe->csum_error_bitmap);
+		}
+	}
+	for (int cur_mirror = start_stripe; cur_mirror < start_stripe + ncopies;
+	     cur_mirror++) {
+		cur_stripe = &sctx->stripes[cur_mirror];
+		set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &cur_stripe->state);
+		scrub_stripe_report_errors(sctx, cur_stripe);
+		wake_up(&cur_stripe->repair_wait);
+
+		if (btrfs_is_zoned(fs_info)) {
+			if (!bitmap_empty(&cur_stripe->init_error_bitmap,
+					  cur_stripe->nr_sectors)) {
+				btrfs_repair_one_zone(fs_info, cur_stripe->logical);
+				break;
+			}
+		}
+		if (!sctx->readonly) {
+			unsigned long repaired;
+
+			bitmap_andnot(&repaired, &cur_stripe->init_error_bitmap,
+				      &cur_stripe->error_bitmap,
+				      cur_stripe->nr_sectors);
+			scrub_write_sectors(sctx, cur_stripe, repaired, false);
+		}
+	}
+	/* Wait for above writeback to finish. */
+	for (int cur_mirror = start_stripe; cur_mirror < start_stripe + ncopies;
+	     cur_mirror++) {
+		cur_stripe = &sctx->stripes[cur_mirror];
+
+		wait_scrub_stripe_io(cur_stripe);
+	}
+}
+
+static int handle_logical_stripes(struct scrub_ctx *sctx,
+				  struct btrfs_block_group *bg)
+{
+	const int nr_stripes = sctx->cur_stripe;
+	const int group_stripes = btrfs_bg_type_to_factor(bg->flags);
+	struct scrub_stripe *stripe;
+
+	for (int i = 0; i < nr_stripes; i++) {
+		stripe = &sctx->stripes[i];
+
+		scrub_submit_initial_read(sctx, stripe);
+	}
+	for (int i = 0; i < nr_stripes; i++) {
+		stripe = &sctx->stripes[i];
+
+		wait_scrub_stripe_io(stripe);
+
+		/* Save the initial failed bitmap for later repair and report usage. */
+		stripe->init_error_bitmap = stripe->error_bitmap;
+		stripe->init_nr_io_errors =
+			bitmap_weight(&stripe->io_error_bitmap, stripe->nr_sectors);
+		stripe->init_nr_csum_errors =
+			bitmap_weight(&stripe->csum_error_bitmap, stripe->nr_sectors);
+		stripe->init_nr_meta_errors =
+			bitmap_weight(&stripe->meta_error_bitmap, stripe->nr_sectors);
+	}
+
+	for (int i = 0; i < nr_stripes; i += group_stripes)
+		repair_one_mirror_group(sctx, i, group_stripes);
+	sctx->cur_stripe = 0;
+
+	return 0;
+}
+
+static int flush_scrub_stripes(struct scrub_ctx *sctx,
+			       struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct scrub_stripe *stripe;
@@ -1666,6 +1792,9 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 	if (!nr_stripes)
 		return 0;
 
+	if (sctx->scrub_logical)
+		return handle_logical_stripes(sctx, bg);
+
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &sctx->stripes[0].state));
 
 	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
@@ -1762,7 +1891,7 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 
 	/* No available slot, submit all stripes and wait for them. */
 	if (sctx->cur_stripe >= sctx->nr_stripes) {
-		ret = flush_scrub_stripes(sctx);
+		ret = flush_scrub_stripes(sctx, bg);
 		if (ret < 0)
 			return ret;
 	}
@@ -2250,7 +2379,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			break;
 	}
 out:
-	ret2 = flush_scrub_stripes(sctx);
+	ret2 = flush_scrub_stripes(sctx, bg);
 	if (!ret)
 		ret = ret2;
 	if (sctx->raid56_data_stripes) {
@@ -3025,8 +3154,7 @@ static void scrub_copy_stripe(const struct scrub_stripe *src,
 static int queue_scrub_logical_stripes(struct scrub_ctx *sctx,
 			struct btrfs_block_group *bg, u64 logical)
 {
-	const int raid_index = btrfs_bg_flags_to_raid_index(bg->flags);
-	const int nr_copies = btrfs_raid_array[raid_index].ncopies;
+	const int nr_copies = btrfs_bg_type_to_factor(bg->flags);
 	const int old_cur = sctx->cur_stripe;
 	struct scrub_stripe *stripe;
 	int ret;
@@ -3035,7 +3163,7 @@ static int queue_scrub_logical_stripes(struct scrub_ctx *sctx,
 	ASSERT(sctx->nr_stripes);
 
 	if (sctx->cur_stripe + nr_copies > sctx->nr_stripes) {
-		ret = flush_scrub_stripes(sctx);
+		ret = flush_scrub_stripes(sctx, bg);
 		if (ret < 0)
 			return ret;
 	}
@@ -3133,7 +3261,7 @@ static int scrub_logical_one_chunk(struct scrub_ctx *sctx,
 		cur = sctx->stripes[sctx->cur_stripe - 1].logical + BTRFS_STRIPE_LEN;
 	}
 out:
-	flush_ret = flush_scrub_stripes(sctx);
+	flush_ret = flush_scrub_stripes(sctx, bg);
 	if (!ret)
 		ret = flush_ret;
 	free_scrub_stripes(sctx);
-- 
2.41.0

