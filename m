Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37F64CC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfGJT23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 15:28:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43429 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJT23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 15:28:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so1690763pgv.10;
        Wed, 10 Jul 2019 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkTtK+B4Hc3hWS1xeEvOMIPoXRqeBBXhhK6OzMBfzY4=;
        b=FR715TlEJfF7PhT/lPqjTreGAoyqYz84oy1MfbOslo98zWCRf05ISJm/6r/Zh7xcnO
         kZ/MN8kYOEETcOeu/nDKCl9bzCckJ60Zo1WYPZvOkJNoQfXh1fAmaLZiARISpgYO3+s+
         cc1oKCSoI9uWzLZriqDkUu1p8+5frN90vNW/s1cwAkl0W52XL2LxXCSvTskp8vcT10Oy
         8aa/ksD6cwkP4zx3cjCgFVcPosIRxOhZjzvnf/01b3JnuoZETgyKJhJfy7A9Y/Z64DLU
         f+IxI82TdGA0iWzCJ+2be8LD5P2MMMzrgCITnwQfl8lbqw8ML9qZk0BI2exTywp829CI
         9s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zkTtK+B4Hc3hWS1xeEvOMIPoXRqeBBXhhK6OzMBfzY4=;
        b=IQ7lSks2HCua1jsrQNZhv5MtqAgEDuz64CFcGXwo5Vq4sWNxODR414nuA4Rjvh4dnk
         +/B1YhI0kPb7HLpVi6ycGdZ2x9K/zICdeF2q8b24cddAH0D8HZnkI35FJRVknh/q1ake
         EEo52lc7+IZwiqB4qsjldJT3stSHst4rCB0B8dfU4WTaaSswmeYIIdsp7tnKdsDQ8XU6
         mXCYUvglxI0ooI95z2MsNptjM3spr9TOfeneqr6dZsbz6uIw4lPV+11UCX7qIhCN1FEj
         14uOB3lsOp1J7fIp2j3ES7k4WOhxRFkpOs0jCXj8J6jo2TdotC8z4uTgRT0/bpFifRQg
         8psw==
X-Gm-Message-State: APjAAAW+Jwh1fPDg/hWgjnZebSvXmrTtQo0iBiz6SpLIwgN1umnrLRq8
        OLkdzUd3LT0sMbP8nDC0lYtNULyRs2c=
X-Google-Smtp-Source: APXvYqwgk+pK2MmnUTnoARfUdkx3duwRDj5Nhk8kLcdGW2kaDaYr6YeKGEVtlaKq94dPFno1fDMprg==
X-Received: by 2002:a63:3d8d:: with SMTP id k135mr39897325pga.23.1562786907707;
        Wed, 10 Jul 2019 12:28:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id v3sm2811637pfm.188.2019.07.10.12.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:28:27 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com
Cc:     axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] Btrfs: delete the entire async bio submission framework
Date:   Wed, 10 Jul 2019 12:28:15 -0700
Message-Id: <20190710192818.1069475-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710192818.1069475-1-tj@kernel.org>
References: <20190710192818.1069475-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

Now that we're not using btrfs_schedule_bio() anymore, delete all the
code that supported it.

Signed-off-by: Chris Mason <clm@fb.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   |   1 -
 fs/btrfs/disk-io.c |  13 +--
 fs/btrfs/super.c   |   1 -
 fs/btrfs/volumes.c | 209 ---------------------------------------------
 fs/btrfs/volumes.h |   8 --
 5 files changed, 1 insertion(+), 231 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..21618b5b18a4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -989,7 +989,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
 	struct btrfs_workqueue *endio_freespace_worker;
-	struct btrfs_workqueue *submit_workers;
 	struct btrfs_workqueue *caching_workers;
 	struct btrfs_workqueue *readahead_workers;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6b1ecc27913b..323cab06f2a9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2028,7 +2028,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
-	btrfs_destroy_workqueue(fs_info->submit_workers);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
 	btrfs_destroy_workqueue(fs_info->caching_workers);
 	btrfs_destroy_workqueue(fs_info->readahead_workers);
@@ -2194,16 +2193,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	fs_info->caching_workers =
 		btrfs_alloc_workqueue(fs_info, "cache", flags, max_active, 0);
 
-	/*
-	 * a higher idle thresh on the submit workers makes it much more
-	 * likely that bios will be send down in a sane order to the
-	 * devices
-	 */
-	fs_info->submit_workers =
-		btrfs_alloc_workqueue(fs_info, "submit", flags,
-				      min_t(u64, fs_devices->num_devices,
-					    max_active), 64);
-
 	fs_info->fixup_workers =
 		btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
 
@@ -2246,7 +2235,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 					    max_active), 8);
 
 	if (!(fs_info->workers && fs_info->delalloc_workers &&
-	      fs_info->submit_workers && fs_info->flush_workers &&
+	      fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->endio_meta_write_workers &&
 	      fs_info->endio_repair_workers &&
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0645ec428b4f..b130dc43b5f1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1668,7 +1668,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 
 	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->submit_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 72326cc23985..fc3a16d87869 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -509,212 +509,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-static void requeue_list(struct btrfs_pending_bios *pending_bios,
-			struct bio *head, struct bio *tail)
-{
-
-	struct bio *old_head;
-
-	old_head = pending_bios->head;
-	pending_bios->head = head;
-	if (pending_bios->tail)
-		tail->bi_next = old_head;
-	else
-		pending_bios->tail = tail;
-}
-
-/*
- * we try to collect pending bios for a device so we don't get a large
- * number of procs sending bios down to the same device.  This greatly
- * improves the schedulers ability to collect and merge the bios.
- *
- * But, it also turns into a long list of bios to process and that is sure
- * to eventually make the worker thread block.  The solution here is to
- * make some progress and then put this work struct back at the end of
- * the list if the block device is congested.  This way, multiple devices
- * can make progress from a single worker thread.
- */
-static noinline void run_scheduled_bios(struct btrfs_device *device)
-{
-	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct bio *pending;
-	struct backing_dev_info *bdi;
-	struct btrfs_pending_bios *pending_bios;
-	struct bio *tail;
-	struct bio *cur;
-	int again = 0;
-	unsigned long num_run;
-	unsigned long batch_run = 0;
-	unsigned long last_waited = 0;
-	int force_reg = 0;
-	int sync_pending = 0;
-	struct blk_plug plug;
-
-	/*
-	 * this function runs all the bios we've collected for
-	 * a particular device.  We don't want to wander off to
-	 * another device without first sending all of these down.
-	 * So, setup a plug here and finish it off before we return
-	 */
-	blk_start_plug(&plug);
-
-	bdi = device->bdev->bd_bdi;
-
-loop:
-	spin_lock(&device->io_lock);
-
-loop_lock:
-	num_run = 0;
-
-	/* take all the bios off the list at once and process them
-	 * later on (without the lock held).  But, remember the
-	 * tail and other pointers so the bios can be properly reinserted
-	 * into the list if we hit congestion
-	 */
-	if (!force_reg && device->pending_sync_bios.head) {
-		pending_bios = &device->pending_sync_bios;
-		force_reg = 1;
-	} else {
-		pending_bios = &device->pending_bios;
-		force_reg = 0;
-	}
-
-	pending = pending_bios->head;
-	tail = pending_bios->tail;
-	WARN_ON(pending && !tail);
-
-	/*
-	 * if pending was null this time around, no bios need processing
-	 * at all and we can stop.  Otherwise it'll loop back up again
-	 * and do an additional check so no bios are missed.
-	 *
-	 * device->running_pending is used to synchronize with the
-	 * schedule_bio code.
-	 */
-	if (device->pending_sync_bios.head == NULL &&
-	    device->pending_bios.head == NULL) {
-		again = 0;
-		device->running_pending = 0;
-	} else {
-		again = 1;
-		device->running_pending = 1;
-	}
-
-	pending_bios->head = NULL;
-	pending_bios->tail = NULL;
-
-	spin_unlock(&device->io_lock);
-
-	while (pending) {
-
-		rmb();
-		/* we want to work on both lists, but do more bios on the
-		 * sync list than the regular list
-		 */
-		if ((num_run > 32 &&
-		    pending_bios != &device->pending_sync_bios &&
-		    device->pending_sync_bios.head) ||
-		   (num_run > 64 && pending_bios == &device->pending_sync_bios &&
-		    device->pending_bios.head)) {
-			spin_lock(&device->io_lock);
-			requeue_list(pending_bios, pending, tail);
-			goto loop_lock;
-		}
-
-		cur = pending;
-		pending = pending->bi_next;
-		cur->bi_next = NULL;
-
-		BUG_ON(atomic_read(&cur->__bi_cnt) == 0);
-
-		/*
-		 * if we're doing the sync list, record that our
-		 * plug has some sync requests on it
-		 *
-		 * If we're doing the regular list and there are
-		 * sync requests sitting around, unplug before
-		 * we add more
-		 */
-		if (pending_bios == &device->pending_sync_bios) {
-			sync_pending = 1;
-		} else if (sync_pending) {
-			blk_finish_plug(&plug);
-			blk_start_plug(&plug);
-			sync_pending = 0;
-		}
-
-		btrfsic_submit_bio(cur);
-		num_run++;
-		batch_run++;
-
-		cond_resched();
-
-		/*
-		 * we made progress, there is more work to do and the bdi
-		 * is now congested.  Back off and let other work structs
-		 * run instead
-		 */
-		if (pending && bdi_write_congested(bdi) && batch_run > 8 &&
-		    fs_info->fs_devices->open_devices > 1) {
-			struct io_context *ioc;
-
-			ioc = current->io_context;
-
-			/*
-			 * the main goal here is that we don't want to
-			 * block if we're going to be able to submit
-			 * more requests without blocking.
-			 *
-			 * This code does two great things, it pokes into
-			 * the elevator code from a filesystem _and_
-			 * it makes assumptions about how batching works.
-			 */
-			if (ioc && ioc->nr_batch_requests > 0 &&
-			    time_before(jiffies, ioc->last_waited + HZ/50UL) &&
-			    (last_waited == 0 ||
-			     ioc->last_waited == last_waited)) {
-				/*
-				 * we want to go through our batch of
-				 * requests and stop.  So, we copy out
-				 * the ioc->last_waited time and test
-				 * against it before looping
-				 */
-				last_waited = ioc->last_waited;
-				cond_resched();
-				continue;
-			}
-			spin_lock(&device->io_lock);
-			requeue_list(pending_bios, pending, tail);
-			device->running_pending = 1;
-
-			spin_unlock(&device->io_lock);
-			btrfs_queue_work(fs_info->submit_workers,
-					 &device->work);
-			goto done;
-		}
-	}
-
-	cond_resched();
-	if (again)
-		goto loop;
-
-	spin_lock(&device->io_lock);
-	if (device->pending_bios.head || device->pending_sync_bios.head)
-		goto loop_lock;
-	spin_unlock(&device->io_lock);
-
-done:
-	blk_finish_plug(&plug);
-}
-
-static void pending_bios_fn(struct btrfs_work *work)
-{
-	struct btrfs_device *device;
-
-	device = container_of(work, struct btrfs_device, work);
-	run_scheduled_bios(device);
-}
-
 static bool device_path_matched(const char *path, struct btrfs_device *device)
 {
 	int found;
@@ -6599,9 +6393,6 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	else
 		generate_random_uuid(dev->uuid);
 
-	btrfs_init_work(&dev->work, btrfs_submit_helper,
-			pending_bios_fn, NULL, NULL);
-
 	return dev;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e532d095c6a4..819047621176 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -18,10 +18,6 @@ extern struct mutex uuid_mutex;
 #define BTRFS_STRIPE_LEN	SZ_64K
 
 struct buffer_head;
-struct btrfs_pending_bios {
-	struct bio *head;
-	struct bio *tail;
-};
 
 /*
  * Use sequence counter to get consistent device stat data on
@@ -55,10 +51,6 @@ struct btrfs_device {
 
 	spinlock_t io_lock ____cacheline_aligned;
 	int running_pending;
-	/* regular prio bios */
-	struct btrfs_pending_bios pending_bios;
-	/* sync bios */
-	struct btrfs_pending_bios pending_sync_bios;
 
 	struct block_device *bdev;
 
-- 
2.17.1

