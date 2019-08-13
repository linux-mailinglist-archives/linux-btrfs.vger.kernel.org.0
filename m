Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1878B1FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfHMIIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 04:08:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727623AbfHMIIJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 04:08:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E201ADCB;
        Tue, 13 Aug 2019 08:08:07 +0000 (UTC)
Subject: Re: [PATCH 2/2] Btrfs: get rid of pointless wtag variable in
 async-thread.c
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1565680721.git.osandov@fb.com>
 <958fe7c61896c82b35b5c552d3fb5bfd4df62627.1565680721.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <feb14e51-9889-1a36-f00b-6e59956de488@suse.com>
Date:   Tue, 13 Aug 2019 11:08:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <958fe7c61896c82b35b5c552d3fb5bfd4df62627.1565680721.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.08.19 г. 10:26 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit ac0c7cf8be00 ("btrfs: fix crash when tracepoint arguments are
> freed by wq callbacks") added a void pointer, wtag, which is passed into
> trace_btrfs_all_work_done() instead of the freed work item. This is
> silly for a few reasons:
> 
> 1. The freed work item still has the same address.
> 2. work is still in scope after it's freed, so assigning wtag doesn't
>    stop anyone from using it.
> 3. The tracepoint has always taken a void * argument, so assigning wtag
>    doesn't actually make things any more type-safe. (Note that the
>    original bug in commit bc074524e123 ("btrfs: prefix fsid to all trace
>    events") was that the void * was implicitly casted when it was passed
>    to btrfs_work_owner() in the trace point itself).
> 
> Instead, let's add some clearer warnings as comments.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com> albeit one small nit
below.

> ---
>  fs/btrfs/async-thread.c      | 21 ++++++++-------------
>  include/trace/events/btrfs.h |  6 +++---
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index d105d3df6fa6..baeb4058e9dc 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -226,7 +226,6 @@ static void run_ordered_work(struct btrfs_work *self)
>  	struct btrfs_work *work;
>  	spinlock_t *lock = &wq->list_lock;
>  	unsigned long flags;
> -	void *wtag;
>  	bool free_self = false;
>  
>  	while (1) {
> @@ -281,21 +280,19 @@ static void run_ordered_work(struct btrfs_work *self)
>  		} else {
>  			/*
>  			 * We don't want to call the ordered free functions with
> -			 * the lock held though. Save the work as tag for the
> -			 * trace event, because the callback could free the
> -			 * structure.
> +			 * the lock held.
>  			 */
> -			wtag = work;
>  			work->ordered_free(work);
> -			trace_btrfs_all_work_done(wq->fs_info, wtag);
> +			/* work must not be dereferenced past this point. */

perhaps prefix the comment with NB: to draw attention to that comment.

> +			trace_btrfs_all_work_done(wq->fs_info, work);
>  		}
>  	}
>  	spin_unlock_irqrestore(lock, flags);
>  
>  	if (free_self) {
> -		wtag = self;
>  		self->ordered_free(self);
> -		trace_btrfs_all_work_done(wq->fs_info, wtag);
> +		/* self must not be dereferenced past this point. */
> +		trace_btrfs_all_work_done(wq->fs_info, self);
>  	}
>  }
>  
> @@ -304,7 +301,6 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>  	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
>  					       normal_work);
>  	struct __btrfs_workqueue *wq;
> -	void *wtag;
>  	int need_order = 0;
>  
>  	/*
> @@ -318,8 +314,6 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>  	if (work->ordered_func)
>  		need_order = 1;
>  	wq = work->wq;
> -	/* Safe for tracepoints in case work gets freed by the callback */
> -	wtag = work;
>  
>  	trace_btrfs_work_sched(work);
>  	thresh_exec_hook(wq);
> @@ -327,9 +321,10 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>  	if (need_order) {
>  		set_bit(WORK_DONE_BIT, &work->flags);
>  		run_ordered_work(work);
> +	} else {
> +		/* work must not be dereferenced past this point. */
> +		trace_btrfs_all_work_done(wq->fs_info, work);
>  	}
> -	if (!need_order)
> -		trace_btrfs_all_work_done(wq->fs_info, wtag);
>  }
>  
>  void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 5cb95646b94e..3d61e80d3c6e 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1388,9 +1388,9 @@ DECLARE_EVENT_CLASS(btrfs__work,
>  );
>  
>  /*
> - * For situiations when the work is freed, we pass fs_info and a tag that that
> - * matches address of the work structure so it can be paired with the
> - * scheduling event.
> + * For situations when the work is freed, we pass fs_info and a tag that that
> + * matches address of the work structure so it can be paired with the scheduling
> + * event. DO NOT add anything here that dereferences wtag.
>   */
>  DECLARE_EVENT_CLASS(btrfs__work__done,
>  
> 
