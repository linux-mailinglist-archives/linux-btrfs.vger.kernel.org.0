Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4C27F92A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgJAFy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:54:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAFy6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:54:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=23FzjoGdVEBIUHb1Ju8ScFrr027ZHbUWVj9HqiQU374=;
        b=eiLdV/pU3FkgqbctnqogYqt+k8hCnWZT+NmIszqh0OWIDEVfnoh1O9oe4cQ7+9Mfd2C90D
        IgNtR6SFkU9CbmMR0/wopBTpNUVVYuGWjbxviKyLawla74gyCU2sXcQZwfzXKvWusie8bz
        accZHnHx0uWZgwSd8Td2Ff9qggruTOk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AFAAB328;
        Thu,  1 Oct 2020 05:54:56 +0000 (UTC)
Subject: Re: [PATCH 1/9] btrfs: add a trace point for reserve tickets
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <35017faea237f88452785b208e4fe36002b46fc9.1601495426.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8808e629-06c6-5015-9ef3-ac9783078526@suse.com>
Date:   Thu, 1 Oct 2020 08:54:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <35017faea237f88452785b208e4fe36002b46fc9.1601495426.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
> While debugging a ENOSPC related performance problem I needed to see the
> time difference between start and end of a reserve ticket, so add a
> tracepoint where we add the ticket, and where we end the ticket.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I wonder can't we get away with a single tracepoint - simply record the
queue time when we create the ticket in __reserve_bytes and then have a
single tracepoint in handle_reserve_ticket which calculates the
difference between curr_time and the written one while the ticket was
queued? IMO it will be more user friendly for manual inspection, I
assume you have analyzed the duration with a bpf script rather than
looking at every pair of start/end events manually? Also won't it be
useful to also have the flush type printed in the end event so that at
least we know what is the type of the ticket ? Let's not forget
tracepoint from the POV of Linus are more or less ABI so it's preferable
if we get them right from the beginning.

> ---
>  fs/btrfs/space-info.c        |  3 +++
>  include/trace/events/btrfs.h | 40 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 64099565ab8f..40726c8888f7 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1279,6 +1279,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  	 * space wasn't reserved at all).
>  	 */
>  	ASSERT(!(ticket->bytes == 0 && ticket->error));
> +	trace_btrfs_end_reserve_ticket(fs_info, ticket->error);
>  	return ret;
>  }
>  
> @@ -1380,6 +1381,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>  			list_add_tail(&ticket.list,
>  				      &space_info->priority_tickets);
>  		}
> +		trace_btrfs_add_reserve_ticket(fs_info, space_info->flags,
> +					       flush, orig_bytes);
>  	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
>  		used += orig_bytes;
>  		/*
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index ecd24c719de4..68d1622623c7 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2025,6 +2025,46 @@ TRACE_EVENT(btrfs_convert_extent_bit,
>  		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
>  );
>  
> +TRACE_EVENT(btrfs_add_reserve_ticket,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, int flush,
> +		 u64 bytes),
> +
> +	TP_ARGS(fs_info, flags, flush, bytes),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	u64,	flags	)
> +		__field(	int,	flush	)
> +		__field(	u64,	bytes	)
> +	),
> +
> +	TP_fast_assign_btrfs(fs_info,
> +		__entry->flags	= flags;
> +		__entry->flush	= flush;
> +		__entry->bytes	= bytes;
> +	),
> +
> +	TP_printk_btrfs("flags=%s flush=%s bytes=%llu",
> +			__print_symbolic(__entry->flush, FLUSH_ACTIONS),
> +			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
> +			__entry->bytes)
> +);
> +
> +TRACE_EVENT(btrfs_end_reserve_ticket,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, int error),
> +
> +	TP_ARGS(fs_info, error),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	int,	error	)
> +	),
> +
> +	TP_fast_assign_btrfs(fs_info,
> +		__entry->error	= error;
> +	),
> +
> +	TP_printk_btrfs("error=%d", __entry->error)
> +);
> +
>  DECLARE_EVENT_CLASS(btrfs_sleep_tree_lock,
>  	TP_PROTO(const struct extent_buffer *eb, u64 start_ns),
>  
> 
