Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA0614855
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKALQZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKALQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244317E1D
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 738751F90C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsgvNrLUOyC6zLHbCX1xbceTpArzOpfO/6L/FBSTfds=;
        b=hPtwLKAykq+LtrCjN+EVBnix5ZRVnf5iNMJl6qnvelPJTu7qlF6NFql+aBTP/gb/Zv91XT
        8dL0dboOJvFHY9kujegekUtk3WKCTrLsZVXozsJBHeo98d4+7ztKdaA/c5Ptm5TnGkeT9B
        QTbX9YJMrZhkQHZP14NkrsaYwKHOHzE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E10611346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHxMLAIAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/12] btrfs: raid56: switch recovery path to a single function
Date:   Tue,  1 Nov 2022 19:16:05 +0800
Message-Id: <d69ee4c48c85174dac9e3f13c932abf0e4967f7c.1667300355.git.wqu@suse.com>
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

Currently btrfs uses end_io functions to jump between different stages
of recovery.

For example, we go the following different functions:

- raid56_bio_end_io()
  This handles the read for all the sectors (except the missing device).

- __raid_recover_end_io()
  This does the real work, it's called inside the delayed work function
   raid_recover_end_io_work().

This one recovery path involves at least 3 different functions, which is
a big burden for readers.

This patch will change the behavior by:

- Introduce a unified recovery entrance, recover_rbio()

- Use submit-and-wait method
  So the workflow is not interrupted by the endio function jump.
  This doesn't bring performance change, but reduce the burden for
  reviewers.

- Run the main function in the rmw_workers workqueue
  Now raid56_parity_recover() only needs to setup the work, and
  queue the work using start_async_work().

Now readers only need to do one function jump (start_async_work()) to
find out the main entrance of recovery path.

Furthermore, recover_rbio() function can easily be reused by other paths.

The old recovery path is still utilized by degraded write path.
It will be cleaned up when we have migrated the write path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 145 +++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/raid56.h |   2 +
 2 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0f6c3358bb10..4bef7e32acbe 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -67,7 +67,6 @@ struct sector_ptr {
 static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
 static void rmw_work(struct work_struct *work);
-static void read_rebuild_work(struct work_struct *work);
 static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
 static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
@@ -752,6 +751,8 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
+static void recover_rbio_work_locked(struct work_struct *work);
+
 /*
  * called as rmw or parity rebuild is completed.  If the plug list has more
  * rbios waiting for this stripe, the next one on the list will be started
@@ -809,10 +810,10 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 			spin_unlock_irqrestore(&h->lock, flags);
 
 			if (next->operation == BTRFS_RBIO_READ_REBUILD)
-				start_async_work(next, read_rebuild_work);
+				start_async_work(next, recover_rbio_work_locked);
 			else if (next->operation == BTRFS_RBIO_REBUILD_MISSING) {
 				steal_rbio(rbio, next);
-				start_async_work(next, read_rebuild_work);
+				start_async_work(next, recover_rbio_work_locked);
 			} else if (next->operation == BTRFS_RBIO_WRITE) {
 				steal_rbio(rbio, next);
 				start_async_work(next, rmw_work);
@@ -989,6 +990,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	}
 
 	bio_list_init(&rbio->bio_list);
+	init_waitqueue_head(&rbio->io_wait);
 	INIT_LIST_HEAD(&rbio->plug_list);
 	spin_lock_init(&rbio->bio_list_lock);
 	INIT_LIST_HEAD(&rbio->stripe_cache);
@@ -1519,6 +1521,40 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 	}
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
+static void submit_read_bios(struct btrfs_raid_bio *rbio,
+			     struct bio_list *bio_list)
+{
+	struct bio *bio;
+
+	atomic_set(&rbio->stripes_pending, bio_list_size(bio_list));
+	while ((bio = bio_list_pop(bio_list))) {
+		bio->bi_end_io = raid_wait_read_end_io;
+
+		if (trace_raid56_scrub_read_recover_enabled()) {
+			struct raid56_bio_trace_info trace_info = { 0 };
+
+			bio_get_trace_info(rbio, bio, &trace_info);
+			trace_raid56_scrub_read_recover(rbio, bio, &trace_info);
+		}
+		submit_bio(bio);
+	}
+}
+
 static void raid56_bio_end_io(struct bio *bio)
 {
 	struct btrfs_raid_bio *rbio = bio->bi_private;
@@ -2176,6 +2212,79 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 	return -EIO;
 }
 
+static int recover_rbio(struct btrfs_raid_bio *rbio)
+{
+	struct bio_list bio_list;
+	struct bio *bio;
+	int ret;
+
+	/*
+	 * Either we're doing recover for a read failure or degraded write,
+	 * caller should have set faila/b correctly.
+	 */
+	ASSERT(rbio->faila >= 0 || rbio->failb >= 0);
+	bio_list_init(&bio_list);
+
+	/*
+	 * Reset error to 0, as we will later increase error for missing
+	 * devices.
+	 */
+	atomic_set(&rbio->error, 0);
+
+	/* For recovery, we need to read all sectors including P/Q. */
+	ret = alloc_rbio_pages(rbio);
+	if (ret < 0)
+		goto out;
+
+	index_rbio_pages(rbio);
+
+	ret = recover_assemble_read_bios(rbio, &bio_list);
+	if (ret < 0)
+		goto out;
+
+	submit_read_bios(rbio, &bio_list);
+	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
+
+	/* We have more errors than our tolerance during the read. */
+	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = recover_sectors(rbio);
+
+out:
+	while ((bio = bio_list_pop(&bio_list)))
+		bio_put(bio);
+
+	return ret;
+}
+
+static void recover_rbio_work(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio;
+	int ret;
+
+	rbio = container_of(work, struct btrfs_raid_bio, work);
+
+	ret = lock_stripe_add(rbio);
+	if (ret == 0) {
+		ret = recover_rbio(rbio);
+		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	}
+}
+
+static void recover_rbio_work_locked(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio;
+	int ret;
+
+	rbio = container_of(work, struct btrfs_raid_bio, work);
+
+	ret = recover_rbio(rbio);
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+}
+
 /*
  * reads everything we need off the disk to reconstruct
  * the parity. endio handlers trigger final reconstruction
@@ -2264,7 +2373,8 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
 		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
-		goto out_end_bio;
+		bio_endio(bio);
+		return;
 	}
 
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
@@ -2278,7 +2388,8 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			   (u64)bio->bi_iter.bi_size, bioc->map_type);
 		free_raid_bio(rbio);
 		bio->bi_status = BLK_STS_IOERR;
-		goto out_end_bio;
+		bio_endio(bio);
+		return;
 	}
 
 	/*
@@ -2298,18 +2409,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			rbio->failb--;
 	}
 
-	if (lock_stripe_add(rbio))
-		return;
-
-	/*
-	 * This adds our rbio to the list of rbios that will be handled after
-	 * the current lock owner is done.
-	 */
-	__raid56_parity_recover(rbio);
-	return;
-
-out_end_bio:
-	bio_endio(bio);
+	start_async_work(rbio, recover_rbio_work);
 }
 
 static void rmw_work(struct work_struct *work)
@@ -2320,14 +2420,6 @@ static void rmw_work(struct work_struct *work)
 	raid56_rmw_stripe(rbio);
 }
 
-static void read_rebuild_work(struct work_struct *work)
-{
-	struct btrfs_raid_bio *rbio;
-
-	rbio = container_of(work, struct btrfs_raid_bio, work);
-	__raid56_parity_recover(rbio);
-}
-
 /*
  * The following code is used to scrub/replace the parity stripe
  *
@@ -2818,6 +2910,5 @@ raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 
 void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio)
 {
-	if (!lock_stripe_add(rbio))
-		start_async_work(rbio, read_rebuild_work);
+	start_async_work(rbio, recover_rbio_work);
 }
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 91d5c0adad15..445e833fcfcf 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -95,6 +95,8 @@ struct btrfs_raid_bio {
 
 	atomic_t error;
 
+	wait_queue_head_t io_wait;
+
 	struct work_struct end_io_work;
 
 	/* Bitmap to record which horizontal stripe has data */
-- 
2.38.1

