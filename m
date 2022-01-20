Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A3494E70
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 13:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiATM4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 07:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiATM4h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 07:56:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81993C06173F
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 04:56:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F5CEB81D74
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 12:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AB0C340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642683393;
        bh=EYNBaj6iOO8GTAYa3WvuSblJaFCZmcm+Rc6EQyDEgEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D578I/Bh9ygTHVcwITi7Wslq4PfEYc4CeLj8p0C5a3pCxctisu3fg7H920NUmKaPI
         5dfV5FbIqgwNXCOEztmmjYoQrbHTlGopRaZkGuyyMOhI3KEJ9C+P+51AMWRxQ60cOu
         cLWYqDuf0OyG7wy/HvaIoQpQoCO0ByLclvJJftwR0vEzdIYsCT/fOI4OUdVYkwfgKo
         DIpF2Im192OToDooskrhhmefly0SnGe19vfaQq8DrykJxX4TrWD/5Dmss3Dns9ZQcP
         t0EWYFWcio7roxvqRotkGsKJiDK15FAm1pNDoPw7ZHRZs+NwH8Xej1TnhsJaLlQjYV
         Fg+uGJ4dnUicQ==
Received: by mail-qt1-f169.google.com with SMTP id 14so5696805qty.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 04:56:33 -0800 (PST)
X-Gm-Message-State: AOAM532UYFCLBZUbsYC7xDbMhXWd02pASTkk5P9hNlqGw+q154OPSFM2
        4h4AM4H/EP20tJQ3qN8XhVQaQ/0Dq9xr6l41BB8=
X-Google-Smtp-Source: ABdhPJwaKfdhUWOjqFvuZzU7itWVXlYqvTr5ga0yIUoGvpzeCJA5h+knQNAbEOz7R1AZMpkJe3T7OOx/3xxLXf6t9co=
X-Received: by 2002:ac8:5e0a:: with SMTP id h10mr25213687qtx.522.1642683392982;
 Thu, 20 Jan 2022 04:56:32 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com> <61cb3a50-3a19-ad21-be2e-edbf55eaa91d@gmx.com>
In-Reply-To: <61cb3a50-3a19-ad21-be2e-edbf55eaa91d@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 20 Jan 2022 12:55:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7r7ct_sMAYHcM3=N4gxipASj8QyA3j5ANhwOfOfgjA4Q@mail.gmail.com>
Message-ID: <CAL3q7H7r7ct_sMAYHcM3=N4gxipASj8QyA3j5ANhwOfOfgjA4Q@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 12:45 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/20 20:02, Fran=C3=A7ois-Xavier Thomas wrote:
> >> What if on top of those patches, you also add this one:
> >> https://pastebin.com/raw/EbEfk1tF
> >
> > That's exactly patch 2 in my stack of patches in fact, is that the corr=
ect link?
>
> Mind to share the full stack of patches or diffs?
>
> I'd say for the known autodefrag, the following seems to solve the
> problem for at least one reporter:
>
> - btrfs: fix too long loop when defragging a 1 byte file
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfed=
2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>
> - [v2] btrfs: defrag: fix the wrong number of defragged sectors
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.299=
91-1-wqu@suse.com/
>
> - btrfs: defrag: properly update range->start for autodefrag
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352.521=
26-1-wqu@suse.com/

That's the stack of patches I pointed out earlier in the thread...

>
> Thanks,
> Qu
>
> >
> > On Thu, Jan 20, 2022 at 12:45 PM Filipe Manana <fdmanana@kernel.org> wr=
ote:
> >>
> >> On Thu, Jan 20, 2022 at 11:37 AM Fran=C3=A7ois-Xavier Thomas
> >> <fx.thomas@gmail.com> wrote:
> >>>
> >>> Hi Felipe,
> >>>
> >>>> So, try with these two more patches on top of that:
> >>>
> >>> Thanks, I did just that, see graph with annotations:
> >>> https://i.imgur.com/pu66nz0.png
> >>>
> >>> No visible improvement, average baseline I/O (for roughly similar
> >>> workloads, the server I'm testing it on is not very busy I/O-wise) is
> >>> still 3-4x higher in 5.16 than in 5.15 with autodefrag enabled.
> >>
> >> What if on top of those patches, you also add this one:
> >>
> >> https://pastebin.com/raw/EbEfk1tF
> >>
> >> Can you see if it helps?
> >>
> >>>
> >>> The good news is that patch 2 did fix a large part of the issues 5.16=
.0 had.
> >>> I also checked that disabling autodefrag immediately brings I/O rate
> >>> back to how it was in 5.15.
> >>
> >> At least that!
> >> Thanks.
> >>
> >>>
> >>>>> Some people reported that 5.16.1 improved the situation for them, s=
o
> >>>> I don't see how that's possible, nothing was added to 5.16.1 that
> >>>> involves defrag.
> >>>> Might just be a coincidence.
> >>>
> >>> Yes, I found no evidence that official 5.16.1 is any better than the
> >>> rest on my side.
> >>>
> >>> Fran=C3=A7ois-Xavier
> >>>
> >>> On Wed, Jan 19, 2022 at 11:14 AM Filipe Manana <fdmanana@kernel.org> =
wrote:
> >>>>
> >>>> On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
> >>>> <fx.thomas@gmail.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> More details on graph[0]:
> >>>>> - First patch (1-byte file) on 5.16.0 did not have a significant im=
pact.
> >>>>> - Both patches on 5.16.0 did reduce a large part of the I/O but sti=
ll
> >>>>> have a high baseline I/O compared to 5.15
> >>>>
> >>>> So, try with these two more patches on top of that:
> >>>>
> >>>> https://patchwork.kernel.org/project/linux-btrfs/patch/2022011807190=
4.29991-1-wqu@suse.com/
> >>>>
> >>>> https://patchwork.kernel.org/project/linux-btrfs/patch/2022011811535=
2.52126-1-wqu@suse.com/
> >>>>
> >>>>>
> >>>>> Some people reported that 5.16.1 improved the situation for them, s=
o
> >>>>
> >>>> I don't see how that's possible, nothing was added to 5.16.1 that
> >>>> involves defrag.
> >>>> Might just be a coincidence.
> >>>>
> >>>> Thanks.
> >>>>
> >>>>> I'm testing that. It's too early to tell but for now the baseline I=
/O
> >>>>> still seems to be high compared to 5.15. Will update with more resu=
lts
> >>>>> tomorrow.
> >>>>>
> >>>>> Fran=C3=A7ois-Xavier
> >>>>>
> >>>>> [0] https://i.imgur.com/agzAKGc.png
> >>>>>
> >>>>> On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
> >>>>> <fx.thomas@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi Filipe,
> >>>>>>
> >>>>>> Thank you so much for the hints!
> >>>>>>
> >>>>>> I compiled 5.16 with the 1-byte file patch and have been running i=
t
> >>>>>> for a couple of hours now. I/O seems to have been gradually increa=
sing
> >>>>>> compared to 5.15, but I will wait for tomorrow to have a clearer v=
iew
> >>>>>> on the graphs, then I'll try the both patches.
> >>>>>>
> >>>>>> Fran=C3=A7ois-Xavier
> >>>>>>
> >>>>>> On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org=
> wrote:
> >>>>>>>
> >>>>>>> On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> >>>>>>>> On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier T=
homas wrote:
> >>>>>>>>> Hello all,
> >>>>>>>>>
> >>>>>>>>> Just in case someone is having the same issue: Btrfs (in the
> >>>>>>>>> btrfs-cleaner process) is taking a large amount of disk IO afte=
r
> >>>>>>>>> upgrading to 5.16 on one of my volumes, and multiple other peop=
le seem
> >>>>>>>>> to be having the same issue, see discussion in [0].
> >>>>>>>>>
> >>>>>>>>> [1] is a close-up screenshot of disk I/O history (blue line is =
write
> >>>>>>>>> ops, going from a baseline of some 10 ops/s to around 1k ops/s)=
. I
> >>>>>>>>> downgraded from 5.16 to 5.15 in the middle, which immediately r=
estored
> >>>>>>>>> previous performance.
> >>>>>>>>>
> >>>>>>>>> Common options between affected people are: ssd, autodefrag. No=
 error
> >>>>>>>>> in the logs, and no other issue aside from performance (the vol=
ume
> >>>>>>>>> works just fine for accessing data).
> >>>>>>>>>
> >>>>>>>>> One person reports that SMART stats show a massive amount of bl=
ocks
> >>>>>>>>> being written; unfortunately I do not have historical data for =
that so
> >>>>>>>>> I cannot confirm, but this sounds likely given what I see on wh=
at
> >>>>>>>>> should be a relatively new SSD.
> >>>>>>>>>
> >>>>>>>>> Any idea of what it could be related to?
> >>>>>>>>
> >>>>>>>> There was a big refactor of the defrag code that landed in 5.16.
> >>>>>>>>
> >>>>>>>> On a quick glance, when using autodefrag it seems we now can end=
 up in an
> >>>>>>>> infinite loop by marking the same range for degrag (IO) over and=
 over.
> >>>>>>>>
> >>>>>>>> Can you try the following patch? (also at https://pastebin.com/r=
aw/QR27Jv6n)
> >>>>>>>
> >>>>>>> Actually try this one instead:
> >>>>>>>
> >>>>>>> https://pastebin.com/raw/EbEfk1tF
> >>>>>>>
> >>>>>>> Also, there's a bug with defrag running into an (almost) infinite=
 loop when
> >>>>>>> attempting to defrag a 1 byte file. Someone ran into this and I'v=
e just sent
> >>>>>>> a fix for it:
> >>>>>>>
> >>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7=
e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> >>>>>>>
> >>>>>>> Maybe that is what you are running into when using autodefrag.
> >>>>>>> Firt try that fix for the 1 byte file case, and if after that you=
 still run
> >>>>>>> into problems, then try with the other patch above as well (both =
patches
> >>>>>>> applied).
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >>>>>>>> index a5bd6926f7ff..0a9f6125a566 100644
> >>>>>>>> --- a/fs/btrfs/ioctl.c
> >>>>>>>> +++ b/fs/btrfs/ioctl.c
> >>>>>>>> @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct =
btrfs_inode *inode,
> >>>>>>>>                  if (em->generation < newer_than)
> >>>>>>>>                          goto next;
> >>>>>>>>
> >>>>>>>> +               /*
> >>>>>>>> +                * Skip extents already under IO, otherwise we c=
an end up in an
> >>>>>>>> +                * infinite loop when using auto defrag.
> >>>>>>>> +                */
> >>>>>>>> +               if (em->generation =3D=3D (u64)-1)
> >>>>>>>> +                       goto next;
> >>>>>>>> +
> >>>>>>>>                  /*
> >>>>>>>>                   * For do_compress case, we want to compress al=
l valid file
> >>>>>>>>                   * extents, thus no @extent_thresh or mergeable=
 check.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Fran=C3=A7ois-Xavier
> >>>>>>>>>
> >>>>>>>>> [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_perf=
ormance_degradation_after_upgrading/
> >>>>>>>>> [1] https://imgur.com/oYhYat1
