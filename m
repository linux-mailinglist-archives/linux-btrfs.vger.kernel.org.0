Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2C4937A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbiASJob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 04:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353130AbiASJo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 04:44:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B0C061748
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 01:44:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so1601553plr.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 01:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+QVxmPPq+bHmYongH/rAq04ra7Q6K6R4PGNSFIgc7mc=;
        b=RT/vSuqNOMZbp1s97YXv0lN8SIeMlI2qGhji25VaF7U19rDWDgom6OenIHbbibyYLX
         VVnQfjeJiWihdLzL/anEA6/SHg8PcgFzf981lPFVHc+XLcaO1O5brUPbfTRE1jObwd7d
         zmJyN7FT5na6Zcn3fL0I0Bafx1TdBNM1qRPe4AMArVdKrwY1jR7HSNzTL477vFG6vUY/
         TFUwR38fwf4MHKPD1g5d/8bt25GTnS9R5gytw4k7ITbZRInfmsiDQmeoBZAniYwBfXP2
         DZwb8LFSMc0rLZcAaQkiYDPE/faz42s+J3iOuCwY4Yu8Xq4Nz37q8QXugnOlAEM0ylcR
         XoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+QVxmPPq+bHmYongH/rAq04ra7Q6K6R4PGNSFIgc7mc=;
        b=jeSfTdkfpKX4uBtWSGcDg8dNuKEMtUqirCqLjVW1w7ZSyaPplx0Hvju+R9uj/QzW0C
         Uo5mzclrASqYk7TD0kKvcx9ziXLTxqaemBdcsbU2DIeQcqHK2rSurDt7CkogwoVMcbVL
         Y9N1Q9FhuMiPdOT9euc1NdaXAOtUztiN/T5geJMFbafd0xl3B6pdBUwlqjWeD8wkR6C+
         yMguel/RDA7dAdawQOtI60zi1wHll/3o8aFEmfOhwp1oheQNWGb/RD7YHiM1lRluYSmm
         rXb8KYhqf8/pLUayVUFJNvlRLzUTpXvcnry3h4oL0FWtXGnkgVEJi1WNuvPJUvb65fMA
         cvBw==
X-Gm-Message-State: AOAM530iZRgNS4VvXfJlUxuomid41YK3ZfNTKq3D2n2gDcNHHf6rF79B
        D0lDajKZxy6OL0M21yv1rqkhrr+Snjo4A4n2iAs=
X-Google-Smtp-Source: ABdhPJz9XBUhnjPIijX1xHxYlOth70y6+W3m8fs9XoUNJlAxfrnu0dOHKx5Nb9w11TjP7HBjZkHQlciTYkN0yPXAdww=
X-Received: by 2002:a17:902:7844:b0:14a:9cff:66c7 with SMTP id
 e4-20020a170902784400b0014a9cff66c7mr20630338pln.14.1642585462347; Wed, 19
 Jan 2022 01:44:22 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home> <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
In-Reply-To: <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Wed, 19 Jan 2022 10:44:10 +0100
Message-ID: <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

More details on graph[0]:
- First patch (1-byte file) on 5.16.0 did not have a significant impact.
- Both patches on 5.16.0 did reduce a large part of the I/O but still
have a high baseline I/O compared to 5.15

Some people reported that 5.16.1 improved the situation for them, so
I'm testing that. It's too early to tell but for now the baseline I/O
still seems to be high compared to 5.15. Will update with more results
tomorrow.

Fran=C3=A7ois-Xavier

[0] https://i.imgur.com/agzAKGc.png

On Mon, Jan 17, 2022 at 10:37 PM Fran=C3=A7ois-Xavier Thomas
<fx.thomas@gmail.com> wrote:
>
> Hi Filipe,
>
> Thank you so much for the hints!
>
> I compiled 5.16 with the 1-byte file patch and have been running it
> for a couple of hours now. I/O seems to have been gradually increasing
> compared to 5.15, but I will wait for tomorrow to have a clearer view
> on the graphs, then I'll try the both patches.
>
> Fran=C3=A7ois-Xavier
>
> On Mon, Jan 17, 2022 at 5:59 PM Filipe Manana <fdmanana@kernel.org> wrote=
:
> >
> > On Mon, Jan 17, 2022 at 12:02:08PM +0000, Filipe Manana wrote:
> > > On Mon, Jan 17, 2022 at 11:06:42AM +0100, Fran=C3=A7ois-Xavier Thomas=
 wrote:
> > > > Hello all,
> > > >
> > > > Just in case someone is having the same issue: Btrfs (in the
> > > > btrfs-cleaner process) is taking a large amount of disk IO after
> > > > upgrading to 5.16 on one of my volumes, and multiple other people s=
eem
> > > > to be having the same issue, see discussion in [0].
> > > >
> > > > [1] is a close-up screenshot of disk I/O history (blue line is writ=
e
> > > > ops, going from a baseline of some 10 ops/s to around 1k ops/s). I
> > > > downgraded from 5.16 to 5.15 in the middle, which immediately resto=
red
> > > > previous performance.
> > > >
> > > > Common options between affected people are: ssd, autodefrag. No err=
or
> > > > in the logs, and no other issue aside from performance (the volume
> > > > works just fine for accessing data).
> > > >
> > > > One person reports that SMART stats show a massive amount of blocks
> > > > being written; unfortunately I do not have historical data for that=
 so
> > > > I cannot confirm, but this sounds likely given what I see on what
> > > > should be a relatively new SSD.
> > > >
> > > > Any idea of what it could be related to?
> > >
> > > There was a big refactor of the defrag code that landed in 5.16.
> > >
> > > On a quick glance, when using autodefrag it seems we now can end up i=
n an
> > > infinite loop by marking the same range for degrag (IO) over and over=
.
> > >
> > > Can you try the following patch? (also at https://pastebin.com/raw/QR=
27Jv6n)
> >
> > Actually try this one instead:
> >
> > https://pastebin.com/raw/EbEfk1tF
> >
> > Also, there's a bug with defrag running into an (almost) infinite loop =
when
> > attempting to defrag a 1 byte file. Someone ran into this and I've just=
 sent
> > a fix for it:
> >
> > https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbf=
ed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/
> >
> > Maybe that is what you are running into when using autodefrag.
> > Firt try that fix for the 1 byte file case, and if after that you still=
 run
> > into problems, then try with the other patch above as well (both patche=
s
> > applied).
> >
> > Thanks.
> >
> >
> >
> > >
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index a5bd6926f7ff..0a9f6125a566 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -1213,6 +1213,13 @@ static int defrag_collect_targets(struct btrfs=
_inode *inode,
> > >                 if (em->generation < newer_than)
> > >                         goto next;
> > >
> > > +               /*
> > > +                * Skip extents already under IO, otherwise we can en=
d up in an
> > > +                * infinite loop when using auto defrag.
> > > +                */
> > > +               if (em->generation =3D=3D (u64)-1)
> > > +                       goto next;
> > > +
> > >                 /*
> > >                  * For do_compress case, we want to compress all vali=
d file
> > >                  * extents, thus no @extent_thresh or mergeable check=
.
> > >
> > >
> > > >
> > > > Fran=C3=A7ois-Xavier
> > > >
> > > > [0] https://www.reddit.com/r/btrfs/comments/s4nrzb/massive_performa=
nce_degradation_after_upgrading/
> > > > [1] https://imgur.com/oYhYat1
