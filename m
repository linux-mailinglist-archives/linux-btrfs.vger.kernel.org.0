Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F91643E75
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiLFIYT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiLFIYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F213EBC
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:03 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF2451FDC8
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTApO1vATqymtPASDcyaQqMix6RFtvR3yV9/M+v9yQM=;
        b=ljIVPYvyfcI1c2aXwjxpXxHNAkTE6jEiKiA3BUoL686DebiLTfkKRd72dWp6PAtr+whQYe
        8vwcEW/F7aeDgXG5pgmCjAa03EJJ924YgcHDXMXCzoAGJCO80gJnFXmYFAKU0mqo/s7mmT
        1uijIP1rEaIwiB4Mwwy03bB0WNfKebA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2DCB5132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qPaOOyD8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 05/11] btrfs: scrub: add a writeback helper for scrub2_stripe
Date:   Tue,  6 Dec 2022 16:23:32 +0800
Message-Id: <1e92cdad3b60464ed6f1cf4c0a24cac7d270e3ef.1670314744.git.wqu@suse.com>
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

Add a new helper, scrub2_writeback_sectors(), to writeback specified
sectors of a scrub2_stripe.

Unlike the read path, writeback can only submit writes for the repair
sectors, no longer in a BTRFS_STRIPE_LEN size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   2 +
 2 files changed, 111 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 15c95cf88a2e..a581d1e4ae44 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -152,6 +152,15 @@ struct scrub2_stripe {
 	 */
 	unsigned long meta_error_bitmap;
 
+	/* This is only for write back cases (repair or replace). */
+	unsigned long write_error_bitmap;
+	
+	/*
+	 * Spinlock for write_error_bitmap, as that's the only case we can have
+	 * multiple bios for one stripe.
+	 */
+	spinlock_t write_error_bitmap_lock;
+
 	/*
 	 * Checksum for the whole stripe if this stripe is inside a data block
 	 * group.
@@ -392,6 +401,7 @@ struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
 
 	init_waitqueue_head(&stripe->io_wait);
 	atomic_set(&stripe->pending_io, 0);
+	spin_lock_init(&stripe->write_error_bitmap_lock);
 
 	stripe->nr_sectors = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
 
@@ -3925,10 +3935,102 @@ static void scrub2_repair_from_mirror(struct scrub2_stripe *orig,
 	}
 }
 
+static void scrub2_write_endio(struct btrfs_bio *bbio)
+{
+	struct scrub2_stripe *stripe = bbio->private;
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio_vec *first_bvec = bio_first_bvec_all(&bbio->bio);
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	unsigned long flags;
+	int bio_size = 0;
+	int first_sector_nr;
+	int i;
+
+	bio_for_each_segment_all(bvec, &bbio->bio, iter_all)
+		bio_size += bvec->bv_len;
+
+	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+		if (stripe->pages[i] == first_bvec->bv_page)
+			break;
+	}
+	/*
+	 * Since our pages should all be from stripe->pages[], we should find
+	 * the page.
+	 */
+	ASSERT(i < BTRFS_STRIPE_LEN >> PAGE_SHIFT);
+	first_sector_nr = ((i << PAGE_SHIFT) + first_bvec->bv_offset) >>
+			  fs_info->sectorsize_bits;
+	bio_put(&bbio->bio);
+
+	spin_lock_irqsave(&stripe->write_error_bitmap_lock, flags);
+	bitmap_set(&stripe->write_error_bitmap, first_sector_nr,
+		   bio_size >> fs_info->sectorsize_bits);
+	spin_unlock_irqrestore(&stripe->write_error_bitmap_lock, flags);
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+/*
+ * Writeback sectors specified by @write_bitmap.
+ *
+ * Called by scrub repair (writeback repaired sectors) or dev-replace
+ * (writeback the sectors to the replace dst device).
+ */
+void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
+			      unsigned long *write_bitmap)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio *bio = NULL;
+	int sector_nr;
+
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+
+	/* Go through each initially corrupted sector. */
+	for_each_set_bit(sector_nr, write_bitmap, stripe->nr_sectors) {
+		const int page_index = (sector_nr << fs_info->sectorsize_bits) >>
+					PAGE_SHIFT;
+		const int pgoff = offset_in_page(sector_nr <<
+						 fs_info->sectorsize_bits);
+		int ret;
+
+		/*
+		 * No bio allocated or we can not merge with previous sector
+		 * (previous sector is not a repaired one).
+		 */
+		if (!bio || sector_nr == 0 ||
+		    !(test_bit(sector_nr, &stripe->init_error_bitmap) &&
+		      !test_bit(sector_nr - 1, &stripe->current_error_bitmap))) {
+			if (bio) {
+				atomic_inc(&stripe->pending_io);
+				btrfs_submit_bio(fs_info, bio,
+						 stripe->mirror_num);
+			}
+			bio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> PAGE_SHIFT,
+					REQ_OP_WRITE, scrub2_write_endio, stripe);
+			ASSERT(bio);
+
+			bio->bi_iter.bi_sector = (stripe->logical +
+				(sector_nr << fs_info->sectorsize_bits)) >>
+				SECTOR_SHIFT;
+		}
+		ret = bio_add_page(bio, stripe->pages[page_index],
+				   fs_info->sectorsize, pgoff);
+		ASSERT(ret == fs_info->sectorsize);
+	}
+	if (bio) {
+		atomic_inc(&stripe->pending_io);
+		btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
+	}
+
+	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
+}
+
 void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct scrub2_stripe *repair;
+	unsigned long writeback_bitmap = 0;
 	int nr_copies;
 	int i;
 
@@ -3964,6 +4066,13 @@ void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
 			break;
 	}
 	free_scrub2_stripe(repair);
+	/*
+	 * Writeback the sectors which are in the init_error_bitmap, but not
+	 * int the current_error_bitmap.
+	 * Thus writeback = init_error & !current_error.
+	 */
+	bitmap_andnot(&writeback_bitmap, &stripe->init_error_bitmap,
+		      &stripe->current_error_bitmap, stripe->nr_sectors);
 }
 
 /*
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 2f1fceace633..a9519214bd41 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -26,5 +26,7 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 				  u64 logical_start, u64 logical_len,
 				  struct scrub2_stripe *stripe);
 void scrub2_repair_one_stripe(struct scrub2_stripe *stripe);
+void scrub2_writeback_sectors(struct scrub2_stripe *stripe,
+			      unsigned long *write_bitmap);
 
 #endif
-- 
2.38.1

