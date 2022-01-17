Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8465491157
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbiAQViL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 16:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiAQViK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 16:38:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EE4C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 13:38:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c5so11994088pgk.12
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qBOkmSLyPL1kbb9Mp7KUKK0VrHsTB0iPalMOC48Gn3M=;
        b=edc9QwAes/1qhn5bde/BSoT536O+dzhbm8T5PqJD8ioKuoh0JdTN5AjyxklEms6CSJ
         Ck6yHvol71eOLdPV3A8m/8CKwGJSY7Dz8Khcc9i8VG5B8wQ2edJPXRub4XNVkTapGoFX
         zBqQ6mJBB7jltBk1R94NKGJm6xLvMDhDPDoVWijaXp083ZepDgi9FLR+MOY71IXXwYs2
         NDhhrbt3EDcHA0g7aMOjznKvyJ6+uh21zWPGviPVjt44ZvPHXrvlMPJe1XpTzqujySiR
         LE2xZIuoa410NCz65v5If5/aQvCoSi6iXVfl3TuDJg33QoGgPR3iq5xBUC/1g7p/5fSb
         Jt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qBOkmSLyPL1kbb9Mp7KUKK0VrHsTB0iPalMOC48Gn3M=;
        b=TFIC+fE8KwfPrUknDFhFZOrXbl7Ktx2FJNEaOdD4l1BRYMVlP2vEqLFLTKMHd6pb98
         wM5JuGdePaB9GrBB+tYiBQwhWB6ckCrrj027KqHX4+Wey3UGhZXcA1bjKPAwyjDXPbzI
         fmrHBncTb/qAgixubtPNf6UQ5uaJiDVGNDeOWKgn2ySuxYv+B9BAlYKRoUSJIR8ehzsN
         vPR3oiw0NTkXJcLrQN7uUd8aObEOuOUacSEMg0VpbcrYgKsyG8QiarKKZ1tTygOSK9wI
         q2bAn1+0jgU+OuA1vjPeqICdrE9Wd4a0osm3WdOfL2MXfgEVVzYvlYI/QfXq5iSGi+zs
         HLXg==
X-Gm-Message-State: AOAM533+LXEWlXR93GdOjN4mhd+Z3SyD8226IZb3M6XBVY1ptIj+ur37
        1Ds3Im2fiN8V9MvdDc38CT47ehv2vRyyUph8/Wu/zKRvaCwLKQ==
X-Google-Smtp-Source: ABdhPJyxrXyo3/LuAAwBUeErda0xk6jykWEoWaF6FJQeHDn8zCOPsh+WbtDN9lKbLvbzJ+ddKndO71fmyQclp2vQaU4=
X-Received: by 2002:a63:9712:: with SMTP id n18mr20532048pge.594.1642455489908;
 Mon, 17 Jan 2022 13:38:09 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
In-Reply-To: <YeWgdQ2ZvceLTIej@debian9.Home>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Mon, 17 Jan 2022 22:37:58 +0100
Message-ID: <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Filipe,

Thank you so much for the hints!

I compiled 5.16 with the 1-byte file patch and have been running it
for a couple of hours now. I/O seems to have been gradually increasing
compared to 5.15, but I will wait for tomorrow to have a clearer view
on the graphs, then I'll try the both patches.

Fran=C3=A7ois-Xavier

On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier Thomas w=
rote:
> > > Hello all,
> > >
> > > Just in case someone is having the same issue: Btrfs (in the
> > > btrfs-cleaner process) is taking a large amount of disk IO after
> > > upgrading to 5.16 on one of my volumes, and multiple other people see=
m
> > > to be having the same issue, see discussion in [0].
> > >
> > > [1] is a close-up screenshot of disk I/O history (blue line is write
> > > ops, going from a baseline of some 10 ops/s to around 1k ops/s). I
> > > downgraded from 5.16 to 5.15 in the middle, which immediately restore=
d
> > > previous performance.
> > >
> > > Common options between affected people are: ssd, autodefrag. No error
> > > in the logs, and no other issue aside from performance (the volume
> > > works just fine for accessing data).
> > >
> > > One person reports that SMART stats show a massive amount of blocks
> > > being written; unfortunately I do not have historical data for that s=
o
> > > I cannot confirm, but this sounds likely given what I see on what
> > > should be a relatively new SSD.
> > >
> > > Any idea of what it could be related to?
> >
> > There was a big refactor of the defrag code that landed in 5.16.
> >
> > On a quick glance, when using autodefrag it seems we now can end up in =
an
> > infinite loop by marking the same range for degrag (IO) over and over.
> >
> > Can you try the following patch? (also at https://pastebin.com/raw/QR27=
Jv6n)
>
> Actually try this one instead:
>
> https://pastebin.com/raw/EbEfk1tF
>
> Also, there's a bug with defrag running into an (almost) infinite loop wh=
en
> attempting to defrag a 1 byte file. Someone ran into this and I've just s=
ent
> a fix for it:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfed=
2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
>
> Maybe that is what you are running into when using autodefrag.
> Firt try that fix for the 1 byte file case, and if after that you still r=
un
> into problems, then try with the other patch above as well (both patches
> applied).
>
> Thanks.
>
>
>
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index a5bd6926f7ff..0a9f6125a566 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
> >                 if (em->generation < newer_than)
> >                         goto next;
> >
> > +               /*
> > +                * Skip extents already under IO, otherwise we can end =
up in an
> > +                * infinite loop when using auto defrag.
> > +                */
> > +               if (em->generation =3D=3D (u64)-1)
> > +                       goto next;
> > +
> >                 /*
> >                  * For do_compress case, we want to compress all valid =
file
> >                  * extents, thus no @extent_thresh or mergeable check.
> >
> >
> > >
> > > Fran=C3=A7ois-Xavier
> > >
> > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_performanc=
e_degradation_after_upgrading/
> > > [1] https://imgur.com/oYhYat1
