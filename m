Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D2747D70
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 08:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjGEGuR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 02:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjGEGtr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 02:49:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0BA19B6
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jul 2023 23:49:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2F81F88E;
        Wed,  5 Jul 2023 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688539747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/aaLjzRXWopYVBb9wc5oPvN8xOkHdRDzOjF350qkfi0=;
        b=E/ZYmajr81fLOTqkEyns6mB6bVni+rNkdD3mX3QdVS977hFB9KpicvFE361WEbpySgnx/j
        oxk67LLrGPx/SD59gbN2nLuRWopVh1XrlIoWkUpKEEH0o6q+n3YtB0Xs2hi+ntkhf/nTD/
        EVPXUZfZNpUG6MEeh40AvszOD/Xfiv8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ED6A134F3;
        Wed,  5 Jul 2023 06:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rpJ1BmISpWTSGgAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 05 Jul 2023 06:49:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Subject: [PATCH] btrfs: speedup scrub csum verification
Date:   Wed,  5 Jul 2023 14:48:48 +0800
Message-ID: <6c1ffe48e93fee9aa975ecc22dc2e7a1f3d7a0de.1688539673.git.wqu@suse.com>
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
There is a report about scrub is much slower on v6.4 kernel on fast NVME
devices.

The system has a NVME device which can reach over 3GBytes/s, but scrub
speed is below 1GBytes/s.

[CAUSE]
Since commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
scrub_stripe infrastructure") scrub goes a completely new
implementation.

There is a behavior change, where previously scrub is doing csum
verification in one-thread-per-block way, but the new code goes
one-thread-per-stripe way.

This means for the worst case, new code would only have one thread
verifying a whole 64K stripe filled with data.

While the old code is doing 16 threads to handle the same stripe.

Considering the reporter's CPU can only do CRC32C at around 2GBytes/s,
while the NVME drive can do 3GBytes/s, the difference can be big:

	1 thread:	1 / ( 1 / 3 + 1 / 2)     = 1.2 Gbytes/s
	8 threads: 	1 / ( 1 / 3 + 1 / 8 / 2) = 2.5 Gbytes/s

[FIX]
To fix the performance regression, this patch would introduce
multi-thread csum verification by:

- Introduce a new workqueue for scrub csum verification
  The new workqueue is needed as we can not queue the same csum work
  into the main scrub worker, where we are waiting for the csum work
  to finish.
  Or this can lead to dead lock if there is no more worker allocated.

- Add extra members to scrub_sector_verification
  This allows a work to be queued for the specific sector.
  Although this means we will have 20 bytes overhead per sector.

- Queue sector verification work into scrub_csum_worker
  This allows multiple threads to handle the csum verification workload.

- Do not reset stripe->sectors during scrub_find_fill_first_stripe()
  Since sectors now contain extra info, we should not touch those
  members.

Reported-by: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Link: https://lore.kernel.org/linux-btrfs/CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h    |  1 +
 fs/btrfs/scrub.c | 66 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..0c0cb5b0e471 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -643,6 +643,7 @@ struct btrfs_fs_info {
 	 */
 	refcount_t scrub_workers_refcnt;
 	struct workqueue_struct *scrub_workers;
+	struct workqueue_struct *scrub_csum_workers;
 	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 38c103f13fd5..f4df3b8852a6 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -72,6 +72,11 @@ struct scrub_sector_verification {
 		 */
 		u64 generation;
 	};
+
+	/* For multi-thread verification. */
+	struct scrub_stripe *stripe;
+	struct work_struct work;
+	unsigned int sector_nr;
 };
 
 enum scrub_stripe_flags {
@@ -258,6 +263,12 @@ static int init_scrub_stripe(struct btrfs_fs_info *fs_info,
 				  GFP_KERNEL);
 	if (!stripe->sectors)
 		goto error;
+	for (int i = 0; i < stripe->nr_sectors; i++) {
+		struct scrub_sector_verification *sector = &stripe->sectors[i];
+
+		sector->stripe = stripe;
+		sector->sector_nr = i;
+	}
 
 	stripe->csums = kcalloc(BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits,
 				fs_info->csum_size, GFP_KERNEL);
@@ -680,11 +691,11 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 
 	/* Sector not utilized, skip it. */
 	if (!test_bit(sector_nr, &stripe->extent_sector_bitmap))
-		return;
+		goto out;
 
 	/* IO error, no need to check. */
 	if (test_bit(sector_nr, &stripe->io_error_bitmap))
-		return;
+		goto out;
 
 	/* Metadata, verify the full tree block. */
 	if (sector->is_metadata) {
@@ -702,10 +713,10 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 				      stripe->logical +
 				      (sector_nr << fs_info->sectorsize_bits),
 				      stripe->logical);
-			return;
+			goto out;
 		}
 		scrub_verify_one_metadata(stripe, sector_nr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -714,7 +725,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 	 */
 	if (!sector->csum) {
 		clear_bit(sector_nr, &stripe->error_bitmap);
-		return;
+		goto out;
 	}
 
 	ret = btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, sector->csum);
@@ -725,6 +736,17 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		clear_bit(sector_nr, &stripe->csum_error_bitmap);
 		clear_bit(sector_nr, &stripe->error_bitmap);
 	}
+out:
+	atomic_dec(&stripe->pending_io);
+	wake_up(&stripe->io_wait);
+}
+
+static void scrub_verify_work(struct work_struct *work)
+{
+	struct scrub_sector_verification *sector = container_of(work,
+			struct scrub_sector_verification, work);
+
+	scrub_verify_one_sector(sector->stripe, sector->sector_nr);
 }
 
 /* Verify specified sectors of a stripe. */
@@ -734,11 +756,24 @@ static void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long b
 	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
 	int sector_nr;
 
+	/* All IO should have finished, and we will reuse pending_io soon. */
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+
 	for_each_set_bit(sector_nr, &bitmap, stripe->nr_sectors) {
-		scrub_verify_one_sector(stripe, sector_nr);
+		struct scrub_sector_verification *sector = &stripe->sectors[sector_nr];
+
+		/* The sector should have been initialized. */
+		ASSERT(sector->sector_nr == sector_nr);
+		ASSERT(sector->stripe == stripe);
+
+		atomic_inc(&stripe->pending_io);
+		INIT_WORK(&sector->work, scrub_verify_work);
+		queue_work(fs_info->scrub_csum_workers, &sector->work);
+
 		if (stripe->sectors[sector_nr].is_metadata)
 			sector_nr += sectors_per_tree - 1;
 	}
+	wait_scrub_stripe_io(stripe);
 }
 
 static int calc_sector_number(struct scrub_stripe *stripe, struct bio_vec *first_bvec)
@@ -1484,8 +1519,6 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	u64 extent_gen;
 	int ret;
 
-	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
-				   stripe->nr_sectors);
 	scrub_stripe_reset_bitmaps(stripe);
 
 	/* The range must be inside the bg. */
@@ -2692,12 +2725,17 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 	if (refcount_dec_and_mutex_lock(&fs_info->scrub_workers_refcnt,
 					&fs_info->scrub_lock)) {
 		struct workqueue_struct *scrub_workers = fs_info->scrub_workers;
+		struct workqueue_struct *scrub_csum_workers =
+			fs_info->scrub_csum_workers;
 
 		fs_info->scrub_workers = NULL;
+		fs_info->scrub_csum_workers = NULL;
 		mutex_unlock(&fs_info->scrub_lock);
 
 		if (scrub_workers)
 			destroy_workqueue(scrub_workers);
+		if (scrub_csum_workers)
+			destroy_workqueue(scrub_csum_workers);
 	}
 }
 
@@ -2708,6 +2746,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 						int is_dev_replace)
 {
 	struct workqueue_struct *scrub_workers = NULL;
+	struct workqueue_struct *scrub_csum_workers = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
@@ -2722,10 +2761,18 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	if (!scrub_workers)
 		return -ENOMEM;
 
+	scrub_csum_workers = alloc_workqueue("btrfs-scrub-csum", flags, max_active);
+	if (!scrub_csum_workers) {
+		destroy_workqueue(scrub_workers);
+		return -ENOMEM;
+	}
+
 	mutex_lock(&fs_info->scrub_lock);
 	if (refcount_read(&fs_info->scrub_workers_refcnt) == 0) {
-		ASSERT(fs_info->scrub_workers == NULL);
+		ASSERT(fs_info->scrub_workers == NULL &&
+		       fs_info->scrub_csum_workers == NULL);
 		fs_info->scrub_workers = scrub_workers;
+		fs_info->scrub_csum_workers = scrub_csum_workers;
 		refcount_set(&fs_info->scrub_workers_refcnt, 1);
 		mutex_unlock(&fs_info->scrub_lock);
 		return 0;
@@ -2737,6 +2784,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	ret = 0;
 
 	destroy_workqueue(scrub_workers);
+	destroy_workqueue(scrub_csum_workers);
 	return ret;
 }
 
-- 
2.41.0

