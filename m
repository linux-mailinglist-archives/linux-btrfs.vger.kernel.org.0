Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9803E60DA76
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiJZFGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiJZFGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD65B9CA
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95C8E1FBA5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EH5MuLWOvsuCbZ6vbvAyqT7tIyvfcWaI7LfXgwPI83o=;
        b=q16f1KzXCmD/LshJ980sPnZfauCrnV5jFCX7IBZkUHWpAt1bZUbPSKh/bpU5fb/1OtLCun
        X4rSdjfsQNo1hSWRJ+HKEIB2qgHQEAMt8clJWP5drttO5y847aoLoBtV3r4udTai80X182
        TNFsZOYSa2PvAxqrxHuB5zOYzrHxar4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB3A913A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oAgCLWDAWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: raid56: implement the write submission part for run_one_write_bio()
Date:   Wed, 26 Oct 2022 13:06:30 +0800
Message-Id: <5b2e815b715fa3d802bf6bd2e8f9e682c0ca5bb9.1666760699.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1666760699.git.wqu@suse.com>
References: <cover.1666760699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is mostly the same as finish_rmw(), the differences are:

- Use dedicated endio
  Which follows the submit-and-wait idea.

- Error handling
  No need to call rbio_orig_end_io().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 160 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 592286783e95..4f648720b97a 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -3020,6 +3020,162 @@ static int recover_one_rbio(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
+static void raid_wait_write_end_io(struct bio *bio)
+{
+	struct btrfs_raid_bio *rbio = bio->bi_private;
+	blk_status_t err = bio->bi_status;
+
+	if (err)
+		fail_bio_stripe(rbio, bio);
+	bio_put(bio);
+	atomic_dec(&rbio->stripes_pending);
+	wake_up(&rbio->io_wait);
+}
+
+static int rmw_submit_writes(struct btrfs_raid_bio *rbio)
+{
+	struct btrfs_io_context *bioc = rbio->bioc;
+	/* The total sector number inside the full stripe. */
+	int total_sector_nr;
+	int stripe;
+	/* Sector number inside a stripe. */
+	int sectornr;
+	struct bio_list bio_list;
+	struct bio *bio;
+	int ret = 0;
+
+	bio_list_init(&bio_list);
+
+	/* We should have at least one data sector. */
+	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
+
+	/*
+	 * At this point we either have a full stripe,
+	 * or we've read the full stripe from the drive.
+	 * recalculate the parity and write the new results.
+	 *
+	 * We're not allowed to add any new bios to the
+	 * bio list here, anyone else that wants to
+	 * change this stripe needs to do their own rmw.
+	 */
+	spin_lock_irq(&rbio->bio_list_lock);
+	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
+	spin_unlock_irq(&rbio->bio_list_lock);
+
+	atomic_set(&rbio->error, 0);
+	rbio->faila = -1;
+	rbio->failb = -1;
+
+	/*
+	 * Now that we've set rmw_locked, run through the
+	 * bio list one last time and map the page pointers
+	 *
+	 * We don't cache full rbios because we're assuming
+	 * the higher layers are unlikely to use this area of
+	 * the disk again soon.  If they do use it again,
+	 * hopefully they will send another full bio.
+	 */
+	index_rbio_pages(rbio);
+	if (!rbio_is_full(rbio))
+		cache_rbio_pages(rbio);
+	else
+		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
+
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
+		generate_pq_vertical(rbio, sectornr);
+
+	/*
+	 * Assemble the write bios.
+	 * For data bios always use the bio from higher layer.
+	 */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+
+		stripe = total_sector_nr / rbio->stripe_nsectors;
+		sectornr = total_sector_nr % rbio->stripe_nsectors;
+
+		/* This vertical stripe has no data, skip it. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
+
+		if (stripe < rbio->nr_data) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (!sector)
+				continue;
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		}
+
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+					 sectornr, REQ_OP_WRITE);
+		if (ret)
+			goto cleanup;
+	}
+
+	if (likely(!bioc->num_tgtdevs))
+		goto write_data;
+
+	/* Assemble write bios for dev-replace target. */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+
+		stripe = total_sector_nr / rbio->stripe_nsectors;
+		sectornr = total_sector_nr % rbio->stripe_nsectors;
+
+		if (!bioc->tgtdev_map[stripe]) {
+			/*
+			 * We can skip the whole stripe completely, note
+			 * total_sector_nr will be increased by one anyway.
+			 */
+			ASSERT(sectornr == 0);
+			total_sector_nr += rbio->stripe_nsectors - 1;
+			continue;
+		}
+
+		/* This vertical stripe has no data, skip it. */
+		if (!test_bit(sectornr, &rbio->dbitmap))
+			continue;
+
+		if (stripe < rbio->nr_data) {
+			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+			if (!sector)
+				continue;
+		} else {
+			sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		}
+
+		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+					 rbio->bioc->tgtdev_map[stripe],
+					 sectornr, REQ_OP_WRITE);
+		if (ret)
+			goto cleanup;
+	}
+
+write_data:
+	ASSERT(bio_list_size(&bio_list));
+	atomic_set(&rbio->stripes_pending, bio_list_size(&bio_list));
+
+	while ((bio = bio_list_pop(&bio_list))) {
+		bio->bi_end_io = raid_wait_write_end_io;
+
+		if (trace_raid56_write_stripe_enabled()) {
+			struct raid56_bio_trace_info trace_info = { 0 };
+
+			bio_get_trace_info(rbio, bio, &trace_info);
+			trace_raid56_write_stripe(rbio, bio, &trace_info);
+		}
+		submit_bio(bio);
+	}
+	return 0;
+
+cleanup:
+	while ((bio = bio_list_pop(&bio_list)))
+		bio_put(bio);
+	return ret;
+}
+
 /*
  * This is the main entry to run a write rbio, which will do read-modify-write
  * cycle.
@@ -3072,7 +3228,9 @@ void run_one_write_rbio(struct btrfs_raid_bio *rbio)
 	}
 
 write:
-	/* Place holder for real write code. */
+	ret = rmw_submit_writes(rbio);
+	if (ret < 0)
+		goto out;
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
 		ret = -EIO;
-- 
2.38.1

