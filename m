Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6594B8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHSRXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 13:23:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:38550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbfHSRXs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 13:23:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57DF2AE52;
        Mon, 19 Aug 2019 17:23:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB317DA7DA; Mon, 19 Aug 2019 19:24:13 +0200 (CEST)
Date:   Mon, 19 Aug 2019 19:24:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/2] Btrfs: get rid of pointless wtag variable in
 async-thread.c
Message-ID: <20190819172413.GL24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1565717247.git.osandov@fb.com>
 <d4fa1870ffce027ada265a67f4e00d397b683241.1565717248.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fa1870ffce027ada265a67f4e00d397b683241.1565717248.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 13, 2019 at 10:33:44AM -0700, Omar Sandoval wrote:
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

I'd argue that the patch did it the way to prevent silly errors like
reusing 'work' because see it's passed to the tracepoint so it's fine to
use any time later as well. The value of the pointer was just something
to grep for not meant to be used in any other way.


> Instead, let's add some clearer warnings as comments.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/async-thread.c      | 21 ++++++++-------------
>  include/trace/events/btrfs.h |  6 +++---
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index d105d3df6fa6..60319075b781 100644
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
> +			/* NB: work must not be dereferenced past this point. */
> +			trace_btrfs_all_work_done(wq->fs_info, work);

I hope that programmers read code and comments so what you do is fine
too and we don't have to reset work to NULL at this point, though this
would make it really hard to miss.
