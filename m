Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111CD495381
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiATRrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 12:47:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44896 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiATRrH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 12:47:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B2C61702
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 17:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038B5C340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642700826;
        bh=3ftE7/gag1MhVdcpsdkGqOnDwX3LQDaA3beJMtjKHV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QvzRVOr/BuBLE1fZgHGj8jWdjf/qHXAnTUv4mli8ER16cN57BPdt6ZB2pJzIKM/8P
         iETrs6G8ijPvhbn121y6DT6mG2lw7D/fCn1eQ6uRH0NjUYKrNjGxB+pG/8Los5PmCq
         kqGKaBUfxnVcPi4wFXTAoKDnobYNXItm+aqAnnFOtqTsyAC3RG0fierrfIInn5Iuha
         sSg+qR3Pa2q7RTqXD8zE0GGNtiADWrDL8MgXQpk4O72NLZlIkOLPdtI9+fFfsNMxh+
         p7p9HhGnKfFwOpODlcvyHo5XrEiWrBTsq+imQQ6qgpms6DNOOfKqcSeGlMuLJfvinY
         iKnmHvD3dORKg==
Received: by mail-qt1-f180.google.com with SMTP id p3so1531828qtn.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 09:47:05 -0800 (PST)
X-Gm-Message-State: AOAM530EVZQKhXw21ODaQexlKzUurd3Vd/xMKTcBNueCmi+82uHIHVA+
        9LMJByWW2FR5JNBgO9tSqamvJwf/nOEZsZUBGXs=
X-Google-Smtp-Source: ABdhPJxbZxe01gEu+5v+m3EqwvP34hWce/0hAzo3mb3XhgRPBrzgsbkub58wX6t21gwvAOlcY1E0GemFYyPSU/Fx2OU=
X-Received: by 2002:ac8:7d09:: with SMTP id g9mr72403qtb.490.1642700825024;
 Thu, 20 Jan 2022 09:47:05 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com> <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
In-Reply-To: <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 20 Jan 2022 17:46:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
Message-ID: <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 12:02 PM Fran=C3=A7ois-Xavier Thomas
<fx.thomas@gmail.com> wrote:
>
> > What if on top of those patches, you also add this one:
> > https://pastebin.com/raw/EbEfk1tF
>
> That's exactly patch 2 in my stack of patches in fact, is that the correc=
t link?

It was the correct link, but I forgot that I had already given it to
you (there's another thread from another
user that reported defrag/autodefrag issues in 5.16 as well).

Ok, so new patches to try and the new stack of patches should be:

1) https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfe=
d2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/

2) https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.29=
991-1-wqu@suse.com/

3) https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352.52=
126-1-wqu@suse.com/

4) https://patchwork.kernel.org/project/linux-btrfs/patch/5cb3ce140c84b0283=
be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com/

5) https://patchwork.kernel.org/project/linux-btrfs/patch/3fe2f747e0a931906=
4d59d051dc3f993fc41b172.1642698605.git.fdmanana@suse.com/

6) https://patchwork.kernel.org/project/linux-btrfs/patch/20aad8ccf0fbdecdd=
d49216f25fa772754f77978.1642700395.git.fdmanana@suse.com/

Hope that helps.
Thanks.


>
> On Thu, Jan 20, 2022 at 12:45 PM Filipe Manana <fdmanana@kernel.org> wrot=
e:
> >
> > On Thu, Jan 20, 2022 at 11:37 AM Fran=C3=A7ois-Xavier Thomas
> > <fx.thomas@gmail.com> wrote:
> > >
> > > Hi Felipe,
> > >
> > > > So, try with these two more patches on top of that:
> > >
> > > Thanks, I did just that, see graph with annotations:
> > > https://i.imgur.com/pu66nz0.png
> > >
> > > No visible improvement, average baseline I/O (for roughly similar
> > > workloads, the server I'm testing it on is not very busy I/O-wise) is
> > > still 3-4x higher in 5.16 than in 5.15 with autodefrag enabled.
> >
> > What if on top of those patches, you also add this one:
> >
> > https://pastebin.com/raw/EbEfk1tF
> >
> > Can you see if it helps?
> >
> > >
> > > The good news is that patch 2 did fix a large part of the issues 5.16=
.0 had.
> > > I also checked that disabling autodefrag immediately brings I/O rate
> > > back to how it was in 5.15.
> >
> > At least that!
> > Thanks.
> >
> > >
> > > >> Some people reported that 5.16.1 improved the situation for them, =
so
> > > > I don't see how that's possible, nothing was added to 5.16.1 that
> > > > involves defrag.
> > > > Might just be a coincidence.
> > >
> > > Yes, I found no evidence that official 5.16.1 is any better than the
> > > rest on my side.
> > >
> > > Fran=C3=A7ois-Xavier
> > >
> > > On Wed, Jan 19, 2022 at 11:14 AM Filipe Manana <fdmanana@kernel.org> =
wrote:
> > > >
> > > > On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
> > > > <fx.thomas@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > More details on graph[0]:
> > > > > - First patch (1-byte file) on 5.16.0 did not have a significant =
impact.
> > > > > - Both patches on 5.16.0 did reduce a large part of the I/O but s=
till
> > > > > have a high baseline I/O compared to 5.15
> > > >
> > > > So, try with these two more patches on top of that:
> > > >
> > > > https://patchwork.kernel.org/project/linux-btrfs/patch/202201180719=
04.29991-1-wqu@suse.com/
> > > >
> > > > https://patchwork.kernel.org/project/linux-btrfs/patch/202201181153=
52.52126-1-wqu@suse.com/
> > > >
> > > > >
> > > > > Some people reported that 5.16.1 improved the situation for them,=
 so
> > > >
> > > > I don't see how that's possible, nothing was added to 5.16.1 that
> > > > involves defrag.
> > > > Might just be a coincidence.
> > > >
> > > > Thanks.
> > > >
> > > > > I'm testing that. It's too early to tell but for now the baseline=
 I/O
> > > > > still seems to be high compared to 5.15. Will update with more re=
sults
> > > > > tomorrow.
> > > > >
> > > > > Fran=C3=A7ois-Xavier
> > > > >
> > > > > [0] https://i.imgur.com/agzAKGc.png
> > > > >
> > > > > On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
> > > > > <fx.thomas@gmail.com> wrote:
> > > > > >
> > > > > > Hi Filipe,
> > > > > >
> > > > > > Thank you so much for the hints!
> > > > > >
> > > > > > I compiled 5.16 with the 1-byte file patch and have been runnin=
g it
> > > > > > for a couple of hours now. I/O seems to have been gradually inc=
reasing
> > > > > > compared to 5.15, but I will wait for tomorrow to have a cleare=
r view
> > > > > > on the graphs, then I'll try the both patches.
> > > > > >
> > > > > > Fran=C3=A7ois-Xavier
> > > > > >
> > > > > > On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.=
org> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote=
:
> > > > > > > > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xav=
ier Thomas wrote:
> > > > > > > > > Hello all,
> > > > > > > > >
> > > > > > > > > Just in case someone is having the same issue: Btrfs (in =
the
> > > > > > > > > btrfs-cleaner process) is taking a large amount of disk I=
O after
> > > > > > > > > upgrading to 5.16 on one of my volumes, and multiple othe=
r people seem
> > > > > > > > > to be having the same issue, see discussion in [0].
> > > > > > > > >
> > > > > > > > > [1] is a close-up screenshot of disk I/O history (blue li=
ne is write
> > > > > > > > > ops, going from a baseline of some 10 ops/s to around 1k =
ops/s). I
> > > > > > > > > downgraded from 5.16 to 5.15 in the middle, which immedia=
tely restored
> > > > > > > > > previous performance.
> > > > > > > > >
> > > > > > > > > Common options between affected people are: ssd, autodefr=
ag. No error
> > > > > > > > > in the logs, and no other issue aside from performance (t=
he volume
> > > > > > > > > works just fine for accessing data).
> > > > > > > > >
> > > > > > > > > One person reports that SMART stats show a massive amount=
 of blocks
> > > > > > > > > being written; unfortunately I do not have historical dat=
a for that so
> > > > > > > > > I cannot confirm, but this sounds likely given what I see=
 on what
> > > > > > > > > should be a relatively new SSD.
> > > > > > > > >
> > > > > > > > > Any idea of what it could be related to?
> > > > > > > >
> > > > > > > > There was a big refactor of the defrag code that landed in =
5.16.
> > > > > > > >
> > > > > > > > On a quick glance, when using autodefrag it seems we now ca=
n end up in an
> > > > > > > > infinite loop by marking the same range for degrag (IO) ove=
r and over.
> > > > > > > >
> > > > > > > > Can you try the following patch? (also at https://pastebin.=
com/raw/QR27Jv6n)
> > > > > > >
> > > > > > > Actually try this one instead:
> > > > > > >
> > > > > > > https://pastebin.com/raw/EbEfk1tF
> > > > > > >
> > > > > > > Also, there's a bug with defrag running into an (almost) infi=
nite loop when
> > > > > > > attempting to defrag a 1 byte file. Someone ran into this and=
 I've just sent
> > > > > > > a fix for it:
> > > > > > >
> > > > > > > https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce=
0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> > > > > > >
> > > > > > > Maybe that is what you are running into when using autodefrag=
.
> > > > > > > Firt try that fix for the 1 byte file case, and if after that=
 you still run
> > > > > > > into problems, then try with the other patch above as well (b=
oth patches
> > > > > > > applied).
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > > > index a5bd6926f7ff..0a9f6125a566 100644
> > > > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > > > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(st=
ruct btrfs_inode *inode,
> > > > > > > >                 if (em->generation < newer_than)
> > > > > > > >                         goto next;
> > > > > > > >
> > > > > > > > +               /*
> > > > > > > > +                * Skip extents already under IO, otherwise=
 we can end up in an
> > > > > > > > +                * infinite loop when using auto defrag.
> > > > > > > > +                */
> > > > > > > > +               if (em->generation =3D=3D (u64)-1)
> > > > > > > > +                       goto next;
> > > > > > > > +
> > > > > > > >                 /*
> > > > > > > >                  * For do_compress case, we want to compres=
s all valid file
> > > > > > > >                  * extents, thus no @extent_thresh or merge=
able check.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Fran=C3=A7ois-Xavier
> > > > > > > > >
> > > > > > > > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massiv=
e_performance_degradation_after_upgrading/
> > > > > > > > > [1] https://imgur.com/oYhYat1
