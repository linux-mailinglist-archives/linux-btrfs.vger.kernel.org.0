Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E5C6C08DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCTCNh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCTCNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC5193EB
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9129C1F37C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avvNXu4t/XwFWTvxov/ry8Bw3iC22xNMxnxrw5pt/vE=;
        b=Y3K9CbpsvfbuwHn2+cuYXriVbkOgc5uc6L8MTYmIjwqMi4xLrFYHeRW/Smx3u0hdgX5Rf8
        O/Clg2Y7aIDcyi27c4fjhNtsaC4blFo8qOFgyEImC34o/Jlz31Yrr+NOOH0qYnFmtyikfW
        qqQg77w3OnesjJFPcTOKVIrKtfEzsFs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA2BF13416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aHH5LEvBF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 08/12] btrfs: scrub: introduce the main read repair worker for scrub_stripe
Date:   Mon, 20 Mar 2023 10:12:54 +0800
Message-Id: <5372a0fca11bf7856b24c6006b42214aeb4ab9c8.1679278088.git.wqu@suse.com>
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

The new helper, scrub_stripe_read_repair_worker(), would handle the
read-repair part:

- Wait for the previous submitted read IO to finish

- Verify the contents of the stripe

- Go through the remaining mirrors, using as large blocksize as possible
  At this stage, we just read out all the failed sectors from each
  mirror and re-verify.
  If no more failed sector, we can exit.

- Go through all mirrors again, sector-by-sector this time
  This time, we read sector by sector, this is to address cases where
  one bad sector mismatches the drive's internal checksum, and cause the
  whole read range to fail.

  We put this recovery method as the last resort, as sector-by-sector
  reading is slow, and read from other mirrors may have already fixed
  the errors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h |   3 +-
 2 files changed, 211 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ed8b9a97f9dd..ee6ccb47ca36 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -118,6 +118,7 @@ struct scrub_stripe {
 
 	atomic_t pending_io;
 	wait_queue_head_t io_wait;
+	wait_queue_head_t repair_wait;
 
 	/* Indicates the states of the stripe. */
 	unsigned long state;
@@ -150,6 +151,8 @@ struct scrub_stripe {
 	 * group.
 	 */
 	u8 *csums;
+
+	struct work_struct work;
 };
 
 struct scrub_recover {
@@ -377,9 +380,9 @@ int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe
 	stripe->state = 0;
 
 	init_waitqueue_head(&stripe->io_wait);
+	init_waitqueue_head(&stripe->repair_wait);
 	atomic_set(&stripe->pending_io, 0);
 
-
 	ret = btrfs_alloc_page_array(BTRFS_STRIPE_LEN >> PAGE_SHIFT,
 				     stripe->pages);
 	if (ret < 0)
@@ -401,7 +404,7 @@ int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe
 	return -ENOMEM;
 }
 
-void wait_scrub_stripe_io(struct scrub_stripe *stripe)
+static void wait_scrub_stripe_io(struct scrub_stripe *stripe)
 {
 	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
 }
@@ -2337,7 +2340,8 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe,
 }
 
 /* Verify specified sectors of a stripe. */
-void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long bitmap)
+static void scrub_verify_one_stripe(struct scrub_stripe *stripe,
+				    unsigned long bitmap)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const unsigned int sectors_per_tree = fs_info->nodesize >>
@@ -2351,6 +2355,209 @@ void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long bitmap)
 	}
 }
 
+static int calc_sector_number(struct scrub_stripe *stripe,
+			      struct bio_vec *first_bvec)
+{
+	int i;
+
+	for (i = 0; i < stripe->nr_sectors; i++) {
+		if (scrub_stripe_get_page(stripe, i) == first_bvec->bv_page &&
+		    scrub_stripe_get_page_offset(stripe, i) == first_bvec->bv_offset)
+			break;
+	}
+	ASSERT(i < stripe->nr_sectors);
+	return i;
+}
+
+/*
+ * Repair read is different to the regular read by:
+ *
+ * - Only reads the failed sectors
+ * - May have extra blocksize limits
+ */
+static void scrub_repair_read_endio(struct btrfs_bio *bbio)
+{
+	struct scrub_stripe *stripe = bbio->private;
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio_vec *bvec;
+	int sector_nr = calc_sector_number(stripe,
+					   bio_first_bvec_all(&bbio->bio));
+	int bio_size = 0;
+	int i;
+
+	ASSERT(sector_nr < stripe->nr_sectors);
+
+	bio_for_each_bvec_all(bvec, &bbio->bio, i)
+		bio_size += bvec->bv_len;
+
+	if (bbio->bio.bi_status) {
+		bitmap_set(&stripe->io_error_bitmap, sector_nr,
+			   bio_size >> fs_info->sectorsize_bits);
+		bitmap_set(&stripe->error_bitmap, sector_nr,
+			   bio_size >> fs_info->sectorsize_bits);
+	} else {
+		bitmap_clear(&stripe->io_error_bitmap, sector_nr,
+			     bio_size >> fs_info->sectorsize_bits);
+	}
+	bio_put(&bbio->bio);
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+static int calc_next_mirror(int mirror, int num_copies)
+{
+	ASSERT(mirror <= num_copies);
+	return (mirror + 1 > num_copies) ? 1 : mirror + 1;
+}
+
+static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
+					    int mirror, int blocksize,
+					    bool wait)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct btrfs_bio *bbio = NULL;
+	const unsigned long old_error_bitmap = stripe->error_bitmap;
+	int i;
+
+	ASSERT(stripe->mirror_num >= 1);
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+
+	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
+		struct page *page;
+		int pgoff;
+		int ret;
+
+		page = scrub_stripe_get_page(stripe, i);
+		pgoff = scrub_stripe_get_page_offset(stripe, i);
+
+		/* The current sector can not be merged, submit the bio. */
+		if (bbio && ((i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) ||
+			     bbio->bio.bi_iter.bi_size >= blocksize)) {
+			ASSERT(bbio->bio.bi_iter.bi_size);
+			atomic_inc(&stripe->pending_io);
+			btrfs_submit_scrub_read(fs_info, bbio, mirror);
+			if (wait)
+				wait_scrub_stripe_io(stripe);
+			bbio = NULL;
+		}
+
+		if (!bbio) {
+			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
+					NULL, scrub_repair_read_endio, stripe);
+			/* Backed by mempool. */
+			ASSERT(bbio);
+			bbio->bio.bi_iter.bi_sector = (stripe->logical +
+				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
+		}
+
+		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		ASSERT(ret == fs_info->sectorsize);
+	}
+	if (bbio) {
+		ASSERT(bbio->bio.bi_iter.bi_size);
+		atomic_inc(&stripe->pending_io);
+		btrfs_submit_scrub_read(fs_info, bbio, mirror);
+		if (wait)
+			wait_scrub_stripe_io(stripe);
+	}
+}
+
+/*
+ * The main entrance for all read related scrub work, including:
+ *
+ * - Wait for the initial read to finish
+ * - Verify and locate any bad sectors
+ * - Go through the remaining mirrors and try to read as large blocksize as
+ *   possible
+ *
+ * - Go through all mirrors (including the failed mirror) sector-by-sector
+ *
+ * Writeback does not happen here, they need extra synchronization.
+ */
+static void scrub_stripe_read_repair_worker(struct work_struct *work)
+{
+	struct scrub_stripe *stripe = container_of(work, struct scrub_stripe,
+						   work);
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
+					  stripe->bg->length);
+	int mirror;
+	int i;
+
+	ASSERT(stripe->mirror_num > 0);
+
+	wait_scrub_stripe_io(stripe);
+	scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
+	/* Save the initial failed bitmap for later repair and report usage. */
+	stripe->init_error_bitmap = stripe->error_bitmap;
+
+	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
+		goto out;
+
+	/*
+	 * Try all remaining mirrors.
+	 *
+	 * Here we still try read as large block as possible, as this is faster
+	 * and we have extra safe nets to rely on.
+	 */
+	for (mirror = calc_next_mirror(stripe->mirror_num, num_copies);
+	     mirror != stripe->mirror_num;
+	     mirror = calc_next_mirror(mirror, num_copies)) {
+		const unsigned long old_error_bitmap = stripe->error_bitmap;
+
+		scrub_stripe_submit_repair_read(stripe, mirror,
+						BTRFS_STRIPE_LEN, false);
+		wait_scrub_stripe_io(stripe);
+		scrub_verify_one_stripe(stripe, old_error_bitmap);
+		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+			goto out;
+	}
+
+	/*
+	 * Last safenet, try re-check all mirrors, including the failed one,
+	 * sector-by-sector.
+	 *
+	 * As if one sector failed the drive's internal csum, the whole read
+	 * containing the offending sector would be marked error.
+	 * Thus here we do sector-by-sector read.
+	 *
+	 * This can be slow, thus we only try it as the last resort.
+	 */
+
+	for (i = 0, mirror = stripe->mirror_num; i < num_copies;
+	     i++, mirror = calc_next_mirror(mirror, num_copies)) {
+		const unsigned long old_error_bitmap = stripe->error_bitmap;
+
+		scrub_stripe_submit_repair_read(stripe, mirror,
+						fs_info->sectorsize, true);
+		wait_scrub_stripe_io(stripe);
+		scrub_verify_one_stripe(stripe, old_error_bitmap);
+		if (bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+			goto out;
+	}
+out:
+	set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state);
+	wake_up(&stripe->repair_wait);
+}
+
+void scrub_read_endio(struct btrfs_bio *bbio)
+{
+	struct scrub_stripe *stripe = bbio->private;
+
+	if (bbio->bio.bi_status) {
+		bitmap_set(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
+		bitmap_set(&stripe->error_bitmap, 0, stripe->nr_sectors);
+	} else {
+		bitmap_clear(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
+	}
+	bio_put(&bbio->bio);
+	if (atomic_dec_and_test(&stripe->pending_io)) {
+		wake_up(&stripe->io_wait);
+		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
+		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
+	}
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 45ff7e149806..bcc9d398fe07 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -19,11 +19,10 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
  */
 struct scrub_stripe;
 int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe);
-void wait_scrub_stripe_io(struct scrub_stripe *stripe);
 int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 				 struct btrfs_device *dev, u64 physical,
 				 int mirror_num, u64 logical_start,
 				 u32 logical_len, struct scrub_stripe *stripe);
-void scrub_verify_one_stripe(struct scrub_stripe *stripe, unsigned long bitmap);
+void scrub_read_endio(struct btrfs_bio *bbio);
 
 #endif
-- 
2.39.2

