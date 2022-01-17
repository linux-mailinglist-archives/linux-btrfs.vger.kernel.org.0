Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD043490FF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiAQR4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 12:56:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59226 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiAQR4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 12:56:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A174760F74
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 17:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C06C36AE7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642442204;
        bh=1AoSFzT/S2DBUgbEb0eN7vmzzOjr3RQc1bW8Js2FyVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GWwyTnot8FedQD+2yR77wBbAjFcdYPPEYuQJ1HVP9EawIGW2PRCi0x5DwAg65W8bS
         nkTorQSM7ALtevIe9mKFkMNK6th83J4ZORzYGXjyFYlwrdI/c4mo4Q4GkkWN7kisDk
         gxuvI5EKcuMyeHPT3u/h1bP1Z8hQ2r5EPaj0PKEWT3L1Td26ZAxH72J1DXbck5iPIw
         E+kkTlBzEKrODm2QhrqUnal7UqcN4OAdJwK0u2iWau8OPC9aIPGwi+fsTToFS0X2JR
         hUq8X8kT2jxTPL8f8LQ3IPLT8k6ul9gdQlnk2Ky9wr4GRR0057LP2f9BnePn6pTmzU
         ZE8n3yFTcQklA==
Received: by mail-qt1-f174.google.com with SMTP id h15so15546351qtx.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 09:56:44 -0800 (PST)
X-Gm-Message-State: AOAM5300FMUt5EsJMatsaEptp2XHadaM0Ac0NIMD6GilBezB126OIb4H
        2qB9jKUyI6Q//1CxvZXHugqt0HYzZN9EYAIm2gk=
X-Google-Smtp-Source: ABdhPJwXCpD4LrU4pU3kpK/mBY+fOz9FGDWSdy6CpN58XBPE/jRCbPZI8/lJid6iKXCxDyAbvyIspmAMwU/ov3iA3i0=
X-Received: by 2002:a05:622a:356:: with SMTP id r22mr7791781qtw.51.1642442202896;
 Mon, 17 Jan 2022 09:56:42 -0800 (PST)
MIME-Version: 1.0
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
 <YeVc0r7lLtns0Bch@debian9.Home> <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
 <YeWetp7/1q/4bU1O@debian9.Home> <254c8e30-6692-3f3c-59ea-e3456ca9a266@mailbox.org>
 <6c1b26b8-3af0-83e9-6260-33394ee8d883@mailbox.org>
In-Reply-To: <6c1b26b8-3af0-83e9-6260-33394ee8d883@mailbox.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 17 Jan 2022 17:56:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5UhQCnsGd25Jd=x5rfhgPkzdDPpO_4iLdj73qSeFUzKg@mail.gmail.com>
Message-ID: <CAL3q7H5UhQCnsGd25Jd=x5rfhgPkzdDPpO_4iLdj73qSeFUzKg@mail.gmail.com>
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
To:     Anthony Ruhier <aruhier@mailbox.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 5:50 PM Anthony Ruhier <aruhier@mailbox.org> wrote:
>
> Filipe,
>
> Just a quick update after my previous email, your patch fixed the issue
> for `btrfs fi defrag`.
> Thanks a lot! I closed my bug on bugzilla.
>
> I'll keep you in touch about the autodefrag.

Please do.
The 1 byte file case was very specific, so it's probably a different issue.

Thanks for testing!

>
> Le 17/01/2022 =C3=A0 18:04, Anthony Ruhier a =C3=A9crit :
> > I'm going to apply your patch for the 1B file, and quickly confirm if
> > it works.
> > Thanks a lot for your patch!
> >
> > About the autodefrag issue, it's going to be trickier to check that
> > your patch fixes it, because for whatever reason the problem seems to
> > have resolved itself (or at least, btrfs-cleaner does way less writes)
> > after a partial btrfs balance.
> > I'll try and look the amount of writes after several hours. Maybe for
> > this one, see with the author of the other bug. If they can easily
> > reproduce the issue then it's going to be easier to check.
> >
> > Thanks,
> > Anthony
> >
> > Le 17/01/2022 =C3=A0 17:52, Filipe Manana a =C3=A9crit :
> >> On Mon, Jan 17, 2022 at 03:24:00PM +0100, Anthony Ruhier wrote:
> >>> Thanks for the answer.
> >>>
> >>> I had the exact same issue as in the thread you've linked, and have
> >>> some
> >>> monitoring and graphs that showed that btrfs-cleaner did constant
> >>> writes
> >>> during 12 hours just after I upgraded to linux 5.16. Weirdly enough,
> >>> the
> >>> issue almost disappeared after I did a btrfs balance by filtering on
> >>> 10%
> >>> usage of data.
> >>> But that's why I initially disabled autodefrag, what has lead to
> >>> discovering
> >>> this bug as I switched to manual defragmentation (which, in the end,
> >>> makes
> >>> more sense anyway with my setup).
> >>>
> >>> I tried this patch, but sadly it doesn't help for the initial issue. =
I
> >>> cannot say for the bug in the other thread, as the problem with
> >>> btrfs-cleaner disappeared (I can still see some writes from it, but
> >>> it so
> >>> rare that I cannot say if it's normal or not).
> >> Ok, reading better your first mail, I see there's the case of the 1 by=
te
> >> file, which is possibly not the cause from the autodefrag causing the
> >> excessive IO problem.
> >>
> >> For the 1 byte file problem, I've just sent a fix:
> >>
> >> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bb=
fed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> >>
> >>
> >> It's actually trivial to trigger.
> >>
> >> Can you check if it also fixes your problem with autodefrag?
> >>
> >> If not, then try the following (after applying the 1 file fix):
> >>
> >> https://pastebin.com/raw/EbEfk1tF
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index a5bd6926f7ff..db795e226cca 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -1191,6 +1191,7 @@ static int defrag_collect_targets(struct
> >> btrfs_inode *inode,
> >>                     u64 newer_than, bool do_compress,
> >>                     bool locked, struct list_head *target_list)
> >>   {
> >> +    const u32 min_thresh =3D extent_thresh / 2;
> >>       u64 cur =3D start;
> >>       int ret =3D 0;
> >>   @@ -1198,6 +1199,7 @@ static int defrag_collect_targets(struct
> >> btrfs_inode *inode,
> >>           struct extent_map *em;
> >>           struct defrag_target_range *new;
> >>           bool next_mergeable =3D true;
> >> +        u64 range_start;
> >>           u64 range_len;
> >>             em =3D defrag_lookup_extent(&inode->vfs_inode, cur, locked=
);
> >> @@ -1213,6 +1215,24 @@ static int defrag_collect_targets(struct
> >> btrfs_inode *inode,
> >>           if (em->generation < newer_than)
> >>               goto next;
> >>   +        /*
> >> +         * Our start offset might be in the middle of an existing
> >> extent
> >> +         * map, so take that into account.
> >> +         */
> >> +        range_len =3D em->len - (cur - em->start);
> >> +
> >> +        /*
> >> +         * If there's already a good range for delalloc within the
> >> range
> >> +         * covered by the extent map, skip it, otherwise we can end u=
p
> >> +         * doing on the same IO range for a long time when using auto
> >> +         * defrag.
> >> +         */
> >> +        range_start =3D cur;
> >> +        if (count_range_bits(&inode->io_tree, &range_start,
> >> +                     range_start + range_len - 1, min_thresh,
> >> +                     EXTENT_DELALLOC, 1) >=3D min_thresh)
> >> +            goto next;
> >> +
> >>           /*
> >>            * For do_compress case, we want to compress all valid file
> >>            * extents, thus no @extent_thresh or mergeable check.
> >> @@ -1220,8 +1240,8 @@ static int defrag_collect_targets(struct
> >> btrfs_inode *inode,
> >>           if (do_compress)
> >>               goto add;
> >>   -        /* Skip too large extent */
> >> -        if (em->len >=3D extent_thresh)
> >> +        /* Skip large enough ranges. */
> >> +        if (range_len >=3D extent_thresh)
> >>               goto next;
> >>             next_mergeable =3D
> >> defrag_check_next_extent(&inode->vfs_inode, em,
> >>
> >>
> >> Thanks.
> >>
> >>
> >>> Thanks,
> >>> Anthony
> >>>
> >>> Le 17/01/2022 =C3=A0 13:10, Filipe Manana a =C3=A9crit :
> >>>> On Sun, Jan 16, 2022 at 08:15:37PM +0100, Anthony Ruhier wrote:
> >>>>> Hi,
> >>>>> Since I upgraded from linux 5.15 to 5.16, `btrfs filesystem defrag
> >>>>> -t128K`
> >>>>> hangs on small files (~1 byte) and triggers what it seems to be a
> >>>>> loop in
> >>>>> the kernel. It results in one CPU thread running being used at
> >>>>> 100%. I
> >>>>> cannot kill the process, and rebooting is blocked by btrfs.
> >>>>> It is a copy of the
> >>>>> bughttps://bugzilla.kernel.org/show_bug.cgi?id=3D215498
> >>>>>
> >>>>> Rebooting to linux 5.15 shows no issue. I have no issue to run a
> >>>>> defrag on
> >>>>> bigger files (I filter out files smaller than 3.9KB).
> >>>>>
> >>>>> I had a conversation on #btrfs on IRC, so here's what we debugged:
> >>>>>
> >>>>> I can replicate the issue by copying a file impacted by this bug,
> >>>>> by using
> >>>>> `cp --reflink=3Dnever`. I attached one of the impacted files to thi=
s
> >>>>> bug,
> >>>>> named README.md.
> >>>>>
> >>>>> Someone told me that it could be a bug due to the inline extent.
> >>>>> So we tried
> >>>>> to check that.
> >>>>>
> >>>>> filefrag shows that the file Readme.md is 1 inline extent. I tried
> >>>>> to create
> >>>>> a new file with random text, of 18 bytes (slightly bigger than the
> >>>>> other
> >>>>> file), that is also 1 inline extent. This file doesn't trigger the
> >>>>> bug and
> >>>>> has no issue to be defragmented.
> >>>>>
> >>>>> I tried to mount my system with `max_inline=3D0`, created a copy of
> >>>>> README.md.
> >>>>> `filefrag` shows me that the new file is now 1 extent, not inline.
> >>>>> This new
> >>>>> file also triggers the bug, so it doesn't seem to be due to the
> >>>>> inline
> >>>>> extent.
> >>>>>
> >>>>> Someone asked me to provide the output of a perf top when the
> >>>>> defrag is
> >>>>> stuck:
> >>>>>
> >>>>>       28.70%  [kernel]          [k] generic_bin_search
> >>>>>       14.90%  [kernel]          [k] free_extent_buffer
> >>>>>       13.17%  [kernel]          [k] btrfs_search_slot
> >>>>>       12.63%  [kernel]          [k] btrfs_root_node
> >>>>>        8.33%  [kernel]          [k] btrfs_get_64
> >>>>>        3.88%  [kernel]          [k] __down_read_common.llvm
> >>>>>        3.00%  [kernel]          [k] up_read
> >>>>>        2.63%  [kernel]          [k] read_block_for_search
> >>>>>        2.40%  [kernel]          [k] read_extent_buffer
> >>>>>        1.38%  [kernel]          [k] memset_erms
> >>>>>        1.11%  [kernel]          [k] find_extent_buffer
> >>>>>        0.69%  [kernel]          [k] kmem_cache_free
> >>>>>        0.69%  [kernel]          [k] memcpy_erms
> >>>>>        0.57%  [kernel]          [k] kmem_cache_alloc
> >>>>>        0.45%  [kernel]          [k] radix_tree_lookup
> >>>>>
> >>>>> I can reproduce the bug on 2 different machines, running 2
> >>>>> different linux
> >>>>> distributions (Arch and Gentoo) with 2 different kernel configs.
> >>>>> This kernel is compiled with clang, the other with GCC.
> >>>>>
> >>>>> Kernel version: 5.16.0
> >>>>> Mount options:
> >>>>>       Machine 1:
> >>>>> rw,noatime,compress-force=3Dzstd:2,ssd,discard=3Dasync,space_cache=
=3Dv2,autodefrag
> >>>>>
> >>>>>       Machine 2:
> >>>>> rw,noatime,compress-force=3Dzstd:3,nossd,space_cache=3Dv2
> >>>>>
> >>>>> When the error happens, no message is shown in dmesg.
> >>>> This is very likely the same issue as reported at this thread:
> >>>>
> >>>> https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home/T/=
#ma1c8a9848c9b7e4edb471f7be184599d38e288bb
> >>>>
> >>>>
> >>>> Are you able to test the patch posted there?
> >>>>
> >>>> Thanks.
> >>>>
> >>>>> Thanks,
> >>>>> Anthony Ruhier
> >>>>>
> >>
> >>
> >>
> >>
