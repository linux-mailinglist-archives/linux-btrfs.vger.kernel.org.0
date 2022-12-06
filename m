Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7AF643E74
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiLFIYS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLFIYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB7CE0D
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:24:02 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C873621C04
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/fQ66Px29j+ycB/rYTS+wW0uX7s+Wg/1g7K+LcSaXE=;
        b=pGCzBUHzYrGzKddDPLOhgXNSklRJDWZ2L5Xw4NWpxXPvaic3L8zBU4uSiKHqSbi47CXOiz
        Mf2U8vHC6y7eOdGlBJQgCzd5qFVVcvvYL15gEmg9ljASAZls1FQ6GdhpIizn3gWwgwbRx5
        WF9x4nWBrC7RxAWXuKtYZUrLFAsYHlg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 36231132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MO+2ASD8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:24:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 04/11] btrfs: scrub: add the repair function for scrub2_stripe
Date:   Tue,  6 Dec 2022 16:23:31 +0800
Message-Id: <d4e21b8595c1fa776be96ada88844ad7a127758c.1670314744.git.wqu@suse.com>
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

The new helper, scrub2_repair_one_stripe(), would do the following work
to repair one scrub2_stripe:

- Go through each remaining mirrors

- Submit a BTRFS_STRIPE_LEN read for the target mirror

- Run verification for above read

- Copy repaired sectors back to the original stripe
  And clear the current_error_bitmap bit for the original stripe.

- Check if we repaired all the sectors

This is a little different than the original repair behavior:

- We only try the next mirror if the current mirror can not repair
  all sectors.

  While the old behavior is to submit read concurrently for all the
  remaining mirrors.

  I'd prefer to put the parallel read into the new scrub_fs interface
  instead.
  For current per-device scrub, the sequential repair only makes
  difference for RAID1C* and RAID6.
  Thus I'd prefer a cleaner code instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h |   2 +-
 2 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index de194c31428e..15c95cf88a2e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -24,6 +24,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "scrub.h"
+#include "bio.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -416,12 +417,44 @@ struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
 		if (!stripe->csums)
 			goto cleanup;
 	}
+	stripe->bg = bg;
 	return stripe;
 cleanup:
 	free_scrub2_stripe(stripe);
 	return NULL;
 }
 
+static struct scrub2_stripe *clone_scrub2_stripe(struct btrfs_fs_info *fs_info,
+						 const struct scrub2_stripe *src)
+{
+	struct scrub2_stripe *dst;
+	int sector_nr;
+
+	dst = alloc_scrub2_stripe(fs_info, src->bg);
+	if (!dst)
+		return NULL;
+	if (src->csums)
+		memcpy(dst->csums, src->csums,
+		       src->nr_sectors * fs_info->csum_size);
+	bitmap_copy(&dst->used_sector_bitmap, &src->used_sector_bitmap,
+		    src->nr_sectors);
+	for_each_set_bit(sector_nr, &src->used_sector_bitmap, src->nr_sectors) {
+		dst->sectors[sector_nr].is_metadata =
+			src->sectors[sector_nr].is_metadata;
+		/* For meta, copy the generation number. */
+		if (src->sectors[sector_nr].is_metadata) {
+			dst->sectors[sector_nr].generation =
+				src->sectors[sector_nr].generation;
+			continue;
+		}
+		/* For data, only update csum pointer if there is data csum. */
+		if (src->sectors[sector_nr].csum)
+			dst->sectors[sector_nr].csum = dst->csums +
+				sector_nr * fs_info->csum_size;
+	}
+	return dst;
+}
+
 static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
 					     struct btrfs_device *dev,
 					     u64 logical, u64 physical,
@@ -3750,6 +3783,10 @@ static void scrub2_verify_one_sector(struct scrub2_stripe *stripe,
 	if (test_bit(sector_nr, &stripe->used_sector_bitmap))
 		return;
 
+	/* IO error, no need to check. */
+	if (test_bit(sector_nr, &stripe->io_error_bitmap))
+		return;
+
 	/* Metadata, verify the full tree block. */
 	if (sector->is_metadata) {
 		/*
@@ -3785,7 +3822,7 @@ static void scrub2_verify_one_sector(struct scrub2_stripe *stripe,
 	}
 }
 
-void scrub2_verify_one_stripe(struct scrub2_stripe *stripe)
+static void scrub2_verify_one_stripe(struct scrub2_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const unsigned int sectors_per_tree = fs_info->nodesize >>
@@ -3810,6 +3847,125 @@ void scrub2_verify_one_stripe(struct scrub2_stripe *stripe)
 		    stripe->nr_sectors);
 }
 
+static void scrub2_read_endio(struct btrfs_bio *bbio)
+{
+	struct scrub2_stripe *stripe = bbio->private;
+
+	if (bbio->bio.bi_status) {
+		bitmap_set(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
+		bitmap_set(&stripe->init_error_bitmap, 0, stripe->nr_sectors);
+	}
+	bio_put(&bbio->bio);
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+static void scrub2_read_and_wait_stripe(struct scrub2_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio *bio;
+	int ret;
+	int i;
+
+	ASSERT(stripe->mirror_num >= 1);
+
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+	bio = btrfs_bio_alloc(BTRFS_STRIPE_LEN >> PAGE_SHIFT, REQ_OP_READ,
+			      scrub2_read_endio, stripe);
+	/* Backed by mempool, should not fail. */
+	ASSERT(bio);
+
+	bio->bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
+
+	for (i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+		ret = bio_add_page(bio, stripe->pages[i], PAGE_SIZE, 0);
+		ASSERT(ret == PAGE_SIZE);
+	}
+	atomic_inc(&stripe->pending_io);
+	btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
+	wait_event(stripe->io_wait, atomic_read(&stripe->pending_io) == 0);
+	scrub2_verify_one_stripe(stripe);
+}
+
+static void scrub2_repair_from_mirror(struct scrub2_stripe *orig,
+				      struct scrub2_stripe *repair,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = orig->bg->fs_info;
+	const int nr_sectors = orig->nr_sectors;
+	int sector_nr;
+
+	/* Reset the error bitmaps for @repair stripe. */
+	bitmap_zero(&repair->current_error_bitmap, nr_sectors);
+	bitmap_zero(&repair->io_error_bitmap, nr_sectors);
+	bitmap_zero(&repair->csum_error_bitmap, nr_sectors);
+	bitmap_zero(&repair->meta_error_bitmap, nr_sectors);
+
+	repair->mirror_num = mirror_num;
+	scrub2_read_and_wait_stripe(repair);
+
+	for_each_set_bit(sector_nr, &orig->used_sector_bitmap, nr_sectors) {
+		int page_index = (sector_nr << fs_info->sectorsize_bits) >>
+				 PAGE_SHIFT;
+		int pgoff = offset_in_page(sector_nr << fs_info->sectorsize_bits);
+
+		if (test_bit(sector_nr, &orig->current_error_bitmap) &&
+		    !test_bit(sector_nr, &repair->current_error_bitmap)) {
+
+			/* Copy the repaired content. */
+			memcpy_page(orig->pages[page_index], pgoff,
+				    repair->pages[page_index], pgoff,
+				    fs_info->sectorsize);
+			/*
+			 * And clear the bit in @current_error_bitmap, so
+			 * later we know we need to write this sector back.
+			 */
+			clear_bit(sector_nr, &orig->current_error_bitmap);
+		}
+	}
+}
+
+void scrub2_repair_one_stripe(struct scrub2_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct scrub2_stripe *repair;
+	int nr_copies;
+	int i;
+
+	/*
+	 * The stripe should only have been verified once, thus its init and
+	 * current error bitmap should match.
+	 */
+	ASSERT(bitmap_equal(&stripe->current_error_bitmap,
+			    &stripe->init_error_bitmap, stripe->nr_sectors));
+
+	/* The stripe has no error from the beginning. */
+	if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
+		return;
+	nr_copies = btrfs_num_copies(fs_info, stripe->logical,
+				     fs_info->sectorsize);
+	/* No extra mirrors to go. */
+	if (nr_copies == 1)
+		return;
+
+	repair = clone_scrub2_stripe(fs_info, stripe);
+	/* Iterate all other copies. */
+	for (i = 0; i < nr_copies - 1; i++) {
+		int next_mirror;
+
+		next_mirror = (i + stripe->mirror_num) >= nr_copies ?
+			      (i + stripe->mirror_num - nr_copies) :
+			      i + stripe->mirror_num;
+		scrub2_repair_from_mirror(stripe, repair, next_mirror);
+
+		/* Already repaired all bad sectors. */
+		if (bitmap_empty(&stripe->current_error_bitmap,
+				 stripe->nr_sectors))
+			break;
+	}
+	free_scrub2_stripe(repair);
+}
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 0aaed61e4d4d..2f1fceace633 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -25,6 +25,6 @@ int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
 				  struct btrfs_block_group *bg,
 				  u64 logical_start, u64 logical_len,
 				  struct scrub2_stripe *stripe);
-void scrub2_verify_one_stripe(struct scrub2_stripe *stripe);
+void scrub2_repair_one_stripe(struct scrub2_stripe *stripe);
 
 #endif
-- 
2.38.1

