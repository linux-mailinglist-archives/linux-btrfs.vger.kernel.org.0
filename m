Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DBB8457F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfHGHR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 03:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727281AbfHGHR3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 03:17:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B1C9AF40;
        Wed,  7 Aug 2019 07:17:27 +0000 (UTC)
Subject: Re: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Tejun Heo <tj@kernel.org>
References: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70f6b4fa-26b1-9225-7509-aa89bb7e067c@suse.com>
Date:   Wed, 7 Aug 2019 10:17:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.08.19 г. 20:34 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We hit a the following very strange deadlock on a system with Btrfs on a
> loop device backed by another Btrfs filesystem:
> 
> 1. The top (loop device) filesystem queues an async_cow work item from
>    cow_file_range_async(). We'll call this work X.
> 2. Worker thread A starts work X (normal_work_helper()).
> 3. Worker thread A executes the ordered work for the top filesystem
>    (run_ordered_work()).
> 4. Worker thread A finishes the ordered work for work X and frees X
>    (work->ordered_free()).
> 5. Worker thread A executes another ordered work and gets blocked on I/O
>    to the bottom filesystem (still in run_ordered_work()).
> 6. Meanwhile, the bottom filesystem allocates and queues an async_cow
>    work item which happens to be the recently-freed X.
> 7. The workqueue code sees that X is already being executed by worker
>    thread A, so it schedules X to be executed _after_ worker thread A
>    finishes (see the find_worker_executing_work() call in
>    process_one_work()).

Isn't the bigger problem  that a single run_ordered_work could
potentially run the ordered work for more than one normal work? E.g.
what if btrfs' code is reworked such that run_ordered_work executes
ordered_func for just one work item (the one which called the function
in the first place) ? Wouldn't that also resolve the issue? Correct me
if I'm wrong but it seems silly to have one work item outlive
ordered_free which is what currently happens, right?



> 
> Now, the top filesystem is waiting for I/O on the bottom filesystem, but
> the bottom filesystem is waiting for the top filesystem to finish, so we
> deadlock.
> 
> This happens because we are breaking the workqueue assumption that a
> work item cannot be recycled while it still depends on other work. Fix
> it by waiting to free the work item until we are done with all of the
> related ordered work.
> 
> P.S.:
> 
> One might ask why the workqueue code doesn't try to detect a recycled
> work item. It actually does try by checking whether the work item has
> the same work function (find_worker_executing_work()), but in our case
> the function is the same. This is the only key that the workqueue code
> has available to compare, short of adding an additional, layer-violating
> "custom key". Considering that we're the only ones that have ever hit
> this, we should just play by the rules.
> 
> Unfortunately, we haven't been able to create a minimal reproducer other
> than our full container setup using a compress-force=zstd filesystem on
> top of another compress-force=zstd filesystem.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/async-thread.c | 56 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 122cb97c7909..b2bfde560331 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -250,16 +250,17 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
>  	}
>  }
>  
> -static void run_ordered_work(struct __btrfs_workqueue *wq)
> +static void run_ordered_work(struct btrfs_work *self)
>  {
> +	struct __btrfs_workqueue *wq = self->wq;
>  	struct list_head *list = &wq->ordered_list;
>  	struct btrfs_work *work;
>  	spinlock_t *lock = &wq->list_lock;
>  	unsigned long flags;
> +	void *wtag;
> +	bool free_self = false;
>  
>  	while (1) {
> -		void *wtag;
> -
>  		spin_lock_irqsave(lock, flags);
>  		if (list_empty(list))
>  			break;
> @@ -285,16 +286,47 @@ static void run_ordered_work(struct __btrfs_workqueue *wq)
>  		list_del(&work->ordered_list);
>  		spin_unlock_irqrestore(lock, flags);
>  
> -		/*
> -		 * We don't want to call the ordered free functions with the
> -		 * lock held though. Save the work as tag for the trace event,
> -		 * because the callback could free the structure.
> -		 */
> -		wtag = work;
> -		work->ordered_free(work);
> -		trace_btrfs_all_work_done(wq->fs_info, wtag);
> +		if (work == self) {
> +			/*
> +			 * This is the work item that the worker is currently
> +			 * executing.
> +			 *
> +			 * The kernel workqueue code guarantees non-reentrancy
> +			 * of work items. I.e., if a work item with the same
> +			 * address and work function is queued twice, the second
> +			 * execution is blocked until the first one finishes. A
> +			 * work item may be freed and recycled with the same
> +			 * work function; the workqueue code assumes that the
> +			 * original work item cannot depend on the recycled work
> +			 * item in that case (see find_worker_executing_work()).
> +			 *
> +			 * Note that the work of one Btrfs filesystem may depend
> +			 * on the work of another Btrfs filesystem via, e.g., a
> +			 * loop device. Therefore, we must not allow the current
> +			 * work item to be recycled until we are really done,
> +			 * otherwise we break the above assumption and can
> +			 * deadlock.
> +			 */
> +			free_self = true;
> +		} else {
> +			/*
> +			 * We don't want to call the ordered free functions with
> +			 * the lock held though. Save the work as tag for the
> +			 * trace event, because the callback could free the
> +			 * structure.
> +			 */
> +			wtag = work;
> +			work->ordered_free(work);
> +			trace_btrfs_all_work_done(wq->fs_info, wtag);
> +		}
>  	}
>  	spin_unlock_irqrestore(lock, flags);
> +
> +	if (free_self) {
> +		wtag = self;
> +		self->ordered_free(self);
> +		trace_btrfs_all_work_done(wq->fs_info, wtag);
> +	}
>  }
>  
>  static void normal_work_helper(struct btrfs_work *work)
> @@ -322,7 +354,7 @@ static void normal_work_helper(struct btrfs_work *work)
>  	work->func(work);
>  	if (need_order) {
>  		set_bit(WORK_DONE_BIT, &work->flags);
> -		run_ordered_work(wq);
> +		run_ordered_work(work);
>  	}
>  	if (!need_order)
>  		trace_btrfs_all_work_done(wq->fs_info, wtag);
> 
