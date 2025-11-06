Return-Path: <linux-btrfs+bounces-18771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1ACC3A9C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 12:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAEE423D44
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5730EF98;
	Thu,  6 Nov 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U1QJopD3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6E303CBB
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428579; cv=none; b=Rgyvb2cuOLbRkFkrWVrehX9/W8Yc7l9x6FH3t2TBQAxmNl0NxPdHlgFqrOX+1LZ9TlPCDb/5gPDpGr7HjMQg8kMokufc5TnBkIXNJYvxUtj/a2e/1qGjifOJt9N0zBha3ajXyBU2OHXY3T3knYnSnUcaq8StWoCRv8GQxjWsh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428579; c=relaxed/simple;
	bh=ABXQLfLROpKSYAfG9fjfNp8dikh+fEDpF844G5QuX4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TooHsaRU7W/JNuQVZufZbalolAlIcLK6GPnRarLjT45uJi5FtzHwYYrU11fF54l4BbX1e+noUAPi6dW1tlA1qTHuC4LEZJFY8xBOSZ170o3Fo8iYE1nZ4C9NdfxcjYcp2sbdNDil2qPqm5TmDhy+fU4Str99rPxOrUrnsnYTQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U1QJopD3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso5494205e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762428576; x=1763033376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quGDS25IjjMuJbJzKmEqKKc3IZ6oM97ylfEw0LRKAk8=;
        b=U1QJopD3/GO26WZRLmOrr2JT6sfDQ/D5EAcnE4JURy9VhlMYhOL4w8YKSTe6UmJJn5
         3wV2rgX7iUYReErdUWRMGZrUAzVcKRKuRUv9aBdI2ztEqNXYU25ortHe/BBOltI/uik2
         c7RJcJM1rQ5K90uLOZKcanXQTw8mw5DSEe/CxTz2paHTx16O5XOgSKX+hcepoJ61tRn6
         VBYHoQ8IvLpfJHDfSHjDzxyVP/xH/OkAbmj45l6hZFPGe4vH+Jp2QBhLNVI8S/A/cyOp
         ZrahldgHd0Ot4ROLLXNB0Mskpl7GPbx2QyQFWujqEfdJACVHqR6V5kxV23PtGMfSzdZe
         aoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428576; x=1763033376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quGDS25IjjMuJbJzKmEqKKc3IZ6oM97ylfEw0LRKAk8=;
        b=s/8RHXrKDhJYaAUB1Ty+9w8TtlHigIjueb1geGx9mjyKOM1K5WE5KblfPY4sR2dCVh
         z05l8LJHOZWoim4Bm1Kom3DCD/7fAPhWei4zmCzBwVHnjlQaEGY7ZBbOE1JncBB1+2PO
         CCkzHL0BBKzq438waQpE2kofn/4Cm5IlPrihDH/F+LGpcaEXvJoY1oFlhO7WdbVwBFDc
         aMWzgDSW8Pi5bkuN02vgyViyF27UmVAITQBBDpLP0u527n42eBOpXfUfS4hUrjfOTdhJ
         MNncQz99LBaL1kzOTRMLiruPtDbqwQzPQUaYN+IIkG2/eXZnsnzumMur8PSq6Es6FhOR
         8w0w==
X-Gm-Message-State: AOJu0YzY10Mzr3fRTHqicWlMRxVcpJ63NZrIZUocUIAQo1uxiYbuHq6v
	h3IBV+WxeSfZXyHaRsZV9tl8NCEOtogLRtmN6rOcV5rqcUo4kISmRLKNCqgzNSDyo/ixEBm8InT
	bzVt9XaWaYF8gC++P16EO8mbkct83XXFY4YR5/MY/SkO9lq5GE3rJ
X-Gm-Gg: ASbGncsn87+5FX6ecQBecK1yNaxffHT16c4xOXA80zyilSbmHZs3bxedebvqk1UqWAo
	3KpXWN/YcBSIb/XmawnI8FofzX4KouenyOs+TAA4yIK3i92/Fn3SzulbvOoOhhPYnKvOo7pDtnE
	oSNeOcleRW6MTzTUgHWLnxtIydErkbV9O2zhvtqZ3+hItxmCAPjVAnViXRjy9uEmI/0brsjiz80
	jR/Ylf5amsxEcHDndTiVylz4IRuafAhx/t/e8HE6p1csfJZz3R6C3daa4nFVqJEUbkajANk6Wxz
	cLpFvlss5iiSGaYvR8IvSO2gLYp7YdsnvDYzl+Lc6oiJK/apJCG5DzYRfPpk90zwe7rA
X-Google-Smtp-Source: AGHT+IFUbnp7OoJJ1YSrY/QuLpnLkTgWsD4tMdlzedYn5IeeZKzn67Da4mOTIrKaJuQHvkQ0OvCGY5a7GuFt24FY54k=
X-Received: by 2002:a05:600c:64c7:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-4775ce611e2mr64715535e9.19.1762428575685; Thu, 06 Nov 2025
 03:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761234580.git.fdmanana@suse.com> <078852f3ef7b95046eeca1c13cfb1bfa34ccac90.1761234581.git.fdmanana@suse.com>
In-Reply-To: <078852f3ef7b95046eeca1c13cfb1bfa34ccac90.1761234581.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 6 Nov 2025 12:29:24 +0100
X-Gm-Features: AWmQ_bmVAaQg--_J8tk4YdZBQO6ca1EQDwh1_xdr24KE04skLKW9HEB7WDq57dg
Message-ID: <CAPjX3Fd=oPSpLhDXY=nSK1aMW2fNdBiQW44viwt0QziCpprU5A@mail.gmail.com>
Subject: Re: [PATCH 27/28] btrfs: avoid space_info locking when checking if
 tickets are served
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 18:02, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When checking if a ticket was served, we take the space_info's spinlock.
> If the ticket was served (its ->bytes is 0) or had an error (its ->error
> it not 0) then we just unlock the space_info and return.
>
> This however causes contention on the space_info's spinlock, which is
> heavily used (space reservation, space flushing, allocating and
> deallocating an extent from a block group (btrfs_update_block_group()),
> etc).
>
> Instead of using the space_info's spinlock to check if a ticket was
> served, use a per ticket spinlock which isn't used by anyone other than
> the task that created the ticket (stack allocated) and the task that
> serves the ticket (a reclaim task or any task deallocating space that
> ends up at btrfs_try_granting_tickets()).
>
> After applying this patch and all previous patches from the same patchset
> (many attempt to reduce space_info critical sections), lockstat showed
> some improvements for a fs_mark test regarding the space_info's spinlock
> 'lock'. The lockstat results:
>
> Before patchset:
>
>   con-bounces:     13733858
>   contentions:     15902322
>   waittime-total:  264902529.72
>   acq-bounces:     28161791
>   acquisitions:    38679282
>
> After patchset:
>
>   con-bounces:     12032220
>   contentions:     13598034
>   waittime-total:  221806127.28
>   acq-bounces:     24717947
>   acquisitions:    34103281
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/space-info.c | 56 +++++++++++++++++++++++++------------------
>  fs/btrfs/space-info.h |  1 +
>  2 files changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 86cd87c5884a..cce53a452fd3 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -517,18 +517,22 @@ bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
>  static void remove_ticket(struct btrfs_space_info *space_info,
>                           struct reserve_ticket *ticket, int error)
>  {
> +       lockdep_assert_held(&space_info->lock);
> +
>         if (!list_empty(&ticket->list)) {
>                 list_del_init(&ticket->list);
>                 ASSERT(space_info->reclaim_size >= ticket->bytes);
>                 space_info->reclaim_size -= ticket->bytes;
>         }
>
> +       spin_lock(&ticket->lock);
>         if (error)
>                 ticket->error = error;
>         else
>                 ticket->bytes = 0;
>
>         wake_up(&ticket->wait);
> +       spin_unlock(&ticket->lock);
>  }
>
>  /*
> @@ -1495,6 +1499,17 @@ static const enum btrfs_flush_state evict_flush_states[] = {
>         RESET_ZONES,
>  };
>
> +static bool is_ticket_served(struct reserve_ticket *ticket)
> +{
> +       bool ret;
> +
> +       spin_lock(&ticket->lock);
> +       ret = (ticket->bytes == 0);
> +       spin_unlock(&ticket->lock);
> +
> +       return ret;
> +}
> +
>  static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
>                                             struct reserve_ticket *ticket,
>                                             const enum btrfs_flush_state *states,
> @@ -1504,29 +1519,25 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
>         u64 to_reclaim;
>         int flush_state = 0;
>
> -       spin_lock(&space_info->lock);
>         /*
>          * This is the priority reclaim path, so to_reclaim could be >0 still
>          * because we may have only satisfied the priority tickets and still
>          * left non priority tickets on the list.  We would then have
>          * to_reclaim but ->bytes == 0.
>          */
> -       if (ticket->bytes == 0) {
> -               spin_unlock(&space_info->lock);
> +       if (is_ticket_served(ticket))
>                 return;
> -       }
>
> +       spin_lock(&space_info->lock);
>         to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
>
>         while (flush_state < states_nr) {
>                 spin_unlock(&space_info->lock);
>                 flush_space(space_info, to_reclaim, states[flush_state], false);
> +               if (is_ticket_served(ticket))
> +                       return;
>                 flush_state++;
>                 spin_lock(&space_info->lock);
> -               if (ticket->bytes == 0) {
> -                       spin_unlock(&space_info->lock);
> -                       return;
> -               }
>         }

The space_info->lock should be unlocked before the loop and grabbed
again only after it. There's no need to take that lock inside with
your change.

--nX

>
>         /*
> @@ -1554,22 +1565,17 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
>  static void priority_reclaim_data_space(struct btrfs_space_info *space_info,
>                                         struct reserve_ticket *ticket)
>  {
> -       spin_lock(&space_info->lock);
> -
>         /* We could have been granted before we got here. */
> -       if (ticket->bytes == 0) {
> -               spin_unlock(&space_info->lock);
> +       if (is_ticket_served(ticket))
>                 return;
> -       }
>
> +       spin_lock(&space_info->lock);
>         while (!space_info->full) {
>                 spin_unlock(&space_info->lock);
>                 flush_space(space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
> -               spin_lock(&space_info->lock);
> -               if (ticket->bytes == 0) {
> -                       spin_unlock(&space_info->lock);
> +               if (is_ticket_served(ticket))
>                         return;
> -               }
> +               spin_lock(&space_info->lock);
>         }
>
>         remove_ticket(space_info, ticket, -ENOSPC);
> @@ -1582,11 +1588,13 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
>
>  {
>         DEFINE_WAIT(wait);
> -       int ret = 0;
>
> -       spin_lock(&space_info->lock);
> +       spin_lock(&ticket->lock);
>         while (ticket->bytes > 0 && ticket->error == 0) {
> +               int ret;
> +
>                 ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
> +               spin_unlock(&ticket->lock);
>                 if (ret) {
>                         /*
>                          * Delete us from the list. After we unlock the space
> @@ -1596,17 +1604,18 @@ static void wait_reserve_ticket(struct btrfs_space_info *space_info,
>                          * despite getting an error, resulting in a space leak
>                          * (bytes_may_use counter of our space_info).
>                          */
> +                       spin_lock(&space_info->lock);
>                         remove_ticket(space_info, ticket, -EINTR);
> -                       break;
> +                       spin_unlock(&space_info->lock);
> +                       return;
>                 }
> -               spin_unlock(&space_info->lock);
>
>                 schedule();
>
>                 finish_wait(&ticket->wait, &wait);
> -               spin_lock(&space_info->lock);
> +               spin_lock(&ticket->lock);
>         }
> -       spin_unlock(&space_info->lock);
> +       spin_unlock(&ticket->lock);
>  }
>
>  /*
> @@ -1804,6 +1813,7 @@ static int reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
>                 ticket.error = 0;
>                 space_info->reclaim_size += ticket.bytes;
>                 init_waitqueue_head(&ticket.wait);
> +               spin_lock_init(&ticket.lock);
>                 ticket.steal = can_steal(flush);
>                 if (trace_btrfs_reserve_ticket_enabled())
>                         start_ns = ktime_get_ns();
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 7e16d4c116c8..a4c2a3c8b388 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -230,6 +230,7 @@ struct reserve_ticket {
>         bool steal;
>         struct list_head list;
>         wait_queue_head_t wait;
> +       spinlock_t lock;
>  };
>
>  static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
> --
> 2.47.2
>
>

