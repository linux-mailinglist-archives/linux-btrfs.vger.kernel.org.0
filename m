Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF82494D50
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiATLpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiATLpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:45:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4286C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A2BDCE2058
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F965C340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679114;
        bh=WYGzmHUMSLTR3GUQ14DUrRQvpfctuMxH2L9bpuiuiw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YOIF450htGGPdOWVSrcqiw4JOmM31X75xEFNrTZEhwdByWPETzggI7fP4M1fOHo86
         PD/BaMgBLba/yBd+TB3rkLGl5IaG1bZRESqp7xhN2daIrWMihpiVQHoaPBAtYGtYpS
         44GREvbcKmp+YZhsxI+j+7w6S+EfTbD9Uf6+dYoS1UbzsignWwPK7coc9JEcPlUkYo
         iNXVA8/fZYecQuyDxw2wTh2STDwmJlWlYKie9/S5m0V0kDwRUwbCeAPLj7PNayF7gv
         d79WJK5fe501j33XliEBL7tpmntlnKPPKP7gQsJ+7NqanT4oFQDY8t7Wi5HSf8ERvn
         bgIx5XApy2ksw==
Received: by mail-qv1-f43.google.com with SMTP id a7so6179713qvl.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:45:14 -0800 (PST)
X-Gm-Message-State: AOAM533IU3bELVexirvM3T6LMAGyPOxMo/J6+D7aaDxUQ45APjEKnhqv
        fezXjHMnJiE47kE5/sduTD7A7fdmVOPhfBFj4yw=
X-Google-Smtp-Source: ABdhPJzos7m58f9CrmV1cIlL2Qb0FByhcm49VHZz7xQ1ESjWDMSUrHFNYPxuGK2Umc9qG4FoQ4uTh4Sqk77ARNdWHwM=
X-Received: by 2002:a05:6214:252e:: with SMTP id gg14mr5493482qvb.89.1642679113357;
 Thu, 20 Jan 2022 03:45:13 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com> <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
In-Reply-To: <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 20 Jan 2022 11:44:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
Message-ID: <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 11:37 AM Fran=C3=A7ois-Xavier Thomas
<fx.thomas@gmail.com> wrote:
>
> Hi Felipe,
>
> > So, try with these two more patches on top of that:
>
> Thanks, I did just that, see graph with annotations:
> https://i.imgur.com/pu66nz0.png
>
> No visible improvement, average baseline I/O (for roughly similar
> workloads, the server I'm testing it on is not very busy I/O-wise) is
> still 3-4x higher in 5.16 than in 5.15 with autodefrag enabled.

What if on top of those patches, you also add this one:

https://pastebin.com/raw/EbEfk1tF

Can you see if it helps?

>
> The good news is that patch 2 did fix a large part of the issues 5.16.0 h=
ad.
> I also checked that disabling autodefrag immediately brings I/O rate
> back to how it was in 5.15.

At least that!
Thanks.

>
> >> Some people reported that 5.16.1 improved the situation for them, so
> > I don't see how that's possible, nothing was added to 5.16.1 that
> > involves defrag.
> > Might just be a coincidence.
>
> Yes, I found no evidence that official 5.16.1 is any better than the
> rest on my side.
>
> Fran=C3=A7ois-Xavier
>
> On Wed, Jan 19, 2022 at 11:14 AM Filipe Manana <fdmanana@kernel.org> wrot=
e:
> >
> > On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
> > <fx.thomas@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > More details on graph[0]:
> > > - First patch (1-byte file) on 5.16.0 did not have a significant impa=
ct.
> > > - Both patches on 5.16.0 did reduce a large part of the I/O but still
> > > have a high baseline I/O compared to 5.15
> >
> > So, try with these two more patches on top of that:
> >
> > https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.2=
9991-1-wqu@suse.com/
> >
> > https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352.5=
2126-1-wqu@suse.com/
> >
> > >
> > > Some people reported that 5.16.1 improved the situation for them, so
> >
> > I don't see how that's possible, nothing was added to 5.16.1 that
> > involves defrag.
> > Might just be a coincidence.
> >
> > Thanks.
> >
> > > I'm testing that. It's too early to tell but for now the baseline I/O
> > > still seems to be high compared to 5.15. Will update with more result=
s
> > > tomorrow.
> > >
> > > Fran=C3=A7ois-Xavier
> > >
> > > [0] https://i.imgur.com/agzAKGc.png
> > >
> > > On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
> > > <fx.thomas@gmail.com> wrote:
> > > >
> > > > Hi Filipe,
> > > >
> > > > Thank you so much for the hints!
> > > >
> > > > I compiled 5.16 with the 1-byte file patch and have been running it
> > > > for a couple of hours now. I/O seems to have been gradually increas=
ing
> > > > compared to 5.15, but I will wait for tomorrow to have a clearer vi=
ew
> > > > on the graphs, then I'll try the both patches.
> > > >
> > > > Fran=C3=A7ois-Xavier
> > > >
> > > > On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org>=
 wrote:
> > > > >
> > > > > On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> > > > > > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier =
Thomas wrote:
> > > > > > > Hello all,
> > > > > > >
> > > > > > > Just in case someone is having the same issue: Btrfs (in the
> > > > > > > btrfs-cleaner process) is taking a large amount of disk IO af=
ter
> > > > > > > upgrading to 5.16 on one of my volumes, and multiple other pe=
ople seem
> > > > > > > to be having the same issue, see discussion in [0].
> > > > > > >
> > > > > > > [1] is a close-up screenshot of disk I/O history (blue line i=
s write
> > > > > > > ops, going from a baseline of some 10 ops/s to around 1k ops/=
s). I
> > > > > > > downgraded from 5.16 to 5.15 in the middle, which immediately=
 restored
> > > > > > > previous performance.
> > > > > > >
> > > > > > > Common options between affected people are: ssd, autodefrag. =
No error
> > > > > > > in the logs, and no other issue aside from performance (the v=
olume
> > > > > > > works just fine for accessing data).
> > > > > > >
> > > > > > > One person reports that SMART stats show a massive amount of =
blocks
> > > > > > > being written; unfortunately I do not have historical data fo=
r that so
> > > > > > > I cannot confirm, but this sounds likely given what I see on =
what
> > > > > > > should be a relatively new SSD.
> > > > > > >
> > > > > > > Any idea of what it could be related to?
> > > > > >
> > > > > > There was a big refactor of the defrag code that landed in 5.16=
.
> > > > > >
> > > > > > On a quick glance, when using autodefrag it seems we now can en=
d up in an
> > > > > > infinite loop by marking the same range for degrag (IO) over an=
d over.
> > > > > >
> > > > > > Can you try the following patch? (also at https://pastebin.com/=
raw/QR27Jv6n)
> > > > >
> > > > > Actually try this one instead:
> > > > >
> > > > > https://pastebin.com/raw/EbEfk1tF
> > > > >
> > > > > Also, there's a bug with defrag running into an (almost) infinite=
 loop when
> > > > > attempting to defrag a 1 byte file. Someone ran into this and I'v=
e just sent
> > > > > a fix for it:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7=
e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> > > > >
> > > > > Maybe that is what you are running into when using autodefrag.
> > > > > Firt try that fix for the 1 byte file case, and if after that you=
 still run
> > > > > into problems, then try with the other patch above as well (both =
patches
> > > > > applied).
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > index a5bd6926f7ff..0a9f6125a566 100644
> > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct=
 btrfs_inode *inode,
> > > > > >                 if (em->generation < newer_than)
> > > > > >                         goto next;
> > > > > >
> > > > > > +               /*
> > > > > > +                * Skip extents already under IO, otherwise we =
can end up in an
> > > > > > +                * infinite loop when using auto defrag.
> > > > > > +                */
> > > > > > +               if (em->generation =3D=3D (u64)-1)
> > > > > > +                       goto next;
> > > > > > +
> > > > > >                 /*
> > > > > >                  * For do_compress case, we want to compress al=
l valid file
> > > > > >                  * extents, thus no @extent_thresh or mergeable=
 check.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Fran=C3=A7ois-Xavier
> > > > > > >
> > > > > > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_pe=
rformance_degradation_after_upgrading/
> > > > > > > [1] https://imgur.com/oYhYat1
