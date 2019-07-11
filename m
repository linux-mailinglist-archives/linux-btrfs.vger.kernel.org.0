Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F365966
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2019 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfGKOxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jul 2019 10:53:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:34812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728487AbfGKOxJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jul 2019 10:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DF5DAE0C;
        Thu, 11 Jul 2019 14:53:07 +0000 (UTC)
Subject: Re: [PATCH 2/5] Btrfs: delete the entire async bio submission
 framework
To:     Tejun Heo <tj@kernel.org>, clm@fb.com,
        David Sterba <dsterba@suse.com>, josef@toxicpanda.com
Cc:     kernel-team@fb.com, axboe@kernel.dk, jack@suse.cz,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190710192818.1069475-1-tj@kernel.org>
 <20190710192818.1069475-3-tj@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c8876469-7da9-0ef0-d042-1ee1d74c588c@suse.com>
Date:   Thu, 11 Jul 2019 17:53:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710192818.1069475-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.07.19 г. 22:28 ч., Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> Now that we're not using btrfs_schedule_bio() anymore, delete all the
> code that supported it.
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.h   |   1 -
>  fs/btrfs/disk-io.c |  13 +--
>  fs/btrfs/super.c   |   1 -
>  fs/btrfs/volumes.c | 209 ---------------------------------------------
>  fs/btrfs/volumes.h |   8 --
>  5 files changed, 1 insertion(+), 231 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0a61dff27f57..21618b5b18a4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -989,7 +989,6 @@ struct btrfs_fs_info {
>  	struct btrfs_workqueue *endio_meta_write_workers;
>  	struct btrfs_workqueue *endio_write_workers;
>  	struct btrfs_workqueue *endio_freespace_worker;
> -	struct btrfs_workqueue *submit_workers;
>  	struct btrfs_workqueue *caching_workers;
>  	struct btrfs_workqueue *readahead_workers;
>  
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6b1ecc27913b..323cab06f2a9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2028,7 +2028,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>  	btrfs_destroy_workqueue(fs_info->rmw_workers);
>  	btrfs_destroy_workqueue(fs_info->endio_write_workers);
>  	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
> -	btrfs_destroy_workqueue(fs_info->submit_workers);
>  	btrfs_destroy_workqueue(fs_info->delayed_workers);
>  	btrfs_destroy_workqueue(fs_info->caching_workers);
>  	btrfs_destroy_workqueue(fs_info->readahead_workers);
> @@ -2194,16 +2193,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
>  	fs_info->caching_workers =
>  		btrfs_alloc_workqueue(fs_info, "cache", flags, max_active, 0);
>  
> -	/*
> -	 * a higher idle thresh on the submit workers makes it much more
> -	 * likely that bios will be send down in a sane order to the
> -	 * devices
> -	 */
> -	fs_info->submit_workers =
> -		btrfs_alloc_workqueue(fs_info, "submit", flags,
> -				      min_t(u64, fs_devices->num_devices,
> -					    max_active), 64);
> -
>  	fs_info->fixup_workers =
>  		btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
>  
> @@ -2246,7 +2235,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
>  					    max_active), 8);
>  
>  	if (!(fs_info->workers && fs_info->delalloc_workers &&
> -	      fs_info->submit_workers && fs_info->flush_workers &&
> +	      fs_info->flush_workers &&
>  	      fs_info->endio_workers && fs_info->endio_meta_workers &&
>  	      fs_info->endio_meta_write_workers &&
>  	      fs_info->endio_repair_workers &&
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 0645ec428b4f..b130dc43b5f1 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1668,7 +1668,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
>  
>  	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
>  	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->submit_workers, new_pool_size);
>  	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
>  	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
>  	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 72326cc23985..fc3a16d87869 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -509,212 +509,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>  	return ret;
>  }
>  
> -static void requeue_list(struct btrfs_pending_bios *pending_bios,
> -			struct bio *head, struct bio *tail)
> -{
> -
> -	struct bio *old_head;
> -
> -	old_head = pending_bios->head;
> -	pending_bios->head = head;
> -	if (pending_bios->tail)
> -		tail->bi_next = old_head;
> -	else
> -		pending_bios->tail = tail;
> -}
> -
> -/*
> - * we try to collect pending bios for a device so we don't get a large
> - * number of procs sending bios down to the same device.  This greatly
> - * improves the schedulers ability to collect and merge the bios.
> - *
> - * But, it also turns into a long list of bios to process and that is sure
> - * to eventually make the worker thread block.  The solution here is to
> - * make some progress and then put this work struct back at the end of
> - * the list if the block device is congested.  This way, multiple devices
> - * can make progress from a single worker thread.
> - */
> -static noinline void run_scheduled_bios(struct btrfs_device *device)
> -{
> -	struct btrfs_fs_info *fs_info = device->fs_info;
> -	struct bio *pending;
> -	struct backing_dev_info *bdi;
> -	struct btrfs_pending_bios *pending_bios;
> -	struct bio *tail;
> -	struct bio *cur;
> -	int again = 0;
> -	unsigned long num_run;
> -	unsigned long batch_run = 0;
> -	unsigned long last_waited = 0;
> -	int force_reg = 0;
> -	int sync_pending = 0;
> -	struct blk_plug plug;
> -
> -	/*
> -	 * this function runs all the bios we've collected for
> -	 * a particular device.  We don't want to wander off to
> -	 * another device without first sending all of these down.
> -	 * So, setup a plug here and finish it off before we return
> -	 */
> -	blk_start_plug(&plug);
> -
> -	bdi = device->bdev->bd_bdi;
> -
> -loop:
> -	spin_lock(&device->io_lock);
> -
> -loop_lock:
> -	num_run = 0;
> -
> -	/* take all the bios off the list at once and process them
> -	 * later on (without the lock held).  But, remember the
> -	 * tail and other pointers so the bios can be properly reinserted
> -	 * into the list if we hit congestion
> -	 */
> -	if (!force_reg && device->pending_sync_bios.head) {
> -		pending_bios = &device->pending_sync_bios;
> -		force_reg = 1;
> -	} else {
> -		pending_bios = &device->pending_bios;
> -		force_reg = 0;
> -	}
> -
> -	pending = pending_bios->head;
> -	tail = pending_bios->tail;
> -	WARN_ON(pending && !tail);
> -
> -	/*
> -	 * if pending was null this time around, no bios need processing
> -	 * at all and we can stop.  Otherwise it'll loop back up again
> -	 * and do an additional check so no bios are missed.
> -	 *
> -	 * device->running_pending is used to synchronize with the
> -	 * schedule_bio code.
> -	 */
> -	if (device->pending_sync_bios.head == NULL &&
> -	    device->pending_bios.head == NULL) {
> -		again = 0;
> -		device->running_pending = 0;
> -	} else {
> -		again = 1;
> -		device->running_pending = 1;
> -	}
> -
> -	pending_bios->head = NULL;
> -	pending_bios->tail = NULL;
> -
> -	spin_unlock(&device->io_lock);
> -
> -	while (pending) {
> -
> -		rmb();
> -		/* we want to work on both lists, but do more bios on the
> -		 * sync list than the regular list
> -		 */
> -		if ((num_run > 32 &&
> -		    pending_bios != &device->pending_sync_bios &&
> -		    device->pending_sync_bios.head) ||
> -		   (num_run > 64 && pending_bios == &device->pending_sync_bios &&
> -		    device->pending_bios.head)) {
> -			spin_lock(&device->io_lock);
> -			requeue_list(pending_bios, pending, tail);
> -			goto loop_lock;
> -		}
> -
> -		cur = pending;
> -		pending = pending->bi_next;
> -		cur->bi_next = NULL;
> -
> -		BUG_ON(atomic_read(&cur->__bi_cnt) == 0);
> -
> -		/*
> -		 * if we're doing the sync list, record that our
> -		 * plug has some sync requests on it
> -		 *
> -		 * If we're doing the regular list and there are
> -		 * sync requests sitting around, unplug before
> -		 * we add more
> -		 */
> -		if (pending_bios == &device->pending_sync_bios) {
> -			sync_pending = 1;
> -		} else if (sync_pending) {
> -			blk_finish_plug(&plug);
> -			blk_start_plug(&plug);
> -			sync_pending = 0;
> -		}
> -
> -		btrfsic_submit_bio(cur);
> -		num_run++;
> -		batch_run++;
> -
> -		cond_resched();
> -
> -		/*
> -		 * we made progress, there is more work to do and the bdi
> -		 * is now congested.  Back off and let other work structs
> -		 * run instead
> -		 */
> -		if (pending && bdi_write_congested(bdi) && batch_run > 8 &&
> -		    fs_info->fs_devices->open_devices > 1) {
> -			struct io_context *ioc;
> -
> -			ioc = current->io_context;
> -
> -			/*
> -			 * the main goal here is that we don't want to
> -			 * block if we're going to be able to submit
> -			 * more requests without blocking.
> -			 *
> -			 * This code does two great things, it pokes into
> -			 * the elevator code from a filesystem _and_
> -			 * it makes assumptions about how batching works.
> -			 */
> -			if (ioc && ioc->nr_batch_requests > 0 &&
> -			    time_before(jiffies, ioc->last_waited + HZ/50UL) &&
> -			    (last_waited == 0 ||
> -			     ioc->last_waited == last_waited)) {
> -				/*
> -				 * we want to go through our batch of
> -				 * requests and stop.  So, we copy out
> -				 * the ioc->last_waited time and test
> -				 * against it before looping
> -				 */
> -				last_waited = ioc->last_waited;
> -				cond_resched();
> -				continue;
> -			}
> -			spin_lock(&device->io_lock);
> -			requeue_list(pending_bios, pending, tail);
> -			device->running_pending = 1;
> -
> -			spin_unlock(&device->io_lock);
> -			btrfs_queue_work(fs_info->submit_workers,
> -					 &device->work);
> -			goto done;
> -		}
> -	}
> -
> -	cond_resched();
> -	if (again)
> -		goto loop;
> -
> -	spin_lock(&device->io_lock);
> -	if (device->pending_bios.head || device->pending_sync_bios.head)
> -		goto loop_lock;
> -	spin_unlock(&device->io_lock);
> -
> -done:
> -	blk_finish_plug(&plug);
> -}
> -
> -static void pending_bios_fn(struct btrfs_work *work)
> -{
> -	struct btrfs_device *device;
> -
> -	device = container_of(work, struct btrfs_device, work);
> -	run_scheduled_bios(device);
> -}
> -
>  static bool device_path_matched(const char *path, struct btrfs_device *device)
>  {
>  	int found;
> @@ -6599,9 +6393,6 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>  	else
>  		generate_random_uuid(dev->uuid);
>  
> -	btrfs_init_work(&dev->work, btrfs_submit_helper,
> -			pending_bios_fn, NULL, NULL);
> -
>  	return dev;
>  }
>  
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index e532d095c6a4..819047621176 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -18,10 +18,6 @@ extern struct mutex uuid_mutex;
>  #define BTRFS_STRIPE_LEN	SZ_64K
>  
>  struct buffer_head;
> -struct btrfs_pending_bios {
> -	struct bio *head;
> -	struct bio *tail;
> -};
>  
>  /*
>   * Use sequence counter to get consistent device stat data on
> @@ -55,10 +51,6 @@ struct btrfs_device {
>  
>  	spinlock_t io_lock ____cacheline_aligned;
>  	int running_pending;
> -	/* regular prio bios */
> -	struct btrfs_pending_bios pending_bios;
> -	/* sync bios */
> -	struct btrfs_pending_bios pending_sync_bios;
>  
>  	struct block_device *bdev;
>  
> 
