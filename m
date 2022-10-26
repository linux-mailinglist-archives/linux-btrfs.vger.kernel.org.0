Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7F160DA73
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiJZFGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiJZFGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4658DE7
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89C701FB9E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlL+KBBDJ5/oUJP7n4249I/HvtylSsEDYX/To87TWyU=;
        b=BOHazNSOAC80pzN7pQdknFXuYHf4O/0nSYYHWeXOD+TZ58DQqjxOoXZLWZMi5rRlUbh/kZ
        6hgNRwgkSW2NBa+GS5QHxbgWRRc9daBUCRd3lVlf/4vXl4D01962oDAQ+3pOFw0fOIpOub
        QYgXcEMvwX1nSCARynanzlrD4HlDUfo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B8E13A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WCS4Kl/AWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: raid56: implement the degraded write for run_one_write_rbio()
Date:   Wed, 26 Oct 2022 13:06:29 +0800
Message-Id: <a0ccf5b129c04cbc3b4077865b1060ef500f5c5b.1666760699.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1666760699.git.wqu@suse.com>
References: <cover.1666760699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For degraded mount (with missing device), before doing a RMW, we should
read out all the good sectors, and recovery the missing device.

This patch will implement the following new functions:

- recover_submit_reads()
  This is different from rmw_submit_reads() by:

  * won't trust any cache
  * will read P/Q stripes

- recover_one_rbio()
  Mostly the recovery part of __raid_recover_end_io() but follows the
  submit-and-wait idea.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 130 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ffcb9bb226be..592286783e95 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2901,6 +2901,125 @@ static int rmw_submit_reads(struct btrfs_raid_bio *rbio)
 	return -EIO;
 }
 
+static int recover_submit_reads(struct btrfs_raid_bio *rbio)
+{
+	int bios_to_read = 0;
+	struct bio_list bio_list;
+	int ret;
+	int total_sector_nr;
+	struct bio *bio;
+
+	ASSERT(rbio->faila >= 0 || rbio->failb >= 0);
+	bio_list_init(&bio_list);
+	atomic_set(&rbio->error, 0);
+
+	/* Read out all sectors that doesn't failed. */
+	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
+	     total_sector_nr++) {
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+		struct sector_ptr *sector;
+
+		if (rbio->faila == stripe || rbio->failb == stripe) {
+			atomic_inc(&rbio->error);
+			/* Skip the current stripe. */
+			ASSERT(sectornr == 0);
+			total_sector_nr += rbio->stripe_nsectors - 1;
+			continue;
+		}
+		/* We don't trust any cache this time. */
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
+					 sectornr, REQ_OP_READ);
+		if (ret < 0)
+			goto error;
+	}
+
+	bios_to_read = bio_list_size(&bio_list);
+	/*
+	 * We should always need to read some stripes, as we don't use
+	 * any cache.
+	 */
+	ASSERT(bios_to_read);
+
+	atomic_set(&rbio->stripes_pending, bios_to_read);
+	while ((bio = bio_list_pop(&bio_list))) {
+		bio->bi_end_io = raid_wait_read_end_io;
+
+		if (trace_raid56_read_partial_enabled()) {
+			struct raid56_bio_trace_info trace_info = { 0 };
+
+			bio_get_trace_info(rbio, bio, &trace_info);
+			trace_raid56_read_partial(rbio, bio, &trace_info);
+		}
+		submit_bio(bio);
+	}
+	return 0;
+
+error:
+	while ((bio = bio_list_pop(&bio_list)))
+		bio_put(bio);
+
+	return -EIO;
+}
+
+static int recover_one_rbio(struct btrfs_raid_bio *rbio)
+{
+	void **pointers = NULL;
+	void **unmap_array = NULL;
+	int ret = 0;
+	int i;
+
+	/*
+	 * @pointers array stores the pointer for each sector, thus it has the
+	 * extra pgoff value added from each sector
+	 *
+	 * @unmap_array is a copy of pointers that does not get reordered during
+	 * reconstruction so that kunmap_local works.
+	 * This is to keep the order of kunmap_local().
+	 */
+	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	if (!pointers || !unmap_array) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Firstly read out all sectors we didn't failed. This time we won't
+	 * trust any cache.
+	 */
+	ret = recover_submit_reads(rbio);
+	if (ret < 0)
+		goto out;
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
+		ret = -EIO;
+		goto out;
+	}
+
+	/* Make sure faila and fail b are in order. */
+	if (rbio->faila >= 0 && rbio->failb >= 0 && rbio->faila > rbio->failb)
+		swap(rbio->faila, rbio->failb);
+	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
+	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
+		spin_lock_irq(&rbio->bio_list_lock);
+		set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
+		spin_unlock_irq(&rbio->bio_list_lock);
+	}
+
+	/* Now recovery the full stripe. */
+	for (i = 0; i < rbio->stripe_nsectors; i++)
+		recover_vertical(rbio, i, pointers, unmap_array);
+
+	index_rbio_pages(rbio);
+
+out:
+	kfree(pointers);
+	kfree(unmap_array);
+	return ret;
+}
+
 /*
  * This is the main entry to run a write rbio, which will do read-modify-write
  * cycle.
@@ -2942,7 +3061,16 @@ void run_one_write_rbio(struct btrfs_raid_bio *rbio)
 	 */
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
-	/* Place holder for extra verification for above reads and data csum. */
+	/*
+	 * We have some sectors on the missing device(s), needs to recover
+	 * the full stripe before writing.
+	 */
+	if (rbio->faila >= 0 || rbio->failb >= 0) {
+		ret = recover_one_rbio(rbio);
+		if (ret < 0)
+			goto out;
+	}
+
 write:
 	/* Place holder for real write code. */
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
-- 
2.38.1

