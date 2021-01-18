Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76562F9D99
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbhARLHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 06:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389386AbhARKvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 05:51:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E12C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 02:50:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j18so2165205wmi.3
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 02:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DVyXR/EzUeNKZ47E6nIUIhUAYOapbtwq9zaWBcJMCUw=;
        b=lJ2oJ1V96kDlB7TbRpmf/9aDozLCPUivQnSwCDeAICjSTgrNiw712j1XfUuRBSp0Iq
         zD80j5QJ8FV90rgI6QQDGP/VTzrPqEm0hSFulYyZYOtALOxWTt6EyZpyu6DqepEvxkSg
         4nD6tCcgrffAtlzBrH6fGfrTQ/mZCsBBC5qsBA8BQfjIq94sl7Q6yBHike8h/Eu7QCop
         y2AjJ8tSH/oFMv8edwku6kh9AwNke4VHFW5y+NRhm39M9MmtXjSMoV4gB2vm0U05XUN1
         CJDddpM8V23O1DdVQEJAWj3Mv5LAfO0qrjxS+6IFyP2/y+TkL9+A5nwB4KGs+PlKSgVm
         WyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DVyXR/EzUeNKZ47E6nIUIhUAYOapbtwq9zaWBcJMCUw=;
        b=k7WvYsvx0ZhhQBloCocBZ85sxwlBWoZRim5hUfyl7LOyt2m3Wxty4FpHzbxDFYP1u4
         9R4yyHOyJnjt5tK5bedMU1kHRA1a90d+lUCYk7+L1zLVKVIm+Z5eWiCQ98L9liMRYo93
         NkQsnASaIjbjygMW/Ncu8Tfv81o9MqikatLu0NpbnkSUQGXRce8vp4cxKEe5D2acDXic
         yFgYDoquT42FXMGCgUpzJZhuUOvUUnoduc1n6+kDIDG7ggW6OR9SGfDxYBsRvvzRHMmv
         6EKrkmj5Uv7mRkIoJioPFS+UX3MGbFcZlGatkp75nIuu0LombvYyBGOkwby4DwxIQBF3
         t+Lw==
X-Gm-Message-State: AOAM531t5/cDV/NCOf4XFj1Xmlo+pBzMD182BO00H6SRyk8HmNCL0UyD
        RZ+txNZePozbIJmwz5fMnrTmaO5Bsm4EWFovIpmecmxA/kNJPKL/
X-Google-Smtp-Source: ABdhPJyNFGwdWLUKHEI3F9M0BGvUYSWAwlTdrj6SYoNHxPwcsEfaqk8/nqPTYp0Xn7NvxpSxJdt2c54YYM5IVpSAwus=
X-Received: by 2002:a1c:9a90:: with SMTP id c138mr5022214wme.147.1610967011756;
 Mon, 18 Jan 2021 02:50:11 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk> <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com> <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
In-Reply-To: <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Mon, 18 Jan 2021 02:50:00 -0800
Message-ID: <CAMj6ewNwnmohsEkddFR9f22aaY7=OSXyZpmeM2oMXQSOFABMgg@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I ended up having other priorities occupying my time since 2019, and
the "solution" of exporting the individual drives on my NAS using NBD
and mounting them on my desktop worked, even if it wasn't pretty.

However, I am currently looking into Syncthing, which I would like to
run on the NAS directly. That would, of course, require accessing the
filesystem directly on the NAS rather than just exporting the raw
devices, which means circling back to this issue.

After updating my NAS, I have determined that the issue still occurs
with Linux 5.8.

What's the next best step for debugging the issue? Ideally, I'd like
to help track down the issue to find a proper fix, rather than just
trying to bypass the issue. I wasn't sure if the suggestion to comment
out btrfs_verify_dev_extents() was more geared toward the former or
the latter.


On Fri, Jun 28, 2019 at 1:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/6/28 =E4=B8=8B=E5=8D=884:00, Erik Jensen wrote:
> >> So it's either the block layer reading some wrong from the disk or btr=
fs
> >> layer doesn't do correct endian convert.
> >
> > My ARM board is running in little endian mode, so it doesn't seem like
> > endianness should be an issue. (It is 32-bits versus my desktop's 64,
> > though.) I've also tried exporting the drives via NBD to my x86_64
> > system, and that worked fine, so if the problem is under btrfs, it
> > would have to be in the encryption layer, but fsck succeeding on the
> > ARM board would seem to rule that out, as well.
> >
> >> Would you dump the following data (X86 and ARM should output the same
> >> content, thus one output is enough).
> >> # btrfs ins dump-tree -b 17628726968320 /dev/dm-3
> >> # btrfs ins dump-tree -b 17628727001088 /dev/dm-3
> >
> > Attached, and also 17628705964032, since that's the block mentioned in
> > my most recent mount attempt (see below).
>
> The trees are completely fine.
>
> So it should be something else causing the problem.
>
> >
> >> And then, for the ARM system, please apply the following diff, and try
> >> mount again.
> >> The diff adds extra debug info, to exam the vital members of a tree bl=
ock.
> >>
> >> Correct fs should output something like:
> >>   BTRFS error (device dm-4): bad tree block start, want 30408704 have =
0
> >>   tree block gen=3D4 owner=3D5 nritems=3D2 level=3D0
> >>   csum:
> >> a304e483-0000-0000-0000-00000000000000000000-0000-0000-0000-0000000000=
00
> >>
> >> The csum one is the most important one, if there aren't so many zeros,
> >> it means at that timing, btrfs just got a bunch of garbage, thus we
> >> could do further debug.
> >
> > [  131.725573] BTRFS info (device dm-1): disk space caching is enabled
> > [  131.731884] BTRFS info (device dm-1): has skinny extents
> > [  133.046145] BTRFS error (device dm-1): bad tree block start, want
> > 17628705964032 have 2807793151171243621
> > [  133.055775] tree block gen=3D7888986126946982446
> > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> > [  133.065661] csum:
> > 416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba9656f=
c
>
> Completely garbage here, so I'd say the data we got isn't what we want.
>
> > [  133.108383] BTRFS error (device dm-1): bad tree block start, want
> > 17628705964032 have 2807793151171243621
> > [  133.117999] tree block gen=3D7888986126946982446
> > owner=3D11331573954727661546 nritems=3D4191910623 level=3D112
> > [  133.127756] csum:
> > 416a456c-1e68-dbc3-185d-aaad410beaef5493ab3f-3cb9-4ba1-2214-b41cba9656f=
c
>
> But strangely, the 2nd try still gives us the same result, if it's
> really some garbage, we should get some different result.
>
> > [  133.136241] BTRFS error (device dm-1): failed to verify dev extents
> > against chunks: -5
>
> You can try to skip the dev extents verification by commenting out the
> btrfs_verify_dev_extents() call in disk-io.c::open_ctree().
>
> It may fail at another location though.
>
> The more strange part is, we have the device tree root node read out
> without problem.
>
> Thanks,
> Qu
>
> > [  133.166165] BTRFS error (device dm-1): open_ctree failed
> >
> > I copied some files over last time I had it mounted on my desktop,
> > which may be why it's now failing at a different block.
> >
> > Thanks!
> >
>
