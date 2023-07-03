Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D4745626
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjGCHdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGCHdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE292E52
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70766218FC
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eO1iej0py8goBFlIIh/KF0ANhgOXs2kxz+dDsLd/rEY=;
        b=qUmAn28FaJuzGUb7XZ6ScSDBqvomgVVUYgNPM1q/8l3lfDnawzIcBtwLsvemjSUQxjPJg5
        xpifD9mLwrkDg9md+c+th1A3Nf/qKU7A6Y+65YFxUUDKY19O9kc72hY+kl0UFbebp8z4uP
        hHUMKNRhapIzcfdQm914yEIOgzQ/VJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5A1613276
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 07:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uDyII7h5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:33:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/14] btrfs: scrub: implement the RAID56 P/Q scrub code
Date:   Mon,  3 Jul 2023 15:32:38 +0800
Message-ID: <8538a4b8c0f2cfa762863ae735a774f903090acb.1688368617.git.wqu@suse.com>
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

For RAID56 P/Q stripe verification, we already have an existing path
inside scrub_raid56_parity_stripe().

Although the existing path is only to verify one P/Q stripe, with recent
changes to scrub_rbio(), we only need to pass a NULL @scrub_dev to
raid56_parity_alloc_scrub_rbio(), then we can verify both P/Q stripes in
one go.

So here we introduce a helper, submit_raid56_pq_scrub_bio(), to do the
necessary work of P/Q stripes verification and repair.

The new helper would be utilized by both scrub_logical and the existing
per-device scrub, and both would use the repaired data stripes to reduce
IO for RAID56 scrub.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 106 +++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4ca502fa0b40..2a882a07b388 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1782,6 +1782,58 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 	return false;
 }
 
+static int submit_raid56_pq_scrub_bio(struct scrub_ctx *sctx,
+				      struct map_lookup *map,
+				      struct scrub_stripe *first_data_stripe,
+				      int group_stripes,
+				      struct btrfs_device *scrub_dev,
+				      unsigned long extent_bitmap)
+{
+	DECLARE_COMPLETION_ONSTACK(io_done);
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_raid_bio *rbio;
+	struct bio *bio;
+	const int data_stripes = nr_data_stripes(map);
+	u64 full_stripe_start = first_data_stripe->logical;
+	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
+	int ret;
+
+	bio = bio_alloc(NULL, 1, REQ_OP_READ, GFP_NOFS);
+	bio->bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
+	bio->bi_private = &io_done;
+	bio->bi_end_io = raid56_scrub_wait_endio;
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
+			      &length, &bioc, NULL, NULL, 1);
+	if (ret < 0) {
+		btrfs_put_bioc(bioc);
+		btrfs_bio_counter_dec(fs_info);
+		return ret;
+	}
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap);
+	btrfs_put_bioc(bioc);
+	if (!rbio) {
+		ret = -ENOMEM;
+		btrfs_bio_counter_dec(fs_info);
+		return ret;
+	}
+	/* Use the recovered stripes as cache to avoid read them from disk again. */
+	ASSERT(group_stripes <= map->num_stripes);
+	for (int i = 0; i < group_stripes; i++) {
+		struct scrub_stripe *stripe = first_data_stripe + i;
+
+		raid56_parity_cache_pages(rbio, stripe->pages, i);
+	}
+	raid56_parity_submit_scrub_rbio(rbio);
+	wait_for_completion_io(&io_done);
+	ret = blk_status_to_errno(bio->bi_status);
+	bio_put(bio);
+	btrfs_bio_counter_dec(fs_info);
+	return 0;
+}
+
 static int repair_raid56_full_stripe(struct scrub_ctx *sctx, int start_stripe,
 				     int group_stripes)
 {
@@ -1853,8 +1905,14 @@ static int repair_raid56_full_stripe(struct scrub_ctx *sctx, int start_stripe,
 		wait_scrub_stripe_io(stripe);
 	}
 
-	/* Still need to scrub P/Q stripes. */
-	ret = -EOPNOTSUPP;
+	/*
+	 * All data stripes repaired, now can generate and verify P/Q stripes.
+	 *
+	 * Pass NULL as @scrub_dev, so that both P/Q stripes would be verified.
+	 */
+	ret = submit_raid56_pq_scrub_bio(sctx, sctx->map, first_stripe,
+					 sctx->map->num_stripes, NULL,
+					 extents_bitmap);
 report:
 	/*
 	 * Update the accounting for data stripes.
@@ -2141,14 +2199,10 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 {
 	DECLARE_COMPLETION_ONSTACK(io_done);
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct btrfs_raid_bio *rbio;
-	struct btrfs_io_context *bioc = NULL;
-	struct bio *bio;
 	struct scrub_stripe *stripe;
 	bool all_empty = true;
 	const int data_stripes = nr_data_stripes(map);
 	unsigned long extent_bitmap = 0;
-	u64 length = btrfs_stripe_nr_to_offset(data_stripes);
 	int ret;
 
 	ASSERT(sctx->raid56_data_stripes);
@@ -2261,38 +2315,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	}
 
 	/* Now we can check and regenerate the P/Q stripe. */
-	bio = bio_alloc(NULL, 1, REQ_OP_READ, GFP_NOFS);
-	bio->bi_iter.bi_sector = full_stripe_start >> SECTOR_SHIFT;
-	bio->bi_private = &io_done;
-	bio->bi_end_io = raid56_scrub_wait_endio;
-
-	btrfs_bio_counter_inc_blocked(fs_info);
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
-			      &length, &bioc, NULL, NULL, 1);
-	if (ret < 0) {
-		btrfs_put_bioc(bioc);
-		btrfs_bio_counter_dec(fs_info);
-		goto out;
-	}
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, scrub_dev, &extent_bitmap);
-	btrfs_put_bioc(bioc);
-	if (!rbio) {
-		ret = -ENOMEM;
-		btrfs_bio_counter_dec(fs_info);
-		goto out;
-	}
-	/* Use the recovered stripes as cache to avoid read them from disk again. */
-	for (int i = 0; i < data_stripes; i++) {
-		stripe = &sctx->raid56_data_stripes[i];
-
-		raid56_parity_cache_pages(rbio, stripe->pages, i);
-	}
-	raid56_parity_submit_scrub_rbio(rbio);
-	wait_for_completion_io(&io_done);
-	ret = blk_status_to_errno(bio->bi_status);
-	bio_put(bio);
-	btrfs_bio_counter_dec(fs_info);
-
+	ret = submit_raid56_pq_scrub_bio(sctx, map, sctx->raid56_data_stripes,
+					 data_stripes, scrub_dev, extent_bitmap);
 out:
 	return ret;
 }
@@ -3545,12 +3569,6 @@ static int scrub_logical_one_chunk(struct scrub_ctx *sctx,
 
 	scrub_blocked_if_needed(fs_info);
 
-	/* RAID56 not yet supported. */
-	if (bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
 	nr_stripes = SCRUB_STRIPES_PER_SCTX * nr_copies;
 	ret = alloc_scrub_stripes(sctx, nr_stripes);
 	if (ret < 0)
-- 
2.41.0

