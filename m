Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C5643E76
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiLFIYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiLFIYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E31572C
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:04 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5AB51FE71
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coso4UdSH4Ds/0byzwJhw+jNeHVi3yKj1p/tdnpxAgQ=;
        b=RDQYdElnhl1BmXdG0bZVNDmG0CM2I4B5tcQ8epQCNSVPrpv0IfJi9N00pm1ChgHyw1O/rk
        1eAKpDCR8zPpCiYkzxWqYIOouzyml38/QRogIK65Zs1rztGecYVI9C/OSOaGs1uoXxDoF6
        lzewkiTjPmuT7++xVlm1UxKv1O7GX/g=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 163F1132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aBOpNSL8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 07/11] btrfs: scrub: add raid56 P/Q scrubbing support
Date:   Tue,  6 Dec 2022 16:23:34 +0800
Message-Id: <9a9101481ba88a952e50963030599d8e987be006.1670314744.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
References: <cover.1670314744.git.wqu@suse.com>
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

The overall idea is pretty much the same as the old RAID56 P/Q scrub
code, but there are some difference:

- If data stripes contains any sector which can not be repaired, we
  abort

  This is to prevent corrupted sector to spread to P/Q.
  Although if we failed to repair the data sectors, there is already not
  much left to save in P/Q.
  We may still want to hold the P/Q untouched, as there is still cases
  like degraded RAID56, if that missing device come back, we may recover
  the corruption.

- Use the scrub2 interface to scrub the data stripes
  Obviously, this is to remove the dependency on the old infra.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 256 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h |   7 +-
 2 files changed, 257 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf0b879709b1..162f7e1dd378 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -180,6 +180,26 @@ struct scrub2_stripe {
 	 * We reuse the same eb for all metadata of the same stripe.
 	 */
 	struct extent_buffer *dummy_eb;
+
+	/* The following members are only for stripe group usage.*/
+	struct work_struct work;
+	struct scrub2_stripe_group *group;
+};
+
+/*
+ * Indicate multiple (related) stripes in a group.
+ *
+ * This is mostly for RAID56 usage only.
+ */
+struct scrub2_stripe_group {
+	struct scrub_ctx *sctx;
+	atomic_t pending_stripes;
+	wait_queue_head_t stripe_wait;
+	int nr_stripes;
+
+	struct btrfs_io_context *bioc;
+
+	struct scrub2_stripe **stripes;
 };
 
 struct scrub_recover {
@@ -3998,8 +4018,8 @@ static void scrub2_write_endio(struct btrfs_bio *bbio)
  * Called by scrub repair (writeback repaired sectors) or dev-replace
  * (writeback the sectors to the replace dst device).
  */
-void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
-			      unsigned long *write_bitmap)
+static void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
+				     unsigned long *write_bitmap)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct bio *bio = NULL;
@@ -4047,7 +4067,7 @@ void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
 	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
 }
 
-void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
+static void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct scrub2_stripe *repair;
@@ -4222,6 +4242,236 @@ void scrub2_report_errors(struct scrub_ctx *sctx,
 	spin_unlock(&sctx->stat_lock);
 }
 
+static void scrub2_data_stripe_for_raid56(struct work_struct *work)
+{
+	struct scrub2_stripe *stripe = container_of(work, struct scrub2_stripe,
+						    work);
+	struct scrub2_stripe_group *full_stripe = stripe->group;
+	unsigned long writeback_bitmap = 0;
+
+	ASSERT(full_stripe);
+
+	scrub2_read_and_wait_stripe(stripe);
+	scrub2_repair_one_stripe(stripe);
+
+	bitmap_andnot(&writeback_bitmap, &stripe->init_error_bitmap,
+		      &stripe->current_error_bitmap, stripe->nr_sectors);
+	if (!full_stripe->sctx->readonly)
+		scrub2_writeback_sectors(stripe, &writeback_bitmap);
+
+	if (atomic_dec_and_test(&full_stripe->pending_stripes))
+		wake_up(&full_stripe->stripe_wait);
+}
+
+static void scrub2_release_full_stripe(struct btrfs_fs_info *fs_info,
+				struct scrub2_stripe_group *full_stripe)
+{
+	int i;
+
+	btrfs_put_bioc(full_stripe->bioc);
+	btrfs_bio_counter_dec(fs_info);
+	ASSERT(atomic_read(&full_stripe->pending_stripes) == 0);
+	if (full_stripe->nr_stripes) {
+		for (i = 0; i < full_stripe->nr_stripes; i++) {
+			if (!full_stripe->stripes[i])
+				continue;
+			free_scrub2_stripe(full_stripe->stripes[i]);
+			full_stripe->stripes[i] = 0;
+		}
+		kfree(full_stripe->stripes);
+		full_stripe->stripes = NULL;
+	}
+}
+
+static int scrub2_init_raid56_full_stripe(struct scrub_ctx *sctx,
+				struct btrfs_block_group *bg,
+				struct scrub2_stripe_group *full_stripe,
+				u64 full_stripe_logical)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 mapped_length = fs_info->sectorsize;
+	struct btrfs_io_context *bioc = NULL;
+	int nr_stripes;
+	int nr_pq;
+	int ret;
+	int i;
+
+	memset(full_stripe, 0, sizeof(*full_stripe));
+	atomic_set(&full_stripe->pending_stripes, 0);
+	init_waitqueue_head(&full_stripe->stripe_wait);
+	full_stripe->sctx = sctx;
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
+			       full_stripe_logical, &mapped_length, &bioc);
+	if (ret < 0)
+		goto out;
+
+	ASSERT(bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK);
+	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID6)
+		nr_pq = 2;
+	else
+		nr_pq = 1;
+
+	nr_stripes = bioc->num_stripes - bioc->num_tgtdevs;
+	full_stripe->nr_stripes = nr_stripes - nr_pq;
+
+	full_stripe->stripes = kcalloc(full_stripe->nr_stripes,
+			sizeof(struct scrub2_stripe *), GFP_KERNEL);
+	if (!full_stripe->stripes) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Allocate all stripes.*/
+	for (i = 0; i < full_stripe->nr_stripes; i++) {
+		full_stripe->stripes[i] = alloc_scrub2_stripe(fs_info, bg);
+		if (!full_stripe->stripes[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		full_stripe->stripes[i]->group = full_stripe;
+		full_stripe->stripes[i]->logical = bioc->raid_map[i];
+		full_stripe->stripes[i]->mirror_num = 1;
+	}
+out:
+	scrub2_release_full_stripe(fs_info, full_stripe);
+	return ret;
+}
+
+static int scrub2_wait_data_stripes(struct btrfs_block_group *bg,
+				    struct scrub2_stripe_group *full_stripe,
+				    u64 full_stripe_logical)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_root *extent_root;
+	struct btrfs_root *csum_root;
+	int ret;
+	int i;
+
+	extent_root = btrfs_extent_root(fs_info, full_stripe_logical);
+	csum_root = btrfs_csum_root(fs_info, full_stripe_logical);
+
+	/* Fullfill the extent info for each data extents. */
+	for (i = 0; i < full_stripe->nr_stripes; i++) {
+		u64 cur_logical = full_stripe_logical + i * BTRFS_STRIPE_LEN;
+
+		ret = scrub2_find_fill_first_stripe(extent_root, csum_root, bg,
+				cur_logical, BTRFS_STRIPE_LEN,
+				full_stripe->stripes[i]);
+		if (ret < 0)
+			goto out;
+	}
+
+	/*
+	 * Now submit data stripes. They go through the regular
+	 * read-verify-repair routine.
+	 */
+	for (i = 0; i < full_stripe->nr_stripes; i++) {
+		INIT_WORK(&full_stripe->stripes[i]->work,
+			  scrub2_data_stripe_for_raid56);
+		atomic_inc(&full_stripe->pending_stripes);
+		queue_work(fs_info->scrub_workers,
+			   &full_stripe->stripes[i]->work);
+	}
+	/*
+	 * We want to wait above scrub for data stripes to finish before
+	 * scrubbing the P/Q stripes.
+	 * As the P/Q scrub relies on above data stripes to be good.
+	 */
+	wait_event(full_stripe->stripe_wait,
+		   atomic_read(&full_stripe->pending_stripes) == 0);
+out:
+	return ret;
+}
+
+static void scrub2_wait_raid56_scrub_endio(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
+/*
+ * For current per-device scrub, RAID56 data stripes are handled just like
+ * RAID0:
+ * - Read data stripes
+ * - Verify
+ * - If corrupted, try extra mirrors (rebuild) and verify again
+ *
+ * But if we hit a parity stripe, we have to do above loop for every data
+ * stripes, and only when all of the sectors in them are fine, we can
+ * check the parity.
+ */
+int scrub2_raid56_parity(struct scrub_ctx *sctx,
+			 struct btrfs_block_group *bg,
+			 struct btrfs_device *target,
+			 u64 full_stripe_logical)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	struct scrub2_stripe_group full_stripe;
+	struct btrfs_raid_bio *rbio;
+	struct bio *bio;
+	DECLARE_COMPLETION_ONSTACK(done);
+	unsigned long used_sector_bitmap = 0;
+	int ret;
+	int i;
+
+	ret = scrub2_init_raid56_full_stripe(sctx, bg, &full_stripe,
+					     full_stripe_logical);
+	if (ret < 0)
+		return ret;
+
+	ret = scrub2_wait_data_stripes(bg, &full_stripe, full_stripe_logical);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If we have any unrepaired sectors, we can not scrub P/Q, as
+	 * it may use corrupted data to calculate new P/Q and spread
+	 * corruption.
+	 */
+	for (i = 0; i < full_stripe.nr_stripes; i++) {
+		struct scrub2_stripe *stripe = full_stripe.stripes[i];
+
+		if (!bitmap_empty(&stripe->current_error_bitmap,
+				  stripe->nr_sectors)) {
+			ret = -EIO;
+			goto out;
+		}
+		/* Also calculate the used_sector_bitmap for P/Q scrub. */
+		bitmap_or(&used_sector_bitmap, &used_sector_bitmap,
+			  &stripe->used_sector_bitmap, stripe->nr_sectors);
+	}
+
+	bio = bio_alloc(NULL, 0, REQ_OP_READ, GFP_KERNEL);
+	ASSERT(bio);
+	bio->bi_iter.bi_sector = full_stripe_logical >> SECTOR_SHIFT;
+	bio->bi_private = &done;
+	bio->bi_end_io = scrub2_wait_raid56_scrub_endio;
+
+	rbio = raid56_parity_alloc_scrub_rbio(bio, full_stripe.bioc, target,
+			&used_sector_bitmap,
+			full_stripe.stripes[0]->nr_sectors);
+	if (!rbio) {
+		bio_put(bio);
+		ret = -ENOMEM;
+		goto out;
+	}
+	raid56_parity_submit_scrub_rbio(rbio);
+
+	/*
+	 * RAID56 scrub code has already handled dev replace case.
+	 * So we just wait for it to finish, and no need to handle
+	 * dev-replace anymore.
+	 */
+	wait_for_completion_io(&done);
+	ret = blk_status_to_errno(bio->bi_status);
+	bio_put(bio);
+
+out:
+	scrub2_release_full_stripe(fs_info, &full_stripe);
+	return ret;
+}
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 362742692a29..c22349380c50 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -25,10 +25,11 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 				  struct btrfs_block_group *bg,
 				  u64 logical_start, u64 logical_len,
 				  struct scrub2_stripe *stripe);
-void scrub2_repair_one_stripe(struct scrub2_stripe *stripe);
-void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
-			      unsigned long *write_bitmap);
 void scrub2_report_errors(struct scrub_ctx *sctx,
 			  struct scrub2_stripe *stripe);
+int scrub2_raid56_parity(struct scrub_ctx *sctx,
+			 struct btrfs_block_group *bg,
+			 struct btrfs_device *target,
+			 u64 full_stripe_logical);
 
 #endif
-- 
2.38.1

