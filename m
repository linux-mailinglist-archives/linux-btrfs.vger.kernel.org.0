Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1131160E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBEWtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 17:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhBEMzS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 07:55:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 439D964FCB
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Feb 2021 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612529670;
        bh=JSaWFgrgpVZIlon8Cowoldf2rvQ5oFHXbEW7YgI5DSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t+RldXRazMwSdh9l08SYI/uCOSXBT7SwpiCM7QNKFNcK+4dawueisnIDD/ATt45Bi
         CIukRCYPv/GXjpcLjSZ66yCGGEbf8rV2dPEZ4vdych4MypN8rOCTMYxuLgLiLeVt5A
         pNBJmBZeV0NwkDq1umg46YEvj5a3JAUudpvzpenY3BJNWQ6HiMTgvHARMjbbultCQ6
         Yaowms7zy1qlkFy2ID+0vX2eBSwTTcZC0nA3W5opJSzmrRaciq8rfKZ+lK9thFHjeV
         2QwfH2ULYX+POqgL7arEgSRhP67Ix980JmCLi9mmSls67xEIi+N1pmV48U7L5Jn4OP
         qYfufW+xLjSKQ==
Received: by mail-qk1-f180.google.com with SMTP id x81so6732834qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Feb 2021 04:54:30 -0800 (PST)
X-Gm-Message-State: AOAM530NLVrRCLv2zztIlknIIsOPFJbHS9PmkdoJIkIF8d1wTocMbjup
        ytOUWHAHZnZ0Suhbs+0JY3op8cw6cvY7NLURpgU=
X-Google-Smtp-Source: ABdhPJyKAy7ugbxZgeFy9ITdaY/ebic6izlrmONRxnk1Q6Em4NLD5TbNfxRhXy7Qj/w5RuZUp4PatBNRJYJfJETGsxQ=
X-Received: by 2002:a05:620a:64d:: with SMTP id a13mr4156825qka.383.1612529669226;
 Fri, 05 Feb 2021 04:54:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612350698.git.fdmanana@suse.com> <0da379a02fdabaf9ca295a34f7de287b5d5465f7.1612350698.git.fdmanana@suse.com>
 <169460c5-8e7b-2d0a-119f-87ef403e070f@oracle.com> <CAL3q7H5OOyZHja4hG8cmMOjcsOQSUKvMms9kZHG28i4GqNkOjA@mail.gmail.com>
 <d563cfa9-5cf2-b408-0a7f-cdb597ebc9cc@oracle.com>
In-Reply-To: <d563cfa9-5cf2-b408-0a7f-cdb597ebc9cc@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 5 Feb 2021 12:54:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4KOLoaZQkf8qY7s8KU7SPWhhGfFDgOq2hgcZP9Ykte0g@mail.gmail.com>
Message-ID: <CAL3q7H4KOLoaZQkf8qY7s8KU7SPWhhGfFDgOq2hgcZP9Ykte0g@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: fix race between writes to swap files and scrub
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 5, 2021 at 7:44 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 2/4/2021 6:11 PM, Filipe Manana wrote:
> > On Thu, Feb 4, 2021 at 8:48 AM Anand Jain <anand.jain@oracle.com> wrote:
> >>
> >> On 2/3/2021 7:17 PM, fdmanana@kernel.org wrote:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> When we active a swap file, at btrfs_swap_activate(), we acquire the
> >>> exclusive operation lock to prevent the physical location of the swap
> >>> file extents to be changed by operations such as balance and device
> >>> replace/resize/remove. We also call there can_nocow_extent() which,
> >>> among other things, checks if the block group of a swap file extent is
> >>> currently RO, and if it is we can not use the extent, since a write
> >>> into it would result in COWing the extent.
> >>>
> >>> However we have no protection against a scrub operation running after we
> >>> activate the swap file, which can result in the swap file extents to be
> >>> COWed while the scrub is running and operating on the respective block
> >>> group, because scrub turns a block group into RO before it processes it
> >>> and then back again to RW mode after processing it. That means an attempt
> >>> to write into a swap file extent while scrub is processing the respective
> >>> block group, will result in COWing the extent, changing its physical
> >>> location on disk.
> >>>
> >>> Fix this by making sure that block groups that have extents that are used
> >>> by active swap files can not be turned into RO mode, therefore making it
> >>> not possible for a scrub to turn them into RO mode.
> >>
> >>> When a scrub finds a
> >>> block group that can not be turned to RO due to the existence of extents
> >>> used by swap files, it proceeds to the next block group and logs a warning
> >>> message that mentions the block group was skipped due to active swap
> >>> files - this is the same approach we currently use for balance.
> >>
> >>    It is better if this info is documented in the scrub man-page. IMO.
> >>
> >>> This ends up removing the need to call btrfs_extent_readonly() from
> >>> can_nocow_extent(), as btrfs_swap_activate() now checks if a block group
> >>> is RO through the new function btrfs_inc_block_group_swap_extents().
> >>>
>
>
> >>> The only other caller of can_nocow_extent() is the direct IO write path,
>
> There is a third caller. check_can_nocow() also calls
> can_nocow_extent(), which I missed before. Any idea where does it get to
> know that extent is RO in the threads using check_can_nocow()? I have to
> back out the RB for this reason for now.

Yes, that one I missed. However it's arguable how useful it is, because starting
nocow writers and changing a block group from RW to RO is not atomic,
and therefore
sometimes it will have no effect, see below.

I'll leave that part out and deal with the direct IO write path
optimization later perhaps,
as things are a bit entangled and not simple to distinguish whether we
are in the
direct IO path or not at can_nocow_extent().

>
>
> >>> btrfs_get_blocks_direct_write(), but that already checks if a block group
> >>> is RO through the call to btrfs_inc_nocow_writers().
>
> >>> In fact, after this
> >>> change we end up optimizing the direct IO write path, since we no longer
> >>> iterate the block groups rbtree twice, once with btrfs_extent_readonly(),
> >>> through can_nocow_extent(), and once again with btrfs_inc_nocow_writers().
> >>> This can save time and reduce contention on the lock that protects the
> >>> rbtree (specially because it is a spinlock and not a read/write lock) on
> >>> very large filesystems, with several thousands of allocated block groups.
> >>>
> >>> Fixes: ed46ff3d42378 ("Btrfs: support swap files")
> >>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >>
> >>    I am not sure about the optimization of direct IO part, but as such
> >>    changes looks good.
>
> Clarifying about the optimization part (for both buffered and direct IO)
> - After patch 1, and patch 2, now we check on the RO extents after the
> functions btrfs_cross_ref_exist(), and csum_exist_in_range(), both of
> them have search_slot, whereas, before patch 1, and patch 2, we used to
> fail early (if the extent is RO) and avoided the search_slot, so I am
> not sure if there is optimization.

And?
Doing a single search is faster than doing 2 searches.
It does not matter to check if a block group is RO before or after
those checks, because:

1) Having a block group RO is a rather exceptional situation and, when
it happens (scrub and balance), it's
temporary. We optimize for common cases, we don't gain anything by
checking for it twice.
Your concern goes the other way around, you want to do the RO check
first to fallback more quickly into
cow mode - optimizing for the exceptional and uncommon case. I could
move up the call to
btrfs_inc_block_group_swap_extents(), to take the place of the call to
btrfs_inc_block_group_swap_extents(),
but really that is pointless since RO block groups are exceptional and
temporary, and would make the code
more complex than needed (having to track which gotos require
decrementing the nocow writers).

2) More importantly, and this is what really matters, have you thought
about what happens
if the block group is turned RO right after we checked that it was RW?
Either after calling
btrfs_extent_readonly() and before calling btrfs_inc_nocow_writers(),
or after calling both.
Should we have additional checks to see if the block group is now RO
after each one of those calls?

In case you didn't notice, starting a nocow write and setting a block
group RO is not atomic,
and that is fine (it's actually much simpler than making it atomic).
Because scrub and balance,
after turning a block group to RO mode, wait for any existing nocow
writes to complete before
they do anything with the block group's extents - new writes are
guaranteed to not allocate from
the block group or write to its existing extents because the block
group is RO now.

I hope this clarifies why having the RO block group check earlier or
later is irrelevant.

Thanks.

>
> Thanks, Anand
