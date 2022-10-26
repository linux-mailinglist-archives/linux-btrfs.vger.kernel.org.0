Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD060DA75
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 07:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiJZFGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 01:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiJZFGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 01:06:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E084158DE7
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 22:06:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A304E1FA95
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666760803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hg6szYI3PaxnQb65Q2wL9gZJXLj1EeC0QMNndvDBkNw=;
        b=hsUXc3Wz93Ame0mn1lVA8F8N6xb+vUWnzXNU9zSoSfhwU7YlemeuvBOQuKPdak7jgwizfT
        dlGx7hd7s+n5xtiJPxyXXg7G+Pq37kQE/g3xpTg9+q3a7BKTNkDu1h+9grYOTHQMRhdFZj
        Fv4KuGaWavC6iJ8Cj8uJyTaOTEtgEg0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07EA413A6E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GMxYMWLAWGP7XQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 05:06:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: raid56: switch to the new run_one_write_rbio()
Date:   Wed, 26 Oct 2022 13:06:32 +0800
Message-Id: <7dca624de976e872abb869885b009713eddca061.1666760699.git.wqu@suse.com>
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

This includes:

- Remove the functions only utilized by the old interface

- Make unlock_stripe() to queue run_one_write_rbio_work_lock()
  As at unlock_stripe(), the next rbio is the one holding the full
  stripe lock, thus it can not use the existing
  run_one_write_rbio_work(), or the rbio may not be executed forever.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 351 ++++------------------------------------------
 fs/btrfs/raid56.h |   1 -
 2 files changed, 27 insertions(+), 325 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 96be2764433e..0f0e03904cb1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -65,7 +65,6 @@ struct sector_ptr {
 
 static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
-static void rmw_work(struct work_struct *work);
 static void read_rebuild_work(struct work_struct *work);
 static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
 static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
@@ -751,6 +750,29 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	return ret;
 }
 
+static void run_one_write_rbio_work(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, work);
+	int ret;
+
+	ret = lock_stripe_add(rbio);
+	if (ret == 0)
+		run_one_write_rbio(rbio);
+}
+
+/*
+ * This is the special version for unlock_stripe(), where the rbio
+ * is already holding the full stripe lock.
+ */
+static void run_one_write_rbio_work_locked(struct work_struct *work)
+{
+	struct btrfs_raid_bio *rbio =
+		container_of(work, struct btrfs_raid_bio, work);
+
+	run_one_write_rbio(rbio);
+}
+
 /*
  * called as rmw or parity rebuild is completed.  If the plug list has more
  * rbios waiting for this stripe, the next one on the list will be started
@@ -814,7 +836,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 				start_async_work(next, read_rebuild_work);
 			} else if (next->operation == BTRFS_RBIO_WRITE) {
 				steal_rbio(rbio, next);
-				start_async_work(next, rmw_work);
+				start_async_work(next, run_one_write_rbio_work_locked);
 			} else if (next->operation == BTRFS_RBIO_PARITY_SCRUB) {
 				steal_rbio(rbio, next);
 				start_async_work(next, scrub_parity_work);
@@ -1119,23 +1141,6 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
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
@@ -1548,174 +1553,11 @@ static void raid56_bio_end_io(struct bio *bio)
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
-/*
- * the stripe must be locked by the caller.  It will
- * unlock after all the writes are done
- */
-static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
-{
-	int bios_to_read = 0;
-	struct bio_list bio_list;
-	const int nr_data_sectors = rbio->stripe_nsectors * rbio->nr_data;
-	int ret;
-	int total_sector_nr;
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
-	/* Build a list of bios to read all the missing data sectors. */
-	for (total_sector_nr = 0; total_sector_nr < nr_data_sectors;
-	     total_sector_nr++) {
-		struct sector_ptr *sector;
-		int stripe = total_sector_nr / rbio->stripe_nsectors;
-		int sectornr = total_sector_nr % rbio->stripe_nsectors;
-
-		/*
-		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk.  If sector_in_rbio() finds a page
-		 * in the bio list we don't need to read it off the stripe.
-		 */
-		sector = sector_in_rbio(rbio, stripe, sectornr, 1);
-		if (sector)
-			continue;
-
-		sector = rbio_stripe_sector(rbio, stripe, sectornr);
-		/*
-		 * The bio cache may have handed us an uptodate page.  If so,
-		 * use it.
-		 */
-		if (sector->uptodate)
-			continue;
-
-		ret = rbio_add_io_sector(rbio, &bio_list, sector,
-			       stripe, sectornr, REQ_OP_READ);
-		if (ret)
-			goto cleanup;
-	}
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
 /*
  * partial stripe writes get handed over to async helpers.
  * We're really hoping to merge a few more writes into this
  * rbio before calculating new parity
  */
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
@@ -1750,71 +1592,6 @@ static int plug_cmp(void *priv, const struct list_head *a,
 	return 0;
 }
 
-static void run_plug(struct btrfs_plug_cb *plug)
-{
-	struct btrfs_raid_bio *cur;
-	struct btrfs_raid_bio *last = NULL;
-
-	/*
-	 * sort our plug list then try to merge
-	 * everything we can in hopes of creating full
-	 * stripes.
-	 */
-	list_sort(NULL, &plug->rbio_list, plug_cmp);
-	while (!list_empty(&plug->rbio_list)) {
-		cur = list_entry(plug->rbio_list.next,
-				 struct btrfs_raid_bio, plug_list);
-		list_del_init(&cur->plug_list);
-
-		if (rbio_is_full(cur)) {
-			int ret;
-
-			/* we have a full stripe, send it down */
-			ret = full_stripe_write(cur);
-			BUG_ON(ret);
-			continue;
-		}
-		if (last) {
-			if (rbio_can_merge(last, cur)) {
-				merge_rbio(last, cur);
-				free_raid_bio(cur);
-				continue;
-
-			}
-			__raid56_parity_write(last);
-		}
-		last = cur;
-	}
-	if (last) {
-		__raid56_parity_write(last);
-	}
-	kfree(plug);
-}
-
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
@@ -1842,61 +1619,6 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 	}
 }
 
-/*
- * our main entry point for writes from the rest of the FS.
- */
-void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
-{
-	struct btrfs_fs_info *fs_info = bioc->fs_info;
-	struct btrfs_raid_bio *rbio;
-	struct btrfs_plug_cb *plug = NULL;
-	struct blk_plug_cb *cb;
-	int ret = 0;
-
-	rbio = alloc_rbio(fs_info, bioc);
-	if (IS_ERR(rbio)) {
-		ret = PTR_ERR(rbio);
-		goto fail;
-	}
-	rbio->operation = BTRFS_RBIO_WRITE;
-	rbio_add_bio(rbio, bio);
-
-	/*
-	 * don't plug on full rbios, just get them out the door
-	 * as quickly as we can
-	 */
-	if (rbio_is_full(rbio)) {
-		ret = full_stripe_write(rbio);
-		if (ret) {
-			free_raid_bio(rbio);
-			goto fail;
-		}
-		return;
-	}
-
-	cb = blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
-	if (cb) {
-		plug = container_of(cb, struct btrfs_plug_cb, cb);
-		if (!plug->info) {
-			plug->info = fs_info;
-			INIT_LIST_HEAD(&plug->rbio_list);
-		}
-		list_add_tail(&rbio->plug_list, &plug->rbio_list);
-	} else {
-		ret = __raid56_parity_write(rbio);
-		if (ret) {
-			free_raid_bio(rbio);
-			goto fail;
-		}
-	}
-
-	return;
-
-fail:
-	bio->bi_status = errno_to_blk_status(ret);
-	bio_endio(bio);
-}
-
 /*
  * Recover a vertical stripe specified by @sector_nr.
  * @*pointers are the pre-allocated pointers by the caller, so we don't
@@ -2308,14 +2030,6 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	bio_endio(bio);
 }
 
-static void rmw_work(struct work_struct *work)
-{
-	struct btrfs_raid_bio *rbio;
-
-	rbio = container_of(work, struct btrfs_raid_bio, work);
-	raid56_rmw_stripe(rbio);
-}
-
 static void read_rebuild_work(struct work_struct *work)
 {
 	struct btrfs_raid_bio *rbio;
@@ -3243,17 +2957,6 @@ void run_one_write_rbio(struct btrfs_raid_bio *rbio)
 	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
 }
 
-static void run_one_write_rbio_work(struct work_struct *work)
-{
-	struct btrfs_raid_bio *rbio =
-		container_of(work, struct btrfs_raid_bio, work);
-	int ret;
-
-	ret = lock_stripe_add(rbio);
-	if (ret == 0)
-		run_one_write_rbio(rbio);
-}
-
 static void queue_write_rbio(struct btrfs_raid_bio *rbio)
 {
 	INIT_WORK(&rbio->work, run_one_write_rbio_work);
@@ -3284,16 +2987,16 @@ static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 				free_raid_bio(cur);
 				continue;
 			}
-			queue_write_rbio(cur);
+			queue_write_rbio(last);
 		}
 		last = cur;
 	}
 	if (last)
-		queue_write_rbio(cur);
+		queue_write_rbio(last);
 	kfree(plug);
 }
 
-void raid56_parity_write_v2(struct bio *bio, struct btrfs_io_context *bioc)
+void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 9ae9e89190e4..8657cafd32c0 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -168,7 +168,6 @@ struct btrfs_device;
 void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			   int mirror_num);
 void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
-void raid56_parity_write_v2(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    unsigned int pgoff, u64 logical);
-- 
2.38.1

