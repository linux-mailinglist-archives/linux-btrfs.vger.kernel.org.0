Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637CC494D1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 12:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiATLhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 06:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiATLhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 06:37:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3EC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:37:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so1057378pjt.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U/Py7fHapm8vD5CwpUIQDIar9Jnj28HrzHxsFpZF3qs=;
        b=MJ6IQ0Lvyf2LWYxHLpXbCx+A/hbzkCaU0YocK3uTEXt6nJRYI6Ew+qxRyWR9VsXY7t
         9/hf9PrVbR2Kwf31kaXbEJaExnRvvleJCpzhWm9uqvu2c9Ay5aQBgekcV3be14J5nfky
         BB2Jca4vrzoWGTpb0XAbGBm97/doEA+e6I6qRcJk/E5/ylDwVSj8JwLF6xkniKlIjP/F
         7jyc6ikmIvibhGytEqZ2mwEA11tuKzwPv8DqlBFb2cG7d+9fUCdmehy0Up/46Yq5f8Y+
         WTty/KZzxnO90hq9SUUwgHZTLaVhxK1yZ/F3liFhDj2COo3Awc7sP9Rp76Rwiwz/5luy
         nqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U/Py7fHapm8vD5CwpUIQDIar9Jnj28HrzHxsFpZF3qs=;
        b=YS81DrVaQPLEE+RJ7AMxNoLq2CE+r9mfzvV5w2V6yiK3zVQ2qoIdYznAHDfrVMwQcp
         Le3Q3+Mc32EHpNAf78ML2m6C90T/1fbw/u1UE7huhhbDmvv88GrlxTq68IQ5inf42kzl
         tsBYQrAq60Al8DWys5ad3ILrPRNxBYGdtsDZ9gSMl54MOuJAxafvKeShUGlIm6++aNiD
         INBGxUl02f5KGg5n9k+mGmESYeBk8y46dCbqVBKMMndaGVkFUbQ2nSurWVQndjjwwbCv
         wG+mn86p5ofKeMN2oYhzs/YYgZmCUzUNtNNlE2n0Qr5pzZm2EEBkCpV9AtrD8XYFPfXI
         iO1A==
X-Gm-Message-State: AOAM531s1qq6wBM1rK8FTjWnkinQDTdo++7U3rOYntkC4idmltuOMjLP
        22xty0YDIcIG7AuQyISaJixf+WXJtdQubgo1aqg=
X-Google-Smtp-Source: ABdhPJxVpj/u9wlGsRQ05czqlW8QJ2rn85EUbLNBN+oWMUX2qsrjZXp7B2P94tKvLWvWd08vkD4uux1/8h1yLnctLt0=
X-Received: by 2002:a17:90a:d154:: with SMTP id t20mr10346596pjw.43.1642678673831;
 Thu, 20 Jan 2022 03:37:53 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com> <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Thu, 20 Jan 2022 12:37:42 +0100
Message-ID: <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Felipe,

> So, try with these two more patches on top of that:

Thanks, I did just that, see graph with annotations:
https://i.imgur.com/pu66nz0.png

No visible improvement, average baseline I/O (for roughly similar
workloads, the server I'm testing it on is not very busy I/O-wise) is
still 3-4x higher in 5.16 than in 5.15 with autodefrag enabled.

The good news is that patch 2 did fix a large part of the issues 5.16.0 had=
.
I also checked that disabling autodefrag immediately brings I/O rate
back to how it was in 5.15.

>> Some people reported that 5.16.1 improved the situation for them, so
> I don't see how that's possible, nothing was added to 5.16.1 that
> involves defrag.
> Might just be a coincidence.

Yes, I found no evidence that official 5.16.1 is any better than the
rest on my side.

Fran=C3=A7ois-Xavier

On Wed, Jan 19, 2022 at 11:14 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
> <fx.thomas@gmail.com> wrote:
> >
> > Hi,
> >
> > More details on graph[0]:
> > - First patch (1-byte file) on 5.16.0 did not have a significant impact=
.
> > - Both patches on 5.16.0 did reduce a large part of the I/O but still
> > have a high baseline I/O compared to 5.15
>
> So, try with these two more patches on top of that:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.299=
91-1-wqu@suse.com/
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352.521=
26-1-wqu@suse.com/
>
> >
> > Some people reported that 5.16.1 improved the situation for them, so
>
> I don't see how that's possible, nothing was added to 5.16.1 that
> involves defrag.
> Might just be a coincidence.
>
> Thanks.
>
> > I'm testing that. It's too early to tell but for now the baseline I/O
> > still seems to be high compared to 5.15. Will update with more results
> > tomorrow.
> >
> > Fran=C3=A7ois-Xavier
> >
> > [0] https://i.imgur.com/agzAKGc.png
> >
> > On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
> > <fx.thomas@gmail.com> wrote:
> > >
> > > Hi Filipe,
> > >
> > > Thank you so much for the hints!
> > >
> > > I compiled 5.16 with the 1-byte file patch and have been running it
> > > for a couple of hours now. I/O seems to have been gradually increasin=
g
> > > compared to 5.15, but I will wait for tomorrow to have a clearer view
> > > on the graphs, then I'll try the both patches.
> > >
> > > Fran=C3=A7ois-Xavier
> > >
> > > On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org> w=
rote:
> > > >
> > > > On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> > > > > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier Th=
omas wrote:
> > > > > > Hello all,
> > > > > >
> > > > > > Just in case someone is having the same issue: Btrfs (in the
> > > > > > btrfs-cleaner process) is taking a large amount of disk IO afte=
r
> > > > > > upgrading to 5.16 on one of my volumes, and multiple other peop=
le seem
> > > > > > to be having the same issue, see discussion in [0].
> > > > > >
> > > > > > [1] is a close-up screenshot of disk I/O history (blue line is =
write
> > > > > > ops, going from a baseline of some 10 ops/s to around 1k ops/s)=
. I
> > > > > > downgraded from 5.16 to 5.15 in the middle, which immediately r=
estored
> > > > > > previous performance.
> > > > > >
> > > > > > Common options between affected people are: ssd, autodefrag. No=
 error
> > > > > > in the logs, and no other issue aside from performance (the vol=
ume
> > > > > > works just fine for accessing data).
> > > > > >
> > > > > > One person reports that SMART stats show a massive amount of bl=
ocks
> > > > > > being written; unfortunately I do not have historical data for =
that so
> > > > > > I cannot confirm, but this sounds likely given what I see on wh=
at
> > > > > > should be a relatively new SSD.
> > > > > >
> > > > > > Any idea of what it could be related to?
> > > > >
> > > > > There was a big refactor of the defrag code that landed in 5.16.
> > > > >
> > > > > On a quick glance, when using autodefrag it seems we now can end =
up in an
> > > > > infinite loop by marking the same range for degrag (IO) over and =
over.
> > > > >
> > > > > Can you try the following patch? (also at https://pastebin.com/ra=
w/QR27Jv6n)
> > > >
> > > > Actually try this one instead:
> > > >
> > > > https://pastebin.com/raw/EbEfk1tF
> > > >
> > > > Also, there's a bug with defrag running into an (almost) infinite l=
oop when
> > > > attempting to defrag a 1 byte file. Someone ran into this and I've =
just sent
> > > > a fix for it:
> > > >
> > > > https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e2=
1bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> > > >
> > > > Maybe that is what you are running into when using autodefrag.
> > > > Firt try that fix for the 1 byte file case, and if after that you s=
till run
> > > > into problems, then try with the other patch above as well (both pa=
tches
> > > > applied).
> > > >
> > > > Thanks.
> > > >
> > > >
> > > >
> > > > >
> > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > index a5bd6926f7ff..0a9f6125a566 100644
> > > > > --- a/fs/btrfs/ioctl.c
> > > > > +++ b/fs/btrfs/ioctl.c
> > > > > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct b=
trfs_inode *inode,
> > > > >                 if (em->generation < newer_than)
> > > > >                         goto next;
> > > > >
> > > > > +               /*
> > > > > +                * Skip extents already under IO, otherwise we ca=
n end up in an
> > > > > +                * infinite loop when using auto defrag.
> > > > > +                */
> > > > > +               if (em->generation =3D=3D (u64)-1)
> > > > > +                       goto next;
> > > > > +
> > > > >                 /*
> > > > >                  * For do_compress case, we want to compress all =
valid file
> > > > >                  * extents, thus no @extent_thresh or mergeable c=
heck.
> > > > >
> > > > >
> > > > > >
> > > > > > Fran=C3=A7ois-Xavier
> > > > > >
> > > > > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_perf=
ormance_degradation_after_upgrading/
> > > > > > [1] https://imgur.com/oYhYat1
