Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F3758D25
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 07:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGSFbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 01:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGSFbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 01:31:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A521D2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 22:30:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24C931F8BF
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689744648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heGKVEtKdtmNxMJefGiQZKb2bIHq52QvStG7qlUm+oI=;
        b=mDdpSrTLqMtEXzYlh2nvGyInStIluwCE1KabJvdGW5DzxJh6jvk+7OfnVQ0tKvHPWSdzWp
        JVFP79AHWHnTqLW6FMP2vUe4f39YbJUjj1o9vZ6/C2OnNRI+ry0kJNgvSjiD/I27GefHPI
        XJg9RcL7a+qNuva3pLBOL+XASrIT6oU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 053B7138EE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8LcdMAZ1t2R7JQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/4] btrfs: scrub: move write back of repaired sectors into scrub_stripe_read_repair_worker()
Date:   Wed, 19 Jul 2023 13:30:23 +0800
Message-ID: <c5127be09729a115a7c5882fa3fad7a47fd840f1.1689744163.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689744163.git.wqu@suse.com>
References: <cover.1689744163.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the scrub_stripe_read_repair_worker() only do reads to rebuild
the corrupted sectors, it doesn't do any writeback.

The design is mostly to put writeback into a more ordered manner, to
co-operate with dev-replace with zoned mode, which requires every write
to be submitted in their bytenr order.

However the writeback for repaired sectors into the original mirror
doesn't need such strong requirement, as it can only happen for
non-zoned devices.

This patch would move the writeback for repaired sectors into
scrub_stripe_read_repair_worker().

To do that, we have to move the following functions forward:
- scrub_write_endio()
- scrub_subnmit_write_bio()
- scrub_write_sectors()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 256 +++++++++++++++++++++++------------------------
 1 file changed, 126 insertions(+), 130 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3b09d359c914..a3aff0296ba4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -983,6 +983,108 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 	spin_unlock(&sctx->stat_lock);
 }
 
+static void scrub_submit_write_bio(struct scrub_ctx *sctx,
+				   struct scrub_stripe *stripe,
+				   struct btrfs_bio *bbio, bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u32 bio_len = bbio->bio.bi_iter.bi_size;
+	u32 bio_off = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
+		      stripe->logical;
+
+	fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
+	atomic_inc(&stripe->pending_io);
+	btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
+	if (!btrfs_is_zoned(fs_info))
+		return;
+	/*
+	 * For zoned writeback, queue depth must be 1, thus we must wait for
+	 * the write to finish before the next write.
+	 */
+	wait_scrub_stripe_io(stripe);
+
+	/*
+	 * And also need to update the write pointer if write finished
+	 * successfully.
+	 */
+	if (!test_bit(bio_off >> fs_info->sectorsize_bits,
+		      &stripe->write_error_bitmap))
+		sctx->write_pointer += bio_len;
+}
+
+static void scrub_write_endio(struct btrfs_bio *bbio)
+{
+	struct scrub_stripe *stripe = bbio->private;
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio_vec *bvec;
+	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	u32 bio_size = 0;
+	int i;
+
+	bio_for_each_bvec_all(bvec, &bbio->bio, i)
+		bio_size += bvec->bv_len;
+
+	if (bbio->bio.bi_status) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&stripe->write_error_lock, flags);
+		bitmap_set(&stripe->write_error_bitmap, sector_nr,
+			   bio_size >> fs_info->sectorsize_bits);
+		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
+	}
+	bio_put(&bbio->bio);
+
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+/*
+ * Submit the write bio(s) for the sectors specified by @write_bitmap.
+ *
+ * Here we utilize btrfs_submit_repair_write(), which has some extra benefits:
+ *
+ * - Only needs logical bytenr and mirror_num
+ *   Just like the scrub read path
+ *
+ * - Would only result in writes to the specified mirror
+ *   Unlike the regular writeback path, which would write back to all stripes
+ *
+ * - Handle dev-replace and read-repair writeback differently
+ */
+static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
+				unsigned long write_bitmap, bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct btrfs_bio *bbio = NULL;
+	int sector_nr;
+
+	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
+		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
+		int ret;
+
+		/* We should only writeback sectors covered by an extent. */
+		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
+
+		/* Cannot merge with previous sector, submit the current one. */
+		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
+			scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
+			bbio = NULL;
+		}
+		if (!bbio) {
+			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_WRITE,
+					       fs_info, scrub_write_endio, stripe);
+			bbio->bio.bi_iter.bi_sector = (stripe->logical +
+				(sector_nr << fs_info->sectorsize_bits)) >>
+				SECTOR_SHIFT;
+		}
+		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		ASSERT(ret == fs_info->sectorsize);
+	}
+	if (bbio)
+		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
+}
+
 /*
  * The main entrance for all read related scrub work, including:
  *
@@ -991,12 +1093,16 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
  * - Go through the remaining mirrors and try to read as large blocksize as
  *   possible
  * - Go through all mirrors (including the failed mirror) sector-by-sector
+ * - Submit the write bio for repaired sectors if needed
  *
- * Writeback does not happen here, it needs extra synchronization.
+ * Writeback for dev-replace does not happen here, it needs extra
+ * synchronization to ensure they all happen in correct order (for zoned
+ * devices).
  */
 static void scrub_stripe_read_repair_worker(struct work_struct *work)
 {
 	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe, work);
+	struct scrub_ctx *sctx = stripe->sctx;
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
 					  stripe->bg->length);
@@ -1062,7 +1168,25 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 			goto out;
 	}
 out:
-	scrub_stripe_report_errors(stripe->sctx, stripe);
+	/*
+	 * Submit the repaired sectors.  For zoned case, we cannot do repair
+	 * in-place, but queue the bg to be relocated.
+	 */
+	if (btrfs_is_zoned(fs_info)) {
+		if (!bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors)) {
+			btrfs_repair_one_zone(fs_info,
+					      sctx->stripes[0].bg->start);
+		}
+	} else if (!sctx->readonly) {
+		unsigned long repaired;
+
+		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
+			      &stripe->error_bitmap, stripe->nr_sectors);
+		scrub_write_sectors(sctx, stripe, repaired, false);
+		wait_scrub_stripe_io(stripe);
+	}
+
+	scrub_stripe_report_errors(sctx, stripe);
 	set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state);
 	wake_up(&stripe->repair_wait);
 }
@@ -1085,108 +1209,6 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 	}
 }
 
-static void scrub_write_endio(struct btrfs_bio *bbio)
-{
-	struct scrub_stripe *stripe = bbio->private;
-	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	struct bio_vec *bvec;
-	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
-	u32 bio_size = 0;
-	int i;
-
-	bio_for_each_bvec_all(bvec, &bbio->bio, i)
-		bio_size += bvec->bv_len;
-
-	if (bbio->bio.bi_status) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&stripe->write_error_lock, flags);
-		bitmap_set(&stripe->write_error_bitmap, sector_nr,
-			   bio_size >> fs_info->sectorsize_bits);
-		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
-	}
-	bio_put(&bbio->bio);
-
-	if (atomic_dec_and_test(&stripe->pending_io))
-		wake_up(&stripe->io_wait);
-}
-
-static void scrub_submit_write_bio(struct scrub_ctx *sctx,
-				   struct scrub_stripe *stripe,
-				   struct btrfs_bio *bbio, bool dev_replace)
-{
-	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	u32 bio_len = bbio->bio.bi_iter.bi_size;
-	u32 bio_off = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT) -
-		      stripe->logical;
-
-	fill_writer_pointer_gap(sctx, stripe->physical + bio_off);
-	atomic_inc(&stripe->pending_io);
-	btrfs_submit_repair_write(bbio, stripe->mirror_num, dev_replace);
-	if (!btrfs_is_zoned(fs_info))
-		return;
-	/*
-	 * For zoned writeback, queue depth must be 1, thus we must wait for
-	 * the write to finish before the next write.
-	 */
-	wait_scrub_stripe_io(stripe);
-
-	/*
-	 * And also need to update the write pointer if write finished
-	 * successfully.
-	 */
-	if (!test_bit(bio_off >> fs_info->sectorsize_bits,
-		      &stripe->write_error_bitmap))
-		sctx->write_pointer += bio_len;
-}
-
-/*
- * Submit the write bio(s) for the sectors specified by @write_bitmap.
- *
- * Here we utilize btrfs_submit_repair_write(), which has some extra benefits:
- *
- * - Only needs logical bytenr and mirror_num
- *   Just like the scrub read path
- *
- * - Would only result in writes to the specified mirror
- *   Unlike the regular writeback path, which would write back to all stripes
- *
- * - Handle dev-replace and read-repair writeback differently
- */
-static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *stripe,
-				unsigned long write_bitmap, bool dev_replace)
-{
-	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	struct btrfs_bio *bbio = NULL;
-	int sector_nr;
-
-	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
-		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
-		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
-		int ret;
-
-		/* We should only writeback sectors covered by an extent. */
-		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
-
-		/* Cannot merge with previous sector, submit the current one. */
-		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
-			scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
-			bbio = NULL;
-		}
-		if (!bbio) {
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_WRITE,
-					       fs_info, scrub_write_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = (stripe->logical +
-				(sector_nr << fs_info->sectorsize_bits)) >>
-				SECTOR_SHIFT;
-		}
-		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-		ASSERT(ret == fs_info->sectorsize);
-	}
-	if (bbio)
-		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
-}
-
 /*
  * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
  * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
@@ -1701,32 +1723,6 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 			   test_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state));
 	}
 
-	/*
-	 * Submit the repaired sectors.  For zoned case, we cannot do repair
-	 * in-place, but queue the bg to be relocated.
-	 */
-	if (btrfs_is_zoned(fs_info)) {
-		for (int i = 0; i < nr_stripes; i++) {
-			stripe = &sctx->stripes[i];
-
-			if (!bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors)) {
-				btrfs_repair_one_zone(fs_info,
-						      sctx->stripes[0].bg->start);
-				break;
-			}
-		}
-	} else if (!sctx->readonly) {
-		for (int i = 0; i < nr_stripes; i++) {
-			unsigned long repaired;
-
-			stripe = &sctx->stripes[i];
-
-			bitmap_andnot(&repaired, &stripe->init_error_bitmap,
-				      &stripe->error_bitmap, stripe->nr_sectors);
-			scrub_write_sectors(sctx, stripe, repaired, false);
-		}
-	}
-
 	/* Submit for dev-replace. */
 	if (sctx->is_dev_replace) {
 		/*
-- 
2.41.0

