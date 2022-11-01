Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B261485A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKALQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiKALQ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0B18B0A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1118E1F90C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCL29pakIAS/AHCCiObsXakw9fm8sUYEFfN8V66Njy8=;
        b=Lc/Z7G1mJ4xl+3alBUM4ZVK2qVzJe+EFX5cRkXFnPPXXVGdWCmcSgHhbN97KLYfZnKMDJe
        J0vJsOY8MqhkrcSsK8wj1S8O9fbOqwj50xRXat69TSfZYDkP6h23s5mW35uHeKPqb44t/G
        Lw5R6Ud4WW6r7Ofj7zpm+1k75kiEcbc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BCE61346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aOmBEwYAYWMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/12] btrfs: raid56: switch write path to rmw_rbio()
Date:   Tue,  1 Nov 2022 19:16:09 +0800
Message-Id: <f51b4c0caa86a1683b5350bcae855a69aaa70a44.1667300355.git.wqu@suse.com>
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

This includes the following changes:

- Implement new raid_unplug() functions
  Now we don't need a workqueue to run the plug, as all our
  work is just queue rmw_rbio_work() call, which can be executed
  without sleep.

- Implement a rmw_rbio_work_locked() helper
  This is for unlock_stripe(), which is already holding the full stripe
  lock.

- Remove all the old functions
  This should already shows how complex the old functions are, as we
  ended up removing the following functions:

  * rmw_work()
  * validate_rbio_for_rmw()
  * raid56_rmw_end_io_work()
  * raid56_rmw_stripe()
  * full_stripe_write()
  * partial_stripe_write()
  * __raid56_parity_write()
  * run_plug()
  * unplug_work()
  * btrfs_raid_unplug()
  * rmw_work()
  * __raid56_parity_recover()
  * raid_recover_end_io_work()

- Unexport rmw_rbio()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 350 ++++++----------------------------------------
 fs/btrfs/raid56.h |   5 -
 2 files changed, 42 insertions(+), 313 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 436c9b1d51f5..94df689713ea 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -64,9 +64,9 @@ struct sector_ptr {
 	unsigned int uptodate:8;
 };
 
-static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
-static void rmw_work(struct work_struct *work);
+static void rmw_rbio_work(struct work_struct *work);
+static void rmw_rbio_work_locked(struct work_struct *work);
 static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
 static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
@@ -816,7 +816,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 				start_async_work(next, recover_rbio_work_locked);
 			} else if (next->operation == BTRFS_RBIO_WRITE) {
 				steal_rbio(rbio, next);
-				start_async_work(next, rmw_work);
+				start_async_work(next, rmw_rbio_work_locked);
 			} else if (next->operation == BTRFS_RBIO_PARITY_SCRUB) {
 				steal_rbio(rbio, next);
 				start_async_work(next, scrub_parity_work);
@@ -1108,23 +1108,6 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	return 0;
 }
 
-/*
- * while we're doing the read/modify/write cycle, we could
- * have errors in reading pages off the disk.  This checks
- * for errors and if we're not able to read the page it'll
- * trigger parity reconstruction.  The rmw will be finished
- * after we've reconstructed the failed stripes
- */
-static void validate_rbio_for_rmw(struct btrfs_raid_bio *rbio)
-{
-	if (rbio->faila >= 0 || rbio->failb >= 0) {
-		BUG_ON(rbio->faila == rbio->real_stripes - 1);
-		__raid56_parity_recover(rbio);
-	} else {
-		finish_rmw(rbio);
-	}
-}
-
 static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
@@ -1602,31 +1585,6 @@ static void raid56_bio_end_io(struct bio *bio)
 			   &rbio->end_io_work);
 }
 
-/*
- * End io handler for the read phase of the RMW cycle.  All the bios here are
- * physical stripe bios we've read from the disk so we can recalculate the
- * parity of the stripe.
- *
- * This will usually kick off finish_rmw once all the bios are read in, but it
- * may trigger parity reconstruction if we had any errors along the way
- */
-static void raid56_rmw_end_io_work(struct work_struct *work)
-{
-	struct btrfs_raid_bio *rbio =
-		container_of(work, struct btrfs_raid_bio, end_io_work);
-
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
-		rbio_orig_end_io(rbio, BLK_STS_IOERR);
-		return;
-	}
-
-	/*
-	 * This will normally call finish_rmw to start our write but if there
-	 * are any failed stripes we'll reconstruct from parity first.
-	 */
-	validate_rbio_for_rmw(rbio);
-}
-
 static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				  struct bio_list *bio_list)
 {
@@ -1687,122 +1645,6 @@ static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
 	return 0;
 }
 
-/*
- * the stripe must be locked by the caller.  It will
- * unlock after all the writes are done
- */
-static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
-{
-	int bios_to_read = 0;
-	struct bio_list bio_list;
-	int ret;
-	struct bio *bio;
-
-	bio_list_init(&bio_list);
-
-	ret = alloc_rbio_pages(rbio);
-	if (ret)
-		goto cleanup;
-
-	index_rbio_pages(rbio);
-
-	atomic_set(&rbio->error, 0);
-
-	ret = rmw_assemble_read_bios(rbio, &bio_list);
-	if (ret < 0)
-		goto cleanup;
-
-	bios_to_read = bio_list_size(&bio_list);
-	if (!bios_to_read) {
-		/*
-		 * this can happen if others have merged with
-		 * us, it means there is nothing left to read.
-		 * But if there are missing devices it may not be
-		 * safe to do the full stripe write yet.
-		 */
-		goto finish;
-	}
-
-	/*
-	 * The bioc may be freed once we submit the last bio. Make sure not to
-	 * touch it after that.
-	 */
-	atomic_set(&rbio->stripes_pending, bios_to_read);
-	INIT_WORK(&rbio->end_io_work, raid56_rmw_end_io_work);
-	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid56_bio_end_io;
-
-		if (trace_raid56_read_partial_enabled()) {
-			struct raid56_bio_trace_info trace_info = { 0 };
-
-			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_read_partial(rbio, bio, &trace_info);
-		}
-		submit_bio(bio);
-	}
-	/* the actual write will happen once the reads are done */
-	return 0;
-
-cleanup:
-	rbio_orig_end_io(rbio, BLK_STS_IOERR);
-
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
-	return -EIO;
-
-finish:
-	validate_rbio_for_rmw(rbio);
-	return 0;
-}
-
-/*
- * if the upper layers pass in a full stripe, we thank them by only allocating
- * enough pages to hold the parity, and sending it all down quickly.
- */
-static int full_stripe_write(struct btrfs_raid_bio *rbio)
-{
-	int ret;
-
-	ret = alloc_rbio_parity_pages(rbio);
-	if (ret)
-		return ret;
-
-	ret = lock_stripe_add(rbio);
-	if (ret == 0)
-		finish_rmw(rbio);
-	return 0;
-}
-
-/*
- * partial stripe writes get handed over to async helpers.
- * We're really hoping to merge a few more writes into this
- * rbio before calculating new parity
- */
-static int partial_stripe_write(struct btrfs_raid_bio *rbio)
-{
-	int ret;
-
-	ret = lock_stripe_add(rbio);
-	if (ret == 0)
-		start_async_work(rbio, rmw_work);
-	return 0;
-}
-
-/*
- * sometimes while we were reading from the drive to
- * recalculate parity, enough new bios come into create
- * a full stripe.  So we do a check here to see if we can
- * go directly to finish_rmw
- */
-static int __raid56_parity_write(struct btrfs_raid_bio *rbio)
-{
-	/* head off into rmw land if we don't have a full stripe */
-	if (!rbio_is_full(rbio))
-		return partial_stripe_write(rbio);
-	return full_stripe_write(rbio);
-}
-
 /*
  * We use plugging call backs to collect full stripes.
  * Any time we get a partial stripe write while plugged
@@ -1837,28 +1679,22 @@ static int plug_cmp(void *priv, const struct list_head *a,
 	return 0;
 }
 
-static void run_plug(struct btrfs_plug_cb *plug)
+static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 {
+	struct btrfs_plug_cb *plug = container_of(cb, struct btrfs_plug_cb, cb);
 	struct btrfs_raid_bio *cur;
 	struct btrfs_raid_bio *last = NULL;
 
-	/*
-	 * sort our plug list then try to merge
-	 * everything we can in hopes of creating full
-	 * stripes.
-	 */
 	list_sort(NULL, &plug->rbio_list, plug_cmp);
+
 	while (!list_empty(&plug->rbio_list)) {
 		cur = list_entry(plug->rbio_list.next,
 				 struct btrfs_raid_bio, plug_list);
 		list_del_init(&cur->plug_list);
 
 		if (rbio_is_full(cur)) {
-			int ret;
-
-			/* we have a full stripe, send it down */
-			ret = full_stripe_write(cur);
-			BUG_ON(ret);
+			/* We have a full stripe, queue it down. */
+			start_async_work(cur, rmw_rbio_work);
 			continue;
 		}
 		if (last) {
@@ -1866,42 +1702,16 @@ static void run_plug(struct btrfs_plug_cb *plug)
 				merge_rbio(last, cur);
 				free_raid_bio(cur);
 				continue;
-
 			}
-			__raid56_parity_write(last);
+			start_async_work(last, rmw_rbio_work);
 		}
 		last = cur;
 	}
-	if (last) {
-		__raid56_parity_write(last);
-	}
+	if (last)
+		start_async_work(last, rmw_rbio_work);
 	kfree(plug);
 }
 
-/*
- * if the unplug comes from schedule, we have to push the
- * work off to a helper thread
- */
-static void unplug_work(struct work_struct *work)
-{
-	struct btrfs_plug_cb *plug;
-	plug = container_of(work, struct btrfs_plug_cb, work);
-	run_plug(plug);
-}
-
-static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
-{
-	struct btrfs_plug_cb *plug;
-	plug = container_of(cb, struct btrfs_plug_cb, cb);
-
-	if (from_schedule) {
-		INIT_WORK(&plug->work, unplug_work);
-		queue_work(plug->info->rmw_workers, &plug->work);
-		return;
-	}
-	run_plug(plug);
-}
-
 /* Add the original bio into rbio->bio_list, and update rbio::dbitmap. */
 static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 {
@@ -1949,19 +1759,13 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	rbio_add_bio(rbio, bio);
 
 	/*
-	 * don't plug on full rbios, just get them out the door
+	 * Don't plug on full rbios, just get them out the door
 	 * as quickly as we can
 	 */
-	if (rbio_is_full(rbio)) {
-		ret = full_stripe_write(rbio);
-		if (ret) {
-			free_raid_bio(rbio);
-			goto fail;
-		}
-		return;
-	}
+	if (rbio_is_full(rbio))
+		goto queue_rbio;
 
-	cb = blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
+	cb = blk_check_plugged(raid_unplug, fs_info, sizeof(*plug));
 	if (cb) {
 		plug = container_of(cb, struct btrfs_plug_cb, cb);
 		if (!plug->info) {
@@ -1969,13 +1773,14 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 			INIT_LIST_HEAD(&plug->rbio_list);
 		}
 		list_add_tail(&rbio->plug_list, &plug->rbio_list);
-	} else {
-		ret = __raid56_parity_write(rbio);
-		if (ret) {
-			free_raid_bio(rbio);
-			goto fail;
-		}
+		return;
 	}
+queue_rbio:
+	/*
+	 * Either we don't have any existing plug, or we're doing a full stripe,
+	 * can queue the rmw work now.
+	 */
+	start_async_work(rbio, rmw_rbio_work);
 
 	return;
 
@@ -2218,21 +2023,6 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 	}
 }
 
-/*
- * This is called only for stripes we've read from disk to reconstruct the
- * parity.
- */
-static void raid_recover_end_io_work(struct work_struct *work)
-{
-	struct btrfs_raid_bio *rbio =
-		container_of(work, struct btrfs_raid_bio, end_io_work);
-
-	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
-		rbio_orig_end_io(rbio, BLK_STS_IOERR);
-	else
-		__raid_recover_end_io(rbio);
-}
-
 static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 				      struct bio_list *bio_list)
 {
@@ -2349,79 +2139,6 @@ static void recover_rbio_work_locked(struct work_struct *work)
 	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
-/*
- * reads everything we need off the disk to reconstruct
- * the parity. endio handlers trigger final reconstruction
- * when the IO is done.
- *
- * This is used both for reads from the higher layers and for
- * parity construction required to finish a rmw cycle.
- */
-static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
-{
-	int bios_to_read = 0;
-	struct bio_list bio_list;
-	int ret;
-	struct bio *bio;
-
-	bio_list_init(&bio_list);
-
-	ret = alloc_rbio_pages(rbio);
-	if (ret)
-		goto cleanup;
-
-	atomic_set(&rbio->error, 0);
-
-	ret = recover_assemble_read_bios(rbio, &bio_list);
-	if (ret < 0)
-		goto cleanup;
-
-	bios_to_read = bio_list_size(&bio_list);
-	if (!bios_to_read) {
-		/*
-		 * we might have no bios to read just because the pages
-		 * were up to date, or we might have no bios to read because
-		 * the devices were gone.
-		 */
-		if (atomic_read(&rbio->error) <= rbio->bioc->max_errors) {
-			__raid_recover_end_io(rbio);
-			return 0;
-		} else {
-			goto cleanup;
-		}
-	}
-
-	/*
-	 * The bioc may be freed once we submit the last bio. Make sure not to
-	 * touch it after that.
-	 */
-	atomic_set(&rbio->stripes_pending, bios_to_read);
-	INIT_WORK(&rbio->end_io_work, raid_recover_end_io_work);
-	while ((bio = bio_list_pop(&bio_list))) {
-		bio->bi_end_io = raid56_bio_end_io;
-
-		if (trace_raid56_scrub_read_recover_enabled()) {
-			struct raid56_bio_trace_info trace_info = { 0 };
-
-			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_scrub_read_recover(rbio, bio, &trace_info);
-		}
-		submit_bio(bio);
-	}
-
-	return 0;
-
-cleanup:
-	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING)
-		rbio_orig_end_io(rbio, BLK_STS_IOERR);
-
-	while ((bio = bio_list_pop(&bio_list)))
-		bio_put(bio);
-
-	return -EIO;
-}
-
 /*
  * the main entry point for reads from the higher layers.  This
  * is really only called when the normal read path had a failure,
@@ -2530,7 +2247,7 @@ static void submit_write_bios(struct btrfs_raid_bio *rbio,
 	}
 }
 
-int rmw_rbio(struct btrfs_raid_bio *rbio)
+static int rmw_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct bio_list bio_list;
 	int sectornr;
@@ -2616,12 +2333,29 @@ int rmw_rbio(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
-static void rmw_work(struct work_struct *work)
+static void rmw_rbio_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
+	int ret;
 
 	rbio = container_of(work, struct btrfs_raid_bio, work);
-	raid56_rmw_stripe(rbio);
+
+	ret = lock_stripe_add(rbio);
+	if (ret == 0) {
+		ret = rmw_rbio(rbio);
+		rbio_orig_end_io(rbio, errno_to_blk_status(ret));
+	}
+}
+
+static void rmw_rbio_work_locked(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio;
+	int ret;
+
+	rbio = container_of(work, struct btrfs_raid_bio, work);
+
+	ret = rmw_rbio(rbio);
+	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
 /*
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 0e77c77c5dba..445e833fcfcf 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -185,9 +185,4 @@ void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
 void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info);
 
-/*
- * Placeholder definition to avoid warning, will be removed when
- * the full write path is migrated.
- */
-int rmw_rbio(struct btrfs_raid_bio *rbio);
 #endif
-- 
2.38.1

