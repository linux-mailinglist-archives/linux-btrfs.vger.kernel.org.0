Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD4493803
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 11:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353497AbiASKOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 05:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353474AbiASKOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 05:14:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA62C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 02:14:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C8156152C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 10:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365FC004E1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 10:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642587270;
        bh=Q1egdjrICYJcB3LuahHzMCuwf2L3VoWp7fqd7Xr/vxw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a5ayScSvR+ygl5WPpETmJZpg0w8alm7W2fltCjHOc7+oPLVwtNwmEFstAiknTQjFA
         5/dmZpjkFbJZKkB6U/+nFvwJzIZlxqVdCXnFEUrZ3sR52zhF7ijcksOjXQHAz08q4D
         gd8TmEN1YApcZJWNRG1JjQ2vgBAP/wp/CT9HzgKQkNdlg8k4+IG0wjhP1e3pzOx21n
         XPjqGEmMMR2gn3kiYH7zTXrmGphqZWdLUFSwPehqz186jxVfhjRJjTXvSvZrZb8EAM
         LLByV+dz+qENnJnLIicqnbx9AmFGejWfZsW3nDL5NqpQYhcLjblcgKz4Dr8ykLhXvQ
         /2g7GQzYmIoWw==
Received: by mail-qt1-f173.google.com with SMTP id c19so1844646qtx.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 02:14:30 -0800 (PST)
X-Gm-Message-State: AOAM5323ENrouXK26R1tI1XBbmT1MHdcSFnACLZv4tz1kMkLVuBSMbgi
        woh6vvaPBMonI4a+x/0540SMlkMUr/JX4+37nXM=
X-Google-Smtp-Source: ABdhPJzmEIkqYNDjpoVkNvDXjgeAOe+slHNHQz7s8RkpUMESeY6JKuEHuJ0G7XJrgIzNovEbryNY57FZ1eIPJS8Uh0Q=
X-Received: by 2002:ac8:5c4b:: with SMTP id j11mr24445091qtj.490.1642587269529;
 Wed, 19 Jan 2022 02:14:29 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com> <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
In-Reply-To: <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 19 Jan 2022 10:13:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
Message-ID: <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 19, 2022 at 9:44 AM Fran=C3=A7ois-Xavier Thomas
<fx.thomas@gmail.com> wrote:
>
> Hi,
>
> More details on graph[0]:
> - First patch (1-byte file) on 5.16.0 did not have a significant impact.
> - Both patches on 5.16.0 did reduce a large part of the I/O but still
> have a high baseline I/O compared to 5.15

So, try with these two more patches on top of that:

https://patchwork.kernel.org/project/linux-btrfs/patch/20220118071904.29991=
-1-wqu@suse.com/

https://patchwork.kernel.org/project/linux-btrfs/patch/20220118115352.52126=
-1-wqu@suse.com/

>
> Some people reported that 5.16.1 improved the situation for them, so

I don't see how that's possible, nothing was added to 5.16.1 that
involves defrag.
Might just be a coincidence.

Thanks.

> I'm testing that. It's too early to tell but for now the baseline I/O
> still seems to be high compared to 5.15. Will update with more results
> tomorrow.
>
> Fran=C3=A7ois-Xavier
>
> [0] https://i.imgur.com/agzAKGc.png
>
> On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
> <fx.thomas@gmail.com> wrote:
> >
> > Hi Filipe,
> >
> > Thank you so much for the hints!
> >
> > I compiled 5.16 with the 1-byte file patch and have been running it
> > for a couple of hours now. I/O seems to have been gradually increasing
> > compared to 5.15, but I will wait for tomorrow to have a clearer view
> > on the graphs, then I'll try the both patches.
> >
> > Fran=C3=A7ois-Xavier
> >
> > On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org> wro=
te:
> > >
> > > On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> > > > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier Thom=
as wrote:
> > > > > Hello all,
> > > > >
> > > > > Just in case someone is having the same issue: Btrfs (in the
> > > > > btrfs-cleaner process) is taking a large amount of disk IO after
> > > > > upgrading to 5.16 on one of my volumes, and multiple other people=
 seem
> > > > > to be having the same issue, see discussion in [0].
> > > > >
> > > > > [1] is a close-up screenshot of disk I/O history (blue line is wr=
ite
> > > > > ops, going from a baseline of some 10 ops/s to around 1k ops/s). =
I
> > > > > downgraded from 5.16 to 5.15 in the middle, which immediately res=
tored
> > > > > previous performance.
> > > > >
> > > > > Common options between affected people are: ssd, autodefrag. No e=
rror
> > > > > in the logs, and no other issue aside from performance (the volum=
e
> > > > > works just fine for accessing data).
> > > > >
> > > > > One person reports that SMART stats show a massive amount of bloc=
ks
> > > > > being written; unfortunately I do not have historical data for th=
at so
> > > > > I cannot confirm, but this sounds likely given what I see on what
> > > > > should be a relatively new SSD.
> > > > >
> > > > > Any idea of what it could be related to?
> > > >
> > > > There was a big refactor of the defrag code that landed in 5.16.
> > > >
> > > > On a quick glance, when using autodefrag it seems we now can end up=
 in an
> > > > infinite loop by marking the same range for degrag (IO) over and ov=
er.
> > > >
> > > > Can you try the following patch? (also at https://pastebin.com/raw/=
QR27Jv6n)
> > >
> > > Actually try this one instead:
> > >
> > > https://pastebin.com/raw/EbEfk1tF
> > >
> > > Also, there's a bug with defrag running into an (almost) infinite loo=
p when
> > > attempting to defrag a 1 byte file. Someone ran into this and I've ju=
st sent
> > > a fix for it:
> > >
> > > https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21b=
bfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> > >
> > > Maybe that is what you are running into when using autodefrag.
> > > Firt try that fix for the 1 byte file case, and if after that you sti=
ll run
> > > into problems, then try with the other patch above as well (both patc=
hes
> > > applied).
> > >
> > > Thanks.
> > >
> > >
> > >
> > > >
> > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > index a5bd6926f7ff..0a9f6125a566 100644
> > > > --- a/fs/btrfs/ioctl.c
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct btr=
fs_inode *inode,
> > > >                 if (em->generation < newer_than)
> > > >                         goto next;
> > > >
> > > > +               /*
> > > > +                * Skip extents already under IO, otherwise we can =
end up in an
> > > > +                * infinite loop when using auto defrag.
> > > > +                */
> > > > +               if (em->generation =3D=3D (u64)-1)
> > > > +                       goto next;
> > > > +
> > > >                 /*
> > > >                  * For do_compress case, we want to compress all va=
lid file
> > > >                  * extents, thus no @extent_thresh or mergeable che=
ck.
> > > >
> > > >
> > > > >
> > > > > Fran=C3=A7ois-Xavier
> > > > >
> > > > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_perfor=
mance_degradation_after_upgrading/
> > > > > [1] https://imgur.com/oYhYat1
