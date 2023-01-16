Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8712E66B7C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjAPHE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 02:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjAPHEv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 02:04:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC3B75D
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 23:04:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2175167472
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673852689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMKfLhAH1RHmrWf7bxHQbcYizGJGceW/QHXO2ogE+a8=;
        b=QhluuUU7x/0UZ4QqVcmbB+DGBjm4XpqbQC+97O7MAj0voWh0yDQr0DXPXHZ2LOQ73Dz/De
        Sc65oZ2VIS0dvnaJfMdhdaxnnheMZt9B2jfQclB1jAgEBI1HCr/v4AxurESiKB1DSzYRGc
        cp79ORST1hxekMdcVpc0BNKweCi1vS0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E0D4138FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iF7AEhD3xGMfZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:04:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: scrub: introduce a writeback helper for scrub_stripe
Date:   Mon, 16 Jan 2023 15:04:20 +0800
Message-Id: <651e3b32ce4974e63e457a0294277e321c1f4e9c.1673851704.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673851704.git.wqu@suse.com>
References: <cover.1673851704.git.wqu@suse.com>
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

Add a new helper, scrub_write_sectors(), to writeback specified sectors
to the target disk.

There are several differences compared to read path:

- Do not utilize btrfs_submit_bio()
  The problem of btrfs_submit_bio() is, for dev-replace case it will
  write the data to both the original and target devices.

  This can cause problem for zoned devices.
  Thus here we manually write back to the specified device instead.

- We can not write the full stripe back
  We can only write the sectors we have.
  There will be two call sites later, one for repaired sectors,
  one for all utilzied sectors of dev-replace.

  Thus the callers should specify their own write_bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |   4 ++
 2 files changed, 122 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 92976310f899..638dece0b863 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -149,6 +149,15 @@ struct scrub_stripe {
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
@@ -383,6 +392,7 @@ static struct scrub_stripe *alloc_scrub_stripe(struct btrfs_fs_info *fs_info,
 
 	init_waitqueue_head(&stripe->io_wait);
 	atomic_set(&stripe->pending_io, 0);
+	spin_lock_init(&stripe->write_error_bitmap_lock);
 
 
 	ret = btrfs_alloc_page_array(BTRFS_STRIPE_LEN >> PAGE_SHIFT,
@@ -2467,6 +2477,114 @@ static void scrub_repair_from_mirror(struct scrub_stripe *orig,
 	}
 }
 
+static void scrub_write_endio(struct bio *bio)
+{
+	struct scrub_stripe *stripe = bio->bi_private;
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio_vec *first_bvec = bio_first_bvec_all(bio);
+	struct bio_vec *bvec;
+	unsigned long flags;
+	int bio_size = 0;
+	int first_sector_nr;
+	int i;
+
+	bio_for_each_bvec_all(bvec, bio, i)
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
+
+	if (bio->bi_status) {
+		spin_lock_irqsave(&stripe->write_error_bitmap_lock, flags);
+		bitmap_set(&stripe->write_error_bitmap, first_sector_nr,
+			   bio_size >> fs_info->sectorsize_bits);
+		spin_unlock_irqrestore(&stripe->write_error_bitmap_lock, flags);
+	}
+	bio_put(bio);
+
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+/*
+ * Writeback specified sectors (by @write_bitmap) to @physical of @device.
+ *
+ * Here we can not utilize btrfs_submit_bio(), as in dev-replace case, it will
+ * write to both the original and replace target devices.
+ * Such duplicated write can cause problems for zoned devices.
+ *
+ * Thus here we submit bio directly to @device.
+ */
+void scrub_write_wait_sectors(struct scrub_ctx *sctx,
+			      struct scrub_stripe *stripe,
+			      struct btrfs_device *dev, u64 physical,
+			      unsigned long *write_bitmap)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio *bio = NULL;
+	bool zoned = btrfs_is_zoned(fs_info);
+	int sector_nr;
+
+	/* Missing devices, skip it. */
+	if (!dev->bdev)
+		return;
+
+	ASSERT(atomic_read(&stripe->pending_io) == 0);
+
+	/* Go through each sector in @write_bitmap. */
+	for_each_set_bit(sector_nr, write_bitmap, stripe->nr_sectors) {
+		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe,
+								  sector_nr);
+		int ret;
+
+		/* We should only writeback sectors covered by an extent. */
+		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
+
+		/* No bio allocated or we can not merge with previous sector. */
+		if (!bio || sector_nr == 0 ||
+		    !test_bit(sector_nr - 1, write_bitmap)) {
+			if (bio) {
+				fill_writer_pointer_gap(sctx, physical +
+					(sector_nr << fs_info->sectorsize_bits));
+				atomic_inc(&stripe->pending_io);
+				submit_bio(bio);
+				if (zoned)
+					wait_scrub_stripe(stripe);
+			}
+			bio = bio_alloc(dev->bdev, BTRFS_STRIPE_LEN >> PAGE_SHIFT,
+					REQ_OP_WRITE, GFP_KERNEL);
+			ASSERT(bio);
+
+			bio->bi_private = stripe;
+			bio->bi_end_io = scrub_write_endio;
+			bio->bi_iter.bi_sector = (physical +
+				(sector_nr << fs_info->sectorsize_bits)) >>
+				SECTOR_SHIFT;
+		}
+		ret = bio_add_page(bio, page, fs_info->sectorsize, pgoff);
+		ASSERT(ret == fs_info->sectorsize);
+	}
+	if (bio) {
+		fill_writer_pointer_gap(sctx, bio->bi_iter.bi_sector << SECTOR_SHIFT);
+		atomic_inc(&stripe->pending_io);
+		submit_bio(bio);
+		if (zoned)
+			wait_scrub_stripe(stripe);
+	}
+
+	wait_scrub_stripe(stripe);
+}
+
 int scrub_repair_one_stripe(struct scrub_stripe *stripe)
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index fc732187db16..03f84acd31ce 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -24,5 +24,9 @@ int scrub_find_fill_first_stripe(struct btrfs_root *extent_root,
 				 u64 logical_start, u64 logical_len,
 				 struct scrub_stripe *stripe);
 int scrub_repair_one_stripe(struct scrub_stripe *stripe);
+void scrub_write_wait_sectors(struct scrub_ctx *sctx,
+			      struct scrub_stripe *stripe,
+			      struct btrfs_device *dev, u64 physical,
+			      unsigned long *write_bitmap);
 
 #endif
-- 
2.39.0

