Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC3450B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfFNAeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:34:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43022 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFNAeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:34:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so220497plb.10;
        Thu, 13 Jun 2019 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/JAvfx5+Iwwj7+HN8ufYq5e0vcppBiU4o2iq5huV3Q=;
        b=qkhvWmsOL7zsVT0hOk04yq/Oe689PujUHGd/HbwUkGvE5Ppwr2lk5fIlPnJbJlNTfP
         dqQfQkNQOpQ+rCF3hDfnMnP57H155WJ+oyUwcPVSqbtqmruc4PCJN6i1LuAXrC0wUt1P
         ukHdX8Sm4uWQ8m8sQywvjpEIhn2nb5hwvrENs8HcTxkU2AOJoiX7Fl3q4gT6VuyQzfNc
         mFS55jTmHcYeFPBYK8yTSwkmJYaM/OCRghkLzHVVQMEdQwaQmfGEt0UcvGaDPUCVV7l8
         DlSuRs6RoViYdVXFHjMTKyQJQjhm1ZF0JobRhF91WbxxHbWtwX7Clblobl+vjz7inhGc
         9TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=F/JAvfx5+Iwwj7+HN8ufYq5e0vcppBiU4o2iq5huV3Q=;
        b=EsNaC++/6zbGrt+zVIzVGPOAV/Ny/CPy0buN8APuWozl+nhNV06D8Iwx3LQ5vvc2XS
         rphvFE+r8kl9f0NPinnc9O1WZ57nR0aXvV31uYjh3irrJQ6FiZo0loyiF9hlrfT4AMJY
         A598lPJQfxk9o52LXtwbLzantsllgTNzckZdvEzJtNqhZlHJMnLBT+NBBBOMjFNr3uvV
         ElY3hODO+6vxzBDbqnw2dJjthWeNmrNbKjM+9owxHd/+0zfcK4sEWg29EXQEqWA5E61b
         rPhTtuXV627Vy6D2qyg4J5WeVJa2E4/Wh+o5sp6QePBf5juRW9ljGWfDaHcKwKC8OJmW
         /cOA==
X-Gm-Message-State: APjAAAV4YdfjBANwZOFk2Jkx+XQUcD8yEEntOZurKpBIQq6fE45Q/Y8A
        KRdUZuBx1k9W86XIVQ/KTP4=
X-Google-Smtp-Source: APXvYqyne0TY1YcUxE/KwkLrkpmL2a5rpfb6BvmOOipyfbEGjkSQYevqyWhP+3UQkAhr86liIajZZg==
X-Received: by 2002:a17:902:aa8a:: with SMTP id d10mr53973231plr.159.1560472446331;
        Thu, 13 Jun 2019 17:34:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id g2sm911781pfb.95.2019.06.13.17.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:34:05 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] Btrfs: delete the entire async bio submission framework
Date:   Thu, 13 Jun 2019 17:33:47 -0700
Message-Id: <20190614003350.1178444-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
References: <20190614003350.1178444-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

Now that we're not using btrfs_schedule_bio() anymore, delete all the
code that supported it.

Signed-off-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/ctree.h   |   1 -
 fs/btrfs/disk-io.c |  13 +--
 fs/btrfs/super.c   |   1 -
 fs/btrfs/volumes.c | 209 ---------------------------------------------
 fs/btrfs/volumes.h |   8 --
 5 files changed, 1 insertion(+), 231 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b81c331b28fa..2a5ba0f85ed3 100644
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
index b34240406f36..9dbe4ba3995d 100644
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
index 2c66d9ea6a3b..3fb86a7bfdf7 100644
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
index 8c7bd79b234a..231f50dd107d 100644
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

