Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50B5614858
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKALQ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKALQY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD117E1D
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27D1A338A1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6EGVqX9UeHG/6fBq2MpIH7grVkc1oM/+8JwaTEe610=;
        b=BAeS5hROc7QuPK32K6eg7qTxUImN79OURw9sh5lMQ0+fImebsM2XrYaWwe3MTETaTamTjg
        0yhXnk+xPQwTBMTjIaIHx25nHnXcz9nRJ3uCeypdd0QG90CkA7Pq4aocNU6VNJRijLwCAR
        1tSiuJ0XJljYnl6uu4IgKWy178VBw2k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 946D21346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UAiYGQUAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/12] btrfs: raid56: introduce the a main entrance for rmw path
Date:   Tue,  1 Nov 2022 19:16:08 +0800
Message-Id: <e4affd159c83954c08467d18ba51098766d2cae4.1667300355.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667300355.git.wqu@suse.com>
References: <cover.1667300355.git.wqu@suse.com>
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

The new entrance will be called rmw_rbio(), it will have a streamlined
workflow by using submit-and-wait method.

Thus there will be no weird jumps between tons of functions, thus way
more reader friendly, and will make later expansion easier, as it's now
a straight workflow, the timing is way more clear.

Unfortunately we can not yet migrate the rmw path to use this new
entrance as we still need extra work to address the plug and
unlock_stripe() function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid56.h |   5 ++
 2 files changed, 166 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index de986bbe43fc..436c9b1d51f5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1252,6 +1252,14 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
 	/* We should have at least one data sector. */
 	ASSERT(bitmap_weight(&rbio->dbitmap, rbio->stripe_nsectors));
 
+	/*
+	 * Reset errors, as we may have errors inherited from from degraded
+	 * write.
+	 */
+	atomic_set(&rbio->error, 0);
+	rbio->faila = -1;
+	rbio->failb = -1;
+
 	/*
 	 * Start assembly.  Make bios for everything from the higher layers (the
 	 * bio_list in our rbio) and our P/Q.  Ignore everything else.
@@ -1666,6 +1674,19 @@ static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	return ret;
 }
 
+static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
+{
+	const int data_pages = rbio->nr_data * rbio->stripe_npages;
+	int ret;
+
+	ret = btrfs_alloc_page_array(data_pages, rbio->stripe_pages);
+	if (ret < 0)
+		return ret;
+
+	index_stripe_sectors(rbio);
+	return 0;
+}
+
 /*
  * the stripe must be locked by the caller.  It will
  * unlock after all the writes are done
@@ -2455,6 +2476,146 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	start_async_work(rbio, recover_rbio_work);
 }
 
+static int rmw_read_and_wait(struct btrfs_raid_bio *rbio)
+{
+	struct bio_list bio_list;
+	struct bio *bio;
+	int ret;
+
+	bio_list_init(&bio_list);
+	atomic_set(&rbio->error, 0);
+
+	ret = rmw_assemble_read_bios(rbio, &bio_list);
+	if (ret < 0)
+		goto out;
+
+	submit_read_bios(rbio, &bio_list);
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+	return ret;
+out:
+	while ((bio = bio_list_pop(&bio_list)))
+		bio_put(bio);
+
+	return ret;
+}
+
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
+static void submit_write_bios(struct btrfs_raid_bio *rbio,
+			      struct bio_list *bio_list)
+{
+	struct bio *bio;
+
+	atomic_set(&rbio->stripes_pending, bio_list_size(bio_list));
+	while ((bio = bio_list_pop(bio_list))) {
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
+}
+
+int rmw_rbio(struct btrfs_raid_bio *rbio)
+{
+	struct bio_list bio_list;
+	int sectornr;
+	int ret = 0;
+
+	/*
+	 * Allocate the pages for parity first, as P/Q pages will always be
+	 * needed for both full-stripe and sub-stripe writes.
+	 */
+	ret = alloc_rbio_parity_pages(rbio);
+	if (ret < 0)
+		return ret;
+
+	/* Full stripe write, can write the full stripe right now. */
+	if (rbio_is_full(rbio))
+		goto write;
+	/*
+	 * Now we're doing sub-stripe write, also need all data stripes to do
+	 * the full RMW.
+	 */
+	ret = alloc_rbio_data_pages(rbio);
+	if (ret < 0)
+		return ret;
+
+	atomic_set(&rbio->error, 0);
+	index_rbio_pages(rbio);
+
+	ret = rmw_read_and_wait(rbio);
+	if (ret < 0)
+		return ret;
+
+	/* Too many read errors, beyond our tolerance. */
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
+		return ret;
+
+	/* Have read failures but under tolerance, needs recovery. */
+	if (rbio->faila >= 0 || rbio->failb >= 0) {
+		ret = recover_rbio(rbio);
+		if (ret < 0)
+			return ret;
+	}
+write:
+	/*
+	 * At this stage we're not allowed to add any new bios to the
+	 * bio list any more, anyone else that wants to change this stripe
+	 * needs to do their own rmw.
+	 */
+	spin_lock_irq(&rbio->bio_list_lock);
+	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
+	spin_unlock_irq(&rbio->bio_list_lock);
+
+	atomic_set(&rbio->error, 0);
+
+	index_rbio_pages(rbio);
+
+	/*
+	 * We don't cache full rbios because we're assuming
+	 * the higher layers are unlikely to use this area of
+	 * the disk again soon.  If they do use it again,
+	 * hopefully they will send another full bio.
+	 */
+	if (!rbio_is_full(rbio))
+		cache_rbio_pages(rbio);
+	else
+		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
+
+	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++)
+		generate_pq_vertical(rbio, sectornr);
+
+	bio_list_init(&bio_list);
+	ret = rmw_assemble_write_bios(rbio, &bio_list);
+	if (ret < 0)
+		return ret;
+
+	/* We should have at least one bio assembled. */
+	ASSERT(bio_list_size(&bio_list));
+	submit_write_bios(rbio, &bio_list);
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+
+	/* We have more errors than our tolerance during the read. */
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
+		ret = -EIO;
+	return ret;
+}
+
 static void rmw_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 445e833fcfcf..0e77c77c5dba 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -185,4 +185,9 @@ void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
 
+/*
+ * Placeholder definition to avoid warning, will be removed when
+ * the full write path is migrated.
+ */
+int rmw_rbio(struct btrfs_raid_bio *rbio);
 #endif
-- 
2.38.1

