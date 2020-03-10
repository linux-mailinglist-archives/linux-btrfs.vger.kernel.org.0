Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E8717F513
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCJKaz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 06:30:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgCJKay (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 06:30:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 239F2B066;
        Tue, 10 Mar 2020 10:30:52 +0000 (UTC)
Subject: Re: [PATCH 4/5] btrfs: only check priority tickets for priority
 flushing
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200309202322.12327-1-josef@toxicpanda.com>
 <20200309202322.12327-5-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f3378de7-0130-1064-0a40-3a7eb593363d@suse.com>
Date:   Tue, 10 Mar 2020 12:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309202322.12327-5-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.03.20 г. 22:23 ч., Josef Bacik wrote:
> In debugging a generic/320 failure on ppc64, Nikolay noticed that
> sometimes we'd ENOSPC out with plenty of space to reclaim if we had
> committed the transaction.  He further discovered that this was because
> there was a priority ticket that was small enough to fit in the free
> space currently in the space_info.
> 
> This is problematic because we prioritize priority tickets, refilling
> them first as new space becomes available.  However this leaves a corner
> where we could fail to satisfy a priority ticket when we would have
> otherwise succeeded.

This warrants an example.

> 
> Consider the case where there's no flushing left to happen other than
> commit the transaction, and there are tickets on the normal flushing
> list. 

^ does this refer to the ordinary flush
btrfs_async_reclaim_metadata_space or priority_reclaim_metadata_space
with evict_flush_states (which also contains a COMMIT_TRANS state).

 The priority flusher comes in, and assume there's enough space
> left in the space_info to satisfy this request.  

This happens _after_ we've been added to the prio list, so perhahps this
and the next sentence need to be transposed, reworded to explicitly
state that despite us having space to satisfy an incoming prio request
if it see pending prio requests it will simply add this to the list.

We will still be added
> to the priority list and go through the flushing motions, and eventually
> fail returning an ENOSPC.
> 
> Instead we should only add ourselves to the list if there's something on
> the priority_list already.  This way we avoid the incorrect ENOSPC
> scenario.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d198cfd45cf7..77ea204f0b6a 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1276,6 +1276,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +/*
> + * This returns true if this flush state will go through the ordinary flushing
> + * code.
> + */
> +static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
> +{
> +	return (flush == BTRFS_RESERVE_FLUSH_DATA) ||
> +		(flush == BTRFS_RESERVE_FLUSH_ALL) ||
> +		(flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
> +}
> +
>  /**
>   * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
>   * @root - the root we're allocating for
> @@ -1311,8 +1322,17 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>  	spin_lock(&space_info->lock);
>  	ret = -ENOSPC;
>  	used = btrfs_space_info_used(space_info, true);
> -	pending_tickets = !list_empty(&space_info->tickets) ||
> -		!list_empty(&space_info->priority_tickets);
> +
> +	/*
> +	 * We don't want NO_FLUSH allocations to jump everybody, they can
> +	 * generally handle ENOSPC in a different way, so treat them the same as
> +	 * normal flushers when it comes to skipping pending tickets.
> +	 */
> +	if (is_normal_flushing(flush) || (flush == BTRFS_RESERVE_NO_FLUSH))
> +		pending_tickets = !list_empty(&space_info->tickets) ||
> +			!list_empty(&space_info->priority_tickets);
> +	else
> +		pending_tickets = !list_empty(&space_info->priority_tickets);
>  
>  	/*
>  	 * Carry on if we have enough space (short-circuit) OR call
> @@ -1338,9 +1358,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>  		ticket.error = 0;
>  		init_waitqueue_head(&ticket.wait);
>  		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
> -		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
> -		    flush == BTRFS_RESERVE_FLUSH_DATA ||
> -		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
> +		if (is_normal_flushing(flush)) {
>  			list_add_tail(&ticket.list, &space_info->tickets);
>  			if (!space_info->flush) {
>  				space_info->flush = 1;
> 
