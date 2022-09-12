Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408285B5896
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiILKnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILKnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 06:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B2BF66
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3A361187
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 10:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394D9C433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662979378;
        bh=PZKNjDuCW+MISEbNC38n6giO19IJiyiB6YPCzYy3quQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e7dTQ8GL7cHqcQnmjBDFVojYpoYd2dqMuG953xaCOeBNtGk5OxmNYV2WhbgwB6K9a
         M7ewpF3Co5Tey6roKWPLWV0m13d28mvUF0uAo0VaZOgk6uQRi5f7Trabpkn6m8mx+1
         XWJl3hH9Vyfd8wKPRUtiN1YWDHIKa9Swv74swUAVPvZh5zJOaNXwg/ql4qMhG9Yy9+
         3bsnuJGG7Zdg/O48PK1B2taYeIP8PtuZpVryuj1GNDME/Hi64EAyf4QC6ThR/tS/Qd
         4v1DyRR7iVg8GpTAVmGkRIpRk2GtTfrokyXz+9WAX3Id5T2oKWWKTX18atEBlwKuW2
         Ouw7HeENWYa0Q==
Received: by mail-ot1-f47.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so5538779oth.8
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:42:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo19txcamRn+bNWIFAOo2mDwlSd6Rflpg1tAiuF/iVUKBACg+qh3
        beeRfKviywG7mBAuyO1R/cyeFqjI6DXcaumo6es=
X-Google-Smtp-Source: AA6agR472xeC0ptW6JmKS6KGchVeyTr+NL/6FxOK883/cRI425xRmZIPMs3ivS+Y2owm4O075qzJclFbKyltMbUVL2w=
X-Received: by 2002:a05:6830:290b:b0:655:d52b:e3bd with SMTP id
 z11-20020a056830290b00b00655d52be3bdmr2858757otu.345.1662979377184; Mon, 12
 Sep 2022 03:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
 <20220912095907.GA269395@falcondesktop> <0a2ffcd7-148b-e64b-5c9c-dc901c968e10@gmx.com>
In-Reply-To: <0a2ffcd7-148b-e64b-5c9c-dc901c968e10@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Sep 2022 11:42:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4kq28Y5TK+jJ-OE7L3vSQej5iBgSfS62Xk=gySg-BXmg@mail.gmail.com>
Message-ID: <CAL3q7H4kq28Y5TK+jJ-OE7L3vSQej5iBgSfS62Xk=gySg-BXmg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 11:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/9/12 17:59, Filipe Manana wrote:
> > On Fri, Sep 09, 2022 at 09:35:01AM -0400, Josef Bacik wrote:
> >> Inside of FB, as well as some user reports, we've had a consistent
> >> problem of occasional ENOSPC transaction aborts.  Inside FB we were
> >> seeing ~100-200 ENOSPC aborts per day in the fleet, which is a really
> >> low occurrence rate given the size of our fleet, but it's not nothing.
> >>
> >> There are two causes of this particular problem.
> >>
> >> First is delayed allocation.  The reservation system for delalloc
> >> assumes that contiguous dirty ranges will result in 1 file extent item.
> >> However if there is memory pressure that results in fragmented writeout,
> >> or there is fragmentation in the block groups, this won't necessarily be
> >> true.  Consider the case where we do a single 256MiB write to a file and
> >> then close it.  We will have 1 reservation for the inode update, the
> >> reservations for the checksum updates, and 1 reservation for the file
> >> extent item.  At some point later we decide to write this entire range
> >> out, but we're so fragmented that we break this into 100 different file
> >> extents.  Since we've already closed the file and are no longer writing
> >> to it there's nothing to trigger a refill of the delalloc block rsv to
> >> satisfy the 99 new file extent reservations we need.  At this point we
> >> exhaust our delalloc reservation, and we begin to steal from the global
> >> reserve.  If you have enough of these cases going in parallel you can
> >> easily exhaust the global reserve, get an ENOSPC at
> >> btrfs_alloc_tree_block() time, and then abort the transaction.
> >
> > There's also another problem I pointed out in the past regarding delalloc
> > reservations. The thing is that we assume for each ordered extent, the new
> > file extent item will require changing only 1 leaf in the subvolume tree.
> >
> > If our new extent has a size of 128M and currently for that range we
> > have 32768 extents each with a size of 4K, then we need to touch 157
> > leaves in order to drop those file extent items before inserting the new
> > one at ordered extent completion. And our reservation that happened at
> > buffered write time only accounted for 1 leaf/path for file extent items
> > (plus 1 for the inode item). This is assuming the default leaf size of 16K,
> > where we can have at most 208 file extent items per leaf.
> >
> > If we have just a single ordered extent triggering this case we probably
> > won't reach -ENOSPC and a transaction abort, as we end up consuming from
> > the global reserve and that may be able to satisfy our space needs.
> > However with multiple ordered extents hitting such cases of insufficient
> > reserved space, and other tasks doing other things and consuming from the
> > global reserve, then the chances of hitting -ENOSPC at btrfs_finish_ordered_io()
> > become very high, leading to a transaction abort there.
>
> In fact, I'm also considering these problems, and for the highly
> fragmented free space case (and other cases like delayed refs generated
> delayed refs case), can we let btrfs itself to learn from last (several)
> delalloc (delayed refs) runs to generate an overall idea on how
> fragmented the free space is.

That won't help for the case I described, because it has nothing to do with
fragmentation.

There's also other case where more than 1 ordered extent is created, but
at reservation time we think it's only 1 ordered extent - compression,
it will split
into many 128K ordered extents. Again, this one has nothing do with
fragmentation.

>
> Then round (down) that value for write/dirty time delalloc reservation?
>
> The same can go to delayed refs reservation too.
>
> If by somehow, the delayed refs are generating more than expected
> delayed refs, we increase the pre-reserved space accordingly.
>
>
>
> Another less dynamic method (but still the same idea) is to introduce a
> doomsday mode.
>
> In that mode, every time we need to reserve space for delalloc, we
> consider the extent can only be at most 4K, double the pre-reserve for
> delayed refs etc.
>
> But I'm afraid this can only reduce, but not really eliminate the ENOSPC
> at critical path.
>
> >
> >>
> >> The other case is the delayed refs reserve.  The delayed refs reserve
> >> updates its size based on outstanding delayed refs and dirty block
> >> groups.  However we only refill this block reserve when returning
> >> excess reservations and when we call btrfs_start_transaction(root, X).
> >> We will reserve 2*X credits at transaction start time, and fill in X
> >> into the delayed refs reserve to make sure it stays topped off.
> >> Generally this works well, but clearly has downsides.  If we do a
> >> particularly delayed ref heavy operation we may never catch up in our
> >> reservations.  Additionally running delayed refs generates more delayed
> >> refs, and at that point we may be committing the transaction and have no
> >> way to trigger a refill of our delayed refs rsv.  Then a similar thing
> >> occurs with the delalloc reserve.
> >>
> >> Generally speaking we well over-reserve in all of our block rsvs.  If we
> >> reserve 1 credit we're usually reserving around 264k of space, but we'll
> >> often not use any of that reservation, or use a few blocks of that
> >> reservation.  We can be reasonably sure that as long as you were able to
> >> reserve space up front for your operation you'll be able to find space
> >> on disk for that reservation.
> >
> > That's another elephant in the room. We assume that if a task reserves
> > space, it will be able to allocate that space later.
> >
> > There are several things that can happen which will result in not being
> > able to allocate space we reserved before:
> >
> > 1) Discard/fitrim - it removes a free space entry, does the discard, and
> >     after that it adds back the free space entry. If all the available space
> >     is in such an entry being discarded, the task fails to allocate space;
> >
> > 2) fsync - it joins a transaction, doesn't reserve space and starts allocating
> >     space for tree blocks, without ever reserving space (because we want it
> >     to be fast and for most cases we don't know in advance, or can estimate,
> >     how many tree blocks we will need to allocate). So it can steal space that
> >     was reserved by some other task;
> >
> > 3) Scrub - scrub temporarily turns a block group into RO mode - if all the
> >     available space was in that block group, than when the task tries to
> >     allocate it will fail because the block group is now RO;
>
> Yes, that's one concern of the existing per-dev scrub.
> If we have 10 devices, all single profiles, then we may mark 10 block
> groups RO at once, hugely increase the chance of ENOSPC.
>
> >
> > 4) During space reservation we only check if free space counters. There
> >     may be block groups with plenty of free space but their profile is not
> >     compatible, so when trying to allocate an extent we are forced to allocate
> >     a new block group with the necessary profile, which will fail if there's
> >     not enough unallocated space.
> >     This mostly affects degraded mode only (hopefully).
>
> This is still pretty common, for RAID1 usage especially one device is
> just slightly (like 10MiB) larger than the other.
>
> The metadata over-reserve still believe we can allocate new metadata bg,
> but nope, and hit a ENOSPC at critical path.
>
> IIRC I had some very old patches for the problem, but haven't updated
> for a long time.
>
> Thanks,
> Qu
>
> >
> > I documented these at btrfs_chunk_alloc() sometime ago, but there are a few
> > more similar cases.
> >
> >>
> >> So introduce a new flushing state, BTRFS_RESERVE_FLUSH_EMERGENCY.  This
> >> gets used in the case that we've exhausted our reserve and the global
> >> reserve.  It simply forces a reservation if we have enough actual space
> >> on disk to make the reservation, which is almost always the case.  This
> >> keeps us from hitting ENOSPC aborts in these odd occurrences where we've
> >> not kept up with the delayed work.
> >>
> >> Fixing this in a complete way is going to be relatively complicated and
> >> time consuming.  This patch is what I discussed with Filipe earlier this
> >> year, and what I put into our kernels inside FB.  With this patch we're
> >> down to 1-2 ENOSPC aborts per week, which is a significant reduction.
> >> This is a decent stop gap until we can work out a more wholistic
> >> solution to these two corner cases.
> >
> > Well, it's a lot more than 2 corner cases :)
> >
> > The change looks fine to me, it's simple and it should help reduce the
> > frequency of several ENOSPC cases. So,
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/block-rsv.c  | 12 ++++++++++++
> >>   fs/btrfs/ctree.h      | 18 ++++++++++++++++++
> >>   fs/btrfs/space-info.c | 27 ++++++++++++++++++++++++++-
> >>   3 files changed, 56 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> >> index ec96285357e0..89e3e7d1bff6 100644
> >> --- a/fs/btrfs/block-rsv.c
> >> +++ b/fs/btrfs/block-rsv.c
> >> @@ -552,5 +552,17 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
> >>              if (!ret)
> >>                      return global_rsv;
> >>      }
> >> +
> >> +    /*
> >> +     * All hope is lost, but of course our reservations are overly
> >> +     * pessimistic, so instead of possibly having an ENOSPC abort here, try
> >> +     * one last time to force a reservation if there's enough actual space
> >> +     * on disk to make the reservation.
> >> +     */
> >> +    ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
> >> +                                       BTRFS_RESERVE_FLUSH_EMERGENCY);
> >> +    if (!ret)
> >> +            return block_rsv;
> >> +
> >>      return ERR_PTR(ret);
> >>   }
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index 0108585d838d..f221b3cb718d 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -2986,6 +2986,24 @@ enum btrfs_reserve_flush_enum {
> >>       * Can be interrupted by a fatal signal.
> >>       */
> >>      BTRFS_RESERVE_FLUSH_ALL_STEAL,
> >> +
> >> +    /*
> >> +     * This is for btrfs_use_block_rsv only.  We have exhausted our block
> >> +     * rsv and our global block rsv.  This can happen for things like
> >> +     * delalloc where we are overwriting a lot of extents with a single
> >> +     * extent and didn't reserve enough space.  Alternatively it can happen
> >> +     * with delalloc where we reserve 1 extents worth for a large extent but
> >> +     * fragmentation leads to multiple extents being created.  This will
> >> +     * give us the reservation in the case of
> >> +     *
> >> +     * if (num_bytes < (space_info->total_bytes -
> >> +     *                  btrfs_space_info_used(space_info, false))
> >> +     *
> >> +     * Which ignores bytes_may_use.  This is potentially dangerous, but our
> >> +     * reservation system is generally pessimistic so is able to absorb this
> >> +     * style of mistake.
> >> +     */
> >> +    BTRFS_RESERVE_FLUSH_EMERGENCY,
> >>   };
> >>
> >>   enum btrfs_flush_state {
> >> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> >> index 2e06b7c422c7..a0abc6dd01c2 100644
> >> --- a/fs/btrfs/space-info.c
> >> +++ b/fs/btrfs/space-info.c
> >> @@ -1583,6 +1583,16 @@ static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
> >>              flush == BTRFS_RESERVE_FLUSH_EVICT);
> >>   }
> >>
> >> +/*
> >> + * NO_FLUSH and FLUSH_EMERGENCY don't want to create a ticket, they just want to
> >> + * fail as quickly as possible.
> >> + */
> >> +static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
> >> +{
> >> +    return (flush != BTRFS_RESERVE_NO_FLUSH &&
> >> +            flush != BTRFS_RESERVE_FLUSH_EMERGENCY);
> >> +}
> >> +
> >>   /**
> >>    * Try to reserve bytes from the block_rsv's space
> >>    *
> >> @@ -1644,6 +1654,21 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
> >>              ret = 0;
> >>      }
> >>
> >> +    /*
> >> +     * Things are dire, we need to make a reservation so we don't abort.  We
> >> +     * will let this reservation go through as long as we have actual space
> >> +     * left to allocate for the block.
> >> +     */
> >> +    if (ret && unlikely(flush == BTRFS_RESERVE_FLUSH_EMERGENCY)) {
> >
> > Does the unlikely() really makes any difference in this context?
> >
> >> +            used = btrfs_space_info_used(space_info, false);
> >> +            if (used + orig_bytes <=
> >> +                writable_total_bytes(fs_info, space_info)) {
> >> +                    btrfs_space_info_update_bytes_may_use(fs_info, space_info,
> >> +                                                          orig_bytes);
> >> +                    ret = 0;
> >> +            }
> >> +    }
> >> +
> >>      /*
> >>       * If we couldn't make a reservation then setup our reservation ticket
> >>       * and kick the async worker if it's not already running.
> >> @@ -1651,7 +1676,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
> >>       * If we are a priority flusher then we just need to add our ticket to
> >>       * the list and we will do our own flushing further down.
> >>       */
> >> -    if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
> >> +    if (ret && can_ticket(flush)) {
> >>              ticket.bytes = orig_bytes;
> >>              ticket.error = 0;
> >>              space_info->reclaim_size += ticket.bytes;
> >> --
> >> 2.26.3
> >>
