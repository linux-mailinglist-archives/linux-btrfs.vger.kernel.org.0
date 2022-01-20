Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB562494D92
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 13:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiATMC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 07:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiATMCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 07:02:24 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB66EC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 04:02:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so4991082plr.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 04:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAFjOVsyi/EhSK57ew0MHNJNSPAznNjQqHBMKaXt3Rk=;
        b=lbcqm7NnuCH0es/6QJDJsZ3ifhtgcAetTW/mfAuxi1hqUWqGKpeocSB3t8oliSVTd3
         uR13wM1uIhoOT8SZHVWYVdfzGiy9pXn35dBUr7I/YTVB0pHczyKo9C3IT/ZP7gsKLekX
         JkkBBQftcmDxBWixJEf8Un/iH6lYda3bZb3kI+enrcFBzy2j/UE54IH74x8AWz5mBKM3
         mg+Hc+DPQEAgHVJXGc6Efkrd66N0VOtuXb3VvXZtA0fSRU9ypie6OnKIWavNiPRAU79I
         keN+anQNeBUADp0VIjiPeXYwe7sT8uLyB9+YZzHEtkIHWH3wSvKxepKytcFi5mS8tTaw
         Qp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAFjOVsyi/EhSK57ew0MHNJNSPAznNjQqHBMKaXt3Rk=;
        b=mSbm51ZuJr8+HeNTqRHps1LJBWJc88D5HOysxhzrEe/Oy3ImpMGJnatppaXOGuX6UQ
         5nbkikxBmrQEuz3zUlZOKkGmE3s5s4S0Jkt+/hhm0nXd1o/2kilMIeFCg6YsQF7gLiOU
         I1jxXfYzx9E1Mmg9BMefF3ohSjzHyQpPuCKXJpzcY++4l+obzaKai+AmC02Ic2CCHw4y
         Jx7gsModygsIiKLkVUvTruJN/SIT0zyyFzNuFYq6ROnlm6f+GlIjVIrAA9YiSMnRVsNw
         JYF6N96/fvJi/n+W0+w4QmPBy9EY/lAHo7mW5t7GsqO8rFifZl+MkwJYE49RmayJCE/e
         6TAw==
X-Gm-Message-State: AOAM53210ryPM8y9k+DszElweztHjVFsKRSzspBCv8nTkhmMNm/jzSP8
        NsIAfb67KyINXbaPqzH/juVGjIrbcjECN2a15YE=
X-Google-Smtp-Source: ABdhPJzkzKxygH5/yvmpiFGbMrB+5eLoWIDJt+iKcLi3OMvrdZajbrDhFodt7BMVY7Z0VcK1M9UTdP/Gn+nom8W3I0U=
X-Received: by 2002:a17:90a:d154:: with SMTP id t20mr10460260pjw.43.1642680144081;
 Thu, 20 Jan 2022 04:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com> <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
In-Reply-To: <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Thu, 20 Jan 2022 13:02:12 +0100
Message-ID: <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> What if on top of those patches, you also add this one:
> https://pastebin.com/raw/EbEfk1tF

That's exactly patch 2 in my stack of patches in fact, is that the correct =
link?

On Thu, Jan 20, 2022 at 12:45 PM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Thu, Jan 20, 2022 at 11:37 AM Fran=C3=A7ois-Xavier Thomas
> <fx.thomas@gmail.com> wrote:
> >
> > Hi Felipe,
> >
> > > So, try with these two more patches on top of that:
> >
> > Thanks, I did just that, see graph with annotations:
> > https://i.imgur.com/pu66nz0.png
> >
> > No visible improvement, average baseline I/O (for roughly similar
> > workloads, the server I'm testing it on is not very busy I/O-wise) is
> > still 3-4x higher in 5.16 than in 5.15 with autodefrag enabled.
>
> What if on top of those patches, you also add this one:
>
> https://pastebin.com/raw/EbEfk1tF
>
> Can you see if it helps?
>
> >
> > The good news is that patch 2 did fix a large part of the issues 5.16.0=
 had.
> > I also checked that disabling autodefrag immediately brings I/O rate
> > back to how it was in 5.15.
>
> At least that!
> Thanks.
>
> >
> > >> Some people reported that 5.16.1 improved the situation for them, so
> > > I don't see how that's possible, nothing was added to 5.16.1 that
> > > involves defrag.
> > > Might just be a coincidence.
> >
> > Yes, I found no evidence that official 5.16.1 is any better than the
> > rest on my side.
> >
> > Fran=C3=A7ois-Xavier
> >
> > On Wed, Jan 19, 2022 at 11:14 AM Filipe Manana <fdmanana@kernel.org> wr=
ote:
> > >
> > > On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
> > > <fx.thomas@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > More details on graph[0]:
> > > > - First patch (1-byte file) on 5.16.0 did not have a significant im=
pact.
> > > > - Both patches on 5.16.0 did reduce a large part of the I/O but sti=
ll
> > > > have a high baseline I/O compared to 5.15
> > >
> > > So, try with these two more patches on top of that:
> > >
> > > https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904=
.29991-1-wqu@suse.com/
> > >
> > > https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352=
.52126-1-wqu@suse.com/
> > >
> > > >
> > > > Some people reported that 5.16.1 improved the situation for them, s=
o
> > >
> > > I don't see how that's possible, nothing was added to 5.16.1 that
> > > involves defrag.
> > > Might just be a coincidence.
> > >
> > > Thanks.
> > >
> > > > I'm testing that. It's too early to tell but for now the baseline I=
/O
> > > > still seems to be high compared to 5.15. Will update with more resu=
lts
> > > > tomorrow.
> > > >
> > > > Fran=C3=A7ois-Xavier
> > > >
> > > > [0] https://i.imgur.com/agzAKGc.png
> > > >
> > > > On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
> > > > <fx.thomas@gmail.com> wrote:
> > > > >
> > > > > Hi Filipe,
> > > > >
> > > > > Thank you so much for the hints!
> > > > >
> > > > > I compiled 5.16 with the 1-byte file patch and have been running =
it
> > > > > for a couple of hours now. I/O seems to have been gradually incre=
asing
> > > > > compared to 5.15, but I will wait for tomorrow to have a clearer =
view
> > > > > on the graphs, then I'll try the both patches.
> > > > >
> > > > > Fran=C3=A7ois-Xavier
> > > > >
> > > > > On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> > > > > > > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavie=
r Thomas wrote:
> > > > > > > > Hello all,
> > > > > > > >
> > > > > > > > Just in case someone is having the same issue: Btrfs (in th=
e
> > > > > > > > btrfs-cleaner process) is taking a large amount of disk IO =
after
> > > > > > > > upgrading to 5.16 on one of my volumes, and multiple other =
people seem
> > > > > > > > to be having the same issue, see discussion in [0].
> > > > > > > >
> > > > > > > > [1] is a close-up screenshot of disk I/O history (blue line=
 is write
> > > > > > > > ops, going from a baseline of some 10 ops/s to around 1k op=
s/s). I
> > > > > > > > downgraded from 5.16 to 5.15 in the middle, which immediate=
ly restored
> > > > > > > > previous performance.
> > > > > > > >
> > > > > > > > Common options between affected people are: ssd, autodefrag=
. No error
> > > > > > > > in the logs, and no other issue aside from performance (the=
 volume
> > > > > > > > works just fine for accessing data).
> > > > > > > >
> > > > > > > > One person reports that SMART stats show a massive amount o=
f blocks
> > > > > > > > being written; unfortunately I do not have historical data =
for that so
> > > > > > > > I cannot confirm, but this sounds likely given what I see o=
n what
> > > > > > > > should be a relatively new SSD.
> > > > > > > >
> > > > > > > > Any idea of what it could be related to?
> > > > > > >
> > > > > > > There was a big refactor of the defrag code that landed in 5.=
16.
> > > > > > >
> > > > > > > On a quick glance, when using autodefrag it seems we now can =
end up in an
> > > > > > > infinite loop by marking the same range for degrag (IO) over =
and over.
> > > > > > >
> > > > > > > Can you try the following patch? (also at https://pastebin.co=
m/raw/QR27Jv6n)
> > > > > >
> > > > > > Actually try this one instead:
> > > > > >
> > > > > > https://pastebin.com/raw/EbEfk1tF
> > > > > >
> > > > > > Also, there's a bug with defrag running into an (almost) infini=
te loop when
> > > > > > attempting to defrag a 1 byte file. Someone ran into this and I=
've just sent
> > > > > > a fix for it:
> > > > > >
> > > > > > https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0f=
f7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> > > > > >
> > > > > > Maybe that is what you are running into when using autodefrag.
> > > > > > Firt try that fix for the 1 byte file case, and if after that y=
ou still run
> > > > > > into problems, then try with the other patch above as well (bot=
h patches
> > > > > > applied).
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > > index a5bd6926f7ff..0a9f6125a566 100644
> > > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(stru=
ct btrfs_inode *inode,
> > > > > > >                 if (em->generation < newer_than)
> > > > > > >                         goto next;
> > > > > > >
> > > > > > > +               /*
> > > > > > > +                * Skip extents already under IO, otherwise w=
e can end up in an
> > > > > > > +                * infinite loop when using auto defrag.
> > > > > > > +                */
> > > > > > > +               if (em->generation =3D=3D (u64)-1)
> > > > > > > +                       goto next;
> > > > > > > +
> > > > > > >                 /*
> > > > > > >                  * For do_compress case, we want to compress =
all valid file
> > > > > > >                  * extents, thus no @extent_thresh or mergeab=
le check.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Fran=C3=A7ois-Xavier
> > > > > > > >
> > > > > > > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_=
performance_degradation_after_upgrading/
> > > > > > > > [1] https://imgur.com/oYhYat1
