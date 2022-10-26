Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100D60DA70
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiJZFGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiJZFGm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A91604B3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 814D11FA95
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxMo3WfaTH1Wi7EvXr3YW81Q1QGAm0Whj29iyv6nDXk=;
        b=kr8TOhhwVcNE+IZEF4fkP6yJolQZ+fFpZCwrByuF1zYnUadbjp7P3IA6mhgOExdeYy96wf
        zlctVyUjcVCC/rP7QA+6IWSzwynhDh/4hrH/fG/YyBtBfU+iCv9ySrWqReqzn0nd8yQ5js
        yzGnjRTN5IU2BJo96GkV8tpSNgSC+5k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D79C013A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cIA3KF7AWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: raid56: implement the read part for run_one_write_rbio()
Date:   Wed, 26 Oct 2022 13:06:28 +0800
Message-Id: <c9b9d90e002c81a2bdc26fd9857db24f35bf8fb7.1666760699.git.wqu@suse.com>
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

The read part is mostly identical as raid56_rmw_stripe(), the
differences are:

- The endio function
  To co-opearate with the new submit-and-wait idea.

- The error handling
  The error handling will be properly done in the caller for
  the original bios, thus the function only need to handle
  the bio list.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c3b33fb8c033..ffcb9bb226be 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2818,6 +2818,89 @@ void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio)
 		start_async_work(rbio, read_rebuild_work);
 }
 
+static void raid_wait_read_end_io(struct bio *bio)
+{
+	struct btrfs_raid_bio *rbio = bio->bi_private;
+
+	if (bio->bi_status)
+		fail_bio_stripe(rbio, bio);
+	else
+		set_bio_pages_uptodate(rbio, bio);
+
+
+	bio_put(bio);
+	atomic_dec(&rbio->stripes_pending);
+	wake_up(&rbio->io_wait);
+}
+
+static int rmw_submit_reads(struct btrfs_raid_bio *rbio)
+{
+	int bios_to_read = 0;
+	struct bio_list bio_list;
+	const int nr_data_sectors = rbio->stripe_nsectors * rbio->nr_data;
+	int ret;
+	int total_sector_nr;
+	struct bio *bio;
+
+	bio_list_init(&bio_list);
+	atomic_set(&rbio->error, 0);
+
+	/* Build a list of bios to read all the missing data sectors. */
+	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
+	     total_sector_nr++) {
+		struct sector_ptr *sector;
+		int stripe = total_sector_nr / rbio->stripe_nsectors;
+		int sectornr = total_sector_nr % rbio->stripe_nsectors;
+
+		/*
+		 * We want to find all the sectors missing from the rbio and
+		 * read them from the disk.  If sector_in_rbio() finds a page
+		 * in the bio list we don't need to read it off the stripe.
+		 */
+		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
+		if (sector)
+			continue;
+
+		sector = rbio_stripe_sector(rbio, stripe, sectornr);
+		/*
+		 * The rbio cache may have handed us an uptodate page.  If so,
+		 * use it.
+		 */
+		if (sector->uptodate)
+			continue;
+
+		ret = rbio_add_io_sector(rbio, &bio_list, sector,
+			       stripe, sectornr, REQ_OP_READ);
+		if (ret)
+			goto error;
+	}
+
+	bios_to_read = bio_list_size(&bio_list);
+	/* This can happen if we have a cached bio. */
+	if (!bios_to_read)
+		return 0;
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
 /*
  * This is the main entry to run a write rbio, which will do read-modify-write
  * cycle.
@@ -2848,7 +2931,10 @@ void run_one_write_rbio(struct btrfs_raid_bio *rbio)
 	if (ret < 0)
 		goto out;
 
-	/* Place holder for read the missing sectors. */
+	/* Read the missing secotrs. */
+	ret = rmw_submit_reads(rbio);
+	if (ret < 0)
+		goto out;
 
 	/*
 	 * We may or may not submitted any sectors, but it doesn't matter.
-- 
2.38.1

